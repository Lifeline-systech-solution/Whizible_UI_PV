
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


Partial Public Class WhizProcessDetails

    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Form Actions"
    Private Const ACTION_DELETE As String = "DELETE"
    Private Const ACTION_MODIFY As String = "MODIFY"
    Private Const ACTION_GET_LATEST As String = "GETLATEST"
    Private Const MODE_VIEW As String = "VIEW"
    Private Const ACTION_DELETE_PROCESS = "DELETEPROCESS"
    Private Const ACTION_DELETE_PROJECT_TYPE = "DELETEPROJECTTYPE"
    Private Const ACTION_PUBLISH_PROCESS As String = "PUBLISHPROCESS"
#End Region

#Region "Private Variables"
    Protected strLevelIdentifier As String = ""
    Private objSTBuilder As System.Text.StringBuilder = Nothing
    Private objDS As DataSet = Nothing
    Private strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Private blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
    Protected strMode As String
    Dim strFromWhere As String
#End Region

#Region "All Templates Table Constants"
    Private Const TEMPLATE_MAIN As String = "Templates"
    Private Const TEMPLATE_DESCRIPTION As String = "Description"
    Private Const COL_TEMPLATE_TITLE As String = "Title"
    Private Const COL_TEMPLATE_DESCRIPTION As String = "Description"
    Private Const COL_TEMPLATE_REVISION_DATE As String = "Revision Date"
    Private Const TEMPLATE_HEADER As String = "Define Templates"
    Private Const TEMPLATE_MENU_ADD As String = "Add Template"
#End Region

#Region "All Guidelines Table Constants"
    Private Const GUIDELINE_MAIN As String = "Guidelines"
    Private Const COL_GUIDELINE_DESCRIPTION As String = "Description"
    Private Const GUIDELINE_HEADER As String = "Define Guidelines"
    Private Const GUIDELINE_MENU_ADD As String = "Add Guideline"
    Private Const COL_GUIDELINE_TITLE As String = "Guideline Title"
    Private Const COL_GUIDELINE_SCOPE As String = "Scope"
    Private Const COL_GUIDELINE_OBJECTIVE As String = "Objective"
    Private Const COL_GUIDELINE_DETAILS As String = "Guideline Details"
    Private Const COL_GUIDELINE_REVISION_NO As String = "Revision Number"
#End Region

#Region "All Checklists Table Constants"
    Private Const CHECKLIST_HEADER As String = "Define CheckLists"
    Private Const CHECKLIST_MENU_ADD As String = "Add Checklist"
    Private Const CHECKLIST_MAIN As String = "Checklists"
    Private Const COL_CHECKLIST_DESCRIPTION As String = "Description"
    Private Const COL_CHECKLIST_REVISION_NO As String = "Revision No"
    Private Const COL_CHECKLIST_NAME As String = "Checklist"
    Private Const COL_CHECKLIST_GROUP As String = "Group"
    Private Const CAP_CHECKLIST_ITEM As String = "Checklist Item"
    'private const string CAP_CHECKLIST_ITEM = "Checklist Item";
#End Region

#Region "All Metrics Table Constatns"
    Private Const METRICS_MAIN As String = "Metrics"
    Private Const COL_METRICS_DESCRIPTION As String = "Description"
    Private Const METRICS_HEADER As String = "Define Metrics"
    Private Const METRICS_MENU_ADD As String = "Add Metric"
    Private Const COL_METRICS_NAME As String = "Metric Name"
    Private Const COL_METRICS_SHORT_NAME As String = "Short Name"
    Private Const COL_METRICS_CATEGORY As String = "Metric Category"
    Private Const COL_METRICS_UCL As String = "Upper Control Limit (UCL)"
    Private Const COL_METRICS_LCL As String = "Lower ControlLimit (LCL)"
    Private Const COL_METRICS_UNIT As String = "Unit"
    Private Const COL_METRICS_DESC As String = "Description"
    Private Const COL_METRICS_GUIDELINE As String = "Guidelines"
    Private Const COL_METRICS_OULEVEL As String = "Is OU Level"
    Private Const COL_METRICS_ACTIVE As String = "Is Active"

#End Region

#Region "All Process Table Constatans"
    Private Const PROCESS_MAIN As String = "Processes"
    Private Const PROCESS_HEADER As String = " Process"
    Private Const PROCESSES_HEADER As String = "Define Processes"
    Private Const COL_PROCESS_DESCRIPTION As String = "Description"
    Private Const COL_PROCESS_ENTRYCRITERIA As String = "Enrtry Criteria"
    Private Const COL_PROCESS_EXITCRITERIA As String = "Exit Criteria"
    Private Const COL_PROCESS_MEASUREMENT As String = "Measurement"
    Private Const COL_PROCESS_REVISION_NO As String = "Revision Number"
    Private Const COL_PROCESS_ORDER_NO As String = "Order Number"
    'Process related menus
    Private Const MNU_PROCESS_ADD As String = "Add Process"
#End Region
#Region "All Project Type Constants"
    Private Const PROJECT_TYPE_MAIN As String = "Project Types"
    Private Const PROJECT_TYPE_HEADER As String = " Project Type"
    Private Const COL_PROJECT_TYPES_HEADER As String = "Project Type"
    Private Const COL_PROJECT_TYPE_DESCRIPTION As String = "Description"
    'Process related menus
    Private Const MNU_PROJECT_TYPE_ADD As String = "Add Project Type"

#End Region

#Region "All Activity Table Constants"
    Private Const ACTIVITY_MAIN As String = "Activity"
    Private Const ACTIVITY_HEADER As String = "Activities"
    Private Const COL_ACTIVITY_TITLE As String = "Activity Name"
    Private Const COL_ACTIVITY_OBJECTIVE As String = "Objective"
    Private Const COL_ACTIVITY_SCOPE As String = "Scope"
    Private Const COL_ACTIVITY_INPUT_CRITERIA As String = "Input Criteria"
    Private Const COL_ACTIVITY_INPUTS As String = "Inputs"
    Private Const COL_ACTIVITY_DETAILS As String = "Activity Details"
    Private Const COL_ACTIVITY_EXIT_CRITERIA As String = "Exit Criteria"
    Private Const COL_ACTIVITY_STAGEID As String = "Activity ID"
    Private Const COL_ACTIVITY_ASSOCIATED_CHECKLISTS As String = "Associated Checklists"
    Private Const COL_ACTIVITY_ASSOCIATED_GUIDELINES As String = "Associated Guidelines"
    Private Const COL_ACTIVITY_ASSOCIATED_TEMPLATES As String = "Associated Templates"
    Private Const CAP_ACTIVITY_TAILORING_AND_DEVIATION As String = "Tailoring /Deviation"
    Private Const CAP_ACTIVITY_PROJECT_SPECIFIC_TEMPLATES As String = "Project Specific Templates"
    'Activity realted menus
    Private Const MNU_ACTIVITY_ADD As String = "Add Activity"
#End Region

#Region "All Help Constants"

    Private Const ACTIVITY_HELP As String = "Process_List"
    Private Const PROCESS_HELP As String = "Process_List"
    Private Const TASK_HELP As String = "Activity_Task_List"
    Private Const PROCESS_TEMPLATE_HELP As String = "1041"
    Private Const PROCESS_GUIDELINES_HELP As String = "658"
    Private Const PROCESS_CHECKLISTS_HELP As String = "2160"
    Private Const PROCESS_METRICS_HELP As String = "676"

#End Region


#Region "Constants"
    Private Const HELP_MENU As String = "?"
    Private Const NO_RECORD As String = "There are no items to show in this view"

#End Region

#Region "Process @ Project"
    Private Const CAP_GET_LATEST_REVISION = "Get Latest Version"
    Private Const CAP_LATEST_REVISION = "Latest Version"
    Private Const CAP_VIEW_DETAILS = "View Details"
    Private Const PROCESS_AT_PROJECT_HELP = "2132"
#End Region

#Region "All Tasks Constants"
    Private Const TASK_HEADER As String = "Tasks"
    Private Const COL_TASK_NAME As String = "Activity Name"
    Private Const COL_TASK_WORK_HRS As String = "Duration"
#End Region



#Region "All Common Menus"
    Private MNU_MODIFY As String = "Modify"
    Private MNU_DELETE As String = "Delete"
    Private MNU_PUBLISH As String = "Publish"
    Private MNU_PUBLISHED As String = "Published"
