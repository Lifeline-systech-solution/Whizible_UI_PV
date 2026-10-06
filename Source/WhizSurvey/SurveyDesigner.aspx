<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SurveyDesigner.aspx.vb" Inherits="Whiz.SurveyDesigner" %>
<!DOCTYPE HTML>
<html>
<%  CommonFunctions.General.PlotPageHeadTag("Designer", , , , "<script language='JavaScript' src='../WhizSurvey/SurveyDesigner.js'></script><script language='JavaScript' src='../WhizSurvey/Survey_Common.js'></script>")%>

<body class='clsPageBody' style='background-color:#f3f3f3;' onload='win_resize()' onresize='win_resize()'>
<form id='frmSurveyDesigner' name='frmSurveyDesigner' method=post <%=m_strDir%>>

    <%If m_blnFinish = False  %>
        <%  DrawHiddenControls()%>    
        <%  WritePage()%>
        <% =CommonFunctions.General.CheckIsNothing(m_sbJSWriteAlertScript.ToString(), "")%>
        <% m_sbJSWriteAlertScript = Nothing%>
        
    <%End If%>
<script language="JavaScript" type="text/javascript">
// Initialize the variables declared in JS
strPagePath = "SurveyDesigner.aspx";
sFrmId='frmSurveyDesigner';
oFrm=GetFormReference(sFrmId);

function win_resize()
{
    var intDivHeight;
    var intDivHeightRisk=68;
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
    <%=WriteScriptToPopulateCapsArr()%>
</script>        

</form>

</body>

</html>