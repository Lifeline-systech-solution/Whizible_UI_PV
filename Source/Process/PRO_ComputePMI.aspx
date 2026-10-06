<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
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

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRO_ComputePMI.aspx.vb" Inherits="PbNIT.PRO_ComputePMI"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><HTML>
<%CommonFunctions.General.PlotPageHeadTag(m_strPageTitle)%>
<BODY MS_POSITIONING="GridLayout" class=clsBody  onresize="window_onresize()" onload="window_onload()">
	<FORM id="frmPMI" method=post runat="server">
		<%DrawPage()%>
	</FORM>

 </BODY>
  
  
  <script language=javascript >
	var objForm = GetFormReference('frmPMI');
	var intMasterTagID;
	
	<%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
	
	if (GetObjectReference('frmPMI', 'intMasterTagID') != null)
		intMasterTagID = GetObjectReference('frmPMI', 'intMasterTagID').value;
	else
		intMasterTagID = '';
  
	function Back_OnClick()
	{
		location.href = "../General/CommonList.aspx?FromWhere=PRO&MasterTagId=1052";
	}
	  
	function SetLCLandUCL(intMetricID)
	{
		if (confirm("<%=MyBase.getResourceString("MSG_CONFIRM")%>"))
		{	
			//Code added By DipaliS - 27 May 2004
			
			//Validations for given Metric ID
			//Get the String for TextBox IDs corresponding to LCL and UCL of given Metric.
			var strTxtLCL="txtDvdLCL" + intMetricID;
			var strTxtUCL="txtDvdUCL" + intMetricID;
			var objTxtLCL=GetObjectReference('objForm',strTxtLCL);
			var objTxtUCL=GetObjectReference('objForm',strTxtUCL);
			var result;
			
			//Not Blank LCL
			result=disallowBlank(objTxtLCL);
			if(result==true)
			{
				alert("<%=MyBase.GetResourceString("MSG_BLANKLCL")%>");
				return;
			}
			
			//Not Blank UCL
			result=disallowBlank(objTxtUCL);
			if(result==true)
			{
				alert("<%=MyBase.GetResourceString("MSG_BLANKUCL")%>");
				return;
			}
			
			//Allow only Numeric Value
			result=disallowNonNumeric(objTxtLCL);
			if(result==true)
			{
				alert("<%=MyBase.GetResourceString("MSG_NUMERIC")%>");
				return;
			}
			result=disallowNonNumeric(objTxtUCL);
			if(result==true)
			{
				alert("<%=MyBase.GetResourceString("MSG_NUMERIC")%>");
				return;
			}
					
			
			//LCL must be less than UCL
			result=disallowValue1GreaterThanValue2(objTxtLCL,objTxtUCL);
			if(result==true)
			{
				alert("<%=Mybase.GetResourceString("MSG_LCLGRUCL")%>");
				return;
			}
					
			//End of Addition
			objForm.action = "PRO_ComputePMI.aspx?MODE=SETNEW&PMIID=<%=m_lngPMIID%>&METRICID=" + intMetricID + "&MasterTagID=" + intMasterTagID ;
		    objForm.submit();
		}
	}
	
	function SetOption()
	{
		objForm.action = "PRO_ComputePMI.aspx?PMIID=<%=m_lngPMIID%>"+ "&MasterTagID=" + intMasterTagID;
		objForm.submit();
	}
	
	function MetricDetails(intMetricID)
	{
		window.open("PRO_ComputePMI_DetailGraph.aspx?SIGMA=<%=m_strSigma%>&PMIID=<%=m_lngPMIID%>&METRICID=" + intMetricID,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500" );
	}
  
	function ShowGraph(intMetricID)
	{ //Commented and added by Yogesh J on 10-Feb-2016 to generate Token
	   // window.open("PRO_ComputePMI_DetailGraph.aspx?PMIID=<%=m_lngPMIID%>&METRICID=" + intMetricID, "_blank", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=500");

	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'PRO_ComputePMI.aspx/GenrateURLToken_ShowGraph_OnClick',
	        data: JSON.stringify({ PMIID: "<%=m_lngPMIID%>", EmployeeID: "<%=Session("intUserID")%>", METRICID: intMetricID }),
			        success: function (Result) {
			            window.open("PRO_ComputePMI_DetailGraph.aspx?FromWhere=PRO&PMIID=<%=m_lngPMIID%>&METRICID=" + intMetricID + "&PKToken=" + Result.d, "_blank", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=500");

			        },
			        error: function () {
			            //      alert("Error")
			        }
			    });
	    //End of addition by Yogesh J on 10-Feb-2016 to generate Token
	}
	
	var objdivlist = GetObjectReference('frmPMI','DivList');
	function window_onload()
	{
		var intDivHeight ;
	
		if (objdivlist != null)
		{
		    //  intDivHeight = window.document.body.offsetHeight - objdivlist.offsetTop - 40;
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 48;//added by Shamkant on 13 Jan 2016
			if (intDivHeight < 100)
				intDivHeight = 100;		// Let the minimum height of the div tag be 100
		
		//'Modified by ShraddhaM on Date 29 June,2006 for WhizibleSEM Issue ID.4168
		
		if(navigator.appName == 'Netscape')
		{
		    //  intDivHeight = window.document.body.offsetHeight - objdivlist.offsetTop - 40;
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 48;//added by Shamkant on 13 Jan 2016
		}
		    /*Commented And Added by KIRAN K K For Height Issue fixing*/
		//objdivlist.style.height = intDivHeight;
		objdivlist.style.height = intDivHeight + 'px';
		    /*Commented And Added by KIRAN K K For Height Issue fixing*/
				
		}
	}

	function window_onresize()		
	{
	    var intDivHeight;
	    if (objdivlist != null)
	    {
	      //  intDivHeight = window.document.body.offsetHeight - objdivlist.offsetTop - 40;
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 48;//added by Shamkant on 13 Jan 2016
			if (intDivHeight < 100 )
				intDivHeight = 100;	// Let the minimum height of the div tag be 100
	        /*Commented And Added by KIRAN K K For Height Issue fixing*/
			//objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
	        /*Commented And Added by KIRAN K K For Height Issue fixing*/ 
			
		}	
	}
	</script>
</HTML>
