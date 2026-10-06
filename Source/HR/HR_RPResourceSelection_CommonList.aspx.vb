Imports System
Imports CommonEngines.General.cEventHandlers
Public Class HR_RPResourceSelection_CommonList
    Inherits CommonList
    Private ResourcePoolID As String
    Private IsSelected As String
    Public Shared FromWhere As String
    Public Shared tableName As String


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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        MyBase.strListPage = "HR_RPResourceSelection_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"

        ResourcePoolID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID"), "0"), String)
        If ResourcePoolID = "0" Then
            ResourcePoolID = HttpContext.Current.Request.Form("hidResourcePoolID")
        End If
        IsSelected = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IsSelected"), ""), String)

        If IsSelected = "" Then
            IsSelected = HttpContext.Current.Request.Form("IsSelected")
        End If

        FromWhere = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Fromwhere"), ""), String)

        If FromWhere = "" Then
            FromWhere = HttpContext.Current.Request.Form("hidFromWhere")
        End If
        If FromWhere = "RES" Then
            tableName = "tbl_PM_ResourcePoolDetail"
        ElseIf FromWhere = "MGR" Then
            tableName = "tbl_PM_ResourcePoolManagers"
        End If

        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New c_HR_RPResourceSelection_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cHR_RPResourceSelection_CommonListSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cHR_RPResourceSelection_CommonListDynamicFilters(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim chkDelete() As String
        Dim Iterator As Integer
        Dim strQuery As String
        Dim strDelteQuery As String
        Dim strDelteSubQuery As String
        Dim PostID As String
        Dim DesignationID As String
        Dim DepartmentID As String
        Dim BusinessGroupID As String
        Dim LocationID As String
        Dim EmployeeName As String




        PostID = Request.Form("RoleID")
        DesignationID = Request.Form("DesignationID")
        DepartmentID = Request.Form("DepartmentID")
        BusinessGroupID = Request.Form("BusinessGroupID")
        LocationID = Request.Form("LocationID")
        EmployeeName = Request.Form("EmployeeName")

        If DeletedIDList <> "" Then

            chkDelete = DeletedIDList.Split(","c)
            'To Insert record in Soft Booking
            For Iterator = 0 To chkDelete.Length - 1
                strQuery = "usp_Ins_tbl_PM_ResourcePoolDetail " + ResourcePoolID + "," + chkDelete(Iterator) + ",'" + FromWhere + "'"
                CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next

        End If
        If DeletedIDList = "" Then
            DeletedIDList = "0"
        End If
        'strDelteQuery = "DELETE FROM " + tableName + " WHERE ResourcePoolID = " + ResourcePoolID + " AND EmployeeID NOT IN(" + DeletedIDList + ")"
        ''strDelteSubQuery = " AND EmployeeID IN (SELECT EmployeeId FROM tbl_PM_Employee WHERE 1 = 1"
        'strDelteSubQuery = " AND EmployeeID IN (SELECT EmployeeId FROM " + tableName + " WHERE 1 = 1 AND ResourcePoolID = " + ResourcePoolID + " AND EmployeeID IN(" + Request.Form("hidUIEmployeeID").ToString() + ") AND EmployeeID NOT IN(" + DeletedIDList + ")"

        strDelteQuery = "DELETE FROM " + tableName + " WHERE ResourcePoolID = " + ResourcePoolID + " AND EmployeeID NOT IN(" + DeletedIDList + ")"
        'strDelteSubQuery = " AND EmployeeID IN (SELECT EmployeeId FROM tbl_PM_Employee WHERE 1 = 1"
        strDelteSubQuery = " AND EmployeeID IN(" + Request.Form("hidUIEmployeeID").ToString() + ") "


        'If PostID <> "" Then
        '    strDelteSubQuery += " AND PostID=" + PostID
        'End If
        'If DesignationID <> "" Then
        '    strDelteSubQuery += " AND DesignationID=" + DesignationID
        'End If
        'If DepartmentID <> "" Then
        '    strDelteSubQuery += " AND DepartmentID=" + DepartmentID
        'End If
        'If BusinessGroupID <> "" Then
        '    strDelteSubQuery += " AND BusinessGroupID=" + BusinessGroupID
        'End If
        'If LocationID <> "" Then
        '    strDelteSubQuery += " AND LocationID=" + LocationID
        'End If
        'If EmployeeName <> "" Then
        '    strDelteSubQuery += " AND EmployeeName like '" + EmployeeName.Trim() + "%'"
        'End If
        ''strDelteSubQuery += ")"
        strDelteQuery += strDelteSubQuery
        'Dim strDelQueryForSoftBooking As String
        'strDelQueryForSoftBooking = strDelteQuery

        'strDelteQuery = "DELETE FROM tbl_RM_SoftBooking_Distribution WHERE OpportunityID = " + OpportunityID + " AND PipelineID = " + pipelineID + " AND BookingID NOT IN( SELECT BookingID FROM tbl_RM_SoftBooking WHERE OpportunityID =" + OpportunityID + " AND PipelineID= " + pipelineID + " AND EmployeeID IN(" + DeletedIDList + "))"
        'strDelteQuery += " AND BookingID IN ( SELECt BookingID FROM tbl_RM_SoftBooking WHERE OpportunityID = " + OpportunityID + " AND PipelineID = " + pipelineID
        'strDelteQuery += strDelteSubQuery + ")"
        CommonFunction.Data.InsertOrUpdateData(strDelteQuery, MyBase.UseSQL)

        'CommonFunction.Data.InsertOrUpdateData(strDelQueryForSoftBooking, MyBase.UseSQL)
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString

    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunctions.General.WriteHTML("<input type=hidden name='IsSelected' value=" + IsSelected + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidFromWhere' value=" + FromWhere + ">")

    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper() = "SHOW SELECTED RESOURCES" Then
            If IsSelected = "SHOWSELECTED" Then
                Cancel = True
            End If
        End If

        If Args.LinkName.ToUpper() = "SHOW ALL RESOURCES" Then
            If IsSelected = "SHOWALL" Or IsSelected = "" Then
                Cancel = True
            End If
        End If

    End Sub

End Class
Public Class c_HR_RPResourceSelection_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Private strRPEmplyeeIDs As String
    Private ResourcePoolID As String
    Private strUIEmployeeIDs As String
    Private Iterator As Integer = 1
    Private pageNumber As Integer
    Private startIterator As Integer

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim PostID As String
        Dim DesignationID As String
        Dim DepartmentID As String
        Dim BusinessGroupID As String
        Dim LocationID As String
        Dim EmployeeName As String
        Dim strSubQuery As String
        Dim strPipeLineFte As String

        ResourcePoolID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID"), "0"), String)

        If ResourcePoolID = "0" Then
            ResourcePoolID = HttpContext.Current.Request.Form("hidResourcePoolID")
        End If

        CommonFunctions.General.WriteHTML("<input type=hidden name='hidResourcePoolID' value=" + ResourcePoolID + ">")


        PostID = HttpContext.Current.Request.Form("RoleID")
        DesignationID = HttpContext.Current.Request.Form("DesignationID")
        DepartmentID = HttpContext.Current.Request.Form("DepartmentID")
        BusinessGroupID = HttpContext.Current.Request.Form("BusinessGroupID")
        LocationID = HttpContext.Current.Request.Form("LocationID")
        EmployeeName = HttpContext.Current.Request.Form("EmployeeName")

        strSubQuery = " AND EmployeeID NOT IN (SELECT EmployeeId FROM tbl_PM_Employee WHERE 1 = 1"
        If PostID <> "" Then
            strSubQuery += " AND PostID=" + PostID
        End If
        If DesignationID <> "" Then
            strSubQuery += " AND DesignationID=" + DesignationID
        End If
        If DepartmentID <> "" Then
            strSubQuery += " AND DepartmentID=" + DepartmentID
        End If
        If BusinessGroupID <> "" Then
            strSubQuery += " AND BusinessGroupID=" + BusinessGroupID
        End If
        If LocationID <> "" Then
            strSubQuery += " AND LocationID=" + LocationID
        End If
        If EmployeeName <> "" Then
            strSubQuery += " AND EmployeeName like '" + EmployeeName.Trim() + "%'"
        End If
        strSubQuery += ")"

        strSubQuery = "SELECT DISTINCT EmployeeID FROM " + HR_RPResourceSelection_CommonList.tableName + " WHERE ResourcePoolID = " + ResourcePoolID + strSubQuery
        Dim strEmpIDs As String = ""
        Dim dr As IDataReader = CommonFunction.Data.GetDataReader(strSubQuery, True) 'remove hardcode
        While dr.Read
            strEmpIDs = strEmpIDs + dr(0).ToString + ","
        End While
        If strEmpIDs <> "" Then
            strEmpIDs = strEmpIDs.Substring(0, strEmpIDs.Length - 1)
        End If
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidSelectedEmpIDs' value=" + strEmpIDs + ">")
        'strPipeLineFte = CType(CommonFunctions.Data.GetDataScalar("SELECT TotalFTE FROM tbl_RM_PipeLine WHERE OpportunityID = " + OpportunityID + " AND PipelineID = " + pipelineID, True), String)
        'If strPipeLineFte = "" Then
        '    strPipeLineFte = "0"
        'End If
        'CommonFunctions.General.WriteHTML("<input type=hidden id='hidMaxResourceSelCount' value=" + strPipeLineFte + ">")
        'To retrive soft booking EmployeeIDs 
        strRPEmplyeeIDs = CType(CommonFunctions.Data.GetDataScalar("usp_sel_ResourcePoolResources " + ResourcePoolID + ",'" + HR_RPResourceSelection_CommonList.FromWhere + "'", True), String)

        pageNumber = CType(HttpContext.Current.Request.Form("txtNumPaging1"), Integer)

        If Not HttpContext.Current.Request.QueryString("PagingNumber") Is Nothing Then

            pageNumber = CType(HttpContext.Current.Request.QueryString("PagingNumber"), Integer)

            If CType(HttpContext.Current.Request.QueryString("PagingNavigation"), String) = "PREV" Then
                pageNumber -= 1
            ElseIf CType(HttpContext.Current.Request.QueryString("PagingNavigation"), String) = "NEXT" Then
                pageNumber += 1
            Else
                pageNumber = CType(HttpContext.Current.Request.QueryString("PagingNumber"), Integer)
            End If


        End If

        startIterator = (pageNumber - 1) * 20 + 1

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strEmpID As String

        If Args.ColumnName.ToUpper = "SELECT" Then
            strEmpID = Args.DataReader("EmployeeID").ToString + ""

            If strRPEmplyeeIDs.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                'Draw CheckBox selected
                Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value=" + strEmpID + " ></TD>"
                Cancel = True
            End If

        End If

    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Iterator >= startIterator Then
            strUIEmployeeIDs = strUIEmployeeIDs + CType(Args.DataReader("EmployeeID"), String) + ","
        End If

        Iterator += 1

    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        strUIEmployeeIDs = strUIEmployeeIDs + "0"
        CommonFunctions.General.WriteHTML("<input type=hidden name=hidUIEmployeeID id=hidUIEmployeeID value='" + strUIEmployeeIDs + "'>")
    End Sub
End Class

Public Class cHR_RPResourceSelection_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim ResourcePoolID As String
        Dim IsSelected As String


        IsSelected = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IsSelected"), ""), String)

        If IsSelected = "" Then
            IsSelected = CType(HttpContext.Current.Request.Form("IsSelected"), String)
        End If

        If Not IsSelected Is Nothing Or IsSelected <> "" Then
            If IsSelected.ToUpper() = "SHOWSELECTED" Then
                ResourcePoolID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID"), "0"), String)

                If ResourcePoolID = "0" Then
                    ResourcePoolID = HttpContext.Current.Request.Form("hidResourcePoolID")
                End If

                GetPageSpecificFilters = "AND EmployeeID IN( SELECT EmployeeId FROM " + HR_RPResourceSelection_CommonList.tableName + " WHERE ResourcePoolID = " + ResourcePoolID + ")"

            End If
        End If

        If HR_RPResourceSelection_CommonList.FromWhere = "RES" Then

            If CType(HttpContext.Current.Request.Form("cboSkill"), String) <> "" Then
                GetPageSpecificFilters += " AND EmployeeID IN(SELECT Distinct EmployeeID FROM tbl_PM_EmployeeSkillMatrix WHERE ToolID = " + CType(HttpContext.Current.Request.Form("cboSkill"), String) + ")"
            End If
        End If

    End Function
End Class


Public Class cHR_RPResourceSelection_CommonListDynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    'Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    'Dim strSkillID As String

    '    'If Args.FilterName = "DepartmentID" Then

    '    '    If HR_RPResourceSelection_CommonList.FromWhere = "RES" Then
    '    '        Cancel = True
    '    '        Args.ToBeInserted = "<input type=hidden name=DepartmentID value=''>"
    '    '        'strSkillID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSkill"), ""), String)

    '    '        'Args.ToBeInserted = "<TD align=right title='Skill'>Skill</TD><TD align=left>" + CommonFunction.HTMLControls.DrawComboBox("cboSkill", " SELECT ToolID,[Description] FROM tbl_PM_Tools WHERE IsSkill=1 ORDER BY 2 ", 150, strSkillID, "Onchange=javascript:cboSkill_OnChange()", True, True) + "<input type=hidden name=DepartmentID value=''></TD></TR><TR>"

    '    '    End If
    '    'End If

    '    'If Args.FilterName = "Skill" Then

    '    '    If HR_RPResourceSelection_CommonList.FromWhere <> "RES" Then
    '    '        Cancel = True
    '    '        Args.ToBeInserted = "<input type=hidden name=Skill value=''>"
    '    '    Else
    '    '        Args.ToBeInserted = "<input type=hidden name=ActualSkillID value='0'>"
    '    '    End If
    '    'End If

    'End Sub


End Class