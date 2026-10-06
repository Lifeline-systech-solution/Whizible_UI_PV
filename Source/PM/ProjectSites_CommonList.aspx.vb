Imports System
Imports CommonEngines.General.cEventHandlers
Public Class ProjectSites_CommonList
    Inherits CommonList
    Private IsDeleteOperation As Boolean = False
    'Added by sonalD on 4rth October 2008
    Private m_script As Integer = 0
    'Added by SonalD on 15nth March 2009
    Private m_blnScript As Boolean = False
    'End of addition by SonalD on 15th March 2009
    Private strSiteName As String
    'End of addition by sonalD on 4rth October 2008

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
        MyBase.strListPage = "ProjectSites_CommonList.aspx"
        'MyBase.strFormPage = "CommonPage.aspx"
        'MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New c_ProjectSites_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
  
    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim chkDelete() As String
        Dim Iterator As Integer
        Dim strQuery As String
        Dim intProjectID As Integer
        Dim strHTML As System.Text.StringBuilder
        Dim dr As IDataReader

        intProjectID = HttpContext.Current.Session("intProjectID")
        If DeletedIDList <> "" Then
            chkDelete = DeletedIDList.Split(","c)
            For Iterator = 0 To chkDelete.Length - 1
                'Added by SonalD on 4rth October 2008
                'strQuery = "SELECT Name from tbl_PM_ProjectSites where Name=(SELECT projectcosttype FROM tbl_cnf_projectcosttype WHERE ProjectCostTypeID=" + chkDelete(Iterator) + ") AND ProjectID=" + intProjectID.ToString
                strQuery = "usp_sel_tbl_PM_ProjectSites_Name " + chkDelete(Iterator) + "," + intProjectID.ToString
                strSiteName = CommonFunction.Data.GetDataScalar(strQuery, True)

                If strSiteName Is Nothing Then
                    'End of addition By SonalD on 4rth October 2008
                    strQuery = "usp_INS_tbl_PM_ProjectSites_tbl_CNF_ProjectCostType " + intProjectID.ToString + "," + chkDelete(Iterator)
                    CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                Else
                    m_script = 1
                End If
                'strQuery = "usp_del_tbl_PM_ProjectSites_ProjectCostType '" + DeletedIDList + "'"
                'CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next
        End If
        
        If DeletedIDList = "" Then
            'Commented by SonalD on 15th March 2009
            'strQuery = "DELETE FROM tbl_PM_ProjectSites WHERE ProjectCostTypeID IS NOT NULL  "
            'CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            'DeletedIDList = "0"
            'End of comment by SonalD on 15th March 2008
            'Added by SonalD on 15th March 2009
            m_blnScript = True
            'End of addition by SonalD on 15th March 2009
        End If
        IsDeleteOperation = True

        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = Whiz.CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim chkDelete As String
        chkDelete = Request.Form("chkDelete")
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If IsDeleteOperation = True Then
            CommonFunction.General.WriteHTML("<script language='javascript'>")
            If m_script = 1 Then
                CommonFunction.General.WriteHTML("alert('Site already exists');")
            End If
            'Modified by SonalD on 15th March 2009
            If m_blnScript = True Then
                CommonFunction.General.WriteHTML("alert('Please select the site');")
            Else
                CommonFunction.General.WriteHTML("refreshParent(""frmCommonList"",""CommonList.aspx"",""../General/CommonList.aspx?MasterTagId=2251"");")
                CommonFunction.General.WriteHTML("window.close();")
                'Added by sonalD
            End If
            'End of addition by SonalD
            'End of modification by SonalD on 15th March 2009
            CommonFunction.General.WriteHTML("</script>")
        End If
            strActionCode = ReturnCodes.DO_NOTHING.ToString

    End Function


    Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName = "Delete" Then
            Args.LinkName = "Save"
        End If
    End Sub

    Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    End Sub

    Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    End Sub

    Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    End Sub

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    End Sub

    Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    End Sub

    Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    End Sub


    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub
    'added by ninad ' Requirement Tag :WAF3_PB_33 
    'Protected Overrides Sub WhizForm_Init()

    'End Sub
    'addition end by ninad ' Requirement Tag :WAF3_PB_33 
End Class
Public Class c_ProjectSites_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strID As String
        strID = HttpContext.Current.Request.Form("chkDelete")
    End Sub
    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strID As String
        strID = HttpContext.Current.Request.Form("chkDelete")
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strProjectCostTypeID As String
        Dim id As String

        If Args.ColumnName.ToUpper = "SELECT" Then
            strProjectCostTypeID = Args.DataReader("ProjectCostTypeID").ToString + ""
            id = CommonFunction.Data.GetDataScalar("USP_sel_tbl_PM_ProjectSites_Flag " + strProjectCostTypeID + "," + HttpContext.Current.Session("intProjectID").ToString, True)

            If id = 1 Then
                'Draw CheckBox selected
                Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value=" + strProjectCostTypeID + " ></TD>"
                Cancel = True
            End If

        End If
    End Sub
    'Addition by SuchitraP on 3-Oct-2008 
    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strProjectCostTypeID As String
        Dim id As String

        strProjectCostTypeID = Args.DataReader("ProjectCostTypeID").ToString + ""
        id = CommonFunction.Data.GetDataScalar("USP_sel_tbl_PM_ProjectSites_Flag " + strProjectCostTypeID + "," + HttpContext.Current.Session("intProjectID").ToString, True)

        If id = 1 Then
            Cancel = True
        End If

    End Sub
    'End by SuchitraP
End Class
