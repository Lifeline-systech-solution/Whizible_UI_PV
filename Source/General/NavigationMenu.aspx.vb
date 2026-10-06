Public Class NavigationMenu
    Inherits WebPages.Template.WhizTemplate

#Region "Declarations"
    Private WithEvents m_objMenu As Whiz.WebForms.Navigation.NavigationMenu
    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On - Wednesday, February 08, 2006 For Req.ID. - WAF3_GEN_3
    'Reason   - For Navigation Menu Favorites.
    '-------------------------------------------------------------------------------------------------------------
    Private WithEvents m_objFavoriteMenu As Whiz.WebForms.Navigation.NavigationMenuFavorites
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Wednesday, February 08, 2006 For Req.ID. - WAF3_GEN_3
    '-------------------------------------------------------------------------------------------------------------
#End Region

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Protected Sub WritePage()
        Dim strFromWhere As String = ""
        Dim strIdentifier As String = ""
        Dim lngUserID As Long
        Dim strLoginType As String
        Dim lngPostID As Long
        Dim strClsNavPaneBody As String
        Dim intDivHeight As Integer

        Dim blnShowFavorites As Boolean = False
        Dim intFavoriteNode As Integer
        Dim intAddRemove As Integer
        Dim strKey As String = ""
        Dim strSQL As String = ""

        Dim blnUseSQL As Boolean = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.General.GetApplicationKeySetting("UseSQL"), "True"), Boolean)
        Dim strConnectionString As String = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.General.GetConnectionString(), ""), String)
        Dim objSystemModules As CommonEngines.HashTables.SystemModules


        If Request.QueryString("FromWhere") Is Nothing Then
            strFromWhere = "SM"
        Else
            'Commented And Added by Chakshuta H on 29th-Oct-2015
            'strFromWhere = Request.QueryString("FromWhere").ToString
            ' ***********************************************************************************
            ' Modified Apr 13,2015 RajK R.No: P2-SEC-1
            ' ***********************************************************************************
            strFromWhere = HttpUtility.HtmlEncode(Request.QueryString("FromWhere").ToString)
            'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
        End If

        If Request.QueryString("TagID") Is Nothing Then
            strIdentifier = ""
        Else
            strIdentifier = Request.QueryString("TagID").ToString
        End If

        lngUserID = CType(Session("intUserID"), Long)
        strLoginType = Session("LoginType").ToString
        lngPostID = CType(Session("intPostID"), Long)

        m_objMenu = New Whiz.WebForms.Navigation.NavigationMenu(strFromWhere, lngUserID, strLoginType, lngPostID, blnUseSQL, strConnectionString)

        With m_objMenu

            'check for default culture id and current thread culture id
            If CType(MyBase.DefaultUILCID, Integer) = CType(Session("LCID"), Integer) Then
                objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", strFromWhere)
            Else
                objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules" + Session("LCID").ToString, strFromWhere)
                If objSystemModules Is Nothing Then
                    objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", strFromWhere)
                End If
            End If
            If Not objSystemModules Is Nothing Then

                strClsNavPaneBody = CommonFunctions.General.CheckIsNothing(objSystemModules.CSSNavMenuPaneBody, "clsNavMenuPaneBody")
                .ParentLinkCSSClass = CommonFunctions.General.CheckIsNothing(objSystemModules.CSSLinkParentNavMenu, "clsLinkParentNavMenu")
                .SelectedLinkCSSClass = CommonFunctions.General.CheckIsNothing(objSystemModules.CSSLinkSelectedNavMenu, "clsLinkSelectedNavMenu")
                .SelectedTDCSSClass = CommonFunctions.General.CheckIsNothing(objSystemModules.CSSTDSelectedNavMenu, "clsTDSelectedNavMenu")

                .ChildLinkCSSClass = CommonFunctions.General.CheckIsNothing(objSystemModules.CSSLinkChildNavMenu, "clsLinkChildNavMenu")

                .RaiseEvents = objSystemModules.RaiseMenuEvents ' enable menu events

                .ShowFavorites = objSystemModules.ShowFavorites
                blnShowFavorites = .ShowFavorites

                .LeftMargin = CType(CommonFunctions.General.CheckIsNothing(objSystemModules.LeftMargin, "0"), Integer) ' the left margin for image

                If .LeftMargin <= 0 Then .LeftMargin = 5
                intDivHeight = CType(CommonFunctions.General.CheckIsNothing(objSystemModules.NavMenuDivHeight, "0"), Integer)
                If intDivHeight <= 0 Then intDivHeight = 0

                .QueryStringIdentifierKey = "TagID"
                .SelectedIdentifier = .DecryptIdentifier(strIdentifier)
                .PageName = "NavigationMenu.aspx"
                .AdditionalQueryString = "FromWhere=" + strFromWhere

                .ParentTDCSSClass = "clsTDParentNavMenu"
                .ParentImageTDCSSClass = "clsTDParentNavMenuImg"

                .ChildTDCSSClass = "clsTDChildNavMenu"
                .ChildImageTDCSSClass = "clsTDChildNavMenuImg"

                .SelectedImageTDCSSClass = "clsTDSelectedNavMenuImg"

                If blnShowFavorites Then

                    intFavoriteNode = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("FavoriteNode"), "0"), Integer)

                    intAddRemove = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("AddRemoveFavorite"), "0"), Integer)
                    'intAddRemove = 0 then add
                    'intAddRemove = 1 then Remove
                    If intFavoriteNode <> 0 Then

                        '-------------------------------------------------------------------------------------------------------------
                        'Added By - PushkarK On - Monday, March 06, 2006 For Hotfix ID. - 2.0.43-SP3-WAF
                        '-------------------------------------------------------------------------------------------------------------
                        'intFavoriteNode = -2 : Get from Session.
                        If intFavoriteNode = -2 Then
                            intFavoriteNode = CType(CommonFunctions.General.CheckIsNothing(Session("FavTagID"), "0"), Integer)
                            'For Where Clause in sp
                            If intFavoriteNode <> 0 Then
                                strKey = lngUserID.ToString + ",'','" + strLoginType + "'"
                                strSQL = "usp_ins_del_tbl_UI_NavigationMenu_Favorites " + strKey + "," + intFavoriteNode.ToString + "," + intAddRemove.ToString
                                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

                                strKey = lngUserID.ToString + "-" + strFromWhere + "-" + strLoginType
                                'HashTable Key
                                CommonEngines.HashTables.CreateHashTables.CreateNavMenuFavoriteNodesHashTable(strKey)

                            End If
                        Else
                            '-------------------------------------------------------------------------------------------------------------
                            'Addition Ends By - PushkarK On - Monday, March 06, 2006 For Hotfix ID. - 2.0.43-SP3-WAF
                            '-------------------------------------------------------------------------------------------------------------

                            'For Where Clause in sp
                            strKey = lngUserID.ToString + ",'" + strFromWhere + "','" + strLoginType + "'"

                            strSQL = "usp_ins_del_tbl_UI_NavigationMenu_Favorites " + strKey + "," + intFavoriteNode.ToString + "," + intAddRemove.ToString
                            CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)


                            strKey = lngUserID.ToString + "-" + strFromWhere + "-" + strLoginType
                            'HashTable Key
                            CommonEngines.HashTables.CreateHashTables.CreateNavMenuFavoriteNodesHashTable(strKey)

                            '-------------------------------------------------------------------------------------------------------------
                            'Added By - PushkarK On - Monday, March 06, 2006 For Hotfix ID. - 2.0.43-SP3-WAF
                            '-------------------------------------------------------------------------------------------------------------
                        End If
                        '-------------------------------------------------------------------------------------------------------------
                        'Addition Ends By - PushkarK On - Monday, March 06, 2006 For Hotfix ID. - 2.0.43-SP3-WAF
                        '-------------------------------------------------------------------------------------------------------------

                    End If

                    m_objFavoriteMenu = New Whiz.WebForms.Navigation.NavigationMenuFavorites(strFromWhere, lngUserID, strLoginType, lngPostID, blnUseSQL, strConnectionString)
                    m_objFavoriteMenu.RaiseEvents = .RaiseEvents ' enable menu events
                    m_objFavoriteMenu.LeftMargin = .LeftMargin ' the left margin for image
                    m_objFavoriteMenu.QueryStringIdentifierKey = .QueryStringIdentifierKey
                    m_objFavoriteMenu.PageName = .PageName
                    m_objFavoriteMenu.AdditionalQueryString = .AdditionalQueryString

                    m_objFavoriteMenu.FavoritesDivCSSClass = CommonFunctions.General.CheckIsNothing(objSystemModules.CSSDivNavFavMenu, "clsDivNavFavMenu")
                    m_objFavoriteMenu.FavoritesTHeadCSSClass = CommonFunctions.General.CheckIsNothing(objSystemModules.CSSTHeadFavorites, "clsTHeadFavoritesNavMenu")

                    m_objFavoriteMenu.ChildLinkCSSClass = CommonFunctions.General.CheckIsNothing(objSystemModules.CSSLinkFavNavMenu, "clsLinkFavNavMenu")
                    m_objFavoriteMenu.ChildTDCSSClass = .ChildTDCSSClass
                    m_objFavoriteMenu.ChildImageTDCSSClass = "clsFavoriteChildTDImg"
                    m_objFavoriteMenu.DivHeight = CType(CommonFunctions.General.CheckIsNothing(objSystemModules.NavMenuFavDivHeight, "0"), Integer)
                    m_objFavoriteMenu.MaxFavorites = CType(CommonFunctions.General.CheckIsNothing(objSystemModules.MaxNumberOfFavorites, "0"), Integer)
                End If

            End If
            objSystemModules = Nothing

            CommonFunctions.General.WriteHTML("<body MS_POSITIONING='GridLayout' class='" + strClsNavPaneBody + "'>")
            CommonFunctions.General.WriteHTML("<form id='frmNavMenu' method='post' runat='server'>")
            CommonFunctions.General.WriteHTML("<div id='clsDivNavMenu' style='height:" + intDivHeight.ToString + "'>")

            'If lngPostID = 44 And UCase(strFromWhere) = "RM" Then
            '    .DisableLinks = True
            '    If .ShowFavorites Then m_objFavoriteMenu.DisableLinks = True
            'End If

            .CreateNavigationMenu()
            CommonFunctions.General.WriteHTML("</div>")
            If blnShowFavorites Then
                m_objFavoriteMenu.CreateNavigationFavoritesMenu()
            End If
            CommonFunctions.General.WriteHTML("</form>")
            CommonFunctions.General.WriteHTML("</body>")
        End With
        m_objMenu.Dispose() : m_objMenu = Nothing
        If Not m_objFavoriteMenu Is Nothing Then
            m_objFavoriteMenu.Dispose() : m_objFavoriteMenu = Nothing
        End If
    End Sub

