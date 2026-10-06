Public Class RM_ProjectRequirementTemplates
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
    Private m_arrSectionNums As String()
    Private m_strRMTemplateID As String
    Private m_strAction As String
    Private m_strProjectID As String
#End Region


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Private Sub InitializeVariables()
        m_strProjectID = Request.QueryString("ProjectID")
        If Request.Form("hidProjectID") <> "" Then
            m_strProjectID = Request.Form("hidProjectID")
        End If
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")

        If Request.QueryString("RMTemplateID") <> "" Then
            m_strRMTemplateID = Request.QueryString("RMTemplateID")
        ElseIf Request.Form("RMTemplateID") <> "" Then
            m_strRMTemplateID = Request.Form("RMTemplateID")
        Else
            m_strRMTemplateID = ""
        End If

        If Request.QueryString("Action") <> "" Then
            m_strAction = Request.QueryString("Action").ToUpper
        Else
            m_strAction = ""
        End If

        CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidSectionNums name=hidSectionNums value=''>")
        If Request.Form("hidSectionNums") <> "" Then
            m_arrSectionNums = Request.Form("hidSectionNums").Split(CChar(","))
        Else
            m_arrSectionNums = "".Split(CChar(","))
        End If


    End Sub
    Private Sub ExecuteActions()

        Select Case m_strAction
            Case "SAVE"
                If m_strRMTemplateID <> "" Then
                    Call SaveTemplateSection()
                End If
                Call SaveRMTemplate()


        End Select


    End Sub
    Protected Sub PageInit()
        MyBase.InitializeResources("AppResources.RM_RequirementTemplates", "AppResources")

        Call InitializeVariables()
        Call ExecuteActions()

        Call DrawMenu()
        CommonFunction.General.WriteHTML("<BR>")
        'CommonFunction.General.WriteHTML("<DIV id=divPage style='OVERFLOW:auto;HEIGHT=500;width=100%'>")

        'CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("LBL_TEST_EXECUTION"), "Test Session: " + CType(CommonFunction.Data.GetDataScalar("SELECT Title FROM tbl_TCM_TestSession WHERE TestSessionID=" + m_strTestSessionID, MyBase.UseSQL), String)))
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, "Requirement Template"))
        CommonFunction.General.WriteHTML("<BR>")


        Call DrawRequiementTemplate()

        If m_strRMTemplateID <> "" Then
            CommonFunction.General.WriteHTML("<BR>")
            Call DrawClientSidePopupMenu()
            CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("LBL_PAGECAPTION"))) ''Appresource
            CommonFunction.General.WriteHTML("<BR>")
            Call DrawTemplateSection()
        Else
            CommonFunction.General.WriteHTML("<div style='height:400'></div>")
        End If


        'CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.General.WriteHTML("<BR>")
        DrawMenu()
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub
    Private Sub DrawRequiementTemplate()
        Dim strTemplateTitle As String = ""
        Dim strTemplateCode As String = ""
        Dim dr As IDataReader
        If m_strRMTemplateID <> "" Then
            dr = CommonFunction.Data.GetDataReader("Select RMTemplateTitle,RMCodeTemplate FROM tbl_RM_ProjectRequirementTemplate WHERE RMTemplateID=" + m_strRMTemplateID, MyBase.UseSQL)
            If dr.Read Then
                strTemplateTitle = dr("RMTemplateTitle").ToString
                strTemplateCode = dr("RMCodeTemplate").ToString
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.General.WriteHTML("<TABLE class=clsTable width=100% cellspacing=0 >")
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")

        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=RMTemplateID value='" + m_strRMTemplateID + "'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEMPLATETITLE")) ''Appresource
        CommonFunction.General.WriteHTML("</TD><TD>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtTemplateTitle", "txtTemplateTitle", , 400, 1000, strTemplateTitle, IsMandatory:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        If m_strRMTemplateID <> "" Then
            CommonFunction.HTMLControls.DrawComboBox("cboAllTemplateTitles", "SELECT RMTemplateTitle,RMTemplateTitle FROM tbl_RM_ProjectRequirementTemplate WHERE ProjectID = " + m_strProjectID + " AND RMTemplateID <> " + m_strRMTemplateID, , , "STYLE='DISPLAY:none'")
        Else
            CommonFunction.HTMLControls.DrawComboBox("cboAllTemplateTitles", "SELECT RMTemplateTitle,RMTemplateTitle FROM tbl_RM_ProjectRequirementTemplate WHERE ProjectID = " + m_strProjectID, , , "STYLE='DISPLAY:none'")
        End If

        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        'Right now Template Code is not shown
        'CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        'CommonFunction.General.WriteHTML("<TD align=right>")
        'CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEMPLATECODE")) 'Appresource
        'CommonFunction.General.WriteHTML("</TD>")
        'CommonFunction.General.WriteHTML("<TD>")
        'CommonFunction.HTMLControls.DrawTextBox("txtTemplateCode", "txtTemplateCode", , 200, 500, strTemplateCode, isMandatory:=True)
        'CommonFunction.General.WriteHTML("</TD>")
        'CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("</TABLE>")

    End Sub
    Private Sub DrawTemplateSection()

        CommonFunction.General.WriteHTML("<table class=clsTable width=100% height=380 cellspacing=0 cellpadding=0>")
        CommonFunction.General.WriteHTML("<tr class=clsTREven >")
        CommonFunction.General.WriteHTML("<td></td></tr>")
        CommonFunction.General.WriteHTML("<tr class=clsTREven >")

        CommonFunction.General.WriteHTML("<td align=center width=100% height=320px >")
        CommonFunction.General.WriteHTML("<div id=sectionDiv style='OVERFLOW:auto;width:90%;height=100%'>")

        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("SELECT TOP 1 * FROM tbl_RM_ProjectTemplateSection WHERE RMTemplateID = " + m_strRMTemplateID + " ORDER BY RMTemplateSectionID", MyBase.UseSQL)
        If Not dr.Read Then
            CommonFunction.General.WriteHTML("<TABLE id=tbl_1 class=clsGridTable cellpadding=0 cellspacing=0 width=100% >")
            CommonFunction.General.WriteHTML("<THEAD class='clsTRColumnHeader'><TH colspan=2 align=left>" + MyBase.GetResourceString("LBL_SECTITLE") + "</TH></THEAD>")
            CommonFunction.General.WriteHTML("<TR class=clsTREven style='BACKGROUND-COLOR: white'>")
            CommonFunction.General.WriteHTML("<TD align=right>1</TD>")
            CommonFunction.General.WriteHTML("<TD>")
            'CommonFunction.HTMLControls.DrawTextBox("txt", "txt", , 500)
            CommonFunction.General.WriteHTML("<Input  Type=Textbox  name='txt' id='txt' class='clsTextBox' style='width:500px;text-align:Left;border-top:black 1px solid;border-left:black 1px solid;border-bottom:black 1px solid;border-right:black 1px solid' value=''  >")
            CommonFunction.General.WriteHTML("<IMG src=../../Images/TreeNodeImages/user.gif id=firstImg > ")
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("</TABLE>")
        End If

        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr class=clsTREven style='height:20'>")
        CommonFunction.General.WriteHTML("<td></td><tr>")
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.Data.DisposeDataReader(dr)

    End Sub
    Private Sub DrawMenu()
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList

        arrMenu.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrCSFunction.Add("Save_Click()")

        arrMenu.Add(MyBase.GetResourceString("MENU_BACK")) 'Appresource
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_BACK"))
        arrCSFunction.Add("Back_Click()")

        arrMenu.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP"))
        arrCSFunction.Add("Help_OnClick('RM_SM_TEMP')")
        CommonFunction.General.WriteHTML(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))

    End Sub
    Private Sub DrawClientSidePopupMenu()

        CommonFunction.General.WriteHTML("<DIV id=divMenu style='DISPLAY:none;width=200;height=200'>")
        CommonFunction.General.WriteHTML("<TABLE class=clsGridTable cellpadding=0 cellspacing=1>")
        CommonFunction.General.WriteHTML("<TR class=clsTRColumnHeader id=siblTR onmouseover=mouseOnmenu('siblTR') onmousedown=createSibling()>")
        CommonFunction.General.WriteHTML("<TD width=100 ><img src='../../Images/RM/Insert.jpg'>" + MyBase.GetResourceString("MENU_SIBLING") + "</TD>") 'Appresource
        CommonFunction.General.WriteHTML("</TR><TR class=clsTROdd id=chldTR onmouseover=mouseOnmenu('chldTR') onmousedown=createChild()>")
        CommonFunction.General.WriteHTML("<TD><img src='../../Images/RM/Insert_below.jpg'>" + MyBase.GetResourceString("MENU_CHILD") + "</TD>") 'Appresource
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")

    End Sub
    Protected Sub DrawTreeTemplateSection()
        Dim dr As IDataReader
        Dim c As Integer = 1
        Dim strCounter As String
        CommonFunction.General.WriteHTML("var Tree = new Array()")
        dr = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_RM_ProjectTemplateSection WHERE RMTemplateID = 0" + m_strRMTemplateID + " ORDER BY OrderNumber", MyBase.UseSQL)
        If dr.Read Then
            CommonFunction.General.WriteHTML("Tree[0]=new Array()")
            CommonFunction.General.WriteHTML("Tree[0][0]=" + dr("RMTemplateSectionID").ToString)
            CommonFunction.General.WriteHTML("Tree[0][1]='" + dr("SectionTitle").ToString.Replace("'", "\'") + "'")
            CommonFunction.General.WriteHTML("Tree[0][2]='" + dr("SectionNumber").ToString + "'")
            CommonFunction.General.WriteHTML("Tree[0][3]='" + dr("ParentTemplateSectionID").ToString + "'")
            CommonFunction.General.WriteHTML("Tree[0][4]='tbl_1'")
            CommonFunction.General.WriteHTML("Tree[0][5]=2")

            While dr.Read
                strCounter = c.ToString()
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "]=new Array()")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][0]=" + dr("RMTemplateSectionID").ToString)
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][1]='" + dr("SectionTitle").ToString.Replace("'", "\'") + "'")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][2]='" + dr("SectionNumber").ToString + "'")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][3]='" + dr("ParentTemplateSectionID").ToString + "'")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][4]=''")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][5]=-1")
                c += 1
            End While
        End If
        CommonFunction.General.WriteHTML("")

        CommonFunction.Data.DisposeDataReader(dr)
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub SaveTemplateSection()
        Dim strSeqNum As String = ""
        Dim strParentSeqNum As String = ""
        Dim strSectionTemplateID As String
        Dim strSQL As String
        Dim counter As Integer = 0
        Dim arrSectionTemplateID As System.Collections.Hashtable = New System.Collections.Hashtable
        Dim con As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(CommonFunctions.General.GetConnectionString())
        Dim cmd As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand
        Dim trans As System.Data.SqlClient.SqlTransaction

        cmd.Connection = con
        con.Open()
        trans = con.BeginTransaction()
        cmd.Transaction = trans
        Try

            If m_arrSectionNums.Length > 0 Then
                cmd.CommandText = "DELETE FROM tbl_RM_ProjectTemplateSection  WHERE RMTemplateID = " + m_strRMTemplateID + " AND SectionNumber NOT IN ('" + Request.Form("hidSectionNums").Replace(",", "','") + "')"
                cmd.ExecuteNonQuery()
            End If

            While m_arrSectionNums.Length > counter
                strSQL = "usp_InsUpd_tbl_RM_ProjectTemplateSection " + m_strRMTemplateID + "," + m_strProjectID + ","
                strSeqNum = m_arrSectionNums(counter)
                If strSeqNum.LastIndexOf(".") = -1 Then
                    'Section does not have parent. Its a single digit
                    'strSectionTemplateID = GetScalar(insert)

                    strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form(m_arrSectionNums(counter))) + "','" + strSeqNum + "',NULL"
                    strSQL += "," + (counter + 1).ToString
                    'strSectionTemplateID = CType(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), String)
                    cmd.CommandText = strSQL
                    strSectionTemplateID = CType(cmd.ExecuteScalar(), String)
                    arrSectionTemplateID.Add(strSeqNum, strSectionTemplateID)

                Else

                    strParentSeqNum = strSeqNum.Substring(0, strSeqNum.LastIndexOf("."))
                    strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form(m_arrSectionNums(counter))) + "','" + strSeqNum + "'," + CType(arrSectionTemplateID.Item(strParentSeqNum), String)
                    strSQL += "," + (counter + 1).ToString
                    cmd.CommandText = strSQL
                    strSectionTemplateID = CType(cmd.ExecuteScalar(), String)
                    arrSectionTemplateID.Add(strSeqNum, strSectionTemplateID)

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

    End Sub
    Private Sub SaveRMTemplate()
        Dim strSQL As String = "usp_InsUpd_tbl_RM_ProjectRequirementTemplate "
        If m_strRMTemplateID <> "" Then
            strSQL += m_strRMTemplateID + "," + m_strProjectID + ","
        Else
            strSQL += "NULL," + m_strProjectID + ","
        End If
        strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form("txtTemplateTitle")) + "',"
        'strSQL += "'" + CommonFunction.General.BuildQueryString(Request.Form("txtTemplateCode")) + "'"
        strSQL += "NULL"
        m_strRMTemplateID = CType(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), String)


    End Sub
End Class