#End Region



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        Dim strAction As String = ""
        objSTBuilder = Nothing

        If Not Request.QueryString("MODE") Is Nothing Then
            strMode = Request.QueryString("MODE").ToString()
        End If

        If Not (Request.QueryString("PKID") Is Nothing) Then
            strLevelIdentifier = Request.QueryString("PKID").ToString()
            'Check if user wants to delete the record
            If Not (Request.QueryString("ACTION") Is Nothing) Then
                strAction = Request.QueryString("ACTION").ToString()
                If strAction = ACTION_DELETE Then
                    Dim strItemID As String = Request.QueryString("ItemID").ToString()
                    DeleteItem(strLevelIdentifier, strItemID)
                ElseIf strAction = ACTION_GET_LATEST Then
                    GetLatestProcessDetails()
                ElseIf strAction = ACTION_DELETE_PROCESS Then
                    DeleteProcess()
                ElseIf strAction = ACTION_PUBLISH_PROCESS Then
                    PublishChecklist()
                End If
            End If
        End If

        ' If view Document is called 
        If Not IsNothing(Request.QueryString.Get("DocumentMode")) Then
            Dim MasterTagID As String = Request.QueryString.Get("MasterTagID").ToString()
            Dim RecordID As String = Request.QueryString.Get("RecordID").ToString()
            Dim ProjectID As String = Request.QueryString.Get("ProjectID").ToString()
            Dim DocumentMode As String = Request.QueryString.Get("DocumentMode").ToString()
            Dim strProjectServerURL As String

            'Dim objSharePointDocumentLibrary As New SharePointDocumentLibrary

            'If DocumentMode.ToUpper() = "DOWNLOAD" Then
            '    Dim UploadedFilesID As String = Request.QueryString.Get("UploadedFilesID").ToString()
            '    Dim UploadedFileGUID As String = Request.QueryString.Get("UploadedFileGUID").ToString()
            '    Dim DocumentLibraryGUID As String = Request.QueryString.Get("DocumentLibraryGUID").ToString()
            '    Dim StrFileName As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT FileName FROM tbl_SP_UploadedFiles WHERE UploadedFilesID= " + UploadedFilesID, blnUseSQL, strConnectionString), "")
            '    strProjectServerURL = WhizDocManagement.ProjectServerURL(MasterTagID, RecordID, ProjectID)
            '    HttpContext.Current.Response.Write("strProjectServerURL " + strProjectServerURL)
            '    WhizDocManagement.DownloadFile(DocumentLibraryGUID, UploadedFileGUID, StrFileName, strProjectServerURL)
            'End If

        End If
    End Sub 'Page_Load
    'GeneratePage(strLevelIdentifier);
    Protected Sub PublishChecklist()
        Dim strApprovedBy As String = ""
        Dim strRevisedBy As String = ""
        Dim strRevisionDate As String = ""
        Dim dtRevisionDate As DateTime = System.DateTime.Now
        Dim strReason As String = ""
        Dim strRevisionNo As String = "0"


        Dim strSQL As String = ""

        strSQL = "usp_Ins_tbl_Q_Questionnaire_Revision " + CommonFunction.General.CheckIsNothing(Request.QueryString.Get("UniqueID")) + ","

        strSQL += "N'" + Session("strUserName") + "'"



        CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

        Response.Write((" <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
        Response.Write(" window.location.href= ""WhizProcessDetails.aspx?PKID=0|CS"";")
        Response.Write(" </script>")

    End Sub
    Protected Sub DeleteItem(ByVal strPKID As String, ByVal strItemID As String)
        WhizProcessFunctions.DeleteRecord(strPKID, strItemID)
    End Sub 'DeleteItem


    Protected Sub GeneratePage(ByVal PKID As String)
        strFromWhere = Request.QueryString.Get("FROMWHERE")
        If strFromWhere = "" Then
            'fill the dataset depending on PKID
            WhizProcessFunctions.GenerateDynamicDataSet(objDS, PKID)
            If objDS.Tables.Count <> 0 Then

                Dim chr(0) As Char
                chr(0) = System.Convert.ToChar("|")
                Dim arrVal As String() = PKID.Split(chr)
                'Set default properties of the grid
                objSTBuilder = New System.Text.StringBuilder()
                If arrVal.Length > 1 Then 'Clicked in one of the hierarchy node
                    objSTBuilder = New System.Text.StringBuilder()
                    Select Case arrVal(1)
                        Case "PS"
                            'User wants to view all processes
                            'DefinitionHelpTable(PROCESS_MAIN, COL_PROCESS_DESCRIPTION)
                            DefinitionHelpTable(PROCESS_MAIN, "")
                            ShowAllProcesses()
                        Case "P"
                            'User wants to view all activities
                            ShowSelectedProcessDetails()
                            ShowAllActivities()
                        Case "AS"
                            ShowSelectedActivity()
                            'user wants to view all tasks
                            ShowAllTasks()
                        Case "TS"
                            'DefinitionHelpTable(TEMPLATE_MAIN, TEMPLATE_DESCRIPTION)
                            DefinitionHelpTable(TEMPLATE_MAIN, "")
                            ShowAllTemplates()
                        Case "T"
                            ShowSelectedTemplate()
                        Case "GS"
                            'DefinitionHelpTable(GUIDELINE_MAIN, COL_GUIDELINE_DESCRIPTION)
                            DefinitionHelpTable(GUIDELINE_MAIN, "")
                            ShowAllGuidelines()
                        Case "G"
                            ShowSelectedGuidelineDetails()
                        Case "CS"
                            'DefinitionHelpTable(CHECKLIST_MAIN, COL_CHECKLIST_DESCRIPTION)
                            DefinitionHelpTable(CHECKLIST_MAIN, "")
                            ShowAllChecklists()
                        Case "C"
                            ShowSelectedChecklist()
                        Case "MS"
                            'DefinitionHelpTable(METRICS_MAIN, COL_METRICS_DESCRIPTION)
                            DefinitionHelpTable(METRICS_MAIN, "")
                            ShowAllMetrics()
                        Case "PT"
                            'DefinitionHelpTable(PROJECT_TYPE_MAIN, COL_PROJECT_TYPE_DESCRIPTION)
                            DefinitionHelpTable(PROJECT_TYPE_MAIN, "")
                            ShowAllProjectTypes()
                    End Select
                    SetPageCaption(PKID)
                    Response.Write(objSTBuilder.ToString())
                    'Clicked on ROOT node
                Else
                    ShowQualityCenterHelp()
                End If

                If Not (objSTBuilder Is Nothing) Then
                    objSTBuilder = Nothing
                End If
            End If
        ElseIf strFromWhere = "PM" Then
            ' Show Project Process Details 
            ShowProjectProcessDetails(PKID)

        End If
    End Sub 'GeneratePage

    Protected Sub SetPageCaption(ByVal PKID As String)
        Dim chr(0) As Char
        chr(0) = System.Convert.ToChar("|")
        Dim arrVal As String() = PKID.Split(chr)
        Dim strPageCaption As String = ""
        Select Case arrVal(1)
            Case "PS"
                'User wants to view all processes
                strPageCaption = PROCESS_MAIN
            Case "P"
                strPageCaption = PROCESS_HEADER
                'User wants to view all activities
            Case "AS"
                strPageCaption = ACTIVITY_MAIN
                'user wants to view all tasks
            Case "TS"
                strPageCaption = TEMPLATE_MAIN
            Case "GS"
                strPageCaption = GUIDELINE_MAIN
            Case "G"
                strPageCaption = GUIDELINE_HEADER
            Case "CS"
                strPageCaption = CHECKLIST_MAIN
            Case "C"
                strPageCaption = CHECKLIST_HEADER
            Case "MS"
                strPageCaption = METRICS_MAIN
            Case "PT"
                strPageCaption = PROJECT_TYPE_MAIN
        End Select
        objSTBuilder.Append(" <script language = ""javascript"" type=""text/javascript"" >")
        objSTBuilder.Append(("window.document.title=""" + strPageCaption + """;"))
        objSTBuilder.Append("</script>")
    End Sub 'SetPageCaption
#Region "Task Details"

    Private Sub ShowAllTasks()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawTaskTableActionLinks(TASK_HEADER)

        objSTBuilder.Append(" <table accesskey='.' class='XmlGridTable' cellspacing='0' rules='all' SelectionType='RowOnly' AllowRowDelete='False' AllowRowInsert='False' AllowMultiSelect='False' border='1' style='margin-left:20 px;border-color:#99AFCB;border-width:1px;border-style:solid;width:95%;border-collapse:collapse;behavior:url(/_layouts/PWA/Library/XMLGrid.htc);table-layout:fixed;'>")
        DrawTaskTableHeader()
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(1).Rows
            Dim intActivityTaskID As Integer = 0
            Dim strTaskName As String = ""
            Dim dblDuration As Double = 0.0

            intActivityTaskID = System.Convert.ToInt32(objDR("ActivityTaskID"))
            If Not (objDR("TaskName") Is Nothing) Then
                strTaskName = System.Convert.ToString(objDR("TaskName"))
            End If
            If Not (objDR("Work") Is Nothing) Then
                dblDuration = System.Convert.ToDouble(objDR("Work"))
            End If
            DrawTaskTableRow(intActivityTaskID, strTaskName, dblDuration)
            intRowID += 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td colspan=>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        objSTBuilder.Append("</table>")
    End Sub 'ShowAllTasks
#End Region


#Region "Quality Details"

    Private Sub ShowQualityCenterHelp()
    End Sub 'ShowQualityCenterHelp

#End Region

#Region "Activity Details"

    Private Sub ShowSelectedActivity()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(ACTIVITY_HEADER, "&nbsp;")
        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        Dim objDR As DataRow = objDS.Tables(0).Rows(0)
        DrawGroupLine()
        objSTBuilder.Append("<tr>")
        strUniqueID = "objParentSection" + System.Convert.ToString(intRowID)
        DrawGroupHeaderColumn(System.Convert.ToString(objDR("Title")), strUniqueID, True)
        'Show Process details in other td
        objSTBuilder.Append("<td>")
        'Div to show and hide this section
        objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
        objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
        'first column information
        DrawColumnHeaderRow(COL_ACTIVITY_OBJECTIVE)
        If Not (objDR("Objective") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Objective"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_ACTIVITY_SCOPE)
        If Not (objDR("Scope") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Scope"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_ACTIVITY_INPUT_CRITERIA)
        If Not (objDR("InputCriteria") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("InputCriteria"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_ACTIVITY_INPUTS)
        If Not (objDR("Inputs") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Inputs"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_ACTIVITY_DETAILS)
        If Not (objDR("Description") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Description"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_ACTIVITY_EXIT_CRITERIA)
        If Not (objDR("ExitCriteria") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("ExitCriteria"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        objSTBuilder.Append("</table>")
        objSTBuilder.Append("</div>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        intRowID = intRowID + 1
        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'ShowSelectedActivity


    Private Sub ShowAllActivities()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        If strMode = MODE_VIEW Then
            DrawHeading(ACTIVITY_HEADER, "")
        Else
            DrawHeading(ACTIVITY_HEADER, MNU_ACTIVITY_ADD)
        End If

        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(1).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSection" + System.Convert.ToString(intRowID)
            If strMode = MODE_VIEW Then
                DrawGroupHeaderColumn(System.Convert.ToString(objDR("Title")), strUniqueID, True)
            Else
                DrawGroupHeaderColumn(System.Convert.ToString(objDR("Title")), strUniqueID)
            End If

            'Show Process details in other td
            objSTBuilder.Append("<td>")
            'Div to show and hide this section
            If strMode = MODE_VIEW Then
                objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
            Else
                objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:none'>"))
            End If

            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")

            'Show modify and delete links
            If strMode <> MODE_VIEW Then
                ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("ActivityID")))
            End If

            'first column information
            DrawColumnHeaderRow(COL_ACTIVITY_OBJECTIVE)
            If Not (objDR("Objective") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Objective"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_SCOPE)
            If Not (objDR("Scope") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Scope"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_INPUT_CRITERIA)
            If Not (objDR("InputCriteria") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("InputCriteria"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_INPUTS)
            If Not (objDR("Inputs") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Inputs"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_DETAILS)
            If Not (objDR("Description") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Description"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_EXIT_CRITERIA)
            If Not (objDR("ExitCriteria") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("ExitCriteria"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            ' show Associated Guidelines
            DrawColumnHeaderRow(COL_ACTIVITY_ASSOCIATED_GUIDELINES)
            ShowAssociatedGuidelines(objDR("ActivityID").ToString())

            ' show Assoicated Checklists
            DrawColumnHeaderRow(COL_ACTIVITY_ASSOCIATED_CHECKLISTS)
            ShowAssociatedChecklists(objDR("ActivityID").ToString())

            ' show Associated Templates
            DrawColumnHeaderRow(COL_ACTIVITY_ASSOCIATED_TEMPLATES)
            ShowAssociatedTemplates(objDR("ActivityID").ToString(), objDR("ProcessID").ToString())


            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            intRowID = intRowID + 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            objSTBuilder.Append("<tr><td style='text-align:center'>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'ShowAllActivities


    Protected Sub ShowAssociatedGuidelines(ByVal strActivityID As String)
        Dim intAssocitedRecordExists As Integer = 0
        Dim objDr As IDataReader
        Dim WAF_objDR As New CommonFunctions.Data.WAF_DataReader()
        WAF_objDR.ConnectionString = strConnectionString
        'int intCounter = 0;
        intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("SELECT Count(ActivityID) FROM tbl_PRS_Activity_References_Draft WHERE ActivityID = " + strActivityID + " AND  DocumentType='Guidelines'", blnUseSQL, strConnectionString))
        If intAssocitedRecordExists > 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td style='text-align:justify'>")
            objSTBuilder.Append("<table class=ms-authoringcontrols width='99%' border=0>")

            objDr = CommonFunctions.Data.GetDataReader("USP_VPM_SEL_Activity_GuideLines " + strActivityID + ",1,1", blnUseSQL, WAF_objDR)
            While objDr.Read()

                objSTBuilder.Append("<tr><td>")
                'if (intCounter==0)
                objSTBuilder.Append("<img src=""../../Images/arrow_right.gif""/>")
                objSTBuilder.Append(("<a href='javascript:ShowDetails(""1|G|" + objDr("GuidelineID").ToString() + """," + objDr("GuidelineID").ToString() + ")'>"))
                objSTBuilder.Append(objDr("Title").ToString())
                objSTBuilder.Append("</a>")
                'else
                '    objSTBuilder.Append("," + objDr["Title"].ToString());
                'intCounter += 1;
                objSTBuilder.Append("</td></tr>")
            End While
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td></tr>")
            CommonFunctions.Data.DisposeDataReader(objDr)
        End If
    End Sub 'ShowAssociatedGuidelines


    Protected Sub ShowAssociatedChecklists(ByVal strActivityID As String)
        Dim intAssocitedRecordExists As Integer = 0
        Dim objDr As IDataReader
        'int intCounter = 0;
        Dim WAF_objDR As New CommonFunctions.Data.WAF_DataReader()
        WAF_objDR.ConnectionString = strConnectionString

        intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("SELECT Count(ActivityID) FROM tbl_PRS_Activity_References_Draft WHERE ActivityID = " + strActivityID + " AND  DocumentType='Checklists'", blnUseSQL, strConnectionString))

        If intAssocitedRecordExists > 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td style='text-align:justify'>")
            objSTBuilder.Append("<table class=ms-authoringcontrols width='99%' border=0>")

            objDr = CommonFunctions.Data.GetDataReader("USP_VPM_SEL_Activity_GuideLines " + strActivityID + ",1,2", blnUseSQL, WAF_objDR)
            While objDr.Read()
                objSTBuilder.Append("<tr><td>")
                'if(intCounter==0)
                objSTBuilder.Append("<img src=""../../Images/arrow_right.gif"">")
                objSTBuilder.Append(("<a href='javascript:ShowDetails(""1|C|" + objDr("QuestionnaireID").ToString() + """," + objDr("QuestionnaireID").ToString() + ")'>"))
                objSTBuilder.Append(objDr("QuestionnaireName").ToString())
                'else
                'objSTBuilder.Append("," + objDr["QuestionnaireName"].ToString());
                objSTBuilder.Append("</td></tr>")
            End While 'intCounter += 1;
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td></tr>")

            CommonFunctions.Data.DisposeDataReader(objDr)
        End If
    End Sub 'ShowAssociatedChecklists

    Protected Sub ShowAssociatedTemplates(ByVal strActivityID As String, ByVal strProcessId As String)
        Dim intAssocitedRecordExists As Integer = 0
        Dim objDr As IDataReader
        Dim intCounter As Integer = 0
        Dim WAF_objDR As New CommonFunctions.Data.WAF_DataReader()
        Dim strUploadedFileID As String
        WAF_objDR.ConnectionString = strConnectionString
        Dim objTemplateFiles As IDataReader

        intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("SELECT Count(ActivityID) FROM tbl_PRS_Activity_References_Draft WHERE ActivityID = " + strActivityID + " AND  DocumentType='Templates'", blnUseSQL, strConnectionString))

        If intAssocitedRecordExists > 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td style='text-align:justify'>")
            objSTBuilder.Append("<table class='clsLinkData' width='99%' border=0>")

            objDr = CommonFunctions.Data.GetDataReader("USP_VPM_SEL_Activity_GuideLines " + strActivityID + ",1,3", blnUseSQL, WAF_objDR)
            While objDr.Read()
                objSTBuilder.Append("<tr><td>")
                'if (intCounter == 0)
                objSTBuilder.Append("<img src=""../../Images/arrow_right.gif"">")
                '' IF a Template Document Is Associated show the Document Image 
                'objTemplateFiles = CommonFunctions.Data.GetDataReader("usp_sel_Tbl_SP_uploadedfiles 1041," + objDr("TemplateID").ToString(), blnUseSQL, strConnectionString)
                'If (objTemplateFiles.Read()) Then
                '    objSTBuilder.Append("<img style='cursor:hand' src=""../../Images/dc.gif"" title='View Template' onclick=ViewDocument('" + objTemplateFiles("UploadedFilesID").ToString() + "','" + objTemplateFiles("UploadedFileGUID").ToString() + "','" + objTemplateFiles("DocumentLibraryGUID").ToString() + "','" + objTemplateFiles("MasterTagID").ToString() + "','" + objTemplateFiles("RecordID").ToString() + "','0','frmProcessDetails','../qc/WhizProcessDetails.aspx?PKID=1|P|" + strProcessId + "')>")
                'End If
                'CommonFunctions.Data.DisposeDataReader(objTemplateFiles)

                objSTBuilder.Append(("<a href='javascript:ShowDetails(""1|T|" + objDr("TemplateID").ToString() + """," + objDr("TemplateID").ToString() + ")'>"))
                objSTBuilder.Append(objDr("Name").ToString())
                objSTBuilder.Append("</a>")
                'else
                'objSTBuilder.Append(","+ objDr["Name"].ToString());
                objSTBuilder.Append("</td></tr>")
            End While
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td></tr>")
            CommonFunctions.Data.DisposeDataReader(objDr)
        End If
    End Sub 'ShowAssociatedTemplates
#End Region

#Region "Process Details"

    Private Sub ShowSelectedProcessDetails()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""

        If strMode = MODE_VIEW Then
            DrawHeading(PROCESS_HEADER, "")
        Else
            DrawHeading(PROCESS_HEADER, "&nbsp;")
        End If


        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        DrawGroupLine()
        'Get first data row
        Dim objDR As DataRow = objDS.Tables(0).Rows(0)

        objSTBuilder.Append("<tr>")
        strUniqueID = "objParentSection" + System.Convert.ToString(intRowID)
        DrawGroupHeaderColumn(System.Convert.ToString(objDR("ProcessName")), strUniqueID, True)
        'Show Process details in other td
        objSTBuilder.Append("<td width='80%'>")
        'Div to show and hide this section
        objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
        objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
        'first column information
        DrawColumnHeaderRow(COL_PROCESS_DESCRIPTION)
        If Not (objDR("Description") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Description"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_PROCESS_ENTRYCRITERIA)
        If Not (objDR("EntryCriteria") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("EntryCriteria"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_PROCESS_EXITCRITERIA)
        If Not (objDR("ExitCriteria") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("ExitCriteria"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_PROCESS_REVISION_NO)
        If Not (objDR("RevisionNo") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("RevisionNo"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_PROCESS_ORDER_NO)
        If Not (objDR("OrderNumber") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("OrderNumber"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        objSTBuilder.Append("</table>")
        objSTBuilder.Append("</div>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        intRowID = intRowID + 1

        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'ShowSelectedProcessDetails


    Private Sub ShowAllProcesses()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(PROCESSES_HEADER, MNU_PROCESS_ADD)
        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(1).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSection" + System.Convert.ToString(intRowID)
            ' show the not published process in red color and published process in normal color.
            If System.Convert.ToString(objDR("Status")).Trim() <> "P" Then
                DrawGroupHeaderColumn("<span style=""color:red"">" + System.Convert.ToString(objDR("ProcessName")) + "</span>", strUniqueID)
            Else
                DrawGroupHeaderColumn(System.Convert.ToString(objDR("ProcessName")), strUniqueID)
            End If 'Show Process details in other td
            objSTBuilder.Append("<td width='70%'>")
            'Div to show and hide this section
            objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:none'>"))
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            'Show modify and delete links

            If strMode <> MODE_VIEW Then
                ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("ProcessID")))
            End If


            'first column information
            DrawColumnHeaderRow(COL_PROCESS_DESCRIPTION)
            If Not (objDR("Description") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Description"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_PROCESS_ENTRYCRITERIA)
            If Not (objDR("EntryCriteria") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("EntryCriteria"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_PROCESS_EXITCRITERIA)
            If Not (objDR("ExitCriteria") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("ExitCriteria"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_PROCESS_REVISION_NO)
            If Not (objDR("RevisionNo") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("RevisionNo"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_PROCESS_ORDER_NO)
            If Not (objDR("OrderNumber") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("OrderNumber"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            intRowID = intRowID + 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            objSTBuilder.Append("<tr><td style='text-align:center'>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'ShowAllProcesses
#End Region

#Region "Templates Details"

    Private Sub ShowAllTemplates()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(TEMPLATE_HEADER, TEMPLATE_MENU_ADD)
        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(1).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSection" + System.Convert.ToString(intRowID)
            DrawGroupHeaderColumn(System.Convert.ToString(objDR("Name")), strUniqueID)
            'Show Process details in other td
            objSTBuilder.Append("<td>")
            'Div to show and hide this section
            objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:none'>"))
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            'Show modify and delete links
            ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("TemplateID")))
            'first column information
            DrawColumnHeaderRow(COL_TEMPLATE_TITLE)
            If Not (objDR("Name") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Name"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_TEMPLATE_DESCRIPTION)
            If Not (objDR("Description") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Description"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_TEMPLATE_REVISION_DATE)
            If Not (objDR("RevisionDate") Is Nothing) AndAlso CommonFunctions.Data.CheckIsDBNull(objDR("RevisionDate"), "").ToString() <> "" Then
                strVal = System.Convert.ToDateTime(objDR("RevisionDate")).ToShortDateString()
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            intRowID = intRowID + 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            objSTBuilder.Append("<tr><td style='text-align:center'>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'ShowAllTemplates


    Protected Sub ShowSelectedTemplate()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(TEMPLATE_HEADER, "")

        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        DrawGroupLine()
        'Get first data row
        Dim objDR As DataRow = objDS.Tables(0).Rows(0)

        objSTBuilder.Append("<tr>")
        strUniqueID = "objParentSection" + System.Convert.ToString(intRowID)
        DrawGroupHeaderColumn(System.Convert.ToString(objDR("Name")), strUniqueID, True)
        'Show Process details in other td
        objSTBuilder.Append("<td width='70%'>")
        'Div to show and hide this section
        objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
        objSTBuilder.Append("<table  class='ms-authoringcontrols' width='99%' border=0>")

        'first column information
        DrawColumnHeaderRow(COL_TEMPLATE_DESCRIPTION)
        If Not (objDR("Description") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Description"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_TEMPLATE_REVISION_DATE)
        If Not (objDR("RevisionDate") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("RevisionDate"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        objSTBuilder.Append("</table>")
        objSTBuilder.Append("</div>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        intRowID = intRowID + 1

        DrawGroupLine()
        objSTBuilder.Append("</table>")
    End Sub 'ShowSelectedTemplate
#End Region

#Region "Guideline Details"

    Private Sub ShowAllGuidelines()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(GUIDELINE_HEADER, GUIDELINE_MENU_ADD)
        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(1).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSection" + System.Convert.ToString(intRowID)
            DrawGroupHeaderColumn(System.Convert.ToString(objDR("Title")), strUniqueID)
            'Show Process details in other td
            objSTBuilder.Append("<td>")
            'Div to show and hide this section
            objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:none'>"))
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            'Show modify and delete links
            ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("GuidelineID")))
            'first column information
            DrawColumnHeaderRow(COL_GUIDELINE_SCOPE)
            If Not (objDR("Scope") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Scope"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_GUIDELINE_OBJECTIVE)
            If Not (objDR("Objective") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Objective"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_GUIDELINE_DETAILS)
            If Not (objDR("GuidelineDetails") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("GuidelineDetails"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_GUIDELINE_REVISION_NO)
            If Not (objDR("RevisionNumber") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("RevisionNumber"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            intRowID = intRowID + 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            objSTBuilder.Append("<tr><td style='text-align:center'>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'ShowAllGuidelines

    Private Sub ShowSelectedGuidelineDetails()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(GUIDELINE_HEADER, "")

        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        DrawGroupLine()
        'Get first data row
        Dim objDR As DataRow = objDS.Tables(0).Rows(0)

        objSTBuilder.Append("<tr>")
        strUniqueID = "objParentSection" + System.Convert.ToString(intRowID)
        DrawGroupHeaderColumn(System.Convert.ToString(objDR("Title")), strUniqueID, True)
        'Show Process details in other td
        objSTBuilder.Append("<td width='70%'>")
        'Div to show and hide this section
        objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
        objSTBuilder.Append("<table  class='ms-authoringcontrols' width='99%' border=0>")

        'first column information
        DrawColumnHeaderRow(COL_GUIDELINE_SCOPE)
        If Not (objDR("Scope") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Scope"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_GUIDELINE_OBJECTIVE)
        If Not (objDR("Objective") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Objective"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_GUIDELINE_DETAILS)
        If Not (objDR("GuidelineDetails") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("GuidelineDetails"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_GUIDELINE_REVISION_NO)
        If Not (objDR("RevisionNumber") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("RevisionNumber"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        objSTBuilder.Append("</table>")
        objSTBuilder.Append("</div>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        intRowID = intRowID + 1

        DrawGroupLine()
        objSTBuilder.Append("</table>")
    End Sub 'ShowSelectedGuidelineDetails 
#End Region

#Region "Checklist Details"

    Private Sub ShowAllChecklists()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(CHECKLIST_HEADER, CHECKLIST_MENU_ADD)
        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(1).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSection" + System.Convert.ToString(intRowID)
            If System.Convert.ToString(objDR("RevisionStatus")).Trim() <> "P" Then
                DrawGroupHeaderColumn("<span style=""color:red"">" + System.Convert.ToString(objDR("QuestionnaireName")) + "</span>", strUniqueID)
            Else
                DrawGroupHeaderColumn(System.Convert.ToString(objDR("QuestionnaireName")), strUniqueID)
            End If 'Show Process details in other td
            objSTBuilder.Append("<td>")
            'Div to show and hide this section
            objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:none'>"))
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            'Show modify and delete links
            ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("QuestionnaireID")))
            'first column information
            DrawColumnHeaderRow(COL_CHECKLIST_DESCRIPTION)
            If Not (objDR("Description") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Description"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_CHECKLIST_REVISION_NO)
            If Not (objDR("RevisionNo") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("RevisionNo"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            intRowID = intRowID + 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            objSTBuilder.Append("<tr><td style='text-align:center'>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'ShowAllChecklists

    Private Sub ShowSelectedChecklist()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(CHECKLIST_HEADER, "")

        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        DrawGroupLine()
        'Get first data row
        Dim objDR As DataRow = objDS.Tables(0).Rows(0)

        objSTBuilder.Append("<tr>")
        strUniqueID = "objParentSection" + System.Convert.ToString(intRowID)
        DrawGroupHeaderColumn(System.Convert.ToString(objDR("QuestionnaireName")), strUniqueID, True)
        'Show Process details in other td
        objSTBuilder.Append("<td width='70%'>")
        'Div to show and hide this section
        objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
        objSTBuilder.Append("<table  class='ms-authoringcontrols' width='99%' border=0>")

        'first column information
        DrawColumnHeaderRow(COL_CHECKLIST_DESCRIPTION)
        If Not (objDR("Description") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("Description"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_CHECKLIST_GROUP)
        If Not (objDR("GroupName") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("GroupName"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        DrawColumnHeaderRow(COL_CHECKLIST_REVISION_NO)
        If Not (objDR("RevisionNo") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("RevisionNo"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""


        objSTBuilder.Append("</table>")
        objSTBuilder.Append("</div>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        intRowID = intRowID + 1

        DrawGroupLine()
        objSTBuilder.Append("</table>")

        ShowChecklistSections(objDR("QuestionnaireID").ToString())
    End Sub 'ShowSelectedChecklist


    Protected Sub ShowChecklistSections(ByVal strQuestionnaireID As String)
        Dim sbHTML As New System.Text.StringBuilder()
        Dim drCategory As IDataReader
        Dim WAF_drCategory As New CommonFunctions.Data.WAF_DataReader()
        Dim intCounter As Integer = 0
        If strQuestionnaireID = "0" Then
            Return
        End If
        sbHTML.Append("<table id=""TABLE2"" border=""0"" cellpadding=""0"" cellspacing=""0"" style=""width:95%"" >")
        sbHTML.Append("<tr class=""ms-WPHeader"">")
        sbHTML.Append("<td style="" height: 34px"">")
        sbHTML.Append("<div class=""ms-WPTitle"">")
        sbHTML.Append(CAP_CHECKLIST_ITEM)
        sbHTML.Append("</div></td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr>")
        sbHTML.Append("<td colspan=""2"">")

        WAF_drCategory.ConnectionString = strConnectionString
        drCategory = CommonFunctions.Data.GetDataReader("usp_VPM_Sel_Questionnaire_Category " + strQuestionnaireID, blnUseSQL, WAF_drCategory)


        While drCategory.Read()
            intCounter += 1
            sbHTML.Append("<table border=""0"" cellpadding=""2"" cellspacing=""0"" width=""99.9%"">")
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
            ShowChecklistSectionQuestions(sbHTML, strQuestionnaireID, drCategory("CaytegoryId").ToString())
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
            sbHTML.Append(NO_RECORD)
            sbHTML.Append("</TD></TR></TABLE>")
        End If
        sbHTML.Append("</td></tr></table>")

        'Response.Write(sbHTML.ToString());
        objSTBuilder.Append(sbHTML.ToString())
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
        sbQuestion.Append("<td style=""width:60%;white-space:pre;vertical-align:top"">")
        sbQuestion.Append("Checklist Item")
        sbQuestion.Append("</td>")
        sbQuestion.Append("<td style=""width:30%;vertical-align:top"">")
        sbQuestion.Append("Answer Options")
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

            sbQuestion.Append(drQuestion("QuestionDescription"))

            sbQuestion.Append("</td>")

            sbQuestion.Append("<td style="";vertical-align:top"">")
            ShowChecklistAnswerOptions(sbQuestion, strQuestionnaireID, drQuestion("QuestionnaireQuestionID").ToString(), drQuestion("AnswerSetID").ToString(), System.Convert.ToBoolean(drQuestion("SingleSelection")))
            sbQuestion.Append("</td>")

            sbQuestion.Append("</tr>")
        End While

        If intCounter = 0 Then
            sbQuestion.Append("<tr>")
            sbQuestion.Append("<td colspan=""4"">")
            sbQuestion.Append(NO_RECORD)
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

#End Region

#Region "Metric Details"
    Private Sub ShowAllMetrics()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        ' Metrics can not be added through UI hence removing Add link 

        'DrawHeading(METRICS_HEADER, METRICS_MENU_ADD)
        DrawHeading(METRICS_HEADER, "")

        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(1).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSection" + System.Convert.ToString(intRowID)
            DrawGroupHeaderColumn(System.Convert.ToString(objDR("Name")), strUniqueID)
            'Show Process details in other td
            objSTBuilder.Append("<td>")
            'Div to show and hide this section
            objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:none'>"))
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            'Show modify and delete links
            ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("MetricID")))
            'first column information
            DrawColumnHeaderRow(COL_METRICS_DESCRIPTION)
            If Not (objDR("Description") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Description"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_METRICS_LCL)
            If Not (objDR("Below") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Below"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_METRICS_UCL)
            If Not (objDR("Above") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Above"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_METRICS_ACTIVE)
            If Not (objDR("Active") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Active"))
            End If
            If strVal = "True" Then
                strVal = "Yes"
            Else
                strVal = "No"
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            intRowID = intRowID + 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            objSTBuilder.Append("<tr><td style='text-align:center'>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'ShowAllMetrics
#End Region

#Region "Project Type Details"
    Private Sub ShowAllProjectTypes()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        ' Metrics can not be added through UI hence removing Add link 

        DrawHeading(PROJECT_TYPE_HEADER, MNU_PROJECT_TYPE_ADD)

        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(1).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSection" + System.Convert.ToString(intRowID)
            DrawGroupHeaderColumn(System.Convert.ToString(objDR("ProjectType")), strUniqueID)
            'Show Process details in other td
            objSTBuilder.Append("<td>")
            'Div to show and hide this section
            objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:none'>"))
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            'Show modify and delete links
            ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("TypeID")))
            'first column information
            DrawColumnHeaderRow(COL_PROJECT_TYPES_HEADER)
            If Not (objDR("Description") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Description"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            intRowID = intRowID + 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
            objSTBuilder.Append("<tr><td style='text-align:center'>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub
#End Region

#Region "Drawing Table"


    Private Sub DefinitionHelpTable(ByVal strMainHeading As String, ByVal strDescriptionCol As String)
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        DrawHeading(strMainHeading, "&nbsp;")

        objSTBuilder.Append("<table border='0' cellpadding='2' cellspacing='0' style ='margin-left:20 px' width='95%'>")
        DrawGroupLine()
        'Get first data row
        Dim objDR As DataRow = objDS.Tables(0).Rows(0)

        objSTBuilder.Append("<tr>")
        strUniqueID = "objHelpSection" + System.Convert.ToString(intRowID)

        'DrawGroupHeaderColumn(System.Convert.ToString(objDR["QualityCenterColHeader"]), strUniqueID);
        DrawGroupHeaderColumn(System.Convert.ToString(objDR("QualityCenterColHeader")), strUniqueID, True)

        'Show Process details in other td
        objSTBuilder.Append("<td width='80%'>")
        'Div to show and hide this section
        objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
        objSTBuilder.Append("<table  class=ms-authoringcontrols width='99%' border=0")
        'first column information
        If strDescriptionCol.Trim <> "" Then
            DrawColumnHeaderRow(strDescriptionCol)
        End If
        If Not (objDR("QualityCenterDescription") Is Nothing) Then
            strVal = System.Convert.ToString(objDR("QualityCenterDescription"))
        End If
        DrawColumnDetailsRow(strVal)
        strVal = ""

        objSTBuilder.Append("</table>")
        objSTBuilder.Append("</div>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        intRowID = intRowID + 1

        DrawGroupLine()

        objSTBuilder.Append("</table>")
    End Sub 'DefinitionHelpTable


    Private Sub ShowAddModify(ByVal strLevelID As String, ByVal strPrimaryKey As String)
        objSTBuilder.Append("<tr>")
        objSTBuilder.Append("<td class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22 align='right'>")
        objSTBuilder.Append(("|<span style='cursor:hand' onclick='javascript:Modify(""" + strLevelID + """," + strPrimaryKey + ")'>" + MNU_MODIFY + "</span>|"))
        objSTBuilder.Append(("<span style='cursor:hand' onclick='javascript:Delete(""" + strLevelID + """," + strPrimaryKey + ")'>" + MNU_DELETE + "</span>|"))

        If strLevelID = "0|PS" Then
            'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'Dim strActivityAssociated As String = CommonFunctions.Data.GetDataScalar("SELECT ISNull( Count(ProcessID) , 0) FROM tbl_PRS_Activity_Draft WHERE ProcessID = " + strPrimaryKey, blnUseSQL, strConnectionString).ToString()
            Dim strActivityAssociated As String = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PRS_Activity_Draft_ProcessID " + strPrimaryKey, blnUseSQL, strConnectionString).ToString()
            'Dim strProcessStatus As String = CommonFunctions.Data.GetDataScalar("SELECT ISNull( Status , 'D') FROM tbl_PRS_Process_Draft WHERE ProcessID = " + strPrimaryKey, blnUseSQL, strConnectionString).ToString()
            Dim strProcessStatus As String = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PRS_Process_Draft_Status " + strPrimaryKey, blnUseSQL, strConnectionString).ToString()
            'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query


            If strProcessStatus.Trim() = "D" Then
                objSTBuilder.Append(("<span style='cursor:hand' onclick='javascript:Publish(" + strActivityAssociated.Trim() + "," + strPrimaryKey.Trim() + ",""" + strLevelID.Trim() + """)'>"))
                objSTBuilder.Append(MNU_PUBLISH)
                objSTBuilder.Append("</span>|")
            Else
                objSTBuilder.Append(("<span  style=""cursor:hand;display:inline; color:Green"">" + MNU_PUBLISHED + "</span>|"))
            End If

            objSTBuilder.Append(("<span id=objviewMode style='cursor:hand' onclick=javascript:ShowProcessView('1|P|" + strPrimaryKey + "')>"))
            objSTBuilder.Append(CAP_VIEW_DETAILS)
            objSTBuilder.Append("</span>")

        ElseIf strLevelID = "0|CS" Then
            'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'Dim strQuestionAssociated As String = CommonFunctions.Data.GetDataScalar("SELECT  Count(QuestionnaireID) FROM tbl_Q_QuestionnaireQuestion WHERE QuestionnaireID = " + strPrimaryKey, blnUseSQL, strConnectionString).ToString()
            Dim strQuestionAssociated As String = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_Q_QuestionnaireQuestion_QuestionnaireID " + strPrimaryKey, blnUseSQL, strConnectionString).ToString()

            'Dim strChecklistStatus As String = CommonFunctions.Data.GetDataScalar("SELECT IsNull( RevisionStatus , 'D' ) FROM tbl_Q_Questionnaire WHERE QuestionnaireID = " + strPrimaryKey, blnUseSQL, strConnectionString).ToString() '
            Dim strChecklistStatus As String = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_Q_Questionnaire_RevisionStatus " + strPrimaryKey, blnUseSQL, strConnectionString).ToString() '
            'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            If strChecklistStatus.Trim() = "D" Then
                objSTBuilder.Append(("<span style='cursor:hand' onclick='javascript:Publish(" + strQuestionAssociated.Trim() + "," + strPrimaryKey.Trim() + ",""" + strLevelID.Trim() + """)'>"))
                objSTBuilder.Append(MNU_PUBLISH)
                objSTBuilder.Append("</span>|")
            Else
                objSTBuilder.Append(("<span style=""cursor:hand;display:inline; color:Green"">" + MNU_PUBLISHED + "</span>|"))
            End If
        End If

        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
    End Sub 'ShowAddModify


    Private Sub DrawGroupLine()
        objSTBuilder.Append("<tr width='100%'>")
        objSTBuilder.Append("<TD class='ms-sectionline' colspan='2'>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
    End Sub 'DrawGroupLine


    Private Overloads Sub DrawGroupHeaderColumn(ByVal strGroupHeader As String, ByVal strUniqueID As String)
        objSTBuilder.Append("<td class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22 width='30%'>")
        'objSTBuilder.Append("<h3 class=ms-standardheader");
        objSTBuilder.Append(("<a style='cursor:hand' onclick=javascript:ShowHideSection('objImg" + strUniqueID + "','" + strUniqueID + "')>"))
        objSTBuilder.Append(("<IMG id='objImg" + strUniqueID + "' style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' alt='Hide/Show' src='../../Images/plus.gif' border=0>&nbsp;"))
        objSTBuilder.Append(strGroupHeader)
        objSTBuilder.Append("</a>")
        objSTBuilder.Append("</td>")
    End Sub 'DrawGroupHeaderColumn
    'objSTBuilder.Append("</h3></td>");

    Private Overloads Sub DrawGroupHeaderColumn(ByVal strGroupHeader As String, ByVal strUniqueID As String, ByVal blnCollapsed As [Boolean])
        objSTBuilder.Append("<td class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22 width='30%'>")
        'objSTBuilder.Append("<h3 class=ms-standardheader");
        objSTBuilder.Append(("<a style='cursor:hand' onclick=javascript:ShowHideSection('objImg" + strUniqueID + "','" + strUniqueID + "')>"))
        objSTBuilder.Append(("<IMG id='objImg" + strUniqueID + "' style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' alt='Hide/Show'"))
        If blnCollapsed = True Then
            objSTBuilder.Append(" src='../../Images/minus.gif' border=0>&nbsp;")
        Else
            objSTBuilder.Append(" src='../../Images/plus.gif' border=0>&nbsp;")
        End If
        objSTBuilder.Append(strGroupHeader)
        objSTBuilder.Append("</a>")
        objSTBuilder.Append("</td>")
    End Sub 'DrawGroupHeaderColumn
    'objSTBuilder.Append("</h3></td>");


    Private Sub DrawColumnHeaderRow(ByVal strColHeader As String)
        objSTBuilder.Append("<tr>")
        objSTBuilder.Append("<td class='ms-sectionheader' style='PADDING-TOP: 4px' vAlign=top>")
        objSTBuilder.Append((strColHeader + " : "))
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
    End Sub 'DrawColumnHeaderRow


    Private Sub DrawColumnDetailsRow(ByVal strColDetails As String)
        objSTBuilder.Append("<tr>")
        objSTBuilder.Append("<td style='text-align:justify'>")
        objSTBuilder.Append(strColDetails)
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
    End Sub 'DrawColumnDetailsRow


    Private Sub DrawHeading(ByVal strHeader As String, ByVal strMenuItem As String)
        objSTBuilder.Append("<table TOPLEVEL border='0' cellpadding='0' cellspacing='0' width='95%'>")
        objSTBuilder.Append("<tr>")
        objSTBuilder.Append("<td>")
        objSTBuilder.Append("<table border='0' cellpadding='0' cellspacing='0' width='100%'>")
        objSTBuilder.Append("<tr class='ms-WPHeader'>")
        objSTBuilder.Append("<td accesskey='W' tabindex='0' title='List of processes.' id='WebPartTitleWPQ1' style='width:50%'>")
        objSTBuilder.Append("<div  class='ms-WPTitle'>")
        objSTBuilder.Append("<nobr>")
        objSTBuilder.Append(("<span>" + strHeader + "</span>"))
        objSTBuilder.Append("<span id='WebPartCaptionWPQ1'></span>")
        objSTBuilder.Append("</nobr>")
        objSTBuilder.Append("</div>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("<td  class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22 align='right'>")

        If strMenuItem <> "&nbsp;" And strMenuItem <> "" Then

            objSTBuilder.Append(("<span id=objAddMode style='cursor:hand' onclick=javascript:AddNew('" + strLevelIdentifier + "')>"))
            objSTBuilder.Append(strMenuItem)
            objSTBuilder.Append("</span>")

            If strMenuItem = MNU_ACTIVITY_ADD Then
                objSTBuilder.Append(("|<span id=objviewMode style='cursor:hand' onclick=javascript:ShowProcessView('" + strLevelIdentifier + "')>"))
                objSTBuilder.Append(CAP_VIEW_DETAILS)
                objSTBuilder.Append("</span>")
            End If

        ElseIf strMenuItem = "&nbsp;" Then
            PlotHelpMenu()
        End If

        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        objSTBuilder.Append("</table>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        objSTBuilder.Append("<tr>")
        objSTBuilder.Append("</tr>")
        objSTBuilder.Append("</table>")
    End Sub 'DrawHeading


    Private Sub PlotHelpMenu()
        Dim arrIdentifier As String() = strLevelIdentifier.Split(System.Convert.ToChar("|"))
        Dim strHelpID As String = ""

        Select Case arrIdentifier(1)
            Case "P"
                strHelpID = ACTIVITY_HELP
            Case "PS"
                If (strFromWhere = "PM") Then
                    strHelpID = PROCESS_AT_PROJECT_HELP
                Else
                    strHelpID = PROCESS_HELP
                End If

            Case "AS"
                strHelpID = TASK_HELP
            Case "TK"
                strHelpID = TASK_HELP
            Case "TS"
                strHelpID = PROCESS_TEMPLATE_HELP
            Case "T"
                strHelpID = "1041"
            Case "GS"
                strHelpID = PROCESS_GUIDELINES_HELP
            Case "g"
                strHelpID = "658"
            Case "CS"
                strHelpID = PROCESS_CHECKLISTS_HELP
            Case "C"
                strHelpID = "2160"
            Case "MS"
                strHelpID = PROCESS_METRICS_HELP
            Case "M"
                strHelpID = "676"
            Case Else
                strHelpID = PROCESS_HELP
        End Select


        objSTBuilder.Append(("<span id=objAddMode style='cursor:hand' onclick=javascript:OpenHelpPage(""" + strHelpID + """)>|" + HELP_MENU + "|"))
        objSTBuilder.Append("</span>")
    End Sub 'PlotHelpMenu
#End Region

#Region "Drawing TaskTable"


    Private Sub DrawTaskTableActionLinks(ByVal strHeader As String)
        objSTBuilder.Append("<table TOPLEVEL border='0' cellpadding='0' cellspacing='0' width='97%'>")
        objSTBuilder.Append("<tr>")
        objSTBuilder.Append("<td>")
        objSTBuilder.Append("<table border='0' cellpadding='0' cellspacing='0' width='100%'>")
        objSTBuilder.Append("<tr class='ms-WPHeader'>")
        objSTBuilder.Append("<td accesskey='W' tabindex='0' title='List of processes.' id='WebPartTitleWPQ1' style='width:50%'>")
        objSTBuilder.Append("<div  class='ms-WPTitle'>")
        objSTBuilder.Append("<nobr>")
        objSTBuilder.Append(("<span>" + strHeader + "</span>"))
        objSTBuilder.Append("<span id='WebPartCaptionWPQ1'></span>")
        objSTBuilder.Append("</nobr>")
        objSTBuilder.Append("</div>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("<td  class=ms-sectionheader style='PADDING-TOP: 4px' vAlign=top height=22 align='right'>")
        objSTBuilder.Append(("|<span id=objAddMode style='cursor:hand' onclick=javascript:AddNew('" + strLevelIdentifier + "')>"))
        objSTBuilder.Append("Add")
        objSTBuilder.Append("</span>|")
        objSTBuilder.Append(("<span id=objDeleteMode style='cursor:hand' onclick=javascript:Delete('" + strLevelIdentifier + "',0)>"))
        objSTBuilder.Append("Delete")
        objSTBuilder.Append("</span>|")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        objSTBuilder.Append("</table>")
        objSTBuilder.Append("</td>")
        objSTBuilder.Append("</tr>")
        objSTBuilder.Append("<tr>")
        objSTBuilder.Append("</tr>")
        objSTBuilder.Append("</table>")
    End Sub 'DrawTaskTableActionLinks


    Private Sub DrawTaskTableHeader()
        objSTBuilder.Append("<TR align='center' class='XmlGridTitleRow'>")

        objSTBuilder.Append("<TD align=""left"" width='75%'>")
        objSTBuilder.Append("Task Name")
        objSTBuilder.Append("</TD>")

        objSTBuilder.Append("<TD align='right' width='15%'>")
        objSTBuilder.Append("Duration (Hrs)")
        objSTBuilder.Append("</TD>")

        objSTBuilder.Append("<TD width='10%'>")
        objSTBuilder.Append("<input type='checkbox' id='chkSelectAll' onclick='SelectDeselectAll(this)'> ")
        objSTBuilder.Append("</TD>")

        objSTBuilder.Append("<TR>")
    End Sub 'DrawTaskTableHeader


    Private Sub DrawTaskTableRow(ByVal intActivityTaskID As Integer, ByVal strTaskName As String, ByVal dblDuration As Double)

        objSTBuilder.Append("<TR>")

        objSTBuilder.Append("<TD style='white-space:normal'>")
        objSTBuilder.Append(("<a href=""javascript:Modify('" + strLevelIdentifier + "','" + System.Convert.ToString(intActivityTaskID) + "')"">"))
        objSTBuilder.Append(strTaskName)
        objSTBuilder.Append("</TD>")

        objSTBuilder.Append("<TD align='right'>")
        objSTBuilder.Append(System.Convert.ToString(dblDuration))
        objSTBuilder.Append("</TD>")

        objSTBuilder.Append("<TD align='center'>")
        objSTBuilder.Append(("<input type='checkbox' id='chkTask' value='" + System.Convert.ToString(intActivityTaskID) + "'>"))
        objSTBuilder.Append("</TD>")

        objSTBuilder.Append("<TR>")
    End Sub 'DrawTaskTableRow


    Private Sub DrawNoTasks()
        objSTBuilder.Append("<TR>")
        objSTBuilder.Append("<TD colspan='3'>")
        objSTBuilder.Append("There are no tasks for selected activity !!")
        objSTBuilder.Append("</TD>")
    End Sub 'DrawNoTasks
#End Region

#Region "Project Process"
    Protected Sub ShowProjectProcessDetails(ByVal PKID As String)
        Dim chr(0) As Char
        chr(0) = System.Convert.ToChar("|")
        Dim arrVal As String() = PKID.Split(chr)
        Dim strProjectID = HttpContext.Current.Session.Item("intProjectID")

        Dim strProcessID As String = ""
        If Not IsNothing(HttpContext.Current.Request.QueryString.Get("ProcessID")) Then
            strProcessID = HttpContext.Current.Request.QueryString.Get("ProcessID").ToString()
        End If

        Select Case arrVal(1)
            Case "PS"
                ShowAllProjectProcesses(strProjectID, strProcessID)
        End Select

    End Sub

    Protected Sub ShowAllProjectProcesses(ByVal strProjectID As String, ByVal strProcessID As String)

        Dim strSQL As String = " usp_VPM_SEL_tbl_PRS_Project_SDLC_Details " + strProjectID
        Dim objDA As SqlDataAdapter = Nothing
        objDS = New DataSet()
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        Dim blnIsProcessRevised As Boolean = False


        If (strProcessID <> "") Then
            strSQL += ", " + strProcessID
        End If

        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)

        objSTBuilder = New System.Text.StringBuilder()

        If strMode <> MODE_VIEW Then
            DrawHeading(PROCESS_HEADER, "&nbsp;")
        Else
            DrawHeading(PROCESS_HEADER, "")
        End If

        objSTBuilder.Append("<table border='0' cellpadding='0' cellspacing='0' width='95%'>")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(0).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSectionProcess" + System.Convert.ToString(objDR("ProcessID"))
            ' show the not latest process in red color and latest process in normal color.
            blnIsProcessRevised = CType(CommonFunctions.Data.GetDataScalar(" usp_sel_Process_Revision " + objDR("ProcessID").ToString() + "," + strProjectID, blnUseSQL, strConnectionString), Boolean)

            If blnIsProcessRevised Then
                DrawGroupHeaderColumn("<span style=""color:red"">" + System.Convert.ToString(objDR("ProcessName")) + "</span>", strUniqueID, True)
            Else
                DrawGroupHeaderColumn(System.Convert.ToString(objDR("ProcessName")), strUniqueID, True)
            End If 'Show Process details in other td

            objSTBuilder.Append("<td width='70%' class=ms-authoringcontrols style='text-align:right'>")

            If strMode <> MODE_VIEW Then

                objSTBuilder.Append("|<span style='cursor:hand' onclick='javascript:ViewProjectProcess_OnClick(" + objDR("ProcessID").ToString() + "," + strProjectID + ")'>")
                objSTBuilder.Append(CAP_VIEW_DETAILS)
                objSTBuilder.Append("</span>")

                If blnIsProcessRevised Then
                    objSTBuilder.Append("|<span style='color:red;cursor:hand' onclick='javascript:GetLatest_OnClick(" + objDR("ProcessID").ToString() + "," + strProjectID + ",""" + strProcessID + """)'>")
                    objSTBuilder.Append(CAP_GET_LATEST_REVISION)
                    objSTBuilder.Append("</span>|")
                Else
                    objSTBuilder.Append("|<span style='color:green'>" + CAP_LATEST_REVISION + "</span>|")
                End If

                objSTBuilder.Append("<span style='cursor:hand' onclick='javascript:DeleteProjectProcess_OnClick(" + objDR("ProcessID").ToString() + "," + strProjectID + ",""" + strProcessID + """)'>")

                objSTBuilder.Append(MNU_DELETE)
                objSTBuilder.Append("</span>|")
            End If

            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("<tr><td colspan=2>")
            'Div to show and hide this section
            objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
            objSTBuilder.Append("<table border=0 cellspacing=0 cellpadding=0><tr><td style='width:30%'>&nbsp;</td><td style='width:70%'>")
            objSTBuilder.Append("<table class=ms-authoringcontrols border=0 cellspacing=0 cellpadding=0>")
            'Show modify and delete links
            'ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("ProcessID")))
            'first column information
            DrawColumnHeaderRow(COL_PROCESS_DESCRIPTION)
            If Not (objDR("Description") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Description"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_PROCESS_ENTRYCRITERIA)
            If Not (objDR("EntryCriteria") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("EntryCriteria"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_PROCESS_EXITCRITERIA)
            If Not (objDR("ExitCriteria") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("ExitCriteria"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_PROCESS_REVISION_NO)
            If Not (objDR("RevisionNo") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("RevisionNo"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_PROCESS_ORDER_NO)
            If Not (objDR("OrderNumber") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("OrderNumber"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td colspan=2 style='99.99%'>")
            ' show activity Details
            ShowProjectProcessActivity(objDR("ProcessID").ToString(), strProjectID, strProcessID)

            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            objSTBuilder.Append("</table>")

            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")

            DrawGroupLine()

            intRowID = intRowID + 1
        Next objDR
        If intRowID = 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table  class=ms-authoringcontrols border=0")
            objSTBuilder.Append("<tr><td style='text-align:center'>")
            objSTBuilder.Append(NO_RECORD)
            objSTBuilder.Append("</td></tr>")
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
        End If
        DrawGroupLine()

        objSTBuilder.Append("</table>")

        SetPageCaption("1|P")
        Response.Write(objSTBuilder.ToString())
        objSTBuilder = Nothing
    End Sub

    Protected Sub ShowProjectProcessActivity(ByVal strProcessID As String, ByVal strProjectID As String, ByVal strSingleProcess As String)
        Dim intRowID As Integer = 0
        Dim strUniqueID As String = ""
        Dim strVal As String = ""
        Dim strSQL As String = " usp_VPM_SEL_v_tbl_PRS_Project_SDLC " + strProcessID + "," + strProjectID
        Dim objDA As SqlDataAdapter = Nothing
        objDS = New DataSet()
        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)

        If objDS.Tables(0).Rows.Count > 0 Then
            DrawHeading(ACTIVITY_HEADER, "")
        End If

        objSTBuilder.Append("<table border='0' cellpadding='0' cellspacing='0' width='99.99%' >")
        Dim objDR As DataRow
        For Each objDR In objDS.Tables(0).Rows
            DrawGroupLine()
            objSTBuilder.Append("<tr>")
            strUniqueID = "objSectionActivity" + System.Convert.ToString(objDR("ActivityID"))
            If strMode <> MODE_VIEW Then
                DrawGroupHeaderColumn(System.Convert.ToString(objDR("Title")), strUniqueID)
            Else
                DrawGroupHeaderColumn(System.Convert.ToString(objDR("Title")), strUniqueID, True)
            End If

            objSTBuilder.Append("<td  width='70%' class=ms-authoringcontrols style='text-align:right'>")

            If strMode <> MODE_VIEW Then
                objSTBuilder.Append("<span style='cursor:hand' onclick=TailoringAndDeviation(")
                objSTBuilder.Append(objDR("SDLCId").ToString())
                objSTBuilder.Append(",")
                objSTBuilder.Append(strProcessID)
                objSTBuilder.Append(",")
                objSTBuilder.Append(strProjectID)
                objSTBuilder.Append(",")
                objSTBuilder.Append(objDR("ActivityID").ToString())
                objSTBuilder.Append(",'")
                objSTBuilder.Append(strSingleProcess)
                objSTBuilder.Append("')>")

                objSTBuilder.Append(CAP_ACTIVITY_TAILORING_AND_DEVIATION)
                objSTBuilder.Append("</span>")
            End If

            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td width=30%>&nbsp;</td>")

            'Show Activity details in other td
            objSTBuilder.Append("<td width=70%>")
            'Div to show and hide this section
            If strMode <> MODE_VIEW Then
                objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:none'>"))
            Else
                objSTBuilder.Append(("<div id='" + strUniqueID + "' style='display:inline'>"))
            End If

            objSTBuilder.Append("<table  class=ms-authoringcontrols width='99.99%' border=0")
            'Show modify and delete links
            'ShowAddModify(strLevelIdentifier, System.Convert.ToString(objDR("ActivityID")))
            'first column information
            DrawColumnHeaderRow(COL_ACTIVITY_STAGEID)
            If Not (objDR("ActivityStageID") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("ActivityStageID"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_OBJECTIVE)
            If Not (objDR("Objective") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Objective"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_SCOPE)
            If Not (objDR("Scope") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Scope"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_INPUT_CRITERIA)
            If Not (objDR("InputCriteria") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("InputCriteria"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_INPUTS)
            If Not (objDR("Inputs") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Inputs"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_DETAILS)
            If Not (objDR("Description") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("Description"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            DrawColumnHeaderRow(COL_ACTIVITY_EXIT_CRITERIA)
            If Not (objDR("ExitCriteria") Is Nothing) Then
                strVal = System.Convert.ToString(objDR("ExitCriteria"))
            End If
            DrawColumnDetailsRow(strVal)
            strVal = ""

            ' show Associated Guidelines
            DrawColumnHeaderRow(COL_ACTIVITY_ASSOCIATED_GUIDELINES)
            ShowAssociatedGuidelines(objDR("ActivityID").ToString())

            ' show Assoicated Checklists
            DrawColumnHeaderRow(COL_ACTIVITY_ASSOCIATED_CHECKLISTS)
            ShowProjectAssociatedChecklists(objDR("SDLCID").ToString())

            ' show Associated Templates
            DrawColumnHeaderRow(COL_ACTIVITY_ASSOCIATED_TEMPLATES)
            ShowProjectAssociatedTemplates(objDR("SDLCID").ToString(), objDR("ProjectID").ToString(), strSingleProcess)

            '' Show Project Specific Templates 
            'DrawColumnHeaderRow(CAP_ACTIVITY_PROJECT_SPECIFIC_TEMPLATES)
            'ShowProjectSpecificTemplates(objDR("SDLCID").ToString(), objDR("ProjectID").ToString(), strSingleProcess)

            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</div>")
            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            intRowID = intRowID + 1
        Next objDR

        DrawGroupLine()

        objSTBuilder.Append("</table>")

        If Not IsNothing(objDS) Then
            objDS.Dispose()
        End If


        If Not IsNothing(objDA) Then
            objDA.Dispose()
        End If

    End Sub

    Protected Sub GetLatestProcessDetails()

        Dim strProcessID As String = HttpContext.Current.Request.QueryString.Get("ProcessID_PK").ToString()
        Dim strProjectID As String = HttpContext.Current.Session.Item("intProjectID").ToString()
        Dim strSQL As String = "EXEC usp_GetLatest_tbl_PRS_Project_SDLC_Details " + strProjectID + "," + strProcessID
        CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

    End Sub

    Protected Sub DeleteProcess()

        Dim strProcessID As String = HttpContext.Current.Request.QueryString.Get("ProcessID_PK").ToString()
        Dim strProjectID As String = HttpContext.Current.Session.Item("intProjectID").ToString()
        Dim strSQL As String = "EXEC usp_Del_Process_At_Project " + strProjectID + "," + strProcessID
        CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

    End Sub


    Protected Sub ShowProjectAssociatedChecklists(ByVal strSDLCID As String)
        Dim intAssocitedRecordExists As Integer = 0
        Dim objDr As IDataReader
        'int intCounter = 0;
        Dim WAF_objDR As New CommonFunctions.Data.WAF_DataReader()
        WAF_objDR.ConnectionString = strConnectionString


        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("SELECT Count(ChecklistID) FROM V_tbl_PRS_SDLC_Checklists WHERE SDLCID = " + strSDLCID, blnUseSQL, strConnectionString))
        intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_sel_V_tbl_PRS_SDLC_Checklists_ChecklistID_Count " + strSDLCID, blnUseSQL, strConnectionString))
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

        If intAssocitedRecordExists > 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td style='text-align:justify'>")
            objSTBuilder.Append("<table class=ms-authoringcontrols width='99%' border=0>")

            'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'objDr = CommonFunctions.Data.GetDataReader("SELECT ChecklistID, Title FROM V_tbl_PRS_SDLC_Checklists WHERE SDLCID= " + strSDLCID, blnUseSQL, WAF_objDR)
            objDr = CommonFunctions.Data.GetDataReader("usp_sel_V_tbl_PRS_SDLC_Checklists_ChecklistID " + strSDLCID, blnUseSQL, WAF_objDR)
            'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            While objDr.Read()
                objSTBuilder.Append("<tr><td>")
                'if(intCounter==0)
                objSTBuilder.Append("<img src=""../../Images/arrow_right.gif"">")
                objSTBuilder.Append(("<a href='javascript:ShowDetails(""1|C|" + objDr("ChecklistID").ToString() + """," + objDr("ChecklistID").ToString() + ")'>"))
                objSTBuilder.Append(objDr("Title").ToString())
                'else
                'objSTBuilder.Append("," + objDr["QuestionnaireName"].ToString());
                objSTBuilder.Append("</td></tr>")
            End While 'intCounter += 1;
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td></tr>")

            CommonFunctions.Data.DisposeDataReader(objDr)
        End If
    End Sub 'ShowAssociatedChecklists

    Protected Sub ShowProjectAssociatedTemplates(ByVal strSDLCID As String, ByVal ProjectId As String, ByVal strSingleProcess As String)
        Dim intAssocitedRecordExists As Integer = 0
        Dim objDr As IDataReader
        Dim intCounter As Integer = 0
        Dim WAF_objDR As New CommonFunctions.Data.WAF_DataReader()
        WAF_objDR.ConnectionString = strConnectionString
        Dim objTemplateFiles As IDataReader

        ''Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("SELECT Count(TemplateID) FROM V_tbl_PRS_SDLC_Templates WHERE SDLCID = " + strSDLCID, blnUseSQL, strConnectionString))
        intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_sel_V_tbl_PRS_SDLC_Templates_Count " + strSDLCID, blnUseSQL, strConnectionString))
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        If intAssocitedRecordExists > 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td style='text-align:justify'>")
            objSTBuilder.Append("<table class='clsLinkData' width='99%' border=0>")

            objDr = CommonFunctions.Data.GetDataReader("SELECT TemplateID, [Name] FROM V_tbl_PRS_SDLC_Templates WHERE SDLCID = " + strSDLCID, blnUseSQL, WAF_objDR)
            While objDr.Read()
                objSTBuilder.Append("<tr><td>")
                'if (intCounter == 0)
                objSTBuilder.Append("<img src=""../../Images/arrow_right.gif"">")
                '' IF a Template Document Is Associated show the Document Image 
                'objTemplateFiles = CommonFunctions.Data.GetDataReader("usp_sel_Tbl_SP_uploadedfiles 1041," + objDr("TemplateID").ToString(), blnUseSQL, strConnectionString)
                'If (objTemplateFiles.Read()) Then
                '    objSTBuilder.Append("<img style='cursor:hand' src=""../../Images/dc.gif"" title='View Template' onclick=ViewDocument('" + objTemplateFiles("UploadedFilesID").ToString() + "','" + objTemplateFiles("UploadedFileGUID").ToString() + "','" + objTemplateFiles("DocumentLibraryGUID").ToString() + "','" + objTemplateFiles("MasterTagID").ToString() + "','" + objTemplateFiles("RecordID").ToString() + "','0','frmProcessDetails','../QC/WhizProcessDetails.aspx?PKID=0|PS&FromWhere=PM&ProcessID=" + strSingleProcess + "')>")
                'End If
                'CommonFunctions.Data.DisposeDataReader(objTemplateFiles)
                objSTBuilder.Append(("<a href='javascript:ShowDetails(""1|T|" + objDr("TemplateID").ToString() + """," + objDr("TemplateID").ToString() + ")'>"))
                objSTBuilder.Append(objDr("Name").ToString())
                objSTBuilder.Append("</a>")
                'else
                'objSTBuilder.Append(","+ objDr["Name"].ToString());
                objSTBuilder.Append("</td></tr>")
            End While
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td></tr>")
            CommonFunctions.Data.DisposeDataReader(objDr)
        End If
    End Sub 'ShowAssociatedTemplates
    Protected Sub ShowProjectSpecificTemplates(ByVal strSDLCID As String, ByVal ProjectId As String, ByVal strSingleProcess As String)
        Dim intAssocitedRecordExists As Integer = 0
        Dim objDr As IDataReader
        Dim intCounter As Integer = 0
        Dim WAF_objDR As New CommonFunctions.Data.WAF_DataReader()
        WAF_objDR.ConnectionString = strConnectionString
        ' Dim objTemplateFiles As IDataReader
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("SELECT Isnull( Count(UploadedFilesID ) ,0)  FROM Tbl_SP_UploadedFiles WHERE MasterTagID = 2022 And RecordID =  " + strSDLCID, blnUseSQL, strConnectionString))
        intAssocitedRecordExists = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_sel_Tbl_SP_UploadedFiles_UploadedFilesID  " + strSDLCID, blnUseSQL, strConnectionString))
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

        If intAssocitedRecordExists > 0 Then
            objSTBuilder.Append("<tr>")
            objSTBuilder.Append("<td style='text-align:justify'>")
            objSTBuilder.Append("<table class='clsLinkData' width='99.99%' border=0>")

            objDr = CommonFunctions.Data.GetDataReader("usp_sel_Tbl_SP_uploadedfiles 2022," + strSDLCID.ToString(), blnUseSQL, strConnectionString)
            While objDr.Read()
                objSTBuilder.Append("<tr><td>")
                'if (intCounter == 0)
                objSTBuilder.Append("<img src=""../../Images/arrow_right.gif"">")
                ' IF a Template Document Is Associated show the Document Image 
                objSTBuilder.Append("<img style='cursor:hand' src=""../../Images/dc.gif"" title='View Template' onclick=ViewDocument('" + objDr("UploadedFilesID").ToString() + "','" + objDr("UploadedFileGUID").ToString() + "','" + objDr("DocumentLibraryGUID").ToString() + "','" + objDr("MasterTagID").ToString() + "','" + objDr("RecordID").ToString() + "','" + ProjectId + "','frmProcessDetails','../QC/WhizProcessDetails.aspx?PKID=0|PS&FromWhere=PM&ProcessID=" + strSingleProcess + "')>")
                objSTBuilder.Append(objDr("FileName").ToString())

                objSTBuilder.Append("</td></tr>")
            End While
            objSTBuilder.Append("</table>")
            objSTBuilder.Append("</td></tr>")
            CommonFunctions.Data.DisposeDataReader(objDr)
        End If
    End Sub 'ShowAssociatedTemplates
#End Region
End Class 'WhizProcess