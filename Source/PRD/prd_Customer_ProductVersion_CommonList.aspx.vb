Imports CommonEngines.General.cEventHandlers
Public Class cPRD_Customer_ProductVersion_CommonList
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
        MyBase.strListPage = "PRD_Customer_ProductVersion_CommonList.aspx"
        MyBase.strFormPage = "PRD_Customer_ProductVersion_CommonList.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cPRD_Customer_ProductVersion_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cPRD_Customer_ProductVersion_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        '' Added By KapilGK 24-May-2006
        '' Purpose : RoamWare Customization
        
        Dim StrselectedComponenets As String = ""
        Dim strProductVersionID As String = "0"

        strProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProductVersionID"), "0")
        'Dim strSql As String
        Dim strProjectID As String = "0"

        StrselectedComponenets = HttpContext.Current.Request.Form("ChkDelete")
        Dim CustomerNumber As String = HttpContext.Current.Request.Form("cboCustomer")
        Dim strmode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "0")
        Dim strScript As String = ""
        If strmode = "SAVE" Then
            If CustomerNumber <> "" Then
                If StrselectedComponenets <> "" Then
                    'CommonFunction.Data.InsertOrUpdateData("Usp_INS_Tbl_PRD_Customer_ProductVersion " + CustomerNumber + " , '" + StrselectedComponenets + "'", True)
                    strScript = vbCrLf + "<Script language=javascript>"
                    strScript += vbCrLf + "    refreshParent('frmCommonList','CommonList.aspx','../General/CommonList.aspx?FromWhere=SM&MasterTagId=3698');"
                    strScript += vbCrLf + "</Script>"
                    CommonFunction.General.WriteHTML(strScript)
                End If
            End If
        End If
       
        '' END : Added By KapilGK on 24-May-2006

    End Function

    Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        '' Added By KapilGK 24-May-2006
        '' Purpose : RoamWare Customization

        If Args.SectionID = 1 Then
            Dim CustomerNumber As String = ""
            Dim strSQL, Uid As String
            Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "")
            If strMode = "First" Then
                CustomerNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CNo"), "")
            End If
            If strMode = "Change" Then
                CustomerNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), "")
            End If
            If strMode = "SAVE" Then
                CustomerNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), "")
            End If

            Dim strHtml As String
            strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
            strHtml += "<tr class=clsTREven><td align=right>Customer Name &nbsp;</td><td align=left>"
            strHtml += CommonFunction.HTMLControls.DrawComboBox("cboCustomer", "usp_sel_tbl_PM_Customer ", 300, CustomerNumber, "onChange='CustomerOnChange()'", True, True)
            strHtml += "</td></tr></table><br>"
            CommonFunction.General.WriteHTML(strHtml)
        End If

        '' END : Added By KapilGK on 24-May-2006

    End Sub
    'Added BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 
    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        Dim StrselectedComponenets As String = ""
        Dim strProductVersionID As String = "0"

        strProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProductVersionID"), "0")
        Dim strSql As String
        Dim strProjectID As String = "0"

        StrselectedComponenets = HttpContext.Current.Request.Form("ChkDelete")
        Dim CustomerNumber As String = HttpContext.Current.Request.Form("cboCustomer")
        Dim strmode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "0")
        'Dim strScript As String = ""
        If strmode = "SAVE" Then
            If CustomerNumber <> "" Then
                If StrselectedComponenets <> "" Then
                    CommonFunction.Data.InsertOrUpdateData("Usp_INS_Tbl_PRD_Customer_ProductVersion " + CustomerNumber + " , '" + StrselectedComponenets + "'", True)
                    'strScript = vbCrLf + "<Script language=javascript>"
                    'strScript += vbCrLf + "    refreshParent('frmCommonList','CommonList.aspx','../General/CommonList.aspx?FromWhere=SM&MasterTagId=3698');"
                    'strScript += vbCrLf + "</Script>"
                    'CommonFunction.General.WriteHTML(strScript)
                End If
            End If
        End If
    End Sub
    'End Added BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 
End Class


Public Class cPRD_Customer_ProductVersion_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class


Class cPRD_Customer_ProductVersion_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        ''' Added By KapilGk 26-May-2006
        ''' Purpose : RoamWare Cutomization
        Dim CustomerNumber As String
        Dim strHtml As String
        Dim Uid As String = CStr(HttpContext.Current.Session("intUserID"))
        Dim strSQL As String

        Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "")
        If strMode = "First" Then
            CustomerNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CNo"), "")
            If CustomerNumber <> "" Then

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strSQL = "SELECT FixedValue FROM Tbl_UI_EmployeeFilterSettings_fieldDetails  WHERE "
                'strSQL += "TagID = 3698 AND UserID =" + Uid + " and ControlName = 'Customer'"
                ''Updated by Dhanashri S on 17 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
                strSQL = "usp_sel_Tbl_UI_EmployeeFilterSettings_fieldDetails_FixedValue " + Uid
                ''End of updation by Dhanashri S on 17 Aug 2016 
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                CustomerNumber = CStr(CommonFunction.Data.CheckIsDBNull(CType(CommonFunctions.Data.GetDataScalar(strSQL, True).ToString, String), ""))
            End If
        End If

        If strMode = "Change" Then
            CustomerNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), "")
        End If

        If strMode = "SAVE" Then
            CustomerNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), "")
        End If

        GetPageSpecificFilters += " AND ( ProductVersionID NOT IN (SELECT ProductVersionID FROM tbl_PRD_Customer_ProductVersion "
        If Not CustomerNumber Is Nothing And CustomerNumber <> "" Then
            GetPageSpecificFilters += " WHERE Customer = " + CustomerNumber
        End If
        GetPageSpecificFilters += " ))"

        '' END : Added By KapilGk 26-May-2006

    End Function
End Class