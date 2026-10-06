<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRO_ActivityEffortDistribution.aspx.vb" Inherits="PbNIT.PRO_ActivityEffortDistribution"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><html>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmPRO_ActivityEffortDistribution" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPRO_ActivityEffortDistribution');
		var objdivlist=GetObjectReference('frmPRO_ActivityEffortDistribution','PageDiv');
		
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
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }

			if (intDivHeight < 100) intDivHeight = 100;

			
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			//objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/ 
        }
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100) intDivHeight = 100;
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			//objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
				}
		}	
		
		function Select_OnClick(intRowNo)
		{
			var objTxt,objChk;
			var blnPhaseTaskIsMandatory;
			
			objChk = GetObjectReference('frmPRO_ActivityEffortDistribution','chkSelect' + intRowNo);
			if(objChk.checked==true)
			{
				objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtEffort' + intRowNo);
				objTxt.disabled=false;
				
				objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtDuration' + intRowNo);
				objTxt.disabled=false;
				
				objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtPhaseTaskMandatory');
				blnPhaseTaskIsMandatory = objTxt.value;
				if(blnPhaseTaskIsMandatory=="1")
				{
					objChk = GetObjectReference('frmPRO_ActivityEffortDistribution','chkMandatory' + intRowNo);
					objChk.disabled=false;
				}				
			}
			else
			{
				objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtEffort' + intRowNo);
				objTxt.disabled=true;
				
				objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtDuration' + intRowNo);
				objTxt.disabled=true;
				
				objChk = GetObjectReference('frmPRO_ActivityEffortDistribution','chkMandatory' + intRowNo);
				objChk.disabled=true;
			}
		}
		
		function Save_OnClick()
        {
            
			if(IsValidData()==true)
			{ //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
			    var MenuTags = document.getElementsByTagName('A');
			    for (i = 0; i < MenuTags.length; i++) {
			        if (MenuTags[i].className == "Menu") {
			            //MenuTags[i].style.display= "none";
			            MenuTags[i].parentNode.style.display = "none";
			        }
			    }
			    setFrameLoader();
			    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
				objform.action = "PRO_ActivityEffortDistribution.aspx?Action=<%=CONST_ACTION_SAVE%>";
				objform.submit();
				//Added By NitinVS on 21 Feb 2005 
                // To Refresh the Parent Page when the Activty data is changed
                var objParent = GetParentFormReference('frmCommonPage'); 
                objParent.submit(); 
                //Commented By Usha Pandit On 15.05.2020 to prevent close popup on save
                //window.close();
                //End Of Commented By Usha Pandit On 15.05.2020 to prevent close popup on save
                // End Addition By NitinVS on 21 Feb 2005 
			}
		}
		
		function IsValidData()
		{
			var intRowCount,i;
			var objChk,objTxt;
			var dblTotalEffort=0.0;
			var dblAllowedEffort=0.0;
			var dblValue=0.0;
			var flag,blnPercentEffort;
			
			objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtRowCount');
			intRowCount = Number(objTxt.value);
			
			for(i=1;i<=intRowCount;i++)
			{
				objChk = GetObjectReference('frmPRO_ActivityEffortDistribution','chkSelect' + i);
				if(objChk.checked==true)
				{
					objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtEffort' + i);
					//modified by HarshK on 06/09/2005 for sp4 issueid 136 (single quotes of  messages replaced by double quotes)
					flag = disallowBlank(objTxt,"<%=MyBase.GetResourceString("MSG_EFFORT_EMPTY")%>",true);
					if(flag==true)
						return false;
					
					flag = disallowNonNumeric(objTxt,"<%=MyBase.GetResourceString("MSG_EFFORT_NONNUMERIC")%>",true);
					if(flag==true)
						return false;
					
					flag = disallowNegativeNumeric(objTxt,"<%=MyBase.GetResourceString("MSG_EFFORT_NONNUMERIC")%>",true);
					if(flag==true)
						return false;
					
					dblValue = Number(objTxt.value);
					if(dblValue==0)
					{
						alert("<%=MyBase.GetResourceString("MSG_EFFORT_EMPTY")%>");
						objTxt.focus();
						return false;
					}
					
					dblTotalEffort += dblValue;
					
					objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtDuration' + i);
					flag = disallowBlank(objTxt,"<%=MyBase.GetResourceString("MSG_DURATION_EMPTY")%>",true);
					if(flag==true)
						return false;
					
					flag = disallowNonNumeric(objTxt,"<%=MyBase.GetResourceString("MSG_DURATION_NONNUMERIC")%>",true);
					if(flag==true)
						return false;
					
					flag = disallowNegativeNumeric(objTxt,"<%=MyBase.GetResourceString("MSG_DURATION_NONNUMERIC")%>",true);
					if(flag==true)
						return false;
					
					dblValue = Number(objTxt.value);
					if(dblValue==0)
					{	//Modified By NitinVS on 20 Oct 2005 for WhizibleSEM SP4 IssueID 614
						alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_DURATION_EMPTY")%>" ,"&#39;","'") );
						//End Modification By NitinVS on 20 Oct 2005 for WhizibleSEM SP4 IssueID 614
						objTxt.focus();
						return false;
                    }

					//End modified by HarshK on 06/09/2005 for sp4 issueid 136 
				}
			}
			//validation for total duration should not exceed phasetask duration
			objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtPhaseTaskEffort');
			dblAllowedEffort = Number(objTxt.value);
			
			objTxt = GetObjectReference('frmPRO_ActivityEffortDistribution','txtPercentEffortDistribution');
            blnPercentEffort = objTxt.value;
            
			if(blnPercentEffort=='1')
			{
				if(dblTotalEffort > 100)
				{
					alert('<%=MyBase.GetResourceString("MSG_EFFORT_EXCEEDS_PERCENTAGE")%>');
					return false;
                }
                //Added by Chetan M on 23 Nov 2020 for validate task effort
                if(dblTotalEffort > dblAllowedEffort)
				{
					alert('<%=MyBase.GetResourceString("MSG_EFFORT_EXCEEDS_PHASETASK")%>');
					return false;
                }
                //End of Added by Chetan M on 23 Nov 2020 for validate task effort
			}
			else
			{
				if(dblTotalEffort > dblAllowedEffort)
				{
					alert('<%=MyBase.GetResourceString("MSG_EFFORT_EXCEEDS_PHASETASK")%>');
					return false;
				}
			}
			
			return true;
		}
		</Script>
	</body>
</html>
