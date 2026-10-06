Imports System.Xml
Imports System.IO
'Excel upload
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Runtime.InteropServices
'End of Excel upload

Public Class frmProductBacklog
    Inherits WebPages.Template.WhizTemplate
    Protected m_strTaskIDList As String = ""
    Protected m_lngTaskId As Long = 0
    Private m_lngProjectId As Long = 0
    Protected m_strEntity As String = ""
    Protected m_strPrimaryKey As String = ""

    Private m_strPhase As String = ""
    Private m_strModule As String = ""
    Private m_strSubProject As String = ""
    Private m_strMilestone As String = ""
    Protected m_strEmployeeId As String = ""
    Protected m_strHolidays As String = ""
    Protected m_ChkDeliverable As Integer = 0
    Public globalUSID As String = ""
    Protected Shared globalUSID1 As String = ""
    Protected Const PROJECT_SETTING_NORMAL As String = "Normal"
    Protected Const PROJECT_SETTING_ACTIVITY As String = "Activity"
    Protected Const PROJECT_SETTING_EFFORT_DISTRIBUTION As String = "Effort_Distribution"
    Protected m_strProjectSetting As String = ""
    Protected m_ApplyEffortDistribution As Boolean
    Protected m_strProjectStartDate As String = ""
    Protected m_strProjectEndDate As String = ""
    Private m_lngProjectLocationID As Long = 0
    Protected m_HaveSubTaskTypes As Boolean
    Protected m_bitResourceValidation As Int16 = 1
    Private m_blnProjectActive As Boolean = False
    Private m_blnBillable As Boolean = False
    Protected blnIsNewTask As Boolean
    Protected m_strUserName As String = ""
    Protected objClsCommon As New clsCommon

    Private WithEvents m_objSprintmapGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objListGrid As New WebPages.Template.GenericGrid
    Private WithEvents objHistorykList As New WebPages.Template.GenericGrid
    Private WithEvents objIssuesList As New WebPages.Template.GenericGrid
    Private WithEvents objReviewList As New WebPages.Template.GenericGrid
    Private WithEvents objImpedimentsLogList As New WebPages.Template.GenericGrid
    Private WithEvents objRiskList As New WebPages.Template.GenericGrid
    Private WithEvents objtaskList As New WebPages.Template.GenericGrid
    Protected arrIgnoreHTMLEncode() As String = {"0"}

    'Excel upload
    Protected intPageLength As Integer
    Private m_objOLEConnection As OleDbConnection
    Private m_objOLEAdapter As OleDbDataAdapter
    Private m_objOLECommand As OleDbCommand
    Private m_objOLEDataReader As OleDbDataReader
    Private m_objDataSet As DataSet
    Private m_arrSourceColumns As String()
    'End of Excel upload

    'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
    Protected strIsSprintStarted As String = ""
    'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not

    'Added by Usha Pandit on 27-March-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date
    Protected strInputFormat As String
    Protected strDateFormat As String
    'End of adding by Usha Pandit on 27-March-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

        If Request.Params("Mode") = "Upload" Then
            UploadData()
        End If


        GetAccessRights()
        Dim strSql As String = "usp_NG2_INS_tbl_NG2_ProjectLevel_ScrumCategory_UserOrder " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ",Null,Null,1,Null"
        CommonFunctions.Data.InsertOrUpdateData(strSql, True)


        ''Added By Nikhil A on 5-April-2018 for Product Backlog excel upload
        If Request.Params("Mode") = "ProcessFile" Then
            ' the system file name
            Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""

            If Request.Files.Count > 0 Then
                strOriginalFileName = Request.Files(0).FileName
                strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                strFileName &= strFileExtension

                If (strFileExtension = ".xls" Or strFileExtension = ".xlsx") Then
                    Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("~/Attachments/Product_Backlog"), strFileName)
                    ' Save the uploaded file to "UploadedFiles" folder
                    Request.Files(0).SaveAs(fileSavePath)

                    strSQLQuery = "usp_NG2_Ins_tbl_PM_PBAttachments '" & strOriginalFileName & "','" & strFileName & "'," & Session("intUserID") & "," & Session("intProjectID")
                    strAttachmentID = CommonFunctions.Data.GetDataScalar(strSQLQuery, True)

                    'Reading Of file
                    ReadExcelData(strAttachmentID, fileSavePath, strOriginalFileName)
                End If
            End If
            ''Added By Nikhil A on 5-April-2018 for Product Backlog excel upload
        End If
        'Added by Usha Pandit on 27-March-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date
        Dim dateFormatID As Integer = CType(CommonFunctions.Application.DateFormatID, Integer)

        Dim DateFormat As String = "usp_sel_tbl_pm_dateformats_FormatDate " + CType(dateFormatID, String)

        strInputFormat = CType(CommonFunctions.Application.InputeDateFormat, String)
        strDateFormat = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(DateFormat, MyBase.UseSQL), ""), String)
        'End of Added by Usha Pandit on 27-March-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date

    End Sub

    Protected strFunctionalNumber As String = ""
    Protected strFeatureName As String = ""
    Protected strUserDesc As String = ""
    Protected strBusinesValue As String = ""
    Protected strPriority As String = ""
    Protected strState As String = ""
    Protected strComplexity As String = ""
    Protected strStoryPoint As String = ""
    Protected strCategory As String = ""
    Protected strVersion As String = ""
    Protected strIterationName As String = ""
    Protected strReleaseName As String = ""
    Protected strCreatedDate As String = ""
    Protected strCreatedBy As String = ""
    Protected strInitialRank As String = ""
    Protected strCategoryColor As String = "#DDD"
    Protected strVersionColor As String = "#DDD"
    Protected strPriorityColor As String = "#DDD"
    Protected strStatus As String = ""
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected strIsPrductOwner As String
    Protected strAcceptanceCriteria As String = ""
    Protected strFixedVersion As String = ""
    Protected strFixedVersionColor As String = "#DDD"

    Protected Function PlotGrid(Optional ByVal filterflag As String = "", Optional ByVal value As String = "")
        strIsPrductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))
        Dim strCategory As String = ""
        Dim strHTML As New StringBuilder()
        Dim flag As String = "0"

        If filterflag = "" Then
                filterflag = "null"
            Else
                filterflag = filterflag
            End If

            If value = "" Then
                value = "null"
                If filterflag = "Release" Then
                    filterflag = "null"
                ElseIf filterflag = "Sprints" Then
                    filterflag = "null"
                Else
                    filterflag = filterflag
                End If

            Else
                value = value
            End If
            Dim strSql As String = ""
            If filterflag = "null" Then
                strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID") & ",NULL,NULL," & Session("intUserID") & "," & filterflag & "," & value & ""
            Else
                strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID") & ",NULL,NULL," & Session("intUserID") & ",'" & filterflag & "'," & value & ""
            End If

            Dim dtProductBacklog As New DataTable()
            strHTML.Append("<div class='row Main' >")
            strHTML.Append("<input type=hidden id=hdnProjectID value='" & Session("intProjectID") & "'>")
            strHTML.Append("<input type=hidden id=hdnstrUserName value='" & Session("strUserName") & "'>")
            strHTML.Append("<input type=hidden id=hdnintuserid value='" & Session("intuserid") & "'>")
            dtProductBacklog = CommonFunctions.Data.GetDataTable(strSql, True)
            Dim intCounter As Integer = 0
            Dim intCounter1 As Integer = 0
            'strHTML.Append("<div class='DivList'>")
            For i As Integer = 0 To dtProductBacklog.Rows.Count - 1
                intCounter1 = dtProductBacklog.Rows.Count
                If i = 0 Or strCategory <> CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Category"), "") Then
                    If i <> 0 Then
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    End If
                    'If intCounter < 3 Then
                    flag = "1"
                    'strHTML.Append("<div class=''>")'
                    'strHTML.Append("<div class='card '>") 'FixedTD
                    strHTML.Append("<div class='col-sm-3 divDraggable1' id='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "'>") 'divDraggable
                    'Else
                    '    strHTML.Append("<div class='col-sm-3 divDraggable' style='display:none' id='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "'>")
                    'End If

                    Dim strCategoryRecent As String = CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Category"), "Uncategorized")
                    If strCategoryRecent = "" Then
                        strCategoryRecent = "Uncategorized"
                    End If
                    If strCategoryRecent = "Uncategorized" Then
                    strHTML.Append("<div class='clsCategory col-sm-12' ><span class='col-sm-7' style='margin-top: 4px !important;'><label id='ClsCategory_" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "'>" & strCategoryRecent & "</label></span><label class='float-end'>")
                Else
                    strHTML.Append("<div class='clsCategory col-sm-12' ><span class='col-sm-7' style='margin-top: 4px !important;'><label id='ClsCategory_" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "'>" & CommonFunctions.HTMLControls.DrawTextBox("txtCategoryname_" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null"), "txtCategoryname_" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null"), "form-control1", , , strCategoryRecent, , , True, , , , "style='' onblur=""ChangeCategoryName(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & ")"" ", True, , , , , , True) & "</label><i class='fas fa-pencil-alt' aria-hidden='true' style='font-size: 12px;' onclick=""EditCategoryName('" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Edit Category'></i></span><label class='float-end col-sm-2'>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") <> 0 Then
                    'Commented & Added By Dipali V On 23rd April 2018 For Menu Filter Icon
                    'strHTML.Append("<i class='fa fa-ellipsis-v' data-bs-toggle='dropdown' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Menu'></i>")

                    strHTML.Append("<i class='fa fa-ellipsis-h' data-bs-toggle='dropdown' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Menu'></i>")
                    'End of Commented & Added By Dipali V On 23rd April 2018 For Menu Filter Icon
                    strHTML.Append("<ul class='dropdown-menu' role='menu' style='width:160px'>")
                    'strHTML.Append("<li onclick=MoveCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ",1)>")
                    'strHTML.Append("Move Left")
                    'strHTML.Append("</li>")
                    'strHTML.Append("<li onclick=MoveCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ",2)>")
                    'strHTML.Append("Move Right")
                    'strHTML.Append("</li>")
                    'strHTML.Append("<li onclick=MoveCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ",3)>")
                    'strHTML.Append("Move Extreme Left")
                    'strHTML.Append("</li>")
                    'strHTML.Append("<li onclick=MoveCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ",4)>")
                    'strHTML.Append("Move Extreme Right")
                    'strHTML.Append("</li>")
                    'Added By Dipali V On 13th April 2018 For Add new Category Functionality
                    strHTML.Append("<li onclick=AddCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ")>")
                    strHTML.Append("Add Category")
                    strHTML.Append("</li>")
                    strHTML.Append("<li onclick=RenameCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ")>")
                    strHTML.Append("Rename")
                    strHTML.Append("</li>")
                    strHTML.Append("<li onclick=DeleteCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ")>")
                    strHTML.Append("Delete")
                    strHTML.Append("</li>")
                    'End of Added By Dipali V On 13th April 2018 For Add new Category Functionality
                    strHTML.Append("</ul>")
                End If
                'Commented & Added By Dipali V On 13th April 2018 For Issue Fixing
                'strHTML.Append("</label><label class='float-end' style='color:#ddd'  onclick=ShowModal('User'," & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ")>Add</label></div>")

                strHTML.Append("</label><label class='float-end addcategory col-sm-2' style='color:#ddd' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Add User Story' onclick=ShowModal('User'," & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ")>Add</label></div>")
                'End of Commented & Added By Dipali V On 13th April 2018 For Issue Fixing
                intCounter += 1
            End If
            'strHTML.Append("</div>")
            If flag = "1" Then
                strHTML.Append("<div class='Outerdiv'>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) <> 0 Then

                flag = "0"
                strHTML.Append("<div class='Eachdiv divDraggable' id='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "'>")
                strHTML.Append("<div class='panel panel-default ' >")

                'Commented And Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story
                'strHTML.Append("<div class='panel-heading'> <label class='user-story-id user_story' title='User story ID' data-bs-toggle='tooltip' data-bs-placement='right' id='lblUserStory' name='lblUserStory'  title='Userstory ID'>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & " </label>") '<img src='images/userstoryid.png' class='user-story-id-img' alt='user-story'/>
                If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("IsSubUserStory"), 0) = 1 Then
                    strHTML.Append("<div class='panel-heading'> <label class='user-story-id user_story' title='Sub User Story ID' data-bs-toggle='tooltip' data-bs-placement='right' id='lblUserStory' name='lblUserStory'  title='Sub User Story ID'>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & " </label>") '<img src='images/userstoryid.png' class='user-story-id-img' alt='user-story'/>
                Else
                    strHTML.Append("<div class='panel-heading'> <label class='user-story-id user_story' title='User Story ID' data-bs-toggle='tooltip' data-bs-placement='right' id='lblUserStory' name='lblUserStory'  title='User Story ID'>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & " </label>") '<img src='images/userstoryid.png' class='user-story-id-img' alt='user-story'/>
                End If
                'End Of Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story


                'strHTML.Append("<input type='hidden' value='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & "' id='hdnUSnew' />")
                strHTML.Append("<label class='float-end user-story-id rank' data-bs-toggle='tooltip'  title='Rank' data-container='body'> <img src='images/rank.png' class='user-story-rank-img' alt='user-story-rank'/>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "") & " </label>")
                strHTML.Append("</div>")
                Dim strDescription As String = ""
                If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString().Length > 150 Then
                    strDescription = CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString().Substring(0, 150) & "..."
                Else
                    strDescription = CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString()
                End If
                strHTML.Append("<div class='panel-body'>")
                'strHTML.Append("<div class='col-sm-12'>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryName"), "").ToString() & "</div>")
                strHTML.Append("<div class='col-sm-12 user-story-description'><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom'  data-container='body'>" & strDescription & "</span></div>")
                strHTML.Append("<div class='divBox fa fa-flag priority' data-bs-toggle='tooltip' title='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Priority"), "") & "' style='color:" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("PriorityColor"), "") & "'></div>")

                strHTML.Append("<label class='float-end label label-success story_point' data-bs-toggle='tooltip' title='Story point'>" & Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Story Point"), "0")) & "</label>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='panel-footer' >")

                'strHTML.Append("<label class='float-end view charts' title='Charts' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'divChart')><i class='fa fa-bar-chart'></i></label>")
                'strHTML.Append("<label class='float-end view details' title='Map to Sprint' data-bs-toggle='modal' data-bs-target=''  onclick=GetMappedSprint(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'Attach')><i class='fa fa-unlink'></i></label>")
                'strHTML.Append("<label class='float-end view issue' title='Issue' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'divIssues')><i class='fa fa-bug'></i></label>")
                'strHTML.Append("<label class='float-end view discussion' title='Discussion' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'divDiscussions')><i class='fa fa-comments-o'></i></label>")
                'strHTML.Append("<label class='float-end attachment view' title='Attachment' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'divAttachments')><i class='fa fa-paperclip'></i></label>")
                strHTML.Append("<label class='float-start view'><button class='view-details view_story' data-bs-toggle='tooltip' title='View Details' type='button' data-bs-placement='top'  data-bs-toggle='modal' data-bs-target='#divProductBacklog' onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><i class='fa fa-eye'></i></button></label>")
                Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_checkUShasSprintnot " & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ",'UserStory'", True))
                If strAddLinkAccess = "0" Then
                    ''added By Dipali V On 28th Feb 2019 For PO Can add UserStory
                    If strIsPrductOwner = "1" Then
                        strHTML.Append("<label class='float-start view'><i class='fa fa-trash delete_story'  data-bs-toggle='tooltip' data-bs-placement='top' title='Delete User Story' onclick=""Delete_UserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ",'')""></i></label>")
                    Else
                        strHTML.Append("<label class='float-start view'><i class='fa fa-trash delete_story'  data-bs-toggle='tooltip' data-bs-placement='top' title='You do not have access' ></i></label>")
                    End If
                    ''End of added By Dipali V On 28th Feb 2019 For PO Can add UserStory
                Else

                    strHTML.Append("<label class='float-start view'><i class='fa fa-trash delete_story' data-bs-toggle='tooltip' data-bs-placement='top'  title='User Story already Mapped to sprint,you do not have acess to delete'></i></label>")
                End If
                strHTML.Append("<label class='float-end view'  onclick=""MoreDetailOnClick(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")""><p style='cursor:pointer'>More..</p></label>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                ''Commented Usha Pandit on 05-April-2019 Purpose::There are no items message getting display even if records exists
                'If (dtProductBacklog.Rows.Count = intCounter1) Then
                '    'added by dipali v On 29th Feb 2019
                '    strHTML.Append("<div class='message1'>")
                '    strHTML.Append("<table class='table'>")
                '    strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
                '    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
                '    strHTML.Append("</tr>")
                '    strHTML.Append("</table>")
                '    strHTML.Append("</div>")
                '    'End of added by dipali v On 29th Feb 2019
                '    strHTML.Append("</div>")
                'End If
                ''Commented Usha Pandit on 05-April-2019 Purpose::There are no items message getting display even if records exists
            Else
                strHTML.Append("<div class='blankdiv divDraggable' id='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "'>")
                strHTML.Append("<div class='panel panel-default adjustheight' >")
                strHTML.Append("<div class=''> <label class='user-story-id user_story' title='User story ID' data-bs-toggle='tooltip' data-bs-placement='top' id='lblUserStory' name='lblUserStory'  title='Userstory ID'></label>") '<img src='images/userstoryid.png' class='user-story-id-img' alt='user-story'/>

                strHTML.Append("<div class='message2'>")
                strHTML.Append("<table class='table'>")
                strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
            '    <!-- /* Modified By Madhuri.K On 03-04-2026 */ -->
                strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")
                strHTML.Append("</div>")


                strHTML.Append("</div>") 'panel-heading
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                'added by dipali v On 29th Feb 2019
                ''Commented Usha Pandit on 05-April-2019 Purpose::There are no items message getting display even if records exists
                'strHTML.Append("<div class='blankmessage2'>")
                'strHTML.Append("<table class='table'>")
                'strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
                'strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
                'strHTML.Append("</tr>")
                'strHTML.Append("</table>")
                'strHTML.Append("</div>")
                ''Commented Usha Pandit on 05-April-2019 Purpose::There are no items message getting display even if records exists
                'End of added by dipali v On 29th Feb 2019

            End If


            'If flag = "1" Then
            '    strHTML.Append("</div>")
            'End If

            strCategory = CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Category"), "")
        Next

        'strHTML.Append("<div class='col-sm-1' id='RightArrow'>")
        'strHTML.Append("<div class='clsCategory' data-bs-toggle='tooltip' title='Next Swim lane' data-bs-placement='bottom'><label class='float-end' style='color:#ddd'><i class='fa fa-arrow-right' id='icnShow'></i></label></div>")
        'strHTML.Append("</div>")
        strHTML.Append("<input type='hidden' value='" & Session("intprojectid") & "' id='hdnProjectID' />")

        strHTML.Append("</div>")

        'Added by Usha Pandit on 01 JUN 2018 As all div not closed , modal popups were getting clear
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'End of Added by Usha Pandit on 01 JUN 2018 As all div not closed , modal popups were getting clear

        strHTML.Append(Modal_popup())
        Return strHTML.ToString()


    End Function
    'Protected Function PlotGrid(Optional ByVal filterflag As String = "", Optional ByVal value As String = "")
    '    Dim strCategory As String = ""
    '    Dim strHTML As New StringBuilder()

    '    If filterflag = "" Then
    '        filterflag = "null"
    '    Else
    '        filterflag = filterflag
    '    End If

    '    If value = "" Then
    '        value = "null"
    '        If filterflag = "Release" Then
    '            filterflag = "null"
    '        ElseIf filterflag = "Sprints" Then
    '            filterflag = "null"
    '        Else
    '            filterflag = filterflag
    '        End If

    '    Else
    '        value = value
    '    End If
    '    Dim strSql As String = ""
    '    If filterflag = "null" Then
    '        strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID") & ",NULL,NULL," & Session("intUserID") & "," & filterflag & "," & value & ""
    '    Else
    '        strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID") & ",NULL,NULL," & Session("intUserID") & ",'" & filterflag & "'," & value & ""
    '    End If

    '    Dim dtProductBacklog As New DataTable()
    '    strHTML.Append("<div class='row Main'>")
    '    strHTML.Append("<input type=hidden id=hdnProjectID value='" & Session("intProjectID") & "'>")
    '    strHTML.Append("<input type=hidden id=hdnstrUserName value='" & Session("strUserName") & "'>")
    '    dtProductBacklog = CommonFunctions.Data.GetDataTable(strSql, True)
    '    Dim intCounter As Integer = 0

    '    For i As Integer = 0 To dtProductBacklog.Rows.Count - 1
    '        If i = 0 Or strCategory <> CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Category"), "") Then
    '            If i <> 0 Then
    '                strHTML.Append("</div>")
    '            End If
    '            If intCounter < 3 Then
    '                strHTML.Append("<div class='col-sm-3 divDraggable' id='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "'>")
    '            Else
    '                strHTML.Append("<div class='col-sm-3 divDraggable' style='display:none' id='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "Null") & "'>")
    '            End If

    '            Dim strCategoryRecent As String = CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Category"), "Uncategorized")
    '            If strCategoryRecent = "" Then
    '                strCategoryRecent = "Uncategorized"
    '            End If
    '            strHTML.Append("<div class='clsCategory'>" & strCategoryRecent & "<label class='float-end'>")
    '            If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") <> 0 Then
    '                strHTML.Append("<i class='fa fa-ellipsis-v' data-bs-toggle='dropdown'></i>")
    '                strHTML.Append("<ul class='dropdown-menu' role='menu' style='width:160px'>")
    '                strHTML.Append("<li onclick=MoveCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ",1)>")
    '                strHTML.Append("Move Left")
    '                strHTML.Append("</li>")
    '                strHTML.Append("<li onclick=MoveCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ",2)>")
    '                strHTML.Append("Move Right")
    '                strHTML.Append("</li>")
    '                strHTML.Append("<li onclick=MoveCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ",3)>")
    '                strHTML.Append("Move Extreme Left")
    '                strHTML.Append("</li>")
    '                strHTML.Append("<li onclick=MoveCategory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ",4)>")
    '                strHTML.Append("Move Extreme Right")
    '                strHTML.Append("</li>")
    '                strHTML.Append("</ul>")
    '            End If
    '            strHTML.Append("</label><label class='float-end' style='color:#ddd' onclick=ShowModal('User'," & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("CategoryID"), "0") & ")>Add</label></div>")

    '            intCounter += 1
    '        End If
    '        If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) <> 0 Then
    '            strHTML.Append("<div class='panel panel-default'>")

    '            strHTML.Append("<div class='panel-heading'> <label class='user-story-id user_story' title='User story ID' id='lblUserStory' name='lblUserStory'  title='Userstory ID'>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & " </label>") '<img src='images/userstoryid.png' class='user-story-id-img' alt='user-story'/>
    '            'strHTML.Append("<input type='hidden' value='" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & "' id='hdnUSnew' />")
    '            strHTML.Append("<label class='float-end user-story-id rank'  title='Rank'> <img src='images/rank.png' class='user-story-rank-img' alt-='user-story-rank'/>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "") & " </label>")
    '            strHTML.Append("</div>")
    '            Dim strDescription As String = ""
    '            If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString().Length > 150 Then
    '                strDescription = CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString().Substring(0, 150) & "..."
    '            Else
    '                strDescription = CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString()
    '            End If
    '            strHTML.Append("<div class='panel-body'>")
    '            'strHTML.Append("<div class='col-sm-12'>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryName"), "").ToString() & "</div>")
    '            strHTML.Append("<div class='col-sm-12 user-story-description' title='Description'>" & strDescription & "</div>")
    '            strHTML.Append("<div class='divBox fa fa-flag priority' title='Priority' style='color:" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("PriorityColor"), "") & "'></div>")

    '            strHTML.Append("<label class='float-end label label-success story_point' title='Story point'>" & Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Story Point"), "0")) & "</label>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("<div class='panel-footer' >")
    '            strHTML.Append("<label class='float-start view'><button class='view-details view_story' title='View story' type='button'  data-bs-toggle='modal' data-bs-target='#divProductBacklog' onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><i class='fa fa-eye'></i></button></label>")
    '            strHTML.Append("<label class='float-start view'><i class='fa fa-trash delete_story' title='Delete story' data-bs-toggle='tooltip' data-bs-placement='bottom' onclick=""Delete_UserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ",'')""></i></label>")

    '            strHTML.Append("<label class='float-end view charts' title='Charts' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'divChart')><i class='fa fa-bar-chart'></i></label>")
    '            strHTML.Append("<label class='float-end view details' title='Details' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'Attach')><i class='fa fa-unlink'></i></label>")
    '            strHTML.Append("<label class='float-end view issue' title='Issues' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'divIssues')><i class='fa fa-bug'></i></label>")
    '            strHTML.Append("<label class='float-end view discussion' title='Discussion' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'divDiscussions')><i class='fa fa-comments-o'></i></label>")
    '            strHTML.Append("<label class='float-end attachment view' title='Attachment' data-bs-toggle='modal' data-bs-target='#divProductBacklog'  onclick=EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "") & ",'divAttachments')><i class='fa fa-paperclip'></i></label>")
    '            strHTML.Append("</div>")

    '            strHTML.Append("</div>")
    '        End If
    '        If i = dtProductBacklog.Rows.Count - 1 Then
    '            strHTML.Append("</div>")
    '        End If
    '        strCategory = CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Category"), "")
    '    Next

    '    strHTML.Append("<div class='col-sm-1' id='RightArrow'>")
    '    strHTML.Append("<div class='clsCategory' data-bs-toggle='tooltip' title='Next' data-bs-placement='bottom'><label class='float-end' style='color:#ddd'><i class='fa fa-arrow-right' id='icnShow'></i></label></div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<input type='hidden' value='" & Session("intprojectid") & "' id='hdnProjectID' />")

    '    strHTML.Append("</div>")
    '    strHTML.Append(Modal_popup())
    '    Return strHTML.ToString()
    'End Function
    Private Function ReadExcelData(ByVal strAttachmentID As String, ByVal UploadedFilePath As String, ByVal OriginalFileName As String)
        '==================================================================================
        ' Function Name     :   ReadExcelData
        ' Purpose           :   Getting dataset for the excel file data
        ' Author            :   BharatT
        ' Created On        :   27th-Jun-2017
        '==================================================================================
        Dim strConnectionString As String = ""
        Dim strSQL As String
        Dim Ischecklimit As String = ""
        Dim intCounter As Integer
        Dim objConn As New ADODB.Connection
        Dim objExcel As New ADOX.Catalog
        Dim strExcelData As New StringBuilder("")
        Dim intPageLength As Integer
        Dim m_objOLEConnection As OleDbConnection
        Dim m_objOLEAdapter As OleDbDataAdapter
        Dim m_objOLECommand As OleDbCommand
        Dim m_objOLEDataReader As OleDbDataReader
        Response.Clear()


        'Establishing the connection with the Source Excel file.
        Dim checkExtension As String = System.IO.Path.GetExtension(UploadedFilePath)
        '' for [OS compatibility]
        If Environment.Is64BitOperatingSystem = True Then
            strConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 12.0;Xml;HDR=No;IMEX=1"""
        Else
            If checkExtension.ToString = ".xls" Then
                strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 8.0;Xml;HDR=No;IMEX=1"""
            ElseIf checkExtension.ToString = ".xlsx" Then
                strConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 12.0;Xml;HDR=No;IMEX=1"""
            End If
        End If

        m_objOLEConnection = New OleDbConnection
        m_objOLEConnection.ConnectionString = strConnectionString

        m_objOLEConnection.Open()

        m_objOLECommand = New OleDbCommand
        m_objOLECommand.Connection = m_objOLEConnection

        m_objOLEAdapter = New OleDbDataAdapter(m_objOLECommand)

        m_objDataSet = New DataSet

        'Getting the name of the Excel WorkSeheet through ADOX.Catalog
        objConn.ConnectionString = strConnectionString
        objConn.Open()
        objExcel.ActiveConnection = objConn
        Dim myTableName = m_objOLEConnection.GetSchema("Tables").Rows(0)("TABLE_NAME")
        Dim intFieldCount As Integer
        Dim intDataTableColumn As Integer
        'Getting all the column names from the source excel file.
        'strSQL = "Select * from [" & myTableName & "]"
        strSQL = "Select * from [" & myTableName & "]"
        m_objOLECommand.CommandText = strSQL

        m_objOLEDataReader = m_objOLECommand.ExecuteReader(CommandBehavior.SingleResult)
        intFieldCount = m_objOLEDataReader.FieldCount


        ''Filling the SourceColumns global array.
        'ReDim m_arrSourceColumns(m_objOLEDataReader.FieldCount - 1)
        'For intCounter = 0 To m_objOLEDataReader.FieldCount - 1
        '    m_arrSourceColumns(intCounter) = m_objOLEDataReader.GetName(intCounter)
        'Next

        m_objOLEDataReader.Close()
        m_objOLEDataReader = Nothing

        'Filling the global dataset with all the source data.
        m_objOLEAdapter.Fill(m_objDataSet)

        For k As Int16 = intFieldCount + 1 To 12
            m_objDataSet.Tables(0).Columns.Add("F" & k)
        Next

        Dim strQuery As String = ""
        Dim drExceField As IDataReader
        Dim FieldDictionary As New System.Collections.Specialized.StringDictionary
        Dim FieldCaptionDictionary As New System.Collections.Specialized.StringDictionary

        Dim arrColCaptions() As String = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"}
        Dim strFieldName As String
        Dim errMsg As String = ""
        Dim strQueryData As New StringBuilder("")
        Dim strExcelValidateData As New StringBuilder("")
        Dim strTableHeaderHTML As New StringBuilder("")
        Dim strTempQuery As String
        Dim strTDData As String = ""

        strQuery = "Usp_NG2_Sel_tbl_PM_PBSExcelUpload_Fields " & Session("intProjectID")
        drExceField = CommonFunctions.Data.GetDataReader(strQuery, True)

        While drExceField.Read
            FieldDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("PBFieldName")))
            FieldCaptionDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("PBFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("FieldCaption")))
        End While

        'Added By Ankush T 25 May 2018 for steps excel upload
        strExcelData.Append("<div class='btn-group btn-breadcrumb'style='width:100% !important;'>")
        strExcelData.Append("<a href='#' class='btn btn-info clsCategory' id='astep1' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Excel Upload' onclick='BackProcess_onclick()'>Step 1</a>") 'disabled
        strExcelData.Append("<a href='#' class='btn btn-info clsCategory' id='astepnew2' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Excel Upload mapping' onclick='BackExcel_onclick()'>Step 2</a>")
        strExcelData.Append("<a href='#' class='btn btn-info clsCategory' id='astepnew3' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Upload'>Step 3</a>")

        strExcelData.Append("</div>")
        'End of Added By Ankush T 25 May 2018 for steps excel upload

        'strExcelData.Append("<div class='container'>")
        strExcelData.Append("<div class='row' id='Exceluploadfile'>")
        'strExcelData.Append("<div class='' ")  'col-sm-3 col-md-3'>
        'strExcelData.Append("<div class='panel-group' id='accordion'>")
        'strExcelData.Append("<div class='panel panel-default'>") 'panel-default 1
        'strExcelData.Append("<div class='panel-heading'>")
        strExcelData.Append("<h4 class='panel-title' style='display:inline;'>")
        strExcelData.Append("<a data-bs-toggle='collapse'  href='#collapseOne'><span class='fa fa-file-excel-o'>") 'data-parent='#accordion'
        strExcelData.Append("</span>&nbsp; Uploaded Data :- <label class='clsFileName' >" & OriginalFileName & "(" & CStr(DateTime.Now) & ")</label></a>")
        strExcelData.Append(" </h4>")

        'strExcelData.Append("<a href=# id='faUpload' onclick='UploadFile_Click(this);' data-bs-toggle='tooltip' title='Upload' style='display:inline;float:right;'  ><i class='fa fa-upload' ></i></a>")

        strExcelData.Append(" </div>")
        'strExcelData.Append("<div id='collapseOne' class='panel-collapse collapse in'>")
        strExcelData.Append("<div  id='excelDataDiv' >") 'class='panel-body'

        strExcelData.Append("<div id='excelDataDivInner' >")

        strExcelData.Append("<div class='row' style='padding:5px; width:100%;'>")
        strExcelData.Append("<div class='input-group input-group-sm' style='float:right;margin-right:2%'>")
        strExcelData.Append("<input type='search' name='txtSearchExcelData' id='txtSearchExcelData' class='txtBox form-control' placeholder='User Stories'>")
        strExcelData.Append("<button type='button' class='btn btn-default'' style='padding:4px 12px!important;float:right;margin-right:-21%;border:none!important;'><i style='font-size:14px!important;color:black;' class='fa fa-search'></i></button>")
        strExcelData.Append("</div>")
        strExcelData.Append("</div>")

        strExcelData.Append("<input type=hidden id='hdnAttachmentID' value='" & strAttachmentID & "' >")
        strExcelData.Append("<table class='clsGridTable'  id='tblexcelupload' border='1' style='border:1px solid #ddd; border-color:#ddd;width:100%'>")
        strTableHeaderHTML.Append("<thead>")
        If strTableHeaderHTML IsNot Nothing Then
            strTableHeaderHTML.Append("<TH class = 'panel-heading' style='width:2%;text-align:center;'>Is Valid</TH>")
        End If
        '  Dim value As Integer = 101 ' 
        If m_objDataSet.Tables(0).Rows.Count > 100 Then
            Ischecklimit = "1"
            strExcelData.Append("<input type='hidden' value='" & Ischecklimit & "' id='hdnIschecklimit' />")
            'Return Ischecklimit
        Else
            Ischecklimit = "0"

        End If

        For Each drPBUS As DataRow In m_objDataSet.Tables(0).Rows

            errMsg = ""
            strQueryData.Clear()
            strExcelValidateData.Clear()
            'strQueryData.Append("Usp_App_Ins_tbl_PM_PBUserStories_Temp " & strAttachmentID)               

            For j As Integer = 0 To 11
                strFieldName = FieldDictionary.Item(arrColCaptions(j))

                strQueryData.Append(",'" & CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j))).Replace("'", "''") & "'")

                strTDData = CStr(Replace(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j)), "'", "''"))

                If strTableHeaderHTML IsNot Nothing Then
                    If strFieldName <> "" Then
                        strTableHeaderHTML.Append("<TH class = 'panel-heading' align=center >" & FieldCaptionDictionary(strFieldName) & "</TH>")
                    Else
                        strTableHeaderHTML.Append("<TH class = 'panel-heading' align=center >" & arrColCaptions(j) & "</TH>")
                    End If
                End If

                Select Case strFieldName
                    Case "FunctionalNo"

                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'If strTDData.Length > 50 Then
                        '    errMsg &= "<li> Functional No should not exceed 50 characters.</li>" & vbCrLf
                        'End If

                        If (strTDData = "") Then
                            errMsg &= "Functional No should not left blank.<br>" & vbCrLf
                        Else
                            Try
                                If strTDData.Length > 50 Then
                                    errMsg &= "Functional No should not exceed 50 characters.<br>" & vbCrLf
                                End If
                            Catch ex As Exception

                            End Try

                        End If
                            'End of added by Ankush T on 25 May 2018 for steps excel upload

                    Case "BusinessValue"

                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'If strTDData.Length > 1000 Then
                        '    errMsg &= "<li> Business Value should not exceed 1000 characters.</li>" & vbCrLf
                        'End If

                        If (strTDData = "") Then
                            errMsg &= "Business Value should not left blank.<br>" & vbCrLf
                        Else
                            Try
                                If strTDData.Length > 50 Then
                                    errMsg &= "Business Value No should not exceed 50 characters.<br>" & vbCrLf
                                End If
                                If strTDData.Length > 1000 Then
                                    errMsg &= "Business Value should not exceed 1000 characters.<br>" & vbCrLf
                                End If
                            Catch ex As Exception

                            End Try

                        End If
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "AcceptanceCriteria"

                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'If strTDData.Length > 200 Then
                        '    errMsg &= "<li> Acceptance Criteria should not exceed 200 characters.</li>" & vbCrLf
                        'End If

                        If (strTDData = "") Then
                            errMsg &= "Acceptance Criteria should not left blank.<br>" & vbCrLf
                        Else
                            Try
                                If strTDData.Length > 200 Then
                                    errMsg &= "Acceptance Criteria should not exceed 200 characters.<br>" & vbCrLf
                                End If
                            Catch ex As Exception

                            End Try

                        End If
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "UserStoryName"

                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'If (strTDData = "") Then
                        '    errMsg &= "<li> UserStoryName should not left blank.</li>" & vbCrLf
                        'End If

                        'If strTDData.Length > 1000 Then
                        '    errMsg &= "<li> UserStoryName should not exceed 1000 characters.</li>" & vbCrLf
                        'End If


                        If (strTDData = "") Then
                            errMsg &= "User Story Name should not left blank.<br>" & vbCrLf
                        End If
                        Try
                            If strTDData.Length > 1000 Then
                                errMsg &= "User Story Name should not exceed 1000 characters.<br>" & vbCrLf
                            End If
                        Catch ex As Exception

                        End Try
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "Description"
                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'If (strTDData = "") Then
                        '    errMsg &= "<li> Description should not left blank.</li>" & vbCrLf
                        'End If
                        'If strTDData.Length > 1000 Then
                        '    errMsg &= "<li> Description should not exceed 1000 characters.</li>" & vbCrLf
                        'End If

                        If (strTDData = "") Then
                            errMsg &= "Description should not left blank.<br>" & vbCrLf
                        End If
                        Try
                            If strTDData.Length > 1000 Then
                                errMsg &= "Description should not exceed 1000 characters.<br>" & vbCrLf
                            End If
                        Catch ex As Exception

                        End Try
                            'End of added by Ankush T on 25 May 2018 for steps excel upload

                    Case "Complexity"
                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'If strTDData.Length > 50 Then
                        '    errMsg &= "<li> Complexity should not exceed 50 characters.</li>" & vbCrLf
                        'End If

                        'If strTDData <> "" Then
                        '    If strTDData <> "High" And strTDData <> "Medium" And strTDData <> "Low" Then
                        '        errMsg &= "<li> Complexity should be in 'High','Medium' and 'Low' Only.</li>" & vbCrLf
                        '    End If
                        'End If

                        If (strTDData = "") Then
                            errMsg &= "Complexity should not left blank.<br>" & vbCrLf
                        Else
                            Try
                                If strTDData.Length > 50 Then
                                    errMsg &= "Complexity should not exceed 50 characters.<br>" & vbCrLf

                                End If

                                If strTDData <> "" Then
                                    If strTDData <> "High" And strTDData <> "Medium" And strTDData <> "Low" Then
                                        errMsg &= "Complexity should be in 'High','Medium' and 'Low' Only.<br>" & vbCrLf
                                    End If
                                End If
                            Catch ex As Exception

                            End Try

                        End If
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "State"
                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'If strTDData.Length > 50 Then
                        '    errMsg &= "<li> State should not exceed 50 characters.</li>" & vbCrLf
                        'End If

                        'If strTDData <> "" Then
                        '    If strTDData <> "Active" And strTDData <> "InActive" Then
                        '        errMsg &= "<li> State should 'Active' or 'InActive' Only.</li>" & vbCrLf
                        '    End If
                        'End If


                        If (strTDData = "") Then
                            errMsg &= "State should not left blank.<br>" & vbCrLf
                        Else
                            Try
                                If strTDData.Length > 50 Then
                                    errMsg &= "State should not exceed 50 characters.<br>" & vbCrLf
                                End If

                                If strTDData <> "" Then
                                    If strTDData <> "Active" And strTDData <> "InActive" Then
                                        errMsg &= "State should 'Active' or 'InActive' Only.<br>" & vbCrLf
                                    End If
                                End If
                            Catch ex As Exception

                            End Try

                        End If
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "Version"
                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'Dim strSQLToValidate As String = ""
                        'Dim strResult As String = ""

                        'strSQLToValidate = "Usp_NG2_Validate_PB_Data " & Session("intProjectID") & ",'" & strTDData & "','Version'"
                        'strResult = CommonFunctions.Data.GetDataScalar(strSQLToValidate, True)

                        'If strResult = "0" Then
                        '    errMsg &= "<li> Version field data is not matched with existing data.</li>" & vbCrLf
                        'End If

                        Dim strSQLToValidate As String = ""
                        Dim strResult As String = ""

                        If (strTDData = "") Then
                            errMsg &= "Version should not left blank.<br>" & vbCrLf
                        End If
                        Try
                            strSQLToValidate = "Usp_NG2_Validate_PB_Data " & Session("intProjectID") & ",'" & strTDData & "','Version'"
                            strResult = CommonFunctions.Data.GetDataScalar(strSQLToValidate, True)

                            If strResult = "0" Then
                                errMsg &= "Version field data is not matched with existing data.<br>" & vbCrLf
                            End If
                        Catch ex As Exception

                        End Try
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "CategoryID"
                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'Dim strSQLToValidate As String = ""
                        'Dim strResult As String = ""

                        'strSQLToValidate = "Usp_NG2_Validate_PB_Data " & Session("intProjectID") & ",'" & strTDData & "','Category'"
                        'strResult = CommonFunctions.Data.GetDataScalar(strSQLToValidate, True)

                        'If strResult = "0" Then
                        '    errMsg &= "<li> Category field data is not matched with existing data.</li>" & vbCrLf
                        'End If

                        Dim strSQLToValidate As String = ""
                        Dim strResult As String = ""

                        'If (strTDData = "") Then
                        '    errMsg &= "Category should not left blank.<br>" & vbCrLf
                        'End If
                        Try
                            If (strTDData <> "") Then
                                strSQLToValidate = "Usp_NG2_Validate_PB_Data " & Session("intProjectID") & ",'" & strTDData & "','Category'"
                                strResult = CommonFunctions.Data.GetDataScalar(strSQLToValidate, True)

                                If strResult = "0" Then
                                    errMsg &= "Category field data is not matched with existing data.<br>" & vbCrLf
                                End If
                            End If
                        Catch ex As Exception

                        End Try
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "FixedVersion"
                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'Dim strSQLToValidate As String = ""
                        'Dim strResult As String = ""

                        'strSQLToValidate = "Usp_NG2_Validate_PB_Data " & Session("intProjectID") & ",'" & strTDData & "','FixedVersion'"
                        'strResult = CommonFunctions.Data.GetDataScalar(strSQLToValidate, True)

                        'If strResult = "0" Then
                        '    errMsg &= "<li> Fixed Version field data is not matched with existing data.</li>" & vbCrLf
                        'End If

                        Dim strSQLToValidate As String = ""
                        Dim strResult As String = ""

                        If (strTDData = "") Then
                            errMsg &= "Fixed Version should not left blank.<br>" & vbCrLf
                        End If
                        Try
                            strSQLToValidate = "Usp_NG2_Validate_PB_Data " & Session("intProjectID") & ",'" & strTDData & "','FixedVersion'"
                            strResult = CommonFunctions.Data.GetDataScalar(strSQLToValidate, True)

                            If strResult = "0" Then
                                errMsg &= "Fixed Version field data is not matched with existing data.<br>" & vbCrLf
                            End If
                        Catch ex As Exception

                        End Try
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "Priority"
                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'Dim strSQLToValidate As String = ""
                        'Dim strResult As String = ""
                        'If (strTDData = "") Then
                        '    errMsg &= "<li> Priority should not left blank.</li>" & vbCrLf
                        'End If

                        'strSQLToValidate = "Usp_NG2_Validate_PB_Data " & Session("intProjectID") & ",'" & strTDData & "','Priority'"
                        'strResult = CommonFunctions.Data.GetDataScalar(strSQLToValidate, True)
                        'If strResult = "0" Then
                        '    errMsg &= "<li> Priority Should be like Must Have,Should Have,Could Have,Won't Have</li>" & vbCrLf
                        'End If

                        Dim strSQLToValidate As String = ""
                        Dim strResult As String = ""
                        If (strTDData = "") Then
                            errMsg &= "Priority should not left blank.<br>" & vbCrLf
                        End If
                        Try
                            strSQLToValidate = "Usp_NG2_Validate_PB_Data " & Session("intProjectID") & ",'" & strTDData & "','Priority'"
                            strResult = CommonFunctions.Data.GetDataScalar(strSQLToValidate, True)
                            If strResult = "0" Then
                                errMsg &= "Priority Should be like Must Have,Should Have,Could Have,Won't Have<br>" & vbCrLf
                            End If
                        Catch ex As Exception

                        End Try
                            'End of added by Ankush T on 25 May 2018 for steps excel upload
                    Case "InitialEstimate"
                        'Commented and added by Ankush T on 25 May 2018 for steps excel upload
                        'If IsNumeric(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j))) = False Then
                        '    errMsg &= "<li> Story Point should be a valid positive integer.</li>" & vbCrLf
                        'End If

                        Try
                            If IsNumeric(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j))) = False Then
                                errMsg &= "Story Point should be a valid positive integer.<br>" & vbCrLf
                            End If
                        Catch ex As Exception

                        End Try
                        'End of added by Ankush T on 25 May 2018 for steps excel upload
                End Select

                strExcelValidateData.Append("<td title='" & strFieldName & "' >")
                strExcelValidateData.Append(strTDData)
                strExcelValidateData.Append("</td>")
            Next

            If strTableHeaderHTML IsNot Nothing Then
                strTableHeaderHTML.Append("<TH class = 'panel-heading'>Errors</TH>")
                strTableHeaderHTML.Append("</thead>")
                strTableHeaderHTML.Append("<tbody>")
                strExcelData.Append(strTableHeaderHTML.ToString)
                strTableHeaderHTML = Nothing
            End If

            strTempQuery = "Usp_NG2_Ins_tbl_PM_PBUserStories_Temp " & strAttachmentID

            If errMsg = "" Then
                strTempQuery &= ",1"
                strExcelData.Append("<tr class='clsValidRow' style='color:darkgreen'>") '
                strExcelData.Append("<td  class='clsvalidRowIndication' >")
                'Added & commented By dipali v On 25th April 2019 for valid record check box enabled
                strExcelData.Append("<input type=checkbox id='chkUS' id='chkUS' class='chkUS' checked disabled />")
                'strExcelData.Append("<input type=checkbox id='chkUS' id='chkUS' class='chkUS' checked  />")
                'End of Added & commented By dipali v On 25th April 2019 for valid record check box enabled
                strExcelData.Append("</td>")
            Else
                strTempQuery &= ",0"
                strExcelData.Append("<tr class='clsInValidRow' style='color:red'>")
                strExcelData.Append("<td  class='clsInvalidRowIndication'>")
                strExcelData.Append("<input type=checkbox id='chkUS' id='chkUS' class='chkUS' disabled />")
                strExcelData.Append("</td>")
            End If

            strExcelData.Append(strExcelValidateData.ToString)

            strTempQuery &= strQueryData.ToString

            Try
                'Insert Excel Row into the table
                CommonFunctions.Data.InsertOrUpdateData(strTempQuery, True)
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try


            strTempQuery = ""

            strExcelData.Append("<td title='Error Description' >")
            If errMsg = "" Then
                strExcelData.Append("<i class='fa fa-check' aria-hidden='true'></i>")
            Else
                strExcelData.Append("" & errMsg & "")
            End If

            strExcelData.Append("</td>")

            strExcelData.Append("</tr>")
        Next
        strExcelData.Append("</tbody>")
        strExcelData.Append("</table>")
        'strExcelData.Append("</div>")
        'strExcelData.Append("</div>")
        'strExcelData.Append("</div>")
        'strExcelData.Append("</div>")
        'strExcelData.Append("</div>")

        'strExcelData.Append("</div>")
        strExcelData.Append("<input type='hidden' value='" & Ischecklimit & "' id='hdnIschecklimit' />")
        strExcelData.Append("</Div></Div>") 'End accordian to container


        'Added By Ankush T on 23 May 2018 for Excel Upload
        strExcelData.Append("<Div>")

        Dim drValidRequestIDs As IDataReader
        Dim ValidRequests As String
        Dim InValidRequests As String
        drValidRequestIDs = CommonFunction.Data.GetDataReader("usp_SEL_Count_ValidInvalidRowtbl_PM_PBUserStories_Temp " & strAttachmentID, True)
        If drValidRequestIDs.Read() Then
            ValidRequests = CommonFunction.Data.CheckIsDBNull(drValidRequestIDs("ValidRow").ToString(), "0")
            InValidRequests = CommonFunction.Data.CheckIsDBNull(drValidRequestIDs("InvalidRow").ToString(), "0")
        End If
        strExcelData.Append("<input type=hidden name='hdnvalidRowCount' id='hdnvalidRowCount' value=" & ValidRequests & " >")
        strExcelData.Append("<input type=hidden name='hdnInvalidRowCount' id='hdnInvalidRowCount' value=" & InValidRequests & " >")
        CommonFunctions.Data.DisposeDataReader(drValidRequestIDs)
        strExcelData.Append("<div style='float:right; margin-top: 3%; padding-left: 5px;'><button type='button' class='btn btn-primary Theam clsCategory' id='btnProcess' style='margin-right:7px;'  title='Upload Excel'  onclick='UploadExcel_Click(this)' >Upload</button></div>")

        strExcelData.Append("<div style='float:right; margin-top: 3%;'><button type='button' class='btn btn-primary Theam clsCategory' id='btnBack' style='margin-right:7px;'  title='Back'  onclick='BackExcel_onclick()' >Back</button></div>")

        strExcelData.Append("</Div>")

        'End of Added By Ankush T on 23 May 2018 for Excel Upload


        Response.Write(strExcelData.ToString)
        Response.End()
        'Dim sqlcmd As New SqlCommand("Usp_App_Ins_tbl_PM_PBUserStories_Temp")
        'sqlcmd.Parameters.AddWithValue("@tblPBUserStories", m_objDataSet.Tables(0))
        'sqlcmd.Parameters.AddWithValue("@intAttachmentID", strAttachmentID)
        'sqlcmd.CommandType = CommandType.StoredProcedure
        'CommonFunction.Data.GetSQLCommandExecute(sqlcmd, True)

        'Commented And Added By Usha Pandit On 25.10.2020 For checking m_objOLEDataReader is null
        'If m_objOLEDataReader.IsClosed = False Then
        '    m_objOLEDataReader.Close()
        '    m_objOLEDataReader = Nothing
        'End If
        If Not m_objOLEDataReader Is Nothing Then
            If m_objOLEDataReader.IsClosed = False Then
                m_objOLEDataReader.Close()
                m_objOLEDataReader = Nothing
            End If
        End If
        'End Of Added By Usha Pandit On 25.10.2020 For checking m_objOLEDataReader is null

        'If objRequestInfo.m_intEndRow = 0 Then objRequestInfo.m_intEndRow = m_objDataSet.Tables(0).Rows.Count
        'objRequestInfo.m_intTotalRecords = m_objDataSet.Tables(0).Rows.Count

        If objConn.State = ConnectionState.Open Then
            objConn.Close()
            objConn = Nothing
        End If

        If objConn.State = ConnectionState.Open Then
            objConn.Close()
            objConn = Nothing
        End If
        'Commented And Added By Usha Pandit On 27.07.2020 For checking m_objOLEDataReader is null
        'If m_objOLEDataReader.IsClosed = False Then
        '    m_objOLEDataReader.Close()
        '    m_objOLEDataReader = Nothing
        'End If
        If Not m_objOLEDataReader Is Nothing Then
            If m_objOLEDataReader.IsClosed = False Then
                m_objOLEDataReader.Close()
                m_objOLEDataReader = Nothing
            End If
        End If
        'End Of Added By Usha Pandit On 27.07.2020 For checking m_objOLEDataReader is null






    End Function
    Function CheckIsProductOwner(ByVal strUserID As String)


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

    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SwapnilA
        ' Created               :	3-JAN-2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22232, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        strIsPrductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))
    End Sub

    Public Function Modal_popup() As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("  <div class='modal fade ' id='divProductBacklog' role='dialog'>")
        ''Added By kashish On 4 April 2018 For Ui change
        strHTML.Append("  <div class='modal-dialog modal-lg' id='ClsModal'>") 'style='width:100%'
        ''End of Added By kashish On 4 April 2018 For Ui change
        strHTML.Append("<div class='modal-content'>")


        strHTML.Append("<div class='container-fluid'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-12'style='' id='divProductBacklog_Body'>")


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function

    Public Function Table_Backlog(Optional ByVal strEntityID As String = "", Optional ByVal strEntity As String = "", Optional ByVal UserStoryID As String = "") As String


        Dim strHTML As New StringBuilder()
        Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID")

        If strEntity = "Category" Then
            strSql &= "," & strEntityID
        ElseIf strEntity = "Priority" Then
            strSql &= ",NULL," & strEntityID
        End If
        Dim dtProductBacklog As New DataTable()
        dtProductBacklog = CommonFunctions.Data.GetDataTable(strSql, True)
        'added by Ashwini M on 24-3-2023
        strHTML.Append("<div class='table-responsive table-bordered col-sm-3' id='leftTree' style='overflow-y: scroll; height: 515px;padding-right: 0px;padding-left: 12px;position:relative;'>")
        'End Of added by Ashwini M On 24-3-2023
        strHTML.Append(" <table class='table'>")
        strHTML.Append("	<thead>")
        strHTML.Append("	  <tr><th style=';text-align: left!important; border: none!important;'>Backlogs</th><th style='position: absolute;right: 0px;border: none!important'>")
        strSql = "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & ""
        Dim dtCategory As New DataTable
        dtCategory = CommonFunctions.Data.GetDataTable(strSql, True)
        strHTML.Append("<div  data-bs-toggle='dropdown' style='cursor:pointer;'><i  data-bs-toggle='tooltip' title='Settings' style='font-size:16px!important' data-bs-placement='bottom' data-container='body' class='fa fa-align-justify Home'></i></div>")
        strHTML.Append("<ul class='dropdown-menu dropdown_category ' role='menu'>")
        strHTML.Append("<li style='border-bottom:1px solid #ddd;'>")
        strHTML.Append("<b>Category</b>")
        strHTML.Append("</li>")
        For i As Integer = 0 To dtCategory.Rows.Count - 1
            If dtCategory.Rows(i)("CategoryID").ToString() = strEntityID And strEntity = "Category" Then
                strHTML.Append("<li style='background-color:#ddd' onclick=FilterData('Category'," & dtCategory.Rows(i)("CategoryID") & ",this)>")
            Else
                strHTML.Append("<li onclick=FilterData('Category'," & dtCategory.Rows(i)("CategoryID") & ",this)>")
            End If
            strHTML.Append(dtCategory.Rows(i)("Category"))
            strHTML.Append("</li>")

        Next

        strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities"
        dtCategory = CommonFunctions.Data.GetDataTable(strSql, True)
        strHTML.Append("<li style='border-bottom:1px solid #ddd;'>")
        strHTML.Append("<b>Priority</b>")
        strHTML.Append("</li>")
        For i As Integer = 0 To dtCategory.Rows.Count - 1
            If dtCategory.Rows(i)("PriorityID").ToString() = strEntityID And strEntity = "Priority" Then
                strHTML.Append("<li style='background-color:#ddd' onclick=FilterData('Priority'," & dtCategory.Rows(i)("PriorityID") & ",this)>")
            Else
                strHTML.Append("<li onclick=FilterData('Priority'," & dtCategory.Rows(i)("PriorityID") & ",this)>")
            End If
            strHTML.Append(dtCategory.Rows(i)("Priority"))
            strHTML.Append("</li>")
        Next
        strHTML.Append("</ul>")
        strHTML.Append("</th> </tr>")
        strHTML.Append("	</thead>")
        strHTML.Append("	<tbody id='tblUserStory_body'>")
        For i As Integer = 0 To dtProductBacklog.Rows.Count - 1
            If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) <> 0 Then
                If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "").ToString() = UserStoryID Then
                    strHTML.Append("<tr><td style='cursor:pointer;color:#3c7dcf' colspan=2 onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><small>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "").ToString() & "</small>&nbsp;&nbsp;" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString() & "</td> </tr>")

                Else
                    strHTML.Append("<tr><td style='cursor:pointer;' colspan=2 onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><small>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "").ToString() & "</small>&nbsp;&nbsp;" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString() & "</td> </tr>")

                End If
            End If
        Next
        strHTML.Append("	</tbody>")
        strHTML.Append("	</table>")
        strHTML.Append("</div>")

        Return (strHTML.ToString())

    End Function

    Public Function Heading_section(ByVal UserStoryId As String) As String
        GetAccessRights()


        Dim strHTML As New StringBuilder()
        Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory " & UserStoryId
        Dim drGetUserStory As IDataReader
        drGetUserStory = CommonFunctions.Data.GetDataReader(strSql, True)

        If drGetUserStory.Read Then
            strFunctionalNumber = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FunctionalNo").ToString, "")
            strFeatureName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("UserStoryName").ToString, "")
            strUserDesc = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Description").ToString, "")
            strBusinesValue = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("BusinessValue").ToString, "")
            strPriority = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("PriorityID").ToString, "")
            strState = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("State").ToString, "")
            strComplexity = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Complexity").ToString, "")
            strCategory = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CategoryID").ToString, "")
            strVersion = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Version").ToString, "")
            'Commented & Added By Dipali V On 10th April 2018 For Access Issue
            'strIterationName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("IterationID"), 0)
            strIterationName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("IterationID"), 0)
            'End of Commented & Added By Dipali V On 10th April 2018 For Access Issue
            strReleaseName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("ReleaseID"), "")
            strCreatedDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CreatedDate").ToString, "")
            strCreatedBy = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CreatedBy").ToString, "")
            strCategoryColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CategoryColor").ToString, "")
            strVersionColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("VersionColor").ToString, "")
            strPriorityColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("PriorityColor").ToString, "")
            strStoryPoint = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("InitialEstimate").ToString, "")
            strInitialRank = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("InitialRank").ToString, "") ''Added By Dipali V On 2nd March
            strStatus = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Status").ToString, "")
            strAcceptanceCriteria = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("AcceptanceCriteria").ToString, "")
            strFixedVersion = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FixedVersion").ToString, "")
            strFixedVersionColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FixedVersionColor").ToString, "")
        End If
        globalUSID = UserStoryId
        drGetUserStory.Dispose()
        If strIterationName = 0 Then
            strIterationName = ""
        End If
        strHTML.Append("<div class='col-sm-9' style='-ms-overflow-style:none;'>")
        strHTML.Append("<input type='hidden' value='" & UserStoryId & "' id='hdnusid' />")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
        'strHTML.Append("<div style='height:50px;width:50px;background-color:" & strPriorityColor & ";' class='img-circle' ></div>" & vbCrLf)
        strHTML.Append("<div style='height:50px;width:50px;position: relative;'><i class='fa fa-certificate' aria-hidden='true' style='font-size: 60px;color:" & strPriorityColor & ";'></i>")
        strHTML.Append("<p style='color: white;font-weight: 600;font-size: 14px;position: absolute;top: 19px;left:0;right:0;    text-align: center;' title='User story ID' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & UserStoryId & "</p></div>")

        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-1'>" & vbCrLf)

        'strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-9'>" & vbCrLf)

        strHTML.Append("<p style='font-size: 16px; font-weight: 500;word-break:break-all;' ><span class='userstoryname'  title='User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strFeatureName & "</span></p>" & vbCrLf)
        strHTML.Append("<label style='white-space:nowrap;font-weight:normal;font-size:11px'>Created By: " & strCreatedBy & " On " & Convert.ToDateTime(strCreatedDate).ToString("dd-MMM-yyyy") & "</label>" & vbCrLf)
        'added by Ashwini M on 24-3-2023
        strHTML.Append("<p class='label label-warning' style='font-weight: 600;font-size: 14px;position: absolute;margin-left:9px;' title='Rank' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strInitialRank & "</p>" & vbCrLf)
        'End Of added by Ashwini M On 24-3-2023
        strHTML.Append("</div>")

        strHTML.Append("<div>" & vbCrLf)
        strHTML.Append("<button type='button' class='close' data-dismiss='modal' onclick='RefreshGrid()'>&times;</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-2'>" & vbCrLf)
        strHTML.Append("")
        strHTML.Append("</div>")

        'strHTML.Append("<div class='row' id='creation_status'>")


        'strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='row '>")
        strHTML.Append("<div class='col-sm-11'>")
        strHTML.Append("")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-1 right'>")
        Dim strIsSprintstatus As String = ""
        If (UserStoryId <> "" Or UserStoryId <> "0") Then

            strIsSprintstatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & UserStoryId & ",'UserStory'", True))
            If strIsSprintstatus = "0" Then
                'Commented and Added by Ankush T 03-april-2019 for Userstory view details popup save button not display
                'If m_objAccess.Edit = True Then
                '    strHTML.Append("<i class='fas fa-trash-alt' aria-hidden='true' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Delete User Story' onclick=""Delete_UserStory(" & UserStoryId & ",'')""></i>")
                'End If
                If m_objAccess.Edit = True Then
                    strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
                End If
                ' Commented and Added by Ankush T 03-april-2019  Aug 2018 for Userstory view details popup save button not display
            End If
        Else
            If strIterationName = "" And strIsSprintstatus = "0" Then
                If m_objAccess.Add = True Then
                    strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
                End If
            End If
        End If


        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
        strIsSprintStarted = strIsSprintstatus
        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not


        If strIsSprintstatus = "0" Then
            If m_objAccess.Delete = True Then
                'Added By Dipali v On 28th feb 2019 For PO Access to Delete US
                'added by Ashwini M on 24-3-2023 for trash icon
                If strIsPrductOwner = "1" Then
                    strHTML.Append("<i class='fas fa-trash-alt' aria-hidden='true' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Delete User Story' onclick=""Delete_UserStory(" & UserStoryId & ",'')""></i>")
                Else
                    strHTML.Append("<i class='fas fa-trash-alt' aria-hidden='true' data-bs-toggle='tooltip' data-bs-placement='bottom' title='You do not have access'></i>")
                    'End Of added by Ashwini M On 24-3-2023 for trash icon
                End If
                'End of Added By Dipali v On 28th feb 2019 For PO Access to Delete US
            End If
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div><hr>")
        Return (strHTML.ToString())

    End Function

    Public Function Tab_section() As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class=' '>")
        strHTML.Append("<ul class='' id=ulTabs>" & vbCrLf)
        strHTML.Append("<li class='active' ><a href='#frmDetails' style='text-decoration: underline;color:#5bc0de'>Details</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divSubstories'>Substories</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divAttachments'>Attachments</a></li> " & vbCrLf)
        strHTML.Append("<li ><a href='#divDiscussions'>Discussion</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divResource'>Teams</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divHistory'>History</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divIssues'>Issues</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divReviews'>Reviews</a></li>" & vbCrLf)
        'strHTML.Append("<li><a href='#divTasks'>Task</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divChart'>Charts</a></li>" & vbCrLf)
        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function

    'Public Function Form_section(ByVal UserStoryId As String, Optional ByVal CategoryID As String = "") As String
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("")
    '    If CategoryID <> "" Then
    '        strCategory = CategoryID
    '    End If
    '    Try
    '        Dim drGetSelectedCheckBoxValue As IDataReader
    '        Dim SelectedCheckbox As String = ""
    '        Dim SelectedCheckboxSplit() As String
    '        Dim str As String = "usp_NG2_GetSelectedUserStoryColumnsForUser " & Session("intUserID") & ""
    '        drGetSelectedCheckBoxValue = CommonFunctions.Data.GetDataReader(str, True)
    '        While drGetSelectedCheckBoxValue.Read()
    '            SelectedCheckbox = CommonFunctions.Data.CheckIsDBNull(drGetSelectedCheckBoxValue("SelectedColumns").ToString, "")
    '        End While
    '        SelectedCheckboxSplit = SelectedCheckbox.Split(",")


    '        strHTML.Append(" <Div id='frmDetails' class='clsBox'>")
    '        For Each SelectedCheckboxValues As String In SelectedCheckboxSplit
    '            Select Case SelectedCheckboxValues
    '                Case "FunctionalNo"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Functional No.</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFunctionalNumber", "txtFunctionalNumber", "form-control", 140, 100, strFunctionalNumber, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "")), False, True), , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                Case "UserStoryName"
    '                    strHTML.Append("<div class=''>")
    '                    strHTML.Append("<div class='form-group'>")
    '                    strHTML.Append("<div class='col-md-6 '> <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Userstory Name</label>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFeatureName", "txtFeatureName", "form-control", 190, 100, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup=ClearSpan('txtFeatureName','spanFeatureName')", True, , , , , , True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanFeatureName' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "Description"
    '                    strHTML.Append(" <div class=''>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" ")
    '                    strHTML.Append(" <div class='col-md-6'> <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Description</label>")
    '                    Dim len As Integer = 1000
    '                    Dim len1 As Integer
    '                    If strUserDesc.Length <> -1 Then
    '                        len1 = strUserDesc.Length
    '                        len = 1000 - len1
    '                    End If
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtUserDesc", "txtUserDesc", , "form-control", , , , , , 36, len, strUserDesc, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc')", True, EnableHTMLEncode:=True))
    '                    strHTML.Append("<small name='countdown' Id='countdown'  style='border-style:None;float: left;margin-top:2%;margin-left:100%'>" & len & "</small>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanUserDesc' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "BusinessValue"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Business Value</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtBusinessValue", "txtBusinessValue", , "form-control", , , , , 190, , 200, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownBU,200)' onKeyUp='javascript:limitText(this,countdownBU, 200)' onkeyup=ClearSpan('txtUserDesc','spanUserDesc')", True, , , , , , , , , True))
    '                    strHTML.Append("<small name='countdownBU' Id='countdownBU'  style='border-style:None;float: left;margin-top:-2%;margin-left:98%'>" & (200 - strBusinesValue.Length) & "</small>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanBusinessValue' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "Priority"
    '                    strHTML.Append(" <div class=''>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <div class='col-md-6'> <label class='control-label' style='white-space: nowrap;margin-top: 11px;'>Priority</label>&nbsp;<a id='aPriority'  data-bs-toggle='dropdown' title='Select Priority Color' style='cursor:pointer' ><i id='iPriorityColor' style='color:" & strPriorityColor & " !important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , strPriority, "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
    '                    strHTML.Append("<table class='table' id='tblPriorityColor'>")
    '                    strHTML.Append("<tr>")
    '                    If UserStoryId <> "" Then
    '                        strHTML.Append(GetColorMaster(strPriority, "Priority"))
    '                    End If
    '                    strHTML.Append("</tr>")
    '                    strHTML.Append("</table>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanPriority' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "State"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>State</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", 190, strState, "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') " & IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanState' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "Complexity"
    '                    strHTML.Append(" <div class=''>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <div class='col-md-6'><label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Complexity</label>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , strComplexity, "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf(strState <> "InActive" And strIterationName = "", "", "disabled"), True, True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanComplexity' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "Status"
    '                Case "Category"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Category</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory", 190, strCategory, "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('cboCategory','spanCategory') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;' />")
    '                    If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then

    '                        strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' title='Add Category' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table id='tblHeader'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Category</h4>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddCategory_OnClick()'; >ADD</button>&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td style='cursor:pointer;width:7%;'>")

    '                        strHTML.Append("<i class='fa fa-close'></i>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
    '                        strHTML.Append("&nbsp; New Category Will available for addition  &nbsp;")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("<table style='width:300px;height:66px;'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td style='text-align:right'>")
    '                        strHTML.Append("Category&nbsp;&nbsp;&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDCategory", "txtADDCategory", "form-control", 174, , , , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , , True, , , , , , True))
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("<td style='position:relative'>")
    '                        strHTML.Append("&nbsp;<a id='aCateColor' data-bs-toggle='dropdown' title='Select Category Color' style='cursor:pointer' ><i id='oColor' style='color:" & strCategoryColor & " !important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table class='table' id='tblCategoryColor'>")
    '                        strHTML.Append("<tr>")
    '                        If UserStoryId <> "" Then
    '                            strHTML.Append(GetColorMaster(strCategory, "Category"))
    '                        End If
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                    End If
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;'></span>")
    '                Case "Version"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Version</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", 190, strVersion, "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then

    '                        strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' data-bs-toggle='tooltip' title='Add Version' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table id='tblHeader'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Version</h4>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddVersion_OnClick()'; >ADD</button>&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<i class='fa fa-close'></i>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
    '                        strHTML.Append("&nbsp; New Version Will available for addition  &nbsp;")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("<table style='width:300px;height:66px;'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td style='text-align:right'>")
    '                        strHTML.Append("Version&nbsp;&nbsp;&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDVersion", "txtADDVersion", "form-control", 200, , , , , , , , , , True, , , , , , True))
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td style='position:relative'>")
    '                        strHTML.Append("&nbsp;<a id='aVersion' data-bs-toggle='dropdown' title='Select Version Color' style='cursor:pointer' ><i id='iVersion' style=' color:" & strVersionColor & "!important;font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table class='table' id='tblVersionColor'>")
    '                        strHTML.Append("<tr>")
    '                        'If UserStoryId <> "" Then
    '                        '    strHTML.Append(GetColorMaster(strVersion, "Version"))
    '                        'End If
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                    End If
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanVersion' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "CreatedBy"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Created By</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(strCreatedBy)
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                Case "CreatedDate"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Created Date</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(strCreatedDate)
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                Case "InitialEstimate"
    '                    strHTML.Append(" <div class=''>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <div class='col-md-6 '><label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Story Point</label> ")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 100, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", True, , , , , , True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanStoryPoint' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "FixedVersion"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Fixed Version</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", 190, strFixedVersion, "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then

    '                        strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' data-bs-toggle='tooltip' title='Add Fixed Version' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table id='tblHeader'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Fixed Version</h4>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddFixedVersion_OnClick()'; >ADD</button>&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<i class='fa fa-close'></i>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
    '                        strHTML.Append("&nbsp; New Version Will available for addition  &nbsp;")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("<table style='width:300px;height:66px;'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td style='text-align:right'>")
    '                        strHTML.Append("Version&nbsp;&nbsp;&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDFixedVersion", "txtADDFixedVersion", "form-control", 200, , , , , , , , , , True, , , , , , True))
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td style='position:relative'>")
    '                        strHTML.Append("&nbsp;<a id='aVersion' data-bs-toggle='dropdown' title='Select Version Color' style='cursor:pointer' ><i id='iFVersion' style=' color:" & strFixedVersionColor & "!important;font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table class='table' id='tblVersionColor2'>")
    '                        strHTML.Append("<tr>")
    '                        If UserStoryId <> "" Then
    '                            strHTML.Append(GetColorMaster(strVersion, "FVersion"))
    '                        End If
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                    End If
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanFixedVersion' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "AcceptanceCriteria"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Acceptance Criteria</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAcceptanceCriteria", "txtAcceptanceCriteria", , "form-control", , , , , 190, , 200, strAcceptanceCriteria, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownAC,200)' onKeyUp='javascript:limitText(this,countdownAC, 200)' onkeyup=ClearSpan('txtAcceptanceCriteria','spanAcceptanceCriteria')", True, , , , , , , , , True))
    '                    strHTML.Append("<small name='countdownAC' Id='countdownAC'  style='border-style:None;float: left;margin-top:-13%;margin-left:100%'>" & (200 - strAcceptanceCriteria.Length) & "</small>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanAcceptanceCriteria' style='color: #dd1037; font-size: 12px;' ></span>")
    '            End Select
    '        Next

    '        strHTML.Append("</Div>")


    '    Catch ex As Exception
    '        Return ex.Message
    '    End Try
    '    Return (strHTML.ToString())
    'End Function


    Public Function Form_section(ByVal UserStoryId As String, Optional ByVal CategoryID As String = "") As String
        Dim strHTML As New StringBuilder()
        strHTML.Append("")
        If CategoryID <> "" Then
            strCategory = CategoryID
        End If
        Try
            Dim drGetSelectedCheckBoxValue As IDataReader
            Dim SelectedCheckbox As String = ""
            Dim SelectedCheckboxSplit() As String
            Dim str As String = "usp_NG2_GetSelectedUserStoryColumnsForUser " & Session("intUserID") & "," & Session("intProjectID")
            drGetSelectedCheckBoxValue = CommonFunctions.Data.GetDataReader(str, True)
            While drGetSelectedCheckBoxValue.Read()
                SelectedCheckbox = CommonFunctions.Data.CheckIsDBNull(drGetSelectedCheckBoxValue("SelectedColumns").ToString, "")
            End While
            SelectedCheckboxSplit = SelectedCheckbox.Split(",")


            strHTML.Append(" <Div id='frmDetails' class=''>")
            For Each SelectedCheckboxValues As String In SelectedCheckboxSplit
                Select Case SelectedCheckboxValues
                    Case "FunctionalNo"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls' style='white-space: nowrap;margin-top: 11px;'>Functional No.</label> ")
                        strHTML.Append(" <div class='col-md-8'>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFunctionalNumber", "txtFunctionalNumber", "form-control", , 100, strFunctionalNumber, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "")), False, True), , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "UserStoryName"
                        Dim len As Integer = 200
                        Dim len1 As Integer
                        If strFeatureName.Length <> -1 Then
                            len1 = strFeatureName.Length
                            len = 200 - len1
                        End If
                        strHTML.Append(" <div class='col-md-12'>")
                        strHTML.Append(" <label class='col-md-2 control-label labelcls'>User Story<span class='required'>*</span></label> ")
                        strHTML.Append(" <div class='col-md-10 '>")
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFeatureName", "txtFeatureName", "form-control", , 200, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "javascript:'limitText(this,countdownFN,200)' onKeyUp='javascript:limitText(this,countdownFN,200)'", True, , , , , , True))

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeatureName", "txtFeatureName", , "form-control", , , , , , , len, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownFN,200)' onKeyUp='javascript:limitText(this,countdownFN, 200)' data-autoresize", True, EnableHTMLEncode:=True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeatureName", "txtFeatureName", , "form-control", , , , , , , len, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup='javascript:limitText(this,countdownFN,200)' onKeyUp='javascript:limitText(this,countdownFN, 200)' data-autoresize", True, EnableHTMLEncode:=True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not

                        strHTML.Append(" <span class='input-group-addon '>")
                        strHTML.Append("<small name='countdownFN' Id='countdownFN'> " & len & " </small>")
                        strHTML.Append("<span id='spanBusinessValue' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "Description"
                        strHTML.Append(" <div class='col-md-12'>")
                        strHTML.Append(" <label class='col-md-2 control-label labelcls'>Description <span class='required'>*</span></label> ")
                        strHTML.Append(" <div class='col-md-10 '>")
                        Dim len As Integer = 1000
                        Dim len1 As Integer
                        If strUserDesc.Length <> -1 Then
                            len1 = strUserDesc.Length
                            len = 1000 - len1
                        End If

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtUserDesc", "txtUserDesc", , "form-control", , , , , , , len, strUserDesc, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtUserDesc", "txtUserDesc", , "form-control", , , , , , , len, strUserDesc, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not

                        strHTML.Append("<small name='countdown' Id='countdown'>" & len & "</small>")
                        strHTML.Append("<span id='spanUserDesc' style='color: #dd1037; font-size: 12px;' ></span>")

                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "BusinessValue"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;margin-top: 11px;'>Business Value</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")

                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtBusinessValue", "txtBusinessValue", , "form-control", , , , , , , 1000, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownBU,1000)' onKeyUp='javascript:limitText(this,countdownBU, 1000)' onkeyup=ClearSpan('txtUserDesc','spanUserDesc')", True, , , , , , , , , True))
                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusinessValue", "txtBusinessValue", "form-control", , 100, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup=ClearSpan('strBusinesValue','strBusinesValue')", True, , , , , , True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusinessValue", "txtBusinessValue", "form-control", , 100, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup=ClearSpan('strBusinesValue','strBusinesValue')", True, , , , , , True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not

                        ' strHTML.Append("<small name='countdownBU' Id='countdownBU'>" & (1000 - strBusinesValue.Length) & "</small>")
                        strHTML.Append("<span id='spanBusinessValue' style='color: #dd1037; font-size: 12px;' ></span>")

                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Priority"
                        strHTML.Append(" <div class='row'>")
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append("<div class='dropdown col-md-4'> <label class='col-md-4 control-label labelcls'>Priority <span class='required'>*</span> &nbsp;<a id='aPriority'  data-bs-toggle='dropdown' title='Select Priority Color' style='cursor:pointer' ><i id='iPriorityColor' style='color:" & strPriorityColor & " !important;' class='fa fa-square' aria-hidden='true'></i></a></label> ")

                        strHTML.Append("<div class='dropdown-menu' role='menu'>")
                        strHTML.Append("<table class='table' id='tblPriorityColor'>")
                        strHTML.Append("<tr>")
                        If UserStoryId <> "" Then
                            strHTML.Append(GetColorMaster(strPriority, "Priority"))
                        End If
                        strHTML.Append("</tr>")
                        strHTML.Append("</table>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append(" <div class='col-md-8'>")

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , strPriority, "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , strPriority, "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not

                        strHTML.Append("<span id='spanPriority' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "State"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;margin-top: 11px;'>State</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", , strState, "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') " & IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", , strState, "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') " & IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not

                        strHTML.Append("<span id='spanState' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Complexity"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls'>Complexity</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , strComplexity, "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf(strState <> "InActive" And strIterationName = "", "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , strComplexity, "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf((strState <> "InActive" And strIterationName = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<span id='spanComplexity' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Status"
                    Case "Category"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls' style='white-space: nowrap;margin-top: 11px;'>Category</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & "", , strCategory, "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('cboCategory','spanCategory') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & "", , strCategory, "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('cboCategory','spanCategory') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;' />")
                        'If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then
                        '    strHTML.Append(" <span class='input-group-addon'>")
                        '    strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' title='Add Category' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='cColorDropDown dropdown-menu category' role='menu'>")
                        '    strHTML.Append("<table id='tblHeader'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Category</h4>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddCategory_OnClick()'; >ADD</button>&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td style='cursor:pointer;width:7%;'>")

                        '    strHTML.Append("<i class='fa fa-close'></i>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
                        '    strHTML.Append("&nbsp; New Category Will available for addition  &nbsp;")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("<table style='width:300px;height:66px;'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td style='text-align:right'>")
                        '    strHTML.Append("Category&nbsp;&nbsp;&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDCategory", "txtADDCategory", "form-control", 174, , , , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , , True, , , , , , True))
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("<td style='position:relative'>")
                        '    strHTML.Append("&nbsp;<a id='aCateColor' data-bs-toggle='dropdown' title='Select Category Color' style='cursor:pointer' ><i id='oColor' style='color:" & strCategoryColor & " !important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='dropdown-menu' role='menu' style='left: unset!important;'>")
                        '    strHTML.Append("<table class='table table-bordered' id='tblCategoryColor' style='background:#fff; left: unset!important;'>")
                        '    strHTML.Append("<tr>")
                        '    If UserStoryId <> "" Then
                        '        strHTML.Append(GetColorMaster(strCategory, "Category"))
                        '    End If
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</span>")
                        'End If

                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;'></span>")

                    Case "CreatedBy"
                        strHTML.Append(" <div class='row'>")
                        strHTML.Append(" <div class='form-group'>")
                        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Created By</label> ")
                        strHTML.Append(" <div class='col-sm-10 '>")
                        strHTML.Append(strCreatedBy)
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "CreatedDate"
                        strHTML.Append(" <div class='row'>")
                        strHTML.Append(" <div class='form-group'>")
                        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Created Date</label> ")
                        strHTML.Append(" <div class='col-sm-10 '>")
                        strHTML.Append(strCreatedDate)
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "InitialEstimate"
                        'strHTML.Append(" <div class=''>") 'commented by Ashwini M on 27-3-2023
                        strHTML.Append(" <div class='col-md-6' style='display:block'>")
                        strHTML.Append(" <div style='display:flex'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls'>Story Point</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", True, , , , , , True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf((strState <> "InActive" And strIterationName = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", True, , , , , , True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<span id='spanStoryPoint' style='color: #dd1037; font-size: 12px;' ></span>")

                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<div class='note'>[ It is recommended to enter story point in Fibonacci series ]</div>")
                        strHTML.Append("</div>")
                        'strHTML.Append(" <div class='col-md-6'>")

                        'strHTML.Append("</div>") 'commented by Ashwini M on 27-3-2023
                        'strHTML.Append("</div>")
                    Case "Version"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;margin-top: 11px;'>Version</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strVersion, "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strVersion, "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not

                        'If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then
                        '    strHTML.Append("<span class='input-group-addon'>")
                        '    strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' data-bs-toggle='tooltip' title='Add Version' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='dropdown-menu category' role='menu'>")
                        '    strHTML.Append("<table id='tblHeader'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Version</h4>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddVersion_OnClick()'; >ADD</button>&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<i class='fa fa-close'></i>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
                        '    strHTML.Append("&nbsp; New Version Will available for addition  &nbsp;")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("<table style='width:300px;height:66px;'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td style='text-align:right'>")
                        '    strHTML.Append("Version&nbsp;&nbsp;&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDVersion", "txtADDVersion", "form-control", 200, , , , , , , , , , True, , , , , , True))
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td style='position:relative'>")
                        '    strHTML.Append("&nbsp;<a id='aVersion' data-bs-toggle='dropdown' title='Select Version Color' style='cursor:pointer' ><i id='iVersion' style=' color:" & strVersionColor & "!important;font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu' style='left: unset!important;'>")
                        '    strHTML.Append("<table class='table table-boredered' id='tblVersionColor' style='background:#fff;left: unset!important;'>")
                        '    strHTML.Append("<tr>")
                        '    If UserStoryId <> "" Then
                        '        strHTML.Append(GetColorMaster(strVersion, "Version"))
                        '    End If
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</span>")
                        'End If
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<span id='spanVersion' style='color: #dd1037; font-size: 12px;' ></span>")
                    Case "FixedVersion"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;margin-top: 11px;'>Fixed Version</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strFixedVersion, "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strFixedVersion, "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not


                        'If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then
                        '    strHTML.Append("<span class='input-group-addon'>")
                        '    strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' data-bs-toggle='tooltip' title='Add Fixed Version' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='dropdown-menu category' role='menu'>")
                        '    strHTML.Append("<table id='tblHeader'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Fixed Version</h4>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddFixedVersion_OnClick()'; >ADD</button>&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<i class='fa fa-close'></i>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
                        '    strHTML.Append("&nbsp; New Version Will available for addition  &nbsp;")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("<table style='width:300px;height:66px;'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td style='text-align:right'>")
                        '    strHTML.Append("Version&nbsp;&nbsp;&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDFixedVersion", "txtADDFixedVersion", "form-control", 200, , , , , , , , , , True, , , , , , True))
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td style='position:relative'>")
                        '    strHTML.Append("&nbsp;<a id='aVersion' data-bs-toggle='dropdown' title='Select Version Color' style='cursor:pointer' ><i id='iFVersion' style=' color:" & strFixedVersionColor & "!important;font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu' style='left: unset!important;'>")
                        '    strHTML.Append("<table class='table table-bordered' id='tblVersionColor2' style='background:#fff;left: unset!important;'>")
                        '    strHTML.Append("<tr>")
                        '    If UserStoryId <> "" Then
                        '        strHTML.Append(GetColorMaster(strVersion, "FVersion"))
                        '    End If
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</span>")
                        'End If
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<span id='spanFixedVersion' style='color: #dd1037; font-size: 12px;' ></span>")
                    Case "AcceptanceCriteria"
                        strHTML.Append(" <div class='col-md-12'>")
                        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Acceptance Criteria</label> ")
                        strHTML.Append(" <div class='col-md-10 '>")

                        'Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAcceptanceCriteria", "txtAcceptanceCriteria", , "form-control", , , , , , , 1000, strAcceptanceCriteria, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownAC,1000)' onKeyUp='javascript:limitText(this,countdownAC, 1000)' onkeyup=ClearSpan('txtAcceptanceCriteria','spanAcceptanceCriteria')  data-autoresize", True, , , , , , , , , True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAcceptanceCriteria", "txtAcceptanceCriteria", , "form-control", , , , , , , 1000, strAcceptanceCriteria, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup='javascript:limitText(this,countdownAC,1000)' onKeyUp='javascript:limitText(this,countdownAC, 1000)' onkeyup=ClearSpan('txtAcceptanceCriteria','spanAcceptanceCriteria')  data-autoresize", True, , , , , , , , , True))
                        'End of Added by Usha Pandit on 22 Aug 2018 for checking if sprint is started or not



                        strHTML.Append("<small name='countdownAC' Id='countdownAC'>" & (1000 - strAcceptanceCriteria.Length) & "</small>")
                        strHTML.Append("<span id='spanAcceptanceCriteria' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                End Select
            Next

            strHTML.Append("</Div>")
            strHTML.Append("</Div>")


        Catch ex As Exception
            Return ex.Message
        End Try
        Return (strHTML.ToString())
    End Function
    Public Function Substories_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        Dim strSql As String = ""

        strHTML.Append("<div id='divSubstories' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion'>Sub User Stories</h2>")
        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & userStoryID & ",'UserStory'", True))
        Dim strIsSubUS As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsSubUserStory " & userStoryID, True))
        If strAddLinkAccess = "1" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','SubUS')>List</a> | <a data-bs-toggle='tooltip' title='Sprint already started/completed you can not add sub userstory' data-bs-placement='bottom' >Add</a></h2>")
        ElseIf strIsSubUS = "1" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','SubUS')>List</a> | <a data-bs-toggle='tooltip' title='Sub User story can not be added against sub user story' data-bs-placement='bottom' >Add</a></h2>")
        Else
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','SubUS')>List</a> | <a data-bs-toggle='tooltip' title='Form View' data-bs-placement='bottom' onclick=ShowData('Form','SubUS')>Add</a></h2>")
        End If

        strHTML.Append("<Div class='col-sm-12' id='divSubstoryList'>")
        strHTML.Append(PlotSubUserStoryList(userStoryID))
        strHTML.Append("</Div>")
        strHTML.Append("<Div class='col-sm-12' id='divSubstoryForm' style='display:none'>")
        strHTML.Append(" <div class='col-sm-12 '>")
        Dim objProduct As New frmProductBacklog
        objProduct.GetAccessRights()
        If m_objAccess.Add = True Or m_objAccess.Edit = True Then
            strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'SubStory') class='fa fa-save'></i>")
        End If

        'If m_objAccess.Edit = True Then
        '    strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'SubStory') class='fa fa-save'></i>")
        'End If
        strHTML.Append("</div>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>User Story <span style='color:red;'>*</span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-8 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", 140, 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Description <span style='color:red;'>*</span> </label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-8 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSubStoryDesc", "txtSubStoryDesc", , "form-control", , , , , , , , , , "", , , , , "onkeyup='javascript:limitText(this,countSubUSdown,1000)' onKeyUp='javascript:limitText(this,countSubUSdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc')  data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append(" <span class='input-group-addon'>")
        strHTML.Append("<small name='countSubUSdown' Id='countSubUSdown'>1000</small>")
        strHTML.Append("<span id='spanAcceptanceCriteria' style='color: #dd1037; font-size: 12px;' ></span>")
        strHTML.Append("</span>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Priority <span style='color:red;'>*</span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-8 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubcboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, True))
        ' strHTML.Append("<span class='input-group-addon' style='color: red;'>*</span>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Complexity <span style='color:red;'></span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-8 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubcboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , "", "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf((strState <> "InActive" And strIterationName = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
        ' strHTML.Append("<span class='input-group-addon' style='color: red;'>*</span>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Category <span style='color:red;'></span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-8 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubcboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & "", , "", "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('cboCategory','spanCategory') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And userStoryID = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
        ' strHTML.Append("<span class='input-group-addon' style='color: red;'>*</span>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

        strHTML.Append("</Div>")
        strHTML.Append("</div>")

        Return strHTML.ToString

    End Function

    Function PlotSubUserStoryList(ByVal userStoryID As String)


        Dim strHTML As New StringBuilder()
        Dim drSubstory As IDataReader
        Dim objProduct As New frmProductBacklog
        objProduct.GetAccessRights()
        Dim strSql As String = "usp_NG2_sel_tbl_PM_SubUserStory " & userStoryID
        drSubstory = CommonFunction.Data.GetDataReader(strSql, True)
        strHTML.Append("<ul class='col-sm-12 chat'>")
        While drSubstory.Read
            strHTML.Append("<li class='col-sm-12'>")
            strHTML.Append("<span class='chat-img float-start'>")
            'strHTML.Append("<div alt='User Avatar' class='img-circle' style='height:50px;width:50px;background-color:" & CommonFunctions.Data.CheckIsDBNull(drSubstory("Color"), "") & "'></div>")
            strHTML.Append("<label class='primary-font' data-bs-toggle='tooltip' data-bs-placement='bottom' title='User StoryID' data-container='body'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & "</label>")
            strHTML.Append("<label class='primary-font' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Initial Rank' data-container='body'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("InitialRank"), "") & "</label>")
            strHTML.Append("</span>")
            strHTML.Append("<div class='chat-body clearfix'>")
            strHTML.Append("<div class='header'>")
            'strHTML.Append("<strong class='primary-font'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & "</strong>")
            strHTML.Append("</div>")
            strHTML.Append("<p  style='padding-left:22%'><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all;' data-container='body'>")
            strHTML.Append("" & CommonFunctions.Data.CheckIsDBNull(drSubstory("Description"), "") & "")
            strHTML.Append("</p>")
            strHTML.Append("<small class='float-end text-muted' style='margin-top:-2%;color:red'>")
            GetAccessRights()
            If m_objAccess.Delete = True Then
                Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_checkUShasSprintnot " & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), 0) & ",'UserStory'", True))
                If strAddLinkAccess = "0" Then
                    If strIsPrductOwner = "1" Then
                        strHTML.Append("<i title='Delete User Story' data-bs-toggle='tooltip' data-bs-placement='bottom' class='fa fa-trash' style='margin-right:13px!important' onclick=""Delete_UserStory(" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & " ,'SubUS')""></i>")
                    Else
                        strHTML.Append("<i title='You do not have access' data-bs-toggle='tooltip' data-bs-placement='bottom' class='fa fa-trash' style='margin-right:13px!important' ></i>")
                    End If

                Else
                    strHTML.Append("<i title='User Story already Mapped to sprint,you do not have acess to delete' data-bs-toggle='tooltip' data-bs-placement='bottom' class='fa fa-trash' style='margin-right:13px!important'></i>")
                End If

            End If
            strHTML.Append("</small>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")
        End While
        strHTML.Append("</ul>")
        Return strHTML.ToString()

    End Function

    Public Function Attachment_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divAttachments' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion' style=''>Attachments</h2>")
        strHTML.Append("<div id='divAttachmentList' class='col-sm-12'>")
        strHTML.Append(GetAttachmentList1(userStoryID))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function GetAttachmentList1(userStoryID As String, Optional ByVal flag As String = "")


        Dim strHTML As New StringBuilder()
        If flag <> "AfterDelete" Then
            strHTML.Append(" <div id='Attachmentus'>")
        End If

        Dim strAttachmentSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & userStoryID & ",'UserStory'"
        Dim dtAttachment As New DataTable
        dtAttachment = CommonFunctions.Data.GetDataTable(strAttachmentSql, True)
        strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><div class='demo-droppable'><p>Drag files here or click to upload</p></div><a class='btn btn-info'  data-bs-toggle='tooltip' title='Upload File' data-bs-placement='bottom' onclick=UploadData(" & userStoryID & ")><i class='fa fa-upload'></i>Upload</a></h2>")
        strHTML.Append(" <div id='listattachment'>")
        For i As Integer = 0 To dtAttachment.Rows.Count - 1
            strHTML.Append(" <div class='row attachRow'>")
            strHTML.Append(" <div class='form-group row'>")
            strHTML.Append(" <div class='col-sm-4 '>")
            strHTML.Append("<span  data-bs-toggle='tooltip' title='File Name' data-bs-placement='bottom' style='word-break:break-all'>" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "</span>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-3 '>")
            strHTML.Append("<span  data-bs-toggle='tooltip' title='Attached By' data-bs-placement='bottom'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy"), "") & " [" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Duration"), "") & "]" & "</span>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-2 ' >")

            'Commented and Added by Usha Pandit On 17 July 2018 for download attachment issue
            'strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='download Attachment' class='fa fa-download'  onclick=""Document_OnClick('" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("FilePath"), "") & "','" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "')""></i>")
            Dim strOriginalFileExtension As String = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "")
            strOriginalFileExtension = strOriginalFileExtension.Substring(strOriginalFileExtension.LastIndexOf("."))

            'Commented and Added by Usha Pandit On 26 March 2019 for attachment tab javascript error
            'strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Download Attachment' class='fa fa-download'  onclick=""Document_OnClick('" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("FilePath"), "") & strOriginalFileExtension & "','" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "')""></i>")
            strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Download Attachment' class='fa fa-download'  onclick=""Document_OnClick('" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("FilePath"), "") & strOriginalFileExtension & "','" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "").ToString().Replace("\", "\\") & "')""></i>")
            'End of Added by Usha Pandit On 26 March 2019 for attachment tab javascript error

            'End of Added by Usha Pandit On 17 July 2018 for download attachment issue


            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-3 ' style='float:right;'>")
            strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Delete Attachment' class='fa fa-trash' style='color:red;' onclick=""Delete_Attachment(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & userStoryID & ",'Userstory')""></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        Next
        strHTML.Append("</div>")
        If flag <> "AfterDelete" Then
            strHTML.Append(" </div>")
        End If

        Return strHTML.ToString()

    End Function

    Public Function Discussion_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divDiscussions' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion'>Discussions</h2>")
        'strHTML.Append("<div class='col-sm-10'>")
        'strHTML.Append("<textarea id='txtDiscussion' name='txtDiscussion' class='form-control'></textarea>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & userStoryID & "','UserStory',this) class='btn btn-default btn-flat'>Post</button>")
        'strHTML.Append("</div>")
        strHTML.Append("<div id='divDiscussionList' class='row'>")
        strHTML.Append(PlotDiscussionThreadBody(userStoryID, strUserDesc, "UserStory"))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function


    'Friend Function PlotDiscussionThreadBody(ByVal strIterationID As String, ByVal strIterationName As String, ByVal strFlag As String)
    '    Dim drGetUserStoryDicussion As IDataReader
    '    Dim drGetUserStoryDicussionCount As IDataReader
    '    Dim drContactList As IDataReader
    '    Dim strHTMLDiscussion As New StringBuilder
    '    Dim StrQuery As String = ""
    '    Dim StrUserStoryCountQuery As String = ""
    '    Dim intDiscussionCount As Integer = 0
    '    Dim strPhotoFileName As String = ""
    '    Dim strDiscussionDate As String = ""
    '    Dim strComment As String = ""
    '    Dim strEmployeeName As String = ""
    '    Dim flag As String = ""
    '    Dim strUserName As String = ""
    '    Dim strDiscussionID As String = ""
    '    Dim strDiscussionID1 As String = ""
    '    Dim dtTable As New DataTable()
    '    StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
    '    drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
    '    Dim intCounter As Integer = 0


    '    strHTMLDiscussion.Append("<ul class='col-sm-6 chat'>")


    '    While drGetUserStoryDicussion.Read
    '        intCounter += 1
    '        strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
    '        strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
    '        strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
    '        strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
    '        strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")
    '        strDiscussionID = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionID").ToString, "")
    '        Dim strSubmittedTime As String = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")
    '        strHTMLDiscussion.Append("<li class='col-sm-12'>")
    '        strHTMLDiscussion.Append("<span class='chat-img float-start'>")
    '        strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '        strHTMLDiscussion.Append("</span>")
    '        strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd'>")
    '        strHTMLDiscussion.Append("<div class='header'>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<div class='row'>")
    '        strHTMLDiscussion.Append("<div class='col-sm-8'>")
    '        strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
    '        strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-bs-toggle='tooltip' data-bs-placement='bottom' style='white-space:pre!important;font-size: 10px;margin-left: 232px;margin-top:-3%'> " & strSubmittedTime & "</P>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description'>")
    '        Dim strLessComment As String = ""
    '        Dim strRemaining As String = ""
    '        If strComment.Length > 200 Then
    '            strLessComment = strComment.Substring(0, 200)
    '            strRemaining = strComment.Substring(201, strComment.Length - 201)
    '        End If
    '        If strLessComment = "" Then
    '            strHTMLDiscussion.Append("" & strComment & "")
    '        Else
    '            strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important'>" & strRemaining & "</p>")
    '        End If
    '        If strComment.Length > 200 Then
    '            strHTMLDiscussion.Append("<a onclick='ShowMoreLess(" & strDiscussionID & ",this)' title='More' data-bs-toggle='tooltip' data-bs-placement='bottom'>More</a></p>")
    '        End If
    '        Dim ReplyFlag As String = ""
    '        strHTMLDiscussion.Append("</span></p>")
    '        If strFlag = "UserStory" Then
    '            ReplyFlag = "UserStoryReply"
    '        ElseIf strFlag = "Iteration" Then
    '            ReplyFlag = "IterationReply"
    '        Else
    '            ReplyFlag = "ReleaseReply"
    '        End If
    '        strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
    '        StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & ReplyFlag & "',1," & Session("intUserID") & "," & strDiscussionID
    '        dtTable = CommonFunctions.Data.GetDataTable(StrQuery, True)
    '        strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'>View all reply<span></label> <a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'>Reply</a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Discussion count' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & dtTable.Rows.Count & "</label>")
    '        strHTMLDiscussion.Append("</small>")
    '        strHTMLDiscussion.Append("</div>")


    '        If dtTable.Rows.Count > 0 Then
    '            strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse' style='float:right;margin-right:-36%'>")
    '            For i As Integer = 0 To dtTable.Rows.Count - 1
    '                strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
    '                strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
    '                strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
    '                strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
    '                strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
    '                strDiscussionID1 = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
    '                strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

    '                strHTMLDiscussion.Append("<input type='hidden' id='hdnstrDiscussionID' value=" & strDiscussionID & ">")
    '                strHTMLDiscussion.Append("<li class='col-sm-12' >") 'style='border-bottom:1px solid white!important'
    '                strHTMLDiscussion.Append("<div class='chat-body clearfix'>")
    '                strHTMLDiscussion.Append("<div class='header'>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("<div class='row'>")
    '                strHTMLDiscussion.Append("<div class='col-sm-9' style='white-space:pre!important'>")
    '                strHTMLDiscussion.Append("<p class='Postedtime'><span style='margin-left:-69%;white-space:pre!important;font-size: 10px;'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("<div class='col-sm-3' style='white-space:nowrap;margin-left:-50%'>")
    '                strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("<p style='Margin-left:7%;Margin-top:-4%;color:#777!important' ><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom' style='margin-left:-92%;'>")
    '                Dim strLessCommentInside As String = ""
    '                Dim strRemainingInside As String = ""
    '                If strComment.Length > 200 Then
    '                    strLessCommentInside = strComment.Substring(0, 200)
    '                    strRemainingInside = strComment.Substring(201, strComment.Length - 201)
    '                End If
    '                If strLessCommentInside = "" Then
    '                    strHTMLDiscussion.Append("" & strComment & "")
    '                Else
    '                    strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important'>" & strRemainingInside & "</label>")
    '                End If
    '                If strComment.Length > 200 Then
    '                    strHTMLDiscussion.Append(" <a onclick='ShowMoreLess(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p>")
    '                End If
    '                strHTMLDiscussion.Append("<br><small class='float-end text-muted' style='margin-right:44%!important;float:right!important;'>")
    '                strHTMLDiscussion.Append("<span title='Discussion Date' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-bs-toggle='tooltip' data-bs-placement='bottom'>Reply</a>")
    '                strHTMLDiscussion.Append("</small>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("<span class='chat-img float-start' style='float:right!important;margin-top:-17%;margin-right:36%'>")
    '                strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '                strHTMLDiscussion.Append("</span>")
    '                strHTMLDiscussion.Append("</li>")
    '            Next
    '            strHTMLDiscussion.Append("</ul>")
    '        End If
    '        strHTMLDiscussion.Append("</li>")
    '        If intCounter = 1 Then
    '            flag = "PlotTextArea"
    '        End If
    '    End While
    '    If intCounter = 0 Then
    '        flag = "PlotTextArea"
    '        strHTMLDiscussion.Append("<li class='col-sm-12'>")
    '        strHTMLDiscussion.Append("<span class='chat-img float-start'>")
    '        'strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '        strHTMLDiscussion.Append("</span>")
    '        strHTMLDiscussion.Append("<div class='chat-body clearfix'>")
    '        strHTMLDiscussion.Append("<div class='header'>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<p title='Description' style='text-align:center'>")
    '        strHTMLDiscussion.Append("No records to view.")
    '        strHTMLDiscussion.Append("</p>")
    '        strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
    '        'strHTMLDiscussion.Append(strDiscussionDate & "<label onclick='reply_onclick(" & strIterationID & ")'></i>")
    '        strHTMLDiscussion.Append("</small>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</li>")
    '    End If

    '    strHTMLDiscussion.Append("</ul>")
    '    'End If

    '    If flag = "PlotTextArea" Then
    '        strHTMLDiscussion.Append("<ul class='col-sm-6' style='margin-top:8%'>")
    '        ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
    '        strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("DiscussionTextArea", "DiscussionTextArea", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
    '        strHTMLDiscussion.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintReleaseAddDiscussion'  style='' onclick=AddNewDiscussion(" & strIterationID & ",'" & strFlag & "',this,'DiscussionTextArea') disabled><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
    '        strHTMLDiscussion.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintRelease'  style=''   onclick=insertuserStoryDiscussion(" & strIterationID & ",'" & strFlag & "',this,'DiscussionTextArea')><sup><i class='fa  fa-comment-o' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpost' title='Post' data-bs-toggle='tooltip' data-bs-placement='top' > Post<span></button>")

    '        'strHTMLDiscussion.Append("</li>")
    '        strHTMLDiscussion.Append("</ul>")
    '    End If





    '    'strHTMLDiscussion.Append("  <div id='footerBoxFooter' class='box-footer'>")
    '    'strHTMLDiscussion.Append("    <div id='footerInputGroup' class='input-group'>")
    '    'If strFlag = "UserStory" Then

    '    '    strHTMLDiscussion.Append("     <input placeholder='Type message...'  onkeyup=sendKey(event,'" & strIterationID & "','" & strFlag & "',1) id='footerInputGroupText_" & strIterationID & "' type='text' name='message'  class='InputGroupText form-control'>")
    '    '    strHTMLDiscussion.Append("        <span class='input-group-btn'>")
    '    '    strHTMLDiscussion.Append("         <button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & strIterationID & "','" & strFlag & "','asd',1) class='btn btn-warning btn-flat'>Post</button>")
    '    '    strHTMLDiscussion.Append("       </span>")
    '    'Else
    '    '    strHTMLDiscussion.Append("     <input placeholder='Type message...'  onkeyup=sendKey(event,'" & strIterationID & "','" & strFlag & "',1) id='footerInputGroupText_" & strIterationID & "' type='text' name='message'  class='InputGroupText form-control'>")
    '    '    strHTMLDiscussion.Append("        <span class='input-group-btn'>")
    '    '    strHTMLDiscussion.Append("         <button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & strIterationID & "','" & strFlag & "','sad',1) class='btn btn-warning btn-flat'>Post</button>")
    '    '    strHTMLDiscussion.Append("       </span>")
    '    'End If
    '    'strHTMLDiscussion.Append(" </div>")
    '    'strHTMLDiscussion.Append(" </div>")


    '    'strHTMLDiscussion.Append(" <div  id='chatMessage_" & strIterationID & "' class='direct-chat-messages' style='border: 1px solid #ddd;'>")



    '    'Dim strHTML As New StringBuilder
    '    'While drGetUserStoryDicussion.Read
    '    '    flag = 1
    '    '    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
    '    '    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
    '    '    strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
    '    '    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
    '    '    strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")


    '    '    If strPhotoFileName = "" Then
    '    '        strPhotoFileName = "no-photo.png"
    '    '    End If
    '    '    If strUserName = "" & HttpContext.Current.Session("strUserName") & "" Then
    '    '        strHTML.Append("    <div class='direct-chat-msg right'>")
    '    '        strHTML.Append("<div class='direct-chat-info clearfix'>")
    '    '        strHTML.Append("<span class='direct-chat-name float-end' style=' float:right!important;'>" & strEmployeeName & "</span>")
    '    '        strHTML.Append("<span class='direct-chat-timestamp float-start'>" & strDiscussionDate & "</span>")
    '    '        strHTML.Append("   </div>")

    '    '        strHTML.Append("   <img class='direct-chat-img' src='../../Images/Photo/" & strPhotoFileName & "' alt = 'Message User Image'>")
    '    '        strHTML.Append(" <div class='direct-chat-text'> " & strComment & "")

    '    '        strHTML.Append("   </div>")

    '    '        strHTML.Append("    </div>")
    '    '    Else
    '    '        strHTML.Append("   <div class='direct-chat-msg'>")
    '    '        strHTML.Append("    <div class='direct-chat-info clearfix'>")
    '    '        strHTML.Append("      <span class='direct-chat-name float-start'>" & strEmployeeName & "</span>")
    '    '        strHTML.Append("     <span class='direct-chat-timestamp float-end' style=' float:right!important;'>" & strDiscussionDate & "</span>")
    '    '        strHTML.Append("   </div>")

    '    '        strHTML.Append("  <img class='direct-chat-img' src='../../Images/Photo/" & strPhotoFileName & "' alt = 'Message User Image'>")
    '    '        strHTML.Append(" <div class='direct-chat-text'> " & strComment & "")
    '    '        strHTML.Append(" </div>")

    '    '        strHTML.Append("    </div>")

    '    '    End If
    '    'End While

    '    'If flag = 0 Then
    '    '    strHTMLDiscussion.Append("<label style='font-size:14px;text-align:center'>No Discussion Available</label>")
    '    '    strHTMLDiscussion.Append("   </div>")
    '    'Else
    '    '    strHTMLDiscussion.Append(strHTML.ToString)
    '    '    strHTMLDiscussion.Append("   </div>")

    '    'End If

    '    Return strHTMLDiscussion.ToString()
    'End Function
    Friend Function PlotDiscussionThreadBody(ByVal strIterationID As String, ByVal strIterationName As String, ByVal strFlag As String)


        Dim drGetUserStoryDicussion As IDataReader
        Dim drGetUserStoryDicussionCount As IDataReader
        Dim drContactList As IDataReader
        Dim strHTMLDiscussion As New StringBuilder
        Dim StrQuery As String = ""
        Dim StrUserStoryCountQuery As String = ""
        Dim intDiscussionCount As Integer = 0
        Dim strPhotoFileName As String = ""
        Dim strDiscussionDate As String = ""
        Dim strComment As String = ""
        Dim strEmployeeName As String = ""
        Dim flag As String = ""
        Dim strUserName As String = ""
        Dim strDiscussionID As String = ""
        Dim strDiscussionID1 As String = ""
        Dim dtTable As New DataTable()
        StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
        drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intCounter As Integer = 0


        strHTMLDiscussion.Append("<ul class='col-sm-6 col-xs-12'>")


        While drGetUserStoryDicussion.Read
            intCounter += 1
            strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
            strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
            strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
            strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
            strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")
            strDiscussionID = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionID").ToString, "")
            Dim strSubmittedTime As String = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")
            strHTMLDiscussion.Append("<li class=''>")
            strHTMLDiscussion.Append("<div class=''>")
            strHTMLDiscussion.Append("<span class='col-md-2 col-sm-2 col-sm-4 float-start'>")
            strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle empimg' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
            strHTMLDiscussion.Append("</span>")
            strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8 col-sm-8'>")
            strHTMLDiscussion.Append("<p class='empname'><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd;background: #b2d5f5;padding: 10px;margin-bottom:10px;border-radius:5px;'>")
            strHTMLDiscussion.Append("<div class='header'>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='row'>")

            strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
            strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-bs-toggle='tooltip' data-bs-placement='bottom' style='white-space:pre!important;font-size: 10px;'> " & strSubmittedTime & "</P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%;word-break:break-all;' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description' style='word-break: break-all;'>")
            Dim strLessComment As String = ""
            Dim strRemaining As String = ""
            If strComment.Length > 200 Then
                strLessComment = strComment.Substring(0, 200)
                strRemaining = strComment.Substring(201, strComment.Length - 201)
            End If
            If strLessComment = "" Then
                strHTMLDiscussion.Append("" & strComment & "")
            Else
                strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important;word-break:break-all;'>" & strRemaining & "</p>")
            End If
            If strComment.Length > 200 Then
                strHTMLDiscussion.Append("<a onclick='ShowMoreLess(" & strDiscussionID & ",this)' title='More' data-bs-toggle='tooltip' data-bs-placement='bottom'>More</a></p>")
            End If
            Dim ReplyFlag As String = ""
            strHTMLDiscussion.Append("</span></p>")
            If strFlag = "UserStory" Then
                ReplyFlag = "UserStoryReply"
            ElseIf strFlag = "Iteration" Then
                ReplyFlag = "IterationReply"
            Else
                ReplyFlag = "ReleaseReply"
            End If
            strHTMLDiscussion.Append("<small class='float-end text-muted' data-bs-toggle='tooltip' title='' data-bs-placement='left' style='margin-right:10px!important'>")
            StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & ReplyFlag & "',1," & Session("intUserID") & "," & strDiscussionID
            dtTable = CommonFunctions.Data.GetDataTable(StrQuery, True)
            'Added By Dipali V On 14th April 2023 For View Reply Issue
            '//strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label> <a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'><i class='fa fa-reply' aria-hidden='true' style=''></i></a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Reply count' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & dtTable.Rows.Count & "</label>")
            strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label> <a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'><i class='fa fa-reply' aria-hidden='true' style=''></i></a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Reply count' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & dtTable.Rows.Count & "</label>")
            'End of Added By Dipali V On 14th April 2023 For View Reply Issue
            strHTMLDiscussion.Append("</small>")



            If dtTable.Rows.Count > 0 Then
                strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse' >")
                For i As Integer = 0 To dtTable.Rows.Count - 1
                    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
                    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
                    strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
                    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
                    strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
                    strDiscussionID1 = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
                    strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

                    strHTMLDiscussion.Append("<input type='hidden' id='hdnstrDiscussionID' value=" & strDiscussionID & ">")
                    strHTMLDiscussion.Append("<li class='' >") 'style='border-bottom:1px solid white!important'
                    strHTMLDiscussion.Append("<div class='chat-body clearfix' style='padding:10px;margin-bottom:10px;background:#c6eab7;border-radius:5px;'>")
                    strHTMLDiscussion.Append("<div class='header'>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class=''>")
                    strHTMLDiscussion.Append("<span class='col-md-3 col-sm-3 col-sm-4 float-end' style='float:right!important;'>")
                    strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
                    strHTMLDiscussion.Append("<p class='Postedtime'><span style='white-space:pre!important;font-size: 10px;'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
                    strHTMLDiscussion.Append("</span>")

                    strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8 col-sm-7' style='white-space:pre!important;float: right;'>")
                    strHTMLDiscussion.Append("<p style='float: right;'><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class='' style='clear:both;'>")
                    strHTMLDiscussion.Append("<p style='color:#777!important;word-break:break-all;' ><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all;'>")
                    Dim strLessCommentInside As String = ""
                    Dim strRemainingInside As String = ""
                    If strComment.Length > 200 Then
                        strLessCommentInside = strComment.Substring(0, 200)
                        strRemainingInside = strComment.Substring(201, strComment.Length - 201)
                    End If
                    If strLessCommentInside = "" Then
                        strHTMLDiscussion.Append("" & strComment & "")
                    Else
                        strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important'>" & strRemainingInside & "</label>")
                    End If
                    If strComment.Length > 200 Then
                        strHTMLDiscussion.Append(" <a onclick='ShowMoreLess(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p></div>")
                    End If
                    strHTMLDiscussion.Append("<div class='text-end'>")
                    strHTMLDiscussion.Append("<small class='float-end text-muted'>")
                    strHTMLDiscussion.Append("<span style='    font-size: 12px!important;' title='Discussion Date' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-reply' aria-hidden='true' style=''></i></a>")
                    strHTMLDiscussion.Append("</small>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("</div>")

                    strHTMLDiscussion.Append("</li>")
                Next
                strHTMLDiscussion.Append("</ul>")
            End If
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</li>")
            If intCounter = 1 Then
                flag = "PlotTextArea"
            End If
        End While
        If intCounter = 0 Then
            flag = "PlotTextArea"
            strHTMLDiscussion.Append("<li class='col-sm-12'>")
            strHTMLDiscussion.Append("<span class='chat-img float-start'>")
            'strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & strPhotoFileName & "' />")
            strHTMLDiscussion.Append("</span>")
            strHTMLDiscussion.Append("<div class='chat-body clearfix'>")
            strHTMLDiscussion.Append("<div class='header'>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<p title='Description' style='text-align:center'>")
            strHTMLDiscussion.Append("No records to view.")
            strHTMLDiscussion.Append("</p>")
            strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
            'strHTMLDiscussion.Append(strDiscussionDate & "<label onclick='reply_onclick(" & strIterationID & ")'></i>")
            strHTMLDiscussion.Append("</small>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</li>")
        End If

        strHTMLDiscussion.Append("</ul>")
        'End If

        If flag = "PlotTextArea" Then
            strHTMLDiscussion.Append("<ul class='col-sm-6 col-xs-12' style='margin-top:8%;text-align:center;'>")
            ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
            'Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("DiscussionTextArea", "DiscussionTextArea", , "form-control", , , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion'", True, EnableHTMLEncode:=True))
            strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("DiscussionTextArea", "DiscussionTextArea", , "form-control", , , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion' maxlength ='2000'", True, EnableHTMLEncode:=True))
            'End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("DiscussionTextArea", "DiscussionTextArea", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
            'strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussion'  style='margin-right:10px;' onclick=AddNewDiscussion(this,'txtDiscussions')><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
            strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussion'  style='' onclick=AddNewDiscussion(" & strIterationID & ",'" & strFlag & "',this,'DiscussionTextArea') disabled><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
            strHTMLDiscussion.Append("      <button type='button' class='btn btn-info' id='SprintRelease'  style=''   onclick=insertuserStoryDiscussion(" & strIterationID & ",'" & strFlag & "',this,'DiscussionTextArea')><sup><i class='far fa-comment' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpost' title='Post' data-bs-toggle='tooltip' data-bs-placement='top' > Post<span></button>")

            'strHTMLDiscussion.Append("</li>")
            strHTMLDiscussion.Append("</ul>")
        End If





        'strHTMLDiscussion.Append("  <div id='footerBoxFooter' class='box-footer'>")
        'strHTMLDiscussion.Append("    <div id='footerInputGroup' class='input-group'>")
        'If strFlag = "UserStory" Then

        '    strHTMLDiscussion.Append("     <input placeholder='Type message...'  onkeyup=sendKey(event,'" & strIterationID & "','" & strFlag & "',1) id='footerInputGroupText_" & strIterationID & "' type='text' name='message'  class='InputGroupText form-control'>")
        '    strHTMLDiscussion.Append("        <span class='input-group-btn'>")
        '    strHTMLDiscussion.Append("         <button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & strIterationID & "','" & strFlag & "','asd',1) class='btn btn-warning btn-flat'>Post</button>")
        '    strHTMLDiscussion.Append("       </span>")
        'Else
        '    strHTMLDiscussion.Append("     <input placeholder='Type message...'  onkeyup=sendKey(event,'" & strIterationID & "','" & strFlag & "',1) id='footerInputGroupText_" & strIterationID & "' type='text' name='message'  class='InputGroupText form-control'>")
        '    strHTMLDiscussion.Append("        <span class='input-group-btn'>")
        '    strHTMLDiscussion.Append("         <button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & strIterationID & "','" & strFlag & "','sad',1) class='btn btn-warning btn-flat'>Post</button>")
        '    strHTMLDiscussion.Append("       </span>")
        'End If
        'strHTMLDiscussion.Append(" </div>")
        'strHTMLDiscussion.Append(" </div>")


        'strHTMLDiscussion.Append(" <div  id='chatMessage_" & strIterationID & "' class='direct-chat-messages' style='border: 1px solid #ddd;'>")



        'Dim strHTML As New StringBuilder
        'While drGetUserStoryDicussion.Read
        '    flag = 1
        '    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
        '    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
        '    strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
        '    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
        '    strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")


        '    If strPhotoFileName = "" Then
        '        strPhotoFileName = "no-photo.png"
        '    End If
        '    If strUserName = "" & HttpContext.Current.Session("strUserName") & "" Then
        '        strHTML.Append("    <div class='direct-chat-msg right'>")
        '        strHTML.Append("<div class='direct-chat-info clearfix'>")
        '        strHTML.Append("<span class='direct-chat-name float-end' style=' float:right!important;'>" & strEmployeeName & "</span>")
        '        strHTML.Append("<span class='direct-chat-timestamp float-start'>" & strDiscussionDate & "</span>")
        '        strHTML.Append("   </div>")

        '        strHTML.Append("   <img class='direct-chat-img' src='../../Images/Photo/" & strPhotoFileName & "' alt = 'Message User Image'>")
        '        strHTML.Append(" <div class='direct-chat-text'> " & strComment & "")

        '        strHTML.Append("   </div>")

        '        strHTML.Append("    </div>")
        '    Else
        '        strHTML.Append("   <div class='direct-chat-msg'>")
        '        strHTML.Append("    <div class='direct-chat-info clearfix'>")
        '        strHTML.Append("      <span class='direct-chat-name float-start'>" & strEmployeeName & "</span>")
        '        strHTML.Append("     <span class='direct-chat-timestamp float-end' style=' float:right!important;'>" & strDiscussionDate & "</span>")
        '        strHTML.Append("   </div>")

        '        strHTML.Append("  <img class='direct-chat-img' src='../../Images/Photo/" & strPhotoFileName & "' alt = 'Message User Image'>")
        '        strHTML.Append(" <div class='direct-chat-text'> " & strComment & "")
        '        strHTML.Append(" </div>")

        '        strHTML.Append("    </div>")

        '    End If
        'End While

        'If flag = 0 Then
        '    strHTMLDiscussion.Append("<label style='font-size:14px;text-align:center'>No Discussion Available</label>")
        '    strHTMLDiscussion.Append("   </div>")
        'Else
        '    strHTMLDiscussion.Append(strHTML.ToString)
        '    strHTMLDiscussion.Append("   </div>")

        'End If

        Return strHTMLDiscussion.ToString()

    End Function

    'Friend Function PlotDiscussionThreadBody(ByVal strIterationID As String, ByVal strIterationName As String, ByVal strFlag As String)
    '    Dim drGetUserStoryDicussion As IDataReader
    '    Dim drGetUserStoryDicussionCount As IDataReader
    '    Dim drContactList As IDataReader
    '    Dim strHTMLDiscussion As New StringBuilder
    '    Dim StrQuery As String = ""
    '    Dim StrUserStoryCountQuery As String = ""
    '    Dim intDiscussionCount As Integer = 0
    '    Dim strPhotoFileName As String = ""
    '    Dim strDiscussionDate As String = ""
    '    Dim strComment As String = ""
    '    Dim strEmployeeName As String = ""
    '    Dim flag As String = ""
    '    Dim strUserName As String = ""
    '    Dim strDiscussionID As String = ""
    '    Dim strDiscussionID1 As String = ""
    '    Dim dtTable As New DataTable()
    '    StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
    '    drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
    '    Dim intCounter As Integer = 0


    '    strHTMLDiscussion.Append("<ul class='col-sm-6 col-sm-12 sprint_card'>")


    '    While drGetUserStoryDicussion.Read
    '        intCounter += 1
    '        strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
    '        strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
    '        strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
    '        strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
    '        strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")
    '        strDiscussionID = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionID").ToString, "")
    '        Dim strSubmittedTime As String = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")
    '        strHTMLDiscussion.Append("<li class=''>")
    '        strHTMLDiscussion.Append("<div class=''>")
    '        strHTMLDiscussion.Append("<span class='col-md-2 col-sm-2 col-sm-4 float-start'>")
    '        strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '        strHTMLDiscussion.Append("</span>")
    '        strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8 col-sm-8'>")
    '        strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd;background: #b2d5f5;padding: 10px;margin-bottom:10px;border-radius:5px;'>")
    '        strHTMLDiscussion.Append("<div class='header'>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<div class='row'>")

    '        strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
    '        strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-bs-toggle='tooltip' data-bs-placement='bottom' style='white-space:pre!important;font-size: 10px;'> " & strSubmittedTime & "</P>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description' style='word-break: break-all;'>")
    '        Dim strLessComment As String = ""
    '        Dim strRemaining As String = ""
    '        If strComment.Length > 200 Then
    '            strLessComment = strComment.Substring(0, 200)
    '            strRemaining = strComment.Substring(201, strComment.Length - 201)
    '        End If
    '        If strLessComment = "" Then
    '            strHTMLDiscussion.Append("" & strComment & "")
    '        Else
    '            strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important'>" & strRemaining & "</p>")
    '        End If
    '        If strComment.Length > 200 Then
    '            strHTMLDiscussion.Append("<a onclick='ShowMoreLess(" & strDiscussionID & ",this)' title='More' data-bs-toggle='tooltip' data-bs-placement='bottom'>More</a></p>")
    '        End If
    '        Dim ReplyFlag As String = ""
    '        strHTMLDiscussion.Append("</span></p>")
    '        If strFlag = "UserStory" Then
    '            ReplyFlag = "UserStoryReply"
    '        ElseIf strFlag = "Iteration" Then
    '            ReplyFlag = "IterationReply"
    '        Else
    '            ReplyFlag = "ReleaseReply"
    '        End If
    '        strHTMLDiscussion.Append("<small class='float-end text-muted' data-bs-toggle='tooltip' title='' data-bs-placement='left' style='margin-right:10px!important'>")
    '        StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & ReplyFlag & "',1," & Session("intUserID") & "," & strDiscussionID
    '        dtTable = CommonFunctions.Data.GetDataTable(StrQuery, True)
    '        strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label> <a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'><i class='fa fa-reply' aria-hidden='true' style='font-size:17px!important;'></i></a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Discussion count' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & dtTable.Rows.Count & "</label>")
    '        strHTMLDiscussion.Append("</small>")



    '        If dtTable.Rows.Count > 0 Then
    '            strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse' >")
    '            For i As Integer = 0 To dtTable.Rows.Count - 1
    '                strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
    '                strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
    '                strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
    '                strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
    '                strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
    '                strDiscussionID1 = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
    '                strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

    '                strHTMLDiscussion.Append("<input type='hidden' id='hdnstrDiscussionID' value=" & strDiscussionID & ">")
    '                strHTMLDiscussion.Append("<li class='' >") 'style='border-bottom:1px solid white!important'
    '                strHTMLDiscussion.Append("<div class='chat-body clearfix' style='padding:10px;margin-bottom:10px;background:#c6eab7;border-radius:5px;'>")
    '                strHTMLDiscussion.Append("<div class='header'>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("<div class=''>")
    '                strHTMLDiscussion.Append("<span class='col-md-3 col-sm-3 col-sm-4 float-end' style='float:right!important;'>")
    '                strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '                strHTMLDiscussion.Append("<p class='Postedtime'><span style='white-space:pre!important;font-size: 10px;'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
    '                strHTMLDiscussion.Append("</span>")

    '                strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8 col-sm-7' style='white-space:pre!important'>")
    '                strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12 col-sm-12'>")
    '                strHTMLDiscussion.Append("<p style='color:#777!important' ><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all;'>")
    '                Dim strLessCommentInside As String = ""
    '                Dim strRemainingInside As String = ""
    '                If strComment.Length > 200 Then
    '                    strLessCommentInside = strComment.Substring(0, 200)
    '                    strRemainingInside = strComment.Substring(201, strComment.Length - 201)
    '                End If
    '                If strLessCommentInside = "" Then
    '                    strHTMLDiscussion.Append("" & strComment & "")
    '                Else
    '                    strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important'>" & strRemainingInside & "</label>")
    '                End If
    '                If strComment.Length > 200 Then
    '                    strHTMLDiscussion.Append(" <a onclick='ShowMoreLess(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p></div>")
    '                End If
    '                strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12 col-sm-12'>")
    '                strHTMLDiscussion.Append("<small class='float-end text-muted'>")
    '                strHTMLDiscussion.Append("<span style='    font-size: 12px!important;' title='Discussion Date' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-reply' aria-hidden='true' style='font-size:17px!important;'></i></a>")
    '                strHTMLDiscussion.Append("</small>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("</div>")

    '                strHTMLDiscussion.Append("</li>")
    '            Next
    '            strHTMLDiscussion.Append("</ul>")
    '        End If
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</li>")
    '        If intCounter = 1 Then
    '            flag = "PlotTextArea"
    '        End If
    '    End While
    '    If intCounter = 0 Then
    '        flag = "PlotTextArea"
    '        strHTMLDiscussion.Append("<li class='col-sm-12'>")
    '        strHTMLDiscussion.Append("<span class='chat-img float-start'>")
    '        'strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '        strHTMLDiscussion.Append("</span>")
    '        strHTMLDiscussion.Append("<div class='chat-body clearfix'>")
    '        strHTMLDiscussion.Append("<div class='header'>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<p title='Description' style='text-align:center'>")
    '        strHTMLDiscussion.Append("No records to view.")
    '        strHTMLDiscussion.Append("</p>")
    '        strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
    '        'strHTMLDiscussion.Append(strDiscussionDate & "<label onclick='reply_onclick(" & strIterationID & ")'></i>")
    '        strHTMLDiscussion.Append("</small>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</li>")
    '    End If

    '    strHTMLDiscussion.Append("</ul>")
    '    'End If

    '    If flag = "PlotTextArea" Then
    '        strHTMLDiscussion.Append("<ul class='col-sm-5 col-sm-12' style='margin-top:8%;text-align:center;'>")
    '        ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
    '        strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("DiscussionTextArea", "DiscussionTextArea", , "form-control", , , , , , , , , , , , , , , " data-autoresize", True, EnableHTMLEncode:=True))
    '        'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("DiscussionTextArea", "DiscussionTextArea", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
    '        'strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussion'  style='margin-right:10px;' onclick=AddNewDiscussion(this,'txtDiscussions')><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
    '        strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussion'  style='' onclick=AddNewDiscussion(" & strIterationID & ",'" & strFlag & "',this,'DiscussionTextArea') disabled><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
    '        strHTMLDiscussion.Append("      <button type='button' class='btn btn-info' id='SprintRelease'  style=''   onclick=insertuserStoryDiscussion(" & strIterationID & ",'" & strFlag & "',this,'DiscussionTextArea')><sup><i class='far fa-comment' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpost' title='Post' data-bs-toggle='tooltip' data-bs-placement='top' > Post<span></button>")

    '        'strHTMLDiscussion.Append("</li>")
    '        strHTMLDiscussion.Append("</ul>")
    '    End If





    '    'strHTMLDiscussion.Append("  <div id='footerBoxFooter' class='box-footer'>")
    '    'strHTMLDiscussion.Append("    <div id='footerInputGroup' class='input-group'>")
    '    'If strFlag = "UserStory" Then

    '    '    strHTMLDiscussion.Append("     <input placeholder='Type message...'  onkeyup=sendKey(event,'" & strIterationID & "','" & strFlag & "',1) id='footerInputGroupText_" & strIterationID & "' type='text' name='message'  class='InputGroupText form-control'>")
    '    '    strHTMLDiscussion.Append("        <span class='input-group-btn'>")
    '    '    strHTMLDiscussion.Append("         <button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & strIterationID & "','" & strFlag & "','asd',1) class='btn btn-warning btn-flat'>Post</button>")
    '    '    strHTMLDiscussion.Append("       </span>")
    '    'Else
    '    '    strHTMLDiscussion.Append("     <input placeholder='Type message...'  onkeyup=sendKey(event,'" & strIterationID & "','" & strFlag & "',1) id='footerInputGroupText_" & strIterationID & "' type='text' name='message'  class='InputGroupText form-control'>")
    '    '    strHTMLDiscussion.Append("        <span class='input-group-btn'>")
    '    '    strHTMLDiscussion.Append("         <button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & strIterationID & "','" & strFlag & "','sad',1) class='btn btn-warning btn-flat'>Post</button>")
    '    '    strHTMLDiscussion.Append("       </span>")
    '    'End If
    '    'strHTMLDiscussion.Append(" </div>")
    '    'strHTMLDiscussion.Append(" </div>")


    '    'strHTMLDiscussion.Append(" <div  id='chatMessage_" & strIterationID & "' class='direct-chat-messages' style='border: 1px solid #ddd;'>")



    '    'Dim strHTML As New StringBuilder
    '    'While drGetUserStoryDicussion.Read
    '    '    flag = 1
    '    '    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
    '    '    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
    '    '    strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
    '    '    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
    '    '    strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")


    '    '    If strPhotoFileName = "" Then
    '    '        strPhotoFileName = "no-photo.png"
    '    '    End If
    '    '    If strUserName = "" & HttpContext.Current.Session("strUserName") & "" Then
    '    '        strHTML.Append("    <div class='direct-chat-msg right'>")
    '    '        strHTML.Append("<div class='direct-chat-info clearfix'>")
    '    '        strHTML.Append("<span class='direct-chat-name float-end' style=' float:right!important;'>" & strEmployeeName & "</span>")
    '    '        strHTML.Append("<span class='direct-chat-timestamp float-start'>" & strDiscussionDate & "</span>")
    '    '        strHTML.Append("   </div>")

    '    '        strHTML.Append("   <img class='direct-chat-img' src='../../Images/Photo/" & strPhotoFileName & "' alt = 'Message User Image'>")
    '    '        strHTML.Append(" <div class='direct-chat-text'> " & strComment & "")

    '    '        strHTML.Append("   </div>")

    '    '        strHTML.Append("    </div>")
    '    '    Else
    '    '        strHTML.Append("   <div class='direct-chat-msg'>")
    '    '        strHTML.Append("    <div class='direct-chat-info clearfix'>")
    '    '        strHTML.Append("      <span class='direct-chat-name float-start'>" & strEmployeeName & "</span>")
    '    '        strHTML.Append("     <span class='direct-chat-timestamp float-end' style=' float:right!important;'>" & strDiscussionDate & "</span>")
    '    '        strHTML.Append("   </div>")

    '    '        strHTML.Append("  <img class='direct-chat-img' src='../../Images/Photo/" & strPhotoFileName & "' alt = 'Message User Image'>")
    '    '        strHTML.Append(" <div class='direct-chat-text'> " & strComment & "")
    '    '        strHTML.Append(" </div>")

    '    '        strHTML.Append("    </div>")

    '    '    End If
    '    'End While

    '    'If flag = 0 Then
    '    '    strHTMLDiscussion.Append("<label style='font-size:14px;text-align:center'>No Discussion Available</label>")
    '    '    strHTMLDiscussion.Append("   </div>")
    '    'Else
    '    '    strHTMLDiscussion.Append(strHTML.ToString)
    '    '    strHTMLDiscussion.Append("   </div>")

    '    'End If

    '    Return strHTMLDiscussion.ToString()
    'End Function
    Public Function Resource_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divResource' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion'>Teams</h2>")
        'strHTML.Append("<div id='divResourceDetails1' style='overflow:auto;padding-right:3%;width:105.5%;' class='row text-center'>")
        ''strHTML.Append("<table class='tblResource'>")
        'Dim dtTable As New DataTable
        'Dim Flag As String = "0"
        'Dim strSql As String = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("intProjectID") & "," & userStoryID & ",'UserStory'"
        'dtTable = CommonFunctions.Data.GetDataTable(strSql, True)
        'For i As Integer = 0 To dtTable.Rows.Count - 1
        '    Flag = 1
        '    strHTML.Append("<div class='col-lg-3 col-md-6 mb-4'>")
        '    strHTML.Append("<div class='card'>")
        '    strHTML.Append("<img class='card-img-top' src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFilename"), "") & "' alt=''>")
        '    strHTML.Append("<div class='card-body'>")
        '    strHTML.Append("<h4 class='card-title'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName"), "") & "</h4>")
        '    strHTML.Append("<p class='card-text'>Role : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("RoleDescription"), "") & "</p>")
        '    strHTML.Append("<p class='card-text'>Assignment Start Date : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("ExpectedStartDate"), "") & "</p>")
        '    strHTML.Append("<p class='card-text'>Assignment End Date : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("ExpectedEndDate"), "") & "</p>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("<div class='card-footer'>")
        '    strHTML.Append("<div class='counter'>")
        '    strHTML.Append("<div class='row'>")

        '    strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
        '    strHTML.Append("<div class='employees'>")
        '    strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("TotalTasks"), "") & "</p>")
        '    strHTML.Append("<p class='employee-p'>Total Tasks</p>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
        '    strHTML.Append("<div class='employees'>")
        '    strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("InProgressTasks"), "") & "</p>")
        '    strHTML.Append("<p class='employee-p'>In Progress</p>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
        '    strHTML.Append("<div class='employees'>")
        '    strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("CompletedTasks"), "") & "</p>")
        '    strHTML.Append("<p class='employee-p'>Completed</p>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")


        'Next
        ''Added By Dipali V On 2nd April 2018 For If no Resource are there
        'If Flag = 0 Then
        '    strHTML.Append("<div class='col-lg-12'>")
        '    strHTML.Append("<p class='nodata'>There are no items assign to resource</p>")
        '    strHTML.Append("</div>")
        'End If
        ''End of Added By Dipali V On 2nd April 2018 For If no Resource are there
        'strHTML.Append("</div>")





        Dim StrQuery As String = ""
        Dim EmployeeName As String = ""
        Dim EmployeeID As String = ""
        Dim ExpectedStartDate As String = ""
        Dim ExpectedEndDate As String = ""
        Dim RoleDescription As String = ""
        Dim SystemFilename As String = ""
        Dim TotalTasks As String = ""
        Dim InProgressTasks As String = ""
        Dim CompletedTasks As String = ""
        Dim TotalIssues As String = ""
        Dim ResourcePercentage As String = ""
        Dim TaskCompletionPercentage As String = ""
        Dim BarColor As String = ""
        Dim Clsprogressbar As String = ""
        Dim badgecolor As String = ""
        Dim drGetTeamDetails As IDataReader

        strHTML.Append("<Div class='col-sm-12' id='divTeamsList'>")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<table class='clsTeamTable'>")

        StrQuery = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("IntProjectID") & "," & userStoryID & ",'UserStory'"
        drGetTeamDetails = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        ' strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFileName").ToString, "")
        While drGetTeamDetails.Read
            intnewCounter += 1
            If intnewCounter = 1 Then
                IscheckDatahas = 1
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
                EmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeName").ToString, "")
                EmployeeID = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeID").ToString, "")
                InProgressTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("InProgressTasks").ToString, "")
                CompletedTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("CompletedTasks").ToString, "")
                TotalIssues = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalIssues").ToString, "")
                ResourcePercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ResourcePercentage").ToString, "")
                TaskCompletionPercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TaskCompletionPercentage").ToString, "")
                TotalTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalTasks").ToString, "")
                SystemFilename = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFilename").ToString, "")
                RoleDescription = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("RoleDescription").ToString, "")
                ExpectedEndDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedEndDate").ToString, "")
                BarColor = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("BarColor").ToString, "")
                If BarColor = "Blue" Then
                    Clsprogressbar = "active"
                    badgecolor = "label label-primary"
                ElseIf BarColor = "Green" Then
                    Clsprogressbar = "progress-bar-success"
                    badgecolor = "label label-success"
                ElseIf BarColor = " Orange" Then
                    Clsprogressbar = "progress-bar-warning"
                    badgecolor = "label label-warning"
                ElseIf BarColor = " Red" Then
                    Clsprogressbar = "progress-bar-danger"
                    badgecolor = "label label-danger"
                End If


                strHTML.Append("<div class='card'>" & vbCrLf)
                'strHTML.Append("<div class='cardheader'>" & vbCrLf)
                strHTML.Append("<div class='Row' style='margin-top:3%'>")
                strHTML.Append("<div class='col-sm-2'>")
                strHTML.Append("<span class='chat-img float-start' data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Image'>")
                strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
                strHTML.Append("</span>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-10'>")

                Dim strLessComment As String = ""
                Dim strRemaining As String = ""
                If RoleDescription.Length > 10 Then
                    strLessComment = RoleDescription.Substring(0, 10)

                End If
                strHTML.Append("<P class='ClsTeamDetails'><span  data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></P>")
                strHTML.Append("<P class='ResourcePercentage'><span data-bs-toggle='tooltip' data-bs-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </P>")
                strHTML.Append("<div class='progress' style='width:80%'>")
                'strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -41px; margin-right: -8px;border-radius:10px;color:white!important;' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</td>")

            End If
            If intnewCounter = 2 Then
                IscheckDatahas = 1
                EmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeName").ToString, "")
                EmployeeID = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeID").ToString, "")
                InProgressTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("InProgressTasks").ToString, "")
                CompletedTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("CompletedTasks").ToString, "")
                TotalIssues = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalIssues").ToString, "")
                ResourcePercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ResourcePercentage").ToString, "")
                TaskCompletionPercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TaskCompletionPercentage").ToString, "")
                TotalTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalTasks").ToString, "")
                SystemFilename = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFilename").ToString, "")
                RoleDescription = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("RoleDescription").ToString, "")
                ExpectedEndDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedEndDate").ToString, "")
                ExpectedStartDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedStartDate").ToString, "")
                BarColor = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("BarColor").ToString, "")
                If BarColor = "Blue" Then
                    Clsprogressbar = "active"
                    badgecolor = "label label-primary"
                ElseIf BarColor = "Green" Then
                    Clsprogressbar = "progress-bar-success"
                    badgecolor = "label label-success"
                ElseIf BarColor = " Orange" Then
                    Clsprogressbar = "progress-bar-warning"
                    badgecolor = "label label-warning"
                ElseIf BarColor = " Red" Then
                    Clsprogressbar = "progress-bar-danger"
                    badgecolor = "label label-danger"
                End If



                strHTML.Append("<td>")
                strHTML.Append("<div class='card'>" & vbCrLf)
                'strHTML.Append("<div class='cardheader'>" & vbCrLf)
                strHTML.Append("<div class='Row' style='margin-top:3%'>")
                strHTML.Append("<div class='col-sm-2'>")
                strHTML.Append("<span class='chat-img float-start' data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Image'>")
                strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
                strHTML.Append("</span>")
                strHTML.Append("</div>")
                Dim strLessComment As String = ""
                Dim strRemaining As String = ""
                If RoleDescription.Length > 10 Then
                    strLessComment = RoleDescription.Substring(0, 10)

                End If


                strHTML.Append("<div class='col-sm-10'>")
                strHTML.Append("<P class='ClsTeamDetails'><span  data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></P>")
                ' strHTML.Append("<P class='ClsTeamDetails'><span  data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='top' title='Role Description'>" & RoleDescription & " </label></P>")
                strHTML.Append("<P class='ResourcePercentage'><span data-bs-toggle='tooltip' data-bs-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </P>")
                strHTML.Append("<div class='progress' style='width:80%'>")
                'strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -41px; margin-right: -8px;border-radius:10px;color:white!important;' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                intnewCounter = 0
            End If



        End While
        If intnewCounter = 1 Then
            strHTML.Append("</tr>")
        End If

        If IscheckDatahas = 0 Then
            strHTML.Append("<tr>")
            strHTML.Append("<td>")
            strHTML.Append("<div class='NoTeam'>")
            strHTML.Append("<span style='text-align:center' > There are no items to show</span>") 'There are no items to show in this view.
            strHTML.Append("</div>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")
        End If

        strHTML.Append("</table>")
        strHTML.Append("</div>")
        strHTML.Append("</Div>")
        strHTML.Append("</Div>")
        Return strHTML.ToString

    End Function
    Public Function History_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        'Added By kashish On For UI change
        strHTML.Append("<div id='divHistory' class='clsBox'>")
        'End of Added By kashish On For UI change
        strHTML.Append("<h2 class='clsDiscussion'>History Details</h2>")
        'strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='text' name='table_search' id='txtSearchhistory' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        'strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-12 col-sm-12' id='divhistoryList'>")
        strHTML.Append(WriteGrid("HistorykList", userStoryID, ""))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function Issues_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()


        'Added By kashish On For UI change
        strHTML.Append("<div id='divIssues' class='clsBox' >")
        'End of Added By kashish On For UI change
        strHTML.Append("<h2 class='clsDiscussion'>Issues Details</h2>")
        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        If strAddLinkAccess = "1" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip' title='Form View' data-bs-placement='bottom' onclick=ShowData('Form','subIssue')>Add</a></h2>")
        Else
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip' title='Map User story to sprint' data-bs-placement='bottom' >Add</a></h2>")

        End If


        strHTML.Append("<div class='col-sm-12 col-sm-12' id='divIssuesList'>")
        strHTML.Append(WriteGrid("IssueList", userStoryID, ""))
        strHTML.Append("</div>")

        strHTML.Append("<Div class='col-sm-12' id='divIssueForm' style='display:none'>")
        strHTML.Append(" <div class='col-sm-12 '>")
        strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'Issue') class='fa fa-save'></i>")
        strHTML.Append("</div>")
        'strHTML.Append(" <div class='row'>") '1ST
        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append(" <div class='col-sm-4 '>")
        'strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Summary</label> ")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-8 '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSummary", "txtSummary", , "form-control", , , , , , 50, , , , , , , , , "onkeyup='javascript:limitText(this,countdownSummary,1000)' onKeyUp='javascript:limitText(this,countdownSummary, 1000)'onchange=ClearSpan('txtSummary','spanUserDesc')", True, EnableHTMLEncode:=True))
        'strHTML.Append("<small name='countdownSummary' Id='countdownSummary'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>1000</small>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;text-align:left'>Summary<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-10' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSummary", "txtSummary", , "form-control", , , , , , , 500, , , , , , , , "onkeyup='javascript:limitText(this,countdownSummary,500)' onKeyUp='javascript:limitText(this,countdownSummary, 500)'onchange=ClearSpan('txtSummary','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append("<small name='countdownSummary' Id='countdownSummary'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>500</small>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;text-align:left'>Description<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-10'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , 1000, , , , , , , , "onkeyup='javascript:limitText(this,countdownDescription,1000)' onchange=ClearSpan('txtDescription','spanUserDesc')", True, EnableHTMLEncode:=True))
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , 1000, , , , , , , , "onkeyup='javascript:limitText(this,countdownDescription,1000)' onKeyUp='javascript:limitText(this,countdownDescription, 1000)'onchange=ClearSpan('txtDescription','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append("<small name='countdownDescription' Id='countdownDescription'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>1000</small>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append(" <div class='row'>") '1nd
        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append(" <div class='col-sm-4 '>")
        'strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Description </label> ")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-8 '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , 50, , , , , , , , , "onkeyup='javascript:limitText(this,countdownDescription,1000)' onKeyUp='javascript:limitText(this,countdownDescription, 1000)'onchange=ClearSpan('txtSummary','spanUserDesc')", True, EnableHTMLEncode:=True))
        'strHTML.Append("<small name='countdownDescription' Id='countdownDescription'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>1000</small>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='row'>") '3rd
        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append(" <div class='col-sm-4 '>")
        'strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Reported Date	</label> ")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-8 '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReportedDate", "txtReportedDate", "form-control", 140, 100, , , , , , , , "style='width: 220px!important'", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div class=''>")
        'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;float:right;margin-top:-2%;margin-right:31%' id='#dptxtReportedDate'  onclick=""$('#txtReportedDate').datepicker();$('#txtReportedDate').datepicker('show');""></i>")
        ''strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")



        'strHTML.Append(" <div class='row'>") '1nd
        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append(" <div class='col-sm-4 '>")
        'strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Reported Time	</label> ")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-8 '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReported", "txtReported", "form-control", 140, 100, , , , , , , , "style='width: 220px!important' onclick=""timeNow(txtReported)""", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Type<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-3' style='margin-left:6% '>")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType", "SELECT ''", , , "onclick=GetSelectedSubtype(this) Class='form-control' style='width:222px!important'", False, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Sub Type<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-3' style='margin-left:6%'>")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboSubIssueType", "SELECT ''", , " form-control", "Class='form-control' style='width:222px!important'", False, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        'strHTML.Append(" <div class='row'>") '1nd
        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append(" <div class='col-sm-4 '>")
        'strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Type</label> ")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-8 '>")
        'strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType", "SELECT ''", , , "onclick=GetSelectedSubtype(this) Class='form-control' style='width:222px!important'", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")



        'strHTML.Append(" <div class='row'>") '1nd
        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append(" <div class='col-sm-4 '>")
        'strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Sub Type</label> ")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-8 '>")
        'strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboSubIssueType", "SELECT ''", , " form-control", "Class='form-control' style='width:222px!important'", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")



        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Reported By<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-3' style='margin-left:14% '>")

        Dim StrReporter As String = HttpContext.Current.Session("intUserID")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboreporter", "Select ''", , StrReporter, "form-control", True, True, "form-control style='width:222px!important'")).ToString.Replace("'", "\'")
        strHTML.Append("</div>")
        strHTML.Append("<input type=hidden id=hdnStrReporter value='" & StrReporter & "'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Staus<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-3' style='margin-left:2%'>")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboStatus", "Select ''", , " form-control", "Class='form-control' style='width:222px!important'", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")




        'strHTML.Append(" <div class='row'>") '1nd
        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append(" <div class='col-sm-4 '>")
        'strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Reported By</label> ")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-8 '>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", 140, 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboreporter", "Select ''", , Session("intuserID"), "form-control", True, True, "form-control style='width:222px!important'")).ToString.Replace("'", "\'")

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")



        'strHTML.Append(" <div class='row'>") '1nd
        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append(" <div class='col-sm-4 '>")
        'strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Resonsible Person</label> ")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-8 '>")
        'Dim ResponsibleIssue As String = "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")

        'strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboResonsible", ResponsibleIssue, , " form-control", "Class='form-control' style='width:222px!important'", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Resonsible Person<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-3' style='margin-left:2%'>")
        Dim ResponsibleIssue As String = "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboResonsible", ResponsibleIssue, , , "Class='form-control' style='width:222px!important'", True, True, , , , ))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")



        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return strHTML.ToString

    End Function
    Public Function Reviews_section(ByVal userStoryID As String) As String


        'Dim strHTML As New StringBuilder()
        ''Added By kashish On For UI change
        'strHTML.Append("<div id='divReviews' class='clsBox' style='margin-left:3%'>")
        ''End of Added By kashish On For UI change

        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<P>Reviews Details</p>")
        'Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        ''If strAddLinkAccess = "1" Then
        'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Form View' data-bs-placement='bottom' onclick=ShowData('Form','subReview')>Add</a></h2>")
        '' Else
        ''strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Map Relase and Sprint to Create Review' data-bs-placement='bottom' >Add</a></h2>")

        ''strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip'  data-bs-placement='bottom' >Add</a></h2>")

        ''End If
        'strHTML.Append("</div>")

        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<Div class='col-sm-12' id='divReviewList'>")
        'strHTML.Append(WriteGrid("ReviewList", userStoryID, ""))
        'strHTML.Append("</Div>")
        'strHTML.Append("</Div>")




        'strHTML.Append("<Div class='col-sm-12' id='divReviewForm' style='display:none'>")

        'strHTML.Append(" <div class='col-sm-12 '>")
        'strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'Review') class='fa fa-save'></i>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-12'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Review Title<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:73%;margin-left:-11%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewtitle", "txtReviewtitle", "form-control", 140, 100, , , , , , , , "", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Review Type<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:73%;margin-left:-11%'>")
        'Dim StrReviewtype As String = "usp_Sel_tbl_PM_ProjectReviewTypes " & Session("IntProjectID")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboReviewtype", StrReviewtype, 190, , "class='form-control' ", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group SecControl' >")
        'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Work Hrs<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='margin-left:19%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewHrs", "txtReviewHrs", "form-control ", 203, 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div class=''>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append("</div>")


        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>R.Start Date<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewStartDate", "txtReviewStartDate", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div class=''>")
        'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpreviewstartdate'  onclick=""$('#txtReviewStartDate').datepicker();$('#txtReviewStartDate').datepicker('show');""></i>")
        ''strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group SecControl' >")
        'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>R.End Date<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='margin-left:19%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewEnddate", "txtReviewEnddate", "form-control ", 203, 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div class=''>")
        'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;margin-left:28%;color:#0099CC;' id='#dpReviewEnddate'  onclick=""$('#txtReviewEnddate').datepicker();$('#txtReviewEnddate').datepicker('show');""></i>")
        ''strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group SecControl' >")
        'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Reviewer<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-6' style='margin-left:25%'>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboReviewer", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 190, , "class='form-control' ", True, True))
        'strHTML.Append("<div class='btn-group dropdown' style='float:right'>")
        ''strHTML.Append("<button type='button' class='btn btn-secondary btn-Green'>")
        ''strHTML.Append("Create")
        ''strHTML.Append("</button>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboReviewer", "cboReviewer", "form-control ", 182, 100, , , , , , , , " style='width:182px!important'  data-bs-toggle='dropdown'", True, , , , , , True))
        '' strHTML.Append("<button type='button' class='btn btn-secondary dropdown-toggle dropdown-toggle-split btn-Green' aria-haspopup='true' aria-expanded='false'>")
        'strHTML.Append("<i class='fa fa-sort-down' style='float: right; margin-top:-9%;margin-right:-2%'></i>")
        'strHTML.Append("</button>")
        'strHTML.Append("<ul class='dropdown-menu'>")


        'Dim ReviewerDetailsnew As IDataReader
        'Dim strSQL As String = "usp_Ng2_Sel_CurrentTeamMembers " & Session("IntProjectID") & ""
        'ReviewerDetailsnew = CommonFunctions.Data.GetDataReader(strSQL, True)
        'Dim intnewCounter As Integer = 0
        'Dim IscheckDatahas As Integer = 0
        'Dim ReviwerName As String = ""
        'Dim ReviwerID As String = ""
        'While ReviewerDetailsnew.Read
        '    intnewCounter += 1
        '    IscheckDatahas = 1
        '    ReviwerName = CommonFunctions.Data.CheckIsDBNull(ReviewerDetailsnew("UserName").ToString, "")
        '    ReviwerID = CommonFunctions.Data.CheckIsDBNull(ReviewerDetailsnew("EmployeeId").ToString, "")
        '    strHTML.Append("<li>")
        '    strHTML.Append("<input type=hidden id='hdnReviwerID" & ReviwerID & "' value='" & ReviwerID & "'>")
        '    strHTML.Append("<input type='checkbox' id='Reviwer" & ReviwerID & "' value='" & ReviwerName & "' class='k-checkboxcboReviewer' onclick=""SelectReviwer(this," & ReviwerID & ",'" & ReviwerName & "')"">")
        '    strHTML.Append("<label class='k-checkbox-label' for='eq1' style='margin-left:9%;font-weight:100!important'>" & ReviwerName & "</label>")
        '    strHTML.Append("</li>")
        '    ' strHTML.Append("<li class='dropdown-item' onclick=SelectResource('User','')>")

        '    'strHTML.Append("</li>")

        'End While

        'strHTML.Append("</ul>")

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")



        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Reviewee<span class='required'></span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:66% '>")

        'strHTML.Append("<div class='btn-group dropdown' style='float:right'>")
        ''strHTML.Append("<button type='button' class='btn btn-secondary btn-Green'>")
        ''strHTML.Append("Create")
        ''strHTML.Append("</button>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboReviewee", "cboReviewee", "form-control ", 203, 100, , , , , , , , " style='width:100px!important'  data-bs-toggle='dropdown'", True, , , , , , True))
        '' strHTML.Append("<button type='button' class='btn btn-secondary dropdown-toggle dropdown-toggle-split btn-Green' aria-haspopup='true' aria-expanded='false'>")
        'strHTML.Append("<i class='fa fa-sort-down' style='float: right; margin-top:-9%;margin-right:3%'></i>")
        'strHTML.Append("</button>")
        'strHTML.Append("<ul class='dropdown-menu'>")


        'Dim ReviewDetailsnew As IDataReader
        'Dim strSQL1 As String = "usp_NG2_Sel_tbl_PM_ReviewStatistics_RevieweeList 'ReviewedOf', " & Session("IntProjectID") & ", NULL, NULL,NULL,NULL,Null,'-1',0"
        'ReviewDetailsnew = CommonFunctions.Data.GetDataReader(strSQL1, True)

        'Dim ResourceName As String = ""
        'Dim ResourceID As String = ""
        'While ReviewDetailsnew.Read
        '    intnewCounter += 1
        '    IscheckDatahas = 1
        '    ResourceName = CommonFunctions.Data.CheckIsDBNull(ReviewDetailsnew("Resource Name").ToString, "")
        '    ResourceID = CommonFunctions.Data.CheckIsDBNull(ReviewDetailsnew("EmployeeID").ToString, "")
        '    strHTML.Append("<li>")
        '    strHTML.Append("<input type=hidden id='hdnresourceID" & ResourceID & "' value='" & ResourceID & "'>")
        '    strHTML.Append("<input type='checkbox' id='Resource" & ResourceID & "' value='" & ResourceName & "' class='k-checkbox' onclick=""SelectResource(this," & ResourceID & ",'" & ResourceName & "')"">")
        '    strHTML.Append("<label class='k-checkbox-label' for='eq1' style='margin-left:9%;font-weight:100!important'>" & ResourceName & "</label>")
        '    strHTML.Append("</li>")
        '    ' strHTML.Append("<li class='dropdown-item' onclick=SelectResource('User','')>")

        '    'strHTML.Append("</li>")

        'End While

        'strHTML.Append("</ul>")
        'strHTML.Append("</div>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboReviewee", strSQL, 190, , "class='form-control' ", True, True))


        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Status<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
        'Dim sqlstatus As String = ""
        'sqlstatus = "usp_Sel_tbl_RTS_ProjectSpecificControlData 'ReviewStatus_ADD_NEW'"
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRevieStatus", "usp_NG2_Sel_tbl_IB_Priorities", 190, "Open", "class='form-control' ", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left;margin-left:0%'>Checklist<span class='required'></span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='margin-left:0% '>")
        'Dim sqlChecklist As String = ""
        'sqlChecklist = "usp_sel_GetProjectChecklistsAndGroups " & Session("intprojectID")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboChecklist", sqlChecklist, 190, , "class='form-control' ", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'Return strHTML.ToString
        Dim strHTML As New StringBuilder()
        'Added By kashish On For UI change
        strHTML.Append("<div id='divReviews' class='clsBox' style='height:555px!important'>")
        'End of Added By kashish On For UI change

        strHTML.Append("<h2 class='clsDiscussion'>Reviews Details</h2>")

        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        If strAddLinkAccess = "1" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Form View' data-bs-placement='bottom' onclick=ShowData('Form','subReview')>Add</a></h2>")
        Else
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Map User story to sprint' data-bs-placement='bottom' >Add</a></h2>")

            'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip'  data-bs-placement='bottom' >Add</a></h2>")
        End If

        strHTML.Append("<div class='col-sm-12 col-sm-12' id='divReviewList'>")
        strHTML.Append(WriteGrid("ReviewList", userStoryID, "UserStory"))
        strHTML.Append("</div>")




        strHTML.Append("<Div class='col-sm-12' id='divReviewForm' style='display:none'>")

        strHTML.Append(" <div class='col-sm-12 '>")
        strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;    margin-top: -10px;' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'Review') class='fa fa-save'></i>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Review Title<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewtitle", "txtReviewtitle", "form-control", , 50, , , , , , , , "", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Review Type<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        Dim StrReviewtype As String = "usp_Sel_tbl_PM_ProjectReviewTypes " & Session("IntProjectID")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboReviewtype", StrReviewtype, , , "class='form-control' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>R.Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewStartDate", "txtReviewStartDate", "form-control", , 100, , , , , , , , "autocomplete='off' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
        strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='float:right; margin-top: -35px;color:#0099CC;' id='#dpreviewstartdate'  onclick=""$('#txtReviewStartDate').datepicker();$('#txtReviewStartDate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>R.End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewEnddate", "txtReviewEnddate", "form-control", , 100, , , , , , , , "autocomplete='off' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='float:right; margin-top: -35px;color:#0099CC;' id='#dpReviewEnddate'  onclick=""$('#txtReviewEnddate').datepicker();$('#txtReviewEnddate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Reviewer<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        strHTML.Append("<div class='btn-group dropdown' style='float:right;width: 100%;'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboReviewer", "cboReviewer", "form-control ", , 100, Session("strusername"), , , , , , , "autocomplete='off' style=''  data-bs-toggle='dropdown'", True, , , , , , True))
        ' strHTML.Append("<button type='button' class='btn btn-secondary dropdown-toggle dropdown-toggle-split btn-Green' aria-haspopup='true' aria-expanded='false'>")
        'strHTML.Append("</button>")
        strHTML.Append("<ul class='dropdown-menu' style='min-width: 190px!important;'>")


        Dim ReviewerDetailsnew As IDataReader
        Dim strSQL As String = "usp_Sel_tbl_PM_ReviewStatistics_ReviewerList 'ReviewedBy', " & Session("IntProjectID") & ", NULL, NULL,NULL,NULL,Null,'-1',0"

        ReviewerDetailsnew = CommonFunctions.Data.GetDataReader(strSQL, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        Dim ReviwerName As String = ""
        Dim ReviwerID As String = ""
        While ReviewerDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ReviwerName = CommonFunctions.Data.CheckIsDBNull(ReviewerDetailsnew("Resource Name").ToString, "")
            ReviwerID = CommonFunctions.Data.CheckIsDBNull(ReviewerDetailsnew("EmployeeID").ToString, "")
            strHTML.Append("<li>")
            strHTML.Append("<input type=hidden id='hdnReviwerID" & ReviwerID & "' value='" & ReviwerID & "'>")
            strHTML.Append("<input type='checkbox' id='Reviwer" & ReviwerID & "' value='" & ReviwerName & "' class='k-checkboxcboReviewer' onclick=""SelectReviwer(this," & ReviwerID & ",'" & ReviwerName & "')"">")
            strHTML.Append("<label class='k-checkbox-label' for='eq1' style='margin-left:9%;font-weight:100!important'>" & ReviwerName & "</label>")
            strHTML.Append("</li>")
            ' strHTML.Append("<li class='dropdown-item' onclick=SelectResource('User','')>")

            'strHTML.Append("</li>")

        End While

        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Reviewee<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")

        strHTML.Append("<div class='btn-group dropdown' style='float:right;    width: 100%;'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboReviewee", "cboReviewee", "form-control ", , 100, , , , , , , , "autocomplete='off' style=''  data-bs-toggle='dropdown'", True, , , , , , True))
        ' strHTML.Append("<button type='button' class='btn btn-secondary dropdown-toggle dropdown-toggle-split btn-Green' aria-haspopup='true' aria-expanded='false'>")
        'strHTML.Append("</button>")
        strHTML.Append("<ul class='dropdown-menu'>")


        Dim ReviewDetailsnew As IDataReader
        Dim strSQL1 As String = "usp_Ng2_Sel_CurrentTeamMembers " & Session("IntProjectID") & ""
        ReviewDetailsnew = CommonFunctions.Data.GetDataReader(strSQL1, True)

        Dim ResourceName As String = ""
        Dim ResourceID As String = ""
        While ReviewDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ResourceName = CommonFunctions.Data.CheckIsDBNull(ReviewDetailsnew("UserName").ToString, "")
            ResourceID = CommonFunctions.Data.CheckIsDBNull(ReviewDetailsnew("EmployeeId").ToString, "")
            strHTML.Append("<li>")
            strHTML.Append("<input type=hidden id='hdnresourceID" & ResourceID & "' value='" & ResourceID & "'>")
            strHTML.Append("<input type='checkbox' id='Resource" & ResourceID & "' value='" & ResourceName & "' class='k-checkbox' onclick=""SelectResource(this," & ResourceID & ",'" & ResourceName & "')"">")
            strHTML.Append("<label class='k-checkbox-label' for='eq1' style='margin-left:9%;font-weight:100!important'>" & ResourceName & "</label>")
            strHTML.Append("</li>")
            ' strHTML.Append("<li class='dropdown-item' onclick=SelectResource('User','')>")

            'strHTML.Append("</li>")

        End While

        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboReviewee", strSQL, 190, , "class='form-control' ", True, True))


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Status<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' style=''>")
        Dim sqlstatus As String = ""
        sqlstatus = "usp_Sel_tbl_RTS_ProjectSpecificControlData 'ReviewStatus_ADD_NEW'"
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRevieStatus", sqlstatus, , "Open", "class='form-control' ", False, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left;margin-left:0%'>Checklist<span class='required'></span></label> ")
        strHTML.Append(" <div class='col-md-8' style=''>")
        Dim sqlChecklist As String = ""
        sqlChecklist = "usp_sel_GetProjectChecklistsAndGroups " & Session("intprojectID")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboChecklist", sqlChecklist, , , "class='form-control' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Work Hrs.<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' style=''>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewHrs", "txtReviewHrs", "form-control ", 203, 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    Public Function Tasks_section(ByVal userStoryID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        Dim TasksDetailsnew As IDataReader
        Dim StrQuery As String = ""
        Dim InitialEstimate As String = ""
        Dim TaskStoryPoint As String = ""
        Dim SumEfforts As String = ""
        StrQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & userStoryID & ",'UserStory'"
        TasksDetailsnew = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        While TasksDetailsnew.Read
            InitialEstimate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("InitialEstimate").ToString, "")
            SumEfforts = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("SumEfforts").ToString, "")
            TaskStoryPoint = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StoryPoint").ToString, "")
        End While
        'EndDate = CType(CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate"), "").ToShortDateString(),
        Dim strSql As String = ""
        If Flag <> "aftersave" Then
            'Added By kashish On For UI change
            strHTML.Append("<div id='divTasks' class='clsBox' style='margin-left:3%'>")
            'End of Added By kashish On For UI change
        End If
        Dim TaskID As String = "0"
        strHTML.Append("<h2 class='clsDiscussion'>Tasks Details</h2>")
        'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a onclick=ShowData('List','subTask')>List</a> | <a onclick=ShowData('Form','subTask')>Add</a></h2>")


        strHTML.Append("<div class='col-sm-12' id='divTaskList'>")
        'strHTML.Append(WriteGrid("TaskList", userStoryID))
        strHTML.Append("<table id='tblProjectDetail' style='Width:100%;'>")
        strHTML.Append("<tbody>")

        strHTML.Append(TasksDetails(userStoryID))


        strHTML.Append("<tr class='trProjectDetail'>")
        'If InitialEstimate < SumEfforts Then
        '    strHTML.Append("<td style='Width:4%;text-align:left;vertical-align:bottom' ><A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%'  data-bs-toggle='tooltip' data-bs-placement='right' title='The sum of tasks was greater that Story point of User Story'></i></A></td>")
        'Else
        strHTML.Append("<td style='Width:4%;text-align:left;vertical-align:bottom' ><A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%'  data-bs-toggle='tooltip' data-bs-placement='right' title='Click here to add new record'></i></A></td>")

        ' End If

        strHTML.Append("<Td style='width:20%'>")
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cborole0", "Usp_App_Sel_tbl_PM_Roles", , , "class='form-control' onchange=ClearSpan('Cborole0','SpanCboPGroup')", False, True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName0", "txtTaskName0", "form-control", 100, 100, , , , , , , , "  PlaceHolder='Task Name' title='Task Name'", True, , , , , , True))
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))
        strHTML.Append("<input type=hidden name='hdrownumber' value='0' /></Td>")

        strHTML.Append("<td style='width:15%'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate0", "txtStartDate0", "form-control", 100, 100, , , , , , , , " PlaceHolder='Start Date' title='Start Date' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
        strHTML.Append(" <i data-bs-toggle='tooltip' title='Start Date' data-bs-placement='bottom' class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpstartdate0'  onclick=""$('#txtStartDate0').datepicker();$('#txtStartDate0').datepicker('show');""></i>")
        strHTML.Append("</td>")


        'strHTML.Append("<td  style='color:#dd4b39;font-size:16px'>")
        'strHTML.Append("<i id='spanStartDate0' data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>")
        'strHTML.Append("</td>")
        strHTML.Append("<td style='width:15%'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate0", "txtEndDate0", "form-control", 100, 100, , , , , , , , " PlaceHolder='End Date' title='End Date' onkeyup=ClearSpan('txtEndDate0','spantxtEndDate0')", True, , , , , , True))
        strHTML.Append(" <i  data-bs-toggle='tooltip' title='End Date' data-bs-placement='bottom' class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpEnddate0'  onclick=""$('#txtEndDate0').datepicker();$('#txtEndDate0').datepicker('show');""></i>")
        strHTML.Append("</td>")

        strHTML.Append("<td style='width:13%'>")

        'Commented and Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs0", "txtWorkHrs0", "form-control", , , , , , False, , , , "PlaceHolder='Work Hrs' title='Work Hrs' onkeyup=ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0') limitText=4", True, , , , , , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs0", "txtWorkHrs0", "form-control", , , , , , False, , , , "PlaceHolder='Work Hrs' title='Work Hrs' onkeyup=ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0') limitText=8", True, , , , , , True))
        'End of Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("</td>")


        strHTML.Append("<td style='width:13%'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints0", "txtStoryPoints0", "form-control", , , , "Center", , , , , , "style='text-align:center!important' PlaceHolder='Story Pts' title='Story Pts' limitText=4", True, , , , , , True))
        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("<input type=hidden id=hdnInitialEstimate value='" & InitialEstimate & "'>")
        strHTML.Append("<input type=hidden id=hdnSumEfforts value='" & SumEfforts & "'>")
        strHTML.Append("</td>")


        strHTML.Append("<td style='width:12%'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType0", "usp_NG2_Sel_tbl_PM_Project_TaskTypes_Names " & Session("intprojectID") & "", 104, , "class='form-control' title='Task Type' style='width:110%!Important'", False, True, , , , ))
        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("</td>")

        strHTML.Append("<td style='width:23%'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource0", "usp_NG2_Sel_tbl_PM_ProjectEmployees " & Session("intprojectID") & "", 104, , "class='form-control' title='Resource' style='width:100%!Important;margin-left:15%'", False, True, , , , ))
        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("</td>")


        strHTML.Append("<td style='width:3%;text-align:center'>")
        If TaskID = "0" Then
            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop;margin-left: 55%;'  data-bs-placement='bottom'  id='idEdit0' data-bs-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & ",0)' disabled></i>")
        Else
            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop;    margin-left: 55%;'  data-bs-placement='bottom' id='idEdit0' data-bs-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & ",0)'></i>")
        End If
        strHTML.Append("</td>")


        strHTML.Append("<td style='width:3%;text-align:center'>")
        strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop;    margin-left: 42%;' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete0' title='Delete Task' class='fa fa-trash' ></i>") 'onclick='DeleteTask()'
        strHTML.Append("</td>")


        strHTML.Append("<td style='width:3%;text-align:center;'>")
        'If InitialEstimate < SumEfforts Then
        '    strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='SaveBtn0' data-bs-toggle='tooltip' title='The sum of tasks was greater that Story point of User Story' class='fa fa-save'></i>")
        'Else
        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        If strAddLinkAccess = "1" Then
            strHTML.Append("<i style='font-size:14px!important;text-align:center;    margin-left: 26%;' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='SaveBtn0' data-bs-toggle='tooltip' title='save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task')""></i>")
        Else
            'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Map Relase and Sprint to Create Review' data-bs-placement='bottom' >Add</a></h2>")
            strHTML.Append("<i style='font-size:14px!important;text-align:center;    margin-left: 26%;' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='SaveBtn0' data-bs-toggle='tooltip' title='Task can not be created as User Story/Sprint get completed/not started.' class='fa fa-save' ></i>")

            'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip'  data-bs-placement='bottom' >Add</a></h2>")
        End If
        'End If

        strHTML.Append("</td>")

        strHTML.Append("<td>")
        strHTML.Append("<a id='errorPopOver0'  style='font-size:15px;display:none' title='Error Details' data-bs-toggle='popover' data-bs-target='#popOverDiv' onmouseover=DataHover(this) data-bs-placement='left' data-content='' class='btn btn-block btn-danger fa fa-check-square-o errorList'></a>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")
        strHTML.Append("</tbody>")
        strHTML.Append("</table>")



        strHTML.Append("</div>")

        'strHTML.Append("<Div class='col-sm-12' id='divTaskForm' style='display:none'>")
        'strHTML.Append(" <div class='col-sm-12 '>")
        'strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save' onclick=Save_SubTab_Data(" & userStoryID & ",'Task') class='fa fa-save'></i>")
        'strHTML.Append("</div>")
        ''strHTML.Append(" <div class='row'>") '1ST
        ''strHTML.Append(" <div class='form-group'>")
        ''strHTML.Append(" <div class='col-sm-4 '>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Task Name</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-8 '>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", "form-control", 140, 100, , , , , , , , "", True, , , , , , True))
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")
        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-12'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Task Name<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:73%;margin-left:-11%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", "form-control", 140, 100, , , , , , , , "", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        ''strHTML.Append(" <div class='row'>") '1ST
        ''strHTML.Append(" <div class='form-group'>")
        ''strHTML.Append(" <div class='col-sm-4 '>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Description</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-8 '>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptiontask", "txtDescriptiontask", , "form-control", , , , , , 50, , , , , , , , , "onkeyup='javascript:limitText(this,countdowntxtDescriptiontask,1000)' onKeyUp='javascript:limitText(this,countdowntxtDescriptiontask, 1000)'onchange=ClearSpan('txtSummary','spanUserDesc')", True, EnableHTMLEncode:=True))
        ''strHTML.Append("<small name='countdowntxtDescriptiontask' Id='countdowntxtDescriptiontask'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>1000</small>")
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")

        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-12'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Description<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:73%;margin-left:-11%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptiontask", "txtDescriptiontask", , "form-control", , , , , , 50, , , , , , , , , "onkeyup='javascript:limitText(this,countdowntxtDescriptiontask,1000)' onKeyUp='javascript:limitText(this,countdowntxtDescriptiontask, 1000)'onchange=ClearSpan('txtSummary','spanUserDesc')", True, EnableHTMLEncode:=True))
        'strHTML.Append("<small name='countdowntxtDescriptiontask' Id='countdowntxtDescriptiontask'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>1000</small>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Start Date<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div class=''>")
        'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpstartdate'  onclick=""$('#txtStartDate').datepicker();$('#txtStartDate').datepicker('show');""></i>")
        ''strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group SecControl' >")
        'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='margin-left:4%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEnddate", "txtEnddate", "form-control ", 203, 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div class=''>")
        'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;margin-left:42%;color:#0099CC;' id='#dpEnddate'  onclick=""$('#txtEnddate').datepicker();$('#txtEnddate').datepicker('show');""></i>")
        ''strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")



        ''strHTML.Append(" <div class='row'>") '1nd
        ''strHTML.Append(" <div class='form-group'>")
        ''strHTML.Append(" <div class='col-sm-4 '>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Assign To</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-8 '>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, True))
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")


        ''strHTML.Append(" <div class='row'>") '1nd
        ''strHTML.Append(" <div class='form-group'>")
        ''strHTML.Append(" <div class='col-sm-4 '>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Priority	</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-8 '>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPrioritytask", "usp_NG2_Sel_tbl_IB_Priorities", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, True))
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")




        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group SecControl' >")
        'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Assign To<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='margin-left:8%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 190, , "class='form-control' ", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Priority<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPrioritytask", "usp_NG2_Sel_tbl_IB_Priorities", 190, , "class='form-control' ", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        ''strHTML.Append(" <div class='row'>") '3rd
        ''strHTML.Append(" <div class='form-group'>")

        ''strHTML.Append(" <div class='col-sm-3 '  style='Margin-left:7%!important'  id='group11'>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;  margin-left:10%!important;'>Work (hrs)</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-3 ' id='group'>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWork", "txtWork", "form-control", 130, 100, , , , , , , , "style='width:130px!important'", True, , , , , , True))
        ''strHTML.Append("</div>")

        ''strHTML.Append(" <div class='col-sm-3 ' style='Margin-left:-6%!important' id='group1'>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Story Points</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-3 ' style='Margin-left:-1%!important'  id='group2'>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints", "txtStoryPoints", "form-control", 130, 100, , , , , , , , "style='width:130px!important'", True, , , , , , True))
        ''strHTML.Append("</div>")

        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")

        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Work (hrs)<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWork", "txtWork", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtWork','spantxtWork')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group SecControl' >")
        'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Story Points<span class='required'></span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='margin-left:9%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints", "txtStoryPoints", "form-control", 190, 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtStoryPoints','spantxtStoryPoints')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        ''strHTML.Append(" <div class='row'>") '1nd
        ''strHTML.Append(" <div class='form-group'>")
        ''strHTML.Append(" <div class='col-sm-4 '>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Start Date</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-8 '>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", 140, 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")



        ''strHTML.Append(" <div class='row'>") '1nd
        ''strHTML.Append(" <div class='form-group'>")
        ''strHTML.Append(" <div class='col-sm-4 '>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>End Date</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-8 '>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", 140, 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")





        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Task Type<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTtypetask", "usp_Ng2_Sel_tbl_PM_Project_TaskTypes_Names  " & Session("intprojectID") & "", 190, , "class='form-control'", True, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group SecControl' >")
        ''strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Story Points<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-3'>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints", "txtStoryPoints", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtStoryPoints','spantxtStoryPoints')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append("</div>")






        ''strHTML.Append(" <div class='row'>") '1nd
        ''strHTML.Append(" <div class='form-group'>")
        ''strHTML.Append(" <div class='col-sm-4 '>")
        ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>User Story</label> ")
        ''strHTML.Append("</div>")
        ''strHTML.Append(" <div class='col-sm-8 '>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUserStorytask", "Usp_Ng2_Sel_tbl_PM_ScrumUserStory_AssignTasks " & Session("intprojectID") & "", , userStoryID, "onChange=UserStoryID_OnChange(value) disabled", True, True, "form-control", , , , ))
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")
        ''strHTML.Append("</div>")


        ''strHTML.Append("</div>")
        'strHTML.Append("</div>")


        If Flag <> "aftersave" Then
            strHTML.Append("</div>")
        End If

        Return strHTML.ToString

    End Function
    Private Function GetProjectSettingsDetails(ByVal strProjectID As String, ByVal strFlag As String) As String
        '====================================================================
        ' Procedure Name       : GetProjectSettingsDetails
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure gets the Project settings information from the database.
        ' Description          : The UseActivities and ApplyEffortDistribution flags are used while assigning the
        '                        Tasks to the resources and while distributing the work hours between them.
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : Bharat T.
        ' Created              : 14th-Dec-2016        
        '=====================================================================
        Dim strQuery As String = ""
        Dim drProjectSettings As IDataReader
        Dim blnUseActivities As Boolean = False
        Dim blnApplyEffortDistribution As Boolean = False
        Dim sbTasksHTML As New StringBuilder("")
        Dim strQuery2 As String = ""
        Dim drWork As IDataReader
        Dim strTemp As String = ""
        ' Changed select to SP 
        strQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " & strProjectID.ToString()

        drProjectSettings = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drProjectSettings.Read() Then
            blnUseActivities = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
            blnApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
            m_lngProjectLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("LocationID"), "0"), Long)
            m_strProjectStartDate = CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedStartDate"), "").ToString()
            m_strProjectEndDate = CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedEndDate"), "").ToString()
            If m_strProjectStartDate <> "" Then m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))
            If m_strProjectEndDate <> "" Then m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date))
            m_HaveSubTaskTypes = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
            m_ApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
            m_bitResourceValidation = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ResourceValidation"), "False"), Short)
            ' True is treated as -1 
            If m_bitResourceValidation = -1 Then
                m_bitResourceValidation = 1
            End If
            m_blnBillable = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Billable"), "False"), Boolean)
            m_blnProjectActive = Not (CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Over"), "False"), Boolean))
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectSettings)

        'Depending upon the Project Level Settings and the Page Called from set the value
        If blnApplyEffortDistribution = False And blnUseActivities = False Then
            m_strProjectSetting = PROJECT_SETTING_NORMAL
        ElseIf blnUseActivities = True Then
            m_strProjectSetting = PROJECT_SETTING_ACTIVITY
        ElseIf blnApplyEffortDistribution = True Then
            m_strProjectSetting = PROJECT_SETTING_EFFORT_DISTRIBUTION
        End If

        m_strHolidays = ""
        strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & m_lngProjectLocationID.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                strTemp = drWork.Item("HolidayDate").ToString()
                If strTemp <> "" Then
                    m_strHolidays &= CommonFunctions.Dates.GetDate(CType(strTemp, Date)) & ","
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        'If strFlag = "Hidden" Then
        '    sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hdnProjectStartDate", "hdnProjectStartDate", , , , CDate(m_strProjectStartDate).ToString("MM/dd/yyyy"), , , , , , True, , True, EnableHTMLEncode:=True))
        '    sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hdnProjectEndDate", "hdnProjectEndDate", , , , CDate(m_strProjectEndDate).ToString("MM/dd/yyyy"), , , , , , True, , True, EnableHTMLEncode:=True))
        '    sbTasksHTML.Append("<input type=hidden id='hdnResourceValidation' name='hdnResourceValidation' value='" & m_bitResourceValidation & "' />")
        '    strQuery2 = "EXEC usp_App_Sel_CurrentTeamMembers_ExpectedDate  " & strProjectID.ToString() & ",0"
        '    sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceStartDate", strQuery2, , , , True, True, , , , True))
        '    strQuery2 = "EXEC usp_App_Sel_CurrentTeamMembers_ExpectedDate  " & strProjectID.ToString() & ",1"
        '    sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceEndDate", strQuery2, , , , True, True, , , , True))


        '    sbTasksHTML.Append("<input type=hidden id='hdnHolidays' name='hdnHolidays' value='" & m_strHolidays & "' />")
        '    sbTasksHTML.Append("<input type=hidden id='hdnApplyEffortDistribution' name='hdnApplyEffortDistribution' value='" & m_ApplyEffortDistribution & "' />")
        '    sbTasksHTML.Append("<input type=hidden id='hdnHaveSubTaskTypes' name='hdnHaveSubTaskTypes' value='" & m_HaveSubTaskTypes & "' />")
        '    GetProjectSettingsDetails = sbTasksHTML.ToString
        'End If

    End Function
    'Added By Dipali V On 4th April 2018 For Get Subtype by type onchnage
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveTask(ByVal AssignTaskData As Object, ByVal UserStoryId As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveTask
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Create a task
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   4th-April-2018
        '=====================================================================
        Try

            Dim objProductBacklog As New frmProductBacklog()
            Dim strReturnHTML As New StringBuilder("")

            strReturnHTML.Append(objProductBacklog.SaveTaskDetails(AssignTaskData))

            'Return New frmProductBacklog().WriteGrid("TaskList", UserStoryId)
            Return New frmProductBacklog().Tasks_section(UserStoryId, "aftersave")
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AfterDeleteTask(ByVal taskId As String, ByVal UserStoryId As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveTask
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Create a task
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   4th-April-2018
        '=====================================================================
        Try

            Dim objProductBacklog As New frmProductBacklog()
            Dim strReturnHTML As New StringBuilder("")
            Dim Restult As String = ""
            Dim strDelete As String = "usp_NG2_del_tbl_PM_ProjectTasksDailyActivity  " & HttpContext.Current.Session("IntProjectId") & "," & taskId & ""
            Restult = CStr(CommonFunction.Data.GetDataScalar(strDelete, True))
            Return New frmProductBacklog().Tasks_section(UserStoryId, "aftersave")
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    Public Function TasksDetails(ByVal userStoryID As String) As String

        Dim strHTML As New StringBuilder()
        Dim strSql As String = ""
        Dim Restult As String = ""
        Dim StrQuery As String = ""
        Dim ScrumTaskName As String = ""
        Dim Effort As String = ""
        Dim AssignedTo As String = ""
        Dim TaskID As String = ""
        Dim StartDate As String = ""
        Dim InitialEstimate As String = ""
        Dim TaskStoryPoint As String = ""
        Dim EndDate As String = ""
        Dim TasksDetailsnew As IDataReader
        StrQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & userStoryID & ",'UserStory'"
        TasksDetailsnew = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        Dim Tasktype As String = ""
        While TasksDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ScrumTaskName = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("ScrumTaskName").ToString, "")
            Effort = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("Effort").ToString, "")
            AssignedTo = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EmployeeID").ToString, "")
            TaskID = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("TaskID").ToString, "")
            InitialEstimate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("InitialEstimate").ToString, "")
            StartDate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StartDate").ToShortDateString(), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate").ToShortDateString(), "")
            'EndDate = CType(CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate"), "").ToShortDateString(),
            TaskStoryPoint = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StoryPoint").ToString, "")
            Tasktype = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EntityTypeID").ToString, "")

            strHTML.Append("<tr class='trProjectDetailedit'>")
            strHTML.Append("<td style='Width:4%;text-align:left;vertical-align:bottom' >")
            ' strHTML.Append("<A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%;cursor: not-allowed;'  data-bs-toggle='tooltip' data-bs-placement='right' title='Click here to add new record'></i></A>")
            strHTML.Append("</td>")
            strHTML.Append("<Td style='width:20%'>")
            ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cborole0", "Usp_App_Sel_tbl_PM_Roles", , , "class='form-control' onchange=ClearSpan('Cborole0','SpanCboPGroup')", False, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName" & TaskID, "txtTaskName" & TaskID, "form-control", 100, 100, ScrumTaskName, , , True, , , , "   title='Task Date' PlaceHolder='Task Name'", True, , , , , , True))
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))


            strHTML.Append("<td style='width:15%'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate" & TaskID, "txtStartDate" & TaskID, "form-control", 100, 100, StartDate, , , True, , , , " PlaceHolder='Start Date'  title='Start Date' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
            strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpstartdate" & TaskID & "' disabled></i>")
            strHTML.Append("</td>")


            'strHTML.Append("<td  style='color:#dd4b39;font-size:16px'>")
            'strHTML.Append("<i id='spanStartDate0' data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>")
            'strHTML.Append("</td>")
            strHTML.Append("<td style='width:15%'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate" & TaskID, "txtEndDate" & TaskID, "form-control", 190, 100, EndDate, , , True, , , , " PlaceHolder='End Date' title='End Date'  onkeyup=ClearSpan('txtEndDate0','spantxtEndDate0')", True, , , , , , True))
            strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpEnddate" & TaskID & "' disabled></i>")
            strHTML.Append("</td>")

            strHTML.Append("<td style='width:13%'>")

            'Commented and Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs" & TaskID, "txtWorkHrs" & TaskID, "form-control", , , Effort, "Center", , True, , , , "style='text-align:center!important' title='Work Hrs' PlaceHolder='Work Hrs' limitText=4", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs" & TaskID, "txtWorkHrs" & TaskID, "form-control", , , Effort, "Center", , True, , , , "style='text-align:center!important' title='Work Hrs' PlaceHolder='Work Hrs' limitText=8", True, , , , , , True))
            'End of Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")

            strHTML.Append("</td>")

            strHTML.Append("<td style='width:13%'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints" & TaskID, "txtStoryPoints" & TaskID, "form-control", , , TaskStoryPoint, "Center", , , , , , "style='text-align:center!important' title='Story Pts' PlaceHolder='Story Pts' limitText=4", True, , , , , , True))
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
            strHTML.Append("</td>")


            strHTML.Append("<td style='width:12%'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType" & TaskID, "usp_Sel_tbl_PM_Project_TaskTypes_Names " & Session("intprojectID") & "", 104, Tasktype, "class='form-control' title='Task Type' style='width:110%!Important' disabled", True, True, , , , ))
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
            strHTML.Append("</td>&nbsp;&nbsp;")


            strHTML.Append("<td style='width:23%'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource" & TaskID, "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 120, AssignedTo, "class='form-control' title='Resource' style='width:100%!Important;margin-left:15%' disabled", True, True, , , , True))
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
            strHTML.Append("</td>")

            Dim strDelete As String = "usp_NG2_del_tbl_PM_ProjectTasks  " & Session("IntProjectId") & "," & TaskID & ""
            Restult = CStr(CommonFunction.Data.GetDataScalar(strDelete, True))

            strHTML.Append("<td style='width:3%;text-align:center'>")
            If TaskID <> "" Then
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4;    margin-left: 55%;' data-bs-placement='bottom'  id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & "," & TaskID & ")'></i>")

            Else
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4;    margin-left: 55%;' data-bs-placement='bottom'  id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & ",0)' disabled></i>")
            End If

            strHTML.Append("</td>")



            strHTML.Append("<td style='width:3%;text-align:center'>")
            If Restult = "1" Then
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red;       margin-left: 42%;' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'  onclick='DeleteTask(" & userStoryID & "," & TaskID & ")' title='Delete Task' class='fa fa-trash' ></i>") '
            Else
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red;        margin-left: 42%;' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='you do not have access to delete Task' class='fa fa-trash' onclick='DeleteTask(" & userStoryID & "," & TaskID & ")' disabled></i>") '
            End If
            strHTML.Append("</td>")


            strHTML.Append("<td style='width:3%;text-align:center;'  id='Update" & TaskID & "'>")
            Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
            If strAddLinkAccess = "1" Then
                strHTML.Append("<i style='font-size:14px!important;text-align:center; margin-left: 26%;'  data-bs-placement='bottom' data-bs-toggle='tooltip'  id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip' title='save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task')""></i>")
            Else
                strHTML.Append("<i style='font-size:14px!important;text-align:center; margin-left: 26%;'  data-bs-placement='bottom' data-bs-toggle='tooltip'  id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip' title='Map Relase and Sprint to Update task ' class='fa fa-save'></i>")

            End If
            'strHTML.Append("<button type='button' id='SaveBtn0' style='width:50px;vertical-align: baseline;' class='btn btn-primary btn-flat' onclick='TaskSave_OnClick()';>Save</button>&nbsp;")
            strHTML.Append("</td>")
            'strHTML.Append("<td style='color:#dd4b39;font-size:16px'>")
            'strHTML.Append("<i id='spanWorkHrs0' data-bs-toggle='tooltip' style='display:none;' title='Error Details' data-bs-toggle='popover' data-bs-placement='left' data-content=''  class='fa fa-info-circle' aria-hidden='true'></i>")
            'strHTML.Append("</td>")
            'strHTML.Append("<td>")
            'strHTML.Append("<a id='errorPopOver0'  style='font-size:15px;display:none' title='Error Details' data-bs-toggle='popover' data-bs-target='#popOverDiv' onmouseover=DataHover(this) data-bs-placement='left' data-content='' class='btn btn-block btn-danger fa fa-check-square-o errorList'></a>")
            'strHTML.Append("</td>")
            strHTML.Append("</tr>")
        End While





        Return strHTML.ToString

    End Function
    Public Function SaveTaskDetails(ByVal AssignTaskData As Object) As String


        Dim strProjectID As String = HttpContext.Current.Session("intprojectid").ToString

        Call GetProjectSettingsDetails(strProjectID, "")
        Dim EmployeeID As String = AssignTaskData(0)("EmployeeID")

        Dim TaskID As String
        Dim TaskName As String
        Dim WorkHrs As String
        Dim StartDate As String
        Dim EndDate As String
        Dim Priority As String
        Dim TaskType As String
        Dim Billable As String
        Dim Hold As String
        Dim PhaseVal As String
        Dim ModuleVal As String
        Dim SubProjectVal As String
        Dim MilestoneVal As String
        Dim ChangeRequestVal As String
        Dim DeliverableVal As String
        Dim PracticeID As String
        Dim UserStoryID As String
        Dim strEntity As String
        Dim StoryPoints As String
        TaskID = AssignTaskData(0)("TaskID")
        TaskName = AssignTaskData(0)("TaskName")
        WorkHrs = AssignTaskData(0)("WorkHrs")
        StartDate = AssignTaskData(0)("StartDate")
        EndDate = AssignTaskData(0)("EndDate")
        Priority = AssignTaskData(0)("Priority")
        TaskType = AssignTaskData(0)("TaskType")
        Billable = AssignTaskData(0)("Billable")
        Hold = AssignTaskData(0)("Hold")
        PhaseVal = AssignTaskData(0)("PhaseVal")
        ModuleVal = AssignTaskData(0)("ModuleVal")
        SubProjectVal = AssignTaskData(0)("SubProjectVal")
        MilestoneVal = AssignTaskData(0)("MilestoneVal")
        ChangeRequestVal = AssignTaskData(0)("ChangeRequestVal")
        DeliverableVal = AssignTaskData(0)("DeliverableVal")
        ''Added By Vidya Jadhav ON 30 Jan 2017
        'For index = 1 To AssignTaskData.

        'Next

        'For Each kvp As KeyValuePair(Of Integer, String) In AssignTaskData(0)
        '    Dim v1 As Integer = kvp.Key
        '    Dim v2 As String = kvp.Value

        'Next

        'For index = 0 To AssignTaskData(0).count - 1
        '    Dim v1 As Integer = AssignTaskData(0)("UserStoryID")
        'Next

        Dim temp As Integer = 0
        Try
            UserStoryID = AssignTaskData(0)("UserStoryID")
            StoryPoints = AssignTaskData(0)("StoryPoints")
        Catch ex As Exception
            temp = 1
        End Try

        'strEntity = AssignTaskData(0)("strEntity")
        'If strEntity <> "Phase" Then
        '    UserStoryID = AssignTaskData(0)("UserStoryID")
        'End If
        ''Added By Vidya Jadhav ON 30 Jan 2017
        PracticeID = HttpContext.Current.Session("ProjectTypeID")

        If EmployeeID <> "" Then
            Dim strQuery As String = ""
            Dim strQuery_1 As String = ""
            Dim strQuery_2 As String = ""
            Dim strTempQuery As String = ""
            Dim arrEmpId() As String
            Dim intNumberOfEmployees As Integer = 0
            Dim strEmployeeNames As String = ""
            Dim strTempName As String = ""
            Dim strSQL As String = ""

            If TaskID > 0 Then
                If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                    '   strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks NULL, " & EmployeeID & "," & TaskID.ToString()
                    strQuery_1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedSubTasks NULL, " & EmployeeID & "," & TaskID.ToString()
                Else
                    ''     strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks " & TaskID.ToString()
                    strQuery_1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedTasks " & TaskID.ToString()
                End If
                blnIsNewTask = False
            Else
                '  strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks NULL"
                strQuery_1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedTasks NULL"
                blnIsNewTask = True
            End If
            strQuery_2 &= ", " & strProjectID.ToString()
            '----------------------
            ' SQL QUERY : PART 2
            '----------------------
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(TaskName) & "'"
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(StartDate) & "'"
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(EndDate) & "'"


            If WorkHrs = "" Then
                strQuery_2 &= ",null"
            Else
                strQuery_2 &= ",'" + WorkHrs + "'"
            End If
            '----------'
            strQuery_2 &= ",'O'"
            '---------'
            If Billable = "1" Then
                strQuery_2 &= ", 1"
            Else
                strQuery_2 &= ", 0"
            End If

            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(TaskName) & "'"
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(TaskType) & "'"

            If StartDate <> "" Then
                strQuery_2 &= ", '" & StartDate.ToString() & "'"
            Else
                strQuery_2 &= ", NULL"
            End If
            If EndDate <> "" Then
                strQuery_2 &= ", '" & EndDate.ToString() & "'"
            Else
                strQuery_2 &= ", NULL"
            End If
            If WorkHrs <> "" Then
                strQuery_2 &= ", " & FormatNumber(WorkHrs, , , , TriState.False)
            Else
                strQuery_2 &= ", NULL"
            End If


            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(Priority) & "'"

            'strSQL = "EXEC Usp_App_Sel_WBSNames " & PhaseVal & "," & ModuleVal & "," & SubProjectVal & "," & MilestoneVal
            'Dim drNames As IDataReader = CommonFunction.Data.GetDataReader(strSQL, True)

            'If drNames.Read Then
            '    m_strPhase = CommonFunction.Data.CheckIsDBNull(drNames("Phase"), "")
            '    m_strModule = CommonFunction.Data.CheckIsDBNull(drNames("Module"), "")
            '    m_strSubProject = CommonFunction.Data.CheckIsDBNull(drNames("Subproject"), "")
            '    m_strMilestone = CommonFunction.Data.CheckIsDBNull(drNames("Milestone"), "")
            'End If

            If PhaseVal > 0 Then
                strQuery_2 &= ", " & PhaseVal.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strPhase) & "'"
            Else
                strQuery_2 &= ", NULL, NULL"
            End If
            If ModuleVal > 0 Then
                strQuery_2 &= ", " & ModuleVal.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strModule) & "'"
            Else
                strQuery_2 &= ", NULL, NULL"
            End If
            If SubProjectVal > 0 Then
                strQuery_2 &= ", " & SubProjectVal.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strSubProject) & "'"
            Else
                strQuery_2 &= ", NULL, NULL"
            End If
            If MilestoneVal > 0 Then
                strQuery_2 &= ", " & MilestoneVal.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strMilestone) & "'"
            Else
                strQuery_2 &= ", NULL, NULL"
            End If

            'ReviewActionId
            '------------------'
            strQuery_2 &= ",null"
            '------------------'

            If ChangeRequestVal > 0 Then
                strQuery_2 &= ", " & ChangeRequestVal.ToString()
            Else
                strQuery_2 &= ", NULL"
            End If


            '-----------Project Feature & Estimation-------'
            strQuery_2 &= ",null"
            strQuery_2 &= ",null"
            '------------------'

            'Deliverable ID
            If DeliverableVal > 0 Then
                strQuery_2 &= ", " & DeliverableVal.ToString()
            Else
                strQuery_2 &= ", NULL"
            End If

            strQuery_2 &= ",null,null,0,1"

            '---Hold----
            If Hold = "1" Then
                strQuery_2 &= ", 1"
            Else
                strQuery_2 &= ", 0"
            End If
            'strQuery_2 &= ",0"
            '---Hold----
            m_strUserName = HttpContext.Current.Session("strUserName")
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"



            If UserStoryID <> "" Or Not UserStoryID Is Nothing Then
                strQuery_2 &= ", 1"
            Else
                strQuery_2 &= ", 0"
            End If


            If UserStoryID <> "" Or Not UserStoryID Is Nothing Then
                strQuery_2 &= ", " & UserStoryID
            Else
                strQuery_2 &= ", NULL"
            End If

            strQuery_2 &= ",NULL"

            strQuery_2 &= "," & StoryPoints
            '---------------------------------------------------------------------------------
            strTempQuery = strQuery_2
            strQuery = strQuery_1 & strTempQuery

            If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
                m_strTaskIDList = m_lngTaskId.ToString() & ", "
                'Insert the SubTasks for each Resource when new Task is created
            ElseIf m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                If blnIsNewTask = True Then
                    arrEmpId = EmployeeID.Split(CType(",", Char))
                    intNumberOfEmployees = arrEmpId.Length()
                    strQuery_2 = strTempQuery
                    strTempQuery = strQuery
                    strEmployeeNames = ""
                    Dim intCtr As Integer = 0
                    For intCtr = 0 To intNumberOfEmployees - 1

                        m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strTempQuery, MyBase.UseSQL), "0"), Long)

                        'Insert the Child Tasks for each employee
                        'strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
                        strQuery_1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
                        strQuery_1 &= ", " & arrEmpId(intCtr)
                        strQuery_1 &= ", NULL"
                        strQuery = strQuery_1 & strQuery_2
                        m_strTaskIDList &= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) & ", "
                    Next
                Else
                    m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
                End If
            End If
        End If

        Return ""

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDropDownValue(ByVal ProjectID As String, ByVal WhichList As String, ByVal Mode As String, ByVal Issue_Type As String)
        Try

            Dim strResult As String = ""
            Dim strResult1 As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim PlotControl As DataTable
            Dim m_strProjectID = ProjectID
            Dim m_strUserID As String
            Dim strHTML As New StringBuilder()
            Dim TypeID As String = ""
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strPlotHtml2 As String = ""
            Dim sbHTML As New StringBuilder()
            Dim strScript As String()

            If WhichList.ToUpper = "REPORTER" Then
                strSQL = "usp_Sel_IB_IssueEntry_EmployeeList ReportedBy ," & ProjectID & "," & HttpContext.Current.Session("intUserID") & ",1, NULL,NULL,E," & Mode & ",0"
            ElseIf WhichList.ToUpper = "ISSUETYPE" Then
                strSQL = "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & ProjectID & ",'T',Null,Null,Null,Null,Null,'" & HttpContext.Current.Session("intpostid") & "'"
                'ElseIf WhichList.ToUpper = "PRIORITY" Then
                '    strSQL = "Exec usp_Sel_tbl_IB_Project_Priorities  " & ProjectID & ""
            ElseIf WhichList.ToUpper = "SUBTYPE" Then
                strSQL = "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & ProjectID & ",'S','" & Issue_Type & "'"
            End If

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)
            strResult = GetSerialized(dtDefectType)

            strHTML.Append(vbCrLf)



            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveReviewDetails(ByVal ReviewID As String, ByVal Reviewtype As String, ByVal Reviewtitle As String, ByVal Reviewer As String, ByVal offline As String, ByVal Reviewee As String, ByVal ReviewPlanned As String, ByVal ReviewPlannedto As String, ByVal RevieweeWork As String, ByVal RevieweeActualfrom As String, ByVal RevieweeActualto As String, ByVal ReviewPhase As String, ByVal Delivariables As String, ByVal ModuleID As String, ByVal defects As String, ByVal per As String, ByVal unit As String, ByVal reviewnote As String, ByVal reviewstatus As String, ByVal billable As String, ByVal workproduct As String, ByVal workproductname As String, ByVal conculsion As String, ByVal Requestor As String, ByVal Coordinator As String, ByVal method As String, ByVal Deviation As String, ByVal Completion As String, ByVal Disposition As String, ByVal Checklist As String, ByVal MileStone As String, ByVal strEntityID As String, ByVal strEntity As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveReviewDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save Review Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   5th April 2018
        '=====================================================================
        Dim insertSuccess As Integer = 0
        Dim strReviewstatsticsProjectID As String = ""
        Dim strUserID As String = HttpContext.Current.Session("intUserID")
        Dim strReviewerName As String = ""
        Dim strRevieweeName As String = ""
        Dim arrEntity As String() = strEntity.Split("_")
        If strUserID IsNot Nothing Then
            If ReviewID = "" Then
                ReviewID = "NULL"
            End If
            If Reviewtype = "" Then
                Reviewtype = "Null"
            End If

            If offline = "" Then
                offline = "NULL"
            End If

            If RevieweeWork = "" Then
                RevieweeWork = "NULL"
            End If
            ''Commented and added by Ankush T on 29 mar 2019 work field changes
            Dim fltRevieweeWork As Decimal

            If RevieweeWork = "0" Or RevieweeWork = "" Then
                RevieweeWork = "00:00"
            End If

            If RevieweeWork.IndexOf(":") = RevieweeWork.Length - 1 Then
                RevieweeWork = RevieweeWork + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = RevieweeWork.Substring(0, RevieweeWork.IndexOf(":"))
            strDecimal = RevieweeWork.Substring(RevieweeWork.IndexOf(":") + 1, 2)
            RevieweeWork = strBeforeDecimal + ":" + strDecimal

            fltRevieweeWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + RevieweeWork + "',2)", True)
            ''Commented and added by Ankush T on 29 mar 2019 work field changes
            If defects = "" Then
                defects = "NULL"
            End If

            If per = "" Then
                per = "NULL"
            End If

            If billable = "" Then
                billable = "NULL"
            End If

            If Delivariables = "" Then
                Delivariables = "NULL"
            End If

            If ModuleID = "" Then
                ModuleID = "NULL"
            End If


            If method = "" Then
                method = "NULL"
            End If

            If Requestor = "" Then
                Requestor = "NULL"
            End If

            If Deviation = "" Then
                Deviation = "NULL"
            End If
            If Completion = "" Then
                Completion = "NULL"
            End If

            If Disposition = "" Then
                Disposition = "NULL"
            End If
            If Checklist = "" Then
                Checklist = "NULL"
            End If

            If ReviewID = "0" Then
                ReviewID = "NULL"
            End If

            If MileStone = "" Then
                MileStone = "NULL"
            End If

            Dim strQueryForUserName As String = "usp_Ng2_Get_UserNamesForReview '" & Reviewee & "','" & Reviewer & "'"
            Dim dtUserName As New DataTable
            dtUserName = CommonFunctions.Data.GetDataTable(strQueryForUserName, True)
            For i As Integer = 0 To dtUserName.Rows.Count - 1
                strReviewerName = CommonFunctions.Data.CheckIsDBNull(dtUserName.Rows(i)("Reviewer"), "")
                strRevieweeName = CommonFunctions.Data.CheckIsDBNull(dtUserName.Rows(i)("Reviewee"), "")
            Next


            ' Dim strQuery As String = " usp_APP_INS_UPD_tbl_PM_ReviewStatistics " & IIf(ReviewID.Replace("'", "''") = "0", "Null", ReviewID.Replace("'", "''")) & "," & ProjectID.Replace("'", "''") & "," & Reviewtype & ",'" & Reviewtitle.Replace("'", "''") & "','" & Reviewer.Replace("'", "''") & "'," & offline.Replace("'", "''") & ",'" & Reviewee.Replace("'", "''") & "','" & ReviewPlanned.Replace("'", "''") & "','" & ReviewPlannedto.Replace("'", "''") & "'," & RevieweeWork.Replace("'", "''") & ",'" & RevieweeActualfrom.Replace("'", "''") & "','" & RevieweeActualto.Replace("'", "''") & "','" & ReviewPhase.Replace("'", "''") & "'," & Delivariables.Replace("'", "''") & "," & ModuleID.Replace("'", "''") & "," & defects.Replace("'", "''") & "," & per.Replace("'", "''") & ",'" & unit.Replace("'", "''") & "','" & reviewnote.Replace("'", "''") & "','" & reviewstatus.Replace("'", "''") & "'," & billable.Replace("'", "''") & ",'" & workproduct.Replace("'", "''") & "','" & workproductname.Replace("'", "''") & "','" & conculsion.Replace("'", "''") & "','" & Requestor.Replace("'", "''") & "','" & Coordinator.Replace("'", "''") & "'," & method.Replace("'", "''") & "," & Deviation.Replace("'", "''") & "," & Completion.Replace("'", "''") & "," & Disposition.Replace("'", "''") & "," & Checklist.Replace("'", "''") & "," & EmployeeID.Replace("'", "''") & ""
            Dim strQuery As String = "  usp_NG2_INS_UPD_tbl_PM_ReviewStatistics " & ReviewID & "," & HttpContext.Current.Session("IntProjectID") & "," & Reviewtype & ",'" & Reviewtitle.Replace("'", "''") & "','" & strReviewerName.Replace("'", "''") & "','" & strRevieweeName.Replace("'", "''") & "','" & ReviewPlanned.Replace("'", "''") & "','" & ReviewPlannedto.Replace("'", "''") & "'," & fltRevieweeWork & ",'" & reviewstatus.Replace("'", "''") & "'," & Checklist.Replace("'", "''") & "," & strEntityID.Replace("'", "''") & ",'UserStory','" & HttpContext.Current.Session("strUserName") & "'"
            'CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            'insertSuccess = "1"

            strReviewstatsticsProjectID = CommonFunction.Data.GetDataScalar(strQuery, True)
            Dim strSQL1 As String = ""
            strSQL1 = "usp_Del_tbl_PM_ReviewStatistics_Reviewers " & strReviewstatsticsProjectID & ",'" & Reviewer & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL1, True)
            Dim strSQLReviwer As String = ""
            strSQLReviwer = "usp_Ins_tbl_PM_ReviewStatistics_Reviewers_New " & strReviewstatsticsProjectID & ",'" & Reviewer & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQLReviwer, True)
            Dim strSQLAuthors As String = ""
            strSQLAuthors = "usp_Del_tbl_PM_ReviewStatistics_Authors " & strReviewstatsticsProjectID & ",'" & Reviewee & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQLAuthors, True)

            Dim strSQLAuthors_New As String = ""
            strSQLAuthors_New = "usp_Ins_tbl_PM_ReviewStatistics_Authors_New " & strReviewstatsticsProjectID & ",'" & Reviewee & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQLAuthors_New, True)



            Dim sqlObservations As String = ""
            sqlObservations = "usp_Upd_tbl_PM_GetReviewObservations " & strReviewstatsticsProjectID & ""
            CommonFunction.Data.InsertOrUpdateData(sqlObservations, True)

            Dim sqlReviewStatistics As String = ""
            sqlReviewStatistics = "usp_Ins_tbl_PM_AssignReviewTasks_ReviewPlanning " & strReviewstatsticsProjectID & "," & HttpContext.Current.Session("intProjectID") & "," & Reviewtype & ",'" & ReviewPlanned.Replace("'", "''") & "','" & Reviewer & "','" & Reviewee & "'," & fltRevieweeWork & ",'" & HttpContext.Current.Session("strUserName") & "'"
            CommonFunction.Data.InsertOrUpdateData(sqlReviewStatistics, True)

            'Dim strSqlForReviewCount As String = "usp_APP_Get_ReviewCountForScrumEntities " & strEntityID & ",'" & arrEntity(0) & "'"
            'Dim dtReviewCount As New DataTable
            'dtReviewCount = CommonFunctions.Data.GetDataTable(strSqlForReviewCount, True)
            'Dim strCount As String = ""
            'If dtReviewCount.Rows.Count > 0 Then
            '    If arrEntity(0) = "Release" Or strEntity = "Iteration_UserStory" Then
            '        strCount = CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("OpenReviews"), 0) & " / " & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ClosedReviews"), 0)

            '    Else
            '        strCount = CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("OpenReviews"), 0) & " / " & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ClosedReviews"), 0) & "||" & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ParentID"), 0) & "||" & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ParentOpenReviews"), 0) & " / " & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ParentClosedReviews"), 0)
            '    End If
            'End If
            Return New frmProductBacklog().WriteGrid("ReviewList", strEntityID, "")
        Else
            Return "Session Expired"
        End If


        'Return PlotResponsivePage(ProjectID, strReviewstatsticsProjectID, "true")


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetSubType(ByVal TypeID As String, ByVal WhichList As String)
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()



            strSQL = "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & HttpContext.Current.Session("intprojectID") & ",'S','" & TypeID & "'"
            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            ' strPlotHtml = GetPlottingScript(ProjectID, HttpContext.Current.Session("intUserID").ToString, TypeID)
            ' strScript = strPlotHtml.Split("|")
            ' strValidation = strScript(1)
            strHTML.Append(vbCrLf)

            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetStatus(ByVal ProjectID As String, ByVal Issue_Type As String)
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()


            Dim StatusIssue As String = "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",'" & Issue_Type & "'," & CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0), Long)
            dtDefectType = CommonFunctions.Data.GetDataTable(StatusIssue, True)
            strResult = GetSerialized(dtDefectType)

            ' strPlotHtml = GetPlottingScript(ProjectID, HttpContext.Current.Session("intUserID").ToString, TypeID)
            ' strScript = strPlotHtml.Split("|")
            ' strValidation = strScript(1)
            strHTML.Append(vbCrLf)

            Return strResult & "|" & strHTML.ToString
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
    Public Shared Function GetDefaultType(ByVal strResult As String)
        Try
            Dim strSQL1 As String = ""
            Dim dtDefectType1 As DataTable
            strSQL1 = "usp_Sel_IB_GetDefault_Type_Status_SubType 'T'," & strResult & ""
            dtDefectType1 = CommonFunctions.Data.GetDataTable(strSQL1, True)
            If dtDefectType1.Rows.Count > 0 Then
                Return CommonFunctions.Data.CheckIsDBNull(dtDefectType1.Rows(0)("Type"), "")
            End If
            Return ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDefaultValues(ByVal strResult As String)
        Try

            Dim strSQL1 As String = ""
            Dim dtDefectType1 As DataTable
            strSQL1 = "usp_Sel_IB_GetDefault_Type_Status_SubType 'S'," & HttpContext.Current.Session("intprojectID") & ", '" + CommonFunction.General.BuildQueryString(strResult.Trim) + "'"
            dtDefectType1 = CommonFunctions.Data.GetDataTable(strSQL1, True)
            If dtDefectType1.Rows.Count > 0 Then
                Return CommonFunctions.Data.CheckIsDBNull(dtDefectType1.Rows(0)("SubType"), "")
            End If
            'Return ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'End of Added By Dipali V On 4th April 2018 For Get Subtype by type onchnage

    Public Function Chart_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divChart' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion'>Chart</h2>")
        strHTML.Append(Graph_US(userStoryID, "UserStory"))
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function Graph_US(ByVal userStoryID As String, ByVal Flag As String) As String

        Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='graph' class='clsBox'>")


        strHTML.Append("<div class='container'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<nav class='col-sm-2' id='myScrollspy'>")
        strHTML.Append("<ul class='nav nav-pills nav-stacked'>")


        strHTML.Append("<li class='active'><a href='#BurnDown'>Burn Down</a></li>") 'onclick=""Tab_onclick(event, 'BurnDown'," & SprintID & ")""
        strHTML.Append("<li><a href='#BurnUp'  >Burn Up</a></li>") 'onclick=""Tab_onclick(event, 'BurnUp'," & SprintID & ")""
        ' strHTML.Append("<li><a href='#Velocity' >Velocity</a></li>") 'onclick=""Tab_onclick(event, 'Velocity'," & SprintID & ")""
        'strHTML.Append("<li><a href='#Flow' >Flow</a></li>") 'onclick=""Tab_onclick(event, 'Flow'," & SprintID & ")""
        'strHTML.Append("<li><a href='#ComSprint' >Com-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CompSprint'," & SprintID & ")""
        'strHTML.Append("<li><a href='#CanSprint' >Can-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CanSprint'," & SprintID & ")""

        strHTML.Append("</ul>")
        strHTML.Append(" </nav>")
        strHTML.Append("<div class='col-sm-9 scrollspy-example' data-spy='scroll' data-bs-target='#myScrollspy' data-offset='5'>")

        strHTML.Append("<div id='BurnDown' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Down</h3>")
        strHTML.Append(PlotBurnDown(userStoryID, Flag, "BurnDown"))
        strHTML.Append("</div>")

        strHTML.Append("<div id='BurnUp' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Up</h3>")
        strHTML.Append(PlotBurnDown(userStoryID, Flag, "BurnUp"))
        strHTML.Append("</div>")



        'strHTML.Append("<div id='Velocity' class='tabcontentChart'>")
        'strHTML.Append("<h3 class='ClsHeaderGraph'>Velocity</h3>")
        'strHTML.Append(PlotBurnDown(userStoryID, Flag, "Velocity"))
        'strHTML.Append("</div>")


        'strHTML.Append("<div id='Flow' class='tabcontentChart'>")
        'strHTML.Append("<h3 class='ClsHeaderGraph'>Flow</h3>")
        'strHTML.Append(PlotBurnDown(SprintID, Flag, "Flow"))
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='ComSprint' class='tabcontentChart'>")
        'strHTML.Append("<h3 class='ClsHeaderGraph'>Com-Sprint</h3>")
        'strHTML.Append(PlotBurnDown(SprintID, Flag, "ComSprint"))
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='CanSprint' class='tabcontentChart'>")
        'strHTML.Append("<h3 class='ClsHeaderGraph'>Can-Sprint</h3>")
        'strHTML.Append(PlotBurnDown(SprintID, Flag, "CancelSprint"))
        'strHTML.Append("</div>")
        strHTML.Append("<br>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")




        ' strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function PlotBurnDown(ByVal userStoryID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder()
        If GraphFlag = "BurnDown" Then
            strHTML.Append("<div class='divLineGraph' style='width:100%;'>") 'height:547px'
            strHTML.Append(GetBurnDownGraph(userStoryID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>") 'float:right;margin-top:-40%;margin-right:-4%'
            strHTML.Append(GetBurnupGraph(userStoryID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "Velocity" Then
            strHTML.Append("<div class='divLineGraph' style='width: 100%;'>") 'height:547px
            strHTML.Append(GetVelocityEffortBarGraph(userStoryID, Flag, GraphFlag))
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            strHTML.Append(GetVelocitySToryPointsBarGraph(userStoryID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "BurnUp" Then
            strHTML.Append("<div class='divLineGraph' style='width: 100%;'>") 'height:547px'
            strHTML.Append(GetBurnupGraphEfforts(userStoryID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            strHTML.Append(GetBurnupGraphStoryPoints(userStoryID, Flag, GraphFlag))
            strHTML.Append("</div>")
            'ElseIf GraphFlag = "Flow" Then
            '    strHTML.Append("<div class='divLineGraph' style='width: 100%;height:126%!important'>")
            '    strHTML.Append(GetFlowGraphEfforts(SprintID, Flag, GraphFlag))
            '    ' strHTML.Append("</div>")
            '    ' strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            '    'strHTML.Append(GetFlowGraphStoryPoints(SprintID, Flag, GraphFlag))
            '    strHTML.Append("</div>")

            'ElseIf GraphFlag = "ComSprint" Then
            '    strHTML.Append("<div class='divLineGraph' style='width: 100%;height:547px'>")
            '    ' strHTML.Append(GetComSprint(SprintID, Flag, GraphFlag))
            '    strHTML.Append("<div id='ComSprintGrid" & SprintID & "' class=''>") 'chart-container

            '    strHTML.Append("</div>")
            '    strHTML.Append("</div>")

            'ElseIf GraphFlag = "CancelSprint" Then
            '    strHTML.Append("<div class='divLineGraph' style='width: 100%;height:547px'>")
            '    strHTML.Append("<div class='' id='CanSprintGrid" & SprintID & "'>") 'chart-container

            '    strHTML.Append("</div>")
            '    strHTML.Append("</div>")
        End If

        Return strHTML.ToString()

    End Function

    Public Function GetBurnDownGraph(ByVal userStoryID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnDown" & userStoryID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function GetBurnupGraph(ByVal userStoryID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnUp" & userStoryID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function

    Public Function GetVelocityEffortBarGraph(ByVal userStoryID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='VelocityEffortBar" & userStoryID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function GetVelocitySToryPointsBarGraph(ByVal userStoryID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='VelocitySToryPoints" & userStoryID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function

    Public Function GetBurnupGraphEfforts(ByVal userStoryID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnupGraphEfforts" & userStoryID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function GetBurnupGraphStoryPoints(ByVal userStoryID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnupGraphStoryPoints" & userStoryID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetUserStoryDetails(ByVal UserStoryId As String)
        Try

            Dim strHTML As New StringBuilder()
            Dim frmBackLog As New frmProductBacklog()
            strHTML.Append("<div id='divUserStories' class='row'>") 'added by Ashwini M On 24-3-2023
            strHTML.Append(frmBackLog.Table_Backlog("", "", UserStoryId))
            'added by Ashwini M on 24-3-2023
            strHTML.Append(frmBackLog.Heading_section(UserStoryId))
            strHTML.Append(frmBackLog.Tab_section())
            strHTML.Append("<div id='divAllUS' class='col-md-12 col-sm-12 col-sm-12'>")
            strHTML.Append("<div id='divUserStroryDetails'>")
            strHTML.Append(frmBackLog.Form_section(UserStoryId))
            strHTML.Append(frmBackLog.Substories_section(UserStoryId))
            strHTML.Append(frmBackLog.Attachment_section(UserStoryId))
            strHTML.Append(frmBackLog.Discussion_section(UserStoryId))
            strHTML.Append(frmBackLog.Resource_section(UserStoryId))
            strHTML.Append(frmBackLog.History_section(UserStoryId))
            strHTML.Append(frmBackLog.Issues_section(UserStoryId))
            strHTML.Append(frmBackLog.Reviews_section(UserStoryId))
            'strHTML.Append(frmBackLog.Tasks_section(UserStoryId, ""))
            strHTML.Append(frmBackLog.Chart_section(UserStoryId))
            'End Of added by Ashwini M On 24-3-2023
            strHTML.Append("</div>")
            'commented by Ashwini M on 24-3-2023
            'strHTML.Append(frmBackLog.Heading_section(UserStoryId))
            'strHTML.Append(frmBackLog.Tab_section())
            'strHTML.Append("<div id='divAllUS' class='col-md-12 col-sm-12 col-sm-12'>")
            'strHTML.Append("<div id='divUserStroryDetails'>")
            'strHTML.Append(frmBackLog.Form_section(UserStoryId))
            'strHTML.Append(frmBackLog.Substories_section(UserStoryId))
            'strHTML.Append(frmBackLog.Attachment_section(UserStoryId))
            'strHTML.Append(frmBackLog.Discussion_section(UserStoryId))
            'strHTML.Append(frmBackLog.Resource_section(UserStoryId))
            'strHTML.Append(frmBackLog.History_section(UserStoryId))
            'strHTML.Append(frmBackLog.Issues_section(UserStoryId))
            'strHTML.Append(frmBackLog.Reviews_section(UserStoryId))
            ''strHTML.Append(frmBackLog.Tasks_section(UserStoryId, ""))
            'strHTML.Append(frmBackLog.Chart_section(UserStoryId))
            'End Of commented by Ashwini M On 24-3-2023
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            globalUSID1 = UserStoryId
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetBurnUpStoryPoint(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnUpChart_StoryPoint " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetGraphDetails(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnDownChart " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetGraphDetailsStoryPoint(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnDownChart_StoryPoint " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function






    <System.Web.Services.WebMethod()>
    Public Shared Function GetGetBurnUpChartGraphDetails(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnUpChart " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetVelocityData(ByVal strGraphFilter As String, ByVal UniqueID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            strGraphSQL = "usp_NG2_GET_VelocityGraphAsperStory " & UniqueID & "," & HttpContext.Current.Session("IntProjectID") & ",'" & strGraphFilter & "'"


            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeCategory(ByVal strCategoryID As String, ByVal strUserStoryID As String, ByVal strUserStoryIDs As String)

        Try
            Dim strSql As String = "usp_NG2_upd_tbl_PM_ScrumUserStory " & strCategoryID & "," & strUserStoryID & ",'" & strUserStoryIDs & "'," & HttpContext.Current.Session("intProjectID")
            CommonFunctions.Data.InsertOrUpdateData(strSql, True)
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveView(ByVal SelectedCheckboxValues As String, ByVal DefaultView As String)
        '=====================================================================
        ' Procedure  Name		:	SaveView
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Add Column Dynamically And save
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				    Vaijat K
        ' Created				:   23/02/2018
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim strResultConfigField As String = ""
            Dim strSQLConfigField As String = ""


            If DefaultView = "YES" Then
                SelectedCheckboxValues = "UserStoryName,Description,Priority,InitialEstimate" 'Complexity,InitialEstimate,UserStoryName
                strSQL = "usp_NG2_INS_AttributesToShowForUserStory " & HttpContext.Current.Session("intUserID") & ",'" & SelectedCheckboxValues & "'"
            Else
                strSQL = "usp_NG2_INS_AttributesToShowForUserStory " & HttpContext.Current.Session("intUserID") & ",'" & SelectedCheckboxValues & "'"
            End If
            strResultConfigField = CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            Return strResultConfigField
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    '<System.Web.Services.WebMethod()>
    'Public Shared Function GetColorMaster(ByVal Id As String, ByVal strMode As String)
    '    Dim StrColorQuery As String = ""
    '    StrColorQuery = "EXEC usp_Ng2_sel_tbl_NG2_ColorMaster"
    '    Dim intColorID As Integer
    '    Dim strColor As String
    '    Dim drGetColorMaster As IDataReader
    '    Dim strHTML As New StringBuilder
    '    drGetColorMaster = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
    '    While drGetColorMaster.Read
    '        intColorID = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("ColorID").ToString, "")
    '        strColor = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("Color").ToString, "")
    '        strHTML.Append("<td style='padding:7px!important;'>")
    '        strHTML.Append("<a onclick=ChangeColor('" & Id & "','" & strColor & "','" & strMode & "') value=" & intColorID & "><i style='cursor:pointer;color:" & strColor & "!important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '        strHTML.Append("</td>")

    '    End While



    '    Return strHTML.ToString
    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetColorMaster(ByVal Id As String, ByVal strMode As String)
        Try

            Dim StrColorQuery As String = ""
            StrColorQuery = "EXEC usp_Ng2_sel_tbl_NG2_ColorMaster"
            Dim intColorID As Integer
            Dim strColor As String
            Dim drGetColorMaster As IDataReader
            Dim index As Integer = 0
            Dim strHTML As New StringBuilder
            drGetColorMaster = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            strHTML.Append("<tr>")
            While drGetColorMaster.Read
                intColorID = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("ColorID").ToString, "")
                strColor = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("Color").ToString, "")
                index = index + 1
                strHTML.Append("<td style='padding:7px!important;'>")
                strHTML.Append("<a onclick=ChangeColor('" & Id & "','" & strColor & "','" & strMode & "') value=" & intColorID & "><i style='cursor:pointer;color:" & strColor & "!important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                strHTML.Append("</td>")
                If index = 15 Then
                    strHTML.Append("</tr>")
                    strHTML.Append("<tr>")
                    index = 0
                End If


            End While
            strHTML.Append("</tr>")


            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetExistingUniqueNumberFromDB(ByVal objComplexity As String, ByVal Priority As String, ByVal strUserStoryId As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetExistingUniqueNumberFromDB
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None

        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   22-Feb-2017
        '=====================================================================
        Try


            If strUserStoryId = "" Then
                strUserStoryId = "NULL"
            End If

            'If strUserStoryId = "0" Then
            '    strUserStoryId = "NULL"
            'End If
            Dim StrQuery As String = ""
            'added By Dipali V On 8th may For Sub Us Rank duplication
            If strUserStoryId = 0 Then
                StrQuery = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & Priority & ", '" & objComplexity & "'," & strUserStoryId & ""
            Else
                StrQuery = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & Priority & ", '" & objComplexity & "',NULL," & strUserStoryId & ""
                ' StrQuery = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & Priority & ", '" & objComplexity & "'," & strUserStoryId & ""

            End If
            'end of added By Dipali V On 8th may For Sub Us Rank duplication
            Dim intUniqueNo As String = ""

            Dim drGetUniqueNo As IDataReader
            Dim strHTML As New StringBuilder
            drGetUniqueNo = CommonFunctions.Data.GetDataReader(StrQuery, True)
            While drGetUniqueNo.Read
                intUniqueNo = CommonFunctions.Data.CheckIsDBNull(drGetUniqueNo("Result").ToString, "")
            End While

            Return intUniqueNo
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveUserStory(ByVal strUserStoryId As String, ByVal FunctionalNumber As String, ByVal FeatureName As String, ByVal UserDesc As String, ByVal Priority As String, ByVal Complexity As String, ByVal BusinessValue As String, ByVal State As String, ByVal StoryPoint As String, ByVal Category As String, ByVal Version As String, ByVal IterationName As String, ByVal ReleaseName As String, ByVal FixedVersion As String, ByVal AcceptanceCriteria As String, ByVal UniqueNo As String) As String

        '=====================================================================
        ' Procedure  Name		:	SaveUserStory
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save User Story
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   28th Dec 2016
        '=====================================================================
        Dim insertSuccess As Integer = 0

        Dim strUserID As String = HttpContext.Current.Session("intUserID")
        Dim intProjectId As Integer = HttpContext.Current.Session("intProjectID")
        Dim intProjectTypeId As Integer = HttpContext.Current.Session("ProjectTypeID")
        Dim strUserName As String = HttpContext.Current.Session("strUserName")


        Dim strUniqueID As String
        'Dim strUserStoryId As String

        Try
            If strUserID IsNot Nothing Then
                If strUserStoryId = "" Then
                    strUserStoryId = "NULL"
                End If
                If FunctionalNumber = "" Then
                    FunctionalNumber = "NULL"
                End If
                If BusinessValue = "" Then
                    BusinessValue = "NULL"
                End If
                If State = "" Then
                    State = "NULL"
                End If
                If StoryPoint = "" Then
                    StoryPoint = "NULL"
                End If
                If Category = "" Then
                    Category = "NULL"
                End If
                If Version = "" Then
                    Version = "NULL"
                End If
                If IterationName = "" Then
                    IterationName = "NULL"
                End If
                If ReleaseName = "" Then
                    ReleaseName = "NULL"
                End If
                If FixedVersion = "" Then
                    FixedVersion = "0"
                End If

                Dim strQuery As String = "usp_NG2_INS_tbl_PM_ScrumUserStory " & strUserStoryId & "," & intProjectId & ",'" & FunctionalNumber.Replace("'", "''") & "','" & FeatureName.Replace("'", "''") & "','" & UserDesc.Replace("'", "''") & "','" & BusinessValue.Replace("'", "''") & "','" & Priority.Replace("'", "''") & "','" & State & "','" & Complexity & "'," & StoryPoint & "," & Category & "," & Version & "," & IterationName & "," & ReleaseName & ",'" & strUserName & "','" & AcceptanceCriteria.Replace("'", "''") & "'," & FixedVersion & ",'" & UniqueNo & "'"
                strUniqueID = CommonFunctions.Data.GetDataScalar(strQuery, True)
                insertSuccess = strUniqueID
                'If strUserStoryId = "Null" Then
                Return insertSuccess
                'Else
                '    Return RefreshGrid(strUserStoryId)
                'End If

            Else
                Return "Session Expired"
            End If

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveUSIssue(ByVal UserStoryId As String, ByVal Summary As String, ByVal Description As String, ByVal IssueType As String, ByVal SubIssueType As String, ByVal reporter As String, ByVal Resonsible As String, ByVal Status As String) As String

        '=====================================================================
        ' Procedure  Name		:	SaveUSIssue
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save SaveUSIssue
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   4th April 2018
        '=====================================================================
        Dim insertSuccess As Integer = 0
        Dim strUserID As String = HttpContext.Current.Session("intUserID")
        Dim intProjectId As Integer = HttpContext.Current.Session("intProjectID")
        Dim intProjectTypeId As Integer = HttpContext.Current.Session("ProjectTypeID")
        Dim strUserName As String = HttpContext.Current.Session("strUserName")


        Dim strUniqueID As String
        'Dim strUserStoryId As String

        Try
            If strUserID IsNot Nothing Then
                If Summary = "" Then
                    Summary = "NULL"
                End If
                If Description = "" Then
                    Description = "NULL"
                End If
                If IssueType = "" Then
                    IssueType = "NULL"
                End If
                If SubIssueType = "" Then
                    SubIssueType = "NULL"
                End If
                If reporter = "" Then
                    reporter = "NULL"
                End If
                If Resonsible = "" Then
                    Resonsible = "NULL"
                End If
                If Status = "" Then
                    Status = "NULL"
                End If

                Dim strQuery As String = "usp_NG2_Ins_tbl_IB_Issue " & intProjectId & ",'" & Summary.Replace("'", "''") & "','" & Description.Replace("'", "''") & "','" & IssueType & "','" & SubIssueType & "','" & Status & "','" & reporter & "'," & Resonsible & ",'" & strUserName & "'," & UserStoryId & ""
                strUniqueID = CommonFunctions.Data.GetDataScalar(strQuery, True)
                insertSuccess = strUniqueID
                'If strUserStoryId = "Null" Then
                Return New frmProductBacklog().WriteGrid("IssueList", UserStoryId, "")

                'Else
                '    Return RefreshGrid(strUserStoryId)
                'End If

            Else
                Return "Session Expired"
            End If
            Return "0"
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEntryValidation(ByVal UserStoryID As String, ByVal USID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   4-JAN-2017
        '=====================================================================
        Try

            Dim ValidationResponseText As New StringBuilder
            ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
            Dim strQuery As String
            Dim strMessage As String = ""
            strQuery = "Exec usp_ScrumEntityDeleteValidationNew 'UserStory','" + UserStoryID + "'"
            Dim drEntityValidation As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
            If (drEntityValidation.HasRows) Then
                While (drEntityValidation.Read())
                    ValidationResponseText.Append(drEntityValidation(0).ToString())
                End While
            Else
            End If
            Return ValidationResponseText.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function FilterData(ByVal strEntityID As String, ByVal strEntity As String)
        Try

            Dim objBacklog As New frmProductBacklog
            Return objBacklog.Table_Backlog(strEntityID, strEntity, "")
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEntry(ByVal UserStoryID As String, ByVal Flag As String, ByVal USID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   4-JAN-2017
        '=====================================================================
        Try

            Dim strQuery As String = "usp_Del_ScrumEntity 'UserStory','" + UserStoryID + "'"
            Dim strDelete As String = CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            Dim objBacklog As New frmProductBacklog
            'strHTML.Append(frmReleasePlanning.PlotSubUserStoryList(UserStoryID))
            If (Flag = "SubUS") Then
                Return New frmProductBacklog().PlotSubUserStoryList(USID)
            Else
                Return RefreshGrid(USID)
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshGrid(ByVal UserStoryID As String) As String
        Try

            Dim objBacklog As New frmProductBacklog

            Return objBacklog.PlotGrid()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function MoveCategory(ByVal CateGoryID As String, ByVal strFlag As String) As String
        Try

            Dim strSql As String = "usp_NG2_INS_tbl_NG2_ProjectLevel_ScrumCategory_UserOrder " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & CateGoryID & ",Null,2," & strFlag & ""
            CommonFunctions.Data.InsertOrUpdateData(strSql, True)
            Return New frmProductBacklog().PlotGrid()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function FilterPlotGrid(ByVal Flag As String, ByVal Value As String) As String
        Try

            Dim objBacklog As New frmProductBacklog
            Return objBacklog.PlotGrid(Flag, Value)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    'Added By Ankush T on 22 May 2018 for Excelupload
    <System.Web.Services.WebMethod()>
    Public Shared Function ExcelUploadMapped(ByVal Flag As String, ByVal From As String) As String
        Try

            Dim strHTML As New StringBuilder()
            Dim objUploadExcel As New UploadExcel()

            strHTML.Append(objUploadExcel.ExcelUploadNew("", "", ""))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExcelUploadMappedProcess(ByVal Flag As String, ByVal From As String, ByVal flag2 As String) As String
        Try

            Dim strHTML As New StringBuilder()
            Dim objUploadExcel As New UploadExcel()

            strHTML.Append(objUploadExcel.ExcelUploadNew("", "", "afterprocess"))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExcelUploadBackProcess(ByVal Flag As String, ByVal From As String, ByVal flag2 As String) As String

        Try
            Dim strHTML As New StringBuilder()
            Dim objUploadExcel As New UploadExcel()

            strHTML.Append(objUploadExcel.ExcelUploadNew("Upload", "Back", "afterprocess"))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExcelUploadBack(ByVal Flag As String, ByVal From As String) As String
        Try

            Dim strHTML As New StringBuilder()
            Dim objUploadExcel As New UploadExcel()

            strHTML.Append(objUploadExcel.ExcelUploadNew("Upload", "Back", ""))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'End of Added By Ankush T on 22 May 2018 for Excelupload

    <System.Web.Services.WebMethod()>
    Public Shared Function AddUserStoryModal(ByVal CategoryID As String, ByVal type As String) 'added By Dipali V On 2nd April 2018 For Sprint & Release Code integration

        Try
            Dim objProduct As New frmProductBacklog
            'Dim objfrmReleasePlanning As New frmReleasePlanning
            objProduct.GetAccessRights()
            Dim strHTML As New StringBuilder()
            If type = "User" Then
                'Added by kashish On 4nd April 2018 For UI change 
                strHTML.Append("<div class='modal-header'>")

                strHTML.Append("<button type='button' class='close' data-dismiss='modal' onclick='RefreshGrid()'>&times;</button>")
                strHTML.Append(" <h5 class='modal-title' style='color: maroon;' id='HeaderCreate'>Create User Story</h5>")



                strHTML.Append(" </div>")
                strHTML.Append("<div class='modal-body'>")
                strHTML.Append("<div class='divBody'>")
                'strHTML.Append("<div class='col-sm-12 float-end'>")
                'strHTML.Append("<h3 style='color:#ddd;font-size:100!important;'>Add Userstory</h3>")
                ''If objProduct.m_objAccess.Add Then
                ''    strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
                ''End If
                'strHTML.Append("<button type='button' class='close' data-dismiss='modal' onclick='RefreshGrid()'>&times;</button>")
                'strHTML.Append("</div>")
                'strHTML.Append("<hr />")
                strHTML.Append(objProduct.Form_section("0", CategoryID))

                strHTML.Append("<div class='col-md-12 align-center' style='margin-bottom: 20px;text-align:right;display:block'>")
                If objProduct.m_objAccess.Add Then
                    strHTML.Append(" <button type='button' class='btn btn-info' onclick='SaveNew_UserStory()' id='addUser' title='' data-bs-toggle='tooltip' data-bs-original-title='Save'>Save</button>")
                End If
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                'Added by kashish On 4nd April 2018 For UI change 
                'End of Added by kashish  4nd April 2018 For UI change 
                'Added by Dipali V On 2nd April 2018 For Sprint & Release Creation 
            ElseIf type = "Sprint" Then
                strHTML.Append(objProduct.sprint_form("", "", "", "", "", "", "", ""))
            ElseIf type = "Release" Then
                strHTML.Append(objProduct.Release_form("", "", "", "", "", "", ""))
                'Commented By Ankush T on 22/05/2018 for Excel upload
                'ElseIf type = "ExcelUpload" Then
                '    strHTML.Append(objProduct.ExcelUpload_form())
                'End of Commented By Ankush T on 22/05/2018 for Excel upload
                'Added By Ankush T 25 May 2018 for steps excel upload
            ElseIf type = "ExcelUploadNew" Then
                Dim objUploadExcel As New UploadExcel()
                strHTML.Append(objUploadExcel.ExcelUploadNew("Upload", "", ""))
                'End of Added By Ankush T 25 May 2018 for steps excel upload

            End If
            'End of Added by Dipali V On 2nd April 2018 For Sprint & Release Creation 

            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Private Function ExcelUpload_form() As String
        '***********************************************************************************
        'Created By : Nikhil A.
        'Created Date : 5-April-2018
        'Purpose : Excel Upload Div on Product Backlog Page.
        '***********************************************************************************



        Dim strHTML As New StringBuilder()


        'strHTML.Append("<Div class='modal-dialog' >")
        'strHTML.Append("<Div class='modal-content' style='width:700px;'>")

        'strHTML.Append("<Div class='modal-header'>")

        'strHTML.Append("<TABLE id='tblExcelUploadHeader' class='clsfullWidth'>")
        'strHTML.Append("<TR>")

        'strHTML.Append("<TD style='text-align:left;'>")
        'strHTML.Append("<Label style='font-size:20px;'>Product Backlog Excel Upload</Label>")
        'strHTML.Append("</TD>")

        'strHTML.Append("<TD style='vertical-align:top;'>")
        'strHTML.Append("<a class='close' data-dismiss='modal' ><i class='fa fa-close'></i></a>")
        'strHTML.Append("</TD>")

        'strHTML.Append("</TR>")
        'strHTML.Append("</TABLE>")

        'strHTML.Append("</Div>")

        'strHTML.Append("<Div id='excelUploadBody' class='modal-body'>")

        Dim strSQLQuery As String
        Dim drAttach As IDataReader
        Dim strOriginalFileName As String = ""
        Dim strSystemFileName As String = ""

        strSQLQuery = "Usp_NG2_Sel_tbl_PM_PBAttachments_LatestUploadedFile " & Session("intProjectID")
        drAttach = CommonFunctions.Data.GetDataReader(strSQLQuery, True)

        If drAttach.Read Then
            strOriginalFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drAttach("OriginalFileName"), ""))
            strSystemFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drAttach("SystemFileName"), ""))
        End If
        'Added by kashish for Ui change
        strHTML.Append("<Div class='panel-heading'>Note : Configure below excel columns corresponding to product backlog fields.</Div>")
        'End of Added by kashish for Ui change

        strHTML.Append("<div class='container' style='margin-top:2%'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='' >")  'col-sm-3 col-md-3'>
        strHTML.Append("<div class='panel-group' id='accordion'>")
        strHTML.Append("<div class='panel panel-default'>") 'panel-default 1
        strHTML.Append("<div class='panel-heading'>")
        strHTML.Append("<h4 class='panel-title' style='display:inline;margin-left:2%'>")
        strHTML.Append("<a data-bs-toggle='collapse'  href='#collapseOne'><span class='fas fa-cog'>") 'data-parent='#accordion'

        Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("~/Attachments/Product_Backlog"), strSystemFileName)

        If strOriginalFileName = "" Then
            strHTML.Append("</span>&nbsp; Field Configuration </a><a href=#  onclick=""DownloadFile('" & fileSavePath & "')"" title='Latest Uploaded File'   ><label style='cursor:pointer;' > &nbsp;" & strOriginalFileName & "<small>(No File Uploaded yet )</small></label></a>")
        Else
            strHTML.Append("</span>&nbsp; Field Configuration </a><a href=#  onclick=""DownloadFile('" & fileSavePath & "')"" title='Latest Uploaded File'   ><label style='cursor:pointer;' > &nbsp;" & strOriginalFileName & "<small>(Latest Uploaded File )</small></label></a>")
        End If
        If strOriginalFileName <> "" Then
            strHTML.Append("<input type='hidden' value='1' id='hdnCheckFileExistornot' />")
        Else
            strHTML.Append("<input type='hidden' value='0' id='hdnCheckFileExistornot' />")
        End If


        strHTML.Append(" </h4>")

        'strHTML.Append("<a href=# id='faUpload' onclick='UploadFile_Click(this);' data-bs-toggle='tooltip' title='Upload' style='display:inline;float:right;'  ><i class='fa fa-upload' ></i></a>")
        strHTML.Append("<a href=# id='faClear' onclick='ClearConfiguration(this);'  data-bs-placement='left' data-bs-toggle='tooltip' title='Clear Configuration' style='display:inline;float:right;margin-left:5px;'  ><i class='fa fa-eraser' ></i></a>")
        strHTML.Append("<a href=# id='faSave' onclick='SaveConfiguration(this);'  data-bs-placement='left' data-bs-toggle='tooltip' title='Save Configuration' style='display:inline;float:right;'  ><i class='fa fa-save' ></i></a>")

        strHTML.Append(" </div>")
        strHTML.Append("<div id='collapseOne' class='panel-collapse collapse in'>")
        strHTML.Append("<div class='panel-body'>")

        strHTML.Append("<table class='table' id='tblFieldList' >")
        strHTML.Append("<tbody>")

        Dim arrColCaptions() As String = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"}
        Dim strFieldQuery As String = "Usp_NG2_Sel_tbl_PM_PBSExcelUpload_Fields " & Session("intProjectID")
        Dim drReader As IDataReader
        Dim strFieldValue As String = ""
        Dim k As Integer = 1
        Dim dtTable As DataTable
        Dim strExcelFieldName As String
        Dim dr() As DataRow

        'drReader = CommonFunctions.Data.GetDataReader(strFieldQuery, True)
        dtTable = CommonFunctions.Data.GetDataTable(strFieldQuery, True)



        'While drReader.Read
        For k = 1 To 12 Step 1
            If (k = 1 Or k = 3 Or k = 5 Or k = 7 Or k = 9 Or k = 11) Then
                strHTML.Append("<tr>")
            End If
            dr = dtTable.Select("ExcelFieldName = '" & arrColCaptions(k - 1) & "'")

            If dr.Length <> 0 Then
                strFieldValue = CommonFunctions.Data.CheckIsDBNull(dr(0)("PBFieldName"), "")
                strExcelFieldName = CommonFunctions.Data.CheckIsDBNull(dr(0)("ExcelFieldName"), "")
            Else
                strFieldValue = ""
                strExcelFieldName = arrColCaptions(k - 1)
            End If


            strHTML.Append("<td style='vertical-align:middle;white-space:nowrap;'>")
            strHTML.Append("<label id='lblField_" & k & "' > ExcelColumn-" & arrColCaptions(k - 1) & " </label>")
            strHTML.Append("</td>")
            strHTML.Append("<td style='vertical-align:middle;'>")


            If strFieldValue = "Priority" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUSField_" & k, "Usp_NG2_Sel_tbl_PM_PBScrumFields", 180, strFieldValue, "onchange='USField_OnChange(" & k & ")' class='form-control clsBorderRed' ", True, True))
                'strHTML.Append("<span id='spnUSField_" & k & "' class='clsSpanColor' >Priority should be in 'Must Have','Should Have','Could Have','Wont Have' only in excel </span>")
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUSField_" & k, "Usp_NG2_Sel_tbl_PM_PBScrumFields", 180, strFieldValue, "onchange='USField_OnChange(" & k & ")' class='form-control'", True, True))
                strHTML.Append("<span id='spnUSField_" & k & "' class='clsSpanColor' ></span>")
            End If

            strHTML.Append("</td>")

            If (k = 2 Or k = 4 Or k = 6 Or k = 8 Or k = 10 Or k = 12) Then
                strHTML.Append("</tr>")
            End If
        Next


        strHTML.Append("<tr>")
        strHTML.Append("<td colspan=4 >")
        strHTML.Append("<span id='spnCommonAlert' class='clsSpanColor' ></span>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")

        strHTML.Append("</tbody>")
        strHTML.Append("</table>")

        strHTML.Append("</Div>") 'End Panel Body
        strHTML.Append("</Div>") 'End collapseOne
        strHTML.Append("</Div>") 'End panel-default 1

        strHTML.Append("<div class='panel panel-default'>") 'panel-default 2
        strHTML.Append("<div class='panel-heading'>")

        strHTML.Append("<Div>")
        strHTML.Append("<h4 class='panel-title' style='display:inline;' >")
        strHTML.Append("<a data-bs-toggle='collapse'  href='#collapseTwo'><span class='fa fa-file-excel-o'>") 'data-parent='#accordion'
        strHTML.Append("</span>&nbsp; Excel File Upload</a>")
        strHTML.Append(" </h4>")

        'strHTML.Append("<a href=# id='faUpload' onclick='ProcessFile_Click(this);' data-bs-toggle='tooltip' title='Process File' style='display:inline;float:right;'  ><i class='fa fa-upload' ></i></a>")
        strHTML.Append("</Div>")

        strHTML.Append(" </div>")

        strHTML.Append("<div id='collapseTwo' class='panel-collapse collapse in'>")
        strHTML.Append("<div class='panel-body'>")

        'strHTML.Append("<label class='control-label'>Select File :</label>")
        'strHTML.Append("<input id='fileUpload' type='file' class='file'>")

        strHTML.Append("<div class='dropzone' id='divDropZone' ><div class='dz-message needsclick'>Drop file to attach or <span style='cursor:pointer;' ><u onclick='ExcelUploadonclick()'>Click to upload</u></span><br></div></div>")
        strHTML.Append("<input type='file' onchange='' name='fileUpload' id='fileUpload' style='display:none'  />")

        'strHTML.Append("<label  id='btnFile' class='btn btn-default btn-file'>")
        'strHTML.Append("Browse <input type='file' style='display: none;'>")
        'strHTML.Append("</label>")

        strHTML.Append("</Div>") 'End Panel Body

        strHTML.Append("<div class='panel-body clsProcessButton' >")
        strHTML.Append("<button type='button' onclick='ProcessFile_Click(this);' data-bs-toggle='tooltip' title='Process File To Validate' class='btn btn-primary mr-auto'>Process File</button>")
        strHTML.Append("</Div>")

        strHTML.Append("</Div>") 'End collapseTwo

        strHTML.Append("</Div>") 'End panel-default 2

        strHTML.Append("</Div></Div></Div></Div>") 'End accordian to container



        'strHTML.Append("<Div  id='modalFooter' class='modal-footer'>") ''modal-footer
        'strHTML.Append("<button type='button' onclick='UploadFile_Click(this);' data-bs-toggle='tooltip' title='Upload Data' class='btn btn-primary mr-auto'>Upload Data</button>")
        'strHTML.Append("<button type='button' class='btn btn-secondary' data-bs-toggle='tooltip' title='Cancel Upload' data-dismiss='modal'>Cancel</button>")
        'strHTML.Append("</Div>") 'modal-footer
        'strHTML.Append("</Div>") 'End of modal-body

        'strHTML.Append("</Div>") 'End of Modal-content
        'strHTML.Append("</Div>") 'End of modal-dialog

        Return strHTML.ToString

    End Function
    Public Function sprint_form(Optional SprintID As String = "", Optional Sprintname As String = "", Optional Description As String = "", Optional SprintStartDate As String = "", Optional SprintEndDate As String = "", Optional SprintDuration As String = "", Optional SprintVelocity As String = "", Optional BusinessDuration As String = "") As String
        '=====================================================================
        ' Procedure Name        :	sprint_form
        ' Purpose               :	sprint_form
        ' Description           :	Open Sprint
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	9h-March-2018
        ' Revisions             :
        '=====================================================================


        Dim strHTML As New StringBuilder()
        Dim Disabled As String = ""

        ' strHTML.Append(" <form class='details_form'>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Sprint Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-10'>")



        If Sprintname = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sprintname", "Sprintname", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('Sprintname','spanSprintname')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sprintname", "Sprintname", "form-control", 190, 100, Sprintname, , , , IIf(Sprintname = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('Sprintname','spanSprintname')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Description</label> ")
        strHTML.Append(" <div class='col-sm-10'>")
        If Description = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionSprint", "txtDescriptionSprint", , "form-control", , , , , , , 1000, , , , , , , , "onkeyup='javascript:Maxlength(this,countdownSprint,1000,""Sprint"")' onKeyUp='javascript:Maxlength(this,countdownSprint, 1000,""Sprint"")'onchange=ClearSpan('txtDescriptionSprint','spantxtDescriptionSprint') data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append("<p  id='countdownSprint' style='float: right;margin-top: -29px;margin-right: -15px; margin-right: -30px;'>1000</p>")
        Else
            Dim len As Integer = 1000
            Dim len1 As Integer
            If Description.Length <> -1 Then
                len1 = Description.Length
                len = 1000 - len1
            End If
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionSprint", "txtDescriptionSprint", , "form-control", , , , , , , len, Description, , , , IIf(Description = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup='javascript:limitText(this,countdownSprint,1000,""Sprint"")' onKeyUp='javascript:limitText(this,countdownSprint, 1000,""Sprint"")'onchange=ClearSpan('txtDescriptionSprint','spantxtDescriptionSprint') data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append("<p  id='countdownSprint' style='float: right;margin-top: -29px;margin-right: -15px;'>" & len & "</p>")

        End If
        'strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style=' font-size: 7px;  margin-top: 17px;color:red;'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='col-sm-6'>")
        strHTML.Append(" <label class='col-sm-4 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-8'>")


        If strIsPrductOwner = 1 Then
            Disabled = "True"
        Else
            Disabled = "False"
        End If
        If SprintStartDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintStartdate", "SprintStartdate", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('SprintStartdate','spanSprintStartdate') onclick=$('#SprintStartdate').datepicker();$('#SprintStartdate').datepicker('show');", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintStartdate", "SprintStartdate", "form-control", 190, 100, SprintStartDate, , , , IIf(SprintStartDate = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('SprintStartdate','spanSprintStartdate')", True, , , , , , True))
        End If
        strHTML.Append("<i class='fa fa-calendar-check-o' style='float: right;margin-top: -25px;color:#0099CC;' onclick=$('#SprintStartdate').datepicker();$('#SprintStartdate').datepicker('show');></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-sm-6'>")
        strHTML.Append(" <label class='col-sm-4 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-8'>")

        If SprintEndDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintEnddate", "SprintEnddate", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('SprintEnddate','spanSprintEnddate') onclick=$('#SprintEnddate').datepicker();$('#SprintEnddate').datepicker('show');", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintEnddate", "SprintEnddate", "form-control", 190, 100, SprintEndDate, , , , IIf(SprintEndDate = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('SprintEnddate','spanSprintEnddate')", True, , , , , , True))
        End If
        strHTML.Append("<i class='fa fa-calendar-check-o' style='float: right;margin-top: -25px;color:#0099CC;' onclick=$('#SprintEnddate').datepicker();$('#SprintEnddate').datepicker('show');></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='col-sm-6'>")
        strHTML.Append(" <label class='col-sm-4 control-label' style='white-space: nowrap;'>Calendar Day's</label> ")
        strHTML.Append(" <div class='col-sm-8'>")

        If SprintDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCalendar", "txtCalendar", "form-control", 190, 100, , , , , True, , , "onkeyup=ClearSpan('txtCalendar','spantxtCalendar')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCalendar", "txtCalendar", "form-control", 190, 100, SprintDuration, , , , IIf(SprintDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtCalendar','spantxtCalendar')", True, , , , , , True))
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append(" <div class='col-sm-6'>")
        strHTML.Append(" <label class='col-sm-4 control-label' style='white-space: nowrap;'>Business Day's</label> ")
        strHTML.Append(" <div class='col-sm-8'>")
        If BusinessDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusiness", "txtBusiness", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtBusiness','spantxtBusiness')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusiness", "txtBusiness", "form-control", , 100, BusinessDuration, , , , IIf(BusinessDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtBusiness','spantxtBusiness')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Efforts<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-4'>")

        If SprintVelocity = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtEfforts','spantxtEfforts')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", "form-control", 190, 100, SprintVelocity, , , , IIf(SprintVelocity = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtEfforts','spantxtEfforts')", True, , , , , , True))
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")



        'Added By Dipali V On 25th April 2018 
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <label class='col-md-6 control-label' style='white-space: nowrap;'>Story Points</label> ")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprinttxtStoryPoint", "SprinttxtStoryPoint", "form-control", , 100, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('SprinttxtStoryPoint','spanStoryPoint')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'End of Added By Dipali V On 25th April 2018 



        ' strHTML.Append("</form>")

        'strHTML.Append("</div>")
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='add_sprint' title='Save' onclick='SaveSprintRelease(""Sprint"")'>Save</button>")
        ' strHTML.Append("<button type='button' class='btn btn-primary' id='addsprint' title='Save' onclick='SaveSprintRelease(""Sprint"")' >Save</button>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-12 align-right' style='margin-top: 20px;margin-bottom:40px;text-align:right;display:block;'>")
        GetAccessRights()
        '   strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addsprint'  title='Save' onclick='SaveSprintRelease(""Sprint"")'>Save</button>&nbsp;&nbsp;&nbsp;")
        ' strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNextSprint'  style='display:none' title='Next' onclick='NextSprintRelease(""Sprint"")'>Next</button>")
        If (UniqueID <> "" Or UniqueID <> "0") And Sprintname <> "" Then
            If m_objAccess.Edit Then
                If strIsPrductOwner = 1 Then
                    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addUpdate'  data-bs-toggle='tooltip' data-bs-placement='top'  title='Update' onclick='SaveSprintRelease(""Sprint"")'><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                Else
                    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addUpdate'  data-bs-toggle='tooltip' data-bs-placement='top'  title='Update' onclick='SaveSprintRelease(""Sprint"")' disabled><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                End If
                ' strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNextSprint'  style='' title='Next' onclick='NextSprintRelease()'><i class='fa fa-angle-double-right' aria-hidden='true'></i>  Next</button>")
                'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addPreSprint'   title='Previous' onclick='PreSprintRelease()' style='display:none'><i class='fa fa-angle-double-left' aria-hidden='true'></i>  Previous</button>")
            End If
        Else
            If Sprintname = "" Then
                If m_objAccess.Add Then
                    strHTML.Append("<button type='button' class='btn btn-info' id='addsprint'  data-bs-toggle='tooltip' data-bs-placement='top'  title='Save' onclick='SaveSprintRelease(""Sprint"")'>Save</button>&nbsp;&nbsp;&nbsp;")
                End If
            End If
        End If
        If m_objAccess.Delete Then
            ' strHTML.Append("&nbsp;&nbsp;<i class='fas fa-trash-alt' aria-hidden='true' onclick='Delete_UserStory(" & UserStoryId & ")'></i>")
        End If
        'If UniqueID <> "" Then
        '    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNextSprint'  style='' title='Next' onclick='NextSprintRelease(""Sprint"")'>Next</button>")

        'End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function

    Public Function Release_form(Optional ReleaseID As String = "", Optional Releasename As String = "", Optional Description As String = "", Optional ReleaseStartDate As String = "", Optional ReleaseEndDate As String = "", Optional ReleaseDuration As String = "", Optional ReleaseVelocity As String = "", Optional BusinessDuration As String = "") As String
        '=====================================================================
        ' Procedure Name        :	Release_form
        ' Purpose               :	Release_form
        ' Description           :	Open Release
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	9h-March-2018
        ' Revisions             :
        '=====================================================================


        Dim strHTML As New StringBuilder()


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Release Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-10'>")
        If Releasename = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ReleaseName", "ReleaseName", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ReleaseName", "ReleaseName", "form-control", 190, 100, Releasename, , , IIf(Releasename = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Description</label> ")
        strHTML.Append(" <div class='col-sm-10'>")
        If Description = "" Then

            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , , , , , , , , , "onkeyup='javascript:Maxlength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:Maxlength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription') data-autoresize", True, EnableHTMLEncode:=True))
            ' <!-- /* Modified By Madhuri.K On 03-04-2026 */ -->
            strHTML.Append("<p style='font-size: 11.5px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right: -26px;' id='countdownRelease'>1000</p>")

        Else
            Dim len As Integer = 1000
            Dim len1 As Integer
            If Description.Length <> -1 Then
                len1 = Description.Length
                len = 1000 - len1
            End If
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , len, Description, , , , IIf(Description = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup='javascript:Maxlength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:Maxlength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription') data-autoresize", True, EnableHTMLEncode:=True))
            ' <!-- /* Modified By Madhuri.K On 03-04-2026 */ -->
            strHTML.Append("<p style='font-size: 11.5px;font-weight: 500;color: grey;float:right;margin-top:-35px; margin-right: -26px;' id='countdownRelease'>" & len & "</p>")

        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='col-sm-6'>")
        strHTML.Append(" <label class='col-sm-4 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-8'>")

        If ReleaseStartDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", 190, 100, ReleaseStartDate, , , , IIf(ReleaseStartDate = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('RstartDate','spanRstartDate')", True, , , , , , True))

        End If

        strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; margin-top: -25px; float:right;color:#0099CC;' id='#dpRSDate' onclick=""$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');""></i>")
        'strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-sm-6'>")
        strHTML.Append(" <label class='col-sm-4 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-8'>")
        If ReleaseEndDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", 190, 100, ReleaseEndDate, , , , IIf(ReleaseEndDate = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')", True, , , , , , True))
        End If
        strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; margin-top: -25px;float:right;color:#0099CC;' id='#dpRendate'  onclick=""$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');""></i>")
        'strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Calendar Day's' >Calendar Day's Duration</label> ")
        'strHTML.Append(" <div class='col-md-6>")

        'If ReleaseDuration = "" Then
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
        'Else
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", 190, 100, ReleaseDuration, , , , IIf(ReleaseDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
        'End If
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Business Day's'>Business Day's Duration</label> ")
        'strHTML.Append(" <div class='col-md-6'>")

        'If BusinessDuration = "" Then
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
        'Else
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", 190, 100, BusinessDuration, , , , IIf(BusinessDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
        'End If
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelBusiness", "txtRelBusiness", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtRelBusiness','spantxtRelBusiness')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div>")
        ''strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='  font-size: 7px;  margin-top: 17px;color:red;'></i>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='col-sm-6'>")
        strHTML.Append(" <label class='col-sm-4 control-label' style='white-space: nowrap;'>Calendar Day's</label> ")
        strHTML.Append(" <div class='col-sm-8'>")

        If ReleaseDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, ReleaseDuration, , , , IIf(ReleaseDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-sm-6'>")
        strHTML.Append(" <label class='col-sm-4 control-label' style='white-space: nowrap;'>Business Day's</label> ")
        strHTML.Append(" <div class='col-sm-8'>")

        If BusinessDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, BusinessDuration, , , , IIf(BusinessDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-12 alignss-right' style='margin-top: 20px;text-align:right;display:block'>")
        GetAccessRights()
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addRelease'  title='Save' onclick='SaveSprintRelease(""Release"")'>Save</button>&nbsp;&nbsp;&nbsp;")
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='display:none' title='Next' onclick='NextSprintRelease(""Release"")'>Next</button>")
        If (UniqueID <> "" Or UniqueID <> "0") And Releasename <> "" Then
            If m_objAccess.Edit Then
                If strIsPrductOwner = 1 Then
                    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addUpdateRelease'  data-bs-toggle='tooltip' data-bs-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")'><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")
                Else
                    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addUpdateRelease'  data-bs-toggle='tooltip' data-bs-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")' disabled><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")

                End If
                'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='' title='Next' onclick='NextSprintRelease(""Release"")'><i class='fa fa-angle-double-right' aria-hidden='true'></i>Next</button>")
                'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addPrerelase'  style='display:none' title='Previous' onclick='NextSprintRelease(""Release"")'><i class='fa fa-angle-double-left' aria-hidden='true'></i>Previous</button>")
            End If
        Else
            If Releasename = "" Then
                If m_objAccess.Add Then
                    strHTML.Append("<button type='button' class='btn btn-info' id='addRelease'  data-bs-toggle='tooltip' data-bs-placement='top'  title='Save' onclick='SaveSprintRelease(""Release"")'>Save</button>&nbsp;&nbsp;&nbsp;")

                End If
            End If
        End If
        If m_objAccess.Delete Then
            ' strHTML.Append("&nbsp;&nbsp;<i class='fas fa-trash-alt' aria-hidden='true' onclick='Delete_UserStory(" & UserStoryId & ")'></i>")
        End If
        'If UniqueID <> "" Then
        '    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='' title='Next' onclick='NextSprintRelease(""Release"")'>Next</button>")

        'End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Save_IterationUserStories(ByVal UserStoryID As String, ByVal IterationID As String, ByVal strMapFlag As String) As String
        '=====================================================================
        ' Procedure Name        :  Save_IterationUserStories()	
        ' Purpose               : To Add save story product to sprint
        ' Description           : To Add save story product to sprint
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 5 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try

            Dim strSQL As String = ""
            Dim strResult As String = ""

            Dim strPos As String = ""

            strSQL = "Usp_NG2_Upd_tbl_PM_ScrumUserStory_Iteration " & UserStoryID & "," & IterationID & ",'" & strMapFlag & "','" & HttpContext.Current.Session("strUserName") & "'"
            Try
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                strResult = "1"
            Catch ex As Exception
            End Try

            '''  RefreshGrid("")

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    Private Function WriteGrid(ByVal Flag As String, Optional ByVal UserStoryID As String = "", Optional ByVal FilterValue As String = "") As String
        '=====================================================================
        ' Procedure Name        : WriteGrid()	
        ' Purpose               : To Plot Release List Grid
        ' Description           :  To Plot Release List Grid
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 6th MArch 2018
        ' Revisions             : None
        '=====================================================================


        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        If UserStoryID = "" Then
            UserStoryID = "0"
        End If


        'If Flag = "UserStory" Then
        '    Dim arrstrActualList() As String
        '    Dim arrstrUserFriendlyList() As String
        '    Dim arrstrLinkArray() As String
        '    Dim arrCheckBoxArray() As String
        '    Dim arrWidthArray() As String
        '    intNoOfDataColumn = 3
        '    strDivID = "DivUSlist"
        '    strSQLQuery = "usp_NG2_GetUserStoriesForRelease " & HttpContext.Current.Session("IntProjectID") & ",'UserStory'"
        '    arrstrActualList = {"UserStoryID", "UserStoryName", "Priority", ""}
        '    arrstrUserFriendlyList = {"User StoryID", "User Story Name", "Priority", "Select"}
        '    arrstrLinkArray = {"", "", "", ""}
        '    arrCheckBoxArray = {"", "", "", "checkUSmapped"}
        '    arrWidthArray = {"align=left", "align=left", "align=Center", "align=left"}

        '    With objGridUS
        '        .ActualColumnArray = arrstrActualList
        '        .UserFriendlyColumnArray = arrstrUserFriendlyList
        '        ' .CheckBoxIDArray = arrCheckBoxArray
        '        .NoOfDataColumns = intNoOfDataColumn
        '        .RowLinkArray = arrstrLinkArray
        '        .TDStyleArray = arrWidthArray
        '        .DIVStyle = "overflow:auto"
        '        .ColNameToolTipOnEachRow = True
        '        .EmptyValueReplacement = (" ")
        '        .DIVID = strDivID
        '        .SQL = strSQLQuery
        '        .ColNameToolTipOnEachRow = True
        '        .UseSQL = True
        '        .returnHTML = True
        '        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
        '        strGridHTML.Append(.DrawGrid())
        '    End With
        '    objGridUS = Nothing









        If Flag = "IssueList" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 6
            strDivID = "DivSubTabIssuesList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumIssues " & UserStoryID & ",'UserStory'"
            arrstrActualList = {"IsImpediment", "IssueID", "ReportedDate", "Type", "IterationName", "Summary"}
            arrstrUserFriendlyList = {"Flag", "ID", "Reported Date", "Type", "Sprint Name", "Summary"}
            arrstrLinkArray = {"", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivSubTabIssuesList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objIssuesList
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
            objIssuesList = Nothing


            'ElseIf Flag = "RisksList" Then
            '    Dim arrstrActualList() As String
            '    Dim arrstrUserFriendlyList() As String
            '    Dim arrstrLinkArray() As String
            '    Dim arrCheckBoxArray() As String
            '    Dim arrWidthArray() As String
            '    intNoOfDataColumn = 5
            '    strDivID = "DivRisksList"
            '    strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumRisks " & SelectedReleaseID & "," & FlagSprintRelease & ""
            '    arrstrActualList = {"DateIdentified", "IterationName", "Status", "Description", "RiskCategory"}
            '    arrstrUserFriendlyList = {"Date Identified ", "Sprint Name", "Status", "Description", "Risk Category"}
            '    arrstrLinkArray = {"", "", "", "", ""}
            '    arrCheckBoxArray = {"", "", "", "", ""}
            '    arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}

            '    With objRiskList
            '        .ActualColumnArray = arrstrActualList
            '        .UserFriendlyColumnArray = arrstrUserFriendlyList
            '        ' .CheckBoxIDArray = arrCheckBoxArray
            '        .NoOfDataColumns = intNoOfDataColumn
            '        .RowLinkArray = arrstrLinkArray
            '        .TDStyleArray = arrWidthArray
            '        .DIVStyle = "overflow:auto"
            '        .ColNameToolTipOnEachRow = True
            '        .EmptyValueReplacement = (" ")
            '        .DIVID = strDivID
            '        .SQL = strSQLQuery
            '        .ColNameToolTipOnEachRow = True
            '        .UseSQL = True
            '        .returnHTML = True
            '        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            '        strGridHTML.Append(.DrawGrid())
            '    End With
            '    objRiskList = Nothing

        ElseIf Flag = "ReviewList" Then

            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 5
            strDivID = "DivReviewList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumReviews " & UserStoryID & ",'UserStory'"
            arrstrActualList = {"ReviewTitle", "ReviewedDate", "ReviewStatus", "ReviewedBy"}
            arrstrUserFriendlyList = {"Review Title", "Reviewed Date", "Status", "Reviewer / Reviewee"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=center", "align=center", "align=center", "align=center", "align=center"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivReviewList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objReviewList
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
            objReviewList = Nothing

        ElseIf Flag = "TaskList" Then

            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 4
            strDivID = "DivTaskList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & UserStoryID & ",'UserStory'"
            arrstrActualList = {"ScrumTaskName", "Effort", "AssignedTo", "InitialEstimate"}
            arrstrUserFriendlyList = {"Task Name", "Plan/Effort", "Assigned To", "Story Points"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivTaskList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objtaskList
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
            objtaskList = Nothing

        ElseIf Flag = "HistorykList" Then

            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 5
            strDivID = "DivHistorykList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & UserStoryID & ",8087"
            arrstrActualList = {"Date", "ModifiedBy", "FieldName", "OldValue", "NewValue"}
            arrstrUserFriendlyList = {"Date", "Modified By", "Field Name", "Old Value", "New Value"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivHistorykList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objHistorykList
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
            objHistorykList = Nothing

        ElseIf Flag = "MapSprintList" Then
            Dim TextSearchVal As String = ""
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 4
            strDivID = "DivSprintlist"
            If TextSearchVal = "" Then
                strSQLQuery = "usp_NG2_SEL_tbl_PM_ScrumIterationData " & HttpContext.Current.Session("IntProjectID") & ""
            Else
                strSQLQuery = "usp_NG2_SEL_tbl_PM_ScrumIterationData " & HttpContext.Current.Session("IntProjectID") & ",null,null," & TextSearchVal & ""
            End If

            arrstrActualList = {"IterationName", "StartDate", "EndDate", "IterationStatus", ""}
            arrstrUserFriendlyList = {"Sprint Name", "Start Date", "End Date", "Sprint Status", "SELECT"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivSprintlist value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            'objGrid = m_objEmpGrid

            With m_objSprintmapGrid
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
            m_objSprintmapGrid = Nothing

        ElseIf Flag = "ListView" Then
            Dim TextSearchVal As String = ""
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 4
            strDivID = "Divlist"
            Dim filterflag As String = ""
            If FilterValue = "" Then
                FilterValue = "null"
            End If
            If filterflag = "" Then
                filterflag = "null"
            End If
            If filterflag = "null" Then
                strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog_ListView " & Session("intProjectID") & ",NULL,NULL," & Session("intUserID") & "," & filterflag & "," & FilterValue & ""
            Else
                strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog_ListView " & Session("intProjectID") & ",NULL,NULL," & Session("intUserID") & ",'" & filterflag & "'," & FilterValue & ""
            End If
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterListCount value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            arrstrActualList = {"InitialRank", "UserStoryName", "Description", "Priority", ""}
            arrstrUserFriendlyList = {"Rank", "UserStory Name", "Description", "Priority", "Edit"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}

            'objGrid = m_objEmpGrid

            With m_objListGrid
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
            m_objListGrid = Nothing
        End If






        'End If
        Return strGridHTML.ToString

    End Function
    ''For Issue Tab
    Private Sub objIssuesList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objIssuesList.DataRowTD_BeforePrint



        'If Args.ColumnName.ToUpper = "FLAG" Then 'Flag
        '    If Not IsDBNull(Args.DataReader("IsImpediment")) Then
        '        Cancel = True
        '        If (Args.DataReader("IsImpediment") = 1) Then

        '            Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue by Impediment' data-bs-toggle='tooltip' data-bs-placement='bottom' ><i class='fa fa-star' aria-hidden='true' style='color:red !important'></i></span></p></td>"
        '        Else

        '            Args.StringToBeInserted = "<td align='center' ><p ></p></TD>"
        '        End If
        '    Else

        '        Args.StringToBeInserted = "<td align='center' ><p ></p></TD>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If


        'If Args.ColumnName.ToUpper = "ID" Then 'Story Points
        '    If Not IsDBNull(Args.DataReader("IssueID")) Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue ID' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IssueID") & "</span></p></td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Issue ID' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If


        'If Args.ColumnName.ToUpper = "REPORTED DATE" Then 'ReportedDate
        '    If Not IsDBNull(Args.DataReader("ReportedDate")) Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reported Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReportedDate") & "</span></p></td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reported Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If

        'If Args.ColumnName.ToUpper = "TYPE" Then 'ReportedDate
        '    If Not IsDBNull(Args.DataReader("Type")) Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue Type' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Type") & "</span></p></td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Issue Type' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If


        'If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'Sprint Name
        '    If Not IsDBNull(Args.DataReader("IterationName")) Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If

        'If Args.ColumnName.ToUpper = "SUMMARY" Then 'Summary
        '    Cancel = True
        '    Dim strLessValue As String = ""
        '    If Args.DataReader("Summary").Length > 100 Then
        '        strLessValue = Args.DataReader("Summary").Substring(0, 100)
        '    Else
        '        strLessValue = Args.DataReader("Summary")
        '    End If
        '    Args.StringToBeInserted = "<td valign='top' align='left' style='white-space:pre-line'><p style='word-break:break-all' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & Args.DataReader("Summary") & "'>" & strLessValue & "</p></td>"


        '    ' End If

        '    'If Not IsDBNull(Args.DataReader("Summary")) Then
        '    '    Cancel = True
        '    '    Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Summary' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Summary") & "</span></p></td>"
        '    'Else
        '    '    Cancel = True
        '    '    Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Summary' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
        '    'End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If


        If Args.ColumnName.ToUpper = "STATUS" Then 'Status
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Status") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "RESPONSIBLE PERSON" Then '"Responsible Person
            If Not IsDBNull(Args.DataReader("EmployeeName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Responsible Person' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("EmployeeName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Responsible Person' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub
    Private Sub objHistorykList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objHistorykList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "DATE" Then 'Date
            If Not IsDBNull(Args.DataReader("Date")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Date") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "MODIFIED BY" Then 'Modified By
            If Not IsDBNull(Args.DataReader("ModifiedBy")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Modified By' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ModifiedBy") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Modified By' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "FIELD NAME" Then 'Field Name
            If Not IsDBNull(Args.DataReader("FieldName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Field Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("FieldName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Field Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "OLD VALUE" Then 'Old Value
            If Not IsDBNull(Args.DataReader("OldValue")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Old Value' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'>" & Args.DataReader("OldValue") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Old Value' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "NEW VALUE" Then 'New Value
            If Not IsDBNull(Args.DataReader("NewValue")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'New Value' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >" & Args.DataReader("NewValue") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'New Value' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub

    Private Sub objReviewList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objReviewList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "REVIEWED DATE" Then 'Reviewed Date
            If Not IsDBNull(Args.DataReader("ReviewedDate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reviewed Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReviewedDate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reviewed Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        'If Args.ColumnName.ToUpper = "SPRINTNAME" Then 'Sprint Name
        '    If Not IsDBNull(Args.DataReader("IterationName")) Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'Status
            If Not IsDBNull(Args.DataReader("ReviewStatus")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReviewStatus") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "REVIEW TITLE" Then 'ReviewTitle
            If Not IsDBNull(Args.DataReader("ReviewTitle")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Review Title' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReviewTitle") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Review Title' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "REVIEWER / REVIEWEE" Then 'Reviewer / Reviewee
            If Not IsDBNull(Args.DataReader("ReviewedBy")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reviewer/Reviewee' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReviewedBy") & "/" & Args.DataReader("Reviewee") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reviewer/Reviewee' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

    End Sub

    Private Sub objtaskList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objtaskList.DataRowTD_BeforePrint




        If Args.ColumnName.ToUpper = "TASK NAME" Then 'Task Name
            If Not IsDBNull(Args.DataReader("ScrumTaskName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Task Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ScrumTaskName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Task Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "ASSIGNED TO" Then 'AssignedTo
            If Not IsDBNull(Args.DataReader("AssignedTo")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Assigned To' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("AssignedTo") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Assigned To' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        'If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'Sprint Name
        '    If Not IsDBNull(Args.DataReader("IterationName")) Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If

        If Args.ColumnName.ToUpper = "PLAN/EFFORT" Then 'Plan/Effort
            If Not IsDBNull(Args.DataReader("Effort")) Then
                Cancel = True
                'Commented and Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change
                'Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Plan/Effort' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Effort") & " / " & Args.DataReader("Actual") & "</span></p></td>"

                Dim strBeforeDecimal As String = ""
                Dim strDecimal As String = ""
                Dim curEfforts As String = Args.DataReader("Effort")
                Dim curActualEfforts As String = Args.DataReader("Actual")

                strBeforeDecimal = curEfforts.Substring(0, curEfforts.IndexOf(":"))
                If strBeforeDecimal.Length = 1 Then
                    strBeforeDecimal = "0" + strBeforeDecimal
                End If
                strDecimal = curEfforts.Substring(curEfforts.IndexOf(":") + 1, 2)
                curEfforts = strBeforeDecimal + ":" + strDecimal

                strBeforeDecimal = curActualEfforts.Substring(0, curActualEfforts.IndexOf(":"))
                If strBeforeDecimal.Length = 1 Then
                    strBeforeDecimal = "0" + strBeforeDecimal
                End If
                strDecimal = curActualEfforts.Substring(curActualEfforts.IndexOf(":") + 1, 2)
                curActualEfforts = strBeforeDecimal + ":" + strDecimal

                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Plan/Effort' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & curEfforts & " / " & curActualEfforts & "</span></p></td>"
                'End of Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Plan/Effort' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "STORY POINTS" Then 'Story Points
            If Not IsDBNull(Args.DataReader("InitialEstimate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Story Points' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("InitialEstimate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Story Points' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
        'If Args.ColumnName.ToUpper = "STATUS" Then 'STATUS
        '    If Not IsDBNull(Args.DataReader("IsActive")) Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IsActive") & "</span></p></td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If

        'arrstrUserFriendlyList = {"Task Name", "Assigned To", "Plan/Effort", "Story Points"}

    End Sub

    Private Sub m_objListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objListGrid.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "USERSTORY NAME" Then 'UserStoryName

            'Commented And Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story
            'If Not IsDBNull(Args.DataReader("UserStoryName")) Then
            '    Cancel = True
            '    Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("UserStoryName") & "</span></p></td>"
            'Else
            '    Cancel = True
            '    Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            'End If

            If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsSubUserStory"), 0) = 1 Then
                If Not IsDBNull(Args.DataReader("UserStoryName")) Then
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sub User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("UserStoryName") & "</span></p></td>"
                Else
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sub User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
                End If
            Else
                If Not IsDBNull(Args.DataReader("UserStoryName")) Then
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("UserStoryName") & "</span></p></td>"
                Else
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
                End If
            End If

            'End Of Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "DESCRIPTION" Then 'Description
            If Not IsDBNull(Args.DataReader("Description")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Description' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Description") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Description' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If



        If Args.ColumnName.ToUpper = "PRIORITY" Then 'Priority
            If Not IsDBNull(Args.DataReader("Priority")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Priority' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Priority") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Priority' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "RANK" Then 'Rank
            If Not IsDBNull(Args.DataReader("InitialRank")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Rank' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("InitialRank") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Rank' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        'Commented And Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story
        'If Args.ColumnName.ToUpper = "EDIT" Then 'Edit
        '    If Not IsDBNull(Args.DataReader("UserStoryID")) Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><i style='font-size:14px!important;text-align:center;color:#429ad4;'  data-bs-placement='bottom'  id='idEdit' title='Edit User Story' class='fas fa-pencil-alt'  data-bs-toggle='modal' data-bs-target='#divProductBacklog' onclick=""EditListUS(" & Args.DataReader("UserStoryID") & ",'')""></i></td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><i style='font-size:14px!important;text-align:center;color:#429ad4;'  data-bs-placement='bottom'  id='idEdit'  title='Edit User Story' class='fas fa-pencil-alt'  data-bs-toggle='modal' data-bs-target='#divProductBacklog' onclick=""EditListUS(" & Args.DataReader("UserStoryID") & ",'')""></i></td>"
        '    End If
        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If

        If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsSubUserStory"), 0) = 1 Then
            If Args.ColumnName.ToUpper = "EDIT" Then 'Edit
                If Not IsDBNull(Args.DataReader("UserStoryID")) Then
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center' ><i style='font-size:14px!important;text-align:center;color:#429ad4;'  data-bs-placement='bottom'  id='idEdit' title='Edit Sub User Story' class='fas fa-pencil-alt'  data-bs-toggle='modal' data-bs-target='#divProductBacklog' onclick=""EditListUS(" & Args.DataReader("UserStoryID") & ",'')""></i></td>"
                Else
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center' ><i style='font-size:14px!important;text-align:center;color:#429ad4;'  data-bs-placement='bottom'  id='idEdit'  title='Edit Sub User Story' class='fas fa-pencil-alt'  data-bs-toggle='modal' data-bs-target='#divProductBacklog' onclick=""EditListUS(" & Args.DataReader("UserStoryID") & ",'')""></i></td>"
                End If
            End If
        Else
            If Args.ColumnName.ToUpper = "EDIT" Then 'Edit
                If Not IsDBNull(Args.DataReader("UserStoryID")) Then
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center' ><i style='font-size:14px!important;text-align:center;color:#429ad4;'  data-bs-placement='bottom'  id='idEdit' title='Edit User Story' class='fas fa-pencil-alt'  data-bs-toggle='modal' data-bs-target='#divProductBacklog' onclick=""EditListUS(" & Args.DataReader("UserStoryID") & ",'')""></i></td>"
                Else
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center' ><i style='font-size:14px!important;text-align:center;color:#429ad4;'  data-bs-placement='bottom'  id='idEdit'  title='Edit User Story' class='fas fa-pencil-alt'  data-bs-toggle='modal' data-bs-target='#divProductBacklog' onclick=""EditListUS(" & Args.DataReader("UserStoryID") & ",'')""></i></td>"
                End If
            End If
        End If

        'End Of Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function GetCategoryColor(ByVal categoryID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCategoryColor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   29th-Dec-2016
        '=====================================================================
        Try

            Dim StrColorQuery As String = "usp_NG2_GETColorForUserStory " & categoryID & ",'category'," & HttpContext.Current.Session("intProjectID") & ""
            Dim strCategoryColor As String = ""

            Dim drGetCategoryColor As IDataReader
            Dim strHTML As New StringBuilder
            drGetCategoryColor = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            While drGetCategoryColor.Read
                strCategoryColor = CommonFunctions.Data.CheckIsDBNull(drGetCategoryColor("Color").ToString, "")
            End While
            Dim strHtml2 As String
            strHtml2 = GetColorMaster(categoryID, "Category")

            Return strCategoryColor + "||" + strHtml2
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetVersionColor(ByVal versionID As String, ByVal Mode As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCategoryColor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   29th-Dec-2016
        '=====================================================================
        Try

            Dim StrColorQuery As String = "usp_NG2_GETColorForUserStory " & versionID & ",'Version'," & HttpContext.Current.Session("intProjectID") & ""
            Dim strCategoryColor As String = ""

            Dim drGetCategoryColor As IDataReader
            Dim strHTML As New StringBuilder
            drGetCategoryColor = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            While drGetCategoryColor.Read
                strCategoryColor = CommonFunctions.Data.CheckIsDBNull(drGetCategoryColor("Color").ToString, "")
            End While

            Dim strHtml2 As String
            strHtml2 = GetColorMaster(versionID, Mode)
            Return strCategoryColor + "||" + strHtml2
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetPriorityColor(ByVal PriorityID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCategoryColor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   29th-Dec-2016
        '=====================================================================
        Try

            Dim StrColorQuery As String = "usp_NG2_GETColorForUserStory " & PriorityID & ",'Priority'," & HttpContext.Current.Session("intProjectID") & ""
            Dim strPriorityColor As String = ""

            Dim drGetPriorityColor As IDataReader
            Dim strHTML As New StringBuilder
            drGetPriorityColor = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            While drGetPriorityColor.Read
                strPriorityColor = CommonFunctions.Data.CheckIsDBNull(drGetPriorityColor("Color").ToString, "")
            End While
            Dim strHtml2 As String
            strHtml2 = GetColorMaster(PriorityID, "Priority")

            Return strPriorityColor + "||" + strHtml2
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeColor(ByVal ID As String, ByVal color As String, ByVal mode As String) As String
        '=====================================================================
        ' Procedure  Name		:	ChangeColor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   30th-Dec-2016
        '=====================================================================

        If ID <> "" Then
            Dim strQuery As String = "usp_NG2_upd_tbl_NG2_ScrumCategoryVersion " & ID & ",'" & color & "','" & mode & "'," & HttpContext.Current.Session("intProjectID") & ""
            Dim strUpdateColor As String = CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

        End If

        If mode = "Priority" Then
            Return 1
        End If
        If mode = "Category" Then
            Return 2
        End If
        If mode = "Version" Then
            Return 3
        End If
        If mode = "FVersion" Then
            Return 4
        End If



    End Function

    'Commented and Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

    '<System.Web.Services.WebMethod()>
    'Public Shared Function SaveSubStories(ByVal strUserStoryID As String, ByVal SubStoryName As String, ByVal SubStoryDesc As String, ByVal strPriority As String, ByVal strRank As String) As String
    '    Dim strSQL As String
    '    Try
    '        strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & strUserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "'"
    '        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    '        Return New frmProductBacklog().PlotSubUserStoryList(strUserStoryID)
    '    Catch ex As Exception
    '        Return "0"
    '    End Try


    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveSubStories(ByVal strUserStoryID As String, ByVal SubStoryName As String, ByVal SubStoryDesc As String, ByVal strPriority As String, ByVal strRank As String, ByVal Complexity As String, ByVal Category As String) As String
        Dim strSQL As String
        Try

            If Complexity = "" Or Complexity Is Nothing Then
                Complexity = "NULL"
            End If
            If Category = "" Or Category Is Nothing Then
                Category = "NULL"
            End If


            If Complexity = "NULL" Then
                strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & strUserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "', " & Complexity & ", " & Category
            Else
                strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & strUserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "', '" & Complexity & "', " & Category
            End If

            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Return New frmProductBacklog().PlotSubUserStoryList(strUserStoryID)
        Catch ex As Exception
            Return "0"
        End Try


    End Function

    'End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

    ''=======================================
    ''created By : Nikhil A
    ''Created On : 5-April-2018
    ''Purpose : for Product backlock excel upload 
    ''=======================================
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveExcelConfiguration(ByVal arrPBFields As Object, ByVal arrExcelFields As Object) As String
        Dim strProjectID As String = HttpContext.Current.Session("intProjectID")
        Dim blnFlag As Boolean = False

        For k As Integer = 0 To 11 Step 1
            Dim strPBFieldName As String = arrPBFields(k)
            Dim strExcelFieldName As String = arrExcelFields(k)
            Dim strSQLQuery As String = "Usp_NG2_Ins_Upd_tbl_PM_PBSExcelUpload_Fields " & strProjectID & ",'" & strPBFieldName & "','" & strExcelFieldName & "'"

            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
            blnFlag = True
        Next

        If blnFlag = True Then
            Return "1"
        Else

            Return "0"
        End If


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetExcelUploadDiv(ByVal ProjectID As String)
        Try

            Dim objProductBacklog As New frmProductBacklog
            Dim strDivHTML As New StringBuilder()

            strDivHTML.Append(objProductBacklog.ExcelUpload_form())
            Return strDivHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function UploadDataExcel(ByVal AttachmentID As String) As String
        Try

            Dim strProjectID As String = HttpContext.Current.Session("intProjectID")
            Dim objProductBacklog As New frmProductBacklog
            Dim strSQLQuery As String = "Usp_NG2_Ins_tbl_PM_ScrumUserStory_ExcelUpload " & AttachmentID & "," & strProjectID & ",'" & HttpContext.Current.Session("strUserName") & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)

            Return 1 & "||" & objProductBacklog.PlotGrid()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ClearExcelConfiguration() As String
        Try

            Dim strProjectID As String = HttpContext.Current.Session("intProjectID")
            Dim blnFlag As Boolean = False

            Dim strSQLQuery As String = "Usp_NG2_Del_tbl_PM_PBSExcelUpload_Fields " & strProjectID
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)

            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Function UploadData()
        If Request.Files.Count > 0 Then
            Dim strUserStoryID As String = Request.Params("UserStoryID")
            Dim strFileName As String
            strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
            Dim response As String = String.Empty
            Dim file As HttpPostedFile = Context.Request.Files(0)
            Dim buffer As Byte() = New Byte(256) {}
            Dim MimeType As String

            Dim fileName As String = HttpContext.Current.Request.Files(0).FileName
            Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
            Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
            Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
            Dim CharList As String()
            CharList = ValidateFileName.Split(","c)
            For k As Integer = 0 To CharList.Length - 1
                If fileName.Contains(CharList(k).ToString) Then
                    fileName1 = fileName1.Replace(CharList(k).ToString, "")
                End If
            Next
            Dim IsFileNameValid As Integer = 1
            Dim ExtensionList As String()
            ExtensionList = fileName.Split("."c)
            If ExtensionList.Length > 2 Then
                IsFileNameValid = 0
            End If
            If fileName = fileName1 And IsFileNameValid = 1 Then
                file.InputStream.Read(buffer, 0, 256)
                file.InputStream.Position = 0
                Dim logpath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                'Added By Dipali V On 31st Oct 2022 For File Content Type
                Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))
                Dim magicNumber As String = BitConverter.ToString(buffer)
                magicNumber = magicNumber.Replace("-", " ")
                Dim xmlDoc As New XmlDocument()
                Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                xmlDoc.Load(xmlPath + "MIMEType.xml")
                Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""

                ''Added by imran on 02-01-2023
                'Dim fileNameExtention As String = HttpContext.Current.Request.Files(0).FileName
                'Dim ext1 As String = Path.GetExtension(fileNameExtention)
                'Dim count As Integer = ext1.Split("."c).Length - 1
                'Dim count2 As Integer = fileNameExtention.Split("."c).Length - 1
                'If count > 1 Then
                '    MimeType = ""
                'End If
                'If count = 1 Or count2 = 1 Then
                For Each node As XmlNode In nodes
                    xContentType = node.SelectSingleNode("ContentType").InnerText
                    If strFileType = xContentType Then
                        fileName = HttpContext.Current.Request.Files(0).FileName
                        Dim ext As String = Path.GetExtension(fileName)
                        ext = ext.Substring(1, ext.Length - 1).ToLower()
                        extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower()
                        If extfromContentType.IndexOf(ext) > -1 Then
                            MimeType = strFileType
                            Exit For
                        End If
                    End If
                Next
                'End If
                'End of comment by imran on 02-01-2022
            Else
                MimeType = ""
            End If

            If MimeType Is Nothing Or MimeType = "" Then
                MimeType = "unknown/unknowns"
            End If

            If strListofTypes.IndexOf(MimeType) >= 0 Then
                Dim strFullPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory) & "/Attachments/Agile/"

                If Not Directory.Exists(strFullPath) Then
                    Directory.CreateDirectory(strFullPath)
                End If

                file.SaveAs(strFullPath + strFileName + Path.GetExtension(file.FileName))
                Dim strSql As String = "usp_NG2_INS_tbl_NG2_ScrumAttachments " & strUserStoryID & ",NULL,NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSql, True)
                Context.Response.Write(GetAttachmentList1(strUserStoryID, ""))
            Else
                Context.Response.Write("Invalid")
            End If
        End If
        Context.Response.End()
    End Function

    <DllImport("urlmon.dll", CharSet:=CharSet.Unicode, ExactSpelling:=True, SetLastError:=False)>
    <System.Security.SecuritySafeCritical()>
    Shared Function FindMimeFromData(ByVal pBC As IntPtr, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzUrl As String, <MarshalAs(UnmanagedType.LPArray, ArraySubType:=UnmanagedType.I1, SizeParamIndex:=3)> ByVal pBuffer() As Byte, ByVal cbSize As Integer, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzMimeProposed As String, ByVal dwMimeFlags As Integer, ByRef ppwzMimeOut As IntPtr, ByVal dwReserved As Integer) As Integer
    End Function
    <System.Security.SecuritySafeCritical()>
    Public Shared Function getMimeFromFile(ByVal file As HttpPostedFile) As String
        Dim mimeout As IntPtr
        Dim MaxContent As Integer = CInt(file.ContentLength)
        If MaxContent > 200 Then MaxContent = 200
        Dim buf As Byte() = New Byte(MaxContent - 1) {}
        file.InputStream.Read(buf, 0, MaxContent)
        Dim result As Integer = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, Nothing, 0, mimeout, 0)

        If result <> 0 Then
            Marshal.FreeCoTaskMem(mimeout)
            Return ""
        End If

        Dim mime As String = Marshal.PtrToStringUni(mimeout)
        Marshal.FreeCoTaskMem(mimeout)
        Return mime.ToLower()
    End Function
    'End of Added By Dipali V On 31st Oct 2022 For File Content Type
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDiscussion(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)
        Try

            Dim strSQL As String
            Dim strREsult As String
            strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'UserStory','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID

            strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If strREsult Then
                If HttpContext.Current.Session("intUserID") <> "0" Then
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", 'UserStory'", True)
                Else
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", 'UserStory'", True)

                End If
            End If

            Return New frmProductBacklog().PlotDiscussionThreadBody(strUserStoryID, "", "UserStory")
        Catch ex As Exception
            Return "Bad Request found"
        End Try
        'PlotDiscussionThreadBody(strUserStoryID, "", "UserStory")
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteAttachment(ByVal strAttachmentID As String, ByVal strUserStoryID As String, ByVal strEntity As String)
        'Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
        'Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strUserStoryID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")
        'Dim strResult As String = CommonFunctions.Data.GetDataScalar(strSql, True)
        'Return strResult & "||" & New frmProductBacklog().GetAttachmentList1(strUserStoryID, "AfterDelete")

        Try

            Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strUserStoryID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")

            Dim strResult As String
            Dim intFlag As Integer
            Dim drattach As IDataReader
            drattach = CommonFunctions.Data.GetDataReader(strSql, True)
            If drattach.Read() Then
                strResult = CommonFunction.Data.CheckIsDBNull(drattach("Result"), "")
                intFlag = CommonFunction.Data.CheckIsDBNull(drattach("intFlag"), "0")
            End If
            Return strResult & "||" & intFlag & "||" & New frmProductBacklog().GetAttachmentList1(strUserStoryID, "AfterDelete")

        Catch ex As Exception
            Return "Bad Request found"
        End Try
        'End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
    End Function
    'Added By Dipali V on 2nd April 2018 For Sprint & Release Validation

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateProjectDates(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String) As String
        '=====================================================================
        ' Purpose				:	ValidateProjectDates
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================
        Dim strSQL As String
        Dim strResult As String

        Try
            strSQL = "Usp_NG2_Validate_ProjectDates_IterationRelease " & ProjectID & ",'" & StartDate & "','" & EndDate & "'"

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "")

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    ''Added By Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
    <System.Web.Services.WebMethod()>
    Public Shared Function getCompanyDetails(ByVal Flag As String) As String
        Dim strRestrictByMinHours As String
        Dim strMinHoursForDAEntry As String
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            strRestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
            strMinHoursForDAEntry = CommonFunction.Data.CheckIsDBNull(drCompany("MinHoursForDAEntry"), "0")
        End If
        drCompany.Close()
        drCompany.Dispose()

        If Flag = "RestrictByMinHours" Then
            Return strRestrictByMinHours
        End If
        If Flag = "MinHoursForDAEntry" Then
            Return strMinHoursForDAEntry
        End If

    End Function
    ''End of Added By Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveSprintRelease(ByVal Flag As String, ByVal SprintID As String, ByVal ProjectID As String, ByVal Sprintname As String, ByVal ReleaseID As String, ByVal txtDescriptionSprint As String, ByVal SprintStartdate As String, ByVal SprintEnddate As String, ByVal txtCalendar As String, ByVal txtEfforts As String, ByVal txtBusiness As String)
        '=====================================================================
        ' Purpose				:	SaveSprintRelease
        ' Author				:	Dipali V
        ' Created				:	10th March 2018
        '=====================================================================
        Dim strReleaseName As String
        Dim strGridHTML As New StringBuilder()
        Dim Restult As Integer = 0
        If SprintID = "0" Then
            SprintID = "Null"
        End If

        If ReleaseID = "0" Then
            ReleaseID = "Null"
        End If

        'Commented and Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
        'Try
        '    If Flag = "Sprint" Then
        '        Dim strQuery As String = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration " & SprintID & "," & ProjectID & ",'" & Sprintname & "'," & ReleaseID & ",'" & txtDescriptionSprint.Replace("'", "''") & "','" & SprintStartdate & "','" & SprintEnddate & "'," & txtCalendar & "," & txtEfforts & ",'" & HttpContext.Current.Session("strUserName") & "'," & txtBusiness & ""
        '        ' CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
        '        Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))

        '    Else
        '        Dim strQuery As String = "usp_NG2_Ins_Upd_tbl_PM_ScrumRelease  " & SprintID & "," & ProjectID & ",'" & Sprintname & "','" & txtDescriptionSprint.Replace("'", "''") & "','" & SprintStartdate & "','" & SprintEnddate & "'," & txtCalendar & "," & txtEfforts & ",'" & HttpContext.Current.Session("strUserName") & "',Null"
        '        Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))
        '    End If
        'Catch ex As Exception
        'End Try

        Try
            If Flag = "Sprint" Then

                Dim fltEfforts As Decimal

                If txtEfforts = "0" Or txtEfforts = "" Then
                    txtEfforts = "00:00"
                End If

                If txtEfforts.IndexOf(":") = txtEfforts.Length - 1 Then
                    txtEfforts = txtEfforts + "00"
                End If

                Dim strDecimal As String = ""
                Dim strBeforeDecimal As String = ""
                strBeforeDecimal = txtEfforts.Substring(0, txtEfforts.IndexOf(":"))
                strDecimal = txtEfforts.Substring(txtEfforts.IndexOf(":") + 1, 2)
                txtEfforts = strBeforeDecimal + ":" + strDecimal

                fltEfforts = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + txtEfforts + "',2)", True)

                Dim strQuery As String = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration " & SprintID & "," & ProjectID & ",'" & Sprintname & "'," & ReleaseID & ",'" & txtDescriptionSprint.Replace("'", "''") & "','" & SprintStartdate & "','" & SprintEnddate & "'," & txtCalendar & "," & fltEfforts & ",'" & HttpContext.Current.Session("strUserName") & "'," & txtBusiness & ""
                ' CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))

            Else
                Dim strQuery As String = "usp_NG2_Ins_Upd_tbl_PM_ScrumRelease  " & SprintID & "," & ProjectID & ",'" & Sprintname & "','" & txtDescriptionSprint.Replace("'", "''") & "','" & SprintStartdate & "','" & SprintEnddate & "'," & txtCalendar & "," & txtEfforts & ",'" & HttpContext.Current.Session("strUserName") & "',Null"
                Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))
            End If
        Catch ex As Exception

            'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDuration(ByVal strStartDate As String, ByVal strEndDate As String)
        Dim strDuration As String
        Dim dtDuration As New DataTable
        dtDuration = CommonFunctions.Data.GetDataTable("usp_NG2_GetCalendarDaysCount '" & strStartDate & "','" & strEndDate & "'," & HttpContext.Current.Session("Intprojectid") & "", True)
        If dtDuration.Rows.Count > 0 Then
            strDuration = dtDuration.Rows(0)("NoOfDays") & "|" & dtDuration.Rows(0)("BusinessDays")
        End If
        Return strDuration
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIterationName(ByVal strIterationName As String, ByVal strProjectID As String, ByVal flag As String)
        Try

            Dim strSql As String = ""
            If flag = "Sprint" Then
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_IterationNameExists " & strProjectID & ",'" & strIterationName & "'", True), "0")

            Else
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_ReleaseNameExists " & strProjectID & ",'" & strIterationName & "'", True), "0")

            End If
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    ''Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIterationNameOnUpdate(ByVal strIterationName As String, ByVal strProjectID As String, ByVal flag As String, ByVal IterationId As String)

        Try
            Dim strSql As String = ""
            If flag = "Sprint" Then
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_IterationNameExists " & strProjectID & ",'" & strIterationName & "'," & IterationId, True), "0")

            Else
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_ReleaseNameExists " & strProjectID & ",'" & strIterationName & "'", True), "0")

            End If
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    ''End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateIterationDate(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Flag As String)

        Try
            Dim strSql As String = ""
            If Flag = "Sprint" Then
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsIterationFallsBetweenPeriod " & ProjectID & ",'" & StartDate & "','" & EndDate & "'", True), "0")
            Else
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsReleaseFallsBetweenPeriod " & ProjectID & ",'" & StartDate & "','" & EndDate & "'", True), "0")
            End If
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    'End of Added By Dipali V on 2nd April 2018 For Sprint & Release Validation

    <System.Web.Services.WebMethod()>
    Public Shared Function ScrumIterationList(ByVal strUserStoryId As String, ByVal Flag As String, ByVal Value As String)
        '=====================================================================
        ' Procedure Name        : Sprint ScrumIterationList()	
        ' Purpose               : To Add Sprint Planning
        ' Description           : To Add Sprint Planning
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V 
        ' Created               : 12 April -2018
        ' Revisions             : None
        '=====================================================================
        Try

            Dim strGridHTML As New StringBuilder("")

            Dim objfrmProductBacklog As New frmProductBacklog()
            If Flag = "ListView" Then
                strGridHTML.Append("<input type=hidden id=hdnProjectID value='" & HttpContext.Current.Session("intProjectID") & "'>")
                strGridHTML.Append("<input type=hidden id=hdnstrUserName value='" & HttpContext.Current.Session("strUserName") & "'>")
                strGridHTML.Append("<input type=hidden id=hdnintuserid value='" & HttpContext.Current.Session("intuserid") & "'>")
                strGridHTML.Append(objfrmProductBacklog.WriteGrid("ListView", strUserStoryId, Value))
                strGridHTML.Append(objfrmProductBacklog.Modal_popup())
            Else
                strGridHTML.Append(objfrmProductBacklog.WriteGrid("MapSprintList", strUserStoryId, ""))
                strGridHTML.Append("<button type='button' class='btn btn-primary' id='SelectSprint' onclick='MappedSprint()' title='Save'>Select</button>")

            End If

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    Private Sub m_objSprintmapGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSprintmapGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SPRINT NAME" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Sprint Name' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationName"), "") + "</p></TD>"
        End If
        If Args.ColumnName.ToUpper = "START DATE" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Start Date' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("StartDate"), "") + "</p></TD>"
        End If
        If Args.ColumnName.ToUpper = "END DATE" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'End Date' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EndDate"), "") + "</p></TD>"
        End If
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Select' data-bs-placement='bottom'><input type='checkbox' value='" & Args.DataReader("IterationID") & "' title='Select' name='chkIterationSel' class='clscheckbox' onclick='SelectOneSprintmappedtoUS(this)'>" + "</p></TD>"
        End If
        If Args.ColumnName.ToUpper = "SPRINT STATUS" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Sprint Status' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationStatus"), "Not Specified") + "</p></TD>"
        End If


    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeCategoryname(ByVal CategoryID As String, ByVal CategoryName As String) As String
        Dim strSQL As String
        Dim Flags As String = "1"
        Try
            'Flags = "1"
            strSQL = "usp_Upd_Ng2_tbl_NG2_ProjectLevel_ScrumCategory " & HttpContext.Current.Session("IntProjectID") & "," & CategoryID & ",'" & CategoryName & "','" & HttpContext.Current.Session("strusername") & "'"
            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Flags = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), "1")
            Return Flags
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function PlotCategoryDetails(ByVal CategoryID As String) As String
        'Dim strSQL As String
        'Dim Flags As String = "0"
        'Try
        '    Flags = "1"
        '    strSQL = "usp_Upd_Ng2_tbl_NG2_ProjectLevel_ScrumCategory " & HttpContext.Current.Session("IntProjectID") & "," & CategoryID & ",'" & CategoryName & "','" & HttpContext.Current.Session("strusername") & "'"
        '    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        'Catch ex As Exception

        'End Try

        'Return Flags
        Try

            Dim strGridHTML As New StringBuilder("")
            Dim objfrmProductBacklog As New frmProductBacklog()
            strGridHTML.Append(objfrmProductBacklog.PlotCategory(CategoryID))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    Function PlotCategory(CategoryID)
        '=====================================================================
        ' Procedure Name        : PlotCategory()	
        ' Purpose               : To Add Sprint Planning
        ' Description           : To Add Sprint Planning
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V 
        ' Created               : 14th April -2018
        ' Revisions             : None
        '=====================================================================


        Dim strHTML As New StringBuilder("")

        strHTML.Append("<div>")
        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Category Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-6' style='width:66%'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("CateGoryName", "CateGoryName", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Order No<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-6' style='width:66%'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("OrderNo_" & CategoryID, "OrderNo_" & CategoryID, "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
        'strHTML.Append("</div>")

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Order No<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-6' style='width:66%'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("CategoryOrder", "CategoryOrder", "form-control", 190, 3, , , , , , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        ''Commented By Aniruddh Gujar on 19-Apr-2018 Purpose::To remove color for category
        'strHTML.Append(" <div class='form-row'>")
        'strHTML.Append(" <div class='col-md-12'>")
        'strHTML.Append(" <div class='form-group '>")
        'strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Color<span class='required'>*</span></label> ")
        'strHTML.Append(" <div class='col-md-6' style='width:66%'>")
        'Dim strPriorityColor As String = ""
        'strHTML.Append("&nbsp;<a id='aCateColor' data-bs-toggle='dropdown' title='Select Category Color' style='cursor:pointer' ><i id='oColor' style='color:" & strCategoryColor & " !important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
        'strHTML.Append("<div class='dropdown-menu' role='menu' style='left: unset!important;top: inherit!important;'>")
        'strHTML.Append("<table class='table table-bordered' id='tblCategoryColor' style='background:#fff; left: unset!important;'>")
        'strHTML.Append("<tr>")
        'strHTML.Append(GetColorMaster(strCategory, "Category"))
        'strHTML.Append("</tr>")
        'strHTML.Append("</table>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        ''End of Commented By Aniruddh Gujar on 19-Apr-2018 Purpose::To remove color for category

        strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            'strHTML.Append(" <div class='col-md-6'>")
            'strHTML.Append(" <div class='form-group '>")
            'strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Order No<span class='required'>*</span></label> ")
            'strHTML.Append(" <div class='col-md-6' style='width:66%'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("OrderNo_" & CategoryID, "OrderNo_" & CategoryID, "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
            'strHTML.Append("</div>")

            'strHTML.Append("</div>")
            'strHTML.Append("</div>")

            strHTML.Append("</div>")




            'strHTML.Append(" <div class='form-row'>")
            'strHTML.Append(" <div class='col-md-12'>")
            'strHTML.Append(" <div class='form-group '>")
            'strHTML.Append("<button type='button' class='btn btn-default'' style='padding:4px 12px!important;float:right;margin-right:-21%;border:none!important;' onclick='AddCategory()'>Save</button>")

            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            Return strHTML.ToString


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCategory(ByVal CategoryID As String) As String
        Try

            Dim strSQL As String = ""
            Dim Restult As String = ""
            Dim Flags As String = "0"
            Dim strQuery As String = "usp_Ng2_ValidateCategoryhasUS " & HttpContext.Current.Session("IntProjectID") & "," & CategoryID & ""
            Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))
            If Restult = "1" Then


            Else
                Try
                    Restult = "0"
                    strSQL = "usp_Del_Ng2_tbl_NG2_ProjectLevel_ScrumCategory " & HttpContext.Current.Session("IntProjectID") & "," & CategoryID & ""
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                Catch ex As Exception

                End Try
            End If


            Return Restult
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function IsCategoryorderExists(ByVal CateGoryName As String, ByVal CateID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsCategoryorderExists
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	To check whether stage name already exists
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   14-April-2018
        '=====================================================================

        Dim strQuery As String = ""
        Dim strResult As String = ""
        Dim strFlag As String = ""

        Try

            strQuery = "usp_NG2_chk_DuplicateUserOrder " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("IntProjectID"), "") & ",'" & CateGoryName & "'"
            If CateID = "" Then
                strQuery += ",null"
            Else
                strQuery += "," & CateID

            End If

            strFlag = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "")


            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function AddNewCategory(ByVal CateGoryName As String, ByVal CategoryOrder As String) As String
        Dim strSQL As String = ""
        Dim Restult As String = "0"
        Dim strHTML As New StringBuilder("")

        Try
            Restult = "1"
            strSQL = "usp_Ng2_Ins_tbl_NG2_ProjectLevel_ScrumCategory " & HttpContext.Current.Session("IntProjectID") & ",'" & CateGoryName & "',null," & CategoryOrder & ",'" & HttpContext.Current.Session("strusername") & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            strHTML.Append(New frmProductBacklog().PlotGrid())
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try





    End Function
End Class