#Region "Event handling-Navigation Menu"


    Protected Overridable Sub Menu_After_ChildNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs) Handles m_objMenu.Menu_After_ChildNode_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_After_ChildNode_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_After_Children_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs) Handles m_objMenu.Menu_After_Children_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_After_Children_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_After_CSFunction_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs) Handles m_objMenu.Menu_After_CSFunction_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_After_CSFunction_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_After_Image_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs) Handles m_objMenu.Menu_After_Image_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_After_Image_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_After_ParentNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs) Handles m_objMenu.Menu_After_ParentNode_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_After_ParentNode_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_After_Parents_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs) Handles m_objMenu.Menu_After_Parents_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_After_Parents_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_After_SelectedNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs) Handles m_objMenu.Menu_After_SelectedNode_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_After_SelectedNode_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_Before_ChildNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel) Handles m_objMenu.Menu_Before_ChildNode_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_Before_ChildNode_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_Before_Children_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel) Handles m_objMenu.Menu_Before_Children_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_Before_Children_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_Before_CSFunction_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel) Handles m_objMenu.Menu_Before_CSFunction_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_Before_CSFunction_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_Before_ParentNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel) Handles m_objMenu.Menu_Before_ParentNode_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_Before_ParentNode_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_Before_Image_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel) Handles m_objMenu.Menu_Before_Image_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_Before_Image_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_Before_Parents_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel) Handles m_objMenu.Menu_Before_Parents_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_Before_Parents_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_Before_SelectedNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel) Handles m_objMenu.Menu_Before_SelectedNode_Print
        WebForms.Navigation.NavigationMenu_Events.Menu_Before_SelectedNode_Print(sender, e)
    End Sub

    Protected Overridable Sub Menu_Init(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel) Handles m_objMenu.Menu_Init

        WebForms.Navigation.NavigationMenu_Events.Menu_Init(sender, e)
    End Sub
