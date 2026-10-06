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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRO_MilestoneAnalysis.aspx.vb" Inherits="PbNIT.PRO_MilestoneAnalysis"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><HTML>
	<%CommonFunctions.General.PlotPageHeadTag("PRO_MilestoneAnalysis")%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
					<form id="frmPRO_MilestoneAnalysis" method="post" runat="server">
									<%PageInit%>
					</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPRO_MilestoneAnalysis');
		var objdivlist=GetObjectReference('frmPRO_MilestoneAnalysis','PageDiv');
		
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
			
			//'Modified by ShraddhaM on Date 29 June,2006 for PMLifeLine Issue ID.4168
			/*if(navigator.appName == 'Netscape')
			{		if("<%=m_strMode%>" == 'REPMIL')
			       {	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 370;
			       }
					else 
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 12330;
			
			}*/
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
			 if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			 if (intDivHeight < 100)	intDivHeight = 100;
		    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			// objdivlist.style.height = intDivHeight;
			 objdivlist.style.height = intDivHeight +'px';
		    /*Commented And Added by KIRAN K K For Height Issue fixing*/
				}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
			 if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			 if (intDivHeight < 100)	intDivHeight = 100;
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			// objdivlist.style.height = intDivHeight;
			 objdivlist.style.height = intDivHeight+'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/ 
				}
            }	
           
            function Page_Onclick(strPageAlphabet) {
                var strMode = "<%=m_strMode%>" + '';

                if (strMode == "") {    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Page Loader
                    setFrameLoader();
                    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Page Loader
                    objform.action = "PRO_MilestoneAnalysis.aspx?PageNumber=" + strPageAlphabet + "&MasterTagID=" + "<%=m_lngMasterTagID%>"
                    objform.submit()
                }
                else if (strMode == "REPMIL") {
                    intProjectID = <%=m_intProjectID%>;
                    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Page Loader
                    setFrameLoader();
                    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Page Loader
                    objform.action = "PRO_MilestoneAnalysis.aspx?PageNumber=" + strPageAlphabet + "&MasterTagID=" + "<%=m_lngMasterTagID%>" + "&strMode=REPMIL" + "&ProjectID=" + intProjectID;
                    objform.submit()
                }

            }
            //Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
            function getUrlVars() {
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            }
            //End Of Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
		function GetMileStones(intProjectID)
        {
            //Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
            var curPageNumber = getUrlVars()["PageNumber"];
            //End Of Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
            //Commented And Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
            //Added by Chetan M on 10 Aug 2020 for Issue Fixing
            if (curPageNumber == undefined) {
                curPageNumber = '-1';
            }
            //End of Added by Chetan M on 10 Aug 2020 for Issue Fixing
            //window.location.href = "PRO_MilestoneAnalysis.aspx?strMode=REPMIL&ProjectID=" + intProjectID + "&MasterTagID=" + "<%=m_lngMasterTagID%>";
            window.location.href = "PRO_MilestoneAnalysis.aspx?strMode=REPMIL&ProjectID=" + intProjectID + "&MasterTagID=" + "<%=m_lngMasterTagID%>" + "&PageNumber=" + curPageNumber;
            //End Of Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
		}
		function Back_OnClick(strMode)
        {
            //Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
            var curPageNumber = getUrlVars()["PageNumber"];
            //End Of Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
            if (strMode == "REPMIL") {
                //Commented And Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
                <%--window.location.href = "PRO_MilestoneAnalysis.aspx?" + "&MasterTagID=" + "<%=m_lngMasterTagID%>";--%>
                window.location.href = "PRO_MilestoneAnalysis.aspx?" + "&MasterTagID=" + "<%=m_lngMasterTagID%>" + "&PageNumber=" + curPageNumber;
                //End Of Added By Usha Pandit On 18.05.2020 For Alphabet filter issue
            }
			
		}
		function MilestoneAnalysisReport(intUniqueID)
		{
			window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=" + "<%=m_lngtMilestoneAnalysisReportID%>" + "&UNIQUEID=" + intUniqueID ,"aaa","resizable=yes,width=550,height=400,left=100,top=140,status =no,titlebar=no,location=no ");
		}
		
			</Script>
		</body>
</HTML>
