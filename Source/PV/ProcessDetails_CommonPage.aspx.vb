Imports CommonEngines.General.cEventHandlers
Public Class cProcessDetails_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProcessDetails_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cProcessDetails_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Function GetUIPageWhereClause(ByVal objGlobal As WebPages.Template.IGlobal, ByVal TableName As String, ByVal PrimaryKey As String, Optional ByRef PrimaryKeyValue As String = "") As String
        If (HttpContext.Current.Request("FromCL") = "1" And objGlobal.ParentTagID = 0) Or (HttpContext.Current.Request("SubTagFromCL") = "1" And objGlobal.ParentTagID <> 0) Then
            'Common Page is accessed from CommonList
            GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"

            '*****************************************************************************
            'Code Added     :       ManishK   29th Aug 2005
            'Purpose        :       To Apply Project Filter for "Show Details" popup
            '                       page for viewing Process Details at project level.
            '*****************************************************************************
            GetUIPageWhereClause += " AND ProjectID = " + HttpContext.Current.Session("intProjectID").ToString
        End If

    End Function
End Class

Public Class cProcessDetails_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        'Added By ManishK on 29th Aug 05
        'Commented by SavitaS on 15 Sept 2006 for SP7 IssueID 6213
        'Args.IgnoreActualValue = True
        'Args.NewValue = Replace(drControls(Args.ControlName).ToString, Chr(13) + Chr(10), "<BR>")
        'End of Commented by SavitaS on 15 Sept 2006 for SP7 IssueID 6213
        'End of addition by ManishK on 29th Aug 05

    End Sub

End Class


Public Class ProcessDetails_CommonPage
    Inherits CommonPage
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "ProcessDetails_CommonList.aspx"
        MyBase.strFormPage = "ProcessDetails_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        Dim strSQL As String
        Dim strProcessName As String
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        ' strSQL = "SELECT ProcessName FROM tbl_PRS_Project_SDLC_ProcessDetails WHERE ProjectID = " + WhizGlobal.ProjectID.ToString + " AND ProcessID = " + Gen.PrimaryKeyValue
        strSQL = "usp_sel_SDLC_ProcessDetails " + WhizGlobal.ProjectID.ToString + "," + Gen.PrimaryKeyValue

        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query

        strProcessName = CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        Args.LeftPageCaption = Args.LeftPageCaption + ": " + strProcessName
        'End of addition by ManishK on 29th Aug 05

    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29
        'Added by ManishK on 29th Aug 2005
        If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
            Dim strFunction As String
            strFunction = "window.close();return;"
            Args.ToBeInsertedInFunction = strFunction
        End If
        'End Of Addition ManishK on 29th Aug 2005
        'End Integration
    End Sub

    Protected Overrides Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29
        'Added by ManishK on 29th Aug 2005 for process 
        Cancel = True
        'End of addition by ManishK on 29th Aug 05
        'End Integration
    End Sub



    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cProcessDetails_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cProcessDetails_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cProcessDetails_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cProcessDetails_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function


End Class
