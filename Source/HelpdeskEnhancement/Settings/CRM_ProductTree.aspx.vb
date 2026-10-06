#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region
Public Class CRM_ProductTree
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Of Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
    End Sub

#End Region

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Public NodeID As String

    Private WithEvents m_objDetailsGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
#End Region
#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        'Call GetGlobalObject()
        'Dim NodeID As String


        If Request("NodeID") <> "" Then
            NodeID = Request("NodeID")
        Else
            NodeID = ""
        End If

        If Request("Mode") = "Edit" Then Return

        'DrawMenu(1)
        Response.Write("<BR>")
        Response.Write("<TABLE id='PageCaption'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable><TR class=clsTRPageCaption><TD align=Left> " + MyBase.GetResourceString("PAGE_CAPTION") + " </TD></TR></TABLE><BR>")
        Response.Write("<DIV Id=divPage Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:100%'>")
        Response.Write("<TABLE valign=bottom BORDER=0 class='clsTable'  CellSpacing='0' CellPadding=0  width=100% height=100%>")
        Response.Write("<TR class='clsTREven'><TD id='TD_Left' width=40% valign='top'>")
        ''Commented and Added by Dhanashri S on 15 Oct 2015
        '' Response.Write("<DIV Id=divLeft Style='HEIGHT:100%;OVERFLOW:auto; WIDTH:100% ;border-right:solid 1 black;'>")
        ''COMMENTED AND ADDED BY NILESH G ON 6/1/2015 FOR ISSUE ID 2752
        '' Response.Write("<DIV Id=divLeft Style='HEIGHT:100%;OVERFLOW:auto; WIDTH:100% ;border-right:solid 1 black;top: 65px;position: absolute;'>")
        Response.Write("<DIV Id=divLeft Style='OVERFLOW:auto;border-right:solid 1px; black;top: 65px;position: absolute;width:40%;'>")
        ''End of Comment and Addition by Dhanashri S on 15 Oct 2015
        Response.Write(GenerateProductTree())
        Response.Write("</DIV>")
        Response.Write("</TD>")
        '        Response.Write("<TD class=clsLinkPageHeaderInner id='TD_Middle' width=1% align='Left' ondblclick='Shift_onClick()'>")
        Response.Write("<TD id='TD_Middle' width=1% align='Left' Title='Show/Hide Link Tree' ondblclick='Shift_onClick()'>")
        'Response.Write("<A HRef='JavaScript:Shift_onClick()'><Image ID=ImgID BORDER=0 src='..\..\images\LeftShift.gif' alt='Show/Hide Link Tree'></A>")
        Response.Write("</TD>")
        Response.Write("<TD id='TD_Right' width=59% valign='top'>")
        ''COMMENTED AND ADDED BY NILESH G ON 6/1/2015 FOR ISSUE ID 2752
        ''Response.Write("<DIV Id=divRight Style='HEIGHT:450px;OVERFLOW:auto; WIDTH:99.99%'>")
        Response.Write("<DIV Id=divRight Style='OVERFLOW:auto;width:99.99%;'>")
        'GenerateInformation()
        Response.Write("</DIV>")
        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")
        Response.Write("</DIV>")
        Response.Write("<BR>")
        'DrawMenu(1)

    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Function GenerateProductTree() As String
        '=====================================================================
        ' Procedure Name		:	GenerateWorkFlowTree
        ' Purpose				:	To generate the work flow definition tree
        ' Description			:	Same as above.
        ' Parameters Passed		:	ProcessID
        ' Parameters Affected	:	None.
        ' Returns				:	Tree script.
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	SandipL
        ' Created				:	 8 mar 2006
        ' Revisions				:   
        '=====================================================================	
        Dim sbHTMLTree As New System.Text.StringBuilder("")
        Dim lngNodeCount As Long = 0
        Dim lngTreeIndex As Long = 0
        Dim strTooltip As String = ""
        Dim strDescription As String = ""
        Dim lngProcessNodeID As Long = 0
        Dim lngStageNodeID As Long = 0
        Dim lngActionNodeID As Long = 0
        Dim strSQL As String

        Dim drProcess As IDataReader
        Dim drStages As IDataReader
        Dim drActions As IDataReader
        Dim drActionDetails As IDataReader

        'sbHTMLTree.Append("<script type='text/javascript' src='../../Reports/Tree.js'></script>" + vbCrLf)
        'sbHTMLTree.Append("<script type='text/javascript' src='Initiative.js'></script>" + vbCrLf)
        'sbHTMLTree.Append("<script type='text/javascript' src='../HOME/HomeTree.js'></script>" + vbCrLf)
        sbHTMLTree.Append("<script type='text/javascript'>" + vbCrLf)
        sbHTMLTree.Append("<!--" + vbCrLf)
        sbHTMLTree.Append("var Tree = new Array;" + vbCrLf)
        sbHTMLTree.Append("// nodeId | parentNodeId | nodeName | nodeUrl |Tooltip |IsParent |ImageName" + vbCrLf)

        strSQL = "usp_sel_all_Productlines_ForTree " + vbCrLf
        drProcess = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        'Process loop
        Do While drProcess.Read
            'Add process node
            lngNodeCount = lngNodeCount + 1
            sbHTMLTree.Append("Tree[" + lngTreeIndex.ToString + "]=" + Chr(34) + drProcess("ChildID").ToString + "|" + drProcess("ParentID").ToString + "|")
            'sbHTMLTree.Append("Tree[" + drProcess("ChildID").ToString + "]=" + Chr(34) + drProcess("ChildID").ToString + "|" + drProcess("ParentID").ToString + "|")
            ' Modified by SandipL on 10 Jan 2007 for SEMSP9 IssueID 9281
            'sbHTMLTree.Append(drProcess("Child").ToString + "|javascript:Node_OnClick(" + drProcess("ChildID").ToString + ")|" + drProcess("Child").ToString + "|")
            sbHTMLTree.Append(drProcess("Child").ToString.Replace("""", "&quot;").Replace(vbCrLf, "\n") + "|javascript:Node_OnClick(" + drProcess("ChildID").ToString + ")|" + drProcess("Child").ToString.Replace("""", "&quot;").Replace(vbCrLf, "\n") + "|")
            ' End modification by SandipL on 11 Jan 2007
            If (drProcess("ParentID").ToString = "0") Then
                sbHTMLTree.Append("-1|")
            Else
                sbHTMLTree.Append("0|")
            End If
            sbHTMLTree.Append("WF_Process.gif" + Chr(34) + ";" + vbCrLf)
            lngTreeIndex = lngTreeIndex + 1

        Loop
        drProcess.Close()

        CommonFunction.Data.DisposeDataReader(drProcess)

        'by default Expand the first node 
        'sbHTMLTree.Append("createTree(Tree,0,0,""../../Reports/"");" + vbCrLf)
        'commented and added by SanaS
        'sbHTMLTree.Append("createTree(Tree);" + vbCrLf)
        sbHTMLTree.Append("objDivLeft=GetObjectReference('frmPRD_ProductTree','divLeft');" + vbCrLf)
        sbHTMLTree.Append(" HTML=createSearchTree(Tree);" + vbCrLf)
        sbHTMLTree.Append(" objDivLeft.innerHTML=HTML; " + vbCrLf)
        'end by SanaS
        ''If m_strInitiativeID <> 0 Then
        ''    sbHTMLTree.Append("setOpenNodes(" + m_strInitiativeID + ");" + vbCrLf)
        ''Else
        sbHTMLTree.Append("OpenAllNodes();" + vbCrLf)
        ''End If


        sbHTMLTree.Append("//-->" + vbCrLf)
        sbHTMLTree.Append("</script>" + vbCrLf)
        GenerateProductTree = sbHTMLTree.ToString

    End Function

    Private Sub DrawMenu(ByVal Position As Integer)
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('PRD_ProductTree')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

   

    Private Function DrawDetailsGrid(ByVal strSQL As String) As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList

        'To store the link details while clicking on Links in grid
        'Modified by SandipL on 12 Jan 2007 for SEMSP9 IssueID 9333
        ' Dim arrWidthArray() As String = {"align=left", "align=right"}
        Dim arrWidthArray() As String = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=right", "align=right"}
        ' End modifications by SandipL on 19 Jan 2007
        Dim arrColRowLinks() As String = {"", ""}
        Dim arrCheckBoxArray() As String = {"", ""}

        Dim arrSummaryFunctions() As String = {"", "", "", "", "", "Sum", "Sum"}
        Dim strHTML As New StringBuilder("")



        '##### Get Column Headings from Resources 
        arrColumnHeadingList.Add("Customer")
        arrColumnHeadingList.Add("Product Version")
        arrColumnHeadingList.Add("AMC From")
        arrColumnHeadingList.Add("AMC To")
        arrColumnHeadingList.Add("AMC Due Date")
        arrColumnHeadingList.Add("AMC Amount")
        arrColumnHeadingList.Add("Licences")
        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("CustomerName")
        arrActualColumnNames.Add("ProductVersion")
        arrActualColumnNames.Add("AMCFrom")
        arrActualColumnNames.Add("AMCTo")
        arrActualColumnNames.Add("AMCDueDate")
        arrActualColumnNames.Add("AMCAmount")
        arrActualColumnNames.Add("Licences")
        '##### End
        '/*Changed By Yasmin on 25th july 2018*/

        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objDetailsGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .CheckBoxIDArray = arrCheckBoxArray
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 7
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 0
            .returnHTML = True
            .SQL = strSQL
            .ColNameToolTipOnEachRow = False
            .UseSQL = True
            .EmptyValueReplacement = ""
            .SummaryFunctions = arrSummaryFunctions
            .ShowSummaryFunctions = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strHTML.Append(.DrawGrid())


        End With

        m_objDetailsGrid = Nothing
        Return strHTML.ToString()

    End Function
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

#End Region

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

        MyBase.InitializeResources("AppResources.PRD_ProductTree", "AppResources")
    End Sub

    Private Sub m_objDetailsGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objDetailsGrid.ColumnHeaderTD_BeforePrint

    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function GenerateInformation(ByVal NodeID As String)
        Try
            Dim drDetail As IDataReader
            Dim strSQL As String
            Dim strHTML As New StringBuilder("")
            Dim objTree As New CRM_ProductTree()

            drDetail = CommonFunctions.Data.GetDataReader("usp_sel_all_Productlines_ForTree " + NodeID, True)
            If drDetail.Read() Then
                'if it is Productline
                If CType(CommonFunctions.Data.CheckIsDBNull(drDetail("ProductLineID"), ""), String) <> "" Then
                    'WriteHTML("ProductLine")
                    strSQL = "usp_sel_Customer_AMC_Details " + CType(CommonFunctions.Data.CheckIsDBNull(drDetail("ProductLineID"), ""), String)
                End If
                'if it is Product
                If CType(CommonFunctions.Data.CheckIsDBNull(drDetail("ProductID"), ""), String) <> "" Then
                    'WriteHTML("Product")
                    strSQL = "usp_sel_Customer_AMC_Details NULL," + CType(CommonFunctions.Data.CheckIsDBNull(drDetail("ProductID"), ""), String)
                End If
                'if it is ProductVersion
                If CType(CommonFunctions.Data.CheckIsDBNull(drDetail("ProductVersionID"), ""), String) <> "" Then
                    'WriteHTML("ProductVersion")
                    strSQL = "usp_sel_Customer_AMC_Details NULL,NULL," + CType(CommonFunctions.Data.CheckIsDBNull(drDetail("ProductVersionID"), ""), String)
                End If
                'if it is Component
                If CType(CommonFunctions.Data.CheckIsDBNull(drDetail("ComponentID"), ""), String) <> "" Then
                    'WriteHTML("Component")
                    strSQL = "usp_sel_Customer_AMC_Details NULL,NULL,NULL," + CType(CommonFunctions.Data.CheckIsDBNull(drDetail("ComponentID"), ""), String)
                End If
            End If

            strHTML.Append(objTree.DrawDetailsGrid(strSQL))

            drDetail.Close()
            CommonFunctions.Data.DisposeDataReader(drDetail)

            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
End Class