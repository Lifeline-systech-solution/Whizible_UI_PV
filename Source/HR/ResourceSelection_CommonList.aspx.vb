Imports System
Imports CommonEngines.General.cEventHandlers
Imports System.Reflection

Public Class ResourceSelection_CommonList
    Inherits CommonList

    Protected m_lngTagID As Long
    Protected m_FromWhere As String
    Protected m_OnBehalf As String
    'Addition done by SuchitraP on 15 Oct 2007
    Protected m_SettingValueResAll As String
    'End of Addition done by SuchitraP on 15 Oct 2007


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
        ''Added By Vaijat K ON 19/04/2017 For XSS And Sql Injection
        For intCount As Integer = 0 To HttpContext.Current.Request.Form.Count - 1
            Dim strKey As String = HttpContext.Current.Request.Form.GetKey(intCount)


            'Dim strValue As String = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.Get(intCount))
            Dim strValue As String = HttpContext.Current.Request.Form.Get(intCount)
            If strValue = Nothing Then strValue = ""
            If strKey = Nothing Then Continue For

            If HttpContext.Current.Request.Form.GetValues(strKey).Length = 1 Then
                'Check apply security parameter of this function and application level settings (ApplyWebSecurity)
                If strKey <> "_VIEWSTATE" And strKey <> "__VIEWSTATEENCRYPTED" And strKey <> "__VIEWSTATE" Then
                    If CommonFunctions.General.GetApplicationKeySetting("ApplyWebSecurity") = "Y" Then


                        Dim FormCollection = System.Web.HttpContext.Current.Request.Form
                        Dim propInfo = FormCollection.[GetType]().GetProperty("IsReadOnly", BindingFlags.Instance Or BindingFlags.NonPublic)
                        propInfo.SetValue(FormCollection, False, New Object() {})
                        'changes in form collection 
                        FormCollection(strKey) = HttpUtility.HtmlEncode(Utilities.Security.SecurityBuilder.CheckUserInput(strValue, 2, True, True, True))
                        ' m_htFormsCollection.Add(strKey, Utilities.Security.SecurityBuilder.CheckUserInput(strValue, SecurityLevel, ApplySQLKeyWordSecurity, ApplyPortSecurity, ApplyPatternSecurity))

                    End If
                End If
            End If



        Next
        ''End Added By Vaijat K ON 19/04/2017 For XSS And Sql Injection
        MyBase.strListPage = "ResourceSelection_CommonList.aspx"
        'Commented and by Yogesh J on 28-Oct-2015
        'MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strFormPage = "ResourceSelection_CommonPage.aspx"
        'End of Addition by Yogesh J on 28-Oct-2015
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"


        m_lngTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Long)
        'Added by ShraddhaM on 28,Nov 2007 for SoftBooking Resource selection
        If m_lngTagID = 0 Then
            m_lngTagID = CType(Request.Form("hidPTagID"), Long)
        End If
        'End of addition by ShraddhaM on 28,Nov 2007 for SoftBooking Resource selection
        'Added by ShraddhaM on 23, July 2007 for CleanUp Activity
        'To Remove AssignTo Combo from HelpDesk Filters
        m_FromWhere = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "0"), String)
        If m_FromWhere = "0" Then
            m_FromWhere = Request.Form("hidFromWhere")
        End If
        'End of addition by ShraddhaM on 23, July 2007 for CleanUp Activity

        'Addition done by SuchitraP on 15 Oct 2007
        If m_lngTagID = CommonFunction.Constants.APP_TAG_RESOURCES Then
            m_SettingValueResAll = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_ResAllocation_SettingValue", True), String)
            If CType(m_SettingValueResAll, Double) = 0 Then
                m_SettingValueResAll = "100"
            End If
        End If
        'End of addition by SuchitraP on 15 Oct 2007

        m_OnBehalf = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("For"), ""), String)
        If m_OnBehalf = "" Then
            m_OnBehalf = Request.Form("hidOnBehalf")
        End If

        MyBase.Page_Load(sender, e)

        ' -------------------------------
        'Added by Dhanashri Samudra ON 3rd April 2014
        'Purpose:To get the EmployeeID of respective Project from current page

        Dim strsql As String = ""
        Dim intProjectID As Integer
        intProjectID = HttpContext.Current.Session("intProjectID")

        Dim strFromWhere As String = ""
        Dim strAction As String = ""
        Dim strTagID As String = ""
        Dim dsIds As DataSet

        strFromWhere = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"))
        strAction = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"))
        strTagID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagID"))

        If strTagID = "1019" And strFromWhere = "NRA" And strAction = "VAL" Then
            Try
                Dim strQuery As String = ""
                Dim strMessage As String = ""
                Dim strUnitID As String = ""

                If Request.QueryString("EmployeeID").ToString <> "" Then
                    Dim EmployeeID As String = Request.QueryString("EmployeeID").ToString()

                    strQuery = "usp_upd_tbl_PM_ProjectEmployeeRole_ProjectWiseResource " & intProjectID.ToString

                    strMessage = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), ""), "")

                    Response.Clear()
                    Response.Write(strMessage)
                    Response.End()
                End If
            Catch ex As Exception
            End Try
        End If

        'End of Addition by Dhanashri Samudra ON 3rd April 2014
        ' ------------------------------


    End Sub




    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New c_ResourceSelection_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cResourceSelection_CommonListSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cResourceSelection_CommonListDynamicFilters(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        'Added by ShraddhaM on 24, July 2007 to Store Query String value in hidden control so that we can use it while filters applied..
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidFromWhere' value=" + m_FromWhere + ">")
        'End of Addition by ShraddhaM on 24, July 2007 
        'Added by ShraddhaM on 28,Nov 2007 for SoftBooking Resource selection
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidPTagID' value=" + CType(m_lngTagID, String) + ">")
        'End of addition by ShraddhaM on 28,Nov 2007 for SoftBooking Resource selection
        'Added by ShraddhaM for Helpdesk on Behalf of employee and Customer on 15,Oct 2009
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidOnBehalf' value='" + m_OnBehalf + "'>")
        'Ended by ShraddhaM for Helpdesk on Behalf of employee and Customer on 15,Oct 2009
    End Function

End Class


Public Class c_ResourceSelection_CommonListPlotGrid
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

        'If strfilterParameter <> "1019" Then
        If Args.DataField.ToUpper = "COSTPERHOUR" Then
            Cancel = True
        End If
        'End If
        ' End Added By PiyushB for Project Profitability Functionality changes
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "USERNAME" Then
            Cancel = True

            Dim m_FromWhere As String
            m_FromWhere = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "0"), String)
            If m_FromWhere = "0" Then
                m_FromWhere = HttpContext.Current.Request.Form("hidFromWhere")
            End If
            Dim m_lngTagID As Long
            m_lngTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Long)
            'Added by ShraddhaM on 28,Nov 2007 for SoftBooking Resource selection
            If m_lngTagID = 0 Then
                m_lngTagID = CType(HttpContext.Current.Request.Form("hidPTagID"), Long)
            End If

            Args.StringToBeInserted = "<TD align=left Title='User Name'>"
            If m_FromWhere.ToUpper() = "CRMFILTERS" Or m_FromWhere.ToUpper() = "RM" Then
                Args.StringToBeInserted += "<A href=""JavaScript:EmployeeName_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + CommonFunction.General.CheckIsNothing(CommonFunctions.General.FormatString(CType(Args.DataReader("UserName"), String), True), "").Replace("&#39;", "\'") + "','" + CType(Args.DataReader("ResourcePercentage"), String) + "','" + CType(CommonFunctions.Dates.GetDate(CType(Args.DataReader("JoiningDate"), Date)), String) + "'," + m_lngTagID.ToString + ",'" + CommonFunction.General.CheckIsNothing(CommonFunctions.General.FormatString(CType(Args.DataReader("Address"), String), True), "").Replace("&#39;", "\'") + "','" + CType(Args.DataReader("Phone"), String) + "')"">"

                ' Added By NitinVS on 8 SEP 2008 for Project Profitability 
            ElseIf m_lngTagID = 3949 Then
                Args.StringToBeInserted += "<a href=""javascript:PayrollemployeeOnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CurrencyID"), ""), String) + "')"" >"
                'End Addition By NitinVS on 8 SEP 2008 for Project Profitability 

            Else
                'Added by ArchanaN on 13 Feb 2008 for Tentative Leaving Date
                Dim TentJoinDate As String
                TentJoinDate = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TentativeDateOfRelieving"), ""), String)
                If TentJoinDate = "" Then
                    TentJoinDate = ""
                Else
                    TentJoinDate = Format(CType(TentJoinDate, Date).ToString("dd-MMM-yyyy"))
                End If
                'End of Added by ArchanaN on 13 Feb 2008 for Tentative Leaving Date
                Args.StringToBeInserted += "<A href=""JavaScript:EmployeeName_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + CommonFunction.General.CheckIsNothing(CommonFunctions.General.FormatString(CType(Args.DataReader("EmployeeName"), String), True), "").Replace("&#39;", "\'") + "','" + CType(Args.DataReader("ResourcePercentage"), String) + "','" + CType(CommonFunctions.Dates.GetDate(CType(Args.DataReader("JoiningDate"), Date)), String) + "'," + m_lngTagID.ToString + ",'" + CommonFunction.General.CheckIsNothing(CommonFunctions.General.FormatString(CType(Args.DataReader("Address"), String), True), "").Replace("&#39;", "\'") + "','" + CType(Args.DataReader("Phone"), String) + "','" + TentJoinDate + "')"">"
            End If
            'End of Addition by ShraddhaM on 23, July 2007 for CleanUp Activity

            Args.StringToBeInserted += CType(Args.DataReader("UserName"), String) + "</A>"
            Args.StringToBeInserted += "</TD>"
        End If
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

    End Sub

