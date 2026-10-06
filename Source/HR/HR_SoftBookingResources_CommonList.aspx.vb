Imports System
Imports CommonEngines.General.cEventHandlers
Public Class HR_SoftBookingResources_CommonList
    Inherits CommonList

    Protected m_SettingValueResAll As String
    Private OpportunityID As String
    Private pipelineID As String
    Private IsSelected As String


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
        MyBase.strListPage = "HR_SoftBookingResources_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'PrashatD move
        OpportunityID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OpportunityID"), "0"), String)
        pipelineID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("pipelineID"), "0"), String)

        If OpportunityID = "0" Then
            OpportunityID = HttpContext.Current.Request.Form("hidOpportunityID")
        End If

        If pipelineID = "0" Then
            pipelineID = HttpContext.Current.Request.Form("hidpipelineID")
        End If
        IsSelected = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IsSelected"), ""), String)

        If IsSelected = "" Then
            IsSelected = HttpContext.Current.Request.Form("IsSelected")
        End If


        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New c_HR_SoftBookingResources_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cHR_SoftBookingResources_CommonListSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cHR_SoftBookingResources_CommonListDynamicFilters(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim chkDelete() As String
        Dim Iterator As Integer
        Dim strQuery As String
        Dim strDelteQuery As String
        Dim strDelteSubQuery As String
        Dim PostID As String

        Dim BusinessGroupID As String
        Dim LocationID As String
        Dim EmployeeName As String
        PostID = Request.Form("RoleID")

        BusinessGroupID = Request.Form("BusinessGroupID")
        LocationID = Request.Form("LocationID")
        EmployeeName = Request.Form("EmployeeName")

        If DeletedIDList <> "" Then

            chkDelete = DeletedIDList.Split(","c)
            'To Insert record in Soft Booking
            For Iterator = 0 To chkDelete.Length - 1

                'strQuery = "usp_upd_AllocatedResource_Distribution 'D'," + pipelineID + ",NULL,NULL,NULL,NULL" + "," + chkDelete(Iterator)
                'CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                strQuery = "usp_Ins_tbl_RM_SoftBooking " + OpportunityID + "," + pipelineID + "," + chkDelete(Iterator) + ",'" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "'"
                CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Next

        End If
        If DeletedIDList = "" Then
            DeletedIDList = "0"
        End If
        strDelteQuery = "DELETE FROM tbl_RM_SoftBooking WHERE OpportunityID = " + OpportunityID + " AND PipelineID = " + pipelineID + " AND EmployeeID NOT IN(" + DeletedIDList + ")"
        'strDelteSubQuery = " AND EmployeeID IN (SELECT EmployeeId FROM tbl_PM_Employee WHERE 1 = 1"
        strDelteSubQuery = " AND EmployeeID IN (SELECT EmployeeId FROM tbl_RM_SoftBooking WHERE 1 = 1 AND EmployeeID IN(" + Request.Form("hidUIEmployeeID").ToString() + ") AND EmployeeID NOT IN(" + DeletedIDList + ")"

        'If PostID <> "" Then
        '    strDelteSubQuery += " AND PostID=" + PostID
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
        strDelteSubQuery += ")"
        strDelteQuery += strDelteSubQuery
        Dim strDelQueryForSoftBooking As String
        strDelQueryForSoftBooking = strDelteQuery

        strDelteQuery = "DELETE FROM tbl_RM_SoftBooking_Distribution WHERE OpportunityID = " + OpportunityID + " AND PipelineID = " + pipelineID + " AND BookingID NOT IN( SELECT BookingID FROM tbl_RM_SoftBooking WHERE OpportunityID =" + OpportunityID + " AND PipelineID= " + pipelineID + " AND EmployeeID IN(" + DeletedIDList + "))"
        strDelteQuery += " AND BookingID IN ( SELECt BookingID FROM tbl_RM_SoftBooking WHERE OpportunityID = " + OpportunityID + " AND PipelineID = " + pipelineID
        strDelteQuery += strDelteSubQuery + ")"
        CommonFunction.Data.InsertOrUpdateData(strDelteQuery, MyBase.UseSQL)

        CommonFunction.Data.InsertOrUpdateData(strDelQueryForSoftBooking, MyBase.UseSQL)
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString

    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunctions.General.WriteHTML("<input type=hidden name='IsSelected' value=" + IsSelected + ">")


    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Addition by SuchitraP on 17-Dec-2008 for Hiding Save and SaveAndClose link when opportunity is closed
        Dim strSQL As String
        Dim IsOpen As Boolean = False
        Dim strTagId As String
        'End of addition by SuchitraP on 17-Dec-2008

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

        strTagId = HttpContext.Current.Request.QueryString("OpenerTagID")
        If strTagId = "" Then
            strTagId = HttpContext.Current.Request.Form("OpenerTagID")
        End If

        'Addition by SuchitraP on 17-Dec-2008 for Hiding Save and SaveAndClose link when opportunity is closed
        If strTagId = "3851" Or strTagId = "3865" Then
            ''  strSQL = "SELECT 1 FROM tbl_RM_Opportunity INNER JOIN tbl_CNF_OpportunityStatus OS ON tbl_RM_Opportunity.StatusID = OS.OpportunityStatusID AND ISNULL(MapToReadyForClosure,0) = 0 WHERE OpportunityID =" + HttpContext.Current.Request.QueryString("OpportunityID")
            strSQL = "usp_sel_OpportunityID_tbl_RM_Opportunity " + HttpContext.Current.Request.QueryString("OpportunityID")
            IsOpen = CommonFunction.Data.GetDataScalar(strSQL, True)
            If IsOpen = False And (Args.LinkName.ToUpper = "SAVE" Or Args.LinkName.ToUpper = "SAVE AND CLOSE") And WhizGlobal.TagID = 3858 Then
                Cancel = True
            End If
        End If
        'End of addition by SuchitraP on 17-Dec-2008

    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Args.HTMLLegend = ""
        Cancel = True
    End Sub
End Class

Public Class c_HR_SoftBookingResources_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Private strSoftBookingEmplyeeIDs As String
    Private OpportunityID As String
    Private pipelineID As String
    Private strUIEmployeeIDs As String = ""
    Private Iterator As Integer = 1
    Private pageNumber As Integer
    Private startIterator As Integer

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim PostID As String

        Dim BusinessGroupID As String
        Dim LocationID As String
        Dim EmployeeName As String
        Dim strSubQuery As String
        Dim strPipeLineFte As String
        'Addition by SuchitraP on 17-Dec-2008 for Hiding Save and SaveAndClose link when opportunity is closed
        Dim strOpenerTagID As String
        'End of addition by SuchitraP on 17-Dec-2008

        OpportunityID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OpportunityID"), "0"), String)
        pipelineID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("pipelineID"), "0"), String)

        If OpportunityID = "0" Then
            OpportunityID = HttpContext.Current.Request.Form("hidOpportunityID")
        End If

        If pipelineID = "0" Then
            pipelineID = HttpContext.Current.Request.Form("hidpipelineID")
        End If

        'Addition by SuchitraP on 17-Dec-2008 for Hiding Save and SaveAndClose link when opportunity is closed
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OpenerTagID"), "") <> "" Then
            strOpenerTagID = HttpContext.Current.Request.QueryString("OpenerTagID")
        ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("hidOpenerTagID"), "") <> "" Then
            strOpenerTagID = HttpContext.Current.Request.Form("hidOpenerTagID")
        End If
        'End of addition by SuchitraP on 17-Dec-2008

        '''Commented and Added by Dhanashri S on 12 Jan 2015
        'CommonFunctions.General.WriteHTML("<input type=hidden name='hidOpportunityID' value=" + OpportunityID + ">")
        'CommonFunctions.General.WriteHTML("<input type=hidden name='hidPipelineID' value=" + pipelineID + ">")

        CommonFunctions.General.WriteHTML("<input type=hidden id='hidOpportunityID' name='hidOpportunityID' value=" + OpportunityID + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidPipelineID' name='hidPipelineID' value=" + pipelineID + ">")
        ''End of Comment and Addition by Dhanashri S on 12 Jan 2015

        'Addition by SuchitraP on 17-Dec-2008 for Hiding Save and SaveAndClose link when opportunity is closed
        CommonFunction.General.WriteHTML("<input type=hidden id='hidOpenerTagID' name='hidOpenerTagID' value=" + strOpenerTagID + ">")
        'End of addition by SuchitraP on 17-Dec-2008

        PostID = HttpContext.Current.Request.Form("RoleID")
        BusinessGroupID = HttpContext.Current.Request.Form("BusinessGroupID")
        LocationID = HttpContext.Current.Request.Form("LocationID")
        EmployeeName = HttpContext.Current.Request.Form("EmployeeName")

        strSubQuery = " AND EmployeeID NOT IN (SELECT EmployeeId FROM tbl_PM_Employee WHERE 1 = 1"
        If PostID <> "" Then
            strSubQuery += " AND PostID=" + PostID
        End If

        If BusinessGroupID <> "" Then
            strSubQuery += " AND BusinessGroupID=" + BusinessGroupID
        End If
        If LocationID <> "" Then
            strSubQuery += " AND LocationID=" + LocationID
        End If
        If EmployeeName <> "" Then
            strSubQuery += " AND EmployeeName like '" + CommonFunction.General.BuildQueryString(EmployeeName.Trim()) + "%'"
        End If
        strSubQuery += ")"

        strSubQuery = "SELECT DISTINCT EmployeeID FROM tbl_RM_SoftBooking WHERE OpportunityID = " + OpportunityID + " AND PipelineID = " + pipelineID + strSubQuery

        Dim strEmpIDs As String = ""
        Dim dr As IDataReader = CommonFunction.Data.GetDataReader(strSubQuery, True) 'remove hardcode
        While dr.Read
            strEmpIDs = strEmpIDs + dr(0).ToString + ","
        End While
        If strEmpIDs <> "" Then
            strEmpIDs = strEmpIDs.Substring(0, strEmpIDs.Length - 1)
        End If
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidSelectedEmpIDs' value=" + strEmpIDs + ">")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''strPipeLineFte = CType(CommonFunctions.Data.GetDataScalar("SELECT TotalFTE FROM tbl_RM_PipeLine WHERE OpportunityID = " + OpportunityID + " AND PipelineID = " + pipelineID, True), String)
        strPipeLineFte = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_RM_PipeLine_OpportunityID " + OpportunityID + "," + pipelineID, True), String)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        If strPipeLineFte = "" Then
            strPipeLineFte = "0"
        End If
        CommonFunctions.General.WriteHTML("<input type=hidden id='hidMaxResourceSelCount' value=" + strPipeLineFte + ">")
        'To retrive soft booking EmployeeIDs 
        strSoftBookingEmplyeeIDs = CType(CommonFunctions.Data.GetDataScalar("usp_sel_SoftBookingResources " + OpportunityID + "," + pipelineID, True), String)

        'pageNumber = CType(HttpContext.Current.Request.Form("txtNumPaging1"), Integer)

        'If Not HttpContext.Current.Request.QueryString("PagingNumber") Is Nothing Then

        '    pageNumber = CType(HttpContext.Current.Request.QueryString("PagingNumber"), Integer)

        '    If CType(HttpContext.Current.Request.QueryString("PagingNavigation"), String) = "PREV" Then
        '        pageNumber -= 1
        '    ElseIf CType(HttpContext.Current.Request.QueryString("PagingNavigation"), String) = "NEXT" Then
        '        pageNumber += 1
        '    Else
        '        pageNumber = CType(HttpContext.Current.Request.QueryString("PagingNumber"), Integer)
        '    End If


        'End If

        'startIterator = (pageNumber - 1) * 20 + 1

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strEmpID As String

        If Args.ColumnName.ToUpper = "SELECT" Then
            strEmpID = Args.DataReader("EmployeeID").ToString + ""

            If strSoftBookingEmplyeeIDs.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                'Draw CheckBox selected
                Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value=" + strEmpID + " ></TD>"
                Cancel = True
            End If

        End If

    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

        'If Iterator >= startIterator Then
        strUIEmployeeIDs = strUIEmployeeIDs + CType(Args.DataReader("EmployeeID"), String) + ","
        'End If
        'Iterator += 1

    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        strUIEmployeeIDs = strUIEmployeeIDs + "0"
        CommonFunctions.General.WriteHTML("<input type=hidden name=hidUIEmployeeID id=hidUIEmployeeID value='" + strUIEmployeeIDs + "'>")
    End Sub
End Class

Public Class cHR_SoftBookingResources_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim OpportunityID As String
        Dim pipelineID As String
        Dim IsSelected As String
        IsSelected = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IsSelected"), ""), String)

        If IsSelected = "" Then
            IsSelected = CType(HttpContext.Current.Request.Form("IsSelected"), String)
        End If

        If Not IsSelected Is Nothing Or IsSelected <> "" Then
            If IsSelected.ToUpper() = "SHOWSELECTED" Then
                OpportunityID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OpportunityID"), "0"), String)
                pipelineID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("pipelineID"), "0"), String)

                If OpportunityID = "0" Then
                    OpportunityID = HttpContext.Current.Request.Form("hidOpportunityID")
                End If

                If pipelineID = "0" Then
                    pipelineID = HttpContext.Current.Request.Form("hidpipelineID")
                End If
                GetPageSpecificFilters = "AND EmployeeID IN( SELECT EmployeeId FROM tbl_RM_SoftBooking WHERE OpportunityID = " + OpportunityID + " AND pipelineID = " + pipelineID + ")"

            End If
        End If
    End Function
End Class


Public Class cHR_SoftBookingResources_CommonListDynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

