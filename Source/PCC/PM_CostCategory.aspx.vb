#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_CostCategory
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        :	
    ' Purpose				:	
    ' Description			:	
    ' Assumptions			:	
    ' Dependencies			:	
    ' Author				:	
    ' Created				:	
    ' Revisions				:	
    '=====================================================================

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

#End Region

#Region "PageEvents"
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        Initialize()
    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        InitializeComponent()
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        'This will initialize all the global objects.
        GetGlobalObject()

        'This will strore the constructed menu string in a string variable.   
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Header if exist. 
        DrawHeader()

        Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;Height=420px'>")

        '--- Display Grid with tasks for updation
        DisplayGrid()

        HttpContext.Current.Response.Write("</DIV>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()
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
        'PrachiK
        'Modified By PrachiK on 15 Feb 2005 for Issue ID=15509. 
        'Purpose: Do not allow user to save changes who is having just "View" Access
        arrMenuList.Add("Close")
        arrMenuToolTipList.Add("Close")
        arrClientSideFunctionList.Add("Close_OnClick()")

        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page.
        ' Description           : Also gets the various User Preferences from the Database and 
        '                         information from the Querystring
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : PrajaktaR
        ' Created               : 19th July 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim strTaskIDs As String
        Dim drCompanyInformation As IDataReader
        Dim intFirstDay As Integer
        Dim dtFromDate As Date
        Dim drDates As IDataReader

        m_strWindowTitle = "Select Cost Category"

        '--- ProjectID
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")) <> "" Then
            m_intProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")), Integer)
        Else
            m_intProjectID = CInt(Session("intProjectID"))
        End If


        If CommonFunctions.General.CheckIsNothing(Request.QueryString("strTextBox")) <> "" Then
            strTextBox = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("strTextBox")), String)
        End If
    End Sub

#End Region

#Region "Constants"



#End Region

#Region "Member Variables"

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights        'This variable is for access rights of page.
    Protected WithEvents frmTaskCostCategory As System.Web.UI.HtmlControls.HtmlForm

    Private strMenu As String                           'stores the static menu string.
    Private m_intProjectID As Integer                   'Project ID
    Protected m_strWindowTitle As String                'Page Title
    Private m_strMode As String                         'Mode
    Protected strTextBox As String                        'QueryString Parameter 'textbox' from PM_TaskCostCategory

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
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function



#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing

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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Private Sub DisplayGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""

        strSQLQuery = "EXEC USP_tbl_PM_CostCategory_ForList " & CType(m_intProjectID, String) + "," + CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), ""))

        Dim arrActualColumns() As String = {"CostCategory", "Description"}
        Dim arrUserFriendlyColumn() As String = {"Cost Category", "Description"}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=50%"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strSQLQuery
            .DIVID = "divList"
            .DIVHeight = 400
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 2
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting     
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 

        'MyBase.InitializeResources("AppResources.PM_TaskCostCategory", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region


    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strCostCategory As String

        If Args.DataField.ToUpper = "COSTCATEGORY" Then
            'Args.EnableLink = True
            Args.StringToBeInserted = "<td align='left' width=40%>" & "<A Href='javascript:CCOnClick(""" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory")).ToString + """)'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CostCategory")).ToString + "</A></TD>"
            Cancel = True
        End If
    End Sub
End Class
