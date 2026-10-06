Imports CommonEngines.General.cEventHandlers
Public Class cPRD_CustomerVersionComponents_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "
    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "PRD_CustomerVersionComponents_CommonList.aspx"
        'MyBase.strFormPage = "PRD_CustomerVersionComponents_CommonList.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub
#End Region

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cPRD_CustomerVersionComponents_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cPRD_CustomerVersionComponents_CommonListCLSQL(MyBase.m_objGlobal)
    End Function


    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        '' Added By KapilGK 29-May-2006
        '' Purpose : RoamWare Customization
        Dim StrselectedComponenets As String = ""
        Dim strCustomerProductVersionID As String = "0"
        Dim strMode As String
        strCustomerProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerProductVersionID"), "0")
        StrselectedComponenets = HttpContext.Current.Request.Form("ChkDelete")
        strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "")
        Dim strScript As String = ""
        'If strCustomerProductVersionID <> "0" And strMode = "SAVE" Then
        '    CommonFunction.Data.InsertOrUpdateData("Usp_INS_tbl_PRD_Customer_ProductVersionComponents " + strCustomerProductVersionID + " , '" + StrselectedComponenets + "'", True)
        'End If
        If strMode = "SAVE" Then
            strScript = vbCrLf + "<Script language=javascript>"
            strScript += vbCrLf + "    refreshParent('frmCommonPage','CommonPage.aspx','../PRD/PRD_CustomerProductExecution_AMC_CommonPage.aspx?FromWhere=SM&MasterTagId=3698');"
            strScript += vbCrLf + "</Script>"
            CommonFunction.General.WriteHTML(strScript)
        End If
        '' END : Added By KapilGK on 29-May-2006
    End Function

   
    ' Added bY NitinVS on 28 Jun 2007 for WhizbileSEM 7 
    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        Dim StrselectedComponenets As String = ""
        Dim strCustomerProductVersionID As String = "0"
        Dim strMode As String
        strCustomerProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerProductVersionID"), "0")
        StrselectedComponenets = HttpContext.Current.Request.Form("ChkDelete")
        strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "")
        'Dim strScript As String = ""
        If strCustomerProductVersionID <> "0" And strMode = "SAVE" Then
            CommonFunction.Data.InsertOrUpdateData("Usp_INS_tbl_PRD_Customer_ProductVersionComponents " + strCustomerProductVersionID + " , '" + StrselectedComponenets + "'", True)
        End If
        If strMode = "SAVE" Then
            'strScript = vbCrLf + "<Script language=javascript>"
            'strScript += vbCrLf + "    refreshParent('frmCommonPage','CommonPage.aspx','../PRD/PRD_CustomerProductExecution_AMC_CommonPage.aspx?FromWhere=SM&MasterTagId=3698');"
            'strScript += vbCrLf + "</Script>"
            'CommonFunction.General.WriteHTML(strScript)
        End If
    End Sub
    ' End Addition bY NitinVS on 28 Jun 2007 for WhizbileSEM 7 
End Class


Public Class cPRD_CustomerVersionComponents_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class


Class cPRD_CustomerVersionComponents_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        ''' Added By KapilGk 29-May-2006
        ''' Purpose : RoamWare Cutomization
        Dim CustomerProductVersionID As String
        Dim strProductVersionID As String
        Dim strSQL As String
        Dim strScript As String
        Dim strCustomerID As String
        CustomerProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerProductVersionID"), "")
        If CustomerProductVersionID <> "" Then

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT ProductVersionID FROM Tbl_PRD_Customer_ProductVersion where CustomerProductVersionID=" + CustomerProductVersionID
            strSQL = "usp_sel_Tbl_PRD_Customer_ProductVersion_ProductVersionID " + CustomerProductVersionID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            strProductVersionID = CStr(CommonFunction.Data.CheckIsDBNull(CType(CommonFunctions.Data.GetDataScalar(strSQL, True).ToString, String), ""))

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT Customer FROM Tbl_PRD_Customer_ProductVersion WHERE CustomerProductVersionID=" + CustomerProductVersionID
            strSQL = "usp_sel_Tbl_PRD_Customer_ProductVersion_Customer " + CustomerProductVersionID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


            strCustomerID = CStr(CommonFunction.Data.CheckIsDBNull(CType(CommonFunctions.Data.GetDataScalar(strSQL, True).ToString, String), ""))
            GetPageSpecificFilters += " AND ( ( ProductVersionID = " + strProductVersionID + " AND CustomerID = " + strCustomerID + " ) OR ("
            GetPageSpecificFilters += " ProductVersionID is null and CustomerID is null and ComponentID not in ("
            GetPageSpecificFilters += "SELECT ComponentID FROM tbl_PRD_Customer_ProductVersionComponents WHERE ProductVersionID =" + strProductVersionID + " AND CustomerID = " + strCustomerID + " )))"

        End If
        '' END : Added By KapilGk 29-May-2006
    End Function
End Class

