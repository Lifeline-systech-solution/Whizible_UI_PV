Public Class CommonSubTag
    Inherits WebPage.Templates.WhizTemplate
    Private m_objSubTagCLSQL As CommonEngine.CommonList.cSubTagCLSQL
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_lngSubTagID As Long
    Private m_lngTagID As Long
    Private m_strForeignKeyValue As String = ""
    Private m_strDivTag As String = "divSubTag"
    Private Const FORM_NAME As String = "frmCommonSubTag"
    'Added By Chakshuta H on 30th-Oct-2015
    '==========================================================================================================
    'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
    '==========================================================================================================
    Protected m_strConnectionString As String = ""
    Protected m_intConnectionID As Integer
    '==========================================================================================================
    ' Addition End By : Ninad   Req Id : WAF3_PB_33
    '==========================================================================================================
    '-------------------------------------------------------------------------------------------------------------

    Private m_blnConsiderContextMenu As Boolean = False 'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47

    'Ended By Chakshuta H on 30th-Oct-2015

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        Call GetParameters()
        'Get the Global object details
        Call GetGlobalObject()
        'Added By Chakshuta H on 30th-Oct-2015
        '==========================================================================================================
        'Added By NinadP :	16 Nov 2006 : Requirement Tag - WAF3_PB_33 
        '==========================================================================================================
        GetConnection()
        '==========================================================================================================
        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================

        'Ended By Chakshuta H on 30th-Oct-2015

        'Get the Sub Tag Details from the Database
        Call SubTag_GetCLSQL()
        'Show the Sub Tag Information
        Call PlotSubTagInformation()
        'Memory Cleanup
        Call MemoryCleanUp()
    End Sub
    Private Sub GetGlobalObject()
        '=====================================================================
        ' Procedure Name        :	GetGlobalObject
        ' Purpose               :	Get Page Specific Global Object
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Create the global class object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        'Get the global object
        m_objGlobal = MyBase.GlobalObject
        'Tag ID
        m_objGlobal.TagID = m_lngTagID
        'Added By Chakshuta H on 30th-Oct-2015
        'added by ninad ' Requirement Tag :WAF3_PB_33 
        Call WhizForm_Init(m_objGlobal, m_intConnectionID)
        'addition end by ninad ' Requirement Tag :WAF3_PB_33 

        'Ended By Chakshuta H on 30th-Oct-2015

    End Sub
    'Added By Chakshuta H on 30th-Oct-2015
    Private Sub GetConnection()
        '=====================================================================
        ' Procedure Name        :	GetConnection
        ' Purpose               :	This method will give call to the shared method GetConnectionID of cCLSQL class, 
        '                           if user has not set the value of m_intConnectionID. This method will return the ConnectionID, that will be set to the variable m_intConnectionID. 
        '                           If the value of this variable is not nothing then, connection string value will be retrieved from this connection id and will be assigned to the variable m_strConnectionString 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	Thursday, Nov 16, 2003 
        ' Requirement Tag       :   WAF3_PB_33 
        ' Revisions             :
        '=====================================================================
        If m_intConnectionID = 0 Then
            m_intConnectionID = CommonEngines.CommonList.cCLSQL.GetConnectionID(m_lngTagID.ToString)
        End If
        If m_intConnectionID <> 0 Then
            m_strConnectionString = CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableConnection(m_intConnectionID.ToString))
        End If
    End Sub
    Protected Overridable Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        '=====================================================================
        ' Procedure Name        :	WebFormInit
        ' Purpose               :	This method will call the WhizForm_Init event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	Friday, Nov 11, 2003 
        ' Requirement Tag       :   WAF3_PB_33 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.WhizForm_Init(m_objGlobal, "LIST", m_intConnectionID)
        cobjEventHndlr = Nothing
    End Sub
    'Ended By Chakshuta H on 30th-Oct-2015

    Private Sub GetParameters()
        '=====================================================================
        ' Procedure Name        :	GetParameters
        ' Purpose               :	Get the request Parameters
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 05, 2004
        ' Revisions             :
        '=====================================================================
        'Get the Sub Tag ID
        If Not Request("SubTagID") Is Nothing Then m_lngSubTagID = CType(Request("SubTagID"), Long)
        'Tag
        If Not Request("TagID") Is Nothing Then m_lngTagID = CType(Request("TagID"), Long)
        'Get the ForeignKey
        If Not Request("ForeignKeyValue") Is Nothing Then m_strForeignKeyValue = Request("ForeignKeyValue").ToString
    End Sub
    Private Sub SubTag_GetCLSQL()
        '=====================================================================
        ' Procedure Name        :	SubTag_GetCLSQL
        ' Purpose               :	Get the Page Details from the database
        ' Description           :	This method access the cSubTagCLSQL class to retrieve 
        '                           the page details required to plot the Sub tag Common List 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        m_objSubTagCLSQL = New CommonEngine.CommonList.cSubTagCLSQL(m_objGlobal)
        With m_objSubTagCLSQL
            'Added By Chakshuta H on 30th-Oct-2015
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            'Ended By Chakshuta H on 30th-Oct-2015
            .SubTagId = m_lngSubTagID
            .ForeignKeyValue = m_strForeignKeyValue
            .Add = False
            .Edit = False
            .Delete = False
            .View = False
            .PagingAlphabet = ""
            .SortBy = ""
            .SortOrder = ""
            .GetSubTagInformation()
            .GetGridSQL()
        End With
    End Sub
    Private Sub PlotSubTagInformation()
        '=====================================================================
        ' Procedure Name        :	PlotSubTagInformation
        ' Purpose               :	Plot the Sub Tag Information
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 05, 2004
        ' Revisions             :
        '=====================================================================
        'Create form
        Call CreateForm()
        'Plot grid
        Call SubTag_PlotGrid()
        'End form
        Call EndForm()
        'client side
        Call WriteClientsideScript()
    End Sub
    Private Sub CreateForm()
        '=====================================================================
        ' Procedure Name        :	CreateForm
        ' Purpose               :	Create Form tag
        ' Description           :	This method will plot the initial portion 
        '                           for the page and form tag
        ' Parameters Passed     :	None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :   Aug 27,2004 Rajanikant Khethawatt, using the 
        '                           commonfunction.General.PLotPageHeadTag for
        '                           plotting the header & R.No. WAF2_PB_32
        '=====================================================================
        ' commented by miiint 23/12/2014
        ' Response.Write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>")
        ' added by miint 23/12/2014
        Response.Write("<!DOCTYPE HTML>")
        Response.Write("<HTML>")
        Response.Write("<HTML>")

        'Page Caption
        ' ***************************************************************************************
        ' Modified Aug 27,2004 Rajanikant Khethawatt R.No.WAF2_PB_32
        ' ***************************************************************************************
        Response.Write(CommonFunction.General.PlotPageHeadTag(m_objSubTagCLSQL.PageCaption, , , , , True, m_objGlobal.ParentTagID))
        ' ***************************************************************************************
        ' End Modification Aug 27,2004 Rajanikant Khethawatt
        ' ***************************************************************************************
        Response.Write("<BODY class='clsBody' onload='CST_window_onload()' onresize='CST_window_onresize()' ><FORM name='" + FORM_NAME + "' method=post>")
    End Sub

    Private Sub EndForm()
        'Form End Tag
        Response.Write("</FORM></BODY></HTML>")
    End Sub

    Private Sub SubTag_PlotGrid()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotGrid
        ' Purpose               :	Plot the CommonList Grid using the cSubTag_PlotGrid class
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Create the object of main CPlotGrid class
        Dim cObjGrid As New CommonEngine.CommonList.cPlotGrid(m_objGlobal)
        With cObjGrid
            'Form Property values
            'Added By Chakshuta H on 30th-Oct-2015
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            'Ended By Chakshuta H on 30th-Oct-2015

            .GridSQL = m_objSubTagCLSQL.GridSQL
            .PrimaryKey = m_objSubTagCLSQL.PrimaryKey
            .SortBy = m_objSubTagCLSQL.SortBy
            .SortOrder = m_objSubTagCLSQL.SortOrder
            '.CommonQueryString = m_strCommonQueryString
            .RecordCount = m_objSubTagCLSQL.RecordCount
            'Use the Statndard Message Resource File
            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            .MessageForNoRecords = MyBase.GetResourceString("NO_RECORDS")
            'Common Page Resource File
            MyBase.InitializeResources("Resources.CommonPage", "Resources")
            'From Parameter values
            .ActualColumnArray = m_objSubTagCLSQL.ActualColumnArray
            If m_objSubTagCLSQL.IsAttachmentTab = True Then
                Dim strUFCols() As String = {MyBase.GetResourceString("SR_NO"), MyBase.GetResourceString("FILE_NAME"), MyBase.GetResourceString("FILE_SIZE"), MyBase.GetResourceString("ATTACHED_BY"), MyBase.GetResourceString("ATTACHED_DATE"), MyBase.GetResourceString("ATTACHED_DESCRIPTION")}
                .SrNoColumn = True
                .IsAttachmentGrid = True
                .AttachmentFolderPath = m_objSubTagCLSQL.AttachmentFolderPath
                .UserFriendlyColumnArray = strUFCols
            Else
                .IsAttachmentGrid = False
                .UserFriendlyColumnArray = m_objSubTagCLSQL.UserFriendlyColumnArray
            End If
            .RowLinkArray = m_objSubTagCLSQL.RowLinkArray
            .RowLinkToolTipArray = m_objSubTagCLSQL.RowLinkToolTipArray
            .FieldDataTypeArray = m_objSubTagCLSQL.FieldDataTypeArray
            .ColumnAlignmentArray = m_objSubTagCLSQL.ColumnAlignmentArray
            .DivHeight = m_objSubTagCLSQL.DivHeight
            .ReturnHTML = False
            'ProjectBtNet Template Common Grid Properties
            .ColumnNameTooltipOnEachRow = True
            .clsColumnHeader = "clsTRColumnHeader"
            'Modified By NileshD on 26 Sep 2005 REQID WAF3_PB_10
            .clsTable = "clsGridTable"
            'End Of Modification By NileshD on 26 Sep 2005 REQID WAF3_PB_10
            .clsTREven = "clsTREven"
            .clsTROdd = "clsTROdd"
            .clsSortingColumn = "clsTDSortColHeader"
            .DivID = m_strDivTag
            .DivStyle = "OVERFLOW:auto; WIDTH:100%"
            .TableStyle = "cellspacing=0 cellpadding=0"
            .BoolTrueHTML = MyBase.GetResourceString("YES")
            .BoolFalseHTML = MyBase.GetResourceString("NO")
            '-----SHOW READ ONLY GRID
            'Do not show "Delete" column
            .Delete = False
            ''.ApplyGridRules = False
            .ApplyGridRules = True 'Modified By Shrikant B On 10 Oct 2008 For Issue ID 23428 (To Display Grid Formating Rule for Sub Tag: Set ApplyGridRules =true)
            .ApplySorting = False
            .ApplyUpdate = False
            'WAF2_PB_2: Added By UmeshJ on 27th August 2004 
            If m_objSubTagCLSQL.CaptionofDeleteColumn.Trim <> "" Then
                .CaptionForDeleteColumn = m_objSubTagCLSQL.CaptionofDeleteColumn.Trim
            Else
                .CaptionForDeleteColumn = MyBase.GetResourceString("DELETE_COLUMN")
            End If
            .ApplySorting = m_objSubTagCLSQL.EnableSorting
            .EnableHTMLEncode = m_objSubTagCLSQL.EnableHTMLEncode
            .ShowDeleteColumn = m_objSubTagCLSQL.ShowDeleteColumn
            'End of Addition
            'WAF2_PB_6: Sorting Column array
            .ColumnSortingArray = m_objSubTagCLSQL.ColumnSortingArray
            'WAF2_PB_6: End of Addtion
            'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: Added By UmeshJ on 1st Sept 2004 for WAF2 Build1
            .ListActionForControlArray = m_objSubTagCLSQL.ListActionForControlArray
            .ListConditionalControlValueArray = m_objSubTagCLSQL.ListConditionalControlValueArray
            .ListConditionClauseArray = m_objSubTagCLSQL.ListConditionClauseArray
            'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: End of addition
            'WAF2_PB_4: Added By UmeshJ on 6th Sep 2004 for Summary Functions
            .SummaryFuncActualColumnArray = m_objSubTagCLSQL.SummaryFuncActualColumnArray
            .SummaryFuncLevelArray = m_objSubTagCLSQL.SummaryFuncLevelArray
            .SummaryFuncNameArray = m_objSubTagCLSQL.SummaryFuncNameArray
            'WAF2_PB_4: End of addition
            'WAF2_PB_68: Added By UmeshJ on 17th Nov 2004 for Optional Tooltip
            .ShowColumnTooltip = False
            'WAF2_PB_68: End of addition
            'Added BY NileshD on 26 Sep 2005 REQID- WAF3_PB_10
            m_objGlobal.ParentTagID = m_lngTagID
            m_objGlobal.TagID = m_lngSubTagID
            'End Of Addition REQID- WAF3_PB_10
            'Added By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
            .IsStaticColumn = m_objSubTagCLSQL.IsStaticColumn
            'End Of Addition By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
            'Added By Chakshuta H on 30th-Oct-2015
            .GridDataRows = m_objSubTagCLSQL.GridDataRows 'WAF3_PB_38 (hotfix 2.0.16-SP6-WAF)

            '-------------------------------------------------------------------------------------------------------------
            'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            'Reason   - For showing context menu in the grid. 
            '-------------------------------------------------------------------------------------------------------------
            .EnableContextMenu = m_objSubTagCLSQL.EnableContextMenu
            .ShowInContextMenuArray = m_objSubTagCLSQL.ShowInContextMenuArray
            .ContextMenuLinkColumn = m_objSubTagCLSQL.ContextMenuLinkColumn
            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            '-------------------------------------------------------------------------------------------------------------

            'Ended By Chakshuta H on 30th-Oct-2015

            Response.Write(.PlotGrid())
            'Added BY NileshD on 26 Sep 2005 REQID- WAF3_PB_10
            m_objGlobal.ParentTagID = 0
            m_objGlobal.TagID = m_lngTagID
            'End Of Addition REQID- WAF3_PB_10
        End With
        'Destroy the object    
        cObjGrid = Nothing
    End Sub
    Private Sub WriteClientsideScript()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript
        ' Purpose               :	Write Clientside Script 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "<SCRIPT Language=javascript>" & vbCrLf)
        'Create the form object...will be used throughout the clientside scripts
        Response.Write(vbCrLf + "   var objfrm;")
        Response.Write(vbCrLf + "   var objdivlist;")
        Response.Write(vbCrLf + "   objfrm = GetFormReference('" + FORM_NAME + "')")
        Response.Write(vbCrLf + "   objdivlist=GetObjectReference('" + FORM_NAME + "','" + m_strDivTag + "')" + vbCrLf)
        'Window_OnResize and Window_OnReload
        Call WriteClientsideScript_WindowOnload_Resize()
        Response.Write(vbCrLf + "</SCRIPT>" & vbCrLf)
    End Sub

    Private Sub WriteClientsideScript_WindowOnload_Resize()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_WindowOnload_Resize
        ' Purpose               :	Write Clientside Script 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2003
        ' Revisions             :
        '=====================================================================
        Dim intHeightFactor As Integer = 42

        CommonFunction.General.WriteHTML("//window resize for Common list")
        CommonFunction.General.WriteHTML("	function CST_window_onresize()")
        CommonFunction.General.WriteHTML("	{")
        CommonFunction.General.WriteHTML("		var intDivHeight ;")
        CommonFunction.General.WriteHTML("		var intDivHeightRisk;")
        CommonFunction.General.WriteHTML("		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
        CommonFunction.General.WriteHTML("		if (intDivHeight < 100)")
        CommonFunction.General.WriteHTML("			intDivHeight = 100;")
        CommonFunction.General.WriteHTML("				")
        'Modified by Miiint on 16-Feb-2015 to append px to height
        'CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight	;")
        CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight + 'px'	;")
        CommonFunction.General.WriteHTML("	}")

        CommonFunction.General.WriteHTML("	//window onload for Common list")
        CommonFunction.General.WriteHTML("	function CST_window_onload()")
        CommonFunction.General.WriteHTML("	{")
        CommonFunction.General.WriteHTML("		var intDivHeight ;")
        CommonFunction.General.WriteHTML("		var intDivHeightRisk;")
        CommonFunction.General.WriteHTML("		var lc;")
        CommonFunction.General.WriteHTML("		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
        CommonFunction.General.WriteHTML("		if (intDivHeight < 100)")
        CommonFunction.General.WriteHTML("			intDivHeight = 100;")
        'Modified by Miiint on 16-Feb-2015 to append px to height
        'CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight	;")
        CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight + 'px'	;")
        CommonFunction.General.WriteHTML("	}")
    End Sub
    Private Sub MemoryCleanUp()
        '=====================================================================
        ' Procedure Name        :	MemoryCleanUp
        ' Purpose               :	Remove the unused objects from the memory
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Sub Tag Objects
        If Not m_objGlobal Is Nothing Then m_objGlobal = Nothing
        If Not m_objSubTagCLSQL Is Nothing Then m_objSubTagCLSQL = Nothing
    End Sub

    Public Sub New()
        'Common Page Resource File
        MyBase.InitializeResources("Resources.CommonPage", "Resources")
    End Sub
End Class
