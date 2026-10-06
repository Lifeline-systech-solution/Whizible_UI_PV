Imports CommonEngines.General.cEventHandlers
Public Class StatusFlowConfiguration_CommonList
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
        MyBase.ApplySecurity(True)

        'If HttpContext.Current.Request.QueryString("Action") = "Delete" Then
        '    Dim strIssueTypeFromStatusToStatusList, strProjectID, strIssueType, strFromStatus, strToStatus, strSql As String
        '    Dim icount As Integer
        '    strIssueTypeFromStatusToStatusList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "")
        '    Dim strArrayITFT As String() = strIssueTypeFromStatusToStatusList.Split(","c)
        '    Dim strScript As String = ""
        '    Dim StrActualValue() As String
        '    For icount = 0 To strArrayITFT.Length() - 1
        '        StrActualValue = strArrayITFT(icount).Split("|"c)
        '        strProjectID = StrActualValue(0)
        '        strIssueType = StrActualValue(1)
        '        strFromStatus = StrActualValue(2)
        '        strToStatus = StrActualValue(3)
        '        If strProjectID <> "" And strIssueType <> "" And strFromStatus <> "" And strToStatus <> "" Then
        '            strSql = "usp_Ins_tbl_IB_StatusFlow '" + strProjectID + "','" + strIssueType + "','" + strFromStatus + "','" + strToStatus + "'"
        '            CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
        '        End If
        '        strProjectID = ""
        '        strIssueType = ""
        '        strFromStatus = ""
        '        strToStatus = ""
        '    Next
        '    'Added by VarunA on 4-June-2007 For Whizible Regression Project Issue-13474
        '    'Purpose : To refresh the parent page while apply customer SLA
        '    'strScript = vbCrLf + "<Script language=javascript>"
        '    'strScript += vbCrLf + "window.opener.document.forms[0].action='../IB/StatusFlowConfiguration_CommonList.aspx?FromWhere=PM&MasterTagId=3978&IssueType='" && "'';"
        '    'strScript += vbCrLf + "window.opener.document.forms[0].submit();"
        '    'strScript += vbCrLf + "</Script>"
        '    'CommonFunction.General.WriteHTML(strScript)
        '    'End by VarunA on 4-June-2007
        'End If


        MyBase.strListPage = "StatusFlowConfiguration_CommonList.aspx"
        MyBase.strFormPage = "StatusFlowConfiguration_CommonPage.aspx"

        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New StatusFlowConfiguration_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New StatusFlowConfiguration_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strIssueTypeFromStatusToStatusList, strDelteQuery, strProjectID, strIssueType, strFromStatus, strToStatus, strSql As String
        Dim icount As Integer
        strDelteQuery = ""

        strIssueTypeFromStatusToStatusList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "")
        strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "")
        'Commented And Added By Usha Pandit On 18.02.2020 For escaping & from query parameter
        'strIssueType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueType"), "")
        strIssueType = HttpUtility.UrlDecode(System.Uri.UnescapeDataString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueType"), "")))
        'End Of Added By Usha Pandit On 18.02.2020 For escaping & from query parameter

        ''"check1"  
        Dim strArrayITFT As String()
        Dim strScript As String = ""
        Dim StrActualValue() As String
        Dim StrProjectIDIssueType() As String

       
        If strProjectID <> "" And strIssueType <> "" Then
            strDelteQuery = " usp_Del_tbl_IB_StatusFlow '" & strProjectID & "','" & strIssueType & "'"
            CommonFunction.Data.InsertOrUpdateData(strDelteQuery, MyBase.UseSQL)
        End If
        If strIssueTypeFromStatusToStatusList <> "" Then
            strArrayITFT = strIssueTypeFromStatusToStatusList.Split(","c)

            For icount = 0 To strArrayITFT.Length() - 1
                StrActualValue = strArrayITFT(icount).Split("|"c)
                strProjectID = StrActualValue(0)
                strIssueType = StrActualValue(1)
                strIssueType = strIssueType.Replace("'", "''")

                strFromStatus = StrActualValue(2)
                strFromStatus = strFromStatus.Replace("'", "''")

                strToStatus = StrActualValue(3)
                strToStatus = strToStatus.Replace("'", "''")

                If strProjectID <> "" And strIssueType <> "" And strFromStatus <> "" And strToStatus <> "" Then
                    strSql = "usp_Ins_tbl_IB_StatusFlow '" + strProjectID + "','" + strIssueType + "','" + strFromStatus + "','" + strToStatus + "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSql, MyBase.UseSQL)
                End If
                strProjectID = ""
                strIssueType = ""
                strFromStatus = ""
                strToStatus = ""
            Next
        End If
        strScript = vbCrLf + "<Script language=javascript>"
        strScript += vbCrLf + " if(!window.opener.closed) { "
        ''Commented And Added By Usha Pandit On 18.12.2019 For redirecting to new page IBIssueTypes_New.aspx
        'strScript += vbCrLf + "window.opener.document.forms[0].action='../IB/IBIssueTypes.aspx?FromWhere=PM&MasterTagId=538';"
        strScript += vbCrLf + "window.opener.document.forms[0].action='../IB/IBIssueTypes_New.aspx?FromWhere=PM&MasterTagId=538&ProjectID=" + strProjectID
        ''End Of Added By Usha Pandit On 18.12.2019 For redirecting to new page IBIssueTypes_New.aspx
        strScript += vbCrLf + "window.opener.document.forms[0].submit(); } "
        strScript += vbCrLf + "</Script>"
        CommonFunction.General.WriteHTML(strScript)

        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
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

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        'Commented And Added By Usha Pandit On 18.02.2020 For escaping & from query parameter
        'Dim strIssueType As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueType"), "")
        Dim strIssueType As String = HttpUtility.UrlDecode(System.Uri.UnescapeDataString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueType"), "")))
        'End Of Added By Usha Pandit On 18.02.2020 For escaping & from query parameter

        Dim strProjectID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "")
        Args.RightPageCaption = "Issue Type : " + strIssueType

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtIssueType", "txtIssueType", "clsTextBox", 150, 20, strIssueType, "left", , False, False, , True, , False, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", "clsTextBox", 150, 20, strProjectID, "left", , False, False, , True, , False, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
    End Sub

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
Class StatusFlowConfiguration_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        ''Added By VarunA on 24-May-2007 For Service Level Aggrement
        Dim strIssueType As String = ""
        Dim strProjectID As String = ""

        'Commented And Added By Usha Pandit On 18.02.2020 For escaping & from query parameter
        'strIssueType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueType"), "")
        strIssueType = HttpUtility.UrlDecode(System.Uri.UnescapeDataString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueType"), "")))
        'End Of Added By Usha Pandit On 18.02.2020 For escaping & from query parameter

        strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "")

        GetPageSpecificFilters += " AND (ProjectID =" + strProjectID + " )"
        GetPageSpecificFilters += " AND ( IssueType ='" + strIssueType + "' )"
        GetPageSpecificFilters += " AND (BProjectID =" + strProjectID + " )"
        GetPageSpecificFilters += " AND ( [Type] ='" + strIssueType + " ')"
        'GetPageSpecificFilters += " AND (B.ProjectID =" + strProjectID + " )"
        'GetPageSpecificFilters += "AND ( B.[Type] =" + strIssueType + " )"

    End Function
End Class
Public Class StatusFlowConfiguration_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "DELETE" Then
            Args.ColumnName = "Select"
        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strSelected As String = ""
        Dim FromStatus As String = ""
        Dim ToStatus As String = ""
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            strSelected = Args.DataReader("Selected").ToString
            FromStatus = Args.DataReader("FromStatus").ToString
            ToStatus = Args.DataReader("ToStatus").ToString
            If FromStatus = ToStatus Then
                ''addeed and commented by omkar 20/3/2020 issue id 23051
                'Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' disabled name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + Args.DataReader("ProjectID").ToString + "|" + Args.DataReader("IssueType").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' disabled name='chkDelete' id='chkDelete" + Args.DataReader("ProjectTypeStatusID").ToString + "' class='clsCheckBox' value=""" + Args.DataReader("ProjectID").ToString + "|" + Args.DataReader("IssueType").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
            ElseIf strSelected = 1 Then
                'Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + Args.DataReader("ProjectID").ToString + "|" + Args.DataReader("IssueType").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete" + Args.DataReader("ProjectTypeStatusID").ToString + "' class='clsCheckBox' value=""" + Args.DataReader("ProjectID").ToString + "|" + Args.DataReader("IssueType").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
            Else
                'Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + Args.DataReader("ProjectID").ToString + "|" + Args.DataReader("IssueType").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' name='chkDelete' id='chkDelete" + Args.DataReader("ProjectTypeStatusID").ToString + "' class='clsCheckBox' value=""" + Args.DataReader("ProjectID").ToString + "|" + Args.DataReader("IssueType").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                ''end of added and commented by omkar 20/3/2020 issue id 23051
            End If

        End If

    End Sub

End Class
