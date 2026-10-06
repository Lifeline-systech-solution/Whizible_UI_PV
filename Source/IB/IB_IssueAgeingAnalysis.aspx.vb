'******************************************************************
'           CSPL Code Header
' Project Name     :    Whizible Enterprise
' Module Name      :    Issue Ageing Analysis
' Purpose          :    Displays the list of Issues assigned for given number of days
' Description      :    <Description>
' Assumptions      :    <Assumptions>
' Dependencies     :    <Dependencies>
' Author           :    JayavantK
' Reviewed         :    
' Tested           :    
' Created          :    April 16, 2004
' Revisions        :    
'******************************************************************

Public Class IB_IssueAgeingAnalysis
    Inherits WebPages.Template.WhizTemplate

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

#Region " Constants Used in the Class "
    Private Enum MenuIndex
        CLOSE
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 2
#End Region

#Region " Class scope Variables Declarations "
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Menu
    Private m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Protected m_lngProjectId As Long = 0
    Private m_intDaysDiff As Integer = 0
    'Added By JyotiG
    'Start
    'Date : 28-Sep-2006
    'Issue ID : 6489
    Protected m_strToken As String
    'End
#End Region

    Public Sub PageInit()
        Dim strMenu As String = ""

        'Initialize the Menu related arrays
        InitPageMenu()

        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("ProjectID"), "0"), Long)
        m_intDaysDiff = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("DaysDiff"), "0"), Integer)

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        ' Display the List of Issues
        DisplayListof_Issues()

        'Display the Menu at Bottom
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_IssueAgeingAnalysis", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "IB_IssueAgeingAnalysis : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub InitPageMenu()
        '====================================================================
        ' Procedure Name        : InitPageMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Builds the arrays required to display the Menu.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 16, 2004
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('AGEING_LIST')"

        MyBase.InitializeResources("AppResources.IB_IssueAgeingAnalysis", "AppResources")
    End Sub

    Private Sub DisplayListof_Issues()
        '====================================================================
        ' Procedure Name        : DisplayListof_Issues
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedures assigns values to the Grid object, which display the list of 
        '                         Issues.  
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 16, 2004
        ' Revisions             :
        '=====================================================================

        Dim strQuery As String = ""
        Dim intColumnsToShow As Integer = 8
        Dim arrActualColumns() As String = {"IssueID", "Description", "ReportedDate", "Assigned On", "Type", _
                                            "Status", "SubType", "Priority"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("ISSUE_ID"), MyBase.GetResourceString("SUMMARY"), _
                                                 MyBase.GetResourceString("REPORTED_DATE"), MyBase.GetResourceString("ASSIGNED_DATE"), _
                                                 MyBase.GetResourceString("TYPE"), MyBase.GetResourceString("STATUS"), _
                                                 MyBase.GetResourceString("SUBTYPE"), MyBase.GetResourceString("PRIORITY")}
        Dim arrRowLink() As String = {"Issue_OnClick(IssueID)"}
        Dim arrstrTDStyle() As String = {"align='left'", "align='left'", "align='left' nowrap", "align='left' nowrap", _
                                         "align='left'", "align='left'", "align='left'", "align='left'"}
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Build the Query for the grid
        strQuery = "Exec usp_DB_BTSAginganalysis " & m_lngProjectId.ToString()
        strQuery &= ", " & Session.Item("intUserID").ToString()
        strQuery &= ", " & m_intDaysDiff.ToString()

        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .RowLinkArray = arrRowLink
            .PrimaryKey = "IssueID"
            .EmptyValueReplacement = "&nbsp;"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "PageDiv"
            .DIVHeight = 200
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Avoid  number formatting for the Issue ID Column.
        If Args.ColIndex = 0 Then
            Args.ApplyDataTypeBasedFormatting = False
        End If
        Select Case UCase(Trim(Args.DataField & ""))
            Case "ISSUEID"
                m_strToken = (CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueId"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String)))
                If Trim(Args.DataReader("IssueId").ToString & "") = "" Then
                    Args.DataFieldValue = " "
                    'Added By JyotiG
                    'Issue Id : 6489
                    'Start
                Else
                    Args.StringToBeInserted = "<TD vAlign=top title='Issue Id' style='TEXT_DECORATION:None' nowrap;>" _
                    & "<A href=""JavaScript:Issue_OnClick('" & CType(Args.DataReader("IssueId"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">" & Trim(Args.DataReader("IssueId").ToString & "") & "</A></TD>"
                    Cancel = True
                    'End
                End If
        End Select
    End Sub
End Class
