<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_Comments.aspx.vb" Inherits="Whiz.CRW_Comments"%>
<HTML>
 <% 'Added by By Ninad on 27 Aug 2007, Issue ID - 14398 %>
<%  If m_blnIsCheckedIn Then CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("COMMENTS_CAPTION_FOR_CHECK_OUT"))%>
<%If Not m_blnIsCheckedIn Then CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("COMMENTS_CAPTION_FOR_CHECK_IN"))%>
<%  'End Addition by By Ninad on 27 Aug 2007, Issue ID - 14398 %>
	<body class="clsBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
	<form id="frm_Comments" name="frm_Comments" method="post">
		<%PageInit()%>
	</form>				
<script language="javascript">
		
var objdivlist;
var objform;
				
objform=GetFormReference('frm_Comments');
objdivlist=GetObjectReference('frm_Comments','DivList');
setFocus(GetObjectReference('frm_Comments','txtComments'));

function window_onload()		
{
	if (window.opener == null)
		    window.open('../../Default.aspx?Message=InvalidLogin','_top');
var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		    windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
}
	
<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 13, 2007 END%>
	
function Save_OnClick(ReportID,TagID)
{	
	var objTxtArea=GetObjectReference('frm_Comments','txtComments');
	if (disallowBlank(objTxtArea,'<%=MyBase.GetResourceString("VALIDATION_MSG_COMMENTS_NOT_ENTERED")%>',true) )
		 return;
	if (disallowMaxlengthViolation(objTxtArea,500,"<%=MyBase.GetResourceString("VALIDATION_MSG_COMMENTS_EXCEEDS_MAX_LENGTH")%>"))
		 return;
	
	objform.action='../CRW/CRW_Comments.aspx?Operation=SAVE&ReportID=' + ReportID + '&TagID=' + TagID;
	objform.submit(); 
 } 
</script>

	</body>
</HTML>

<!--Including files & Libraries-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<script type="text/javascript" src="../General/responsive/responsive.js"></script>

<script type="text/javascript">

$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
     responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
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
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

});
</script>