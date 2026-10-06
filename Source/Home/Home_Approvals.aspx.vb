#Region "Imports"
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
Imports System.Globalization
Imports System.Text
Imports Authentication
Imports System.Net
#End Region
Partial Public Class Home_Approvals
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.ID = "frm_Approvals"

    End Sub
    Protected WithEvents divTbl As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents txtContentTab As System.Web.UI.HtmlControls.HtmlInputHidden
    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Event Variables Declaretions"
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objLeavesGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objIRGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objExpenseGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objProjectGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objProjectTimeSheetGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objResourceTimeSheetGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSectionTitleLeave As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleIR As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleExpense As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleProject As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleProjectTimeSheet As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleResourceTimeSheet As New WebPage.Templates.SectionTitle
#End Region
#Region " Constants Variables Declaretions"

    Private Const MODE_APPROVE As String = "APPROVE"
    Private Enum GridIndex
        LEAVE = 1
        IR = 2
        EXPENSE = 3
        PROJECT = 4
        PROJECT_TIMESHEET = 5
        RESOURCE_TIMESHEET = 6
        TOTAL_GRID = 6
    End Enum
#End Region
#Region " Structure Declaretions"
    Public Structure StructGridName
        Dim strDumy As String
        Private Const TotalGrid As Integer = 6

        Public ReadOnly Property LEAVE() As String
            Get
                LEAVE = "Leave"
            End Get

        End Property
        Public ReadOnly Property IR() As String
            Get
                IR = "IR"
            End Get

        End Property
        Public ReadOnly Property EXPENSE() As String
            Get
                EXPENSE = "Expense"
            End Get

        End Property
        Public ReadOnly Property PROJECT() As String
            Get
                PROJECT = "Project"
            End Get

        End Property
        Public ReadOnly Property PROJECT_TIMESHEET() As String
            Get
                PROJECT_TIMESHEET = "Project Timesheet"
            End Get

        End Property
        Public ReadOnly Property RESOURCE_TIMESHEET() As String
            Get
                RESOURCE_TIMESHEET = "Resource Timesheet"
            End Get

        End Property

    End Structure
#End Region

#Region " Private Variables Declaretions "

    Private m_intTotalNoOfRows As Integer
    Private strsql As String
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Private m_dsGrid As DataSet
    Private m_GridName As StructGridName = New StructGridName
    Private m_blnIsApprover As Boolean = False
    Private m_blnIsStageProjectWorkflow As Boolean = False


#End Region
#Region " Protected Variables Declaretions "
    Protected m_intLeaveTotalNoOfRows As Integer = 0
    Protected m_intIRTotalNoOfRows As Integer = 0
    Protected m_intExpenseTotalNoOfRows As Integer = 0
    Protected m_intProjectTotalNoOfRows As Integer = 0
    Protected m_intProjectTimeSheetTotalNoOfRows As Integer = 0
    Protected m_intResourceTimeSheetTotalNoOfRows As Integer = 0
    Protected m_intLeavePageNumber As Integer = 1
    Protected m_intIRPageNumber As Integer = 1
    Protected m_intExpensePageNumber As Integer = 1
    Protected m_intProjectPageNumber As Integer = 1
    Protected m_intProjectTimeSheetPageNumber As Integer = 1
    Protected m_intResourceTimeSheetPageNumber As Integer = 1
    Protected m_intPageSize As Integer = 20
    Protected m_intDivHieght As Integer = 280
    Protected m_lngTagId As Long = 0
    Protected m_strContentTab As String = ""


#End Region
#Region " Public Variables Declaretions "
    Dim m_strPKToken As String = ""
    Dim m_strTSIDs As String = ""
    Dim m_strTSIDsWithToken As String = ""
    Public strExpenseSheetIDList As String = ""
    Public strTokenIDList As String = ""

#End Region

#Region " initialize the page here - Page_Load"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If txtContentTab.Value <> "" Then
            m_strContentTab = Server.UrlDecode(txtContentTab.Value)
        Else
            m_strContentTab = m_GridName.LEAVE
        End If
    End Sub

#End Region

#Region " General Function Definition"
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

    '    ArrTopMenuCaptionsList.Add("<img src='../../Images/Home/Comments.gif'> Common Comment")
    '    ArrTopMenuToolTipsList.Add("Comments")
    '    ArrTopMenuFunctionsList.Add("Comments_OnClick()")

    '    ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/approve.gif'> Approve")
    '    ArrTopMenuToolTipsList.Add("Approve")
    '    ArrTopMenuFunctionsList.Add("Approve_OnClick()")

    '    ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/selectall.gif'> Select All")
    '    ArrTopMenuToolTipsList.Add("Select All")
    '    ArrTopMenuFunctionsList.Add("SelectAll_OnClick()")

    '    ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/clearall.gif'> Clear All")
    '    ArrTopMenuToolTipsList.Add("Claer All")
    '    ArrTopMenuFunctionsList.Add("ClearAllOnClick()")

    '    ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/back.gif'> Back")
    '    ArrTopMenuToolTipsList.Add("Back")
    '    ArrTopMenuFunctionsList.Add("Back_OnClick()")

    '    ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images_BW/help.gif'>Help")
    '    ArrTopMenuToolTipsList.Add("Help")

    '    If m_strContentTab.ToUpper = m_GridName.LEAVE.ToUpper Then
    '        ArrTopMenuFunctionsList.Add("Help_OnClick('LeaveHelp')")
    '    End If
    '    If m_strContentTab.ToUpper = m_GridName.RESOURCE_TIMESHEET.ToUpper Then
    '        ArrTopMenuFunctionsList.Add("Help_OnClick('ResourceTimesheetHelp')")
    '    End If

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
    Private Function CheckApproverAccess(ByVal strExpenseSheetID As String) As Boolean
        '=====================================================================
        ' Procedure  Name		:	CheckApproverAccess
        ' Parameters Passed		:	By Val strExpenseSheetID
        ' Returns				:	the Approver Access(True or False)
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	Return the Approver Access(True or False)
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	4:35 PM 9/28/2007
        '=====================================================================

        Dim drAccess As IDataReader
        Dim strQuery As String
        Dim strSql As String
        Dim strCount As String
        Dim blnResult As Boolean
        strSql = "USP_GET_Valid_ExpenseSheetApprover " & strExpenseSheetID & "," & Session("intUserID").ToString & ",1"
        strCount = CType(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), String)
        If strCount = "1" Then
            blnResult = True
            CheckApproverAccess = blnResult
        Else
            blnResult = False
            CheckApproverAccess = blnResult
        End If
        CommonFunctions.Data.DisposeDataReader(drAccess)
    End Function

