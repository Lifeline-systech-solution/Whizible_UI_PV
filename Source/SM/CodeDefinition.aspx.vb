Public Class CodeDefinition
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    '=====================================================================
    ' Page Name             : CodeDefinition
    ' Purpose               : To generate the code for Code Templates
    ' Description           : This page is called from the Code Templates page
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : AbhijeetD
    ' Created               : 5th May 2004
    ' Revisions             : 
    '=====================================================================

    'Constants
    Private Const MAX_CODE_MASKS As Integer = 5

    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private m_strCodeTemplate As String
    Private m_strCoShortCode As String
    Private m_intModuleID As Integer
    Private m_strFromWhere As String
    Private m_strAction As String
    Private m_strlblprjSystem As String
    Protected WithEvents frmCodeDefinition As System.Web.UI.HtmlControls.HtmlForm
    Private m_strlblprjJob As String


    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Retrieve FromWhere from the query string
        m_strFromWhere = CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
        CommonFunction.HTMLControls.DrawTextBox("hdFromWhere", "hdFromWhere", , , , m_strFromWhere, , , , , , True, EnableHTMLEncode:=True)

        'Retrieve Action from the query string
        m_strAction = CommonFunction.General.CheckIsNothing(Request.QueryString("Action"))

        'Retrieve Action from the query string
        m_intModuleID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ModuleID"), "0"), Integer)
        CommonFunction.HTMLControls.DrawTextBox("hdModuleID", "hdModuleID", , , , m_intModuleID.ToString, , , , , , True, EnableHTMLEncode:=True)

        'Retrieve the CodeTemplate from query string
        'm_strCodeTemplate = CommonFunction.General.CheckIsNothing(Request.QueryString("CodeTemplate"), "")

        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

        ''m_strCodeTemplate = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT CodeTemplate FROM tbl_PM_CodeTemplates WHERE ModuleID = " + m_intModuleID.ToString, m_blnUseSQL))).ToString
        m_strCodeTemplate = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_PM_CodeTemplates_ModuleID " + m_intModuleID.ToString, m_blnUseSQL))).ToString
        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

        m_strCodeTemplate = m_strCodeTemplate.Replace("<", "&#60")
        m_strCodeTemplate = m_strCodeTemplate.Replace(">", "&#62")
        CommonFunction.HTMLControls.DrawTextBox("hdCodeTemplate", "hdCodeTemplate", , , , m_strCodeTemplate, , , , , , True, EnableHTMLEncode:=True)

    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit
        ' Purpose               : Entry to the page
        ' Description           : Called from within the <Form> Tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th May 2004
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String

        'Render top menu
        strMenu = DrawMenu()
        Response.Write(strMenu)

        'Render the Page Legend
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {CommonFunctions.HTMLControls.DrawMandatoryImage(, True)}
        CommonFunction.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

        'Draw Header
        Dim objHeader As New WebPage.Templates.HeaderFooter
        objHeader.HeaderFooter = MyBase.GetResourceString("PROJECT_CODE_MANDATORY")
        objHeader.DrawHeaderFooter()
        objHeader = Nothing

        CommonFunction.General.WriteHTML("<BR>")

        'Render page caption
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , True))
        CommonFunction.General.WriteHTML("<BR>")

        Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")

        'Update the Code Definition to the database
        If m_strAction = "Save" Then
            UpdateCodeDefinition()
            CommonFunction.General.WriteHTML("<SCRIPT language='JavaScript'>" + vbCrLf)
            CommonFunction.General.WriteHTML("window.close();" + vbCrLf)
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End If

        'Get the labels to be displayed
        GetLabels()

        'Get the code template from the database
        GetCodeTemplate()

        'Generate Array of Field Names
        GenerateArrayOfFields()

        'Render UI for the page
        DrawCodeDefinitionUI()
        Response.Write("</DIV>")

        'Render botton menu
        Response.Write("<br>" + strMenu)

    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th Feb, 2004   
        ' Revisions             :
        '=====================================================================

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Help_OnClick('CODE_DEFINITION')"}
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.CodeDefinition", "AppResources")
        Return (strMenu)

    End Function

    Private Sub GetLabels()
        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
        '' Dim strSQL As String = "SELECT * FROM tbl_CNF_ConfigFieldName"
        Dim strSQL As String = "usp_Sel_tbl_CNF_ConfigFieldName"
        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
        Dim drFieldLabels As IDataReader

        drFieldLabels = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
        While drFieldLabels.Read
            Select Case Trim(drFieldLabels("FieldName").ToString)
                Case "System"
                    m_strlblprjSystem = Trim(CommonFunction.Data.CheckIsDBNull(drFieldLabels("Label")).ToString)
                Case "Job Code"
                    m_strlblprjJob = Trim(CommonFunction.Data.CheckIsDBNull(drFieldLabels("Label")).ToString)
            End Select

        End While
        CommonFunction.Data.DisposeDataReader(drFieldLabels)

    End Sub

    Private Sub GetCodeTemplate()
        Dim strSQL As String
        Dim drCodeTemplate As IDataReader
        Dim drCompanyInfo As IDataReader

        If m_strFromWhere <> "" Then

            'If strFromWhere = "Schedule" Then
            '    strSQL = "Select CodeTemplate From tbl_PM_CompanySchedules Where ScheduleID = " & intScheduleId
            'Else
            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
            ''strSQL = "Select CodeTemplate From tbl_PM_CodeTemplates Where ModuleName='" + m_strFromWhere + "'"
            strSQL = "usp_Sel_tbl_PM_CodeTemplates_CodeTemplate '" + m_strFromWhere + "'"
            'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

            'End If

            drCodeTemplate = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
            If drCodeTemplate.Read Then
                m_strCodeTemplate = CommonFunction.Data.CheckIsDBNull(drCodeTemplate("CodeTemplate"), m_strCodeTemplate).ToString
            End If
            CommonFunction.Data.DisposeDataReader(drCodeTemplate)

            m_strCodeTemplate = m_strCodeTemplate.Replace("<", "&#60")
            m_strCodeTemplate = m_strCodeTemplate.Replace(">", "&#62")
            CommonFunction.HTMLControls.DrawTextBox("hdCodeTemplate", "hdCodeTemplate", , , , m_strCodeTemplate, , , , , , True, EnableHTMLEncode:=True)
        End If
        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

        ''strSQL = "SELECT ShortCompanyName from tbl_PM_CompanyInformation"
        strSQL = "usp_Sel_tbl_PM_CompanyInformation_ShortCompanyName "
        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

        drCompanyInfo = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
        If drCompanyInfo.Read Then
            m_strCoShortCode = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("ShortCompanyName")).ToString
        Else
            m_strCoShortCode = ""
        End If
        CommonFunction.Data.DisposeDataReader(drCompanyInfo)

    End Sub

    Private Sub GenerateArrayOfFields()
        '=====================================================================
        ' Procedure Name        : GenerateArrayOfFields
        ' Purpose               : Generates array in javascript for field names
        ' Description           : This array is used in the client side funciton DefineCodes
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th May, 2004   
        ' Revisions             :
        '=====================================================================

        Dim drFields As IDataReader
        Dim strFieldName As String
        Dim intRowLoop As Integer = 0

        CommonFunction.General.WriteHTML(" <Script language='javascript'> ")
        CommonFunction.General.WriteHTML(" var arrFields=new Array(); ")

        m_strFromWhere = m_strFromWhere.Replace("'", "")
        'Create an array of Fields
        drFields = CommonFunction.Data.GetDataReader("usp_Sel_GetCodeGenerationFieldList '" + m_strFromWhere + "'", m_blnUseSQL)
        While drFields.Read
            strFieldName = CommonFunction.Data.CheckIsDBNull(drFields("FieldName")).ToString

            Select Case strFieldName
                Case "System"
                    strFieldName = m_strlblprjSystem
                Case "Job Code"
                    strFieldName = m_strlblprjJob
            End Select

            CommonFunction.General.WriteHTML("arrFields[" + intRowLoop.ToString + "]='" + strFieldName + "' ;  ")
            intRowLoop = intRowLoop + 1
        End While
        CommonFunction.Data.DisposeDataReader(drFields)
        'Create an array of Separators
        drFields = CommonFunction.Data.GetDataReader("usp_Sel_GetTemplateSeparators ", m_blnUseSQL)
        intRowLoop = 0
        CommonFunction.General.WriteHTML(" var arrSeparators=new Array(); ")
        While drFields.Read
            strFieldName = CommonFunction.Data.CheckIsDBNull(drFields("Separator")).ToString
            CommonFunction.General.WriteHTML("arrSeparators[" + intRowLoop.ToString + "]='" + strFieldName + "' ;  ")
            intRowLoop = intRowLoop + 1
        End While
        CommonFunction.Data.DisposeDataReader(drFields)

        'Generate the After Save message
        CommonFunction.General.WriteHTML("var strAfterSaveMsg=''")
        If m_strFromWhere = "Issues" Then
            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
            ''If Not CommonFunction.Data.GetDataScalar("SELECT IssueID FROM tbl_IB_Issue", m_blnUseSQL) Is Nothing Then
            If Not CommonFunction.Data.GetDataScalar("usp_Sel_tbl_IB_Issue_IssueID ", m_blnUseSQL) Is Nothing Then
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                CommonFunction.General.WriteHTML("strAfterSaveMsg='" + MyBase.GetResourceString("ISSUE_CODE_AFFECTED") + "'")
            End If
        End If
        CommonFunction.General.WriteHTML("</Script>")

    End Sub


    Private Sub DrawCodeDefinitionUI()
        Dim intCodeMaskCounter As Integer

        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<table class=clsTable cellspacing='0' cellpadding='0' width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td colspan=3 class='clsTDEvenLabelLeft'>" + MyBase.GetResourceString("LEVEL_1") + " : " + MyBase.GetResourceString("CODE_PREFIX") + "&nbsp;&nbsp;")
        CommonFunction.HTMLControls.DrawTextBox("txtCodePreFix", "txtCodePreFix", , 150, 10, m_strCoShortCode, , , , , , , "onChange='CodePreView()'", EnableHTMLEncode:=True)
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<Tr><Td bgcolor=black colspan=3></Td></Tr>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td class='clsTDEvenLabelLeft' align='left'>" + MyBase.GetResourceString("LEVEL_2") + " : " + MyBase.GetResourceString("CODE_MASK") + "</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding='0' width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<tbody>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTRColHeader + ">")
        CommonFunction.General.WriteHTML("<td align='center' width='25%'>" + MyBase.GetResourceString("USE_MASK") + "</td>")
        CommonFunction.General.WriteHTML("<td align='center' width='50%'>" + MyBase.GetResourceString("SEQUENCE") + "</td>")
        CommonFunction.General.WriteHTML("<td align='center' width='25%'>" + MyBase.GetResourceString("SEPERATOR") + "</td>")
        CommonFunction.General.WriteHTML("</tr>")



        For intCodeMaskCounter = 1 To MAX_CODE_MASKS
            CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
            CommonFunction.General.WriteHTML("<td align='Center'>")
            CommonFunction.HTMLControls.DrawCheckBox("chk" + intCodeMaskCounter.ToString, "chk" + intCodeMaskCounter.ToString, , , , , "onClick='javascript:DisplaySelectBoxes(" + intCodeMaskCounter.ToString + ",this)'")
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("<td align='Center' id='tdSequence" + intCodeMaskCounter.ToString + "'></td>")
            CommonFunction.General.WriteHTML("<td id='tdSeperator" + intCodeMaskCounter.ToString + "' align='center'></td>")
            CommonFunction.General.WriteHTML("</tr>")
        Next

        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + "><td colspan='3'>")
        CommonFunction.General.WriteHTML("<Tr><Td bgcolor=black colspan=3></Td></Tr><br>")
        CommonFunction.General.WriteHTML("</td></tr>")

        CommonFunction.General.WriteHTML("</tbody>")
        CommonFunction.General.WriteHTML("</table>")

        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<table cellspacing='0' cellpadding='0' width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td>&nbsp;</td>")
        CommonFunction.General.WriteHTML("<td class='clsTDEvenLabelLeft'>" + MyBase.GetResourceString("CODE_PATTERN") + " : (" + MyBase.GetResourceString("CODE_PREFIX") + ")-(" + MyBase.GetResourceString("CODE_MASK") + ")</td>")
        CommonFunction.General.WriteHTML("</tr>	")
        CommonFunction.General.WriteHTML("<Tr><Td bgcolor=black colspan=3></Td></Tr>")

        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td class='clsTDEvenLabelLeft' colspan=3>" + MyBase.GetResourceString("CODE_PREVIEW") + "</td>")
        CommonFunction.General.WriteHTML("</tr>")

        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td colspan=3>")
        CommonFunction.HTMLControls.DrawTextBox("txtCodePreView", "txtCodePreView", , , , m_strCodeTemplate, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.General.WriteHTML("<LABEL name='lblCodePreView' id='lblCodePreView' STYLE = 'WIDTH: 90%'>" + m_strCodeTemplate + "</LABEL>")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>	")

        CommonFunction.General.WriteHTML("</tbody>")
        CommonFunction.General.WriteHTML("</table>")
    End Sub

    Private Sub UpdateCodeDefinition()
        Dim strUpdateString As String
        Dim strSQL As String

        strUpdateString = CommonFunction.General.BuildQueryString(MyBase.FixString(Request.Form("txtCodePreview"), 300, False, False))
        strUpdateString = Replace(strUpdateString, "<", "&#60;")
        strUpdateString = Replace(strUpdateString, ">", "&#62;")

        'Generate the parameter as: <MODULE_ID>~<CODE_TEMPLATE>,
        strSQL = "usp_Ins_tbl_PM_CodeTemplates '" + m_intModuleID.ToString + "~" + strUpdateString + "," + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

        ''For showing the updated value on the page
        'm_strCodeTemplate = MyBase.FixString(Request.Form("txtCodePreview"), 300, False, False)
        'm_strCodeTemplate = m_strCodeTemplate.Replace("<", "&#60")
        'm_strCodeTemplate = m_strCodeTemplate.Replace(">", "&#62")
    End Sub
End Class
