Public Class Home
    Inherits WebPages.Template.WhizTemplate
#Region "Member variables"

    Protected sbHTML As StringBuilder
    Protected m_strDefaultPageURL As String = ""
    Protected m_strSQL As String = ""
    Protected dsGroupTab As DataSet
    Protected dsTabItems As DataSet
    Protected m_strGroupTabID As String = ""
    Protected IsFirstHit As Boolean
    Protected m_strTabGroupItemID As String = ""
    Protected m_objAccess As New WebPage.Templates.AccessRights
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    'Protected RecordCount As Integer = 0

    Protected IsAccessForNode As Boolean
    Protected m_strSearchText As String = ""

    Protected m_intPageNumber As Integer = 0
    Protected m_intRowCount As Integer = 0
    Protected dblRatio As Double = 0.0
    'Protected dsTemp As DataSet
    Private strPagecaption As String = ""
    Protected m_strLinkOptions As String = ""
    Protected m_strIsXMLHTTP As String = ""
    Protected m_strMode As String = ""
    Protected m_strFavTagID As String = ""
    Protected argCB As CommonFunctions.HTMLControls.WAF_DropDown
    Protected m_strProjectID As String = ""
    Protected m_strDefaultTagID As String = ""
    Protected m_strControlItemID As String = ""
    Protected m_strIsFavXMLHTTP As String = ""
    Protected m_InsControlItemID As String = ""
    Protected m_FirstTagCIID As String = ""

    'Added By Amol Changle On: 08 May 2009
    'Purpose:To use New/Old tree
    Protected m_intUseNewUITree As Integer = 0
    'End Addition


    'Protected m_strAction As String = ""
    'Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected m_strTemplateID As String = ""
    Protected m_CRMDefaultPage As String = ""
    Protected m_lngPostID As Long = 0
    Protected m_strModuleBarImage As String = "../../Images/Sort_down.gif"
    Protected m_strNavigationBarImage As String = "../../Images/Home/LeftMove.gif"

    Protected m_strRModuleBarImage As String = "../../Images/Sort_up.gif"
    Protected m_strRNavigationBarImage As String = "../../Images/Home/RightMove.gif"
    Protected m_lngCRMID As Long = 0
    Protected drCRM As IDataReader
    Protected intFlagSessionExpire As String = "0"
    Protected m_strAllowResourceAllocation As String = CommonFunction.Application.AllowResourceAllocation.ToString
    Protected m_strToken As String
    Protected AllowVersionChange As String = "0"
