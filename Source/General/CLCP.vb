Imports System.Text
Imports System.Data
Public Class EventHandlers
    Inherits CommonEngines.EventHandlers


End Class
Public Class EventChecker
    Public Shared Function CheckEventCallFlag(ByVal TagId As Long, _
            ByVal ParentTagID As Long, ByVal className As String, ByVal eventName As String) As Boolean
        '============================================================================
        'Function Name		: CheckEventCallFlag
        'Description		: Function returns whether the event needs to be called
        '                       for specified tag /sub tag
        'Parameters         : TagId, ParentTagId, extension type
        '                     
        'Return Values		: boolean value indicating if the event is to be called.
        'Author				: RajeshB
        'Created			: 14th October 2004.
        '============================================================================
        Dim applicableEvents() As CommonEngines.HashTables.CLCPTagEventMapping
        Dim objTagEventMapping As New CommonEngines.HashTables.CLCPTagEventMapping
        objTagEventMapping.CLCPEventClassName = className
        objTagEventMapping.CLCPEventName = eventName
        Dim blnEvalExtension As Boolean = False
        If ParentTagID = 0 Then
            applicableEvents = CommonEngines.HashTables.GetHashTableObject.GetCLCPTagEventMapping(TagId)

        Else
            Dim strKey As String = CType(ParentTagID, String) + "-" + CType(TagId, String)
            applicableEvents = CommonEngines.HashTables.GetHashTableObject.GetCLCPTagEventMapping(strKey)


        End If
        If Not (applicableEvents Is Nothing Or objTagEventMapping Is Nothing) Then
            ' If the extension type is found
            If Array.IndexOf(applicableEvents, objTagEventMapping) <> -1 Then
                blnEvalExtension = True
            Else : blnEvalExtension = False
            End If
        End If
        Return blnEvalExtension

    End Function
