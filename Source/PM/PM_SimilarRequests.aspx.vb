#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_SimilarRequests
    Inherits WebPages.Template.WhizTemplate


    '=====================================================================
    ' Project Name          :   PBNIT Enterprise
    ' Module Name           :   Resource Allocation Details
    ' Page Name 	        :   PM_SimilarRequests
    ' Purpose				:	Show the similar request list.
    ' Description			:	Show the similar request list.
    ' Assumptions			:	Request already created.
    ' Dependencies			:	RequestID
    ' Author				:	NileshD
    ' Created				:	April 15, 2004
    ' Revisions				:	
    '=====================================================================

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
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Protected m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    Protected m_strRequestId As String
    Protected m_lngLocationId As Long
    Protected m_lngProjectID As Long = 0

    Private Enum MenuIndex
        CLOSE
        HELP
    End Enum
    Protected m_lngTagId As Long = 0

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
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_lngTagId = m_objGlobal.TagID
        m_lngProjectID = m_objGlobal.ProjectID
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
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
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
    
        Dim arrMenu(1) As String

        Dim arrMenuToolTip(1) As String

        Dim arrClientSideFunction(1) As String

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        arrMenuToolTip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        arrClientSideFunction(MenuIndex.CLOSE) = "Close_OnClick()"

        arrMenu(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        arrMenuToolTip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunction(MenuIndex.HELP) = "Help_OnClick(" & m_lngTagId.ToString() & ")"


        Dim strGrid As String

        'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_SimilarRequests", "AppResources")
    End Sub
    
    Private Sub DrawPageCaption ()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), , , True))
        Response.Write("<BR>")

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
        ' Author                : NileshD
        ' Created               : April 15, 2004
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
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
         m_objMenu = Nothing
         m_objGrid = Nothing
         m_objGlobal = Nothing
         m_objAccessRights = Nothing

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
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        Dim strQuery As String

        'This will initialize all the global objects.
        GetGlobalObject()
   
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()

        'Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")

        'Display the Control used to filter the list of requests.
        CommonFunctions.General.WriteHTML("<TABLE class='clsTable' cellpadding=0 cellspacing=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")

        CommonFunctions.General.WriteHTML("<TD width='10%' align='Right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OFFICE"))
        CommonFunctions.General.WriteHTML("</TD><TD width='23%' align='Left'>")
        strQuery = "EXEC usp_Sel_tbl_PM_Location"

        'for the first time get the location id of selected project.
        If Not (Request.QueryString("LocationID") Is Nothing) AndAlso Request.QueryString("LocationID") <> "" Then
            m_lngLocationId = CType(Request.QueryString("LocationID"), Long)
        Else
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'm_lngLocationId = CType(CommonFunction.Data.GetDataScalar("SELECT LOCATIONID FROM tbl_PM_Project where ProjectID = " + m_objGlobal.ProjectID.ToString, MyBase.UseSQL), Long)
            m_lngLocationId = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Project_LocationID " + m_objGlobal.ProjectID.ToString, MyBase.UseSQL), Long)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        End If

        'if this page is called for fisr time or if blank entry of combobox is selected then set the value
        'otherwise set the index to 0
        If Not (Request.QueryString("LocationID") Is Nothing) Then
            If Request.QueryString("LocationID") = "" Then
                CommonFunctions.HTMLControls.DrawComboBox("cboOffice", strQuery, 150, "0", "OnChange = CboOffice_Change()", True)
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboOffice", strQuery, 150, m_lngLocationId.ToString(), "OnChange = CboOffice_Change()", True)
            End If
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboOffice", strQuery, 150, m_lngLocationId.ToString(), "OnChange = CboOffice_Change()", True)
        End If

        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")

        DrawGrid()

        'HttpContext.Current.Response.Write("</DIV>")

        Response.Write("<BR>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()
    End Sub

    Private Sub DrawGrid()
        '====================================================================
        ' Procedure Name        : DrawGrid
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the Grid
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrActualColumns() As String = {"Projects", "Request Details"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("PROJECTS"), _
                                                 MyBase.GetResourceString("REQUEST_DETAILS")}
        Dim arrTDStyle() As String = {"width=30%", "width=70%"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'get the requestid from querystring. pass it to procedure and get the similar requests.
        m_strRequestId = CommonFunction.Data.CheckIsDBNull(Request.QueryString("RequestID").ToString, "").ToString


        'for the first time and for combo's 0 the index is selected , do not pass the location id to sp
        If Not (Request.QueryString("LocationID") Is Nothing) AndAlso Request.QueryString("LocationID") = "" Then
            strSQL = "usp_Sel_SimilarRequests " + m_strRequestId
        Else
            strSQL = "usp_Sel_SimilarRequests " + m_strRequestId + "," + m_lngLocationId.ToString
        End If

        With m_objGrid
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .TDStyleArray = arrTDStyle
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .DIVID = "PageDiv"
            .DIVHeight = 240
            .ColNameToolTipOnEachRow = True
            .NoOfDataColumns = 2
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

    End Sub

#End Region

# Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        '  MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
# End Region

# Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
# End Region

#Region "Page Events"
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
    End Sub
#End Region

End Class
