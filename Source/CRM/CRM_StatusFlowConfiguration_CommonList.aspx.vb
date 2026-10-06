Imports CommonEngines.General.cEventHandlers
Public Class CRM_StatusFlowConfiguration_CommonList
    Inherits CommonList
    Private objCLSQL As CRM_StatusFlowConfiguration_CommonListCLSQL
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        objCLSQL = New CRM_StatusFlowConfiguration_CommonListCLSQL(MyBase.m_objGlobal)
        Return objCLSQL
    End Function

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
        MyBase.strListPage = "CRM_StatusFlowConfiguration_CommonList.aspx"
        'strSubType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        'MyBase.strFormPage = "CommonPage.aspx"
        'MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strSubTypeFromStatusToStatusList, strDelteQuery, strSubRequestTypeID, strSubRequestType, strFromStatusID, strToStatusID, strFromStatus, strToStatus, strSql As String
        Dim icount As Integer

        'Added by GokulP on 20 May 2010 for Saving the data 
        Dim strFromStatusFilter As String = ""
        Dim strToStatusFilter As String = ""
        Dim strArrayFromFilter As String()
        Dim strArrayToFilter As String()
        Dim StrActualValueFromFilter() As String
        Dim StrActualValueToFilter() As String
        Dim StrActualFromStatusFilter() As String
        Dim StrActualToStatusFilter() As String

        strFromStatusFilter = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("FromStatus"), "")
        If Not Request.Form("FromStatus") Is Nothing Then
            strFromStatusFilter = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("FromStatus"), "")
        End If

        strToStatusFilter = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ToStatus"), "")
        If Not Request.Form("ToStatus") Is Nothing Then
            strToStatusFilter = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ToStatus"), "")
        End If
        strFromStatusFilter = strFromStatusFilter.Trim.ToString
        strToStatusFilter = strToStatusFilter.Trim.ToString

        If strFromStatusFilter <> "" Then
            strArrayFromFilter = strFromStatusFilter.Split(","c)

            For icount = 0 To strArrayFromFilter.Length() - 1
                StrActualValueFromFilter = strArrayFromFilter(icount).Split("|"c)
                'StrActualFromStatusFilter = StrActualValueFromFilter(0).Split("."c)
                strFromStatusFilter = StrActualValueFromFilter(0).Substring((StrActualValueFromFilter(0).IndexOf("."c) + 2), StrActualValueFromFilter(0).Length - (StrActualValueFromFilter(0).IndexOf("."c) + 2))
                'strFromStatusFilter = Trim(StrActualFromStatusFilter(1))
                strFromStatusFilter = strFromStatusFilter.Replace("'", "''")
            Next
        End If
        If strToStatusFilter <> "" Then
            strArrayToFilter = strToStatusFilter.Split(","c)

            For icount = 0 To strArrayToFilter.Length() - 1
                StrActualValueToFilter = strArrayToFilter(icount).Split("|"c)
                strToStatusFilter = StrActualValueToFilter(0).Substring((StrActualValueToFilter(0).IndexOf("."c) + 2), StrActualValueToFilter(0).Length - (StrActualValueToFilter(0).IndexOf("."c) + 2))
                'StrActualToStatusFilter = StrActualValueToFilter(0).Split("."c)
                'strToStatusFilter = Trim(StrActualToStatusFilter(1))
                strToStatusFilter = strToStatusFilter.Replace("'", "''")
            Next
        End If
        'End of Addition by GokulP on 20 May 2010 for Saving the data 

        strDelteQuery = ""
        strSubTypeFromStatusToStatusList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "")
        If Not Request.QueryString("SubRequestTypeID") Is Nothing Then
            strSubRequestTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        ElseIf Not Request.Form("txtSubTypeID") Is Nothing Then
            strSubRequestTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubTypeID"), "")
        End If
        If Not Request.QueryString("SubRequestType") Is Nothing Then
            strSubRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestType"), "")
        ElseIf Not Request.Form("txtSubType") Is Nothing Then
            strSubRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubType"), "")
        End If

        Dim strArraySTFT As String()
        Dim strScript As String = ""
        Dim StrActualValue() As String
        Dim StrActualFromStatus() As String
        Dim StrActualToStatus() As String
        If strSubRequestTypeID <> "" Then
            'Commented & Added by GokulP on 21 May 2010 for Saving Data while applying filters
            If strFromStatusFilter.Trim.ToString = "" Then
                strFromStatusFilter = "NULL"
            Else
                strFromStatusFilter = "'" + strFromStatusFilter.Trim.ToString + "'"
            End If
            If strToStatusFilter.Trim.ToString = "" Then
                strToStatusFilter = "NULL"
            Else
                strToStatusFilter = "'" + strToStatusFilter.Trim.ToString + "'"
            End If
            'strDelteQuery = " usp_Del_tbl_CRM_StatusFlow " & strSubRequestTypeID
            strDelteQuery = " usp_Del_tbl_CRM_StatusFlow " & strSubRequestTypeID & "," & strFromStatusFilter & "," & strToStatusFilter
            'End of Commen & Addition by GokulP on 21 May 2010 for Saving Data while applying filters
            CommonFunction.Data.InsertOrUpdateData(strDelteQuery, MyBase.UseSQL)
        End If
        If strSubTypeFromStatusToStatusList <> "" Then
            strArraySTFT = strSubTypeFromStatusToStatusList.Split(","c)

            For icount = 0 To strArraySTFT.Length() - 1
                StrActualValue = strArraySTFT(icount).Split("|"c)
                strSubRequestTypeID = StrActualValue(0)
                strFromStatusID = StrActualValue(1)
                strToStatusID = StrActualValue(2)
                StrActualFromStatus = StrActualValue(3).Split("."c)
                strFromStatus = Trim(StrActualFromStatus(1))
                strFromStatus = strFromStatus.Replace("'", "''")

                StrActualToStatus = StrActualValue(4).Split("."c)
                strToStatus = Trim(StrActualToStatus(1))
                strToStatus = strToStatus.Replace("'", "''")

                If strSubRequestTypeID <> "" Then
                    strSql = "usp_Ins_tbl_CRM_StatusFlow " + strSubRequestTypeID + ",'" + strSubRequestType + "','" + strFromStatusID + "','" + strToStatusID + "','" + strFromStatus + "','" + strToStatus + "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSql, MyBase.UseSQL)
                End If
                strSubRequestTypeID = ""
                strFromStatusID = ""
                strToStatusID = ""
                strFromStatus = ""
                strToStatus = ""
            Next
        End If
        strScript = vbCrLf + "<Script language=javascript>"
        strScript += vbCrLf + "window.opener.document.forms[0].action='../General/CommonList.aspx?MasterTagID=919&FromWhere=SM';"
        strScript += vbCrLf + "window.opener.document.forms[0].submit();"
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

    End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid

        Return New CRM_StatusFlowConfiguration_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim strSubType As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestType"), "")
        Dim strSubTypeID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        ' Dim strSubTypeID As String = ""
        'strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        'Dim strProjectID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "")
        If strSubType = "" And strSubTypeID = "" Then
            strSubType = HttpContext.Current.Request.Form("txtSubType")
            strSubTypeID = HttpContext.Current.Request.Form("txtSubTypeID")
        End If
        Args.RightPageCaption = "Sub-Request Type : " + strSubType

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtSubType", "txtSubType", "clsTextBox", 150, 20, strSubType, "left", , False, False, , True, , False, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtSubTypeID", "txtSubTypeID", "clsTextBox", 150, 20, strSubTypeID, "left", , False, False, , True, , False, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
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
    'Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
    '    Return New CRM_StatusFlowConfiguration_CommonListCLSQL(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
    '    Return New CRM_StatusFlowConfiguration_CommonListPlotGrid(MyBase.m_objGlobal)
    'End Function
