Public Class ProjectRequirementDetails
    Inherits WebPages.Template.WhizTemplate
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents FreeTextBox1 As FreeTextBoxControls.FreeTextBox
    Protected WithEvents HyperLink1 As System.Web.UI.WebControls.HyperLink

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

    End Sub
#Region "Variables"
    Private m_strProjectRequirementID As String
    Private m_strProjectRMTemplateID As String
    Private strProjectID As String

#End Region
    Private Sub InitializeVariables()
        strProjectID = Request.QueryString("ProjectID")
        If Request.Form("hidProjectID") <> "" Then
            strProjectID = Request.Form("hidProjectID")
        End If
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectID id=hidProjectID value=" + strProjectID + ">")
        If Request.QueryString("ProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.QueryString("ProjectRequirementID")
        ElseIf Request.Form("hidProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.Form("hidProjectRequirementID")
        Else
            Response.End()
        End If
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")
        If Request.Form("cboRMTemplate") = "" Then
            m_strProjectRMTemplateID = CType(CommonFunction.Data.GetDataScalar("SELECT ISNULL(ProjectRMTemplateID,0) FROM tbl_RM_ProjectRequirements WHERE ProjectRequirementID = " + m_strProjectRequirementID, MyBase.UseSQL), String)
        Else
            m_strProjectRMTemplateID = Request.Form("cboRMTemplate")
        End If

    End Sub
    Protected Sub PageInit()
        MyBase.InitializeResources("AppResources.ProjectRequirementDetails", "AppResources")
        InitializeVariables()
        ExecuteActions()
        RM_CommonFunction.Genereal.DrawRequirementHeaderNavigation("Details", m_strProjectRequirementID, strProjectID)
        DrawMenu("U")

        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<Table class=clsTable width=100% cellspacing=0 cellpadding=0>")
        CommonFunction.General.WriteHTML("<tr class=clsTRPageCaption>")



        CommonFunction.General.WriteHTML("<td align=center>" + MyBase.GetResourceString("LBL_REQUIREMENT_TEMPLATE"))  ''Appresource 

        If m_strProjectRMTemplateID = "0" Then
            CommonFunction.HTMLControls.DrawComboBox("cboRMTemplate", "usp_Sel_tbl_RM_ProjectRequirementTemplate " + strProjectID, , m_strProjectRMTemplateID, isMandatory:=True)
        Else
            CommonFunction.HTMLControls.DrawComboBox("cboRMTemplate", "usp_Sel_tbl_RM_ProjectRequirementTemplate " + strProjectID, , m_strProjectRMTemplateID, " disabled ", isMandatory:=True)
        End If
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")
        If m_strProjectRMTemplateID <> "0" Then
            CommonFunction.General.WriteHTML("<BR>")
            DrawTemplateSection()
        Else
            CommonFunction.General.WriteHTML("<div id=sectionDiv style='OVERFLOW:auto;width:100%;height=380'></DIV>")
        End If


        CommonFunction.General.WriteHTML("<BR>")
        DrawMenu("B")
        DrawClientSidePopupMenu()
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub
    Private Sub DrawTemplateSection()
        'CommonFunction.General.WriteHTML("<table class=clsTable width=100% height=380 cellspacing=0 cellpadding=0>")
        'CommonFunction.General.WriteHTML("<tr class=clsTREven >")
        'CommonFunction.General.WriteHTML("<td></td></tr>")
        'CommonFunction.General.WriteHTML("<tr class=clsTREven >")

        'CommonFunction.General.WriteHTML("<td align=center width=100% height=320px >")
        CommonFunction.General.WriteHTML("<div id=sectionDiv style='OVERFLOW:auto;width:100%;height=400'>")

        CommonFunction.General.WriteHTML("</DIV>")
        'CommonFunction.General.WriteHTML("</td>")

        'CommonFunction.General.WriteHTML("</tr>")
        'CommonFunction.General.WriteHTML("<tr class=clsTREven style='height:20'>")
        'CommonFunction.General.WriteHTML("<td></td><tr>")
        'CommonFunction.General.WriteHTML("</table>")
    End Sub
    Protected Sub DrawTreeTemplateSection()
        Dim dr As IDataReader
        Dim c As Integer = 1
        Dim strCounter As String
        Dim strToHold As String
        CommonFunction.General.WriteHTML("var Tree = new Array()")
        dr = CommonFunction.Data.GetDataReader("usp_Sel_ProjectRequirementSectionDetails " + m_strProjectRequirementID, MyBase.UseSQL)
        If dr.Read Then
            CommonFunction.General.WriteHTML("Tree[0]=new Array()")
            CommonFunction.General.WriteHTML("Tree[0][0]=" + dr("ProjectRequirementSectionID").ToString)
            CommonFunction.General.WriteHTML("Tree[0][1]='" + dr("SectionTitle").ToString.Replace("'", "\'") + "'")
            CommonFunction.General.WriteHTML("Tree[0][2]='" + dr("SectionNumber").ToString + "'")
            CommonFunction.General.WriteHTML("Tree[0][3]='" + dr("ParentProjectRequirementSectionID").ToString + "'")
            CommonFunction.General.WriteHTML("Tree[0][4]='tbl_1'")
            CommonFunction.General.WriteHTML("Tree[0][5]=2")
            strToHold = dr("Details").ToString.Replace("\", "\\").Replace("'", "\'").Replace(Chr(10), "\n").Replace(Chr(13), "")
            CommonFunction.General.WriteHTML("Tree[0][6]='" + strToHold + "'")
            While dr.Read
                strCounter = c.ToString()
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "]=new Array()")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][0]=" + dr("ProjectRequirementSectionID").ToString)
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][1]='" + dr("SectionTitle").ToString.Replace("'", "\'") + "'")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][2]='" + dr("SectionNumber").ToString + "'")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][3]='" + dr("ParentProjectRequirementSectionID").ToString + "'")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][4]=''")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][5]=-1")
                strToHold = dr("Details").ToString.Replace("\", "\\").Replace("'", "\'").Replace(Chr(10), "\n").Replace(Chr(13), "")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][6]='" + strToHold + "'")
                c += 1
            End While
        End If
        CommonFunction.General.WriteHTML("")

        CommonFunction.Data.DisposeDataReader(dr)
    End Sub
    Private Sub DrawClientSidePopupMenu()

        CommonFunction.General.WriteHTML("<DIV id=divMenu style='DISPLAY:none;width=200;height=200'>")
        CommonFunction.General.WriteHTML("<TABLE class=clsGridTable cellpadding=0 cellspacing=1>")

        CommonFunction.General.WriteHTML("<TR class=clsTRColumnHeader id=editTR onmouseover=mouseOnmenu('editTR') onmousedown=showSectionTextBox()>")
        CommonFunction.General.WriteHTML("<TD width=100 ><img src='../../Images/RM/Insert.gif'>" + MyBase.GetResourceString("MENU_EDIT") + "</TD>") 'Appresource
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class=clsTROdd id=siblTR onmouseover=mouseOnmenu('siblTR') onmousedown=createSibling()>")
        CommonFunction.General.WriteHTML("<TD width=100 ><img src='../../Images/RM/Insert.gif'>" + MyBase.GetResourceString("MENU_SIBLING") + "</TD>") 'Appresource
        CommonFunction.General.WriteHTML("</TR><TR class=clsTROdd id=chldTR onmouseover=mouseOnmenu('chldTR') onmousedown=createChild()>")
        CommonFunction.General.WriteHTML("<TD><img src='../../Images/RM/Insert_below.gif'>" + MyBase.GetResourceString("MENU_CHILD") + "</TD>") 'Appresource
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class=clsTROdd id=deleteTR onmouseover=mouseOnmenu('deleteTR') onmousedown=deleteSection()>")
        CommonFunction.General.WriteHTML("<TD width=100 ><img src='../../Images/RM/Delete.gif'>" + MyBase.GetResourceString("MENU_DELETE") + "</TD>") 'Appresource
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")

    End Sub
    Private Sub ExecuteActions()
        If Request.QueryString("Mode") = "SAVE" Then
            Save_ProjectRequirements_RMTemplateID()
        ElseIf Request.QueryString("Mode") = "XMLHTTP" Then
            If Request.QueryString("SaveSectionAndDetails") = "TRUE" Then
                SaveSectionsAndDetails()
            End If

        End If
    End Sub
    Private Sub Save_ProjectRequirements_RMTemplateID()
        If Request.Form("cboRMTemplate") <> "" Then
            CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_RM_ProjectRequirements_RMTemplateID " + m_strProjectRequirementID + "," + m_strProjectRMTemplateID, MyBase.UseSQL)

        End If
    End Sub


    Private Sub SaveSectionsAndDetails()

        Dim strSeqNum As String = ""
        Dim strParentSeqNum As String = ""
        Dim strProjectRequirementSectionID As String
        Dim strSQL As String
        Dim counter As Integer = 0
        Dim arrSectionTemplateID As System.Collections.Hashtable = New System.Collections.Hashtable

        Dim con As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(CommonFunctions.General.GetConnectionString())
        Dim cmd As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand
        Dim trans As System.Data.SqlClient.SqlTransaction
        Dim m_arrSectionNums As String()

        If Request.Form("hidSectionNums") <> "" Then
            m_arrSectionNums = Request.Form("hidSectionNums").Split(CChar(","))

        Else
            m_arrSectionNums = "".Split(CChar(","))
        End If

        cmd.Connection = con
        con.Open()
        trans = con.BeginTransaction()
        cmd.Transaction = trans
        Try
            'CommonFunction.Data.InsertOrUpdateData("DELETE FROM tbl_RM_TemplateSection  WHERE RMTemplateID = " + m_strRMTemplateID, MyBase.UseSQL)
            If m_arrSectionNums.Length > 0 Then
                'cmd.CommandText = "DELETE FROM tbl_RM_ProjectRequirementSections  WHERE ProjectRequirementID = " + m_strProjectRequirementID
                'cmd.ExecuteNonQuery()
                'cmd.CommandText = "DELETE FROM tbl_RM_ProjectRequirementSectionDetails  WHERE ProjectRequirementID = " + m_strProjectRequirementID
                'cmd.ExecuteNonQuery()
                cmd.CommandText = "usp_Del_tbl_RM_ProjectRequirementSectionsAndDetails " + m_strProjectRequirementID + ",'''" + Request.Form("hidSectionNums").Replace(",", "'',''") + "'''"
                cmd.ExecuteNonQuery()
            End If

            While m_arrSectionNums.Length > counter
                strSQL = "usp_InsUpd_tbl_RM_ProjectRequirementSections " + m_strProjectRequirementID + ","
                strSeqNum = m_arrSectionNums(counter)
                If strSeqNum.LastIndexOf(".") = -1 Then
                    'Section does not have parent. Its a single digit
                    'strSectionTemplateID = GetScalar(insert)

                    strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form(m_arrSectionNums(counter))) + "','" + strSeqNum + "',NULL"
                    strSQL += "," + (counter + 1).ToString

                    cmd.CommandText = strSQL
                    strProjectRequirementSectionID = CType(cmd.ExecuteScalar(), String)
                    arrSectionTemplateID.Add(strSeqNum, strProjectRequirementSectionID)
                    '''For addition of details /html
                    strSQL = "usp_InsUpd_tbl_RM_ProjectRequirementSectionDetails " + m_strProjectRequirementID + "," + strProjectRequirementSectionID + ","
                    strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form("Deta" + m_arrSectionNums(counter))) + "'"
                    cmd.CommandText = strSQL
                    cmd.ExecuteNonQuery()
                    ''End of addition of details /html

                Else

                    strParentSeqNum = strSeqNum.Substring(0, strSeqNum.LastIndexOf("."))
                    strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form(m_arrSectionNums(counter))) + "','" + strSeqNum + "'," + CType(arrSectionTemplateID.Item(strParentSeqNum), String)
                    strSQL += "," + (counter + 1).ToString
                    cmd.CommandText = strSQL
                    strProjectRequirementSectionID = CType(cmd.ExecuteScalar(), String)
                    arrSectionTemplateID.Add(strSeqNum, strProjectRequirementSectionID)

                    '''For addition of details /html
                    strSQL = "usp_InsUpd_tbl_RM_ProjectRequirementSectionDetails " + m_strProjectRequirementID + "," + strProjectRequirementSectionID + ","
                    strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form("Deta" + m_arrSectionNums(counter))) + "'"
                    cmd.CommandText = strSQL
                    cmd.ExecuteNonQuery()
                    ''End of addition of details /html


                End If
                counter += 1
            End While
            trans.Commit()

        Catch ex As Exception
            trans.Rollback()

        Finally

            con.Close()
            con.Dispose()
            cmd.Dispose()
        End Try
        Response.Clear()
        Response.End()


    End Sub
    Private Sub DrawMenu(ByVal strWhich As String)
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList


        arrMenu.Add("Show History")
        arrMenuToolTip.Add("Show History")
        arrCSFunction.Add("History_Click()")



        arrMenu.Add(MyBase.GetResourceString("MENU_VIEW"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_VIEW"))
        arrCSFunction.Add("View_Click()")

        arrMenu.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrCSFunction.Add("Save_Click()")

        arrMenu.Add("Close")
        arrMenuToolTip.Add("Close")
        arrCSFunction.Add("Close_OnClick()")

        arrMenu.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTip.Add("Help")
        arrCSFunction.Add("Help_OnClick('RM_SM_TEMP')")


        If strWhich = "U" Then
            CommonFunction.General.WriteHTML("<Table id=tblMenuU class=clsTable cellspacing=0 cellpadding=0 width='99.9%'><TR class=clsTRMenu>")
            CommonFunction.General.WriteHTML("<td>")
            CommonFunction.General.WriteHTML("Requirement:&nbsp;" + CType(CommonFunction.Data.GetDataScalar("SELECT ReqTitle FROM Tbl_RM_ProjectRequirements WHERE ProjectRequirementID = " + m_strProjectRequirementID, MyBase.UseSQL), String))
            CommonFunction.General.WriteHTML("</td>")
        Else
            CommonFunction.General.WriteHTML("<DIV id=divMenuB>")
            CommonFunction.General.WriteHTML("<Table id=tblMenuB class=clsTable cellspacing=0 cellpadding=0 width='99.9%'><TR class=clsTRMenu>")
        End If

        CommonFunction.General.WriteHTML("<TD align=Right>")
        If m_strProjectRMTemplateID <> "0" Then
            CommonFunction.General.WriteHTML(" | <A class='Menu' style='' HREF=""Javascript:" + CType(arrCSFunction(0), String) + """ Title=""" + CType(arrMenuToolTip(0), String) + """ >" + CType(arrMenu(0), String) + "</A>")
        End If
        CommonFunction.General.WriteHTML(" |  <A class='Menu' style='' HREF=""Javascript:" + CType(arrCSFunction(1), String) + """ Title=""" + CType(arrMenuToolTip(1), String) + """ >" + CType(arrMenu(1), String) + "</A>")
        CommonFunction.General.WriteHTML(" | <A class='Menu' style='' HREF=""Javascript:" + CType(arrCSFunction(2), String) + """ Title=""" + CType(arrMenuToolTip(2), String) + """ >" + CType(arrMenu(2), String) + "</A>")
        CommonFunction.General.WriteHTML(" | <A class='Menu' style='' HREF=""Javascript:" + CType(arrCSFunction(3), String) + """ Title=""" + CType(arrMenuToolTip(3), String) + """ >" + CType(arrMenu(3), String) + "</A>")
        CommonFunction.General.WriteHTML(" | <A class='Menu' style='' HREF=""Javascript:" + CType(arrCSFunction(4), String) + """ Title=""" + CType(arrMenuToolTip(4), String) + """ >" + CType(arrMenu(4), String) + "</A>")
        CommonFunction.General.WriteHTML(" |</TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE>")

        If strWhich <> "U" Then
            CommonFunction.General.WriteHTML("<DIV>")
        End If

        'CommonFunction.General.WriteHTML(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
End Class
