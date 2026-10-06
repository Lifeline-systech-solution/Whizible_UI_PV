'=====================================================================
' Project Name          :  WhizibleSEM SP4
' Module Name           :  DB_MyProjects.aspx (../Source/DB)
' Purpose               :  To display the list of Projects Accessible to an User
' Dependencies          :  Tables and USP's used in this Page.
' Author                :  SandeepA
' Reviewed              :  
' Created               :  13 Dec,2005
'=====================================================================
Option Strict On

'Import References
#Region "Imports"
Imports CommonFunctions
Imports System
Imports System.Data
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class DB_MyProjects
    Inherits WebPages.Template.WhizTemplate
    ' SearchKey: JP_31Jul2006
    ' JijeshP Modification START for (PM DashBoard Enhanced View Enhancements)
    Dim blnRiskNodeAccess As Boolean
    Dim blnETCNodeAccess As Boolean
    Dim blnETCRequest As Boolean
    'Added at class level so that this array can be accessed from the events.
    Dim arrstrRowLinkField() As String = {"", "", "", "ShowDB(ProjectID)", "ShowHealthSheet(ProjectID)", "ShowETCApprovals(ProjectID)"}
    ' JijeshP Modificatiob END
    ' Added By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
    Dim m_objETCHashTable As New Hashtable
    Dim m_objAccessHashTable As New Hashtable
    ' End Addition By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
    'Added BY VarunA on 7-July-2008 IssueID-21539
    Dim objReportingFreqDR As IDataReader
    Dim strFrequency As String
    Protected intFrequencyId As Integer
    'End By VarunA on 7-July-2008 IssueID-21539



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

#Region "Member Variables"
    'Global Variables Declared
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private strMenu As String                           'stores the static menu string.
    Private m_intProjectID As Integer                   'Project ID
    Protected m_strWindowTitle As String                'Page Title
    '-- Use the Grid class to plot the 'My Projects' grid
    Private WithEvents m_objMyProjects_Grid As New WebPage.Templates.AdvancedGrid
    Dim m_strSortByField As String = "ProjectName"
    Dim m_strAscOrDesc As String = "ASC"
    Dim m_intRowCount As Integer = 0
#End Region

#Region "Page Load"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            'Put user code to initialize the page here
            'Initialize the Global Objects
            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
            m_objGlobal = MyBase.GlobalObject()
            m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
            m_objAccessRights.GetAccess()
            'Get Window Title
            m_strWindowTitle = MyBase.GetResourceString("HEADING")
        Catch ex As Exception
            'Exception Handler
        End Try
    End Sub
#End Region

#Region "General Functions"
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

