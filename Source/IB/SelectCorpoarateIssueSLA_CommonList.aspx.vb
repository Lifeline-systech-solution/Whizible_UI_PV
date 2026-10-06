Option Strict Off
Imports CommonEngines.General.cEventHandlers
'Added By Usha Pandit On 01.04.2020 For avoiding duplicate records
Imports System.Linq
'End Of Added By Usha Pandit On 01.04.2020 For avoiding duplicate records

Public Class SelectCorpoarateIssueSLA_CommonList
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
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "SelectCorpoarateIssueSLA_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region


    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strSQL As String
        Dim arrComma As Char() = {","c}
        Dim arrComma1 As Char() = {"~"c}
        'Commented And Added By Usha Pandit On 01.04.2020 For avoiding duplicate records
        'Dim strList As String() = DeletedIDList.Split(arrComma)
        'Dim strSLADetails As String() = DeletedIDList.Split(arrComma)
        Dim strList As String() = DeletedIDList.Split(arrComma).Distinct().ToArray()
        Dim strSLADetails As String() = DeletedIDList.Split(arrComma).Distinct().ToArray()
        'End Of Added By Usha Pandit On 01.04.2020 For avoiding duplicate records

        Dim strSLADetailID As String
        Dim IssueTypeID As String
        Dim IssueType As String
        Dim strProjectId As String
        Dim CorporateSLADetailID As String
        Dim strScript As String
        Dim CustomerID As String
        strProjectId = HttpContext.Current.Session("intProjectID").ToString
        For Each strSLADetailID In strList
            strSLADetails = strSLADetailID.Split(arrComma1)
            IssueTypeID = Replace(strSLADetails(2), "'", "")
            IssueType = strSLADetails(3)
            CorporateSLADetailID = Replace(strSLADetails(4), "'", "")
            CustomerID = strSLADetails(1)
            strSQL = "usp_Ins_ProjectCustomer_SLA   " + strProjectId + ",'" + CustomerID + "','" + IssueTypeID + "','" + IssueType + "','" + CorporateSLADetailID + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Next
        ' strScript = "<script language = 'javascript'>"
        ' strScript += "window.opener.document.forms['frmSelectCorporateSLA'].action = 'ProjectlevelSLADefinition_CommonList.aspx?FromWhere=PM&MasterTagID=3098';" + vbCrLf
        ' strScript += "window.opener.document.forms['frmSelectCorporateSLA'].submit();" + vbCrLf
        'strScript = " refreshParent('frmProjectSLA', 'ProjectlevelSLADefinition_CommonList.aspx','ProjectlevelSLADefinition_CommonList.aspx?FromWhere=PM&MasterTagID=3098');"
        'strScript = " window.opener.document.forms['frmProjectSLA'].action = 'ProjectlevelSLADefinition_CommonList.aspx?FromWhere=PM&MasterTagID=3574';" + vbCrLf
        'strScript += " window.opener.document.forms['frmProjectSLA'].submit(); "
        'strScript += " window.close(); "
        '' strScript += "</script>"
        'BeforeDelete = strScript
        'CommonFunction.General.WriteHTML(strScript)
        strActionCode = ReturnCodes.IGNORE_DELETE.ToString

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

                    .ToBeInsertedInFunction += "objfrm.action='../IB/SelectCorpoarateIssueSLA_CommonList.aspx?Operation=DELETE&MasterTagID=3611&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1;'" + vbCrLf
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


                'Args.ToBeInsertedInFunction += "var blnIsRecordSelected=false;" + vbCrLf
                'Args.ToBeInsertedInFunction += "var Count = frmCommonList.chkDelete.length ;" + vbCrLf
                'Args.ToBeInsertedInFunction += "for(intCnt = 0;intCnt<=Count-1;intCnt++)" + vbCrLf
                'Args.ToBeInsertedInFunction += "{" + vbCrLf
                'Args.ToBeInsertedInFunction += "if (objfrm.chkDelete[intCnt].checked == true )" + vbCrLf
                'Args.ToBeInsertedInFunction += "{blnIsRecordSelected = true; break;}" + vbCrLf
                'Args.ToBeInsertedInFunction += "}" + vbCrLf
                'Args.ToBeInsertedInFunction += "if (blnIsRecordSelected == false) {" + vbCrLf
                'Args.ToBeInsertedInFunction += "alert('Please select at least one SLA');" + vbCrLf
                'Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                'Args.ToBeInsertedInFunction += "if (confirm('Are you sure you want to inherite the selected SLA to Project Level?'))" + vbCrLf
                'Args.ToBeInsertedInFunction += "{" + vbCrLf
                'Args.ToBeInsertedInFunction += "objfrm.action = 'Commonlist.aspx?Operation=DELETE&MasterTagID=3101&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1;'" + vbCrLf
                'Args.ToBeInsertedInFunction += "objfrm.submit();" + vbCrLf
                'Args.ToBeInsertedInFunction += "}" + vbCrLf
                'Args.ToBeInsertedInFunction += "return;" + vbCrLf
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

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strScript As String
        'Refresh Parent for Filters
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("RefreshCL")) = "1" Or _
            CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToUpper = "DELETE" Then
            'Modified and Update By JyotiG
            'Issue ID : 6458
            'Date : 28-Sep-2006
            'Start
            'Added  By Dipali V On 31st March 2020 For Java Script Issues
            strScript = "if(window.opener!=undefined || window.opener!=null){"
            'End of Added  By Dipali V On 31st March 2020 For Java Script Issues
            'strScript = " window.opener.document.forms['frmProjectSLA'].action = 'ProjectlevelSLADefinition_CommonList.aspx?FromWhere=PM&MasterTagID=3574';" + vbCrLf
            strScript = " window.opener.document.forms['frmCommonList'].action = 'ProjectlevelSLADefinition_CommonList.aspx?FromWhere=PM&MasterTagID=3574';" + vbCrLf
            'strScript += " window.opener.document.forms['frmProjectSLA'].submit(); "
            strScript += " window.opener.document.forms['frmCommonList'].submit(); "
            'End
            strScript += " window.close(); }"

            PageListPostRender = strScript
            strActionCode = ReturnCodes.ON_LOAD.ToString

        End If
    End Function

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cSelectCorporateSLA_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class cSelectCorporateSLA_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strProjectId As String
        Dim strProjectCustomerID As String
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim blnUseSQL As Boolean = True
        strProjectId = HttpContext.Current.Session("intProjectID").ToString
        strSQL = "SELECT CustomerID FROM tbl_PM_Project  WHERE  tbl_PM_Project.ProjectID='" + strProjectId + "'"
        objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
        If objDr.Read Then
            strProjectCustomerID = objDr("CustomerID").ToString
        End If
        If Args.DataReader("IsIssueCustomerPresent") = "0" Then
            If Args.DataReader("CustomerID") <> strProjectCustomerID Then
                Cancel = True
            End If
        End If
        CommonFunction.Data.DisposeDataReader(objDr)
    End Sub
End Class
