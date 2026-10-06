<%@ Page Language="vb" AutoEventWireup="false" EnableViewState="false" EnableViewStateMac="false" CodeBehind="Marquee.aspx.vb" Inherits="PbNIT.Marquee" %>

<html>
    <%  WritePageHead()%>
    <body>
        <form id="frmMarquee" name="frmMarquee" method="post" runat="server">
            <%WritePage()%>
            
        </form>
        
    
    </body>
</html>

<script type="text/javascript">

var intMarqueeStop = 0;
function CookieGroup() 
{
    var varMarquee = GetObjectReference('','marquee');
    
    if(intMarqueeStop == 0)
    {  
        varMarquee.stop();
        intMarqueeStop = 1;
    }
    else
    {
       varMarquee.start();
       intMarqueeStop = 0;
    }
}
</script>