Option Strict Off
#Region "Imports"
Imports CommonFunctions
Imports WebPages.Template
#End Region

Public Class DB_Communication
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : DB_Communication
    ' Purpose               : Creates the Project Manager's communication Dashboard similar to outlook
    ' Description           : Same as above
    ' Parameters Passed     : 
    ' Returns               : 
    ' Parameters Affected   : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : MrugajaB
    ' Created               : Dec 12th ,2005
    ' Revisions             : 
    '=====================================================================

    Private m_blnUseSQL As Boolean
    Private m_objGlobal As IGlobal
    ''-- Use the Grid class to plot the grid

    Private WithEvents m_objEmailGrid As New WebPage.Templates.AdvancedGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 

    Protected m_intProjectID As Integer
    Protected m_strMode As String
    Private strSQLQuery As String
    Private m_intLogID As Integer
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""
    Public m_CheckboxIDs As String = ""
    Private strMenu As String

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

        'm_strDB_PageName = "../DB/PMDashboard_OutlookView"
        If Session("intProjectID") Is Nothing Then
            m_intProjectID = 0
        Else
            m_intProjectID = CType(Session("intProjectID"), Integer)
        End If

        m_strMode = Request.QueryString("Mode")
        m_intLogID = Request.QueryString("LogID")

        'Sort Fields
        'If Not Page.IsPostBack Then
        m_strSortBy = CommonFunctions.General.CheckIsNothing(Request.QueryString("SortByField"), "")
        m_strSortOrder = CommonFunctions.General.CheckIsNothing(Request.QueryString("ASCorDESC"), "")
        'Else
        '    m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
        '    m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        'End If
        'End Of addition

        If m_strSortBy = "" Then m_strSortBy = "FromEmp"
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"

        m_strSortOrder = CommonFunctions.General.UnBuildQueryString(m_strSortOrder)

        ' Call to Init. Page settings and module-level variables
        Call Initialize()

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page
        ' Description           : Also gets the various User Preferences from the Database
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Jan 5th, 2004
        ' Revisions             : 
        '=====================================================================
        Dim strTaskIDs As String
        '-- Procedure to Initialize all the page level settings/variables
        '-- Also retries the various User settings saved in User Preferences

        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)


    End Sub

    Public Sub DrawPage()
        '=====================================================================
        ' Page Name             : DrawPage
        ' Purpose               : The Main functions which draw the Page are called here 
        ' Description           : this fn. is called from within the Form Tag
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 5th, 2003
        ' Revisions             : 
        '=====================================================================
        '--1. Write the Combo for e-Dashboard selections
        'CommonFunctions.General.WriteHTML("<TABLE Class=clsTable Width=100%>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
        'CommonFunctions.General.WriteHTML("<TD>")
        Dim strTaskIDs As String

        'Palce Hidden Controls
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, , , , , , , , EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, , , , , , , , EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

        'Added by SandeepA on 22 Dec,2005 for adding Header
        CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class='clsTRPageCaption'><TD align='Left'><B>" & MyBase.GetResourceString("WHIZIBLE_EMAILS") & "</B></TD></TR></TABLE><BR>")
        'End of Addition By SandeepA on 22 Dec,2005 for adding header

        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")


        If m_strMode = "DisplayList" Then
            '--- Display Grid with tasks for updation

            DisplayGrid()

        ElseIf m_strMode = "DisplayMail" Then
            DisplayMail()
        ElseIf m_strMode = "DeleteMail" Then
            Dim arrChkDelete() As String
            Dim strDailyActivityIDsToDelete As String
            Dim strSQL As String

            'Construct the query to delete the selected records from tbl_PM_DailyActivity table.
            If CType(MyBase.GetFormValue("chkDelete"), String) <> "" Then
                arrChkDelete = Split(CType(FixString(MyBase.GetFormValue("chkDelete"), 0, False, True), String), ",")
                For Each strDailyActivityIDsToDelete In arrChkDelete
                    strSQL = "usp_del_tbl_CDB_Communication " & strDailyActivityIDsToDelete
                    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                Next
            End If
            DisplayGrid()
        End If
        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")

        ' Added by PurvaJ on 5 May 2006
        Dim objHeaderFooter = New WebPages.Template.HeaderFooter

        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<BR>")
        'End Addition PurvaJ
        CommonFunctions.General.WriteHTML(strMenu)
        'CommonFunctions.General.WriteHTML("<BR>")
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String

        If m_strMode <> "DisplayMail" Then

            'Added by PurvaJ on 5 May 2006
            m_CheckboxIDs = ""
            arrMenuList.Add("Select All") 'MyBase.GetResourceString("MENU_SELECT_ALL"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"))
            arrClientSideFunctionList.Add("SelectAll_OnClick()")

            arrMenuList.Add("Clear All") 'MyBase.GetResourceString("MENU_CLEAR_ALL"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP"))
            arrClientSideFunctionList.Add("ClearAll_OnClick()")
            'End Addition  PurvaJ

            arrMenuList.Add(MyBase.GetResourceString("MENU_DELETE"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP"))
            arrClientSideFunctionList.Add("Delete_OnClick()")

            'Commented By SandeepA on 22 Dec,2005 for Hiding Help
            arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
            'intigrated by harshk for sp4 issueid 219
            arrClientSideFunctionList.Add("Help_OnClick('PM Dashboard Outlook View - Whizible Emails')")
            ''End intigrated by harshk for sp4 issueid 219
            'End of Comment by SandeepA on 22 Dec,2005

            
            'Create the static menu.
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)
        End If

    End Sub

    Private Sub DisplayGrid()
        '=====================================================================
        ' Page Name             : PrepareSections
        ' Purpose               : Calls to the 4 Grids in the Top Section for the 4 grids
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 1, 2003
        ' Revisions             : 
        '=====================================================================
        '-- Draws the TO DO LIST


        '-- define the Actual Array and UserFriendly array..

        Dim strGRID As String

        'Response.Write("<TABLE ID='tblMilestones' cellspacing=1 border=0 width=100% Style='VISIBILITY:hidden;DISPLAY:none' >")
        'Response.Write("<TR class=clsTREven ><TD align=center>")

        Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;Height=415px'>") 'height changed from 360 to 415
       
        '--Form the SQL Query for Grid
        strSQLQuery = "EXEC usp_sel_tbl_CDB_Communication " & Session("intUserID").ToString & ",NULL,'" & m_strSortBy & "','" & m_strSortOrder & "'"

        Dim arrActualColumns() As String = {"FromEmp", "Subject", "EmailDate", ""}
        Dim arrUserFriendlyColumn() As String = {"From", "Subject", "Received", "Delete"}
        Dim arrTDStyle() As String = {"", "", "align=Left width='20%'", ""}
        Dim arrCheckBox() As String = {"", "", "", "chkDelete"}
        'Set the Advanced Grid Properties
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objEmailGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            '   .RowLinkArray = arrRowLink
            .EmptyValueReplacement = "&nbsp;"
            .UseSQL = MyBase.UseSQL
            .SQL = strSQLQuery
            .DIVID = "divList"
            .DIVHeight = 410 'divheight changed from 350 to 410
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 3

            '   .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .SortOrder = m_strSortOrder
            .SortBy = m_strSortBy
            .ClientSideSortFunctionName = "Sort_OnClick"
            .CheckBoxIDArray = arrCheckBox
            .PrimaryKey = "LogID"
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        m_objEmailGrid = Nothing
        '  End If
        HttpContext.Current.Response.Write("</DIV>")
    End Sub

    Private Sub DisplayMail()
        Dim drMailDetails As IDataReader
        Dim strFromEmailID As String
        Dim strToEmailIDs As String
        Dim strCCEmailIDs As String
        Dim strSubject As String
        Dim strMessage As String

        strSQLQuery = "Exec usp_sel_tbl_CDB_Communication " & Session("intUserID") & "," & m_intLogID

        drMailDetails = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drMailDetails.Read Then
            strFromEmailID = CType(drMailDetails.Item("FromEmailID"), String)
            strToEmailIDs = CType(drMailDetails.Item("ToEmailIDs"), String)
            strCCEmailIDs = CType(drMailDetails.Item("CCEmailIDs"), String)
            strSubject = CType(drMailDetails.Item("Subject"), String)
            strMessage = CType(drMailDetails.Item("Message"), String)
        End If

        CommonFunction.Data.DisposeDataReader(drMailDetails)

        Dim strSQL As String
        Dim blnShowFrom As Boolean

        'plot the controls
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<TABLE class=clsTable cellspacing=0 width='99.9%' style='WIDTH: 100%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        'Integrated By SandeepA on 21 Dec,2005 for PMDashboard Outlook View.
        General.WriteHTML("<TR class='clsTRSectionHeader' >")
        General.WriteHTML("<TD align='right' COLSPAN='2'> | <A class='Menu' style='' HREF='Javascript:CloseOnClick()' Title='Close window' >Close</A> | </TD>")
        General.WriteHTML("</TR>")
        'End of Integration by SandeepA.


        'display CC mail id textbox
        'blnShowFrom = True
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_FROM") + "&nbsp;</TD>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtFromEmailID", "txtFromEmailID", , 450, , strFromEmailID + "".Trim, , , , Not blnShowFrom, , , , True, True, , , , , EnableHTMLEncode:=True) + "</TD>")
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("</TR>")

        'display the TO mail id textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_TO") + "&nbsp;</TD>")
        'If m_lngMessageID <> 23 Then
        'General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , strToEmailIDs + "".Trim, , , , , , , , True, True) + "</TD>")
        'Else
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , strToEmailIDs + "".Trim, , , , True, , , , True, True, , , , , EnableHTMLEncode:=True) + "</TD>")
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'End If
        General.WriteHTML("</TR>")

        'display CC mail id textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_CC") + "&nbsp;</TD>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtCCToEmailID", "txtCCToEmailID", , 450, , strCCEmailIDs + "".Trim, , , , , , , , True, , , , , , EnableHTMLEncode:=True) + "</TD>")
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("</TR>")

        'display the subject
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_SUBJECT") + "&nbsp;</TD>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtSubject", "txtSubject", , 450, , strSubject + "".Trim, , , , , , , , True, True, , , , , EnableHTMLEncode:=True) + "</TD>")
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("</TR>")

        'display the message
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("CAP_MESSAGE") + "&nbsp;</TD>")

        'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", , , , "frmDB_Communication", , , 450, 280, , strMessage + "".Trim, , , , , , , , True, True) + "</TD>")
        General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", , , , "frmDB_Communication", , , 450, 280, , strMessage + "".Trim, , , , , , , , True, True, EnableHTMLEncode:=True) + "</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
    End Sub


    Private Sub m_objEmailGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objEmailGrid.DataRowTD_BeforePrint
        Dim strName As String
        Select Case Args.ColumnName
            Case "From"
                If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsRead"), 0), Integer) = 0 Then
                    Args.StringToBeInserted = "<TD align='left' width=30%><B>" & Args.DataReader("FromEmp") & "</B></TD>"
                Else
                    Args.StringToBeInserted = "<TD align='left' width=30%>" & Args.DataReader("FromEmp") & "</TD>"
                End If
                Cancel = True

            Case "Subject"
                If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsRead"), 0), Integer) = 0 Then
                    Args.StringToBeInserted = "<TD align='left' width=50%><A href='JavaScript:Display_Mail(" + CStr(Args.DataReader("LogID")) + " )'><B>" & Args.DataReader("Subject") & "</B></A></TD>"
                Else
                    Args.StringToBeInserted = "<TD align='left' width=50%><A href='JavaScript:Display_Mail(" + CStr(Args.DataReader("LogID")) + " )'>" & Args.DataReader("Subject") & "</A></TD>"
                End If
                Cancel = True
        End Select
    End Sub

    Public Sub New()
        'MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.DB_Communication", "AppResources")
    End Sub

#Region "General Functions/Procedures"
    Private Sub DeleteMails(ByVal strTaskIDs As String)

        Dim strSQLQuery As String
        'Here the tasks in the table tbl_PM_ProjectTasks will get udpated
        'i.e Set the IsActiveFlag = 1
        If strTaskIDs <> "" Then
            'Modified By VidyaJ - Performance Issue - Tasks - 86
            'Added ProjectID parameter
            strSQLQuery = "EXEC usp_del_tbl_CDB_Communication '" & Left(strTaskIDs, strTaskIDs.Length - 1)

            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
        End If

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
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
#End Region

End Class
