Public Partial Class ML_ModuleAccess_MultiSelect_Customer
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
#Region "Global Variables"
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Protected m_strModuleID As String
    Protected m_strMode As String
    Private m_strAction As String
    Private m_strUniqueID As String = ""
    Protected m_arrUniqueIDList As New ArrayList
    Protected m_FromWhere As String = ""
    Protected m_intTotalRows As Integer = 0
    Protected strModule As String = ""
    Protected strLicences As String = ""
    Protected strLicencesforModule As String = ""
    Protected m_intPageNumber As Integer = 1
    Protected m_strSortOrder As String = ""
    Protected m_strSortBy As String = ""
    Protected m_strAvailable As String
    Protected m_intAlloted As Integer
    Private m_intTotalNoOfRows As Integer
    Protected m_strScript As String = ""
    Private m_strModules As String
    Protected m_strRoleID As String = ""
    Private strMenu As String
    Private strXMLPath As String = Server.MapPath("../GENERAL/").ToString + "WhizModules.xml"
    Private m_validXML As String 'Integer
    Protected m_strEmployeeName As String = ""
    Protected m_strBG As String = ""
    Protected m_strOU As String = ""
    Protected m_strOrderBy As String = ""
    Protected SelectedLoginCount As Integer = 0
#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        InitVariables()

        If m_strAction.ToUpper = "SAVE" Then
            SaveModuleAccess_employee()
        End If

        m_validXML = MLCommonFunction.ML_CommonFunction.Validate_Modulexml(strXMLPath)
        If m_validXML = "" Then
            Dim strQuery As String
            InitData()
            CommonFunctions.General.WriteHTML("<BR>")
            DrawMenu()
            DrawPageCaption()
            'CommonFunctions.General.WriteHTML("<BR>")
            '            DrawLicences()
            ' CommonFunctions.General.WriteHTML("<BR>")
            DrawFilter()
            'DrawPaging()
            ' CommonFunctions.General.WriteHTML("<BR>")

            DrawGrid()
        Else
            Response.Write("<DIV ID='PageDiv' Style='Height:400px;WIDTH:100%;OVERFLOW:auto;'>")
            Response.Write("<TABLE class=clsTABLE Width='100%' Height='100%'>")
            Response.Write("<TR><TD align=Center class=clsTDGroupFooter><B>" + m_validXML + "</B></TD></TR>")
            Response.Write("</TABLE></DIV>")
        End If

    End Sub
    Private Sub SaveModuleAccess_employee()
        Dim strQuery As String = ""
        Dim strApplicable As String
        Dim strApplicableArr() As String
        Dim strMandatory As String
        Dim strSQL As String

        strApplicable = Request("chkApplicable")
        strQuery = "usp_ins_upd_ModuleAccess_MultiSelect_Customer " & m_strModuleID & ",'" & strApplicable & "','" & m_strEmployeeName & "'"
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        'm_strScript = " refreshParent('frmCommonPage','ModuleAccess_CommonList.aspx','ModuleAccess_CommonList.aspx?ModuleTagId_PK=" + m_strModuleID.ToString + "&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');"
        m_strScript = " refreshParent('frmCommonList','ModuleAccess_CommonList.aspx','ModuleAccess_CommonList.aspx?ModuleTagId_PK=" + m_strModuleID.ToString + "MasterTagID=2651&FromWhere=SM');"
        m_strScript = m_strScript + " window.close();"
        ' CommonFunctions.General.WriteHTML(m_strScript)

    End Sub

    Private Sub InitVariables()
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModuleID"), "") <> "" Then
            m_strModuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModuleID"), "")
        ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModuleTagId"), "") <> "" Then
            m_strModuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModuleTagId"), "")
        End If

        'm_strRoleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("RoleID"), "")
        m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Action"), "")
        m_FromWhere = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("FromWhere"), "")
        m_strEmployeeName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerName"), "")
        If m_strEmployeeName = "" Then
            m_strEmployeeName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCustomer"), "")
        End If
        'm_strBG = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("BG"), "")
        'm_strOU = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("OU"), "")
    End Sub
    Private Sub InitData()

        Dim dXMLSet As New DataSet()
        Dim dXMLRdr As DataTableReader


        'If MLCommonFunction.ML_CommonFunction.Validate_Modulexml(strXMLPath) = True Then
        Try
            If CommonFunctions.FileDirectory.IsFileExists(strXMLPath) Then
                dXMLSet.ReadXml(strXMLPath)
                dXMLRdr = dXMLSet.CreateDataReader()
                While dXMLRdr.Read()
                    strLicences = MLCommonFunction.ML_CommonFunction.Decrypt(dXMLRdr("Licences_Text").ToString())
                    strModule = strLicences.Substring(strLicences.IndexOf("/") + 1, strLicences.LastIndexOf("/") - (strLicences.IndexOf("/") + 1))
                    strLicences = strLicences.Substring(strLicences.LastIndexOf("/") + 1)

                    If strModule = m_strModuleID Then
                        If strLicences = "" Then
                            strLicences = "0"
                        End If
                        strLicencesforModule = strLicences
                        m_intAlloted = CommonFunctions.Data.GetDataScalar("select ISNULL(Count(UniqueID),0) as Alloted FROM tbl_PM_Login_AccessibleModules Where ModuleID=" + strModule.ToString + " AND IsActive=1", MyBase.UseSQL)
                        m_strAvailable = CType(strLicencesforModule, Integer) - m_intAlloted
                    End If

                End While
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
        End Try

        '   End If

    End Sub
    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 
        ' Revisions             :
        '=====================================================================


        Dim arrMenuCaptionsList() As String = {"Save", "Select All", "Clear All", "Close"}
        Dim arrMenuToolTipsList() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Select All", "Clear All", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrClientSideFunctionList() As String = {"Save_OnClick()", "SelectAll_OnClick()", "ClearAll_OnClick()", "Close_OnClick()"}

        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenuCaptionsList, arrClientSideFunctionList, arrMenuToolTipsList, True)
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
    Private Sub DrawPaging()
        '=====================================================================
        ' Procedure Name        : DrawPaging
        ' Description           : To write the paging for the request grid
        ' Purpose               : 
        ' Parameters Passed     : SQL for paging
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             : NitinVS on 25 July 2005 changed Pageing from list to search Mode
        '=====================================================================
        ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 

        'Dim ds As DataSet
        Dim intRecordCount As Integer
        'Dim strPaging As String = WebPages.Template.Paging.DrawPaging(m_intPageNumber.ToString, PagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClick", "", True, , , True, 20)
        Dim strPaging As String = ""
        Dim PagingSQL As String = ""


        PagingSQL = "usp_sel_Modulewise_CustomerAccess_Count " + m_strModuleID


        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)


        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If
        'Code commented and added by PrashantD on 24 May 2007 for CleanUp Activity
        'If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
        '    strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
        'Else
        '    strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, m_intPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
        'End If
        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"
        'End of comment and addition by PrashantD on 24 May 2007 for CleanUp Activity


        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True)

        ' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 

        If Trim(strPaging & "") <> "" Then
            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
        End If
    End Sub
    Private Sub DrawLicences()
        Response.Write("<table Style='height:15px;width:99.9%'  class='clsTable' cellspacing=0 cellpadding=0>")
        'Response.Write("<tr class='clsTReven'>")
        Response.Write("<tr class='clsTRPageCaption'>")
        Response.Write("<td align=left ><b>Available Licences:" + strLicencesforModule.ToString + "</b></td>")
        Response.Write("<td align=left ><b>Issued Licences:" + m_intAlloted.ToString + "</b></td>")
        Response.Write("</tr>")
        Response.Write("</table>")
    End Sub
    Private Sub DrawGrid()
        Dim strQuery As String


        Dim arrActualCols() As String = {"CustomerName", "LoginName", "Selected"}
        Dim arrUserFriendlyCols() As String = {"Customer Name", "Login Name", "Select"}
        Dim arrRowLink() As String = {"", ""}
        Dim arrChkBox() As String = {"", "", "chkSelect"}

        Dim arrstrTDStyle() As String = {"style='width=30%' align=left", "style='width=30%' align=left", "style='width=15%', Title='Select'"}
        Dim strRoleID As String = ""

        If m_strEmployeeName = "" Then
            m_strEmployeeName = "NULL"
        Else
            m_strEmployeeName = "'" & CommonFunction.General.BuildQueryString(m_strEmployeeName) & "'"
        End If


        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboRole"), "").ToString <> "" Then
            m_strRoleID = HttpContext.Current.Request.Form("cboRole").ToString
        Else
            m_strRoleID = "NULL"
        End If

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboBusinessGroup"), "").ToString <> "" Then
            m_strBG = HttpContext.Current.Request.Form("cboBusinessGroup").ToString
        Else
            m_strBG = "NULL"
        End If

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboOrganizationUnit"), "").ToString <> "" Then
            m_strOU = HttpContext.Current.Request.Form("cboOrganizationUnit").ToString
        Else
            m_strOU = "NULL"
        End If

        If Not Request.QueryString("sortby") Is Nothing Then
            m_strSortBy = Request.QueryString("sortby")
        Else
            m_strSortBy = "CustomerName"
        End If
        If Not Request.QueryString("sortorder") Is Nothing Then
            m_strOrderBy = Request.QueryString("sortorder")
        Else
            m_strOrderBy = "ASC"
        End If
        strQuery = "Exec usp_sel_Modulewise_CustomerAccess " + m_strModuleID.ToString + "," + m_strRoleID.ToString + "," & m_strEmployeeName & "," + m_strBG + "," + m_strOU


        'Set the Generic Grid Properties
        With m_objGrid
            .NoOfDataColumns = 4
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .RowLinkArray = arrRowLink
            .CheckBoxIDArray = arrChkBox
            .ClientSideSortFunctionName = "Sort_OnClick"
            .returnHTML = False
            .TDStyleArray = arrstrTDStyle
            .SortBy = m_strSortBy '"ProjectType"
            .SortOrder = m_strOrderBy
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVHeight = 490
            .DIVStyle = "overflow:auto"
            .DIVID = "divList"
            .PrimaryKey = "LoginID"
            .DrawGrid()
        End With

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
    Private Sub DrawFilter()
        '=====================================================================
        ' Procedure Name        : DrawFilter()	
        ' Purpose               : To write the Filters 
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created Date          : 6-Apr-2010
        '=====================================================================
        'Response.Write("<DIV ID='PageDiv' Style='Height:400px;WIDTH:100%;OVERFLOW:auto;'>")
        'Response.Write("<TABLE class=clsTABLE Width='100%' Height='100%'>")
        'Response.Write("<TR><TD align=Center class=clsTDGroupFooter><B>" + m_validXML + "</B></TD></TR>")
        'Response.Write("</TABLE></DIV>")



        Dim sbHTML As New System.Text.StringBuilder("")
        sbHTML.Append("<DIV id=divFilter style='overflow:auto;'>")
        sbHTML.Append("<Table class=clsTABLE width='100%' cellpadding=0 cellspacing=0 >")
        sbHTML.Append("<Tr class=clsTRBlank>")
        sbHTML.Append("<TD valign=top align=Right><b>Customer Name</b></td>")
        sbHTML.Append("<TD valign=top align=Left title=Contains>" & CommonFunction.HTMLControls.DrawTextBox("txtCustomer", "txtCustomer", , 150, 500, m_strEmployeeName, ToBeInserted:="onKeyPress=txtName_OnKeyPress()", returnHTML:=True) & "</TD>")
        sbHTML.Append("</Tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        CommonFunction.General.WriteHTML(sbHTML.ToString)

    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim strModuleName As String = ""
        strModuleName = CommonFunctions.Data.GetDataScalar("Select ModuleName from tbl_PM_SystemModules where ModuleTagID=" + m_strModuleID.ToString, True)
        WebPages.Template.PageCaption.GetPageCaptions(, "Module Access -" + strModuleName, "Cosumed Licenses: " + m_intAlloted.ToString + "/" + strLicencesforModule.ToString)

        CommonFunctions.General.WriteHTML("<BR>")
    End Sub



    Public Sub New()
        MyBase.New()
        'MyBase.InitializeResources("AppResourcePPM.DM_IntiativeApprovers", "AppResourcePPM")
    End Sub



    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strLoginID As String
        If Args.DataField.ToUpper = "SELECTED" Then
            Dim strModuleID As String
            Dim blnDisabled As Boolean = False
            Dim blnSelected As Boolean = False
            If (CType(Args.DataReader("Selected"), Boolean)) Then
                blnSelected = True
                SelectedLoginCount = SelectedLoginCount + 1
            End If
            Cancel = True
            strLoginID = CType(Args.DataReader("LoginID"), String)
            Args.StringToBeInserted = "<TD  align=center >" + vbCrLf
            
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , blnSelected, strLoginID, blnDisabled, , True)

            Args.StringToBeInserted += "</Td>"

        End If
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class

