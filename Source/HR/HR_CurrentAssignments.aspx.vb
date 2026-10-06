'*********************************************************************
'                CSPL Code Header
' Project Name     : Whizible  
' Module Name      : HR_CurrentAssignments
' Purpose          : The page for Employee Current Assignments
' Description      : Same as Above   
' Assumptions      :    
' Dependencies     : 
' Author           : JyotiG
' Reviewed         :
' Tested           :
' Created          : Nov 23, 2006
' Revisions        :								   
'*********************************************************************
Public Class HR_CurrentAssignments
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

#Region "Constructor"
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016

        MyBase.InitializeResources("AppResources.PM_EmployeeSkillsSearch", "AppResources")
    End Sub
#End Region

#Region "Member Variables"
    Private m_strMode As String = ""
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected m_lngMasterTagID As Long
    Protected m_strViewMode As String  'Employee or Skill]
    Protected m_strPagingAlphabet As String
    Private WithEvents m_objGrid As New WebPages.Template.AdvancedGrid
    Private WithEvents m_objAccesibleGrid As New WebPages.Template.AdvancedGrid
    Private m_strPreviousValue As String
    Private WithEvents m_objGridForFilter As WebPages.Template.AdvancedGrid
    Private m_blnMatchFound As Boolean
    Private m_strSelectedToolID As String
    Private m_strSelectedYears As String
    Private m_strSelectedMonths As String
    Private m_strSelectedProficiency As String
    Private m_blnSelectedCoreCompetency As Boolean
    Protected m_intCheckBoxCount As Integer
    Private m_intCounter As Integer
    Private m_strToolArray() As String
    Private m_strToolDetailsArray() As String
    Private m_strMenu As String
    Protected m_lngEmployeeId As Long = 0
    Protected m_strProjectStatus As String = ""
    Protected m_strShow As String = ""
    Protected m_strActive As String = ""
    Protected m_strSortBy As String
    Protected m_strSortOrder As String
    Protected m_intNoOfRows As Integer
#End Region

