Imports CommonFunctions

'=====================================================================
'This page was created for practice and project type association but 
'that was canceled and functionality changed.Now this page is used for 
'Execution Template(PhaseTask Template) and project type mapping but 
'page name was not changed.
'=====================================================================
Public Class PRO_ProjectTypePractices
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

    Protected m_strAction As String = ""
    Private m_blnUseSQL As Boolean
    Protected m_strWindowTitle As String

    Private WithEvents m_objGrid As New WebPages.Grid.cMultiInsertGrid
    Private m_intProjectTypeID As Integer
    Private m_strSelectedTemplateIDs As String


    'Initialize all the variables here
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString + ""
        Else
            m_strAction = ""
        End If
        m_intProjectTypeID = CType(Request.QueryString("TypeID"), Integer)

        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE") + ""
        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	16 Sep 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SELECTALL"), MyBase.GetResourceString("MENU_CLEARALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"Save_OnClick(" & m_intProjectTypeID & ")", "SelectAll_OnClick()", "ClearAll_OnClick()", "Close_OnClick()", "Help_OnClick('PTYPECONFIG_TEMPLATES')"}

        Dim dr As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim strProjectType As String
        Dim strTemplateIDList() As String
        Dim strTemplateID As String
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        MyBase.InitializeResources("AppResources.PRO_ProjectTypePractices", "AppResources")

        Dim arrUFN() As String = {MyBase.GetResourceString("COL_TEMPLATES"), MyBase.GetResourceString("COL_SELECT")}
        Dim arrAN() As String = {"TemplateName", "Selected"}
        Dim arrChkBox() As String = {"", "chkSelect"}
        Dim arrChkBoxCheckedOn() As String = {"", "Selected"}


        'update data
        If m_strAction.ToUpper.Trim = "SAVE" Then

            'first delete unselected templates
            strTemplateID = MyBase.GetFormValue("txtDeleteTemplateIDs") + ""
            If strTemplateID <> "" And strTemplateID <> "," Then
                strTemplateIDList = strTemplateID.Split(","c)
                For Each strTemplateID In strTemplateIDList
                    If strTemplateID <> "" Then
                        strSQL = "usp_Del_tbl_PRS_ProjectType_ExecutionTemplate " + m_intProjectTypeID.ToString
                        strSQL += "," + strTemplateID.Trim
                        CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                    End If
                Next
            End If

            strTemplateID = MyBase.GetFormValue("chkSelect") + ""
            If strTemplateID <> "" Then
                strTemplateIDList = strTemplateID.Split(","c)
                For Each strTemplateID In strTemplateIDList
                    If strTemplateID <> "" Then
                        strSQL = "usp_Ins_tbl_PRS_ProjectType_ExecutionTemplate " + m_intProjectTypeID.ToString
                        strSQL += "," + strTemplateID.Trim
                        CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                    End If
                Next
            End If
        End If

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        ' menu
        General.WriteHTML(strMenu)
        General.WriteHTML("<BR>")

        ' get the project type name
        strSQL = "usp_sel_ProjectTypeRelated_Informaion 7," + m_intProjectTypeID.ToString + ",null"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            strProjectType = dr("ProjectType").ToString
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        'page caption
        General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), MyBase.GetResourceString("PRACTICE") + " : " + strProjectType))
        General.WriteHTML("<BR>")
        General.WriteHTML("<Div id='PageDiv' width=100% height=90% style='overflow:auto;'>") 'width=100% height=90%
        'General.WriteHTML("<DIV id=DivList style='overflow:auto;Height:450' >")
        m_strSelectedTemplateIDs = ""

        ' plot the grid here
        With m_objGrid
            .NoOfDataColumns = 1
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrUFN
            .CheckBoxIDArray = arrChkBox
            .CheckboxCheckOnColumnArray = arrChkBoxCheckedOn

            .SQL = "usp_Sel_tbl_PRS_ProjectType_ExecutionTemplate " + m_intProjectTypeID.ToString
            .TableName = "tbl_PRS_ProjectType_ExecutionTemplate"
            .ForeignKey = "ProjectTypeID"
            .PrimaryKey = "TemplateID"

            .ForeignKeyValue = m_intProjectTypeID.ToString
            .UseSQL = m_blnUseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ' draw the grid
            .DrawGrid()
        End With
        m_objGrid = Nothing

        'General.WriteHTML("</div>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtSelectedTemplateIDs", "txtSelectedTemplateIDs", , , , m_strSelectedTemplateIDs.Trim, , , , , , True, , True))
        'General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtDeleteTemplateIDs", "txtDeleteTemplateIDs", , , , , , , , , , True, , True))
        General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtSelectedTemplateIDs", "txtSelectedTemplateIDs", , , , m_strSelectedTemplateIDs.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtDeleteTemplateIDs", "txtDeleteTemplateIDs", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        General.WriteHTML("</Div>")
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim blnIsChecked As Boolean = False

        If Args.DataField = "Selected" Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Selected"), "False"), Boolean) Then
                blnIsChecked = True
                If m_strSelectedTemplateIDs = "" Then
                    m_strSelectedTemplateIDs = ","
                End If
                'create the list of all selected templateIDs
                m_strSelectedTemplateIDs += Args.DataReader("TemplateID").ToString + ","
            End If

            Args.StringToBeInserted = "<TD align='center'>"
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , blnIsChecked, Args.DataReader("TemplateID").ToString, , "onclick='javascript:Select_OnClick(this)'", True)
            Args.StringToBeInserted += "</TD>"

            Cancel = True
        End If
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PRO_ProjectTypePractices", "AppResources")
    End Sub

End Class
