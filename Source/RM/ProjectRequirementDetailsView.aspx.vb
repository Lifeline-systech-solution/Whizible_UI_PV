Public Class ProjectRequirementDetailsView
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
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

    End Sub
#Region "Variables"
    Private m_strProjectRequirementID As String
    Private m_strProjectRMTemplateID As String

#End Region
    Private Sub InitializeVariables()
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

        CommonFunction.General.WriteHTML("<Table id=tblMenuU class=clsTable cellspacing=0 cellpadding=0 width='99.9%'><TR class=clsTRMenu>")
        CommonFunction.General.WriteHTML("<TD align=Right> | <A class='Menu' style='' HREF=""Javascript:Print_Click()"" Title=""Print"" >Print</A> | <A class='Menu' style='' HREF=""Javascript:Close_OnClick()"" Title=""Close"" >Close</A> | </TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE>")
        CommonFunction.General.WriteHTML("<BR>")
        DrawRequirementDetails()

        If m_strProjectRMTemplateID <> "0" Then
            CommonFunction.General.WriteHTML("<BR>")
            DrawTemplateSection()
        Else
            CommonFunction.General.WriteHTML("<div id=sectionDiv style='OVERFLOW:auto;width:100%;height=380'></DIV>")
        End If
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<Table id=tblMenuB class=clsTable cellspacing=0 cellpadding=0 width='99.9%'><TR class=clsTRMenu>")
        CommonFunction.General.WriteHTML("<TD align=Right> | <A class='Menu' style='' HREF=""Javascript:Print_Click()"" Title=""Print"" >Print</A> | <A class='Menu' style='' HREF=""Javascript:Close_OnClick()"" Title=""Close"" >Close</A> |  </TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE>")
    End Sub
    Private Sub DrawTemplateSection()
        
        CommonFunction.General.WriteHTML("<div id=sectionDiv style='OVERFLOW:auto;width:100%;height=400'>")

        CommonFunction.General.WriteHTML("</DIV>")
        
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
    
    
    Private Sub DrawRequirementDetails()
        Dim dr As IDataReader
        CommonFunction.General.WriteHTML("<style>")
        CommonFunction.General.WriteHTML(".trWhiteCss {")
        CommonFunction.General.WriteHTML("padding-right: 2pt;")
        CommonFunction.General.WriteHTML("padding-left: 2pt;")
        CommonFunction.General.WriteHTML("font-size: 8pt;")
        CommonFunction.General.WriteHTML("padding-bottom: 2pt;")
        CommonFunction.General.WriteHTML("margin: 2pt;")
        CommonFunction.General.WriteHTML("color: #000000;")
        CommonFunction.General.WriteHTML("padding-top: 2pt;")
        CommonFunction.General.WriteHTML("background-repeat: repeat;")
        CommonFunction.General.WriteHTML("font-family: Verdana, Arial;")
        CommonFunction.General.WriteHTML("height: 18px;")
        CommonFunction.General.WriteHTML("</style>")
        dr = CommonFunction.Data.GetDataReader("SELECT ReqTitle,RequirementCode,RequirementType,Priority,convert(varchar,PlannedStartDate,106) PlannedStartDate,convert(varchar,PlannedEndDate,106) PlannedEndDate FROM v_tbl_RM_ProjectRequirements WHERE ProjectRequirementID = " + m_strProjectRequirementID, MyBase.UseSQL)
        If dr.Read Then
            CommonFunction.General.WriteHTML("")
            CommonFunction.General.WriteHTML("<table width=100% >")
            CommonFunction.General.WriteHTML("<tr class=trWhiteCss >")
            CommonFunction.General.WriteHTML("<td><B>Title: </B>" + dr("ReqTitle").ToString + "</td>")
            CommonFunction.General.WriteHTML("<td><B>Code: </B>" + dr("RequirementCode").ToString + "</td>")
            CommonFunction.General.WriteHTML("</tr>")
            CommonFunction.General.WriteHTML("<tr class=trWhiteCss ><td><B>Type: </B>" + dr("RequirementType").ToString + "</td>")
            CommonFunction.General.WriteHTML("<td><B>Priority: </B>" + dr("Priority").ToString + "</td>")
            CommonFunction.General.WriteHTML("</tr>")
            CommonFunction.General.WriteHTML("<tr class=trWhiteCss ><td><B>Planned Start Date: </B>" + dr("PlannedStartDate").ToString + "</td>")
            CommonFunction.General.WriteHTML("<td><B>Planned End Date: </B>" + dr("PlannedEndDate").ToString + "</td>")
            CommonFunction.General.WriteHTML("</tr>")
            CommonFunction.General.WriteHTML("</table>")

        End If
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub



End Class
