#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports System.Text
Imports Whizible
#End Region

Public Class Faq_DocumentType
    Inherits WebPages.Template.WhizTemplate
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
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
    Protected m_strPagingSQL As String
    Dim strPage As String
    Dim strPaging As String

    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
    Protected m_PKToken_FromDocument As String
    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197


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

        'Check here from where the request is i.e. from Assign Task , Issue, Deliverable, Help desk 
        If CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "ISSUE" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "ISSUE" Then
            Call PlotControls_For_Issue()
        ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "DELIVERABLE" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "DELIVERABLE" Then
            Call PlotControls_For_Deliverable()
        ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "CRM" Or CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocType"), String), "").Trim.ToUpper = "CRM" Then

            '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
            m_PKToken_FromDocument = Request.QueryString("PKToken")
            If m_PKToken_FromDocument = "" Then
                m_PKToken_FromDocument = CommonFunctions.Security.Token.GetToken(CType(Request.QueryString("QueryID"), String) + CType(Session("intUserID"), String) + "0" + "0")
            End If
            If (CType(Request.QueryString("QueryID"), String) <> "0") Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("QueryID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken_FromDocument) = True) Then
                Call PlotControls_For_CRM()
            Else
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Attachments", 0, 0, "Query ID", CType(Request.QueryString("QueryID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
            'ElseIf CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("DocumentType"), String), "").Trim.ToUpper = "REVIEWDOCUMENT" Then
        Else
            Call PlotControls()
        End If

        Response.Write("</DIV>")
        'Lower Menu Generation 
        strMenu = GenerateLowerMenu()
        Response.Write("<BR>" + strMenu)
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

        MyBase.ApplySecurity()
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

        m_strPagingSQL = "EXEC usp_Sel_Documents_Attached_For_Paging_faq " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
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
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
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
            .DIVID = "divlist"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
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
        Dim arrstrRowLinkField() As String = {"Document_OnClick_For_Issue(FilePath)", "", "", ""}
        Dim strSortBy, strSortOrder As String

        '--- Set the Column Headings for the Pending Timesheet List
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
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
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick_For_Issue"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
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
        ' Author                : Pramod D
        ' Created               :  12/07/2011
        ' Revisions             :
        '=====================================================================

        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer
        Dim strSortBy, strSortOrder As String
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15

        '--- Set the TD style array
        Dim arrWidthArray() As String = {"align=left style='width=25%'", "align=left style='width=20%'", "align=left style='width=20%'", "align=left style='width=35%'"}
        'Added by Pramod d..On 21/07/2011
        'Added only FilePath parameter to java script
        Dim arrstrRowLinkField() As String = {"Document_OnClick_For_CRM(OriginalFileName,FilePath)", "", "", ""}
        'End of modification by pramod d..on 21/07/2011
        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_FILE_NAME"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_ATTACHEDBY"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_UPLOAD_DATE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DESCRIPTION"))

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("FilePath")
        arrColNamesList.Add("AttachedBy")
        arrColNamesList.Add("DateOfAttaching")
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
        'Added by Pramod D..On 6/07/2011
        'Purpose: open attachment  list in FAQ page
        strSQLQuery = "EXEC usp_Sel_Documents_Attached_For_CRM_faq " + CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("QueryID"), String), "")
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
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick_For_CRM"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
            .DrawGrid()
        End With
        'Ended by Pramod D...On6/07/2011

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
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
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
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .ClientSideSortFunctionName = "Sort_OnClick_For_Deliverable"
            .SortBy = strSortBy
            .SortOrder = strSortOrder
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

End Class

