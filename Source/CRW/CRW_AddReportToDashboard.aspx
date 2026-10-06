<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_AddReportToDashboard.aspx.vb" Inherits="Whiz.CRW_AddReportToDashboard" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("Add Report To Dashboard"))%>
    
   
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmAddToDashboard" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
</html>
<script language="javascript">
	var objform;
	var objdivlist;
	var objtxtLinkName;
	var objcboDashboard;
             <%' Added By Shamkant S on 8 Dec Jan 2015 %>
		     <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
              disableRightClick();
             <%End If%>
		     <%' Ended By Shamkant S on 8 Dec Jan 2015 %>
	
	objform = GetFormReference('frmAddToDashboard');
	objdivlist = GetObjectReference('frmAddToDashboard','divList');
	objtxtLinkName = GetObjectReference('frmAddToDashboard','txtLinkName');
	objcboDashboard = GetObjectReference('frmAddToDashboard','cboDashboard');
		
	function validate()
	{
		if (disallowBlank(objtxtLinkName,"Please provide the name of the link")) return false;
		if (disallowBlank(objcboDashboard,"Please select the dashboard")) return false;
		return true;
	}
	
	
	function Save_OnClick(reportid)
	{
		if (validate()== true)
		{
			objform.action = "CRW_AddReportToDashboard.aspx?Action=SAVE&ReportID=" + reportid;
			objform.submit();
		}
	}
	<% 'WAF3_PB_42 April 10, 2007 Replace window_onload and window_onresize functions  %>
</script>


<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->



<script type="text/javascript" src="../General/responsive/responsive.js"></script>


<script type="text/javascript">
$(document).ready(function(){


    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:12/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:19/01/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

});

$(window).resize(function(){

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Table Inner Menu on Window Resize
    // By Whom: Miiint
    // When:12/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:12/02/2015
    /*---------------------------------------------------------*/

   responsiveFooterMenuResize();

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-collapse & close for tablet view
    // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
    // By Whom: Miiint
    // When:17/02/2015
    /*---------------------------------------------------------*/
    collapseDivsResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-collapse & close for tablet view
    /*---------------------------------------------------------*/

    });

</script>
