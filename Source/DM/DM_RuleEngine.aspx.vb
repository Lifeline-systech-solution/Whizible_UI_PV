Public Class DM_RuleEngine
    Inherits WebPages.Template.WhizTemplate

    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Protected intNatureOfDemandID As Integer
    Protected intRequestStageID As Integer
    Protected strNatureOfDemand As String
    Protected strRule As String = ""
    Protected strUserFriendlyRule As String = ""
    Private WithEvents m_objList As WebPages.Template.GenericGrid
    Protected strMode As String
    Protected strRuleDetails As String
    Protected strUserFriendlyRuleDetails As String
    Protected strAction As String
    Protected strUserName As String
    Protected srtStage As String
    Protected intRuleID As String = "0"
    Protected strRuleName As String = ""
    Private strHtml As New System.Text.StringBuilder

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
        MyBase.InitializeResources("AppResources.DM_RuleEngine", "AppResources")
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
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        ' Revisions             :
        '=====================================================================

        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting

        MyBase.InitializeResources("AppResources.DM_RuleEngine", "AppResources")
        Dim strSQL As String

        InitVariables()

        If strMode = "STAGE" Then
            DrawStageGrid()
        End If
        If strMode = "PROJECT_STAGE" Then
            DrawProjectStageGrid()
        End If
        If strMode = "SAVESTAGE" Then
            SaveStages()
            DrawStageGrid()
        End If

        If strMode = "LIST" Then
            Draw_List()
        End If
        If strMode = "SAVE" Then
            'Save From Edit Mode
            If Validate_Query(strRuleDetails) Then
                Perform_Action(strMode)
            End If
        End If

        If strMode = "EDIT" Or strMode = "ADD_NEW" Or strMode = "SAVE" Then
            Draw_Page()
        End If
    End Sub
    Protected Sub SaveStages()
        '=====================================================================
        ' Procedure Name        : SaveStages()
        ' Purpose               : Save Stages Against Rule and NOI.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SwatiC
        ' Created               : Mar 14,2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strStageIDs As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect"), "0")

        strSQL = "Usp_Ins_tbl_IM_Rule_Stages " + intNatureOfDemandID.ToString + ",'" + strStageIDs + "'," + intRuleID

        CommonFunction.Data.SQLInsertOrUpdateData(strSQL)
        ' Refresh PArent Page
        Response.Write(vbCrLf + "<Script language=javascript>")
        Response.Write(vbCrLf + "   refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','DemandTypes_CommonPage.aspx?NatureofDemandID_PK=" + intNatureOfDemandID.ToString + "&MasterTagID=3928&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
        Response.Write(" window.close();")
        Response.Write(vbCrLf + "</Script>")
    End Sub
    Protected Sub DrawStageGrid()
        '=====================================================================
        ' Procedure Name        : DrawStageGrid()
        ' Purpose               : To draw the Grid
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SwatiC
        ' Created               : Mar 14,2008
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        m_objList = New WebPages.Template.GenericGrid

        Dim strHtml_List As New System.Text.StringBuilder
        Dim strMenu As String

        Dim arrActualColumns() As String = {"RequestStage", "OrderNo", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("REQUEST_STAGE"), MyBase.GetResourceString("ORDER_NO"), MyBase.GetResourceString("SELECT")}
        Dim arrTDStyle() As String = {"align=left", "align=center"}
        Dim arrRowLinkTooltip() As String = {MyBase.GetResourceString("REQUEST_STAGE"), MyBase.GetResourceString("ORDER_NO"), MyBase.GetResourceString("SELECT")}
        Dim arrCheckBoxID() As String = {"", "", "chkSelect"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        strQuery = "Exec Usp_Sel_NatureOfDemand_Stages " + intNatureOfDemandID.ToString + "," + intRuleID


        strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_Workflow " + intNatureOfDemandID.ToString, MyBase.UseSQL), "")

        strMenu = DrawMenu()
        Response.Write(strMenu)

        strHtml_List.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml_List.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("CONFIGURESTAGES") + "</TD><TD align=Right>" + MyBase.GetResourceString("NOD") + "&nbsp;:&nbsp;" + strNatureOfDemand + "</TD></TR></TABLE><BR>" + vbCrLf)

        strHtml_List.Append("<BR>")
        CommonFunction.General.WriteHTML(strHtml_List.ToString)

        'Set the Generic Grid Properties
        With m_objList
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "RequestStageID"
            .CheckBoxIDArray = arrCheckBoxID
            .RowLinkToolTipArray = arrRowLinkTooltip
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "DivListGrid"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 2
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
        m_objList = Nothing

        Response.Write("<br>" + strMenu)
        strHtml_List = Nothing


    End Sub
    Protected Sub DrawProjectStageGrid()
        '=====================================================================
        ' Procedure Name        : DrawProjectStageGrid()
        ' Purpose               : To draw the Project Rule Stage Grid
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
        m_objList = New WebPages.Template.GenericGrid

        Dim strHtml_List As New System.Text.StringBuilder
        Dim strMenu As String

        Dim arrActualColumns() As String = {"RequestStage", "OrderNo", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("REQUEST_STAGE"), MyBase.GetResourceString("ORDER_NO"), MyBase.GetResourceString("SELECT")}
        Dim arrTDStyle() As String = {"align=left", "align=center"}
        Dim arrRowLinkTooltip() As String = {MyBase.GetResourceString("REQUEST_STAGE"), MyBase.GetResourceString("ORDER_NO"), MyBase.GetResourceString("SELECT")}
        Dim arrCheckBoxID() As String = {"", "", "chkSelect"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        strQuery = "Exec Usp_Sel_ProjectNatureOfDemand_Stages " + intNatureOfDemandID.ToString + "," + intRuleID


        strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_Workflow " + intNatureOfDemandID.ToString, MyBase.UseSQL), "")

        strMenu = DrawMenu()
        Response.Write(strMenu)

        strHtml_List.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml_List.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("CONFIGURESTAGES") + "</TD><TD align=Right>" + MyBase.GetResourceString("NOD") + "&nbsp;:&nbsp;" + strNatureOfDemand + "</TD></TR></TABLE><BR>" + vbCrLf)

        strHtml_List.Append("<BR>")
        CommonFunction.General.WriteHTML(strHtml_List.ToString)

        'Set the Generic Grid Properties
        With m_objList
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "RequestStageID"
            .CheckBoxIDArray = arrCheckBoxID
            .RowLinkToolTipArray = arrRowLinkTooltip
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "DivListGrid"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = arrActualColumns.Length - 1
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
        m_objList = Nothing

        Response.Write("<br>" + strMenu)
        strHtml_List = Nothing


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
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        ' Revisions             :
        '=====================================================================

        strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode").ToUpper, "")
        strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "").ToUpper

        intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandID"), "0")
        If intNatureOfDemandID = 0 Then
            intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ForeignKeyValue"), "0")
        End If
       

        strRuleDetails = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtRule"), "")
        strUserFriendlyRuleDetails = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUserFriendlyRule"), "")
        strRuleDetails = CommonFunctions.General.BuildQueryString(strRuleDetails)
        strUserFriendlyRuleDetails = CommonFunctions.General.BuildQueryString(strUserFriendlyRuleDetails)
        strUserName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "").ToString
        strUserName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetSQLDataScalar("usp_sel_IM_Role_RuleEngine " + strUserName), "")

        intRuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RuleID"), "0")

        If intRuleID = "0" Or intRuleID Is Nothing Then
            intRuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NOIRuleID"), "0")
        End If
        If strMode = "EDIT" Or strMode = "SAVE" Or strMode = "ADD_NEW" Then
            intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandID"), "0")
            If intNatureOfDemandID = 0 Then
                intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ForeignKeyValue"), "0")
            End If

        End If
        If intNatureOfDemandID = 0 Then
            intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectNatureOfDemandID"), "0")
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
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        '=====================================================================
        'Dim strSQL As String
        'strSQL = "SELECT 1 FROM tbl_IM_IdeaMaster WITH (NOLOCK) Where 1=1 AND " + strActualFormula
        'Dim dr As IDataReader
        'Try
        '    dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'Catch exc As Exception
        '    Return False
        'Finally
        '    CommonFunction.Data.DisposeDataReader(dr)
        'End Try
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
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        If strAction = "SAVE" Then
            strRuleName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtRuleName"), "")

            If intRuleID = "0" Or intRuleID Is Nothing Then
                strSQL = "usp_Ins_Upd_Tbl_IM_NatureOfDemand_Rule " + intNatureOfDemandID.ToString + ",'" + strRuleDetails + "','" + strUserFriendlyRuleDetails + "','" + strUserName + "','" + strRuleName + "', NULL"
            Else
                strSQL = "usp_Ins_Upd_Tbl_IM_NatureOfDemand_Rule " + intNatureOfDemandID.ToString + ",'" + strRuleDetails + "','" + strUserFriendlyRuleDetails + "','" + strUserName + "','" + strRuleName + "', " + intRuleID
            End If
            CommonFunction.Data.SQLInsertOrUpdateData(strSQL)

            ' Refresh PArent Page
            Response.Write(vbCrLf + "<Script language=javascript>")
            Response.Write(vbCrLf + "   refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','DemandTypes_CommonPage.aspx?NatureofDemandID_PK=" + intNatureOfDemandID.ToString + "&MasterTagID=3928&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
            'WhiziblePPM/Source/DM/DemandTypes_CommonPage.aspx?Operation=SAVE&Mode=&NatureofDemandID=3&MasterTagID=2114&FromWhere=DM&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1
            Response.Write(" window.close();")
            Response.Write(vbCrLf + "</Script>")
            strSQL = Nothing
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

        Dim strMenu As String
        Dim strUSP As String

        strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_Workflow " + intNatureOfDemandID.ToString, MyBase.UseSQL), "")

        'To Plot Top Menu
        strMenu = DrawMenu()
        Response.Write(strMenu)

        'To Draw Plot Header
        DrwaPageCaption()

        'To Plot the Grid
        DrawListGrid()

        'To Plot Bottom Menu
        Response.Write("<br>" + strMenu)


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
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String
        Dim strWhere As String = ""
        Dim strFilterFlag As String
        Dim strUSP As String

        Dim objLink As WebPage.UI.cDynamicLink

        strFilterFlag = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboFieldList"), ""), String)
        'intNatureOfDemandID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandID"), "")
        strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_Workflow " + intNatureOfDemandID.ToString, MyBase.UseSQL), "")

        strUserFriendlyRule = ""
        strRule = ""

        'To Plot Top Menu
        strMenu = DrawMenu()
        Response.Write(strMenu)


        Response.Write("<div ID=PageDiv style='overflow:auto;width:100%;height:200px'>" + vbCrLf)

        'To Plot Page header
        DrwaPageCaption()

        'To Plot UI
        DrawUI()

        strHtml = Nothing
        Response.Write("</div>")

        ' Footer Note 
        Response.Write("<TABLE id='tblNote'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        Response.Write("<TR class=clsTREven><TD align=right> <B>" + MyBase.GetResourceString("CAP_NOTE") + "</B></TD>" + vbCrLf)
        Response.Write("<TD align=left>" + MyBase.GetResourceString("CAP_NOTE1") + "</TD>" + vbCrLf)
        Response.Write("</TR></TABLE>" + vbCrLf)

        'To Plot Bottom Menu
        Response.Write("<br>" + strMenu)

    End Sub
    Private Sub DrwaPageCaption()
        '=====================================================================
        ' Procedure Name        : DrwaPageCaption()
        ' Purpose               : To draw Page Caption.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        ' Revisions             :
        '=====================================================================
        Dim strCaption As String = ""

        strCaption = "<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf
        strCaption += "<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("WINDOW_TITLE") + "</TD><TD align=Right>" + MyBase.GetResourceString("NOD") + "&nbsp;:&nbsp;" + strNatureOfDemand + "</TD></TR></TABLE>" + vbCrLf
        strCaption += "<BR>"
        CommonFunction.General.WriteHTML(strCaption)

    End Sub
    Private Sub DrawUI()
        '=====================================================================
        ' Procedure Name        : DrawUI()
        ' Purpose               : To Draw UI
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        ' Revisions             :
        '=====================================================================

        Dim drRuleDetails As IDataReader
        Dim drDefinedRules As IDataReader
        Dim strUSP As String


        'Get Rule Details and User Friendly Rule Details
        strUSP = "usp_Get_Tbl_IM_NatureOfDemand_Rule " + intRuleID

        drDefinedRules = CommonFunction.Data.GetDataReader(strUSP, MyBase.UseSQL)
        While drDefinedRules.Read
            strUserFriendlyRule = CommonFunction.Data.CheckIsDBNull(drDefinedRules("UserFriendlyRuleDetails"), "")
            strRule = CommonFunction.Data.CheckIsDBNull(drDefinedRules("RuleDetails"), "")
            strRuleName = CommonFunction.Data.CheckIsDBNull(drDefinedRules("RuleName"), "")
        End While
        CommonFunction.Data.DisposeDataReader(drDefinedRules)

        strHtml.Append("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>" + vbCrLf)

        'To plot Rule Name control
        strHtml.Append("<TR class='clsTREven'>" + vbCrLf)
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        strHtml.Append("<TD align=Right valign='top'>Rule Name</TD><TD  colspan =8 align=Left valign='top'>&nbsp; " & CommonFunctions.HTMLControls.DrawTextBox("txtRuleName", "txtRuleName", , 400, 200, strRuleName, , , , , , , , True, True, EnableHTMLEncode:=True) & "</TD>" + vbCrLf)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        strHtml.Append("</TR>")

        'To plot Filed control
        strHtml.Append("<TR class='clsTREven'>" + vbCrLf)
        strHtml.Append("<TD align=Right valign='top'>" & MyBase.GetResourceString("FIELD") & "</TD><TD align=Left valign='top'>&nbsp; " & CommonFunctions.HTMLControls.DrawComboBox("cboFieldList", "usp_Sel_Tbl_IM_RuleAttributes NULL," + intNatureOfDemandID.ToString, 200, , "onchange=javascript:Field_OnChange()", True, True) & "</TD>" + vbCrLf)
        strHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboField", "usp_Sel_Tbl_IM_RuleAttributes 2," + intNatureOfDemandID.ToString, 200, , "onchange=javascript:FilterField_OnChange('')", True, True, , , , True) + vbCrLf)
        strHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboValidationRule", "usp_Sel_Tbl_IM_RuleAttributes 3," + intNatureOfDemandID.ToString, 200, , "onchange=javascript:FilterField_OnChange('')", True, True, , , , True) + vbCrLf)

        'To plot Operatot control
        strHtml.Append("<TD align=Right valign='top'>" & MyBase.GetResourceString("OPERATOR") & "</TD><TD align=Left valign='top'>&nbsp; " + CommonFunction.HTMLControls.DrawComboBox("cboOperator", "usp_Sel_PB_ComparisonOperators", 80, "=", , True, True) + "</TD>" + vbCrLf)

        'To plot Value control
        strHtml.Append("<TD align=Right valign='top'>" & MyBase.GetResourceString("VALUE") & "&nbsp;</TD>" + vbCrLf)
        strHtml.Append("<TD align=Left>")

        strUSP = "usp_Sel_Tbl_IM_RuleAttributes 1," + intNatureOfDemandID.ToString
        drRuleDetails = CommonFunction.Data.GetDataReader(strUSP, MyBase.UseSQL)

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
                    strHtml.Append(CommonFunctions.HTMLControls.DrawDateControl(CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), , 80, , "Calender_OnClick", "frm_IM_RuleEngine", , , , , , , True, , , , True) + vbCrLf)
                    strHtml.Append(CommonFunctions.HTMLControls.DrawImage("../../Images/calendar.gif", "imgCalendar", " style='Display: none; CURSOR: hand;'", "Calender_OnClick('','')", , , "Click to open calendar", True) + vbCrLf)
                Case "4"
                    'Draw List Box
                    strHtml.Append(CommonFunction.HTMLControls.DrawListBox(CommonFunction.Data.CheckIsDBNull(drRuleDetails("RuleAttribute"), ""), CommonFunction.Data.CheckIsDBNull(drRuleDetails("SQLSource"), ""), 300, 80, , , , True, , , , True) + vbCrLf)
            End Select

        End While
        CommonFunction.Data.DisposeDataReader(drRuleDetails)

        strHtml.Append("</TD>")

        'To plot Append Link 
        strHtml.Append("<TD align='left' valign='bottom'>")
        strHtml.Append("|")
        strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:Append_OnClick()' Title='Append'> Append </A></B> " + vbCrLf)
        strHtml.Append("|")
        strHtml.Append("</TD></TR>" + vbCrLf)
        strHtml.Append("</TABLE>")

        'To plot (,),And, or, Allow All, Deny All
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
        strHtml.Append("|")
        'strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:AllowAll_OnClick()' Title='Append'> Allow All </A></B> " + vbCrLf)
        'strHtml.Append("|")
        'strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:AllowNone_OnClick()' Title='Append'> Deny All </A></B> " + vbCrLf)
        'strHtml.Append("|")
        strHtml.Append("</TD>" + vbCrLf)

        strHtml.Append("<TD width=10% >&nbsp;</TD>" + vbCrLf)
        strHtml.Append("</TR>" + vbCrLf)


        'To plot Rule Defination control
        strHtml.Append("<TR class='clsTREven'>" + vbCrLf)
        strHtml.Append("<TD align='left' colspan=2 >" + vbCrLf)

        If strMode = "EDIT" Or strMode = "ADD_NEW" Or strMode = "SAVE" Then
            strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtUserFriendlyRule", "txtUserFriendlyRule", , , , , , , 800, 50, , strUserFriendlyRule, , , True, True, , , , True))
            strHtml.Append(CommonFunction.HTMLControls.DrawTextArea("txtRule", "txtRule", , , , , , , 800, 50, , strRule, , , , , , , , True, , , , , , True))
        End If

        strHtml.Append("</TD>")

        'To plot Clear All Link
        strHtml.Append("<TD align='left' valign='bottom'>")
        strHtml.Append("|")
        strHtml.Append("<B> <A style='FONT-WEIGHT: bold; TEXT-DECORATION: none' HREF='Javascript:ClearAll_OnClick()' Title='Clear All'> Clear All </A></B> " + vbCrLf)
        strHtml.Append("|")
        strHtml.Append("</TD>" + vbCrLf)

        strHtml.Append("</TR>")
        strHtml.Append("</TABLE>" + vbCrLf)

        strHtml.Append("<BR>" + vbCrLf)
        CommonFunction.General.WriteHTML(strHtml.ToString)

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
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        m_objList = New WebPages.Template.GenericGrid

        Dim arrActualColumns() As String = {"RuleName", "UserFriendlyRuleDetails", "ConfigureStages"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RULE_NAME"), MyBase.GetResourceString("RULE"), MyBase.GetResourceString("CONFIGURESTAGES")}
        Dim arrGroupColumns() As String = {"", "", ""}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=center"}
        Dim arrRowLink() As String = {"Edit_OnClick(NOIRuleID)", "", "ConfigureStages_OnClick(NOIRuleID,NatureOfDemandID)"}
        Dim arrRowLinkTooltip() As String = {MyBase.GetResourceString("RULE_NAME"), MyBase.GetResourceString("RULE"), MyBase.GetResourceString("CONFIGURESTAGES")}
        strQuery = "Exec usp_Sel_Tbl_IM_NatureOfDemand_Rule " + intNatureOfDemandID.ToString
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Set the Generic Grid Properties
        With m_objList
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "NOIRuleID"
            .RowLinkArray = arrRowLink
            .RowLinkToolTipArray = arrRowLinkTooltip
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "DivListGrid"
            .DIVHeight = 375
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 3
            .returnHTML = True
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
        ' Author                : SwatiC
        ' Created               : Mar 13,2008
        ' Revisions             :
        '=====================================================================
        Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode").ToUpper, "")

        If strMode = "STAGE" Or strMode = "SAVESTAGE" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"SaveStage_OnClick(" + intRuleID + "," + intNatureOfDemandID.ToString + ")", "Close_OnClick()"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            Return strMenu
        End If

        If strMode = "EDIT" Or strMode = "ADD_NEW" Or strMode = "SAVE" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Save_OnClick('" + strMode + "')", "Close_OnClick()", "OpenHelpPage('" + MyBase.GetResourceString("OPEN_HELP_DEFINE") + "')"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            Return strMenu
        End If
        If strMode = "LIST" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADD"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADD"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Add_OnClick()", "Close_OnClick()", "OpenHelpPage('" + MyBase.GetResourceString("OPEN_HELP_DEFINE") + "')"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            Return strMenu
        End If
        If strMode = "PROJECT_STAGE" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Close_OnClick()", "OpenHelpPage('" + MyBase.GetResourceString("OPEN_HELP_DEFINE") + "')"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            Return strMenu
        End If
    End Function

    Protected Overrides Sub finalize()
        If Not IsNothing(m_objMenu) Then m_objMenu = Nothing
        If Not IsNothing(m_objList) Then m_objList = Nothing
        If Not IsNothing(intNatureOfDemandID) Then intNatureOfDemandID = Nothing
        If Not IsNothing(intRequestStageID) Then intRequestStageID = Nothing
        If Not IsNothing(strRule) Then strRule = Nothing
        If Not IsNothing(strUserFriendlyRule) Then strUserFriendlyRule = Nothing
        If Not IsNothing(strMode) Then strMode = Nothing
        If Not IsNothing(strRuleDetails) Then strRuleDetails = Nothing
        If Not IsNothing(strUserFriendlyRuleDetails) Then strUserFriendlyRuleDetails = Nothing
        If Not IsNothing(strUserName) Then strUserName = Nothing
        If Not IsNothing(srtStage) Then srtStage = Nothing
        If Not IsNothing(strAction) Then strAction = Nothing

    End Sub

    Private Sub m_objList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objList.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            If CType(Args.DataReader("Select"), Integer) > 0 Then
                Args.IsCheckBoxChecked = True
            Else
                Args.IsCheckBoxChecked = False
            End If
        End If
    End Sub
End Class
