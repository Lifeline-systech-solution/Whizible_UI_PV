<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_EmployeeSkillsSearch.aspx.vb" Inherits="PbNIT.PM_EmployeeSkillsSearch"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGECAPTIONFORFILTER"))%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>
<!-- <script src="../General/CommonFunctions.js"></script> -->
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added by Yogesh J on 25-NOV-2015*/
    TR.clsTRSectionHeader b {
        font-weight: bold !important;
    }
    /*End of additon by Yogesh J  on 25-NOV-2015 */
</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
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

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
					<form id="frmPM_EmployeeSkillsSearch" method="post" runat="server">
							<%PageInit%>
					</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPM_EmployeeSkillsSearch');
		var objdivlist=GetObjectReference('frmPM_EmployeeSkillsSearch','PageDiv');
		var intCheckedArray=new Array();

		// Added by MahendraV On 6:03 PM 9/3/2007 For PMLifeLine 7.1
		// To ste filter only for 30 skills
		// Start_MV_9/3/2007
		var cntCheckBox = 0;
		// End_MV_9/3/2007
		//The div tag has id as PageDiv 
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			//Commented and added by nilesh g on 23/11/2015 
			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
			    //}
			var browser=isIE();
			if(browser=='IE')
			{
			    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 44 ;
			   
			}
			else if(browser=='CR')
			{
			    intDivHeight =window.innerHeight-objdivlist.offsetTop-44;
			    
			}
			else if(browser=='FF')
			{
			    intDivHeight =window.innerHeight-objdivlist.offsetTop-45;
			    
			}
			else
			{
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			}
			    //end of Commented and added by nilesh g on 23/11/2015 
			//End of modification by MonikaI
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight+'px';
			
			}	
			CheckFilterOnlyForThirtySkills();
			
		}
		// Added by MahendraV On 6:03 PM 9/3/2007 For PMLifeLine
		// To ste filter only for 30 skills
		// To changes if some skills experience is not specified
		// Start_MV_9/3/2007
		function CheckFilterOnlyForThirtySkills()
		{
			cntCheckBox = 0;
			//Added By VarunA on 25-Sep-2007 For PMLifeLine
						var i=0;
			//End By VarunA on 25-Sep-2007
			for(i=0;i<<%=m_intCheckBoxCount%>;i++)
			{
				if(<%=m_intCheckBoxCount%>==1)
				{
					if (objform.chkToolRequired.checked==true)
					{
						cntCheckBox			= cntCheckBox + 1;
						intCheckedArray[i]	= 1;
					}
					else
					{
						intCheckedArray[i] = 0;
					}
					
						
				}
				else
				{
					if (objform.chkToolRequired[i].checked==true)
					{
						cntCheckBox			= cntCheckBox + 1;
						intCheckedArray[i]	= 1;
					}
					else
					{
						intCheckedArray[i] = 0;
					}
				}
							
			}
			
		}
		// End_MV_9/3/2007
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    //}
			    //Commented and added by nilesh g on 23/11/2015 
			    //if(navigator.appName == 'Netscape')
			    //{		  
			    //	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
			    //}
			    var browser=isIE();
			    if(browser=='IE')
			    {
			        intDivHeight =window.innerHeight  - objdivlist.offsetTop - 44 ;
			       
			    }
			    else if(browser=='CR')
			    {
			        intDivHeight =window.innerHeight-objdivlist.offsetTop-44;
			       
			    }
			    else if(browser=='FF')
			    {
			        intDivHeight =window.innerHeight-objdivlist.offsetTop-45;
			        
			    }
			    else
			    {
			        intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    }
			    //end of Commented and added by nilesh g on 23/11/2015 
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px';	}
		}	
		function optViewMode_onclick(strViewMode)
		{
			objform.action = "PM_EmployeeSkillsSearch.aspx?ViewMode=" + strViewMode + "&MasterTagID=" + "<%=m_lngMasterTagID%>" + "&PageNumber="+ "<%=m_strPagingAlphabet%>"
			objform.submit()
		}
		function Page_Onclick(strPageAlphabet)
		{
			objform.action="PM_EmployeeSkillsSearch.aspx?ViewMode=" + "<%=m_strViewMode%>" + "&PageNumber="+ strPageAlphabet + "&MasterTagID=" + "<%=m_lngMasterTagID%>"
			objform.submit()
		}
		function ProjectDetails_OnClick(intEmployeeID)
		{
		
		    //Commented and added by Yogesh J on 15-Feb-2016 to generate Token
		//	window.open ("../HR/HR_EmployeeResume.aspx?EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=700,height=550");

		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'PM_EmployeeSkillsSearch.aspx/GenrateURLToken_ProjectDetails_OnClick',
		        data: JSON.stringify({ EmployeeID: intEmployeeID }),
	        success: function (Result) {
	            window.open ("../HR/HR_EmployeeResume.aspx?EmployeeID=" + intEmployeeID + "&FromWhere=PM&Token="+ Result.d,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=700,height=550");

			        },
			        error: function () {
			            //      alert("Error")
			        }
	    });
		    //End of addition by Yogesh J on 15-Feb-2016 to generate Token
		}
		function SetFilter_OnClick()
		{
				
			
			window.open ("PM_EmployeeSkillsSearch.aspx?PageNumber=" + "<%=m_strPagingAlphabet%>" + "&ViewMode=" + "<%=m_strViewMode%>" + "&Mode=ApplyFilter" + "&MasterTagID=" + "<%=m_lngMasterTagID%>", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=600,height=450");	
		}
			
	
		function chkToolRequired_onclick(intIndex)
		{
			
			if(<%=m_intCheckBoxCount%>==1)
			{
				
				if(objform.chkToolRequired.checked == true) 
				{
						// Added by MahendraV On 6:03 PM 9/3/2007 For PMLifeLine
						// To ste filter only for 30 skills
						// To changes if some skills experience is not specified
						// Start_MV_9/3/2007
						cntCheckBox							= cntCheckBox + 1;
						intCheckedArray[intIndex]			= 1;
						// End_MV_9/3/2007
						objform.cboYears.disabled			= false;
						objform.cboMonths.disabled			= false;					
						objform.cboProficiency.disabled		= false;
						objform.chkCoreCompetency.disabled	= false;
				}
				else
				{
						// Added by MahendraV On 6:03 PM 9/3/2007 For PMLifeLine
						// To ste filter only for 30 skills
						// To changes if some skills experience is not specified
						// Start_MV_9/3/2007
						cntCheckBox							= cntCheckBox - 1;
						intCheckedArray[intIndex]			= 0;
						// End_MV_9/3/2007
						objform.cboYears.disabled			= true;
						objform.cboMonths.disabled			= true;					
						objform.cboProficiency.disabled		= true;
						objform.chkCoreCompetency.disabled	= true;
				}
			}
			else
			{
				if(objform.chkToolRequired[intIndex].checked == true)
						{
							// Added by MahendraV On 6:03 PM 9/3/2007 For PMLifeLine
							// To ste filter only for 30 skills
							// Start_MV_9/3/2007
							cntCheckBox										= cntCheckBox + 1;
							// End_MV_9/3/2007
							objform.cboYears[intIndex].disabled				= false;
							objform.cboMonths[intIndex].disabled			= false;
							objform.cboProficiency[intIndex].disabled		= false;
							objform.chkCoreCompetency[intIndex].disabled	= false;
							intCheckedArray[intIndex]						= 1;
						}
				else
						{
							// Added by MahendraV On 6:03 PM 9/3/2007 For PMLifeLine
							// To ste filter only for 30 skills
							// Start_MV_9/3/2007
							cntCheckBox										= cntCheckBox - 1;
							// End_MV_9/3/2007
							objform.cboYears[intIndex].disabled				= true;
							objform.cboMonths[intIndex].disabled			= true;
							objform.cboProficiency[intIndex].disabled		= true;
							objform.chkCoreCompetency[intIndex].disabled	= true;
							intCheckedArray[intIndex]						= 0;
						}
			}
		}
		function Show_OnClick()
			{	
				
			
				var intInd=0;
				var result="<%=m_intCheckBoxCount%>";
				var flagCheckZero = false;
				if(result == 1)
				{
				}
				else
				{
					while(intInd<=result-1)
					{
						if(intCheckedArray[intInd] == 1)
						{
							if(objform.cboYears[intInd].value == 0 && objform.cboMonths[intInd].value == 0)
							{
								flagCheckZero = true;
																				
							}
						}
						intInd++;				
					}
					
					if(flagCheckZero == true)
					{
						var vartest=confirm("For some skills experience is not specified.\nPress 'OK' to continue or 'CANCEL' to set the experience. ");
						if(vartest==false)
							return;
					}
				}	
				// Added by MahendraV On 6:03 PM 9/3/2007 For PMLifeLine
								// To ste filter only for 30 skills
				// Start_MV_9/3/2007
				if(cntCheckBox > 30)
				{
					alert("Maximum number of skills to be filter can be 30.\n Please specify filter upto 30 skills.");
					return ;
				}
				// End_MV_9/3/2007
				objform.action = "PM_EmployeeSkillsSearch.aspx?PageNumber=" + "<%=m_strPagingAlphabet%>" + "&ViewMode=" + "<%=m_strViewMode%>" + "&Mode=ApplyFilter&Action=Show" + "&MasterTagID=" + "<%=m_lngMasterTagID%>"	
				objform.submit()
		}
		function ClearFilter_OnClick()
		{
			location.href = "PM_EmployeeSkillsSearch.aspx?PageNumber=" + "<%=m_strPagingAlphabet%>" + "&ViewMode=" + "<%=m_strViewMode%>" + "&Mode=ClearFilter" +"&MasterTagID=" + "<%=m_lngMasterTagID%>"	;
			objform.submit;
		}
	
		

		
	
		</Script>
				
	</body>
</HTML>
