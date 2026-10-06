'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhiziblePPM
' Module Name           :  MentricDB_Menu.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================
Option Strict Off
#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
' To Plot the Dynamic Menu
Imports Telerik.WebControls



#End Region

Public Class MetricDB_Menu
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
    Protected m_lngTagId As Long = 1001


    Protected MyMenuGroup As MenuGroup
    Protected MyMenuChildGroup As MenuGroup
    Protected MyMenuItem As New Telerik.WebControls.MenuItem

    Protected WithEvents MyMenu As New Telerik.WebControls.RadMenu

    ' JijeshP Addition on 28th Jul 2006
    Protected WithEvents MyMenu2 As New Telerik.WebControls.RadMenu
    Protected m_NoSections As Integer
    Protected NoMenu As Integer = 1
    ' JijeshP Addition Ends.


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
        Call GetGlobalObject()

        Call InitVariables()

        Call DrawMenu()

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
        'm_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub InitVariables()
        '====================================================================
        ' Procedure Name        :  InitVariables
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To store the variable values
        ' Description           :  This sub-routine Fills the variables with initial values 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  28 Nov 2005 
        ' Revisions             :  
        '=====================================================================
        m_lngTagId = CInt(Request.QueryString("DashboardID"))
    End Sub
    ''''''''''Private Sub DrawMenu()
    ''''''''''    '====================================================================
    ''''''''''    ' Procedure Name        :  DrawMenu
    ''''''''''    ' Parameters Passed     :  None
    ''''''''''    ' Returns               :  None
    ''''''''''    ' Parameters Affected   :  None
    ''''''''''    ' Purpose               :  To Draw the Image Menu
    ''''''''''    ' Description           :  This sub-routine Draws the Image menu based.
    ''''''''''    ' Assumptions           :  None
    ''''''''''    ' Dependencies          :  None
    ''''''''''    ' Author                :  NitinVS 
    ''''''''''    ' Created               :  28 Nov 2005 
    ''''''''''    ' Revisions             :  
    ''''''''''    '=====================================================================
    ''''''''''    Dim strSQL As String
    ''''''''''    Dim strSQLSections As String
    ''''''''''    Dim objDr As IDataReader
    ''''''''''    Dim objDrSections As IDataReader
    ''''''''''    Dim strCaption As String
    ''''''''''    Dim strHref As String
    ''''''''''    Dim strImage As String
    ''''''''''    Dim IsGroupedOn As Boolean
    ''''''''''    Dim strMenuId As String
    ''''''''''    Dim strCurrentMenuGroup As String
    ''''''''''    Dim objSectionTitle As New WebPages.Template.SectionTitle
    ''''''''''    Dim objfirstGroup As MenuGroup
    ''''''''''    Dim blnFirstMenuGroup As Boolean = False
    ''''''''''    Dim strMenu As String
    ''''''''''    Dim strDiv As String

    ''''''''''    m_NoSections = 0

    ''''''''''    strSQLSections = "usp_sel_Tbl_Menu_Settings_Test " + m_lngTagId.ToString
    ''''''''''    objDrSections = CommonFunction.Data.GetDataReader(strSQLSections, MyBase.UseSQL)
    ''''''''''    While objDrSections.Read
    ''''''''''        m_NoSections = m_NoSections + 1
    ''''''''''        strSQL = "usp_sel_Tbl_Menu_Settings_Test " + m_lngTagId.ToString + ", NULL, " + CType(objDrSections("SectionID"), String)
    ''''''''''        objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

    ''''''''''        ' Create The Menu Object with Default properties 
    ''''''''''        MyMenuGroup = New MenuGroup

    ''''''''''        MyMenu.ID = "MyMenu"
    ''''''''''        MyMenuGroup.Flow = "Vertical"
    ''''''''''        MyMenuGroup.Id = "LeftMenu"

    ''''''''''        MyMenu.RootGroup = MyMenuGroup


    ''''''''''        MyMenu.ScrollSpeed = 10
    ''''''''''        MyMenu.OverrideDefaultTDCss = True
    ''''''''''        MyMenu.CausesValidation = 0
    ''''''''''        MyMenu.ClickToOpen = True
    ''''''''''        MyMenu.CssFile = "../General/WindowsXP.css"
    ''''''''''        MyMenu.DefaultExpandEffectDuration = 5
    ''''''''''        MyMenu.DefaultGroupCss = "MenuGroup"
    ''''''''''        MyMenu.DefaultItemCss = "MenuItem"
    ''''''''''        MyMenu.DefaultItemHeight = 15
    ''''''''''        MyMenu.DefaultItemOverCss = "arrow_right.gif"
    ''''''''''        MyMenu.EnableViewState = 0
    ''''''''''        MyMenu.GroupHideDelay = 1000
    ''''''''''        MyMenu.DefaultItemOverCss = "MenuItemOver"
    ''''''''''        MyMenu.OnClientClick = "ProcessClientHover"
    ''''''''''        MyMenu.Opacity = 100
    ''''''''''        MyMenu.Overlay = 1
    ''''''''''        MyMenu.OverrideDefaultTDCss = 0
    ''''''''''        MyMenu.ScrollCssClass = "MenuScroll"
    ''''''''''        MyMenu.ScrollDownDisabledImage = "ScrollDownDisabled.gif"
    ''''''''''        MyMenu.ScrollDownImage = "ScrollDown.gif"
    ''''''''''        MyMenu.ScrollOverCssClass = "MenuScrollOver"
    ''''''''''        MyMenu.ScrollSpeed = 10
    ''''''''''        MyMenu.ScrollUpDisabledImage = "ScrollUpDisabled.gif"
    ''''''''''        MyMenu.ScrollUpImage = "ScrollUp.gif"
    ''''''''''        MyMenu.ShadowColor = "White"
    ''''''''''        MyMenu.ShadowWidth = 1
    ''''''''''        MyMenu.ShowPath = 1
    ''''''''''        MyMenu.ImagesBaseDir = "Images"




    ''''''''''        While objDr.Read
    ''''''''''            strCaption = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Caption"), ""), "")
    ''''''''''            strHref = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Href"), ""), "")
    ''''''''''            IsGroupedOn = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("IsGroupedOn"), ""), "")
    ''''''''''            strImage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Image"), ""), "")
    ''''''''''            strMenuId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("MenuID"), ""), "")

    ''''''''''            MyMenuItem = New MenuItem

    ''''''''''            MyMenuItem.Id = strMenuId
    ''''''''''            MyMenuItem.Label = HttpUtility.UrlDecode("<BR>" + strCaption)
    ''''''''''            MyMenuItem.Href = strHref
    ''''''''''            MyMenuItem.LeftLogo = strImage
    ''''''''''            MyMenuItem.NoWrap = False
    ''''''''''            MyMenuItem.TextAlign = "Center"
    ''''''''''            MyMenuItem.Target = "WorkSpace"
    ''''''''''            MyMenuItem.ToolTip = strCaption

    ''''''''''            MyMenuItem.PostBack = False
    ''''''''''            MyMenuItem.ParentGroup = MyMenuGroup
    ''''''''''            MyMenuGroup.AddItem(MyMenuItem)


    ''''''''''            'MyMenuItem = New MenuItem

    ''''''''''            'MyMenuItem.Id = strMenuId
    ''''''''''            'MyMenuItem.Label = strCaption
    ''''''''''            'MyMenuItem.Href = strHref
    ''''''''''            'MyMenuItem.Target = "WorkSpace"
    ''''''''''            'MyMenuItem.ToolTip = strCaption
    ''''''''''            'MyMenuItem.Height = 8
    ''''''''''            'MyMenuItem.NoWrap = False
    ''''''''''            'MyMenuItem.PostBack = False
    ''''''''''            'MyMenuItem.ParentGroup = MyMenuGroup
    ''''''''''            'MyMenuGroup.AddItem(MyMenuItem)

    ''''''''''        End While

    ''''''''''        'MyMenu.RootGroup = MyMenuGroup
    ''''''''''        'MyMenu.RootGroup = objfirstGroup

    ''''''''''        CommonFunction.Data.DisposeDataReader(objDr)

    ''''''''''        'With objSectionTitle
    ''''''''''        '    Response.Write(.GetSectionTitle("Metircs", "DivMenu", "ShowHideMenu"))
    ''''''''''        '    Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
    ''''''''''        '    Response.Write(.ClientsideScript())
    ''''''''''        '    Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
    ''''''''''        'End With

    ''''''''''        Response.Write("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable><TR class=clsTRSectionHeader><TD align=Left id=tdShowHide_ShowHideMenu  onclick ='ShowHideMenu()' onmouseover='divOnMouseOver(this)' >PM Dashboard</TD><TD align=Right><Div id='SecLinksDivMenu'></Div></TD></TR></TABLE>")

    ''''''''''        Response.Write("<Div id='DivMenu' name='Menudiv'>")
    ''''''''''        strMenu = MyMenu.GetMenuHTML()
    ''''''''''        strMenu = Replace(strMenu, "<tr>", "<tr class=clsTREven>")
    ''''''''''        strMenu = Replace(strMenu, "<td align=""center"">&lt;BR&gt;", "<td></TD></tr><tr class=clsTREven> <td align='center' >")

    ''''''''''        strMenu = Replace(strMenu, "align=""Left"" width=""5px""", "align='Center'")

    ''''''''''        Response.Write(strMenu)
    ''''''''''        Response.Write("</div>")



    ''''''''''        MyMenu = Nothing
    ''''''''''        MyMenuItem = Nothing
    ''''''''''        MyMenuGroup = Nothing
    ''''''''''        objSectionTitle = Nothing
    ''''''''''    End While ' JP_28jul
    ''''''''''End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        :  DrawMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Image Menu
        ' Description           :  This sub-routine Draws the Image menu based.
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrajaktaR 
        ' Created               :  6 Jun 2006
        ' Revisions             :  
        '                       'Modified by JijeshP on 31st July 2006 for WhizibleSEM SP 7.2 Issue ID.3735
        '                       ' Used the WhizibleSEM6.0 solution Pages for the Integration                        
        '=====================================================================
        Dim strSQL As String
        Dim strSQLSections As String
        Dim objDr As IDataReader
        Dim objDrSections As IDataReader
        Dim strCaption As String
        Dim strHref As String
        Dim strImage As String
        Dim IsGroupedOn As Boolean
        Dim strMenuId As String
        Dim strCurrentMenuGroup As String
        Dim objSectionTitle As New WebPages.Template.SectionTitle
        Dim objfirstGroup As MenuGroup
        Dim blnFirstMenuGroup As Boolean = False
        Dim strMenu As String
        Dim strDiv As String
        Dim strMode As String = ""

        m_NoSections = 0

        strSQLSections = "usp_sel_Tbl_Menu_Settings_Test " + m_lngTagId.ToString
        objDrSections = CommonFunction.Data.GetDataReader(strSQLSections, MyBase.UseSQL)
        While objDrSections.Read
            m_NoSections = m_NoSections + 1
            strSQL = "usp_sel_Tbl_Menu_Settings_Test " + m_lngTagId.ToString + ", NULL, " + CType(objDrSections("SectionID"), String)
            objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

            MyMenuGroup = New MenuGroup

            Dim MyMenu1 As New Telerik.WebControls.RadMenu

            MyMenu1.ID = "MyMenu1_" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDrSections("SectionID"), ""), "")
            MyMenuGroup.Flow = "Vertical"
            MyMenuGroup.Id = "LeftMenu"

            MyMenu1.RootGroup = MyMenuGroup

            MyMenu1.ScrollSpeed = 10
            MyMenu1.OverrideDefaultTDCss = True
            MyMenu1.CausesValidation = 0
            MyMenu1.ClickToOpen = True
            MyMenu1.CssFile = "../General/WindowsXP.css"
            MyMenu1.DefaultExpandEffectDuration = 5
            MyMenu1.DefaultGroupCss = "MenuGroup"
            MyMenu1.DefaultItemCss = "MenuItem"
            MyMenu1.DefaultItemHeight = 15
            MyMenu1.DefaultItemOverCss = "arrow_right.gif"
            MyMenu1.EnableViewState = 0
            MyMenu1.GroupHideDelay = 1000
            MyMenu1.DefaultItemOverCss = "MenuItemOver"
            MyMenu1.OnClientClick = "ProcessClientHover"
            MyMenu1.Opacity = 100
            MyMenu1.Overlay = 1
            MyMenu1.OverrideDefaultTDCss = 0
            MyMenu1.ScrollCssClass = "MenuScroll"
            MyMenu1.ScrollDownDisabledImage = "ScrollDownDisabled.gif"
            MyMenu1.ScrollDownImage = "ScrollDown.gif"
            MyMenu1.ScrollOverCssClass = "MenuScrollOver"
            MyMenu1.ScrollSpeed = 10
            MyMenu1.ScrollUpDisabledImage = "ScrollUpDisabled.gif"
            MyMenu1.ScrollUpImage = "ScrollUp.gif"
            MyMenu1.ShadowColor = "White"
            MyMenu1.ShadowWidth = 1
            MyMenu1.ShowPath = 1
            MyMenu1.ImagesBaseDir = "Images"

            While objDr.Read
                strCaption = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Caption"), ""), "")
                strHref = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Href"), ""), "")
                IsGroupedOn = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("IsGroupedOn"), ""), "")
                strImage = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Image"), ""), "")
                strMenuId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("MenuID"), ""), "")
                'Integrated by Sana for resource management on 8-Oct-2009
                'Added By GaneshG On 08-Sep-09
                If strCaption.ToUpper = "ALLOCATE RESOURCE" And m_lngTagId = 1008 Then
                    If CommonFunction.Application.AllowResourceAllocation = True Then
                        strHref = "../PM/PM_ResourceAllocation.aspx?FromWhere=MDB&MasterTagId=1225"
                    Else
                        strHref = "../Home/ProjectListforResourceAllocation_CommonList.aspx?FromWhere=MDB&MasterTagID=20053"
                    End If
                End If
                'End Addition By GaneshG
                'End Integration by Sana for resource management on 8-Oct-2009

                MyMenuItem = New MenuItem

                MyMenuItem.Id = strMenuId
                MyMenuItem.Label = HttpUtility.UrlDecode("<BR>" + strCaption)
                MyMenuItem.Href = strHref
                MyMenuItem.LeftLogo = strImage
                MyMenuItem.NoWrap = False
                MyMenuItem.TextAlign = "Center"
                MyMenuItem.Target = "WorkSpace"
                MyMenuItem.ToolTip = strCaption

                MyMenuItem.PostBack = False
                MyMenuItem.ParentGroup = MyMenuGroup

                'Added by NitinVS on 6 Sug 2007 for WhizibleSEM 7
                MyMenuItem.Width = "105"
                'End Addition by NitinVS on 6 Sug 2007 for WhizibleSEM 7

                MyMenuGroup.AddItem(MyMenuItem)
            End While

            'Response.Write("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable ><TR class=clsTRSectionHeader><TD align=Left id=tdShowHide_ShowHideMenu" + CType(objDrSections("SectionID"), String) + " onclick ='ShowHideMenu(tdShowHide_ShowHideMenu" + CType(objDrSections("SectionID"), String) + ")' onmouseover='divOnMouseOver(this)' >" + CType(objDrSections("SectionName"), String) + "</TD><TD align=Right><Div id='SecLinksDivMenu'></Div></TD></TR></TABLE>")
            Response.Write("<TABLE cellspacing=1 cellpadding=1 border-style:ridge border-color: black  border=""1"" Width='99.9%' class=clsTable ><TR class=clsTRSectionHeader><TD align=center id=tdShowHide_ShowHideMenu" + strMenuId + " onclick ='ShowHideMenu(" + CType(objDrSections("OrderNo"), String) + ")' onmouseover='divOnMouseOver(this)' >" + CType(objDrSections("SectionName"), String) + "</TD></TR></TABLE>") '<TD align=Right><Div id='SecLinksDivMenu'></Div></TD>
            CommonFunction.Data.DisposeDataReader(objDr)

            Response.Write("<Div name=Menudiv id=DivMenu" + CType(objDrSections("OrderNo"), String) + ">")
            strMenu = MyMenu1.GetMenuHTML()
            strMenu = Replace(strMenu, "<tr>", "<tr class=clsTREven>")
            strMenu = Replace(strMenu, "<td align=""center"">&lt;BR&gt;", "<td></TD></tr><tr class=clsTREven> <td align='center' >")

            strMenu = Replace(strMenu, "align=""Left"" width=""5px""", "align='Center'")

            Response.Write(strMenu)
            Response.Write("</div>")
            MyMenu1 = Nothing
        End While

        CommonFunction.Data.DisposeDataReader(objDrSections)

        'MyMenu1 = Nothing

        MyMenuItem = Nothing
        MyMenuGroup = Nothing
        objSectionTitle = Nothing

    End Sub
#End Region

    Public Sub New()
        'MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub



End Class
