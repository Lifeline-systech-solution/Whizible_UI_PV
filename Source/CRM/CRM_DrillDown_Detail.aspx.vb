Public Class CRM_DrillDown_Detail
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "protected variables"
    Protected WithEvents tblGraph As System.Web.UI.HtmlControls.HtmlTable
    Protected m_lngItemId As Long
    Protected m_lngDashboardID As Long
    Protected m_strCurrWHERE As String
    Protected m_strPrevWHERE As String
    Protected m_strPrevAttribute As String
    Protected m_strPrevAttributeValue As String
    Protected m_intGraphHeight As Integer = 0
    Protected m_intGraphWidth As Integer = 0
 Protected m_strFromWhere As String = ""
    Protected m_intCurrDrillDown As Integer
    Protected m_PKToken_Query_DT As String = "" '' Added by Yogesh J 
    Protected m_PKToken_Query_ID As String = ""

    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On - Friday, February 10, 2006 For HotFix ID. - 2.0.34-SP3-WAF
    'Reason   - For Showing the Drilldown order in the Page Caption.
    '-------------------------------------------------------------------------------------------------------------
    Protected m_strCurrentDrillDownPath As String = ""
    Protected m_strPrevAttributeNameForZoom As String = ""
    Protected m_strPrevAttributeValueForZoom As String = ""
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Friday, February 10, 2006 For HotFix ID. - 2.0.34-SP3-WAF
    '-------------------------------------------------------------------------------------------------------------

    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On - Thursday, February 22, 2006 For Req.ID. - WAF3_CDB_20
    'Reason   - For showing/hiding CT output page.
    '-------------------------------------------------------------------------------------------------------------
    Protected m_intShowCT As Integer = 0
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Thursday, February 22, 2006 For Req.ID. - WAF3_CDB_20
    '-------------------------------------------------------------------------------------------------------------

#End Region

#Region "module variables & constants"
    Private m_strSQL As String = ""
    Private m_strGraphSQL As String = ""
    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean

 Private m_blnFromADMIN As Boolean = False
    Private m_lngEntityID As Long
    Private m_lngQueryID As Long
    Private m_intGraphID As Integer
    Private m_intNoOfGraphElements As Integer = 5

    Private m_intPrevDrillDown As Integer
    Private m_intLastDrillDown As Integer
    Private m_strDrillDown_FirstField As String
    Private m_blnIsOracleDB As Boolean = False
	Private m_strConnectionString As String = ""
    Private m_blnDrillDownExists As Boolean = False
    Private m_strPalleteStyle As String
    Private m_strAccess As String
    'Added by SandipL -- Applying FilterText
    Protected m_lngFilterID As Long = 0
    Private m_strFilterText As String = ""
    Private m_strMode As String = "DB"
    'End addition by SandipL