#End Region
#Region "Costants"
    Protected Const PAGE_SIZE As Integer = 10
    Private Const DEFAULT_TAGID As Long = 32
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        Dim drCompany As IDataReader
        drCompany = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            AllowVersionChange = CommonFunctions.Data.CheckIsDBNull(drCompany("AllowVersionChange"), "0")
        End If
    End Sub
    Protected Sub PageInit()
        m_strToken = CommonFunctions.Security.Token.GetToken(CType(16, String) + CType(Session("intUserID"), String) + "0" + "0")

        'm_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")).ToString()

        'Call PerformAction()

        Initialize_Variables()

        DrawHiddenFields()

        'Call DrawProjectSelectionDiv()

        If m_strIsFavXMLHTTP = "1" And m_strMode <> "" Then
            AddRemoveFavourites()
            DrawHiddenFields()
            Response.Clear()
            '---Modified by purvaj on 14 Jul 2009 Favourites displayed in all the tabs.
            Response.Write((New Home_FloatingMenu).DrawFavoriateTabs(m_strTemplateID.ToUpper, Request.Browser.Browser.ToString)) '"PM"
            '--- End modifiaction purvaj
            Response.End()
            Exit Sub

            'Code Added By Bharat Tekade on 1st-Feb-2016 for favorites tree
        ElseIf m_strIsFavXMLHTTP = "0" And m_strMode <> "" Then
            AddRemoveFavourites()
            DrawHiddenFields()
            Response.Clear()
            '---Modified by purvaj on 14 Jul 2009 Favourites displayed in all the tabs.
            'Response.Write((New Home_FloatingMenu).DrawFavoriateTabs(m_strTemplateID.ToUpper, Request.Browser.Browser.ToString)) '"PM"
            '--- End modifiaction purvaj
            Response.End()
            Exit Sub
        'End of Code Added By Bharat Tekade on 1st-Feb-2016 for favorites tree
        End If

        GetDatabasValues()

        DrawHeader()

        WritePage()

        DisposeNotUsedObjects()

    End Sub


    Protected Sub DrawHiddenFields()
        '=====================================================================
        ' Proce  Name	    	:	DrawHiddenFields
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw hidden fields
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGroupTabID", "txtGroupTabID", , , , m_strGroupTabID, , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtThemeID", "hidTxtThemeID", , , , , , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTemplateID", "hidTemplateID", , , , m_strTemplateID, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGroupTabID", "txtGroupTabID", , , , m_strGroupTabID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtThemeID", "hidTxtThemeID", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTemplateID", "hidTemplateID", , , , m_strTemplateID, , , , , , True, , True, EnableHTMLEncode:=True))
        'Code Added By Bharat T on 8th-Oct-2015 for Fav Tabs
        Dim strFavouriteTagIDs As String

        'Commented and Added By Bharat Tekade on 1st-Oct-2016
        If Not m_strMode = "DT" And Not m_strMode = "AT" Then
            strFavouriteTagIDs = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull( _
                    CommonFunctions.Data.GetDataScalar("usp_sel_tbl_UI_NavigationMenu_Favorites " + _
                    CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID")) + ",'" + m_strTemplateID + "','" + _
                    CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType")) + "'", True)))
        Else
            strFavouriteTagIDs = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull( _
                    CommonFunctions.Data.GetDataScalar("usp_sel_tbl_SEM_ControlItems_FavouritesTreeNode " + _
                    CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID")) + ",'" + m_strTemplateID + "','" + _
                    CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType")) + "'", True)))
        End If
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtFavouriteTagIDs", "txtFavouriteTagIDs", value:=strFavouriteTagIDs, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End of Code Added By Bharat T on 8th-Oct-2015 for Fav Tabs
    End Sub
    Protected Sub DisposeNotUsedObjects()
        '=====================================================================
        ' Function  Name		:	DisposeNotUsedObjects
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To destroy not used objects
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        dsGroupTab = Nothing
        dsTabItems = Nothing
        m_objAccess = Nothing
        m_GlobalObject = Nothing
        argCB = Nothing
    End Sub
    Protected Sub Initialize_Variables()
        '=====================================================================
        ' Function  Name		:	Initialize_Variables
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Persists the state of the page 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        GetGlobalObject()

        If Not Request("GroupTabID") Is Nothing Then
            m_strGroupTabID = CType(Request("GroupTabID"), String)
        Else
            m_strGroupTabID = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtGroupTabID"), ""), String)
        End If

        m_strTabGroupItemID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("TabGroupItemID"), ""), String)

        m_strSearchText = CommonFunction.General.CheckIsNothing(Request.Form("txtSearch"))

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber")) <> "" Then
            m_intPageNumber = CType(Request.Form("txtPageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If

        m_strLinkOptions = CommonFunction.General.CheckIsNothing(Request.Form("cboLinkOptions"), "")

        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strTemplateID = CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
        Else
            m_strTemplateID = CommonFunction.General.CheckIsNothing(Request.Form("hidTemplateID"), "")
        End If


        m_lngPostID = m_GlobalObject.RoleID

        If m_strTemplateID <> "PM" And m_GlobalObject.LoginType.ToUpper = "E" Then
            m_lngPostID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Employee_Role " + m_GlobalObject.UserID.ToString, MyBase.UseSQL), "0"), Long)
        End If

        m_strIsXMLHTTP = CommonFunction.General.CheckIsNothing(Request("IsXMLHTTP"))
        m_strMode = CommonFunction.General.CheckIsNothing(Request("Mode"))
        m_strFavTagID = CommonFunction.General.CheckIsNothing(Request("FavTagID"))
        m_strProjectID = m_GlobalObject.ProjectID.ToString
        m_strIsFavXMLHTTP = CommonFunction.General.CheckIsNothing(Request("IsFavXMLHTTP"))

        m_strDefaultTagID = CommonFunctions.General.CheckIsNothing(Request("hidDefaultTagID"), "0").ToString()
        m_strControlItemID = CommonFunctions.General.CheckIsNothing(Request("hidDefaultControlItemID"), "0").ToString()

        If GetTagAccessRights(CType(m_strDefaultTagID, Long)) Then
            m_strDefaultPageURL = CommonFunctions.General.CheckIsNothing(Request("hidDefaultPageURL"), "").ToString()
        Else
            m_strDefaultPageURL = ""
        End If

        m_strSQL = "Exec usp_Sel_Home_CRM_HRM " & HttpContext.Current.Session("intUserID").ToString
        drCRM = CommonFunctions.Data.GetDataReader(m_strSQL, True)
        If drCRM.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(drCRM("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drCRM)

        'Added By Amol Changle On: 11 May 2009
        'Purpose: To select whether to use New/Old UI tree
        m_intUseNewUITree = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_Sel_UseNewUITree", True), "0"), "0").ToString(), Integer)
        'End Addition
        If m_strTemplateID = "CRM" Then
            '--- Added By purvaj on 3 Aug 2009 to set the default page URL for Helpdesk
            Dim drDefaultMode As IDataReader
            Dim strMode As String = ""
            ' get the default mode for the user
            drDefaultMode = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultSettings	" & CType(Session("intUserID"), Long) & ",'DefaultMode','" & CommonFunctions.General.BuildQueryString(CType(Session("LoginType"), String)) & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drDefaultMode.Read Then
                strMode = drDefaultMode("ItemValue").ToString
            Else
                strMode = "SR"
            End If
            If strMode.ToUpper = "DB" And m_lngCRMID = 0 Then
                strMode = "SR"
            End If
            CommonFunction.Data.DisposeDataReader(drDefaultMode)
            If CType(Session("LoginType"), String) = "E" Then
                'Commented And Added By Vaijat K ON 17/11/2017 For Opening New Page Default
                'Select Case strMode
                '    Case "MD"
                '        m_CRMDefaultPage = "../CRM/CRM_MyDashboard.aspx?Mode=MD"

                '    Case "DB"
                '        m_CRMDefaultPage = "../CRM/CRM_Dashboard.aspx?Mode=DB"

                '    Case "SR"
                '        m_CRMDefaultPage = "../CRM/CRM_RequestList.aspx?Mode=SR"

                '    Case "AR"
                '        m_CRMDefaultPage = "../CRM/CRM_RequestList.aspx?Mode=AR"
                'End Select
                m_CRMDefaultPage = "../HelpdeskEnhancement/Settings/HelpdeskTab.aspx"
                'End Commented And Added By Vaijat K ON 17/11/2017 For Opening New Page Default
            Else
                'Commented And Added By Vaijat K ON 17/11/2017 For Opening New Page Default
                'm_CRMDefaultPage = "../CRM/CRM_RequestList.aspx?Mode=SR"
                m_CRMDefaultPage = "../HelpdeskEnhancement/Settings/HelpdeskTab.aspx"
                'End Commented And Added By Vaijat K ON 17/11/2017 For Opening New Page Default
            End If
            '--- End addition purvaj
        End If

    End Sub
    Private Sub GetDatabasValues()
        Call CommonFunction.General.GetWorkflowStatus()
        Dim strIsActive As Boolean = CommonFunction.Application.IsActive
        Dim intCnt As Integer = 0

        '
        'm_strSQL = "usp_Sel_AccessibleProjectTags "
        'Integrated by vidyak for for Whiziblesem9.0 SP1 -HotFix 9.0.002(Patch  for moving Process Management & chlid  nodes from Configuration to Process module.).
        'If m_strTemplateID <> "PRO" And m_strTemplateID <> "KM" Then
        If m_strTemplateID <> "KM" Then
            'End-Integrated by vidyak for for Whiziblesem9.0 SP1 -HotFix 9.0.002(Patch  for moving Process Management & chlid  nodes from Configuration to Process module.).
            m_strSQL = "usp_Sel_AccessibleProjectTags_setup "

            'If m_strSearchText <> "" Then
            '    m_strSQL += "N'" & CommonFunction.General.BuildQueryString(m_strSearchText) & "'"
            'Else


            m_strSQL += " NULL"
            'End If

            'If m_strLinkOptions <> "" Then
            '    m_strSQL = m_strSQL + "," + m_strLinkOptions
            'Else
            m_strSQL = m_strSQL + ",NULL"
            'End If

            m_strSQL = m_strSQL + "," & m_GlobalObject.UserID.ToString
            m_strSQL = m_strSQL + "," & m_GlobalObject.RoleID.ToString
            m_strSQL = m_strSQL + "," & m_GlobalObject.ProjectID.ToString
            m_strSQL = m_strSQL + ",'" & m_GlobalObject.LoginType & "'"

            m_strSQL += "," + m_strTemplateID

            'Added By Amol Changle On: 07 May 2009
            'Purpose: To plot old tree, last parameter passed as TreeType='O'
            If CType(m_intUseNewUITree, Boolean) Then
                m_strSQL = m_strSQL + ",'N'"
            Else
                m_strSQL = m_strSQL + ",'O'"
            End If
            'Integrated by vidyak for for Whiziblesem9.0 SP1 -HotFix 9.0.002(Patch  for moving Process Management & chlid  nodes from Configuration to Process module.).
            ' ElseIf m_strTemplateID.ToUpper = "PRO" Then
            ' m_strSQL = "usp_Sel_Process_QC_Tree "
            'Integrated by vidyak for for Whiziblesem9.0 SP1 -HotFix 9.0.002(Patch  for moving Process Management & chlid  nodes from Configuration to Process module.).
        ElseIf m_strTemplateID.ToUpper = "KM" Then
            'Commented and Modified by AbhijeetC on 4 Nov 2009 for WhizibleSEM 9.0
            'm_strSQL = "usp_SEL_KM_Tree "
            m_strSQL = "usp_SEL_KM_Tree " & m_GlobalObject.UserID.ToString & ",'" & m_GlobalObject.LoginType & "'"
            'Commented and Modified by AbhijeetC on 4 Nov 2009 for WhizibleSEM 9.0
        End If
        'End Addition

        'dsTemp = CommonFunction.Data.GetDataSet(m_strSQL, "TEMP", , , MyBase.UseSQL)

        'm_intRowCount = dsTemp.Tables(0).Rows.Count


        'Dim intStartRecord As Integer = 0

        'intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)

        '======================Amol
        'If m_intPageNumber = -1 Then
        dsGroupTab = CommonFunction.Data.GetDataSet(m_strSQL, "GroupTab", , , MyBase.UseSQL)
        'Else
        'dsGroupTab = CommonFunction.Data.GetDataSet(m_strSQL, "GroupTab", intStartRecord, PAGE_SIZE, MyBase.UseSQL)
        'End If
        '===============Amol

        Dim strScript As New StringBuilder
        Dim strTagID As String
        Dim intRowIndex As Integer = 0
        Dim drTree As IDataReader
        Dim strSQL As String = ""
        Dim dr As IDataReader

        '--- Added By purvaj on 10 jul 2009 for helpdesk tree
        If m_strTemplateID.ToUpper = "CRM" Or m_strTemplateID.ToUpper = "DB" Then
            strScript.Append("<script language=javascript>")
            strScript.Append(vbCrLf)
            strScript.Append("var Tree = new Array;")
            strScript.Append(vbCrLf)
            drTree = CommonFunction.Data.GetDataReader("usp_sel_Tree_forNewUI '" + m_strTemplateID.ToUpper.ToString + "','" + m_GlobalObject.LoginType + "'", True)
            While drTree.Read()
                '""5|1|e-dashboard|../CRM/CRM_Dashboard.aspx?Mode=DB|HelpDesk|5|page.gif|1"";")
                If GetTagAccessRights(CommonFunction.Data.CheckIsDBNull(drTree("TagID"), 0)) = True Or CommonFunction.Data.CheckIsDBNull(drTree("TagID"), 0) = 0 Then
                    Select Case CommonFunction.Data.CheckIsDBNull(drTree("TagDescription"), "").ToString.ToUpper
                        Case "WORKFLOW APPROVALS"
                            If strIsActive = True Then
                                strScript.Append("Tree[" + intCnt.ToString + "]=""")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ControlItemID"), "0").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ParentItemID"), "0").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("TagDescription"), "").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("PageName"), "").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ParentTagName"), "").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("TagID"), "0").ToString + "|")
                                strScript.Append("page.gif|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("IsParent"), "0").ToString + """;")
                                intCnt += 1
                            End If
                        Case "E-DASHBOARD"

                            If m_lngCRMID <> 0 Then
                                strScript.Append("Tree[" + intCnt.ToString + "]=""")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ControlItemID"), "0").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ParentItemID"), "0").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("TagDescription"), "").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("PageName"), "").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ParentTagName"), "").ToString + "|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("TagID"), "0").ToString + "|")
                                strScript.Append("page.gif|")
                                strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("IsParent"), "0").ToString + """;")
                                intCnt += 1
                            End If
                        Case Else
                            strScript.Append("Tree[" + intCnt.ToString + "]=""")
                            strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ControlItemID"), "0").ToString + "|")
                            strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ParentItemID"), "0").ToString + "|")
                            strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("TagDescription"), "").ToString + "|")
                            strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("PageName"), "").ToString + "|")
                            strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("ParentTagName"), "").ToString + "|")
                            strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("TagID"), "0").ToString + "|")
                            strScript.Append("page.gif|")
                            strScript.Append(CommonFunction.Data.CheckIsDBNull(drTree("IsParent"), "0").ToString + """;")
                            intCnt += 1
                    End Select
                End If
            End While
            strScript.Append(vbCrLf)
            strScript.Append("</script>")
            CommonFunction.Data.DisposeDataReader(drTree)
        Else
            '--- End addition purvaj
            strScript.Append("<script language=javascript>")
            strScript.Append(vbCrLf)
            strScript.Append("var Tree = new Array;")
            strScript.Append(vbCrLf)
            If dsGroupTab.Tables(0).Rows.Count > 0 Then
                For intIndex As Integer = 0 To dsGroupTab.Tables(0).Rows.Count - 1

                    If intRowIndex <= dsGroupTab.Tables(0).Rows.Count - 1 Then
                        strTagID = CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("TagID"), "0").ToString()
                    End If

                    'Added and modified by ShraddhaM on 15,Jun 2009
                    'To hide project--> Staffing Plan nodewhen resource allocation workflow is on
                    If strTagID = "3855" Then
                        If CommonFunction.Application.AllowResourceAllocation Then
                            intIndex = intIndex - 1
                            intRowIndex = intRowIndex + 1
                            Continue For

                        End If
                    End If


                    If intRowIndex <= dsGroupTab.Tables(0).Rows.Count - 1 Then


                        strScript.Append("Tree[")
                        strScript.Append(intIndex.ToString())
                        strScript.Append("]=""")
                        strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("TagID"), "0").ToString())
                        strScript.Append("|")
                        strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("ParentTagID"), "0").ToString())
                        strScript.Append("|")
                        strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("TagDescription"), "").ToString())
                        strScript.Append("|")
                        If Not CType(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("IsParent"), "0"), Boolean) Then
                            If (m_strProjectID <> "" And m_strProjectID <> "0") Or m_strTemplateID.ToUpper <> "PM" Then
                                strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("PageName"), "").ToString())
                            Else
                                If strTagID = "32" Or strTagID = "3936" Then
                                    strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("PageName"), "").ToString())
                                End If
                            End If
                        End If
                        strScript.Append("|")
                        strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("ParentTagName"), "").ToString())
                        strScript.Append("|")
                        strScript.Append(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("ControlItemID"), "0").ToString())
                        strScript.Append("|page.gif")
                        If CType(CommonFunctions.Data.CheckIsDBNull(dsGroupTab.Tables(0).Rows(intRowIndex)("IsParent"), "0"), Boolean) Then
                            strScript.Append("|-1"";")
                        Else
                            strScript.Append("|0"";")
                        End If
                        strScript.Append(vbCrLf)

                        intRowIndex = intRowIndex + 1
                        'End of addition and modification by Shraddha M
                    End If
                Next
            End If

            strScript.Append("</script>")
        End If

        strScript.Append(vbCrLf)

        CommonFunctions.General.WriteHTML(strScript.ToString())
        strScript = Nothing

        'For Each drRow As DataRow In dsGroupTab.Tables(0).Rows
        '    If CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID")), String) <> "" And CType(CommonFunction.Data.CheckIsDBNull(drRow("ControlItemID")), String) <> "0" Then
        '        m_FirstTagCIID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TagID")), String)
        '    End If
        '    Exit For
        'Next
    End Sub
    Protected Sub DrawHeader()
        '=====================================================================
        ' Function  Name		:	DrawHeader()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw page header
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 05th, 2009
        ' Revisions				:	
        '=====================================================================

        Dim m_sBHTML As New StringBuilder
        Dim strRightCaption As String = ""
        Dim sbH As New StringBuilder("")
        Dim strDashBoardID As String = ""

        sbH.Append("<div id='divHeader' style='width:100%;valign:top; height:38px;'>")  ''ADDED BY PuneetM 23-06-2015

        sbH.Append("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0   class='clsGridTable' width=100%  style=""BORDER-BOTTOM: black 1px outset; "">")
        sbH.Append("<TR class='clsTRBlank'>")
        '-------------- modified by purvaj on 13 Jul 2009 SEM 8.1 New UI
        '-------------- favourite items will be displayed accross tabs.
        '-------------If m_strTemplateID.ToUpper <> "DB" And m_strTemplateID.ToUpper <> "CRM" Then

        ' "TD_clsTDBlank_width" Added by Dhanashri S on 16 Mar 2015
        'sbH.Append("<TD class='clsTDBlank TD_clsTDBlank_width'  style=""valign:bottom;align:left;border:0;width:19%;"" >") ''border:0 By Puneet M 23-06-2015
        'Commented added by Shamkant S on 10 Nov 2015
        sbH.Append("<TD class='clsTDBlank TD_clsTDBlank_width'  style=""valign:bottom;align:left;border:0;width:21%;"" >")
        'End of Addition by Dhanashri S
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''sbH.Append(CommonFunction.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , , 20, m_strSearchText, , "width:50%;vertical-align:bottom", , , , , "  onkeypress=txtSearch_OnKeyup(event)  title='Search Pages' placeholder='Search' style='height:20px;'", True, , )) ' onkeypress='javascript:ShowFloatingmenu(""SearchIn"",event)'
        sbH.Append(CommonFunction.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , , 20, m_strSearchText, , "width:50%;vertical-align:bottom", , , , , "  onkeypress=txtSearch_OnKeyup(event)  title='Search Pages' placeholder='Search' style='height:20px;'", True, , , EnableHTMLEncode:=True)) ' onkeypress='javascript:ShowFloatingmenu(""SearchIn"",event)'
        'style='height:22px;'
        sbH.Append("&nbsp;<input type='button' value='Search'  onclick='javascript:Search_OnClick(event)' text='Search' title='Search'>")
        If m_strTemplateID.ToUpper = "KM" Then
            sbH.Append("&nbsp;<input type='button' value='Search Text'  onclick='javascript:SearchText_OnClick()' text='Search Text' title='Search Text'>")
        End If
        sbH.Append("</Td>")

        If m_strTemplateID.ToUpper = "DB" Then

            If Trim(m_GlobalObject.RoleID.ToString) <> "" Then
                m_strSQL = "usp_CDB_GetUserDashboardsForCombo  " & m_GlobalObject.UserID.ToString & "," & m_GlobalObject.RoleID.ToString
            Else
                m_strSQL = "usp_CDB_GetUserDashboardsForCombo  " & m_GlobalObject.UserID.ToString
            End If

            strDashBoardID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CDB_DefaultDashboard_Home " + HttpContext.Current.Session("intUserID").ToString + ",'" + HttpContext.Current.Session("LoginType").ToString + "'", True), ""), "") '../Home/MyHome_TabUI.aspx?ShortName=TabUI&FromWhere=TABUI|0"
            m_CRMDefaultPage = strDashBoardID
            ''Commented By Puneet M on 12 June 2015, Purpose: For Top Home Link & DropDown responsive
            ''sbH.Append("<TD  class='clsTDBlank' style=""valign:bottom;align:left;width:40%;"">Select Dashboard&nbsp;")
            ''Added By Puneet M on 12 June 2015, Purpose: For Top Home Link & DropDown responsive
            sbH.Append("<TD  class='clsTDBlank' style=""valign:bottom;align:left;width:38%;border:0;"">Select Dashboard&nbsp;") ''border:0; By PuneetM 23-06-2015
            ''End of Added By Puneet M on 12 June 2015, Purpose: For Top Home Link & DropDown responsive
            sbH.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", m_strSQL, 250, strDashBoardID, "OnChange='JavaScript:cboDashboard_OnChange(event)'", , True))
            ''Below line Commented by Puneet M on 12th June 2015. Purpose Image Position alignment
            ''sbH.Append("<Img id='imgHome' Border=0 src='../../Images/Home/home.jpg' align='top' OnClick='JavaScript:cboDashboard_OnChange(event)' style='cursor:pointer'></A>")
            ''Below line Modified by Puneet M on 12 june 2015 Purpose: image alignment
            sbH.Append("<Img id='imgHome' Border=0 src='../../Images/Home/home.jpg' OnClick='JavaScript:cboDashboard_OnChange(event)' style='cursor:pointer'></A>")
            ''End of line Modified by Puneet M on 12 june 2015 Purpose: image alignment
            sbH.Append("</td>")
            '''''ElseIf m_strTemplateID.ToUpper = "CRM" Then
            '''''    sbH.Append("<TD class='clsTDBlank' style=""valign:bottom;align:left"">&nbsp;")
            '''''    sbH.Append("</td>")
        End If



        If m_strTemplateID.ToUpper = "PM" Then
            ' "TD_clsTDBlank_width_SwitchProject" Added by Dhanashri S on 16 Mar 2015
            sbH.Append("<TD class='clsTDBlank TD_clsTDBlank_width_SwitchProject' align=right  style=""valign:top;text-align:left;padding:1px 1px 1px 1px;border:0"">") 'border:#C0C0FF 1px outset;padding:1px 1px 1px 1px;     MODIFIED BY PUNEET M 23-06-2015. Purpose:[Remove td right grey border] border:0
            'End of Addition by Dhanashri S
            sbH.Append("<a href=""#"" class='clsLinkHome' title='Projects' style='text-decoration:none;' onclick='javascript:ShowFloatingmenu(""Project"",event)' >&nbsp;<b>Switch Project</b>&nbsp;&nbsp;</a>") '&nbsp;&nbsp;&nbsp;")';&nbsp;<img src='../../Images/Home/Projects.gif' border=0 style=""vertical-align:bottom"">&nbsp;&nbsp; padding:  1px 2px 1px 2px;border: #C0C0FF 1px outset;MARGIN: 1px 1px 1px 1px;

            sbH.Append("&nbsp;</Td>")
        End If


        ' "TD_clsTDBlank_width_PrevButton" Added by Dhanashri S on 16 Mar 2015
        ''Below line modified[width:3%;] by Puneet M on 12th June 2015 Purpose: Prev image width reduced.
        sbH.Append("<TD class='clsTDBlank TD_clsTDBlank_width_PrevButton'   align=right style=""valign:bottom;align:right;width:3%;border:0;"">") '' MODIFIED BY PUNEET M ON 23-06-2015 PURPOSE[White border remove] border:0
        'End of Addition by Dhanashri S 

        sbH.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousFAV()"" Title=""Previous Favorites"" onmouseover=""window.status='Previous Favorites';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbH.Append("<Img id='prevLeft' Border=0 src='../../Images/Home/roundleft.gif' align='top'></A>")
        sbH.Append("</Td>")

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '--- Modified by purvaj on 14 Jul 2009 8.1 SEM New UI , adjust the widdh when called from DB(HOME)

        ' "TD_clsTDBlank_width_FavTabs" Added by Dhanashri S on 16 Mar 2015
        If m_strTemplateID.ToUpper = "DB" Then
            sbH.Append("<TD id='tdTabs' name='tdTabs' valign=top align=right class='clsTDBlank TD_clsTDBlank_width_FavTabs'  style=""valign :bottom;align:right;white-space:nowrap; border:0;"">")   ''PUNEET M 23-06-2015   width: 20%; border:0
        Else
            sbH.Append("<TD id='tdTabs' name='tdTabs' class='clsTDBlank TD_clsTDBlank_width_FavTabs'  style=""valign :bottom;align:right;white-space:nowrap;  border:0;"">")   ''PUNEET M 23-06-2015   width: 20%; border:0
        End If
        'End of Addition by Dhanashri S

        sbH.Append((New Home_FloatingMenu).DrawFavoriateTabs(m_strTemplateID, Request.Browser.Browser.ToString))

        sbH.Append("</Td>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


        '''''''''''''''PrashantSJ 20th May 2009


        sbH.Append("<TD class='clsTDBlank' align=right  style=""valign:bottom;text-align:right;border:0;width: 5%;white-space:nowrap;"">") '' PUNEET M 23-06-2015 border:0; | txt-align:right (08-JULY-2015)
        sbH.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextFAV()"" Title=""Next Favorites"" onmouseover=""window.status='Next Favorites';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbH.Append("<Img id='prevRight' Border=0 src='../../Images/Home/roundright.gif' align='top'></A>&nbsp;&nbsp; ")
        sbH.Append("<a href=""#""  title='Manage Favorites' onclick='javascript:ShowFloatingmenu(""GoTo"",event)' style=""text-decoration:none;vertical-align:bottom;""><img src='../../Images/Home/Favorites.gif' border=0 style=""vertical-align:top""></a>") '&nbsp;&nbsp;&nbsp;")
        sbH.Append("</td>")

        '''--ElseIf m_strTemplateID.ToUpper = "DB" Then

        '''''''''''''''''End modification purvaj

        sbH.Append("</tr>")
        sbH.Append("</table>")


        sbH.Append("</div>")

        If m_strIsFavXMLHTTP = "1" Then
            Response.Clear()
            Response.Write(sbH.ToString)
            Response.End()
        Else
            Response.Write(sbH.ToString)
        End If

        sbH = Nothing
        m_sBHTML = Nothing
        sbH = Nothing

    End Sub
    Protected Sub WritePage()
        '=====================================================================
        ' Function  Name		:	WritePage()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Persists the state of the page 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder


        'Response.Write("<div id='divMain' style='OVERFLOW:auto;width:99.9%;valign:top;'>")
        Response.Write("<div id='divMain' style='width:99.9%;valign:top;'>")

        Response.Write("<div id='divTab' style='OVERFLOW:auto;width:99.9%;valign:top;'>")
        DrawTabGroups()
        Response.Write("</div>")
        'sbHTML.Append("<iframe name='frmMain' id='frmMain' onLoad='calcHeight()'  src='" + m_strDefaultPageURL + "' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>" + vbCrLf)
        '        Response.Write("<input type=hidden name='hidDefaultPageURL' id='hidDefaultPageURL' value='" + m_strDefaultPageURL + "'>")
        Response.Write("</div>")

        'If IsFirstHit Then
        '    Response.Write(sbHTML.ToString)
        'Else
        '    Response.Clear()
        'Response.Write(sbHTML.ToString)
        'Response.End()
        'End If

        sbHTML = Nothing

    End Sub
    Private Sub DrawTabGroups()
        '=====================================================================
        ' Function  Name		:	DrawTabGroups()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw the tab groups i.e. Tasks planning,Timesheet Entry etc.
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        Dim m_sBHTML As New StringBuilder
        Dim strDefaultGroupTabID As String = ""
        Dim strParentTagName As String = ""
        '--- Added By purvaj on 21 jul 09 SEM 8.1 New ui show module icons  in the left
        Dim strNavigationMenu As String = ""
        Dim objSystemModulesAry() As CommonEngines.HashTables.SystemModules
        Dim strImage As String = ""
        Dim intCount As Integer = 0
        Dim strColor As String = ""

        '-- End addition purvaj
        dblRatio = m_intRowCount / PAGE_SIZE

        Dim strIsCreatedByCustomer As String = "0"

        If CType(Session("IsCreatedByCustomer"), Boolean) Then
            strIsCreatedByCustomer = "1"
        Else
            strIsCreatedByCustomer = "0"
        End If
        Dim strStyleSheet As String = CommonFunction.Data.GetDataScalar("usp_get_StyleSheet " + HttpContext.Current.Session("intUserID").ToString + ",N'" + HttpContext.Current.Session("LoginType").ToString + "'," + strIsCreatedByCustomer, MyBase.UseSQL)

        If strStyleSheet = "StyleSheetChanakya.css" Then
            strColor = "MenuDefault.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_BrickRed.css" Then
            strColor = "Menured.gif"
            m_strModuleBarImage = "../../Images/Home/classicDownMove.GIF"
            m_strNavigationBarImage = "../../Images/Home/classicLeftMove.gif"

            m_strRModuleBarImage = "../../Images/Home/classicUpMove.GIF"
            m_strRNavigationBarImage = "../../Images/Home/classicRightMove.gif"

        ElseIf strStyleSheet = "StyleSheetChanakya_BurntSienna.css" Then
            strColor = "MenuBurntSienna.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_Green.css" Then
            strColor = "MenuGreen.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_Purple.css" Then
            strColor = "MenuPurple.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_GYellow.css" Then
            strColor = "MenuYellow.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_turquoise.css" Then
            strColor = "MenuTurquoise.gif"
        ElseIf strStyleSheet = "StyleSheetChanakya_black.css" Then
            strColor = "MenuGray.gif"
            m_strModuleBarImage = "../../Images/Home/classicDownMove.GIF"
            m_strNavigationBarImage = "../../Images/Home/classicLeftMove.gif"

            m_strRModuleBarImage = "../../Images/Home/classicUpMove.GIF"
            m_strRNavigationBarImage = "../../Images/Home/classicRightMove.gif"

        ElseIf strStyleSheet = "StyleSheetChanakya_white.css" Then
            strColor = "MenuClassic.gif"
        Else
            strColor = "MenuDefault.gif"
        End If

        'If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
        '    m_intPageNumber = 1
        'End If


        'm_sBHTML.Append("<TABLE cellSpacing=0 cellPadding=3 width='100%' align=center border=0 >")
        ''m_sBHTML.Append("<TABLE cellSpacing=0 cellPadding=0 width=99.99% height='99.99%' align=center class='clsTable' border='1' >") '' commented & added below by Puneet M on 23-06-2015
        ''Commented and added by Nilesh g on 20/11/2015
        ''  m_sBHTML.Append("<TABLE cellSpacing=0 cellPadding=0 width=99.99% height='99.99%' align=center class='clsTable' border='1' style=background-color:none; >")
        m_sBHTML.Append("<TABLE cellSpacing=0 cellPadding=0 width=100% height='99.99%' align=center class='clsTable' border='1' style='background-color:none; border:1px black;' >")
        m_sBHTML.Append("<TBODY>")
        m_sBHTML.Append("<tr>")
        ''style='BORDER-RIGHT: blue 1px outset; BORDER-TOP: blue 1px outset;BORDER-LEFT: blue 1px outset; BORDER-BOTTOM: blue 1px outset;'
        If m_strTemplateID.ToUpper <> "CRM" And m_strTemplateID.ToUpper <> "DB" Then
            ''Commented by Puneet M on 16thJUNE2015
            ''m_sBHTML.Append("<TD id='tdTree' name='tdTree'  style=""vertical-align:top;width:200px;""  nowrap  >") '
            m_sBHTML.Append("<TD id='tdTree' name='tdTree'  style=""vertical-align:top;width:200px;""  nowrap  >") '
        Else
            ''Commented by Puneet M on 16thJUNE2015
            ''m_sBHTML.Append("<TD id='tdTree' name='tdTree'  style=""vertical-align:top;width:150px;""  nowrap   >") '
            m_sBHTML.Append("<TD id='tdTree' name='tdTree'  style=""vertical-align:top;width:150px;""  nowrap   >") '
        End If

        ''Commented AND ADDED BY Puneet M on 16thJUNE2015
        ''m_sBHTML.Append("<TABLE cellSpacing=0 cellPadding=1 width='100%' height='100%' align=center class='clsTable' border='0'>")
        m_sBHTML.Append("<TABLE id=tblInnertdTree cellSpacing=0 cellPadding=1 width='100%' align=top class='clsTable' border='0'>")
        m_sBHTML.Append("<tr >")

        'Added by Dhanashri on 5 Mar 2015
        m_sBHTML.Append("<TD id='tdTree_Inner' class='tdTree_Inner_Height'>")
        'Ended by Dhanashri

        'If m_strTemplateID.ToUpper <> "CRM" And m_strTemplateID.ToUpper <> "DB" And m_strTemplateID.ToUpper <> "PRO" And m_strTemplateID.ToUpper <> "KM" Then
        '    If m_InsControlItemID <> "" Then
        '        m_sBHTML.Append("<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()'  style=""vertical-align:top;text-align:left;align:left;"" ><img id=imgFav border=0 src='../../Images/Home/favorites-.gif' title='Remove From favourites' /></a>")
        '    Else
        '        m_sBHTML.Append("<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()'  style=""vertical-align:top;text-align:left;align:left;"" ><img id=imgFav border=0 src='../../Images/Home/favorites+.gif' title='Add To favourites' /></a>")
        '    End If
        'End If
        Dim strDisplay As String = ""
        If m_strTemplateID.ToUpper = "CRM" Or m_strTemplateID.ToUpper = "DB" Or m_strTemplateID.ToUpper = "PRO" Or m_strTemplateID.ToUpper = "KM" Then
            strDisplay = "none"
        End If


        'Commented and added by bharat t on 6th-Oct-2015 for fav tabs
        'If m_InsControlItemID <> "" Then
        '    m_sBHTML.Append("<a id='aFav' class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()'  style=""vertical-align:top;text-align:left;align:left;display:" + strDisplay + ";"" ><img id='imgFav' border=0 src='../../Images/Home/favorites-.gif' title='Remove From Favorites' /></a>")
        'Else
        '    m_sBHTML.Append("<a id='aFav' class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()'  style=""vertical-align:top;text-align:left;align:left;display:" + strDisplay + ";"" ><img id=imgFav  border=0 src='../../Images/Home/fav+.gif' title='Add To Favorites' /></a>")
        'End If
        m_sBHTML.Append("<table class=clsTable border=0 3px; style='background-color:white;'>")
        m_sBHTML.Append("<tbody>")
        m_sBHTML.Append("<tr class=clsTRBody valign=middle>")
        m_sBHTML.Append("<td id=TdAll style='vertical-align: middle;'>")
        m_sBHTML.Append("<span id=selected>All</span>")
        m_sBHTML.Append("</td>")
        m_sBHTML.Append("<td id=TdFavourite style='vertical-align: middle;'>")
        m_sBHTML.Append("<a title=Favourite class=navtab href=javascript:Tree_Switch('Favourite')>Favourite</a></td>")
        m_sBHTML.Append("<td id=TDAddRemoveFavourite style=width: 99.99%; text-align: right;>")

        m_sBHTML.Append("</td>")

        'm_sBHTML.Append("<td id=TdFavouriteTree style='vertical-align: middle;width:101px;text-align: right'>")
        'If m_InsControlItemID <> "" Then
        '    m_sBHTML.Append("<a id='tFav' class='clsLinkChildNavMenu' href='javascript:addRemoveFavoritesFromTree()'  style=""vertical-align:top;text-align:left;align:left;display:" + strDisplay + ";"" ><img id='imgFavT' border=0 src='../../Images/Home/FavTreeMinus.gif' title='Remove From Fav Tree' /></a>")
        'Else
        '    m_sBHTML.Append("<a id='tFav' class='clsLinkChildNavMenu' href='javascript:addRemoveFavoritesFromTree()'  style=""vertical-align:top;text-align:left;align:left;display:" + strDisplay + ";"" ><img id=imgFavT  border=0 src='../../Images/Home/FavTreePlus.gif' title='Add To Fav Tree' /></a>")
        'End If
        'm_sBHTML.Append("<input type=hidden id=hdnTemplateTree  value=" & m_strTemplateID & ">")
        'm_sBHTML.Append("</td>")

        m_sBHTML.Append("<td id=TdFavourite style='vertical-align: middle;width:101px;text-align: right'>")
        If m_InsControlItemID <> "" Then
            m_sBHTML.Append("<a id='tFav' class='clsLinkChildNavMenu' href='javascript:addRemoveFavoritesFromTree()'  style=""vertical-align:top;text-align:left;align:left;display:" + strDisplay + ";"" ><img id='imgFavT' border=0 src='../../Images/Home/FavTreeMinus.gif' title='Remove From Fav Tree' /></a>&nbsp;&nbsp;")
            m_sBHTML.Append("<a id='aFav' class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()'  style=""vertical-align:top;text-align:left;align:left;display:" + strDisplay + ";"" ><img id='imgFav' border=0 src='../../Images/Home/favorites-.gif' title='Remove From Favorites' /></a>")
        Else
            m_sBHTML.Append("<a id='tFav' class='clsLinkChildNavMenu' href='javascript:addRemoveFavoritesFromTree()'  style=""vertical-align:top;text-align:left;align:left;display:" + strDisplay + ";"" ><img id=imgFavT  border=0 src='../../Images/Home/FavTreePlus.gif' title='Add To Fav Tree' /></a>&nbsp;&nbsp;")
            m_sBHTML.Append("<a id='aFav' class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()'  style=""vertical-align:top;text-align:left;align:left;display:" + strDisplay + ";"" ><img id=imgFav  border=0 src='../../Images/Home/favplus.gif' title='Add To Favorites' /></a>")

        End If
        m_sBHTML.Append("<input type=hidden id=hdnTemplateTree  value=" & m_strTemplateID & ">")
        m_sBHTML.Append("<input type=hidden id=hdnTemplate  value=" & m_strTemplateID & ">")

        m_sBHTML.Append("</td>")
        m_sBHTML.Append("</tr>")
        m_sBHTML.Append("</tbody>")
        m_sBHTML.Append("</table>")
        'End of Commented and added by bharat t on 6th-Oct-2015 for fav tabs

        '''''''''''''PrashantSJ on 25th May 2009

        m_sBHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a  id='hfView' href='#' onclick='javascript:ShowFloatingmenu(""Views"",event)'  style=""vertical-align:top;text-align:right;align:right;"" ><img id=imgView1 border=0 src='../../Images/Home/views.gif' title='Views' /></a>")



        '''''''''''''End of addition by PrashantSJ on 25th May 2009
        If CType(m_intUseNewUITree, Boolean) Then
            If m_strTemplateID.ToUpper <> "CRM" And m_strTemplateID.ToUpper <> "DB" Then

                'Commented and Added by Dhanashri S on 17 Mar 2015

                '    m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB' style=""width:150px;height:514px;background-color:White"">")
                'Else
                '    m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB' style=""width:200px;height:514px;background-color:White"">")

                '' Commented By Puneet M ON 16th June 2015
                ''m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB clsDivDB_Height' style=""width:150px;height:514px;background-color:White"">")
                m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB clsDivDB_Height' style=""width:150px;background-color:White"">")
            Else
                '' Commented By Puneet M ON 16th June 2015
                ''m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB clsDivDB_Height' style=""width:200px;height:514px;background-color:White"">")
                m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB clsDivDB_Height' style=""width:200px;background-color:White"">")
                'End of Comment and Addition

            End If
        Else
            'COMMTEND AND ADDED by PrashantSJ on 26th Aug 09

            'Commented and added by Dhanashri S on 17 Mar 2015
            'm_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB ' style=""width:200px;height:99.99%;background-color:White;;OVERFLOW:auto;"">")
            m_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB clsDivDB_Height' style=""width:200px;height:99.99%;background-color:White;;OVERFLOW:auto;"">")
            'End of Comment and Addition

            'm_sBHTML.Append("<div id='divTree' name='divTree' class='clsDivDB' style=""width:200px;height:99.99%;background-color:White;;OVERFLOW:auto;"">")
        End If




        m_sBHTML.Append("</div>")



        'Added By Amol Changle On: 07 May 2009
        If CType(m_intUseNewUITree, Boolean) Then

            m_sBHTML.Append("<span style=""text-align:left;width:49.99%;vertical-align:bottom""><A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()"" Title=""Previous Records"" onmouseover=""window.status='Previous Records';return true;"" onmouseout=""window.status=' ';return true;"">")
            m_sBHTML.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A></span>")

            m_sBHTML.Append("<span style=""text-align:right;width:49.99%;vertical-align:bottom""><A style='TEXT-DECORATION:NONE;text-align:right;vertical-align:bottom' HREF=""Javascript:ShowNextPage()"" Title=""Next Records"" onmouseover=""window.status='Next Records';return true;"" onmouseout=""window.status=' ';return true;"">")
            m_sBHTML.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A></span> ")

        End If
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'm_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 150, 4, "1", "right", , , , , True, , True))
        m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 150, 4, "1", "right", , , , , True, , True, EnableHTMLEncode:=True))

        m_sBHTML.Append("</td>")
        m_sBHTML.Append("</tr>")

        m_sBHTML.Append("<tr  >")
        ''m_sBHTML.Append("<td vAlign=top>")  '' COMMENTED BY PUNEET M on 23-06-2015
        m_sBHTML.Append("<td style=vertical-align:bottom;>")
        m_sBHTML.Append(GetModules())
        m_sBHTML.Append("</td>")
        m_sBHTML.Append("</tr>")



        m_sBHTML.Append("</table>")

        '--- Added By purvaj on 21 jul 09 SEM 8.1 New ui show module icons  in the left
        m_sBHTML.Append("</td>")
        m_sBHTML.Append("<td style='vertical-align:bottom;display:none;' id='tblLeftNavigation'  height='100%' >")
        If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
        Else
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules" + MyBase.CurrentThreadUICultureID.ToString)
            If objSystemModulesAry Is Nothing Then
                objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
            End If
        End If

        m_sBHTML.Append("<TABLE cellSpacing=0 cellPadding=0 width='100%' height='100%' align=center class='clsTable' border='0'>")
        ''Added and commented by PrashantSJ on 21st Aug 2009
        'm_sBHTML.Append("<tr valign=top style='text-align:center;background-attachment: fixed;background-image:url(""../../Images/Home/" + strColor.ToString + """) ;background-position:Left; '>")
        m_sBHTML.Append("<tr valign=top class='clsTRGroupHeader' style='text-align:center;'>")
        ''Added and commented by PrashantSJ on 21st Aug 2009

        m_sBHTML.Append("<td valign='middle' align=center style='border-bottom:1px solid gray;cursor:pointer;' onclick='javascript:HideTree()' text='Navigation Pane' class='clsMenu'> ")
        'm_sBHTML.Append("<A valign='middle' style='text-decoration:none;' Title='Navigation Pane' class='clsMenu' href='javascript:HideTree()'><img src='../../Images/Home/NavigationPane.gif' border=0></a>")
        m_sBHTML.Append("<img src='../../Images/Home/NavigationPane.gif' border=0>")
        m_sBHTML.Append("</td>")
        m_sBHTML.Append("</tr>")

        For intCount = 0 To objSystemModulesAry.Length - 1
            If Not objSystemModulesAry Is Nothing Then
                
                If Not objSystemModulesAry(intCount).HideModuleNameOnTab And (objSystemModulesAry(intCount).ShortName.ToUpper <> "BTS" And objSystemModulesAry(intCount).ShortName <> "DT" And objSystemModulesAry(intCount).ShortName <> "SU") Then
                    Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, objSystemModulesAry(intCount).ModuleTagID, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
                    'Create the object of GetAccess class
                    Dim objGetAccess As New WebPage.Templates.AccessRights
                    'Call method get access to get the access
                    objGetAccess.GetAccess(objGlobal, True)
                    If Not objGetAccess.Access Or (objSystemModulesAry(intCount).ShortName = "SM" And CType(Session("IsCreatedByCustomer"), Boolean) = True) Then
                        Continue For
                    End If
                    ''Commented and added by NitinC on 14 September for WhizibleSEM v10.0 (New Images)
                    ''Commented and added by NitinC on 14 September for WhizibleSEM v10.0 (New Images)

                    If objSystemModulesAry(intCount).ShortName.ToUpper = "PM" Then
                        strImage = "../../Images/dc.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SM" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "FA" Then
                        strImage = "../../Images/RDB_Outstanding2.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "RM" Then
                        strImage = "../../Images/cssImages/WF_UserStage_Old.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "MR" Then
                        strImage = "../../Images/cssImages/Link images/graph.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "PRO" Then
                        strImage = "../../Images/TimeSheet.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SU" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "CRM" Then
                        strImage = "../../Images/template.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "KM" Then
                        strImage = "../../Images/bs.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "DB" Then
                        strImage = "../../Images/Home/home.jpg"
                    End If

                    'If objSystemModulesAry(intCount).ShortName.ToUpper = "PM" Then
                    '    strImage = "../../Images/NewHomePage/images/project.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SM" Then
                    '    strImage = "../../Images/SM.jpg" ''
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "FA" Then
                    '    strImage = "../../Images/FA.jpg" ''
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "RM" Then
                    '    strImage = "../../Images/CSSImages/WF_UserStage_Last.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "MR" Then
                    '    strImage = "../../Images/NewHomePage/images/proprofit.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "PRO" Then
                    '    strImage = "../../Images/NewHomePage/images/process.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SU" Then
                    '    strImage = "../../Images/NewHomePage/config2.jpg"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "CRM" Then
                    '    strImage = "../../Images/NewHomePage/images/support.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "KM" Then
                    '    strImage = "../../Images/NewHomePage/images/knowledge.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "DB" Then
                    '    strImage = "../../Images/NewHomePage/images/home.gif"
                    'End If


                    ''End of Commented and added by NitinC on 14 September for WhizibleSEM v10.0 (New Images)

                    ''Added and commented by PrashantSJ on 21st Aug 2009
                    'm_sBHTML.Append("<tr class=clsTREven style='text-align:center;background-attachment: fixed;background-image:url(""../../Images/Home/" + strColor.ToString + """) ;background-position:Left;'>") 'class=clsTREven
                    m_sBHTML.Append("<tr valign='center' class='clsTRGroupHeader' style='text-align:center;background-attachment: fixed;'>")
                    ''Added and commented by PrashantSJ on 21st Aug 2009

                    m_sBHTML.Append("<td style='border-bottom:1px solid gray;width:15%;' >") '''''padding:2px 2px 2px 2px;
                    m_sBHTML.Append("<A valign='center' style='text-decoration:none;' onmouseover='this.style.backgroundColor=""#FFD695""' onmouseout='this.style.backgroundColor=""""' Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' class='clsMenu' href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'><img src='" + strImage + "' border=0 style=""vertical-align:top;align:left;""></a>")
                    m_sBHTML.Append("</td>")
                    m_sBHTML.Append("</tr>")
                End If
            End If
        Next

        m_sBHTML.Append("</table>")
        '-- End addition purvaj

        m_sBHTML.Append("</td>")
        'm_sBHTML.Append("<TD ID='tdDot1' name='tdDot1' vAlign=top width=1px   background='../../Images/Home/dot2.gif' onclick='javascript:ShowTree()'><a name='aShowTree' id='aShowTree' style=""text-decoration:none;"" href='javascript:HideTree()' ><img ID='ImgShowHide' src='../../Images/ScrollLeft.gif' border=0 /></a></TD>")
        ' m_sBHTML.Append("<TD ID='tdDot1' name='tdDot1' vAlign=top width=1px   onclick='javascript:ShowTree()'></TD>")
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''PrashantSJ on 30th june 2009

        m_sBHTML.Append("<TD ID='tdDot1' valign='middle' title='Show / Hide Tree' name='tdDot1' class='clsTDScroll' onclick='javascript:HideTree()' onmouseover='SetRollOverTD(this,event,1)' onmouseout='SetRollOverTD(this,event,2)' style='cursor:pointer;align:center;vAlign:center;vertical-align:middle' >")
        m_sBHTML.Append("<img ID='ImgShowHide' title='Show / Hide Tree' src='" + m_strNavigationBarImage + "' border=0 style=""vertical-align:middle;align:Left;padding-left:0px;padding-bottom:0px;padding-right:0px;padding-top:0px;""/>")
        m_sBHTML.Append("</TD>")

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        m_sBHTML.Append("<TD id='ifTD' vAlign=top width='100%'>")
        ''BORDER-RIGHT: blue 1px outset; BORDER-TOP: blue 1px outset;BORDER-LEFT: blue 1px outset; BORDER-BOTTOM: blue 1px outset;
        If m_strTemplateID.ToUpper <> "KM" Then
            'Commented by Kiran k k for loader  2/11/15
            'm_sBHTML.Append("<iframe name='frmMain'  id='frmMain'   src='' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>") 'onmouseover='HideFrame()''onLoad='calcHeight()'
            m_sBHTML.Append("<iframe name='frmMain'  id='frmMain' onload='setFrameLoaded();'  src='' scrolling='no' marginwidth='0' allowtransparency='false' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>") 'onmouseover='HideFrame()''onLoad='calcHeight()'
            'Commented end  by Kiran k k for loader  2/11/15
        Else
            'Commented by Kiran k k for loader  2/11/15
            'm_sBHTML.Append("<iframe name='frmMain'  id='frmMain'   src='' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>") 'onmouseover='HideFrame()''onLoad='calcHeight()'
            m_sBHTML.Append("<iframe name='frmMain'  onload='setFrameLoaded();' id='frmMain'   src='' scrolling='yes' marginwidth='0' allowtransparency='false' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>") 'onmouseover='HideFrame()''onLoad='calcHeight()'
            'Commented end  by Kiran k k for loader  2/11/15
        End If
        m_sBHTML.Append("</TD>")
        ''Added by Nilesh Gundecha for PLot Quic View 
        m_sBHTML.Append("<TD ID='tdDot2' valign='middle' title='Show/Hide Panel' name='tdDot2' class='clsTDScroll' style='display:none;border: 3px solid #e39321;align:top;vAlign:center;vertical-align:top;background:white' >")
        ''m_sBHTML.Append("<img ID='ImgShowHide1' title='Show / Hide Tree' src='" + m_strNavigationBarImage + "' border=0 style=""vertical-align:middle;align:Left;padding-left:0px;padding-bottom:0px;padding-right:0px;padding-top:0px;""/>")
        ''Commented And Added By Vaijat K ON 29/09/2016 For Dynamic Theme
        ''m_sBHTML.Append("<div id='divclose' style='padding-top:10px;padding-left:10px;background:#f6eee4;'><img id='imgExpandTab' src='../../Images/Home/leftarrow.png' alt='loading' onclick='f_imgExpand()' style='background-color: #e39321;cursor:pointer;' /><img id='imgclosetab' src='../../Images/Home/rightarrow.png' alt='loading' onclick='f_imgClose()' style='cursor:pointer;' /></div>")
        ''Added by Sanyogeeta R on 25 Nov 2016 For Display leftarrow.png and rigntarrow.png in Crome Browser
        m_sBHTML.Append("<div id='divclose' style='padding-top:10px;padding-left:10px;background:#f6eee4;'><img id='imgExpandTab' style='background-image:url(../../Images/Home/leftarrow.png);background-repeat: no-repeat;cursor:pointer;' onclick='f_imgExpand()' />&nbsp&nbsp<img id='imgclosetab' style='background-image:url(../../Images/Home/rightarrow.png);background-repeat: no-repeat;cursor:pointer;' onclick='f_imgClose()' /></div>") ''src='../../Images/Home/leftarrow.png' src='../../Images/Home/rightarrow.png'
        ''End Of Addition  by Sanyogeeta R on 25 Nov 2016 For Display leftarrow.png and rigntarrow.png in Crome Browser
        ''End of Addition By Vaijat K ON 29/09/2016 
        'Commented by Kiran k k for loader  2/11/15
        ' m_sBHTML.Append("<iframe name='frmView'  id='ViewMain'  align='top'   scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%; height: 300px' ></iframe>") 'onmouseover='HideFrame()''onLoad='calcHeight()'
        m_sBHTML.Append("<iframe name='frmView' onload='setFrameLoaded();' id='ViewMain'  align='top'   scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%; height: 96%' ></iframe>") 'onmouseover='HideFrame()''onLoad='calcHeight()'
        'Commented end  by Kiran k k for loader  2/11/15
        m_sBHTML.Append("</TD>")

        ''Ended by Nilesh Gundecha for PLot Quic View 
        m_sBHTML.Append("</TR></TBODY></TABLE>")


        'm_sBHTML.Append("<input type=hidden name='hidDefaultPageURL' id='hidDefaultPageURL' value='" + m_strDefaultPageURL + "'>")
        'm_sBHTML.Append("<input type=hidden name='hidDefaultTagID' id='hidDefaultTagID' value='" + m_strDefaultTagID + "'>")
        ' m_sBHTML.Append("<input type=hidden name='hidDefaultControlItemID' id='hidDefaultControlItemID' value='" + m_strControlItemID + "'>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'm_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultPageURL", "hidDefaultPageURL", , , , m_strDefaultPageURL, returnHTML:=True, DisplayNone:=True))
        'm_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultTagID", "hidDefaultTagID", , , , m_strDefaultTagID, returnHTML:=True, DisplayNone:=True))
        'm_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultControlItemID", "hidDefaultControlItemID", , , , m_strControlItemID, returnHTML:=True, DisplayNone:=True))
        m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultPageURL", "hidDefaultPageURL", , , , m_strDefaultPageURL, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
        m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultTagID", "hidDefaultTagID", , , , m_strDefaultTagID, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
        m_sBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidDefaultControlItemID", "hidDefaultControlItemID", , , , m_strControlItemID, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))

        If m_strIsXMLHTTP = "1" Then
            Response.Clear()
            Response.Write(m_sBHTML.ToString)
            Response.End()
        Else
            Response.Write(m_sBHTML.ToString)
        End If

        m_sBHTML = Nothing
    End Sub
    Private Function DrawHelpDeskItems() As String
        '=====================================================================
        ' Function  Name		:	DrawHelpDeskItems()
        ' Parameters Passed		:	TagID
        ' Returns				:	To return helpdesk modes
        ' Parameters Affected	:	None
        ' Purpose				:	To return helpdesk modes
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	June 30 2009
        ' Revisions				:	
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Call CommonFunction.General.GetWorkflowStatus()
        Dim strIsActive As Boolean = CommonFunction.Application.IsActive

        '''strHTML.Append("<script language=javascript>")
        '''strHTML.Append("var Tree = new Array;")
        '''strHTML.Append("Tree[0]=""1|0|HelpDesk|HelpDesk|1|page.gif|1"";")
        '''strHTML.Append("Tree[1]=""2|1|My e-dashboard|../CRM/CRM_MyDashboard.aspx?Mode=MD|2|page.gif|1"";")
        '''strHTML.Append("Tree[2]=""3|2|Request Approvals|../CRM/CRM_LineManagerApprovals.aspx|3|page.gif|0"";")
        '''strHTML.Append("Tree[3]=""4|2|Workflow Approvals|../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035|4|page.gif|0"";")
        '''strHTML.Append("Tree[4]=""5|1|e-dashboard|../CRM/CRM_Dashboard.aspx?Mode=DB|5|page.gif|1"";")
        '''strHTML.Append("Tree[5]=""6|5|Helpdesk Analysis|../Home/DetailView.aspx?MenuGroupID=16|6|page.gif|0"";")
        '''strHTML.Append("Tree[6]=""7|5|Request Approvals|../CRM/CRM_LineManagerApprovals.aspx|7|page.gif|0"";")
        '''strHTML.Append("Tree[7]=""8|5|WorkflowApprovals|../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035|8|page.gif|0"";")
        '''strHTML.Append("Tree[8]=""9|5|Show SLA|.../CRM/CRM_SLA.aspx?Mode=DB&FilterID=|9|page.gif|0"";")
        '''strHTML.Append("createSearchTree(Tree);")
        '''strHTML.Append("</script>")

        '''DrawHelpDeskItems = strHTML.ToString
        strHTML = Nothing

        '''strHTML.Append("<ul>")
        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_MyDashboard.aspx?Mode=MD"",0,0,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>My e-Dashboard</b></a>")

        '''strHTML.Append("<ul id='ul_Myedashboard' style='display:none;list-style-position:outside;'>")
        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_LineManagerApprovals.aspx"",0,1,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Request Approvals</b></a>")
        '''strHTML.Append("</li>")
        '''If strIsActive = True Then
        '''    strHTML.Append("<li id='tabItem_li'>")
        '''    strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035"",0,2,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Workflow Approvals</b></a>")
        '''    strHTML.Append("</li>")
        '''End If
        '''strHTML.Append("</ul>")

        '''strHTML.Append("</li>")

        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_Dashboard.aspx?Mode=DB"",0,3,event)' title='e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>e-Dashboard</b></a>")

        '''strHTML.Append("<ul id='ul_edashboard' style='display:none;list-style-position:outside;'>")
        '''If strIsActive = True Then
        '''    strHTML.Append("<li id='tabItem_li'>")
        '''    strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../Home/DetailView.aspx?MenuGroupID=16"",0,4,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Helpdesk Analysis</b></a>")
        '''    strHTML.Append("</li>")
        '''Else
        '''    strHTML.Append("<li id='tabItem_li'>")
        '''    strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../Home/DetailView.aspx?MenuGroupID=16"",0,4,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Show Helpdesk Graph</b></a>")
        '''    strHTML.Append("</li>")
        '''End If

        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_LineManagerApprovals.aspx"",0,5,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Request Approvals</b></a>")
        '''strHTML.Append("</li>")

        '''If strIsActive = True Then
        '''    strHTML.Append("<li id='tabItem_li'>")
        '''    strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035"",0,6,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Workflow Approvals</b></a>")
        '''    strHTML.Append("</li>")
        '''End If

        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_SLA.aspx?Mode=DB&FilterID="",0,7,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Show SLA</b></a>")
        '''strHTML.Append("</li>")
        '''strHTML.Append("</ul>")

        '''strHTML.Append("</li>")

        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_RequestList.aspx?Mode=SR"",0,8,event)' title='My Requests' style='color:blue;curosr:hand;text-decoration:underline;'><b>My Requests</b></a>")

        '''strHTML.Append("<ul id='ul_MyRequests' style='display:none;list-style-position:outside;'>")
        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_LineManagerApprovals.aspx"",0,9,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Request Approvals</b></a>")
        '''strHTML.Append("</li>")

        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_SLA.aspx?Mode=DB&FilterID="",0,10,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Show SLA</b></a>")
        '''strHTML.Append("</li>")
        '''strHTML.Append("</ul>")

        '''strHTML.Append("</li>")

        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_RequestList.aspx?Mode=AR"",0,11,event)' title='Inbox' style='color:blue;curosr:hand;text-decoration:underline;'><b>Inbox</b></a>")

        '''strHTML.Append("<ul id='ul_Inbox' style='display:none;list-style-position:outside;'>")
        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_LineManagerApprovals.aspx"",0,12,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Request Approvals</b></a>")
        '''strHTML.Append("</li>")

        '''strHTML.Append("<li id='tabItem_li'>")
        '''strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../CRM/CRM_SLA.aspx?Mode=DB&FilterID="",0,13,event)' title='My e-Dashboard' style='color:blue;curosr:hand;text-decoration:underline;'><b>Show SLA</b></a>")
        '''strHTML.Append("</li>")

        '''strHTML.Append("</ul>")

        '''strHTML.Append("</li>")

        '''strHTML.Append("</ul>")


    End Function
    Private Function DrawHomeItems() As String
        '=====================================================================
        ' Function  Name		:	DrawHomeItems()
        ' Parameters Passed		:	TagID
        ' Returns				:	To return Home modes
        ' Parameters Affected	:	None
        ' Purpose				:	To return helpdesk modes
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	June 30 2009
        ' Revisions				:	
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<ul>")
        strHTML.Append("<li id='tabItem_li'>")
        strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../General/CommonPage.aspx?MasterTagID=1085&ParentTagID=0"",1085,0,event)' title='My Profile' style='color:blue;curosr:hand;text-decoration:underline;'><b>My Profile</b></a>")
        strHTML.Append("</li>")

        strHTML.Append("<li id='tabItem_li'>")
        strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../Home/MyHome_TabUI.aspx?ShortName=TabUI&FromWhere=TABUI"",0,1,event)' title='My Home' style='color:blue;curosr:hand;text-decoration:underline;'><b>My Home</b></a>")
        strHTML.Append("</li>")

        strHTML.Append("<li id='tabItem_li'>")
        strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../DB/Alerts_CommonList.aspx?MasterTagID=3707&ParentTagID=0"",3707,2,event)' title='My Alerts' style='color:blue;curosr:hand;text-decoration:underline;'><b>My Alerts</b></a>")
        strHTML.Append("</li>")

        strHTML.Append("<li id='tabItem_li'>")
        strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../HR/MyLeaves_CommonList.aspx?MasterTagID=1208"",1208,3,event)' title='My Leaves' style='color:blue;curosr:hand;text-decoration:underline;'><b>My Leaves</b></a>")
        strHTML.Append("</li>")

        ''Added by Dhanashri S
        strHTML.Append("<li id='tabItem_li'>")
        strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../PM/MyApproval_Home.aspx?MasterTagID=22179"",22179,4,event)' title='My Pending Approval' style='color:blue;curosr:hand;text-decoration:underline;'><b>My Pending Approval</b></a>")
        strHTML.Append("</li>")
        ''Added by Dhanashri S

        strHTML.Append("<li id='tabItem_li'>")
        strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../Home/MyExpenses.aspx?ShortName=TabUI&FromWhere=TABUI"",0,4,event)' title='My Expenses' style='color:blue;curosr:hand;text-decoration:underline;'><b>My Expenses</b></a>")

        '--- Added By purvaj on 9 Jul 2009
        strHTML.Append("<ul id='ul_Expenses' name='ul_Expenses' style='display:none;list-style-position:outside;'>")
        If GetTagAccessRights(3556) = True Then
            strHTML.Append("<li id='tabItem_li'>")
            strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../EWF/EWF_ExpenseEntryList.aspx?FromWhere=DT&MasterTagId=3556"",0,5,event)' title='Expense Entry' style='color:blue;curosr:hand;text-decoration:underline;'><b>Expense Entry</b></a>")
            strHTML.Append("</li>")
        End If
        If GetTagAccessRights(3593) = True Then
            strHTML.Append("<li id='tabItem_li'>")
            strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../EWF/MyExpenseSheet_CommonList.aspx?FromWhere=DT&MasterTagId=3593"",0,6,event)' title='My Expense Sheet' style='color:blue;curosr:hand;text-decoration:underline;'><b>My Expense Sheet</b></a>")
            strHTML.Append("</li>")
        End If
        If GetTagAccessRights(3595) = True Then
            strHTML.Append("<li id='tabItem_li'>")
            strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../EWF/ExpenseSheetApproval_CommonList.aspx?FromWhere=DT&MasterTagId=3595"",0,7,event)' title='Expense Sheet Approval' style='color:blue;curosr:hand;text-decoration:underline;'><b>Expense Sheet Approval</b></a>")
            strHTML.Append("</li>")
        End If
        If GetTagAccessRights(3596) = True Then
            strHTML.Append("<li id='tabItem_li'>")
            strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../EWF/EscalatedExpenseSheets_CommonList.aspx?FromWhere=DT&MasterTagId=3596"",0,8,event)' title='Escalated Expense Sheets' style='color:blue;curosr:hand;text-decoration:underline;'><b>Escalated Expense Sheets</b></a>")
            strHTML.Append("</li>")
        End If
        If GetTagAccessRights(3597) = True Then
            strHTML.Append("<li id='tabItem_li'>")
            strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../EWF/FinanceApproval_CommonList.aspx?FromWhere=DT&MasterTagId=3597"",0,9,event)' title='Finance Approval' style='color:blue;curosr:hand;text-decoration:underline;'><b>Finance Approval</b></a>")
            strHTML.Append("</li>")
        End If
        If GetTagAccessRights(3598) = True Then
            strHTML.Append("<li id='tabItem_li'>")
            strHTML.Append("<a id='tabItem_A' onclick='javascript:TabItemOnClick(""../EWF/ExpenseBifurcation_CommonList.aspx?FromWhere=DT&MasterTagId=3598"",0,10,event)' title='Expense Bifurcation' style='color:blue;curosr:hand;text-decoration:underline;'><b>Expense Bifurcation</b></a>")
            strHTML.Append("</li>")
        End If
        strHTML.Append("</ul>")
        '--- End addition purvaj

        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        DrawHomeItems = strHTML.ToString
        strHTML = Nothing
    End Function
    Private Function GetModules() As String
        '=====================================================================
        ' Function  Name		:	GetModules()
        ' Parameters Passed		:	TagID
        ' Returns				:	To return system modules 
        ' Parameters Affected	:	None
        ' Purpose				:	To return system modules 
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	June 26 2009
        ' Revisions				:	
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim intCount As Integer = 0
        Dim strImage As String = ""
        Dim strModuleList As String = ""
        '--- Added By purvaj on 21 jul 09 SEM 8.1 New ui show module icons  in the left
        Dim strNavigationMenu As String = ""
        
        Dim objSystemModulesAry() As CommonEngines.HashTables.SystemModules

        If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
        Else
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules" + MyBase.CurrentThreadUICultureID.ToString)
            If objSystemModulesAry Is Nothing Then
                objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
            End If
        End If

        If Not objSystemModulesAry Is Nothing Then
            strHTML.Append("<div id='trGM' name='trGM' >")
            strHTML.Append("<Table border=0 cellspacing=0 cellpadding=0 width='99.9%' class='clsTable' valign='bottom'>")
            strHTML.Append("<TR  >")
            strHTML.Append("<Td  style='height:3%;' class='clsTDScroll' align='center' colspan='2' title='Enlarge/Shrink module bar' onclick='javascript:ShowHideModules(this)' style='cursor:pointer;' onmouseover='SetRollOverTD(this,event,1)' onmouseout='SetRollOverTD(this,event,2)'>")
            strHTML.Append("<font color='white'>...</font><img id='imgUpDown' alt='Enlarge/Shrink module bar' src='" + m_strModuleBarImage + "' border=0 style=""vertical-align:middle;align:center;"" /><font color='white'>...</font>")
            strHTML.Append("</Td>")
            strHTML.Append("</TR>")
            strHTML.Append("<TR  id='trModuleBar' name='trModuleBar' class='clsTRMenu' style='display:none;'>")

            strHTML.Append("<Td id='tdModuleBar' align='center' colspan='2' >")
            strHTML.Append("</Td>")
            strHTML.Append("</TR>")


            For intCount = 0 To objSystemModulesAry.Length - 1
                ''And GetTagAccessRights(objSystemModulesAry(intCount).ModuleTagID, True)
                If Not objSystemModulesAry(intCount).HideModuleNameOnTab And (objSystemModulesAry(intCount).ShortName.ToUpper <> "BTS" And objSystemModulesAry(intCount).ShortName <> "DT" And objSystemModulesAry(intCount).ShortName <> "SU") Then
                    Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, objSystemModulesAry(intCount).ModuleTagID, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
                    'Create the object of GetAccess class
                    Dim objGetAccess As New WebPage.Templates.AccessRights
                    'Call method get access to get the access
                    objGetAccess.GetAccess(objGlobal, True)

                    If Not objGetAccess.Access Or (objSystemModulesAry(intCount).ShortName = "SM" And CType(Session("IsCreatedByCustomer"), Boolean) = True) Then
                        Continue For
                    End If

                    ''Commented and added by NitinC on 14 September for WhizibleSEM v10.0 (New Images)

                    If objSystemModulesAry(intCount).ShortName.ToUpper = "PM" Then
                        strImage = "../../Images/dc.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SM" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "FA" Then
                        strImage = "../../Images/RDB_Outstanding2.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "RM" Then
                        strImage = "../../Images/cssImages/WF_UserStage_Old.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "MR" Then
                        strImage = "../../Images/cssImages/Link images/graph.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "PRO" Then
                        strImage = "../../Images/TimeSheet.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SU" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "CRM" Then
                        strImage = "../../Images/template.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "KM" Then
                        strImage = "../../Images/bs.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "DB" Then
                        strImage = "../../Images/Home/home.jpg"
                    End If

                    'If objSystemModulesAry(intCount).ShortName.ToUpper = "PM" Then
                    '    strImage = "../../Images/NewHomePage/images/project.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SM" Then
                    '    strImage = "../../Images/SM.jpg" ''
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "FA" Then
                    '    strImage = "../../Images/FA.jpg" ''
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "RM" Then
                    '    strImage = "../../Images/CSSImages/WF_UserStage_Last.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "MR" Then
                    '    strImage = "../../Images/NewHomePage/images/proprofit.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "PRO" Then
                    '    strImage = "../../Images/NewHomePage/images/process.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SU" Then
                    '    strImage = "../../Images/NewHomePage/config2.jpg"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "CRM" Then
                    '    strImage = "../../Images/NewHomePage/images/support.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "KM" Then
                    '    strImage = "../../Images/NewHomePage/images/knowledge.gif"
                    'ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "DB" Then
                    '    strImage = "../../Images/NewHomePage/images/home.gif"
                    'End If


                    ''End of Commented and added by NitinC on 14 September for WhizibleSEM v10.0 (New Images)
                    strModuleList += "<A style='text-decoration:none;' Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' onmouseover='this.style.backgroundColor=""#FFD695""' onmouseout='this.style.backgroundColor=""""' class='clsMenu' href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'><img src='" + strImage + "' border=0 style=""vertical-align:bottom;align:left;""></a>" + "&nbsp;" '&nbsp;"
                    If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                        strHTML.Append("<TR class='clsTRMenuMouseOver' id='trModules' name='trModules' style='cursor:pointer;text-align:left;'  onclick='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'>") 'onmouseover=javascript:ModulesOnMouseOver(this)' onmouseout='javascript:ModulesOnMouseOut(this);'
                    Else
                        strHTML.Append("<TR class='clsTRMenu' id='trModules' name='trModules' style='cursor:pointer;text-align:left;' onclick='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'  onmouseover='javascript:ModulesOnMouseOver(this)' onmouseout='javascript:ModulesOnMouseOut(this)'>") 'onmouseover=javascript:ModulesOnMouseOver(this)' onmouseout='javascript:ModulesOnMouseOut(this);'
                    End If

                    strHTML.Append("<Td align='left' style='height:15%;'>")
                    strHTML.Append("<img src='" + strImage + "' border=0 style=""vertical-align:bottom;align:left;"">")
                    strHTML.Append("</Td>")

                    strHTML.Append("<Td align='left'  style='cursor:pointer;text-align:left;height:15%;' id='iMenu'>")
                    'strHTML.Append("<A class='Menu' style='TEXT-DECORATION:NONE' onmouseover='this.style.backgroundColor='#FFD695'' onmouseout='this.style.backgroundColor='''  Title='Configuration' >")



                    strHTML.Append("<A style='text-decoration:none;width:170px;' class='clsMenu'")
                    ''''If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                    ''''    ''strHTML.Append(" class='cSelected' ")
                    ''''    ''strHTML.Append(" class='cSelected' ") ''clsLinkSelectedNavMenu

                    ''''Else
                    ''''    strHTML.Append(" class='clsMenu' ")
                    ''''End If


                    strHTML.Append(" Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' ")
                    strHTML.Append(" href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'>")

                    'strHTML.Append("<b>")
                    ''Tahoma
                    '''If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                    '''    strHTML.Append("<i>")
                    '''    strHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ModuleName)))
                    '''    strHTML.Append("</i>")
                    '''Else
                    strHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ModuleName)))
                    '''End If
                    'strHTML.Append("</b>")

                    'strHTML.Append("</A>")
                    strHTML.Append("</A>")
                    strHTML.Append("</Td>")
                    strHTML.Append("</TR>")

                    objGlobal = Nothing
                    objGetAccess = Nothing

                End If
            Next

            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidTxtModules", "hidTxtModules", , , , strModuleList, , , , , , True, , True))

            strHTML.Append("</Table>")
            strHTML.Append("</div>")
        End If
        GetModules = strHTML.ToString
        objSystemModulesAry = Nothing
        strHTML = Nothing
    End Function
    Private Function GetTagAccessRights(ByVal lngTagID As Long, Optional ByVal IsModuleAccess As Boolean = True) As Boolean
        '=====================================================================
        ' Function  Name		:	GetTagAccessRights()
        ' Parameters Passed		:	TagID
        ' Returns				:	boolean value whether tag is accessable or not
        ' Parameters Affected	:	None
        ' Purpose				:	To verify whether tag is accessable or not
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, lngTagID, m_lngPostID, CType(Session("intUserID"), Integer), Session("LoginType").ToString)
        'Create the object of GetAccess class
        Dim objGetAccess As New WebPage.Templates.AccessRights
        'Call method get access to get the access

        Dim IsAccessForNode As Boolean

        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            ' m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            objGetAccess.GetAccess(objGlobal, IsModuleAccess)

            If IsModuleAccess Then
                Return objGetAccess.Access()
            End If

            If objGetAccess.Add = True OrElse objGetAccess.Delete = True OrElse objGetAccess.Edit = True OrElse objGetAccess.View Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        Return IsAccessForNode

    End Function
    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : July 29, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()
    End Sub
    Public Sub AddRemoveFavourites()
        'm_InsControlItemID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_INS_UPD_ControlMenuItem_Favorites " + m_strFavTagID + "," + m_GlobalObject.UserID.ToString + ",'" + m_strMode.ToString + "'", True)), String)
        'Commented and Added By Bharat Tekade on 1st-Oct-2016
        If Not m_strMode = "DT" And Not m_strMode = "AT" Then
            m_InsControlItemID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_INS_UPD_ControlMenuItem_Favorites " + m_strFavTagID + "," + m_GlobalObject.UserID.ToString + ",'" + m_strMode.ToString + "'", True)), String)
        Else
            m_InsControlItemID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_INS_UPD_tbl_SEM_ControlItems_FavouritesTreeNode " + m_strFavTagID + "," + m_GlobalObject.UserID.ToString + ",'" + m_strMode.ToString + "'", True)), String)
        End If
        'End of Commented and Added By Bharat Tekade on 1st-Oct-2016

    End Sub

    'Private Sub DrawProjectSelectionDiv()
    '    '=====================================================================
    '    ' Procedure Name        : DrawProjectSelectionGrid()	
    '    ' Purpose               : Procedure to draw project selection Div
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : None
    '    ' Parameters Affected   : None
    '    ' Assumptions           : None
    '    ' Dependencies          : None
    '    ' Author                : Amol Changle
    '    ' Created               : 17 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder
    '    Dim strSQL As New StringBuilder
    '    Dim drProject As IDataReader

    '    strSQL.Append("usp_Sel_AccessibleProjectLists_Home ")
    '    strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString())
    '    strSQL.Append(",'")
    '    strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "E").ToString())
    '    strSQL.Append("',")
    '    strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intRoleLevel"), "0").ToString())
    '    strSQL.Append(",1,NULL,")
    '    strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString())

    '    drProject = CommonFunctions.Data.GetDataReader(strSQL.ToString(), True)

    '    strHTML.Append("<div id='PopUp' style='height:400;position:absolute;z-index:1000;width:65%;left:20;top:30;BORDER: black 3px solid; BACKGROUND-COLOR: #ffffff;display:none;' class ='clsDivPopup'>")
    '    strHTML.Append(GenerateMenu())
    '    strHTML.Append("<div id='InnerPopUp' style='height:93%;width:99%;overflow:auto;position:absolute;' >")

    '    While drProject.Read()
    '        strHTML.Append("<span style='BORDER: #317082 2px solid; BACKGROUND-COLOR: #ffffff;width:100%;' onclick=""javascript:SelectProject(" + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString() + ")"">")
    '        strHTML.Append("<table border=0 cellspacing=0 cellpadding=0 class='clsTable' width=100%>")
    '        strHTML.Append("<tr>")
    '        strHTML.Append("<td align=right>")
    '        strHTML.Append("<b>Project Code: </b>&nbsp;")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=left>")
    '        strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectCode")))
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=right>")
    '        strHTML.Append("<b>Project Name: </b>&nbsp;")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=left>")
    '        strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName")))
    '        strHTML.Append("</td>")
    '        strHTML.Append("</tr>")
    '        strHTML.Append("<tr>")
    '        strHTML.Append("<td align=right>")
    '        strHTML.Append("<b>Start Date: </b>&nbsp;")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=left>")
    '        If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedStartDate")).ToString() = "" Then
    '            strHTML.Append("&nbsp;")
    '        Else
    '            strHTML.Append(CommonFunctions.Dates.CGetDate(drProject("ExpectedStartDate")))
    '        End If
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=right>")
    '        strHTML.Append("<b>End Date: </b>&nbsp;")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<td align=left>")
    '        If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedEndDate")).ToString() = "" Then
    '            strHTML.Append("&nbsp;")
    '        Else
    '            strHTML.Append(CommonFunctions.Dates.CGetDate(drProject("ExpectedEndDate")))
    '        End If
    '        strHTML.Append("</td>")
    '        strHTML.Append("</tr>")
    '        strHTML.Append("</table>")
    '        strHTML.Append("</span>")
    '    End While

    '    strHTML.Append("</div></div>")

    '    CommonFunctions.General.WriteHTML(strHTML.ToString())

    '    strSQL = Nothing
    '    strHTML = Nothing
    '    CommonFunctions.Data.DisposeDataReader(drProject)
    'End Sub

    'Private Sub PerformAction()
    '    '=====================================================================
    '    ' Procedure Name        : PerformAction()	
    '    ' Purpose               : Procedure to perform actions
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : None
    '    ' Parameters Affected   : None
    '    ' Assumptions           : None
    '    ' Dependencies          : None
    '    ' Author                : Amol Changle
    '    ' Created               : 17 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================



    '    Select Case m_strAction.ToLower()

    '        Case "selectproject"
    '            Dim strProjectID As String = ""
    '            Dim strProjectName As String = ""

    '            strProjectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")).ToString()

    '            If strProjectID <> "" Then
    '                Session("intProjectID") = strProjectID
    '                strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectName FROM tbl_PM_Project WITH (NOLOCK) WHERE ProjectID = " + strProjectID, True), "0"), String)
    '                Session("strProjectName") = strProjectName
    '                Session("intPostID") = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_EmployeeRoleOnProject " + CType(HttpContext.Current.Session("intUserID"), String) + "," + strProjectID + "," + CType(Context.Session("LoginType"), String), True), "0"), String)
    '            End If

    '            Dim strScript As New System.Text.StringBuilder
    '            strScript.Append("<Script language=javascript>" + vbCrLf)
    '            strScript.Append("window.parent.frames(0).location.href=window.parent.frames(0).location.href;" + vbCrLf)
    '            strScript.Append("</Script>" + vbCrLf)
    '            HttpContext.Current.Response.Write(strScript.ToString)
    '    End Select

    'End Sub

    'Private Function GenerateMenu() As String
    '    '=====================================================================
    '    ' function Name         : GenerateTopMenu()	
    '    ' Purpose               : To generate top and bottom menu
    '    ' Description           : same as above
    '    ' Parameters Passed     : none
    '    ' Returns               : none
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 9:57 AM 9/17/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim ArrTopMenuCaptionsList As New ArrayList
    '    Dim ArrTopMenuToolTipsList As New ArrayList
    '    Dim ArrTopMenuFunctionsList As New ArrayList

    '    ArrTopMenuCaptionsList.Add("<img src='../../Images/cssImages/Link Images/Close.gif'> Close")
    '    ArrTopMenuToolTipsList.Add("Close")
    '    ArrTopMenuFunctionsList.Add("CloseDiv_OnClick()")


    '    Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
    '    ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
    '    ArrTopMenuCaptionsList = Nothing

    '    Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
    '    ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
    '    ArrTopMenuToolTipsList = Nothing

    '    Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
    '    ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
    '    ArrTopMenuFunctionsList = Nothing
    '    Return m_objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
    'End Function
End Class