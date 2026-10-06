Public Class DM_ApproverRuleEngine
    Inherits WebPages.Template.WhizTemplate

    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Protected intNatureOfDemandID As Integer
    Protected intRequestStageID As Integer
    Protected intApproverID As Integer
    Protected strNatureOfDemand As String
    Protected strRequestStage As String
    Protected strApproverName As String
    Protected strRule As String = ""
    Protected strUserFriendlyRule As String = ""
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objList As New WebPages.Template.GenericGrid
    Protected m_arrUniqueIDList As New ArrayList
    Protected strMode As String
    Protected m_strSortBy As String
    Protected strRuleDetails As String
    Protected strUserFriendlyRuleDetails As String
    Protected strAction As String
    Protected strUserName As String
    Protected srtStage As String
    Protected strStageChange As String
    Protected intChangeStageID As Integer
    Protected strApplyRuleForExisting As String = "0"

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        MyBase.InitializeResources("AppResources.DM_ApproverRuleEngine", "AppResources")
    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To Initialise the Page 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : August 21,2006
        ' Revisions             :
        '=====================================================================
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.DM_ApproverRuleEngine", "AppResources")
        Dim strSQL As String
        strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode").ToUpper, "")
        strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "").ToUpper
        strStageChange = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("StageChange"), "").ToUpper
        InitVariables()

        If strMode = "LIST" Then
            Draw_List()
        End If

        If strMode = "APPLYALL" And strAction = "STAGECHANGE" Then
            'Stage Filter 
            Draw_Page()
        Else
            If strMode = "EDIT" Or strMode = "APPLYALL" Then
                If strAction = "SAVEALL" Then
                    'Save From ApplyAll Mode
                    If Validate_Query(strRuleDetails) Then
                        Perform_Action(strMode)
                        Draw_Page()
                    Else
                        Draw_Page()
                        Response.Write("<Script>" + vbCrLf)
                        Response.Write("alert('Invalid Query')")
                        Response.Write("</Script>" + vbCrLf)
                    End If
                Else
                    'Edit Mode
                    Draw_Page()
                End If
            End If
        End If

        If strMode = "SAVE" Then
            'Save From Edit Mode
            If Validate_Query(strRuleDetails) Then
                Perform_Action(strMode)
                Draw_Page()
            Else
                Draw_Page()
                Response.Write("<Script>" + vbCrLf)
                Response.Write("alert('Invalid Query')")
                Response.Write("</Script>" + vbCrLf)
            End If
        End If

        If strMode = "CLEAR" Then
            'Clear Rule 
            Perform_Action(strMode)
            Draw_Page()
        End If
        If strMode = "PROJECT_LIST" Then
            Draw_ProjectList()
        End If
    End Sub
    Protected Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()
        ' Purpose               : To Initialise the Variables 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : August 21,2006
        ' Revisions             :
        '=====================================================================

        intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandID"), 0)
        strRuleDetails = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtRule"), "")
        strUserFriendlyRuleDetails = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUserFriendlyRule"), "")
        strRuleDetails = CommonFunctions.General.BuildQueryString(strRuleDetails)
        strUserFriendlyRuleDetails = CommonFunctions.General.BuildQueryString(strUserFriendlyRuleDetails)
        srtStage = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboStage"), "")
        strUserName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "").ToString
        strUserName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetSQLDataScalar("usp_sel_IM_Role_RuleEngine " + strUserName), "")

        If strStageChange = "YES" Then
            intChangeStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("StageID"), 0)
        End If
        If strMode = "LIST" Or strMode = "PROJECT_LIST" Then
            intRequestStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestStageID"), 0)
        End If
        If strMode = "EDIT" Or strMode = "SAVE" Or strMode = "CLEAR" Then
            intRequestStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestStageID"), 0)
            intApproverID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ApproverID"), 0)
        End If

        strApplyRuleForExisting = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ApplyRuleForExisting"), "0")
        If intNatureOfDemandID = 0 Then
            intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectNatureOfDemandID"), 0)
        End If
    End Sub
    Private Function Validate_Query(ByVal strActualFormula As String) As Boolean
        '=====================================================================
        ' Procedure Name        : Validate_Query()	
        ' Purpose               : To validate the whereclause for the alert
        ' Description           : The query is built with the whereclause and executed
        '                         and in case of any error false is returned else true
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : August 22,2006
        '=====================================================================
        Dim strSQL As String
        strSQL = "usp_validate_rule " + intNatureOfDemandID.ToString + ",'" + strActualFormula + "'"
        Dim dr As IDataReader
        Try
            dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Catch exc As Exception
            Return False
        Finally
            CommonFunction.Data.DisposeDataReader(dr)
        End Try
        Return True
    End Function

    Protected Sub Perform_Action(ByVal strAction As String)
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To Reallocate the Approvers
        ' Description           : 
        '                         
        ' Parameters Passed     : strAction
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : August 1,2006
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        If strAction = "APPLYALL" Then
            Dim i As Integer
            Dim strApproverID As String() = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkApplicable"), "").Split(","c)
            Dim strRequetStageID As String() = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkStage"), "").Split(","c)
            Dim strApprovers As String
            For i = 0 To strApproverID.Length - 1

                ' Modified By NitinVS on 16 FEb 2007 For IssueID 
                ' Added Parameter for ApplyRuleForExisting 
                strSQL = "usp_Ins_Upd_Tbl_IM_NatureOfDemand_Stage_Rule " + intNatureOfDemandID.ToString + "," + strRequetStageID(i) + ",'" + strApproverID(i) + "',N'" + strRuleDetails + "',N'" + strUserFriendlyRuleDetails + "',N'" + strUserName + "' , " + strApplyRuleForExisting
                'End Modification  By NitinVS on 16 FEb 2007 For IssueID 

                CommonFunction.Data.SQLInsertOrUpdateData(strSQL)
            Next
        End If

        If strAction = "SAVE" Then
            intRequestStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestStageID"), "")
            intApproverID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ApproverID"), "")
            ' Modified By NitinVS on 16 FEb 2007 For IssueID 
            ' Added Parameter for ApplyRuleForExisting 

            strSQL = "usp_Ins_Upd_Tbl_IM_NatureOfDemand_Stage_Rule " + intNatureOfDemandID.ToString + "," + intRequestStageID.ToString + "," + intApproverID.ToString + ",N'" + strRuleDetails + "',N'" + strUserFriendlyRuleDetails + "',N'" + strUserName + "' , " + strApplyRuleForExisting

            'End Modification  By NitinVS on 16 FEb 2007 For IssueID 

            CommonFunction.Data.SQLInsertOrUpdateData(strSQL)
        End If

        If strAction = "CLEAR" Then
            intRequestStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestStageID"), "")
            intApproverID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ApproverID"), "")
            strSQL = "usp_Del_Tbl_IM_NatureOfDemand_Stage_Rule " + intNatureOfDemandID.ToString + "," + intRequestStageID.ToString + "," + intApproverID.ToString + ",N'" + strUserName + "'"
            CommonFunction.Data.SQLInsertOrUpdateData(strSQL)
        End If

    End Sub

    Protected Sub Draw_List()
        '=====================================================================
        ' Procedure Name        : Draw_List()
        ' Purpose               : To generate the List
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : August 21,2006
        ' Revisions             :
        '=====================================================================
        Dim strHtml As New System.Text.StringBuilder
        Dim strMenu As String
        Dim strUSP As String

        strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_Workflow " + intNatureOfDemandID.ToString, MyBase.UseSQL), "")
        strRequestStage = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_RequestStage " + intRequestStageID.ToString, MyBase.UseSQL), "")

        strMenu = DrawMenu()
        Response.Write(strMenu)

        'strHtml.Append("<div ID=PageDiv style='overflow:auto;width:100%;height:100px'>" + vbCrLf)
        strHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("WINDOW_TITLE") + "</TD></TR></TABLE><BR>" + vbCrLf)

        strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("NOD") + "&nbsp;:&nbsp;" + strNatureOfDemand + "</TD><TD align=Right>" + MyBase.GetResourceString("STAGE") + "&nbsp;:&nbsp;" + strRequestStage + "</TD></TR></TABLE>" + vbCrLf)
        strHtml.Append("<BR>")
        CommonFunction.General.WriteHTML(strHtml.ToString)
        DrawListGrid()
        Response.Write("<br>" + strMenu)
        strHtml = Nothing

    End Sub
    Protected Sub Draw_ProjectList()
        '=====================================================================
        ' Procedure Name        : Draw_ProjectList()
        ' Purpose               : To generate the project rule List
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : July 23,2008
        ' Revisions             :
        '=====================================================================
        Dim strHtml As New System.Text.StringBuilder
        Dim strMenu As String
        Dim strUSP As String

        strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_Workflow " + intNatureOfDemandID.ToString + ",'P'", MyBase.UseSQL), "")
        strRequestStage = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_RequestStage " + intRequestStageID.ToString, MyBase.UseSQL), "")

        strMenu = DrawMenu()
        Response.Write(strMenu)

        'strHtml.Append("<div ID=PageDiv style='overflow:auto;width:100%;height:100px'>" + vbCrLf)
        strHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("WINDOW_TITLE") + "</TD></TR></TABLE><BR>" + vbCrLf)

        strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("NOD") + "&nbsp;:&nbsp;" + strNatureOfDemand + "</TD><TD align=Right>" + MyBase.GetResourceString("STAGE") + "&nbsp;:&nbsp;" + strRequestStage + "</TD></TR></TABLE>" + vbCrLf)
        strHtml.Append("<BR>")
        CommonFunction.General.WriteHTML(strHtml.ToString)
        DrawProjectListGrid()
        Response.Write("<br>" + strMenu)
        strHtml = Nothing

    End Sub
    Private Sub DrawProjectListGrid()
        '=====================================================================
        ' Procedure Name        : DrawProjectListGrid()
        ' Purpose               : To generate the Grid for PROJECT List Mode 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : July 23,2008
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String

        Dim arrActualColumns() As String = {"RoleDescription", "UserFriendlyRuleDetails"} ', "History"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("APPROVER_CAP"), MyBase.GetResourceString("RULE")} ', MyBase.GetResourceString("HISTORY_CAP")}
        Dim arrGroupColumns() As String = {"", ""} ', ""}
        Dim arrTDStyle() As String = {"align=left", "align=left"} ', "align=center"}
        'Dim arrRowLink() As String = {"", "", "History_OnClick(NOIRuleID)"}
        'Dim arrRowLinkTooltip() As String = {"", "", "", MyBase.GetResourceString("HISTORY_CAP")}
        strQuery = "Exec usp_Sel_Tbl_IM_ProjectNatureOfDemand_Stage_Rule " + intNatureOfDemandID.ToString + "," + intRequestStageID.ToString
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Set the Generic Grid Properties
        With m_objList
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "NOIRuleID"
            .GroupOnColumn = arrGroupColumns

            '.RowLinkArray = arrRowLink
            '.RowLinkToolTipArray = arrRowLinkTooltip

            '.SortBy = m_strSortBy
            '.SortOrder = m_strSortOrder
            '.ClientSideSortFunctionName = "Sort_OnClick"


            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "DivListGrid"
            .DIVHeight = 375
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 2
            '.returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
        m_objList = Nothing
    End Sub
    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To generate the UI and is called from
        '                         the .aspx page
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : August 21,2006
        ' Revisions             :
        '=====================================================================
        Dim strHtml As New System.Text.StringBuilder
        Dim strMenu As String
        Dim strWhere As String = ""
        Dim strFilterFlag As String
        Dim strUSP As String

        Dim drRuleDetails As IDataReader
        Dim drDefinedRules As IDataReader
        Dim objLink As WebPage.UI.cDynamicLink

        strFilterFlag = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboFieldList"), ""), String)
        strUSP = "usp_Sel_Tbl_IM_RuleAttributes 1"
        strUSP = strUSP + "," + intNatureOfDemandID.ToString
        'purvaj 16 July 2008
        drRuleDetails = CommonFunction.Data.GetDataReader(strUSP, MyBase.UseSQL)

        intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandID"), "")

        If strMode = "EDIT" Or strMode = "CLEAR" Or (strMode = "SAVE" And strAction <> "SAVEALL") Then
            intRequestStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestStageID"), "")
            intApproverID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ApproverID"), "")
        End If

        strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_Workflow " + intNatureOfDemandID.ToString, MyBase.UseSQL), "")
        strRequestStage = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_RequestStage " + intRequestStageID.ToString, MyBase.UseSQL), "")
        strApproverName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_IM_Role_RuleEngine " + intApproverID.ToString, MyBase.UseSQL), "")

        'Get Rule Details and User Friendly Rule Details
        strUSP = "usp_Get_Tbl_IM_NatureOfDemand_Stage_Rule " + intNatureOfDemandID.ToString + "," + intRequestStageID.ToString + "," + intApproverID.ToString
        drDefinedRules = CommonFunction.Data.GetDataReader(strUSP, MyBase.UseSQL)
        While drDefinedRules.Read
            strUserFriendlyRule = CommonFunction.Data.CheckIsDBNull(drDefinedRules("UserFriendlyRuleDetails"), "")
            strRule = CommonFunction.Data.CheckIsDBNull(drDefinedRules("RuleDetails"), "")
        End While
        CommonFunction.Data.DisposeDataReader(drDefinedRules)
        'Get Grid Details
        strMenu = DrawMenu()
        Response.Write(strMenu)
        strHtml.Append("<div ID=PageDiv style='overflow:auto;width:100%;height:200px'>" + vbCrLf)
        strHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        If strMode = "EDIT" Or strMode = "CLEAR" Or (strMode = "SAVE" And strAction <> "SAVEALL") Then
            strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("WINDOW_TITLE") + "</TD></TR></TABLE>" + vbCrLf)
        Else
            strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("CONFIGURE_RULE") + "</TD><TD align=right>" + MyBase.GetResourceString("NOD") + "&nbsp;:&nbsp;" + strNatureOfDemand + "</TD></TR></TABLE>" + vbCrLf)
        End If
        strHtml.Append("<BR>")
        strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)

        If strMode = "EDIT" Or strMode = "CLEAR" Or (strMode = "SAVE" And strAction <> "SAVEALL") Then
            strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("NOD") + "&nbsp;:&nbsp;" + strNatureOfDemand + "</TD><TD align=Right>" + MyBase.GetResourceString("STAGE") + "&nbsp;:&nbsp;" + strRequestStage + "</TD></TR></TABLE>" + vbCrLf)
            strHtml.Append("<BR>" + vbCrLf)
            strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
            strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("APPROVER_CAP") + "&nbsp;:&nbsp;" + strApproverName + "</TD><TD align=Left>&nbsp;</TD></TR></TABLE><BR>" + vbCrLf)
        End If

        strHtml.Append("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>" + vbCrLf)
        strHtml.Append("<TR class='clsTREven'>" + vbCrLf)
        strHtml.Append("<TD align=Right valign='top'>" & MyBase.GetResourceString("FIELD") & "</TD><TD align=Left valign='top'>&nbsp; " & CommonFunctions.HTMLControls.DrawComboBox("cboFieldList", "usp_Sel_Tbl_IM_RuleAttributes NULL," + intNatureOfDemandID.ToString, 200, , "onchange=javascript:Field_OnChange()", True, True) & "</TD>" + vbCrLf)
        strHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboField", "usp_Sel_Tbl_IM_RuleAttributes 2," + intNatureOfDemandID.ToString, 200, , "onchange=javascript:FilterField_OnChange('')", True, True, , , , True) + vbCrLf)
        strHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboValidationRule", "usp_Sel_Tbl_IM_RuleAttributes 3," + intNatureOfDemandID.ToString, 200, , "onchange=javascript:FilterField_OnChange('')", True, True, , , , True) + vbCrLf)
        strHtml.Append("<TD align=Right valign='top'>" & MyBase.GetResourceString("OPERATOR") & "</TD><TD align=Left valign='top'>&nbsp; " + CommonFunction.HTMLControls.DrawComboBox("cboOperator", "usp_Sel_PB_ComparisonOperators", 80, "=", , True, True) + "</TD>" + vbCrLf)
        strHtml.Append("<TD align=Right valign='top'>" & MyBase.GetResourceString("VALUE") & "&nbsp;</TD>" + vbCrLf)
        strHtml.Append("<TD align=Left>")
        While drRuleDetails.Read

            Select Case CommonFunction.Data.CheckIsDBNull(drRuleDetails("FieldType"), "0")
                Case "1"
                    'Draw Combo Box
                    strHtml.Append(CommonFunctions.HTMLControls.DrawComboBox(CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), CommonFunction.Data.CheckIsDBNull(drRuleDetails("SQLSource"), ""), 300, , "onchange=javascript:FilterField_OnChange('')", , True, , , , True) + vbCrLf)
                Case "2"
                    'Draw Text Box
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    strHtml.Append(CommonFunctions.HTMLControls.DrawTextBox(CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), , 200, 10, "", , , , , , , , True, , , , True, EnableHTMLEncode:=True) + vbCrLf)
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                Case "3"
                    'Draw Date Control
                    strHtml.Append(CommonFunctions.HTMLControls.DrawDateControl(CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), , 80, , "Calender_OnClick", "frm_DM_RuleEngine", , , , , , , True, , , , True) + vbCrLf)
                    strHtml.Append(CommonFunctions.HTMLControls.DrawImage("../../Images/calendar.gif", "imgCalendar", " style='Display: none; CURSOR: hand;'", "Calender_OnClick('','')", , , "Click to open calendar", True) + vbCrLf)
                Case "4"
                    'Draw List Box
                    strHtml.Append(CommonFunction.HTMLControls.DrawListBox(CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), CommonFunction.Data.CheckIsDBNull(drRuleDetails("SQLSource"), ""), 300, 80, , , , True, , , , True) + vbCrLf)
            End Select

        End While
        strHtml.Append("</TD>")
        strHtml.Append("<TD align='left' valign='bottom'>")
        strHtml.Append("|")
        strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:Append_OnClick()' Title='Append'> Append </A></B> " + vbCrLf)
        strHtml.Append("|")
        strHtml.Append("</TD></TR>" + vbCrLf)
        strHtml.Append("</TABLE>")

        strHtml.Append("<Table width=99.9% class='clsTable' cellpadding=0 cellspacing=0>" + vbCrLf)
        strHtml.Append("<TR class='clsTREven'>" + vbCrLf)
        strHtml.Append("<TD align='left' width=5% >Insert</TD>" + vbCrLf)

        strHtml.Append("<TD align='left'>")
        strHtml.Append("|")
        strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:OpeningBracket_OnClick()' Title='Append'> ( </A></B> " + vbCrLf)
        strHtml.Append("|")
        strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:ClosingBracket_OnClick()' Title='Append'> ) </A></B> " + vbCrLf)
        strHtml.Append("|")
        strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:And_OnClick()' Title='Append'> AND </A></B> " + vbCrLf)
        strHtml.Append("|")
        strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:Or_OnClick()' Title='Append'> OR </A></B> " + vbCrLf)
        ' purvaj 16 July 2008
        'strHtml.Append("|")
        'strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:AllowAll_OnClick()' Title='Append'> Allow All </A></B> " + vbCrLf)
        'strHtml.Append("|")
        'strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:AllowNone_OnClick()' Title='Append'> Deny All </A></B> " + vbCrLf)
        strHtml.Append("|")
        strHtml.Append("</TD>" + vbCrLf)

        strHtml.Append("<TD width=10% >&nbsp;</TD>" + vbCrLf)
        strHtml.Append("</TR>" + vbCrLf)

        strHtml.Append("<TR class='clsTREven'>" + vbCrLf)
        strHtml.Append("<TD align='left' colspan=2 >" + vbCrLf)

        If strMode = "EDIT" Or strMode = "CLEAR" Or (strMode = "SAVE" And strAction <> "SAVEALL") Then
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtUserFriendlyRule", "txtUserFriendlyRule", , , , , , , 800, 50, , strUserFriendlyRule, , , True, True, , , , True))
            'strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtRule", "txtRule", , , , , , , 800, 50, , strRule, , , , , , , , True, , , , , , True))
            strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtUserFriendlyRule", "txtUserFriendlyRule", , , , , , , 800, 50, , strUserFriendlyRule, , , True, True, , , , True, EnableHTMLEncode:=True))
            strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtRule", "txtRule", , , , , , , 800, 50, , strRule, , , , , , , , True, , , , , , True, EnableHTMLEncode:=True))
        Else
            'strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtUserFriendlyRule", "txtUserFriendlyRule", , , , , , , 800, 50, , , , , True, True, , , , True))
            'strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtRule", "txtRule", , , , , , , 800, 50, , , , , , , , , , True, , , , , , True))
            strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtUserFriendlyRule", "txtUserFriendlyRule", , , , , , , 800, 50, , , , , True, True, , , , True, EnableHTMLEncode:=True))
            strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtRule", "txtRule", , , , , , , 800, 50, , , , , , , , , , True, , , , , , True, EnableHTMLEncode:=True))
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        End If
        strHtml.Append("</TD>")
        strHtml.Append("<TD align='left' valign='bottom'>")
        strHtml.Append("|")
        strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:ClearAll_OnClick()' Title='Clear All'> Clear All </A></B> " + vbCrLf)
        strHtml.Append("|")
        strHtml.Append("</TD>" + vbCrLf)

        strHtml.Append("</TR>")
        strHtml.Append("</TABLE>" + vbCrLf)

        strHtml.Append("<BR>" + vbCrLf)
        CommonFunction.General.WriteHTML(strHtml.ToString)
        strHtml = Nothing
        If strMode = "APPLYALL" Then
            Response.Write("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
            Response.Write("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("SEL_APPROVER") + "</TD>" + vbCrLf)
            Response.Write("<TD align=Right> " + MyBase.GetResourceString("STAGE") + " </TD>" + vbCrLf)
            Response.Write("<TD align=Left>&nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboStage", "usp_Sel_NOI_RequestStage " + intNatureOfDemandID.ToString, 300, srtStage, "onchange='cboStage_Change()'", True, True) + "</TD>" + vbCrLf)
            Response.Write("</TR></TABLE><BR>" + vbCrLf)
            DrawGrid()
        End If
        Response.Write("</div>")

        ' Footer Note 
        Response.Write("<TABLE id='tblNote'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        Response.Write("<TR class=clsTREven><TD align=right> <B>" + MyBase.GetResourceString("CAP_NOTE") + "</B></TD>" + vbCrLf)
        Response.Write("<TD align=left>" + MyBase.GetResourceString("CAP_NOTE1") + "</TD>" + vbCrLf)
        Response.Write("</TR></TABLE>" + vbCrLf)
        Response.Write("<br>" + strMenu)
        CommonFunction.Data.DisposeDataReader(drRuleDetails)
    End Sub

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()
        ' Purpose               : To generate the Grid
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : August 29,2006
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandID"), "")

        Dim arrActualColumns() As String = {"RequestStage", "EmployeeName", "UserFriendlyRuleDetails", "History", "Selected"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("STAGE"), MyBase.GetResourceString("APPROVER_CAP"), MyBase.GetResourceString("RULE"), MyBase.GetResourceString("HISTORY_CAP"), MyBase.GetResourceString("SELECT_CAP")}
        Dim arrGroupColumns() As String = {"1", "", "", "", ""}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=center", "align=center"}
        Dim arrRowLink() As String = {"", "", "", "History_OnClick(NOIRuleID)", ""}
        Dim arrRowLinkTooltip() As String = {"", "", "", MyBase.GetResourceString("HISTORY_CAP"), ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        If strStageChange = "YES" Then
            strQuery = "Exec usp_Sel_Tbl_IM_NatureOfDemand_Stage_Rule " + intNatureOfDemandID.ToString + "," + intChangeStageID.ToString
        Else
            strQuery = "Exec usp_Sel_Tbl_IM_NatureOfDemand_Stage_Rule_All " + intNatureOfDemandID.ToString
        End If
        'Set the Generic Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "NOIRuleID"
            .GroupOnColumn = arrGroupColumns
            .RowLinkArray = arrRowLink
            .RowLinkToolTipArray = arrRowLinkTooltip

            '.SortBy = m_strSortBy
            '.SortOrder = m_strSortOrder
            '.ClientSideSortFunctionName = "Sort_OnClick"

            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "DivList"
            .DIVHeight = 180
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 5
            '.returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
        m_objGrid = Nothing
    End Sub
    Private Sub DrawListGrid()
        '=====================================================================
        ' Procedure Name        : DrawListGrid()
        ' Purpose               : To generate the Grid for List Mode 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : August 29,2006
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String

        Dim arrActualColumns() As String = {"RoleDescription", "UserFriendlyRuleDetails"} ', "History"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("APPROVER_CAP"), MyBase.GetResourceString("RULE")} ', MyBase.GetResourceString("HISTORY_CAP")}
        Dim arrGroupColumns() As String = {"", ""} ', ""}
        Dim arrTDStyle() As String = {"align=left", "align=left"} ', "align=center"}
        Dim arrRowLink() As String = {"Edit_OnClick(RoleID)", ""} ', "History_OnClick(NOIRuleID)"}
        'Dim arrRowLinkTooltip() As String = {"", "", "", MyBase.GetResourceString("HISTORY_CAP")}
        strQuery = "Exec usp_Sel_Tbl_IM_NatureOfDemand_Stage_Rule " + intNatureOfDemandID.ToString + "," + intRequestStageID.ToString
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Set the Generic Grid Properties
        With m_objList
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "NOIRuleID"
            .GroupOnColumn = arrGroupColumns
            .RowLinkArray = arrRowLink
            '.RowLinkToolTipArray = arrRowLinkTooltip
            '.SortBy = m_strSortBy
            '.SortOrder = m_strSortOrder
            '.ClientSideSortFunctionName = "Sort_OnClick"


            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "DivListGrid"
            .DIVHeight = 375
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 2
            '.returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
        m_objList = Nothing
    End Sub
    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Aug 26,2006
        ' Revisions             :
        '=====================================================================
        Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode").ToUpper, "")
        If strMode = "EDIT" Or strMode = "SAVE" Or strMode = "CLEAR" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLEAR_RULE"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLEAR_RULE_TOOLTIP"), MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Save_OnClick('" + strMode + "')", "ClearRule_OnClick()", "Back_OnClick()", "Close_OnClick()", "OpenHelpPage('" + MyBase.GetResourceString("OPEN_HELP_DEFINE") + "')"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            Return strMenu
        End If
        If strMode = "LIST" Or strMode = "PROJECT_LIST" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Close_OnClick()", "OpenHelpPage('" + MyBase.GetResourceString("OPEN_HELP_DEFINE") + "')"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            Return strMenu
        End If
        If strMode = "APPLYALL" Or strMode = "SAVEALL" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Save_OnClick('" + strMode + "')", "Close_OnClick()", "OpenHelpPage('" + MyBase.GetResourceString("OPEN_HELP_CONFIGURE") + "')"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            Return strMenu
        End If
    End Function

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "SELECTED" Then
            Cancel = True
            Dim strApproverID As String = CType(Args.DataReader("Selected"), String)
            Dim strStageID As String = CType(Args.DataReader("RequestStageID"), String)
            Args.StringToBeInserted = "<TD  align=center >" + vbCrLf
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , , strApproverID, , , True)
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkStage", "chkStage", , , strStageID, , , True, , , , True)
            Args.StringToBeInserted += "</Td>"
        End If
    End Sub

    Protected Overrides Sub finalize()
        If Not IsNothing(m_objMenu) Then m_objMenu = Nothing
        If Not IsNothing(m_objList) Then m_objList = Nothing
        If Not IsNothing(m_objGrid) Then m_objGrid = Nothing
        If Not IsNothing(intNatureOfDemandID) Then intNatureOfDemandID = Nothing
        If Not IsNothing(intRequestStageID) Then intRequestStageID = Nothing
        If Not IsNothing(intApproverID) Then intApproverID = Nothing
        If Not IsNothing(strNatureOfDemand) Then strNatureOfDemand = Nothing
        If Not IsNothing(strRequestStage) Then strRequestStage = Nothing
        If Not IsNothing(strApproverName) Then strApproverName = Nothing
        If Not IsNothing(strRule) Then strRule = Nothing
        If Not IsNothing(strUserFriendlyRule) Then strUserFriendlyRule = Nothing
        If Not IsNothing(m_arrUniqueIDList) Then m_arrUniqueIDList = Nothing
        If Not IsNothing(strMode) Then strMode = Nothing
        If Not IsNothing(m_strSortBy) Then m_strSortBy = Nothing
        If Not IsNothing(strRuleDetails) Then strRuleDetails = Nothing
        If Not IsNothing(strUserFriendlyRuleDetails) Then strUserFriendlyRuleDetails = Nothing
        If Not IsNothing(strUserName) Then strUserName = Nothing
        If Not IsNothing(srtStage) Then srtStage = Nothing
        If Not IsNothing(strStageChange) Then strStageChange = Nothing
        If Not IsNothing(intChangeStageID) Then intChangeStageID = Nothing
        If Not IsNothing(strAction) Then strAction = Nothing

    End Sub

    Private Sub m_objList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objList.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "HISTORY" Then
            If CommonFunction.Data.CheckIsDBNull(Args.DataReader("UserFriendlyRuleDetails")) = "" Then
                Cancel = True
                Args.StringToBeInserted = "<td>-</td>"
            End If
        End If
    End Sub
End Class
