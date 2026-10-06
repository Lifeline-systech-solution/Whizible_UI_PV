Imports System
Imports CommonEngines.General.cEventHandlers
Imports Whizible
Public Class BulkAllocation_CommonList
    Inherits CommonList
    Protected m_lngTagID As Long
    Protected m_FromWhere As String
    Protected m_SettingValueResAll As String
    Protected m_strSelected As String
    Protected m_strSel_Details As String
    'Added By SonalD on 24th Sept 2008
    Protected m_refreshParent As Integer = 0
    'End of addition by sonalD on 24th Sept 2008
    Protected m_lngEmployeeID As Integer
    Protected m_strLoginType As String

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "BulkAllocation_CommonList.aspx"
        MyBase.strFormPage = "../General/CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"

        ''Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
        Dim RoleDescription As String
        Dim Designationname As String
        Dim Department As String
        Dim BusinessGroup As String
        Dim Location As String
        Dim EmployeeName As String
        Dim ExpectedStartDate As String
        Dim ExpectedEndDate As String
        Dim ResourcePercentage As String

        ''Added By Vidya Jadhav ON 14 Dec 2016 For Employee Filter Persists
        m_lngEmployeeID = HttpContext.Current.Session("intUserID")
        m_strLoginType = HttpContext.Current.Session("LoginType")
        ''End Of Added By Vidya Jadhav ON 14 Dec 2016 For Employee Filter Persists

        RoleDescription = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RoleDescription"), "")
        Designationname = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Designationname"), "")
        Department = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Department"), "")
        BusinessGroup = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroup"), "")
        Location = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Location"), "")
        EmployeeName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeName"), "")
        ExpectedStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedStartDate"), "")
        ExpectedEndDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedEndDate"), "")
        ResourcePercentage = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePercentage"), "")




        If Not Request.QueryString("RoleDescription") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                RoleDescription = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("RoleDescription")), String)
                RoleDescription = IIf(RoleDescription = "", "", RoleDescription).ToString
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'RoleDescription','RoleDescription','F','" & RoleDescription & "','" & RoleDescription & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'RoleDescription','" & m_strLoginType & "'"
                RoleDescription = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                RoleDescription = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'RoleDescription','" & m_strLoginType & "'"
            RoleDescription = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If


        If Not Request.QueryString("Designationname") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                Designationname = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("Designationname")), String)
                Designationname = IIf(Designationname = "", "", Designationname).ToString
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'Designationname','Designationname','F','" & Designationname & "','" & Designationname & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Designationname','" & m_strLoginType & "'"
                Designationname = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                Designationname = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Designationname','" & m_strLoginType & "'"
            Designationname = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If


        If Not Request.QueryString("Department") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                Department = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("Department")), String)
                Department = IIf(Department = "", "", Department).ToString
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'Department','Department','F','" & Department & "','" & Department & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Department','" & m_strLoginType & "'"
                Department = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                Department = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Department','" & m_strLoginType & "'"
            Department = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If



        If Not Request.QueryString("BusinessGroup") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                BusinessGroup = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("BusinessGroup")), String)
                BusinessGroup = IIf(BusinessGroup = "", "", BusinessGroup).ToString
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'BusinessGroup','BusinessGroup','F','" & BusinessGroup & "','" & BusinessGroup & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'BusinessGroup','" & m_strLoginType & "'"
                BusinessGroup = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                BusinessGroup = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'BusinessGroup','" & m_strLoginType & "'"
            BusinessGroup = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If

        If Not Request.QueryString("Location") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                Location = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("Location")), String)
                Location = IIf(Location = "", "", Location).ToString
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'Location','Location','F','" & Location & "','" & Location & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Location','" & m_strLoginType & "'"
                Location = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                Location = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Location','" & m_strLoginType & "'"
            Location = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If

        If Not Request.QueryString("EmployeeName") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                EmployeeName = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeName")), String)
                EmployeeName = IIf(EmployeeName = "", "", EmployeeName).ToString
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'EmployeeName','EmployeeName','F','" & EmployeeName & "','" & EmployeeName & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'EmployeeName','" & m_strLoginType & "'"
                EmployeeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                EmployeeName = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'EmployeeName','" & m_strLoginType & "'"
            EmployeeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If

        If Not Request.QueryString("ExpectedStartDate") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                ExpectedStartDate = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ExpectedStartDate")), String)
                ExpectedStartDate = IIf(ExpectedStartDate = "", "", ExpectedStartDate).ToString
                'Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'ExpectedStartDate','ExpectedStartDate','F','" & ExpectedStartDate & "_" & HttpContext.Current.Session("intProjectId") & "','" & ExpectedStartDate & "_" & HttpContext.Current.Session("intProjectId") & "'"
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'ExpectedStartDate','ExpectedStartDate','F','" & ExpectedStartDate & "','" & ExpectedStartDate & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedStartDate','" & m_strLoginType & "'"
                ExpectedStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                ExpectedStartDate = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedStartDate','" & m_strLoginType & "'"
            ExpectedStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If
        'Dim ArrExpectedStartDate As Array
        'If ExpectedStartDate <> "" Then
        '    ArrExpectedStartDate = ExpectedStartDate.Split("_")
        '    Dim ProjectIDToCheck As String
        '    ProjectIDToCheck = ArrExpectedStartDate(1)
        '    If ProjectIDToCheck = HttpContext.Current.Session("intProjectId") Then
        '        ExpectedStartDate = ArrExpectedStartDate(0)
        '    End If
        'End If

        If Not Request.QueryString("ExpectedEndDate") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                ExpectedEndDate = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ExpectedEndDate")), String)
                ExpectedEndDate = IIf(ExpectedEndDate = "", "", ExpectedEndDate).ToString
                ' Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'ExpectedEndDate','ExpectedEndDate','F','" & ExpectedEndDate & "_" & HttpContext.Current.Session("intProjectId") & "','" & ExpectedEndDate & "_" & HttpContext.Current.Session("intProjectId") & "'"
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'ExpectedEndDate','ExpectedEndDate','F','" & ExpectedEndDate & "','" & ExpectedEndDate & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedEndDate','" & m_strLoginType & "'"
                ExpectedEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                ExpectedEndDate = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedEndDate','" & m_strLoginType & "'"
            ExpectedEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If
        'Dim ArrExpectedEndDate As Array
        'If ExpectedEndDate <> "" Then
        '    ArrExpectedEndDate = ExpectedEndDate.Split("_")
        '    Dim ProjectIDToCheck1 As String
        '    ProjectIDToCheck1 = ArrExpectedEndDate(1)
        '    If ProjectIDToCheck1 = HttpContext.Current.Session("intProjectId") Then
        '        ExpectedEndDate = ArrExpectedEndDate(0)
        '    End If
        'End If
        If Not Request.QueryString("ResourcePercentage") Is Nothing Then

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyFilters")) = "1" Then
                ResourcePercentage = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ResourcePercentage")), String)
                ResourcePercentage = IIf(ResourcePercentage = "", "", ResourcePercentage).ToString
                Dim strSQLins = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968,null,'ResourcePercentage','ResourcePercentage','F','" & ResourcePercentage & "','" & ResourcePercentage & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLins, True)
                'strSQLins = "usp_Ins_tbl_UI_EmployeeFilterSettings  '" & m_strLoginType & "'," & m_lngEmployeeID & ",3968"
                'CommonFunction.Data.InsertOrUpdateData(strSQLins, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            If m_lngEmployeeID <> 0 Then
                Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ResourcePercentage','" & m_strLoginType & "'"
                ResourcePercentage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
            Else
                ResourcePercentage = ""
            End If
        Else
            Dim strSqlQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ResourcePercentage','" & m_strLoginType & "'"
            ResourcePercentage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlQuery, True), "")
        End If

        ''End Of Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
        m_lngTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Long)
        If m_lngTagID = 0 Then
            m_lngTagID = CType(Request.Form("hidPTagID"), Long)
        End If
        m_FromWhere = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "0"), String)
        If m_FromWhere = "0" Then
            m_FromWhere = Request.Form("hidFromWhere")
        End If
        If m_lngTagID = CommonFunction.Constants.APP_TAG_RESOURCES Then
            m_SettingValueResAll = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_ResAllocation_SettingValue", True), String)
            If CType(m_SettingValueResAll, Double) = 0 Then
                m_SettingValueResAll = "100"
            End If
        End If
        m_strSelected = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("hidSelected"))
        m_strSel_Details = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("hidSel_Details"))
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action")).Trim.ToUpper = "SAVE" Then
            Call SaveAndAllocate()
            m_strSelected = ""
            m_strSel_Details = ""
        End If
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New c_BulkAllocation_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function


    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cBulkAllocation_CommonListSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cBulkAllocation_CommonListDynamicFilters(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidFromWhere' name='hidFromWhere' value=" + m_FromWhere + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidPTagID' name='hidPTagID' value=" + CType(m_lngTagID, String) + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidSelected' name='hidSelected' value='" + m_strSelected + "'>")
        'Modified by SonalD on 14th April 2009 For IssueID 29445..FormatString function used for value of this hidden control
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidSel_Details' name='hidSel_Details' value='" + CommonFunctions.General.FormatString(m_strSel_Details) + "'>")
        'End of modification by SonalD on 14th April 2009 
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''CommonFunctions.General.WriteHTML("<input type=hidden id='hidProjectStartDate' name='hidProjectStartDate' value='" + CType(CommonFunctions.Data.GetDataScalar("Select convert(varchar(20),ExpectedStartDate,106)  from tbl_Pm_Project where ProjectID=" + CStr(HttpContext.Current.Session("intProjectId")), True), String) + "'>")
        ''CommonFunctions.General.WriteHTML("<input type=hidden id='hidProjectEndDate' name='hidProjectEndDate' value='" + CType(CommonFunctions.Data.GetDataScalar("Select  convert(varchar(20),ExpectedEndDate,106) from tbl_Pm_Project where ProjectID=" + CStr(HttpContext.Current.Session("intProjectId")), True), String) + "'>")
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidProjectStartDate' name='hidProjectStartDate' value='" + CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_Pm_Project_ExpectedStartDate " + CStr(HttpContext.Current.Session("intProjectId")), True), String) + "'>")
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidProjectEndDate' name='hidProjectEndDate' value='" + CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_Pm_Project_ExpectedEndDate " + CStr(HttpContext.Current.Session("intProjectId")), True), String) + "'>")
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        'Added by SonalD on 24th Sept 2008
        If m_refreshParent = 1 Then
            CommonFunction.General.WriteHTML("<script language='javascript'>")
            CommonFunction.General.WriteHTML("refreshParent(""frmCommonList"",""CommonList.aspx"",""../General/CommonList.aspx?MasterTagId=1019"");")
            CommonFunction.General.WriteHTML("</script>")
        End If
        'End if addition by SonalD on 24th Sept 2008
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        'MyBase.Initialize_Legend(Cancel, Args)
        Args.HTMLLegend = ""
        Cancel = True
    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName = "Delete" Then
            Cancel = True
        End If
        If Args.LinkName = "Filters" Then
            Cancel = True
        End If

        If Args.ClientSideFunctionName.ToUpper.Trim = "ALLCLEAR" Then
            Args.ToBeInsertedInFunction = "BulkAllocate_ClearAll_OnClick(); return;//"
        ElseIf Args.ClientSideFunctionName.ToUpper.Trim = "SELECTALL_ONCLICK" Then
            Args.ToBeInsertedInFunction = "BulkAllocate_SelectAll_OnClick(); return;//"
        ElseIf Args.ClientSideFunctionName.ToUpper.Trim = "SAVEANDALLOCATE" Then
            Dim strToBeInserted As StringBuilder = New System.Text.StringBuilder
            strToBeInserted.Append("if(!validate_BulkAllocation()) {return false; }")
            strToBeInserted.Append("objfrm.action = 'BulkAllocation_CommonList.aspx?Action=Save';")
            strToBeInserted.Append("objfrm.submit(); return;//")
            Args.ToBeInsertedInFunction = strToBeInserted.ToString
        End If
    End Sub

    Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

        If Args.HeaderFooter.Trim.ToUpper = "HEADER" Then

            Dim strHeaderFooter As System.Text.StringBuilder = New System.Text.StringBuilder

            Dim dtmProjectEndDate As String
            ' Added By ChaitraliH For WhizibleSem8 On 2 Oct 08
            Dim dtmProjectStartDate As String
            Dim strAllocationRole As String = ""
            Dim strReportingTo As String = ""
            Dim strResourceStatus As String = ""
            Dim strSql As String
            Dim strSql2 As String

            Dim ExpectedStartDate As String
            Dim ExpectedEndDate As String
            Dim ResourcePercentage As String

            ' ExpectedStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedStartDate"), "")
            ' ExpectedEndDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedEndDate"), "")
            ResourcePercentage = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePercentage"), "")
            ''Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
            Dim chkBillable As String = ""
            ''End of Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            ''strSql = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID =" + CStr(HttpContext.Current.Session("intProjectId")) + "AND IsDefaultApprover = 1"
            strSql = "usp_sel_tbl_PM_ProjectEmployeeRole_EmployeeID " + CStr(HttpContext.Current.Session("intProjectId"))
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            strReportingTo = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)

           
           
            'Allocation Role
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("AllocationRole"), "").ToString() <> "" Then
                strAllocationRole = HttpContext.Current.Request.Form("AllocationRole")
            End If
            'Reporting To
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ReportingTo"), "").ToString() <> "" Then
                'Added by SonalD on 14th April 2009 For IssueID 29445..FormatString function used
                strReportingTo = CommonFunction.General.FormatString(HttpContext.Current.Request.Form("ReportingTo"))
                'End of modification by SonalD on 14th April 2009
            End If
            'Status
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ResourceStatus"), "").ToString() <> "" Then
                strResourceStatus = HttpContext.Current.Request.Form("ResourceStatus")
            End If

            ''Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
            'Billable
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkBillable"), "").ToString() <> "" Then
                chkBillable = HttpContext.Current.Request.Form("chkBillable")
            End If
            ''End of Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes


            If dtmProjectStartDate = "" Then
                Dim strSQLQuery1 = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedStartDate','" & m_strLoginType & "'"
                dtmProjectStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery1, True), "")
            End If

            If dtmProjectStartDate = "" Then
                'Start Date
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedStartDate"), "").ToString() = "" Then
                    dtmProjectStartDate = CommonFunction.Dates.GetDate(Now())
                Else
                    dtmProjectStartDate = HttpContext.Current.Request.Form("ExpectedStartDate")
                End If
            End If
            Dim strSQLQuery
            If dtmProjectEndDate = "" Then
                strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedEndDate','" & m_strLoginType & "'"
                dtmProjectEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
            End If

            If dtmProjectEndDate = "" Then
                ' End Date
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedEndDate"), "").ToString() = "" Then
                    ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                    '' dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("SELECT  CASE WHEN DATEDIFF(dd, ExpectedEndDate, Getdate()) <= 0 THEN convert(varchar(20), ExpectedEndDate,106) ELSE '' END FROM tbl_PM_Project Where Projectid = " + CStr(HttpContext.Current.Session("intProjectId")), True), String))
                    dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ExpectedEndDate_HR " + CStr(HttpContext.Current.Session("intProjectId")), True), String))
                    ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                Else
                    dtmProjectEndDate = HttpContext.Current.Request.Form("ExpectedEndDate")
                End If
            End If



            Dim strSQLQuery2 = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ResourcePercentage','" & m_strLoginType & "'"
            ResourcePercentage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery2, True), "")
            If ResourcePercentage = "" Then
                ResourcePercentage = 0
            End If

             
        ' End Of Addition By ChaitraliH For WhizibleSem8 On 2 Oct 08
        'dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Project_ExpectedEndDate " + CStr(HttpContext.Current.Session("intProjectId")), True), DateTime))
        strHeaderFooter.Append("<BR><TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>3. Enter Allocation Details</TD></TR></TABLE><BR>")
        strHeaderFooter.Append("<TABLE id='tbl_AllocationDetails' CellSpacing='0' BORDER='0' class='clsTable' width='100%'>")
        strHeaderFooter.Append("<TR align='Left' class='clsTRPageFilters'>")

        ''Commented By Vidya Jadhav ON 3 Aug 2017 For Bulk Allocation Resource Functionality
        'strHeaderFooter.Append("<TD align='right'>Start Date</TD>")
        'strHeaderFooter.Append("<TD align='left'>")
        'strHeaderFooter.Append(CommonFunctions.HTMLControls.DrawDateControl("ExpectedStartDate", "ExpectedStartDate", , , dtmProjectStartDate, , "frmCommonList", , , , , , , True, True))
        'strHeaderFooter.Append("</TD>")
        ' strHeaderFooter.Append("<TD align='right'>End Date</TD>")
        'strHeaderFooter.Append("<TD align='left'>")
        ' strHeaderFooter.Append(CommonFunctions.HTMLControls.DrawDateControl("ExpectedEndDate", "ExpectedEndDate", , , dtmProjectEndDate, , "frmCommonList", , , , , , , True, True))
        ' strHeaderFooter.Append("</TD>")
        ''End Of Commented By Vidya Jadhav ON 3 Aug 2017 For Bulk Allocation Resource Functionality

        ''Commented By Vidya Jadhav ON 3 Aug 2017 For Bulk Allocation Resource Functionality
            strHeaderFooter.Append("<TD align='right'>Start Date : </TD>")
        strHeaderFooter.Append("<TD align='left'>")
            strHeaderFooter.Append("<label id='lblExpectedStartDate'></label>")
        strHeaderFooter.Append("</TD>")
            strHeaderFooter.Append("<TD align='right'>End Date : </TD>")
        strHeaderFooter.Append("<TD align='left'>")
            strHeaderFooter.Append("<label id='lblExpectedEndDate'></label>")
        strHeaderFooter.Append("</TD>")
            strHeaderFooter.Append("<TD align='LEFT' style='width:87px;'>Resource Percentage : </TD>")
        strHeaderFooter.Append("<TD align='left'>")
            strHeaderFooter.Append("<label>" & ResourcePercentage & "</label>")
        strHeaderFooter.Append("</TD>")
        ''End Of Commented By Vidya Jadhav ON 3 Aug 2017 For Bulk Allocation Resource Functionality
        strHeaderFooter.Append("</TR>")
        strHeaderFooter.Append("<TR align='Left' class='clsTRPageFilters'>")
        strHeaderFooter.Append("<TD align='right'>Project Role</TD>")
        strHeaderFooter.Append("<td align='left'>")
        strHeaderFooter.Append(CommonFunctions.HTMLControls.DrawComboBox("AllocationRole", "EXEC usp_Sel_tbl_PM_Role_PopulateCombo", 150, strAllocationRole, , , True, , True))
        strHeaderFooter.Append("</td>")
        strHeaderFooter.Append("<TD align='right'>Reporting To</TD>")
        strHeaderFooter.Append("<td align='left'>")
        Dim GroupingColName As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
        GroupingColName.DropdownGroupingColumn = "IsExternal"
        'GroupingColName.ConnectionString = "usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID
        GroupingColName.WidthInPixel = 150
        GroupingColName.ReturnHTML = True
        GroupingColName.IsMandatory = True
        GroupingColName.InsertBlankRow = True
        GroupingColName.MatchFieldID = CommonFunction.General.CheckIsNothing(strReportingTo, "0")
        'strHeaderFooter.Append(CommonFunctions.HTMLControls.DrawComboBox("ReportingTo", "usp_sel_tbl_PM_RowWiseExternalApprovers " + CStr(HttpContext.Current.Session("intProjectId")), , strReportingTo, , , True, , True))
        strHeaderFooter.Append(CommonFunctions.HTMLControls.DrawComboBox("ReportingTo", "usp_sel_tbl_PM_RowWiseExternalApprovers " + CStr(HttpContext.Current.Session("intProjectId")), GroupingColName))
            strHeaderFooter.Append("</td>")
            strHeaderFooter.Append("<TD align='LEFT'></TD>")
            strHeaderFooter.Append("<TD align='left'>")
            strHeaderFooter.Append("</TD>")
        strHeaderFooter.Append("</TR>")

        strHeaderFooter.Append("<TR align='Left' class='clsTRPageFilters'>")
        strHeaderFooter.Append("<TD align='right'>Status</TD>")
        strHeaderFooter.Append("<td align='left'>")
        strHeaderFooter.Append(CommonFunctions.HTMLControls.DrawComboBox("ResourceStatus", "usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable ", 150, strResourceStatus, , , True, , True))
        strHeaderFooter.Append("</td>")
        ''Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
        strHeaderFooter.Append("<TD align='right'>Billable</TD>")
        strHeaderFooter.Append("<td align='left'>")
        strHeaderFooter.Append(CommonFunction.HTMLControls.DrawCheckBox("chkBillable", "chkBillable", , False, chkBillable, , , True))
        strHeaderFooter.Append("</td>")
            ''End of Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
            strHeaderFooter.Append("<TD align='LEFT'></TD>")
            strHeaderFooter.Append("<TD align='left'>")
            strHeaderFooter.Append("</TD>")
        strHeaderFooter.Append("</TR>")
        strHeaderFooter.Append("<tr class='clsTRPageCaption'><td colspan='8'  style='text-align:center;' width=25% height=15%>")
        strHeaderFooter.Append("<input class=ButtonStyle style='width:120' type=button id=btnApply onclick='Allocate_OnClick()' value=""Allocate Resources"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        strHeaderFooter.Append("</TR>")
        strHeaderFooter.Append("</TABLE>")

        Args.HeaderFooter = strHeaderFooter.ToString
        End If

    End Sub

    Private Sub SaveAndAllocate()
        Dim strSQL As String
        ''Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
        Dim ischeck As Boolean
        ischeck = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IsBillable"))
        ''End of Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes

        strSQL = " usp_ins_BulkResourceAllocation " + CType(HttpContext.Current.Session("intProjectID"), String) + ", "
        strSQL = strSQL + "NULL, "
        strSQL = strSQL + "NULL, "
        strSQL = strSQL + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("AllocationRole")) + ", "
        strSQL = strSQL + "0, "
        strSQL = strSQL + "'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedStartDate")) + "',"
        strSQL = strSQL + "'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedEndDate")) + "',"
        strSQL = strSQL + "NULL, "
        strSQL = strSQL + "'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("ResourceStatus")) + "',"
        ''Commented and Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
        'strSQL = strSQL + "0, 
        If ischeck = True Then
            strSQL = strSQL + "1, "
        Else
            strSQL = strSQL + "0, "
        End If

        ''End of Commented and Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
        strSQL = strSQL + "NULL, "
        strSQL = strSQL + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("ReportingTo")) + ","
        strSQL = strSQL + "0, "
        strSQL = strSQL + "'" + m_strSelected + "',"
        ''Added By Vidya Jadhav ON 5 Aug 2017 For Bulk Resource Allocation Issue Fixing
        strSQL = strSQL + "'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("ResourcePercentage")) + "'"
        ''End Of Added By Vidya Jadhav ON 5 Aug 2017 For Bulk Resource Allocation Issue Fixing
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        'Added by SonalD on 24th sept 2008
        m_refreshParent = 1
        'End of addition 
    End Sub

