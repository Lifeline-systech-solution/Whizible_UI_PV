'=====================================================================
' Class	Name	        :	CLCPTemplate
' Purpose				:	This is a standard events template for each
'                           page built using page builder.
' Description			:	
' Assumptions			:	None
' Dependencies			:	None
' Author				:	RajeshB
' Created				:	9 Aug 2003
' Revisions				:
'=====================================================================
' ==============> Usage
'   Uncomment the event you wish to use and write code in the event
' as you would normally do in the default events class.

Namespace CLCPEvents

	Public Class CLCPTemplate

#Region " Attachment Events "

        '        Public Shared Sub Before_ViewAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentView, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)


        '        End Sub

        '        Public Shared Sub Initialize_Attachment(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Initialize, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)

        '        End Sub

        '        Public Shared Sub Before_FileControl_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Before_Description_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub After_UI_Print(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Before_UploadAttachment(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUpload, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)

        '        End Sub

        '        Public Shared Sub After_UploadAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUpload, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Before_SaveAttachment(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentSave, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub After_SaveAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentSave, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

#End Region

#Region " CLCP_Events_Controls "

        '        Public Shared Sub Before_PlotControlCell(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Controls, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef drControls As IDataReader = Nothing)

        '        End Sub

        '        Public Shared Sub After_PlotControlCell(ByRef Args As EventHandlers.WAF_Controls, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef drControls As IDataReader = Nothing)
        '        End Sub

        '        Public Shared Sub Before_PlotControlCaption(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Controls, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef drControls As IDataReader = Nothing, _
        '                     Optional ByRef InsertBeforeCaption As String = "")
        '        End Sub

        '        Public Shared Sub After_PlotControlCaption(ByRef Args As EventHandlers.WAF_Controls, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef drControls As IDataReader = Nothing, _
        '                     Optional ByRef InsertAfterCaption As String = "")
        '        End Sub

        '        Public Shared Sub Before_PlotControl(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Controls, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef drControls As IDataReader = Nothing, _
        '                     Optional ByRef InsertBeforeControl As String = "")

        '        End Sub

        '        Public Shared Sub After_PlotControl(ByRef Args As EventHandlers.WAF_Controls, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef drControls As IDataReader = Nothing, _
        '                     Optional ByRef InsertAfterControl As String = "")
        '        End Sub

#End Region

#Region " CLCP_Events_cEventHandlers "

        'Public Shared Sub PageListPreRender(ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '             ByRef strActionCode As String, _
        '             ByRef strMasterPrimaryKey As String, _
        '             ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
        '             ByRef PageListPreRender As String)

        '    'Application standard return code. Do not comment following lines
        '    Dim objEvent As CommonEngine.General.cEventHandlers
        '    strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString

        'End Sub

        'Public Shared Sub PageUIPreRender(ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '             ByRef strActionCode As String, _
        '             ByRef strMasterPrimaryKey As String, _
        '             ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
        '             ByRef PageUIPreRender As String, _
        '             Optional ByRef strPrimaryKey As String = "")

        '    'Application standard return code. Do not comment following lines
        '    Dim objEvent As CommonEngine.General.cEventHandlers
        '    strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString

        'End Sub

        'Public Shared Sub PageListPostRender(ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '             ByRef strActionCode As String, _
        '             ByRef strMasterPrimaryKey As String, _
        '             ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
        '             ByRef PageListPostRender As String)

        '    'Application standard return code. Do not comment following lines
        '    Dim objEvent As CommonEngine.General.cEventHandlers
        '    strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString

        'End Sub

        'Public Shared Sub PageUIPostRender(ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '             ByRef strActionCode As String, _
        '             ByRef strMasterPrimaryKey As String, _
        '             ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
        '             ByRef PageUIPostRender As String, _
        '             Optional ByRef strPrimaryKey As String = "")

        '    'Application standard return code. Do not comment following lines
        '    Dim objEvent As CommonEngine.General.cEventHandlers
        '    strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString

        'End Sub

        'Public Shared Sub BeforeSave(ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '             ByRef ControlsHashTable As Hashtable, _
        '             ByRef PrimaryKey As String, _
        '             ByRef strActionCode As String, _
        '             ByRef strMasterPrimaryKey As String, _
        '             ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
        '             ByRef BeforeSave As String, _
        '             Optional ByRef RedirectToCL As Boolean = True)

        '    'Application standard return code. Do not comment following lines
        '    Dim objEvent As CommonEngine.General.cEventHandlers
        '    strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString


        'End Sub

        'Public Shared Sub AfterSave(ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '             ByRef ControlsHashTable As Hashtable, _
        '             ByRef PrimaryKey As String, _
        '             ByRef strActionCode As String, _
        '             ByRef strMasterPrimaryKey As String, _
        '             ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
        '             ByRef AfterSave As String, _
        '             Optional ByRef RedirectToCL As Boolean = True)

        '    'Application standard return code. Do not comment following lines
        '    Dim objEvent As CommonEngine.General.cEventHandlers
        '    strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString


        'End Sub

        'Public Shared Sub BeforeDelete(ByRef DeletedIDList As String, _
        '             ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '             ByRef strActionCode As String, _
        '             ByRef strMasterPrimaryKey As String, _
        '             ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
        '             ByRef BeforeDelete As String)

        '    'Application standard return code. Do not comment following lines
        '    Dim objEvent As CommonEngine.General.cEventHandlers
        '    strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString

        'End Sub

        'Public Shared Sub AfterDelete(ByRef DeletedIDList As String, _
        '             ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '             ByRef strActionCode As String, _
        '             ByRef strMasterPrimaryKey As String, _
        '             ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
        '             ByRef AfterDelete As String)

        '    'Application standard return code. Do not comment following lines
        '    Dim objEvent As CommonEngine.General.cEventHandlers
        '    strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString

        'End Sub

