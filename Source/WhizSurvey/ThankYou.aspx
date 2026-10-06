<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ThankYou.aspx.vb" Inherits="Whiz.ThankYou" %>
<HTML>
<%  CommonFunctions.General.PlotPageHeadTag()%>
<BODY class='clsPageBody' style='background-color:#f3f3f3;' onload='win_resize()' onresize='win_resize()'>
<form id='frmCommonPage' name='frmCommonPage' method=post>
<%DrawPageCaptionForAnonymousEmailSurvey()%>
<table border=1 style='width:99.99%;background-color:white;' <%=strTDStyle%>>
    <TR class='clsTRBody'>
        <TD valign=top  colspan=2>
            <div id='divPage' style='height:550px;overflow:auto;width:100%' >
            <br/>
            <%  Response.Write(m_strCompletionText)%>
            </div>
        </TD>
    </TR>
</table>

<script language="JavaScript" type="text/javascript">
function win_resize()
{
    var intDivHeight;
    var intDivHeightRisk=28;
    var oDivPage=GetObjectReference('frmCommonPage','divPage');
    if (oDivPage!=null)
    {
        if (navigator.appName == 'Microsoft Internet Explorer')
        {intDivHeight = document.body.offsetHeight - oDivPage.offsetTop - intDivHeightRisk;}
        else
        {intDivHeight = window.innerHeight - oDivPage.offsetTop - intDivHeightRisk;}
        if (intDivHeight<100)
	        intDivHeight=100;
        oDivPage.style.height=intDivHeight;
    }
}
</script>
</form>
</BODY> 
</HTML> 