#Region "Page Plotting Procedures"
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
        ' Author                :   SandeepA
        ' Created               :   13 Dec,2005
        ' Revisions             :   
        '=====================================================================

        'This will initialize all the global objects.
        Try
            '' START : Commented & Modified By ParagD On 29-Aug-2006 
            '' Purpose : Whiz SP 7.2 Release
            '' Project wise Resource - Project Role should be considered and not Corporate Level role.

            ' SearchKey: JP_31Jul2006
            ' Modification by JijeshP on 31-Jul-2006 to Provide ETC Approval Link      

            ''Dim strsql As String
            ''strsql = "Exec usp_DB_CheckAccessForNode " & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'417'"
            ''blnETCNodeAccess = CBool(CommonFunctions.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))

            '' END : Commented & Modified By ParagD On 29-Aug-2006 

            '--- Get the Global Object
            Call GetGlobalObject()
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168


            'Added By VarunA on 7-July-2008 IssueID-21539
            'Purpose : To have the frequency depending on corporate level.
            objReportingFreqDR = CommonFunction.Data.GetDataReader("usp_SEL_Tbl_PM_companyInformation_ResourceTimeSheetFrequency", MyBase.UseSQL)
            If objReportingFreqDR.Read Then
                strFrequency = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objReportingFreqDR("Frequency"), ""), "")
                intFrequencyId = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objReportingFreqDR("FrequencyID"), "0"), "0"), Integer)
            End If
            CommonFunction.Data.DisposeDataReader(objReportingFreqDR)
            'End By VarunA on 7-July-2008 IssueID-21539



            CommonFunctions.General.WriteHTML("<table class='clsTable' height='850' cellSpacing='0' cellPadding='0' width='99.9%' align='center' border='0'><tbody><tr><td vAlign='top' height='320'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            'This will strore the constructed menu string in a string variable.   
            DrawMenu()
            CommonFunctions.General.WriteHTML(strMenu)
            CommonFunctions.General.WriteHTML("<BR>")
            'Display the page caption.
            DrawPageCaption()
            'Display the Header if exist. 
            DrawHeader()
            '--- Display Grid with tasks 
            '--- <DIV> tag used for Scroll Bar
            CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style=""overflow:auto;height:350;WIDTH:99.99%"">")
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' To Get the etc request existance and access for project in single fetch 
            Call getETCAccess()
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            DisplayGrid()
            CommonFunctions.General.WriteHTML("</DIV>")
            'Display the Menu at the Bottom
            CommonFunctions.General.WriteHTML("<BR>")
            '--- Plot the Row Count
            'CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'><TR class=clsTREven><TD width='100%' align='right'>Total Records :" & m_intRowCount & "</TD></TR></TABLE><BR>")
            'CommonFunctions.General.WriteHTML(strMenu)
            'CommonFunctions.General.WriteHTML("</td></tr></table>")
            DisposeObjects()
        Catch ex As Exception
            'Exception Handler
        End Try

    End Sub
    Private Sub getETCAccess()
        '====================================================================
        ' Procedure Name        :  getETCAccess
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get the access and etc existance details for the accesible project 
        ' Description           :  This sub-routine fills the m_objETCHashTable ,m_objAccessHashTable 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS
        ' Created               :  29 May 2007 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String = " usp_SEL_MYProjectsETCandNodeAccess " + Session("intUserID").ToString + IIf(CommonFunction.Application.ShowEvenReleaseFromProject, ",1", ",0").ToString()
        Dim objDR As IDataReader
        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        While objDR.Read

            m_objAccessHashTable.Add(objDR("ProjectID").ToString(), CType(objDR("ETCAccessible"), Boolean))
            m_objETCHashTable.Add(objDR("ProjectID").ToString(), CType(objDR("EtcExists"), Boolean))

        End While

        CommonFunction.Data.DisposeDataReader(objDR)


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
        ' Author                :  SandeepA
        ' Created               :  13 Dec,2005
        ' Revisions             :  
        '=====================================================================
        Try
            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
            m_objGlobal = MyBase.GlobalObject()
            m_objAccessRights = New cAccessRights(m_objGlobal)
            m_objAccessRights.GetAccess()
            m_lngTagId = m_objGlobal.TagID
        Catch ex As Exception
            'Exception Handler
        End Try
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

            'Get the Menu from Resource File
            arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
            arrClientSideFunctionList.Add("Help_OnClick('PM Dashboard Outlook View - My Projects')")

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
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.9%'><TR class='clsTRPageCaption'><TD align='Left'><B>" & MyBase.GetResourceString("LEFT_CAPTION") & "</B></TD></TR></TABLE>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            'CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='100%'><TR class='clsTRPageCaption'><TD align='Left'><B>" & MyBase.GetResourceString("LEFT_CAPTION") & "</B></TD><TD align='Right'>|<a class='Menu' style='TEXT-DECORATION:None' Href='javascript:OpenHelpPage(3104)'><Font Size=1 face=Arial;verdana color=black><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP") + "</font></b></a>|</TD></TR></TABLE>")
            Response.Write("<BR>")
        Catch ex As Exception
            'Exception Handler
        End Try

    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SandeepA
        ' Created               : 13 Dec,2005
        ' Revisions             :
        '=====================================================================
        Try
            Dim objHeader As HeaderFooter
            Dim strReturn As String
            'Initialize HeaderFooter Object
            objHeader = New HeaderFooter
            objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
            strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
            If strReturn <> "" Then
                Response.Write(strReturn)
            End If
            objHeader = Nothing
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
            '-- define the Actual Array and UserFriendly array..

            '' START : Modified By ParagD On 29-Aug-2006
            '' Purpose : Whiz SP 7.2 release. Changed ETC Approval To ETC Authentication.

            ' SearchKey: JP_31Jul2006
            ' Modification by JijeshP on 31-Jul-2006 to Provide ETC Approval Link             
            Dim arrstrActualList() As String = {"ProjectName", "ExpectedStartDate", "ExpectedEndDate", "", "", "ETC Authentication"}
            Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("PROJECT_NAME"), MyBase.GetResourceString("START_DATE"), _
                                         MyBase.GetResourceString("END_DATE"), MyBase.GetResourceString("DB"), MyBase.GetResourceString("PRJ_HEALTH_SHEET"), "ETC Authentication"}
            '' END : Modified By ParagD On 29-Aug-2006

            Dim arrstrRowLinkField() As String = {"", "", "", "ShowDB(ProjectID)", "ShowHealthSheet(ProjectID)"}

            'Dim arrstrTDStyle() As String = {"", "style='width=10%'", "style='width=10%'", "style='text-align=center'", "style='text-align=center'"}
            Dim arrstrTDStyle() As String = {"", "style='width=10%'", "style='width=10%'", "style='text-align=center'", "style='text-align=center'", "style='text-align=center'"}

            '--- Get the SortBy and SortOrder fields
            m_strSortByField = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("SortBy"), "ProjectName"))
            m_strAscOrDesc = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("SortOrder"), "ASC"))

            '-- SQL Query for the 'My Projects' grid
            'strSQLQuery = " EXEC usp_Sel_ProjectStatus_ForEmployee  " + Session("intUserID").ToString
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Replaced the usp_Sel_ProjectStatus_ForEmployee with usp_SEL_MyProjects

            'strSQLQuery = " EXEC usp_Sel_ProjectStatus_ForEmployee  " + Session("intUserID").ToString
            'strSQLQuery = strSQLQuery & ",'ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strSQLQuery = " usp_SEL_MyProjects " + Session("intUserID").ToString + ",'ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'," + IIf(CommonFunction.Application.ShowEvenReleaseFromProject, "1", "0").ToString()
            ' E nd Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            '--- Get count of rows affected
            'drGrid = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            'm_intRowCount = 0
            'While drGrid.Read()
            'm_intRowCount += 1
            'End While
            'CommonFunctions.Data.DisposeDataReader(drGrid)
            Dim arrIgnoreHTMLEncode() As String = {"0"}
            '--- Set Grid Object properties
            With m_objMyProjects_Grid
                '--Columns in the Grid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
                .RowLinkArray = arrstrRowLinkField
                .TDStyleArray = arrstrTDStyle
                .SQL = strSQLQuery
                .EmptyValueReplacement = ""
                .ColNameToolTipOnEachRow = True
                '-- Properties for Sorting
                .ClientSideSortFunctionName = "Sort_OnClick"
                .SortBy = m_strSortByField
                .SortOrder = m_strAscOrDesc
                .DIVHeight = 0
                .returnHTML = True
                .UseSQL = MyBase.UseSQL
                '--Sorting in Grid
                .SortBy = m_strSortByField
                .SortOrder = m_strAscOrDesc
                'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                strGRID = .DrawGrid()
            End With
            '--- Plot Grid
            Response.Write(strGRID)
            '--- Clear Grid Object
            m_objMyProjects_Grid = Nothing

        Catch ex As Exception
            'Exception Handler
        End Try
    End Sub