#Region "Procedures"
    Public Sub PageInit()
        
        'Get the Page Number
        If Trim(Request.QueryString("PageNumber")) = "" Then
            m_strPagingAlphabet = "-1"
        Else
            m_strPagingAlphabet = Trim(Request.QueryString("PageNumber"))
        End If

        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15



        GetGlobalObject()

        m_lngMasterTagID = m_objGlobal.TagID
        If m_strMode = "" Then
            GetInitialVales()
            GetMenu(True)
            GetPageCaption(0)
            Response.Write("<BR>")
            GetUI()
            Response.Write("<BR>")
            GetAllocatedProjectUI()
            Response.Write("</DIV>")
            Response.Write("<BR>")
            GetMenu(False)
        End If

    End Sub

    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : JyotiG
    ' Created               : April 2, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub
    Private Sub GetUI()
        'Draw Filter

        Dim strDefaultval As String
        strDefaultval = "1"
        Response.Write("<table CellSpacing=" & "'0'" & "width=" & "'99.9%'" & "class=" & "'clsTable'" & ">")
        Response.Write("<TR class='clsTREven'><TD align=left>")
        'Projectt Aceess : Accessible / Allocated
        Response.Write("Project Access ")
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Show"), "") = "" Then
            Dim strDefault As String
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("Attempt"), "") = "" Then
                strDefault = "1"
                m_strShow = "1"
                Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboShow", "usp_Status_ComboFill 2", 100, strDefault, "onchange='javascript:cboShow_OnChange()'", True, True, , , ))
            Else
                Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboShow", "usp_Status_ComboFill 2", 100, "", "onchange='javascript:cboShow_OnChange()'", True, True, , , ))
            End If

        Else
            Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboShow", "usp_Status_ComboFill 2", 100, Request.QueryString("Show").ToString, "onchange='javascript:cboShow_OnChange()'", True, True, , , ))
        End If
        Response.Write("</TD><TD align=left>")

        'Project Over : Yes/ No
        Response.Write("Is Project Over?")
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Status"), "") = "" Then
            Dim strDef As String
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("Attempt"), "") = "" Then
                strDef = "0"
                m_strProjectStatus = "0"
                Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboProjectStatus", "usp_Status_ComboFill 1", 100, strDef, "onchange='javascript:cboProjectStatus_OnChange()'", True, True, , , ))
            Else
                Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboProjectStatus", "usp_Status_ComboFill 1", 100, "", "onchange='javascript:cboProjectStatus_OnChange()'", True, True, , , ))
            End If
        Else
            Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboProjectStatus", "usp_Status_ComboFill 1", 100, Request.QueryString("Status").ToString, "onchange='javascript:cboProjectStatus_OnChange()'", True, True, , , ))
        End If
        Response.Write("</TD><TD align=left>")

        'Is Active : Yes/ No
        Response.Write("Is Resource Active?")
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Active"), "") = "" Then
            Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboIsActive", "usp_Status_ComboFill 3", 100, "", "onchange='javascript:cboIsActive_OnChange()'", True, True, , , ))
        Else
            Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboIsActive", "usp_Status_ComboFill 3", 100, Request.QueryString("Active").ToString, "onchange='javascript:cboIsActive_OnChange()'", True, True, , , ))
        End If
        Response.Write("</TD></TR>")
        Response.Write("</table>")
    End Sub
    Private Sub GetInitialVales()
        'Intialise & retrive all values
        'Employee Id
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strEmployeeId"), "") = "" Then
            HttpContext.Current.Session.Add("strEmployeeId", Request.QueryString("EmployeeID_PK"))
            m_lngEmployeeId = CType(CommonFunction.General.CheckIsNothing(Session("strEmployeeId"), "0"), Long)
            HttpContext.Current.Session("EmployeeID") = Nothing
        Else
            m_lngEmployeeId = CType(CommonFunction.General.CheckIsNothing(Session("strEmployeeId"), "0"), Long)
        End If
        'Show : Accessible /Allocated
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Show"), "") = "" Then
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("Attempt"), "") = "" Then
                m_strShow = "1"
            End If
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Show"), "") <> "" Then
            m_strShow = CType(Request.QueryString("Show"), String)
        End If

        'Status : Open / Close
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Status"), "") = "" Then
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("Attempt"), "") = "" Then
                m_strProjectStatus = "0"
            End If
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Status"), "") <> "" Then
            m_strProjectStatus = CType(Request.QueryString("Status"), String)
        End If

        'Active : Yes/No
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Active"), "") <> "" Then
            m_strActive = CType(Request.QueryString("Active"), String)
        End If

        'For Sort Order 
        'Start
        'Sort Fields
        If Not Page.IsPostBack Then
            m_strSortBy = CommonFunctions.General.CheckIsNothing(Request.QueryString("txthidSortBy"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(Request.QueryString("txthidSortOrder"), "")
        Else
            m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        End If
        If m_strSortBy = "" Then m_strSortBy = "ProjectName" 'By Default Sort by Project Name
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"
        m_strSortOrder = CommonFunctions.General.UnBuildQueryString(m_strSortOrder)

    End Sub
    '=====================================================================
    ' Procedure Name        : GetMenu()	
    ' Purpose               : Function To Draw the Menu and Paging
    ' Description           : same as above
    ' Parameters Passed     : DrawPaging as Boolean
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : JyotiG
    ' Created               : Dec 05 2006
    ' Revisions             :
    '=====================================================================
    Private Sub GetMenu(ByVal DrawPaging As Boolean)
        Dim objMenu As WebPages.Template.StaticMenu
        Dim strPager As String
        objMenu = New WebPages.Template.StaticMenu

        Dim objPager As WebPages.Template.Paging
        objPager = New WebPages.Template.Paging
        Dim strSpNameForPaging As String
        Dim strQuery As String
        Dim strSQLQuery As String

        If m_lngEmployeeId <> 0 Then 'First time by default show allocated and Open Projects
            If (m_strProjectStatus = "0" Or CommonFunctions.General.CheckIsNothing(Request.QueryString("Attempt"), "") = "") And (m_strActive = "") And (m_strShow = "1") Then
                If m_strPagingAlphabet = "-1" Then
                    strSQLQuery = "Exec usp_sel_EmployeeProjects_Paging " & CType(m_lngEmployeeId, String) & ",1,0,NULL," & CType(m_strSortBy, String) & ",'" & CType(m_strSortOrder, String) & "','-1'"
                Else
                    strSQLQuery = "Exec usp_sel_EmployeeProjects_Paging " & CType(m_lngEmployeeId, String) & ",1,0,NULL," & CType(m_strSortBy, String) & ",'" & CType(m_strSortOrder, String) & "','-1'"
                End If

            Else
                If m_strActive = "" Then
                    m_strActive = "NULL"
                End If
                If m_strShow = "" Then
                    m_strShow = "NULL"
                End If
                If m_strProjectStatus = "" Then
                    m_strProjectStatus = "NULL"
                End If
                strSQLQuery = "Exec usp_sel_EmployeeProjects_Paging " & CType(m_lngEmployeeId, String) & "," & CType(m_strShow, String) & "," & CType(m_strProjectStatus, String) & "," & CType(m_strActive, String) & "," & CType(m_strSortBy, String) & ",'" & CType(m_strSortOrder, String) & "','-1'"
            End If
        End If
        strSpNameForPaging = strSQLQuery
        CheckIfAlphabetExists(strSpNameForPaging)
        strPager = objPager.DrawPaging(m_strPagingAlphabet, strSpNameForPaging)
        If strPager <> "" Then
            strPager = "Select " + strPager
        End If
        objPager = Nothing

        'Plot the Menu and the pager
        Dim arrMenu() As String = {"?"}

        Dim arrClientSideFunctions() As String = {"Help_OnClick('CA')"}

        Dim arrMenuToolTip() As String = {"Help"}

        If DrawPaging = True Then
            objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, False, strPager)
        Else
            objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, False)
        End If

        objMenu = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name        : GetMenu()	
    ' Purpose               : Function To Page Caption
    ' Description           : same as above
    ' Parameters Passed     : View
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : JyotiG
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageCaption(ByVal View As Integer)
        'If View Mode

        If View = 0 Then
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal)
        End If
    End Sub

    '=====================================================================
    ' Procedure Name        : GetAllocatedProjectUI()	
    ' Purpose               : Function To Draw the UI for Employee Current Assignments
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : JyotiG
    ' Created               : Nov 23, 2006
    ' Revisions             :
    '=====================================================================
    Private Sub GetAllocatedProjectUI()
        Dim strSQLQuery As String

        Dim ObjAllocatedProjectSection As New WebPage.Templates.SectionTitle
        Dim objSectionTitle As WebPages.Template.SectionTitle
        Response.Write("<DIV id='PageDiv' style='Overflow:auto;width=100%;Height:300'>")
        If m_lngEmployeeId <> 0 Then 'First time by default show allocated and Open Projects
            If (m_strProjectStatus = "0" Or CommonFunctions.General.CheckIsNothing(Request.QueryString("Attempt"), "") = "") And (m_strActive = "") And (m_strShow = "1") Then
                strSQLQuery = "Exec usp_sel_EmployeeProjects " & CType(m_lngEmployeeId, String) & ",1,0,NULL," & CType(m_strSortBy, String) & ",'" & CType(m_strSortOrder, String) & "','" & CType(CommonFunctions.General.BuildQueryString(m_strPagingAlphabet), String) & "'"
            Else
                If m_strActive = "" Then
                    m_strActive = "NULL"
                End If
                If m_strShow = "" Then
                    m_strShow = "NULL"
                End If
                If m_strProjectStatus = "" Then
                    m_strProjectStatus = "NULL"
                End If
                strSQLQuery = "Exec usp_sel_EmployeeProjects " & CType(m_lngEmployeeId, String) & "," & CType(m_strShow, String) & "," & CType(m_strProjectStatus, String) & "," & CType(m_strActive, String) & "," & CType(m_strSortBy, String) & ",'" & CType(m_strSortOrder, String) & "','" & CType(CommonFunctions.General.BuildQueryString(m_strPagingAlphabet), String) & "'"
            End If
        End If

        Dim arrActualColumnArray() As String = {"ProjectName", _
                                                "RoleDescription", _
                                                "ExpectedStartDate", _
                                                "ExpectedEndDate", _
                                                "ActualStartDate", _
                                                "ActualEndDate", _
                                                "PlannedEffort", _
                                                "ActualEffort", _
                                                "IsActive" _
                                                }

        Dim arrUserFriendlyArray() As String = {"Project Name", _
                                                "Role", _
                                                "Start Date", _
                                                "End Date", _
                                                "Actual Start Date", _
                                                "Actual End Date", _
                                                "Planned Effort(hrs)", _
                                                "Actual Effort(hrs)", _
                                                "Is Resource Active?" _
                                                }

        Dim arrTDStyle() As String = {"align=left style='width=15%'", "align=left width=15%", "align=left width=15%", "align=left width=15%", "align=left width=15%", "align=left width=15%", "align=right width=10%", "align=right width=10%", "align=left width=8%"}
        Dim strGrid As String

        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGrid.TDStyleArray = arrTDStyle
        m_objGrid.returnHTML = True
        m_objGrid.UseSQL = MyBase.UseSQL
        m_objGrid.SQL = strSQLQuery
        m_objGrid.NoOfDataColumns = 11
        m_objGrid.DIVHeight = 0
        m_intNoOfRows = m_objGrid.NoOfRowsInPage
        m_objGrid.SortBy = m_strSortBy
        m_objGrid.SortOrder = m_strSortOrder
        m_objGrid.ClientSideSortFunctionName = "Sort_OnClick"
        m_objGrid.EmptyValueReplacement = "N/A"
        m_objGrid.DIVStyle = "'overflow:auto;height:500;'"
        strGrid = m_objGrid.DrawGrid()
        m_objGrid = Nothing
        Response.Write(strGrid)
        ' total records
        Dim intNoOfRows As Integer
        Dim ds As DataSet
        ds = CommonFunctions.Data.GetDataSet(strSQLQuery, "default", , , CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        intNoOfRows = ds.Tables(0).Rows.Count
        Response.Write("<BR>")
        CommonFunctions.General.WriteTotalRecordsHTML(intNoOfRows, "Total Records:", False, "clsTREven")
        ds.Dispose() : ds = Nothing
        'End total record

    End Sub
    '=====================================================================
    ' Procedure Name        : CheckIfAlphabetExists()	
    ' Purpose               : If alphabet does not exist in current selected list, then set it to -1
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 8, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub CheckIfAlphabetExists(ByVal SQL As String)
        Dim drPaging As IDataReader
        Dim blnToSetAlphabet As Boolean = False
        drPaging = CommonFunctions.Data.GetDataReader(SQL, MyBase.UseSQL)
        While drPaging.Read
            If m_strPagingAlphabet.ToLower = CType(drPaging.Item(0), String).ToLower Then
                blnToSetAlphabet = True
            End If
        End While
        CommonFunction.Data.DisposeDataReader(drPaging)
        If blnToSetAlphabet = False Then
            m_strPagingAlphabet = "-1"
        End If
    End Sub

    '=====================================================================
    ' Procedure Name        : GetPageLegend()	
    ' Purpose               : Function To Draw the page legend
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : JyotiG
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageLegend()
        Dim arrLegend() As String = {MyBase.GetResourceString("PAGE_LEGEND")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        Response.Write(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True))
    End Sub


#End Region

#Region "Grid Events"
    
#End Region



    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strEmployeeId"), "") = "" Then
        '    HttpContext.Current.Session.Add("strEmployeeId", Request.QueryString("EmployeeID_PK"))
        '    m_lngEmployeeId = CType(CommonFunction.General.CheckIsNothing(Session("strEmployeeId"), "0"), Long)
        '    HttpContext.Current.Session("EmployeeID") = Nothing

        'Else
        '    m_lngEmployeeId = CType(CommonFunction.General.CheckIsNothing(Session("strEmployeeId"), "0"), Long)
        'End If
        'Dim strDefaultval As String
        'strDefaultval = "1"
        'Response.Write("<table CellSpacing=" & "'0'" & "width=" & "'99.9%'" & "class=" & "'clsTable'" & ">")
        'Response.Write("<TR class='clsTREven'><TD align=left>")
        'Response.Write("Project Access ")
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("Show"), "") = "" Then
        '    Dim strDefault As String
        '    If CommonFunctions.General.CheckIsNothing(Request.QueryString("Attempt"), "") = "" Then
        '        strDefault = "1"
        '        m_strShow = "1"
        '        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboShow", "usp_Status_ComboFill 2", 100, strDefault, "onchange='javascript:cboShow_OnChange()'", True, True, , , ))
        '    Else
        '        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboShow", "usp_Status_ComboFill 2", 100, "", "onchange='javascript:cboShow_OnChange()'", True, True, , , ))
        '    End If

        'Else
        '    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboShow", "usp_Status_ComboFill 2", 100, Request.QueryString("Show").ToString, "onchange='javascript:cboShow_OnChange()'", True, True, , , ))
        'End If
        'Response.Write("</TD><TD align=left>")
        'Response.Write("Is Project Over?")
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("Status"), "") = "" Then
        '    Dim strDef As String
        '    If CommonFunctions.General.CheckIsNothing(Request.QueryString("Attempt"), "") = "" Then
        '        strDef = "0"
        '        m_strProjectStatus = "0"
        '        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboProjectStatus", "usp_Status_ComboFill 1", 100, strDef, "onchange='javascript:cboProjectStatus_OnChange()'", True, True, , , ))
        '    Else
        '        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboProjectStatus", "usp_Status_ComboFill 1", 100, "", "onchange='javascript:cboProjectStatus_OnChange()'", True, True, , , ))
        '    End If
        'Else
        '    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboProjectStatus", "usp_Status_ComboFill 1", 100, Request.QueryString("Status").ToString, "onchange='javascript:cboProjectStatus_OnChange()'", True, True, , , ))
        'End If
        'Response.Write("</TD><TD align=left>")
        'Response.Write("Is Active ")
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("Active"), "") = "" Then
        '    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboIsActive", "usp_Status_ComboFill 3", 100, "", "onchange='javascript:cboIsActive_OnChange()'", True, True, , , ))
        'Else
        '    Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboIsActive", "usp_Status_ComboFill 3", 100, Request.QueryString("Active").ToString, "onchange='javascript:cboIsActive_OnChange()'", True, True, , , ))
        'End If

        'Response.Write("</TD></TR>")
        'Response.Write("</table>")
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("Status"), "") <> "" Then
        '    m_strProjectStatus = CType(Request.QueryString("Status"), String)
        'End If
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("Show"), "") <> "" Then
        '    m_strShow = CType(Request.QueryString("Show"), String)
        'End If
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("Active"), "") <> "" Then
        '    m_strActive = CType(Request.QueryString("Active"), String)
        'End If
        ''For Sort Order 
        ''Start
        ''Sort Fields
        'If Not Page.IsPostBack Then
        '    m_strSortBy = CommonFunctions.General.CheckIsNothing(Request.QueryString("txthidSortBy"), "")
        '    m_strSortOrder = CommonFunctions.General.CheckIsNothing(Request.QueryString("txthidSortOrder"), "")
        'Else
        '    m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
        '    m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        'End If
        'If m_strSortBy = "" Then m_strSortBy = "ProjectName"
        'm_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        'If m_strSortOrder = "" Then m_strSortOrder = "ASC"
        'm_strSortOrder = CommonFunctions.General.UnBuildQueryString(m_strSortOrder)

        'End
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        HttpContext.Current.Session("strEmployeeId") = Nothing
    End Sub
End Class
