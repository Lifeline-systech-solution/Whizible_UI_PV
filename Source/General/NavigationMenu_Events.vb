Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
'-------------------------------------------------------------------------------------------------------------
'Added By - PushkarK On - Wednesday, February 08, 2006 For Req.ID. - WAF3_GEN_3
'Reason   - For Navigation MEnu Favorites.
'-------------------------------------------------------------------------------------------------------------
Imports System.Web
Imports Whiz.WebForms.Navigation
'-------------------------------------------------------------------------------------------------------------
'Addition Ends By - PushkarK On - Wednesday, February 08, 2006 For Req.ID. - WAF3_GEN_3
'-------------------------------------------------------------------------------------------------------------

Namespace WebForms.Navigation
    Public Class NavigationMenu_Events

        Public Shared Sub Menu_After_ChildNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs)
            '' called after a child node is printed

            '' ex I: Disabling the Links after Enabling in Menu_Before_ChildNode_Print
            'If e.MenuNode.AccessGroup = "PM" Then
            '    If e.MenuNode.Identifier = "32" Then
            '        CType(sender, NavigationMenu).DisableLinks = True
            '    End If
            'End If

            '' ex I: Disabling the Links after Enabling in Menu_Before_ChildNode_Print
            '' also set ShowFavorites = True if in "Menu_Before_ChildNode_Print" event it is set to false
            'If e.MenuNode.AccessGroup = "SM" AndAlso e.MenuNode.Identifier = "80001" Then
            '    e.ApplySecurity = True
            '    CType(sender, NavigationMenu).ShowFavorites = True
            'End If

            '' ex: Ex_WAF3_GEN_3
            'Dim lngPostID As Long = CType(HttpContext.Current.Session("intUserID"), Long)
            'lngPostID = CType(HttpContext.Current.Session("intPostID"), Long)
            'If lngPostID = 44 And e.MenuNode.AccessGroup = "SM" Then
            '    If e.MenuNode.Identifier = "714" Then
            '        CType(sender, Whiz.WebForms.Navigation.NavigationMenu).DisableLinks = True
            '    End If
            'End If

        End Sub

        Public Shared Sub Menu_After_Children_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs)
            ' called after all children nodes are printed
        End Sub

        Public Shared Sub Menu_After_CSFunction_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs)
            ' called after the client side function for handling parent link clicks is printed
        End Sub

        Public Shared Sub Menu_After_Image_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs)
            ' called after the node image is printed
        End Sub

        Public Shared Sub Menu_After_ParentNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs)
            ' called after a parent node is printed
        End Sub

        Public Shared Sub Menu_After_Parents_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs)
            ' called after all parent nodes are printed
        End Sub

        Public Shared Sub Menu_After_SelectedNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgs)
            ' called after the selected/current node is printed
        End Sub

        Public Shared Sub Menu_Before_ChildNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel)
            '' called before a child node is printed

            '' ex I: setting security to false for a node
            'If e.MenuNode.Identifier = "80001" Then
            '    e.ApplySecurity = False
            'End If

            '' ex II: cancelling a node
            '    If e.MenuNode.AccessGroup = "IX" Then
            '        If e.MenuNode.Identifier = "1584" Then
            '            e.Cancel = True
            '        End If
            '    End If


            '' ex III: Enabling the Link for specific conditions
            'If e.MenuNode.AccessGroup = "PM" Then
            '    If e.MenuNode.Identifier = "32" Then
            '        CType(sender, NavigationMenu).DisableLinks = False
            '    End If
            'End If


            '' ex IV: After Adding a child node in Menu_Before_SelectedNode_Print Event 
            '' set the ApplySecurity to false for that specific child node
            'If e.MenuNode.AccessGroup = "SM" AndAlso e.MenuNode.Identifier = "80001" Then
            '    e.ApplySecurity = False
            'End If


            '' ex V: After Adding a child node in Menu_Before_SelectedNode_Print Event 
            '' set the ApplySecurity to false for that specific child node
            '' and set ShowFavorites = False to remove "add to favorite" link
            'If e.MenuNode.AccessGroup = "SM" AndAlso e.MenuNode.Identifier = "80001" Then
            '    e.ApplySecurity = False
            '    CType(sender, NavigationMenu).ShowFavorites = False
            'End If


            '' ex: Ex_WAF3_GEN_3
            'Dim lngPostID As Long = CType(HttpContext.Current.Session("intUserID"), Long)
            'lngPostID = CType(HttpContext.Current.Session("intPostID"), Long)
            'If lngPostID = 44 And e.MenuNode.AccessGroup = "SM" Then
            '    If e.MenuNode.Identifier = "714" Then
            '        CType(sender, Whiz.WebForms.Navigation.NavigationMenu).DisableLinks = False
            '    End If
            'End If

        End Sub

        Public Shared Sub Menu_Before_Children_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel)
            ' called before the children for the selected node are printed
        End Sub

        Public Shared Sub Menu_Before_CSFunction_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel)
            ' called before the client side function for handling parent node clicks is printed
        End Sub

        Public Shared Sub Menu_Before_ParentNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel)
            ' called before the parent node is printed
        End Sub

        Public Shared Sub Menu_Before_Image_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel)
            ' called before the image is printed
        End Sub

        Public Shared Sub Menu_Before_Parents_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel)
            ' called before the parent nodes are printed
        End Sub

        Public Shared Sub Menu_Before_SelectedNode_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel)
            ' called before the selected node is printed

            '' e.x: addding a child node to the selected node
            'If e.MenuNode.AccessGroup = "SM" Then
            '    Dim node As New Whiz.WebForms.Navigation.NavigationMenu("SM")
            '    node.Identifier = "80001"
            '    node.Name = "inserted node"
            '    node.PageName = "New node "
            '    node.URL = "../Source/CDB/CDB_main.aspx?DashboardID=4&"
            '    e.MenuNode.AddChild(node.CreateNode)
            '    node.Dispose()
            '    node = Nothing
            'End If

            Dim intCount As Integer
            Dim intOrder As Integer
            intOrder = 2
            intCount = 403            '80001


            If e.MenuNode.Identifier = "684" Or e.MenuNode.Identifier = "680" Then

                Dim drChildNodes As IDataReader
                Dim strSQL As String

                If e.MenuNode.Identifier = "684" Then
                    strSQL = "Exec usp_Sel_SDLCProcess " & CType(HttpContext.Current.Session("intProjectID"), Integer)
                Else
                    strSQL = "Exec usp_Sel_CorporatePlans " & CType(HttpContext.Current.Session("intProjectID"), Integer)
                End If

                drChildNodes = CommonFunctions.Data.GetDataReader(strSQL, True)


                While (drChildNodes.Read)
                    Dim node As New Whiz.WebForms.Navigation.NavigationMenu("PM")


                    'Modified by MrugajaB on 17th Jan 2006
                    'node.Identifier = "3" 'CType(intCount, String)                  'CType(drChildNodes("TagID"), String)
                    node.Identifier = CType(drChildNodes("TagID"), String)
                    'End Modification

                    node.Name = CType(drChildNodes("TagName"), String)

                    node.PageName = CType(drChildNodes("TagDescription"), String)
                    node.URL = CType(drChildNodes("PageName"), String)
                    node.ParentIdentifier = CType(e.MenuNode.Identifier, String)

                    'Commented by MrugajaB on 17th Jan 2006
                    'node.ApplyAccessSecurity = False
                    'End Comment
                    node.Level = "0"
                    node.Order = CType(intOrder, String)

                    e.MenuNode.AddChild(node.CreateNode)
                    node.Dispose()
                    node = Nothing
                    intCount = intCount + 1
                    intOrder = intOrder + 1
                End While

                CommonFunctions.Data.DisposeDataReader(drChildNodes)

            End If

        End Sub

        Public Shared Sub Menu_Init(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.EventArgsWithCancel)
            ' called before the menu plotting begins
            ' use for changing the basic properties of the node.

            '' ex I: removing the role access security
            ' If e.MenuNode.AccessGroup = "KM" Then
            '   e.MenuNode.ApplySecurity = False
            ' End If

        End Sub

    End Class


    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On - Wednesday, February 08, 2006 For Req.ID. - WAF3_GEN_3
    'Reason   - For Navigation MEnu Favorites.
    '-------------------------------------------------------------------------------------------------------------
    Public Class NavigationMenuFavorites_Events

        Public Shared Sub FavoritesMenu_After_Item_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgs)
            '' called after a child node is printed

            '' ex I: Disabling the Links after Enabling in Menu_Before_ChildNode_Print
            'If e.MenuNode.AccessGroup = "PM" Then
            '    If e.MenuNode.Identifier = "32" Then
            '        CType(sender, NavigationMenu).DisableLinks = True
            '    End If
            'End If


            '' ex: Ex_WAF3_GEN_3
            'Dim lngPostID As Long = CType(HttpContext.Current.Session("intUserID"), Long)
            'lngPostID = CType(HttpContext.Current.Session("intPostID"), Long)
            'If lngPostID = 44 And e.FavoriteMenuNode.AccessGroup = "SM" Then
            '    If e.FavoriteMenuNode.Identifier = "714" Then
            '        CType(sender, Whiz.WebForms.Navigation.NavigationMenuFavorites).DisableLinks = True
            '    End If
            'End If

        End Sub

        Public Shared Sub FavoritesMenu_After_Items_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgs)
            ' called after all children nodes are printed
        End Sub

        Public Shared Sub FavoritesMenu_After_Image_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgs)
            ' called after the node image is printed
        End Sub

        Public Shared Sub FavoritesMenu_Before_Item_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgsWithCancel)
            '' called before a child node is printed

            '' ex I: setting security to false for a favorite node
            'If e.FavoriteMenuNode.Identifier = "1029" Then
            '    e.ApplySecurity = False
            'End If

            '' ex II: cancelling a favorite node
            '    If e.FavoriteMenuNode.AccessGroup = "SM" Then
            '        If e.FavoriteMenuNode.Identifier = "1029" Then
            '            e.Cancel = True
            '        End If
            '    End If

            '' ex III: Enabling the Link for specific conditions
            'If e.FavoriteMenuNode.AccessGroup = "PM" Then
            '    If e.FavoriteMenuNode.Identifier = "32" Then
            '        CType(sender, NavigationMenuFavorites).DisableLinks = False
            '    End If
            'End If


            '' ex: Ex_WAF3_GEN_3
            'Dim lngPostID As Long = CType(HttpContext.Current.Session("intUserID"), Long)
            'lngPostID = CType(HttpContext.Current.Session("intPostID"), Long)
            'If lngPostID = 44 And e.FavoriteMenuNode.AccessGroup = "SM" Then
            '    If e.FavoriteMenuNode.Identifier = "714" Then
            '        CType(sender, Whiz.WebForms.Navigation.NavigationMenuFavorites).DisableLinks = False
            '    End If
            'End If

        End Sub

        Public Shared Sub FavoritesMenu_Before_Items_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgsWithCancel)
            ' called before the children for the selected node are printed
        End Sub

        Public Shared Sub FavoritesMenu_Before_Image_Print(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgsWithCancel)
            ' called before the image is printed
        End Sub

        Public Shared Sub FavoritesMenu_Init(ByVal sender As Object, ByVal e As Whiz.WebForms.Navigation.FavoriteEventArgsWithCancel)
            ' called before the menu plotting begins
            ' use for changing the basic properties of the node.

            '' ex I: removing the role access security
            ' If e.MenuNode.AccessGroup = "KM" Then
            '   e.MenuNode.ApplySecurity = False
            ' End If

        End Sub

    End Class
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Wednesday, February 08, 2006 For Req.ID. - WAF3_GEN_3
    '-------------------------------------------------------------------------------------------------------------

End Namespace