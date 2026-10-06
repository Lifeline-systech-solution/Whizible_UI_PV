Public Class RT_RowwiseApprovers
    Inherits WebPages.Template.WhizTemplate

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

#Region " Initialized Variables "


    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 

    Private m_intProjectID As Integer
    Private strSQLQuery As String
    Private m_intIndex As Integer
    Protected m_strWindowTitle As String
    Private m_ApproverSet As Integer
    Private m_intCount As Integer
    Private m_strName As String
    Protected m_strAlphabet As String
    'Added by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4353
    Private m_bln_ShowHistory As Boolean = False
    'END Of Addition by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4353

    'Added by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4360
    Protected m_bln_ShowExpenseLink As String
    'END Of Addition by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4360

    Protected m_strFilter As String

    Protected m_Approver As String
    Protected m_Role As String
    Protected m_NewApprover As String
    Protected m_NewHidApprover As String

    Protected m_TagShowHistory As Long = CommonFunction.Constants.APP_Tag_ROWWISE_APPROVERS_HISTORY
    Private WithEvents m_objSectionFilters As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionActions As New WebPage.Templates.SectionTitle

#End Region

#Region " Page Load Functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = MyBase.GetResourceString("ROW_WISE_APPROVERS")
        m_intIndex = 2
    End Sub

    Public Sub PlotHeader()
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strExpenseSQL As String = "select ExpenseWorkflow FROM tbl_PM_CompanyInformation"
        Dim strExpenseSQL As String = "usp_sel_tbl_PM_CompanyInformation_ExpenseWorkflow"
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

        m_bln_ShowExpenseLink = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strExpenseSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

        CommonFunctions.General.WriteHTML("<TABLE cellpadding=0 cellspacing=0 class=clsTableNavLinks width='100%'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' valign=middle>")
        CommonFunctions.General.WriteHTML("<TD noWrap>")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Timesheet Approvers' href='javascript:ItemTab_OnClick(""Timesheet"")' Timesheet?)?>Timesheet Approvers</a>")
        If m_bln_ShowExpenseLink.ToUpper <> "FALSE" Then
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Expense Approvers' href='javascript:ItemTab_OnClick(""Expense"")' Expense?)?>Expense Approvers</a>")
        End If
        CommonFunctions.General.WriteHTML("</TD> </TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 9 , 2004
        ' Revisions             :
        '=====================================================================
        'Added by PrajaktaR on 15th June 2006 for Bristlecone ( Getting role access)
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = 2250
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        'END Of Addition by PrajaktaR on 15th June 2006 for Bristlecone ( Getting role access)
        m_ApproverSet = 0
        m_intProjectID = CType(Session("intProjectID"), Integer)

        If Request.QueryString("Mode") = "Save" Then
            SaveApprovers()
        End If

        If Request.QueryString("Mode") = "SaveDefaultApprover" Then
            SaveDefaultApprover()
        End If

        If Request.QueryString("Mode") = "SetDefaultApprover" Then
            DrawMenuDefaultApprover()
            CommonFunctions.General.WriteHTML("<BR>")
            'Modified By VarunA on 6-July-2007 Whizible 7.0 Development & Release
            'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:60px'>")
            CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:99.9%;'>")
            'End By VarunA on 6-July-2007
            Dim strSQLQuery As String
            Dim intDefaultApprover As Integer
            Dim drDefaultApprover As IDataReader

            '##### Get the Default Approver
            drDefaultApprover = CommonFunctions.Data.GetDataReader("usp_Sel_GetDefaultApprover " + CType(m_intProjectID, String), MyBase.UseSQL)
            If drDefaultApprover.Read Then
                intDefaultApprover = CType(CommonFunctions.Data.CheckIsDBNull(drDefaultApprover("EmployeeID"), "0"), Integer)
            End If
            CommonFunctions.Data.DisposeDataReader(drDefaultApprover)
            '##### End 

            'Modified By VarunA on 6-July-2007 Whizible 7.0 Development & Release
            'CommonFunctions.General.WriteHTML("<Table cellSpacing='1' cellPadding='0' width='100%' border='0'>")
            CommonFunctions.General.WriteHTML("<Table class=clsTable cellSpacing='0' cellPadding='0' width='99.9%' border='0'>")
            'End By VarunA on 6-July-2007

            CommonFunctions.General.WriteHTML("<tbody>")
            'Modified By VarunA on 6-July-2007 Whizible 7.0 Development & Release
            'CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<tr class=clsTREven>")
            'End By VarunA on 6-July-2007

            'Default Approver

            'Modified By VarunA on 6-July-2007 Whizible 7.0 Development & Release
            'CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabel' align='left'><B>" + MyBase.GetResourceString("DEFAULT_APPROVER") + " </B></td>")
            'CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabelLeft' align='left'>")
            CommonFunctions.General.WriteHTML("<td align='right'><B>" + MyBase.GetResourceString("DEFAULT_APPROVER") + " </B>")
            CommonFunctions.General.WriteHTML("&nbsp;</td><td align='left'>")
            'End By VarunA on 6-July-2007
            strSQLQuery = "usp_sel_tbl_PM_RowWiseApprovers  " & CType(m_intProjectID, String)
            CommonFunctions.HTMLControls.DrawComboBox("cboDefaultApprover", strSQLQuery, 200, CType(intDefaultApprover, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</tbody>")
            CommonFunctions.General.WriteHTML("</table>")
            CommonFunctions.General.WriteHTML("</DIV>")
            CommonFunctions.General.WriteHTML("<BR>")
            DrawMenuDefaultApprover()
          
        Else
            'Added by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4353
            Dim drHistory As IDataReader
            Dim strHistory As String
            'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'strHistory = "SELECT UniqueID FROM d_tbl_PM_RowwiseApprovers_History WHERE ProjectID = " + CType(m_intProjectID, String)
            strHistory = "usp_sel_d_tbl_PM_RowwiseApprovers_History_UniqueID " + CType(m_intProjectID, String)
            'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            drHistory = CommonFunctions.Data.GetDataReader(strHistory, MyBase.UseSQL)
            If drHistory.Read Then
                m_bln_ShowHistory = True
            End If
            CommonFunctions.Data.DisposeDataReader(drHistory)
            'END Of Addition by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4353
            '            DrawMenu()
            If Request.QueryString("Alphabet") <> "" Then
                m_strAlphabet = Request.QueryString("Alphabet") + ""

                'Modified By VidyaJ - issueID- 11107
                If m_strAlphabet = "AND" Then
                    m_strAlphabet = "&"
                End If
                If m_strAlphabet = "'" Then
                    m_strAlphabet = "'" & CommonFunctions.General.BuildQueryString(m_strAlphabet) & "'"
                End If
                If m_strAlphabet = "HASH" Then
                    m_strAlphabet = "#"
                End If
                If m_strAlphabet = "PLUS" Then
                    m_strAlphabet = "+"
                End If
            Else
                m_strAlphabet = "-1"
            End If
            DrawMenu()
            m_strFilter = ""
            If Request.Form("cboApprover") <> "" Then
                m_strFilter = m_strFilter + " AND PER.ReportingTo = " + CType(Request.Form("cboApprover"), String)
                m_Approver = CType(Request.Form("cboApprover"), String)
            Else
                m_Approver = ""
            End If

            If Request.Form("cboRole") <> "" Then
                m_strFilter = m_strFilter + " AND PER.Role = " + CType(Request.Form("cboRole"), String)
                m_Role = CType(Request.Form("cboRole"), String)
            Else
                m_Role = ""
            End If

            If Request.Form("txtNewApprover") <> "" Then
                m_NewApprover = CType(Request.Form("txtNewApprover"), String)
            Else
                m_NewApprover = ""
            End If

            If Request.Form("txtHidEmployeeID") <> "" Then
                m_NewHidApprover = CType(Request.Form("txtHidEmployeeID"), String)
            Else
                m_NewHidApprover = ""
            End If
            'Added by PrajaktaR on 14th June 2006 for Bristlecone
            Dim intDefaultApprover As Integer
            Dim strDefaultApprover As String
            Dim drDefaultApprover As IDataReader

            '##### Get the Default Approver
            drDefaultApprover = CommonFunctions.Data.GetDataReader("usp_Sel_GetDefaultApproverName " + CType(m_intProjectID, String), MyBase.UseSQL)
            If drDefaultApprover.Read Then
                intDefaultApprover = CType(CommonFunctions.Data.CheckIsDBNull(drDefaultApprover("EmployeeID"), "0"), Integer)
                strDefaultApprover = CType(CommonFunctions.Data.CheckIsDBNull(drDefaultApprover("EmployeeName"), "0"), String)
            End If
            CommonFunctions.Data.DisposeDataReader(drDefaultApprover)
            CommonFunctions.General.WriteHTML("<TABLE  cellSpacing='1' cellPadding='0' width='100%' border='0'><TR class=clsTRSectionHeader><TD id=DefaultApproverID align=Left >Default Approver : " + strDefaultApprover + "</TD></TR></TABLE>")

            'END Of Added by PrajaktaR on 14th June 2006 for Bristlecone

            DrawFilterSection()
            DrawActionSection()

            DrawGrid()
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("EmployeeCount", "EmployeeCount", , , , CType(m_intIndex - 1, String), , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

            DrawMenu(False)


            '##### Writing client side script for returning blnApproverSet 
            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            CommonFunctions.General.WriteHTML("function getApproverSet()" + vbCrLf)
            CommonFunctions.General.WriteHTML("{" & vbCrLf)
            CommonFunctions.General.WriteHTML("var blnApprover;" + vbCrLf)
            CommonFunctions.General.WriteHTML("blnApproverSet=" + CType(m_ApproverSet, String) + ";" + vbCrLf)
            CommonFunctions.General.WriteHTML("return blnApproverSet;" + vbCrLf)
            CommonFunctions.General.WriteHTML("}" + vbCrLf)
            CommonFunctions.General.WriteHTML("</script>")
            '##### End 
        End If

    End Sub
#End Region

#Region " Plots the Menu "
    Private Sub DrawFilterSection()
        Dim strPaging As String = ""
        Dim strSectionTag As String = "divFilter"
        Dim strFunctionName As String = "ShowHide_divFilter"
        '' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 Search Paging is Implemented 

        Response.Write(m_objSectionFilters.GetSectionTitle(MyBase.GetResourceString("FILTERS_SECTION"), strSectionTag, strFunctionName, , ))
        Response.Write("<script language=javascript>" & m_objSectionFilters.ClientsideScript & "</script>")
        Response.Write("<DIV id=divFilter>")

        'Draw Approvers Filter
        CommonFunctions.General.WriteHTML("<Table cellSpacing='1' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tbody>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabel' align='left'><B>" + MyBase.GetResourceString("FILTER_APPROVER") + " </B></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabelLeft' align='left'>")

        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT DISTINCT PER.ReportingTo,E.EmployeeName FROM tbl_PM_ProjectEmployeeRole PER INNER JOIN tbl_PM_Employee E ON PER.ReportingTo = E.EmployeeID AND PER.ProjectID = " & CType(m_intProjectID, String)
        strSQLQuery = "usp_sel_tbl_PM_ProjectEmployeeRole_ReportingTo " & CType(m_intProjectID, String)

        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

        CommonFunctions.HTMLControls.DrawComboBox("cboApprover", strSQLQuery, 200, m_Approver, "onchange='javascript:Filter_OnChange()'", True, )
        CommonFunctions.General.WriteHTML("</td>")
        'Draw Role Filter
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabel' align='left'><B>" + MyBase.GetResourceString("FILTER_ROLE") + "</B></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabelLeft' align='left'>")

        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT DISTINCT PER.Role,R.RoleDescription FROM tbl_PM_ProjectEmployeeRole PER INNER JOIN tbl_PM_Role R ON PER.Role = R.RoleID AND PER.ProjectID = " & CType(m_intProjectID, String)
        strSQLQuery = "usp_sel_tbl_PM_ProjectEmployeeRole_RoleDescription " & CType(m_intProjectID, String)
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        CommonFunctions.HTMLControls.DrawComboBox("cboRole", strSQLQuery, 200, m_Role, "onchange='javascript:Filter_OnChange()'", True, )
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</tbody>")
        CommonFunctions.General.WriteHTML("</table>")


        Response.Write("</DIV>")
        m_objSectionFilters = Nothing
        'divGraphs.Attributes.Add("style", "overflow:auto" + vbCrLf)
    End Sub

    Private Sub DrawActionSection()
        Dim strPaging As String = ""
        Dim strSectionTag As String = "divAction"
        Dim strFunctionName As String = "ShowHide_divAction"
        '' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 Search Paging is Implemented 

        Response.Write(m_objSectionActions.GetSectionTitle(MyBase.GetResourceString("ACTION_SECTION"), strSectionTag, strFunctionName, , ))
        Response.Write("<script language=javascript>" & m_objSectionActions.ClientsideScript & "</script>")
        Response.Write("<DIV id=divAction>")
        ShowNewApprover()
        Response.Write("</DIV>")
        m_objSectionActions = Nothing
    End Sub

    Private Sub DrawMenu(Optional ByVal blnShowPaging As Boolean = True)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 09, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPageAlphabets As String
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String

        m_objMenu = New WebPages.Template.StaticMenu
        'Added by PrajaktaR on 15th June 2006 for Bristlecone ( Getting role access)
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            'END Of Addition by PrajaktaR on 15th June 2006 for Bristlecone ( Getting role access)
            arrMenuCaptionsList.Add(MyBase.GetResourceString("SET_DEFAULT_APPROVER"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("SET_DEFAULT_APPROVER_TOOLTIP"))
            arrClientSideFunctionList.Add("SetDefaultApprover_OnClick()")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("SET_APPROVER"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("SET_APPROVER_TOOLTIP"))
            arrClientSideFunctionList.Add("Save_OnClick()")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("SELECT_ALL"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("SELECT_ALL_TOOLTIP"))
            arrClientSideFunctionList.Add("SelectAll_OnClick()")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("CLEAR_ALL"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("CLEAR_ALL_TOOLTIP"))
            arrClientSideFunctionList.Add("ClearAll_Click()")

            'Added by PrajaktaR on 20 June 2006 for Bristlecone IsseID 4353
            If m_bln_ShowHistory = True Then
                'END Of Addition by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4353
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOW_HISTORY"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOW_HISTORY_TOOLTIP"))
                arrClientSideFunctionList.Add("ShowHistory_OnClick()")
                'Added by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4353
            End If
            'END Of Addition by PrajaktaR on 20 June 2006 for Bristlecone IssueID 4353
            'Added by PrajaktaR on 15th June 2006 for Bristlecone ( Getting role access)
        End If
        'END Of Addition by PrajaktaR on 15th June 2006 for Bristlecone ( Getting role access)
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('RT_RWA')")

        'display the paging links on the menu bar
        strSQLQuery = "usp_sel_tbl_PM_RowWiseApprovers_ForGrid " + CType(Session("intProjectID"), String) + ",'-1'" + ",1,'" + m_strFilter + "'"

        objPaging = New WebPage.Templates.Paging
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strSQLQuery, MyBase.GetResourceString("ROWWISEAPPROVERS_PAGING"), "Paging_OnClick", "EmployeeName", True)
        objPaging = Nothing

        If blnShowPaging = True Then
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, strPagingHTML)
        Else
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        End If

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        strPageAlphabets = ""
    End Sub

    Private Sub DrawMenuDefaultApprover()
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPageAlphabets As String
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String

        m_objMenu = New WebPages.Template.StaticMenu

        arrMenuCaptionsList.Add(MyBase.GetResourceString("SET_DEFAULT_APPROVER"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("SET_DEFAULT_APPROVER_TOOLTIP"))
        arrClientSideFunctionList.Add("SaveDefaultApprover_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('RT_RWA')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        strPageAlphabets = ""
    End Sub
#End Region

#Region " Generic Functions "
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region

#Region " Grid Plotting "
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid on the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 9,20004
        ' Revisions             :
        '=====================================================================


        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList

        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"style='width:20%'", "align=left", "align=left", "align=left", "align=center"}
        Dim arrColRowLinks() As String = {"", "", "", "", ""}
        Dim arrCheckBoxArray() As String = {"", "", "", "", "EmployeeID"}


        '##### Get Page Title from Reosrces and Display
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ROWWISEAPPROVERS_CAPTION"))
        'Modified by NiranjanK on Date June 08,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:80px'>")
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;height:80%'>")
        'End of modification by NiranjanK June 08,2006 for WhzibleSEM Issue ID.4168
        'Modified By VidyaJ - issueID- 11107
        strSQLQuery = "usp_sel_tbl_PM_RowWiseApprovers_ForGrid " + CType(m_intProjectID, String) + ",'" + m_strAlphabet + "',0,'" + m_strFilter + "'"
        'Modified By VidyaJ - for  IssueID - 86 - SP4
        'Changed DIV height from 230 to 400
        CommonFunctions.General.WriteHTML("<br><DIV id=DivList style='Overflow:auto;width=100%;Height:400'>")

        ''Plots the Table for Rowwise Approvers
        ''-------------------------------------------------------------------


        '##### Get Column Headings from Resources 
        arrColumnHeadingList.Add(MyBase.GetResourceString("HEADING_EMPLOYEE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("HEADING_ROLE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("HEADING_APPROVER"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("HEADING_LAST_APPROVER"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("HEADING_SELECT"))
        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("RoleDescription")
        arrActualColumnNames.Add("Approver")
        arrActualColumnNames.Add("OldApprover")
        arrActualColumnNames.Add("EmployeeID")
        '##### End
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .CheckBoxIDArray = arrCheckBoxArray
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 5
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .EmptyValueReplacement = ""
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        m_objGrid = Nothing
        CommonFunction.General.WriteHTML("<br></div>")
        CommonFunction.General.WriteHTML("</div>")



    End Sub
#End Region

#Region " Event Handling "
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim strOldApprover As String

        '##### If field is OldApprover then change the color
        If Args.DataField = "OldApprover" Then
            Cancel = True
            strOldApprover = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OldApprover"), "-"), String)
            If strOldApprover <> "-" Then
                Args.StringToBeInserted = "<TD align=left>" + "<font color=red>" + strOldApprover + "</font></TD>"
            Else
                Args.StringToBeInserted = "<TD>&nbsp;&nbsp;</TD>"
            End If

            'Writing a hidden control

            m_strName = "EmployeeID" + CType(m_intIndex, String)
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox(m_strName, m_strName, , , , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), ""), String), , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

        End If

        'Added By SantoshK on May 17 2006
        If Args.DataField = "EmployeeID" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkEmployeeID", "chkEmployeeID", , , CType(Args.DataFieldValue, String), , , True) + "</td>"
        End If
        'Addition Ends by SantoshK on May 17 2006
    End Sub

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        m_intIndex = m_intIndex + 1
    End Sub

#End Region

#Region " Constructor "
    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.RT_RowwiseApprovers", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region "ShowNewApprover"
    Private Sub ShowNewApprover()
        CommonFunctions.General.WriteHTML("<Table cellSpacing='1' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tbody>")
        CommonFunctions.General.WriteHTML("<tr>")

        'New Approver
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabel' align='left'><A style='' HREF='Javascript:SelectNewApprover()' Title='Select New Approver' ><B>" + MyBase.GetResourceString("NEW_APPROVER") + "</B></A></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDEvenLabelLeft' align='left'>")
        strSQLQuery = "usp_sel_tbl_PM_RowWiseExternalApprovers  " & CType(m_intProjectID, String)
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtNewApprover", "txtNewApprover", , , , m_NewApprover, , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtHidEmployeeID", "txtHidEmployeeID", , , , m_NewHidApprover, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</tbody>")
        CommonFunctions.General.WriteHTML("</table>")
    End Sub
#End Region

#Region "Save Approvers"
    Private Sub SaveApprovers()
        Dim intDefaultSet As Integer
        Dim intDefaultApprover As String
        Dim intEmployeeID As String
        Dim intApproverID As String
        Dim intUniqueID As Integer
        Dim strSQL As String
        Dim strArrEmployeeID() As String
        Dim lenArray As Integer

        '' START : Integrated by ParagD on 14-Aug-2006 for whizible SP 7.2
        'Code commented by SavitaS on 26 July 2006 for Bristlecone IssueID 2934
        'Added by PrajaktaR on 22 June 2006 for Bristlecone IssueID 4366
        'Dim m_blnHimself As Boolean = False
        'END Of Addition by PrajaktaR on 22 June 2006 for Bristlecone IssueID 4366
        'End of Code commented by SavitaS on 26 July 2006 for Bristlecone IssueID 2934
        '' END : Integrated by ParagD on 14-Aug-2006 for whizible SP 7.2

        'intEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(MyBase.GetFormValue(m_strName), ""), Integer)
        m_strName = "txtHidEmployeeID"
        If Not Request.Form(m_strName) = "" Then
            intApproverID = CType(Request.Form(m_strName), String)
        End If

        intEmployeeID = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkEmployeeID", True), "")
        If intEmployeeID <> "" Then
            strArrEmployeeID = intEmployeeID.Split(CType(",", Char))
            'Now Insert Into Table
            For lenArray = 1 To strArrEmployeeID.Length
                If CType(intApproverID, String) <> "" Then
                    'Added by PrajaktaR on 22 June 2006 for Bristlecone IssueID 4366
                    'If CType(strArrEmployeeID(lenArray - 1), String) <> intApproverID Then
                        'Call getRecordset(" Exec usp_Ins_RowWiseApprovers " & Session("intProjectID") & "," & intEmployeeID & "," & intApproverID)
                        strSQL = "usp_Ins_RowWiseApprovers " + CType(m_intProjectID, String) + "," + CType(strArrEmployeeID(lenArray - 1), String) + "," + CType(intApproverID, String)
                        intUniqueID = CType(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                        'intApproverID = ""
                        'Commented by MrugajaB on 7th July 2006 as this check is not required for timesheet approval
                        'Else
                        '    m_blnHimself = True
                    'End If
                    'End Comment
                    'END OF Addition by PrajaktaR on 22 June 2006 for Bristlecone IssueID 4366
                End If
            Next
        End If
        'Commented by MrugajaB on 7th July 2006 as this check is not required for timesheet approval
        'Added by PrajaktaR on 22 June 2006 for Bristlecone IssueID 4366
        'If m_blnHimself = True Then
        '    CommonFunctions.General.WriteHTML("<Script> ")
        '    CommonFunctions.General.WriteHTML("alert('The Resource cannot be set as approver for himself. ');")
        '    CommonFunctions.General.WriteHTML("</Script>")
        'End If
        'END Of Addition by PrajaktaR on 22 June 2006 for Bristlecone IssueID 4366
        'End Comment
    End Sub

    Private Sub SaveDefaultApprover()
        Dim intDefaultSet As Integer
        Dim intDefaultApprover As String
        Dim intEmployeeID As String
        Dim intApproverID As String
        Dim intUniqueID As Integer
        Dim strSQL As String
        Dim strArrEmployeeID() As String
        Dim lenArray As Integer

        If Not Request.Form("cboDefaultApprover") = "" Then
            intDefaultApprover = CType(Request.Form("cboDefaultApprover"), String)
        End If
        m_intCount = CType(CommonFunctions.Data.CheckIsDBNull(Request.Form("EmployeeCount"), ""), Integer)
        intDefaultSet = 0

        If CType(intDefaultApprover, String) <> "" Then
            strSQL = "usp_Ins_RowWiseApprovers " + CType(m_intProjectID, String) + "," + CType(intDefaultApprover, String) + "," + CType(intDefaultApprover, String) + ",1"
            'Call getRecordset(" Exec usp_Ins_RowWiseApprovers " & Session("intProjectID") & "," & intDefaultApprover & "," & intDefaultApprover & ",1")
            intUniqueID = CType(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
        End If

    End Sub
#End Region
End Class
