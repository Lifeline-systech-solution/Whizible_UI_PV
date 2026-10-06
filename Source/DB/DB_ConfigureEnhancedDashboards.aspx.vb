Public Class DB_ConfigureEnhancedDashboards
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
#Region "Variables"
    Private m_arrParentMenu As String()
    Private m_arrChildMenu As String()
    Protected m_strDashboardID As String
    Private m_strAction As String
    Dim strTagID As String = ""
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
    End Sub
    Private Sub InitializeVariables()
        If Request.QueryString("DashboardID") <> "" Then
            m_strDashboardID = Request.QueryString("DashboardID")
        ElseIf Request.Form("DashboardID") <> "" Then
            m_strDashboardID = Request.Form("DashboardID")
        Else
            m_strDashboardID = ""
        End If

        If Request.QueryString("Action") <> "" Then
            m_strAction = Request.QueryString("Action").ToUpper
        Else
            m_strAction = ""
        End If

        If Request.Form("hidParentIDs") <> "" Then
            m_arrParentMenu = Request.Form("hidParentIDs").Split(CChar(","))
        End If

        If Request.Form("hidRelation") <> "" Then
            m_arrChildMenu = Request.Form("hidRelation").Split(CChar(","))
        End If
    End Sub
    Private Sub ExecuteActions()
        Select Case m_strAction
            Case "SAVE"
                If m_strDashboardID <> "" Then
                    Call SaveTemplateSection()
                End If
                Call SaveDashboardName()
        End Select
    End Sub
    Protected Sub PageInit()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        Call InitializeVariables()
        Call ExecuteActions()
        Call DrawMenu()
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<DIV id=divPage style='OVERFLOW:auto;HEIGHT=500;width=100%'>")
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, "Enhanced Dashboard Configuraion"))
        CommonFunction.General.WriteHTML("<BR>")

        Call DrawDashboardMainTab()

        If m_strDashboardID <> "" Then
            CommonFunction.General.WriteHTML("<BR>")
            Call DrawClientSidePopupMenu()
            CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, "Menu Sections"))
            CommonFunction.General.WriteHTML("<BR>")
            Call DrawTemplateSection()
        End If
        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.General.WriteHTML("<BR>")
        DrawMenu()
    End Sub
    Private Sub DrawDashboardMainTab()
        Dim strDashboardName As String = ""
        Dim dr As IDataReader
        If m_strDashboardID <> "" Then
            strDashboardName = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_DashboardInformation " + m_strDashboardID + ", 0", MyBase.UseSQL), ""), String)
        End If
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=DashboardID value='" + m_strDashboardID + "'>")
        CommonFunction.General.WriteHTML("<TABLE class=clsTable width=100% cellspacing=0 >")
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("Dashboard Name")
        CommonFunction.General.WriteHTML("</TD><TD>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtDBName", "txtDBName", , 300, 200, strDashboardName, IsMandatory:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
    End Sub
    
    Private Sub DrawTemplateSection()
        Dim sbStr As System.Text.StringBuilder
        Dim ParentLevel As Int32, ChildLevel As Int32, SectionID As String, strHiddenValue As String, strHiddenParentValues As String
        strHiddenValue = ""
        strHiddenParentValues = ""
        SectionID = "0"
        Dim drTemp As IDataReader
        Dim drTemp1 As IDataReader
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_sel_DashboardInformation " + m_strDashboardID + ", 2", MyBase.UseSQL)
        CommonFunction.General.WriteHTML("<div id=sectionDiv style='OVERFLOW:auto;width:100%;height:500'>")
        If Not dr.Read Then 'i.e. No sections are configured.
            CommonFunction.General.WriteHTML("<TABLE id=tbl_1 class=clsGridTable cellpadding=0 cellspacing=1 width=100% ><THEAD class='clsTRColumnHeader'><TH width =10% align=left colspan=2>Order #</TH><TH width=20% align=left>Caption</TH><TH width=20% align=left title='Images are expected to be present in [Site Folder]->Images->DB folder.'>Image</TH><TH width=40% align=left>Dashboard/Page URL</TH></THEAD>")
            CommonFunction.General.WriteHTML("<TR class=clsTREven><TD width =10% align = left>")
            CommonFunction.General.WriteHTML("<IMG src=../../Images/TreeNodeImages/user.gif id=firstImg1 onmousedown=showDiv()> ")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtOrderNo_1", "txtOrderNo_1", , 25, 2, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("</TD><td width =10% align = left>-</td><td width =20% align = left>")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtCaption_1", "txtCaption_1", , 150, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("<IMG src=../../Images/TreeNodeImages/delete.gif id=deleteImg1 onmousedown=deleteSection('1')> ")
            CommonFunction.General.WriteHTML("</TD><td width =20% align = left>-</td><td width =40% align = left>-</td>")
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("</TABLE>")
            CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidParentIDs name=hidParentIDs value=1>")
            CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidParent name=hidParent value=1>")
            CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidRelation name=hidRelation value=''>")
        Else
            sbStr = New System.Text.StringBuilder
            sbStr.Append("<TABLE id=tbl_1 class=clsGridTable cellpadding=0 cellspacing=1 width=100% ><THEAD class='clsTRColumnHeader'><TH width=10% align ='left' colspan=2>Order #</TH><TH width = 20% align ='left'>Caption</TH><TH width = 20% align ='left' title='Images are expected to be present in [Site Folder]->Images->DB folder.'>Image</TH><TH width = 40% align ='left'>Dashboard/Page URL</TH></THEAD>")

            drTemp = CommonFunction.Data.GetDataReader("usp_sel_DashboardInformation " + m_strDashboardID + ", 3", MyBase.UseSQL)

            ParentLevel = 1
            While drTemp.Read
                ChildLevel = 1
                SectionID = drTemp("SectionID").ToString
                sbStr.Append("<TR class=clsTREven id = " + ParentLevel.ToString + ">")
                sbStr.Append("<td title=Create Menu/Submenu>")
                sbStr.Append("<IMG src=../../Images/TreeNodeImages/user.gif id=firstImg" + ParentLevel.ToString + " onmousedown=showDiv()> ")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                sbStr.Append(CommonFunction.HTMLControls.DrawTextBox("txtOrderNo_" + ParentLevel.ToString, "txtOrderNo_" + ParentLevel.ToString, , 25, 4, drTemp("OrderNo").ToString, returnHTML:=True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                sbStr.Append("</td><td>-</td><td>")
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                sbStr.Append(CommonFunction.HTMLControls.DrawTextBox("txtCaption_" + ParentLevel.ToString, "txtCaption_" + ParentLevel.ToString, , 150, 100, drTemp("Caption").ToString, returnHTML:=True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                sbStr.Append("<IMG src=../../Images/TreeNodeImages/delete.gif id=deleteImg" + ParentLevel.ToString + " onmousedown=deleteSection('" + ParentLevel.ToString + "')> ")
                sbStr.Append("</td><td>-</td><td>-</td></tr>")

                drTemp1 = CommonFunction.Data.GetDataReader("usp_sel_DashboardInformation " + m_strDashboardID + ", 4," + SectionID, MyBase.UseSQL)
                While drTemp1.Read
                    sbStr.Append("<tr class=clsTREven id=" + ParentLevel.ToString + "_" + ChildLevel.ToString + " ><td></td><TD align=left>")
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    sbStr.Append(CommonFunction.HTMLControls.DrawTextBox("txtOrderNo_" + ParentLevel.ToString + "_" + ChildLevel.ToString, "txtOrderNo_" + ParentLevel.ToString + "_" + ChildLevel.ToString, , 25, 2, drTemp1("OrderNo").ToString, returnHTML:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    sbStr.Append("</td><TD>")
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    sbStr.Append(CommonFunction.HTMLControls.DrawTextBox("txtCaption_" + ParentLevel.ToString + "_" + ChildLevel.ToString, "txtCaption_" + ParentLevel.ToString + "_" + ChildLevel.ToString, , 150, 100, drTemp1("Caption").ToString, returnHTML:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    sbStr.Append("</td><td title='Images are expected to be present in [Site Folder]->Images->DB folder.'>")
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    sbStr.Append(CommonFunction.HTMLControls.DrawTextBox("txtImage_" + ParentLevel.ToString + "_" + ChildLevel.ToString, "txtImage_" + ParentLevel.ToString + "_" + ChildLevel.ToString, , 150, 100, drTemp1("Image").ToString, returnHTML:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    sbStr.Append("</td><td title='Click here to select the Dashboard.'>")
                    'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    sbStr.Append(CommonFunction.HTMLControls.DrawTextBox("txtHref_" + ParentLevel.ToString + "_" + ChildLevel.ToString, "txtHref_" + ParentLevel.ToString + "_" + ChildLevel.ToString, , 280, 200, drTemp1("HRef").ToString, returnHTML:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                    sbStr.Append("<IMG src=../../Images/TreeNodeImages/Lookup.gif id=HrefImg" + ParentLevel.ToString + " onmousedown=OpenPopUp('" + ParentLevel.ToString + "_" + ChildLevel.ToString + "')> ")
                    sbStr.Append("<IMG src=../../Images/TreeNodeImages/delete.gif id=deleteImg" + ParentLevel.ToString + "_" + ChildLevel.ToString + " onmousedown=deleteSection('" + ParentLevel.ToString + "_" + ChildLevel.ToString + "')> ")
                    sbStr.Append("</td></tr>")
                    strHiddenValue = strHiddenValue + ParentLevel.ToString + "_" + ChildLevel.ToString + ","
                    ChildLevel = ChildLevel + 1
                End While
                CommonFunction.Data.DisposeDataReader(drTemp1)
                strHiddenParentValues = strHiddenParentValues + ParentLevel.ToString + ","
                ParentLevel = ParentLevel + 1
            End While
            If strHiddenValue.Trim <> "" Then
                strHiddenValue = strHiddenValue.Substring(0, strHiddenValue.LastIndexOf(","))
            End If
            If strHiddenParentValues.Trim <> "" Then
                strHiddenParentValues = strHiddenParentValues.Substring(0, strHiddenParentValues.LastIndexOf(","))
            End If

            sbStr.Append("</TABLE>")
            CommonFunction.General.WriteHTML(sbStr.ToString)
            CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidParentIDs name=hidParentIDs value=" + strHiddenParentValues.ToString + ">")
            CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidParent name=hidParent value=" + (ParentLevel - 1).ToString + ">")
            CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidRelation name=hidRelation value=" + strHiddenValue + ">")
        End If

        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.Data.DisposeDataReader(drTemp)
        sbStr = Nothing
    End Sub
    Private Sub DrawClientSidePopupMenu()
        CommonFunction.General.WriteHTML("<DIV id=divMenu style='DISPLAY:none;width=200;height=200'>")
        CommonFunction.General.WriteHTML("<TABLE class=clsGridTable cellpadding=0 cellspacing=1>")
        CommonFunction.General.WriteHTML("<TR class=clsTRColumnHeader id=siblTR onmouseover=mouseOnmenu('siblTR') onmousedown=createSibling(this)>")
        CommonFunction.General.WriteHTML("<TD width=100><img src='../../Images/RM/Insert.jpg'>Insert</TD>")
        CommonFunction.General.WriteHTML("</TR><TR class=clsTROdd align=center id=chldTR onmouseover=mouseOnmenu('chldTR') onmousedown=createChild(this)>")
        CommonFunction.General.WriteHTML("<TD><img src='../../Images/RM/Insert_below.jpg'>Insert Below</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")
    End Sub
    Private Sub DrawMenu()
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList

        arrMenu.Add("Save")
        arrMenuToolTip.Add("Save")
        arrCSFunction.Add("Save_Click()")

        arrMenu.Add("Back") 'Appresource
        arrMenuToolTip.Add("Back")
        arrCSFunction.Add("Back_Click()")

        arrMenu.Add("?")
        arrMenuToolTip.Add("?")
        arrCSFunction.Add("Help_OnClick('TCM')")
        CommonFunction.General.WriteHTML(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
    Private Sub SaveTemplateSection()
        Dim strParentMenuID As String = ""
        Dim strParentSeqNum As String = ""
        Dim strSectionID As String
        Dim strCaption As String
        Dim strOrderNo As String
        Dim strImage As String
        Dim strHref As String

        Dim strSQL As String = ""
        Dim Parentcounter As Integer = 0
        Dim Childcounter As Integer = 0
        Dim arrSectionTemplateID As System.Collections.Hashtable = New System.Collections.Hashtable
        Dim con As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(CommonFunctions.General.GetConnectionString())
        Dim cmd As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand
        Dim trans As System.Data.SqlClient.SqlTransaction

        cmd.Connection = con
        con.Open()
        trans = con.BeginTransaction()
        cmd.Transaction = trans
        Try
            'cmd.CommandText = "DELETE FROM tbl_Menu_Settings  WHERE SectionID in (select SectionID from tbl_Menu_Sections where TaGID = (select TagID from tbl_DBMenuSections where DashboardID = " + m_strDashboardID + ")) DELETE FROM tbl_Menu_Sections WHERE TAGID = (select TagID from tbl_DBMenuSections where DashboardID =" + m_strDashboardID + ")"
            cmd.CommandText = "usp_sel_DashboardInformation " + m_strDashboardID + ", 1"
            cmd.ExecuteNonQuery()

            While m_arrParentMenu.Length > Parentcounter
                strParentMenuID = m_arrParentMenu(Parentcounter)
                strCaption = CommonFunction.General.BuildQueryString(Request.Form("txtCaption_" + strParentMenuID))
                strOrderNo = Request.Form("txtOrderNo_" + strParentMenuID)

                strSQL = "usp_ins_MenuSectionsDetails " + m_strDashboardID.ToString + ", 1,'" + strCaption + "'," + strOrderNo.ToString

                cmd.CommandText = strSQL
                strSectionID = CType(cmd.ExecuteScalar(), String)
                If Not m_arrChildMenu Is Nothing Then
                    Childcounter = 0
                    While m_arrChildMenu.Length > Childcounter
                        strSQL = "usp_ins_MenuSectionsDetails "
                        If m_arrChildMenu(Childcounter).Substring(0, m_arrChildMenu(Childcounter).LastIndexOf("_")) = strParentMenuID Then
                            strCaption = CommonFunction.General.BuildQueryString(Request.Form("txtCaption_" + m_arrChildMenu(Childcounter)))
                            strOrderNo = CommonFunction.General.CheckIsNothing(Request.Form("txtOrderNo_" + m_arrChildMenu(Childcounter)), "")
                            strImage = CommonFunction.General.BuildQueryString(Request.Form("txtImage_" + m_arrChildMenu(Childcounter)))
                            strHref = CommonFunction.General.BuildQueryString(Request.Form("txtHref_" + m_arrChildMenu(Childcounter)))

                            strSQL += m_strDashboardID.ToString + ",0,null, null, '" + strCaption + "','" + strOrderNo + "', '" + strImage + "','" + strHref + "'," + strSectionID
                            cmd.CommandText = strSQL
                            cmd.ExecuteScalar()
                        End If
                        Childcounter += 1
                    End While
                End If
                Parentcounter += 1
            End While
            trans.Commit()

        Catch ex As Exception
            trans.Rollback()
        Finally
            con.Close()
            con.Dispose()
            cmd.Dispose()
        End Try

    End Sub
    Private Sub SaveDashboardName()
        Dim strSQL As String = "usp_ins_TagIDForDashboard "
        If m_strDashboardID <> "" Then
            strSQL += m_strDashboardID + ","
        Else
            strSQL += "NULL,"
        End If
        strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form("txtDBName")) + "'"

        m_strDashboardID = CType(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), String)
    End Sub
End Class