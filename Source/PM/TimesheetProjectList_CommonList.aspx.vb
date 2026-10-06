Imports CommonEngines.General.cEventHandlers
Public Class TimesheetProjectList_CommonList
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "TimesheetProjectList_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        

        MyBase.Page_Load(sender, e)
    End Sub


    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strProjectID As String = ""
        If CommonFunction.General.CheckIsNothing(Request.QueryString("cboProjectID")) <> "" Then
            strProjectID = CommonFunction.General.CheckIsNothing(Request.QueryString("cboProjectID"))
        Else
            strProjectID = CommonFunction.General.CheckIsNothing(Request.Form("txtHidProjectID"))
        End If

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHidProjectID", "txtHidProjectID", , , , strProjectID, , , , , , True, , True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015

    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New TSProjectSelection_CommonListCLSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New TSProjectSelection_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

End Class
Public Class TSProjectSelection_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strProjectIDs As String

        strProjectIDs = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_AccessibleProjectLists 'ProjectID'," + CType(HttpContext.Current.Session("intUserID"), String) + "," + CType(HttpContext.Current.Session("LoginType"), String) + "," + CType(HttpContext.Current.Session("intRoleLevel"), String) + ",0," + CType(HttpContext.Current.Session("intLoginID"), String), True), "0"), String)
        GetPageSpecificFilters = ""

        If strProjectIDs <> "" Then
            GetPageSpecificFilters += " AND ProjectID IN (" + strProjectIDs + ")"
        End If

    End Function
End Class

Public Class TSProjectSelection_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Protected strProjectID As String = ""
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("cboProjectID")) <> "" Then
            strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("cboProjectID"))
        Else
            strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidProjectID"))
        End If
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "PROJECTNAME" Then
            Cancel = True
            Args.StringToBeInserted += "<td align=left >"
            Args.StringToBeInserted += "<a href='javascript:Project_OnClick(this," + CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID")).ToString + ")'>"
            If CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0") = strProjectID Then
                Args.StringToBeInserted += "<b>" + CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName")) + "</b>"
            Else
                Args.StringToBeInserted += CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"))
            End If

            Args.StringToBeInserted += "</A>"
            Args.StringToBeInserted += "</td>"
        End If
    End Sub
    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        
        If CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0") = strProjectID Then
            Args.clsTR = "clsTRGroupHeader"
        End If
    End Sub
End Class