#End Region

#Region " CLCP_Events_DynamicActions "

        '        Public Shared Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Before_ExecutingAction(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "", _
        '                     Optional ByRef ControlsHashTable As Hashtable = Nothing)
        '        End Sub

        '        Public Shared Sub After_ExecutingAction(ByRef Args As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "", _
        '                     Optional ByRef ControlsHashTable As Hashtable = Nothing)
        '        End Sub

        '        Public Shared Sub Before_Link_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_DynamicMenu_Link, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Before_NavLinks_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_DynamicMenu_NavLinks, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Before_NavLink_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_DynamicMenu_NavLink, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_PagingLink, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     ByRef Paging As WAF_DynamicMenu_Paging)
        '        End Sub

        '        Public Shared Sub Before_Paging_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_DynamicMenu_Paging, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Initialize(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_DynamicMenu, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_Paging, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     ByRef Paging As WAF_DynamicMenu_Paging)
        '        End Sub

        '        Public Shared Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

#End Region

#Region " CLCP_Events_DynamicFilters "

        '			Public Shared  Sub Initialize_Filters(ByRef Cancel As Boolean, _
        '																ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFiltersTable, _
        '																ByRef WhizGlobal As WebPages.Template.IGlobal)
        '						End Sub

        '			Public Shared  Sub Before_Filter_Print(ByRef Cancel As Boolean, _
        '																ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, _
        '																ByRef WhizGlobal As WebPages.Template.IGlobal)
        '					End Sub

        '        Public Shared Sub After_Filter_Print(ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, _
        '                ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

#End Region

#Region "CLCP_Events_Graph "

        '			Public Shared  Sub Before_PlotGraph(ByRef Cancel As Boolean, _
        '																ByRef Args As EventHandlers.WAF_Graph, _
        '																ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '																Optional ByRef PrimaryKey As String = "")
        '							End Sub

        '			Public Shared  Sub After_PlotGraph(ByRef Args As EventHandlers.WAF_Graph, _
        '																ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '																Optional ByRef PrimaryKey As String = "")

        '							End Sub

#End Region

