Imports CommonEngines.General.cEventHandlers

Public Class TimesheetDetails_CommonList
    Inherits CommonList
    'Added By ShraddhaM on 26,July 2007
    Protected m_TaskID As String
    Protected m_ReviewStatisticsID As String
    Protected m_DeliverableID As String
    Protected m_IssueID As String
    'End of Addition By ShraddhaM on 26,July 2007


   
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
        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitPlotGrid()
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "TimesheetDetails_CommonList.aspx"
        MyBase.strFormPage = "TimesheetDetails_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)



    End Sub
#End Region
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cTimesheetDetails_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cTimesheetDetails_CommonListSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        'Added By ShraddhaM on 26,July 2007 
        'Purpose : PM Dashboard Enhanced View --> Filters -->"Apply without Save" Page Crash when we apply Resource [List] Filter

        'For IssueID
        If Not HttpContext.Current.Request.QueryString("IssueID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("IssueID") <> "" Then
            m_IssueID = HttpContext.Current.Request.QueryString("IssueID")
        ElseIf Not Request.Form("txtIssueId") Is Nothing Then
            m_IssueID = Request.Form("txtIssueId")
        Else
            m_IssueID = ""
        End If

        'For TaskID
        If Not HttpContext.Current.Request.QueryString("TaskID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("TaskID") <> "" Then
            m_TaskID = HttpContext.Current.Request.QueryString("TaskID")
        ElseIf Not Request.Form("txtTaskId") Is Nothing Then
            m_TaskID = Request.Form("txtTaskId")
        Else
            m_TaskID = ""
        End If

        'For ReviewStatisticsID
        If Not HttpContext.Current.Request.QueryString("ReviewStatisticsID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("ReviewStatisticsID") <> "" Then
            m_ReviewStatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID")
        ElseIf Not Request.Form("txtReviewStatisticsId") Is Nothing Then
            m_ReviewStatisticsID = Request.Form("txtReviewStatisticsId")
        Else
            m_ReviewStatisticsID = ""
        End If

        'For DeliverableID
        If Not HttpContext.Current.Request.QueryString("DeliverableID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("DeliverableID") <> "" Then
            m_DeliverableID = HttpContext.Current.Request.QueryString("DeliverableID")
        ElseIf Not Request.Form("txtDeliverableID") Is Nothing Then
            m_DeliverableID = Request.Form("txtDeliverableID")
        Else
            m_DeliverableID = ""
        End If

        CommonFunctions.General.WriteHTML("<input type = hidden name='txtIssueId' value=" + m_IssueID + ">")
        CommonFunctions.General.WriteHTML("<input type = hidden name='txtTaskId' value=" + m_TaskID + ">")
        CommonFunctions.General.WriteHTML("<input type = hidden name='txtReviewStatisticsId' value=" + m_ReviewStatisticsID + ">")
        CommonFunctions.General.WriteHTML("<input type = hidden name='txtDeliverableID' value=" + m_DeliverableID + ">")
        'End of Addition By ShraddhaM on 26,July 2007 
    End Function
End Class
Public Class cTimesheetDetails_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cTimesheetDetails_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Protected m_TaskID As String
    Protected m_ReviewStatisticsID As String
    Protected m_DeliverableID As String
    Protected m_IssueID As String

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)

        'Added By ShraddhaM on 26,July 2007 
        'Purpose : PM Dashboard Enhanced View --> Filters -->"Apply without Save" Page Crash when we apply Resource [List] Filter

        'For IssueID
        If Not HttpContext.Current.Request.QueryString("IssueID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("IssueID") <> "" Then
            m_IssueID = HttpContext.Current.Request.QueryString("IssueID")
        ElseIf Not HttpContext.Current.Request.Form("txtIssueId") Is Nothing Then
            m_IssueID = HttpContext.Current.Request.Form("txtIssueId")
        Else
            m_IssueID = ""
        End If


        'For TaskID
        If Not HttpContext.Current.Request.QueryString("TaskID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("TaskID") <> "" Then
            m_TaskID = HttpContext.Current.Request.QueryString("TaskID")
        ElseIf Not HttpContext.Current.Request.Form("txtTaskId") Is Nothing Then
            m_TaskID = HttpContext.Current.Request.Form("txtTaskId")
        Else
            m_TaskID = ""
        End If

        'For ReviewStatisticsID
        If Not HttpContext.Current.Request.QueryString("ReviewStatisticsID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("ReviewStatisticsID") <> "" Then
            m_ReviewStatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID")
        ElseIf Not HttpContext.Current.Request.Form("txtReviewStatisticsId") Is Nothing Then
            m_ReviewStatisticsID = HttpContext.Current.Request.Form("txtReviewStatisticsId")
        Else
            m_ReviewStatisticsID = ""
        End If

        'For DeliverableID
        If Not HttpContext.Current.Request.QueryString("DeliverableID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("DeliverableID") <> "" Then
            m_DeliverableID = HttpContext.Current.Request.QueryString("DeliverableID")
        ElseIf Not HttpContext.Current.Request.Form("txtDeliverableID") Is Nothing Then
            m_DeliverableID = HttpContext.Current.Request.Form("txtDeliverableID")
        Else
            m_DeliverableID = ""
        End If

        'End of Addition By ShraddhaM on 26,July 2007 


    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        'Commented By ShraddhaM on 26,July 2007 
        'PM Dashboard Enhanced View --> Filters -->"Apply without Save" Page Crash when we apply Resource [List] Filter

        'If Not HttpContext.Current.Request.QueryString("IssueID") Is Nothing Then

        '    GetPageSpecificFilters &= " AND WhichTask = 'B'and OtherTaskID =" + HttpContext.Current.Request.QueryString("IssueID")
        'End If

        'If Not HttpContext.Current.Request.QueryString("ReviewStatisticsID") Is Nothing Then

        '      GetPageSpecificFilters &= " AND ReviewStatisticsID IS NOT NULL and ReviewStatisticsID =" + HttpContext.Current.Request.QueryString("ReviewStatisticsID")

        'End If

        'If Not HttpContext.Current.Request.QueryString("TaskID") Is Nothing Then

        '    GetPageSpecificFilters &= "AND TaskID =" + HttpContext.Current.Request.QueryString("TaskID")
        'End If

        'If Not HttpContext.Current.Request.QueryString("DeliverableID") Is Nothing Then

        '    GetPageSpecificFilters &= "AND DeliverableID =" + HttpContext.Current.Request.QueryString("DeliverableID")
        'End If
        'End of Comment By ShraddhaM on 26,July 2007

        'Added By ShraddhaM on 26,July 2007 
        'Purpose : PM Dashboard Enhanced View --> Filters -->"Apply without Save" Page Crash when we apply Resource [List] Filter

        If Not m_IssueID Is Nothing And m_IssueID <> "" Then

            GetPageSpecificFilters &= " AND WhichTask = 'B' AND OtherTaskID = " + m_IssueID
        End If

        If Not m_ReviewStatisticsID Is Nothing And m_ReviewStatisticsID <> "" Then

            GetPageSpecificFilters &= " AND ReviewStatisticsID IS NOT NULL AND ReviewStatisticsID = " + m_ReviewStatisticsID

        End If

        If Not m_TaskID Is Nothing And m_TaskID <> "" Then

            GetPageSpecificFilters &= "AND TaskID =" + m_TaskID
        End If

        If Not m_DeliverableID Is Nothing And m_DeliverableID <> "" Then

            GetPageSpecificFilters &= "AND DeliverableID = " + m_DeliverableID
        End If

        '' Added By NitinVS on 24 May 2005 for Expense Workflow Implementation
        'GetPageSpecificFilters &= " AND FPCenterID IN (SELECT FPCenterID FROM tbl_CNF_financeProcessingCenter_Details WHERE EmployeeID = " + CType(HttpContext.Current.Session("intUserID"), String) + ")"
        ' End Addition By NitinVS on 24 May 2005 for Expense Workflow Implementation 
    End Function
End Class
