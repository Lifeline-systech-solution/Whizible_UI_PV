Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_Navigation
            Public Shared Sub Initialize_Menu_DefaultNavigation(ByRef Cancel As Boolean, ByRef Args As CommonFunctions.GenerateTree.WAF_HTMLMenu)

            End Sub
            Public Shared Sub Before_NodeAdd_DefaultNavigation(ByRef Cancel As Boolean, ByRef Args As CommonFunctions.GenerateTree.WAF_HTMLMenuItem)
                Dim drReader As IDataReader
                Dim SQL As String
                Dim strQuery As String
                Dim drGadgets As IDataReader
                Dim IsActive As Boolean = True
                Dim IsParent As String

                If HttpContext.Current.Session("LoginType").ToString <> "C" Then
                    ' If the current node is having a advance view then change the url to the tabbed view page.
                    If Not HttpContext.Current.Session("intProjectID") Is Nothing Then
                        SQL = "usp_Sel_tbl_CNF_GadgetNodes_EmployeePreferences " + Args.TagID.ToString + "," + HttpContext.Current.Session("intUserID").ToString()
                        drReader = CommonFunction.Data.GetDataReader(SQL, True)
                        If drReader.Read Then
                            IsActive = CType(drReader("Active"), Boolean)
                        End If
                        If IsActive = True Then
                            Args.Href = "../Source/General/Tab_Viewpage.aspx?FromWhere=PM&FromTagID=27&FromWhere=PM&MasterTagId=" + Args.TagID.ToString
                            'strQuery = "usp_Sel_GetGadgetTagIDs " + Args.TagID.ToString
                            'drGadgets = CommonFunction.Data.GetDataReader(strQuery, True)
                            'While drGadgets.Read
                            '    drGadgets("TagID").ToString()
                            'End While
                        End If

                        CommonFunction.Data.DisposeDataReader(drReader)

                        ' if the current node is gadget in active advance view for the logged in resource hide the link from tree
                        If Args.IsParent = True Then
                            IsParent = "1"
                        Else
                            IsParent = "0"
                        End If
                        'Modified By VarunA on 23-Feb-2009 RequestID-18602
                        'Purpose : Depending upon Employee Level and Role node should be accessible 
                        'strQuery = "usp_Sel_GetGadgetTagIDs " + Args.TagID.ToString + "," + HttpContext.Current.Session("intUserID").ToString() + "," + IsParent
                        strQuery = "usp_Sel_GetGadgetTagIDs " + Args.TagID.ToString + "," + HttpContext.Current.Session("intUserID").ToString() + "," + IsParent + "," + HttpContext.Current.Session("intPostID").ToString()
                        'End By VarunA On 23-Feb-2009 RequestID-18602
                        drGadgets = CommonFunction.Data.GetDataReader(strQuery, True)
                        If drGadgets.Read Then
                            Cancel = Not CType(drGadgets("Show"), Boolean)
                        End If
                        CommonFunction.Data.DisposeDataReader(drGadgets)
                    End If

                    'Added by SonalD on 12th August 2008
                    'Purpose : To change node name when easymenu is enabled
                    Dim strSQL As String
                    Dim dr As IDataReader
                    Dim intUserID As String
                    Dim IsEasyMenu As String = ""
                    intUserID = HttpContext.Current.Session("intUserID")
                    IsEasyMenu = CommonFunction.Data.GetDataScalar("usp_sel_IsEasyMenu_tbl_UI_UserSettings " + intUserID, True)
                    If IsEasyMenu = "1" Or IsEasyMenu Is Nothing Then
                        strSQL = "usp_sel_tbl_CNF_ReplacementNodeName"
                        dr = CommonFunction.Data.GetDataReader(strSQL, True)
                        While dr.Read()
                            If Args.Item = dr("GadgetNodeName") Then
                                Args.Item = dr("NewNodeName")
                            End If
                        End While
                        CommonFunction.Data.DisposeDataReader(dr)
                    End If
                    'End of Addition by sonald on 12th august 2008
                End If

                ' Added By PurvaJ On 12-May-2008 for WhizibleSEM8
                ' Purpose : To enabled workflow approvals page link even if there is no project selected.
                If Args.TagID = CommonFunction.Constants.APP_TAG_WORKFLOW_APPROVALS Then
                    Args.Href = "../Source/DM/DM_WorkFlowApprovals.aspx"
                End If

                If Args.TagID = CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING Then
                    Args.Href = "../Source/General/CommonList.aspx?Show=0&FromWhere=PM&MasterTagId=32"
                End If
                ' End addition PurvaJ



            End Sub

            Public Shared Sub AfterMenuInitialize(ByRef Args As DynamicMenu.EventMenu)

            End Sub
            Public Shared Sub BeforeMenuHTMLReplace(ByRef Cancel As Boolean, ByRef Args As DynamicMenu.EventMenu)

            End Sub
            Public Shared Sub AfterMenuHTMLReplace(ByRef Args As DynamicMenu.EventMenu)

            End Sub
            Public Shared Sub BeforeMenuTargetFramePlot(ByRef Cancel As Boolean, ByRef Args As DynamicMenu.InlineFrame)


            End Sub
            Public Shared Sub AfterMenuTargetFramePlot(ByRef Args As DynamicMenu.InlineFrame)

            End Sub

            Public Shared Sub BeforeAddItem(ByRef Cancel As Boolean, ByRef Args As DynamicMenu.MenuItemDecorator)
                Dim leftLogo As String = "../images/sidebarnormal.gif"
                Dim leftlogoover As String = "../images/sidebar.gif"

                'If Args.ID = "PM" Or Args.ID = "QSD" Or Args.ID = "SM" _
                '    Or Args.ID = "RM" Or Args.ID = "KM" Or Args.ID = "CRM" _
                '    Or Args.ID = "MR" Or Args.ID = "PRO" Or Args.ID = "FA" _
                '    Or Args.ID = "DA" Or Args.ID = "BTS" Or Args.Label = "Logout" Then
                '    Args.MenuItem.LeftLogo = leftLogo
                '    Args.MenuItem.LeftLogoOver = leftlogoover
                'End If
                '' Added by Dhanashri S on 29 Oct 2015
                If Args.ID = "DB" Or Args.ID = "PM" Or Args.ID = "QSD" Or Args.ID = "SM" _
                    Or Args.ID = "RM" Or Args.ID = "KM" Or Args.ID = "CRM" _
                    Or Args.ID = "MR" Or Args.ID = "PRO" Or Args.ID = "FA" _
                    Or Args.ID = "DA" Or Args.ID = "BTS" Or Args.Label = "Logout" Then

                    If Args.ID Is Nothing Then
                        Args.MenuItem.LeftLogo = Args.Label + ".jpg"
                    Else
                        Args.MenuItem.LeftLogo = Args.ID + ".jpg"
                    End If
                    'Args.MenuItem.LeftLogoOver = Args.ID + "over.jpg"

                    'Args.MenuItem.LeftLogo = leftLogo
                    'Args.MenuItem.LeftLogoOver = leftlogoover
                End If
                ''End of Addition by Dhanashri S on 29 Oct 2015
            End Sub
            Public Shared Sub AfterAddItem(ByRef Args As DynamicMenu.MenuItemDecorator)

            End Sub
            Public Shared Sub BeforePlotMenu(ByRef Cancel As Boolean, ByRef Args As DynamicMenu.EventMenu)

            End Sub
            Public Shared Sub AfterPlotMenu(ByRef Args As DynamicMenu.EventMenu)

            End Sub

            Public Shared Sub BeforeChildItemAssign(ByRef Cancel As Boolean, ByRef item As DynamicMenu.EventMenuItem, ByRef group As DynamicMenu.EventMenuGroup)

            End Sub
            Public Shared Sub AfterChildItemAssign(ByRef item As DynamicMenu.EventMenuItem, ByRef group As DynamicMenu.EventMenuGroup)

            End Sub

        End Class
    End Namespace
End Namespace