#Region " CLCP_Events_Grid "

        '			Public Shared  Sub Initialize_Grid(ByRef Cancel As Boolean, _
        '																ByRef Args As EventHandlers.WAF_Grid.WAF_InitializeGrid, _
        '																ByRef WhizGlobal As WebPages.Template.IGlobal)
        '							End Sub

        '			Public Shared  Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, _
        '																ByRef Args As EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, _
        '																ByRef WhizGlobal As WebPages.Template.IGlobal)
        '						End Sub

        '			Public Shared  Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, _
        '																ByRef Args As EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, _
        '																ByRef WhizGlobal As WebPages.Template.IGlobal)
        '			End Sub

        '			Public Shared  Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, _
        '																ByRef Args As EventHandlers.WAF_Grid.WAF_DataRowTR, _
        '																ByRef WhizGlobal As WebPages.Template.IGlobal)
        '				End Sub

        '        Public Shared Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Grid.WAF_DataRowTD, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared  Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared  Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared  Sub After_GridColumnHeaderTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared  Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub InitializeListPage_SubTag(ByRef Cancel As Boolean, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     ByRef PrimaryKey As String)
        '        End Sub

        '        Public Shared Sub BeforePrintListPage_SubTag(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_SubTag, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     ByRef PrimaryKey As String)
        '        End Sub
#End Region

#Region "CLCP_Events_HeaderFooter"

        '        Public Shared Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_HeaderFooter, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     ByRef Gen As EventHandlers.WAF_General)
        '        End Sub
#End Region

#Region "CLCP_Events_PageCaption"

        '        Public Shared Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_PageCaption, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     ByRef Gen As EventHandlers.WAF_General)
        '        End Sub
#End Region

#Region "CLCP_Events_PageLegends"

        '        Public Shared Sub Initialize_Legend(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_InitializeLegends, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     ByRef Gen As EventHandlers.WAF_General)
        '        End Sub
        '        Public Shared Sub Before_Legend_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_Legends, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     ByRef Gen As EventHandlers.WAF_General)
        '        End Sub
#End Region

#Region "CLCP_Events_RelatedData"

        '        Public  Shared Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub

        '        Public  Shared Sub After_PlotRelatedDataHeader(ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub

        '        Public Shared  Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub

        '        Public Shared  Sub After_PlotRelatedDataGrid(ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub
        '        Public Shared Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        '        End Sub
        '        Public Shared Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        '        End Sub
        '        Public Shared Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        '        End Sub
        '        Public Shared Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        '        End Sub
        '        Public Shared Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        '        End Sub
        '        Public Shared Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        '        End Sub
#End Region

#Region " CLCP_Events_Sections "

        '        Public Shared Sub Before_PlotSection(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Section, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub

        '        Public Shared Sub After_PlotSection(ByRef Args As EventHandlers.WAF_Section, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub

        '        Public Shared Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_Section, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub

        '        Public Shared Sub After_PlotSectionTitle(ByRef Args As EventHandlers.WAF_Section, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub

        '        Public Shared Sub Section_Title_Initialize(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_SectionTitle, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub

        '        Public Shared Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, _
        '                     ByRef Args As WAF_SectionLinks, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal)
        '        End Sub


#End Region

#Region "CLCP_Events_SubTag "

        '        Public Shared Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, _
        '                     ByRef Args As Tab.WAF_TabSettings, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub

        'Public Shared Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        'End Sub

        '        Public Shared Sub BeforePlotDetails_SubTag(ByRef Cancel As Boolean, _
        '                     ByRef Args As EventHandlers.WAF_SubTag, _
        '                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
        '                     Optional ByRef PrimaryKey As String = "")
        '        End Sub
#End Region