End Class


Public Class c_BulkAllocation_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Protected strfilterParameter As String = ""

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ' Added By PiyushB for Project Profitability Functionality changes
        strfilterParameter = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "").ToString()
        If strfilterParameter = "" Then
            strfilterParameter = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("hidPTagID"), "").ToString()
        End If
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFilterParameter", "txtFilterParameter", value:=strfilterParameter, ReturnHTML:=True, Ishidden:=True))

        If strfilterParameter <> "1019" Then
            If Args.DataField.ToUpper = "COSTPERHOUR" Then
                Cancel = True
            End If
        End If
        ' End Added By PiyushB for Project Profitability Functionality changes

        ''Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
        If Args.DataField.ToUpper = "STARTDATE" Then
            Cancel = True
        End If


        If Args.DataField.ToUpper = "ENDDATE" Then
            Cancel = True
        End If
         
        ''End Of Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ' Added By PiyushB for Project Profitability Functionality changes
        strfilterParameter = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "").ToString()
        If strfilterParameter = "" Then
            strfilterParameter = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("hidPTagID"), "").ToString()
        End If
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFilterParameter", "txtFilterParameter", value:=strfilterParameter, ReturnHTML:=True, Ishidden:=True))

        If strfilterParameter <> "1019" Then
            If Args.DataField.ToUpper = "COSTPERHOUR" Then
                Cancel = True
            End If
        End If
        ' End Added By PiyushB for Project Profitability Functionality changes



        If Args.DataField.ToUpper = "STARTDATE" Then
            Cancel = True
        End If
    


        If Args.DataField.ToUpper = "ENDDATE" Then
            Cancel = True
        End If

        If Args.DataField.ToUpper = "RESOURCEPERCENTAGE" Then
            Cancel = True
            Dim ResourcePercentage As String = CType(Args.DataReader("ResourcePercentage"), String)
            Args.StringToBeInserted = "<TD align=left Title='Available Resource %'>"
            Args.StringToBeInserted += "<A href=""javascript:Percentage_OnClick('" & Args.DataReader("EmployeeID") & "')"">"

            Args.StringToBeInserted += CType(Args.DataReader("ResourcePercentage"), String) + "</A>"
            Args.StringToBeInserted += "</TD>"
        End If


        Dim strCheckBox As String
        Dim strSelected As String
        Dim intLoopCounter As Integer
        strSelected = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("hidSelected"))
        If Args.ColumnName.ToUpper = "SELECT" Then
            Dim flg_Selected As Boolean = False
            Dim strArray As String() = strSelected.Split(",")
            For intLoopCounter = 0 To strArray.Length() - 1
                If strArray(intLoopCounter) <> "" Then
                    If CInt(Args.DataReader.Item("EmployeeId")) = CInt(strArray(intLoopCounter)) Then
                        Cancel = True
                        flg_Selected = True
                        CommonFunction.General.CheckIsNothing(CommonFunctions.General.FormatString(CType(Args.DataReader("UserName"), String), True), "").Replace("'", "''")
                        'Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkDelete' id='chkDelete' class='clsCheckBox' value='" + CStr(Args.DataReader.Item("EmployeeId")) + "' onclick='Javascript:chkDelete_Onclick(" + CStr(Args.DataReader.Item("EmployeeId")) + ",""" + CStr(Args.DataReader.Item("UserName")) + "::" + CStr(Args.DataReader.Item("JoiningDate")) + "::" + CStr(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TentativeDateOfRelieving"))) + """ )'  checked ></td>"
                        Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkDelete' id='chkDelete' class='clsCheckBox' value='" + CStr(Args.DataReader.Item("EmployeeId")) + "' onclick='Javascript:chkDelete_Onclick(" + CStr(Args.DataReader.Item("EmployeeId")) + ",""" + CommonFunction.General.CheckIsNothing(CommonFunctions.General.FormatString(CType(Args.DataReader("UserName"), String), True), "").Replace("'", "''") + "::" + CStr(Args.DataReader.Item("JoiningDate")) + "::" + CStr(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TentativeDateOfRelieving"))) + """ )'  checked ></td>"
                    End If
                End If
            Next
            If (flg_Selected = False) Then
                Cancel = True
                Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkDelete' id='chkDelete' class='clsCheckBox' value='" + CStr(Args.DataReader.Item("EmployeeId")) + "' onclick='Javascript:chkDelete_Onclick(" + CStr(Args.DataReader.Item("EmployeeId")) + ",""" + CommonFunction.General.CheckIsNothing(CommonFunctions.General.FormatString(CType(Args.DataReader("UserName"), String), True), "").Replace("'", "''") + "::" + CStr(Args.DataReader.Item("JoiningDate")) + "::" + CStr(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TentativeDateOfRelieving"))) + """ )' ></td>"
            End If

            Args.StringToBeInserted = Args.StringToBeInserted + CommonFunctions.HTMLControls.DrawCheckBox("hidResource_Details", "hidResource_Details", , False, CommonFunction.General.CheckIsNothing(CommonFunctions.General.FormatString(CType(Args.DataReader("UserName"), String), True), "").Replace("'", "''") + "::" + CType(Args.DataReader.Item("JoiningDate"), String) + "::" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TentativeDateOfRelieving")), String), , , True, , , , True)
        End If
    End Sub

End Class

Public Class cBulkAllocation_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

   

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String

        Dim m_lngTagID As Long
        m_lngTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Long)
        If m_lngTagID = 0 Then
            m_lngTagID = CType(HttpContext.Current.Request.Form("hidPTagID"), Long)
        End If

        If m_lngTagID = CommonFunction.Constants.APP_TAG_RESOURCES Then
            GetPageSpecificFilters &= " AND EmployeeID Not in (SELECT EmployeeID From tbl_PM_ProjectEmployeeRole Where ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String) + ")"
        ElseIf m_lngTagID = CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS Then
            Dim m_intResourceID As Integer

            Dim strSQLEmpId As String
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            '' strSQLEmpId = "Select EmployeeId from tbl_PM_Employee_ResourceFullControlUsers where EmployeeId=" & objGlobal.UserID
            strSQLEmpId = "usp_sel_tbl_PM_Employee_ResourceFullControlUsers_EmployeeId " & objGlobal.UserID
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal

            m_intResourceID = CType(CommonFunctions.Data.GetDataScalar(strSQLEmpId, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)

            If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(m_intResourceID, "0"), "0").ToString, Integer) = 0 And (CType(CommonFunction.General.CheckIsNothing(objGlobal.RoleID, "0").ToString(), Integer) <> 7) Then
                GetPageSpecificFilters = " AND ReportingTo = " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
            End If
        End If
    End Function

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
        Dim RoleDescription As String
        Dim Designationname As String
        Dim Department As String
        Dim BusinessGroup As String
        Dim Location As String
        Dim EmployeeName As String
        Dim ExpectedStartDate As String
        Dim ExpectedEndDate As String
        Dim ResourcePercentage As String

        ''Added By Vidya Jadhav ON 14 Dec 2016 For Employee Filter Persists
        Dim m_lngEmployeeID = HttpContext.Current.Session("intUserID")
        Dim m_strLoginType = HttpContext.Current.Session("LoginType")
        ''End Of Added By Vidya Jadhav ON 14 Dec 2016 For Employee Filter Persists

        'Added By Vidya Jadhav ON 14 Dec 2016 For Employee Filter Persists
        'strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3873, " & m_lngEmployeeID & ",'BusinessGroup','" & m_strLoginType & "'"
        'BusinessGroup = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")

        'strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3873, " & m_lngEmployeeID & ",'HiringManager','" & m_strLoginType & "'"
        'HiringManager = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")

        
        'strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3873, " & m_lngEmployeeID & ",'CustomerName','" & m_strLoginType & "'"
        'CustomerName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")

        'strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3873, " & m_lngEmployeeID & ",'CandidateName','" & m_strLoginType & "'"
        'CandidateName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        ''End Of Added By Vidya Jadhav ON 14 Dec 2016 For Employee Filter Persists



        
        RoleDescription = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RoleDescription"), "")
        Designationname = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Designationname"), "")
        Department = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Department"), "")
        BusinessGroup = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroup"), "")
        Location = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Location"), "")
        EmployeeName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeName"), "")
        ExpectedStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedStartDate"), "")
        ExpectedEndDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedEndDate"), "")
        ResourcePercentage = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePercentage"), "")
        If ResourcePercentage = "" Then
            ResourcePercentage = "null"
        End If

        If RoleDescription = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'RoleDescription','" & m_strLoginType & "'"
            RoleDescription = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")

        End If

        If Designationname = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Designationname','" & m_strLoginType & "'"
            Designationname = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If Department = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Department','" & m_strLoginType & "'"
            Department = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If


        If BusinessGroup = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'BusinessGroup','" & m_strLoginType & "'"
            BusinessGroup = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If Location = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Location','" & m_strLoginType & "'"
            Location = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If EmployeeName = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'EmployeeName','" & m_strLoginType & "'"
            EmployeeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If ExpectedStartDate = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedStartDate','" & m_strLoginType & "'"
            ExpectedStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If
        'Dim ArrExpectedStartDate As Array
        'If ExpectedStartDate <> "" Then
        '    ArrExpectedStartDate = ExpectedStartDate.Split("_")
        '    Dim ProjectIDToCheck As String
        '    ProjectIDToCheck = ArrExpectedStartDate(1)
        '    If ProjectIDToCheck = HttpContext.Current.Session("intProjectId") Then
        '        ExpectedStartDate = ArrExpectedStartDate(0)
        '    Else
        '        ExpectedStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedStartDate"), "")
        '    End If
        'End If

        If ExpectedEndDate = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedEndDate','" & m_strLoginType & "'"
            ExpectedEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        'Dim ArrExpectedEndDate As Array
        'If ExpectedEndDate <> "" Then
        '    ArrExpectedEndDate = ExpectedEndDate.Split("_")
        '    Dim ProjectIDToCheck1 As String
        '    ProjectIDToCheck1 = ArrExpectedEndDate(1)
        '    If ProjectIDToCheck1 = HttpContext.Current.Session("intProjectId") Then
        '        ExpectedEndDate = ArrExpectedEndDate(0)
        '    Else
        '        ExpectedStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedStartDate"), "")
        '    End If
        'End If

        If ResourcePercentage = "null" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ResourcePercentage','" & m_strLoginType & "'"
            ResourcePercentage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If ResourcePercentage = "" Then
            ResourcePercentage = "null"
        End If

        Args.GridSQL = "usp_SEL_Calculate_ResourceAvailable_Percentage " & CType(HttpContext.Current.Session("intProjectID"), Long) & ",'" & RoleDescription & "','" & Designationname & "','" & Department & "','" & BusinessGroup & "','" & Location & "','" & EmployeeName & "','" & ExpectedStartDate & "','" & ExpectedEndDate & "'," & ResourcePercentage & ""
        ''End Of Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
    End Sub

