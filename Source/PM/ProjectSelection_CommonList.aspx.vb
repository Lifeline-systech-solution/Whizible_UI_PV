Imports CommonEngines.General.cEventHandlers
Public Class ProjectSelection_CommonList
    Inherits CommonList

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Public WithEvents m_GenerateTree As New CommonFunctions.GenerateTree
    'Public Shared m_NavHashTable As Hashtable
    Public strMainPage As String
    'Protected strProjectID As String
    Public Shared strAction As String = ""
    Private strFromHome As String = ""

    Private strFavouriteProjectIDs As String = ""

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim strProjectID As String
        Dim strProjectName As String
        Dim strHashtableKey As String
        Dim strPath As String = System.AppDomain.CurrentDomain.BaseDirectory
        Dim strFromWhere As String

        'Added by ShraddhaM for Whiziblesem8.0 on 10,Feb 2009
        'Purpose : For Add Favourites functionality
        strAction = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"))

        If strAction Is Nothing Then
            strAction = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("Action"))
        End If
        'Ended by ShraddhaM
        strPath = strPath.Replace("/", "\")
        strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        strFromWhere = HttpContext.Current.Request.QueryString("FromWhere")
        strProjectName = HttpContext.Current.Request.QueryString("ProjectName")

        'If CType(HttpContext.Current.Session("intUserID"), String) <> "" And strProjectID <> "" Then
        '    Session("intPostID") = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_EmployeeRoleOnProject " + CType(HttpContext.Current.Session("intUserID"), String) + "," + strProjectID, True), "0"), String)
        'End If

        If strProjectID <> "" And strAction.ToLower() = "selectproject" Then
            Session("intProjectID") = strProjectID
            'Commented and Added by Chakshuta H on 8th-Aug-2016 
            'strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectName FROM tbl_PM_Project WITH (NOLOCK) WHERE ProjectID = " + strProjectID, True), "0"), String)
            strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectID " + strProjectID, True), "0"), String)
            'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 

            Session("strProjectName") = strProjectName
            Session("intPostID") = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_EmployeeRoleOnProject " + CType(HttpContext.Current.Session("intUserID"), String) + "," + strProjectID + "," + CType(Context.Session("LoginType"), String), True), "0"), String)
            strHashtableKey = "PM-" & strProjectID & "-" & CType(Context.Session("intUserId"), String) & "-" & CType(Context.Session("intPostID"), String) & "-" & CType(Context.Session("LoginType"), String)
            If CommonEngines.HashTables.GetHashTableObject.IsUserTreeKeyExists(strHashtableKey) = False Then
                CommonEngines.HashTables.CreateHashTables.AddUserTreeKey(strHashtableKey)
                Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
            Else
                If CommonFunctions.FileDirectory.IsFileExists(strPath + "Reports\" & strHashtableKey & ".html") = False Then
                    Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
                End If
            End If
            If strMainPage = "" Then strMainPage = "../../Reports/" & strHashtableKey & ".html"
            'm_NavHashTable = New Hashtable
            'm_NavHashTable.Add("NAVIGATION", sender)
        End If

        'Added By Amol Changle On: 18 Mar 2009
        'Purpose: To Perform Actions
        Call PerformActions(strAction, strProjectID)

        'End Addition

        strFavouriteProjectIDs = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_ProjectFavourites " + CType(HttpContext.Current.Session("intUserID"), String), True), "0"), String)

        MyBase.strListPage = "ProjectSelection_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"

        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Private Sub PerformActions(ByVal strAction As String, ByVal strProjectID As String)
        Dim strQuery As String

        Select Case strAction.ToLower()
            Case "addtofavourites"
                strQuery = "usp_INS_tbl_PM_ProjectFavourites_Individual " + Session("intUserID").ToString() + ",'" + Session("LoginType").ToString + "','" + strProjectID + "','ADDFAV'"
                CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case "removefromfavourites"
                strQuery = "usp_INS_tbl_PM_ProjectFavourites_Individual " + Session("intUserID").ToString() + ",'" + Session("LoginType").ToString + "','" + strProjectID + "','REMFAV'"
                CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End Select
    End Sub

    'Private Sub m_GenerateTree_Initialize_Menu(ByRef Cancel As Boolean, ByRef Args As CommonFunctions.GenerateTree.WAF_HTMLMenu) Handles m_GenerateTree.Initialize_Menu
    '    Call CommonEngine.General.CLCP_Events_Navigation.Initialize_Menu_DefaultNavigation(Cancel, Args)
    'End Sub

    'Private Sub m_GenerateTree_Before_NodeAdd(ByRef Cancel As Boolean, ByRef Args As CommonFunctions.GenerateTree.WAF_HTMLMenuItem) Handles m_GenerateTree.Before_NodeAdd
    '    Call CommonEngine.General.CLCP_Events_Navigation.Before_NodeAdd_DefaultNavigation(Cancel, Args)
    'End Sub


    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New ProjectSelection_CommonListCLSQL(MyBase.m_objGlobal, strFavouriteProjectIDs)
    End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New ProjectSelection_CommonListPlotGrid(MyBase.m_objGlobal, strFavouriteProjectIDs)
    End Function

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New ProjectSelection_CommonListDynamicFilters(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

        'Added By Amol Changle On: 18 Mar 2009
        'Purpose: To refresh Home Page
        strFromHome = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromHome"))
        If strFromHome = "" Then
            strFromHome = CommonFunctions.General.CheckIsNothing(Request.Form("FromHome"))
        End If
        'End Addtion

        CommonFunctions.General.WriteHTML("<input name=FromHome id=FromHome type=hidden value=" + strFromHome + ">")

        Dim strScript As New System.Text.StringBuilder
        strScript.Append("<Script language=javascript>" + vbCrLf)
        strScript.Append(" var objForm = GetFormReference('frmCommonList'); " + vbCrLf)

        strScript.Append(" var objCurrentTagID=''; " + vbCrLf)
        strScript.Append(" var objRightPage ; " + vbCrLf)
        strScript.Append(" var strRemain ; " + vbCrLf)
        strScript.Append(" var strProcess ; " + vbCrLf)
        strScript.Append(" var objProcessID = ''; " + vbCrLf)
        'strScript.Append("var objNav = window.opener.parent.location.href ;" + vbCrLf)
        strScript.Append("if(window.opener!=null)")
        strScript.Append("var objNav = window.opener.location.href ;" + vbCrLf)
        strScript.Append("else objNav='';")
        strScript.Append("if (objNav.match('FromWhere=PM')!= null )" + vbCrLf)
        strScript.Append("{" + vbCrLf)
        strScript.Append(" objRightPage = window.opener.parent.document.frames['Sub'].location.href ;" + vbCrLf)
        'strScript.Append("}" + vbCrLf)
        strScript.Append(" if (objRightPage!='') { " + vbCrLf)
        strScript.Append(" var objRightPageLength = objRightPage.length; " + vbCrLf)
        strScript.Append(" if (objRightPage.toUpperCase().match('MASTERTAGID')) " + vbCrLf)
        strScript.Append(" strRemain = objRightPage.substring(objRightPage.toUpperCase().lastIndexOf('MASTERTAGID=')+12,objRightPageLength);" + vbCrLf)
        'strScript.Append(" else " + vbCrLf)
        'strScript.Append(" strRemain = objRightPage.substring(objRightPage.lastIndexOf('MasterTagId=')+12,objRightPageLength);" + vbCrLf)
        strScript.Append(" if (objRightPage.toUpperCase().match('PROCESSID')) " + vbCrLf)
        strScript.Append(" strProcess = objRightPage.substring(objRightPage.toUpperCase().lastIndexOf('PROCESSID=')+10,objRightPageLength);" + vbCrLf)
        strScript.Append("if(strRemain!=null)" + vbCrLf)
        strScript.Append(" if (strRemain.indexOf('&')!= -1) " + vbCrLf)
        strScript.Append(" objCurrentTagID = strRemain.substring(0,strRemain.indexOf('&')) ;" + vbCrLf)
        strScript.Append(" else " + vbCrLf)
        strScript.Append(" objCurrentTagID = strRemain ;" + vbCrLf)
        'Added By VarunA on 18-Dec-2008 IssueID-25985
        'Purpose : To handle the Process Activity nodes
        strScript.Append("if(strProcess!=null)" + vbCrLf)
        strScript.Append(" if (strProcess.indexOf('&')!= -1) " + vbCrLf)
        strScript.Append(" objProcessID = strProcess.substring(0,strProcess.indexOf('&')) ;" + vbCrLf)
        strScript.Append(" else " + vbCrLf)
        strScript.Append(" objProcessID = '' ;" + vbCrLf)
        'End By VarunA on 18-Dec-2008 IssueID-25985
        strScript.Append("} }" + vbCrLf)
        strScript.Append("function ProjectName_OnClick(intProjectID,strProjectName) {" + vbCrLf)
        strScript.Append("objForm.action='../PM/ProjectSelection_CommonList.aspx?FromWhere=PM&MasterTagID=8026&ProjectID='+intProjectID+'&ProjectName='+strProjectName+'&CurrentTagID='+objCurrentTagID +'&ProcessID='+objProcessID;" + vbCrLf)
        strScript.Append("objForm.submit(); }" + vbCrLf)
        strScript.Append("</Script>" + vbCrLf)

        HttpContext.Current.Response.Write(strScript.ToString)
        'Added by ShraddhaM for Whiziblesem8.0 on 10,Feb 2009
        'Purpose : For Add Favourites functionality
        CommonFunctions.General.WriteHTML("<input type=hidden name='Action' value=" + strAction + ">")
        'Ended by ShraddhaM

        '=====================================
        'Dim strScript As New System.Text.StringBuilder
        strScript.Length = 0
        Dim strProjectID As String
        'Dim strProjectName As String
        'Dim strProjectNameCon As String
        Dim strCurrentTagID As String
        Dim strPageName As String
        Dim strIsShow As String
        Dim strRoleName As String
        Dim strProcessID As String
        Dim strIsProcessAccessible As String = "0"

        strProjectID = Request.QueryString("ProjectId")

        If Not Request.QueryString("CurrentTagID") Is Nothing OrElse Request.QueryString("CurrentTagID") <> "" Then
            strCurrentTagID = Request.QueryString("CurrentTagID")
        Else
            strCurrentTagID = ""
        End If


        'Added By VarunA on 18-Dec-2008 IssueID-25985
        'Purpose : To handle the Process Activity nodes
        If Not Request.QueryString("ProcessID") Is Nothing OrElse Request.QueryString("ProcessID") <> "" Then
            strProcessID = Request.QueryString("ProcessID")
        End If
        If strProcessID <> "" Then
            'Commented and Added by Chakshuta H on 8th-Aug-2016 
            'strIsProcessAccessible = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select 1 From tbl_PRS_Project_SDLC_ProcessDetails Where ProjectID=" + strProjectID + " AND ProcessID=" + strProcessID, True), "0"), "0"), String)
            strIsProcessAccessible = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PRS_Project_SDLC_ProcessDetails_ProjectID " + strProjectID + "," + strProcessID, True), "0"), "0"), String)
            'End of Commented and Added by Chakshuta H on 8th-Aug-2016 
        End If
        'End By VarunA on 18-Dec-2008 IssueID-25985

        If strCurrentTagID <> "" Then
            'Commented and Added by Chakshuta H on 8th-Aug-2016 
            'strPageName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT PageName FROM tbl_UI_TagMaster WHERE TagID=" + strCurrentTagID, True), "0"), String)
            strPageName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_UI_TagMaster_PageName " + strCurrentTagID, True), "0"), String)
            'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        End If

        'Added by ShraddhaM on 8 July for Gadget Functionality
        Dim drReader As IDataReader
        Dim SQL As String
        Dim IsActive As Boolean = True
        Dim ForGadgetTagID As String

        strCurrentTagID = strCurrentTagID

        If strCurrentTagID = "" Or strCurrentTagID Is Nothing Then
            strCurrentTagID = "NULL"
        End If

        SQL = "usp_Sel_tbl_CNF_GadgetNodes_EmployeePreferences " + strCurrentTagID + "," + HttpContext.Current.Session("intUserID").ToString()
        drReader = CommonFunction.Data.GetDataReader(SQL, True)
        If drReader.Read Then
            IsActive = CType(drReader("Active"), Boolean)
        End If
        If IsActive = True Then
            strPageName = "General/Tab_Viewpage.aspx"
        End If
        CommonFunction.Data.DisposeDataReader(drReader)
        'End of addition by ShraddhaM 

        If CType(HttpContext.Current.Session("intUserID"), String) <> "" And strProjectID <> "" And strCurrentTagID <> "" Then
            strIsShow = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_IsPageAccessible " + CType(HttpContext.Current.Session("intUserID"), String) + "," + strProjectID + "," + strCurrentTagID + "," + CType(HttpContext.Current.Session("LoginType"), String), True), "0"), String)
        End If

        'If strProjectName <> "" Then
        '    strProjectNameCon = "Project: " & strProjectName
        'End If

        If strAction.ToLower() = "selectproject" Then

            strScript.Append("<Script language=javascript>" + vbCrLf)

            '''''''''''''''''''''''''''''''''''''''''''''''''''
            '''''''''Commented By Amol Changle On: 21 Mar 2009

            strScript.Append("var objProjectID;" + vbCrLf)
            strScript.Append("var objTree;" + vbCrLf)
            'strScript.Append("var objProjectName;" + vbCrLf)
            strScript.Append("var objMasterTagID;" + vbCrLf)
            strScript.Append("var objIsShow;" + vbCrLf)
            strScript.Append("var objIsProcess;" + vbCrLf)
            strScript.Append("var objTagID;" + vbCrLf)
            strScript.Append("objTagID='" + strCurrentTagID + "';" + vbCrLf)
            'strScript.Append("var objRoleName;" + vbCrLf)
            'strScript.Append("var objRoleLevel;" + vbCrLf)
            'strScript.Append("var objNav = window.opener.parent.location.href ;" + vbCrLf)

            'Added By Amol Changle On: 21 Mar 2009
            strScript.Append("if(window.opener!=null)")
            'End Addition
            strScript.Append("var objNav = window.opener.location.href ;" + vbCrLf)
            'Added By Amol Changle On: 21 Mar 2009
            strScript.Append("else objNav='';")
            'End Addition

            'strScript.Append("if (objNav.match('FromWhere=PM')!= null )" + vbCrLf)
            'strScript.Append("{" + vbCrLf)
            strScript.Append("objProjectID='" + strProjectID + "';" + vbCrLf)
            'strScript.Append("objRoleLevel='" + strRoleLevel + "';" + vbCrLf)
            'strScript.Append("objProjectName = window.opener.document.getElementById('lblProject');" + vbCrLf)
            'strScript.Append("objRoleName = window.opener.document.getElementById('lblRoleName');" + vbCrLf)
            strScript.Append("if(objProjectID!='') {" + vbCrLf)


            If strFromHome = "1" Then
                'Window
                'strScript.Append("window.opener.document.getElementById(""frmHome"").submit();" + vbCrLf)
                'Iframe
                strScript.Append("  if (navigator.appName == 'Microsoft Internet Explorer') ")
                strScript.Append(" {")
                strScript.Append("document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.parent(0).location.href=document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.parent(0).location.href;" + vbCrLf)
                strScript.Append("} else {")
                strScript.Append("window.parent.parent.frames['link'].frameElement.src=window.parent.parent.frames['link'].frameElement.src;")
                strScript.Append("}")
            Else
                strScript.Append("if(window.opener!=null)")
                strScript.Append("window.opener.location.reload();" + vbCrLf)
            End If

            strScript.Append("if (objNav.match('FromWhere=PM')!= null )" + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("objMasterTagID = window.opener.parent.document.frames['Sub'].location.href ;" + vbCrLf)
            strScript.Append("window.opener.parent.document.frames['Main'].location.href='" + strMainPage + "';" + vbCrLf)
            strScript.Append("objIsShow='" + strIsShow + "';" + vbCrLf)
            strScript.Append("objIsProcess='" + strIsProcessAccessible + "';" + vbCrLf)
            strScript.Append("if (objIsShow=='1' && objTagID!='32') {" + vbCrLf)
            strScript.Append("if (objMasterTagID.toUpperCase().match('MASTERTAGID') && objMasterTagID.toUpperCase().match('REPORTID'))" + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("window.opener.parent.document.frames['Sub'].location.href='../" + strPageName + "&FromWhere=PM&MasterTagID=" + strCurrentTagID + "';" + vbCrLf)
            strScript.Append("}" + vbCrLf)
            strScript.Append("else if (objMasterTagID.toUpperCase().match('MASTERTAGID') && objMasterTagID.toUpperCase().match('PROCESSID') && objIsProcess=='1')" + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("window.opener.parent.document.frames['Sub'].location.href='../" + strPageName + "?ProcessID=" + strProcessID + "&FromWhere=PM&MasterTagID=" + strCurrentTagID + "';" + vbCrLf)
            strScript.Append("}" + vbCrLf)
            strScript.Append("else if (objMasterTagID.toUpperCase().match('MASTERTAGID') && objMasterTagID.toUpperCase().match('PROCESSID') && objIsProcess=='0')" + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("window.opener.parent.document.frames['Sub'].location.href='../../Source/General/CommonList.aspx?FromWhere=PM&MasterTagID=32';" + vbCrLf)
            strScript.Append("}" + vbCrLf)
            strScript.Append("else if (objMasterTagID.toUpperCase().match('MASTERTAGID') && objMasterTagID.toUpperCase().match('PROCESSID')==null && objMasterTagID.toUpperCase().match('REPORTID')==null && objTagID!='80000')" + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("window.opener.parent.document.frames['Sub'].location.href='../" + strPageName + "?FromWhere=PM&MasterTagID=" + strCurrentTagID + "';" + vbCrLf)
            strScript.Append("}" + vbCrLf)
            strScript.Append("else if (objMasterTagID.toUpperCase().match('MASTERTAGID') && objMasterTagID.toUpperCase().match('PROCESSID')==null && objMasterTagID.toUpperCase().match('REPORTID')==null && objTagID=='80000')" + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("window.opener.parent.document.frames['Sub'].location.href='../../Source/PM/PM_BuildEfforts.aspx?FromWhere=PM&MasterTagId=80000';" + vbCrLf)
            strScript.Append("} }" + vbCrLf)
            strScript.Append("else {" + vbCrLf)
            strScript.Append("window.opener.parent.document.frames['Sub'].location.href='../../Source/General/CommonList.aspx?FromWhere=PM&MasterTagID=32';" + vbCrLf)
            strScript.Append("}" + vbCrLf)
            'strScript.Append("else" + vbCrLf)
            'strScript.Append("window.opener.parent.document.frames['Sub'].location.href='../" + strPageName + "?FromWhere=PM&MasterTagId=" + strCurrentTagID + "';" + vbCrLf)
            strScript.Append("}" + vbCrLf)
            'strScript.Append("objProjectName.innerHTML='" + strProjectNameCon + "';" + vbCrLf)
            'strScript.Append("if (objRoleLevel=='3') " + vbCrLf)
            'strScript.Append("objRoleName.innerHTML='" + strRoleName + "';" + vbCrLf)

            '''Added by PrashantSJ on 12th March 2009 for WhizibleSEM 8.0 New HOME module
            'strScript.Append("debugger;var strParentPage;" + vbCrLf)
            'strScript.Append("strParentPage=window.opener.parent.document.frames['Sub'].location.href;" + vbCrLf)
            'strScript.Append("if(strParentPage.toUpperCase().match('HOME'))" + vbCrLf)
            'strScript.Append("{" + vbCrLf)
            'strScript.Append("window.opener.parent.document.frames['Sub'].location.href=strParentPage;" + vbCrLf)
            'strScript.Append("}" + vbCrLf)
            '''End of addition by PrashantSJ on 12th March 2009

            ''Added By Amol Changle On: 18 Mar 2009
            If strFromHome = "1" Then
                'Window
                'strScript.Append("window.opener.parent.frames(0).location.href=window.opener.parent.frames(0).location.href;" + vbCrLf)
                'IFrame
                'strScript.Append("document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.forms(""frmHome"").submit();" + vbCrLf)

                strScript.Append("  if (navigator.appName == 'Microsoft Internet Explorer') ")
                strScript.Append(" {")
                strScript.Append("document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.forms(0).submit();" + vbCrLf)
                strScript.Append("} else {")
                strScript.Append("parent.document.getElementById('frmHome').submit();" + vbCrLf)
                strScript.Append("}")
            Else
                strScript.Append("if(window.opener.parent.document.frames['Sub'].document.getElementById(""frmHome"")!=null)")
                strScript.Append(vbCrLf)
                strScript.Append("window.opener.parent.document.frames['Sub'].document.getElementById(""frmHome"").submit();")
                strScript.Append(vbCrLf)
            End If
            ''End Addition

            strScript.Append("window.close(); " + vbCrLf)
            strScript.Append("}" + vbCrLf)

            'strScript.Append("ReloadParent()")

            '''''''''''''''''''''''''''''''''''''''''''''
            '''''''''End Comments By Amol Changle On: 21 Mar 2009

            strScript.Append("</Script>" + vbCrLf)
            HttpContext.Current.Response.Write(strScript.ToString)

        End If
        '=====================================

        strActionCode = ReturnCodes.ON_LOAD.ToString()

    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    End Function
    Protected Overrides Sub Finalize()
        m_GenerateTree = Nothing
        MyBase.Finalize()
    End Sub
    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Args.HTMLLegend = " "
        Cancel = True
    End Sub

    'Added by ShraddhaM for Whiziblesem8.0 on 10,Feb 2009
    'Purpose : For Add Favourites functionality
    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

        Dim strQuery As String

        'If strAction = "ADDFAV" Then
        strQuery = "usp_INS_tbl_PM_ProjectFavourites " + Session("intUserID").ToString() + ",'" + Session("LoginType").ToString + "','" + DeletedIDList + "','" + strAction + "'"
        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        'End If

        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function


    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ClientSideFunctionName.ToLower() = "removefav" Or Args.ClientSideFunctionName.ToLower = "allprojects" Then
            If strAction = "ADDFAV" Or strAction = "" Or strAction = "SHOWALL" Or strAction = "PROJSEL" Then
                Cancel = True
            End If
        End If


        If Args.ClientSideFunctionName.ToLower() = "showfav" Or Args.ClientSideFunctionName.ToLower = "delete_onclick" Then
            If strAction = "SHOWFAV" Or strAction = "REMFAV" Then
                Cancel = True
            End If
        End If

        If strFromHome = "1" And Args.ClientSideFunctionName.ToLower = "close_click" Then
            Args.ClientSideFunctionName = "CloseFrame_OnClick"
        End If


    End Sub
    'ended by ShraddhaM

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    '    If Args.SectionID = CommonFunction.Constants.SECTION_HEADER Then
    '        Cancel = True
    '    End If
    'End Sub

End Class


Public Class ProjectSelection_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Private strFavouriteProjectIDs As String = ""

    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal FavouriteProjectIDs As String)
        Call MyBase.New(WhizGlobal)

        strFavouriteProjectIDs = FavouriteProjectIDs
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strProjectIDs As String
        strProjectIDs = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_AccessibleProjectLists 'ProjectID'," + CType(HttpContext.Current.Session("intUserID"), String) + "," + CType(HttpContext.Current.Session("LoginType"), String) + "," + CType(HttpContext.Current.Session("intRoleLevel"), String) + IIf(CommonFunction.Application.ShowEvenReleaseFromProject, ",1", ",0").ToString() + "," + CType(HttpContext.Current.Session("intLoginID"), String), True), "0"), String)
        'GetPageSpecificFilters = ""
        'If strProjectIDs <> "" Then
        GetPageSpecificFilters += " AND ProjectID IN (" + strProjectIDs + ")"
        'End If

        'Added by ShraddhaM for Whiziblesem8.0 on 10,Feb 2009
        'Purpose : For Add Favourites functionality

        If HttpContext.Current.Request.Form("Action") = "SHOWFAV" Or HttpContext.Current.Request.Form("Action") = "REMFAV" Then
            strProjectIDs = strFavouriteProjectIds
            If strProjectIDs = "" Then
                strProjectIDs = "0"
            End If
            GetPageSpecificFilters += " AND ProjectID IN (" + strProjectIDs + ")"
        End If
        'Ended by ShraddhaM

    End Function

    Public strSQL As String

End Class


Public Class ProjectSelection_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Private strFavouriteProjectIDs As String = ""

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal FavouriteProjectIDs As String)
        Call MyBase.New(WhizGlobal)
        strFavouriteProjectIDs = FavouriteProjectIDs
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Cancel = True
        Args.ToBeInserted = DrawProjectSelectionDiv(Args.GridSQL, Args.WhereClause)
    End Sub

    'Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

    '    If Args.DataField.ToUpper = "PROJECTNAME" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD align=left Title='ProjectName'>"
    '        Args.StringToBeInserted += "<A href=""JavaScript:ProjectName_OnClick('" + CType(Args.DataReader("ProjectID"), String) + "','" + Replace(CType(Args.DataReader("ProjectName"), String), "'", "\'") + "')"">"
    '        Args.StringToBeInserted += CType(Args.DataReader("ProjectName"), String) + "</A></TD>"
    '    End If

    '    'Addition by SuchitraP on 11-Feb-2009
    '    'Purpose:For Add Favourites functionality
    '    If Args.ColumnName.ToUpper = "ADD TO FAVOURITE" And (ProjectSelection_CommonList.strAction = "SHOWALL" Or ProjectSelection_CommonList.strAction = "PROJSEL" Or ProjectSelection_CommonList.strAction = "ADDFAV") Then
    '        If Args.DataReader("IsPresent").ToString = "1" Then
    '            Cancel = True
    '            Args.StringToBeInserted = "<TD align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value=" + Args.DataReader("ProjectID").ToString + "></TD>"
    '        End If
    '    End If
    '    'End by SuchitraP
    'End Sub

    Private Function DrawProjectSelectionDiv(ByVal strSQL As String, ByVal strWhereClause As String) As String
        '=====================================================================
        ' Procedure Name        : DrawProjectSelectionGrid()	
        ' Purpose               : Procedure to draw project selection Div
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Amol Changle
        ' Created               : 17 Mar 2009
        ' Revisions             :
        '=====================================================================
        Dim strHTML As New StringBuilder
        Dim dsProject As DataSet
        Dim intIndex As Integer = 0
        Dim intResult As Integer
        Dim strToolTip As New StringBuilder
        Dim strBusinessGroup As String = ""


        strFavouriteProjectIds = "," + strFavouriteProjectIds + ","

        'strSQL = strSQL.Substring(0, strSQL.Length - 1) + " AND " + CommonFunctions.General.BuildQueryString(strWhereClause) + "'"

        strHTML.Append("<table cellspacing='0' cellpadding='3' width=99.99% >")

        dsProject = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_Project", UseSQL:=True)

        For Each drProject As DataRow In dsProject.Tables(0).Select(strWhereClause + " AND ProjectID=" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString())
            strToolTip.Append("Start Date: ")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedStartDate")).ToString() = "" Then
                strToolTip.Append("")
            Else
                strToolTip.Append(CommonFunctions.Dates.GetDate(drProject("ExpectedStartDate")))
            End If
            strToolTip.Append(vbCrLf)
            strToolTip.Append("End Date: ")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedEndDate")).ToString() = "" Then
                strToolTip.Append("")
            Else
                strToolTip.Append(CommonFunctions.Dates.GetDate(drProject("ExpectedEndDate")))
            End If

            'strHTML.Append("<span class='ProjectSpan' onclick=""javascript:ShowContextMenu(event," + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString() + ")"" title='" + strToolTip.ToString() + "'> ")
            'strHTML.Append("<b>Project Code: </b>&nbsp;")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectCode")))
            'strHTML.Append("<br><b>Project Name: </b>&nbsp;<font color=blue>")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName")))
            'strHTML.Append("</font></span>")
            'strHTML.Append("&nbsp;&nbsp;&nbsp;")
            'Math.DivRem(intIndex, 2, intResult)
            'If intResult = 1 Then
            '    strHTML.Append("<br><br>")
            'End If
            'intIndex += 1

            strHTML.Append("<tr>")
            strHTML.Append("<td class='CtMn_LeftFill'></td>")
            strHTML.Append("<td colspan=2><a class='clsLinkChildNavMenu' style=""text-decoration:none;""  ><b><i>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("BusinessGroup")).ToString())
            strHTML.Append("</i></b>")
            strHTML.Append("</a></td>")
            strHTML.Append("</tr>")
            strHTML.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td><td class='CtMn_Hr'></td></tr>")

            strHTML.Append("<tr>")
            strHTML.Append("<td class='CtMn_LeftFill'></td>")
            strHTML.Append("<td ><a class='clsLinkChildNavMenu' style=""text-decoration:none;"" title='")
            strHTML.Append(strToolTip.ToString())
            strHTML.Append("' href=""javascript:SelectProject_OnClick('")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID")).ToString())
            strHTML.Append("')"">")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName")).ToString())
            strHTML.Append("</a></td>")

            'If strFavouriteProjectIDs.IndexOf("," + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString() + ",") > -1 Then
            '    strHTML.Append("<td align=right><a style=""text-decoration:none;"" title='Remove From Favourtes' href='javascript:RemoveFromFavourites_OnClick(")
            '    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID")).ToString())
            '    strHTML.Append(")'><img src='../../Images/Home/RemoveFavorite.gif' border=0 /></a></td>")
            'Else
            '    strHTML.Append("<td align=right><a style=""text-decoration:none;"" title='Add To Favourtes' href='javascript:AddToFavourites_OnClick(")
            '    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID")).ToString())
            '    strHTML.Append(")'><img src='../../Images/Home/AddFavorite.gif' border=0 /></a></td>")
            'End If
            strHTML.Append("</tr>")
            strHTML.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td><td class='CtMn_Hr'></td></tr>")

            strBusinessGroup = CommonFunctions.Data.CheckIsDBNull(drProject("BusinessGroup")).ToString()
            strToolTip.Length = 0
        Next

        For Each drProject As DataRow In dsProject.Tables(0).Select(strWhereClause + " AND ProjectID<>" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString(), "BusinessGroup ASC,ProjectName ASC")
            strToolTip.Append("Start Date: ")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedStartDate")).ToString() = "" Then
                strToolTip.Append("")
            Else
                strToolTip.Append(CommonFunctions.Dates.GetDate(drProject("ExpectedStartDate")))
            End If
            strToolTip.Append(vbCrLf)
            strToolTip.Append("End Date: ")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedEndDate")).ToString() = "" Then
                strToolTip.Append("")
            Else
                strToolTip.Append(CommonFunctions.Dates.GetDate(drProject("ExpectedEndDate")))
            End If

            'strHTML.Append("<span class='ProjectSpan' onclick=""javascript:ShowContextMenu(event," + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString() + ")"" title='" + strToolTip.ToString() + "'> ")
            'strHTML.Append("<b>Project Code: </b>&nbsp;")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectCode")))
            'strHTML.Append("<br><b>Project Name: </b>&nbsp;<font color=blue>")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName")))
            'strHTML.Append("</font></span>")
            'strHTML.Append("&nbsp;&nbsp;&nbsp;")
            'Math.DivRem(intIndex, 2, intResult)
            'If intResult = 1 Then
            '    strHTML.Append("<br><br>")
            'End If
            'intIndex += 1


            If strBusinessGroup <> CommonFunctions.Data.CheckIsDBNull(drProject("BusinessGroup")).ToString() And CommonFunctions.Data.CheckIsDBNull(drProject("BusinessGroup")).ToString() <> "" Then
                strHTML.Append("<tr>")
                strHTML.Append("<td class='CtMn_LeftFill'></td>")
                strHTML.Append("<td colspan=2><a class='clsLinkChildNavMenu' style=""text-decoration:none;""  ><b><i>")
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("BusinessGroup")).ToString())
                strHTML.Append("</i></b>")
                strHTML.Append("</a></td>")
                strHTML.Append("</tr>")
                strHTML.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td><td class='CtMn_Hr'></td></tr>")
            End If
            strHTML.Append("<tr>")
            strHTML.Append("<td class='CtMn_LeftFill'></td>")
            strHTML.Append("<td ><a class='clsLinkChildNavMenu' style=""text-decoration:none;"" title='")
            strHTML.Append(strToolTip.ToString())
            strHTML.Append("' href=""javascript:SelectProject_OnClick('")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID")).ToString())
            strHTML.Append("')"">")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName")).ToString())
            strHTML.Append("</a></td>")

            'If strFavouriteProjectIDs.IndexOf("," + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString() + ",") > -1 Then
            '    strHTML.Append("<td align=right><a style=""text-decoration:none;"" title='Remove From Favourtes' href='javascript:RemoveFromFavourites_OnClick(")
            '    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID")).ToString())
            '    strHTML.Append(")'><img src='../../Images/Home/RemoveFavorite.gif' border=0 /></a></td>")
            'Else
            '    strHTML.Append("<td align=right><a style=""text-decoration:none;"" title='Add To Favourtes' href='javascript:AddToFavourites_OnClick(")
            '    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID")).ToString())
            '    strHTML.Append(")'><img src='../../Images/Home/AddFavorite.gif' border=0 /></a></td>")
            'End If
            strHTML.Append("</tr>")

            strHTML.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td><td class='CtMn_Hr'></td></tr>")

            strBusinessGroup = CommonFunctions.Data.CheckIsDBNull(drProject("BusinessGroup")).ToString()

            strToolTip.Length = 0
        Next

        strHTML.Append("</table>")

        'DrawFloatingMenu()

        DrawProjectSelectionDiv = strHTML.ToString()
        strHTML = Nothing
        strToolTip = Nothing
    End Function

    'Private Sub DrawFloatingMenu()
    '    '=====================================================================
    '    ' Procedure Name		:	DrawFloatingMenus
    '    ' Parameters Passed		:	None
    '    ' Returns				:	HTML String
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To Plot Floating Menus for each objective an KPI from Tree structure. 
    '    ' Description			:	Same as purpose.
    '    ' Assumptions			:	None.
    '    ' Dependencies			:	None.
    '    ' Author				:	NitinVS
    '    ' Created				:	4 Feb 2008
    '    ' Revisions				:	
    '    '=====================================================================

    '    Dim DrawFloatingMenus As New StringBuilder

    '    DrawFloatingMenus.Append("<div id='divContextMenu' class='ContextMenu' style='display:none;'>")
    '    DrawFloatingMenus.Append("<table id='tblKPI' cellspacing='0' cellpadding='3'>")

    '    DrawFloatingMenus.Append("<tr id='trCtSelectProject'>")
    '    DrawFloatingMenus.Append("<td id='tdImgCtSelectProject' class='CtMn_LeftFill'></td>")
    '    DrawFloatingMenus.Append("<td id='tdCtSelectProject' ></td>")
    '    DrawFloatingMenus.Append("</tr>")
    '    DrawFloatingMenus.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")

    '    DrawFloatingMenus.Append("<tr id='trCtAddToFavourite'>")
    '    DrawFloatingMenus.Append("<td id='tdImgCtAddToFavourite' class='CtMn_LeftFill'></td>")
    '    DrawFloatingMenus.Append("<td id='tdCtAddToFavourite'></td>")
    '    DrawFloatingMenus.Append("</tr>")
    '    'DrawFloatingMenus.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")

    '    DrawFloatingMenus.Append("<tr id='trCtRemoveFromFavourite'>")
    '    DrawFloatingMenus.Append("<td id='tdImgCtRemoveFromFavourite' class='CtMn_LeftFill'></td>")
    '    DrawFloatingMenus.Append("<td id='tdCtRemoveFromFavourite'></td>")
    '    DrawFloatingMenus.Append("</tr>")
    '    DrawFloatingMenus.Append("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")

    '    DrawFloatingMenus.Append("</table>")
    '    DrawFloatingMenus.Append("</div>")

    '    CommonFunctions.General.WriteHTML(DrawFloatingMenus.ToString())

    'End Sub


End Class

Public Class ProjectSelection_CommonListDynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Initialize_Filters(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFiltersTable, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.LoginType = "C" Then
            Cancel = True
        End If
    End Sub
End Class




