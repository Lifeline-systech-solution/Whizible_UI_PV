#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_ConfigureResourceAllocationDays
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Project Name          :   PBNIT Enterprise
    ' Module Name           :   Resource Allocation Details
    ' Page Name 	        :   PM_ConfigureResourceAllocationDays	
    ' Purpose				:	To modify the configured day for that request.
    ' Description			:	To modify the configured day for that request.
    ' Assumptions			:	Request already created.
    ' Dependencies			:	RequestID
    ' Author				:	NileshD
    ' Created				:	April 14, 2004
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
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Protected m_strRequestId As String
    Private strMenu As String                           'stores the static menu string.

    Private Enum MenuIndex
        SAVE
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
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_lngTagId = m_objGlobal.TagID
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
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================
    
        Dim arrMenu(2) As String

        Dim arrMenuToolTip(2) As String

        Dim arrClientSideFunction(2) As String

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        arrMenuToolTip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        arrClientSideFunction(MenuIndex.SAVE) = "Save_OnClick()"

        arrMenu(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        arrMenuToolTip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        arrClientSideFunction(MenuIndex.CLOSE) = "Close_OnClick()"

        arrMenu(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        arrMenuToolTip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunction(MenuIndex.HELP) = "Help_OnClick(" & m_lngTagId.ToString() & ")"


        Dim strGrid As String

        'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_ConfigureResourceAllocationDays", "AppResources")
     
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
        ' Created               : April 14, 2004
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
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        'strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        strReturn = "<B>" + MyBase.GetResourceString("PAGE_HEADER") + "</B>"
        IF strReturn <> "" then
           Response.Write(strReturn) 
        End IF   
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
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Private Sub WritePageLegend()
        '====================================================================
        ' Procedure Name        : WritePageLegend
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page legend
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
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
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        Dim strConfiguredDays As String
        Dim strValue As String
        Dim strSQL As String
        Dim objHeaderFooter As WebPages.Template.HeaderFooter

        m_strRequestId = CommonFunction.Data.CheckIsDBNull(Request.QueryString("RequestID").ToString, "").ToString
        'if query string contain updated value then updated the same in the database
        If Request.QueryString.Count = 2 Then
            strValue = CommonFunction.Data.CheckIsDBNull(Request.QueryString("Value").ToString, "").ToString
            strSQL = "usp_Upd_tbl_PM_ResourceRequest_ConfiguredDays " + m_strRequestId + "," + strValue
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        End If

        'select the configured days for selected request.
        strConfiguredDays = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ResourceRequest_configuredDays " + m_strRequestId, MyBase.UseSQL).ToString

        'This will initialize all the global objects.
        GetGlobalObject()

        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)

        'Page legend
        WritePageLegend()

        'Display the page caption.
        DrawPageCaption()

        'Display the Header if exist. 
        'DrawHeader()
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.HeaderFooter = MyBase.GetResourceString("PAGE_HEADER")
        objHeaderFooter.DrawHeaderFooter()
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<BR>")

        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<Table class='clsTable' cellpadding=0 cellspacing=0 width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>")
        Response.Write(MyBase.GetResourceString("NO_DAYS") + " ")
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNoDays", "txtNoDays", , 30, 2, strConfiguredDays, "Right", , , , , , , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</TD></TR></Table>")
        HttpContext.Current.Response.Write("</DIV>")
        Response.Write("<BR>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()
    End Sub

#End Region

# Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
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
        MyBase.InitializeResources("AppResources.PM_ConfigureResourceAllocationDays", "AppResources")

    End Sub
#End Region

End Class