End Class

Public Class cResourceSelection_CommonListSQL
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
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            ' strSQLEmpId = "Select EmployeeId from tbl_PM_Employee_ResourceFullControlUsers where EmployeeId=" & objGlobal.UserID
            strSQLEmpId = "usp_sel_tbl_PM_Employee_ResourceFullControlUsers " & objGlobal.UserID
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
            m_intResourceID = CType(CommonFunctions.Data.GetDataScalar(strSQLEmpId, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)

            If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(m_intResourceID, "0"), "0").ToString, Integer) = 0 And (CType(CommonFunction.General.CheckIsNothing(objGlobal.RoleID, "0").ToString(), Integer) <> 7) Then
                GetPageSpecificFilters = " AND ReportingTo = " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
            End If
        End If
    End Function

End Class


Public Class cResourceSelection_CommonListDynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strSQL As String = ""
        Dim RoleFilterValue As String = ""
        Dim lngControlTagID As Long


        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SetFilter"), "") <> "1" And _
            Args.FilterName.ToUpper = "ROLEDESCRIPTION" And ((CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Long) = CommonFunction.Constants.APP_TAG_RESOURCES) Or (CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Long) = CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS)) Then

            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RoleID"), "") <> "" Then
                ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion

                'strSQL = "SELECT RoleDescription FROM tbl_PM_Role Where RoleID=" & CType(HttpContext.Current.Request.QueryString("RoleID"), String).ToString
                strSQL = "usp_sel_tbl_PM_Role_RoleDescription " & CType(HttpContext.Current.Request.QueryString("RoleID"), String).ToString
                '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
                RoleFilterValue = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), ""), String)
            End If

            Args.FixedValue = RoleFilterValue

            strSQL = ""
            strSQL = "usp_sel_tbl_UI_ControlTagMaster_ControlTagID " & WhizGlobal.TagID.ToString
            lngControlTagID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"), Long)

            strSQL = ""
            If RoleFilterValue <> "" Then
                strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString + "," + lngControlTagID.ToString + ",'RoleDescription','Role','F','" + CommonFunction.General.BuildQueryString(RoleFilterValue) + "','" + CommonFunction.General.BuildQueryString(RoleFilterValue) + "'"
            Else
                strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString + "," + lngControlTagID.ToString + ",'RoleDescription','Role','F',NULL,NULL"
            End If
            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            strSQL = ""
            strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString
            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        End If

    End Sub
End Class