End Class
Public Class CRM_StatusFlowConfiguration_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public strSubTypeID As String
    Public strSelected As String
    Dim FromStatus As String = ""
    Dim ToStatus As String = ""


    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)

    End Sub
   
    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
    End Sub
    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim StrActualFromStatus() As String
        Dim StrActualToStatus() As String

        If Not HttpContext.Current.Request.QueryString("SubRequestTypeID") Is Nothing Then
            strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        ElseIf Not HttpContext.Current.Request.Form("txtSubTypeID") Is Nothing Then
            strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubTypeID"), "")
        End If
        'strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "0")

        FromStatus = Args.DataReader("FromStatus").ToString
        'Commented & Added by GokulP on 21 May 2010 for Saving Data
        'StrActualFromStatus = FromStatus.Split("."c)
        'FromStatus = Trim(StrActualFromStatus(1))
        FromStatus = FromStatus.Substring((FromStatus.IndexOf("."c) + 2), FromStatus.Length - (FromStatus.IndexOf("."c) + 2))
        FromStatus = Trim(FromStatus)
        'End of Comment & Addition by GokulP on 21 May 2010 for Saving Data

        ToStatus = Args.DataReader("ToStatus").ToString
        'Commented & Added by GokulP on 21 May 2010 for Saving Data
        'StrActualToStatus = ToStatus.Split("."c)
        'ToStatus = Trim(StrActualToStatus(1))
        ToStatus = ToStatus.Substring((ToStatus.IndexOf("."c) + 2), ToStatus.Length - (ToStatus.IndexOf("."c) + 2))
        ToStatus = Trim(ToStatus)
        'End of Commented & Addition by GokulP on 21 May 2010 for Saving Data
        strSelected = CommonFunctions.Data.GetDataScalar("Select 1 from tbl_CRM_StatusFlow where SubRequestTypeID=" & strSubTypeID & " AND FromStatus='" & FromStatus & "' AND ToStatus='" & ToStatus & "'", True)
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Dim strSelected As String = ""
        'Dim FromStatus As String = ""
        'Dim ToStatus As String = ""

        'Dim StrActualFromStatus() As String
        'Dim StrActualToStatus() As String
        If Args.ColumnName.ToUpper = "TO STATUS" Then
            'If strSubTypeID = "" Or strSubTypeID Is Nothing Then
            '    strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubTypeID"), "")
            'End If
            If strSelected = 1 Then
                Cancel = True
                Args.StringToBeInserted = "<td><Font color='blue'>" & Args.DataReader("ToStatus").ToString & "</Font></TD>"
            End If

        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            If strSubTypeID = "" Or strSubTypeID Is Nothing Then
                strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubTypeID"), "")
            End If
            If FromStatus = ToStatus Then
                'Commented and added by Chetan M on 18 Jan 2021 for 2 checkbox is getting selected
                'Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' disabled name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' disabled name='chkDelete' id='chkDelete""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """' class='clsCheckBox' value=""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
            ElseIf strSelected = 1 Then
                'Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """' class='clsCheckBox' value=""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
            Else
                'Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' name='chkDelete' id='chkDelete""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """' class='clsCheckBox' value=""" + strSubTypeID + "|" + Args.DataReader("FromStatusID").ToString + "|" + Args.DataReader("ToStatusID").ToString + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                'Commented and added by Chetan M on 18 Jan 2021 for 2 checkbox is getting selected
            End If

        End If
    
    End Sub

End Class
Class CRM_StatusFlowConfiguration_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strSubType As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestType"), "")
        'Dim strSubTypeID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        Dim strSubTypeID As String = ""
        If Not HttpContext.Current.Request.QueryString("SubRequestTypeID") Is Nothing Then
            strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        ElseIf Not HttpContext.Current.Request.Form("txtSubTypeID") Is Nothing Then
            strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubTypeID"), "")
        End If

        'Dim strShowAllOrSelected As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowAllOrSelected"), "0")
        'If Not strSubType Is Nothing And strSubTypeID <> "" And strShowAllOrSelected = "1" Then
        '    GetPageSpecificFilters += " And SubrequestTypeID='" & strSubTypeID & "'"
        'ElseIf strShowAllOrSelected = "0" Then
        '    GetPageSpecificFilters += " AND SubrequestTypeID='" & strSubTypeID & "' or SubRequesttypeID is null"
        'End If
    End Function
    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.Initialize_GridSQL(Cancel, Args, WhizGlobal)
        Dim strSubTypeID As String = ""
        Dim strselected As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowAllOrSelected"), "")
        If Not HttpContext.Current.Request.QueryString("SubRequestTypeID") Is Nothing Then
            strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
        ElseIf Not HttpContext.Current.Request.Form("txtSubTypeID") Is Nothing Then
            strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubTypeID"), "")
        End If
        If strselected = "1" Then
            Args.GridSQL = "USP_Sel_ShowSelectedStatus '" & strSubTypeID & "'"
        End If

    End Sub
End Class


