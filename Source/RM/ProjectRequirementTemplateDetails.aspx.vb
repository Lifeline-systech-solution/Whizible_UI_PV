Public Class ProjectRequirementTemplateDetails
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
        MyBase.ApplySecurity(True)
        InitializeComponent()
    End Sub

#End Region

    Public HTMLStr1 As String = ""
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

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

        If Request.Form("hidHTMLStr") <> "" Then
            HTMLStr1 = Request.Form("hidHTMLStr")
            PrintWordDoc()
        Else
            CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectID id=hidProjectID value=" + strProjectID + ">")
            CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")
        End If

    End Sub
    Protected Sub PageInit()
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.ProjectRequirementDetails", "AppResources")
        InitializeVariables()
        If Request.Form("hidHTMLStr") = "" Then
            DrawMenu()
        End If

        CommonFunction.General.WriteHTML("<div id=sectionDiv style='OVERFLOW:auto;width:100%;height=400'>")
        CommonFunction.General.WriteHTML("</DIV>")

        If Request.Form("hidHTMLStr") = "" Then
            DrawMenu()
        End If
    End Sub

    Protected Sub DrawTreeTemplateSection()
        Dim dr As IDataReader
        Dim c As Integer = 1
        Dim strCounter As String
        Dim strToHold As String
        CommonFunction.General.WriteHTML("var Tree = new Array()")
        dr = CommonFunction.Data.GetDataReader("usp_Sel_ProjectRequirementTemplateSectionDetails " + strProjectID, MyBase.UseSQL)
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
            CommonFunction.General.WriteHTML("Tree[0][7]='" + dr("IsNewRequirement").ToString + "'")
            CommonFunction.General.WriteHTML("Tree[0][8]='" + dr("ReqTitle").ToString + "'")
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
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][7]='" + dr("IsNewRequirement").ToString + "'")
                CommonFunction.General.WriteHTML("Tree[" + strCounter + "][8]='" + dr("ReqTitle").ToString + "'")
                c += 1
            End While
        End If
        CommonFunction.General.WriteHTML("")

        CommonFunction.Data.DisposeDataReader(dr)
    End Sub

    Private Sub DrawMenu()
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList

        arrMenu.Add("Export to Word")
        arrMenuToolTip.Add("Export to Word")
        arrCSFunction.Add("ExportToWord_Onclick()")

        arrMenu.Add("Close")
        arrMenuToolTip.Add("Close")
        arrCSFunction.Add("Close_OnClick()")

        arrMenu.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTip.Add("Help")
        arrCSFunction.Add("Help_OnClick('RM_PRJ_TEMP')")

        CommonFunction.General.WriteHTML("<DIV id=divMenu style='DISPLAY:none;width=200;height=200'>")
        CommonFunction.General.WriteHTML("</DIV>")

        CommonFunction.General.WriteHTML("<Table id=tblMenuB class=clsTable cellspacing=0 cellpadding=0 width='99.9%'><TR class=clsTRMenu>")
        CommonFunction.General.WriteHTML("<TD align=Right>")

        CommonFunction.General.WriteHTML(" <A class='Menu' style='' HREF=""Javascript:" + CType(arrCSFunction(0), String) + """ Title=""" + CType(arrMenuToolTip(0), String) + """ >" + CType(arrMenu(0), String) + "</A>")
        CommonFunction.General.WriteHTML(" | <A class='Menu' style='' HREF=""Javascript:" + CType(arrCSFunction(1), String) + """ Title=""" + CType(arrMenuToolTip(1), String) + """ >" + CType(arrMenu(1), String) + "</A>")
        CommonFunction.General.WriteHTML(" | <A class='Menu' style='' HREF=""Javascript:" + CType(arrCSFunction(2), String) + """ Title=""" + CType(arrMenuToolTip(2), String) + """ >" + CType(arrMenu(2), String) + "</A>")
        CommonFunction.General.WriteHTML(" </TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE>")
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
    Protected Sub PrintWordDoc()

        Dim strBody As New System.Text.StringBuilder("")

        strBody.Append("<html " & _
                "xmlns:o='urn:schemas-microsoft-com:office:office' " & _
                "xmlns:w='urn:schemas-microsoft-com:office:word'" & _
                "xmlns='http://www.w3.org/TR/REC-html40'>" & _
                "<head><title>Time</title>")

        'The setting specifies document's view after it is downloaded as Print instead of the default Web Layout
        strBody.Append("<!--[if gte mso 9]>" & _
                                 "<xml>" & _
                                 "<w:WordDocument>" & _
                                 "<w:View>Print</w:View>" & _
                                 "<w:Zoom>90</w:Zoom>" & _
                                 "<w:DoNotOptimizeForBrowser/>" & _
                                 "</w:WordDocument>" & _
                                 "</xml>" & _
                                 "<![endif]-->")

        strBody.Append("<style>" & _
                                "<!-- /* Style Definitions */" & _
                                "@page Section1" & _
                                "   {size:8.5in 11.0in; " & _
                                "   margin:1.0in 1.25in 1.0in 1.25in ; " & _
                                "   mso-header-margin:.5in; " & _
                                "   mso-footer-margin:.5in; mso-paper-source:0;}" & _
                                " div.Section1" & _
                                "   {page:Section1;}" & _
                                "-->" & _
                               "</style></head>")

        strBody.Append("<body lang=EN-US style='tab-interval:.5in'>" & _
                                "<div class=Section1><font face='Verdana' size=10><pre>" & HTMLStr1 & "</pre></font></div></body></html>")

        'Force this content to be downloaded as a Word document with the name of your choice
        Response.AppendHeader("Content-Type", "application/msword")
        Response.AppendHeader("Content-disposition", _
                               "attachment; filename=ProjectRequirementTemplates.doc")
        Response.Clear()
        Response.Write(strBody)
    End Sub

End Class