End Class

Public Class cBulkAllocation_CommonListDynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
        Dim RoleDescription As String
        Dim Designationname As String
        Dim Department As String
        Dim BusinessGroup As String
        Dim Location As String
        Dim EmployeeName As String
        Dim ExpectedStartDate As String
        Dim ExpectedEndDate As String
        Dim ResourcePercentage As String
        Dim dtmProjectStartDate As String
        Dim dtmProjectEndDate As String
        Dim m_lngEmployeeID As Integer
        Dim m_strLoginType As String

        ''Added By Vidya Jadhav ON 14 Dec 2016 For Employee Filter Persists
        m_lngEmployeeID = HttpContext.Current.Session("intUserID")
        m_strLoginType = HttpContext.Current.Session("LoginType")
        ''End Of Added By Vidya Jadhav ON 14 Dec 2016 For Employee Filter Persists

        RoleDescription = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RoleDescription"), "")
        Designationname = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Designationname"), "")
        Department = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Department"), "")
        BusinessGroup = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroup"), "")
        Location = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Location"), "")
        EmployeeName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeName"), "")
        ExpectedStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedStartDate"), "")
        ExpectedEndDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpectedEndDate"), "")
        ResourcePercentage = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePercentage"), "")



        ' End Date
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedEndDate"), "").ToString() = "" Then
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            '' dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("SELECT  CASE WHEN DATEDIFF(dd, ExpectedEndDate, Getdate()) <= 0 THEN convert(varchar(20), ExpectedEndDate,106) ELSE '' END FROM tbl_PM_Project Where Projectid = " + CStr(HttpContext.Current.Session("intProjectId")), True), String))
            dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ExpectedEndDate_HR " + CStr(HttpContext.Current.Session("intProjectId")), True), String))
            ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        Else
            dtmProjectEndDate = HttpContext.Current.Request.Form("ExpectedEndDate")
        End If

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedStartDate"), "").ToString() = "" Then
            dtmProjectStartDate = CommonFunction.Dates.GetDate(Now())
        Else
            dtmProjectStartDate = HttpContext.Current.Request.Form("ExpectedStartDate")
        End If


        If RoleDescription = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'RoleDescription','" & m_strLoginType & "'"
            RoleDescription = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")

        End If

        If Designationname = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Designationname','" & m_strLoginType & "'"
            Designationname = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If Department = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Department','" & m_strLoginType & "'"
            Department = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If


        If BusinessGroup = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'BusinessGroup','" & m_strLoginType & "'"
            BusinessGroup = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If Location = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'Location','" & m_strLoginType & "'"
            Location = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If EmployeeName = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'EmployeeName','" & m_strLoginType & "'"
            EmployeeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

        If dtmProjectStartDate = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedStartDate','" & m_strLoginType & "'"
            dtmProjectStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If


        'Dim ArrExpectedStartDate As Array
        'If dtmProjectStartDate <> "" Then
        '    ArrExpectedStartDate = dtmProjectStartDate.Split("_")
        '    Dim ProjectIDToCheck1 As String
        '    ProjectIDToCheck1 = ArrExpectedStartDate(1)
        '    If ProjectIDToCheck1 = HttpContext.Current.Session("intProjectId") Then
        '        dtmProjectEndDate = ArrExpectedStartDate(0)
        '    Else

        '        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedStartDate"), "").ToString() = "" Then
        '            dtmProjectStartDate = CommonFunction.Dates.GetDate(Now())
        '        Else
        '            dtmProjectStartDate = HttpContext.Current.Request.Form("ExpectedStartDate")
        '        End If

        '    End If
        'Else
        '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedStartDate"), "").ToString() = "" Then
        '        dtmProjectStartDate = CommonFunction.Dates.GetDate(Now())
        '    Else
        '        dtmProjectStartDate = HttpContext.Current.Request.Form("ExpectedStartDate")
        '    End If
        'End If

        If dtmProjectEndDate = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ExpectedEndDate','" & m_strLoginType & "'"
            dtmProjectEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If
         
        'Dim ArrExpectedEndDate As Array
        'If dtmProjectEndDate <> "" Then
        '    ArrExpectedEndDate = dtmProjectEndDate.Split("_")
        '    Dim ProjectIDToCheck As String
        '    ProjectIDToCheck = ArrExpectedEndDate(1)
        '    If ProjectIDToCheck = HttpContext.Current.Session("intProjectId") Then
        '        dtmProjectEndDate = ArrExpectedEndDate(0)
        '    Else
        '        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedEndDate"), "").ToString() = "" Then
        '            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '            '' dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("SELECT  CASE WHEN DATEDIFF(dd, ExpectedEndDate, Getdate()) <= 0 THEN convert(varchar(20), ExpectedEndDate,106) ELSE '' END FROM tbl_PM_Project Where Projectid = " + CStr(HttpContext.Current.Session("intProjectId")), True), String))
        '            dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ExpectedEndDate_HR " + CStr(HttpContext.Current.Session("intProjectId")), True), String))
        '            ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '        Else
        '            dtmProjectEndDate = HttpContext.Current.Request.Form("ExpectedEndDate")
        '        End If
        '    End If
        'Else
        '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ExpectedEndDate"), "").ToString() = "" Then
        '        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '        '' dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("SELECT  CASE WHEN DATEDIFF(dd, ExpectedEndDate, Getdate()) <= 0 THEN convert(varchar(20), ExpectedEndDate,106) ELSE '' END FROM tbl_PM_Project Where Projectid = " + CStr(HttpContext.Current.Session("intProjectId")), True), String))
        '        dtmProjectEndDate = CommonFunctions.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ExpectedEndDate_HR " + CStr(HttpContext.Current.Session("intProjectId")), True), String))
        '        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '    Else
        '        dtmProjectEndDate = HttpContext.Current.Request.Form("ExpectedEndDate")
        '    End If
        'End If
        ''End Of Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing



        If ResourcePercentage = "" Then
            Dim strSQLQuery = "USP_SEL_TBL_UI_EMPLOYEEfILTERSETTINGS_Employee  3968, " & m_lngEmployeeID & ",'ResourcePercentage','" & m_strLoginType & "'"
            ResourcePercentage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")
        End If

         
        Dim strSQL As String = ""
        Dim RoleFilterValue As String = ""
        Dim lngControlTagID As Long
        'CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>1.Search Resources </TD></TR></TABLE>")
        ''Commented By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
        If Args.FilterName.ToUpper = "ROLEDESCRIPTION" Then
            '   Args.ToBeInserted = "<TD align=Left colspan=6><b>1. Search Resources</b></TD></TR><Br><TR align=Left class='clsTRPageFilters'>"
            Args.ToBeInserted = "</TR><TR align=Left class='clsTRPageCaption'><TD align=Left colspan=6><b>1. Search Available Resources</b></TD></TR></TABLE><BR><TABLE id='tblFilter03968' CellSpacing=0 BORDER=0 class='clsTable' width='100%'><TR align=Left class='clsTRPageFilters'>"
        End If
        ''End of Commented By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
        'CommonFunction.General.WriteHTML("<TR align='Left' class='clsTRPageFilters'>")
        'CommonFunction.General.WriteHTML("<TD align='right'>Start Date</TD>")

        ''Commented By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing
        'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SetFilter"), "") <> "1" And _
        '    Args.FilterName.ToUpper = "ROLEDESCRIPTION" And ((CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Long) = CommonFunction.Constants.APP_TAG_RESOURCES) Or (CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Long) = CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS)) Then

        '    'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RoleID"), "") <> "" Then
        '    ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '    '' strSQL = "SELECT top 1 RoleDescription from tbl_PM_Role WHERE IsUserGroup=0 ORDER BY RoleDescription"
        '    strSQL = "usp_sel_RoleDescription_tbl_PM_Role_HR"
        '    ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '    RoleFilterValue = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), ""), String)
        '    'End If

        '    Args.FixedValue = RoleFilterValue

        '    strSQL = ""
        '    ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '    ''strSQL = "SELECT ControlTagID FROM tbl_UI_ControlTagMaster Where ControlName='RoleDescription' AND TagID=" & WhizGlobal.TagID.ToString
        '    strSQL = "usp_sel_tbl_UI_ControlTagMaster_ControlTagID " & WhizGlobal.TagID.ToString
        '    ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '    lngControlTagID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"), Long)

        '    strSQL = ""
        '    If RoleFilterValue <> "" Then
        '        strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString + "," + lngControlTagID.ToString + ",'RoleDescription','Role','F','" + CommonFunction.General.BuildQueryString(RoleFilterValue) + "','" + CommonFunction.General.BuildQueryString(RoleFilterValue) + "'"
        '    Else
        '        strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString + "," + lngControlTagID.ToString + ",'RoleDescription','Role','F',NULL,NULL"
        '    End If
        '    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        '    strSQL = ""
        '    strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString
        '    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        'End If
        ''End of Commented By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing

        ''Added By Vidya Jadhav ON 3 Aug 2017 For Bulk Resource Allocation Issue Fixing

        If Args.FilterName.ToUpper = "ROLEDESCRIPTION" Then
            ' Cancel = True
            Dim strHTML11 As String = ""
            'strSQL = "select RoleDescription from tbl_PM_Role WHERE IsUserGroup = 0 Order by 1"
            strSQL = "usp_Sel_BulkAllocation_RoleDescription"
            ' Args.ToBeInserted = "</TR><TR align=Left class='clsTRPageCaption'><TD align=Left colspan=6><b>1. Search Resources</b></TD></TR></TABLE><BR><TABLE id='tblFilter03968' CellSpacing=0 BORDER=0 class='clsTable' width='100%'><TR align=Left class='clsTRPageCaption'><TD align=Left colspan=6><b>1. Search Resources</b></TD></TR><TR align=Left class='clsTRPageFilters'>"
            Args.ToBeInserted += "<td align='right'>Role</td><td>"
            '' strHTML = CommonFunctions.HTMLControls.DrawComboBox("Designationname", "select department from tbl_PM_DepartmentMaster ")
            strHTML11 = CommonFunctions.HTMLControls.DrawComboBox("RoleDescription", strSQL, 140, RoleDescription, " ", True, True)
            Args.ToBeInserted += strHTML11
            Args.ToBeInserted += "</td>"
        End If

        If Args.FilterName.ToUpper = "DESIGNATIONNAME" Then
            Cancel = True
            Dim strHTML As String = ""
            Args.ToBeInserted = "<td align='right'>Designation</td><td>"
            '' strHTML = CommonFunctions.HTMLControls.DrawComboBox("Designationname", "select department from tbl_PM_DepartmentMaster ")
            strHTML = CommonFunctions.HTMLControls.DrawComboBox("Designationname", "usp_Sel_BulkAllocation_DesignationName", 140, Designationname, " ", True, True)
            Args.ToBeInserted += strHTML
            Args.ToBeInserted += "</td>"
        End If

        If Args.FilterName.ToUpper = "DEPARTMENT" Then
            Cancel = True
            Dim strHTML1 As String = ""
            Args.ToBeInserted = "<td align='right'>Department</td><td>"
            '  strHTML1 = CommonFunctions.HTMLControls.DrawComboBox("Department", "select department from tbl_PM_DepartmentMaster ")
            strHTML1 = CommonFunctions.HTMLControls.DrawComboBox("Department", "usp_Sel_BulkAllocation_Department", 140, Department, " ", True, True)
            Args.ToBeInserted += strHTML1
            Args.ToBeInserted += "</td></tr>"
        End If

        If Args.FilterName.ToUpper = "BUSINESSGROUP" Then
            Cancel = True
            Dim strHTML2 As String = ""
            Args.ToBeInserted = "<tr><td align='right'>Business Group</td><td>"
            '' Args.
            'strHTML2 = CommonFunctions.HTMLControls.DrawComboBox("BusinessGroup", "SELECT BusinessGroup FROM tbl_CNF_BusinessGroups Order by 1")
            strHTML2 = CommonFunctions.HTMLControls.DrawComboBox("BusinessGroup", "SELECT BusinessGroup FROM tbl_CNF_BusinessGroups Order by 1 ", 140, BusinessGroup, "", True, True)
            Args.ToBeInserted += strHTML2
            Args.ToBeInserted += "</td>"
        End If


        If Args.FilterName.ToUpper = "LOCATION" Then
            Cancel = True
            Dim strHTML3 As String = ""
            Args.ToBeInserted = "<td align='right'>Organization Unit</td><td>"
            'strHTML3 = CommonFunctions.HTMLControls.DrawComboBox("Location", "select Location from tbl_PM_Location Order By Location")
            strHTML3 = CommonFunctions.HTMLControls.DrawComboBox("Location", "select Location from tbl_PM_Location Order By Location ", 140, Location, "", True, True)
            Args.ToBeInserted += strHTML3
            Args.ToBeInserted += "</td>"
        End If

        If Args.FilterName.ToUpper = "EMPLOYEENAME" Then
            Cancel = True
            Dim strHTML4 As String = ""
            Args.ToBeInserted = "<td align='right'>Employee Name</td><td>"
            'strHTML = CommonFunctions.HTMLControls.DrawTextBox("EmployeeName", "select Location from tbl_PM_Location Order By Location")
            strHTML4 = CommonFunctions.HTMLControls.DrawTextBox("EmployeeName", "EmployeeName", , 140, 30, EmployeeName, , , , , , , "", True, , , , , , True)
            Args.ToBeInserted += strHTML4
            Args.ToBeInserted += "</td></tr>"
        End If

        If Args.FilterName.ToUpper = "STARTDATE" Then
            Cancel = True
            Dim strHTML5 As String = ""

            Args.ToBeInserted = "<tr><td align='right'>Start Date</td><td>"

            strHTML5 = CommonFunctions.HTMLControls.DrawDateControl("ExpectedStartDate", "ExpectedStartDate", , , dtmProjectStartDate, , "frmCommonList", , , , , , , True, True)
            '   strHTML1 = CommonFunctions.HTMLControls.DrawDateControl("ExpectedEndDate", "ExpectedEndDate", , , , , "frmCommonList", , , , , , , True, True)

            Args.ToBeInserted += strHTML5
            '  Args.ToBeInserted += "<td>|<a href='javascript:applyFilter()' title='Show' style='padding-top:14px'>Search Resources</a>|</td> "
            Args.ToBeInserted += "</td>"
        End If


        If Args.FilterName.ToUpper = "ENDDATE" Then
            Cancel = True
            Dim strHTML6 As String = ""

            Args.ToBeInserted = "<td align='right'>End Date</td><td>"

            strHTML6 = CommonFunctions.HTMLControls.DrawDateControl("ExpectedEndDate", "ExpectedEndDate", , , dtmProjectEndDate, , "frmCommonList", , , , , , , True, True)
            '   strHTML1 = CommonFunctions.HTMLControls.DrawDateControl("ExpectedEndDate", "ExpectedEndDate", , , , , "frmCommonList", , , , , , , True, True)

            Args.ToBeInserted += strHTML6
            '  Args.ToBeInserted += "<td>|<a href='javascript:applyFilter()' title='Show' style='padding-top:14px'>Search Resources</a>|</td> "
            Args.ToBeInserted += "</td>"
        End If


        If Args.FilterName.ToUpper = "RESOURCEPERCENTAGE" Then
            Cancel = True
            Dim strHTML7 As String = ""

            Args.ToBeInserted = "<td align='right'>Resource Percentage</td><td>"

            strHTML7 = CommonFunctions.HTMLControls.DrawTextBox("ResourcePercentage", "ResourcePercentage", , 140, 30, ResourcePercentage, , , , , , , "", True, , , , , , True)

            Args.ToBeInserted += strHTML7
            Args.ToBeInserted += "<td>| <a href='javascript:applyFilter()' title='Show' style='padding-top:14px'>Search Resources</a> |</td> "
            Args.ToBeInserted += "</td></tr>"
        End If
        'strHeaderFooter.Append("<TD align='right'>Start Date</TD>")
        'strHeaderFooter.Append("<TD align='left'>")
        'strHeaderFooter.Append(CommonFunctions.HTMLControls.DrawDateControl("ExpectedStartDate", "ExpectedStartDate", , , dtmProjectStartDate, , "frmCommonList", , , , , , , True, True))
        'strHeaderFooter.Append("</TD>")
        ' strHeaderFooter.Append("<TD align='right'>End Date</TD>")
        'strHeaderFooter.Append("<TD align='left'>")
        ' strHeaderFooter.Append(CommonFunctions.HTMLControls.DrawDateControl("ExpectedEndDate", "ExpectedEndDate", , , dtmProjectEndDate, , "frmCommonList", , , , , , , True, True))
        ' strHeaderFooter.Append("</TD>")

    End Sub
    Protected Overrides Sub Initialize_Filters(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFiltersTable, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub


End Class
'Public Class BulkAllocation_CommonListCLSQL
'    Inherits CommonEngine.CommonList.cCLSQL

'    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New(objGlobal)
'    End Sub
'    'Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
'    '    MyBase.Initialize_GridSQL(Cancel, Args, WhizGlobal)
'    '    Args.GridSQL = "usp_sel_calculate_per_alloc11 '1-aug-2017','31-aug-2017'"

'    'End Sub

'    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Args.GridSQL = "usp_SEL_Calculate_Available_Percentage '1-aug-2017','31-aug-2017'"


'    End Sub
'End Class
