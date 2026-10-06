Imports CommonEngines.General.cEventHandlers
Public Class ProjectTestSet_CommonList
    Inherits CommonList



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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) 'Handles MyBase.Load
        MyBase.strListPage = "ProjectTestSet_CommonList.aspx"
        MyBase.strFormPage = "ProjectTestSet_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here

        
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
       
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        'Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
        Dim m_intFlag As Integer
        m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + CType(HttpContext.Current.Session("intProjectID"), String), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
        CommonFunctions.General.WriteHTML("<INPUT type=hidden id='flgScrumPractice' name='flgScrumPractice' value='" + CType(m_intFlag, String) + "'>")
        'End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
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

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cProjectTestSetPlotGrid(MyBase.m_objGlobal)
    End Function

    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strFunction As String
        If Args.ClientSideFunctionName.ToUpper = "GETLATEST_ONCLICK" Then
            strFunction = "if (confirm('This will amend the existing test set data by the latest revised test set data.\n Do you want to continue?')== false)" + vbCrLf
            strFunction += "{return;} "
            Args.ToBeInserted = strFunction

        End If
    End Sub
End Class
Public Class cProjectTestSetPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
    End Sub



    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strsql As String
        Dim strfunction As String
        Dim intPublished As Integer
        Dim intPreviousPublished As Integer
        Dim strSQLQuery As String
        Dim drCompareRevision As IDataReader

        If Args.DataField.ToUpper = "HYPERLINK1" Then

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
            If (blnAddRight = False) And (blnEditRight = False) Then
                Cancel = True

                CommonFunctions.Data.DisposeDataReader(drAccessRights)

            Else


                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''strsql = "If Exists(SELECT 1  FROM tbl_TCM_ProjectTestSet WHERE  PublishStatus = 1 And ProjectTestSetID = " + CType(Args.DataReader("ProjectTestSetID"), String) + " AND EXISTS (SELECT ProjectTestCaseID  FROM tbl_TCM_ProjectTestCaseDetails WHERE ProjectTestSetID=" + CType(Args.DataReader("ProjectTestSetID"), String) + " ) )  Select 1 Else Select 0"
                strsql = "usp_sel_tbl_TCM_ProjectTestSet_ProjectTestSetID " + CType(Args.DataReader("ProjectTestSetID"), String)

                intPublished = CInt(CommonFunctions.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                If intPublished = 1 Then
                    Args.EnableLink = True
                Else
                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''strsql = "If Exists(SELECT 1  FROM tbl_TCM_ProjectTestSet_Revision  WHERE   ProjectTestSetId = " + CType(Args.DataReader("ProjectTestSetID"), String) + "  AND EXISTS (SELECT 1  FROM tbl_TCM_ProjectTestSet WHERE  PublishStatus = 0 AND ProjectTestSetID=" + CType(Args.DataReader("ProjectTestSetID"), String) + ") )   Select 1 Else Select 0"
                    strsql = "usp_sel_tbl_TCM_ProjectTestSet_Revision_ProjectTestSetId " + CType(Args.DataReader("ProjectTestSetID"), String)

                    intPreviousPublished = CInt(CommonFunctions.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))

                    If intPreviousPublished = 1 Then
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = "<FONT color='RED'>" + "Published" + "</FONT>"
                        Args.EnableLink = False
                    Else
                        Args.EnableLink = False
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = "-"
                    End If

                End If
            End If
        ElseIf Args.ColumnName.ToUpper = "GET LATEST REVISION" Then
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
            If (blnAddRight = False) And (blnEditRight = False) Then
                Cancel = True
            End If
            CommonFunctions.Data.DisposeDataReader(drAccessRights)
        End If


        If Args.ColumnName.ToUpper = "GET LATEST REVISION" Then
            If Args.DataReader("ProjectTestSetID").ToString <> "" Then
                strSQLQuery = "EXEC usp_sel_tbl_TCM_TestSet_GetLatestRevision " & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectTestSetID"), "0"), String)
                drCompareRevision = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                If drCompareRevision.Read Then
                    If CType(drCompareRevision("GetLastest"), String) = "1" Then
                        Args.EnableLink = False
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = "-"
                    End If
                    If CType(drCompareRevision("GetLastest"), String) = "2" Then
                        Args.IgnoreActualValue = True
                        Args.EnableLink = False
                        Args.ReplacementValue = "<FONT color='RED'>" + "Latest" + "</FONT>"
                    End If

                End If
                CommonFunctions.Data.DisposeDataReader(drCompareRevision)
            End If
        End If

    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "HYPERLINK1" Then
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
            If (blnAddRight = False) And (blnEditRight = False) Then
                Cancel = True
            End If
            CommonFunctions.Data.DisposeDataReader(drAccessRights)
        ElseIf Args.ColumnName.ToUpper = "GET LATEST REVISION" Then
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
            If (blnAddRight = False) And (blnEditRight = False) Then
                Cancel = True
            End If
            CommonFunctions.Data.DisposeDataReader(drAccessRights)
        End If
    End Sub
End Class

