Public Partial Class Collateral
    Inherits WebPages.Template.WhizTemplate
    Private m_strTab As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
    End Sub
    
    'Protected Sub PlotTabMenu()
    '    Dim strHtml As New System.Text.StringBuilder

    '    strHtml.Append("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'>" + vbCrLf)
    '    strHtml.Append("<TR class=clsTRMenu>" + vbCrLf)
    '    strHtml.Append("<TD align=Right>" + vbCrLf)
    '    strHtml.Append("| <A class='Menu' style=''  Title=""Product""  onclick=""Product_OnClick()"" >Product</A> | " + vbCrLf)
    '    strHtml.Append("<A class='Menu' style=''  Title=""Home""  onclick=""Home_OnClick('HOME')"" ><img border=0 src='..\..\Images\home.png'> </A> | " + vbCrLf)
    '    strHtml.Append("<A class='Menu' style=''  Title=""My""  href=""JavaScript:ShowContextMenu(event,this)"" onmouseover=""JavaScript:ShowContextMenu(event,this)"" >My</A> | " + vbCrLf)
    '    strHtml.Append("<A class='Menu' style=''  Title=""Team""  onclick=""Team_OnClick('TEAM')"" >Team</A> | " + vbCrLf)
    '    strHtml.Append("<A class='Menu' style=''  Title=""Help""  onclick=""Help_OnClick('KM')"" ><Img Border=0 src='../../Images/cssImages/Link images/help.gif'></A> |" + vbCrLf)
    '    strHtml.Append("</TD></TR></TABLE><BR>" + vbCrLf)

    '    Response.Write(strHtml.ToString)
    'End Sub
End Class