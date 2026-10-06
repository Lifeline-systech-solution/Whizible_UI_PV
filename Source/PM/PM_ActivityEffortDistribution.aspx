<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ActivityEffortDistribution.aspx.vb" Inherits="PbNIT.PM_ActivityEffortDistribution"%>
<!DOCTYPE HTML>
<HTML>
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    <head>
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


    </head>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmPM_ActivityEffortDistribution" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPM_ActivityEffortDistribution');
		var objdivlist=GetObjectReference('frmPM_ActivityEffortDistribution','PageDiv');
		
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
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
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
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
        }
		}	
		
		<%MyBase.InitializeResources("AppResources.PM_ActivityEffortDistribution", "AppResources")%>
		
			//  'Coded Added By VidyaJ - Security Issue - 6197   
		function Activity_OnClick(strID,strtoken)
		{
			var strTID,strPID;
			var objTxt;
			
			objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtTemplateID');
			strTID=objTxt.value;
			
					
			objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtPhaseTaskID');
			strPID=objTxt.value;
			//  'Coded Added By VidyaJ - Security Issue - 6197    
			window.open("../General/CommonPage.aspx?PKToken=" + strtoken + "&ProjectPhaseTaskActivityID_PK=" + strID + "&MasterTagID=2178&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PhaseTaskID=" + strPID + "&TemplateID=" + strTID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=400");
		}
		
		function Save_OnClick()
		{
			if(IsValidData()==true)
			{
				objform.action = "PM_ActivityEffortDistribution.aspx?Action=<%=CONST_ACTION_SAVE%>";
				objform.submit();
				//Added By NitinVS on 21 Feb 2005 
                // To Refresh the Parent Page when the Activty data is changed
                var objParent = GetParentFormReference('frmCommonPage'); 
                objParent.submit(); 
                window.close();
                // End Addition By NitinVS on 21 Feb 2005 
			}
		}
		
		function IsValidData()
		{
			var intRowCount,i;
			var objChk, objTxt;
			var dblTotalEffort=0.0;
			var dblValue=0.0;
			var flag;
			
			objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtRowCount');
			intRowCount = Number(objTxt.value);
			
			for(i=1;i<=intRowCount;i++)
			{
			
				objChk = GetObjectReference('frmPM_ActivityEffortDistribution','chkSelect' + i);
				if(objChk)
				{
					if(objChk.checked==true)
					{
					  				
						objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtEffort' + i);
						flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_EFFORT_EMPTY")%>',true);
						if(flag==true) 	return false;
							
						flag = disallowNonNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_EFFORT_NONNUMERIC")%>',true);
						if(flag==true) return false;
							
						flag = disallowNegativeNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_EFFORT_NONNUMERIC")%>',true);
						if(flag==true) 	return false;
							
						dblValue = Number(objTxt.value);
						if(dblValue==0)
						{
							alert('<%=MyBase.GetResourceString("MSG_EFFORT_EMPTY")%>');
							objTxt.focus();
							return false;
						}
							
						dblTotalEffort += dblValue;
							
						objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtDuration' + i);
						flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DURATION_EMPTY")%>',true);
						if(flag==true)
							return false;
							
						flag = disallowNonNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_DURATION_NONNUMERIC")%>',true);
						if(flag==true)
							return false;
							
						flag = disallowNegativeNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_DURATION_NONNUMERIC")%>',true);
						if(flag==true)
							return false;
							
						dblValue = Number(objTxt.value);
						if(dblValue==0)
						{
							alert('<%=MyBase.GetResourceString("MSG_DURATION_EMPTY")%>');
							objTxt.focus();
							return false;
						}
					}
				}
				else
				{
					objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtEffort' + i);
						flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_EFFORT_EMPTY")%>',true);
						if(flag==true) 	return false;
							
						flag = disallowNonNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_EFFORT_NONNUMERIC")%>',true);
						if(flag==true) return false;
							
						flag = disallowNegativeNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_EFFORT_NONNUMERIC")%>',true);
						if(flag==true) 	return false;
							
						dblValue = Number(objTxt.value);
						if(dblValue==0)
						{
							alert('<%=MyBase.GetResourceString("MSG_EFFORT_EMPTY")%>');
							objTxt.focus();
							return false;
						}
							
						dblTotalEffort += dblValue;
							
						objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtDuration' + i);
						flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DURATION_EMPTY")%>',true);
						if(flag==true)
							return false;
							
						flag = disallowNonNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_DURATION_NONNUMERIC")%>',true);
						if(flag==true)
							return false;
							
						flag = disallowNegativeNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_DURATION_NONNUMERIC")%>',true);
						if(flag==true)
							return false;
							
						dblValue = Number(objTxt.value);
						if(dblValue==0)
						{
							alert('<%=MyBase.GetResourceString("MSG_DURATION_EMPTY")%>');
							objTxt.focus();
							return false;
						}
				}
			}
			
			//validation for total effort should not exceed 100%				
			if(dblTotalEffort > 100)
			{
				alert('<%=MyBase.GetResourceString("MSG_EFFORT_EXCEEDS_PERCENTAGE")%>');
				return false;
			}
			
			return true;
		}
		
		function Select_OnClick(intRowNo)
		{
			var objTxt,objChk;
			var blnPhaseTaskIsMandatory;
			
			objChk = GetObjectReference('frmPM_ActivityEffortDistribution','chkSelect' + intRowNo);
			if(objChk.checked==true)
			{
				objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtEffort' + intRowNo);
				objTxt.disabled=false;
				
				objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtDuration' + intRowNo);
				objTxt.disabled=false;
				
				objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtPhaseTaskMandatory');
				blnPhaseTaskIsMandatory = objTxt.value;
				if(blnPhaseTaskIsMandatory=="1")
				{
					objChk = GetObjectReference('frmPM_ActivityEffortDistribution','chkMandatory' + intRowNo);
					objChk.disabled=false;
				}				
			}
			else
			{
				objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtEffort' + intRowNo);
				objTxt.value = '';
				objTxt.disabled=true;
				
				objTxt = GetObjectReference('frmPM_ActivityEffortDistribution','txtDuration' + intRowNo);
				objTxt.value = '';
				objTxt.disabled=true;
				
				objChk = GetObjectReference('frmPRO_ActivityEffortDistribution','chkMandatory' + intRowNo);
				objChk.disabled=true;
			}
		}
		</Script>
	</body>
</HTML>