#End Region

#Region "Grid Events"
    Private Sub m_MyProjectsGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMyProjects_Grid.DataRowTD_BeforePrint
        '====================================================================
        ' Procedure Name        :   m_MyProjectsGrid_DataRowTD_BeforePrint
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   Draw the column text Before TD Print
        ' Description           :   same as above.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   13 Dec,2005
        ' Revisions             :   
        '=====================================================================
        Try
            'Args.TDStyle = Args.TDStyle + "ForDB"

            If Args.ColIndex = 3 Then
                Args.StringToBeInserted = "<TD Align=center><A Href='javascript:ShowDB(" + Args.DataReader("ProjectID").ToString + ")'>" + MyBase.GetResourceString("DB") + "</A></TD>"
                Cancel = True
            End If
            If Args.ColIndex = 4 Then
                Args.StringToBeInserted = "<TD Align=center><A Href='javascript:ShowHealthSheet(" + Args.DataReader("ProjectID").ToString + ")'>" + MyBase.GetResourceString("PRJ_HEALTH_SHEET") + "</A></TD>"
                Cancel = True
            End If
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            ' SearchKey: JP_31Jul2006
            ' Modification by JijeshP on 31-Jul-2006 to Provide ETC Approval Link 
            Dim strsql As String
            If Args.ColIndex = 5 Then
                'To check if there are any ETC requests for the Project.
                'strsql = "Exec usp_DB_CheckETCRecords " & Args.DataReader("ProjectID").ToString
                'blnETCRequest = CBool(CommonFunctions.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))

                ''' START : Commented & Modified By ParagD On 29-Aug-2006 
                ''' Purpose : Whiz SP 7.2 Release
                ''' Project wise Resource - Project Role should be considered and not Corporate Level role.
                '''                         Thus ProjectID parameter is added for SP : "usp_DB_CheckAccessForNode"               

                '' SearchKey: JP_31Jul2006
                '' Modification by JijeshP on 31-Jul-2006 to Provide ETC Approval Link      

                'Dim strsql1 As String
                'strsql1 = "Exec usp_DB_CheckAccessForNode " & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'417' ," & Args.DataReader("ProjectID").ToString
                'blnETCNodeAccess = CBool(CommonFunctions.Data.GetDataScalar(strsql1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))

                ''' END : Commented & Modified By ParagD On 29-Aug-2006 
                blnETCNodeAccess = CType(m_objAccessHashTable(Args.DataReader("ProjectID").ToString), Boolean)
                blnETCRequest = CType(m_objETCHashTable(Args.DataReader("ProjectID").ToString), Boolean)

                If blnETCNodeAccess = True And blnETCRequest = True Then
                    'Commented And Added By Usha Pandit On 15.07.2020 For ETC Authentication link alignment
                    'Args.StringToBeInserted = "<TD Align=center><A Href='javascript:ShowETCApprovals(" + Args.DataReader("ProjectID").ToString + ")'>" + MyBase.GetResourceString("ETC_APPROVAL") + " </A></TD>"
                    Args.StringToBeInserted = "<TD Align=left><A Href='javascript:ShowETCApprovals(" + Args.DataReader("ProjectID").ToString + ")'>" + MyBase.GetResourceString("ETC_APPROVAL") + " </A></TD>"
                    'End Of Added By Usha Pandit On 15.07.2020 For ETC Authentication link alignment
                    Cancel = True
                Else
                    arrstrRowLinkField(5) = ""
                    Args.ReplacementValue = MyBase.GetResourceString("ETC_APPROVAL")
                End If
            End If
            ' JijeshP Modification Ends...SearchKey: JP_31Jul2006

            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        Catch ex As Exception
            'Exception Handler
        End Try

    End Sub
    Private Sub m_MyProjectsGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objMyProjects_Grid.ColumnHeaderTD_BeforePrint
        '====================================================================
        ' Procedure Name        :   m_MyProjectsGrid_ColumnHeaderTD_BeforePrint
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   Disable the Sorting from the Grid.
        ' Description           :   same as above.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   13 Dec,2005
        ' Revisions             :   
        '=====================================================================
        Try
            'Args.TDStyle = Args.TDStyle + "ForDB"
            If Args.ColIndex = 3 Or Args.ColIndex = 4 Or Args.ColIndex = 5 Then
                Args.ApplySorting = False
            End If
        Catch ex As Exception
            'Exception Handler
        End Try
    End Sub
#End Region

#Region "Constructor"
    Public Sub New()
        '  MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.DB_MyProjects", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()

        If Not IsNothing(m_objETCHashTable) Then
            m_objETCHashTable = Nothing
        End If
        If Not IsNothing(m_objAccessHashTable) Then
            m_objAccessHashTable = Nothing
        End If

        MyBase.Finalize()
    End Sub
#End Region

  
End Class