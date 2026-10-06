Imports CommonFunctions
Imports System.IO
Imports System.Xml
Imports Newtonsoft.Json
Imports System.Net
Imports System.Runtime.InteropServices
Public Class PM_ProjectDocuments
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_MODE_DETAIL As String = "DETAILS"
    Protected CONST_MODE_LIST As String = "LIST"
    Protected CONST_MODE_HISTORY As String = "HISTORY"
    Protected CONST_MODE_UPLOAD As String = "UPLOAD"
    Protected CONST_MODE_REVIEW As String = "REVIEW"
    Protected CONST_MODE_ATTACHURL As String = "URL"
    Protected CONST_ACTION_SAVE As String = "SAVE"
    Protected CONST_ACTION_DELETE As String = "DELETE"
    Protected CONST_ACTION_UPLOAD As String = "UPLOAD"
    Protected CONST_ACTION_ATTACHURL As String = "ATTACH"

    Protected m_strMode As String
    'Added by MonikaI on 4th Oct 2006 IssueID : 6636
    Protected m_strPageType As String
    'End by MonikaI
    Protected m_strFromWhere As String
    Protected m_strMasterTagID As String
    Protected m_strAction As String
    Private m_strcategoryID As String
    'Added By VarunA on 20-Jan-2008 RequestID-21539
    'Purpose : To have paging and text Search
    Protected m_strAlphabet As String = "-1"
    Protected m_strtxtSearch As String = ""
    Protected m_strsubCategoryID As String = ""
    Protected m_strDocumentcategoryID As String
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""
    'End By VarunA on 20-Jan-2008 RequestID-21539
    Protected m_strWindowTitle As String
    Protected m_strFileUploaded As Boolean = False
    Protected m_strDocumentID As String
    Private m_blnAddAccess As Boolean
    Private m_blnDelAccess As Boolean
    Protected m_strProjectID As String
    Private m_strRoleID As String
    Private m_strLoginType As String
    Private m_lngUserID As Long
    Private WithEvents m_objGrid As WebPage.Templates.GenericGrid
    'Added by MrugajaB on 2nd Mar 2005
    Protected m_intTagID, m_intUniqueID As String
    ' End of Addition

    'Added by VivekP On 2 jun 2005
    Protected FromTimesheet As String
    Protected TempProjectId As Long
    'End Of addition On 2 jun 2005

    'Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197
    Protected m_strToken As String
    Protected m_strParentToken As String
    'End Addition
    'Added By JyotiG
    'Start_JG_12912_11-Apr-2007
    Protected blnPerformSuccessFully As Boolean
    'End of addition by JyotiG
    'added By NitinVS on 24 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 
    Protected m_blnEditAccess As Boolean
    'End addition By NitinVS on 24 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 
    Protected m_strExtensionList As String
    Protected m_PKToken As String = ""
    Protected str_Token As String = ""
    ''Added by Yogesh Jalamkar on 
    Private m_blnValidate As Boolean = True
    ''End of addition


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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        If Request.QueryString("Mode") <> "" Then
            If Request.QueryString("Mode").ToUpper = CONST_MODE_DETAIL Or Request.QueryString("Mode").ToUpper = CONST_MODE_LIST Then
                m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_DETAILS")
            ElseIf Request.QueryString("Mode").ToUpper = CONST_MODE_HISTORY Then
                m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_HISTORY")
            ElseIf Request.QueryString("Mode").ToUpper = CONST_MODE_UPLOAD Then
                m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_UPLOAD")
            ElseIf Request.QueryString("Mode").ToUpper = CONST_MODE_REVIEW Then
                m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_REVIEW")
            Else
                m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_DETAILS")
            End If
        Else
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_DETAILS")
        End If

        'Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197
        m_strToken = ""
        m_strParentToken = ""

        'When page is called from Assigned Task List Page Token is passed as query string 
        'If Page is submitted internally then Token value is read from hidden variable

        If HttpContext.Current.Request.QueryString("ParentToken") Is Nothing Then
            m_strParentToken = Request.Form("txthidParentToken") & ""
        Else
            m_strParentToken = Request.QueryString("ParentToken") & ""
        End If
        If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
            m_strToken = Request.Form("txthidToken") & ""
        Else
            m_strToken = Request.QueryString("PkToken") & ""
        End If

        m_intUniqueID = Request.QueryString("UniqueID") + ""
        m_lngUserID = CType(Session("intUserID").ToString, Long)
        'If HttpContext.Current.Request.QueryString("mastertagid") = "467" Then
        '    If HttpContext.Current.Request.QueryString("mastertagid") = "467" And HttpContext.Current.Request.QueryString("pktoken") Is Nothing Then
        '        m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_intUniqueID, String) + CType(m_lngUserID, String) + "0" + "467")
        '    Else
        '        m_strToken = Request.QueryString("pktoken") & ""

        '    End If
        'End If

        'Added By VarunA on 28-Aug-2009 RequestID-21539
        'Purpose : To have sorting on grid
        If Page.IsPostBack Then
            m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        End If
        'End By VarunA on 28-Aug-2009 RequestID-21539
        '' ''Added  By Shamkant s 31/12/2015


        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        ' ''Ended By Shamkant s 31/12/2015

        ''Added by Yogesh J on on 29-Jan-2016 to validate Token
        'If Request.QueryString("Mode") = "UPLOAD" And Request.QueryString("FromWhere") = "PM" Then
        '    If Request.QueryString("UniqueID") IsNot Nothing And Request.QueryString("Token") IsNot Nothing And Request.QueryString("SubCategoryID") IsNot Nothing Then

        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("UniqueID"), String) + CType(Request.QueryString("CategoryID"), String) + CType(Request.QueryString("SubCategoryID"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then
        '            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(Request.QueryString("UniqueID"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    End If

        'End If
        'If Request.QueryString("Mode") = "URL" And Request.QueryString("FromWhere") = "PM" Then
        '    If Request.QueryString("CategoryID") IsNot Nothing And Request.QueryString("SubCategoryID") IsNot Nothing And Request.QueryString("PKToken") IsNot Nothing Then

        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("CategoryID"), String) + CType(Request.QueryString("SubCategoryID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '            '  Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(Request.QueryString("UniqueID"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    End If

        'End If
        ' ''End of addition by Yogesh J on on 29-Jan-2016 to validate Token

        ''Added by Yogesh J on 01-Feb-2016 to validate Token
        'If Request.QueryString("DocumentID") <> "" And Request.QueryString("PKToken") <> "" Then
        '    If Request.QueryString("MasterTagID") <> 1026 And Request.QueryString("MasterTagID") <> 2191 Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("DocumentID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Document", 0, 0, "Document ID", CType(Request.QueryString("DocumentID"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    End If
        'End If
        ' ''End of addition by Yogesh J on on 01-Feb-2016 to validate Token
        ''Added by Yogesh J on 01-Feb-2016 to validate Token
        'If Request.QueryString("TaskId") <> "" And Request.QueryString("PKToken") <> "" And Request.QueryString("UniqueID") <> "" Then

        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TaskId"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(Request.QueryString("MasterTagID"), String), Request.QueryString("PKToken")) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("MasterTag", 0, 0, "MasterTagID", CType(Request.QueryString("MasterTagID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If

        'End If
        ' ''End of addition by Yogesh J on on 01-Feb-2016 to validate Token
        ' ''Added by Yogesh J on on 02 Mar 2016 to validate Token
        'If Request.QueryString("FromWhere") = "PM" And Request.QueryString("Mode") = "UPLOAD" And Request.QueryString("Flag") = "Token" Then
        '    If Request.QueryString("UniqueID") IsNot Nothing And Request.QueryString("Token") IsNot Nothing Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("UniqueID"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then

        '            ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    End If
        'End If
        ''  End of addition by Yogesh J on 02-Mar-2016 to validate Token 

        ' ''Added by Dhanashri S on 29 Mar 2016 Purpose:to validate Token
        'If (Request.QueryString("PKAttachURLToken") <> "" And Request.QueryString("UniqueID") <> "" And Request.QueryString("TaskId") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("UniqueID"), String) + CType(Request.QueryString("TaskId"), String), Request.QueryString("PKAttachURLToken")) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("UniqueID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


        '    End If

        'End If


        'If (Request.QueryString("PKAttachURLCreateTaskToken") <> "" And Request.QueryString("UniqueID") <> "" And Request.QueryString("TaskId") <> "" And Request.QueryString("ProjectID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("UniqueID"), String) + CType(Request.QueryString("TaskId"), String) + CType(Request.QueryString("ProjectID"), String), Request.QueryString("PKAttachURLCreateTaskToken")) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("UniqueID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


        '    End If

        'End If
        ''End of Addition by Dhanashri S on 29 Mar 2016

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 26 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccess As WebPage.Templates.AccessRights

        'Added By MrugajaB on 4th Mar 2005 for SP2 Document Sub Category Feature
        Dim drSubCategory As IDataReader
        Dim arrValues As System.Collections.ArrayList
        Dim iRowLoop As Integer
        Dim iColLoop As Integer
        Dim strSubCat As String
        'End Addition
        'Added By VarunA on 20-Jan-2008 RequestID-21539
        'Purpose : To have paging and text Search
        Dim sbHTML As New System.Text.StringBuilder
        Dim strSearchText As String = ""
        Dim objDynamicLink As WebPages.UI.cDynamicLink
        'End By VarunA on 20-Jan-2008 RequestID-21539

        m_strMode = Request.QueryString("Mode") + ""
        'Added by MonikaI on 4th Oct 2006 IssueID : 6636
        m_strPageType = Request.QueryString("PageType") + ""
        'End by MonikaI
        If m_strMode = "" Then m_strMode = CONST_MODE_LIST
        m_strAction = Request.QueryString("Action") + ""
        m_strFromWhere = Request.QueryString("FromWhere") + ""
        m_strMasterTagID = Request.QueryString("MasterTagID") + ""
        m_strDocumentID = Request.QueryString("DocumentID") + ""



        'Added By VivekP On 5 Jun 2005
        FromTimesheet = Request.QueryString("FromTimesheet")
        If Request.QueryString("FromTimesheet") = "CreateTask" Then
            m_strProjectID = CType(Request.QueryString("ProjectID"), String)
            TempProjectId = CType(Request.QueryString("ProjectID"), Long)
        Else

            m_strProjectID = Session("intProjectID").ToString + ""
        End If
        'End Of addition on 5 Jun 2005

        m_strRoleID = Session("intPostID").ToString + ""
        m_strLoginType = Session("LoginType").ToString + ""
        m_lngUserID = CType(Session("intUserID").ToString, Long)

        ' Code Added by MrugajaB on 2nd Mar 2005
        m_strcategoryID = Request.QueryString("DocumentCategoryID") + ""

        ' Code Added By NitinVS on 8 March 2005 
        ' To Get the TagID from the queryString 
        m_intTagID = Request.QueryString("MasterTagID") + ""
        m_intUniqueID = Request.QueryString("UniqueID") + ""
        'Create Client Side array to filter Sub Categories 

        'Added By VarunA on 20-Jan-2008 RequestID-21539
        'Purpose : To have paging and text Search
        If CommonFunction.General.CheckIsNothing(Request.QueryString("PagingAlphabet"), "") <> "" Then
            m_strAlphabet = Request.QueryString("PagingAlphabet")
            'ElseIf CommonFunction.General.CheckIsNothing(Request.Form("txthdnPagingAlphabet"), "") <> "" Then
            '   m_strAlphabet = Request.Form("txthdnPagingAlphabet")
        End If

        If CommonFunction.General.CheckIsNothing(Request.Form("txtSearch"), "") <> "" Then
            m_strtxtSearch = Request.Form("txtSearch").ToString
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("TextSearch"), "") <> "" Then
            m_strtxtSearch = Request.QueryString("TextSearch")
        End If
        If m_strtxtSearch <> "" Then
            m_strAlphabet = "-1"
        End If
        If CommonFunction.General.CheckIsNothing(Request.Form("cboCategory1"), "") <> "" Then
            m_strDocumentcategoryID = Request.Form("cboCategory1").ToString
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("CategoryID"), "") <> "" Then
            m_strDocumentcategoryID = Request.QueryString("CategoryID")
        Else
            m_strDocumentcategoryID = "Null"
        End If
        If CommonFunction.General.CheckIsNothing(Request.Form("cboSubCategory1"), "") <> "" Then
            m_strsubCategoryID = Request.Form("cboSubCategory1").ToString
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("SubCategoryID"), "") <> "" Then
            m_strsubCategoryID = Request.QueryString("SubCategoryID")
        Else
            m_strsubCategoryID = "NULL"
        End If
        'End By VarunA on 20-Jan-2008 RequestID-21539
        ''Added by Yogesh Jalamkar on 12-Aug-2016 For PKToken
        If (m_strToken = "" And m_strParentToken <> "") Then
            m_strToken = m_strParentToken
        End If
        Dim m_lngTaskId As String

        If HttpContext.Current.Request.QueryString("TaskId") IsNot Nothing Then
            m_lngTaskId = Request.QueryString("TaskId")
        End If

        If (m_strToken = "" And HttpContext.Current.Session("intUserID") <> 0 And HttpContext.Current.Request.QueryString("MasterTagID") <> "467") Then
            m_blnValidate = False
        ElseIf m_lngTaskId <> "" And m_strToken <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngTaskId, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(CommonFunction.General.CheckIsNothing(Request.QueryString("MasterTagID"), "0"), String), m_strToken) = False) Then
                m_blnValidate = False
            End If
        ElseIf m_intUniqueID <> "" And m_strToken <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_intUniqueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(CommonFunction.General.CheckIsNothing(Request.QueryString("MasterTagID"), "0"), String), m_strToken) = False) Then
                m_blnValidate = False
            End If
        ElseIf m_strDocumentID <> "" And m_strToken <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_strDocumentID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(CommonFunction.General.CheckIsNothing(Request.QueryString("MasterTagID"), "0"), String), m_strToken) = False) Then
                m_blnValidate = False
            End If
        End If

        If (m_blnValidate = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End of addition by Yogesh Jalamkar on 12-Aug-2016 For PKToken
        If HttpContext.Current.Request.QueryString("MasterTagID") = "467" Then
            If HttpContext.Current.Request.QueryString("MasterTagID") = "467" And HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_intUniqueID, String) + CType(m_lngUserID, String) + "0" + "467")
            Else
                m_strToken = Request.QueryString("PkToken") & ""

            End If
        End If
        'Added by Yogesh Jalamkar To generate Token on 1-Mar-2016
        str_Token = CommonFunctions.Security.Token.GetToken(CType(m_strDocumentcategoryID, String) + CType(m_strsubCategoryID, String) + "0" + "0")
        'End of addition by Yogesh J on 01-Mar-2016

        'Code Added By NeetaP on 8th August 2003 Order By SubCategory
        'strQuery="Select CategoryID, SubCategoryID, SubCategory From tbl_PM_DocumentSubCategory"

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "Select CategoryID, SubCategoryID, SubCategory From tbl_PM_DocumentSubCategory Order By SubCategory"
        strSQL = "usp_sel_tbl_PM_DocumentSubCategory_CategoryID_SubCategoryID_SubCategory"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'Addition Ends
        drSubCategory = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        Response.Write(" <SCRIPT LANGUAGE=javascript>	")
        Response.Write(" arrsubCategories=new Array; ")

        iRowLoop = 0
        While (drSubCategory.Read)
            strSubCat = ""
            strSubCat = Convert.ToString(drSubCategory("CategoryID"))
            strSubCat = strSubCat & "," + Replace(Convert.ToString(drSubCategory("SubcategoryID")), "'", "\'")
            strSubCat = strSubCat & "," + Replace(Convert.ToString(drSubCategory("SubCategory")), "'", "\'")
            Response.Write("arrsubCategories[" & iRowLoop & "]='" & strSubCat & "' ;  ")
            iRowLoop = iRowLoop + 1
        End While
        Data.DisposeDataReader(drSubCategory)


        Response.Write("</Script>")
        '==========================
        ' End of Addition

        'get the access settings for the user
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject
        objAccess = New WebPage.Templates.AccessRights
        'Modified By NitinVS on 24 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12491 
        'Access of Sub tag for Documents is to be applied and not that of parent 
        'i.e Access for Documents subtag is to be checked and not that of Phase
        Select Case m_intTagID
            Case "34"
                objGlobal.ParentTagID = 34
                objGlobal.TagID = 2115
            Case "516"
                objGlobal.ParentTagID = 516
                objGlobal.TagID = 2119
            Case "1026"
                objGlobal.ParentTagID = 1026
                objGlobal.TagID = 2118
            Case "1039"
                objGlobal.ParentTagID = 1039
                objGlobal.TagID = 2120
            Case "2191"
                objGlobal.ParentTagID = 2191
                objGlobal.TagID = 2128
        End Select
        ' End Modification By NitinVS on 24 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12491 

        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add
        m_blnDelAccess = objAccess.Delete
        'blnEditAccess = objAccess.Edit
        m_blnEditAccess = objAccess.Edit
        objAccess = Nothing

        Select Case m_strMode.ToUpper.Trim
            Case CONST_MODE_DETAIL, CONST_MODE_LIST

                If m_strAction <> "" Then
                    Call performAction("A")

                    ' Modified By NitinVS on 8 March 2005 
                    ' To Refresh Parent page when the Page is called from other than Project Documents
                    'write client side script to refresh parent
                    Call RefreshParent()
                    ' End Modification By NitinVS on 8 March 2005 PBNITE SP2

                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList
                'Added By VarunA on 20-Jan-2008 RequestID-21539
                'Purpose : To have paging and text Search
                Dim objPaging As WebPages.Template.Paging
                Dim strPagingHTML As String

                objPaging = New WebPage.Templates.Paging
                strPagingHTML = objPaging.DrawPaging(m_strAlphabet, "usp_Sel_tbl_PM_ProjectDocuments_FilterPaging " + m_strProjectID + "," + m_strRoleID + ",'" + CommonFunctions.General.BuildQueryString(m_strtxtSearch.ToString) + "'," + m_strDocumentcategoryID.ToString + "," + m_strsubCategoryID.ToString, "Select", "AlphaNumericPaging_OnClick", "Alphabet", True)
                objPaging = Nothing
                'End By VarunA on 20-Jan-2008 RequestID-21539

                arrMenu.Add(MyBase.GetResourceString("MENU_LIST_VIEW")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_LIST_VIEW_TOOLTIP")) : arrClientSideFunctions.Add("ListView_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_DETAIL_VIEW")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_DETAIL_VIEW_TOOLTIP")) : arrClientSideFunctions.Add("DetailView_OnClick()")
                If m_blnAddAccess = True Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_UPLOAD_DOCUMENT")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_UPLOAD_DOCUMENT_TOOLTIP")) : arrClientSideFunctions.Add("UploadDoc_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_ATTACH_URL_TOOLTIP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ATTACH_URL")) : arrClientSideFunctions.Add("AttachURL_OnClick()")
                End If
                'Trupti
                'If Request.QueryString("Mode").ToUpper <> CONST_MODE_HISTORY Then
                If m_blnDelAccess = True Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_DELETE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP")) : arrClientSideFunctions.Add("Delete_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('" + m_strMasterTagID.Trim + "')")
                'End If
                'end by Trupti
                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'draw upper menu
                'Modified By VarunA on 20-Jan-2008 RequestID-21539
                'Purpose : To have paging and text Search
                'strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)
                'End By VarunA on 20-Jan-2008 RequestID-21539
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for issue assignment page.
                MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")

                'draw page caption 
                'WebPage.Templates.PageCaption.GetPageCaptions(objGlobal, MyBase.GetResourceString("PAGE_CAPTION_DETAILS"))
                WebPage.Templates.PageCaption.GetPageCaptions(objGlobal)
                General.WriteHTML("<BR>")

                'Added By VarunA on 20-Jan-2008 RequestID-21539
                'Purpose : To have paging and text Search
                sbHTML.Append("<TABLE id='tblSearch'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven valign=left>")

                'Commented and Added by Dhanashri S on 5th Sept 2014 Puppose:SP2 upgrade
                'sbHTML.Append("<td Width='10%' NoWrap title='Document Search' > Document Name</td><td Width='20%' align=left>")
                sbHTML.Append("<td Width='7%' NoWrap title='Document Search' > Document Name</td><td Width='15%' align=left>")
                'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 150, value:=m_strtxtSearch, ToBeInserted:="Title='Contains' onkeypress=txtSearch_KeyPress(event) ", returnHTML:=True))
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 100, value:=m_strtxtSearch, ToBeInserted:="Title='Contains' onkeypress=txtSearch_KeyPress(event) ", returnHTML:=True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                'End of Comment and Addition by Dhanashri S on 5th Sept 2014

                sbHTML.Append("</td>")

                'Commented and Added by Dhanashri S on 5th Sept 2014 Puppose:SP2 upgrade
                'sbHTML.Append("<td Width='10%' NoWrap title='Document Category' > Document Category</td><td Width='20%' align=left>")
                sbHTML.Append("<td Width='7%' NoWrap title='Document Category' > Document Category</td><td Width='15%' align=left>")
                strSQL = "usp_Sel_tbl_PM_DocumentCategory_ForRole " + m_strRoleID.Trim + "," + m_strProjectID.Trim
                'sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory1", strSQL, 150, m_strDocumentcategoryID.ToString, "onchange = 'cboCategoryList_OnChange()'", True, True, , False))
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory1", strSQL, 100, m_strDocumentcategoryID.ToString, "onchange = 'cboCategoryList_OnChange()'", True, True, , False))
                'End of Comment and Addition by Dhanashri S on 5th Sept 2014

                sbHTML.Append("</td>")

                'Commented and Added by Dhanashri S on 5th Sept 2014 Puppose:SP2 upgrade
                'sbHTML.Append("<td Width='10%' NoWrap title='Document Sub Category' > Document Sub Category</td><td id='tdSubCategory' Width='20%' align=left>")
                sbHTML.Append("<td Width='7%' NoWrap title='Document Sub Category' > Document Sub Category</td><td id='tdSubCategory' Width='15%' align=left>")
                'End of Comment and Addition by Dhanashri S on 5th Sept 2014

                'If m_strDocumentcategoryID.Trim = "" Then
                '    m_strDocumentcategoryID = "Null"
                'End If
                If m_strDocumentcategoryID.Trim = "Null" Then
                    strSQL = "usp_Sel_tbl_PM_DocumentSubCategory 0, Null ," + m_strProjectID
                Else
                    strSQL = "usp_Sel_tbl_PM_DocumentSubCategory " + m_strDocumentcategoryID.Trim + " , Null , " + m_strProjectID
                End If

                'Commented and Added by Dhanashri S on 5th Sept 2014 Puppose:SP2 upgrade
                'sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubCategory1", strSQL, 150, m_strsubCategoryID.ToString, , True, True, , False))
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubCategory1", strSQL, 100, m_strsubCategoryID.ToString, , True, True, , False))
                'End of Comment and Addition by Dhanashri S on 5th Sept 2014

                sbHTML.Append("</td>")
                sbHTML.Append("<td align=center Width='10%'>")
                objDynamicLink = New WebPages.UI.cDynamicLink
                objDynamicLink.LinkName = "Show"
                objDynamicLink.Tooltip = "Show"
                objDynamicLink.FunctionName = "Show_OnClick()"
                objDynamicLink.ReturnHTML = True
                sbHTML.Append(" |<B>" + objDynamicLink.GetDynamicLink() + "</B>| ")
                objDynamicLink = Nothing
                sbHTML.Append("</td></tr>")
                sbHTML.Append("</Table><br>")
                CommonFunctions.General.WriteHTML(sbHTML.ToString)
                sbHTML = Nothing
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(HTMLControls.DrawTextBox("txthidSubCategory", "txthidSubCategory", , , , m_strsubCategoryID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                'End By VarunA on 20-Jan-2008 RequestID-21539

                'draw page description
                objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_DETAILS") + ""
                objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
                Dim strHeader As String
                strHeader = objHeader.DrawHeaderFooter(objGlobal, True) + ""
                If strHeader <> "" Then
                    General.WriteHTML(strHeader)
                    General.WriteHTML("<BR>")
                End If
                objHeader = Nothing

                'plot the grid for document list
                Call plotDocumentListGrid()
                'Added By VarunA on 28-Aug-2009 RequestID-21539
                'Purpose : To have sorting on grid
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                'End By VarunA on 28-Aug-2009 RequestID-21539

                'plot the lower menu
                General.WriteHTML("<BR>")
                'Added By VarunA on 20-Jan-2008 RequestID-21539
                'Purpose : To have paging and text Search
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                'End By VarunA on 20-Jan-2008 RequestID-21539
                General.WriteHTML(strMenu)


            Case CONST_MODE_HISTORY

                If m_strAction <> "" Then
                    Call performAction("I")
                    ' Added By NitinVS on 18 March 2005 for PBNITE SP2
                    Call RefreshParent()
                    ' End Addition By NitinVS on 18 March 2005 for PBNITE SP2 SP2
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList
                'Commented by TruptiK on 23-Dec-08
                'Purpose:-There is no need of delete link.
                'Commented By Reshma C on 19 March 2020 For IssueID-
                'If m_blnDelAccess = True Then
                '    arrMenu.Add(MyBase.GetResourceString("MENU_DELETE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP")) : arrClientSideFunctions.Add("Delete_OnClick()")
                'End If
                'End of Commented By Reshma C on 19 March 2020 For IssueID-
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('" + m_strMasterTagID.Trim + "')")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for issue assignment page.
                MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_HISTORY"))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_HISTORY") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen for document history
                Call plotDocumentHistoryScreen()

                'plot the lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

            Case CONST_MODE_UPLOAD

                If m_strAction <> "" Then
                    Call performUploadAction()

                    ' Modified By NitinVS on 8 March 2005 
                    ' To Refresh Parent page when the Page is called from other than Project Documents
                    'write client side script to refresh parent

                    'Added By JyotiG
                    'Start_JG_12912_11-Apr-2007
                    If blnPerformSuccessFully = True Then
                        'End_JG_12912_11-Apr-2007
                        Call RefreshParent()
                    End If
                    ' End Modification By NitinVS on 8 March 2005 PBNITE SP2
                End If


                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                If m_blnAddAccess = True Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_UPLOAD")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_UPLOAD_TOOLTIP")) : arrClientSideFunctions.Add("Upload_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'initialize the resource file for issue assignment page.
                MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_UPLOAD"))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_UPLOAD") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen for document upload
                Call plotDocumentUploadScreen()

                'plot the lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

            Case CONST_MODE_REVIEW

                If m_strAction <> "" Then
                    Call performReviewAction()
                    ' Added By NitinVS on 18 March 2005 for PBNITE SP2
                    Call RefreshParent()
                    ' End Addition By NitinVS on 18 March 2005 for PBNITE SP2 

                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                ' Modified By NitinVS on 24 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 
                ' To show save link if user has edit access to the page 
                If m_blnEditAccess = True Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("ReviewSave_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('467')")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'initialize the resource file for issue assignment page.
                MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_REVIEW"))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_REVIEW") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen for document upload
                Call plotDocumentReviewScreen()

                'plot the lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

                'If m_strAction <> "" Then
                '    General.WriteHTML("<Script language=javascript>")
                '    General.WriteHTML("opener.location.href=opener.location.href;")
                '    General.WriteHTML("window.close();")
                '    General.WriteHTML("</Script>")
                'End If

            Case CONST_MODE_ATTACHURL

                If m_strAction <> "" Then
                    Call performAttachURLAction()

                    ' Modified By NitinVS on 8 March 2005 
                    ' To Refresh Parent page when the Page is called from other than Project Documents
                    'write client side script to refresh parent
                    Call RefreshParent()
                    ' End Modification By NitinVS on 8 March 2005 PBNITE SP2
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                If m_blnAddAccess = True Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_ATTACH_URL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ATTACH_URL_TOOLTIP")) : arrClientSideFunctions.Add("Attach_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'initialize the resource file for issue assignment page.
                MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_ATTACHURL"))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_ATTACHURL") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen for document upload
                Call plotAttachURLScreen()

                'plot the lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

                'If m_strAction <> "" Then
                '    General.WriteHTML("<Script language=javascript>")
                '    General.WriteHTML("opener.location.href=opener.location.href;")
                '    General.WriteHTML("window.close();")
                '    General.WriteHTML("</Script>")
                'End If

        End Select
        'Added by ArchanaN on 1-Oct-2010
        m_strExtensionList = CommonFunction.General.GetFileExtnListForTag(m_intTagID)
        'End of Added by ArchanaN on 1-Oct-2010
        objGlobal = Nothing

        ''Added by Yogesh J on 29-Jan-2016 to generatte Token
        'm_PKToken = CommonFunctions.Security.Token.GetToken(CType(Session("intProjectID").ToString, String) + CType(m_strDocumentcategoryID, String) + CType(m_strsubCategoryID, String) + "0" + "0")
        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Session("intProjectID").ToString, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_intTagID, String))


        ''End of addition by Yogesh J on 29-Jan-2016 to generatte Token
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotDocumentListGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls to show list of documents 
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 26 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotDocumentListGrid()
        Dim arrlstColHeader As Collections.ArrayList
        Dim arrlstAN As Collections.ArrayList
        Dim arrlstRowLink As Collections.ArrayList
        Dim arrlstTDStyle As Collections.ArrayList
        Dim arrlstCheckBox As Collections.ArrayList
        Dim strSQL As String
        Dim intRowCount As Integer

        arrlstColHeader = New Collections.ArrayList
        arrlstAN = New Collections.ArrayList
        arrlstRowLink = New Collections.ArrayList
        arrlstTDStyle = New Collections.ArrayList
        arrlstCheckBox = New Collections.ArrayList

        'create the list of columns
        arrlstColHeader.Add(MyBase.GetResourceString("CAP_CATEGORY")) : arrlstColHeader.Add("Document Sub Category") : arrlstColHeader.Add(MyBase.GetResourceString("COL_DOCUMENT_NAME")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_UPLOAD_DATE")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_SIZE")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_LAST_MODIFIED")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_REVIEW")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_HISTORY"))
        arrlstAN.Add("Category") : arrlstAN.Add("SubCategory") : arrlstAN.Add("FileName") : arrlstAN.Add("UploadedDate") : arrlstAN.Add("FileSize") : arrlstAN.Add("UpdatedDate") : arrlstAN.Add(MyBase.GetResourceString("LINK_REVIEW")) : arrlstAN.Add(MyBase.GetResourceString("LINK_HISTORY"))
        arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("Document_OnClick(DocumentID)") : arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("Review_OnClick(DocumentID)") : arrlstRowLink.Add("History_OnClick(DocumentID,DocumentRefID)")
        arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("")

        'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15 
        'arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='right'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'")
        arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left' Style='vertical-align: top'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='right'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left' Style='vertical-align: top'") : arrlstTDStyle.Add("align='left' Style='vertical-align: top'")
        'Commented And Edited End by KIRAN K K  For footer line alignment 16-11-15 

        'set the delete column of the grid if user has delete access
        If m_blnDelAccess = True Then
            arrlstColHeader.Add(MyBase.GetResourceString("COL_DELETE"))
            arrlstAN.Add("")
            arrlstRowLink.Add("")
            'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15 
            ' arrlstTDStyle.Add("align='center'")
            arrlstTDStyle.Add("align='center' Style='vertical-align: top'")
            'Commented And Edited End by KIRAN K K  For footer line alignment 16-11-15  
            arrlstCheckBox.Add("chkDelete")
        End If

        Dim arrColHeader(arrlstColHeader.Count) As String
        Dim arrAN(arrlstAN.Count) As String
        Dim arrRowLink(arrlstRowLink.Count) As String
        Dim arrCheckBox(arrlstCheckBox.Count) As String
        Dim arrTDStyle(arrlstTDStyle.Count) As String
        Dim arrGroupOn() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        arrlstColHeader.CopyTo(arrColHeader)
        arrlstAN.CopyTo(arrAN)
        arrlstRowLink.CopyTo(arrRowLink)
        arrlstCheckBox.CopyTo(arrCheckBox)
        arrlstTDStyle.CopyTo(arrTDStyle)

        arrlstColHeader = Nothing
        arrlstAN = Nothing
        arrlstRowLink = Nothing
        arrlstTDStyle = Nothing
        arrlstCheckBox = Nothing

        'Modified By VarunA on 20-Jan-2008 RequestID-21539
        'Purpose : To have paging and text Search
        'strSQL = "usp_Sel_tbl_PM_ProjectDocuments " + m_strProjectID.Trim + ",NULL,NULL," + m_strRoleID.Trim
        strSQL = "usp_Sel_tbl_PM_ProjectDocuments " + m_strProjectID.Trim + ",NULL,NULL," + m_strRoleID.Trim + ",'" + CommonFunctions.General.BuildQueryString(m_strAlphabet.ToString) + "','" + CommonFunctions.General.BuildQueryString(m_strtxtSearch.ToString) + "'," + m_strDocumentcategoryID.ToString + "," + m_strsubCategoryID.ToString
        'End By VarunA on 20-Jan-2008 RequestID-21539

        'create Grid object and set the properties
        m_objGrid = New WebPage.Templates.GenericGrid
        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .RowLinkArray = arrRowLink
            .CheckBoxIDArray = arrCheckBox
            .GroupOnColumn = arrGroupOn
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "CheckBoxID"
            'Added By VarunA on 28-Aug-2009 RequestID-21539
            'Purpose : To have sorting on grid
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            'End By VarunA on 28-Aug-2009 RequestID-21539
            .DIVID = "DivList"
            .DIVHeight = 300
            .DIVStyle = "overflow: auto"
            .NoOfDataColumns = 6
            'Added By VarunA on 28-Aug-2009 RequestID-21539
            'Purpose : To have sorting on grid
            .ClientSideSortFunctionName = "Sort_OnClick"
            'End By VarunA on 28-Aug-2009 RequestID-21539
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = ""
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        intRowCount = m_objGrid.NoOfRows
        m_objGrid = Nothing

        'save the record count in the hidden control
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txthdRowCount", "txthdRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

    End Sub

    'In this event display the details of all documents bellow its TR only for the 
    'Detail mode of the page.Here TR is inserted bellow the parent TR for each property.
    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        Dim strClsTR As String

        If m_strMode = CONST_MODE_DETAIL Then

            Args.StringToBeInserted = "<TR class='" + Args.clsTR + "'><TD colspan=10>"
            Args.StringToBeInserted += "<B>" + MyBase.GetResourceString("CAP_UPLOADEDBY") + " : </B>" + Data.CheckIsDBNull(Args.DataReader("UploadedBy"), "").ToString
            Args.StringToBeInserted += "</TD></TR>"
            Args.StringToBeInserted += "<TR class='" + Args.clsTR + "'><TD colspan=10>"
            'Commented And Edited by KIRAN K K  For cross page scripting 16-11-15 
            'Args.StringToBeInserted += "<B>" + MyBase.GetResourceString("CAP_COMMENTS") + " : </B>" + Data.CheckIsDBNull(Args.DataReader("Description"), "").ToString
            Args.StringToBeInserted += "<B>" + MyBase.GetResourceString("CAP_COMMENTS") + " : </B>" + Server.HtmlEncode(Data.CheckIsDBNull(Args.DataReader("Description"), "").ToString)
            'Commented And Edited by KIRAN K K  For cross page scripting 16-11-15 
            Args.StringToBeInserted += "</TD></TR>"

            If Not IsDBNull(Args.DataReader("ReviewedDate")) Then
                If Args.DataReader("ReviewedDate").ToString <> "" Then
                    Args.StringToBeInserted = "<TR class='" + Args.clsTR + "'><TD colspan=10>"
                    Args.StringToBeInserted += "<B>" + MyBase.GetResourceString("CAP_REVIEWEDBY") + " : </B>" + Data.CheckIsDBNull(Args.DataReader("ReviewedBy"), "").ToString
                    Args.StringToBeInserted += "</TD></TR>"
                    Args.StringToBeInserted += "<TR class='" + Args.clsTR + "'><TD colspan=10>"
                    Args.StringToBeInserted += "<B>" + MyBase.GetResourceString("CAP_REVIEW_DATE") + " : </B>" + Data.CheckIsDBNull(Args.DataReader("ReviewedDate"), "").ToString
                    Args.StringToBeInserted += "</TD></TR>"
                    'Modified & Commented By VarunA on 2-June-2008
                    'Purpose : To have ReviewDate and Review Comment as bold, as it was converting in HTML Encode.
                    'Args.StringToBeInserted += "<TR class='" + Args.clsTR + "'><TD colspan=9><PRE>"
                    Args.StringToBeInserted += "<TR class='" + Args.clsTR + "'><TD colspan=10>"
                    'Commented and Modified By JyotiG
                    'Start_JG_12485_28-Mar-2007
                    'Args.StringToBeInserted += "<B>" + MyBase.GetResourceString("CAP_REVIEW_COMMENTS") + " : </B>" + Data.CheckIsDBNull(Args.DataReader("ReviewNotes"), "").ToString
                    'Commented  BY Shamkant S For IssueId 3151 on 12 Feb 2016
                    Args.StringToBeInserted += "<B>" + MyBase.GetResourceString("CAP_REVIEW_COMMENTS") + " : </B>" + CommonFunction.General.FormatString(Data.CheckIsDBNull(Args.DataReader("ReviewNotes"), "").ToString)
                    '  Args.StringToBeInserted += "<B>" + MyBase.GetResourceString("CAP_REVIEW_COMMENTS") + " : </B>" + Server.HtmlEncode(CommonFunction.General.FormatString(Data.CheckIsDBNull(Args.DataReader("ReviewNotes"), "").ToString, False))
                    'Commented Ended  BY Shamkant S For IssueId 3151 on 12 Feb 2016
                    'End_JG_12485_28-Mar-2007
                    'Args.StringToBeInserted += "</PRE></TD></TR>"
                    Args.StringToBeInserted += "</TD></TR>"
                    'End By VarunA on 2-June-2008
                End If
            End If
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "FILENAME" Then
            If CType(Data.CheckIsDBNull(Args.DataReader("IsURL"), "0"), Boolean) <> True Then
                'Args.StringToBeInserted = "<TD align='left'><A href='../../Documents/" + Args.DataReader("DirectoryName").ToString + "\" + Args.DataReader("FileName").ToString + "' target=_new >" + Args.DataReader("FileName").ToString + "</A></TD>"
            Else
                Args.StringToBeInserted = "<TD align='left'><A href='" + Args.DataReader("FileName").ToString + "' target=_new >" + Args.DataReader("FileName").ToString + "</A></TD>"
                Cancel = True
            End If
        ElseIf Args.ColumnName = MyBase.GetResourceString("COL_HISTORY") Or Args.ColumnName = MyBase.GetResourceString("COL_REVIEW") Then
            If CType(Data.CheckIsDBNull(Args.DataReader("IsURL"), "0"), Boolean) = True Then
                Args.StringToBeInserted = "<TD align='left'></TD>"
                Cancel = True
            End If
        End If
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotDocumentHistoryScreen
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls to show the history records  of the document
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 1 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotDocumentHistoryScreen()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim objFile As CommonFunction.FileDirectory
        Dim objLink As WebPage.UI.cDynamicLink
        Dim strFileName As String
        Dim strDocumentCategory As String
        Dim strTRClass As String
        Dim intRowCount As Integer
        Dim strFilePath As String
        Dim blnFileExists As Boolean

        'get document category from the database
        strDocumentCategory = ""
        strSQL = "usp_Sel_tbl_PM_ProjectDocuments " + m_strProjectID.Trim + "," + m_strDocumentID.Trim
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            strDocumentCategory = Data.CheckIsDBNull(objDr("Category"), "").ToString + ""
        End If
        Data.DisposeDataReader(objDr)

        'display document category
        General.WriteHTML("<Table width=99.9% class='clsTable' cellpadding=0 cellspacing=0 >")
        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("CAP_CATEGORY") + " : </B> ")
        'Modified By nitinVS on 24 apr 2007 for WhizibleSEM SP 8 Regression Fixes IssueID 12513 
        ' Added Server.HTMENCODE 
        General.WriteHTML(Server.HtmlEncode(strDocumentCategory.Trim) + "</TD>")
        'End Modification By nitinVS on 24 apr 2007 for WhizibleSEM SP 8 Regression Fixes IssueID 12513 
        General.WriteHTML("</TR></Table>")

        'display the grid for document history details
        General.WriteHTML("<div id='DivList' width=100% height=90% style='overflow: auto;'>")
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

        'get the data for each document history record
        intRowCount = 0
        objFile = New CommonFunction.FileDirectory
        objLink = New WebPage.UI.cDynamicLink
        objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        objLink.ReturnHTML = True

        strSQL = "usp_Sel_tbl_PM_ProjectDocuments " + m_strProjectID.Trim + "," + m_strDocumentID.Trim
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDr.Read

            If intRowCount Mod 2 = 0 Then strTRClass = "clsTREven" Else strTRClass = "clsTROdd"

            strFilePath = Server.MapPath("../../Documents/") + Data.CheckIsDBNull(objDr("DirectoryName"), "").ToString + "\" + Data.CheckIsDBNull(objDr("FileName"), "").ToString
            If objFile.IsFileExists(strFilePath.Trim) = True Then
                blnFileExists = True
            Else
                blnFileExists = False
            End If

            'display file name
            General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
            General.WriteHTML("<TD width=25% align='right' ><B>" + MyBase.GetResourceString("COL_FILE_NAME") + "</B>&nbsp;</TD>")
            General.WriteHTML("<TD align='left'>" + Data.CheckIsDBNull(objDr("FileName"), "").ToString + "</TD>")

            'if file exists then show the download link
            If blnFileExists = True Then
                objLink.LinkName = MyBase.GetResourceString("LINK_DOWNLOAD") + ""
                objLink.FunctionName = "Download_OnClick('" + objDr("DocumentID").ToString + "')"
                objLink.Tooltip = MyBase.GetResourceString("LINK_DOWNLOAD_TOOLTIP") + ""
                General.WriteHTML("<TD></TD><TD align='right'>| " + objLink.GetDynamicLink() + " |</TD>")
            Else
                General.WriteHTML("<TD></TD><TD></TD>")
            End If
            General.WriteHTML("</TR>")

            'show uploaded by and file size
            General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
            General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("COL_UPLOAD_DATE") + "</B>&nbsp;</TD>")
            General.WriteHTML("<TD align='left'>" + Dates.GetDate(CType(Data.CheckIsDBNull(objDr("UploadedDate"), ""), Date)) + "</TD>")
            If blnFileExists = True Then
                General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("COL_FILE_SIZE") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left'>" + Data.CheckIsDBNull(objDr("FileSize"), "").ToString + " " + MyBase.GetResourceString("KB") + "</TD>")
            Else
                General.WriteHTML("<TD></TD><TD></TD>")
            End If
            General.WriteHTML("</TR>")

            'display Last modified
            General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
            General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("COL_LAST_MODIFIED") + "</B>&nbsp;</TD>")
            'Commented and Modified by JyotiG
            'Start
            'Issue Id : 6651
            'General.WriteHTML("<TD align='left' colspan=3>" + Dates.GetDate(CType(Data.CheckIsDBNull(objDr("UpdatedDate"), ""), Date)) + "</TD>")
            Dim strDate As String
            If CStr(CommonFunctions.Data.CheckIsDBNull(objDr("UpdatedDate"), "")) = "" Then
                strDate = ""
            Else
                strDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(objDr("UpdatedDate"), "").ToString))
            End If
            General.WriteHTML("<TD align='left' colspan=3>" + strDate + "</TD>")
            'End
            General.WriteHTML("</TR>")

            'display Comments
            General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
            General.WriteHTML("<TD align='right' valign='top'><B>" + MyBase.GetResourceString("CAP_DESC") + "</B>&nbsp;</TD>")
            'Commented and Modified By JyotiG
            'Start_JG_12485_03-Apr-2007
            'General.WriteHTML("<TD align='left' colspan=3>" + Data.CheckIsDBNull(objDr("Description"), "").ToString + "</TD>")
            General.WriteHTML("<TD align='left' colspan=3>" + CommonFunction.General.FormatString(Data.CheckIsDBNull(objDr("Description"), "").ToString) + "</TD>")
            'End_JG_12485_03-Apr-2007
            General.WriteHTML("</TR>")

            'display uploaded by
            General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
            General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_UPLOADEDBY") + "</B>&nbsp;</TD>")
            General.WriteHTML("<TD align='left' colspan=3>" + Data.CheckIsDBNull(objDr("UploadedBy"), "").ToString + "</TD>")
            General.WriteHTML("</TR>")

            'display the reviewd date and reviewed by if reviewed date is present
            If Not IsDBNull(objDr("ReviewedBy")) Then
                General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_REVIEWEDBY") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left'>" + Data.CheckIsDBNull(objDr("ReviewedBy"), "").ToString + "</TD>")
                General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_REVIEW_DATE") + "</B>&nbsp;</TD>")
                General.WriteHTML("<TD align='left'>" + Dates.GetDate(CType(Data.CheckIsDBNull(objDr("ReviewedDate"), ""), Date)) + "</TD>")
                General.WriteHTML("</TR>")
                'display Review Notes
                General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                General.WriteHTML("<TD align='right'valign='top'><B>" + MyBase.GetResourceString("CAP_REVIEW_COMMENTS") + "</B></TD>")
                '  Commented  by Viraj P on 17 Nov 2015 Purpose HTML Ecoding
                'Commented  BY Shamkant S For IssueId 3151 on 12 Feb 2016
                General.WriteHTML("<TD align='left' colspan=3>" + Data.CheckIsDBNull(objDr("ReviewNotes"), " ").ToString + "</TD>")
                ' General.WriteHTML("<TD align='left' colspan=3>" + Server.HtmlEncode(Data.CheckIsDBNull(objDr("ReviewNotes"), " ").ToString) + "</TD>")
                'Commented Ended BY Shamkant S For IssueId 3151 on 12 Feb 2016
                'End of Comment  by Viraj P on 17 Nov 2015
                General.WriteHTML("</TR>")
            End If

            'if user has delete access then show the delete checkbox column
            If m_blnDelAccess = True Then
                If Not IsDBNull(objDr("DocumentRefID")) Then
                    General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
                    General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("COL_DELETE") + "</B>&nbsp;</TD>")
                    General.WriteHTML("<TD align='left' colspan=3>")
                    General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , objDr("DocumentID").ToString, , , True))
                    General.WriteHTML("</TD></TR>")
                End If
            End If

            'increament the row conter
            intRowCount += 1
        End While
        Data.DisposeDataReader(objDr)
        objLink = Nothing
        objFile = Nothing

        'if no rows printed then display message 
        If intRowCount < 1 Then
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='center' colspan=4 >")
            General.WriteHTML(MyBase.GetResourceString("NORECORDFOUND"))
            General.WriteHTML("</TD></TR>")
        End If

        'close the table
        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'save the record count in the hidden control
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txthdRowCount", "txthdRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

    End Sub

    '=====================================================================
    ' Procedure Name		:	performAction
    ' Parameters Passed		:	strWhatToDelete - String
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database based on the action specified.
    ' Description			:	Here document record is deleted for the selected documents from the database.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 2 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction(ByVal strWhatToDelete As String)
        Dim strSQL As String
        Dim strDocumentIDList As String
        Dim arrDocumentID() As String
        Dim objDr As IDataReader
        Dim objFile As CommonFunction.FileDirectory
        Dim strFilePath As String

        'get the quama seperated list of selected document IDs
        strDocumentIDList = MyBase.GetFormValue("chkDelete") + ""

        Select Case m_strAction
            Case CONST_ACTION_DELETE
                If strDocumentIDList <> "" Then
                    objFile = New CommonFunction.FileDirectory

                    arrDocumentID = Split(strDocumentIDList, ",")
                    Dim i As Integer
                    For i = 0 To arrDocumentID.Length - 1

                        strSQL = "usp_Sel_tbl_PM_ProjectDocuments " + m_strProjectID.Trim + "," + arrDocumentID(i).Trim + ",'" + strWhatToDelete.Trim + "'"
                        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        While objDr.Read
                            strSQL = "usp_Del_tbl_PM_ProjectDocuments " + objDr("DocumentID").ToString + ""
                            Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                            'document is not URL then delete the physical file also
                            If CType(Data.CheckIsDBNull(objDr("IsURL"), "0"), Boolean) = False Then
                                'if physical deletion is allowed then delete the file from disk
                                If CommonFunction.Application.PhysicalDeletionOfDocuments = True Then
                                    strFilePath = "../../Documents/" + Data.CheckIsDBNull(objDr("DirectoryName"), "").ToString + "/" + Data.CheckIsDBNull(objDr("FileName"), "").ToString
                                    strFilePath = Server.MapPath(strFilePath)
                                    objFile.DeleteFile(strFilePath.Trim)
                                End If
                            End If

                        End While
                        Data.DisposeDataReader(objDr)

                    Next
                    objFile = Nothing
                End If
        End Select

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotDocumentUploadScreen
    ' Parameters Passed		:	plotDocumentUploadScreen
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls for the upload mode of the page.
    ' Description			:	Here HTML file control is plotted to select the file from the disk.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 2 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotDocumentUploadScreen()
        'Dim strSQL As String
        'Dim strCategory As String
        'Dim strChangeRequest As String
        'Dim strDesc As String

        'General.WriteHTML("<Div id='DivList' width=100% height=90% style='overflow: auto;' >")
        'General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

        ''display the file control
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_SELECT_DOCUMENT") + "</TD>")
        'General.WriteHTML("</TR>")
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='left'>" + HTMLControls.DrawFileControl("txtFileName", "txtFileName", "clsFileControl", 60, , , , , , , True) + "</TD>")
        'General.WriteHTML("</TR>")

        ''display document category combo
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_DOCUMENT_CATEGORY") + "</TD>")
        'General.WriteHTML("</TR>")
        'General.WriteHTML("<TR class='clsTREven'>")
        'strSQL = "usp_Sel_tbl_PM_DocumentCategory_ForRole " + m_strRoleID.Trim + "," + m_strProjectID.Trim
        ''General.WriteHTML("<TD align='left'>" + HTMLControls.DrawComboBox("cboCategory", strSQL, 450, , , True, True, , True) + "</TD>")
        '' Code Modified by MrugajaB on 2nd Mar 2005
        ''General.WriteHTML("<TD align='left'>" + HTMLControls.DrawComboBox("cboCategory", strSQL, 450, , , True, True, , True) + "</TD>")
        'General.WriteHTML("<TD align='left'>" + HTMLControls.DrawComboBox("cboCategory", strSQL, 400, m_strcategoryID.ToString, "onchange = 'cboCategory_OnChange()'", True, True, , True) + "</TD>")
        '' End Modification
        'General.WriteHTML("</TR>")

        '' Code Added by MrugajaB on 3rd Mar 2005 for Document Sub category
        ''display document Sub category combo
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_DOCUMENT_SUBCATEGORY") + "</TD>")
        'General.WriteHTML("</TR>")
        'General.WriteHTML("<TR class='clsTREven'>")
        ''Modified By NitinVS on 2 Apr 2005 for PBNITE SP2 Issue ID 17152 
        ''To Show document Sub Category of categories selected for the Project 
        ''strSQL = "usp_Sel_tbl_PM_DocumentSubCategory " + m_strcategoryID.Trim
        'If m_strcategoryID.Trim = "" Then
        '    m_strcategoryID = "Null"
        'End If
        'strSQL = "usp_Sel_tbl_PM_DocumentSubCategory " + m_strcategoryID.Trim + " , Null , " + m_strProjectID
        'm_strcategoryID = ""
        ''End Modification By NitinVS on 2 Apr 2005 for PBNITE SP2 Issue ID 17152 
        'General.WriteHTML("<TD id='tdSubCategory' align='left'>" + HTMLControls.DrawComboBox("cboSubCategory", strSQL, 400, , , True, True, , False) + "</TD>")
        'General.WriteHTML("</TR>")
        '' End of Addition

        ''display change request combo
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_CHANGE_REQUEST") + "</TD>")
        'General.WriteHTML("</TR>")
        'General.WriteHTML("<TR class='clsTREven'>")
        'strSQL = "usp_Sel_tbl_PM_ChangeRequest_Master " + m_strProjectID.Trim
        'General.WriteHTML("<TD align='left'>" + HTMLControls.DrawComboBox("cboChangeRequest", strSQL, 450, , , True, True) + "</TD>")
        'General.WriteHTML("</TR>")

        ''display discription textarea
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_DESC") + "</TD>")
        'General.WriteHTML("</TR>")
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='left'>" + HTMLControls.DrawTextArea("txtDescription", "txtDescription", MyBase.GetResourceString("CAP_DESC"), , , "frmProjectDocuments", , , 450, 50, , , , , , , , , , True, True) + "</TD>")
        ''Modified By NitinVS  on 27 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12515 
        '' Removed the TD Code 
        ''Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197
        ''Purpose:Hidden variable that will store value of token that is passed in edit mode from Task List Page
        'General.WriteHTML(HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True))
        'General.WriteHTML(HTMLControls.DrawTextBox("txthidParentToken", "txthidParentToken", value:=m_strParentToken, returnHTML:=True, IsHidden:=True))
        ''End Addition
        ''End Modification By NitinVS  on 27 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12515 
        'General.WriteHTML("</TR>")

        'General.WriteHTML("</Table>")

        'General.WriteHTML("<Table id='tblMsg' class='clsTable' width=99.9% cellspacing=0 cellpadding=0 style='Display: none;'>")
        'General.WriteHTML("<TR class='clsTROdd'><TD align='center'>Uploading file,Please wait...</TD></TR>")
        'General.WriteHTML("</Table>")

        'General.WriteHTML("</div>")

        ''write client side script to set focus on the filename textbox
        'General.WriteHTML("<Script language=javascript>")
        'General.WriteHTML(" var objTxt =  GetObjectReference('frmProjectDocuments','txtFileName');")
        'General.WriteHTML(" if(objTxt!=null) objTxt.focus(); ")
        'General.WriteHTML("</Script>")


        'Added by NitinC on 29 March 2011 for WhizibleSEM 10.0
        Dim strSQL As String
        Dim strCategory As String
        Dim strChangeRequest As String
        Dim strDesc As String

        With Response
            '.Write(strMenu)
            .Write("<BR>")

            .Write("<DIV ID='divList' Style='Height:270px;WIDTH:100%;OVERFLOW:auto;'>")

            .Write("<TABLE id='tblFileAttachment' cellspacing=0 class=clsTable style='Width:99.9%;visibility:visible;DISPLAY: inline'>")
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("<B>Note : </B> User can attach maximum three files at a time.")
            .Write("</TD>")
            .Write("</TR>")


            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            General.WriteHTML("<BR>")
            .Write("<B>" + "Select File" + "</B>")
            .Write("</TD>")
            .Write("</TR>")

            ' the file control

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()' onchange='forOnchange(this)'")
            .Write("</TD>")
            .Write("</TR>")

            CommonFunctions.General.WriteHTML("<tr class=clsTREven id=AttFileHead style='display:none' ><td><B>Attached Files</B></td></tr><TR class=clsTREven ><TD><BR><table id=tblFiles style='display:none;width=85%;' class=clsGridTable><thead class=clsTRColumnHeader align='left'><th>Files</th><th >Select document category</th><th >select document sub category</th><th >Change Request</th><th >Comment</th><th width=100></th></thead></table></TD></TR>")

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'Purpose:Hidden variable that will store value of token that is passed in edit mode from Task List Page
            General.WriteHTML(HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txthidParentToken", "txthidParentToken", value:=m_strParentToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            'General.WriteHTML(HTMLControls.DrawTextBox("txthidFileCount", "txthidFileCount", value:=0, returnHTML:=True, IsHidden:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txthidcboCategory", "txthidcboCategory", , returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txthidcboSubCategory", "txthidcboSubCategory", , returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txthidcboChangeRequest", "txthidcboChangeRequest", , returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            ' comments
            .Write("<TR class=clsTREven>")
            .Write("<TD>")

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , m_intTagID.ToString, IsHidden:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")

            ' Message Table
            .Write("<TABLE id=tblFileUploadStatus cellspacing=1 height='90%' Width='99.9%' class=clsTable style='visibility:visible;display:none'>")
            .Write("<TR>")
            .Write("<TD height='20'>")
            .Write("&nbsp;</TD></TR>")
            .Write("<TR><TD align=center class=clsTDEven>")
            .Write("<LABEL id=lblFileUploadStatus><B>Uploading file(s)...Please wait !!</B></LABEL>")
            .Write("</TD></TR>")
            .Write("</TABLE>")

            .Write("</DIV>")
            .Write("<BR>")
            '.Write(strMenu)
        End With



        'write client side script to set focus on the filename textbox
        General.WriteHTML("<Script language=javascript>")
        General.WriteHTML(" var objTxt =  GetObjectReference('frmProjectDocuments','txtFileName');")
        General.WriteHTML(" if(objTxt!=null) objTxt.focus(); ")

        General.WriteHTML(" var FileCount=0; ")
        General.WriteHTML(" var FileCount_toDisable = 0; ")
        General.WriteHTML(" function addFileinGrid() ")
        General.WriteHTML(" { ")
        General.WriteHTML(" //debugger; ")
        General.WriteHTML("  var objtxtFileName = GetObjectReference('frmAttachment','txtFileName'+FileCount); ")
        General.WriteHTML(" var objFileGrid = GetObjectReference('frmAttachment','tblFiles'); ")
        General.WriteHTML(" objFileGrid.style.display=""""; ")
        General.WriteHTML(" var newRow  = objFileGrid.insertRow(objFileGrid.rows.length); ")

        General.WriteHTML(" newRow.id='FILENAME'+FileCount; ")
        General.WriteHTML(" newRow.name='txtFileName'; ")
        General.WriteHTML(" newRow.className = ""clsTREven""; ")
        General.WriteHTML(" var newCell = newRow.insertCell(0); ")

        General.WriteHTML(" var fileName = objtxtFileName.value; ")
        General.WriteHTML(" var index = fileName.lastIndexOf(""\\""); ")
        General.WriteHTML(" if (index==-1) ")
        General.WriteHTML(" index = fileName.lastIndexOf(""/""); ")

        General.WriteHTML(" if (index != -1) ")
        General.WriteHTML(" fileName = fileName.substring(index+1,fileName.length); ")

        General.WriteHTML(" newCell.innerHTML=fileName;  ")

        'display document category combo
        General.WriteHTML(" newCell = newRow.insertCell(1); ")
        strSQL = "usp_Sel_tbl_PM_DocumentCategory_ForRole " + m_strRoleID.Trim + "," + m_strProjectID.Trim
        General.WriteHTML(" newCell.innerHTML='" + HTMLControls.DrawComboBox("cboCategory", strSQL, , m_strcategoryID.ToString, "onchange = ""cboCategory_OnChange('+ FileCount + ')""", False, True, , True) + "'; ")
        General.WriteHTML(" newCell.firstChild.id='cboCategory'+FileCount;  ")
        General.WriteHTML(" newCell.firstChild.name='cboCategory'+FileCount; //debugger ")
        General.WriteHTML(" var objCbo = GetObjectReference('frmPM_UploadDocument','cboCategory'+FileCount);  ")
        General.WriteHTML(" var opt = document.createElement(""option"");")
        'General.WriteHTML(" objCbo.options.insertAdjacentHTML(opt,objCbo.options[0]) ")
        General.WriteHTML(" opt.text = ''; ")
        General.WriteHTML(" opt.value = ''; ")
        General.WriteHTML(" objCbo.selectedIndex = 0; ")
        General.WriteHTML(" objCbo.style.width = 175; ")



        'display document Sub category combo
        If m_strcategoryID.Trim = "" Then
            m_strcategoryID = "Null"
        End If
        strSQL = "usp_Sel_tbl_PM_DocumentSubCategory " + m_strcategoryID.Trim + " , Null , " + m_strProjectID
        m_strcategoryID = ""
        General.WriteHTML(" newCell = newRow.insertCell(2); ")
        General.WriteHTML(" newCell.id = ""tdSubCategory""+FileCount ")
        General.WriteHTML(" newCell.innerHTML='" + HTMLControls.DrawComboBox("cboSubCategory", strSQL, , , , False, True, , False) + "'; ")
        General.WriteHTML(" newCell.firstChild.id='cboSubCategory'+FileCount;  ")
        General.WriteHTML(" newCell.firstChild.name='cboSubCategory'+FileCount;  ")
        General.WriteHTML(" var objSubCbo = GetObjectReference('frmPM_UploadDocument','cboSubCategory'+FileCount);  ")
        General.WriteHTML(" var op = document.createElement(""option"");   ")
        '   General.WriteHTML(" objSubCbo.options.insertBefore(op,objSubCbo.options[0]) ")
        General.WriteHTML(" op.text = ''; ")
        General.WriteHTML(" op.value = ''; ")
        General.WriteHTML(" objSubCbo.selectedIndex = 0; ")
        General.WriteHTML(" objSubCbo.style.width = 175; ")

        'display change request combo
        strSQL = "usp_Sel_tbl_PM_ChangeRequest_Master " + m_strProjectID.Trim
        General.WriteHTML(" newCell = newRow.insertCell(3); ")
        General.WriteHTML(" newCell.innerHTML='" + HTMLControls.DrawComboBox("cboChangeRequest", strSQL, , , , False, True) + "'; ")
        General.WriteHTML(" newCell.firstChild.id='cboChangeRequest'+FileCount;  ")
        General.WriteHTML(" newCell.firstChild.name='cboChangeRequest'+FileCount;  ")
        General.WriteHTML(" var objReqCbo = GetObjectReference('frmPM_UploadDocument','cboChangeRequest'+FileCount);  ")
        General.WriteHTML(" var opr = document.createElement(""option"");   ")
        ' General.WriteHTML(" objReqCbo.options.insertBefore(opr,objReqCbo.options[0]) ")
        General.WriteHTML(" opr.text = ''; ")
        General.WriteHTML(" opr.value = ''; ")
        General.WriteHTML(" objReqCbo.selectedIndex = 0; ")
        General.WriteHTML(" objReqCbo.style.width = 175; ")

        'display Comment textarea control
        General.WriteHTML(" newCell = newRow.insertCell(4); ")
        General.WriteHTML(" newCell.innerHTML=""<Textarea wrap='Hard'  name='txtComments' id='txtComments' class='clsTextArea' style='width:250px  ; height:50px  ; text-align:Left'  ></Textarea>""; ")


        General.WriteHTML(" newCell = newRow.insertCell(5); ")
        ' //Purpose: Replaced tooltip -> Upload to Remove Attachment
        General.WriteHTML(" newCell.innerHTML=""<A class='Menu' style='' HREF='Javascript:RemoveAttachement("" + FileCount + "")' Title='Remove Attachment' >(Remove)</A>""; ")


        General.WriteHTML(" parentTD = objtxtFileName.parentNode; ")
        General.WriteHTML(" objtxtFileName.style.display = 'none'; ")

        General.WriteHTML(" FileCount++; ")
        General.WriteHTML(" FileCount_toDisable++; ")

        General.WriteHTML(" var FileControl; ")
        General.WriteHTML(" FileControl=document.createElement(""INPUT""); ")
        General.WriteHTML(" FileControl.type=""FILE"" ;")
        General.WriteHTML(" FileControl.id=""txtFileName""+FileCount; ")
        General.WriteHTML(" FileControl.name=""txtFileName""+FileCount; ")
        General.WriteHTML(" FileControl.className = 'clsTextBox'; ")
        General.WriteHTML(" FileControl.size=74; ")
        'General.WriteHTML(" FileControl.attribute='forOnchange(this)'; ")
        General.WriteHTML(" FileControl.setAttribute('onchange', 'forOnchange(this);'); ")

        General.WriteHTML(" FileControl.onkeydown=function(){return false;}; ")
        General.WriteHTML(" FileControl.onbeforepaste=function(){return false;}; ")
        General.WriteHTML(" FileControl.onpaste=function(){return false;}; ")
        General.WriteHTML(" FileControl.onkeydown=function(){return txtFileName_onkeydown();}; ")
        General.WriteHTML(" FileControl.onbeforepaste=function(){return txtFileName_onbeforepaste();}; ")
        General.WriteHTML(" FileControl.onpaste=function(){return txtFileName_onpaste();}; ")
        'General.WriteHTML(" FileControl.onchange=forOnchange; ")

        General.WriteHTML(" if (FileCount_toDisable==3) ")
        General.WriteHTML(" FileControl.disabled=true; ")

        General.WriteHTML(" parentTD.appendChild(FileControl); ")
        'General.WriteHTML(" FileControl.fireEvent('onclick'); ")


        General.WriteHTML(" } ")

        General.WriteHTML(" </Script> ")



        'End of Added by NitinC on 29 March 2011 for WhizibleSEM 10.0

    End Sub
    Private Shared Function GetResponse(uri As String, data As Byte()) As String

        Try
            Dim request As HttpWebRequest = TryCast(HttpWebRequest.Create(New Uri(uri)), HttpWebRequest)
            request.KeepAlive = False
            'request.UserAgent = WhatsConstants.UserAgent;
            request.Method = "POST"
            request.Accept = "text/json"
            request.ContentType = "application/x-www-form-urlencoded"
            request.ContentLength = data.Length
            'Dim stream As Stream = New MemoryStream(byteArray)
            ' request.BeginGetRequestStream(New AsyncCallback(AddressOf GetRequestStreamCallback), request)
            request.GetRequestStream().Write(data, 0, data.Length)
            Using reader = New System.IO.StreamReader(request.GetResponse().GetResponseStream())

                Return reader.ReadLine()
            End Using

        Catch ex As System.Net.WebException
            '   MessageBox.Show(ex.Message, "Error Message", MessageBoxButtons.OK, MessageBoxIcon.[Error])
            'var response = ex.Response as HttpWebResponse;
            'ServiceData fex = new ServiceData();
            'throw new FaultException<ServiceData>(fex,new FaultReason(fex.ErrorDetails));
            Return ""
        End Try
        ' allDone.WaitOne()


    End Function
    '=====================================================================
    ' Procedure Name		:	performUploadAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To upload the file given by the user and update the database with the entry.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 2 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performUploadAction()
        Dim strSQL As String
        Dim strFileName As String
        Dim strCategory As String
        Dim strDescription As String
        Dim strChangeRequest As String
        Dim objFileUpload As FileUpload.cUpload
        Dim objFile As CommonFunction.FileDirectory.FileProperties
        Dim dblFileSize As Double
        Dim strCreatedDate As String
        Dim strLastModifiedDate As String
        Dim strOldFileName As String
        Dim strUploadedFileName As String
        Dim strFilePath As String
        Dim strDirectoryName As String

        ' Code Added by MrugajaB on 2nd Mar 2005
        Dim strCodeTemplate As String
        Dim intSrNo As Integer
        ' End of Addition

        ' Added By NitinVS on 12 March 2005 PBNITE SP2
        ' To save the Document code
        Dim objDR As IDataReader
        Dim strDocumentCode As String
        '  End Addition By NitinVS on 12 March 2005 PBNITE SP2

        'Added by NitinC on 01 April 2011 for WhizibleSEM 10.0
        Dim count As Integer
        count = 0
        Dim i As Integer
        Dim hidcboCategory() As String
        Dim hidcboSubCategory() As String
        Dim hidcboChangeRequest() As String
        Dim arrDescription() As String

        'Modified by Chakshuta H on 20th-Oct-2015 Purpose::startIndex cannot be larger than length of string.Parameter name : startIndex()
        If MyBase.GetFormValue("txthidcboCategory") <> "" Then
            hidcboCategory = MyBase.GetFormValue("txthidcboCategory").Substring(1).Split(",")
        End If
        If MyBase.GetFormValue("txthidcboSubCategory") <> "" Then
            hidcboSubCategory = MyBase.GetFormValue("txthidcboSubCategory").Substring(1).Split(",")
        End If
        If MyBase.GetFormValue("txthidcboChangeRequest") <> "" Then
            hidcboChangeRequest = MyBase.GetFormValue("txthidcboChangeRequest").Substring(1).Split(",")
        End If
        'End Of Modified by Chakshuta H on 20th-Oct-2015 
        arrDescription = MyBase.GetFormValue("txtComments").Split(",")
        'While Request.Files.Count > count

        For i = 0 To hidcboCategory.Length - 1
            'End of Added by NitinC on 01 April 2011 for WhizibleSEM 10.0

            ' Code Added by MrugajaB on 2nd Mar 2005 for Adding Sub category
            Dim strSubCategory As String

            'Commented and added by NitinC on 01 April 2011 for WhizibleSEM 10.0
            'strSubCategory = MyBase.GetFormValue("cboSubCategory") + ""
            ' Addition Ends
            strSubCategory = hidcboSubCategory(i).ToString + ""
            'End of Commented and added by NitinC on 01 April 2011 for WhizibleSEM 10.0

            Dim m_ParentTagID As Long = 0

            'get the values from the form controls
            ''Commented and added by NitinC on 01 April 2011 for WhizibleSEM 10.0
            'strCategory = MyBase.GetFormValue("cboCategory") + ""
            'strChangeRequest = MyBase.GetFormValue("cboChangeRequest") + ""
            'strDescription = MyBase.GetFormValue("txtDescription") + ""
            strCategory = hidcboCategory(i).ToString + ""
            strChangeRequest = hidcboChangeRequest(i).ToString + ""
            strDescription = arrDescription(i).ToString + ""
            ''End of Commented and added by NitinC on 01 April 2011 for WhizibleSEM 10.0


            'Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197
            'Purpose:Before saving the record, the token must be validated
            'If ((CType(m_intUniqueID, String) <> "") And (CommonFunctions.Security.Token.ValidateToken(CType(m_intUniqueID, String) + CType(m_lngUserID, String) + CType(m_ParentTagID, String) + CType(m_intTagID, String), m_strToken) = True)) Or (m_intTagID <> "1038") Then
            If CommonFunctions.Security.Token.ValidateToken(CType(m_intUniqueID, String) + CType(m_lngUserID, String) + CType(m_ParentTagID, String) + CType(m_intTagID, String), m_strToken) = True Or m_strToken = "" Then
                'Added By JyotiG
                'Start_JG_12912_11-Apr-2007
                'Issue :Projects > Execute > Documents: Page crashes if the document name is long.
                Try
                    'End_JG_12912_11-Apr-2007
                    'get the name of the directory 
                    ' Code Modified by MrugajaB on 2nd Mar 2005 for Sub Directory
                    'strDirectoryName = CreateDirectoryStructure(CType(m_strProjectID, Long), CType(strCategory.Trim, Long))
                    ''Added by swapnil aswale on 15-06-2016
                    ''-------------------Commented BY Nikhi A---------------------------------
                    '''Dim response As String = String.Empty
                    '''Dim file As HttpPostedFile = Context.Request.Files(i)
                    '''Dim buffer As Byte() = New Byte(256) {}
                    '''Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
                    '''Dim MimeType As String
                    '''file.InputStream.Read(buffer, 0, 256)
                    '''file.InputStream.Position = 0
                    ''''Dim mimeKey = ConfigurationManager.AppSettings("MimeHostPath")
                    ''''Dim uri As String = String.Format(mimeKey)

                    ''''response = GetResponse(uri, buffer)
                    ''''Dim tokenJson = JsonConvert.SerializeObject(response)

                    ''''Dim jsonResult = JsonConvert.DeserializeObject(Of Dictionary(Of String, Object))(response)
                    ''''MimeType = jsonResult.Item("mime")

                    '''Dim logpath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)

                    ''''If strListofTypes.Contains("text/plain") Or strListofTypes.Contains("text/xml") Or strListofTypes.Contains("application/xml") Or strListofTypes.Contains("text/html") Then
                    ''''If MimeType = "text/plain" Or MimeType = "text/xml" Or MimeType = "application/xml" Or MimeType = "text/html" Then

                    ''''Else
                    ''''file.InputStream.Read(buffer, 0, 256)
                    '''Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))
                    '''Dim magicNumber As String = BitConverter.ToString(buffer)
                    '''magicNumber = magicNumber.Replace("-", " ")
                    '''Dim xmlDoc As New XmlDocument()
                    '''Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                    '''xmlDoc.Load(xmlPath + "MIMEType.xml")
                    '''Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                    '''Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""
                    '''Dim ext As String = ""

                    '''For Each node As XmlNode In nodes
                    '''    xMagicNumber = node.SelectSingleNode("MagicNumber").InnerText

                    '''    Dim xsubstring As String = magicNumber.Substring(0, Convert.ToInt32(xMagicNumber.Length))
                    '''    'If Convert.ToInt32(xMagicNumber.Length) > 25 Then
                    '''    '    xMagicNumber.Substring(0, 25)
                    '''    'End If

                    '''    ''----------------------------------------
                    '''    If xsubstring = xMagicNumber Then
                    '''        extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower()
                    '''        Dim fileName As String = file.FileName
                    '''        ext = Path.GetExtension(fileName)
                    '''        ext = ext.Substring(1, ext.Length - 1)
                    '''        If extfromContentType.IndexOf(ext) > -1 Then
                    '''            MimeType = strFileType
                    '''        End If
                    '''        'MimeType = node.SelectSingleNode("ContentType").InnerText
                    '''        Exit For
                    '''    Else
                    '''        'Dim file1 As HttpPostedFile = Context.Request.Files(i)
                    '''        Dim fileName As String = file.FileName
                    '''        ext = Path.GetExtension(fileName)
                    '''        ext = ext.Substring(1, ext.Length - 1)
                    '''        If ext = xMagicNumber Then
                    '''            MimeType = node.SelectSingleNode("ContentType").InnerText
                    '''        End If
                    '''    End If
                    '''    ''----------------------------------------------------
                    '''Next
                    ''-------------------Commented BY Nikhi A---------------------------------
                    Dim buffer As Byte() = New Byte(256) {}
                    Dim MimeType As String = ""
                    Dim file As HttpPostedFile = Context.Request.Files(i)

                    Dim fileName As String = HttpContext.Current.Request.Files(count).FileName
                    Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
                    Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
                    Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
                    Dim CharList As String()
                    CharList = ValidateFileName.Split(","c)
                    For k As Integer = 0 To CharList.Length - 1
                        If fileName.Contains(CharList(k).ToString) Then
                            fileName1 = fileName1.Replace(CharList(k).ToString, "")
                        End If
                    Next
                    Dim IsValidFileName As Integer = 1
                    Dim ExtensionList As String()
                    ExtensionList = fileName.Split("."c)
                    If ExtensionList.Length > 2 Then
                        IsValidFileName = 0
                    End If
                    If fileName = fileName1 And IsValidFileName = 1 Then
                        Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(i))
                        'file.InputStream.Read(buffer, 0, 256)
                        'file.InputStream.Position = 0
                        'Dim magicNumber As String = BitConverter.ToString(buffer)
                        'magicNumber = magicNumber.Replace("-", " ")
                        Dim xmlDoc As New XmlDocument()
                        Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                        xmlDoc.Load(xmlPath + "MIMEType.xml")
                        Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                        Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""

                        'Added by imran on 02-01-2023
                        'Dim fileNameExtention As String = HttpContext.Current.Request.Files(count).FileName
                        'Dim ext1 As String = Path.GetExtension(fileNameExtention)
                        'Dim tcount As Integer = ext1.Split("."c).Length - 1
                        'Dim count2 As Integer = fileNameExtention.Split("."c).Length - 1
                        'If tcount > 1 Then
                        '    MimeType = ""
                        'End If

                        'If count = 1 Or count2 = 1 Then
                        For Each node As XmlNode In nodes
                                xContentType = node.SelectSingleNode("ContentType").InnerText
                                If strFileType = xContentType Then
                                    fileName = HttpContext.Current.Request.Files(count).FileName
                                    Dim ext As String = Path.GetExtension(fileName)
                                    ext = ext.Substring(1, ext.Length - 1).ToLower()
                                    extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower()
                                    If extfromContentType.IndexOf(ext) > -1 Then
                                        MimeType = strFileType
                                        Exit For
                                    End If
                                End If
                            Next
                        'End If
                        'End of comment by imran on 02-01-2022
                    Else
                        MimeType = ""
                    End If

                    If MimeType Is Nothing Or MimeType = "" Then
                        MimeType = "unknown/unknowns"
                    End If
                    'End If

                    ''Ended by swapnil aswale on 15-06-2016
                    If strListofTypes.IndexOf(MimeType) >= 0 Then
                        strDirectoryName = CreateDirectoryStructure(CType(m_strProjectID, Long), CType(strCategory.Trim, Long), strSubCategory.Trim)
                        ' End of Modification

                        strFilePath = Server.MapPath("../../Documents") + "\" + strDirectoryName.Trim

                        'create the file object ot upload the file, Here Control Name is passed to the constructor
                        'where the file name is taken internally from the control.Here we are not passing third parameter
                        'to the constructor which is filename to upload.
                        'This object creates the file name if it is already there to avoid the overwrite of old
                        ''COMMENTED AND ADDED BY NITINC ON 05 APRIL 2011 FOR WHIZIBLESEM 10.0
                        'objFileUpload = New FileUpload.cUpload("txtFileName", strFilePath)



                        ''objFileUpload = New FileUpload.cUpload(Request.Files.Keys.Item(i), strFilePath)
                        ''''END OF COMMENTED AND ADDED BY NITINC ON 05 APRIL 2011 FOR WHIZIBLESEM 10.0

                        ''objFileUpload.OverwriteIfExists = False
                        ''objFileUpload.UploadFile()

                        Dim fileSavePath As String = Path.Combine(strFilePath, HttpContext.Current.Request.Files(i).FileName)

                        Request.Files(i).SaveAs(fileSavePath)

                        'strOldFileName = objFileUpload.OriginalFileName
                        'strUploadedFileName = objFileUpload.UploadedFileName

                        strOldFileName = HttpContext.Current.Request.Files(i).FileName
                        strUploadedFileName = HttpContext.Current.Request.Files(i).FileName

                        'objFileUpload = Nothing
                        'create the fileProperties object ot get the properties of the file
                        objFile = New CommonFunction.FileDirectory.FileProperties
                        objFile.FilePath = strFilePath + "\" + strUploadedFileName.Trim
                        objFile.GetFileProperties()
                        dblFileSize = objFile.FileSizeInKB
                        strCreatedDate = objFile.FileCreatedDate.ToString
                        strLastModifiedDate = objFile.LastUpdatedDate.ToString
                        strUploadedFileName = strUploadedFileName.Substring(0, strUploadedFileName.LastIndexOf("."))
                        strFileName = strOldFileName.Substring(0, strOldFileName.LastIndexOf("."))

                        strCreatedDate = "SELECT CONVERT(VARCHAR(10), GetDate(),20)"
                        Dim strDate1 As String = CommonFunction.Data.GetDataScalar(strCreatedDate, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

                        strLastModifiedDate = "SELECT CONVERT(VARCHAR(10), GetDate(),20)"
                        Dim strDate2 As String = CommonFunction.Data.GetDataScalar(strLastModifiedDate, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

                        'make the entry of the file in the database
                        If m_strLoginType.ToUpper.Trim = "C" Then
                            ' Modified By NitinVS on 10 MArch 2005 For PBNITE SP2
                            ' To cater for special characters in filename, added function General.BuildQueryString() to strUploadedFileName
                            'strSQL = "usp_Ins_tbl_PM_ProjectDocuments " + strCategory.Trim + "," + m_strProjectID.Trim + ",'" + General.BuildQueryString(strDirectoryName.Trim) + "','" + General.BuildQueryString(strUploadedFileName.Trim) + "','" + strCreatedDate.Trim + "','" + strLastModifiedDate.Trim + "','" + strDescription.Trim + "'," + dblFileSize.ToString + ",'" + objFile.Extension.Substring(1, objFile.Extension.Length - 1) + "','" + General.BuildQueryString(strFileName.Trim) + "'," + m_lngUserID.ToString + ",'C'"
                            strSQL = "usp_Ins_tbl_PM_ProjectDocuments " + strCategory.Trim + "," + m_strProjectID.Trim + ",'" + General.BuildQueryString(strDirectoryName.Trim) + "','" + General.BuildQueryString(strUploadedFileName.Trim) + "','" + strDate1 + "','" + strDate2 + "','" + strDescription.Trim + "'," + dblFileSize.ToString + ",'" + objFile.Extension.Substring(1, objFile.Extension.Length - 1) + "','" + General.BuildQueryString(strFileName.Trim) + "'," + m_lngUserID.ToString + ",'C'"

                        Else
                            'strSQL = "usp_Ins_tbl_PM_ProjectDocuments " + strCategory.Trim + "," + m_strProjectID.Trim + ",'" + General.BuildQueryString(strDirectoryName.Trim) + "','" + General.BuildQueryString(strUploadedFileName.Trim) + "','" + strCreatedDate.Trim + "','" + strLastModifiedDate.Trim + "','" + strDescription.Trim + "'," + dblFileSize.ToString + ",'" + objFile.Extension.Substring(1, objFile.Extension.Length - 1) + "','" + General.BuildQueryString(strFileName.Trim) + "'," + m_lngUserID.ToString + ",'E'"
                            strSQL = "usp_Ins_tbl_PM_ProjectDocuments " + strCategory.Trim + "," + m_strProjectID.Trim + ",'" + General.BuildQueryString(strDirectoryName.Trim) + "','" + General.BuildQueryString(strUploadedFileName.Trim) + "','" + strDate1 + "','" + strDate2 + "','" + strDescription.Trim + "'," + dblFileSize.ToString + ",'" + objFile.Extension.Substring(1, objFile.Extension.Length - 1) + "','" + General.BuildQueryString(strFileName.Trim) + "'," + m_lngUserID.ToString + ",'E'"
                        End If

                        'End Modification By NitinVS on 10 MArch 2005 For PBNITE SP2
                        objFile = Nothing

                        If strChangeRequest <> "" Then
                            strSQL += "," + strChangeRequest.Trim
                        Else
                            strSQL += ",NULL"
                        End If
                        'Code Added by RajkumarM on 12th Dec 2004 for Document Subcategory
                        If strSubCategory <> "" Then
                            strSQL = strSQL & ", " & strSubCategory
                        Else
                            strSQL = strSQL & ", NULL"
                        End If
                        If m_intTagID <> "" Then
                            strSQL = strSQL & ", " & m_intTagID
                        Else
                            strSQL = strSQL & ", NULL"
                        End If
                        If m_intUniqueID <> "" Then
                            strSQL = strSQL & ", " & m_intUniqueID
                        Else
                            strSQL = strSQL & ", NULL"
                        End If

                        ' Added By NitinVS on 12 March 2005 
                        ' To Add the Document Code 
                        strDocumentCode = "usp_SEL_ProjectDocumentCode  " + m_strProjectID.Trim + " , " + strCategory

                        If strSubCategory <> "" Then
                            strDocumentCode = strDocumentCode & ", " & strSubCategory
                        Else
                            strDocumentCode = strDocumentCode & ", NULL"
                        End If

                        strDocumentCode = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strDocumentCode, MyBase.UseSQL), "")

                        If strDocumentCode <> "" Then
                            strCodeTemplate = strDocumentCode
                        End If

                        ' End Addition By NitinVS on 12 March 2005 PBNITE SP2

                        strSQL = strSQL & ",'" & CommonFunction.General.BuildQueryString(strCodeTemplate) & "'"


                        'update the database 
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                        blnPerformSuccessFully = True
                        'Added By JyotiG
                        'Start_JG_12912_11-Apr-2007
                        'Issue :Projects > Execute > Documents: Page crashes if the document name is long.
                    Else
                        CommonFunction.General.WriteHTML("<Script>")
                        ''CommonFunction.General.WriteHTML("alert('Invalid Content Type!!'); ")
                        CommonFunction.General.WriteHTML("alert('Please upload valid file.'); ")
                        CommonFunction.General.WriteHTML("</Script>")
                    End If
                Catch ex As Exception
                    strFilePath = strFilePath + objFileUpload.UploadedFileName
                    Dim strMessage As String
                    If strFilePath.Length > 260 Then
                        strMessage = "<script language=javascript>"
                        strMessage = strMessage + "alert('" + MyBase.GetResourceString("MSG_MAX_FILEPATH") + "');" + vbCrLf
                        strMessage = strMessage + "</script>"
                        Response.Write(strMessage)
                        blnPerformSuccessFully = False
                    End If
                End Try
                'End_JG_12912_11-Apr-2007
            Else
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Upload Document", CType(m_intTagID, Long), m_ParentTagID, "Task ID", CType(m_intUniqueID, String))

                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            count += 1
            'End While
        Next
    End Sub
    'Added By Dipali V On 31st Oct 2022 For File Content Type
    <DllImport("urlmon.dll", CharSet:=CharSet.Unicode, ExactSpelling:=True, SetLastError:=False)>
    <System.Security.SecuritySafeCritical()>
    Shared Function FindMimeFromData(ByVal pBC As IntPtr, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzUrl As String, <MarshalAs(UnmanagedType.LPArray, ArraySubType:=UnmanagedType.I1, SizeParamIndex:=3)> ByVal pBuffer() As Byte, ByVal cbSize As Integer, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzMimeProposed As String, ByVal dwMimeFlags As Integer, ByRef ppwzMimeOut As IntPtr, ByVal dwReserved As Integer) As Integer
    End Function

    <System.Security.SecuritySafeCritical()>
    Public Shared Function getMimeFromFile(ByVal file As HttpPostedFile) As String
        Dim mimeout As IntPtr
        Dim MaxContent As Integer = CInt(file.ContentLength)
        If MaxContent > 200 Then MaxContent = 200
        Dim buf As Byte() = New Byte(MaxContent - 1) {}
        file.InputStream.Read(buf, 0, MaxContent)
        Dim result As Integer = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, Nothing, 0, mimeout, 0)

        If result <> 0 Then
            Marshal.FreeCoTaskMem(mimeout)
            Return ""
        End If

        Dim mime As String = Marshal.PtrToStringUni(mimeout)
        Marshal.FreeCoTaskMem(mimeout)
        Return mime.ToLower()
    End Function
    'End of Added By Dipali V On 31st Oct 2022 For File Content Type

    '=====================================================================
    ' Procedure Name		:	CreateDirectoryStructure
    ' Parameters Passed		:	lngProjectID    - Long - current project ID
    '                           lngCategoryID   _ Long  - Category ID
    ' Returns				:	String - Directory name
    ' Parameters Affected	:	None
    ' Purpose				:	To Get the directory name for the project and category given
    ' Description			:	Here this function will create the directory structure for the given 
    '                           project and category if it is not present. Structure is there is ProjectCode nameed
    '                           directory under Documents and under that there is Category named directory.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 2 2004
    ' Revisions				:	MrugajaB on 2nd Mar 2005 for Sub directory
    '=====================================================================
    Private Function CreateDirectoryStructure(ByVal lngProjectID As Long, ByVal lngCategoryID As Long, ByVal lngSubCategoryID As String) As String
        Dim strDirectory As String
        Dim strFullPath As String
        Dim strProjectCode As String
        Dim strCategoryDirectory As String
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim objDrCategory As IDataReader
        Dim objDrProject As IDataReader
        Dim objFile As CommonFunction.FileDirectory

        ' Code Added by MrugajaB on 2nd Mar 2005 for SubDirectory
        Dim strSubCategoryDirectory As String
        ' End of Addition

        strSQL = "usp_Sel_tbl_PM_ProjectDocumentByCategory " + lngProjectID.ToString + "," + lngCategoryID.ToString

        ' Code Added by MrugajaB on 2nd Mar 2005 for SubDirectory
        If lngSubCategoryID.ToString <> "" Then
            strSQL = strSQL + "," + lngSubCategoryID.ToString
        End If
        ' End of Addition

        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then

            strDirectory = Data.CheckIsDBNull(objDr("DirectoryName"), "").ToString + ""
            'generate full path to create the directory
            strFullPath = Server.MapPath("../../Documents/")

            'if project code named directory is not exiting then create it
            strFullPath += strDirectory.Substring(0, strDirectory.IndexOf("\"))
            If FileDirectory.IsDirectoryExists(strFullPath) = False Then
                FileDirectory.CreateDirectory(Server.MapPath("../../Documents/"), strDirectory.Substring(0, strDirectory.IndexOf("\")))
            End If

            'if category code named directory is not exiting then create it
            strFullPath += strDirectory.Substring(strDirectory.IndexOf("\"))
            If FileDirectory.IsDirectoryExists(strFullPath) = False Then
                FileDirectory.CreateDirectory(Server.MapPath("../../Documents/"), strDirectory.Trim)
            End If

        Else
            'if not present for the given project and category then create new directory

            'get the category directory name
            strSQL = "usp_Sel_tbl_PM_DocumentCategory " + lngCategoryID.ToString
            objDrCategory = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDrCategory.Read Then
                strCategoryDirectory = Data.CheckIsDBNull(objDrCategory("DirectoryName"), "").ToString
            End If
            Data.DisposeDataReader(objDrCategory)

            ' Code Added by MrugajaB on 2nd Mar 2005 for SubDirectory
            'get the category Sub directory name
            If lngSubCategoryID.ToString <> "" Then
                strSQL = "usp_Sel_tbl_PM_DocumentSubCategory NULL," + lngSubCategoryID.ToString + " , " + m_strProjectID
                objDrCategory = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDrCategory.Read Then
                    strSubCategoryDirectory = Data.CheckIsDBNull(objDrCategory("DirectoryName"), "").ToString
                End If
                Data.DisposeDataReader(objDrCategory)
            End If
            ' Code Addition Ends

            'get the project code to create the directory of name project code
            strSQL = "usp_Sel_tbl_PM_Project " + lngProjectID.ToString
            objDrProject = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDrProject.Read Then
                strProjectCode = Data.CheckIsDBNull(objDrProject("ProjectCode"), "").ToString + ""
            End If
            Data.DisposeDataReader(objDrProject)
            ' Code Added by MrugajaB on 2nd Mar 2005 for SP2 for Document sub category
            'If ProjectCode contains character like "/" or "\" ,error will be generated
            'while creating directory.So these characters will be replaced by "_" character
            'If strProjectCode <> "" Then
            strProjectCode = Replace(strProjectCode, "\", "_")
            strProjectCode = Replace(strProjectCode, "/", "_")
            'create full path to create the directory
            strFullPath = Server.MapPath("../../Documents") + "\" + strProjectCode.Trim
            'End If

            'End Addition
            'if project code named directory is not exiting then create it
            If FileDirectory.IsDirectoryExists(strFullPath) = False Then
                FileDirectory.CreateDirectory(Server.MapPath("../../Documents/"), strProjectCode.Trim)
            End If
            strFullPath += "\"

            'create new category directory named directory if not exists
            If FileDirectory.IsDirectoryExists((strFullPath + strCategoryDirectory.Trim)) = False Then
                FileDirectory.CreateDirectory(strFullPath.Trim, strCategoryDirectory.Trim)
            End If
            strFullPath += strCategoryDirectory.Trim

            strDirectory = strProjectCode + "\" + strCategoryDirectory.Trim

            ' Code Added by MrugajaB on 2nd Mar 2005 for SP2 for Document sub category
            If lngSubCategoryID.ToString <> "" Then
                strFullPath += "\"
                If FileDirectory.IsDirectoryExists((strFullPath + strSubCategoryDirectory.Trim)) = False Then
                    FileDirectory.CreateDirectory(strFullPath.Trim, strSubCategoryDirectory.Trim)
                End If
                strFullPath += strSubCategoryDirectory.Trim
                strDirectory = strProjectCode + "\" + strCategoryDirectory.Trim + "\" + strSubCategoryDirectory.Trim
            Else
                strDirectory = strProjectCode + "\" + strCategoryDirectory.Trim
            End If

            ' Code Addition Ends
        End If
        Data.DisposeDataReader(objDr)

        CreateDirectoryStructure = strDirectory.Trim
    End Function

    '=====================================================================
    ' Procedure Name		:	plotDocumentReviewScreen
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls for document review screen.
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 3 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotDocumentReviewScreen()
        Dim strDocumentRefID As String
        Dim strComments As String
        Dim strSQL As String
        Dim objDr As IDataReader

        'get the docuement ref ID and Comments
        strComments = MyBase.GetFormValue("txtComments", False) + ""
        strSQL = "usp_Sel_tbl_PM_ProjectDocuments " + m_strProjectID.Trim + "," + m_strDocumentID.Trim + ",'I'"
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("DocumentRefID")) Then
                strDocumentRefID = objDr("DocumentRefID").ToString + ""
            Else
                strDocumentRefID = objDr("DocumentID").ToString
            End If
            'strComments = Data.CheckIsDBNull(objDr("ReviewNotes"), "").ToString + ""
        End If
        Data.DisposeDataReader(objDr)

        'plot the conrol
        General.WriteHTML("<Div id='DivList' width=100% height=90% style='overflow: auto;' >")
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("CAP_REVIEW_COMMENTS") + "</TD>")
        General.WriteHTML("<TD align='left' >")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("CAP_REVIEW_COMMENTS"), , , "frmProjectDocuments", , , 350, 100, 500, strComments.Trim, , , , , , , , True, True))
        General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("CAP_REVIEW_COMMENTS"), , , "frmProjectDocuments", , , 350, 100, 500, strComments.Trim, , , , , , , , True, True, EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        General.WriteHTML("</TD>")
        'Added by MrugajaB on 22th Sept 2006 for whiziblesem SP7 issue ID.6197
        'Purpose:Hidden variable that will store value of token that is passed in edit mode from Task List Page
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("<TD align='left'>" + HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>")
        General.WriteHTML("<TD align='left'>" + HTMLControls.DrawTextBox("txthidParentToken", "txthidParentToken", value:=m_strParentToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>")
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'End Addition
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'write client side script to set focus on the comments textbox
        General.WriteHTML("<Script language=javascript>")
        General.WriteHTML(" var objTxt =  GetObjectReference('frmProjectDocuments','txtComments');")
        General.WriteHTML(" if(objTxt!=null) objTxt.focus(); ")
        General.WriteHTML("</Script>")


    End Sub

    '=====================================================================
    ' Procedure Name		:	performReviewAction
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database for the given document ID
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 3 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performReviewAction()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strComments As String

        strComments = MyBase.GetFormValue("txtComments", False) + ""
        If strComments.Length > 3800 Then strComments = strComments.Substring(0, 3800)

        Select Case m_strAction
            Case CONST_ACTION_SAVE
                If m_strLoginType.ToUpper = "C" Then
                    strSQL = "usp_Upd_tbl_PM_ProjectDocuments " + m_strDocumentID.Trim + "," + m_lngUserID.ToString + ",'" + General.BuildQueryString(strComments) + "','C'"
                Else
                    strSQL = "usp_Upd_tbl_PM_ProjectDocuments " + m_strDocumentID.Trim + "," + m_lngUserID.ToString + ",'" + General.BuildQueryString(strComments) + "','E'"
                End If
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        End Select

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotAttachURLScreen
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls for the Attach URL screen
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 3 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotAttachURLScreen()
        Dim strSQL As String

        'plot the controls
        General.WriteHTML("<div id='divList' width=100% height=90% style='overflow: auto;' >")
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

        'display URL text box
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("CAP_ENTER_URL") + "</B> " + MyBase.GetResourceString("MSG_URL") + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'>")
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtURL", "txtURL", , 400, 500, , , , , , , , , True, True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("</TD></TR>")

        'display category combo
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_DOCUMENT_CATEGORY") + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")

        'Modified By NitinVS on 10 March 2005 PBNITE SP2
        ' To Remove Additional TD 
        'General.WriteHTML("<TD align='left'>")
        'End Modification By NitinVS on 10 MArch 2005 PBNITE SP2

        'modified by SachinR    on 06 Oct 2004
        'Issue 13285 resolved
        strSQL = "usp_Sel_tbl_PM_DocumentCategory_ForRole " + m_strRoleID.Trim + "," + m_strProjectID.Trim
        'modification end

        ' Code Modified by RajkumarM on 12th Dec 2004
        'General.WriteHTML(HTMLControls.DrawComboBox("cboCategory", strSQL, 400, , , True, True, , True))
        General.WriteHTML("<TD align='left'>" + HTMLControls.DrawComboBox("cboAttachCategory", strSQL, 400, m_strcategoryID.ToString, "onchange = 'cboAttachCategory_OnChange()'", True, True, , True) + "</TD>")
        ' End of Modification

        General.WriteHTML("</TD></TR>")
        ' Added By NitinVS on 10 March 2005 PBNITE SP2

        'display document Sub category combo
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_DOCUMENT_SUBCATEGORY") + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")
        'Modified By NitinVS on 2 Apr 2005 for PBNITE SP2 Issue ID 17152 
        'To Show document Sub Category of categories selected for the Project 
        'strSQL = "usp_Sel_tbl_PM_DocumentSubCategory " + m_strcategoryID.Trim
        If m_strcategoryID.Trim = "" Then
            m_strcategoryID = "Null"
        End If
        strSQL = "usp_Sel_tbl_PM_DocumentSubCategory " + m_strcategoryID.Trim + " , Null , " + m_strProjectID

        m_strcategoryID = ""
        'End Modification By NitinVS on 2 Apr 2005 for PBNITE SP2 Issue ID 17152 

        General.WriteHTML("<TD id='tdSubCategory' align='left'>" + HTMLControls.DrawComboBox("cboSubCategory", strSQL, 400, , , True, True, , False) + "</TD>")
        General.WriteHTML("</TR>")
        ' End of Addition By NitinVS on 10 March 2005 PBNITE SP2


        'display description
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'>" + MyBase.GetResourceString("CAP_DESC") + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'General.WriteHTML(HTMLControls.DrawTextArea("txtDescription", "txtDescription", MyBase.GetResourceString("CAP_DESC"), , , "frmProjectDocuments", , , 400, 50, , , , , , , , , , True, True))
        General.WriteHTML(HTMLControls.DrawTextArea("txtDescription", "txtDescription", MyBase.GetResourceString("CAP_DESC"), , , "frmProjectDocuments", , , 400, 50, , , , , , , , , , True, True, EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'Modified By NitinVS  on 27 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12515 
        ' Removed the TD Code 
        'Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197
        'Purpose:Hidden variable that will store value of token that is passed in edit mode from Task List Page
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txthidParentToken", "txthidParentToken", value:=m_strParentToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'End Addition
        General.WriteHTML("</TD></TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'write client side script to set focus on the URL textbox
        General.WriteHTML("<Script language=javascript>")
        General.WriteHTML(" var objTxt =  GetObjectReference('frmProjectDocuments','txtURL');")
        General.WriteHTML(" if(objTxt!=null) objTxt.focus(); ")
        General.WriteHTML("</Script>")

    End Sub

    '=====================================================================
    ' Procedure Name		:	performAttachURLAction
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database with the entry of given URL
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 3 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAttachURLAction()
        Dim strSQL As String
        Dim strURL As String
        Dim strCategoryID As String
        Dim strDescription As String

        ' Code Added by MrugajaB on 2nd Mar 2005 for Adding Sub category
        Dim strSubCategory As String
        strSubCategory = MyBase.GetFormValue("cboSubCategory") + ""
        ' Addition Ends

        'get the values from the controls
        strURL = MyBase.GetFormValue("txtURL", False) + ""

        'Modified By NitinVS on 10 March 2005 
        'Page Crashing as Combo name is changed from 'cboCategory' to  'cboAttachCategory' 
        'strCategoryID = MyBase.GetFormValue("cboCategory") + ""
        strCategoryID = MyBase.GetFormValue("cboAttachCategory") + ""
        ' End Modification By NitinVS on 10 March 2005 for PBNITE SP2

        strDescription = MyBase.GetFormValue("txtDescription", False) + ""

        'enter the URL 
        strSQL = "usp_Ins_tbl_PM_ProjectDocuments_FOR_URL " + strCategoryID.Trim + "," + m_strProjectID.Trim + ",'" + General.BuildQueryString(strURL.Trim) + "','" + General.BuildQueryString(strDescription.Trim) + "'," + m_lngUserID.ToString + ",'" + m_strLoginType.Trim + "'"

        'Code Added by MrugajaB on 2nd Mar 2005 for Document Subcategory
        If strSubCategory <> "" Then
            strSQL = strSQL & ", " & strSubCategory
        Else
            strSQL = strSQL & ", NULL"
        End If

        If m_intTagID <> "" Then
            strSQL = strSQL & ", " & m_intTagID
        Else
            strSQL = strSQL & ", NULL"
        End If
        If m_intUniqueID <> "" Then
            strSQL = strSQL & ", " & m_intUniqueID
        Else
            strSQL = strSQL & ", NULL"
        End If

        ' End Addition

        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

    End Sub
    Private Sub RefreshParent()
        '=====================================================================
        ' Procedure Name		:	RefreshParent
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To update the database with the entry of given URL
        ' Description			:	Same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SachinR
        ' Created				:	Mar 18 2005
        ' Revisions				:	
        '=====================================================================
        ' To Refresh Parent page when the Page is called from other than Project Documents
        'write client side script to refresh parent
        If m_intTagID <> "" Then
            Select Case m_intTagID
                Case "467"
                    'Modified By NitinVS on 1 Apr 2005 for PBNITE SP2
                    'Parent page is to be refreshed for mode other than delete
                    If m_strAction <> CONST_ACTION_DELETE Then
                        General.WriteHTML("<Script Language=javascript>")
                        If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                            'Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                            'Purpose : Paging should be persist while deleting the document.
                            'General.WriteHTML("opener.location.href = ""PM_ProjectDocuments.aspx?Mode=" + CONST_MODE_LIST + "&MasterTagID=" + m_strMasterTagID.Trim + "&FromWhere=" + m_strFromWhere.Trim + """ ")
                            ''ADDED BY NITINC ON 05 APRIL 2011 FOR WHIZIBLESEM 10.0 
                            m_strDocumentcategoryID = "NULL"
                            m_strsubCategoryID = "NULL"
                            ''END OF ADDED BY NITINC ON 05 APRIL 2011 FOR WHIZIBLESEM 10.0
                            'Commented and Added by Yogesh Jalamkar on 13-Aug-2016
                            'General.WriteHTML("opener.location.href = ""PM_ProjectDocuments.aspx?Mode=" + CONST_MODE_LIST + "&MasterTagID=" + m_strMasterTagID.Trim + "&FromWhere=" + m_strFromWhere.Trim + "&PagingAlphabet=" + m_strAlphabet.Trim + "&TextSearch=" + m_strtxtSearch.Trim + "&CategoryID=" + m_strDocumentcategoryID + "&SubCategoryID=" + m_strsubCategoryID + """ ")
                            General.WriteHTML("opener.location.href = ""PM_ProjectDocuments.aspx?Mode=" + CONST_MODE_LIST + "&MasterTagID=" + m_strMasterTagID.Trim + "&FromWhere=" + m_strFromWhere.Trim + "&PagingAlphabet=" + m_strAlphabet.Trim + "&TextSearch=" + m_strtxtSearch.Trim + "&CategoryID=" + m_strDocumentcategoryID + "&PKToken=" + m_strToken + "&SubCategoryID=" + m_strsubCategoryID + """ ")
                            ' //End of addition by Yogesh Jalamkar on 13-Aug-2016
                            'End By VarunA 0n 20-Jan-2009 RequestID-21539
                        Else
                            ' //Commented and Added by Yogesh Jalamkar on 13-Aug-2016
                            'General.WriteHTML("opener.location.href = ""PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&Mode=" + CONST_MODE_LIST + "&MasterTagID=" + m_strMasterTagID.Trim + "&FromWhere=" + m_strFromWhere.Trim + """")
                            General.WriteHTML("opener.location.href = ""PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&Mode=" + CONST_MODE_LIST + "&MasterTagID=" + m_strMasterTagID.Trim + "&PKToken=" + m_strToken + "&FromWhere=" + m_strFromWhere.Trim + """")
                            ' End of addition by Yogesh Jalamkar on 13-Aug-2016
                        End If
                        'General.WriteHTML(" window.opener.location.href = 'PM_ProjectDocuments.aspx?Mode=" + CONST_MODE_LIST + "&MasterTagID=" + m_strMasterTagID.Trim + "&FromWhere=" + m_strFromWhere.Trim + "';")
                        General.WriteHTML("window.close();")
                        General.WriteHTML("</Script>")
                    End If

                    'Added by NitinC on 06 April 2011
                    If m_strMode = "HISTORY" Then
                        General.WriteHTML("<Script Language=javascript>")
                        General.WriteHTML("opener.location.href = ""PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&Mode=" + CONST_MODE_LIST + "&MasterTagID=" + m_strMasterTagID.Trim + "&FromWhere=" + m_strFromWhere.Trim + """")
                        General.WriteHTML("</Script>")
                    End If
                    'End of Added by NitinC on 06 April 2011

                    'End Modification By NitinVS on 1 Apr 2005 for PBNITE SP2
                Case "34"   ' MileStones 
                    General.WriteHTML("<Script Language=javascript>")
                    'Commented and Modified By MonikaI
                    General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','../General/CommonPage.aspx',true)")
                    'Modified By VidyaJ - Security issue - 6197
                    'Dim strToken As String
                    'strToken = m_strParentToken
                    'If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                    '    General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + strToken + "&MilestoneID_PK=" + m_intUniqueID.ToString + "&MasterTagID=34&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    'Else
                    '    General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + strToken + "&FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&MilestoneID_PK=" + m_intUniqueID.ToString + "&MasterTagID=34&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    'End If
                    'General.WriteHTML("window.close();")
                    General.WriteHTML("</Script>")
                Case "516" ' Phases 
                    General.WriteHTML("<Script Language=javascript>")
                    'Commented and Modified By MonikaI
                    ''COMMENTED AND ADDED BY NILESH G ON 19/4/2016 FOR NEXTGEN ISSUE FIXING
                    ''General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','../General/CommonPage.aspx',true)")
                    General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','../General/CommonPage.aspx?MasterTagID=516',true)")
                    'Modified By VidyaJ - Security issue - 6197
                    ''END OF COMMENTED AND ADDED BY NILESH G ON 19/4/2016

                    'If Request.QueryString("FromTimesheet") <> "CreateTask" Then

                    '    General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + m_strParentToken + "&ProjectPhaseID_PK=" + m_intUniqueID.ToString + "&MasterTagID=516&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    'Else
                    '    General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + m_strParentToken + "&FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&ProjectPhaseID_PK=" + m_intUniqueID.ToString + "&MasterTagID=516&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    'End If
                    'General.WriteHTML("window.close();")
                    General.WriteHTML("</Script>")

                Case "1026" ' Reviews
                    'Modified By VidyaJ - Security issue - 6197
                    General.WriteHTML("<Script Language=javascript>")
                    If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                        General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + m_strParentToken + "&ReviewStatisticsID_PK=" + m_intUniqueID.ToString + "&MasterTagID=1026&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    Else
                        General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + m_strParentToken + "&FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&ReviewStatisticsID_PK=" + m_intUniqueID.ToString + "&MasterTagID=1026&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    End If
                    General.WriteHTML("window.close();")
                    General.WriteHTML("</Script>")

                Case "1038" ' Assigned Task 
                    Dim strQueryString As String

                    If CommonFunction.General.CheckIsNothing(Request.QueryString("FilterParameter"), "") <> "" Then
                        strQueryString = Request.QueryString("FilterParameter")
                    Else
                        strQueryString = ""
                    End If

                    General.WriteHTML("<Script Language=javascript>")
                    If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                        'Commented and modified by MonikaI on 4th Oct 2006 IssueID : 6636
                        'General.WriteHTML("opener.location = ""../PM/PM_TaskAssignment.aspx?TaskId=" + m_intUniqueID.ToString + "&PkToken=" + m_strToken + "&Mode=Edit&MasterTagID=1038" + strQueryString + """")
                        'Modified & Commented By VarunA on 26-Feb-2008 IssueID-19003
                        'Purpose : For not to having Assign Resource and Delete Resouce link, while editing a task in Risks
                        'General.WriteHTML("opener.location = ""../PM/PM_TaskAssignment.aspx?PageType=" + m_strPageType + "&TaskId=" + m_intUniqueID.ToString + "&PkToken=" + m_strToken + "&Mode=Edit&MasterTagID=1038" + strQueryString + """")
                        'End by MonikaI
                        General.WriteHTML("opener.location = ""../PM/PM_TaskAssignment.aspx?TaskId=" + m_intUniqueID.ToString + "&PkToken=" + m_strToken + "&Mode=Edit&MasterTagID=1038" + strQueryString + """")
                        'End By VarunA on 26-Feb-2008 IssueID-19003
                    Else
                        'Commented and Modified By JytoiG
                        'Start
                        'Issue Id : 6616
                        'General.WriteHTML("opener.location = ""../PM/PM_TaskAssignment.aspx?FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&TaskId=" + m_intUniqueID.ToString + "&Mode=Edit&MasterTagID=1038" + strQueryString + """")
                        General.WriteHTML("opener.location = ""../PM/PM_TaskAssignment.aspx?PkToken=" + m_strToken + "&FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&TaskId=" + m_intUniqueID.ToString + "&Mode=Edit&MasterTagID=1038" + strQueryString + """")
                        'End
                    End If
                    '../PM/PM_TaskAssignment.aspx?TaskId=57432&Mode=Edit&MasterTagID=1038&PageNumber=-1&optTasks=All&optStatus=YetToStart&txthidSortBy=A.TaskName&txthidSortOrder=ASC
                    General.WriteHTML("window.close();")
                    General.WriteHTML("</Script>")
                Case "1039" ' change Management
                    'Modified By VidyaJ - Security issue - 6197
                    General.WriteHTML("<Script Language=javascript>")
                    'Commented and Modified By MonikaI
                    General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','../General/CommonPage.aspx',true)")

                    'If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                    '    General.WriteHTML("opener.location = ""../General/CommonPage.aspx?ChangeRequestID_PK=" + m_intUniqueID.ToString + "&MasterTagID=1039&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    'Else
                    '    General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + m_strParentToken + "&FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&ChangeRequestID_PK=" + m_intUniqueID.ToString + "&MasterTagID=1039&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    'End If
                    'General.WriteHTML("window.close();")
                    General.WriteHTML("</Script>")

                Case "2191" ' Fast Track Review 
                    'Modified By VidyaJ - Security issue - 6197
                    General.WriteHTML("<Script Language=javascript>")
                    If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                        General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + m_strParentToken + "&ReviewStatisticsID_PK=" + m_intUniqueID.ToString + "&MasterTagID=2191&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    Else
                        General.WriteHTML("opener.location = ""../General/CommonPage.aspx?PKToken=" + m_strParentToken + "&FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&ReviewStatisticsID_PK=" + m_intUniqueID.ToString + "&MasterTagID=2191&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                    End If
                    General.WriteHTML("window.close();")
                    General.WriteHTML("</Script>")

            End Select
        End If


    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    'Added By VarunA on 28-Aug-2009 RequestID-21539
    'Purpose : To have sorting on grid
    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "CATEGORY" Then
            Args.ApplySorting = False
        End If
    End Sub
    'End By VarunA on 28-Aug-2009 RequestID-21539

    ''Added by Yogesh J on 01-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_Review_OnClick(DocumentID As String, EmployeeID As String, MasterTag As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(DocumentID, String) + CType(EmployeeID, String) + "0" + CType(MasterTag, String))

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 01-Feb-2016
End Class
