Imports CommonEngines.General.cEventHandlers
Public Class SelectCorpoarateDeliverableSLA_CommonList
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
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.strListPage = "SelectCorpoarateDeliverableSLA_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
        MyBase.ApplySecurity(True)


    End Sub
#End Region


    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strSQL As String
        Dim arrComma As Char() = {","c}
        Dim arrComma1 As Char() = {"~"c}
        Dim strChecklistSectionList As String() = DeletedIDList.Split(arrComma)
        Dim strSLADetails As String() = DeletedIDList.Split(arrComma)
        Dim strSLADetailID As String
        Dim IssueTypeID As String
        Dim IssueType As String
        Dim strProjectId As String
        Dim CorporateSLADetailID As String
        Dim strScript As String
        strProjectId = HttpContext.Current.Session("intProjectID").ToString
        For Each strSLADetailID In strChecklistSectionList
            strSLADetails = strSLADetailID.Split(arrComma1)
            IssueTypeID = strSLADetails(1)
            IssueType = strSLADetails(2)
            CorporateSLADetailID = strSLADetails(3)
            strSQL = "usp_Ins_ProjectDeliverable_SLA   " + strProjectId + ", '" + IssueTypeID.ToString + "','" + IssueType + "','" + CorporateSLADetailID.ToString + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Next
        strScript = "<script language = javascript>"
        strScript += "window.close();"
        'MasterTagID=3098
        strScript += "window.opener.document.forms['Form1'].action = 'ProjectLevelDeliverableSLA_CommonList.aspx?FromWhere=PM&MasterTagID=3617';" + vbCrLf
        strScript += "window.opener.document.forms['Form1'].submit();" + vbCrLf
        strScript += "</script>"
        CommonFunction.General.WriteHTML(strScript)
        strActionCode = ReturnCodes.IGNORE_SAVE.ToString
        strActionCode = ReturnCodes.IGNORE_DELETE.ToString
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString

    End Function

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

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Select Case Args.ClientSideFunctionName.ToUpper
            Case "CLOSE_ONCLICK"
                Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                Args.ToBeInsertedInFunction += "return;"
            Case "CORPORATESLA_ONCLICK"
                Dim strFunction As String
                With Args
                    .ToBeInsertedInFunction += " var objVerify;" + vbCrLf
                    .ToBeInsertedInFunction += " var intctr;" + vbCrLf
                    .ToBeInsertedInFunction += " var objForm;" + vbCrLf
                    .ToBeInsertedInFunction += " var strVal; " + vbCrLf
                    .ToBeInsertedInFunction += " var bSubmit; " + vbCrLf
                    .ToBeInsertedInFunction += " bSubmit = false; " + vbCrLf

                    .ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonList');" + vbCrLf
                    .ToBeInsertedInFunction += " objVerify = GetObjectReference('frmCommonList','chkDelete',true); " + vbCrLf

                    .ToBeInsertedInFunction += "    if(objVerify!=null) " + vbCrLf
                    .ToBeInsertedInFunction += "    { " + vbCrLf

                    .ToBeInsertedInFunction += "    if(objVerify.length == 0)" + vbCrLf
                    .ToBeInsertedInFunction += "        return;" + vbCrLf

                    .ToBeInsertedInFunction += "        if(objVerify.length > 1)" + vbCrLf
                    .ToBeInsertedInFunction += "        { " + vbCrLf
                    .ToBeInsertedInFunction += "            for(i=0;i<=objVerify.length-1;i++)" + vbCrLf
                    .ToBeInsertedInFunction += "            { " + vbCrLf
                    .ToBeInsertedInFunction += "                if (objVerify[i].checked == true) " + vbCrLf
                    .ToBeInsertedInFunction += "                { " + vbCrLf
                    .ToBeInsertedInFunction += "                    bSubmit = true; " + vbCrLf
                    .ToBeInsertedInFunction += "                    break; " + vbCrLf
                    .ToBeInsertedInFunction += "                } " + vbCrLf
                    .ToBeInsertedInFunction += "            } " + vbCrLf
                    .ToBeInsertedInFunction += "        } " + vbCrLf
                    .ToBeInsertedInFunction += "        else " + vbCrLf
                    .ToBeInsertedInFunction += "        { " + vbCrLf
                    .ToBeInsertedInFunction += "            if (frmCommonList.chkDelete.checked == true) " + vbCrLf
                    .ToBeInsertedInFunction += "                bSubmit = true; " + vbCrLf
                    .ToBeInsertedInFunction += "        } " + vbCrLf

                    .ToBeInsertedInFunction += " if (bSubmit==true) " + vbCrLf
                    .ToBeInsertedInFunction += " { " + vbCrLf
                    .ToBeInsertedInFunction += "    var bConfirmed; " + vbCrLf
                    .ToBeInsertedInFunction += "    bConfirmed = window.confirm('Are you sure you want to inherit the selected SLA to Project Level?');" + vbCrLf
                    .ToBeInsertedInFunction += "    if (bConfirmed == false) " + vbCrLf
                    .ToBeInsertedInFunction += "        return;" + vbCrLf
                    .ToBeInsertedInFunction += "    else " + vbCrLf
                    .ToBeInsertedInFunction += "    {" + vbCrLf
                    '.ToBeInsertedInFunction += "        objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET, String) + " &Verify=True';" + vbCrLf
                    '.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                    '.ToBeInsertedInFunction += "objfrm.action = '../General/Commonlist.aspx?Operation=DELETE&MasterTagID=3585&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1;'" + vbCrLf
                    '.ToBeInsertedInFunction += " objfrm.action = '../General/CLCP_AdvanceFilters.aspx?Mode=ADD_NEW&MasterTagID=1017&TagID=3585&ParentTagID=0&FromCL=1?Operation=DELETE&MasterTagID=3585&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1;'" + vbCrLf

                    .ToBeInsertedInFunction += "objfrm.action='../Process/SelectCorpoarateDeliverableSLA_CommonList.aspx?Operation=DELETE&MasterTagID=3624&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1;'" + vbCrLf
                    '--.ToBeInsertedInFunction += "objfrm.action='../General/CommonList.aspx?Operation=DELETE&MasterTagID=3624&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1;'" + vbCrLf
                    .ToBeInsertedInFunction += "objfrm.submit();" + vbCrLf

                    '.ToBeInsertedInFunction += "        return;" + vbCrLf
                    .ToBeInsertedInFunction += "    } " + vbCrLf
                    .ToBeInsertedInFunction += "} " + vbCrLf
                    .ToBeInsertedInFunction += " else " + vbCrLf
                    .ToBeInsertedInFunction += " { " + vbCrLf
                    .ToBeInsertedInFunction += "    alert('Please select SLA.')  " + vbCrLf
                    .ToBeInsertedInFunction += "    return; " + vbCrLf
                    .ToBeInsertedInFunction += " } " + vbCrLf

                    .ToBeInsertedInFunction += " } " + vbCrLf  'objverify!=null 
                    .ToBeInsertedInFunction += " return; " + vbCrLf
                End With
        End Select

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
End Class
