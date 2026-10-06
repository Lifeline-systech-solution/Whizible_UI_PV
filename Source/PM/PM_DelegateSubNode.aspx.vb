#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_DelegateSubNode
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

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        ''Added by Dhanashri S on 29 Jan 2016 for PkToken Validation
        If Not Request.QueryString("PkTokenTabAccess") Is Nothing Then
            m_PKToken_TabAccess = Request.QueryString("PkTokenTabAccess").ToString
        End If
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_PKToken_EmployeeID = Request.QueryString("EmployeeID").ToString
        End If
        If Not Request.QueryString("TagID") Is Nothing Then
            m_PKToken_TagID = Request.QueryString("TagID").ToString
        End If

        If m_PKToken_TabAccess <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_EmployeeID, String) + CType(m_PKToken_TagID, String) + CType(0, String) + CType(0, String), m_PKToken_TabAccess) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_PKToken_EmployeeID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of Addition by Dhanashri S on 29 Jan 2016


        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    Protected m_lngTagID As Long
    Protected m_lngUserID As Long
    Private m_lngProjectID As Long

    ''Added by Dhanashri S on 29 Jan 2016 for PkToken Validation
    Protected m_PKToken_TabAccess As String
    Protected m_PKToken_EmployeeID As String
    Protected m_PKToken_TagID As String
    ''End of Addition by Dhanashri S on 29 Jan 2016

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
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SELECTALL"), MyBase.GetResourceString("MENU_CLEARALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        Dim arrClientSideFunction() As String = {"Save_OnClick()", "SelectAll_OnClick()", "ClearAll_OnClick()", "Close_OnClick()", "Help_OnClick('TASK_DELEGATION')"}

        Dim strGrid As String

        'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
     
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.PM_DelegateSubNode", "AppResources")
        WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION") + "")
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
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
        ' Author                : 
        ' Created               : 
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here
        Dim strAction As String
        m_lngProjectID = CType(Session("intProjectID"), Long)
        If Request.QueryString("TagID") <> "" Then
            m_lngTagID = CType(Request.QueryString("TagID"), Long)
        Else
            m_lngTagID = 0
        End If

        m_lngUserID = CType(Request.QueryString("EmployeeID"), Long)

        strAction = Request.QueryString("Action") + ""

        If strAction <> "" Then
            Call performSubnodeAction(m_lngUserID, m_lngTagID, m_lngProjectID)
        End If


        'This will initialize all the global objects.
        GetGlobalObject()
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()

        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        Call plotSubnodeGrid(m_lngTagID, m_lngUserID)
        HttpContext.Current.Response.Write("</DIV>")
        Response.Write("<BR>")


        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotSubnodeGrid
    ' Parameters Passed		:	lngTagID - long - Tag ID 
    '                           lngUserID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw the grid of sub tag and Access type check boxes
    ' Description			:	This procedure will plot the grid of Sub Tag for the tagID passed to it
    '                           Here grid class is not used, as grid class doesn't support the 
    '                           requirements so grid is plotted manually with check boxes for access types.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	DipaliS
    ' Created				:	Dec 24 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotSubnodeGrid(ByVal lngTagID As Long, ByVal lngUserID As Long)
        Dim strSQL As String
        Dim objDrSubTag As IDataReader
        Dim objDr As IDataReader
        Dim lngSubTagID As Long
        Dim blnAdd As Boolean
        Dim blnEdit As Boolean
        Dim blnDelete As Boolean
        Dim blnView As Boolean
        Dim blnAccess As Boolean
        Dim blnCheckboxDisabled As Boolean
        Dim objLink As WebPage.UI.cDynamicLink
        Dim intRowCount As Integer
        Dim strModuleName As String
        Dim strParentTagName As String

        
        'display table
        '******************************************************************************************
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0>")

        'display column headers
        CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
        CommonFunctions.General.WriteHTML("<TD align=centre>" + MyBase.GetResourceString("COL_ACCESS") + "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=centre>" + MyBase.GetResourceString("COL_ADD") + "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=centre>" + MyBase.GetResourceString("COL_EDIT") + "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=centre>" + MyBase.GetResourceString("COL_DELETE") + "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=centre>" + MyBase.GetResourceString("COL_VIEW") + "</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        'start displaying the data
        strSQL = "usp_sel_Tbl_PM_tbl_PM_TaskDelegation_SubTag " + lngTagID.ToString + "," + lngUserID.ToString + "," + m_lngProjectID.ToString
        objDrSubTag = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        intRowCount = 1
        While objDrSubTag.Read

            If Not IsDBNull(objDrSubTag("SubTagID")) Then
                lngSubTagID = CType(objDrSubTag("SubTagID"), Long)
            End If

            'get all the Access (Add,Edit,Delete,View) for the tag
            If Not IsDBNull(objDrSubTag("A")) Then
                blnAdd = CType(objDrSubTag("A"), Boolean)
            Else
                blnAdd = False
            End If
            If Not IsDBNull(objDrSubTag("E")) Then
                blnEdit = CType(objDrSubTag("E"), Boolean)
            Else
                blnEdit = False
            End If
            If Not IsDBNull(objDrSubTag("D")) Then
                blnDelete = CType(objDrSubTag("D"), Boolean)
            Else
                blnDelete = False
            End If
            If Not IsDBNull(objDrSubTag("V")) Then
                blnView = CType(objDrSubTag("V"), Boolean)
            Else
                blnView = False
            End If

            If intRowCount Mod 2 <> 0 Then
                CommonFunctions.General.WriteHTML("<TR class='clsTROdd' >")
            Else
                CommonFunctions.General.WriteHTML("<TR class='clsTREven' >")
            End If

            CommonFunctions.General.WriteHTML("<TD align='left'>" + objDrSubTag("SubTagName").ToString + "</TD>")

            'display the check boxes
            CommonFunctions.General.WriteHTML("<TD align=centre>" + CommonFunctions.HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=centre>" + CommonFunctions.HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=centre>" + CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=centre>" + CommonFunctions.HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")

            CommonFunctions.General.WriteHTML("</TR>")
            intRowCount += 1

        End While
        objDrSubTag.Close()
        objDrSubTag.Dispose()
        objDrSubTag = Nothing

        CommonFunctions.General.WriteHTML("</Table>")
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , intRowCount.ToString, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub

    '=====================================================================
    ' Procedure Name		:	performSubnodeAction
    ' Parameters Passed		:	UserId 
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data for access to subtag for the UserId and TagID.
    ' Description			:	This procedure will update the data in the subnodeaccess for access
    '                           settings.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	DipaliS
    ' Created				:	Dec 23 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performSubnodeAction(ByVal lngUserID As Long, ByVal lngTagID As Long, ByVal lngProjectID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim i As Integer
        Dim blnPresent As Boolean
        Dim strAddAccess As String
        Dim strEditAccess As String
        Dim strDeleteAccess As String
        Dim strViewAccess As String
        Dim strUniqueSubTagIDList As String
        Dim arrList() As String


        'get the subTagId list for Add,Edit,Delete and View
        strAddAccess = MyBase.GetFormValue("chkAdd") + ""
        strEditAccess = MyBase.GetFormValue("chkEdit") + ""
        strDeleteAccess = MyBase.GetFormValue("chkDelete") + ""
        strViewAccess = MyBase.GetFormValue("chkView") + ""

        'create a list of SubTagID's for which entries are to be made for access
        Dim strTempList As String
        Dim arrTempList() As String
        Dim j As Integer

        strTempList = strAddAccess.Trim + "," + strEditAccess.Trim + "," + strDeleteAccess.Trim + "," + strViewAccess.Trim
        arrTempList = Split(strTempList, ",")
        strUniqueSubTagIDList = ""

        For i = 0 To arrTempList.Length - 1
            arrList = Split(strUniqueSubTagIDList.Trim, ",")
            blnPresent = False
            For j = 0 To arrList.Length - 1
                If arrTempList(i).Trim = arrList(j).Trim Then
                    blnPresent = True
                    Exit For
                End If
            Next
            arrList = Nothing   'free the memory

            If blnPresent = False Then
                strUniqueSubTagIDList += arrTempList(i).Trim + ","
            End If
        Next

        'first delete all the records from the tbl_UI_subnodeaccess table for this 
        'roleID and SubTagID's of this TagID
        strSQL = "usp_del_tbl_PM_TaskDelegation_SubTag " + m_lngTagID.ToString + "," + lngUserID.ToString + "," + lngProjectID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'to insert record in the tbl_ui_subnodeaccess first check whether there is 
        'already record present for this subtagID and RoleId or not. If not present then
        'insert new reocrd for this RoleID and subtagID and then update that record for access.
        strSQL = "usp_ins_tbl_PM_TaskDelegation_SubTag '" + strUniqueSubTagIDList.Trim + "'," + lngUserID.ToString + "," + lngProjectID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)


        'update the records for the Add access settings
        strSQL = "usp_upd_tbl_PM_TaskDelegation_SubTag '" + strAddAccess.Trim + "'," + lngUserID.ToString + ",'A'" + "," + lngProjectID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'update the records for the edit access settings
        strSQL = "usp_upd_tbl_PM_TaskDelegation_SubTag '" + strEditAccess.Trim + "'," + lngUserID.ToString + ",'E'" + "," + lngProjectID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'update the records for the Delete access settings
        strSQL = "usp_upd_tbl_PM_TaskDelegation_SubTag '" + strDeleteAccess.Trim + "'," + lngUserID.ToString + ",'D'" + "," + lngProjectID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'update the records for the View access settings
        strSQL = "usp_upd_tbl_PM_TaskDelegation_SubTag '" + strViewAccess.Trim + "'," + lngUserID.ToString + ",'V'" + "," + lngProjectID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

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

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        '' START : Integrated By ParagD On 6-Oct-2006
        '           w.r.t. IssueID #7105
        'Added by TruptiK
        If Args.LinkName.ToUpper = "SAVE" Then
            CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()
        End If
        'End of adition by TruptiK
        '' END : Integrated By ParagD On 6-Oct-2006
    End Sub
End Class
