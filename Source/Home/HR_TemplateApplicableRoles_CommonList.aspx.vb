Imports CommonEngines.General.cEventHandlers
Public Class HR_TemplateApplicableRoles_CommonList
    Inherits CommonList


    Public m_strParentTagID As String
    Public m_strTemplateID As String
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
        MyBase.strListPage = "HR_TemplateApplicableRoles_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        ' strActionCode = Whiz.CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
        Dim strSelectedRoles() As String = DeletedIDList.Split(Convert.ToChar(","))
        Dim intTemplateID As Integer

        Dim i As Integer
        Dim strSelectedRole As String = ""
        Dim strSQL As String = ""
        Dim m_strParentTagID As String
        Dim intParentTagID As Integer
        'intTemplateID = CommonFunction.General.CheckIsNothing(Request.QueryString("TemplateID"), "")
        m_strTemplateID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TemplateID"), "0")
        If m_strTemplateID = "0" Or m_strTemplateID = "" Then
            m_strTemplateID = CommonFunction.General.CheckIsNothing(Request.Form("txthidTemplateID"), "")
        End If
        intTemplateID = Convert.ToInt32(m_strTemplateID)

        m_strParentTagID = CommonFunction.General.CheckIsNothing(Request.QueryString("ParentID"), "")
        If m_strParentTagID = "" Then
            m_strParentTagID = CommonFunction.General.CheckIsNothing(Request.Form("txthidParentTagID"), "")
        End If
        intParentTagID = Convert.ToInt32(m_strParentTagID)

        For i = 0 To strSelectedRoles.Length - 1
            strSelectedRole = Convert.ToInt32(strSelectedRoles(i))
            If intParentTagID = 3951 Then
                strSQL = "exec usp_Ins_tbl_HR_TemplateMaster_ApplicableRoles " & intTemplateID & "," & strSelectedRole
            End If
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strSQL = Nothing
        Next

        Response.Write("<script language= javascript> " + vbCrLf)

        If intParentTagID = 3951 Then
            'Response.Write(" window.opener.location.href='../General/CommonPage.aspx?TemplateID_PK=" + strTemplateID + "&PKToken=oPtT8CbTJgi4whWNsM3G4g&MasterTagID=2272&FromWhere=PA&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';")
            CommonFunctions.General.WriteHTML("window.opener.document.forms['frmCommonPage'].action = '../General/CommonPage.aspx?TemplateID_PK=" + m_strTemplateID + "&MasterTagID=3951&FromWhere=PA&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';" + vbCrLf)
            CommonFunctions.General.WriteHTML("window.opener.document.forms['frmCommonPage'].submit();" + vbCrLf)

        End If
        CommonFunctions.General.WriteHTML("window.close(); " + vbCrLf)
        Response.Write("</script>")

        strActionCode = Whiz.CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
        Return ""
    End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = Whiz.CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        ' strActionCode = ReturnCodes.DO_NOTHING.ToString
        m_strTemplateID = CommonFunction.General.CheckIsNothing(Request.QueryString("TemplateID"), "")
        If m_strTemplateID = "" Or m_strTemplateID = "0" Then
            m_strTemplateID = CommonFunction.General.CheckIsNothing(Request.Form("txthidTemplateID"), "")
        End If
        CommonFunction.General.WriteHTML("<input type=hidden id=txthidTemplateID name=txthidTemplateID value=" + m_strTemplateID + ">")

        m_strParentTagID = CommonFunction.General.CheckIsNothing(Request.QueryString("ParentID"), "")
        If m_strParentTagID = "" Then
            m_strParentTagID = CommonFunction.General.CheckIsNothing(Request.Form("txthidParentTagID"), "")
        End If
        CommonFunction.General.WriteHTML("<input type=hidden id=txthidParentTagID name=txthidParentTagID value=" + m_strParentTagID + ">")

        Return ""
    End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "DELETE_ONCLICK" Then
            Args.ToBeInsertedInFunction = "" + vbCrLf
            Args.ToBeInsertedInFunction += " if (!ValidateControl()) return;" + vbCrLf
            Args.ToBeInsertedInFunction += "" + vbCrLf
        End If
        If Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
            Args.ToBeInsertedInFunction = "" + vbCrLf
            Args.ToBeInsertedInFunction += " if (!ValidateControlSaveADD()) return;" + vbCrLf
            Args.ToBeInsertedInFunction += "" + vbCrLf
        End If
    End Sub

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

    'addition end by ninad ' Requirement Tag :WAF3_PB_33 
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cCommmonList_Template_SelectRoles(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cCommmonList_TemplateSelectRolesPlotGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class cCommmonList_Template_SelectRoles
    Inherits CommonEngine.CommonList.cCLSQL
    Public m_strTemplateID As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim intTemplateID As Integer
        Dim intParentTagID As Integer
        intTemplateID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TemplateID"), "0"), Integer)
        intParentTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ParentID"), "0"), Integer)
        If intParentTagID = 0 Then
            Dim strParentID As String
            strParentID = HttpContext.Current.Request.Form("txthidParentTagID")
            intParentTagID = Convert.ToInt32(strParentID)
        End If
        
        If intTemplateID = 0 Then
            Dim strTemplateID As String
            m_strTemplateID = HttpContext.Current.Request.Form("txthidTemplateID")
            intTemplateID = Convert.ToInt32(m_strTemplateID)
        End If
        m_strTemplateID = intTemplateID.ToString
        'If intTemplateID <> "" Then
        CommonFunction.General.WriteHTML("<input type=hidden id=txthidTemplateID name=txthidTemplateID value=" + intTemplateID.ToString + ">")
        'End If
        If intParentTagID = 3951 Then
            Args.GridSQL = "usp_Sel_tbl_PM_TemplateApplicableRoles " + intTemplateID.ToString


        End If
    End Sub
End Class




Public Class cCommmonList_TemplateSelectRolesPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim intDocumentId As Integer = 0
    Dim strWeight As String = ""
    Dim strDefaultRating As String = ""
    Dim strValueDriver As String = ""
    Dim strRuleDesc As String = ""
    Dim strRuleID As String = ""
    Dim strtargets As String = ""
    Dim strEmployeeValueDriverIDs As String = ""
    Dim strSelectedRoles As String = ""
    Dim intTemplateID As Integer
    Dim intParentTagID As Integer
    Dim drSelectedRoles As IDataReader


    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        'intTemplateID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TemplateID"), "0"), Integer)
        'intParentTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ParentID"), "0"), Integer)
        'If intParentTagID = 0 Then
        '    Dim strParentID As String
        '    strParentID = HttpContext.Current.Request.Form("txthidParentTagID")
        '    intParentTagID = Convert.ToInt32(strParentID)
        'End If
        'If intTemplateID = 0 Then
        '    Dim strTemplateID As String
        '    strTemplateID = HttpContext.Current.Request.Form("txthidTemplateID")
        '    intTemplateID = Convert.ToInt32(strTemplateID)
        'End If
        'If intParentTagID = 2699 Then
        '    drSelectedRoles = CommonFunction.Data.GetDataReader("usp_sel_tbl_HR_DocumentsRole " + intTemplateID.ToString, True)
        '    While drSelectedRoles.Read
        '        strSelectedRoles = strSelectedRoles + drSelectedRoles("RoleID").ToString + ","
        '    End While
        'End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim arrSelectedRoles As String() = strSelectedRoles.Split(",")
        Dim intCount As Integer = 0
        Dim blnChk As Boolean = False
        If intParentTagID = 3955 Then
            If Args.ColumnName.ToUpper = "SELECT" Then
                For intCount = 0 To arrSelectedRoles.Length - 2
                    If Args.DataReader("RoleID") = CInt(arrSelectedRoles(intCount)) Then
                        blnChk = True
                        Exit For
                    Else
                        blnChk = False
                    End If
                Next
                Cancel = True
                Args.StringToBeInserted = "<TD ALIGN=CENTER>" + CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", "clsCheckBox", IIf(blnChk, "True", "False"), Args.DataReader("RoleID").ToString, , , True)
            End If
        End If
    End Sub
End Class
