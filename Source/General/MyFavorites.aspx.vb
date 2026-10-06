'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  MyFavorites.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  NitinVS 
' Reviewed              :  
' Tested                :  
' Created               :  25 Jan 2006 
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

Public Class MyFavorites
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
    Protected m_lngTagId As Long = 3088
    Protected m_lngMode As Long
    Protected m_lngAction As Long = -1
    Protected m_strEmployeeId As String
    Protected m_strLogintype As String = "E"
    Protected m_strTemplateId As String = ""
    Protected m_strParentNodeID As String
    Protected m_strFavoriteID As String

    Private WithEvents objMyFavoritesGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objSelectFavoritesGrid As New WebPage.Templates.GenericGrid
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu

    Public Enum EnumMode
        MYFAVORITES
        SELECT_FAVORITES
        ADD_PARENT
        EDIT_FAVORITES
        LIST_PARENT
        EDIT_PARENT
    End Enum

    Public Enum EnumAction
        MYFAVORITES
        SELECT_FAVORITES
        ADD_PARENT
        EDIT_FAVORITES
        DELETE_PARENT
        EDIT_PARENT
    End Enum

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
        ' Author                :   NitinVS 
        ' Created               :   25 Jan 2006 
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()

        Call InitialiseVariables()

        If m_lngAction <> -1 Then
            Call PerformAcion()
        End If
        Call DrawMenu()

        CommonFunctions.General.WriteHTML("<BR>")

        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGECAPTION_MYFAVORITES"))

        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:99.99%;Height:400px'>")

        ' Draw My Favorites Screen 
        If m_lngMode = EnumMode.MYFAVORITES Then
            Call DrawMyFavorites()
        End If

        ' Draw screen to select pages to add to Favorites 
        If m_lngMode = EnumMode.SELECT_FAVORITES Then
            Call DrawSelectFavorites()
        End If

        If m_lngMode = EnumMode.EDIT_FAVORITES Then
            Call DrawEditFavorites()
        End If

        If m_lngMode = EnumMode.LIST_PARENT Then
            Call DrawListParent()
        End If

        If m_lngMode = EnumMode.ADD_PARENT Then
            Call DrawAddParent()
        End If

        If m_lngMode = EnumMode.EDIT_PARENT Then
            Call DrawEditParent()
        End If

        CommonFunction.General.WriteHTML("</DIV>")

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
        ' Author                :  NitinVS 
        ' Created               :  25 Jan 2006
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
        ' Procedure Name        :  InitialiseVariables
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Initialise the Variables 
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  25 Jan 2006 
        ' Revisions             :  
        '=====================================================================

        If m_lngMode = EnumMode.MYFAVORITES Then

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADD_TO_FAVORITES"), MyBase.GetResourceString("MENU_LIST_PARENT"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_DELETE_FAVORITES"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADD_TO_FAVORITES"), MyBase.GetResourceString("MENU_LIST_PARENT"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_DELETE_FAVORITES"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"AddToMyFavorites_OnClick()", "ListParent_OnClick()", "SelectAll_OnClick()", "AllClear()", "Delete_OnClick()", "OpenHelpPage('MyFavorites')"}

            m_objMenu = New WebPages.Template.StaticMenu
            Dim strmenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            CommonFunctions.General.WriteHTML(strmenu)

            m_objMenu = Nothing
        ElseIf m_lngMode = EnumMode.SELECT_FAVORITES Then

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"FavoritesSaveOnClick()", "SelectAll_OnClick()", "AllClear()", "Close_OnClick()", "OpenHelpPage('MyFavorites')"}

            m_objMenu = New WebPages.Template.StaticMenu
            Dim strmenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            CommonFunctions.General.WriteHTML(strmenu)

            m_objMenu = Nothing

        ElseIf m_lngMode = EnumMode.EDIT_FAVORITES Then

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"FavoritesUpdateOnClick()", "Close_OnClick()", "OpenHelpPage('MyFavorites')"}

            m_objMenu = New WebPages.Template.StaticMenu
            Dim strmenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            CommonFunctions.General.WriteHTML(strmenu)

            m_objMenu = Nothing

        ElseIf m_lngMode = EnumMode.LIST_PARENT Then

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADD_PARENT"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_DELETE_FAVORITES"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADD_PARENT"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLEAR_ALL"), MyBase.GetResourceString("MENU_DELETE_FAVORITES"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"AddParent_OnClick()", "SelectAll_OnClick()", "AllClear()", "DeleteParent_OnClick()", "Close_OnClick()", "OpenHelpPage('MyFavorites')"}

            m_objMenu = New WebPages.Template.StaticMenu
            Dim strmenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            CommonFunctions.General.WriteHTML(strmenu)

            m_objMenu = Nothing

        ElseIf m_lngMode = EnumMode.EDIT_PARENT Then

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"ParnetUpdateOnClick()", "Close_OnClick()", "OpenHelpPage('MyFavorites')"}

            m_objMenu = New WebPages.Template.StaticMenu
            Dim strmenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            CommonFunctions.General.WriteHTML(strmenu)
            m_objMenu = Nothing

        ElseIf m_lngMode = EnumMode.ADD_PARENT Then

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"AddParentSave_OnClick()", "Close_OnClick()", "OpenHelpPage('MyFavorites')"}

            m_objMenu = New WebPages.Template.StaticMenu
            Dim strmenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            CommonFunctions.General.WriteHTML(strmenu)
            m_objMenu = Nothing

        End If


    End Sub
    Private Sub InitialiseVariables()
        '====================================================================
        ' Procedure Name        :  InitialiseVariables
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Initialise the Variables 
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  25 Jan 2006 
        ' Revisions             :  
        '=====================================================================
        m_strEmployeeId = HttpContext.Current.Session("intUserID").ToString
        m_strLogintype = HttpContext.Current.Session("LoginType").ToString
        m_lngMode = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "1"), Long)
        m_lngAction = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ACTION"), "-1"), Long)
        m_strTemplateId = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODULE"), "")
        m_strParentNodeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ParentNodeID"), "")
        m_strFavoriteID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FavoriteID"), "")

    End Sub

    Private Sub DrawMyFavorites()
        '====================================================================
        ' Procedure Name        :  DrawMyFavorites
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw My Favorites Screen 
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  25 Jan 2006 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String

        Dim ArrActualFieldNames() As String = {"ParentNode", "OrderNo", "NodeDescription", ""}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("COL_PARENTNODE"), MyBase.GetResourceString("COL_ORDERNO"), MyBase.GetResourceString("COL_CHILDNODE"), MyBase.GetResourceString("COL_DELETE")}
        Dim ArrGrouponColumns() As String = {"1", "", "", ""}
        Dim ArrTDStyle() As String = {"align=left width=25%", "align=right width=10%", "align=left width=40%", "align=center width=25%"}
        Dim arrCheckBoxIds() As String = {"", "", "", "chkSelect"}
        Dim arrRowLink() As String = {"", "", "Edit_Favorites_On_click(FavoriteID)", ""}

        strSQL = "usp_sel_tbl_Favorites_MyFavorites " + m_strEmployeeId + ",'" + m_strLogintype + "'"

        With objMyFavoritesGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .CheckBoxIDArray = arrCheckBoxIds
            .NoOfDataColumns = 3
            .PrimaryKey = "FavoriteID"
            .DIVID = "DivMyTaskList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 450
            .SQL = strSQL
            .RowLinkArray = arrRowLink
            .GroupOnColumn = ArrGrouponColumns
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .DrawGrid()

        End With
        objMyFavoritesGrid = Nothing

    End Sub

    Private Sub DrawSelectFavorites()
        '====================================================================
        ' Procedure Name        :  DrawSelectFavorites
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw Selection List of Available Pages 
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  25 Jan 2006 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String

        Dim ArrActualFieldNames() As String = {"TagName"}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("COL_TAGNAME"), MyBase.GetResourceString("COL_SELECT")}
        Dim ArrTDStyle() As String = {"align=left width=75%", "align=center width=25%"}
        Dim arrCheckBoxIds() As String = {"", "chkSelect"}


        ' Draw the Filter for Module 
        CommonFunction.General.WriteHTML("<Table class='clsTable' width='99.9%' cellspacing=0 cellpading=0>")
        CommonFunction.General.WriteHTML("<TR class='clsTROdd'>")
        CommonFunction.General.WriteHTML("<TD align=right width=30% nowrap>")

        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_MODULE") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD align=left width=70% >")
        CommonFunction.HTMLControls.DrawComboBox("cboModule", "usp_Sel_Modules_Accessible ", 300, m_strTemplateId, "onchange=ModuleChange()")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<BR>")

        CommonFunction.General.WriteHTML("<TR class='clsTROdd'>")
        CommonFunction.General.WriteHTML("<TD align=right width=30% nowrap>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_FOLDER") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD style='align=left;width=70%' >")
        CommonFunction.HTMLControls.DrawComboBox("cboParent", "usp_Sel_Tbl_favorites_Parent_Edit " + m_strEmployeeId + ",'" + m_strLogintype + "'", 300, m_strParentNodeID)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</Table>")
        CommonFunction.General.WriteHTML("<BR>")

        strSQL = "usp_sel_tbl_UserAccess_for_Myfavorites " + m_strEmployeeId + ",'" + m_strLogintype + "', '" + m_strTemplateId + "'"

        With objSelectFavoritesGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .CheckBoxIDArray = arrCheckBoxIds
            .NoOfDataColumns = 1
            .PrimaryKey = "TagID"
            .DIVID = "DivMyTaskList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 400
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .DrawGrid()

        End With
        objMyFavoritesGrid = Nothing

        ArrActualFieldNames = Nothing
        ArrUserFriendlyFieldNames = Nothing
        ArrTDStyle = Nothing
        arrCheckBoxIds = Nothing

    End Sub

    Private Sub DrawListParent()
        '====================================================================
        ' Procedure Name        :  DrawMyFavorites
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw My Favorites Screen 
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  25 Jan 2006 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String

        Dim ArrActualFieldNames() As String = {"NodeDescription", "OrderNo"}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("COL_PARENTNODE"), MyBase.GetResourceString("COL_ORDERNO"), MyBase.GetResourceString("COL_DELETE")}
        Dim ArrTDStyle() As String = {"align=left width=50", "align=right width=25%", "align=left width=25%"}
        Dim arrCheckBoxIds() As String = {"", "", "chkSelect"}
        Dim arrRowLink() As String = {"Edit_Parnet_On_click(FavoriteID)", "", ""}
        Dim arrSortBy As String = "NodeDescription"

        strSQL = "usp_Sel_Tbl_favorites_Parent " + m_strEmployeeId + ",'" + m_strLogintype + "'"

        With objMyFavoritesGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .CheckBoxIDArray = arrCheckBoxIds
            .NoOfDataColumns = 2
            .PrimaryKey = "FavoriteID"
            .DIVID = "DivParnetList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 150
            .SQL = strSQL
            .SortBy = arrSortBy
            .SortOrder = "Asc"
            .RowLinkArray = arrRowLink
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .DrawGrid()

        End With
        objMyFavoritesGrid = Nothing

    End Sub

    Private Sub PerformAcion()
        '====================================================================
        ' Procedure Name        :  PerformAcion
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Execute the Database action 
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  25 Jan 2006 
        ' Revisions             :  
        '=====================================================================

        If m_lngMode = EnumMode.MYFAVORITES And m_lngAction = EnumAction.MYFAVORITES Then
            Dim strNodeList() As String
            Dim strNode As String

            strNodeList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Item("chkSelect"), "").Split(","c)

            For Each strNode In strNodeList
                Dim txtSQL As New System.Text.StringBuilder
                txtsql.Append("USP_DEL_tbl_favorites ")
                txtsql.Append(strNode)

                CommonFunction.Data.InsertOrUpdateData(txtsql.ToString, MyBase.UseSQL)
                txtsql = Nothing
            Next

        ElseIf m_lngMode = EnumMode.SELECT_FAVORITES And m_lngAction = EnumAction.SELECT_FAVORITES Then
            Dim strSelectednodes() As String
            Dim strCounter As String
            Dim strSQL As String


            strSelectednodes = HttpContext.Current.Request.Form.Item("chkSelect").Split(","c)

            For Each strCounter In strSelectednodes
                Dim txtSQL As New System.Text.StringBuilder
                txtSQL.Append("usp_Ins_tbl_Favorites ")
                txtSQL.Append(m_strEmployeeId)
                txtSQL.Append(" , '")
                txtSQL.Append(m_strLogintype)
                txtSQL.Append("' , ")
                txtSQL.Append(strCounter)
                txtSQL.Append(" , ")
                txtSQL.Append(m_strParentNodeID)

                strSQL = txtSQL.ToString
                txtSQL = Nothing
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next

            'Refreshparent
            CommonFunction.General.WriteHTML("<script language='javascript' >")
            CommonFunction.General.WriteHTML("refreshParent('frmMyFavorites', 'MyFavorites.aspx' ,'../General/MyFavorites.aspx?MODE=0&MasterTagID=3080&FromWhere=MR')")
            CommonFunction.General.WriteHTML("</script>")

        End If

        If m_lngMode = EnumMode.EDIT_FAVORITES And m_lngAction = EnumAction.EDIT_FAVORITES Then
            'Dim strParentIdentifier As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboParent"), "0")
            Dim strOrderNo As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNo"), "0")
            Dim txtSQL As New System.Text.StringBuilder

            txtSQL.Append("usp_UPD_tbl_Favorites ")
            txtsql.Append(m_strEmployeeId)
            txtsql.Append(" , '")
            txtsql.Append(m_strLogintype)
            txtsql.Append("', ")
            txtsql.Append(m_strFavoriteID)
            txtsql.Append(" , ")
            txtsql.Append(m_strParentNodeID)
            txtsql.Append(" , ")
            txtsql.Append(strOrderNo)

            CommonFunction.Data.InsertOrUpdateData(txtsql.ToString, MyBase.UseSQL)

            'Refreshparent
            CommonFunction.General.WriteHTML("<script language='javascript' >")
            CommonFunction.General.WriteHTML("refreshParent('frmMyFavorites', 'MyFavorites.aspx' ,'../General/MyFavorites.aspx?MODE=0&MasterTagID=3080&FromWhere=MR')")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</script>")

        End If

        If m_lngMode = EnumMode.EDIT_PARENT And m_lngAction = EnumAction.EDIT_PARENT Then

            Dim strOrderNo As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNo"), "0")
            Dim strNodedescription As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtParent"), "0")
            Dim txtSQL As New System.Text.StringBuilder

            txtSQL.Append("usp_UPD_tbl_Favorites_Parent ")
            txtsql.Append(m_strEmployeeId)
            txtsql.Append(" , '")
            txtsql.Append(m_strLogintype)
            txtsql.Append("', ")
            txtsql.Append(m_strFavoriteID)
            txtsql.Append(" , '")
            txtsql.Append(LTrim(RTrim(strNodedescription)))
            txtsql.Append("' , ")
            txtsql.Append(m_strParentNodeID)
            txtsql.Append(" , ")
            txtsql.Append(strOrderNo)

            CommonFunction.Data.InsertOrUpdateData(txtsql.ToString, MyBase.UseSQL)

            'Refreshparent
            CommonFunction.General.WriteHTML("<script language='javascript' >")
            CommonFunction.General.WriteHTML("refreshParent('frmMyFavorites', 'MyFavorites.aspx' ,'../General/MyFavorites.aspx?MODE=4')")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</script>")

        End If

        If m_lngMode = EnumMode.ADD_PARENT And m_lngAction = EnumAction.ADD_PARENT Then

            Dim strOrderNo As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNo"), "0")
            Dim strNodedescription As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtParent"), "0")
            Dim txtSQL As New System.Text.StringBuilder

            txtSQL.Append("usp_INS_tbl_Favorites_Parent ")
            txtsql.Append(m_strEmployeeId)
            txtsql.Append(" , '")
            txtsql.Append(m_strLogintype)
            txtsql.Append("', '")
            txtsql.Append(LTrim(RTrim(strNodedescription)))
            txtsql.Append("' , ")
            txtsql.Append(m_strParentNodeID)
            txtsql.Append(" , ")
            txtsql.Append(strOrderNo)

            CommonFunction.Data.InsertOrUpdateData(txtsql.ToString, MyBase.UseSQL)

            'Refreshparent
            CommonFunction.General.WriteHTML("<script language='javascript' >")
            CommonFunction.General.WriteHTML("refreshParent('frmMyFavorites', 'MyFavorites.aspx' ,'../General/MyFavorites.aspx?MODE=4')")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</script>")

        End If

        If m_lngMode = EnumMode.LIST_PARENT And m_lngAction = EnumAction.DELETE_PARENT Then

            Dim strFavoriteIDList() As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect"), "0").Split(","c)
            Dim objDr As IDataReader
            Dim strFavoriteID As String = ""
            Dim strResult As String = ""

            For Each strFavoriteID In strFavoriteIDList
                Dim txtSQL As New System.Text.StringBuilder
                txtSQL.Append("usp_Del_tbl_Favorites_Parent ")
                txtsql.Append(m_strEmployeeId)
                txtsql.Append(" , '")
                txtsql.Append(m_strLogintype)
                txtsql.Append("', ")
                txtsql.Append(strFavoriteID)
                objDr = CommonFunction.Data.GetDataReader(txtsql.ToString, MyBase.UseSQL)

                txtsql = Nothing

                If objDr.Read Then
                    strResult += CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Result"), ""), "")
                End If
                CommonFunction.Data.DisposeDataReader(objDr)
            Next

            If strResult <> "" Then
                CommonFunction.General.WriteHTML("<script language='javascript' >")
                CommonFunction.General.WriteHTML("alert(""" + strResult + """)")
                CommonFunction.General.WriteHTML("</script>")
            Else
                'Refreshparent
                CommonFunction.General.WriteHTML("<script language='javascript' >")
                CommonFunction.General.WriteHTML("refreshParent('frmMyFavorites', 'MyFavorites.aspx' ,'../General/MyFavorites.aspx?MODE=0&MasterTagID=3080&FromWhere=MR')")
                CommonFunction.General.WriteHTML("</script>")
            End If

        End If

    End Sub

    Private Sub DrawEditFavorites()
        '====================================================================
        ' Procedure Name        :  DrawEditFavorites
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw screen for Favorites Edit
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  31 Jan 2006 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strTagName As String
        Dim lngParentIdentifier As String
        Dim strOrderNo As String

        strSQL = "usp_sel_Favorites " + m_strEmployeeId + ",'" + m_strLogintype + "' , " + m_strFavoriteID
        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If objDR.Read Then
            strTagName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("nodeName"), ""), "")
            lngParentIdentifier = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("parentNodeID"), "0"), "0")
            strOrderNo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("OrderNo"), "0"), "0")
        End If
        CommonFunction.Data.DisposeDataReader(objDR)
        CommonFunction.General.WriteHTML("<TABLE id='tblEditFavorites' cellPadding=1 CellSpacing=0 class='clsTable' width='99.9%'>")
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_CHILDNODE") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.General.WriteHTML(strTagName)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_PARENTNODE") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.HTMLControls.DrawComboBox("cboParent", "usp_Sel_Tbl_favorites_Parent_Edit " + m_strEmployeeId + ",'" + m_strLogintype + "'", 300, lngParentIdentifier)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_ORDERNO") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.HTMLControls.DrawTextBox("txtOrderNo", "txtOrderNo", , 50, 10, strOrderNo, "right")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</Table>")

    End Sub

    Private Sub DrawEditParent()
        '====================================================================
        ' Procedure Name        :  DrawEditParent
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw screen for Parnet Edit
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  3 Feb 2006 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strNodeName As String
        Dim strOrderNo As String
        Dim strParentIdentifier As String

        strSQL = "usp_Sel_Tbl_favorites_Parent " + m_strEmployeeId + ",'" + m_strLogintype + "' , " + m_strFavoriteID
        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If objDR.Read Then
            strNodeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("NodeDescription"), ""), "")
            strOrderNo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("OrderNo"), "0"), "0")
            strParentIdentifier = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("ParentIdentifier"), "0"), "0")
        End If
        CommonFunction.Data.DisposeDataReader(objDR)
        CommonFunction.General.WriteHTML("<TABLE id='tblEditFavorites' cellPadding=1 CellSpacing=0 class='clsTable' width='99.9%'>")
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_PARENTNODE") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.HTMLControls.DrawTextBox("txtParent", "txtParent", , 300, 100, strNodeName, ismandatory:=True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")


        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_PARENTNODE") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.HTMLControls.DrawComboBox("cboParent", "usp_Sel_Tbl_favorites_Parent_Edit " + m_strEmployeeId + ",'" + m_strLogintype + "', " + m_strFavoriteID, 300, strParentIdentifier)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_ORDERNO") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.HTMLControls.DrawTextBox("txtOrderNo", "txtOrderNo", , 50, 10, strOrderNo, "right")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("</Table>")

    End Sub
    Private Sub DrawAddParent()
        '====================================================================
        ' Procedure Name        :  DrawEditParent
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw screen for Add Parnet 
        ' Description           :  
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  3 Feb 2006 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strNodeName As String
        Dim strOrderNo As String

        CommonFunction.General.WriteHTML("<TABLE id='tblEditFavorites' cellPadding=1 CellSpacing=0 class='clsTable' width='99.9%'>")
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_PARENTNODE") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.HTMLControls.DrawTextBox("txtParent", "txtParent", , 300, 100, , ismandatory:=True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_PARENTNODE") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.HTMLControls.DrawComboBox("cboParent", "usp_Sel_Tbl_favorites_Parent_Edit " + m_strEmployeeId + ",'" + m_strLogintype + "'", 300)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD  align=right width='30%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_ORDERNO") + " :")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD  align=left width='70%'>")
        CommonFunction.HTMLControls.DrawTextBox("txtOrderNo", "txtOrderNo", , 50, 10, , "right")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("</Table>")

    End Sub


#End Region

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.MyFavorites", "AppResources")
    End Sub


End Class
