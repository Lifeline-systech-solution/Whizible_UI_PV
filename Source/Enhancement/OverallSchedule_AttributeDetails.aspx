<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OverallSchedule_AttributeDetails.aspx.vb" Inherits="PbNIT.OverallSchedule_AttributeDetails" %>

<!DOCTYPE html>

<html>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <% CommonFunctions.General.PlotPageHeadTag("Overall Schedule Details")%>

    <head runat="server">
        <title>Overall Schedule Details</title>
    </head>
    <body>
        <form id="frmOverallSchedule_AttributeDetails" runat="server">
            <%PageInit%>	
        </form>
    
        <script language= "javascript" type="text/javascript" >
            var objform = GetFormReference('frmOverallSchedule_AttributeDetails');
            var objDivMain = GetObjectReference('frmOverallSchedule_AttributeDetails', 'divList');

            function Close_OnClick()
            {        
                window.close();
            }
        </script>
    </body>
</html>
