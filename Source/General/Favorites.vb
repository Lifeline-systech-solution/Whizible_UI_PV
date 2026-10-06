'=====================================================================
' Module Name           : Favorites
' Description           : same as above
' Parameters Passed     : none
' Returns               : none
' Parameters Affected   : 
' Assumptions           : 
' Dependencies          : 
' Author                : NitinVS
' Created               : Jan 24, 2006
' Revisions             :
'=====================================================================

#Region "Imports"
Imports System.Web
Imports System.IO
Imports System.Threading
Imports System.Text
#End Region

Namespace FavoritesTree

   

    Public Class FavoritesTree
       
        Private Shared m_intLeftMargin As Integer = 30  ' the left margin (TD width for the margin). 
        Private Shared m_strTableStyle As String = "cellpadding=0 cellspacing=0 width=100%" ' table style
        Private Shared m_strTableCSSClass As String = "clsTableNavMenu" ' the css class name for the table
        Private Shared m_strSelectedTRCSSClass As String = "clsTRSelectedNavMenu"
        Private Shared m_strParentTRCSSClass As String = "clsTRParentNavMenu"
        Private Shared m_strChildTRCSSClass As String = "clsTRChildTRNavMenu"
        Private Shared m_strSelectedTDCSSClass As String = "clsTDSelectedNavMenu" ' the TD class for selcted node
        Private Shared m_strParentTDCSSClass As String = "clsTDParentNavMenu" ' the TD class for Parent nodes
        Private Shared m_strChildTDCSSClass As String = "clsTDChildNavMenu" ' the TD class for child node
        Private Shared m_strSelectedImageTDCSSClass As String = "clsTDSelectedNavMenuImg" ' the TD class for selected node image
        Private Shared m_strParentImageTDCSSClass As String = "clsTDParentNavMenuImg" ' the TD class for parent node image
        Private Shared m_strChildImageTDCSSClass As String = "clsTDChildNavMenuImg" ' the TD class for child node image
        Private Shared m_strMenuLinkCSSClass As String = "clsNavMenu"
        Private Shared m_strSelectedLinkCSSClass As String = "clsLinkSelectedNavMenu" ' the TD class for selected node image
        Private Shared m_strParentLinkCSSClass As String = "clsLinkParentNavMenu" ' the TD class for parent node image
        Private Shared m_strChildLinkCSSClass As String = "clsLinkChildNavMenu" ' the TD class for child node image
       

        Public Shared Function DrawFavoritesMenu(ByVal intParentIdentifier As Integer) As String
            '=====================================================================
            ' Procedure Name        : DrawFavoritesMenu()	
            ' Purpose               : Main procedure to draw Favorites Menu
            ' Description           : same as above
            ' Parameters Passed     : none
            ' Returns               : none
            ' Parameters Affected   : 
            ' Assumptions           : 
            ' Dependencies          : 
            ' Author                : VidyaJ 
            ' Created               : Jan  25, 2006
            ' Revisions             :
            '=====================================================================

           

            Try
                With HttpContext.Current.Response
                    .Write("<TABLE class=" + m_strTableCSSClass + " " + m_strTableStyle + ">")

                    '--Write Javascript function to handle node click

                    .Write("<SCRIPT Language=javascript>")
                    .Write(" function FavoritesNode_Click(id) ")
                    .Write(" { window.location.href='NavigationMenu.aspx?TagID='+id + '&FromWhere=FV';} ")
                    .Write(" </SCRIPT> ")

                    '--Create Favorites Parent Node
                    CreateFavoritesMenu(intParentIdentifier)

                  
                    .Write("</TABLE>")
                End With

            Catch ex As Exception
                ex.Source = "DrawFavoritesMenu - Error: Error building menu  "
                Throw ex
            End Try

        End Function

        Private Shared Sub CreateChildNodes(ByVal intParentIdentifier As Integer)

        End Sub
        Private Shared Sub CreateFavoritesMenu(ByVal intParentIdentifier As Integer)
            Try
                Dim strSQL As String
                Dim objDR As IDataReader
                strSQL = "usp_sel_FavoritesMenu " + CType(HttpContext.Current.Session("intUSerID"), String) + ",'" + CType(HttpContext.Current.Session("LoginType"), String) + "'" & "," & CType(intParentIdentifier, String)


                objDR = CommonFunctions.Data.GetDataReader(strSQL, True)


                While objDR.Read

                    With HttpContext.Current.Response

                        If CType(objDR("parentNodeID"), Integer) = 0 Then
                            '--Create Favorites Parent Node
                            .Write("<TR class=" + m_strParentTRCSSClass + ">")
                            WriteLeftMarginTD()
                            .Write("<TD class=" + m_strParentImageTDCSSClass + ">")
                            .Write("</TD>")
                            If intParentIdentifier = 0 Then
                                .Write("<TD class=" + m_strSelectedTDCSSClass + ">")
                            Else
                                .Write("<TD class=" + m_strParentTDCSSClass + ">")
                            End If
                            .Write("<a class=" + m_strParentLinkCSSClass + " href=""javascript:FavoritesNode_Click(0)"" >")
                            .Write(HttpContext.Current.Server.HtmlEncode(CType(objDR("NodeName"), String)))
                            .Write("</a>")
                            .Write("</TD>")
                            .Write("</TR>")
                        Else
                            If CType(objDR("IsParent"), Boolean) = False Then
                                .Write("<TR class=" & m_strChildTRCSSClass & "> ")
                                .Write("<TD ></TD>")
                                .Write("<TD class=" & m_strChildTDCSSClass & "></TD>")
                                If CType(objDR("TemplateID"), String) = "PM" And CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID")) = "" And CType(objDR("TagID"), Integer) <> 32 Then
                                    .Write("<TD class=" & m_strChildTDCSSClass & ">" & CType(objDR("NodeName"), String) & " </TD></TR>")
                                Else
                                    .Write("<TD class=" & m_strChildTDCSSClass & "><A class=" & m_strChildLinkCSSClass & " href = '" & CType(objDR("nodeURL"), String) & "' target=Sub> " & CType(objDR("NodeName"), String) & " </A></TD></TR>")
                                End If


                            Else

                                    .Write("<TR class=clsTRChildTRNavMenu>")
                                    .Write("<TD width=25></TD>")
                                    .Write("<TD class=clsTDChildNavMenuImg></TD>")
                                    .Write("<TD class=clsTDParentNavMenu><A class=clsLinkParentNavMenu ")
                                    .Write(" href = 'javascript:FavoritesNode_Click(" & CType(objDR("NodeID"), Integer) & ")' > " & CType(objDR("NodeName"), String) & " </A></TD></TR>")



                                End If
                            End If


                    End With
                End While
                CommonFunction.Data.DisposeDataReader(objDR)

            Catch ex As Exception
                ex.Source = "CreateFavoritesRootNode - Error: Error building menu  "
                Throw ex
            End Try
        End Sub
        Private Shared Sub WriteLeftMarginTD()
            HttpContext.Current.Response.Write("<TD width=" + m_intLeftMargin.ToString + "></TD>")
        End Sub

        Public Shared Function DrawFavoritesHTMLTree() As String
            '=====================================================================
            ' Procedure Name        : DrawFavoritesHTMLTree()	
            ' Purpose               : Main procedure to draw HTML Favorites Tree 
            ' Description           : same as above
            ' Parameters Passed     : none
            ' Returns               : none
            ' Parameters Affected   : 
            ' Assumptions           : 
            ' Dependencies          : 
            ' Author                : NitinVS 
            ' Created               : Jan  24, 2006
            ' Revisions             :
            '=====================================================================

            Dim sbHTMLTree As New StringBuilder
            Dim strSQL As String
            Dim objDR As IDataReader
            Dim TreeIndex As Integer
            Dim strExapndedNodes As String
            Dim sbExpandednodes As New StringBuilder

            sbHTMLTree.Append("<html>" + vbCrLf)
            sbHTMLTree.Append("<head>" + vbCrLf)
            sbHTMLTree.Append("<title>Tree</title>" + vbCrLf)
            sbHTMLTree.Append("<meta http-equiv='Content-Type' content='text/html;'>" + vbCrLf)
            sbHTMLTree.Append("<link rel='StyleSheet' href='../Source/General/StyleSheetChanakya.css' type='text/css'>" + vbCrLf)
            sbHTMLTree.Append("<meta http-equiv='Cache-Control' CONTENT='no-cache'>" + vbCrLf)
            sbHTMLTree.Append("<meta http-equiv='Pragma' CONTENT='no-cache'>" + vbCrLf)
            sbHTMLTree.Append("<script type='text/javascript' src='../Source/General/Tree.js'></script>" + vbCrLf)
            sbHTMLTree.Append("<script type='text/javascript'>" + vbCrLf)
            sbHTMLTree.Append("<!--" + vbCrLf)
            sbHTMLTree.Append("var Tree = new Array;" + vbCrLf)
            sbHTMLTree.Append("// nodeId | parentNodeId | nodeName | nodeUrl |Tooltip |IsParent |TreeNodeImagePath" + vbCrLf)

            ' Code To Create The Array 
            strSQL = "usp_sel_Favorites " + CType(HttpContext.Current.Session("intUSerID"), String) + ",'" + CType(HttpContext.Current.Session("LoginType"), String) + "'"

            objDR = CommonFunctions.Data.GetDataReader(strSQL, True)

            Dim intCount As Integer = 0
            Dim aryExpandedNodes() As String
            Dim intCountForImages As Integer

            While objDR.Read
                sbHTMLTree.Append("Tree[" + TreeIndex.ToString + "]=" + Chr(34) + objDR("nodeID").ToString + "|" + objDR("ParentnodeID").ToString + "|")
                sbHTMLTree.Append(objDR("nodeName").ToString + "|" + objDR("nodeUrl").ToString.ToString + "|" + objDR("Tooltip").ToString + "|")
                sbHTMLTree.Append(CType(objDR("IsParent"), Integer).ToString + "|")

                sbHTMLTree.Append(objDR("TreeNodeImagePath").ToString + Chr(34) + ";" + vbCrLf)

                If CType(objDR("IsParent"), Boolean) = True Then
                    strExapndedNodes = strExapndedNodes + (TreeIndex + 1).ToString + "'"

                    sbExpandednodes.Append("var arrNode" + intCount.ToString + "Values=Tree[" + TreeIndex.ToString + "].split(""|"");" + vbCrLf)
                    sbExpandednodes.Append("oc(" + objDR("nodeID").ToString + ",0,arrNode" + intCount.ToString + "Values[6]);" + vbCrLf)

                    intCount += 1
                End If

                TreeIndex += 1
            End While

            CommonFunction.Data.DisposeDataReader(objDR)


            sbHTMLTree.Append("//-->" + vbCrLf)
            sbHTMLTree.Append("</script>" + vbCrLf)
            sbHTMLTree.Append("</head>" + vbCrLf)

            sbHTMLTree.Append("<body class=clsTreeBody>" + vbCrLf)
            sbHTMLTree.Append("<form id='frmTree'>" + vbCrLf)
            sbHTMLTree.Append("<div id='tree'>" + vbCrLf)
            sbHTMLTree.Append("<script type='text/javascript'>" + vbCrLf)
            sbHTMLTree.Append("<!--" + vbCrLf)
            sbHTMLTree.Append(" var objfrm;" + vbCrLf)
            sbHTMLTree.Append(" var objdivlist;" + vbCrLf)
            sbHTMLTree.Append(" objfrm = GetFormReference('frmTree');" + vbCrLf)
            sbHTMLTree.Append(" objdivlist=GetObjectReference('frmTree','tree');" + vbCrLf)
            ' for netscape/firefox browsers set the apt div height
            sbHTMLTree.Append(" if(navigator.appName != 'Microsoft Internet Explorer')" + vbCrLf)
            sbHTMLTree.Append(" {" + vbCrLf)
            sbHTMLTree.Append("     objdivlist.style.overflow='auto';" + vbCrLf)
            sbHTMLTree.Append("     objdivlist.style.height=520;" + vbCrLf)
            sbHTMLTree.Append(" }" + vbCrLf)
            sbHTMLTree.Append("createTree(Tree);" + vbCrLf)

            'Dim intCount As Integer
            'Dim aryExpandedNodes() As String
            ''Code Added BY NiranjanS for displaying Tree node images on 20 Sep 2005 R.No. WAF3_PB_9
            'Dim intCountForImages As Integer
            'If strExapndedNodes & "" <> "" Then
            '    aryExpandedNodes = strExapndedNodes.Split(Chr(39))

            '    For intCount = 0 To aryExpandedNodes.Length - 1
            '        If aryExpandedNodes(intCount).ToString.Trim <> "" Then
            '            intCountForImages = CType(aryExpandedNodes(intCount), Integer) - 1
            '            sbHTMLTree.Append("var arrNode" + intCount.ToString + "Values=Tree[" + intCountForImages.ToString + "].split(""|"");" + vbCrLf)
            '            sbHTMLTree.Append("oc(" + aryExpandedNodes(intCount) + ",0,arrNode" + intCount.ToString + "Values[6]);" + vbCrLf)
            '        End If
            '    Next
            'End If
            sbHTMLTree.Append(sbExpandednodes.ToString)

            sbHTMLTree.Append("-->") '//
            sbHTMLTree.Append("</script>" + vbCrLf)
            sbHTMLTree.Append("</div>" + vbCrLf)
            sbHTMLTree.Append("</form>" + vbCrLf)
            sbHTMLTree.Append("</body>" + vbCrLf)
            sbHTMLTree.Append("</html>" + vbCrLf)

            Dim swMyFile As TextWriter
            Dim strFileName As String

            'Modified BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
            'strFileName = "../../Reports/Tree" & CType(context.Session("intUserId"), String) & ".html"
            strFileName = "../../Reports/FA-" & CType(HttpContext.Current.Session("intUserId"), String) & "-" & CType(HttpContext.Current.Session("LoginType"), String) & ".html"


            'End of Modification BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8

            swMyFile = File.CreateText(HttpContext.Current.Server.MapPath(strFileName))
            swMyFile.Write(sbHTMLTree.ToString)
            sbHTMLTree = Nothing
            swMyFile.Close()



            'DrawFavoritesHTMLTree = sbHTMLTree.ToString
        End Function

    End Class

End Namespace

