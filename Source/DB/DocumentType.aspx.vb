#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports System.Text
#End Region

Public Class DocumentType
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        ''commented by nilesh g on 31/12/2015 for Security
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
        ''end of commented by nilesh g on 31/12/2015 for Security
        InitializeComponent()
    End Sub

#End Region

    Private strMenu As String
    Private WithEvents m_objGrid As New GenericGrid
    Protected m_strMasterPrimaryKeyValue As String
    Protected m_strURL As Boolean
    Protected m_strSortBy As String
    Protected m_strSortOrder As String
    Protected m_strProjectID As String
    Protected m_strUniqueID As String
    Protected m_strTagID As String
    Protected m_strFrom As String
    Protected m_strIssueID As String
    ''ADDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
    Protected m_PKToken As String = ""
    Protected m_PKToken_FromIssue As String = ""
    Protected m_QueryProjectID As String = ""
    Protected m_QueryISsueID As String = ""
    Protected m_QueryTagID As String = ""
    ''ENDDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
    Protected m_strPagingSQL As String
    Dim strPage As String
    Dim strPaging As String

    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
    Protected m_PKToken_FromDocument As String = ""
    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    'CHakshuta
    Private m_blnValidate As Boolean = True
    'CHakshuta

    ''Added by Dhanashri S on 23 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
    Protected m_PkToken_DocumentType As String
    ''End of addition by Dhanashri S on 23 Aug 2016


    Protected m_pktoken_Proj As String




    Public Sub PageInit()

        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : main procedure to build page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================
        'Upper Menu Generation 
        strMenu = GenerateMenu()
        Response.Write(strMenu)
        m_strMasterPrimaryKeyValue = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("UniqueID"), String), "")
        Response.Write("<DIV ID='PageDiv' Style='Height:90%;WIDTH:100%;OVERFLOW:auto;'>")

        m_PKToken_FromDocument = Request.QueryString("PKToken")
        'Check here from where the request is i.e. from Assign Task , Issue, Deliverable, Help desk 
        If CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "ISSUE" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "ISSUE" Then
            If Trim(Request.QueryString("PKToken") & "") <> "" And Trim(Request.QueryString("ProjectID") & "") <> "" And Trim(Request.QueryString("IssueID") & "") <> "" Then
                m_PKToken_FromIssue = Request.QueryString("PKToken")
                m_QueryProjectID = Request.QueryString("ProjectID")
                m_QueryISsueID = Request.QueryString("IssueID")
                m_QueryTagID = Request.QueryString("TagID")
            End If

            'If (m_PKToken_FromIssue <> "" And CommonFunctions.Security.Token.ValidateToken(CType(m_QueryTagID, String) + CType(m_QueryProjectID, String) + CType(m_QueryISsueID, String) + "0" + "0", m_PKToken_FromIssue) = False) Then
            '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            'End If

            'If Trim(Request.QueryString("ProjectID") & "") <> "" Then
            '    m_QueryProjectID = Request.QueryString("ProjectID")
            'End If
            'If Trim(Request.QueryString("IssueID") & "") <> "" Then
            '    m_QueryISsueID = Request.QueryString("IssueID")
            'End If


            Call PlotControls_For_Issue()
        ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "DELIVERABLE" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "DELIVERABLE" Then
            Call PlotControls_For_Deliverable()
        ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "CRM" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "CRM" Then

            '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
            m_PKToken_FromDocument = Request.QueryString("PKToken")

            'If m_PKToken_FromDocument = "" Then
            '    ' m_PKToken_FromDocument = CommonFunctions.Security.Token.GetToken(CType(Request.QueryString("QueryID"), String) + CType(Session("intUserID"), String) + "0" + "0")

            'End If
            ''Commented and added by Yogesh J on 21-Jan-2016

            If (CType(Request.QueryString("QueryID"), String) <> "") And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("QueryID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken_FromDocument) = True) Then
                Call PlotControls_For_CRM()

                'Else
                '    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Attachments", 0, 0, "Query ID", CType(Request.QueryString("QueryID"), String))
                '    'Token is Invalid now redirect to the Invalid Access Page
                '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
            'ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "REVIEWDOCUMENT" Then
            'Addition by SuchitraP on 20-Jan-2009 for KM changes
        ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "KM" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "KM" Then
            Call PlotControls_For_KM()
            'End of addition by SuchitraP
        Else
            Call PlotControls()
        End If

        Response.Write("</DIV>")
        'Lower Menu Generation 
        strMenu = GenerateLowerMenu()
        Response.Write("<BR>" + strMenu)

        ''Added By Vidya J On 29 Mar 2016
        'If (Request.QueryString("PKToken") <> "" And Request.QueryString("ProcedureID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String), Request.QueryString("PKToken")) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("ProcedureID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ''End Of Addtion By Vidya J On 26 Mar 2016

        ''Added by Dhanashri S on 23 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
        If HttpContext.Current.Request.QueryString("DocumentType") IsNot Nothing Then
            m_PkToken_DocumentType = Request.QueryString("DocumentType")
        End If
        ''End of addition by Dhanashri S on 23 Aug 2016 

        ''Added by Dhanashri S on 23 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing

        If HttpContext.Current.Request.QueryString("ProjectID") IsNot Nothing Then
            m_pktoken_Proj = Request.QueryString("ProjectID")
        End If
       
        ''End of addition by Dhanashri S on 23 Aug 2016 Paging
        'Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0" And Request.QueryString("Paging") = "" And Request.QueryString("DocType") = "") Then
            m_blnValidate = False
        ElseIf Request.QueryString("ProcedureID") <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
            'ElseIf Request.QueryString("ProjectID") <> "" Then
            '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
            '        m_blnValidate = False
            '    End If
            'End If
        ElseIf m_pktoken_Proj <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_pktoken_Proj, String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
        End If
        If m_blnValidate = False Then
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        ''Added by Dhanashri S on 23 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing

        ''End of addition by Dhanashri S on 23 Aug 2016 
        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String) + "0" + "0")
        'End Of Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
    End Sub ' Main procedure to build page

    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.DocumentType", "AppResources")

    End Sub ' Constructor for the page

    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        m_strProjectID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProjectID"), String), "")
        m_strUniqueID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("UniqueID"), String), "")
        m_strTagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("TagID"), String), "")

        'Commented and Modified By JyotiG
        'Start_JG_8825_20-Dec-2006
        'strPage = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("Paging"), String), "-1")
        strPage = CommonFunction.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("Paging"), String), "-1"))
        'End_JG_8825_20-Dec-2006
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_QUESTION_MARK"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('DCUMENT_HELP')")

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        'Generate menu string and return

        ' This is for Paging 

        If CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "ISSUE" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "ISSUE" Then
            m_strIssueID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("IssueID"), String), "")
            m_strFrom = "ISSUE"

            strPaging = GeneratePagingSqlForIssue()

        ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "DELIVERABLE" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "DELIVERABLE" Then
            m_strUniqueID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ScheduleID"), String), "")
            m_strFrom = "DELIVERABLE"

            strPaging = GeneratePagingSqlForDeliverable()
        ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "CRM" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "CRM" Then
            m_strUniqueID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("QueryID"), String), "")
            m_strFrom = "CRM"

            strPaging = GeneratePagingSqlForCRM()
            'Addition by SuchitraP on 20-Jan-2009 for KM changes
        ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "KM" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "KM" Then
            m_strUniqueID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProcedureID"), String), "")
            m_strFrom = "KM"
            strPaging = GeneratePagingSqlForKM()
            'End of addition by SuchitraP on 20-Jan-2009 for KM changes
        Else
            strPaging = GeneratePagingSql()
        End If
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True, strPaging)

    End Function 'Menu generation

    Private Function GenerateLowerMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_QUESTION_MARK"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('')")

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        'Generate menu string and return

        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function 'LowerMenu generation
    Private Function GeneratePagingSql() As String
 '=====================================================================
        ' Function Name         : GeneratePagingSql()
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        'This is for Assigned task, Milstine, Review Documents
        m_strPagingSQL = "usp_Sel_Documents_Attached_For_Paging " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
        m_strPagingSQL += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProjectID"), String), "") + ", "
        m_strPagingSQL += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("UniqueID"), String), "") + ", "
        m_strPagingSQL += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("TagID"), String), "") + ", " + "A"

        Return WebPages.Template.Paging.DrawPaging(strPage, m_strPagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClick", "", True, , , False, 20)

    End Function

    Private Function GeneratePagingSqlForIssue() As String
  '=====================================================================
        ' Function Name         : GeneratePagingSqlForIssue()
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        'This is for Issue Documents paging
        m_strPagingSQL = "EXEC usp_Sel_Documents_Attached_For_Paging " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
        m_strPagingSQL += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProjectID"), String), "") + ", "
        m_strPagingSQL += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("IssueID"), String), "") + ", " + "NULL, " + "I"

        Return WebPages.Template.Paging.DrawPaging(strPage, m_strPagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClickForIssue", "", True, , , False, 20)

    End Function

    Private Function GeneratePagingSqlForKM() As String
        '=====================================================================
        ' Function Name         : GeneratePagingSqlForKM()
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuchitraP
        ' Created               : Jan 20, 2009
        ' Revisions             :
        '=====================================================================

        'This is for KM Attachments paging

        m_strPagingSQL = "SELECT DISTINCT UPPER(SUBSTRING(Originalfilename,1,1)) FROM tbl_KM_Attachments WHERE ProcedureID = "
        m_strPagingSQL += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProcedureID"), String), "")
        Return WebPages.Template.Paging.DrawPaging(strPage, m_strPagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClickForKM", "", True, , , False, 20)

    End Function
    Private Function GeneratePagingSqlForCRM() As String
 '=====================================================================
        ' Function Name         : GeneratePagingSqlForCRM()
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        'This is for Help Desk Documents paging

        m_strPagingSQL = "EXEC usp_Sel_Documents_Attached_For_Paging " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
        m_strPagingSQL += "NULL , "
        m_strPagingSQL += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("QueryID"), String), "") + ", " + "NULL, " + "C"
        Return WebPages.Template.Paging.DrawPaging(strPage, m_strPagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClickForCRM", "", True, , , False, 20)

    End Function

    Private Function GeneratePagingSqlForDeliverable() As String
 '=====================================================================
        ' Function Name         : GeneratePagingSqlForDeliverable()
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        'This is for Deliverable Documents paging

        m_strPagingSQL = "EXEC usp_Sel_Documents_Attached_For_Paging " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
        m_strPagingSQL += "NULL , "
        m_strPagingSQL += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ScheduleID"), String), "") + ", " + "NULL, " + "D"

        Return WebPages.Template.Paging.DrawPaging(strPage, m_strPagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClickForDeliverable", "", True, , , False, 20)

    End Function


    Private Sub PlotControls()
        '=====================================================================
        ' Procedure Name        : PlotControls()	
        ' Purpose               : Plot the controls on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim strSortBy, strSortOrder As String
        Dim intRecordCount As Integer

        '--- Display the list of records for the selected Employee
        Dim arrWidthArray() As String = {"align=left style='width=20%'", "align=left style='width=20%'", "align=left style='width=30%'", "align=left style='width=10%'", "align=left style='width=10%'", "align=left style='width=10%'"}
        Dim arrstrRowLinkField() As String = {"", "", "Document_OnClick(DocumentID,ProjectID)", "", "", ""}
        Dim arrGroupOnColumn() As String = {"Category"}

        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DOCUMENT_CATEGORY"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DOCUMENT_SUBCATEGORY"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DOCUMENT_NAME"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_UPLOAD_DATE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_FILE_SIZE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_LAST_MODIFIED"))

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("Category")
        arrColNamesList.Add("SubCategory")
        arrColNamesList.Add("FileName")
        arrColNamesList.Add("UploadedDate")
        arrColNamesList.Add("FileSize")
        arrColNamesList.Add("UpdatedDate")

        '--- Display the Page Caption 
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAP_DOCUMENT_ATTACHED"))
        CommonFunctions.General.WriteHTML("<br>")

        If Not Request.QueryString("sortby") Is Nothing Then
            strSortBy = Request.QueryString("sortby")
        Else
            ''Modified by Manishk on 15th Feb 2006 For Document Category Default Sorting issue
            'strSortBy = "UpdatedDate"
            strSortBy = "Category"
            ''End of Modified by Manishk on 15th Feb 2006 For Document Category Default Sorting issue
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            strSortOrder = Request.QueryString("sortorder")
        Else
            ''Modified by Manishk on 15th Feb 2006 For Document Category Default Sorting issue
            'strSortOrder = "DESC"
            strSortOrder = "ASC"
            ''End of Modified by Manishk on 15th Feb 2006 For Document Category Default Sorting issue
        End If

        strSQLQuery = "EXEC usp_Sel_Documents_Attached " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
        strSQLQuery += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProjectID"), String), "") + ", "
        strSQLQuery += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("UniqueID"), String), "") + ", "
        strSQLQuery += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("TagID"), String), "") + ", "
        strSQLQuery += "'" + strPage + "'"
        strSQLQuery += ", '" + strSortBy + "', '" + strSortOrder + "'"


        With m_objGrid
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 6
            .GroupOnColumn = arrGroupOnColumn
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            ''dhn
            ''.DIVID = "divlist"
            .DIVID = "DivList"
            ''dhn
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()

        End With

        intRecordCount = m_objGrid.NoOfRows

        m_objGrid = Nothing
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<BR><TABLE class=clsGridTable cellpadding=0 cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD width='100%' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records " + CStr(intRecordCount) + " </TD></TR></TABLE>")

    End Sub 'Plot controls on the page

    Private Sub PlotControls_For_KM()
        '=====================================================================
        ' Procedure Name        : PlotControls_For_KM()	
        ' Purpose               : Plot the controls on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuchitraP
        ' Created               : Jan 20, 2009
        ' Revisions             :
        '=====================================================================

        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer

        '--- Set the TD style array
        Dim arrWidthArray() As String = {"align=left style='width=25%'", "align=left style='width=20%'", "align=left style='width=20%'", "align=left style='width=35%'"}
        Dim arrstrRowLinkField() As String = {"Document_OnClick_For_KM(Attachments,OriginalFilename)", "", "", ""}
        Dim strSortBy, strSortOrder As String

        '--- Set the Column Headings 
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_FILE_NAME"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_ATTACHEDBY"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_UPLOAD_DATE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DESCRIPTION"))

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("OriginalFileName")
        arrColNamesList.Add("AttachedBy")
        arrColNamesList.Add("AttachedDate")
        arrColNamesList.Add("Description")


        If Not Request.QueryString("sortby") Is Nothing Then
            strSortBy = Request.QueryString("sortby")
        Else
            strSortBy = "DateOfAttaching"
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            strSortOrder = Request.QueryString("sortorder")
        Else
            strSortOrder = "DESC"
        End If

        '--- Display the Page Caption 
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAP_DOCUMENT_ATTACHED"))
        CommonFunctions.General.WriteHTML("<br>")

        '--- Display the list of records for the selected Employee
        If strPage <> "-1" Then
            strSQLQuery = "SELECT OriginalFilename,AttachedBy,AttachedDate,Description,Attachments FROM tbl_KM_Attachments WHERE OriginalFilename like '" + strPage + "%' AND ProcedureID =" + CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProcedureID"), String), "") + " ORDER BY 1"
        Else
            'Comment and modification by SuchitraP on 4-Jun-2009
            'strSQLQuery = "SELECT OriginalFilename,AttachedBy,AttachedDate,Description,Attachments FROM tbl_KM_Attachments WHERE ProcedureID =" + CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProcedureID"), String), "") + " ORDER BY 1"
            strSQLQuery = "usp_Sel_tbl_KM_Attachments " + CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProcedureID"), String), "")
            'End of comment and modification by SuchitraP
        End If

        With m_objGrid
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 7 '4
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = "DivList"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick_For_KM"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        intRecordCount = m_objGrid.NoOfRows

        m_objGrid = Nothing

        CommonFunctions.General.WriteHTML("<BR><TABLE class=clsGridTable cellpadding=0 cellspacing=0 width='99.9%'>")

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD width='100%' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records " + CStr(intRecordCount) + " </TD></TR></TABLE>")

    End Sub

    Private Sub PlotControls_For_Issue()
        '=====================================================================
        ' Procedure Name        : PlotControls_For_Issue()	
        ' Purpose               : Plot the controls on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer

        '--- Set the TD style array
        Dim arrWidthArray() As String = {"align=left style='width=25%'", "align=left style='width=20%'", "align=left style='width=20%'", "align=left style='width=35%'"}

        'Modified By VarunA on 06-Apr-2009 RequestID-19552
        'Purpose : To have the Original file name for attachment
        'Dim arrstrRowLinkField() As String = {"Document_OnClick_For_Issue(FilePath)", "", "", ""}
        Dim arrstrRowLinkField() As String = {"Document_OnClick_For_Issue(FilePath,OriginalFileName)", "", "", ""}
        'End By VarunA on 06-Apr-2009 RequestID-19552

        Dim strSortBy, strSortOrder As String

        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_FILE_NAME"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_ATTACHEDBY"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_UPLOAD_DATE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DESCRIPTION"))

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("OriginalFileName")
        arrColNamesList.Add("AttachedBy")
        arrColNamesList.Add("DateOfAttaching")
        arrColNamesList.Add("Description")


        If Not Request.QueryString("sortby") Is Nothing Then
            strSortBy = Request.QueryString("sortby")
        Else
            strSortBy = "DateOfAttaching"
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            strSortOrder = Request.QueryString("sortorder")
        Else
            strSortOrder = "DESC"
        End If

        '--- Display the Page Caption 
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAP_DOCUMENT_ATTACHED"))
        CommonFunctions.General.WriteHTML("<br>")

        '--- Display the list of records for the selected Employee
        strSQLQuery = "EXEC usp_Sel_Documents_Attached_For_Issue " + CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ProjectID"), String), "") + ", "
        strSQLQuery += CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("IssueID"), String), "")
        strSQLQuery += ",NULL, '" + strPage + "'"
        strSQLQuery += ", '" + strSortBy + "', '" + strSortOrder + "'"


        With m_objGrid
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 4
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = "DivList"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick_For_Issue"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        intRecordCount = m_objGrid.NoOfRows

        m_objGrid = Nothing
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<BR><TABLE class=clsGridTable cellpadding=0 cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD width='100%' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records " + CStr(intRecordCount) + " </TD></TR></TABLE>")

    End Sub 'Plot controls on the page

    Private Sub PlotControls_For_CRM()
        '=====================================================================
        ' Procedure Name        : PlotControls_For_CRM()	
        ' Purpose               : Plot the controls on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 21, 2005
        ' Revisions             :
        '=====================================================================

        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer
        Dim strSortBy, strSortOrder As String

        '--- Set the TD style array
        Dim arrWidthArray() As String = {"align=left style='width=25%'", "align=left style='width=20%'", "align=left style='width=20%'", "align=left style='width=35%'"}
        'Modified By VarunA on 10-June-2008 RequestID-13758
        'Purpose : To have the Original file name for attachment
        'Dim arrstrRowLinkField() As String = {"Document_OnClick_For_CRM(SystemFileName)", "", "", ""}
        Dim arrstrRowLinkField() As String = {"Document_OnClick_For_CRM(SystemFileName,OriginalFileName)", "", "", ""}
        'End By VarunA on 10-June-2008 RequestID-13758

        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_FILE_NAME"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_ATTACHEDBY"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_UPLOAD_DATE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DESCRIPTION"))

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("OriginalFileName")
        arrColNamesList.Add("AttachedBy")
        arrColNamesList.Add("DateAttached")
        arrColNamesList.Add("Description")

        If Not Request.QueryString("sortby") Is Nothing Then
            strSortBy = Request.QueryString("sortby")
        Else
            strSortBy = "DateAttached"
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            strSortOrder = Request.QueryString("sortorder")
        Else
            strSortOrder = "DESC"
        End If

        '--- Display the Page Caption 
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAP_DOCUMENT_ATTACHED"))
        CommonFunctions.General.WriteHTML("<br>")

        '--- Display the list of records for the selected Employee
        strSQLQuery = "EXEC usp_Sel_Documents_Attached_For_CRM " + CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("QueryID"), String), "")
        strSQLQuery += " ,NULL , '" + strPage + "'"
        strSQLQuery += ", '" + strSortBy + "', '" + strSortOrder + "'"

        With m_objGrid
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 4
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = "DivList"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick_For_CRM"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        intRecordCount = m_objGrid.NoOfRows

        m_objGrid = Nothing
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<BR><TABLE class=clsGridTable cellpadding=0 cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD width='100%' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records " + CStr(intRecordCount) + " </TD></TR></TABLE>")

    End Sub

    Private Sub PlotControls_For_Deliverable()
        '=====================================================================
        ' Procedure Name        : PlotControls_For_Deliverable()	
        ' Purpose               : Plot the controls on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================


        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer
        Dim strSortBy, strSortOrder As String

        '--- Set the TD style array
        Dim arrWidthArray() As String = {"align=left style='width=25%'", "align=left style='width=20%'", "align=left style='width=20%'", "align=left style='width=35%'"}
        Dim arrstrRowLinkField() As String = {"Document_OnClick_For_Deliverable(GeneratedFileName)", "", "", ""}

        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_FILE_NAME"))
        '  arrColHeadingsList.Add("File Size (KB)")
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_ATTACHEDBY"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_UPLOAD_DATE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DESCRIPTION"))

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("OriginalFileName")
        arrColNamesList.Add("AttachedBy")
        arrColNamesList.Add("AttachedDate")
        arrColNamesList.Add("Description")

        '--- Display the Page Caption 
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAP_DOCUMENT_ATTACHED"))
        CommonFunctions.General.WriteHTML("<br>")

        If Not Request.QueryString("sortby") Is Nothing Then
            strSortBy = Request.QueryString("sortby")
        Else
            ''Modified by Manishk on 15th Feb 2006 for PM-Dashboard Document Tooltip issue
            'strSortBy = "AttachedDate"
            strSortBy = "OriginalFileName"
            ''End of Modified by Manishk on 15th Feb 2006 for PM-Dashboard Document Tooltip issue
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            strSortOrder = Request.QueryString("sortorder")
        Else
            ''Modified by Manishk on 15th Feb 2006 for PM-Dashboard Document Tooltip issue
            'strSortOrder = "DESC"
            strSortOrder = "ASC"
            ''End of Modified by Manishk on 15th Feb 2006 for PM-Dashboard Document Tooltip issue
        End If

        '--- Display the list of records for the selected Employee
        strSQLQuery = "EXEC usp_Sel_Documents_Attached_For_Deliverable " + CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("ScheduleID"), String), "")
        strSQLQuery += ", NULL , '" + strPage + "'"
        strSQLQuery += ", '" + strSortBy + "', '" + strSortOrder + "'"


        With m_objGrid
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 4
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = "DivList"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick_For_Deliverable"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        intRecordCount = m_objGrid.NoOfRows

        m_objGrid = Nothing
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<BR><TABLE class=clsGridTable cellpadding=0 cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD width='100%' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records " + CStr(intRecordCount) + " </TD></TR></TABLE>")

    End Sub 'Plot controls on the page

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : ManishK
        ' Created               : 18th Nov 2005
        ' Revisions             :
        '=====================================================================
        m_objGrid = Nothing

    End Sub

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
        ' Author                : ManishK
        ' Created               : 18th Nov 2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    'Addition by SuchitraP on 4-Jun-2009 for Showing Attachment date/time in KM
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "KM" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "KM" Then
            If Args.ColumnName.ToUpper = "UPLOAD DATE" Then
                Cancel = True
                If CommonFunctions.General.CheckIsNothing((Args.DataReader("AttachedDate").ToString), "") <> "" Then
                    'Commented & Added By Dipali V On 28th Dec 2020 For Handal Null Condition
                    'Args.StringToBeInserted = "<td  vAlign=top align=left style='width=20%' title=""Upload Date"">" + CommonFunctions.General.CheckIsNothing(CommonFunctions.Dates.CGetDateTime(Args.DataReader("AttachedDate").ToString), "") + "</td>"
                    Args.StringToBeInserted = "<td  vAlign=top align=left style='width=20%' title=""Upload Date"">" + CommonFunctions.General.CheckIsNothing(CommonFunctions.Dates.CGetDateTime(Args.DataReader("AttachedDate").ToString), "") + "</td>"
                    'End of Commented & Added By Dipali V On 28th Dec 2020 For Handal Null Condition
                Else
                    Args.StringToBeInserted = "<td  vAlign=top align=left style='width=20%' title=""Upload Date""></td>"

                End If
            End If
        End If
    End Sub
    'End of addition by SuchitraP
End Class

