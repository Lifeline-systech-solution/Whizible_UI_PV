Imports Whizible
Imports CommonEngines.General.cEventHandlers
Public Class LinkMetricsToCustomer_CommonList
    Inherits CommonList




#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object
    Private strName As String

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.

        MyBase.strListPage = "LinkMetricsToCustomer_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim IsSelected As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowAllOrSelected"), "")
        If Args.LinkName.ToUpper() = "SHOW SELECTED" Then
            If IsSelected = "1" Then
                Cancel = True
            End If
        End If

        If Args.LinkName.ToUpper() = "SHOW ALL" Then
            If IsSelected = "0" Or IsSelected = "" Then
                Cancel = True
            End If
        End If

        If Args.ClientSideFunctionName.ToUpper = "DELETE_ONCLICK" Then
            Dim UniqueID As String = ""
            UniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), "")


            '***********************************
            ''''Args.ToBeInsertedInFunction = "  var atleastoneSelected = 0;"
            ''''Args.ToBeInsertedInFunction += " var objchkDelete = GetObjectReference('frmCommonList','chkDelete',1);"
            '''''Validate at least one entry is selected 
            ''''Args.ToBeInsertedInFunction += "  for(i=0;i<objchkDelete.length;i++) {" + vbCrLf

            ''''Args.ToBeInsertedInFunction += "  if (objchkDelete[i].checked==true) {" + vbCrLf

            ''''Args.ToBeInsertedInFunction += "  atleastoneSelected=1 ; } }" + vbCrLf

            ''''Args.ToBeInsertedInFunction += "  if (atleastoneSelected == 0 ) {" + vbCrLf

            ''''Args.ToBeInsertedInFunction += "  alert('Please select atleast one entry');" + vbCrLf
            ''''Args.ToBeInsertedInFunction += "  return; "
            ''''Args.ToBeInsertedInFunction += "  } else {" + vbCrLf
            ' Args.ToBeInsertedInFunction += "  }"
            'objfrm.action = "LinkMetricsToCustomer_CommonList.aspx?Operation=DELETE&MasterTagID=20099&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
            'objfrm.submit()
            ''Added by swapnil aswale on 24/12/2015 
            If UniqueID <> "" Then
                Args.ToBeInsertedInFunction += "  objfrm.action = ""LinkMetricsToCustomer_CommonList.aspx?Operation=DELETE&MasterTagID=8071&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&ModeID=" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModeID"), "") + "&UniqueID=" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), "") + """;" + vbCrLf
                Args.ToBeInsertedInFunction += " objfrm.submit(); " + vbCrLf
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModeID"), "2") = "2" Then
                    Args.ToBeInsertedInFunction += " window.opener.location.href = ""../Metrics/LinkMetrics.aspx?Show=Customer&MasterTagID=8070&FromWhere=SM"";"
                Else
                    Args.ToBeInsertedInFunction += " window.opener.location.href = ""../Metrics/LinkMetrics.aspx?Show=Practice&MasterTagID=8070&FromWhere=SM"";"
                End If

            End If
            ''Ended

            ''''Args.ToBeInsertedInFunction += " return; }"
            ' Args.ToBeInsertedInFunction += "  return true;"
            '*************

        End If

        If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
            Args.ToBeInsertedInFunction = "window.close(); return;" + vbCrLf
        End If

        If Args.ClientSideFunctionName.ToUpper = "CLEARALL_ONCLICK" Then
            Args.ToBeInsertedInFunction = " ClearAll_OnClick('frmCommonList','chkDelete'); return;"
        End If
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cLinkMetricsToCustomer_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cLinkMetricsToCustomer_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strList, strSql, ModeID, strUniqueID As String
        strList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "")
        ModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtModeID"), "")
        strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUniqueID"), "")
        If ModeID <> "" And strUniqueID <> "" Then
            strSql = "usp_Ins_tbl_MET_Metircs_Mapping " + ModeID + "," + strUniqueID + ",'" + strList + "'"
            CommonFunctions.Data.InsertOrUpdateData(strSql, MyBase.UseSQL)
        End If

        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strModeID As String
        Dim strUniqueID As String

        If Not HttpContext.Current.Request.QueryString("ModeID") Is Nothing Then
            strModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModeID"), "")
            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), "")
        ElseIf Not HttpContext.Current.Request.Form("txtModeID") Is Nothing Then
            strModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtModeID"), "")
            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUniqueID"), "")
        End If

        If strModeID = "2" Then
            strName = "Customer :" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select CustomerName from tbl_PM_Customer where Customer=" + strUniqueID, MyBase.UseSQL), "0"), "0")
        ElseIf (strModeID = "1") Then
            strName = "Practice :" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select ProjectType from tbl_PRS_ProjectTypes where TypeID=" + strUniqueID, MyBase.UseSQL), "0"), "0")
        End If
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunction.HTMLControls.DrawTextBox("txtModeID", "txtModeID", "clsTextBox", 150, 20, strModeID, "left", , False, False, , True, , False)
        '''CommonFunction.HTMLControls.DrawTextBox("txtUniqueID", "txtUniqueID", "clsTextBox", 150, 20, strUniqueID, "left", , False, False, , True, , False)
        CommonFunction.HTMLControls.DrawTextBox("txtModeID", "txtModeID", "clsTextBox", 150, 20, strModeID, "left", , False, False, , True, , False, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtUniqueID", "txtUniqueID", "clsTextBox", 150, 20, strUniqueID, "left", , False, False, , True, , False, EnableHTMLEncode:=True)
        ''''End Added By Vaijat K On 06/10/2015
    End Function
    Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
        Dim strModeID As String
        Dim strUniqueID As String

        If Not HttpContext.Current.Request.QueryString("ModeID") Is Nothing Then
            strModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModeID"), "")
            ''Added by Dhanashri S on 22 Dec 2015 For IssueID:2842
            If strModeID = "" Then
                strModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtModeID"), "")
            End If
            ''End of Addition by Dhanashri S on 22 Dec 2015
            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), "")
            ''Added by Dhanashri S on 22 Dec 2015 For IssueID:2842
            If strUniqueID = "" Then
                strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUniqueID"), "")
            End If
            ''End of Addition by Dhanashri S on 22 Dec 2015
        ElseIf Not HttpContext.Current.Request.Form("txtModeID") Is Nothing Then
            strModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtModeID"), "")
            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUniqueID"), "")
        End If

        Args.SQL = "usp_Sel_tbl_MET_Metircs_Mapping_EntiyWise_Paging " + strModeID + "," + strUniqueID + ",0,'-1'"
        ' MyBase.Initialize_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
    End Sub

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub



    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    ''Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    ''End Sub


    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal Whizglobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Args.RightPageCaption = strName
    End Sub

End Class

Public Class cLinkMetricsToCustomer_CommonListPlotGrid
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

    End Sub
End Class
Class cLinkMetricsToCustomer_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Protected m_strPageNumber As String = ""
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strselected As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowAllOrSelected"), "")
        If strselected = "1" Then
            GetPageSpecificFilters += " And Selected =1'"
        End If
        'If Not strSubType Is Nothing And strSubTypeID <> "" And strShowAllOrSelected = "1" Then
        '    GetPageSpecificFilters += " And SubrequestTypeID='" & strSubTypeID & "'"
        'ElseIf strShowAllOrSelected = "0" Then
        '    GetPageSpecificFilters += " AND SubrequestTypeID='" & strSubTypeID & "' or SubRequesttypeID is null"
        'End If
    End Function

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.Initialize_GridSQL(Cancel, Args, WhizGlobal)
        Dim strModeID As String = ""
        Dim strUniqueID As String = ""
        Dim strselected As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowAllOrSelected"), "0")


        If Not HttpContext.Current.Request.QueryString("ModeID") Is Nothing Then
            strModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModeID"), "")
            ''Added by Dhanashri S on 22 Dec 2015 For IssueID:2842
            If strModeID = "" Then
                strModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtModeID"), "")
            End If
            ''End of Addition by Dhanashri S on 22 Dec 2015
            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), "")
            ''Added by Dhanashri S on 22 Dec 2015 For IssueID:2842
            If strUniqueID = "" Then
                strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUniqueID"), "")
            End If
            ''End of Addition by Dhanashri S on 22 Dec 2015
        ElseIf Not HttpContext.Current.Request.Form("txtModeID") Is Nothing Then
            strModeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtModeID"), "")
            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUniqueID"), "")
        End If

        m_strPageNumber = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strPageNumber = "" Then
            m_strPageNumber = "-1"
        Else
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")
        End If



        Args.GridSQL = "usp_Sel_tbl_MET_Metircs_Mapping_EntiyWise " + strModeID + "," + strUniqueID + "," + strselected + ",'" + m_strPageNumber + "'"



        'If strselected = "1" Then
        '    Args.GridSQL = "USP_Sel_ShowSelectedStatus '" & strSubTypeID & "'"
        'End If


        'Dim strSubTypeID As String = ""
        'Dim strselected As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowAllOrSelected"), "")
        'If Not HttpContext.Current.Request.QueryString("SubRequestTypeID") Is Nothing Then
        '    strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        'ElseIf Not HttpContext.Current.Request.Form("txtSubTypeID") Is Nothing Then
        '    strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubTypeID"), "")
        'End If
        'If strselected = "1" Then
        '    Args.GridSQL = "USP_Sel_ShowSelectedStatus '" & strSubTypeID & "'"
        'End If

    End Sub

End Class