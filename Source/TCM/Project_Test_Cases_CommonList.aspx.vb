Imports CommonEngines.General.cEventHandlers
Public Class Project_Test_Cases_CommonList
    Inherits CommonList
    Protected UserStoryID As String


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
        MyBase.strListPage = "Project_Test_Cases_CommonList.aspx"
        MyBase.strFormPage = "Project_Test_Cases_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here

        

        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cProject_Test_Cases_CommonList(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cProject_Test_Cases_CommonList_DynamicFilters(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim TestSetID As String
        TestSetID = CType(HttpContext.Current.Request.QueryString("ProjectTestSetID"), String)

        ''Added by NitinC On 29 June 2011 For WhizibleSEM v10.0 (Agile Methodology)

        'If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "0") <> "0" Then
        '    UserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
        '    If Request.Form("hidUserStoryID") = "" Then
        '        CommonFunction.General.WriteHTML("<input type=HIDDEN name='hidUserStoryID' value='" + UserStoryID.ToString + "'>")
        '    End If
        'ElseIf Request.Form("hidUserStoryID") <> Nothing Then
        '    UserStoryID = Request.Form("hidUserStoryID")
        'Else
        '    UserStoryID = "NULL"
        'End If
        ''End of Added by NitinC On 29 June 2011 For WhizibleSEM v10.0 (Agile Methodology)

        If Args.ClientSideFunctionName.ToLower = "section_onclick" Then
            If UserStoryID <> Nothing Then
                Args.ToBeInsertedInFunction += "window.open ('../General/CommonList.aspx?FromWhere=PM&MasterTagID=3665&ProjectTestSetID=" + TestSetID.ToString + "&UserStoryID=" + UserStoryID.ToString + "', '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 700)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=700,height=500');" + vbCrLf
            Else
                Args.ToBeInsertedInFunction += "window.open ('../General/CommonList.aspx?FromWhere=PM&MasterTagID=3665&ProjectTestSetID=" + TestSetID.ToString + "', '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 700)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=700,height=500');" + vbCrLf
            End If

            Args.ToBeInsertedInFunction += "return;"
        End If
        If Args.ClientSideFunctionName.ToLower = "sectiongrid_onclick" Then
            If UserStoryID <> Nothing Then
                Args.ToBeInsertedInFunction += "window.open ('../TCM/Project_TestSection_Grid_CommonList.aspx?FromWhere=PM&MasterTagID=3667&ProjectTestSetId=" + TestSetID.ToString + "&UserStoryID=" + UserStoryID.ToString + "', '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 700)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=700,height=500');" + vbCrLf
            Else
                Args.ToBeInsertedInFunction += "window.open ('../TCM/Project_TestSection_Grid_CommonList.aspx?FromWhere=PM&MasterTagID=3667&ProjectTestSetId=" + TestSetID.ToString + "', '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 700)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=700,height=500');" + vbCrLf
            End If

            Args.ToBeInsertedInFunction += "return;"
        End If

    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim TestSetID As String
        Dim strbuildstring As String
        Dim strSQL As String
        Dim strTestSetName As String
        Dim drname As IDataReader

        TestSetID = CType(HttpContext.Current.Request.QueryString("ProjectTestSetID"), String)
        ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
        ''strSQL = "Select TestSetName from tbl_TCM_ProjectTestSet Where ProjectTestSetID=" + CStr(TestSetID)

        'Commented and Added By Bharat T on 10th-Nov-2016 for MasterCard Upgrade issue fixing
        'strSQL = "usp_sel_tbl_TCM_ProjectTestSet_TestSetName" + CStr(TestSetID)
        strSQL = "usp_sel_tbl_TCM_ProjectTestSet_TestSetName " & CStr(TestSetID)
        'End of Commented and Added By Bharat T on 10th-Nov-2016 for MasterCard Upgrade issue fixing

        drname = CommonFunctions.Data.GetDataReader(strSQL, True)
        If drname.Read Then
            strTestSetName = CStr(drname.Item("TestSetName"))
            strbuildstring = "Test Set : " + strTestSetName
            Args.RightPageCaption = strbuildstring
        End If
        CommonFunction.Data.DisposeDataReader(drname)
    End Sub

    Private Sub Page_Init1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

    End Sub

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "0") <> "0" Then
            UserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
        End If
        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            UserStoryID = Request.Form("txthidUserStoryID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidUserStoryID", "txthidUserStoryID", , , , UserStoryID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            UserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidUserStoryID", "txthidUserStoryID", , , , UserStoryID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
    End Function
    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "0") <> "0" Then
            UserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
        End If
        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            UserStoryID = Request.Form("txthidUserStoryID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidUserStoryID", "txthidUserStoryID", , , , UserStoryID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            UserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidUserStoryID", "txthidUserStoryID", , , , UserStoryID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
    End Sub
End Class

Public Class cProject_Test_Cases_CommonList
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "COPY" Then
            Dim drAccessRights As IDataReader
            Dim strQuery As String
            Dim intPostId As Integer
            Dim intUserId As Integer
            Dim strLoginType As String
            Dim intProjectID As Integer
            Dim blnAddRight As Boolean
            Dim blnEditRight As Boolean

            intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
            intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
            strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
            intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
            drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                drAccessRights.Read()
                blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
            End If
            If (blnAddRight = False) Then
                Cancel = True
            End If
            CommonFunctions.Data.DisposeDataReader(drAccessRights)
        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "COPY" Then
            Dim drAccessRights As IDataReader
            Dim strQuery As String
            Dim intPostId As Integer
            Dim intUserId As Integer
            Dim strLoginType As String
            Dim intProjectID As Integer
            Dim blnAddRight As Boolean
            Dim blnEditRight As Boolean

            intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
            intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
            strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
            intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
            drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                drAccessRights.Read()
                blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
            End If
            If (blnAddRight = False) Then
                Cancel = True
            End If
            CommonFunctions.Data.DisposeDataReader(drAccessRights)
        End If
    End Sub


End Class
Public Class cProject_Test_Cases_CommonList_DynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.FilterName.ToUpper = "PROJECTTESTSECTIONID" Then
            Dim strTestSetID As String
            strTestSetID = CType(HttpContext.Current.Request.QueryString("ProjectTestSetID"), String)
            If strTestSetID Is Nothing Or strTestSetID = "" Then
                strTestSetID = HttpContext.Current.Request.Form("ProjectTestSetID")

            End If
            Args.SQL = " usp_Sel_tbl_TCM_ProjectTestSection " & strTestSetID

        End If
        'Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
        If Args.FilterName.ToUpper = "USERSTORYID" Then
            Dim m_intFlag As Integer
            m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + CType(WhizGlobal.ProjectID, String), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
            If m_intFlag = 0 Then
                Cancel = True
            End If
        End If
        'End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
    End Sub
End Class