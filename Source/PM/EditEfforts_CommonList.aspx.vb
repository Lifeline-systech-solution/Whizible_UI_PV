Imports CommonEngines.General.cEventHandlers
Public Class EditEfforts_CommonList
    Inherits CommonList
    Public strAction As String


    ''Global Variables
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    Protected m_intBaselineNumber As Integer = 0
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
        MyBase.strListPage = "EditEfforts_CommonList.aspx"
        MyBase.strFormPage = "EditEfforts_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        If Not Request.QueryString("Flag") Is Nothing And Request.QueryString("Flag") <> "" Then
            strAction = Request.QueryString("Flag").ToString()
        Else
            strAction = ""
        End If
        If CType(Session("intProjectID"), Long) > 0 Then
        Else

            'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
            m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(Session("intProjectID").ToString, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

            Dim strQuery As String = ""
            Dim drProjectStatus As IDataReader

            'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
            strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString

            drProjectStatus = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
                If drProjectStatus.Read() Then
                    m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectStatus)
        End If
        If strAction.ToUpper = "IBRETURN" Then
            SaveEfforts()
        End If
    End Sub
    Private Sub SaveEfforts()
        Dim strSQL As String = ""
        If Not Request.QueryString("IssueID") Is Nothing And Request.QueryString("IssueID") <> "" Then
            strSQL = "EXEC Usp_Upd_Efforts_tbl_PM_ScrumPrioritize " + Request.QueryString("IssueID").ToString
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        End If

        'Dim strScrumPrioritizeID As String = ""
        'Dim strEffort As String = ""
        'Dim strRequiredIDArray As String = ""
        'Dim strSQL As String = ""
        ''Dim ScrumPrioritizeID() As String
        ''Dim Effort() As String
        ''Dim selectedScrumPrioritizeID() As String
        ''Dim i As Integer
        ''Dim j As Integer

        ''get Form data.
        'strScrumPrioritizeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("ScrumPrioritizeID"))
        'strEffort = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("Effort"))
        'strRequiredIDArray = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))

        'strSQL = "EXEC Usp_Upd_Efforts_tbl_PM_ScrumPrioritize '" + strScrumPrioritizeID + "','" + strEffort + "','" + strRequiredIDArray + "'"
        'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

        ''ScrumPrioritizeID = strScrumPrioritizeID.Split(",")
        ''Effort = strScrumPrioritizeID.Split(",")
        ''selectedScrumPrioritizeID = strRequiredIDArray.Split(",")

        ''For i = 0 To ScrumPrioritizeID.Length - 1
        ''    For j = 0 To selectedScrumPrioritizeID.Length - 1
        ''        If ScrumPrioritizeID(i) = selectedScrumPrioritizeID(j) Then
        ''            strSQL = ""
        ''            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        ''        End If
        ''    Next
        ''Next
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cEditEfforts_CommonList_PlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New EditEfforts_CommonListCLSQL(MyBase.m_objGlobal)
    End Function
    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
End Class
Class EditEfforts_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        GetPageSpecificFilters += "AND [Effort] <= 0 AND ProjectID=" + CType(objGlobal.ProjectID, String) + " Order by NumericPriority"
    End Function
End Class
Class cEditEfforts_CommonList_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    
    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.DataField.Trim.ToUpper = "TYPE" Then
            If Args.DataReader("Type").ToString.ToUpper = "FEATURE" Then
                Args.StringToBeInserted = "<td align='Left' title='Type' width='50'><IMG src=""../../Images/Scrum/Feature.gif""></td>"
                Cancel = True
            ElseIf Args.DataReader("Type").ToString.ToUpper = "ISSUE" Then
                Args.StringToBeInserted = "<td align='Left' title='Type' width='50'><IMG src=""../../Images/Scrum/Bug.gif""></td>"
                Cancel = True
            ElseIf Args.DataReader("Type").ToString.ToUpper = "STORY" Then
                Args.StringToBeInserted = "<td align='Left' title='Type' width='50'><IMG src=""../../Images/Scrum/UserStory.gif""></td>"
                Cancel = True
            End If
        End If

        If Args.DataReader("Type").ToString.ToUpper = "ISSUE" Then
            Dim strSQL As String
            Dim strFlag As String
            Dim strIssueId As String
            strIssueId = Args.DataReader("EntityID").ToString
            Dim strToken As String = ""
            strToken = CommonFunctions.Security.Token.GetToken(strIssueId + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "0")
            strSQL = "usp_Sel_Flag_tbl_PM_ScrumIssue " + strIssueId
            strFlag = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
            If Args.DataField.ToUpper = "ENTITYID" Then
                If strFlag = "1" Then 'Issue already assign to release
                    'Args.IgnoreActualValue = True
                    'Args.ReplacementValue = "Edit"
                    Cancel = True
                    Args.StringToBeInserted = "<TD  align=Center ><A href=""JavaScript:MapIssue_OnClick('" + strIssueId + "')"" >Edit</A></TD>"
                ElseIf strFlag = "0" Then 'Issue not assign to release
                    Cancel = True
                    Args.StringToBeInserted = "<TD  align=Center ><A href=""JavaScript:MapIssue_OnClick('" + strIssueId + "')"" >Map Issue</A></TD>"
                End If
            End If
            If Args.DataField.ToUpper = "DUMMYCOL" Then
                If strFlag = "1" Then 'Issue already assign to release
                    Cancel = True
                    Args.StringToBeInserted = "<TD  align=Center ><A href=""JavaScript:AssignIssue_OnClick('" + strIssueId + "','" + strToken + "')"" >Assign Issues</A></TD>"
                ElseIf strFlag = "0" Then 'Issue not assign to release
                    Args.IgnoreActualValue = True
                    'Args.ReplacementValue = "Assign Issues"
                End If
            End If
        ElseIf Args.DataReader("Type").ToString.ToUpper = "STORY" Then
            If Args.DataField.ToUpper = "DUMMYCOL" Then
                Args.IgnoreActualValue = True
            End If
            If Args.DataField.ToUpper = "ENTITYID" Then
                Cancel = True
                Args.StringToBeInserted = "<TD  align=Center ><A href=""JavaScript:MapToIteration_OnClick('" + Args.DataReader("EntityID").ToString + "')"" >Map To Iteration</A></TD>"
            End If
        End If

        'If Args.DataField.Trim.ToUpper = "EFFORT" Then
        '    Args.StringToBeInserted = "<td align='Left'>" + CommonFunctions.HTMLControls.DrawTextBox("Effort", "Effort", , 50, 5, Args.DataReader("Effort").ToString(), , , False, , , False, , True) + CommonFunctions.HTMLControls.DrawTextBox("ScrumPrioritizeID", "ScrumPrioritizeID", , 50, 5, Args.DataReader("ScrumPrioritizeID").ToString(), , , False, , , True, , True) + "</TD>"
        '    Cancel = True
        'End If
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "ENTITYID" Or Args.ColumnName.ToUpper = "DUMMYCOL" Then
            Args.ColumnName = ""
        End If
    End Sub
    'Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Args.WhereClause += " 1=1 AND ProjectID=" + CType(WhizGlobal.ProjectID, String)
    End Sub

    Protected Overrides Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        
    End Sub

End Class