#End Region

    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On - Wednesday, February 08, 2006 For Req.ID. - WAF3_GEN_3
    'Reason   - For adding event handling for Navigation Menu Favorites.
    '-------------------------------------------------------------------------------------------------------------
#Region "Event handling - Navigation Menu Favorites"

    Protected Overridable Sub FavoritesMenu_After_Item_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgs) Handles m_objFavoriteMenu.FavoritesMenu_After_Item_Print
        WebForms.Navigation.NavigationMenuFavorites_Events.FavoritesMenu_After_Item_Print(sender, e)
    End Sub

    Protected Overridable Sub FavoritesMenu_After_Items_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgs) Handles m_objFavoriteMenu.FavoritesMenu_After_Items_Print
        WebForms.Navigation.NavigationMenuFavorites_Events.FavoritesMenu_After_Items_Print(sender, e)
    End Sub

    Protected Overridable Sub FavoritesMenu_After_Image_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgs) Handles m_objFavoriteMenu.FavoritesMenu_After_Image_Print
        WebForms.Navigation.NavigationMenuFavorites_Events.FavoritesMenu_After_Image_Print(sender, e)
    End Sub

    Protected Overridable Sub FavoritesMenu_Before_Item_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgsWithCancel) Handles m_objFavoriteMenu.FavoritesMenu_Before_Item_Print
        WebForms.Navigation.NavigationMenuFavorites_Events.FavoritesMenu_Before_Item_Print(sender, e)
    End Sub

    Protected Overridable Sub FavoritesMenu_Before_Items_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgsWithCancel) Handles m_objFavoriteMenu.FavoritesMenu_Before_Items_Print
        WebForms.Navigation.NavigationMenuFavorites_Events.FavoritesMenu_Before_Items_Print(sender, e)
    End Sub

    Protected Overridable Sub FavoritesMenu_Before_Image_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgsWithCancel) Handles m_objFavoriteMenu.FavoritesMenu_Before_Image_Print
        WebForms.Navigation.NavigationMenuFavorites_Events.FavoritesMenu_Before_Image_Print(sender, e)
    End Sub
    Protected Overridable Sub FavoritesMenu_Init(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgsWithCancel) Handles m_objFavoriteMenu.FavoritesMenu_Init

        WebForms.Navigation.NavigationMenuFavorites_Events.FavoritesMenu_Init(sender, e)
    End Sub
#End Region
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Wednesday, February 08, 2006 For Req.ID. - WAF3_GEN_3
    '-------------------------------------------------------------------------------------------------------------


    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class

