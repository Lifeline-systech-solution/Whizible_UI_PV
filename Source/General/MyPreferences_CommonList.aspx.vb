Imports CommonEngines.General.cEventHandlers
Public Class MyPreferences_CommonList
    Inherits CommonList
    Private m_strNodeTagID As String




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
        MyBase.strListPage = "MyPreferences_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CLCP_Events_Grid_MyPreferences(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cMyPreferences_CommonListCLSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cMyPreferences_CommonListDynamicFilters(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

        Dim sbHTML As New System.Text.StringBuilder
        Dim arrShowList() As String
        Dim strListOfchkDelete As String = ""
        Dim strTagID As String = ""
        Dim txtOrderNo As Integer = 0
        Dim strOrderNo As String
        Dim i As Integer = 0
        Dim strSQL As String = ""
        Dim strFromWhere As String
        Dim strUncheckedBox As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidUCS"))
        strListOfchkDelete = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))

        m_strNodeTagID = Request.QueryString("NodeTagID")

        If m_strNodeTagID Is Nothing Then
            m_strNodeTagID = Request.Form("txthidNodeTagID")
        End If

        If strListOfchkDelete <> "" Then
            arrShowList = strListOfchkDelete.Split(","c)

            For i = 0 To arrShowList.Length - 1
                strTagID = arrShowList(i)
                strOrderNo = strOrderNo + CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNo" + strTagID), "0"), String) + ","
                'strSQL = "usp_Ins_Tbl_CNF_Employee_Gadgets_Details " & strTagID & "," & txtOrderNo.ToString & "," & HttpContext.Current.Session("intUserID").ToString & ",'" & HttpContext.Current.Session("strUserName").ToString & "'"
                'CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next
        End If

        'If strListOfchkDelete <> "" Then
        '    arrShowList = strListOfchkDelete.Split(","c)

        'For i = 0 To arrShowList.Length - 1
        '    strTagID = arrShowList(i)
        '        txtOrderNo = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNo" + strTagID), "0"), Integer)
        '    strSQL = "usp_Ins_Tbl_CNF_Employee_Gadgets_Details " & strTagID & "," & txtOrderNo.ToString & "," & HttpContext.Current.Session("intUserID").ToString & ",'" & HttpContext.Current.Session("strUserName").ToString & "'"
        '    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        'Next
        'End If


        'If strUncheckedBox <> "" Then
        '    strSQL = "usp_Ins_Tbl_CNF_Employee_Gadgets_Details NULL,NULL," & HttpContext.Current.Session("intUserID").ToString & ",'" & HttpContext.Current.Session("strUserName").ToString & "','" & strUncheckedBox.Substring(0, strUncheckedBox.Length - 1) & "'"
        '    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        'End If


        strSQL = "usp_UPD_Tbl_CNF_Employee_Gadgets_Details " & m_strNodeTagID & ",'" & strListOfchkDelete & "','" & strUncheckedBox & "','" & strOrderNo & "'," & HttpContext.Current.Session("intUserID").ToString
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)


        sbHTML.Append("<Script language=javascript>")
        sbHTML.Append("parent.refreshTabs('&Mypreferences=1');")
        'sbHTML.Append("var obj=GetObjectReference('','Tab_20008');")
        'sbHTML.Append("if(obj!=null){alert(obj);")
        'sbHTML.Append("obj.className='selectedTab';}")
        sbHTML.Append("</Script>")

        HttpContext.Current.Response.Write(sbHTML.ToString)

        sbHTML = Nothing
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strTabID As String = ""
        If Not HttpContext.Current.Request.Form("txtHidTabID") Is Nothing Then
            strTabID = HttpContext.Current.Request.Form("txtHidTabID").ToString
        Else
            strTabID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TabID")).ToString
        End If

        m_strNodeTagID = Request.QueryString("NodeTagID")

        If m_strNodeTagID Is Nothing Then
            m_strNodeTagID = Request.Form("txthidNodeTagID")
        End If

        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHidUCS", "txtHidUCS", , , , , , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHidTabID", "txtHidTabID", , , , strTabID, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txthidNodeTagID", "txthidNodeTagID", , , , m_strNodeTagID, , , , , , True, , True))
    End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
    'added by ninad ' Requirement Tag :WAF3_PB_33 
    'Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
    '    MyBase.WhizForm_Init(WhizGlobal, m_intConnectionID)
    'End Sub
    'addition end by ninad ' Requirement Tag :WAF3_PB_33 
End Class
Class cMyPreferences_CommonListDynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Private m_strNodeTagID As String

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'MyBase.Before_Filter_Print(Cancel, Args, WhizGlobal)

        m_strNodeTagID = HttpContext.Current.Request.QueryString("NodeTagID")

        If m_strNodeTagID Is Nothing Then
            m_strNodeTagID = HttpContext.Current.Request.Form("txthidNodeTagID")
        End If

        If Args.FilterName.ToUpper = "PARENTID" Then
            Args.SQL += " AND EG.EmployeeID = " + HttpContext.Current.Session("intUserID").ToString()
            Args.SQL += " AND GN.NodeTagID = " + m_strNodeTagID
            Args.SQL += " ORDER BY PT.TagDescription"
        End If

    End Sub
