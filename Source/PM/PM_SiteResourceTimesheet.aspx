<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_SiteResourceTimesheet.aspx.vb" Inherits="PbNIT.PM_SiteResourceTimesheet"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
        <%CommonFunctions.General.PlotPageHeadTag("Site Resource TimeSheet")%>
        
        <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
        <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
        <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmPM_SiteResourceTimesheet" name="frmPM_SiteResourceTimesheet" method="post"
			runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPM_SiteResourceTimesheet');
		var objdivlist=GetObjectReference('frmPM_SiteResourceTimesheet','PageDiv');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 35;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 35 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 35;
		    }
			if (intDivHeight < 100) intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
				}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 35;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 35 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 35;
		    }
			if (intDivHeight < 100) intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
				}
		}	
		
		
		function OnlyNumeric(intAllowDecimal)
		{
			var KeyAscii = window.event.keyCode;
			
			if (intAllowDecimal==1 && KeyAscii == 46)
			{
			return;
			}
			
			else
			{
			if ( KeyAscii < 48 || KeyAscii > 57 ) 
				{ window.event.keyCode = 0; } 
			}	
		}
		
		function ApplySiteFilter()
		{
			objform.action = "PM_SiteResourceTimesheet.aspx?ApplyFilter=True&TimesheetID=<%=m_strTimesheetID%>";
			objform.submit();
		}
		
		function ApplyEmployeeFilter()
		{
			objform.action = "PM_SiteResourceTimesheet.aspx?ApplyFilter=True&TimesheetID=<%=m_strTimesheetID%>";
			objform.submit();
		}
		
		function Save_OnClick()
		{
			//Added by DipaliS 6 Oct 2004
			if(ValidateData()==false)
				return;
			//End Addition by DipaliS
			objform.action = "PM_SiteResourceTimesheet.aspx?Action=Save&TimesheetID=<%=m_strTimesheetID%>";
			objform.submit();
		}
		//Added by DipaliS 6 Oct 2004
		function ValidateData()
		{
			//Function that validates the data enetered with the actual timesheet data	
			var objTotal =GetObjectReference('frmPM_SiteResourceTimesheet','txtTotal',true);
			var objNormal;
			var objExtra;
			var objNonBillable;
			var intCount;
			var len=objTotal.length;
			var result=true;
			var flNormalHours, flExtraHours, flNonBillableHours
			if(len==0) result=false;			
			if(len==1) 
				{					
					objTotal =GetObjectReference('frmPM_SiteResourceTimesheet','txtTotal');
					objNormal=GetObjectReference('frmPM_SiteResourceTimesheet','txtNormalHours');
					objExtra=GetObjectReference('frmPM_SiteResourceTimesheet','txtExtraHours');
					objNonBillable=GetObjectReference('frmPM_SiteResourceTimesheet','txtNonBillableHours');										var Total;
					// Code added by SwapnilR on 10th Jan 2005				
					
					if(objNormal.value == "" )
					{
						flNormalHours = 0;
					}
					else
					{
						flNormalHours = objNormal.Value; 
					}
					if(objExtra.value == "" )
					{
						flExtraHours = 0
					}
					else
					{
						flExtraHours = objExtra.Value 
					}
					if(objNonBillable.value == "" )
					{
						flNonBillableHours = 0
					}
					else
					{
						flNonBillableHours = objNonBillable.Value 
					}
					Total=parseFloat(flNormalHours) + parseFloat(flExtraHours)+parseFloat(flNonBillableHours);
					// End of code addition by SwapnilR on 10th Jan 2005
					if(Total!=parseFloat(objTotal.value))
					{
					result=false
					alert("<%=Mybase.GetResourceString("MSG_MAXVALUE")%>");
					setFocus(objNormal);
					}
						
					
				}
			else
			{
					objNormal=GetObjectReference('frmPM_SiteResourceTimesheet','txtNormalHours',true);
					objExtra=GetObjectReference('frmPM_SiteResourceTimesheet','txtExtraHours',true);
					objNonBillable=GetObjectReference('frmPM_SiteResourceTimesheet','txtNonBillableHours',true);
					
				for(intCount=0;intCount<len;intCount++)
				{										
					var Total, flNormalHours, flExtraHours, flNonBillableHours;
					if(objNormal[intCount].value == "" )
					{
						flNormalHours = 0
					}
					else
					{
						flNormalHours = objNormal[intCount].value
					}
					if(objExtra[intCount].value == "" )
					{
						flExtraHours = 0
					}
					else
					{
						flExtraHours = objExtra[intCount].value
					}
					if(objNonBillable[intCount].value == "" )
					{
						flNonBillableHours = 0
					}
					else
					{
						flNonBillableHours = objNonBillable[intCount].value
					}
					//Total=parseFloat(objNormal[intCount].value)+ parseFloat(objExtra[intCount].value)+parseFloat(objNonBillable[intCount].value);
					Total=parseFloat(flNormalHours)+ parseFloat(flExtraHours)+parseFloat(flNonBillableHours);
					if(Total!=parseFloat(objTotal[intCount].value))
					{
						alert("<%=Mybase.GetResourceString("MSG_MAXVALUE")%>");
						setFocus(objNormal[intCount]);
						result=false;
						break;
					}
				} 
			}		
			if(result==false)
				return false;
			else
				return true;
				
		}
		//End Addition by DipaliS
		</Script>
	</body>
</HTML>
