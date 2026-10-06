<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Welcome.aspx.vb" Inherits="Whiz.Welcome" %>
<HTML>
<%  CommonFunctions.General.PlotPageHeadTag()%>

<BODY class='clsPageBody' style='background-color:#f3f3f3;'  onload='win_resize()' onresize='win_resize()'>
<form id='frmSurveyDesigner' name='frmSurveyDesigner' method=post>
<table border=1 style='width:99.99%;'>
    <tr style='vertical-align:top;' <%=strTDStyle%> >
    <td>
        <table style='width:99.99%;background-color:white;'>
            <tr>
                <td style='vertical-align:top;text-align:<%=strimgLeftAlign%>;' >
                    <img Border=0 src='../../images/green/logo.gif' id ='imgLeft' border=0>
                </td>
                <td style='vertical-align:top;text-align:<%=strimgRightAlign%>;' ></td>
            </tr>
        </table> 
        <%  DrawPageCaption() %>
        <div id='divPage' style='height:550px;overflow:auto;width:100%'>
            <table style='width:99.99%;background-color:white;'>
                <tr>
                    <TD valign=top  colspan=2><!--HR></HR--></td>
                </tr>
                <TR class='clsTRBody'>
                    <TD valign=top  colspan=2>
                        <%  Response.Write(m_strWelcomeText)%>
                    </TD>
                </TR>
            </Table>
        </div>
    </td>
    </tr>
</Table>
<%=m_strScript %>
<script language="JavaScript" type="text/javascript">
function win_resize()
{
    var intDivHeight;
    var intDivHeightRisk=28;
    var oDivPage=GetObjectReference('frmSurveyDesigner','divPage');
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