End Class
Public Class CLCP_Events_Grid_MyPreferences
    Inherits CommonEngine.CommonList.cPlotGrid
    Private strSQL As String = ""
    Public htGadget As Hashtable
    Public htActive As Hashtable
    Public dr As IDataReader
    Dim m_objAccess As New WebPage.Templates.AccessRights
    Dim m_GlobalObject As New WebPages.Template.WhizGlobal
    Dim IsAccessForNode As Boolean

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
        htGadget = New Hashtable
        htActive = New Hashtable
        'strSQL = "SELECT TagID,OrderNo,IsActive FROM tbl_CNF_Employee_Gadgets WHERE EmployeeID=" + HttpContext.Current.Session("intUserID").ToString
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ''strSQL = "SELECT * FROM v_Tbl_CNF_Employee_Gadgets_Details WHERE 1=1 AND EmployeeID=" + HttpContext.Current.Session("intUserID").ToString
        strSQL = "usp_SEL_v_Tbl_CNF_Employee_Gadgets_Details " + HttpContext.Current.Session("intUserID").ToString
        ''eND OF Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        dr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While dr.Read
            htGadget.Add(CommonFunction.Data.CheckIsDBNull(dr("TagID")).ToString, CommonFunction.Data.CheckIsDBNull(dr("OrderNo")).ToString)
            'htActive.Add(CommonFunction.Data.CheckIsDBNull(dr("TagID")).ToString, CBool(CommonFunction.Data.CheckIsDBNull(dr("IsActive")).ToString))
            htActive.Add(CommonFunction.Data.CheckIsDBNull(dr("TagID")).ToString, CBool(CommonFunction.Data.CheckIsDBNull(dr("Active")).ToString))
        End While
        CommonFunction.Data.DisposeDataReader(dr)

        'To get access


        Dim UseHashTable As String
        Dim LCID As Long
        Dim IsAccessForNode As Boolean

        UseHashTable = CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP")
        LCID = System.Threading.Thread.CurrentThread.CurrentUICulture.LCID()

        If Not HttpContext.Current.Session("intProjectID") Is Nothing Then
            m_GlobalObject.ProjectID = CType(HttpContext.Current.Session("intProjectID"), Long)
        End If
        If Not HttpContext.Current.Session("intLoginID") Is Nothing Then
            m_GlobalObject.LoginID = CType(HttpContext.Current.Session("intLoginID"), Long)
        End If
        If Not HttpContext.Current.Session("LoginType") Is Nothing Then
            m_GlobalObject.LoginType = HttpContext.Current.Session("LoginType").ToString
        End If
        If Not HttpContext.Current.Session("IsCreatedByCustomer") Is Nothing Then
            m_GlobalObject.IsCustomerCreated = CType(HttpContext.Current.Session("IsCreatedByCustomer"), Boolean)
        End If

        If Not HttpContext.Current.Session("intPostID") Is Nothing Then
            m_GlobalObject.RoleID = CType(HttpContext.Current.Session("intPostID"), Long)
        End If

        If Not HttpContext.Current.Session("intRoleLevel") Is Nothing Then
            m_GlobalObject.RoleLevel = CType(HttpContext.Current.Session("intRoleLevel"), Integer)
        End If
        If Not HttpContext.Current.Session("strUserName") Is Nothing Then
            m_GlobalObject.UserName = HttpContext.Current.Session("strUserName").ToString
        End If
        If Not HttpContext.Current.Session("intUserID") Is Nothing Then
            m_GlobalObject.UserID = CType(HttpContext.Current.Session("intUserID"), Long)
        End If

        m_GlobalObject.LCID = LCID
        m_GlobalObject.ParentTagID = 0
        m_GlobalObject.returnHTML = False
        m_GlobalObject.UseHashTable = UseHashTable
        m_GlobalObject.clsTable = ""
        m_GlobalObject.clsTR = ""


    End Sub


    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Select Case Args.DataField.ToUpper
            Case "EMPLOYEEID"
                Cancel = True
            Case "ORDERNO"
                Cancel = True
                Dim strTagID As String = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TagID").ToString, ""), String)
                Args.StringToBeInserted = "<td style='align:center;text-align:center;'>" + CommonFunction.HTMLControls.DrawTextBox("txtOrderNo" + strTagID, "txtOrderNo" + strTagID, , 50, , CommonFunction.General.CheckIsNothing(htGadget.Item(strTagID), "").ToString, "right", , , , , , , True, True) + "</td>"
        End Select

        If Args.ColumnName.ToUpper = "SHOW" Then

            Dim blnActive As Boolean = CBool(htActive.Item(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TagID").ToString, ""), String)))
            If blnActive Then ''CBool(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Active"), "0")) Then
                Args.IsSelected = True
            End If
        End If

    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

        m_GlobalObject.FromWhere = Args.DataReader("FromWhere")
        m_GlobalObject.TagID = Args.DataReader("TagID")

        'Get the Access Rights 
        m_objAccess.GetAccess(m_GlobalObject)
        If m_objAccess.Add = True OrElse m_objAccess.Delete = True OrElse m_objAccess.Edit = True OrElse m_objAccess.View Then
            IsAccessForNode = True
        Else
            IsAccessForNode = False
        End If

        If IsAccessForNode = False Then
            Cancel = True
        End If


    End Sub
    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "EMPLOYEEID" Then
            Cancel = True
        End If
    End Sub
    Protected Overrides Sub Finalize()
        MyBase.Finalize()
        'htGadget = Nothing
        'CommonFunction.Data.DisposeDataReader(dr)
    End Sub
End Class

Class cMyPreferences_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Private m_strNodeTagID As String

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String

        m_strNodeTagID = HttpContext.Current.Request.QueryString("NodeTagID")

        If m_strNodeTagID Is Nothing Then
            m_strNodeTagID = HttpContext.Current.Request.Form("txthidNodeTagID")
        End If

        GetPageSpecificFilters += " AND NodeTagID = " + m_strNodeTagID
        GetPageSpecificFilters += " AND EmployeeID = " + CType(HttpContext.Current.Session("intUserID"), String)

        'Return MyBase.GetPageSpecificFilters(objGlobal)
    End Function
End Class