End Class
Namespace CommonEngine
    Namespace General

    End Namespace

    Namespace CommonList
        Public Class cPlotGrid
            Inherits CommonEngines.CommonList.cPlotGrid

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                ''Assign the Parameter values to the local variables
                Call MyBase.New(WhizGlobal)
            End Sub
            Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                "Initialize_Grid")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_InitializeGrid = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Initialize_Grid", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_InitializeGrid
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.Initialize_Grid(Cancel, Args, WhizGlobal)
                    'Added By NileshD on 29 Aug 2005 for IssueID:20886 
                    Args.TableStyle = " CellSpacing=1 CellPadding=0"
                    'End of addition By NileshD on 29 Aug 2005 for IssueID:20886 
                End If
            End Sub
            Protected Overrides Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Before_GridColumnHeaderTR_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_ColumnHeaderTR = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Before_GridColumnHeaderTR_Print", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_ColumnHeaderTR
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.Before_GridColumnHeaderTR_Print(Cancel, Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Before_GridColumnHeaderTD_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_ColumnHeaderTD = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Before_GridColumnHeaderTD_Print", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_ColumnHeaderTD
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.Before_GridColumnHeaderTD_Print(Cancel, Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Before_GridDataRowTR_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_WAF_DataRowTR = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Before_GridDataRowTR_Print", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_WAF_DataRowTR
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.Before_GridDataRowTR_Print(Cancel, Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Before_GridDataRowTD_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_WAF_DataRowTD = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "Before_GridDataRowTD_Print", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_WAF_DataRowTD
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.Before_GridDataRowTD_Print(Cancel, Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_Grid_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_InitializeGrid = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_Grid_Print", ExtensionArgs)

                    Args = ExtensionArgs.m_InitializeGrid
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.After_Grid_Print(Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_GridColumnHeaderTR_Print")
                If blnCheckEventCall = True Then

                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_ColumnHeaderTR = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_GridColumnHeaderTR_Print", ExtensionArgs)

                    Args = ExtensionArgs.m_ColumnHeaderTR
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.After_GridColumnHeaderTR_Print(Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Sub After_GridColumnHeaderTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_GridColumnHeaderTD_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_ColumnHeaderTD = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_GridColumnHeaderTD_Print", ExtensionArgs)

                    Args = ExtensionArgs.m_ColumnHeaderTD
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.After_GridColumnHeaderTD_Print(Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_GridDataRowTR_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_WAF_DataRowTR = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_GridDataRowTR_Print", ExtensionArgs)


                    Args = ExtensionArgs.m_WAF_DataRowTR
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************

                    Call CommonEngine.General.CLCP_Events_Grid.After_GridDataRowTR_Print(Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_GridDataRowTD_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.m_WAF_DataRowTD = Args
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "After_GridDataRowTD_Print", ExtensionArgs)

                    Args = ExtensionArgs.m_WAF_DataRowTD
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.After_GridDataRowTD_Print(Args, WhizGlobal)
                End If
            End Sub
            Protected Overrides Function IsSpecialCaseEditMode_UIPage(ByVal objGlobal As WebPages.Template.IGlobal) As Boolean
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                                    "IsSpecialCaseEditMode_UIPage")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                                    "IsSpecialCaseEditMode_UIPage", ExtensionArgs)


                    objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    IsSpecialCaseEditMode_UIPage = CommonEngine.General.cPageSpecificBehavior.IsSpecialCaseEditMode_UIPage(objGlobal)
                End If
                'addition ends.
            End Function
            Protected Overrides Function FormatUIPageHrefTag(ByVal objGlobal As WebPages.Template.IGlobal) As String
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                                    "FormatUIPageHrefTag")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                                    "FormatUIPageHrefTag", ExtensionArgs)


                    objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    FormatUIPageHrefTag = CommonEngine.General.cPageSpecificBehavior.FormatUIPageHrefTag(objGlobal)
                End If
                'addition ends.
                FormatUIPageHrefTag = CommonEngine.General.cPageSpecificBehavior.FormatUIPageHrefTag(objGlobal)
            End Function
            Protected Overrides Sub InitializeListPage_SubTag(ByRef Cancel As Boolean, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal PrimaryKey As String)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "InitializeListPage_SubTag")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.PrimaryKey = PrimaryKey
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "InitializeListPage_SubTag", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    PrimaryKey = ExtensionArgs.PrimaryKey
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.InitializeListPage_SubTag(Cancel, WhizGlobal, PrimaryKey)
                End If
            End Sub
            Protected Overrides Sub BeforePrintListPage_SubTag(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal PrimaryKey As String)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "BeforePrintListPage_SubTag")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_SubTag = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.PrimaryKey = PrimaryKey
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Grid", _
                                    "BeforePrintListPage_SubTag", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_SubTag
                    WhizGlobal = ExtensionArgs.m_global
                    PrimaryKey = ExtensionArgs.PrimaryKey

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Grid.BeforePrintListPage_SubTag(Cancel, Args, WhizGlobal, PrimaryKey)
                End If
            End Sub
            'Added by Ninad on 26 Dec 2007, ReqID WAF3_PB_55 Multi Insert Subtag
            Protected Overrides Sub Initialize_Controls(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_InitializeControls, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef ControlCollection As CommonEngines.HashTables.UIControlTagMaster())
                Call CommonEngine.General.CLCP_Events_Controls.Initialize_Controls(Cancel, Args, WhizGlobal, ControlCollection)
            End Sub
            Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", "Before_PlotControlCell")
                If blnCheckEventCall = True Then
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, _
                                                                              "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                                                                              "Before_PlotControlCell", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls
                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    Call CommonEngine.General.CLCP_Events_Controls.Before_PlotControlCell(Cancel, Args, WhizGlobal, drControls)
                End If
            End Sub

            Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", "After_PlotControlCell")
                If blnCheckEventCall = True Then
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, _
                                                                              "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                                                                               "After_PlotControlCell", ExtensionArgs)
                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls
                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    Call CommonEngine.General.CLCP_Events_Controls.After_PlotControlCell(Args, WhizGlobal, drControls)
                End If
            End Sub
            Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", "Before_PlotControl")
                If blnCheckEventCall = True Then
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls
                    ExtensionArgs.InsertBeforeCaption = InsertBeforeControl
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, _
                                                                              "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                                                                            "Before_PlotControl", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls
                    InsertBeforeControl = ExtensionArgs.InsertBeforeControl
                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    Call CommonEngine.General.CLCP_Events_Controls.Before_PlotControl(Cancel, Args, WhizGlobal, drControls, InsertBeforeControl)
                End If
            End Sub

            Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                            "After_PlotControl")
                If blnCheckEventCall = True Then
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls
                    ExtensionArgs.InsertAfterControl = InsertAfterControl
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                            "After_PlotControl", ExtensionArgs)
                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls
                    InsertAfterControl = ExtensionArgs.InsertAfterControl
                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    Call CommonEngine.General.CLCP_Events_Controls.After_PlotControl(Args, WhizGlobal, drControls, InsertAfterControl)
                End If
            End Sub
            'End Addition by Ninad on 26 Dec 2007, ReqID WAF3_PB_55 Multi Insert Subtag
        End Class

        Public Class cSubTagCLSQL
            Inherits CommonEngines.CommonList.cSubTagCLSQL

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                'Assign the Parameter values to the local variables
                Call MyBase.New(WhizGlobal)
            End Sub
            'WAF3_PB_38 Issue Fix April 24, 2007 UmeshJ 2.0.08-SP7-WAF START
            Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call CommonEngine.General.CLCP_Events_Grid.Initialize_GridSQL(Cancel, Args, WhizGlobal)
            End Sub
            'WAF3_PB_38 Issue Fix April 24, 2007 UmeshJ 2.0.08-SP7-WAF END
            Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetPageSpecificFilters")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetPageSpecificFilters", ExtensionArgs)

                    objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    GetPageSpecificFilters = CommonEngine.General.cPageSpecificBehavior.GetPageSpecificFilters(objGlobal)
                End If
                'addition ends

            End Function
            Protected Overrides Function GetUIPageURL(ByVal FunctionName As String, ByVal objGlobal As WebPages.Template.IGlobal, ByVal blnEditMode_UIPageOpenInWindow As Boolean, ByVal strUIPage As String) As String
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetUIPageURL")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************

                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = objGlobal
                    ExtensionArgs.FunctionName = FunctionName
                    ExtensionArgs.EditMode_UIPageOpenInWindow = blnEditMode_UIPageOpenInWindow
                    ExtensionArgs.UIPage = strUIPage
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetUIPageURL", ExtensionArgs)

                    objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    GetUIPageURL = CommonEngine.General.cPageSpecificBehavior.GetUIPageURL(FunctionName, objGlobal, blnEditMode_UIPageOpenInWindow, strUIPage)
                End If
                'addition ends.
            End Function

            Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                    "Before_UploadAttachment")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_attachUpload = Args
                    ExtensionArgs.m_global = WhizGlobal
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                    "Before_UploadAttachment", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_attachUpload
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Attachments.Before_UploadAttachment(Cancel, Args, WhizGlobal)
                End If
            End Sub

            Protected Overrides Sub After_UploadAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                    "After_UploadAttachment")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_attachUpload = Args
                    ExtensionArgs.m_global = WhizGlobal
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                    "After_UploadAttachment", ExtensionArgs)

                    Args = ExtensionArgs.m_attachUpload
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Attachments.After_UploadAttachment(Args, WhizGlobal)
                End If
            End Sub

            Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                    "Before_SaveAttachment")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_attachSave = Args
                    ExtensionArgs.m_global = WhizGlobal
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                    "Before_SaveAttachment", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_attachSave
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Attachments.Before_SaveAttachment(Cancel, Args, WhizGlobal)
                End If
            End Sub

            Protected Overrides Sub After_SaveAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                    "After_SaveAttachment")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_attachSave = Args
                    ExtensionArgs.m_global = WhizGlobal
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                    "After_SaveAttachment", ExtensionArgs)

                    Args = ExtensionArgs.m_attachSave
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Attachments.After_SaveAttachment(Args, WhizGlobal)
                End If
            End Sub

            Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_SubTag", _
                                    "BeforePlotDetails_SubTag")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_SubTag = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.PrimaryKey = PrimaryKey
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_SubTag", _
                                    "BeforePlotDetails_SubTag", ExtensionArgs)
                    Args = ExtensionArgs.m_SubTag
                    Cancel = ExtensionArgs.Cancel
                    PrimaryKey = ExtensionArgs.PrimaryKey
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_SubTag.BeforePlotDetails_SubTag(Cancel, Args, WhizGlobal, PrimaryKey)
                End If
            End Sub

            Protected Overrides Sub Before_ViewAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Attachments", "Before_ViewAttachment")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_attachmentView = Args
                    ExtensionArgs.m_global = WhizGlobal


                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, _
                                                                             "Whiz.CommonEngine.General.CLCP_Events_Attachments", _
                                                                             "Before_ViewAttachment", ExtensionArgs)
                    Args = ExtensionArgs.m_attachmentView
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Attachments.Before_ViewAttachment(Args, WhizGlobal)
                End If
            End Sub
            '_______________________Added By UmeshJ on 18 November 2004___________________________#ATT18
            Protected Overrides Sub Initialize_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentDeleteInitialize, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call CommonEngine.General.CLCP_Events_Attachments.Initialize_AttachmentDelete(Cancel, Args, WhizGlobal)
            End Sub
            Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call CommonEngine.General.CLCP_Events_Attachments.Before_AttachmentDelete(Cancel, Args, WhizGlobal)
            End Sub
            Protected Overrides Sub After_AttachmentDelete(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call CommonEngine.General.CLCP_Events_Attachments.After_AttachmentDelete(Args, WhizGlobal)
            End Sub
            '_______________________End of addition on 18 November 2004___________________________

            Public Overrides Sub DeleteRecords()
                '=====================================================================
                ' Procedure Name        :	DeleteRecords
                ' Purpose               :	This method will delete the Records.
                '                           It will create the object of the class cCLDelete 
                '                           to delete the records 
                '                           Set value for the DeletionResult
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	Sunday, October 19, 2003 
                ' Revisions             :
                '=====================================================================
                If strDeletionIDList.Trim = "" Then Return

                'If the Selected Tab is Attachment tab then call the DeleteAttachment function
                If blnIsAttachmentTab = True Then
                    Call DeleteAttachments()
                    If m_strDeletionSQL.Trim <> "" Then
                        'Added By UmeshJ on Sep 07, 2004
                        If InStr(UCase(m_strDeletionSQL), " WHERE ") = 0 Then
                            'For single attachment if where condition is not specified
                            m_strDeletionSQL += " WHERE " + strPrimaryKey + " IN (" + strDeletionIDList.Trim + ")"
                        End If
                        'End of addition
                        'Clear the Attachment Details
                        '==========================================================================================================
                        'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
                        '==========================================================================================================
                        CommonFunctions.Data.InsertOrUpdateData(m_strDeletionSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), m_ConnectionString)
                        '==========================================================================================================
                        ' Addition End By : Ninad   Req Id : WAF3_PB_33
                        '==========================================================================================================
                        Return
                    End If
                End If
                Dim cobjCLDelete As New CommonEngine.CommonList.cCLDelete(m_ObjGlobal)
                '==========================================================================================================
                'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
                '==========================================================================================================
                cobjCLDelete.ConnectionString = m_ConnectionString
                '==========================================================================================================
                ' Addition End By : Ninad   Req Id : WAF3_PB_33
                '==========================================================================================================
                cobjCLDelete.DeletionIDList = strDeletionIDList
                cobjCLDelete.DeletionSPName = m_strDeletionSPName
                cobjCLDelete.PrimaryKeyColumn = strPrimaryKey
                cobjCLDelete.TableName = m_strTableName
                cobjCLDelete.SubTagID = lngSubTagId
                'Added By Chakshuta H on 29th-Oct-2015
                '=============================================================================================
                'Added By Abhijeet Nikam On 30-JUL-2010 For Transaction History 
                '=============================================================================================

                cobjCLDelete.MaintainTransHistory = blnMaintainTransHistory
                If blnMaintainTransHistory = True Then
                    cobjCLDelete.TransactionHistory_DeletedBy = strTransHistory_DeletedBy
                End If
                '=============================================================================================
                'Addition End By Abhijeet Nikam On 30-JUL-2010 For Transaction History
                '=============================================================================================
                'Ended By Chakshuta H on 29th-Oct-2015
                strDeletionResult = cobjCLDelete.DeleteRecords()
                cobjCLDelete = Nothing


            End Sub


            Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

            End Sub

        End Class 'End cSubTagCLSQL

        Public Class cCLSQL
            Inherits CommonEngines.CommonList.cCLSQL

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                'Assign the Parameter values to the local variables
                Call MyBase.New(WhizGlobal)
            End Sub
            'WAF3_PB_38 Issue Fix April 24, 2007 UmeshJ 2.0.08-SP7-WAF START
            Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call CommonEngine.General.CLCP_Events_Grid.Initialize_GridSQL(Cancel, Args, WhizGlobal)
            End Sub
            'WAF3_PB_38 Issue Fix April 24, 2007 UmeshJ 2.0.08-SP7-WAF END
            Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetPageSpecificFilters")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetPageSpecificFilters", ExtensionArgs)

                    objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    GetPageSpecificFilters = CommonEngine.General.cPageSpecificBehavior.GetPageSpecificFilters(objGlobal)
                End If
                'addition ends

            End Function
            Protected Overrides Function GetUIPageURL(ByVal FunctionName As String, ByVal objGlobal As WebPages.Template.IGlobal, ByVal blnEditMode_UIPageOpenInWindow As Boolean, ByVal strUIPage As String) As String
                GetUIPageURL = CommonEngine.General.cPageSpecificBehavior.GetUIPageURL(FunctionName, objGlobal, blnEditMode_UIPageOpenInWindow, strUIPage)
            End Function
            Public Overrides Sub DeleteRecords()
                '=====================================================================
                ' Procedure Name        :	DeleteRecords
                ' Purpose               :	This method will delete the Records.
                '                           It will create the object of the class cCLDelete 
                '                           to delete the records 
                '                           Set value for the DeletionResult
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	Sunday, October 19, 2003 
                ' Revisions             :
                '=====================================================================
                If strDeletionIDList.Trim = "" Then Return

                Dim cobjCLDelete As New CommonEngine.CommonList.cCLDelete(m_ObjGlobal)

                ''Code Modified by swapnil aswale on 13-1-2016  to handle responsive code [generating duplicate checkbox ]
                Dim Result As String = String.Empty
                Dim newArray As Array
                newArray = Split(strDeletionIDList, ",")
                For i As Integer = 0 To newArray.Length - 1
                    If Result.IndexOf(newArray(i).ToString()) = -1 Then
                        If i = 0 Then
                            Result += newArray(i).ToString()
                        Else
                            Result += "," & newArray(i).ToString()
                        End If
                    End If
                Next
                strDeletionIDList = Result
                ''Ended

                '==========================================================================================================
                ' Purpose               :	To set connection string property
                ' Description           :	same as above
                ' Requirement Tag       :   WAF3_PB_33 
                ' Added By              :	Ninad
                ' Created               :	10 Nov 2006 
                '==========================================================================================================
                cobjCLDelete.ConnectionString = m_ConnectionString
                '==========================================================================================================
                ' Addition End By : Ninad   Req Id : WAF3_PB_33
                '==========================================================================================================

                cobjCLDelete.DeletionIDList = strDeletionIDList
                cobjCLDelete.DeletionSPName = m_strDeletionSPName
                cobjCLDelete.PrimaryKeyColumn = strPrimaryKey
                cobjCLDelete.TableName = m_strTableName
                'Added By Chakshuta H on 29th-Oct-2015
                '==========================================================================
                'Added By Abhijeet Nikam On 30-JUL-2010 For Transaction History
                '==========================================================================
                cobjCLDelete.MaintainTransHistory = blnMaintainTransHistory
                If blnMaintainTransHistory = True Then
                    cobjCLDelete.TransactionHistory_DeletedBy = strTransHistory_DeletedBy
                End If
                '==========================================================================
                'Addition End By Abhijeet Nikam On 30-JUL-2010 For Transaction History
                '==========================================================================
                'Ended By Chakshuta H on 29th-Oct-2015
                strDeletionResult = cobjCLDelete.DeleteRecords
                  cobjCLDelete = Nothing
            End Sub

        End Class

        Public Class cSubTagDynamicFilters
            Inherits CommonEngines.CommonList.cSubTagDynamicFilters

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                'Assign the Parameter values to the local variables
                Call MyBase.New(WhizGlobal)
            End Sub

            Protected Overrides Sub Initialize_Filters(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFiltersTable, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                            "Initialize_Filters")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.PlotDynamicFiltersTable = Args
                    ExtensionArgs.m_global = WhizGlobal


                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                            "Initialize_Filters", ExtensionArgs)

                    Args = ExtensionArgs.PlotDynamicFiltersTable
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Dim obj As New CommonEngine.General.CLCP_Events_DynamicFilters

                    obj.Initialize_Filters(Cancel, Args, WhizGlobal)
                    obj = Nothing
                End If
            End Sub

            Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                                "Before_Filter_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.PlotDynamicFilter = Args
                    ExtensionArgs.m_global = m_ObjGlobal


                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                                "Before_Filter_Print", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.PlotDynamicFilter
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Dim obj As New CommonEngine.General.CLCP_Events_DynamicFilters
                    obj.Before_Filter_Print(Cancel, Args, WhizGlobal)
                    obj = Nothing
                End If
            End Sub

            Protected Overrides Sub After_Filter_Print(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                            "After_Filter_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.PlotDynamicFilter = Args
                    ExtensionArgs.m_global = WhizGlobal


                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                            "After_Filter_Print", ExtensionArgs)

                    Args = ExtensionArgs.PlotDynamicFilter
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Dim obj As New CommonEngine.General.CLCP_Events_DynamicFilters
                    obj.After_Filter_Print(Args, WhizGlobal)
                    obj = Nothing
                End If
            End Sub
        End Class

        Public Class cDynamicFilters
            Inherits CommonEngines.CommonList.cDynamicFilters

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                'Assign the Parameter values to the local variables
                Call MyBase.New(WhizGlobal)
            End Sub

            Protected Overrides Sub Initialize_Filters(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFiltersTable, ByVal WhizGlobal As WebPages.Template.IGlobal)
                CommonEngine.General.CLCP_Events_DynamicFilters.Initialize_Filters(Cancel, Args, WhizGlobal)
            End Sub

            Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
                CommonEngine.General.CLCP_Events_DynamicFilters.Before_Filter_Print(Cancel, Args, WhizGlobal)
            End Sub

            Protected Overrides Sub After_Filter_Print(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
                CommonEngine.General.CLCP_Events_DynamicFilters.After_Filter_Print(Args, WhizGlobal)
            End Sub
        End Class

        Public Class cCLDelete
            Inherits CommonEngines.CommonList.cCLDelete
            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call MyBase.New(WhizGlobal)
            End Sub
            '==========================================================================================================
            ' Purpose               :	The signature will be modified. ConnectionString (string) parameter will be added. 
            '                           This parameter will be passed to the method CommonEngine.General. cPageSpecificBehavior.ExecuteDeletionSP
            ' Description           :	same as above
            ' Requirement Tag       :   WAF3_PB_33 
            ' Modified By           :	Ninad
            ' Created               :	10 Nov 2006 
            '==========================================================================================================
            Protected Overrides Function ExecuteDeletionSP(ByVal strDeletionSP As String, ByVal UniqueID As String, ByVal objGlobal As WebPages.Template.IGlobal, Optional ByVal lngSubTagId As Long = 0, Optional ByVal strConnectionString As String = "") As String
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "ExecuteDeletionSP")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = objGlobal
                    ExtensionArgs.UniqueID = UniqueID
                    ExtensionArgs.SubTagID = lngSubTagId
                    ExtensionArgs.SQL = strDeletionSP
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "ExecuteDeletionSP", ExtensionArgs)


                    objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************

                    ExecuteDeletionSP = CommonEngine.General.cPageSpecificBehavior.ExecuteDeletionSP(strDeletionSP, UniqueID, objGlobal, lngSubTagId, strConnectionString)
                End If
                'addition ends.
            End Function
            '==========================================================================================================
            ' Modification End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================

        End Class

    End Namespace

    Namespace CommonPage
        Public Class cPlotControls
            Inherits CommonEngines.CommonPage.cPlotControls

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call MyBase.New(WhizGlobal)
            End Sub
            'UJ_25052007 WAF3_PB_49
            Protected Overrides Sub Initialize_Controls(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_InitializeControls, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef ControlCollection As CommonEngines.HashTables.UIControlTagMaster())
                Call CommonEngine.General.CLCP_Events_Controls.Initialize_Controls(Cancel, Args, WhizGlobal, ControlCollection)
            End Sub
            Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", "Before_PlotControlCell")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, _
                                                                              "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                                                                              "Before_PlotControlCell", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Controls.Before_PlotControlCell(Cancel, Args, WhizGlobal, drControls)
                End If
            End Sub

            Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", "After_PlotControlCell")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs


                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, _
                                                                              "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                                                                               "After_PlotControlCell", ExtensionArgs)

                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Controls.After_PlotControlCell(Args, WhizGlobal, drControls)
                End If
            End Sub

            Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", "Before_PlotControlCaption")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls
                    ExtensionArgs.InsertBeforeCaption = InsertBeforeCaption

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, _
                                                                              "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                                                                              "Before_PlotControlCaption", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls
                    InsertBeforeCaption = ExtensionArgs.InsertBeforeCaption

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Controls.Before_PlotControlCaption(Cancel, Args, WhizGlobal, drControls, InsertBeforeCaption)
                End If
            End Sub

            Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                            "After_PlotControlCaption")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls
                    ExtensionArgs.InsertAfterCaption = InsertAfterCaption
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                            "After_PlotControlCaption", ExtensionArgs)

                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls
                    InsertAfterCaption = ExtensionArgs.InsertAfterCaption

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Controls.After_PlotControlCaption(Args, WhizGlobal, drControls, InsertAfterCaption)
                End If
            End Sub

            Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", "Before_PlotControl")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls
                    ExtensionArgs.InsertBeforeCaption = InsertBeforeControl
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, _
                                                                              "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                                                                              "Before_PlotControl", ExtensionArgs)
                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls
                    InsertBeforeControl = ExtensionArgs.InsertBeforeControl

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Controls.Before_PlotControl(Cancel, Args, WhizGlobal, drControls, InsertBeforeControl)
                End If
            End Sub

            Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                            "After_PlotControl")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_control = Args
                    ExtensionArgs.m_global = WhizGlobal
                    ExtensionArgs.drControls = drControls
                    ExtensionArgs.InsertAfterControl = InsertAfterControl
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Controls", _
                            "After_PlotControl", ExtensionArgs)

                    Args = ExtensionArgs.m_control
                    WhizGlobal = ExtensionArgs.m_global
                    drControls = ExtensionArgs.drControls
                    InsertAfterControl = ExtensionArgs.InsertAfterControl

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_Controls.After_PlotControl(Args, WhizGlobal, drControls, InsertAfterControl)
                End If

            End Sub

            Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                        "Before_GridLinksFunction_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = Cancel
                    ExtensionArgs.m_gridlinks_Function = Args
                    ExtensionArgs.m_global = WhizGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(WhizGlobal.TagID, WhizGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                        "Before_GridLinksFunction_Print", ExtensionArgs)

                    Cancel = ExtensionArgs.Cancel
                    Args = ExtensionArgs.m_gridlinks_Function
                    WhizGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    Call CommonEngine.General.CLCP_Events_DynamicActions.Before_GridLinksFunction_Print(Cancel, Args, WhizGlobal)
                End If
            End Sub

            Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetCheckDuplicateSQL")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = objGlobal
                    ExtensionArgs.SQL = strSQL
                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(objGlobal.TagID, objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetCheckDuplicateSQL", ExtensionArgs)


                    objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    GetCheckDuplicateSQL = CommonEngine.General.cPageSpecificBehavior.GetCheckDuplicateSQL(strSQL, objGlobal)
                End If
                'addition ends.
            End Function
        End Class

        Public Class cSubTagCPSQL
            Inherits cCPSQL
            '=====================================================================
            ' Class	Name	        :	cSubTagCPSQL
            ' Purpose				:	It will retrieve data from the database to 
            '                           plot Sub Common Page Controls
            ' Description			:	Same as above
            ' Assumptions			:	None
            ' Dependencies			:	Inherits cCPSQL
            ' Author				:	UmeshJ
            ' Created				:	November 20, 2003
            ' Revisions				:	
            '=====================================================================
            Private strForeignKeyValue As String = ""
            'Class  variables
            Private m_blnIsCommonPageTab As Boolean = False
            Public WriteOnly Property ForeignKeyValue() As String
                Set(ByVal Value As String)
                    strForeignKeyValue = Value
                End Set
            End Property
            Private strForeignKey As String = ""
            Public Property ForeignKey() As String
                Set(ByVal Value As String)
                    strForeignKey = Value
                End Set
                Get
                    Return strForeignKey
                End Get
            End Property
            'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 22 Nov 2007
            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                MyBase.New(WhizGlobal)
            End Sub

            Public Overrides Function GetSettings() As String
                '=====================================================================
                ' Procedure Name        :	GetSettings
                ' Purpose               :	This method will retrieve the different
                '                           page settings from the database and assigns those
                '                           to the corresponding properties
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	Monday, October 08, 2003 
                ' Revisions             :
                '=====================================================================
                Call GetPageDetails()
                Call GetParentProperties() 'WAF3_PB_26
                Call GetPrimaryKey()
                If strPrimaryKey.Trim <> "" Then Call GetFormSQL()
                'Added By Chakshuta H on 29th-Oct-2015
                '-----------------------------------------------------------------------
                'Added By ShrikantB ON 21-JUL-2010 For Concurrency Control 
                '-----------------------------------------------------------------------
                If (strPrimaryKey.Trim <> "" AndAlso blnMaintainConcurrency = True) Then
                    Call GetCurrentTimestampValue()
                End If
                '-----------------------------------------------------------------------
                'Addition End By ShrikantB ON 21-JUL-2010 For Concurrency Control 
                '-----------------------------------------------------------------------

                'Ended By Chakshuta H on 29th-Oct-2015
                Call GetSetUserPreferences()
            End Function

            Private Sub GetParentProperties()
                '=====================================================================
                ' Procedure Name        :	GetParentProperties
                ' Purpose               :	This method will retrieve the Parent Web Form Properties
                '                           Page Details from the Tag Master
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	Wednesday, August 23, 2006 (Req. ID. WAF3_PB_26)
                ' Revisions             :   
                '=====================================================================
                Dim objTagMaster As CommonEngines.HashTables.UITagMaster
                If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_ObjGlobal.LCID Then
                    objTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_ObjGlobal.ParentTagID)
                Else
                    objTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterCultureObject(m_ObjGlobal.ParentTagID.ToString.Trim & m_ObjGlobal.LCID.ToString)
                    If objTagMaster Is Nothing Then
                        objTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_ObjGlobal.ParentTagID)
                    End If
                End If
                'WAF3_PB_26: Added By UmeshJ on 23 Aug 2006
                m_blnEnablePKSecurity = objTagMaster.EnablePKSecurity
                'End of Addition
                objTagMaster = Nothing
            End Sub

            Private Sub GetPageDetails()
                '=====================================================================
                ' Procedure Name        :	GetPageDetails
                ' Purpose               :	This method will retrieve the 
                '                           Page Details from the Tag Master
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	Monday, November 20, 2003 
                ' Revisions             :
                '=====================================================================

                Dim objUITagMaster As CommonEngines.HashTables.SubUITagMaster()

                If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_ObjGlobal.LCID Then
                    'Local culture ID is same as the default culture id
                    objUITagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(m_ObjGlobal.ParentTagID)
                Else
                    'Culture ID is other than the default culture id
                    'Check if the Culture is supported by the system
                    'Yes. Culture is supported. Retrieve the data specific to that Culture 
                    objUITagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(m_ObjGlobal.ParentTagID.ToString.Trim & m_ObjGlobal.LCID.ToString)
                    If objUITagMaster Is Nothing Then
                        'No. Culture is NOT supported. Retrieve the data from the defual culture 
                        objUITagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(m_ObjGlobal.ParentTagID)
                    End If
                End If
                'Page Details from the hash table
                Dim intIndex As Integer = 0
                Dim intLastIndex As Integer = objUITagMaster.Length - 1
                For intIndex = 0 To intLastIndex
                    If m_ObjGlobal.TagID = objUITagMaster(intIndex).SubTagID Then
                        'IF the Current tag is the selected Tag then retrieve details for it
                        strPageCaption = objUITagMaster(intIndex).TagDescription.ToString
                        If CommonFunctions.General.CheckIsNothing(objUITagMaster(intIndex).RelativeView) = "" Then
                            m_strTableOrViewName = objUITagMaster(intIndex).TableName.ToString
                        Else
                            m_strTableOrViewName = objUITagMaster(intIndex).RelativeView.ToString
                        End If
                        strTableName = objUITagMaster(intIndex).TableName.ToString
                        'Header
                        strPageHeader = objUITagMaster(intIndex).UIPageHeader.ToString
                        'Footer
                        strPageFooter = objUITagMaster(intIndex).UIPageFooter.ToString
                        strCPLegend = objUITagMaster(intIndex).CPPageLegend.ToString
                        'Events
                        blnBeforeSave = CType(objUITagMaster(intIndex).EnableEventBeforeSaveOnCP, Boolean)
                        blnAfterSave = CType(objUITagMaster(intIndex).EnableEventAfterSaveOnCP, Boolean)
                        blnPreRender = CType(objUITagMaster(intIndex).EnableEventPreRenderOnCP, Boolean)
                        'Access
                        blnApplyRoleLevelAccess = CType(objUITagMaster(intIndex).ApplyRoleLevelAccess, Boolean)
                        'Common Page Tab
                        If InStr(1, objUITagMaster(intIndex).PageName.ToUpper, "COMMONPAGE.ASPX", CompareMethod.Text) <> 0 Then
                            m_blnIsCommonPageTab = True
                        End If
                        'Audit Trail
                        If objUITagMaster(intIndex).MaintainAuditTrail = True Then
                            strAuditTrialField_CreatedBy = objUITagMaster(intIndex).AuditTrail_CreatedBy
                            strAuditTrialField_CreatedDate = objUITagMaster(intIndex).AuditTrail_CreatedDate
                            strAuditTrialField_UpdatedBy = objUITagMaster(intIndex).AuditTrail_UpdatedBy
                            strAuditTrialField_UpdatedDate = objUITagMaster(intIndex).AuditTrail_UpdatedDate
                            blnMaintainAuditTrail = True
                        End If

                        'Added By Chakshuta H on 29th-Oct-2015

                        '========================================================================
                        'Added By Abhijeet Nikam On 27 July 2010 For Transaction History
                        '-------------------------------------------------------------------------
                        If objUITagMaster(intIndex).MaintainTransHistory = True Then
                            blnShowTransactionHistory = True
                        End If
                        '------------------------------------------------------------------------
                        'Addition End By  Abhijeet Nikam On 27 July 2010 For Transaction History
                        '========================================================================
                        '------------------------------------------------------------------------------------------
                        'Added By ShrikantB on 20-JUL-2010 For Concurrency Control
                        '------------------------------------------------------------------------------------------
                        If objUITagMaster(intIndex).MaintainConcurrency = True Then
                            strConcurrency_UpdatedDate = objUITagMaster(intIndex).Concurreny_Timestamp
                            strConcurrency_UpdatedBy = objUITagMaster(intIndex).Concurreny_UpdatedBy
                            blnMaintainConcurrency = True
                        End If
                        '------------------------------------------------------------------------------------------
                        'Addition End By ShrikantB On 20-JUL-2010 For Concurrency Control
                        '------------------------------------------------------------------------------------------
                        'Ended By Chakshuta H on 29th-Oct-2015

                        blnPostRender = objUITagMaster(intIndex).EnableEventPostRenderOnCP
                        'Added By UmeshJ for WAF2..Build1
                        blnDisplayNavigationLinks = objUITagMaster(intIndex).ShowNavigationLinks
                        'End of addition
                        blnIsIdentityOn = objUITagMaster(intIndex).IsIdentityOn
                        'WAF3_PB_42 April 06, 2007 START
                        If CommonFunctions.General.GetFrameworkSettings("GEN_ACTION_NAVIGATION_DROPDOWNMENU", "Enabled") = False Then
                            m_intAction_NavigationSchema = DynamicAction_NavigationSchema.CLASSICAL
                        Else
                            m_intAction_NavigationSchema = CType(objUITagMaster(intIndex).DynamicAction_NavigationSchema, CommonEngines.CommonPage.cCPSQL.DynamicAction_NavigationSchema)
                        End If
                        'Determine the Menu position
                        If m_intAction_NavigationSchema = DynamicAction_NavigationSchema.DROPDOWN Then
                            m_intDropdownMenu_Width = objUITagMaster(intIndex).DropdownMenu_Width_OnForm
                            m_strDropdownMenu_HideControls = objUITagMaster(intIndex).DropdownMenu_HideControls_OnForm
                        End If
                        'WAF3_PB_42 April 06, 2007 END
                        m_blnIsDesignMode = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_ObjGlobal.ParentTagID).IsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 25 May 2007
                    End If
                Next
                objUITagMaster = Nothing
                'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 22 Nov 2007
                Dim objUICtrlTagMaster As CommonEngines.HashTables.UIControlTagMaster()
                Dim objControl As CommonEngines.HashTables.UIControlTagMaster
                If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_ObjGlobal.LCID Then
                    'Local culture ID is same as the default culture id
                    objUICtrlTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubControlTagMasterCPObject(CType(m_ObjGlobal.TagID, Long))
                Else
                    'Culture ID is other than the default culture id
                    'Check if the Culture is supported by the system
                    objUICtrlTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubControlTagMasterCPObject(m_ObjGlobal.TagID.ToString & CType(m_ObjGlobal.LCID, String))
                    If objUICtrlTagMaster Is Nothing Then
                        'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                        objUICtrlTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubControlTagMasterCPObject(CType(m_ObjGlobal.TagID, Long))
                    End If
                End If
                For Each objControl In objUICtrlTagMaster
                    If objControl.IsForeignKey Then
                        strForeignKey = objControl.ControlName
                        Exit For
                    End If
                Next
                objUICtrlTagMaster = Nothing
                objControl = Nothing
                'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 22 Nov 2007
                'Get the Table Name from the Table or View Name
                If strTableName.Trim <> "" Then
                    strTableName = CommonFunctions.General.GetTableName(strTableName)
                ElseIf m_strTableOrViewName.Trim <> "" Then
                    strTableName = CommonFunctions.General.GetTableName(m_strTableOrViewName)
                End If
                'Call CommonEngines.General.cPageSpecificBehavior.GetPageCaption(m_ObjGlobal, strPageCaption)
            End Sub

            Protected Overrides Sub GetSetUserPreferences()
                '=====================================================================
                ' Procedure Name        :	GetSetUserPreferences
                ' Purpose               :	This method will retrieve and save the 
                '                           User Preferences
                ' Description           :	The sorting preferences will be stored for 
                '                           the user for the page. When next time the page
                '                           will be visited, it will be displayed according 
                '                           to the previously saved user preferences  
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	PrasannaP
                ' Created               :	25, May, 2005
                ' Revisions             :
                '=====================================================================
                Dim strTemp As String

                'Set the Preferences for the user
                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SubSectionID")) <> "" And CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SubSectionIDValue")) <> "" Then
                    'User has clicked on the Section. Save the settings 
                    Select Case CType(HttpContext.Current.Request("SubSectionID"), Long)
                        Case CommonFunctions.Constants.SECTION_HEADER
                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_HEADER + "-" + m_ObjGlobal.TagID.ToString, CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SectionIDValue"))))
                        Case CommonFunctions.Constants.SECTION_SUBTAG
                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_SUBTAG + "-" + m_ObjGlobal.TagID.ToString, CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SectionIDValue"))))
                        Case CommonFunctions.Constants.SECTION_GRAPH
                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_GRAPH + "-" + m_ObjGlobal.TagID.ToString, CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SectionIDValue"))))
                        Case CommonFunctions.Constants.SECTION_RELATED_DATA
                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_RELATEDDATA + "-" + m_ObjGlobal.TagID.ToString, CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SectionIDValue"))))
                        Case CommonFunctions.Constants.SECTION_FOOTER
                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_FOOTER + "-" + m_ObjGlobal.TagID.ToString, CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SectionIDValue"))))
                    End Select
                End If

                'Get the Paging preferences for the user for the page from the database
                strTemp = CType(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_HEADER + "-" + m_ObjGlobal.TagID.ToString), String)
                If Not strTemp Is Nothing Then
                    bytSectionPreferences(0) = CType(strTemp, Byte)
                End If
                strTemp = CType(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_SUBTAG + "-" + m_ObjGlobal.TagID.ToString), String)
                If Not strTemp Is Nothing Then
                    bytSectionPreferences(1) = CType(strTemp, Byte)
                End If
                strTemp = CType(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_GRAPH + "-" + m_ObjGlobal.TagID.ToString), String)
                If Not strTemp Is Nothing Then
                    bytSectionPreferences(2) = CType(strTemp, Byte)
                End If
                strTemp = CType(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_RELATEDDATA + "-" + m_ObjGlobal.TagID.ToString), String)
                If Not strTemp Is Nothing Then
                    bytSectionPreferences(3) = CType(strTemp, Byte)
                End If
                strTemp = CType(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(m_ObjGlobal.UserID.ToString + "-" + m_ObjGlobal.LoginType + "-" + CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_SUBTAG_FOOTER + "-" + m_ObjGlobal.TagID.ToString), String)
                If Not strTemp Is Nothing Then
                    bytSectionPreferences(4) = CType(strTemp, Byte)
                End If
            End Sub

            Public Overrides Sub GetNavigationLinks()
                '=====================================================================
                ' Procedure Name        :	GetNavigationLinks
                ' Purpose               :	This method will retrieve the Navigation links
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 06,2003
                ' Revisions             :   UJ_18.01.2007_195
                '=====================================================================
                If strPrimaryKey.Trim <> "" And strPrimaryKeyValue.Trim <> "" Then
                    Dim strSQL As String
                    Dim objPrimaryKeyValue As Object
                    Dim arrListRowLink As New System.Collections.ArrayList
                    If m_strFilter.Trim = "" Then m_strFilter = GetSubTagNavigationWhereClause()
                    If m_strSortBy.Trim = "" Then
                        'Consider the Sorting user preferences
                        Dim objCLSQL As New CommonEngines.CommonList.cSubTagCLSQL(m_ObjGlobal)
                        objCLSQL.SubTagId = m_ObjGlobal.TagID
                        objCLSQL.GetSetUserPreferences()
                        m_strSortBy = objCLSQL.SortBy
                        m_strSortOrder = objCLSQL.SortOrder
                        objCLSQL = Nothing
                        'If user preferences for the sorting are not present then get default sorting column
                        If m_strSortBy.Trim = "" Then
                            'UJ_18.01.2007_195 Start
                            'Dim objSortBy As Object
                            'strSQL = "usp_Sel_v_tbl_UI_SubControlTagMaster_FieldDetails " + m_ObjGlobal.TagID.ToString + ", 'ControlName','DefaultSorting=1 And ShowInGrid=1'"
                            m_strSortOrder = "ASC"
                            m_strSortBy = GetControl(m_ObjGlobal.TagID, WAF_ControlPropertyGroups.DefaultSorting, True)
                            If m_strSortBy = "" Then m_strSortBy = strPrimaryKey
                            'objSortBy = CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'If Not objSortBy Is Nothing Then
                            '    m_strSortBy = objSortBy.ToString
                            'Else
                            '    m_strSortBy = strPrimaryKey
                            'End If
                            'UJ_18.01.2007_195 End
                        End If
                    End If

                    'Get the Group Name if Grouping is On
                    Dim strGroupName As String
                    'UJ_18.01.2007_195 Start
                    'strSQL = "usp_Sel_v_tbl_UI_SubControlTagMaster_FieldDetails " + m_ObjGlobal.TagID.ToString + ", 'ControlName','IsGroupHeader=1 And ShowInGrid=1'"
                    'strGroupName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                    strGroupName = GetControl(m_ObjGlobal.TagID, WAF_ControlPropertyGroups.IsGroupHeader, True)
                    'UJ_18.01.2007_195 End
                    If strGroupName.Trim <> "" And m_strSortBy.Trim <> "" Then strGroupName += ","

                    Dim strOrderByClause As String
                    'Order By Clause
                    If m_strSortBy.Trim <> "" Then strOrderByClause = " ORDER BY " + strGroupName + m_strSortBy.Trim + " " + m_strSortOrder
                    Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean) '2.0.7.02
                    'Modified By UmeshJ on 24 Nov 2004 for Navigation Links problem if grouping is applied 
                    strSQL = "SELECT " + strPrimaryKey + " AS PK FROM " + m_strTableOrViewName
                    If blnUseSQL = True Then strSQL = strSQL + " WITH(NOLOCK)" 'Hotfix 2.0.7.02----
                    strSQL = strSQL + " WHERE 1 = 1 " + m_strFilter + strOrderByClause '" ORDER BY " + m_strSortBy.Trim + " " + m_strSortOrder
                    'End of addition

                    'UJ_04092006 START
                    Dim strFlag As String = GetNavDetailsFromDataset(strSQL, strPrimaryKeyValue, "NAV_LINKS")
                    If InStr(strFlag, "DISPLAY_FIRST") <> 0 Then
                        'Current entry is NOT the First Entry..hence display the FIRST and PREVIOUS navigation links
                        arrListRowLink.Add("FIRST")
                        arrListRowLink.Add("PREVIOUS")
                    End If
                    If InStr(strFlag, "DISPLAY_LAST") <> 0 Then
                        'Current entry is NOT the Last Entry..hence display the NEXT and LAST navigation links
                        arrListRowLink.Add("NEXT")
                        arrListRowLink.Add("LAST")
                    End If
                    'Dim strPK As String() = GetArrayFromDataset(strSQL)
                    'Dim intIndex As Integer = strPK.IndexOf(strPK, strPrimaryKeyValue)
                    'If intIndex <> -1 Then
                    '    If intIndex <> 0 Then
                    '        'Get the previous entry
                    '        arrListRowLink.Add("FIRST")
                    '        'Get the previous entry
                    '        arrListRowLink.Add("PREVIOUS")
                    '    End If
                    '    If intIndex <> (strPK.Length - 1) Then
                    '        'Get the next entry
                    '        arrListRowLink.Add("NEXT")
                    '        arrListRowLink.Add("LAST")
                    '    End If
                    'End If
                    'UJ_04092006 END

                    'Convert ArrayList into String Array
                    Dim strRowLinkArrayTemp(arrListRowLink.Count - 1) As String
                    arrListRowLink.ToArray.CopyTo(strRowLinkArrayTemp, 0)
                    strNavigationLinkSysNames = strRowLinkArrayTemp
                    arrListRowLink = Nothing
                    objPrimaryKeyValue = Nothing
                End If
            End Sub

            Protected Overrides Sub GetFormSQL()
                '=====================================================================
                ' Procedure Name        :	GetFormSQL
                ' Purpose               :	This method will prepare the SQL to get the 
                '                           values for the form controls
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 06,2003
                ' Revisions             :   by Ninad 29 March 2007 - To get control names from hashtable, to build form sql  - Req ID WAF3_PB_43
                '=====================================================================
                Dim sbFormSQL As New System.Text.StringBuilder("SELECT ")
                Dim blnUseSQL As Boolean = CBool(CommonFunctions.General.GetApplicationKeySetting("UseSQL")) 'WAF3_PB_38
                'Added by Ninad 29 March 2007 - To get control names from hashtable, to build form sql - Req ID WAF3_PB_43 
                Dim objSubTagMasterControls() As CommonEngines.HashTables.FormSQLControlsTagMaster
                objSubTagMasterControls = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableFormSQLControlsSubTagMaster(m_ObjGlobal.TagID)
                Dim objSubTagMasterControl As CommonEngines.HashTables.FormSQLControlsTagMaster
                For Each objSubTagMasterControl In objSubTagMasterControls
                    If Not objSubTagMasterControl.IsHREFParameter Then
                        sbFormSQL.Append("dbo.")
                        sbFormSQL.Append(m_strTableOrViewName)
                        sbFormSQL.Append(".")
                        sbFormSQL.Append(objSubTagMasterControl.ControlName)
                        sbFormSQL.Append(",")
                    Else
                        sbFormSQL.Append("dbo.")
                        sbFormSQL.Append(m_strTableOrViewName)
                        sbFormSQL.Append(".")
                        sbFormSQL.Append(Replace(objSubTagMasterControl.ControlName, CommonFunctions.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS, ",dbo." + m_strTableOrViewName + "."))
                        sbFormSQL.Append(",")
                    End If
                Next
                objSubTagMasterControl = Nothing
                objSubTagMasterControls = Nothing
                'Addition End by Ninad 29 March 2007 - To get control names from hashtable, to build form sql  - Req ID WAF3_PB_43
                'Remove Last Comma
                sbFormSQL.Remove(sbFormSQL.Length - 1, 1)
                'End If
                'Hotfix 2.0.7.02----
                sbFormSQL.Append(" FROM ") : sbFormSQL.Append(m_strTableOrViewName)
                If blnUseSQL = True Then sbFormSQL.Append(" WITH(NOLOCK)")
                sbFormSQL.Append(GetPageWhereClause())
                'Hotfix 2.0.7.02----
                strFormSQL = sbFormSQL.ToString
                sbFormSQL = Nothing
            End Sub

            Private Function GetPageWhereClause() As String
                '=====================================================================
                ' Procedure Name        :	GetPageWhereClause
                ' Purpose               :	Get UI Page Where Clause
                ' Description           :	Same as above
                ' Parameters Passed     :	objGlobal - WhizGlobal object, TableName - Table Name
                '                           PrimaryKey , PrimaryKeyValue
                ' Parameters Affected   :	None
                ' Returns               :	Result
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 26, 2003
                ' Revisions             :
                '=====================================================================
                If (HttpContext.Current.Request("SubTagFromCL") = "1" And m_objGlobal.ParentTagID <> 0) Then
                    'Common Page is accessed from Sub Tag CommonList
                    GetPageWhereClause = " WHERE " + strPrimaryKey + "='" + CommonFunctions.General.BuildQueryString(strPrimaryKeyValue) + "'"
                End If
            End Function

            Public Sub GetPrimaryKeyValue()
                '=====================================================================
                ' Procedure Name        :	GetPrimaryKeyValue
                ' Purpose               :	This method will retrieve the Primary Key value
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 06,2003
                ' Revisions             :
                '=====================================================================
                Dim strQuery As String = "SELECT " + strPrimaryKey + " FROM " + strTableName + " WHERE " + strPrimaryKey + "='" + CommonFunctions.General.BuildQueryString(strForeignKeyValue) + "'"
                Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean) 'WAF3_PB_38
                If blnUseSQL = True Then strQuery = "EXEC sp_executeSQL N'" + Replace(strQuery, "'", "''") + "'" 'WAF3_PB_38
                strPrimaryKeyValue = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, blnUseSQL, m_ConnectionString))
            End Sub

            Private Sub GetPrimaryKey()
                '=====================================================================
                ' Procedure Name        :	GetPrimaryKey
                ' Purpose               :	This method will retrieve the Primary Key
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 06,2003
                ' Revisions             :   UJ_18.01.2007_195
                '=====================================================================
                Dim strSQL As String
                Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean) 'WAF3_PB_38

                'Get the Primary Key Field Name
                'UJ_18.01.2007_195 Start
                'strSQL = "usp_Sel_v_tbl_UI_SubControlTagMaster_FieldDetails " + m_ObjGlobal.TagID.ToString + ",'ControlName','IsPrimaryKey=1'"
                'strPrimaryKey = CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                strPrimaryKey = GetControl(m_ObjGlobal.TagID, WAF_ControlPropertyGroups.IsPrimaryKey, True)
                'UJ_18.01.2007_195 End
                'Primary key Value
                '________________________WAF3_PB_26 START UmeshJ 21st Aug 2006________________________
                'URL : PK + UserID + ParentTagID + TagID
                Dim sUserID As String = CStr(m_ObjGlobal.UserID)
                Dim sParentTagID As String = CStr(m_ObjGlobal.ParentTagID)
                Dim sTagID As String = CStr(m_ObjGlobal.TagID.ToString)
                '________________________WAF3_PB_26 END UmeshJ 21st Aug 2006__________________________
                If strPrimaryKey.Trim <> "" Then
                    If Not HttpContext.Current.Request(strPrimaryKey + "_PK") Is Nothing And strPrimaryKeyValue = "" And blnIsEditMode = True Then
                        If m_blnIsCommonPageTab = False Then
                            strPrimaryKeyValue = CType(HttpContext.Current.Request(strPrimaryKey + "_PK"), String)
                        Else
                            Call GetPrimaryKeyValue()
                        End If
                        '________________________WAF3_PB_26 START UmeshJ 21st Aug 2006________________________
                        'URL : PK + UserID + ParentTagID + TagID
                        Call ValidateToken(strPrimaryKeyValue + sUserID + sParentTagID + sTagID)
                        '________________________WAF3_PB_26 END UmeshJ 21st Aug 2006__________________________
                        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("Navigation")) <> "" Then
                            Dim objPrimaryKeyValue As Object
                            If m_strFilter.Trim = "" Then m_strFilter = GetSubTagNavigationWhereClause()
                            If m_strSortBy.Trim = "" Then
                                'Consider the Sorting user preferences
                                Dim objCLSQL As New CommonEngines.CommonList.cSubTagCLSQL(m_ObjGlobal)
                                objCLSQL.SubTagId = m_ObjGlobal.TagID
                                objCLSQL.GetSetUserPreferences()
                                m_strSortBy = objCLSQL.SortBy
                                m_strSortOrder = objCLSQL.SortOrder
                                objCLSQL = Nothing
                                'If user preferences for the sorting are not present then get default sorting column
                                If m_strSortBy.Trim = "" Then
                                    'UJ_18.01.2007_195 Start
                                    'Dim objSortBy As Object
                                    'strSQL = "usp_Sel_v_tbl_UI_SubControlTagMaster_FieldDetails " + m_ObjGlobal.TagID.ToString + ", 'ControlName','DefaultSorting=1 And ShowInGrid=1'"
                                    m_strSortOrder = "ASC"
                                    m_strSortBy = GetControl(m_ObjGlobal.TagID, WAF_ControlPropertyGroups.DefaultSorting, True)
                                    If m_strSortBy = "" Then m_strSortBy = strPrimaryKey
                                    'objSortBy = CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    'If Not objSortBy Is Nothing Then
                                    '    m_strSortBy = objSortBy.ToString
                                    'Else
                                    '    m_strSortBy = strPrimaryKey
                                    'End If
                                    'UJ_18.01.2007_195 End
                                End If
                            End If

                            'Get the Group Name if Grouping is On
                            Dim strGroupName As String = ""
                            'UJ_18.01.2007_195 Start
                            'strSQL = "usp_Sel_v_tbl_UI_SubControlTagMaster_FieldDetails " + m_ObjGlobal.TagID.ToString + ", 'ControlName','IsGroupHeader=1 And ShowInGrid=1'"
                            'strGroupName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                            strGroupName = GetControl(m_ObjGlobal.TagID, WAF_ControlPropertyGroups.IsGroupHeader, True)
                            'UJ_18.01.2007_195 End
                            ''Modified By UmeshJ on 24 Nov 2004 for Navigation Links problem if grouping is applied 
                            If strGroupName.Trim <> "" And m_strSortBy.Trim <> "" Then
                                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("Navigation")).Trim.ToUpper = "LAST" Then
                                    strGroupName += " DESC,"
                                Else
                                    strGroupName += ","
                                End If
                            End If
                            'End of addition

                            Dim strOrderByClause As String
                            Select Case CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("Navigation")).Trim.ToUpper
                                Case "FIRST"
                                    'First link
                                    If m_strSortBy.Trim <> "" Then strOrderByClause = " ORDER BY " + strGroupName + m_strSortBy.Trim + " " + m_strSortOrder
                                    strSQL = "SELECT " + strPrimaryKey + " FROM " + m_strTableOrViewName
                                    If blnUseSQL = True Then strSQL = strSQL + " WITH(NOLOCK)" 'Hotfix 2.0.7.02----
                                    strSQL = strSQL + " WHERE 1=1 " + m_strFilter + strOrderByClause
                                    If blnUseSQL = True Then strSQL = "EXEC sp_executeSQL N'" + Replace(strSQL, "'", "''") + "'" 'WAF3_PB_38
                                    objPrimaryKeyValue = CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, m_ConnectionString) 'WAF3_PB_33
                                    If Not objPrimaryKeyValue Is Nothing Then strPrimaryKeyValue = objPrimaryKeyValue.ToString
                                Case "PREVIOUS"
                                    strSQL = "SELECT " + strPrimaryKey + " AS PK FROM " + m_strTableOrViewName
                                    If blnUseSQL = True Then strSQL = strSQL + " WITH(NOLOCK)" 'Hotfix 2.0.7.02----
                                    strSQL = strSQL + " WHERE 1 = 1 " + m_strFilter + " ORDER BY " + strGroupName + m_strSortBy.Trim + " " + m_strSortOrder
                                    'UJ_04092006 START
                                    Call GetNavDetailsFromDataset(strSQL, strPrimaryKeyValue, "NAVIGATE_PREVIOUS")
                                    'Dim strPK As String() = GetArrayFromDataset(strSQL)
                                    'Dim intIndex As Integer = strPK.IndexOf(strPK, strPrimaryKeyValue)
                                    'If intIndex <> -1 Then
                                    '    'Current entry found
                                    '    If intIndex <> 0 Then
                                    '        'Get the previous entry
                                    '        strPrimaryKeyValue = strPK(intIndex - 1)
                                    '    End If
                                    'End If
                                    'UJ_04092006 END
                                Case "NEXT"
                                    'Next link
                                    strSQL = "SELECT " + strPrimaryKey + " AS PK FROM " + m_strTableOrViewName
                                    If blnUseSQL = True Then strSQL = strSQL + " WITH(NOLOCK)" 'Hotfix 2.0.7.02----
                                    strSQL = strSQL + " WHERE 1 = 1 " + m_strFilter + " ORDER BY " + strGroupName + m_strSortBy.Trim + " " + m_strSortOrder
                                    'UJ_04092006 START
                                    Call GetNavDetailsFromDataset(strSQL, strPrimaryKeyValue, "NAVIGATE_NEXT")
                                    'Dim strPK As String() = GetArrayFromDataset(strSQL)
                                    'Dim intIndex As Integer = strPK.IndexOf(strPK, strPrimaryKeyValue)
                                    'If intIndex <> -1 Then
                                    '    'Current entry found
                                    '    If intIndex <> (strPK.Length - 1) Then
                                    '        'Get the next entry
                                    '        strPrimaryKeyValue = strPK(intIndex + 1)
                                    '    End If
                                    'End If
                                    'UJ_04092006 END
                                Case "LAST"
                                    'Last link
                                    If m_strSortOrder.Trim.ToUpper = "DESC" Then
                                        strOrderByClause = " ORDER BY " + strGroupName + m_strSortBy.Trim + " ASC "
                                    Else
                                        strOrderByClause = " ORDER BY " + strGroupName + m_strSortBy.Trim + " DESC "
                                    End If
                                    strSQL = "SELECT " + strPrimaryKey + " FROM " + m_strTableOrViewName
                                    If blnUseSQL = True Then strSQL = strSQL + " WITH(NOLOCK)" 'Hotfix 2.0.7.02----
                                    strSQL = strSQL + " WHERE 1=1 " + m_strFilter + strOrderByClause
                                    If blnUseSQL = True Then strSQL = "EXEC sp_executeSQL N'" + Replace(strSQL, "'", "''") + "'" 'WAF3_PB_38
                                    objPrimaryKeyValue = CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, m_ConnectionString) 'WAF3_PB_33
                                    If Not objPrimaryKeyValue Is Nothing Then strPrimaryKeyValue = objPrimaryKeyValue.ToString
                            End Select
                            '________________________WAF3_PB_26 START UmeshJ 22nd Aug 2006________________________
                            m_strPKToken_Value = CommonFunctions.Security.Token.GetToken(strPrimaryKeyValue + sUserID + sParentTagID + sTagID)
                            '________________________WAF3_PB_26 END UmeshJ 21st Aug 2006__________________________
                            objPrimaryKeyValue = Nothing
                        End If
                    Else
                        '________________________WAF3_PB_26 START UmeshJ 22nd Aug 2006________________________
                        'URL : PK + UserID + ParentTagID + TagID
                        If strPrimaryKeyValue <> "" Then Call ValidateToken(strPrimaryKeyValue + sUserID + sParentTagID + sTagID)
                        '________________________WAF3_PB_26 END UmeshJ 21st Aug 2006__________________________
                    End If
                End If
            End Sub

            'Added By Chakshuta H on 29th-Oct-2015
            Private Sub GetCurrentTimestampValue()
                '=====================================================================
                ' Procedure Name        :	GetCurrentTimestampValue
                ' Purpose               :	This method will gives the Current Timestamp Value  ie Updated Date
                '                           values for the Concurrency Control
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	ShrikantB
                ' Created               :	20-JUL-2010
                '=====================================================================
                Dim strSQL As String
                Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean) 'WAF3_PB_38
                Dim strCurrentTimestampVal As String = ""
                If strPrimaryKeyValue = "" And blnIsEditMode = True Then
                    If Not HttpContext.Current.Request(strPrimaryKey + "_PK") Is Nothing And blnIsEditMode = True Then
                        strPrimaryKeyValue = CType(HttpContext.Current.Request(strPrimaryKey + "_PK"), String)
                    End If
                End If
                If strPrimaryKey.Trim <> "" And strPrimaryKeyValue <> "" Then
                    strSQL = "DECLARE @Timestampval TIMESTAMP "
                    strSQL = strSQL + "SELECT  @Timestampval=" + strConcurrency_UpdatedDate + " FROM " + m_strTableOrViewName
                    If blnUseSQL = True Then strSQL = strSQL + " WITH(NOLOCK)"
                    strSQL = strSQL + " WHERE 1=1  AND " + strPrimaryKey + "='" + strPrimaryKeyValue + "'"
                    strSQL = strSQL + " SELECT dbo.fn_TSToStr(@Timestampval) AS 'CurrentTS'"
                    If blnUseSQL = True Then strSQL = "EXEC sp_executeSQL N'" + Replace(strSQL, "'", "''") + "'"
                    strCurrentTimestampVal = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), m_ConnectionString))
                    If Not strCurrentTimestampVal Is Nothing Then strCurrentTimeStampValue = strCurrentTimestampVal
                End If
            End Sub
            'Ended By Chakshuta H on 29th-Oct-2015

            Private Function GetSubTagNavigationWhereClause() As String
                '=====================================================================
                ' Procedure Name        :	GetSubTagNavigationWhereClause
                ' Purpose               :	This method will get the Sub Tag Navigation Where clause
                ' Description           :	Same as above 
                ' Parameters Passed     :	None.
                ' Parameters Affected   :	None.
                ' Returns               :	Sub Tag Navigation Where clause
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 26,2003
                ' Revisions             :   UJ_18.01.2007_195
                '=====================================================================
                'Get the Filter Clause
                Dim objFilter As New CommonEngines.CommonList.cSubTagDynamicFilters(m_ObjGlobal)
                objFilter.GetFilterClause()
                Dim strFilter As String = objFilter.FilterClause
                objFilter = Nothing
                'Foreign Key Filter
                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ForeignKey"), "") <> "" And CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ForeignKeyValue"), "") <> "" Then
                    strFilter += " AND " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ForeignKey"), "") + " = '" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ForeignKeyValue"), "")) + "'"
                End If
                'If Page is accessed from Commonlist then get the paging condition
                Dim strPagingClause As String = ""
                Dim strPagingAlphabet As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SubTagPagingAlphabet"), "")
                If strPagingAlphabet = "" Then
                    'Consider the Sorting user preferences
                    Dim objCLSQL As New CommonEngines.CommonList.cSubTagCLSQL(m_ObjGlobal)
                    objCLSQL.SubTagId = m_ObjGlobal.TagID
                    objCLSQL.GetSetUserPreferences()
                    strPagingAlphabet = objCLSQL.PagingAlphabet
                    objCLSQL = Nothing
                End If

                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SubTagFromCL"), "") = "1" And _
                    (strPagingAlphabet <> "-1" And strPagingAlphabet <> "") Then
                    'UJ_18.01.2007_195 Start
                    'Dim objPaging As Object
                    'Dim strSQL As String = "usp_Sel_v_tbl_UI_SubControlTagMaster_FieldDetails " + m_ObjGlobal.TagID.ToString + ", 'ControlName','IsPagingColumn = 1'"
                    'objPaging = CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    'If Not objPaging Is Nothing Then
                    '    strPagingClause = " AND Left(" + objPaging.ToString + ",1) = '" + CommonFunctions.General.BuildQueryString(strPagingAlphabet) + "'"
                    'End If
                    Dim strPaging As String = GetControl(m_ObjGlobal.TagID, WAF_ControlPropertyGroups.IsPagingColumn, True)
                    If strPaging <> "" Then
                        strPagingClause = " AND Left(" + strPaging + ",1) = '" + CommonFunctions.General.BuildQueryString(strPagingAlphabet) + "'"
                    End If
                    'UJ_18.01.2007_195 End
                End If

                GetSubTagNavigationWhereClause = strPagingClause + strFilter + GetPageSpecificFilters(m_ObjGlobal) + strAdvancedFilter
            End Function

        End Class

        Public Class cCPSQL
            Inherits CommonEngines.CommonPage.cCPSQL
            'Constructor
            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call MyBase.New(WhizGlobal)
            End Sub

            Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String 'CLSQL, CPSQL, SubTagCPSQL
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetPageSpecificFilters")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = m_objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetPageSpecificFilters", ExtensionArgs)

                    m_objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    GetPageSpecificFilters = CommonEngine.General.cPageSpecificBehavior.GetPageSpecificFilters(objGlobal)
                End If
                'addition ends
            End Function

            Protected Overrides Function GetUIPageWhereClause(ByVal objGlobal As WebPages.Template.IGlobal, ByVal TableName As String, ByVal PrimaryKey As String, Optional ByRef PrimaryKeyValue As String = "") As String
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetUIPageWhereClause")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.m_global = m_objGlobal
                    ExtensionArgs.PrimaryKey = PrimaryKey
                    ExtensionArgs.PrimaryKeyValue = PrimaryKeyValue

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                            "GetUIPageWhereClause", ExtensionArgs)

                    m_objGlobal = ExtensionArgs.m_global
                    PrimaryKey = ExtensionArgs.PrimaryKey
                    PrimaryKeyValue = ExtensionArgs.PrimaryKeyValue

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************

                    GetUIPageWhereClause = CommonEngine.General.cPageSpecificBehavior.GetUIPageWhereClause(objGlobal, TableName, PrimaryKey, PrimaryKeyValue)
                End If
                'addition ends.
            End Function
        End Class 'cCPSQL

        Public Class cValidationRules
            Inherits CommonEngines.CommonPage.cValidationRules

            'Constructor
            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call MyBase.New(WhizGlobal)
            End Sub

        End Class

        Public Class cSubTagDataManagement
            Inherits CommonEngines.CommonPage.cSubTagDataManagement

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                MyBase.New(WhizGlobal)
            End Sub

        End Class

        Public Class cDataManagement
            Inherits CommonEngines.CommonPage.cDataManagement

            'Constructor
            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                Call MyBase.New(WhizGlobal)
            End Sub
            Public Overrides Function GeneratePrimaryKeyValue(ByVal ControlsHashTable As Hashtable, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal strDataType As String, Optional ByVal intMaxLength As Integer = 0, Optional ByVal intPrevMax As Long = 0) As String
                GeneratePrimaryKeyValue = CommonFunction.General.GeneratePrimaryKeyValue(ControlsHashTable, WhizGlobal, strDataType, intMaxLength, intPrevMax)
            End Function
        End Class
    End Namespace
End Namespace