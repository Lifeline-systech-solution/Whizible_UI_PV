Public Class frmScrumBoard
    Inherits WebPages.Template.WhizTemplate
    Private Shared intIterationID As Integer
    Private Shared strIterationName As String
    Private Shared intReleaseID As String
    Private Shared strReleaseName As String
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected m_objIsDOD As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        GetAccessRights()
    End Sub
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
        ' Author                :Yogesh Jalamkar
        ' Created               :	22-March-2018
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22237, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)

        m_objIsDOD = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_NG2_chk_IsCustomStageApplicable " & HttpContext.Current.Session("intProjectID"), True), "0")
    End Sub
    Protected Function WritePage(Optional ByVal flag As String = "") As String
        '=====================================================================
        ' Procedure Name        :	WritePage
        ' Purpose               :	Write The page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Yogesh Jalamkar
        ' Created               :	26-MAR-2018
        ' Revisions             :
        '=====================================================================
        GetAccessRights()
        Dim strHTML As New StringBuilder("")
        Dim strSql As String = "usp_NG2_sel_CurrentReleaseAndIteration " & Session("intProjectID")
        Dim drCurrentDetails As IDataReader
        drCurrentDetails = CommonFunctions.Data.GetDataReader(strSql, True)
        While drCurrentDetails.Read()
            intIterationID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("CurrentIteration"), 0)
            strIterationName = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("IterationName"), "")
            intReleaseID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("ReleaseID"), 0)
            strReleaseName = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("ReleaseName"), "")
        End While


        strHTML.Append(DrawHeaderSection())
        strHTML.Append("<div id='table' class='dragscroll'>")
        strHTML.Append(DrawMainSection())

        strHTML.Append("</div>")
        If (flag = "1") Then
            Return strHTML.ToString
        Else
            CommonFunction.General.WriteHTML(strHTML.ToString)
        End If
    End Function
    Private Function DrawHeaderSection() As String
        '=====================================================================
        ' Purpose				:	To plot the header section of page
        ' Author				:	Yogesh Jalamkar
        ' Created				:	26-Mar-2018.
        '=====================================================================


        Dim strHTML As New StringBuilder
        strHTML.Append("<div>")
        strHTML.Append("<div class='row' style='margin-left:28px!important'>")
        strHTML.Append("<div class='fixed-top'>")
        strHTML.Append("<div class='col-md-12' style='display:flex'>")
        'Commented & Added By Dipali V On 1st Aug 2018 For Issue Id 14360 col-md-4 
        strHTML.Append("<div class='col-sm-4 clsDivHeader' style='color: #888888b8; font-weight: 500; font-size: 16px;margin-top: 11px;'>Scrum Board</div>")
        'End of Commented & Added By Dipali V On 1st Aug 2018 For Issue Id 14360 col-md-4 

        strHTML.Append("<div class='col-sm-8' style='margin-top:0px;float:right;'>")
        '' Commented and Added by Usha Pandit on 22.04.2019 for proper tooltip display
        'strHTML.Append("<div class='' style='float:right;margin-right: -29px;'>")
        strHTML.Append("<div class='' style='float:right;'>")
        '' End of Added by Usha Pandit on 22.04.2019 for proper tooltip display
        strHTML.Append("<a class='arrow-to-display horizon-prev' title='Previous' data-toggle='tooltip' data-placement='bottom' data-container='body' ><i class='fa fa-arrow-left disabled'></i></a>")

        If m_objAccess.Add = True Then
            If m_objIsDOD = "1" Then
                strHTML.Append("<a id='add-btn' class='add-dynamic-div' title='Add Stage' data-container='body' data-toggle='tooltip' data-placement='bottom'><i class='fa fa-plus'></i></a>")
            ElseIf m_objIsDOD = "2" Then
                strHTML.Append("<span id='CustomStageAdd-btn' class='add-dynamic-div' title='Maximum 5 custom stages can be added' data-toggle='tooltip' data-placement='bottom' data-container='body'><i class='fa fa-plus'></i></span>")
            ElseIf m_objIsDOD = "0" Then
                strHTML.Append("<span id='CustomStageAdd-btn' class='add-dynamic-div' title='You cannot add Custom Stages' data-toggle='tooltip'  data-placement='bottom' data-container='body'><i class='fa fa-plus'></i></span>")
            End If
        End If

        '' strHTML.Append("<a href='#openpopup' class='content' data-toggle='modal' title='Add Stage'><i class='fas fa-pencil-alt-square-o add-dynamic-div' aria-hidden='true'></i></a>")
        strHTML.Append("<a class='arrow-to-display horizon-next' title='Next' data-toggle='tooltip' data-placement='bottom' data-container='body'><i class='fa fa-arrow-right'></i></a>")

        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<div class='btn-group dropdown' id='div1'><div data-bs-toggle='dropdown' style='cursor: pointer;text-align:center;margin-right:21px;margin-left: 11px;margin-top: -2px;' aria-expanded='false'><i data-toggle='tooltip' data-placement='bottom' data-container='body'  title='Select Sprint' style='font-size:16px!important;color: #34495e;' class='fa fa-filter'></i></div>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle

        strHTML.Append("<div class='dropdown-menu' id='filter-dropdown' role='menu' >")
        strHTML.Append("<div id='tblAdvHeader'><div class='row'><div class='col-sm-10'><p  class='grey-text' style='float:left;margin-left:5%!important'>Filters</p></div> <div class='col-sm-2'> <i class='fas fa-times' style='font-size:14px!important;color:grey!important;'></i> </div></div></div>")
        strHTML.Append("<div id='dropdown-content'>")
        strHTML.Append("<div class='row'><div class='col-md-12'> <label for='defaultFormRegisterNameE' class='grey-text'>Select Release</label> <div class='input-group' ><span class='input-group-addon' style='background-color: #275482; border: 1px solid #275482;color:white;'><i class='fa fa-list' aria-hidden='true'></i></span>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ScrumReleases", "usp_NG2_sel_tbl_PM_ScrumReleases " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), ""), , intReleaseID, "class='form-select' onchange=Release_OnChange(this)", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div><br /><hr id='hr1'>")

        strHTML.Append("<div class='row'><div class='col-md-12'> <label for='defaultFormRegisterNameE' class='grey-text'>Select Sprint</label> <div class='input-group' ><span class='input-group-addon' style='background-color: #275482; border: 1px solid #275482;color:white;'><i class='fa fa-list' aria-hidden='true'></i></span>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ScrumIterations", "usp_NG2_sel_tbl_PM_ScrumIterations NULL," & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), ""), , intIterationID, "class='form-select' onchange=Sprint_OnChange(this)", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div><br /><hr id='hr2'>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='btn-group' id='DivfilterClear'  style='padding: 8px;'>")
        strHTML.Append("<i class='fa fa-filter' data-toggle='tooltip'  data-placement='bottom' title='Clear Filter' data-container='body' id='filterClear' onclick=ClearFilter(this)><i class='fa fa-remove'></i></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='col-md-5 col-sm-5 col-sm-6' style='margin-top: 75px;'>")
        strHTML.Append("<p style ='margin-top: 0px;margin-left:12px;'>Sprint Name : <span class='sprintname'></span></p></div>")
        strHTML.Append("<div class='col-md-7 col-sm-7 col-sm-6' style='float:right;'>")
        strHTML.Append("<p class='note'>Note: Cancelled user story(shown in Grey color) can not drag to next stage</p> ")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ''Added By Aniruddh Gujar on 18-Apr-2018 Purpose::To display the Sprint and Release Name
        'strHTML.Append("<div>")
        'strHTML.Append("<div class='row' style='margin-left:0px !important'>")
        'strHTML.Append("<div class='col-md-12'>")

        'strHTML.Append("<div class='col-lg-5 col-lg-offset-8 col-md-8 col-sm-12 col-sm-12'>")
        'strHTML.Append("<p class='ReleaseName'>Release Name : " & strReleaseName & "</p> ")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-lg-5 col-lg-offset-8 col-md-8 col-sm-12 col-sm-12'>")
        'strHTML.Append("<p class='SprintName'>Sprint Name : " & strIterationName & "</p> ")
        'strHTML.Append("</div>")

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        ''End of Added By Aniruddh Gujar on 18-Apr-2018 Purpose::To display the Sprint and Release Name

        Return strHTML.ToString

    End Function
    Private Function DrawMainSection() As String
        '=====================================================================
        ' Purpose				:	To plot the main section of page
        ' Author				:	Yogesh Jalamkar
        ' Created				:	26-Mar-2018.
        '=====================================================================

        Dim strHTML As New StringBuilder("")
        Dim drGetCustomStage As IDataReader

        Dim StrQuery As String = "usp_sel_tbl_NG2_ScrumStages " & Session("intProjectID") & "," & intIterationID & "," & intReleaseID

        Dim strUserStoriesSQL As String = ""

        Dim strStageName As String = ""
        Dim isCustom As String = ""
        Dim strOrderNo As String = ""
        Dim strStageColor As String = ""
        Dim FirstCustomStage As String = ""
        Dim strStageId As String = ""
        Dim strStageList As String = ""
        Dim strCustomStageList As String = ""
        Dim strStagIDwithoutFirst As String = ""
        drGetCustomStage = CommonFunctions.Data.GetDataReader(StrQuery, True)


        While drGetCustomStage.Read

            isCustom = CommonFunctions.Data.CheckIsDBNull(drGetCustomStage("IsCustom").ToString, "")
            strHTML.Append("<div class='inner' id='innder-" & drGetCustomStage("StageID") & "'>")
            strHTML.Append("<div class='col-lg-12 col-md-12 col-sm-12 col-sm-12'>")
            strHTML.Append("<div class='scrum-grid' >")
            strHTML.Append("<div class='scrum-title collapse fade in'>")
            If isCustom = "1" Then
                strHTML.Append("<a onclick=""Delete_Stage('" & CommonFunction.Data.CheckIsDBNull(drGetCustomStage("StageID"), "") & "')""><i class='fa fa-trash close-stage' style='display:none;'  title='Delete Stage' data-toggle='tooltip'data-placement='bottom' ></i></a>")
            End If


            'strHTML.Append("<i class='fa " & CommonFunction.Data.CheckIsDBNull(drGetCustomStage("Icon"), "") & " icon' style='color:" & CommonFunctions.General.CheckIsNothing(drGetCustomStage("Color"), "") & "'aria-hidden='true'></i>")

            If (CommonFunctions.Data.CheckIsDBNull(drGetCustomStage("StageName"), "") = "Completed") Then
                strHTML.Append("<i class='far fa-check-square icon' style='color:" & CommonFunctions.General.CheckIsNothing(drGetCustomStage("Color"), "") & "'aria-hidden='true'></i>")
            Else
                strHTML.Append("<i class='fa " & CommonFunction.Data.CheckIsDBNull(drGetCustomStage("Icon"), "") & " icon' style='color:" & CommonFunctions.General.CheckIsNothing(drGetCustomStage("Color"), "") & "'aria-hidden='true'></i>")
            End If


            strHTML.Append("<div>")
            If isCustom = "1" Then
                strHTML.Append("<p class='drag-text'><i class='far fa-hand-point-up drag-handler' aria-hidden='true'></i>Drag User Story between list <a onclick=Edit_Stage('" & CommonFunction.Data.CheckIsDBNull(drGetCustomStage("StageID"), "") & "') data-toggle='tooltip'data-placement='bottom' title='Edit Stage'><i class='fas fa-pencil-alt pencil' style='display:none;' ></i></a></p>")
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("myStories", "myStories", "form-control", , , , , "", , , , , "placeholder='search...'", True, , , , , , True))
            Else
                strHTML.Append("<p class='drag-text'><i class='far fa-hand-point-up drag-handler' aria-hidden='true'></i>Drag User Story between list </p>")
                If (CommonFunctions.General.CheckIsNothing(drGetCustomStage("StageID"), "") = "1") Then
                    strHTML.Append("<input type='search' name='search' id='myStories'placeholder='search...'/>")
                End If
            End If
            strHTML.Append("<input type=hidden id=hdnIterationID value='" & intIterationID & "'>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='scrum-content'>")
            strHTML.Append("<div class='scrum-header' style='background-color:" & CommonFunctions.General.CheckIsNothing(drGetCustomStage("Color"), "") & "'title='click to hide'>")
            If (CommonFunctions.Data.CheckIsDBNull(drGetCustomStage("StageName"), "").ToString.ToUpper.Length > 30) Then
                strHTML.Append("<center><p data-bs-toggle='collapse' data-bs-target='.collapse'>" & CommonFunctions.General.CheckIsNothing(drGetCustomStage("StageName"), "").Substring(0, 30) & "..</p></center>")
            Else
                strHTML.Append("<center><p data-bs-toggle='collapse' data-bs-target='.collapse'>" & CommonFunctions.General.CheckIsNothing(drGetCustomStage("StageName"), "") & "</p></center>")
            End If

            strHTML.Append("</div>")
            'strHTML.Append("<h5>" & CommonFunctions.General.CheckIsNothing(drGetCustomStage("Percentage"), "") & "%</h5>")
            strHTML.Append("<h5></h5>")
            strHTML.Append("</div>")


            strHTML.Append("<!--To Do list Drag Drop Card strat-->")
            strHTML.Append(GetUserStroy(CommonFunction.Data.CheckIsDBNull(drGetCustomStage("StageID"), ""), isCustom))
            strHTML.Append("<!--To Do list drag Dop Ends Here-->")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

        End While


        Return strHTML.ToString()

    End Function
    Private Function GetUserStroy(ByVal stageID As String, ByVal iscustom As String) As String
        '=====================================================================
        ' Purpose				:	To plot user stories for stages
        ' Author				:	Yogesh Jalamkar
        ' Created				:	26-Mar-2018.
        '=====================================================================


        Dim strHTML As New StringBuilder("")
        Dim drUserStory As IDataReader
        Dim strUserStorySQL As String
        strUserStorySQL = "usp_NG2_SEL_tbl_PM_ScrumBoard_ToDoList " & Session("intProjectID") & "," & intIterationID & "," & intReleaseID & "," & stageID
        drUserStory = CommonFunctions.Data.GetDataReader(strUserStorySQL, True)
        strHTML.Append("<div id='connectedSS'>")
        strHTML.Append("<div class='list divDraggable divstage' id='stage_" & stageID & "'  Iscustom=" & iscustom & ">")
        Dim ischecked As Integer = 0
        While drUserStory.Read
            ischecked = 1
            If (CommonFunction.Data.CheckIsDBNull(drUserStory("IsCancelledStory"), "0") = "1") Then
                strHTML.Append("<div class='scrum-stories' draggable='false' style='background:#d8d2d2' id='sortable_" & drUserStory("UserStoryID") & "_" & stageID & "'>")
            Else
                strHTML.Append("<div class='scrum-stories' draggable='true' id='sortable_" & drUserStory("UserStoryID") & "_" & stageID & "'>")
            End If

            If stageID = "1" Then
                strHTML.Append("<div class='scrum-stories-list to-do-list'>")
            Else
                strHTML.Append("<div class='scrum-stories-list'>")
            End If
            'Addedy By Yasmin S for user story no on 6th Feb 2018
            strHTML.Append("<div class='' style='cursor:pointer;'><b title='User Story ID' data-toggle='tooltip' data-placement='top' style='cursor:pointer;'><label id='lblUserStoryST' style='cursor:pointer;'>" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryID"), "") & "</label></b></div>")
            'strHTML.Append("<div class='clearfix'>")
            strHTML.Append("<div class='bottom-line'>")
            If CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString().Length > 50 Then
                'strHTML.Append("<p id='UserStoryName' data-toggle='tooltip' class='Description wordwrap'   title='User Story Name<br>" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString() & "'>" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString().Substring(0, 50) & "..." & "</p>")
                strHTML.Append("<p class='Description wordwrap' style='word-break: break-all;' id='UserStoryName' data-toggle='tooltip'   title=""User Story:" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString() & """ data-placement='bottom' data-container='body'>" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString() & "..." & "</p></div>") 'Added by Swapna

            Else
                'strHTML.Append("<p id='UserStoryName' data-toggle='tooltip' class='Description wordwrap' title='User Story Name<br>" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString() & "'>" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString() & "</p>")
                strHTML.Append("<p class='Description wordwrap' style='word-break: break-all;' id='UserStoryName' data-toggle='tooltip' title=""User Story:" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString() & """ data-placement='bottom' data-container='body'>" & CommonFunctions.Data.CheckIsDBNull(drUserStory("UserStoryName"), "").ToString() & "</p></div>") 'Added By Swapna

            End If

            strHTML.Append("<div class='row'>")
            If CommonFunction.Data.CheckIsDBNull(drUserStory("MaxEndDate"), "").ToString <> "" Then
                strHTML.Append(" <span class='col-md-6' data-toggle='tooltip' title='End Date of Task' style='cursor: pointer;'>")
                strHTML.Append("<i class='far fa-clock drag-handler' aria-hidden='true'></i> " & CommonFunction.Dates.GetDate(drUserStory("MaxEndDate")) & "")
                strHTML.Append("</span>")
            Else
                strHTML.Append(" <span class='col-md-6' data-toggle='tooltip' title='End Date of Task'  style='cursor: pointer;'>")
                strHTML.Append("<i class='far fa-clock drag-handler' aria-hidden='true'></i> " & CommonFunction.Data.CheckIsDBNull(drUserStory("MaxEndDate"), "") & "")
                strHTML.Append("</span>")
            End If
            strHTML.Append("<span class='col-md-2' data-toggle='tooltip' title='Story Point'  style='cursor: pointer;'>" & CommonFunction.Data.CheckIsDBNull(drUserStory("InitialEstimate"), "") & "</span>")
            strHTML.Append("<span class='task-high-priority col-md-2' style='color:" & CommonFunction.Data.CheckIsDBNull(drUserStory("PriorityColor"), "") & "'><i class='fa fa-flag' aria-hidden='true'data-toggle='tooltip' title='Priority : " & CommonFunction.Data.CheckIsDBNull(drUserStory("Priority"), "") & "'></i></span>")
            strHTML.Append("<span class='col-md-2'><i Class='fas fa-arrows-alt drag-drop-popup 'aria-hidden='true' onclick=Open_DragPopUp('" & CommonFunction.Data.CheckIsDBNull(drUserStory("UserStoryID"), "") & "','" & stageID & "','" & iscustom & "')  title='Drag & Drop'  style='float:right;'></i></span>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

        End While


        If ischecked <> 1 Then
            strHTML.Append("<p style='text-align: center!important;' class='nodrop'>There are no items to show in this view </p>")
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetIterationName(ByVal ReleaseID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetIterationName
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   26-Mar-2018.
        '=====================================================================

        Try

            Dim strHTML As New StringBuilder
            Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumIterations " & IIf(ReleaseID = "", "null", ReleaseID) & "," & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")

            Dim intIterationID As Integer
            Dim strIterationName As String
            Dim strStartDate As String
            Dim strEndDate As String
            Dim strIterationName1 As String = ""
            Dim strCurrentIteration As String = ""
            Dim drIteration As IDataReader
            drIteration = CommonFunctions.Data.GetDataReader(strSql, True)


            While drIteration.Read()
                strHTML.Append(drIteration("IterationID").ToString())
                strHTML.Append(",")
                strHTML.Append(drIteration("IterationName").ToString())
                strHTML.Append("$$")

            End While



            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function PlotUserStories(ByVal ReleaseID As String, ByVal IterationID As String) As String
        '=====================================================================
        ' Procedure  Name		:	PlotUserStories
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   26-Mar-2018.
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder("")
            Dim objfrmScrumBoard As New frmScrumBoard()
            If (IterationID <> "") Then
                intIterationID = IterationID
            End If
            If (ReleaseID <> "") Then
                intReleaseID = ReleaseID
            End If


            strHTML.Append(objfrmScrumBoard.DrawMainSection())
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateLogPersonAccessUserStory(ByVal UserStoryID As String) As String
        '=====================================================================
        ' Procedure  Name		:	ValidateLogPersonAccessUserStory
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================
        Try

            Dim strQuery As String = ""
            Dim strMessage As String = ""
            Dim drGetValidation As IDataReader
            Dim strResult As String = ""

            strQuery = "usp_NG2_chk_UserAssociatedWithUserStory " & UserStoryID & ",'" & HttpContext.Current.Session("intUserID") & "'"


            drGetValidation = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drGetValidation.Read
                strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation("Result").ToString, "")
            End While
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DropValidation(ByVal UserStoryID As String, ByVal StageID As String, ByVal Mode As String, ByVal IssueOpenFlag As String) As String
        '=====================================================================
        ' Procedure  Name		:	DropInProgressValidation
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				: Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================

        Dim strQuery As String = ""
        Dim strMessage As String = ""
        Dim drGetValidation As IDataReader
        Dim drGetValidation1 As IDataReader
        Dim strResult As String = ""
        Dim strResult1 As String = ""


        If IssueOpenFlag = "1" Then
            strQuery = "usp_NG2_chk_IssueOpenForUserStory " & UserStoryID & ""
            drGetValidation1 = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drGetValidation1.Read
                strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation1("Result").ToString, "")
            End While

            If strResult = "" Then
                If Mode = "InProgress" Then
                    strQuery = "usp_NG2_chk_TaskMappedToUserstory " & UserStoryID & ""
                ElseIf Mode = "Completed" Then
                    strQuery = "usp_NG2_chk_AllowToCompleteUserStory " & UserStoryID & ",'" & HttpContext.Current.Session("intUserID") & "'"
                End If
                drGetValidation = CommonFunctions.Data.GetDataReader(strQuery, True)
                While drGetValidation.Read
                    strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation("Result").ToString, "")
                End While
                Return strResult
            Else
                Return strResult
            End If



        End If


        If strResult = "" Then
            If Mode = "InProgress" Then
                strQuery = "usp_NG2_chk_TaskMappedToUserstory " & UserStoryID & ""
            ElseIf Mode = "Completed" Then
                strQuery = "usp_NG2_chk_AllowToCompleteUserStory " & UserStoryID & ",'" & HttpContext.Current.Session("intUserID") & "'"
            End If
            drGetValidation = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drGetValidation.Read
                strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation("Result").ToString, "")
            End While
            Return strResult
        End If


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateStageID(ByVal UserStoryID As String, ByVal StageID As String, ByVal Mode As String) As String
        '=====================================================================
        ' Procedure  Name		:	UpdateStageID
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================

        Dim strQuery As String = ""
        Dim strResult As String = ""
        Dim strFlag As String = "0"

        Try


            Dim strValidationResult As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_IsSprintCompleted " & UserStoryID, True), "")

            If strValidationResult = "" Then
                strQuery = "usp_NG2_upd_tbl_PM_ScrumBoardUserStories " & UserStoryID & "," & StageID & ",'" & HttpContext.Current.Session("strUserName") & "'"


                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

                strFlag = "1"
            Else
                strFlag = strValidationResult
            End If
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function AddStage(ByVal StageID As String, ByVal StageName As String, ByVal stageposition As String, ByVal stagebackgroundcolor As String, ByVal stageicon As String) As String
        '=====================================================================
        ' Procedure  Name		:	AddStage
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================

        Dim strQuery As String = ""
        Dim strResult As String = ""
        Dim strFlag As String = "0"

        Try

            strQuery = "usp_INS_tbl_NG2_ScrumStages " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("IntProjectID"), "") & ",'" & StageName & "','" & HttpContext.Current.Session("strUserName") & "'"
            If stageposition <> "" Then
                strQuery += "," & stageposition & ""
            Else
                stageposition += ",null"
            End If

            If stagebackgroundcolor <> "" Then
                strQuery += ",'" & stagebackgroundcolor & "'"
            Else
                strQuery += ",null"
            End If
            If stageicon <> "" Then
                strQuery += ",'" & stageicon & "'"
            Else
                strQuery += ",null"
            End If
            If (StageID <> "") Then
                strQuery += "," & StageID
            Else
                strQuery += ",null"
            End If

            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            strFlag = "1"

            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function IsStageNameExists(ByVal StageName As String, ByVal StageID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsStageNameExists
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	To check whether stage name already exists
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================

        Dim strQuery As String = ""
        Dim strResult As String = ""
        Dim strFlag As String = ""

        Try

            strQuery = "usp_NG2_chk_DuplicateStageName " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("IntProjectID"), "") & ",'" & StageName & "'"
            If StageID = "" Then
                strQuery += ",null"
            Else
                strQuery += "," & StageID

            End If

            strFlag = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "")


            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowEditStage(ByVal StageID As String) As String
        '=====================================================================
        ' Procedure  Name		:	ShowEditStage
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	To show details of stage
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder()
            Dim StrQuery As String = "usp_sel_tbl_NG2_ScrumStages " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "") & ",null,null," & StageID
            Dim strStageName As String = ""
            Dim strStagePosition As String = ""
            Dim strStageColor As String = ""
            Dim strStageIcon As String = ""
            Dim strStageID As String
            Dim drStage As IDataReader
            drStage = CommonFunction.Data.GetDataReader(StrQuery, True)
            If drStage.Read() Then
                strStageID = CommonFunctions.Data.CheckIsDBNull(drStage("StageID"), "")
                strStageName = CommonFunctions.Data.CheckIsDBNull(drStage("StageName"), "")
                strStagePosition = CommonFunctions.Data.CheckIsDBNull(drStage("OrderNo"), "")
                strStageColor = CommonFunctions.Data.CheckIsDBNull(drStage("Color"), "")
                strStageIcon = CommonFunctions.Data.CheckIsDBNull(drStage("Icon"), "")

            End If

            strHTML.Append("<form>")
            strHTML.Append("<div class='input-group stage-divide' data-toggle='tooltip' title='Please enter stage name' data-placement='bottom'>")
            strHTML.Append("<span class='input-group-addon stage-info'  ><i class='fa fa-edit'></i></span>")

            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("activityname", "activityname", "form-control", , , strStageName, , "", , , , , "placeholder='Please enter the text for custom stage' required", True, , , , , , True))
            strHTML.Append("</div>")
            strHTML.Append("<div class='input-group stage-divide' data-toggle='tooltip' title='Please specify position of stage' data-placement='bottom'>")
            strHTML.Append("<span class='input-group-addon stage-info'  data-toggle='tooltip'><i class='fa fa-dot-circle-o'></i></span>")

            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("activityposition", "activityposition", "form-control", , , strStagePosition, , "", , , , , "placeholder='Please specify position of stage' required", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("activityposition", "usp_NG2_Sel_StagePosition ", , strStagePosition, "class='form-control'", True, True))
            strHTML.Append("</div>")
            strHTML.Append("<div class='' data-toggle='tooltip' title='Select background color for text & icon' data-placement='bottom'>")
            strHTML.Append("<div class='input-group col-md-6 col-sm-6 col-sm-6' style='float: left!important;' >")
            strHTML.Append("<span class='input-group-addon stage-info'  data-toggle='tooltip'><i class='fa fa-paint-brush'></i></span>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append(" <div class='form-control'>&nbsp;<a id='stagebackgroundcolor' value='" & strStageColor & "'  data-bs-toggle='dropdown' title='Select Priority Color' style='cursor:pointer;color:" & strStageColor & "'  ><i id='iScrumStage' style=' font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
            strHTML.Append("<table class='table table-bordered' id='tblPriorityColor'>")
            strHTML.Append(GetColorMaster(strStageID, "Stage"))
            strHTML.Append("</table>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")

            strHTML.Append("<div class='input-group stage-divide col-md-6 col-sm-6 col-sm-6'>")
            strHTML.Append("<input type='text' class='form-control' placeholder='Select background color for text & icon' disabled />")

            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='input-group stage-divide' title='Please select icon for custom stage' data-toggle='tooltip' data-placement:'bottom'>")
            strHTML.Append("<span class='input-group-addon stage-info' ><i class='fa fa-hand-pointer-o' aria-hidden='true'></i></span>")
            'strHTML.Append("<input type='text' class='form-control' placeholder='Please give a icon for stage' disabled />")
            '<input type="text" name="fruit_txt" class="name" style="display: none;" />

            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtactivityicon", "txtactivityicon", "form-control", , , strStageIcon, , "", , , , , "placeholder='Please give a icon for stage' ", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("activityicon", "usp_NG2_GETIconsForScrumBoard ", , strStageIcon, "class='form-control' onchange='IconSelect_Onchange(this)'", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtactivityicon", "txtactivityicon", "form-control", , , strStageIcon, , "", , , , , "", True, , , , , , True))
            strHTML.Append("</div>")
            strHTML.Append("<div class='input-group col-md-12 col-sm-12 col-sm-12 align-center'>")
            strHTML.Append("<button type='button' class='btn btn-default submit-btn' name='addDynamicstage' value='Apply' onclick=Save_Stage('" & StageID & "') style='float:right'> Apply </button>")

            strHTML.Append("</div>")
            strHTML.Append("</form>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetColorMaster(ByVal Id As String, ByVal strMode As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteStage
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	To delete custom stage
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yasmin Shaikh
        ' Created				:   02-Apr-2018
        '=====================================================================
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
                'Commented & Added By Dipali V On 19th April 2018 For Color Picker Issue Fixing
                'If index = 10 Then
                If index = 18 Then
                    strHTML.Append("</tr>")
                    strHTML.Append("<tr>")
                    index = 0
                End If
                'End of Commented & Added By Dipali V On 19th April 2018 For Color Picker Issue Fixing

            End While
            strHTML.Append("</tr>")


            Return strHTML.ToString
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
        ' Author				:	Aniruddh Gujar
        ' Created				:   03-Apr-2018
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
        If mode = "Stage" Then
            Return 5
        End If
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteStage(ByVal StageID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteStage
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	To delete custom stage
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================
        Dim strFlag As String
        Dim strSQL As String = "usp_NG2_chk_AllowToDeleteScrumStages " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("IntProjectID"), "0") & "," & StageID
        Try
            strFlag = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True))
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEntityName(ByVal IterationID As String, ByVal ReleaseID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetEntityName
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	To delete custom stage
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================
        Dim strFlag As String
        Dim strSQL As String = "usp_NG2_chk_GetEntityNames " & IterationID & "," & ReleaseID
        Try
            strFlag = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True))
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function PlotDragDrop(ByVal UserStoryID As String, ByVal StageID As String, ByVal IsCustom As String) As String
        '=====================================================================
        ' Procedure  Name		:	PlotDragDrop
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	To plot drag drop page
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================
        Try

            Dim strFlag As String
            Dim strHTML As New StringBuilder("")
            strHTML.Append("<form>")
            strHTML.Append("<div class='input-group stage-divide' data-toggle='tooltip' title='Select stage to drop'>")
            strHTML.Append("<span class='input-group-addon stage-info'>")
            strHTML.Append("<i class='fa fa-list'></i>")
            strHTML.Append("</span>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ScrumStages", "usp_NG2_Sel_ScrumStages " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "") & "," & StageID, , , "class='form-control' ", True, True))
            strHTML.Append("</div>")

            strHTML.Append(" <div class='input-group col-md-12 col-sm-12 col-sm-12 align-center'>")

            strHTML.Append("<button type='button' class='btn btn-default submit-btn' name='setPosition' value='Apply' onclick=DragDrop_Onclick(" & UserStoryID & "," & StageID & "," & IsCustom & ")> Save </button>")
            strHTML.Append("</div>")
            strHTML.Append("</form>")

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ClearFilter() As String
        '=====================================================================
        ' Procedure  Name		:	GetIterationName
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   26-Mar-2018.
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder("")
            'Dim strSql As String = "usp_NG2_sel_CurrentReleaseAndIteration " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
            'Dim drCurrentDetails As IDataReader
            Dim objfrmScrumBoard As New frmScrumBoard()
            'drCurrentDetails = CommonFunctions.Data.GetDataReader(strSql, True)
            'While drCurrentDetails.Read()
            '    intIterationID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("CurrentIteration"), "0")
            '    intReleaseID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("ReleaseID"), "0")

            'End While

            'strHTML.Append(objfrmScrumBoard.DrawMainSection())
            strHTML.Append(objfrmScrumBoard.WritePage("1"))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function



    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshPageAfterDraging() As String
        '=====================================================================
        ' Procedure  Name		:	RefreshPageAfterDraging
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   9th June 2018.
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder("")
            Dim objfrmScrumBoard As New frmScrumBoard()
            strHTML.Append(objfrmScrumBoard.DrawMainSection())
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
End Class