#Region "CLCP_PageSpecificBehavior"

        'Public Shared Shadows Sub GetPageSpecificGlobalObject(ByRef objGlobal As WebPages.Template.IGlobal)
        'End Sub

        'Public Shared Shadows Sub GetPageSpecificFilters(ByRef objGlobal As WebPages.Template.IGlobal, _
        '             ByRef GetPageSpecificFilters As String)

        ''If you don't want default behaviour, then comment following code

        '    Dim objUICtrlValue() As CommonEngines.HashTables.UITagDefaultFilters
        '    Dim intLength As Integer
        '    Dim intIndex As Integer
        '    GetPageSpecificFilters = ""
        '    'Create object of Default Filter hash table
        '    objUICtrlValue = CommonEngines.HashTables.GetHashTableObject.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
        '    'If the object is nothing then exit
        '    If objUICtrlValue Is Nothing Then
        '        GetPageSpecificFilters = ""
        '        Exit Sub
        '    End If

        '    intLength = objUICtrlValue.Length - 1
        '    For intIndex = 0 To intLength
        '        'some default value is defined for the control
        '        If objUICtrlValue(intIndex).IsQueryStringParameter = False Then
        '            If CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).SessionVariable) <> "" Then
        '                'Get value from the session variable 
        '                GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).SessionVariable))).ToString) + "'"
        '            End If
        '        Else
        '            'Get the Filter Parameter value from the Query String
        '            GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName)).ToString)) + "'"
        '        End If
        '    Next
        '    'Destroy the object
        '    objUICtrlValue = Nothing

        'End Sub

        'Public Shared Shadows Sub GetCheckDuplicateSQL(ByRef strSQL As String, _
        '             ByRef objGlobal As WebPages.Template.IGlobal, _
        '             ByRef GetCheckDuplicateSQL As String)

        ''If you don't want default behaviour, then comment following code

        '    If strSQL.Trim = "" Then
        '        GetCheckDuplicateSQL = ""
        '        Exit Sub
        '    End If

        '    GetCheckDuplicateSQL = strSQL
        '    'If objGlobal.FromWhere = "PM" Then  'And ((objGlobal.ParentTagID = 0 And objGlobal.TagID = CommonFunction.Constants.TAG_LIST_OF_PROJECTS) Or objGlobal.ParentTagID <> 0)

        '    Dim objPageFilter() As CommonEngines.HashTables.UITagDefaultFilters
        '    Dim intLength As Integer
        '    Dim intIndex As Integer

        '    If objGlobal.ParentTagID = 0 Then
        '        'For Master Tag
        '        objPageFilter = CommonEngines.HashTables.GetHashTableObject.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
        '    Else
        '        'For Sub Tag
        '        objPageFilter = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
        '    End If
        '    'End
        '    'If the object is nothing then exit
        '    If objPageFilter Is Nothing Then Exit Sub
        '    intLength = objPageFilter.Length - 1
        '    For intIndex = 0 To intLength
        '        If InStr(1, strSQL, "WHERE", CompareMethod.Text) = 0 Then
        '            If objPageFilter(intIndex).IsQueryStringParameter = False Then
        '                GetCheckDuplicateSQL += " WHERE " + CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).SessionVariable)).ToString) + "'"
        '            Else
        '                GetCheckDuplicateSQL += " WHERE " + CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName)).ToString) + "'"
        '            End If
        '        Else
        '            If objPageFilter(intIndex).IsQueryStringParameter = False Then
        '                GetCheckDuplicateSQL += " AND " + CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).SessionVariable)).ToString) + "'"
        '            Else
        '                GetCheckDuplicateSQL += " AND " + CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName)).ToString) + "'"
        '            End If
        '        End If
        '    Next
        '    'Destroy the object
        '    objPageFilter = Nothing
        '    'End If

        'End Sub

        'Public Shared Shadows Sub ExecuteDeletionSP(ByRef strDeletionSP As String, _
        '             ByRef UniqueID As String, _
        '             ByRef objGlobal As WebPages.Template.IGlobal, _
        '             ByRef ExecuteDeletionSP As String, _
        '             Optional ByRef lngSubTagId As Long = 0)

        '    'If you don't want default behaviour, then comment following code
        '    'Execute the Deletion SP
        '    ExecuteDeletionSP = ""

        '    Dim objCmd As New SqlClient.SqlCommand
        '    Try
        '        'objCmd.Connection = CommonFunction.Connection.GetSQLConnection(CommonFunctions.Application.ConnectionString)
        '        objCmd.CommandText = strDeletionSP
        '        objCmd.CommandType = CommandType.StoredProcedure
        '        objCmd.Parameters.Add(New SqlClient.SqlParameter("@intUniqueID", SqlDbType.Int, 40))
        '        objCmd.Parameters("@intUniqueID").Value = UniqueID
        '        If objGlobal.FromWhere = "PM" And lngSubTagId = 0 Then
        '            objCmd.Parameters.Add(New SqlClient.SqlParameter("@intProjectID", SqlDbType.Int, 40))
        '            objCmd.Parameters("@intProjectID").Value = objGlobal.ProjectID
        '        End If
        '        objCmd.Parameters.Add(New SqlClient.SqlParameter("@strResult", SqlDbType.VarChar, 1000))
        '        objCmd.Parameters("@strResult").Direction = ParameterDirection.Output
        '        'Execute the Command and get the Command object
        '        objCmd = CommonFunction.Data.GetSQLCommandExecute(objCmd, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        '        ExecuteDeletionSP = objCmd.Parameters("@strResult").Value.ToString()
        '    Catch ex As Exception
        '        ex.Source = "ExecuteDeletionSP"
        '        Throw ex
        '    Finally
        '        'Destroy the object
        '        objCmd.Dispose()
        '        objCmd = Nothing
        '    End Try


        'End Sub

        'Public Shared Shadows Sub GetUIPageWhereClause(ByRef objGlobal As WebPages.Template.IGlobal, _
        '             ByRef TableName As String, ByRef PrimaryKey As String, _
        '             ByRef GetUIPageWhereClause As String, _
        '             Optional ByRef PrimaryKeyValue As String = "")

        ''If you don't want default behaviour, then comment following code

        '    If (HttpContext.Current.Request("FromCL") = "1" And objGlobal.ParentTagID = 0) Or (HttpContext.Current.Request("SubTagFromCL") = "1" And objGlobal.ParentTagID <> 0) Then
        '        'Common Page is accessed from CommonList
        '        GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"
        '    Else
        '        'if the Common Page is directly accessed then
        '        If objGlobal.FromWhere = "PM" Then
        '            If objGlobal.TagID <> CommonFunction.Constants.TAG_PROJECT_INFORMATION Or PrimaryKeyValue.Trim = "" Then
        '                'For Projects Module append then ProjectID
        '                GetUIPageWhereClause = " WHERE ProjectID = '" + HttpContext.Current.Session("intProjectID").ToString + "'"
        '                PrimaryKeyValue = HttpContext.Current.Session("intProjectID").ToString
        '            Else
        '                'Common Page is accessed from CommonList
        '                GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"
        '            End If
        '        Else
        '            Dim strSQL As String
        '            strSQL = "SELECT " + PrimaryKey + " FROM " + TableName + " ORDER BY " + PrimaryKey
        '            PrimaryKeyValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
        '            GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"
        '        End If
        '    End If

        'End Sub

        'Public Shared Shadows Sub IsSpecialCaseEditMode_UIPage(ByRef objGlobal As WebPages.Template.IGlobal, _
        '             ByRef IsSpecialCaseEditMode_UIPage As Boolean)

        '    IsSpecialCaseEditMode_UIPage = False

        'End Sub

        'Public Shared Shadows Sub GetUIPageURL(ByRef FunctionName As String, _
        '             ByRef objGlobal As WebPages.Template.IGlobal, _
        '             ByRef blnEditMode_UIPageOpenInWindow As Boolean, _
        '             ByRef strUIPage As String, ByRef GetUIPageURL As String)

        ''If you don't want default behaviour, then comment following code

        '    If blnEditMode_UIPageOpenInWindow = True Then
        '        GetUIPageURL = "Javascript:" + FunctionName + "('<UNIQUE_ID>')"
        '    Else
        '        If InStr(1, strUIPage, "?", CompareMethod.Text) <> 0 Then
        '            GetUIPageURL = strUIPage + "&<UNIQUE_ID>"
        '        Else
        '            GetUIPageURL = strUIPage + "?<UNIQUE_ID>"
        '        End If
        '    End If
        'End Sub

        'Public Shared Sub FormatUIPageHrefTag(ByRef objGlobal As WebPages.Template.IGlobal, _
        '             ByRef FormatUIPageHrefTag As String)

        '    FormatUIPageHrefTag = ""

        'End Sub

#End Region

#Region " USER Implementation "

#End Region

    End Class

End Namespace



