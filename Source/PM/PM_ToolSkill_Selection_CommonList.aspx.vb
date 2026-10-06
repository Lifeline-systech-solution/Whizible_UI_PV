Imports CommonEngines.General.cEventHandlers
Imports PbNIT
Public Class PM_ToolSkill_Selection_CommonList
    Inherits CommonList


    Private strIsSkill As String
    Private strshowSelected As String
    Protected SelectedIDs As String = ""
    Protected SelectedSkill As String = ""
    Public FormTagId As String

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
        MyBase.strListPage = "PM_ToolSkill_Selection_CommonList.aspx"
        MyBase.strFormPage = "PM_ToolSkill_Selection_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here

        strshowSelected = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("showSelected"), "")

        If strshowSelected Is Nothing Or strshowSelected = "" Then
            strshowSelected = CType(HttpContext.Current.Request.Form("showSelected"), String)
        End If

        If Not Request.QueryString("IsSkill") Is Nothing And Request.QueryString("IsSkill") <> "" Then
            strIsSkill = Request.QueryString("IsSkill").ToString()
        ElseIf Not Request.Form("hidIsSkill") Is Nothing And Request.Form("hidIsSkill") <> "" Then
            strIsSkill = Request.Form("hidIsSkill").ToString()
        End If

        If Not Request.QueryString("SelectedIDs") Is Nothing And Request.QueryString("SelectedIDs") <> "" Then
            SelectedIDs = CommonFunction.General.CheckIsNothing(Request.QueryString("SelectedIDs"), "").ToString()
        ElseIf Not Request.Form("SelectedIDs") Is Nothing And Request.Form("SelectedIDs") <> "" Then
            SelectedIDs = CommonFunction.General.CheckIsNothing(Request.Form("SelectedIDs"), "").ToString()
        End If

        If Not Request.QueryString("SelectedSkill") Is Nothing And Request.QueryString("SelectedSkill") <> "" Then
            SelectedSkill = CommonFunction.General.CheckIsNothing(Request.QueryString("SelectedSkill"), "").ToString()
        ElseIf Not Request.Form("SelectedSkill") Is Nothing And Request.Form("SelectedSkill") <> "" Then
            SelectedSkill = CommonFunction.General.CheckIsNothing(Request.Form("SelectedSkill"), "").ToString()
        End If

        If Not Request.QueryString("TagId") Is Nothing And Request.QueryString("TagId") <> "" Then
            FormTagId = Request.QueryString("TagId").ToString()
            'Session("FormTagId") = FormTagId
        ElseIf Not Request.Form("hidFormTagId") Is Nothing And Request.Form("hidFormTagId") <> "" Then
            FormTagId = Request.Form("hidFormTagId").ToString()
        End If

        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunction.General.WriteHTML("<input type=hidden id='hidIsSkill' name='hidIsSkill' value=" + strIsSkill + " >")
        CommonFunction.General.WriteHTML("<input type=hidden id='showSelected' name='showSelected' value=" + strshowSelected + " >")
        CommonFunction.General.WriteHTML("<input type=hidden id='SelectedIDs' name='SelectedIDs' value='" + SelectedIDs + "' >")
        CommonFunction.General.WriteHTML("<input type=hidden id='SelectedSkill' name='SelectedSkill' value='" + SelectedSkill + "' >")

        CommonFunction.General.WriteHTML("<input type=hidden id='hidFormTagId' name='hidFormTagId' value='" + FormTagId + "' >")

    End Function


    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper = "SHOW SELECTED SKILLS" Then
            If strshowSelected = "1" Then
                Cancel = True
            End If
        End If
        If Args.LinkName.ToUpper = "SHOW ALL SKILLS" Then
            If strshowSelected = "0" Then
                Cancel = True
            End If
        End If

    End Sub

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cPM_ToolSkill_Selection_CommonListSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cPM_ToolSkill_Selection_CommonList_DynamicFilters(MyBase.m_objGlobal)

    End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cPM_ToolSkill_Selection_CommonListPlotGrid(MyBase.m_objGlobal, SelectedIDs)
    End Function
    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal whizglobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
End Class


