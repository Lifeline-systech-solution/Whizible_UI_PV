'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  DB_AddToReportsFavorites.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class DB_AddToReportsFavorites
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

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Private strMenu As String                           'stores the static menu string.
    Protected m_lngTagId As Long = 0
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objMyProjects_Grid As WebPage.Templates.AdvancedGrid

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
        Dim strReportID As String
        Dim strArrReportID() As String
        Dim lenArray As Integer
        'Call GetGlobalObject()

        If Request.QueryString("Operation") = "AddToFavorites" Then
            strReportID = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("ReportID", True), "")
            If strReportID <> "" Then
                strArrReportID = strReportID.Split(CType(",", Char))
                'Now Insert Into Table
                For lenArray = 1 To strArrReportID.Length
                    If IsNumeric(CType(strArrReportID(lenArray - 1), String)) Then
                        CommonFunctions.Data.InsertOrUpdateData("INSERT INTO tbl_PM_ReportsFavorites(ReportID,EmployeeID) VALUES (" + CType(strArrReportID(lenArray - 1), String) + "," + CType(Session("intUserID"), String) + ")", True)
                    Else
                        CommonFunctions.Data.InsertOrUpdateData("INSERT INTO tbl_PM_ReportsFavorites(ReportID,EmployeeID,url) VALUES (0," + CType(Session("intUserID"), String) + ",'" + CType(strArrReportID(lenArray - 1), String) + "')", True)
                    End If
                Next

            End If
        End If

        CommonFunctions.General.WriteHTML("<table class='clsTable' height='400' cellSpacing='0' cellPadding='0' width='100%' align='center' border='0'><tbody><tr><td vAlign='top' height='320'>")
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()
        '--- Display Grid with tasks 
        '--- <DIV> tag used for Scroll Bar
        CommonFunctions.General.WriteHTML("<DIV id='divList' style=""overflow:auto;height:400;WIDTH:100%"">")
        DisplayGrid()
        CommonFunctions.General.WriteHTML("</DIV>")
        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        '--- Plot the Row Count
        'CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'><TR class=clsTREven><TD width='100%' align='right'>Total Records :" & m_intRowCount & "</TD></TR></TABLE><BR>")
        'CommonFunctions.General.WriteHTML(strMenu)
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        DisposeObjects()
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
        ' Author                : SandeepA
        ' Created               : 13 Dec,2005
        ' Revisions             :
        '=====================================================================
        Try
            Dim arrMenuList As New ArrayList
            Dim arrMenuToolTipList As New ArrayList
            Dim arrClientSideFunctionList As New ArrayList
            Dim strGrid As String

            arrMenuList.Add(MyBase.GetResourceString("ADD_TO_FAVORITES"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("ADD_TO_FAVORITES_TOOLTIP"))
            arrClientSideFunctionList.Add("AddToFavorite_OnClick()")

            'Added by SavitaS on 12 Sept 2006 for SP7 IssueID 5639
            arrMenuList.Add("Select All")
            arrMenuToolTipList.Add("Select All")
            arrClientSideFunctionList.Add("SelectAll_OnClick()")

            arrMenuList.Add("Clear All")
            arrMenuToolTipList.Add("Clear All")
            arrClientSideFunctionList.Add("ClearAll_OnClick()")
            'End of Added by SavitaS on 12 Sept 2006 for SP7 IssueID 5639


            arrMenuList.Add(MyBase.GetResourceString("CLOSE"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("CLOSE_TOOLTIP"))
            arrClientSideFunctionList.Add("Close_OnClick()")

            'Get the Menu from Resource File
            arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
            arrClientSideFunctionList.Add("Help_OnClick('PM Dashboard Outlook View - Add To Favorite')")

            'Create the static menu.
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)
        Catch ex As Exception
            'Exception Handler
        End Try
    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SandeepA
        ' Created               : 13 Dec,2005
        ' Revisions             :
        '=====================================================================
        '--- Plot the Caption
        Try
            CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='100%'><TR class='clsTRPageCaption'><TD align='Left'><B> Add To Reports Favorites </B></TD></TR></TABLE>")
            Response.Write("<BR>")
        Catch ex As Exception
            'Exception Handler
        End Try

    End Sub
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
        ' Author                : SandeepA
        ' Created               : 13 Dec,2005
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Private Sub DisplayGrid()
        '====================================================================
        ' Procedure Name        :   DisplayGrid
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw grid
        ' Description           :   This procedure is used to draw grid on the page.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   13 Dec,2005
        ' Revisions             :   
        '=====================================================================
        Try
            '-- My Projects Grid
            Dim strSQLQuery, strGRID As String
            Dim drGrid As IDataReader

            Dim arrActualCols() As String = {"ReportTitle", "ReportID"}
            Dim arrstrUserFriendlyList() As String = {"Report Name", "Select"}
            Dim arrLink() As String = {"", ""}
            'end of integration by harshada d on 19 dec 2005  for issue id 989 
            Dim arrChkBox() As String = {"", "ReportID"}
            'End Comment PurvaJ
            Dim arrstrTDStyle() As String = {"style='width=90%'", "style='text-align=center'"}
            '-- End Modification by PurvaJ

            '-- SQL Query for the 'My Projects' grid
            'Added by TruptiK on 18-Dec-2007
            'Purpose:-BFT RequestID 10455
            If CType(Session("intProjectID"), String) = "" Then
                strSQLQuery = " EXEC usp_sel_ReportsList  " + Session("intUserID").ToString + "," + Session("intPostID").ToString + "," + "1"
            Else

                'Modified by TruptiK on 25-Oct-2007
                'Purpose:-To take projectlevel role also FOR RequestID 9633.
                'strSQLQuery = " EXEC usp_sel_ReportsList  " + Session("intUserID").ToString 
                strSQLQuery = " EXEC usp_sel_ReportsList  " + Session("intUserID").ToString + "," + Session("intPostID").ToString
                'End of modification by TruptiK on 25-Oct-2007
            End If
            '--- Get count of rows affected
            'drGrid = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            'm_intRowCount = 0
            'While drGrid.Read()
            'm_intRowCount += 1
            'End While
            'CommonFunctions.Data.DisposeDataReader(drGrid)
            Dim arrIgnoreHTMLEncode() As String = {"0"}
            '--- Set Grid Object properties
            m_objMyProjects_Grid = New WebPage.Templates.AdvancedGrid
            With m_objMyProjects_Grid
                .NoOfDataColumns = 1
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                .ActualColumnArray = arrActualCols
                .RowLinkArray = arrLink
                .CheckBoxIDArray = arrChkBox
                .TDStyleArray = arrstrTDStyle
                .PrimaryKey = "ReportID"
                .returnHTML = False
                .SQL = strSQLQuery
                .UseSQL = True
                .PageSize = 20
                .DIVID = "divGrid"
                .DIVStyle = "overflow:auto;width:100%;"
                .DIVHeight = 480
                .ColNameToolTipOnEachRow = True
                'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .DrawGrid()
            End With
            'm_objMyProjects_Grid = Nothing

            '--- Plot Grid
            'Response.Write(strGRID)
            '--- Clear Grid Object
            m_objMyProjects_Grid = Nothing

        Catch ex As Exception
            'Exception Handler
            Response.Write(ex.Source & "  " & ex.Message)
        End Try
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
        ' Author                : SandeepA
        ' Created               : 13 Dec,2005
        ' Revisions             :
        '=====================================================================
        Try
            Dim arrElements(arrList.Count - 1) As String
            arrList.ToArray.CopyTo(arrElements, 0)
            Return arrElements
        Catch ex As Exception
            'Exception Handler
        End Try
    End Function
#End Region

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.DB_AddToReportsFavorites", "AppResources")
    End Sub

    Private Sub m_objMyProjects_Grid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMyProjects_Grid.DataRowTD_BeforePrint
        If Args.ColumnName = "Select" Then
            'if not custom Report
            If CType(Args.DataFieldValue, String) <> "0" Then
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("ReportID", "ReportID", , , CType(Args.DataFieldValue, String), , , True) + "</TD>"
            Else
                'if Custom Report
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("ReportID", "ReportID", , , CType(Args.DataReader("url"), String), , , True) + "</TD>"
            End If

            Cancel = True
        End If
    End Sub
End Class