#End Region
#Region " General Procedure Definition"

    Protected Sub TabContent()

        '=====================================================================
        ' Procedure Name        : TabContent()	
        ' Purpose               : Draw the tab button for detail page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 4:10 PM 10/10/2007
        ' Revisions             : 
        '=====================================================================

        CommonFunctions.General.WriteHTML("<ul id='tabnav'  valign='top'>")

        If m_strContentTab.ToUpper = m_GridName.LEAVE.ToUpper Then
            CommonFunctions.General.WriteHTML("<li class=tabSelected><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.LEAVE) + """)' id=""" + m_GridName.LEAVE + """ >" + m_GridName.LEAVE + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.LEAVE) + """)' id=""" + m_GridName.LEAVE + """ >" + m_GridName.LEAVE + " </a></li>&nbsp;")
        End If
        If m_strContentTab.ToUpper = m_GridName.IR.ToUpper Then
            CommonFunctions.General.WriteHTML("<li class=tabSelected><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.IR) + """)' id=""" + m_GridName.IR + """ >" + m_GridName.IR + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.IR) + """)' id=""" + m_GridName.IR + """ >" + m_GridName.IR + " </a></li>&nbsp;")
        End If
        If m_strContentTab.ToUpper = m_GridName.EXPENSE.ToUpper Then
            CommonFunctions.General.WriteHTML("<li class=tabSelected><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.EXPENSE) + """)' id=""" + m_GridName.EXPENSE + """ >" + m_GridName.EXPENSE + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.EXPENSE) + """)' id=""" + m_GridName.EXPENSE + """ >" + m_GridName.EXPENSE + " </a></li>&nbsp;")
        End If
        If m_strContentTab.ToUpper = m_GridName.PROJECT.ToUpper Then
            CommonFunctions.General.WriteHTML("<li class=tabSelected><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.PROJECT) + """)' id=""" + m_GridName.PROJECT + """ >" + m_GridName.PROJECT + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.PROJECT) + """)' id=""" + m_GridName.PROJECT + """ >" + m_GridName.PROJECT + " </a></li>&nbsp;")
        End If
        If m_strContentTab.ToUpper = m_GridName.PROJECT_TIMESHEET.ToUpper Then
            CommonFunctions.General.WriteHTML("<li class=tabSelected><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.PROJECT_TIMESHEET) + """)' id=""" + m_GridName.PROJECT_TIMESHEET + """ >" + m_GridName.PROJECT_TIMESHEET + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.PROJECT_TIMESHEET) + """)' id=""" + m_GridName.PROJECT_TIMESHEET + """ >" + m_GridName.PROJECT_TIMESHEET + " </a></li>&nbsp;")
        End If
        If m_strContentTab.ToUpper = m_GridName.RESOURCE_TIMESHEET.ToUpper Then
            CommonFunctions.General.WriteHTML("<li class=tabSelected><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.RESOURCE_TIMESHEET) + """)' id=""" + m_GridName.RESOURCE_TIMESHEET + """ >" + m_GridName.RESOURCE_TIMESHEET + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.RESOURCE_TIMESHEET) + """)' id=""" + m_GridName.RESOURCE_TIMESHEET + """ >" + m_GridName.RESOURCE_TIMESHEET + " </a></li>&nbsp;")
        End If



        CommonFunctions.General.WriteHTML("</ul>")

    End Sub
    Protected Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : Main procedure to build the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 3:51 PM 9/13/2007
        ' Revisions             : 
        '=====================================================================
        Dim blnNoItemsFoundFlag As Boolean = True
        Call GetGlobalObject()
        If Not HttpContext.Current.Request.QueryString("MODE") Is Nothing Then
            Dim UniqueID As String
            Dim m_strUniqueIDs As String = ""
            Dim strGetUniqueID As String
            Dim strComment As String
            Dim intTotalNoOfGrid As Integer = GridIndex.TOTAL_GRID
            Dim intCount As Integer = 1

            If HttpContext.Current.Request.QueryString("MODE").ToUpper = "APPROVED" Then
                While intTotalNoOfGrid >= intCount
                    Select Case intCount
                        Case GridIndex.LEAVE
                            m_strUniqueIDs = Request.Form("chkLeaveShow")
                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.LEAVE)
                        Case GridIndex.IR
                            m_strUniqueIDs = Request.Form("chkIRShow")
                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.IR)
                        Case GridIndex.EXPENSE
                            m_strUniqueIDs = Request.Form("chkExpenseShow")
                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.EXPENSE)
                        Case GridIndex.PROJECT
                            m_strUniqueIDs = Request.Form("chkProjectShow")
                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.PROJECT)
                        Case GridIndex.PROJECT_TIMESHEET
                            m_strUniqueIDs = Request.Form("chkProjectTimeSheetShow")
                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.PROJECT_TIMESHEET)
                        Case GridIndex.RESOURCE_TIMESHEET
                            m_strUniqueIDs = Request.Form("chkResourceTimeSheetShow")
                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.RESOURCE_TIMESHEET)
                    End Select
                    intCount += 1
                End While
            End If

            If HttpContext.Current.Request.QueryString("MODE").ToUpper = "REJECTED" Then
                While intTotalNoOfGrid >= intCount
                    Select Case intCount
                        Case GridIndex.LEAVE
                            m_strUniqueIDs = Request.Form("chkLeaveShow")
                            RejectedSelectedRow(m_strUniqueIDs, GridIndex.LEAVE)
                        Case GridIndex.IR
                            m_strUniqueIDs = Request.Form("chkIRShow")
                            RejectedSelectedRow(m_strUniqueIDs, GridIndex.IR)
                        Case GridIndex.EXPENSE
                            m_strUniqueIDs = Request.Form("chkExpenseShow")
                            RejectedSelectedRow(m_strUniqueIDs, GridIndex.EXPENSE)
                        Case GridIndex.PROJECT
                            m_strUniqueIDs = Request.Form("chkProjectShow")
                            RejectedSelectedRow(m_strUniqueIDs, GridIndex.PROJECT)
                        Case GridIndex.PROJECT_TIMESHEET
                            m_strUniqueIDs = Request.Form("chkProjectTimeSheetShow")
                            RejectedSelectedRow(m_strUniqueIDs, GridIndex.PROJECT_TIMESHEET)
                        Case GridIndex.RESOURCE_TIMESHEET
                            m_strUniqueIDs = Request.Form("chkResourceTimeSheetShow")
                            RejectedSelectedRow(m_strUniqueIDs, GridIndex.RESOURCE_TIMESHEET)
                    End Select
                    intCount += 1
                End While
            End If

        End If

        If Not (Session("intUserID") Is Nothing) Then


            'Call PlotPageHeadTag()
            'Response.Write(GenerateMenu())
            'Response.Write(PlotSearchControl())
            Dim intTotalNoOfGrid As Integer = GridIndex.TOTAL_GRID
            Dim intCount As Integer = 1
            Call Initialize()
            '''CommonFunction.General.WriteHTML("<TABLE border=0 cellspacing =0 width=99.9%><TR class='clsTRPageHeader'>")
            '''CommonFunctions.General.WriteHTML("<TD valign='middle' align='right' nowrap width='50%'  height='0.4%'><b>Note :</b> Please select a record to enter Comment.</TD></TR><TR><TD valign='middle' align='left' nowrap width='100%'  height='2%' colspan='2'>&nbsp;</TD></TR>")
            '''CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'><TD valign='middle' align='left' nowrap width='100%'  height='0.4%' colspan='2'><B>Pending Approvals </B></TD></TR></Table>")

            '''CommonFunction.General.WriteHTML("<TABLE class='clsTable' border=0 cellspacing =0 width='99.9%'>")
            '''CommonFunctions.General.WriteHTML("<TR class='clsTROdd'><TD align='center' nowrap width='30%'  height='0.4%'><B>Comment ")
            '''CommonFunction.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , , , , 200, 40, 500)
            '''CommonFunctions.General.WriteHTML("&nbsp;&nbsp;<a href='javascript:ApplyComment(""" + m_strContentTab.ToUpper.ToString + """)'>Apply Comment to All</A></B></TD></TR></TABLE>")

            Call TabContent()
            CommonFunctions.General.WriteHTML("<div style='border:1px solid gray; width ='100%' padding: 10px'>")
            CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='overflow:auto;height=440;Width:100%;'>")
            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR><TD width='100%'>")
            CommonFunctions.General.WriteHTML(GenerateMenu())
            CommonFunctions.General.WriteHTML("</TD></TR></Table>")

            CommonFunctions.General.WriteHTML("<br>")
            While intTotalNoOfGrid >= intCount

                Select Case intCount
                    Case GridIndex.LEAVE
                        ' To plot Leave Approvals Grid
                        If m_strContentTab = m_GridName.LEAVE Then
                            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTRBlankNEW'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.LEAVE + " Approvals </B></TD></TR></Table><br>")
                            blnNoItemsFoundFlag = False
                            If m_intLeaveTotalNoOfRows > m_intPageSize Then
                                Call WritePaging(m_GridName.LEAVE, GridIndex.LEAVE)
                            End If
                            Call PlotLeavesGrid()
                        End If
                    Case GridIndex.IR
                        ' To plot IR Approvals Grid
                        If m_strContentTab = m_GridName.IR Then
                            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTRBlankNEW'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.IR + " Approvals </B></TD></TR></Table><br>")
                            blnNoItemsFoundFlag = False
                            If m_intIRTotalNoOfRows > m_intPageSize Then
                                Call WritePaging(m_GridName.IR, GridIndex.IR)
                            End If
                            Call PlotIRGrid()
                       End If
                    Case GridIndex.EXPENSE
                        ' To plot Expense Approvals Grid
                        If m_strContentTab = m_GridName.EXPENSE Then
                            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTRBlankNEW'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.EXPENSE + " Approvals </B></TD></TR></Table><br>")
                            blnNoItemsFoundFlag = False
                            If m_intExpenseTotalNoOfRows > m_intPageSize Then
                                Call WritePaging(m_GridName.EXPENSE, GridIndex.EXPENSE)
                           End If
                            Call PlotExpenseApprovals()
                        End If

                    Case GridIndex.PROJECT
                        ' To plot Project Approvals Grid
                        If m_strContentTab = m_GridName.PROJECT Then
                            blnNoItemsFoundFlag = False
                            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTRBlankNEW'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.PROJECT + " Approvals </B></TD></TR></Table><br>")
                            If m_intProjectTotalNoOfRows > m_intPageSize Then
                                Call WritePaging(m_GridName.PROJECT, GridIndex.PROJECT)
                            End If
                            Call PlotProjectGrid()
                        End If
                    Case GridIndex.PROJECT_TIMESHEET
                        ' To plot Project TimeSheet Approvals Grid
                        If m_strContentTab = m_GridName.PROJECT_TIMESHEET Then
                            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTRBlankNEW'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.PROJECT_TIMESHEET + " Approvals </B></TD></TR></Table><br>")
                            blnNoItemsFoundFlag = False
                            If m_intProjectTimeSheetTotalNoOfRows > m_intPageSize Then
                                Call WritePaging(m_GridName.PROJECT_TIMESHEET, GridIndex.PROJECT_TIMESHEET)
                            End If
                            Call PlotProjectTimeSheetGrid()
                        End If

                    Case GridIndex.RESOURCE_TIMESHEET
                        ' To plot Resource TimeSheet Approvals Grid
                        If m_strContentTab = m_GridName.RESOURCE_TIMESHEET Then
                            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTRBlankNEW'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.RESOURCE_TIMESHEET + " Approvals </B></TD></TR></Table><br>")
                            blnNoItemsFoundFlag = False
                            If m_intResourceTimeSheetTotalNoOfRows > m_intPageSize Then
                                Call WritePaging(m_GridName.RESOURCE_TIMESHEET, GridIndex.RESOURCE_TIMESHEET)
                            End If
                            Call PlotResourceTimeSheetGrid()
                         End If

                End Select
                intCount += 1
            End While
            If blnNoItemsFoundFlag = True Then
                CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
                CommonFunctions.General.WriteHTML("<TABLE class='clsGridTable' border=0 cellspacing =1 width=99.9%><TR class='clsTRBlankNEW'><TD align='center' width = '100%' height='0.4%' >There are no items to show in this view.</TD></TR></TABLE>")
            End If
            CommonFunctions.General.WriteHTML("</DIV>")
        Else
            Response.Redirect("Home_Approvals.aspx?Message=SessionExpired")
        End If
        CommonFunctions.General.WriteHTML("</div>")
    End Sub
    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : Initialize procedure to Initialize the page class level variable
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 10:20 AM 9/21/2007
        ' Revisions             : 
        '=====================================================================

        If Not HttpContext.Current.Request.QueryString("LeavePageNumber") Is Nothing Then
            m_intLeavePageNumber = CType(HttpContext.Current.Request.QueryString("LeavePageNumber"), Integer)
        End If
        If Not HttpContext.Current.Request.QueryString("IRPageNumber") Is Nothing Then
            m_intIRPageNumber = CType(HttpContext.Current.Request.QueryString("IRPageNumber"), Integer)
        End If
        If Not HttpContext.Current.Request.QueryString("ExpensePageNumber") Is Nothing Then
            m_intExpensePageNumber = CType(HttpContext.Current.Request.QueryString("ExpensePageNumber"), Integer)
        End If
        If Not HttpContext.Current.Request.QueryString("ProjectPageNumber") Is Nothing Then
            m_intProjectPageNumber = CType(HttpContext.Current.Request.QueryString("ProjectPageNumber"), Integer)
        End If
        If Not HttpContext.Current.Request.QueryString("ProjectTimeSheetPageNumber") Is Nothing Then
            m_intProjectTimeSheetPageNumber = CType(HttpContext.Current.Request.QueryString("ProjectTimeSheetPageNumber"), Integer)
        End If

        If Not HttpContext.Current.Request.QueryString("ResourceTimeSheetPageNumber") Is Nothing Then
            m_intResourceTimeSheetPageNumber = CType(HttpContext.Current.Request.QueryString("ResourceTimeSheetPageNumber"), Integer)
        End If

        If m_strContentTab = m_GridName.LEAVE Then
            m_intLeaveTotalNoOfRows = (CommonFunction.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + Session("intUserID").ToString(), m_GridName.LEAVE, , , MyBase.UseSQL)).Tables(m_GridName.LEAVE).Rows.Count
        End If

        m_intIRTotalNoOfRows = (CommonFunction.Data.GetDataSet("Usp_Sel_tbl_PM_Rfis_Approval " + m_objGlobal.UserID.ToString(), m_GridName.IR, , , MyBase.UseSQL)).Tables(m_GridName.IR).Rows.Count
        m_intExpenseTotalNoOfRows = (CommonFunction.Data.GetDataSet("Usp_tbl_PM_Expensesheet_Expensesheets_For_Approval " + m_objGlobal.UserID.ToString(), m_GridName.EXPENSE, , , MyBase.UseSQL)).Tables(m_GridName.EXPENSE).Rows.Count
        If m_strContentTab = m_GridName.PROJECT Then
            Dim strQuery As String = "EXEC usp_Sel_tbl_PM_Role_IsApprover " + CommonFunction.General.CheckIsNothing(m_objGlobal.UserID, "0").ToString()
            m_blnIsApprover = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
            If m_blnIsApprover = True Then
                m_intProjectTotalNoOfRows = (CommonFunction.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_Pending_Approval '" + m_objGlobal.UserID.ToString() + "'", m_GridName.PROJECT, , , MyBase.UseSQL)).Tables(m_GridName.PROJECT).Rows.Count
            End If
        End If
        m_intProjectTimeSheetTotalNoOfRows = (CommonFunction.Data.GetDataSet("usp_sel_tbl_PM_ProjectTimesheet_Pending_Approval " + m_objGlobal.UserID.ToString(), m_GridName.PROJECT_TIMESHEET, , , MyBase.UseSQL)).Tables(m_GridName.PROJECT_TIMESHEET).Rows.Count
        If m_strContentTab = m_GridName.RESOURCE_TIMESHEET Then
            m_intResourceTimeSheetTotalNoOfRows = (CommonFunction.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Pending_Approval " + Session("intUserID").ToString(), m_GridName.RESOURCE_TIMESHEET, , , MyBase.UseSQL)).Tables(m_GridName.RESOURCE_TIMESHEET).Rows.Count
        End If

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
        ' Author                :  MahendraV
        ' Created               :  12:08 PM 9/17/2007
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub
    Private Sub PlotLeavesGrid()
        '=====================================================================
        ' Procedure Name        : PlotLeavesGrid()
        ' Purpose               : To generate the Grid For Leave Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 11:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strNumPag As String
        If m_intLeavePageNumber > 0 Then
            strNumPag = "," + m_intLeavePageNumber.ToString
        Else
            strNumPag = ",0"
        End If
        strsql = "Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + Session("intUserID").ToString() + "" + strNumPag
        m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

        Dim arrActualColumns() As String = {"EmployeeName", "FromDate", "ToDate", "LeaveType", "", "", "", ""}
        Dim arrUserFriendlyColumn() As String = {"Employee Name", "From Date", "To Date", "Leave Type", "Scheduled Tasks", "Show Detail", "Comment", "Select"}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center", "align=center", "align=center"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "chkLeaveApprove"}
        With m_objLeavesGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "LeaveID"
            .CheckBoxIDArray = arrCheckBox
            .PageSize = m_intPageSize
            .CurrentPage = m_intLeavePageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = MyBase.UseSQL
            '.SortBy = "EmployeeName"
            '.SortOrder = "ASC"
            .DIVID = "DivLeaves"
            .DIVHeight = m_intDivHieght
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 4
            .returnHTML = True
            CommonFunctions.General.WriteHTML((.DrawGrid()).Replace("class=clsTREvenRow", "class=clsTRBlankNew").Replace("class='clsTRSectionHeader'", "class=clsTRBlankNew"))
        End With
        m_objLeavesGrid = Nothing
        m_dsGrid = Nothing
    End Sub
    Private Sub PlotIRGrid()
        '=====================================================================
        ' Procedure Name        : PlotIRGrid()
        ' Purpose               : To generate the Grid For IR Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 6:21 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strNumPag As String
        If m_intIRPageNumber > 0 Then
            strNumPag = "," + m_intIRPageNumber.ToString
        Else
            strNumPag = ",0"
        End If
        strsql = "Usp_Sel_tbl_PM_Rfis_Approval " + m_objGlobal.UserID.ToString() + "" + strNumPag
        m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

        Dim arrActualColumns() As String = {"ProjectName", "CustomerName", "UniqueID", "RFITypeName", "Amount", "", "", ""}
        Dim arrUserFriendlyColumn() As String = {"Project Name", "Customer Name", "ID", "Type", "Amount", "Show Detail", "Comment", "Select"}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=right", "align=left", "align=left", "align=center", "align=center", "align=center"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "chkExpenseApprove"}
        Dim arrstrGroupOnColumn() As String = {"0"}
        With m_objIRGrid
            .GroupOnColumn = arrstrGroupOnColumn
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "UniqueID"
            .PageSize = m_intPageSize
            '.SortBy = "ProjectName"
            '.SortOrder = "ASC"
            .CurrentPage = m_intIRPageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = MyBase.UseSQL
            .DIVID = "DivIR"
            .DIVHeight = m_intDivHieght
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 4
            .returnHTML = True
            CommonFunctions.General.WriteHTML((.DrawGrid()).Replace("class=clsTREvenRow", "class=clsTRBlankNew").Replace("class='clsTRSectionHeader'", "class=clsTRBlankNew"))
        End With

        m_objIRGrid = Nothing
        m_dsGrid = Nothing

    End Sub
    Private Sub PlotExpenseApprovals()
        '=====================================================================
        ' Procedure Name        : PlotExpenseApprovals()
        ' Purpose               : To generate the Grid For Expense Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strNumPag As String
        If m_intExpensePageNumber > 0 Then
            strNumPag = "," + m_intExpensePageNumber.ToString
        Else
            strNumPag = ",0"
        End If

        strsql = "Usp_tbl_PM_Expensesheet_Expensesheets_For_Approval " + m_objGlobal.UserID.ToString() + "" + strNumPag
        m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

        Dim arrActualColumns() As String = {"Title", "ExpenseSheetID", "SubmittedBy", "CurrencySymbol", "TotalAmount", "StatusDate", "", "", ""}
        Dim arrUserFriendlyColumn() As String = {"Title", "ID", "Submitted By", "CurrencySymbol", "Total Amount", "Status Change Date", "Show Detail", "Comment", "Select"}
        Dim arrTDStyle() As String = {"align=left", "align=right", "align=left", "align=left", "align=left", "align=center", "align=center", "align=center", "align=center"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "", "chkExpenseApprove"}
        With m_objExpenseGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "ExpenseSheetID"
            .CheckBoxIDArray = arrCheckBox
            .PageSize = m_intPageSize
            .CurrentPage = m_intExpensePageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = MyBase.UseSQL
            '.SortBy = "Title"
            '.SortOrder = "ASC"
            .DIVID = "DivExpense"
            .DIVHeight = m_intDivHieght
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = arrActualColumns.Length - 3
            .returnHTML = True
            CommonFunctions.General.WriteHTML((.DrawGrid()).Replace("class=clsTREvenRow", "class=clsTRBlankNew").Replace("class='clsTRSectionHeader'", "class=clsTRBlankNew"))
        End With

        HttpContext.Current.Session("ExpenseSheetIDList") = ""
        HttpContext.Current.Session("TokenForExpences") = ""
        HttpContext.Current.Session("ExpenseSheetIDList") = strExpenseSheetIDList
        HttpContext.Current.Session("TokenForExpences") = strTokenIDList

        m_objExpenseGrid = Nothing
        m_dsGrid = Nothing
    End Sub
    Private Sub PlotProjectGrid()
        '=====================================================================
        ' Procedure Name        : PlotProjectGrid()
        ' Purpose               : To generate the Grid For Project Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 12:15 PM 9/14/2007
        ' Revisions             :
        '=====================================================================
        Dim strNumPag As String
        If m_intProjectPageNumber > 0 Then
            strNumPag = "," + m_intProjectPageNumber.ToString
        Else
            strNumPag = ",0"
        End If

        strsql = "Usp_Sel_tbl_PM_ProjectRevision_Pending_Approval  '" + m_objGlobal.UserID.ToString() + "' " + strNumPag
        m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

        Dim arrActualColumns() As String = {"ProjectName", "ProjectType", "ExpectedStartDate", "ExpectedEndDate", "", "", ""}
        Dim arrUserFriendlyColumn() As String = {"Project Name", "Practice", "Start Date", "End Date", "Show Detail", "Comment", "Select"}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center", "align=center"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "chkProjectApprove"}
        With m_objProjectGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "ProjectID"
            .PageSize = m_intPageSize
            .CurrentPage = m_intProjectPageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = MyBase.UseSQL
            '.SortBy = "ProjectName"
            '.SortOrder = "ASC"
            .DIVID = "DivProject"
            .DIVHeight = m_intDivHieght
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 4
            .returnHTML = True
            CommonFunctions.General.WriteHTML((.DrawGrid()).Replace("class=clsTREvenRow", "class=clsTRBlankNew").Replace("class='clsTRSectionHeader'", "class=clsTRBlankNew"))
        End With

        m_objProjectGrid = Nothing
        m_dsGrid = Nothing

    End Sub
    Private Sub PlotProjectTimeSheetGrid()
        '=====================================================================
        ' Procedure Name        : PlotProjectGrid()
        ' Purpose               : To generate the Grid For Project TimeSheet Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 12:55 PM 9/14/2007
        ' Revisions             :
        '=====================================================================
        Dim strNumPag As String
        If m_intProjectTimeSheetPageNumber > 0 Then
            strNumPag = "," + m_intProjectTimeSheetPageNumber.ToString
        Else
            strNumPag = ",0"
        End If

        strsql = "usp_sel_tbl_PM_ProjectTimesheet_Pending_Approval " + m_objGlobal.UserID.ToString() + "" + strNumPag
        m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

        Dim arrActualColumns() As String = {"TimeSheetNo", "CreatedDate1", "ProjectName", "FromDate", "ToDate", "", "", ""}
        Dim arrUserFriendlyColumn() As String = {"Time Sheet No", "Date", "Project Name", "From Date", "To Date", "Show Detail", "Comment", "Select"}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=center", "align=center", "align=center"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "chkProjectTimesheetApprover"}
        With m_objProjectTimeSheetGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "TimeSheetNo"
            .PageSize = m_intPageSize
            .CurrentPage = m_intProjectTimeSheetPageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = MyBase.UseSQL
            '.SortBy = "ProjectName"
            '.SortOrder = "ASC"
            .DIVID = "DivProjectTimeSheet"
            .DIVHeight = m_intDivHieght
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 4
            .returnHTML = True
            CommonFunctions.General.WriteHTML((.DrawGrid()).Replace("class=clsTREvenRow", "class=clsTRBlankNew").Replace("class='clsTRSectionHeader'", "class=clsTRBlankNew"))
        End With

        m_objProjectTimeSheetGrid = Nothing
        m_dsGrid = Nothing

    End Sub
    Private Sub PlotResourceTimeSheetGrid()
        '=====================================================================
        ' Procedure Name        : PlotResourceTimeSheetGrid()
        ' Purpose               : To generate the Grid For Resource TimeSheet Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:18 PM 9/14/2007
        ' Revisions             :
        '=====================================================================
        Dim strNumPag As String
        If m_intResourceTimeSheetPageNumber > 0 Then
            strNumPag = "," + m_intResourceTimeSheetPageNumber.ToString
        Else
            strNumPag = ",0"
        End If

        strsql = "usp_sel_tbl_PM_ResourceTimesheet_Pending_Approval " + Session("intUserID").ToString() + "" + strNumPag
        m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

        Dim arrActualColumns() As String = {"EmployeeName", "FromDate", "ToDate", "TotalAMH", "", "", ""}
        Dim arrUserFriendlyColumn() As String = {"Employee Name", "From Date", "To Date", "Actual Work(hrs)", "Show Detail", "Comment", "Select"}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center", "align=center"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "chkResourceTimesheetApprover"}
        With m_objResourceTimeSheetGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "TimesheetID"
            .PageSize = m_intPageSize
            .CurrentPage = m_intResourceTimeSheetPageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = MyBase.UseSQL
            '.SortBy = "EmployeeName"
            '.SortOrder = "ASC"
            .DIVID = "DivResourceTimeSheet"
            .DIVHeight = m_intDivHieght
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 4
            .returnHTML = True
            CommonFunctions.General.WriteHTML((.DrawGrid()).Replace("class=clsTREvenRow", "class=clsTRBlankNew").Replace("class='clsTRSectionHeader'", "class=clsTRBlankNew"))

        End With
        Session("TSIDs") = m_strTSIDs
        Session("TSIDsWithToken") = m_strTSIDsWithToken
        m_objResourceTimeSheetGrid = Nothing
        m_dsGrid = Nothing

    End Sub
    Private Sub WritePaging(ByVal strGridName As String, ByVal intGridNo As Integer)
        '=====================================================================
        ' function Name         : WritePaging(ByVal strGridName As String, ByVal intGridNo As Integer)
        ' Purpose               : To write the paging for the request grid
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                :  MahendraV
        ' Created               : 11:10 AM 9/17/2007
        ' Revisions             :
        '=====================================================================

        Dim strSectionTag As String = strGridName + "divGrid"
        Dim strFunctionName As String = strGridName + "ShowHide_divGrid"
        Dim intRecordCount As Integer
        Dim dsObject As DataSet
        Dim strPaging As String = ""

        strPaging = "<TABLE border='0' cellspacing = '1' width = '100%' height='0.4%' class='clsGridTable'><TR class='clsTREven'><TD align='right' width = '100%' height='0.4%' colspan = '2' >"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage(" + CType(intGridNo, String) + ")"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage(" + CType(intGridNo, String) + ")""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NavPreviousEnable.gif' align='top'></A>"

        Select Case intGridNo
            Case GridIndex.LEAVE
                m_intTotalNoOfRows = m_intLeaveTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intLeavePageNumber Then
                    m_intLeavePageNumber = 1
                End If
                If m_intLeavePageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                Else
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intLeavePageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                End If
            Case GridIndex.IR
                m_intTotalNoOfRows = m_intIRTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intIRPageNumber Then
                    m_intIRPageNumber = 1
                End If
                If m_intIRPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                Else
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intIRPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                End If
            Case GridIndex.EXPENSE
                m_intTotalNoOfRows = m_intExpenseTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intExpensePageNumber Then
                    m_intExpensePageNumber = 1
                End If
                If m_intExpensePageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                Else
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intExpensePageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                End If
            Case GridIndex.PROJECT
                m_intTotalNoOfRows = m_intProjectTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intProjectPageNumber Then
                    m_intProjectPageNumber = 1
                End If
                If m_intProjectPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                Else
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intProjectPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                End If
            Case GridIndex.PROJECT_TIMESHEET
                m_intTotalNoOfRows = m_intProjectTimeSheetTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intProjectTimeSheetPageNumber Then
                    m_intProjectTimeSheetPageNumber = 1
                End If
                If m_intProjectTimeSheetPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                Else
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intProjectTimeSheetPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                End If
            Case GridIndex.RESOURCE_TIMESHEET
                m_intTotalNoOfRows = m_intResourceTimeSheetTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intResourceTimeSheetPageNumber Then
                    m_intResourceTimeSheetPageNumber = 1
                End If
                If m_intResourceTimeSheetPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                Else
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intResourceTimeSheetPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                End If
        End Select

        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage(" + CType(intGridNo, String) + ")"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage(" + CType(intGridNo, String) + ")"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages" + CType(intGridNo, String) + " value=" + (Math.Ceiling(m_intTotalNoOfRows / m_intPageSize)).ToString + ">"
        strPaging += "of " + (Math.Ceiling(m_intTotalNoOfRows / m_intPageSize)).ToString
        strPaging += " |<A href='javascript:NumPage_OnClick(""-1""," + CType(intGridNo, String) + ")' TITLE='Show All Records'><B>All</B> </A>"
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages" + CType(intGridNo, String), "txtNoOfPages" + CType(intGridNo, String), , , , (Math.Ceiling(m_intTotalNoOfRows / m_intPageSize)).ToString, returnHTML:=True, DisplayNone:=True)
        strPaging += "</TD></TR></TABLE>"

        Select Case intGridNo
            Case GridIndex.LEAVE
                Response.Write(m_objSectionTitleLeave.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                Response.Write("<script language=javascript>" & m_objSectionTitleLeave.ClientsideScript & "</script>")
            Case GridIndex.IR
                Response.Write(m_objSectionTitleIR.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                Response.Write("<script language=javascript>" & m_objSectionTitleIR.ClientsideScript & "</script>")

            Case GridIndex.EXPENSE
                Response.Write(m_objSectionTitleExpense.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                Response.Write("<script language=javascript>" & m_objSectionTitleExpense.ClientsideScript & "</script>")

            Case GridIndex.PROJECT
                Response.Write(m_objSectionTitleProject.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                Response.Write("<script language=javascript>" & m_objSectionTitleProject.ClientsideScript & "</script>")

            Case GridIndex.PROJECT_TIMESHEET
                Response.Write(m_objSectionTitleProjectTimeSheet.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                Response.Write("<script language=javascript>" & m_objSectionTitleProjectTimeSheet.ClientsideScript & "</script>")

            Case GridIndex.RESOURCE_TIMESHEET
                Response.Write(m_objSectionTitleResourceTimeSheet.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                Response.Write("<script language=javascript>" & m_objSectionTitleResourceTimeSheet.ClientsideScript & "</script>")

        End Select
        dsObject = Nothing

    End Sub
    Private Sub AprrovedSelectedRow(ByVal m_strUniqueIDs As String, ByVal intGridIndex As Integer)
        '=====================================================================
        ' Procedure Name        : AprrovedSelectedRow()
        ' Purpose               : To find the index of selected Leave,IR,Expense,Project,Project TimeSheet and Resourse TimeSheet
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 8:12 PM 9/19/2007
        ' Revisions             :
        '=====================================================================

        Dim strComment As String
        Dim strUniqueID As String
        Dim strGetUniqueID As String
        While (m_strUniqueIDs <> "")

            If m_strUniqueIDs.LastIndexOf(",") <> m_strUniqueIDs.Length - 1 Then

                strUniqueID = m_strUniqueIDs
                If m_strUniqueIDs.LastIndexOf(",") = -1 Then
                    strGetUniqueID = m_strUniqueIDs
                    strComment = Request.Form("txt_" & strGetUniqueID)
                    m_strUniqueIDs = ""
                End If

                m_strUniqueIDs = m_strUniqueIDs.Substring(m_strUniqueIDs.LastIndexOf(",") + 1)
                If m_strUniqueIDs <> "" Then
                    strGetUniqueID = m_strUniqueIDs
                    strComment = Request.Form("txt_" & strGetUniqueID)
                    strUniqueID = strUniqueID.Replace("," + m_strUniqueIDs, "")
                    m_strUniqueIDs = strUniqueID
                End If

            End If
           
            Approved(strGetUniqueID, strComment, intGridIndex)
        End While
    End Sub
    Protected Sub RejectedSelectedRow(ByVal m_strUniqueIDs As String, ByVal intGridIndex As Integer)
        '=====================================================================
        ' Procedure Name        : RejectedSelectedRow()
        ' Purpose               : To find the index of selected Leave,IR,Expense,Project,Project TimeSheet and Resourse TimeSheet
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 08-April-2009
        ' Revisions             :
        '=====================================================================

        Dim strComment As String
        Dim strUniqueID As String
        Dim strGetUniqueID As String
        While (m_strUniqueIDs <> "")

            If m_strUniqueIDs.LastIndexOf(",") <> m_strUniqueIDs.Length - 1 Then

                strUniqueID = m_strUniqueIDs
                If m_strUniqueIDs.LastIndexOf(",") = -1 Then
                    strGetUniqueID = m_strUniqueIDs
                    strComment = Request.Form("txt_" & strGetUniqueID)
                    m_strUniqueIDs = ""
                End If

                m_strUniqueIDs = m_strUniqueIDs.Substring(m_strUniqueIDs.LastIndexOf(",") + 1)
                If m_strUniqueIDs <> "" Then
                    strGetUniqueID = m_strUniqueIDs
                    strComment = Request.Form("txt_" & strGetUniqueID)
                    strUniqueID = strUniqueID.Replace("," + m_strUniqueIDs, "")
                    m_strUniqueIDs = strUniqueID
                End If

            End If

          
            Rejected(strGetUniqueID, strComment, intGridIndex)
        End While
    End Sub
    Private Sub Approved(ByVal strUniqueID As String, ByVal strComment As String, ByVal intGridIndex As Integer)
        '=====================================================================
        ' Procedure Name        : Approved()
        ' Purpose               : To Approve the Leave,IR,Expense,Project,Project TimeSheet and Resourse TimeSheet
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 8:12 PM 9/19/2007
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Select Case intGridIndex
            Case GridIndex.LEAVE

                Dim lngLeaveStatusID As Long = 2
                strQuery = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " & strUniqueID
                strQuery &= ", " & lngLeaveStatusID.ToString()
                strQuery &= ", " & Session("intUserID").ToString()
                strQuery &= ", N'" & CommonFunctions.General.BuildQueryString(strComment) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case GridIndex.IR

                Dim drDetails As IDataReader
                Dim intProjectID As Integer
                strQuery = "EXEC usp_Sel_tbl_PM_RFIs " & strUniqueID
                drDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drDetails.Read Then
                    intProjectID = CType(CommonFunctions.General.CheckIsNothing(drDetails.Item("ProjectID"), "0"), Integer)
                End If
                CommonFunctions.Data.DisposeDataReader(drDetails)
                ' Build query to update the RFI status and insert the Status History record.
                strQuery = "EXEC usp_Upd_tbl_PM_RFIs_ChangeRFIStatus " & strUniqueID & ", " & intProjectID
                strQuery = strQuery & ", '" & CommonFunctions.General.BuildQueryString("Approved") & "'"
                strQuery = strQuery & ", N'" & CommonFunctions.General.BuildQueryString(strComment) & "'"
                strQuery = strQuery & ", N'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case GridIndex.EXPENSE

                
                PerformExpenseSheetOperation(strUniqueID, strComment, "A")

            Case GridIndex.PROJECT

                strQuery = "EXEC usp_Sel_IsStageProjectWorkflow "
                strQuery = strQuery & " " & CType(strUniqueID, String)
                m_blnIsStageProjectWorkflow = CType(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), Boolean)

                If m_blnIsStageProjectWorkflow Then
                    CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobal, strUniqueID, "SYS_APPROVE", 32, , "HOME", CommonFunction.General.BuildQueryString(strComment))
                Else

                    strQuery = "EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason "
                    strQuery = strQuery & "'" & CType(strUniqueID, String) & "',"
                    strQuery = strQuery & "N'" & CommonFunction.General.BuildQueryString(strComment) & "',"
                    strQuery = strQuery & "N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(m_objGlobal.UserName, "").ToString()) & "','A' "
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                End If

            Case GridIndex.PROJECT_TIMESHEET

                strQuery = "EXEC usp_Upd_tbl_PM_TimeSheetInvoice '" & strUniqueID & "',"
                strQuery = strQuery & "N'" & CommonFunction.General.BuildQueryString(strComment) & "'"
                strQuery = strQuery & ",N'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case GridIndex.RESOURCE_TIMESHEET

                Dim drVerify As IDataReader
                Dim m_drTimesheet As IDataReader
                Dim intVerifiedBy As Long
                Dim intDailyActivityID As Integer
                Dim intVerified As Integer
                Dim strSQLQuery As String
                Dim strRemarks As String
                Dim dtVerificationDate As String
                Dim strFromDate As String
                Dim strToDate As String

                dtVerificationDate = CType(Now(), String)
                intVerifiedBy = CommonFunction.General.CheckIsNothing(Session("intUserID"), "0")
                strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & strUniqueID & "," & CType(intVerifiedBy, String)
                m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                'Get Activity record details for the resource timesheet
                Do While m_drTimesheet.Read()
                    strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
                    strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
                    intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
                    intVerified = 1
                    strRemarks = "'" & CommonFunction.General.BuildQueryString(strComment) & "',"

                    '--- Execute sp to update verification details to Daily Activity Table
                    strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
                    strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "',N'" + strRemarks + "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Loop

                CommonFunctions.Data.DisposeDataReader(m_drTimesheet)

                'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & strUniqueID & "," & CType(intVerifiedBy, String) & "," & "'V'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))



                'If Resource TimeSheet are verified then change the status to 'verified' 
                strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & CType(strUniqueID, String)
                drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drVerify.Read = False Then
                    strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & CType(strUniqueID, String) & ",'V'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
                CommonFunctions.Data.DisposeDataReader(drVerify)
        End Select


    End Sub
    Private Sub PerformExpenseSheetOperation(ByVal PrimaryKeyID As String, ByVal ActionComment As String, ByVal ActionType As String)
        '=====================================================================
        ' Procedure Name        : PerformExpenseSheetOperation()
        ' Purpose               : To perform expenseheet approve or reject operation
        ' Parameters Passed     : PrimaryKeyID,Comment,Action Type (i.e.Approve or Reject)
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : 14th Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim drExpensesEntryID As IDataReader
        Dim m_blnisValidExpenses As Boolean = False
        Dim strExpensesEntryIds As String = ""
        Dim strExpenseEntryCommentsList As String = ""
        Dim sSQL As String = ""
        Dim dsExpense As DataSet
        Dim strFinNotSetEntries As String = ""

        sSQL = "usp_Sel_tbl_PM_Expenses_ForExpenseSheet " + m_objGlobal.UserID.ToString() + "," + PrimaryKeyID + ",1"
        dsExpense = CommonFunctions.Data.GetDataSet(sSQL, "Expense", , , MyBase.UseSQL)

        For Each drRow As DataRow In dsExpense.Tables(0).Select("ActualStatus='ReSubmitted' OR ActualStatus='Submitted'")
            strExpensesEntryIds = strExpensesEntryIds + CType(CommonFunctions.Data.CheckIsDBNull(drRow("ExpensesEntryID"), "0"), String) + ","
            strExpenseEntryCommentsList = strExpenseEntryCommentsList + ActionComment + ":#:"
        Next

        dsExpense = Nothing

        strExpensesEntryIds = strExpensesEntryIds.Substring(0, strExpensesEntryIds.LastIndexOf(","))
        
        If ActionType.ToUpper = "A" Then
            sSQL = "usp_IsFinanceApproverSetFor_SelectedExpenses '" & strExpensesEntryIds & "'"
            strFinNotSetEntries = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), String)
        End If

        If strFinNotSetEntries <> "" Then
            CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
            CommonFunction.General.WriteHTML("alert('Expense Entries with following IDs cannot be sent for Finance Approval as Finance Approver is not Set for them. IDs:" + strFinNotSetEntries + "');" + vbCrLf)
            CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
        Else
            If m_objGlobal.UserID.ToString() <> "" And PrimaryKeyID <> "" Then
                sSQL = "EXEC usp_Sel_CheckValidExpenseEntries " & m_objGlobal.UserID.ToString() & ", 1," & PrimaryKeyID & ",'" & strExpensesEntryIds & ",'"
                m_blnisValidExpenses = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Boolean)
            End If

            If m_blnisValidExpenses = False Or CheckApproverAccess(PrimaryKeyID) = False Then
                'action to take on invalid login
                Session.Abandon()
                Response.Write("<script language=javascript>" & vbCrLf)
                Response.Write("	window.open(""../../Approvals.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                Response.Write("</script>" & vbCrLf)
                Response.End()
            Else
                If ActionType.ToUpper = "A" Then
                    sSQL = "usp_upd_tbl_PM_ExpenseEntry_Approved "
                Else
                    sSQL = "usp_upd_tbl_PM_ExpenseEntry_Rejected "
                End If
                sSQL += PrimaryKeyID + ", '" + strExpensesEntryIds + "' , N'"
                sSQL += strExpenseEntryCommentsList + "', "
                sSQL += m_objGlobal.UserID.ToString()

                If ActionType.ToUpper = "A" Then
                    sSQL += ",1"
                End If

                CommonFunction.Data.InsertOrUpdateData(sSQL, MyBase.UseSQL)
            End If
        End If
    End Sub
    Private Sub Rejected(ByVal strUniqueID As String, ByVal strComment As String, ByVal intGridIndex As Integer)
        '=====================================================================
        ' Procedure Name        : Rejected()
        ' Purpose               : To reject the Leave,IR,Expense,Project,Project TimeSheet and Resourse TimeSheet
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 8-April-2009
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Select Case intGridIndex
            Case GridIndex.LEAVE

                Dim lngLeaveStatusID As Long = 3
                strQuery = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " & strUniqueID
                strQuery &= ", " & lngLeaveStatusID.ToString()
                strQuery &= ", " & Session("intUserID").ToString()
                strQuery &= ", N'" & CommonFunctions.General.BuildQueryString(strComment) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case GridIndex.IR

                Dim drDetails As IDataReader
                Dim intProjectID As Integer
                strQuery = "EXEC usp_Sel_tbl_PM_RFIs " & strUniqueID
                drDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drDetails.Read Then
                    intProjectID = CType(CommonFunctions.General.CheckIsNothing(drDetails.Item("ProjectID"), "0"), Integer)
                End If
                CommonFunctions.Data.DisposeDataReader(drDetails)
                ' Build query to update the RFI status and insert the Status History record.
                strQuery = "EXEC usp_Upd_tbl_PM_RFIs_ChangeRFIStatus " & strUniqueID & ", " & intProjectID
                strQuery = strQuery & ", '" & CommonFunctions.General.BuildQueryString("Rejected") & "'"
                strQuery = strQuery & ", N'" & CommonFunctions.General.BuildQueryString(strComment) & "'"
                strQuery = strQuery & ", N'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case GridIndex.EXPENSE

                PerformExpenseSheetOperation(strUniqueID, strComment, "R")
                

            Case GridIndex.PROJECT

                strQuery = "EXEC usp_Sel_IsStageProjectWorkflow "
                strQuery = strQuery & " " & CType(strUniqueID, String)
                m_blnIsStageProjectWorkflow = CType(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), Boolean)

                If m_blnIsStageProjectWorkflow Then
                    CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobal, strUniqueID, "SYS_REJECT", 32, , "HOME", CommonFunction.General.BuildQueryString(strComment))
                Else

                    strQuery = "EXEC usp_Ins_tbl_PM_ProjectBaselineRejectionReason "
                    strQuery = strQuery & "'" & CType(strUniqueID, String) & "',"
                    strQuery = strQuery & "'" & CommonFunction.General.BuildQueryString(strComment) & "',"
                    strQuery = strQuery & "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(m_objGlobal.UserName, "").ToString()) & "'"

                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                End If

            Case GridIndex.PROJECT_TIMESHEET

                strQuery = "EXEC usp_Upd_tbl_PM_TimeSheetInvoice_For_Rejection '" & strUniqueID & "',"
                strQuery = strQuery & "N'" & CommonFunction.General.BuildQueryString(strComment) & "'"
                strQuery = strQuery & ",N'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case GridIndex.RESOURCE_TIMESHEET

                Dim drVerify As IDataReader
                Dim m_drTimesheet As IDataReader
                Dim intVerifiedBy As Long
                Dim intDailyActivityID As Integer
                Dim intVerified As Integer
                Dim strSQLQuery As String
                Dim strRemarks As String
                Dim dtVerificationDate As String
                Dim strFromDate As String
                Dim strToDate As String
                Dim strRemarksIDs As String = ""

                dtVerificationDate = CType(Now(), String)
                intVerifiedBy = CommonFunction.General.CheckIsNothing(Session("intUserID"), "0")
                strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & strUniqueID & "," & CType(intVerifiedBy, String)
                m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                'Get Activity record details for the resource timesheet
                Do While m_drTimesheet.Read()
                    strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
                    strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
                    intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
                    intVerified = 0
                    strRemarks = CommonFunction.General.BuildQueryString(strComment)

                    '--- Execute sp to update verification details to Daily Activity Table
                    strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
                    strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "',N'" + strRemarks + "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    strRemarksIDs += CType(intDailyActivityID, String)
                Loop

                CommonFunctions.Data.DisposeDataReader(m_drTimesheet)

                strQuery = "usp_Upd_UnverifyResouceTimesheetStatus " + strUniqueID + "," + CType(intVerifiedBy, String) + ",'" + CType(strRemarksIDs, String) + "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & strUniqueID & "," & CType(intVerifiedBy, String) & "," & "'J'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))





        End Select
    End Sub
    Protected Sub PlotHeadTag()
        CommonFunctions.General.PlotPageHeadTag("Approvals", , , , "<link rel=""stylesheet"" type=""text/css"" href=""../General/tabcontent.css"" />")
    End Sub

#End Region

#Region " General Events Definition"

    Private Sub m_objLeavesGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objLeavesGrid.ColumnHeaderTD_BeforePrint

    End Sub

    Private Sub m_objLeavesGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objLeavesGrid.ColumnHeaderTR_BeforePrint
        Args.clsColumnHeader = "clsTheadBlankNEW"
    End Sub
    Private Sub m_objLeavesGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objLeavesGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objLeavesGrid_DataRowTD_BeforePrint()
        ' Purpose               : To modify the Grid For Leaves Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strUniqueID As String
        Dim strTxtName As String
        Dim intLeaveID As Integer
        Dim blnIsChecked As Boolean = False
        Dim strEmployeeName As String
        Dim strPKToken As String = ""
        intLeaveID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), Integer)
        strUniqueID = CType(intLeaveID, String)
        strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String)
        strEmployeeName = strEmployeeName.Replace("'", "").Trim()
        If Args.ColumnName.ToUpper = "SHOW DETAIL" Then
            Cancel = True
            strPKToken = CommonFunctions.Security.Token.GetToken(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0").ToString + Session("intUserID").ToString + "0" + "1208")
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><a href='javascript:javascript:ShowDetail(1,""" + strPKToken + """," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), String) + ")' title='Click to show detail' > Show Detail </a></td>"
        End If
        If Args.ColumnName.ToUpper = "SCHEDULED TASKS" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><a href='javascript:javascript:Scheduled_Tasks(1," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), String) + "," + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0").ToString + ",""" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FromDate"), "0").ToString + """,""" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ToDate"), "0").ToString + """)' title='Click to show detail' > Scheduled Tasks </a></td>"
        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strEmployeeName + " for " + m_GridName.LEAVE + " Approvals'>"
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkLeaveShow", "chkLeaveShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intLeaveID"",1) ", True)
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "COMMENT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), String) + "'  src='../../Images/Home/Details.gif' expand='true' onclick='javascript:DisplayComment(1,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), String) + ")'> <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
        End If

    End Sub

    Private Sub m_objIRGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objIRGrid.ColumnHeaderTR_BeforePrint
        Args.clsColumnHeader = "clsTheadBlankNEW"
    End Sub
    Private Sub m_objIRGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objIRGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objIRGrid_DataRowTD_BeforePrint()
        ' Purpose               : To modify the Grid For IR Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strUniqueID As String
        Dim strTxtName As String
        Dim intUniqueID As Integer
        Dim blnIsChecked As Boolean = False
        Dim strProjectName As String
        Dim strAmmount As String
        Dim strPKToken As String = ""
        intUniqueID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), Integer)
        strProjectName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String)
        strAmmount = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Amount"), ""), String)
        strProjectName = strProjectName.Replace("'", "")
        strAmmount = strAmmount.Replace("'", "").Trim()
        strUniqueID = CType(intUniqueID, String)
        If Args.ColumnName.ToUpper = "SHOW DETAIL" Then
            Cancel = True
            strPKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2074, String) + CType(0, String) + CType(Args.DataReader.Item("ProjectID"), String)) 'CommonFunctions.Security.Token.GetToken(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0").ToString + Session("intUserID").ToString + "0" + "2074")
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><a href='javascript:javascript:ShowDetail(2,""" + strPKToken + """," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), String) + ")' title='Click to show detail' > Show Detail </a></td>"
        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strProjectName + " of Ammount " + strAmmount + " for " + m_GridName.IR + " Aprrovals'>"
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkIRShow", "chkIRShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intUniqueID"",2) ", True)
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "COMMENT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), String) + "'  src='../../Images/Home/Details.gif' expand='true' onclick='javascript:DisplayComment(2,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), String) + ")'>  <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
        End If
    End Sub
    Private Sub m_objExpenseGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objExpenseGrid.ColumnHeaderTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objExpenseGrid_ColumnHeaderTD_BeforePrint()
        ' Purpose               : To modify the Grid For Expense Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================

        If Args.DataField.ToUpper = "CURRENCYSYMBOL" Then
            Cancel = True
            Args.ApplySorting = False
            Args.StringToBeInserted = ""
        End If
        If Args.ColumnName.ToUpper = "TOTAL AMOUNT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD nowrap colspan=2 align=center Title=""ID :  Column Name : Total Amount""><B>" + Args.ColumnName + "</B></TD>"

        End If
    End Sub

    Private Sub m_objExpenseGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objExpenseGrid.ColumnHeaderTR_BeforePrint
        Args.clsColumnHeader = "clsTheadBlankNEW"
    End Sub
    Private Sub m_objExpenseGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objExpenseGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objExpenseGrid_ColumnHeaderTD_BeforePrint()
        ' Purpose               : To modify the Grid For Expense Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strUniqueID As String
        Dim strTxtName As String
        Dim intExpenseSheetID As Integer
        Dim blnIsChecked As Boolean = False
        Dim strTitle As String
        Dim strPKToken As String = ""
        intExpenseSheetID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), Integer)
        strTitle = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Title"), ""), String)
        strUniqueID = CType(intExpenseSheetID, String)
        strTitle = strTitle.Replace("'", "").Trim()
        If Args.ColumnName.ToUpper = "SHOW DETAIL" Then
            Cancel = True
            strPKToken = CommonFunctions.Security.Token.GetToken(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0").ToString + Session("intUserID").ToString + "0" + "3595")
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><a href='javascript:javascript:ShowDetail(3,""" + strPKToken + """," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), String) + ")' title='Click to show detail' > Show Detail </a></td>"
        End If
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strTitle + " for " + m_GridName.EXPENSE + " Approvals'>"
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkExpenseShow", "chkExpenseShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intExpenseSheetID"",3) ", True)
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "COMMENT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), String) + "'  src='../../Images/Home/Details.gif' expand='true' onclick='javascript:DisplayComment(3,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), String) + ")'>  <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
        End If
        ' if the Currency Count is more than 1 then down show the Currency And Amount 
        Dim m_lngCurrencyCount As Long = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CurrencyCount"), "0"), "0"), Long)

        If m_lngCurrencyCount > 1 Then
            ' modified by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 
            If Args.DataField.ToUpper = "CURRENCYSYMBOL" Then
                ' Args.IgnoreActualValue = True
                Args.ReplacementValue = "-"
                '<TD   align=Left Title="ID : 51 Column Name : Amount Details"><A href="Javascript:Hyperlink1(&quot;61&quot;,&quot;51&quot;)" Title="Click to View Amount Distribution Per Currency"></A></TD>
            ElseIf Args.DataField.ToUpper = "TOTALAMOUNT" Then
                'Args.IgnoreActualValue = True
                '  Args.ReplacementValue = "-"
                '  ElseIf Args.ColumnName.ToUpper = "AMOUNT DETAILS" Then
                'Args.IgnoreActualValue = True
                'Args.EnableLink = False
                Cancel = True
                Args.StringToBeInserted = "<td align='center'><A href=""Javascript:Hyperlink1(&quot;" + Args.DataReader("EmployeeId").ToString + "&quot;,&quot;" + Args.DataReader("ExpenseSheetID").ToString + "&quot;)"" Title=""Click to View Amount Distribution Per Currency""> Amount Details </A></td>"

            End If
            ' end of modified by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 
            'Else
            '    ' modified by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 
            '    If Args.DataField.ToUpper = "TOTALAMOUNT" Then
            '        ' Args.IgnoreActualValue = True
            '        Args.EnableLink = False
            '        Args.ReplacementValue = "-"
            '        ' end of modified by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 
            '    End If

        End If

    End Sub

    Private Sub m_objProjectGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objProjectGrid.ColumnHeaderTR_BeforePrint
        Args.clsColumnHeader = "clsTheadBlankNEW"
    End Sub
    Private Sub m_objProjectGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objProjectGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objProjectGrid_DataRowTD_BeforePrint()
        ' Purpose               : To modify the Grid For Project Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strUniqueID As String
        Dim strTxtName As String
        Dim intProjectID As Integer
        Dim blnIsChecked As Boolean = False
        Dim strProjectName As String
        Dim strPKToken As String = ""
        intProjectID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), Integer)
        strProjectName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String)
        strProjectName = strProjectName.Replace("'", "").Trim()
        strUniqueID = CType(intProjectID, String)
        If Args.ColumnName.ToUpper = "SHOW DETAIL" Then
            Cancel = True
            strPKToken = CommonFunctions.Security.Token.GetToken(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0").ToString + Session("intUserID").ToString + "0" + "32")
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><a href='javascript:javascript:ShowDetail(4,""" + strPKToken + """," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) + ")' title='Click to show detail' > Show Detail </a></td>"
        End If
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strProjectName + " for " + m_GridName.PROJECT + " Approvals'>"
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkProjectShow", "chkProjectShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intProjectID"",4) ", True)
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "COMMENT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) + "'  src='../../Images/Home/Details.gif' expand='true' onclick='javascript:DisplayComment(4,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) + ")'>  <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
        End If
    End Sub

    Private Sub m_objProjectTimeSheetGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objProjectTimeSheetGrid.ColumnHeaderTR_BeforePrint
        Args.clsColumnHeader = "clsTheadBlankNEW"
    End Sub
    Private Sub m_objProjectTimeSheetGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objProjectTimeSheetGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objProjectTimeSheetGrid_DataRowTD_BeforePrint()
        ' Purpose               : To modify the Grid For Project TimeSheet Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strUniqueID As String
        Dim strTxtName As String
        Dim intTimeSheetNo As Integer
        Dim blnIsChecked As Boolean = False
        Dim strProjectName As String
        Dim strPKToken As String = ""
        intTimeSheetNo = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), Integer)
        strProjectName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String)
        strProjectName = strProjectName.Replace("'", "").Trim()
        strUniqueID = CType(intTimeSheetNo, String)
        If Args.ColumnName.ToUpper = "SHOW DETAIL" Then
            Cancel = True
            strPKToken = CommonFunctions.Security.Token.GetToken(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0").ToString + Session("intUserID").ToString + "0" + "42")
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><a href='javascript:javascript:ShowDetail(5,""" + strPKToken + """," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), String) + ")' title='Click to show detail' > Show Detail </a></td>"
        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strProjectName + " for " + m_GridName.PROJECT_TIMESHEET + " Approvals'>"
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkProjectTimeSheetShow", "chkProjectTimeSheetShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intTimeSheetNo"",5) ", True)
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "COMMENT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), String) + "'  src='../../Images/Home/Details.gif' expand='true' onclick='javascript:DisplayComment(5,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), String) + ")'>  <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
        End If
    End Sub

    Private Sub m_objResourceTimeSheetGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objResourceTimeSheetGrid.ColumnHeaderTR_BeforePrint
        Args.clsColumnHeader = "clsTheadBlankNEW"
    End Sub
    Private Sub m_objResourceTimeSheetGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objResourceTimeSheetGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objResourceTimeSheetGrid_DataRowTD_BeforePrint()
        ' Purpose               : To modify the Grid For Resource TimeSheet Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strUniqueID As String
        Dim strTxtName As String
        Dim intTimesheetID As Integer
        Dim blnIsChecked As Boolean = False
        Dim strEmployeeName As String
        Dim strPKToken As String = ""
        intTimesheetID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), Integer)
        strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String)
        strEmployeeName = strEmployeeName.Replace("'", "").Trim()
        strUniqueID = CType(intTimesheetID, String)
        If Args.ColumnName.ToUpper = "SHOW DETAIL" Then
            Cancel = True
            strPKToken = CommonFunctions.Security.Token.GetToken(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0").ToString + Session("intUserID").ToString + "0" + "2125")
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><a href='javascript:javascript:ShowDetail(6,""" + strPKToken + """," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), String) + ")' title='Click to show detail' > Show Detail </a></td>"
        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strEmployeeName + " for " + m_GridName.RESOURCE_TIMESHEET + " Approvals'>"
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkResourceTimeSheetShow", "chkResourceTimeSheetShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intTimesheetID"",6) ", True)
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "COMMENT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), String) + "'  src='../../Images/Home/Details.gif' expand='true' onclick='javascript:DisplayComment(6,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), String) + ")'>  <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
        End If
    End Sub
    'Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
    '    '=====================================================================
    '    ' Procedure Name        : m_objMenu_Before_Link_Print()
    '    ' Purpose               : To Approve the Leave,IR,Expense,Project,Project TimeSheet and Resourse TimeSheet
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 8:12 PM 9/19/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    If Not HttpContext.Current.Request.QueryString("MODE") Is Nothing Then
    '        If HttpContext.Current.Request.QueryString("MODE").ToUpper = "APPROVED" Then
    '            If Args.FunctionName.ToUpper = "APPROVE_ONCLICK()" Then
    '                Dim UniqueID As String
    '                Dim m_strUniqueIDs As String = ""
    '                Dim strGetUniqueID As String
    '                Dim strComment As String
    '                Dim intTotalNoOfGrid As Integer = GridIndex.TOTAL_GRID
    '                Dim intCount As Integer = 1
    '                While intTotalNoOfGrid >= intCount

    '                    Select Case intCount
    '                        Case GridIndex.LEAVE
    '                            m_strUniqueIDs = Request.Form("chkLeaveShow")
    '                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.LEAVE)
    '                        Case GridIndex.IR
    '                            m_strUniqueIDs = Request.Form("chkIRShow")
    '                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.IR)
    '                        Case GridIndex.EXPENSE
    '                            m_strUniqueIDs = Request.Form("chkExpenseShow")
    '                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.EXPENSE)
    '                        Case GridIndex.PROJECT
    '                            m_strUniqueIDs = Request.Form("chkProjectShow")
    '                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.PROJECT)
    '                        Case GridIndex.PROJECT_TIMESHEET
    '                            m_strUniqueIDs = Request.Form("chkProjectTimeSheetShow")
    '                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.PROJECT_TIMESHEET)
    '                        Case GridIndex.RESOURCE_TIMESHEET
    '                            m_strUniqueIDs = Request.Form("chkResourceTimeSheetShow")
    '                            AprrovedSelectedRow(m_strUniqueIDs, GridIndex.RESOURCE_TIMESHEET)
    '                    End Select
    '                    intCount += 1
    '                End While
    '            End If
    '        End If
    '    End If
    'End Sub

    Private Function GenerateMenu() As String
        Dim sbHTML As New System.Text.StringBuilder
        Dim ArrTopMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrTopMenuFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrTopMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        Dim strMenu As String = ""
        ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/approve.gif'> Approve")
        ArrTopMenuToolTipsList.Add("Approve")
        ArrTopMenuFunctionsList.Add("Approve_OnClick()")

        ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/back.gif'> Reject")
        ArrTopMenuToolTipsList.Add("Reject")
        ArrTopMenuFunctionsList.Add("Reject_OnClick()")
        'End If
        ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/selectall.gif'> Select All")
        ArrTopMenuToolTipsList.Add("Select All")
        ArrTopMenuFunctionsList.Add("SelectAll_OnClick()")

        ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/clearall.gif'> Clear All")
        ArrTopMenuToolTipsList.Add("Claer All")
        ArrTopMenuFunctionsList.Add("ClearAllOnClick()")

        ArrTopMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images_BW/help.gif'>Help")
        ArrTopMenuToolTipsList.Add("Help")

        If m_strContentTab.ToUpper = m_GridName.LEAVE.ToUpper Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('LeaveHelp')")
        End If
        If m_strContentTab.ToUpper = m_GridName.RESOURCE_TIMESHEET.ToUpper Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('ResourceTimesheetHelp')")
        End If
        If m_strContentTab.ToUpper = m_GridName.EXPENSE.ToUpper Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('ExpenseHelp')")
        End If
        If m_strContentTab.ToUpper = m_GridName.IR.ToUpper Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('IRHelp')")
        End If
        If m_strContentTab.ToUpper = m_GridName.PROJECT.ToUpper Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('ProjectHelp')")
        End If
        If m_strContentTab.ToUpper = m_GridName.PROJECT_TIMESHEET.ToUpper Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('ProjectTimesheetHelp')")
        End If

        Dim ArrClientSideFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        Dim ArrMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        Dim ArrMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        strMenu = strMenu.Replace("class=clsTRMenu", "class=clsTRBlankNew")
        strMenu = strMenu.Replace("class=Menu", "")
        m_objMenu = Nothing
        Return strMenu



    End Function

#End Region


    Private Sub m_objLeavesGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objLeavesGrid.DataRowTR_BeforePrint
        Args.clsTR = "clsTRBlank"
    End Sub

    Private Sub m_objIRGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objIRGrid.DataRowTR_BeforePrint
        Args.clsTR = "clsTRBlank"
    End Sub

    Private Sub m_objExpenseGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objExpenseGrid.DataRowTR_BeforePrint
        Args.clsTR = "clsTRBlank"
        strExpenseSheetIDList += Args.DataReader("ExpensesheetID").ToString + ","
        strTokenIDList += CType(Args.DataReader("ExpenseSheetID"), String).Trim + "+" + CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpenseSheetID"), String) + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "3595").Trim + "#"

    End Sub

    Private Sub m_objProjectGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objProjectGrid.DataRowTR_BeforePrint
        Args.clsTR = "clsTRBlank"
    End Sub

    Private Sub m_objProjectTimeSheetGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objProjectTimeSheetGrid.DataRowTR_BeforePrint
        Args.clsTR = "clsTRBlank"
    End Sub

    Private Sub m_objResourceTimeSheetGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objResourceTimeSheetGrid.DataRowTR_BeforePrint

        Args.clsTR = "clsTRBlank"
        m_strPKToken = CommonFunctions.Security.Token.GetToken(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0").ToString + Session("intUserID").ToString + "0" + "2125")
        m_strTSIDs += Args.DataReader("TimesheetID").ToString + ","
        m_strTSIDsWithToken += Args.DataReader("TimesheetID").ToString + "+" + Args.DataReader("EmployeeID").ToString + "+" + Args.DataReader("StatusCode").ToString + "+" + m_strPKToken + "#"

    End Sub
End Class