Public Class cPM_ToolSkill_Selection_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Dim strSelectedIDs As String = ""

    Dim IsChecked As String



    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal strSelectedID As String)
        Call MyBase.New(WhizGlobal)
        strSelectedIDs = strSelectedID

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper() = "SELECT" Then

            'If strSelectedIDs <> "" Then
            Cancel = True
            If strSelectedIDs <> "" Then
                strSelectedIDs = "," + strSelectedIDs + ","
            End If
            'strSelectedIDs = HttpContext.Current.Request.Form("SelectedIDs").ToString()
            If strSelectedIDs.Contains("," + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ToolID"), ""), String) + ",") = True Then
                Args.StringToBeInserted = "<td  align=center><Input type=checkbox name=chkDelete  id=chkDelete  class='clsCheckBox' OnClick = ""chkDelete_onClick(" & CType(Args.DataReader("ToolID"), String) & ")"" value=" + CType(Args.DataReader("ToolID"), String) + " checked >"
                Args.StringToBeInserted += "<Input type=hidden name=txtDescription  id=txtDescription  class='clsCheckBox'  value='" + CType(Args.DataReader("Description"), String) + "'></td>"
            Else
                Args.StringToBeInserted = "<td  align=center><Input type=checkbox name=chkDelete  id=chkDelete  class='clsCheckBox' OnClick = ""chkDelete_onClick(" & CType(Args.DataReader("ToolID"), String) & ")"" value=" + CType(Args.DataReader("ToolID"), String) + " >"
                Args.StringToBeInserted += "<Input type=hidden name=txtDescription  id=txtDescription  class='clsCheckBox'   value='" + CType(Args.DataReader("Description"), String) + "' ></td>"
            End If
            'End If

        End If
    End Sub

End Class

Public Class cPM_ToolSkill_Selection_CommonList_DynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters

    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub
    Public m_strLocationID As String

    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strIsSkill As String
        Dim DefaultFilter As String
        Dim strSQL As String
        Dim lngControlTagID As Long
        Dim FormTagId As String
        strIsSkill = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IsSkill"), ""), String)
        If strIsSkill Is Nothing OrElse strIsSkill = "" Then
            strIsSkill = CType(HttpContext.Current.Request.Form("hidIsSkill"), String)
        End If

        FormTagId = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagId"), ""), String)
        If FormTagId Is Nothing OrElse FormTagId = "" Then
            FormTagId = CType(HttpContext.Current.Request.Form("hidFormTagId"), String)
        End If


        If Args.FilterName.ToUpper = "TOOLS_CATEGORYID" Then

            'DefaultFilter = CommonFunction.Data.GetDataScalar("SELECT TOP 1 Tools_SubCategoryID FROM tbl_FCI_Tools_SubCategory ORDER BY SubCategoryName", True)
            'If Args.FixedValue = "" Then
            '    Args.FixedValue = DefaultFilter

            '    strSQL = ""
            '    strSQL = "SELECT ControlTagID FROM tbl_UI_ControlTagMaster Where ControlName='Tools_CategoryID' AND TagID=" & WhizGlobal.TagID.ToString
            '    lngControlTagID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"), Long)

            '    strSQL = ""
            '    If DefaultFilter <> "" Then
            '        strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString + "," + lngControlTagID.ToString + ",'Tools_CategoryID','Skill Sub Category','F','" + CommonFunction.General.BuildQueryString(DefaultFilter) + "','" + CommonFunction.General.BuildQueryString(DefaultFilter) + "'"
            '    Else
            '        strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString + "," + lngControlTagID.ToString + ",'Tools_CategoryID','Skill Sub Category','F',NULL,NULL"
            '    End If
            '    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            '    strSQL = ""
            '    strSQL = "usp_Ins_tbl_UI_EmployeeFilterSettings '" + WhizGlobal.LoginType.Trim + "'," + WhizGlobal.UserID.ToString + "," + WhizGlobal.TagID.ToString
            '    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            'End If

            'If Args.FixedValue = "" Then
            '    Args.SQL = " AND 1=2 "
            'End If

            If strIsSkill = "1" Then
                Cancel = True
            End If
        End If

    End Sub
End Class
Public Class cPM_ToolSkill_Selection_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim showSelected As String
        Dim strIsSkill As String
        Dim strProjectID As String

        Dim FormTagId As String
        FormTagId = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagId"), ""), String)
        If FormTagId Is Nothing OrElse FormTagId = "" Then
            FormTagId = CType(HttpContext.Current.Request.Form("hidFormTagId"), String)
        End If
        showSelected = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("showSelected"), "")
        strProjectID = HttpContext.Current.Session("intProjectID").ToString()

        If showSelected = "" Then
            showSelected = CType(HttpContext.Current.Request.Form("showSelected"), String)
        End If

        strIsSkill = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IsSkill"), ""), String)
        If strIsSkill Is Nothing OrElse strIsSkill = "" Then
            strIsSkill = CType(HttpContext.Current.Request.Form("hidIsSkill"), String)
        End If
        'GetPageSpecificFilters = " AND ToolID NOT IN(SELECT ToolID FROM tbl_PM_ProjectTools WHERE ProjectID = " + strProjectID + ")"

        If FormTagId = "694" Then
            GetPageSpecificFilters = " AND ToolID NOT IN(SELECT ToolID FROM tbl_PRS_Training_needs WHERE ProjectID = " + strProjectID + ")"
        ElseIf FormTagId = "35" Then
            GetPageSpecificFilters = " AND ToolID NOT IN(SELECT ToolID FROM tbl_PM_ProjectTools WHERE ProjectID = " + strProjectID + ")"
        End If

        If Not showSelected Is Nothing Or showSelected <> "" Then
            If showSelected.ToUpper() = "1" Then
                If strIsSkill = "1" Then 'Tool
                    GetPageSpecificFilters += " AND IsSkill = 0 " '+ " AND IsSelected = 1 "
                ElseIf strIsSkill = "2" Then ' Skill
                    GetPageSpecificFilters += " AND IsSkill = 1 " '+ strIsSkill '+ " AND IsSelected = 1 "
                End If

            End If
            If showSelected.ToUpper() = "0" Then
                If strIsSkill = "1" Then 'Tool
                    GetPageSpecificFilters += " AND IsSkill = 0 "
                ElseIf strIsSkill = "2" Then ' Skill
                    GetPageSpecificFilters += " AND IsSkill = 1 "
                End If
            End If
        End If

    End Function
End Class