#End Region


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Initialize()
        ''Added by Yogesh J on 19-Jan-2016 for to generate and validate Token
        If m_PKToken_Query_DT <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngItemId, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken_Query_DT) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_lngItemId, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of addition by Yogesh J 

        Call CreateDrillDownGraph()
    End Sub

    Protected Sub WriteDrillDownAttributesCombo()
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : WriteDrillDownAttributesCombo
        ' Requirement Tag       : WAF3_CDB_20
        ' Description           : This method plots the combobox for Available Drill Down Attributes
        ' Parameters Passed     : -
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Tuesday, February 14, 2006
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------

        Dim drDrillDownAttributes As IDataReader
        Dim strSQL As String = ""
        Dim sbScript As System.Text.StringBuilder
        Dim strToBeInserted As String = ""
        Dim strCaption As String = ""

        Try
            sbScript = New System.Text.StringBuilder("")
            m_lngEntityID = GetEntityID(m_lngQueryID)

            strSQL = "EXEC usp_Sel_tbl_CDB_Item_DrillDown_Master_GetDrillDownAttributes  " & m_lngEntityID & "," & m_lngItemId
            
            strCaption = GetFromResourceFile("CAP_DRILLDOWN_ATTRIBUTES")
            sbScript.Append(strCaption + ": ")

            strToBeInserted += " OnChange=JavaScript:cboDrillDownAttribut_OnChange() "

            sbScript.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDrillDownAttributes", strSQL, , m_strDrillDown_FirstField, strToBeInserted, False, True, , , , , ))
            Response.Write(sbScript.ToString)

            sbScript = Nothing

            If Not drDrillDownAttributes Is Nothing Then
                CommonFunctions.Data.DisposeDataReader(drDrillDownAttributes)
            End If
            drDrillDownAttributes = Nothing

        Catch ex As Exception
            sbScript = Nothing
            If Not drDrillDownAttributes Is Nothing Then
                CommonFunctions.Data.DisposeDataReader(drDrillDownAttributes)
            End If
            drDrillDownAttributes = Nothing

            ex.Source = "CDB_DrillDown_Detail->WriteDrillDownAttributesCombo"
            Throw ex

        End Try

    End Sub

    Protected Sub WriteMenu(ByVal ShowPageCaption As Boolean)
        '=====================================================================
        ' Procedure Name        : WriteMenu
        ' Purpose               : To write the menu for page
        ' Description           : To write the menu for page
        ' Parameters Passed     : ShowPageCaption as boolean
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : WebPage.Templates namespace
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        Dim blnReadOnly As Boolean = False

        ' get the sql
            If m_blnFromADMIN Then
            strSQL = "EXEC usp_Sel_tbl_CDB_Item_Master  NULL," & m_lngItemId
        Else
            strSQL = "EXEC usp_Sel_tbl_CDB_Item_Details  " & m_lngDashboardID & "," & m_lngItemId & "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"
        End If

        ' check for read only status
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            If Not IsDBNull(dr("ReadOnly")) Then
                blnReadOnly = CType(dr("ReadOnly"), Boolean)
            End If
        End If
        CloseDataReader(dr)

        If blnReadOnly Then
        If m_blnDrillDownExists Then
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_NEXTLEVEL"), MyBase.GetResourceString("MENU_CLOSE")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_NEXTLEVEL_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
                Dim arrCSFunction() As String = {"NextLevel_OnClick()", "Close_OnClick()"}
                'Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/next.gif"}

                If m_intShowCT = 0 Then

                    ReDim Preserve arrMenu(UBound(arrMenu) + 1)
                    arrMenu(UBound(arrMenu)) = MyBase.GetResourceString("MENU_CLOSE")

                    ReDim Preserve arrMenuToolTip(UBound(arrMenuToolTip) + 1)
                    arrMenuToolTip(UBound(arrMenuToolTip)) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")

                    ReDim Preserve arrCSFunction(UBound(arrCSFunction) + 1)
                    arrCSFunction(UBound(arrCSFunction)) = "Close_OnClick()"

                    'ReDim Preserve arrImagePaths(UBound(arrImagePaths) + 1)
                    'arrImagePaths(UBound(arrImagePaths)) = "../../Images/cssImages/Link images/close.gif"

                End If
                Dim intPos As Integer = -1
                WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrCSFunction = Nothing
                'arrImagePaths = Nothing
        ElseIf m_intShowCT = 0 Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
            Dim arrCSFunction() As String = {"Close_OnClick()"}
                'Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/close.gif"}
                Dim intPos As Integer = -1
                WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False)

                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrCSFunction = Nothing
                'arrImagePaths = Nothing
            End If
        Else
            If m_blnDrillDownExists Then
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_NEXTLEVEL")} ', MyBase.GetResourceString("MENU_CLOSE")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_NEXTLEVEL_TOOLTIP")} ', MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
                Dim arrCSFunction() As String = {"NextLevel_OnClick()"} ', "Close_OnClick()"}

                'Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/next.gif", "../../Images/cssImages/Link images/config.gif"}

                If m_intShowCT = 0 Then

                    ReDim Preserve arrMenu(UBound(arrMenu) + 1)
                    arrMenu(UBound(arrMenu)) = MyBase.GetResourceString("MENU_CLOSE")

                    ReDim Preserve arrMenuToolTip(UBound(arrMenuToolTip) + 1)
                    arrMenuToolTip(UBound(arrMenuToolTip)) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")

                    ReDim Preserve arrCSFunction(UBound(arrCSFunction) + 1)
                    arrCSFunction(UBound(arrCSFunction)) = "Close_OnClick()"

                    'ReDim Preserve arrImagePaths(UBound(arrImagePaths) + 1)
                    'arrImagePaths(UBound(arrImagePaths)) = "../../Images/cssImages/Link images/close.gif"

                End If

                Dim intPos As Integer = -1
                WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False)

                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrCSFunction = Nothing
                'arrImagePaths = Nothing
            Else


                If m_intShowCT = 0 Then

                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
                    Dim arrCSFunction() As String = {"Close_OnClick()"}

                    'ReDim Preserve arrImagePaths(UBound(arrImagePaths) + 1)
                    'arrImagePaths(UBound(arrImagePaths)) = "../../Images/cssImages/Link images/close.gif"


                    Dim intPos As Integer = -1
                    WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False)

                    arrMenu = Nothing
                    arrMenuToolTip = Nothing

                End If

                'arrImagePaths = Nothing
            End If
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------
        'Level : 2 Newer ends

        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Friday, February 17, 2006 For Req.ID. - WAF3_CDB_20
        '-------------------------------------------------------------------------------------------------------------
        'Level : 1 Older ends

        If ShowPageCaption Then
            With Response
                ' page caption
                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Friday, February 10, 2006 For HotFix ID. - 2.0.34-SP3-WAF
                'Reason   - For Showing the Drilldown order in the Page Caption.
                '-------------------------------------------------------------------------------------------------------------
                'Added Blank Table as BR was not whizible
                .Write("<TABLE>" & vbCrLf)
                .Write("<TR>" & vbCrLf)
                .Write("<TD>")
                .Write("</TD>")
                .Write("</TR>" & vbCrLf)
                .Write("</TABLE>" & vbCrLf)
                .Write("<BR>" & vbCrLf)

                If CommonFunctions.General.CheckIsNothing(m_strCurrentDrillDownPath) <> "" Then
                    WebPage.Templates.PageCaption.GetPageCaptions(, m_strCurrentDrillDownPath)
                Else
                    Dim strCaption As String = ""
                    strCaption = GetFromResourceFile("PAGE_CAP_DRILLDOWNS")
                    WebPage.Templates.PageCaption.GetPageCaptions(, strCaption)
                End If
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Friday, February 10, 2006 For HotFix ID. - 2.0.34-SP3-WAF
                '-------------------------------------------------------------------------------------------------------------
                'Added Blank Table as BR was not whizible
                .Write("<TABLE>" & vbCrLf)
                .Write("<TR>" & vbCrLf)
                .Write("<TD>")
                .Write("</TD>")
                .Write("</TR>" & vbCrLf)
                .Write("</TABLE>" & vbCrLf)
                .Write("<BR>" & vbCrLf)

            End With
        End If
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize
        ' Purpose               : To initialize the module variables
        ' Description           : To initialize the module variables
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : , CommonFucntions.dll
        '                         funApplyAccessFilter,funGetUserFriendlyAttributeName
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        Dim intGraphTypeID As Integer
      'Modified by SandeepA on 10 Aug 2005
        ' For Requirement Tag:WAF2_CDB_1
        ' Variable to get the enableattributesorting 
        Dim blnEnableAttributeSorting As Boolean
        ' End of modification
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Friday, February 10, 2006 For HotFix ID. - 2.0.34-SP3-WAF
        'Reason   - For Showing the Drilldown order in the Page Caption.
        '-------------------------------------------------------------------------------------------------------------
        Dim strLastDrillDownPath As String = ""
        Dim strCurrDrillDownPath As String = ""
        Dim strArrDrillDowns() As String
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Friday, February 10, 2006 For HotFix ID. - 2.0.34-SP3-WAF
        '-------------------------------------------------------------------------------------------------------------
        If Request.QueryString("ItemID") <> "" Then
            m_lngItemId = CType(Request.QueryString("ItemID"), Long)
        Else
            m_lngItemId = 0
        End If
        If Not Request.QueryString("DashboardID") Is Nothing Then
            m_lngDashboardID = CType(Request.QueryString("DashboardID"), Integer)
        End If
        If Not Request.QueryString("height") Is Nothing Then
            m_intGraphHeight = CType(Request.QueryString("height"), Integer)
        End If
        If Not Request.QueryString("width") Is Nothing Then
            m_intGraphWidth = CType(Request.QueryString("width"), Integer)
        End If

        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        End If
        ''Added by Yogesh J on 19-Jan-2016 for generate and validate Token
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_PKToken_Query_DT = Request.QueryString("PKToken").ToString
        End If
        ''Ended by Yogesh J on 19-Jan-2016 for generate and validate Token
        m_strPrevWHERE = Request.QueryString("CURRWHERE")
        m_strPrevWHERE = Replace(m_strPrevWHERE, "|||", "'")
        If Trim(m_strFromWhere & "").ToUpper = "ADMIN" Then
            m_blnFromADMIN = True
        Else
            m_blnFromADMIN = False
        End If

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Thursday, February 22, 2006 For Req.ID. - WAF3_CDB_20
        'Reason   - For showing/hiding CT output page.
        '-------------------------------------------------------------------------------------------------------------
        m_intShowCT = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ShowCT"), "0"), Integer)
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Thursday, February 22, 2006 For Req.ID. - WAF3_CDB_20
        '-------------------------------------------------------------------------------------------------------------


        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)


        ' get the graph id
        strSQL = "EXEC usp_Sel_tbl_CDB_Item_Master  NULL," & m_lngItemId
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngQueryID = CType(dr("QueryID"), Long)
            If Not IsDBNull(dr("DrillDownGraphTypeID")) Then
                m_intGraphID = CType(dr("DrillDownGraphTypeID"), Integer)
            Else
                m_intGraphID = CType(dr("GraphTypeID"), Integer)
            End If
            m_lngDashboardID = CType(dr("DashboardID"), Long)
            intGraphTypeID = CType(dr("GraphTypeID"), Integer)
            If Not IsDBNull(dr("NoOfGraphElements")) Then
                m_intNoOfGraphElements = CType(dr("NoOfGraphElements"), Integer)
            Else
                m_intNoOfGraphElements = 5
            End If
        End If
        CloseDataReader(dr)

        m_strPrevAttribute = Request.QueryString("colname").ToString

        m_strPrevAttributeValue = Replace(Request.QueryString("colvalue").ToString, "|||", "'")

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Friday, February 10, 2006 For HotFix ID. - 2.0.34-SP3-WAF
        'Reason   - For Showing the Drilldown order in the Page Caption.
        '-------------------------------------------------------------------------------------------------------------
        m_strPrevAttributeNameForZoom = m_strPrevAttribute
        m_strPrevAttributeValueForZoom = m_strPrevAttributeValue
        m_strCurrentDrillDownPath = CommonFunctions.General.CheckIsNothing(Request.QueryString("CurrentDrillDownPath"))
        m_strCurrentDrillDownPath = Replace(m_strCurrentDrillDownPath, "|||", "'")
        If m_strPrevAttributeValue <> "" Then
            m_lngEntityID = GetEntityID(m_lngQueryID)
            If m_strCurrentDrillDownPath <> "" Then
                strLastDrillDownPath = m_strCurrentDrillDownPath
                strLastDrillDownPath = strLastDrillDownPath.Replace("->", "^")
                strArrDrillDowns = strLastDrillDownPath.Split(New Char() {"^"c})
                strLastDrillDownPath = strArrDrillDowns(strArrDrillDowns.Length - 1)
                strCurrDrillDownPath = funGetUserFriendlyAttributeName(m_lngEntityID, m_strPrevAttribute) + "=" + m_strPrevAttributeValue
                If Not strLastDrillDownPath = strCurrDrillDownPath Then
                    m_strCurrentDrillDownPath += "->"
                    m_strCurrentDrillDownPath += funGetUserFriendlyAttributeName(m_lngEntityID, m_strPrevAttribute) + "=" + m_strPrevAttributeValue
                End If
            Else
                m_strCurrentDrillDownPath += funGetUserFriendlyAttributeName(m_lngEntityID, m_strPrevAttribute) + "=" + m_strPrevAttributeValue
            End If
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Friday, February 10, 2006 For HotFix ID. - 2.0.34-SP3-WAF
        '-------------------------------------------------------------------------------------------------------------

        If Trim(m_strPrevAttribute & "") <> "" And Trim(m_strPrevAttributeValue & "") = "" Then
            m_strPrevAttributeValue = "NOT SPECIFIED"
        End If
        If Not Request.QueryString("CURR") Is Nothing Then
            m_intCurrDrillDown = CType(Request.QueryString("CURR"), Integer)
        Else
            m_intCurrDrillDown = -1
        End If

        m_blnDrillDownExists = False

        ' DRILL DOWN DETAILS
        strSQL = "EXEC usp_Sel_tbl_CDB_Item_DrillDown_Master  " & m_lngItemId
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        Do While dr.Read
            If m_blnDrillDownExists = False Then
                If m_intCurrDrillDown <> -1 Then
                    ' THe prev. drill down was on this
                    If CInt(dr("DrillDownOrderNumber")) = m_intCurrDrillDown Then
                        m_intPrevDrillDown = CType(dr("DrillDownOrderNumber"), Integer)
                        '-------------------------------------------------------------------------------------------------------------
                        'Modified By - PushkarK On - Tuesday, February 14, 2006 For Req.ID. - WAF3_CDB_20
                        'Reason   - For Showing the Drilldown. Added the if condition.
                        '-------------------------------------------------------------------------------------------------------------
                        If Trim(m_strPrevAttribute & "") = "" Then
                            m_strPrevAttribute = dr("AttributeName").ToString
                        End If
                        '-------------------------------------------------------------------------------------------------------------
                        'Modification Ends By - PushkarK On - Tuesday, February 14, 2006 For Req.ID. - WAF3_CDB_20
                        '-------------------------------------------------------------------------------------------------------------
                    End If
                    ' NExt level
                    If CInt(dr("DrillDownOrderNumber")) > m_intCurrDrillDown Then
                        m_blnDrillDownExists = True
                        m_intCurrDrillDown = CType(dr("DrillDownOrderNumber"), Integer)
                        m_strDrillDown_FirstField = dr("AttributeName").ToString
                        '===============================================================================
                        ' Modified By : SandeepA
                        ' For Requirement Tag:WAF2_CDB_1
                        ' To get the Column value for Column 'EnableAttributeSorting
                        blnEnableAttributeSorting = CBool(CommonFunctions.Data.CheckIsDBNull(dr.Item("EnableAttributeSorting"), "0"))
                        ' End of Modifications For Requirement Tag:WAF2_CDB_1
                        '===============================================================================

                    End If
                Else
                    ' FIrst level
                    m_blnDrillDownExists = True
                    m_intCurrDrillDown = CType(dr("DrillDownOrderNumber"), Integer)
                    m_strDrillDown_FirstField = dr("AttributeName").ToString
                    '===============================================================================
                    ' Modified By : SandeepA
                    ' For Requirement Tag:WAF2_CDB_1
                    ' To get the Column value for Column 'EnableAttributeSorting
                    blnEnableAttributeSorting = CBool(CommonFunctions.Data.CheckIsDBNull(dr.Item("EnableAttributeSorting"), "0"))
                    ' End of Modifications For Requirement Tag:WAF2_CDB_1
                    '===============================================================================

                End If
            End If

            ' THe last drill down will be this
            m_intLastDrillDown = CType(dr("DrillDownOrderNumber"), Integer)
        Loop
        CloseDataReader(dr)

        'Added by SandipL
        If Not Request("CRMFilterID") Is Nothing Then
            m_lngFilterID = CLng(Request("CRMFilterID"))
            If m_lngFilterID > 0 Then
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_Filters " & m_lngFilterID, m_blnUseSQL)
                If dr.Read Then
                    If Trim(dr("FilterText").ToString & "") <> "" Then
                        m_strFilterText = " And (" & Trim(dr("FilterText").ToString) & ")"
                    End If
                End If

            ElseIf Not Session("strCRM_Filter_DB") Is Nothing Then
                If Session("strCRM_Filter_DB").ToString <> "" Then
                    m_strFilterText = " AND (" & Session("strCRM_Filter_DB").ToString & ")"
                End If
            End If
        End If
        CloseDataReader(dr)
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        End If
        'End addition by SandipL

        If m_intCurrDrillDown = m_intLastDrillDown Then m_blnDrillDownExists = False
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, February 14, 2006 For Req.ID. - WAF3_CDB_20
        'Reason   - For Showing the Drilldown.
        '-------------------------------------------------------------------------------------------------------------
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("cboVal"), "") <> "" Then
            m_strDrillDown_FirstField = CommonFunctions.General.CheckIsNothing(Request.QueryString("cboVal"), "")
            m_strPrevAttribute = m_strDrillDown_FirstField
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, February 14, 2006 For Req.ID. - WAF3_CDB_20
        '-------------------------------------------------------------------------------------------------------------

        Call GetConnectionString(GetConnectionID(, m_lngQueryID), m_blnIsOracleDB, m_blnUseSQL)

        ' Modified by SandeepA fro CDB-Sorting on Drill Down Attributes
        'For Requirement Tag:WAF2_CDB_1
        ' Added Argument blnEnableAttributeSorting
        m_strSQL = funBuildQueryForDrillDown(m_lngQueryID, intGraphTypeID, m_strDrillDown_FirstField, blnEnableAttributeSorting)
        'End of Modifications For Requirement Tag:WAF2_CDB_1


        If m_blnIsOracleDB Then
            m_strSQL = Replace(Replace(m_strSQL, "[", ""), "]", "")
            m_strGraphSQL = "SELECT " & Right(Trim(m_strSQL & ""), Len(Trim(m_strSQL & "")) - 6)
            m_strGraphSQL = "SELECT * From (" & m_strSQL & ") Where RowNum < " & (m_intNoOfGraphElements + 1)
        Else
            m_strGraphSQL = "SELECT TOP " & m_intNoOfGraphElements & "  " & Right(Trim(m_strSQL & ""), Len(Trim(m_strSQL & "")) - 6)
        End If

        ' set the DB settings
        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_DashboardDetails " + m_lngDashboardID.ToString, m_blnUseSQL)
        If dr.Read Then
            If Not IsDBNull(dr("DashboardType")) Then
                m_strAccess = dr("DashboardType").ToString
            Else
                m_strAccess = "FULL_ACCESS"
            End If
            If Not IsDBNull(dr("PalleteStyle")) Then
                m_strPalleteStyle = dr("PalleteStyle").ToString
            Else
                m_strPalleteStyle = "EARTHTONES"
            End If
            If m_intGraphHeight = 0 Then
                If Not IsDBNull(dr("GraphHeight")) Then
                    m_intGraphHeight = CType(dr("GraphHeight"), Integer)
                Else
                    m_intGraphHeight = 260
                End If
            End If

            If m_intGraphWidth = 0 Then
                If Not IsDBNull(dr("GraphWidth")) Then
                    m_intGraphWidth = CType(dr("GraphWidth"), Integer)
                Else
                    m_intGraphWidth = 492
                End If
            End If
        End If
        CloseDataReader(dr)

        SetGraphSettings()
    End Sub

    Private Function GetEntityID(Optional ByVal lngQueryID As Long = 0) As Long
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : GetEntityID
        ' Requirement Tag       : WAF3_CDB_20
        ' Description           : This method gives the Entity ID for the specified Query
        ' Parameters Passed     : -
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Friday, February 10, 2006
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------

        Dim dr As IDataReader

        If lngQueryID = 0 Then lngQueryID = m_lngQueryID

        ' get the entityid for the query

        Try
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_Query_Master " + lngQueryID.ToString, m_blnUseSQL)

            If dr.Read Then
                GetEntityID = CType(dr("EntityID"), Long)
            Else
                GetEntityID = 0
            End If
            CloseDataReader(dr)

        Catch ex As Exception
            If Not dr Is Nothing Then
                CloseDataReader(dr)
            End If
            ex.Source = "CDB_DrillDown_Detail->GetEntityID"
            Throw ex
        End Try

    End Function

    Private Function GetFromResourceFile(ByVal strKey As String) As String
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : GetFromResourceFile
        ' Requirement Tag       : WAF3_CDB_20
        ' Description           : This method gets the string from resource file
        ' Parameters Passed     : strKey - String
        ' Returns               : String
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Tuesday, February 14, 2006
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------
        GetFromResourceFile = ""
        MyBase.InitializeResources("Resources.CDB_DrillDown_Detail", "Resources")
        GetFromResourceFile = MyBase.GetResourceString(strKey)
        'Reset
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

    End Function

    Private Sub CreateDrillDownGraph()
        '=====================================================================
        ' Procedure Name        : CreateDrillDownGraph
        ' Purpose               : To create the drill down graph
        ' Description           : 
        ' Parameters Passed     : data reader object
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        Dim cell As New HtmlTableCell
        Dim row As New HtmlTableRow

        tblGraph.Rows.Add(row)
        ' add row cells
        cell = New HtmlTableCell
        cell.Attributes.Add("width", "100%")
        cell.Attributes.Add("align", "center")
        Try
            ' adding the chart control here by calling the function
            cell.Controls.Add(CreateGraph(m_lngItemId, m_strGraphSQL, m_intGraphHeight, m_intGraphWidth, True))
        Catch exc As Exception
            cell.Attributes.Add("class", "clsTDOdd")
            cell.Attributes.Add("border", "1")
            cell.Attributes.Add("bordercolor", "black")
            cell.InnerHtml = "<B>The graph was not generated</B>"
        End Try
        row.Cells.Add(cell)
 cell.Dispose() : cell = Nothing
        row.Dispose() : row = Nothing
    End Sub

    ' Modified by SandeepA for CDB-Sorting on Drill Down Attributes
    'For Requirement Tag:WAF2_CDB_1
    ' Added Argument blnEnableAttributeSorting

    Private Function funBuildQueryForDrillDown(ByVal intQueryID As Long, ByVal intGraphTypeID As Integer, ByVal strAttribute As String, Optional ByVal blnEnableAttributeSorting As Boolean = False) As String
        '=====================================================================
        ' Procedure Name        : funBuildQueryForDrillDown
        ' Description           : Build the query for the ID Passed for the next level
        ' Purpose               : To build the query for the ID Passed 
        ' Parameters Passed     : Query ID, GraphTypeID, ByVal strAttribute
        ' Returns               : The SQL Query
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : usp_CDB_Get_QueryDetails, CommonFucntions.dll
        '                         funApplyAccessFilter,funGetUserFriendlyAttributeName
        ' Author                : Rajanikant
        ' Created               : Wednesday, Jan 07, 2004 
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String, strSELECT As String, strFROM As String
        Dim strORDERBY As String, strGROUPBY As String, strWHERE As String
        Dim arrTemp() As String = {}
        Dim intUpperBound, intLoopCtr As Integer
        Dim strValueField As String
        Dim strTempWhere As String
        Dim strExtendedWhereClause As String
        Dim arr() As String = {}
        Dim intEntityID As Long
        Dim strDrillDownFilters As String
        Dim blnIsOracleDB As Boolean = False

        Dim arrSelect() As String = {}
        Dim arrGroupBy() As String = {}
        Dim arrOrderBy() As String = {}
        Dim intUpperBound2 As Integer
        Dim intGroupCount As Integer = 0

        Dim strAccess As String = ""

        ' The Details of the query
        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_QueryDetails " & intQueryID, True)
        If dr.Read Then
            strSELECT = dr("SelectClause").ToString
            strFROM = dr("EntityName").ToString
            strWHERE = dr("WhereClause").ToString
            strGROUPBY = dr("GroupByClause").ToString
            strORDERBY = dr("OrderByClause").ToString
            strExtendedWhereClause = dr("ExtendedWhereClause").ToString
            strTempWhere = strWHERE.ToString
 m_strCurrWHERE = strWHERE
            intEntityID = CType(dr("EntityID"), Long)
        End If
        CloseDataReader(dr)



        ' splitting the select list on comma (",")
        arrTemp = Split(strSELECT, ",")

        ' getting the upper bound of the array of select elements
        intUpperBound = UBound(arrTemp)

        For intLoopCtr = 0 To intUpperBound
            ReDim Preserve arrSelect(intLoopCtr)
            ReDim Preserve arrOrderBy(intLoopCtr)

            If InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "SUM(", CompareMethod.Binary) > 0 _
                Or InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "MAX(", CompareMethod.Binary) > 0 _
                Or InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "MIN(", CompareMethod.Binary) > 0 _
                Or InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "AVG(", CompareMethod.Binary) > 0 _
                Or InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "COUNT(", CompareMethod.Binary) > 0 _
                Then
                If intUpperBound = 0 Then
                    ReDim Preserve arrSelect(1)
                    ReDim Preserve arrOrderBy(1)
                    ReDim Preserve arrGroupBy(0)

                    ' function is applied
                    arr = Split(arrTemp(intLoopCtr), " As ")
                    intUpperBound2 = UBound(arr)

                    If blnIsOracleDB = True Then
                        strValueField = "NVL(" & arr(0) & ",0) As " & arr(intUpperBound2)
					arrSelect(0) = "NVL(" + strAttribute + ",'Not Specified') As " + strAttribute
                    Else
                        strValueField = "IsNull(" & arr(0) & ",0) As " & arr(intUpperBound2)
         
                    arrSelect(0) = "IsNull(" + strAttribute + ",'Not Specified') As " + strAttribute
           End If
                    arrOrderBy(0) = (1).ToString + " Asc"
                    arrGroupBy(0) = strAttribute
                    arrSelect(1) = strValueField
                    arrOrderBy(1) = (2).ToString + " Desc"
                    m_strPrevAttributeValue = ""
                    m_strPrevAttribute = ""
                Else
                    If intLoopCtr > 0 Then
                        ' function is applied
                        arr = Split(arrTemp(intLoopCtr), " As ")
                        intUpperBound2 = UBound(arr)

                        If blnIsOracleDB = True Then
                            strValueField = "NVL(" & arr(0) & ",0) As " & arr(intUpperBound2)
                        Else
                            strValueField = "IsNull(" & arr(0) & ",0) As " & arr(intUpperBound2)
                        End If
                        arrSelect(intLoopCtr) = strValueField
                        arrOrderBy(intLoopCtr) = (intLoopCtr + 1).ToString + " Desc"
                    Else
                        arrSelect(0) = "IsNull(" + strAttribute + ",'Not Specified') As " + strAttribute
                        arrOrderBy(0) = (intLoopCtr + 1).ToString + " Desc"
                    End If
                End If
            Else
                ReDim Preserve arrGroupBy(intGroupCount)
                'no function is applied
                If intLoopCtr = 0 Then
  					If blnIsOracleDB = True Then
                        arrSelect(0) = "NVL(" + strAttribute + ",'Not Specified') As " + strAttribute
                    Else
                        arrSelect(0) = "IsNull(" + strAttribute + ",'Not Specified') As " + strAttribute
                    End If
                    arrGroupBy(intGroupCount) = strAttribute
                    arrOrderBy(intLoopCtr) = (intLoopCtr + 1).ToString + " Asc"
                Else
                    arr = Split(arrTemp(intLoopCtr), " As ")
                    intUpperBound2 = UBound(arr)

                    If blnIsOracleDB = True Then
                        strValueField = "NVL(" & arr(0) & ",0) As " & arr(intUpperBound2)
                    Else
                        strValueField = "IsNull(" & arr(0) & ",0) As " & arr(intUpperBound2)
                    End If
                    arrSelect(intLoopCtr) = strValueField
                    arrGroupBy(intGroupCount) = arrTemp(intLoopCtr)
                    arrOrderBy(intLoopCtr) = (intLoopCtr + 1).ToString + " Asc"
                End If
                intGroupCount += 1
            End If
        Next

        strSQL = "SELECT " + Join(arrSelect, ",")

        strSQL = strSQL & " FROM " & strFROM

        ' WHERE
        If Trim(m_strPrevWHERE & "") = "" Then
            ' the where clause with the level filter
            'strAccess = " FunctionID=" & GetEmployeeDepartment(m_lngEmployeeID)

            'addded by harshada d on 14 feb 2006 for helpdesk enhancements
            Dim strSQLAccessibleRequests As New System.Text.StringBuilder
            If m_strMode = "DB" Then
                'strSQLAccessibleRequests.Append(" WHERE(1 = 1)")
                strSQLAccessibleRequests.Append("  v_CRM_HelpDesk_Master.QueryID IN ")
                strSQLAccessibleRequests.Append("( Select QueryID FROM v_CRM_HelpDesk_Master where v_CRM_HelpDesk_Master.FunctionID IN ")
                strSQLAccessibleRequests.Append("( SELECT DepartmentID FROM fnAccessibleDepts(" & m_lngEmployeeID & "")
                strSQLAccessibleRequests.Append(" ))")
                strSQLAccessibleRequests.Append("UNION")
                strSQLAccessibleRequests.Append("( Select QueryID FROM v_CRM_HelpDesk_Master where ")
                strSQLAccessibleRequests.Append(" v_CRM_HelpDesk_Master.CustomerID in (SELECT CustomerShortName ")
                strSQLAccessibleRequests.Append("from fnAccessibleCustomers (" & m_lngEmployeeID & "")
                strSQLAccessibleRequests.Append(" ))))")
            ElseIf m_strMode = "SR" Then
                strSQLAccessibleRequests.Append(" CustomerID = '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'")
                strSQLAccessibleRequests.Append(" AND	Left(LoginType,1) ='" & m_strLoginType & "' ")

            ElseIf m_strMode = "AR" Then
                strSQLAccessibleRequests.Append(" 	AssignTo =" & m_lngEmployeeID.ToString)
            End If


            If Trim(strSQLAccessibleRequests.ToString + "") <> "" Then
                If Trim(strWHERE & "") <> "" Then
                    strWHERE = Replace(Trim(strWHERE & ""), "@", "") & " AND " + strSQLAccessibleRequests.ToString
                Else
                    strWHERE = strSQLAccessibleRequests.ToString
                End If
            End If
        Else
            ' the where clause for the last drill down
            strWHERE = "(" & m_strPrevWHERE & ")"
        End If
        If m_strFilterText <> "" Then
            m_strFilterText = formatfiltertext(m_strFilterText)
            strWHERE = strWHERE & m_strFilterText
        End If
        'End Of addition by harshada d on 14 feb 2006 for helpdesk enhancements

        ' CAll was from a detail
        If Trim(m_strPrevAttributeValue & "") <> "" Then
            If UCase(Trim(m_strPrevAttributeValue & "")) = "NOT SPECIFIED" Then
                ' THe attribute value Is "Not specifed" (implies it is NULL in the database)		
                If Trim(strWHERE & "") <> "" Then
                    strWHERE = strWHERE & " AND " & m_strPrevAttribute & "  IS NULL "
                Else
                    strWHERE = m_strPrevAttribute & " IS NULL "
                End If
       If Trim(m_strCurrWHERE & "") <> "" Then
                    m_strCurrWHERE = m_strCurrWHERE & " AND " & m_strPrevAttribute & "  IS NULL "
                Else
                    m_strCurrWHERE = m_strPrevAttribute & "  IS NULL "
                End If
            Else
                ' else appending the condition for the drill down
                If Trim(strWHERE & "") <> "" Then
                    strWHERE = strWHERE & " AND " & m_strPrevAttribute & " = '" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                Else
                    strWHERE = m_strPrevAttribute & " = '" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                End If
  If Trim(m_strCurrWHERE & "") <> "" Then
                    m_strCurrWHERE = m_strCurrWHERE & " AND " & m_strPrevAttribute & " = '" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                Else
                    m_strCurrWHERE = m_strPrevAttribute & " = '" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                End If
            End If
        End If

        strSQL = strSQL & " WHERE 1=1 "
        If Trim(strWHERE & "") <> "" Then
            strSQL = strSQL & " AND " & strWHERE
        End If

        If Trim(strExtendedWhereClause & "") <> "" Then
            arr = Split(Trim(strExtendedWhereClause & ""), " ")
            If UCase(Trim(arr(0) & "")) = "AND" Or UCase(Trim(arr(0) & "")) = "OR" Then
                strSQL = strSQL & " " & strExtendedWhereClause
            Else
                strSQL = strSQL & " AND " & strExtendedWhereClause
            End If
        End If

        ' the current where clause that will submitted
        m_strCurrWHERE = strWHERE

        strDrillDownFilters = Replace(strWHERE, WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(m_blnUseSQL, intEntityID, Replace(Trim(strTempWhere & ""), "@", "")), "")

        strDrillDownFilters = Replace(Trim(strDrillDownFilters & ""), Trim(strTempWhere & ""), "", 1, Len(Trim(strDrillDownFilters & "")), CompareMethod.Binary)

        If Left(Trim(strDrillDownFilters & ""), 4) = "AND " Then
            strDrillDownFilters = Right(Trim(strDrillDownFilters & ""), Len(Trim(strDrillDownFilters & "")) - 4)
        End If

        strGROUPBY = Join(arrGroupBy, ",")
        If Right(Trim(strGROUPBY & ""), 1) = "," Then
            strGROUPBY = Left(Trim(strGROUPBY & ""), Len(Trim(strGROUPBY & "")) - 1)
        End If
        ' GROUP BY
        strSQL = strSQL & " GROUP BY " & strGROUPBY



        ' ORDER BY
        '===================================================================================================
        ' Modified By SandeepA on 10 Aug 2005
        ' For Requirement Tag:WAF2_CDB_1
        ' Reversing the array only for default sorting
        If blnEnableAttributeSorting = False Then
            arrOrderBy.Reverse(arrOrderBy)
        End If
        'End of Modifications 10 Aug 2005 SandeepA Requirement Tag:WAF2_CDB_1
        '===================================================================================================
        strORDERBY = Join(arrOrderBy, ",")
        If Right(Trim(strORDERBY & ""), 1) = "," Then
            strORDERBY = Left(Trim(strORDERBY & ""), Len(Trim(strORDERBY & "")) - 1)
        End If
        If Trim(strORDERBY & "") <> "" Then
            strSQL = strSQL & " ORDER BY " & strORDERBY
        End If


        'REplacing the comma operator if any
        strSQL = Replace(strSQL, "@COMMA@", ",")

        strSQL = Replace(Replace(strSQL, "[[", "[", , , Microsoft.VisualBasic.CompareMethod.Binary), "]]", "]", , , Microsoft.VisualBasic.CompareMethod.Binary)

  '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On - Thursday, July 13, 2006 For Hotfix ID. - 2.0.17-SP4-WAF
        'Reason      - For Support Request ID. - 119. The Query Builder Session Variables were not getting set.
        '              Hence replacement was done with blank values. 
        'Solution    - Added the code to set and clear QRB Session Variables
        '-------------------------------------------------------------------------------------------------------------
        CommonFunctions.General.SetQRBSessionVariables()

        strSQL = CommonFunctions.General.ReplacePlaceHolders(strSQL)

        CommonFunctions.General.ClearQRBSessionVariables()
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Thursday, July 13, 2006 For Hotfix ID. - 2.0.17-SP4-WAF
        '-------------------------------------------------------------------------------------------------------------

        ' REturning the final query
        funBuildQueryForDrillDown = Replace(Replace(strSQL & "", "[[", "["), "]]", "]")
    End Function

    Private Function GetEmployeeDepartment(ByVal EmployeeID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetEmployeeDepartment
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_EmployeeDepartment " & EmployeeID, m_blnUseSQL)
        If dr.Read Then
            GetEmployeeDepartment = CType(CommonFunctions.General.CheckIsNothing(dr("DepartmentID"), "0"), Long)
        Else
            GetEmployeeDepartment = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function funGetUserFriendlyAttributeName(ByVal intEntityID As Long, ByVal strAttributeName As String) As String
        '=====================================================================
        ' Procedure Name        : funGetUserFriendlyAttributeName()
        ' Description           : to get the user friendlyname of the attribute
        ' Purpose               : 
        ' Parameters Passed     : ByVal intEntityID, ByVal strAttributeName
        ' Returns               :
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          : communfunctions.asp,usp_CDB_Get_UserFriendlyName
        ' Author                : Rajanikant
        ' Created               : Friday, August 09, 2002 14:56 
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader

        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_UserFriendlyName  " & intEntityID & ",'" & CommonFunctions.General.BuildQueryString(Trim(strAttributeName & "")) & "'", True)
        If dr.Read Then
            ' REturning the User Friendly name
            funGetUserFriendlyAttributeName = Trim(dr(0).ToString & "")
        Else
            ' NO match found returning the same attribute back
            funGetUserFriendlyAttributeName = Trim(strAttributeName & "")
        End If
      CloseDataReader(dr)

    End Function


    Private Function CreateGraph(ByVal ItemID As Long, ByVal SQL As String, ByVal Height As Integer, ByVal Width As Integer, ByVal ShowDrillDowns As Boolean) As WebControl
        '=====================================================================
        ' Procedure Name        : CreateGraph
        ' Purpose               : To create the graph for the dashboard item
        ' Description           : 
        ' Parameters Passed     : itemid, sql, height,width,showdrilldowns(true/false)
        ' Returns               : graph control as web control
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim objGraph As Graph.Graph
        Dim strSQL As String
        Dim strBorderStyle As String = ""
        Dim strBorderColor As String = ""
        Dim strChartBackColor As String = ""
        Dim strChartAreaColor As String = ""
        Dim strCaptionColor As String = ""
        Dim intUCL As Integer = 0
        Dim intLCL As Integer = 0
        Dim strUCLColor As String = ""
        Dim strLCLColor As String = ""
        Dim strPieLabelStyle As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim strTitleColor As String = ""
        Dim blnEnable3D As Boolean = False

        Dim intXAxisMax As Long = 0
        Dim intXAxisMin As Long = 0
        Dim intXAxisInterval As Long = 0

        Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings
        Dim blnShowHover As Boolean = True

        Dim blnOracle As Boolean
        Dim strConnectionString As String

        'check the application settings for hover on graphs
        objFrameworkSetting = CommonEngines.HashTables.GetHashTableObject.GetHashTableFrameWorkSettingsObject("EnableHoverForCDBDrillDowns")
        If Not objFrameworkSetting Is Nothing Then
            If objFrameworkSetting.ValidateStatus() = True Then
                If UCase(Trim(objFrameworkSetting.Status & "")) = "Y" Then
                    blnShowHover = True
                Else
                    blnShowHover = False
                End If
            Else
                blnShowHover = False
            End If
        End If
        objFrameworkSetting = Nothing


        ' get the item details
        strSQL = "EXEC usp_CDB_GetQueryDetails_ForItem " & m_lngDashboardID & "," & m_lngItemId & ",null,null,1"

        ' Added 03-Oct-2005 RajK R.No WAF3_CDB_7
        strSQL += ",'" + CommonFunctions.General.BuildQueryString(m_strDrillDown_FirstField) + "'"
        ' End Addition 03-Oct-2005 RajK WAF3_CDB_7


        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            ' set the item values
            strItemName = dr("ItemName").ToString : strBorderStyle = dr("BorderStyle").ToString
            strBorderColor = dr("BorderColor").ToString : strChartBackColor = dr("ChartBackColor").ToString
            strChartAreaColor = dr("ChartAreaColor").ToString : strCaptionColor = dr("CaptionColor").ToString
            strTitleColor = dr("TitleColor").ToString
            If Not IsDBNull(dr("UCL")) Then
                intUCL = CType(dr("UCL"), Integer)
            End If
            strUCLColor = dr("UCLColor").ToString
            If Not IsDBNull(dr("LCL")) Then
                intLCL = CType(dr("LCL"), Integer)
            End If
            strLCLColor = dr("LCLColor").ToString
            If Not IsDBNull(dr("ShowLegends")) Then
                blnShowLegends = CType(dr("ShowLegends"), Boolean)
            End If
            If Not IsDBNull(dr("ShowExplodedPie")) Then
                blnShowExplodedPie = CType(dr("ShowExplodedPie"), Boolean)
            End If
            If Not IsDBNull(dr("Enable3D")) Then
                blnEnable3D = CType(dr("Enable3D"), Boolean)
            End If
            lngEntityID = CType(dr("EntityID"), Long)
            strNomenclature = dr("Nomenclature").ToString
            strPieLabelStyle = dr("PieLabelStyle").ToString

            If Not IsDBNull(dr("XAxisMin")) Then
                intXAxisMin = CType(dr("XAxisMin"), Long)
            End If
            If Not IsDBNull(dr("XAxisMax")) Then
                intXAxisMax = CType(dr("XAxisMax"), Long)
            End If
            If Not IsDBNull(dr("XAxisInterval")) Then
                intXAxisInterval = CType(dr("XAxisInterval"), Long)
            End If

            ' Added 03-Oct-2005 RajK R.No WAF3_CDB_7
            ' change the graph type based on user set graph type 
            m_intGraphID = CType(CommonFunctions.Data.CheckIsDBNull(dr("DrillDownGraphTypeID"), "0"), Integer)
            ' End addition  03-Oct-2005 RajK R.No WAF3_CDB_7
        End If
        CloseDataReader(dr)


        ' default title color
        If Trim(strTitleColor & "") = "" Then strTitleColor = "white"

        strConnectionString = GetConnectionString(GetConnectionID(lngEntityID), blnOracle, m_blnUseSQL)
        m_blnIsOracleDB = blnOracle
        m_strConnectionString = strConnectionString
        If blnOracle Then
            SQL = Replace(Replace(SQL, "[", ""), "]", "")
        End If
        ' create the graph for the item
        objGraph = New Graph.Graph
        objGraph.ConnectionString = CommonFunctions.Application.ConnectionString
        objGraph.ExternalDBConnectionString = strConnectionString
        objGraph.UseSQL = m_blnUseSQL
        objGraph.ExternalDBUseSQL = Not blnOracle
        objGraph.VirtualImagePath = "../../Images/"
        objGraph.Enable3D = blnEnable3D
        objGraph.ChartType = GetChartType()
        objGraph.BorderStyle = strBorderStyle
        objGraph.PalleteStyle = m_strPalleteStyle
        objGraph.GraphTitle = strItemName
        objGraph.GraphTitleColor = strTitleColor
        objGraph.TitleFont = New System.Drawing.Font("verdana", 10, System.Drawing.FontStyle.Bold)
        objGraph.SQL = SQL
        objGraph.Width = Width
        objGraph.Height = Height
        objGraph.ChartBackColor = strChartBackColor
        objGraph.ChartAreaColor = strChartAreaColor
        objGraph.BorderColor = strBorderColor

        objGraph.BorderGradientColor = "WHITE"
        objGraph.BorderGradientStyle = "TOPBOTTOM"
        objGraph.ChartBackGradientColor = "WHITE"
        objGraph.ChartBackGradientStyle = "TOPBOTTOM"
        objGraph.ChartAreaGradientColor = "WHITE"
        If objGraph.ChartType(0) = "PIE" Or objGraph.ChartType(0) = "DOUGHNUT" Then
            objGraph.ChartAreaGradientStyle = "CENTER"
        Else
            objGraph.ChartAreaGradientStyle = "TOPBOTTOM"
        End If
        If Not (m_intGraphID = 2 Or m_intGraphHeight = 7) Then
            objGraph.LegendColor = getColor(ItemID)
        End If
        objGraph.LegendCaptionColor = strCaptionColor
        objGraph.LegendBorderColor = strCaptionColor
        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
        'objGraph.XAxisFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
        'objGraph.YAxisFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
        'objGraph.XAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Bold)
        'objGraph.YAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Bold)

        If m_blnDrillDownExists Then
            If blnShowHover Then
                objGraph.DrillDownHoverPage = "CRM_DrillDown_Hover.aspx?DashboardID=" + m_lngDashboardID.ToString + "&ItemID=" + ItemID.ToString + "&CURR=" + m_intCurrDrillDown.ToString + "&CURRWHERE=" + Replace(Server.UrlEncode(m_strCurrWHERE), "'", "|||") + "&"
            End If
            objGraph.DrillDownClientSideFunctionName = "DrillDown_OnClick(" + ItemID.ToString + ","
        End If
        If m_intGraphID = 2 Then
            objGraph.ShowExplodedPie = blnShowExplodedPie
            objGraph.PieChartLabelStyle = strPieLabelStyle
        End If
        objGraph.ShowLegends = blnShowLegends
        objGraph.EntityID = lngEntityID
        objGraph.Nomenclature = strNomenclature
        objGraph.PieChartLabelStyle = strPieLabelStyle
        If m_intGraphID <> 5 Then
            objGraph.LCL = intLCL : objGraph.LCLColor = strLCLColor
            objGraph.UCL = intUCL : objGraph.UCLColor = strUCLColor
        End If

        objGraph.YAxisMin = intXAxisMin
        If intXAxisMax <> 0 Then
            objGraph.YAxisMax = intXAxisMax
        End If
        If intXAxisInterval <> 0 Then
            objGraph.YAxisInterval = intXAxisInterval
        End If
        objGraph.XAxisInterval = 1

        ' return the control
        Return objGraph.GenerateChartControl()
        objGraph = Nothing
    End Function


    Private Function getColor(ByVal ItemID As Long) As String()
        '=====================================================================
        ' Procedure Name        : GetColor
        ' Purpose               : To get the colors the sql
        ' Description           : 
        ' Parameters Passed     : item id
        ' Returns               : arr of string for color
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Dec 16,2003
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim intCount As Integer = 1
        Dim arr() As String = {}

        strSQL = "usp_sel_tbl_CDB_Item_Series_Master " + ItemID.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arr(intCount)
            arr(intCount) = dr("ColorName").ToString
            intCount += 1
        Loop
        CloseDataReader(dr)

        Return arr
    End Function


    Private Function GetChartType() As String()
        '=====================================================================
        ' Procedure Name        : GetChartType()
        ' Purpose               : get the chart type array
        ' Description           : 
        ' Parameters Passed     : data reader object
        ' Returns               : array of chart types
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        Dim ds As DataSet
        Dim intUBound As Integer
        Dim intX As Integer
        Dim strSQL As String
        Dim dr As IDataReader
        Dim arr() As String = {}
        Dim intCount As Integer = 1
        Dim arrGraph() As String = {}

        ds = CommonFunctions.Data.GetDataSet(m_strSQL, "default", , , UseSQL)
        intUBound = ds.Tables(0).Columns.Count()
        ds.Dispose() : ds = Nothing

        strSQL = "usp_sel_tbl_CDB_Item_Series_Master " + m_lngItemId.ToString

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arrGraph(intCount)
            arrGraph(intCount) = dr("GraphID").ToString
            intCount += 1
        Loop
        CloseDataReader(dr)

        Select Case m_intGraphID
            Case 2 'pie
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "PIE"
                Next
                Return arr
            Case 3 ' column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                                arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                            Else
                                arr(intX) = "COLUMN"
                            End If
                        Else
                            arr(intX) = "COLUMN"
                        End If
                    Else
                        arr(intX) = "COLUMN"
                    End If
                Next
                Return arr
            Case 4 ' line
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "LINE"
                        End If
                    Else
                        arr(intX) = "LINE"
                    End If
                Next
                Return arr
            Case 5 ' bar
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "BAR"
                Next
                Return arr
            Case 6 ' step
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "STEPLINE"
                        End If
                    Else
                        arr(intX) = "STEPLINE"
                    End If
                Next
                Return arr
            Case 7 ' doughnut
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "DOUGHNUT"
                Next
                Return arr

            Case 8 ' CandleStick
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "CANDLESTICK"
                        End If
                    Else
                        arr(intX) = "CANDLESTICK"
                    End If
                Next
                Return arr

            Case 9 ' Spline
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINE"
                        End If
                    Else
                        arr(intX) = "SPLINE"
                    End If
                Next
                Return arr
            Case 10 ' Splin area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINEAREA"
                        End If
                    Else
                        arr(intX) = "SPLINEAREA"
                    End If
                Next
                Return arr

            Case 11 ' Area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "AREA"
                        End If
                    Else
                        arr(intX) = "AREA"
                    End If
                Next
                Return arr
            Case 12 ' stacked column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "RADAR"
                Next
                Return arr
            Case Else
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "COLUMN"
                Next
                Return arr
        End Select


    End Function

    Private Function GetChartName(ByVal intGraphID As Integer) As String
        '=====================================================================
        ' Procedure Name        : GetChartName
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================

        Select Case intGraphID
            Case 2 : Return "PIE"
            Case 3 : Return "COLUMN"
            Case 4 : Return "LINE"
            Case 5 : Return "BAR"
            Case 6 : Return "STEPLINE"
            Case 7 : Return "DOUGHNUT"
            Case 8 : Return "CANDLESTICK"
            Case 9 : Return "SPLINE"
            Case 10 : Return "SPLINEAREA"
            Case 11 : Return "AREA"
            Case 12 : Return "RADAR"
            Case Else : Return "COLUMN"
        End Select
    End Function
    ' Added by SandipL to overcome mismatch in fields of Listing view and Entity view
    Private Function formatfiltertext(ByVal strFilterText As String) As String
        strFilterText = strFilterText.ToUpper.Replace("ASSIGNTO", "USERNAME")
        strFilterText = strFilterText.ToUpper.Replace("LOGINTYPE", "LEFT(LOGINTYPE,1)")
        formatfiltertext = strFilterText
    End Function
    'End addition by SandipL
    Protected Sub BuildGrid()
        '=====================================================================
        ' Procedure Name        : BuildGrid()	
        ' Purpose               : To build the grid for the Query id
        ' Description           : To build the grid for the Query id
        ' Parameters Passed     : ByVal Query ID, sortby, sortorder, div height
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : ProjectByNet.QueryBuilder namespace
        ' Author                : Rajanikant
        ' Created               : Nov 10,2003
        ' Revisions             :
        '=====================================================================
        Dim objGrid As WebPage.Templates.GenericGrid
        Dim dr As IDataReader
        Dim m_lngEntityID As Long
        Dim intX As Integer
        Dim intY As Integer
        Dim intUpperBound As Integer
        Dim intActualColumnCount As Integer
        Dim arrAttributesAN() As String = {}
        Dim arrAttributesUFN() As String = {}
        Dim arrAttributes() As String = {}
        Dim arrAttributesUFAttributes() As String = {}
        Dim arrRowLink() As String = {}
        Dim ds As DataSet
        Dim strSQL As String = ""
        Dim lngDetailQueryID As Long

        Dim blnOracle As Boolean
        Dim strConnectionString As String
        ' get the entityid for the query
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_Query_Master " + m_lngQueryID.ToString, m_blnUseSQL)
        If dr.Read Then
            m_lngEntityID = CType(dr("EntityID"), Long)
        Else
            ' entity id is missing 
            Exit Sub
        End If
        CloseDataReader(dr)

        strConnectionString = GetConnectionString(GetConnectionID(m_lngEntityID), blnOracle, m_blnUseSQL)
        ' populate the attirb arrays
        Call CRM_QueryOutput.PopulateEntityAttributeArrays(m_lngEntityID, arrAttributes, arrAttributesUFAttributes, m_blnUseSQL)
        intUpperBound = UBound(arrAttributes)
        ReDim arrAttributesAN(0) : ReDim arrAttributesUFN(0)

        ' execute the SQL passed--> to get the actual columns
        dr = CommonFunction.Data.GetDataReader(m_strSQL, Not blnOracle, strConnectionString)
        For intX = 0 To dr.FieldCount - 1
            ReDim Preserve arrAttributesAN(intX) : ReDim Preserve arrAttributesUFN(intX)
            For intY = 0 To intUpperBound
                If arrAttributes(intY).Trim.ToUpper = dr.GetName(intX).Trim.ToUpper Or arrAttributes(intY).Trim.ToUpper = "[" & dr.GetName(intX).Trim.ToUpper & "]" Then
                    ' actual column names
                    arrAttributesAN(intX) = ""
                    ' user friendly column names
                    arrAttributesUFN(intX) = arrAttributesUFAttributes(intY).Trim
                    Exit For
                End If
            Next
        Next
        CloseDataReader(dr)


        strSQL = "EXEC usp_Sel_tbl_CDB_Item_Master  NULL," & m_lngItemId
        dr = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            If Not IsDBNull(dr("DetailQueryID")) Then
                lngDetailQueryID = CType(dr("DetailQueryID"), Long)
            End If
        End If
        CloseDataReader(dr)

        If lngDetailQueryID <> 0 Then
            ReDim Preserve arrAttributesAN(UBound(arrAttributesAN) + 1)
            ReDim Preserve arrAttributesUFN(UBound(arrAttributesUFN) + 1)
            ReDim arrRowLink(UBound(arrAttributesAN))
            arrAttributesAN(UBound(arrAttributesAN)) = "Details"
            arrAttributesUFN(UBound(arrAttributesUFN)) = "Details"
        End If


        ' get the actual column count
        dr = CommonFunctions.Data.GetDataReader(m_strSQL, Not blnOracle, strConnectionString)
        intActualColumnCount = dr.FieldCount
        If UBound(arrRowLink) < 0 Then
            ReDim Preserve arrRowLink(intActualColumnCount)
        End If
        If m_blnDrillDownExists Then
            arrRowLink(0) = "DrillDown_OnClick({}" + m_lngItemId.ToString + ",'{}" + dr.GetName(0) + "','" + dr.GetName(0) + "')"
        End If

        If lngDetailQueryID <> 0 Then
            ''Added by Yogesh J on 20-Jan-2016 to generate and pass token
            m_PKToken_Query_ID = CommonFunctions.Security.Token.GetToken(CType(lngDetailQueryID, String) + CType(Session("intUserID"), String) + "0" + "0")
            ''End of addition by Yogesh J 20-Jan-2016 to generate and pass token
            arrRowLink(UBound(arrRowLink)) = "Detail_OnClick({}" + lngDetailQueryID.ToString + ",'{}" + dr.GetName(0) + "','" + dr.GetName(0) + "')"
        End If
        CloseDataReader(dr)


        ' Grid object
        objGrid = New WebPage.Templates.GenericGrid
        ' set attributes
        objGrid.ActualColumnArray = arrAttributesAN
        objGrid.UserFriendlyColumnArray = arrAttributesUFN

        objGrid.DIVHeight = m_intGraphHeight : objGrid.DIVID = "DivList2" : objGrid.DIVStyle = "overflow:scroll"
        objGrid.NoOfDataColumns = intActualColumnCount : objGrid.RowLinkArray = arrRowLink
        objGrid.PrinterFriendlyVersion = False
        objGrid.SQL = m_strSQL : objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False : objGrid.UseSQL = m_blnUseSQL
        objGrid.ConnectionString = strConnectionString

        objGrid.DrawGrid()

        ' clean up
        arrAttributes = Nothing : arrAttributesUFAttributes = Nothing
        arrAttributesAN = Nothing : arrAttributesUFN = Nothing
        objGrid = Nothing
    End Sub


    Private Sub CloseDataReader(ByRef dr As IDataReader)
        '=====================================================================
        ' Procedure Name        : CloseDataReader
        ' Purpose               : To close the datareader object
        ' Description           : 
        ' Parameters Passed     : data reader object
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
    End Sub
    Private Sub SetGraphSettings()
        '=====================================================================
        ' Procedure Name        : SetGraphSettings
        ' Purpose               : To get the pallete style to be applied
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Mar 23,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_CDB_DashboardSettings " & m_lngDashboardID & "," & m_lngEmployeeID & ",'" & m_strLoginType & "'", m_blnUseSQL)
        If dr.Read Then
            m_strPalleteStyle = dr("PalleteStyle").ToString
            If m_intGraphHeight = 0 Then
                m_intGraphHeight = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphHeight").ToString, "0"), Integer)
            End If
            If m_intGraphWidth = 0 Then
                m_intGraphWidth = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphWidth").ToString, "0"), Integer)
            End If
        End If
        CloseDataReader(dr)
    End Sub

    Private Function GetConnectionString(ByVal lngConnectionID As Long, ByRef IsOracle As Boolean, ByVal UseSQL As Boolean) As String
        '=====================================================================
        ' Procedure Name        : GetConnectionString()	
        ' Description           : To get the connection info. for conn. id.
        ' Purpose               : To get the connection info. for conn. id.
        ' Parameters Passed     : ByVal Connection ID,ByRef Database type, BYval UseSQL (true/false)
        ' Returns               : connection string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : usp_sel_tbl_QRB_Connection_Master
        ' Author                : Rajanikant
        ' Created               : Dec 18,2003
        ' Revisions             :
        '=====================================================================
        If lngConnectionID <> 0 Then
            Dim dr As IDataReader
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_Connection_Master " + lngConnectionID.ToString, UseSQL)
            If dr.Read Then
                GetConnectionString = dr("ConnectionString").ToString
                If dr("DatabaseType").ToString.Trim.ToUpper = "S" Then
                    IsOracle = False
                Else
                    IsOracle = True
                End If
            Else
                GetConnectionString = ""
            End If
            CloseDataReader(dr)
        Else
            GetConnectionString = ""
        End If
    End Function

    Function GetConnectionID(Optional ByVal EntityID As Long = 0, Optional ByVal QueryID As Long = 0) As Long
        '=====================================================================
        ' Procedure Name        : GetConnectionID()	
        ' Description           : To get the connection info. for conn. id.
        ' Purpose               : To get the connection info. for conn. id.
        ' Parameters Passed     : ByVal Connection ID,ByRef Database type, BYval UseSQL (true/false)
        ' Returns               : connection string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : usp_sel_tbl_QRB_Connection_Master
        ' Author                : Rajanikant
        ' Created               : Nov 07,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        If QueryID = 0 Then
            dr = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID " & EntityID, m_blnUseSQL)
            If dr.Read Then
                If Not IsDBNull(dr("ConnectionID")) Then
                    GetConnectionID = CType(dr("ConnectionID"), Long)
                Else
                    GetConnectionID = 0
                End If
            Else
                GetConnectionID = 0
            End If
            CloseDataReader(dr)
        Else
            dr = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID_ForQuery " & QueryID, m_blnUseSQL)
            If dr.Read Then
                If Not IsDBNull(dr("ConnectionID")) Then
                    GetConnectionID = CType(dr("ConnectionID"), Long)
                Else
                    GetConnectionID = 0
                End If
            Else
                GetConnectionID = 0
            End If
            CloseDataReader(dr)
        End If

    End Function


    '  Added 28-Sep-2005 Rajanikant Khethawatt R.No:WAF3_CDB_7
    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    '  End Addition 28-Sep-2005 Rajanikant Khethawatt R.No:WAF3_CDB_7
End Class

