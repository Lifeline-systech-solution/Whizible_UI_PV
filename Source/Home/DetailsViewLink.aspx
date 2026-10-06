<%@ Page Language="vb" AutoEventWireup="false" EnableViewState="false" EnableViewStateMac="false" CodeBehind="DetailsViewLink.aspx.vb" Inherits="PbNIT.DetailsViewLink" %>

<html>
<head runat="server">
</head>
   <%IF m_intMarqueeSectionHeight <> 0 Then%>
        <frameset id="frmDetailsView" border="0" rows="*,<%=m_intMarqueeSectionHeight%>" frameSpacing="0" frameBorder="0">
        <%IF m_strFromWhere <> "" Then%>
                <frame name="DetailsView" id="DetailsView" src="../Home/HRHome.aspx?ShowMarquee=1&ShortName=<%=m_strFromWhere%>" marginwidth="0" marginheight="0" BORDER="0" target="_self">
                <frame name="MarqueeHome" id="MarqueeHome" scrolling="No" src="../Home/Marquee.aspx?ShowMarquee=1&ShortName=<%=m_strFromWhere%>" marginwidth="0" marginheight="0" BORDER="0" target="_self" >             
        <%--<%Else%>
                <frame name="DetailsView"  id="DetailsView" src="../Home/DetailView.aspx?ShowMarquee=1&MenuGroupID=<%=m_intMenuGroupID%>" marginwidth="0" marginheight="0" BORDER="0" target="_self" frameborder=no>
               <frame name="Marquee" id="Marquee" scrolling="No" src="../Home/Marquee.aspx?MenuGroupID=<%=m_intMenuGroupID%>" marginwidth="0" marginheight="0" BORDER="0" target="MarqueeHome" frameborder=no>--%> 
       <%End If%>
       </frameset> 
   <%Else%>
        <frameset id="frmDetailsView" border="0" rows="100%" frameSpacing="0" frameBorder="0">
        <%IF m_strFromWhere <> "" Then%>
                <frame name="DetailsView" src="../Home/HRHome.aspx?ShortName=<%=m_strFromWhere%>" marginwidth="0" marginheight="0" BORDER="0" target="_self">
        <%Else%>
                <frame name="DetailsView"  src="../Home/DetailView.aspx?MenuGroupID=<%=m_intMenuGroupID%>" marginwidth="0" marginheight="0" BORDER="0" target="_self" frameborder=no>
        <%End If%>
        </frameset> 
    <%End If%>
   
</html>

<%--<%--<script language=javascript >
    
    debugger;
    if ("<%=m_strFromWhere%>" != "")
    {
        
        objMarqueeHome = parent.document.getElementById("MarqueeHome");
        objMarqueeHome.style.display = "none"; 
    } 
    
</script>--%>--%>