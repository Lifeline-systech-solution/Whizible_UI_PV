Public Class RMLinks
    Inherits WebPages.Template.WhizTemplate
    'Added By RajeshJ on 16 Jan 2007
#Region "Variables"
    'Added By RajeshJ on 16 Jan 2007
    Protected m_strProjectRequirement_ImpactID As String
    Protected m_strProtectedString As String
    'Added By RajeshJ on 16 Jan 2007
#End Region

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
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub DrawLinks()
        Dim strIsDisabled As String
        If Request.QueryString("ProjectRequirementID") = "" Then
            strIsDisabled = "disabled"
        Else
            strIsDisabled = ""
        End If
        If Request.Form("reqPath") <> "" Then
            CommonFunction.General.WriteHTML("<input type=hidden name=reqPath id=reqPath value=" + Request.Form("reqPath") + ">")
        ElseIf Request.QueryString("ProjectRequirementID") <> "" Then
            CommonFunction.General.WriteHTML("<input type=hidden name=reqPath id=reqPath value=""../RM/ProjectRequirements_CommonPage.aspx?ProjectRequirementID_PK=" + Request.QueryString("ProjectRequirementID") + "&PK_Token=" + _
            CommonFunctions.Security.Token.GetToken(Request.QueryString("ProjectRequirementID") + CType(Session("intUserID"), String) + "0" + "0") + "&MasterTagID=3714&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"">")
        Else
            CommonFunction.General.WriteHTML("<input type=hidden name=reqPath id=reqPath value='' >")
        End If

        If Request.Form("hidProjectRequirementID") <> "" Then
            CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + Request.Form("hidProjectRequirementID") + ">")
        ElseIf Request.QueryString("ProjectRequirementID") <> "" Then
            CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + Request.QueryString("ProjectRequirementID") + ">")
        Else

            CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value='' >")
        End If

        Dim strRequirement As String
        CommonFunction.General.WriteHTML("<table  bgcolor=#ffffff style=""BACKGROUND-COLOR: #ffffff"" width=100%><tr><td></td></tr></table>")
        CommonFunction.General.WriteHTML("<table class=clsTableNavLinks width=100% height=100% cellpadding=0 cellspacing=0>")
        CommonFunction.General.WriteHTML("<tr class=clsTRNavLinks valign=middle>")
        CommonFunction.General.WriteHTML("<td align=center>")
        If Request.QueryString("ProjectRequirementID") = "" Then
            CommonFunction.General.WriteHTML("<a class='clsNavTab' " + strIsDisabled + " id=LnkReq href=""javascript:Link_onClick('LnkReq')"" >Requirement</a> ")
        Else
            CommonFunction.General.WriteHTML("<a class='clsSelected' id=LnkReq href=""javascript:Link_onClick('LnkReq')"" >Requirement</a> ")
        End If
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align=center>")
        CommonFunction.General.WriteHTML("<a class='clsNavTab' " + strIsDisabled + " id=LnkDet href=""javascript:Link_onClick('LnkDet')"" >Details</a> ")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align=center>")
        CommonFunction.General.WriteHTML("<a class='clsNavTab' " + strIsDisabled + " id=LnkImp href=""javascript:Link_onClick('LnkImp')"" >Impact</a> ")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align=center>")
        CommonFunction.General.WriteHTML("	<a class='clsNavTab' " + strIsDisabled + " id=LnkDoc href=""javascript:Link_onClick('LnkDoc')"" >Documents</a> ")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        'Reomving label of requirement title
        'CommonFunction.General.WriteHTML("<tr >")
        'CommonFunction.General.WriteHTML("<td class=clsLinkPageHeaderInner id=reqCaption align=left colspan=4 ><b>")
        'If Request.QueryString("ProjectRequirementID") = "" Then

        'CommonFunction.General.WriteHTML("Requirement:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        'Else
        If Request.QueryString("ProjectRequirementID") <> "undefined" And Request.QueryString("ProjectRequirementID") <> "" Then
            'strRequirement = CType(CommonFunction.Data.GetDataScalar("SELECT ReqTitle FROM Tbl_RM_ProjectRequirements WHERE ProjectRequirementID = " + Request.QueryString("ProjectRequirementID"), MyBase.UseSQL), String)
            'Added By RajeshJ on 16 Jan 2007
            m_strProjectRequirement_ImpactID = CType(CommonFunction.Data.GetDataScalar("SELECT ProjectRequirement_ImpactID FROM Tbl_RM_ProjectReqImpactAnalysis WHERE ProjectRequirementID = " + Request.QueryString("ProjectRequirementID"), MyBase.UseSQL), String)
            m_strProtectedString = m_strProjectRequirement_ImpactID + "&PKToken=" + CommonFunctions.Security.Token.GetToken(m_strProjectRequirement_ImpactID + CType(Session("intUserID"), String) + "0" + "0")
            'End of Addition By RajeshJ on 16 Jan 2007
            'CommonFunction.General.WriteHTML("Requirement:&nbsp;" + strRequirement)
            'Else
            'CommonFunction.General.WriteHTML("Requirement:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        End If

        'End If
        'End of removing label requirement title

        CommonFunction.General.WriteHTML("</b></td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")
    End Sub

End Class
