<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_ValidationRules.aspx.vb" Inherits="PbNIT.IB_ValidationRules"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%PlotPageHeader()%>
    <%CommonFunctions.General.PlotPageHeadTag("")%>
   
	<body MS_POSITIONING="GridLayout" class="clsBody val-body" onresize="window_onresize()" onload="window_onload()" onunload="window_onunload()">
		<form id="frmValidationRules" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
			var strValidationRules = "Close";
			var objForm = GetFormReference('frmValidationRules');
			var objdivlist = GetObjectReference('frmValidationRules','divList');
			
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
			function window_onload()
			{
				var intDivHeight ;
				//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168			 
				 
				if(navigator.appName == 'Netscape')
				{
				intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
				}
				else
				{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
						// Let the minimum height of the div tag be 100
				objdivlist.style.height = intDivHeight + 'px';		
			}
			
			function window_onresize()		
			{
				var intDivHeight;
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
				if (intDivHeight < 100 )
					intDivHeight = 100;	// Let the minimum height of the div tag be 100
				
				objdivlist.style.height = intDivHeight +'px';		
			}
			
			function window_onunload()
			{
				window.returnValue= strValidationRules;
			}
			
			function SetValidation()
			{
				 
				 //frmCustomeFields
				var objValidationCheckbox, i, j;
				
				objValidationCheckbox = GetObjectReference('frmValidationRules', 'chkApply', true);
				 
				strValidationRules = "";
				for(i=0; i < objValidationCheckbox.length; i++)
				{	
					if (objValidationCheckbox[i].checked == true )
					{
						if (objValidationCheckbox[i].value == 3)
						{					
							for (j = 0; j < objValidationCheckbox.length; j++)
							{
								if ((objValidationCheckbox[j].checked == true ) &&  (objValidationCheckbox[j].value == 9))
								{
									alert(replaceSubstring("<%=MyBase.GetResourceString("NUMDATA_AND_ONLY_ALPHABETS")%>", "&#39;","'"));
									return;
								}
								if ((objValidationCheckbox[j].checked == true ) &&  (objValidationCheckbox[j].value == 13))
								{
									alert(replaceSubstring("<%=MyBase.GetResourceString("NUMDATA_AND_POSIIVE_NUMDATA")%>", "&#39;","'"));
									return;
								}						
							}
						}
						if (objValidationCheckbox[i].value == 9)
						{
							
							for (j = 0; j < objValidationCheckbox.length; j++)
							{
								if ((objValidationCheckbox[j].checked == true ) &&  (objValidationCheckbox[j].value == 13))
								{
									alert(replaceSubstring("<%=MyBase.GetResourceString("ONLY_ALPHABETS_AND_POSITIVE_NUMDATA")%>", "&#39;","'"));
									return;
								}
							}
						}				
						strValidationRules = strValidationRules	+ objValidationCheckbox[i].value + ",";
					}			
				}
				if((isSubstringExists("," + strValidationRules, "18")== true) ||	//Value Range Validation
				   (isSubstringExists("," + strValidationRules, "17")== true) ||	//Max Value Validation
				   (isSubstringExists("," + strValidationRules, "16")== true))	//Min Value Validation
				{
					if(isSubstringExists("," + strValidationRules, "3")==false)	//Numeric Data Validation
					{
						strValidationRules = "3," + strValidationRules;
					}
				}
				//Modified By VidyaJ - Browser Issue - IssueID - 809 
				//For netscape the else condition is written as showModalDialog does not work
				if (window.showModalDialog)
				{
					window.returnValue= strValidationRules;
				}
				else
				{	
				 
					//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168	
					 
				    //if(window.opener.document.forms[0].name == 'frmTaskCustomFields')
				    //Added By Vidya J ON 26 July 2016 For Fujitsu Issue Fixing
				    if (window.opener.document.forms.frmTaskCustomFields != null || typeof window.opener.document.forms.frmTaskCustomFields !== 'undefined')
				        //if(window.opener.document.forms[0].name == 'frmTaskCustomFields')
				        //End Of Added By Vidya J ON 26 July 2016 For Fujitsu Issue Fixing

					{
						var objCustomFields=GetParentObjectReference('frmTaskCustomFields','txtValidationRules');
					 
				    }
				        // Added By Vidya J ON 26 July 2016 For Fujitsu Issue Fixing
				        //Added By Bharat Tekade on 14th-July-2016 for NSDL Issue Fixing	
				    else if (window.opener.document.forms.frmIssueCustomFields != null || typeof window.opener.document.forms.frmIssueCustomFields !== 'undefined') {
				        var objCustomFields = GetParentObjectReference('frmIssueCustomFields', 'txtValidationRules');
				    }
				        //End of Added By Bharat Tekade on 14th-July-2016 for NSDL Issue Fixing		
				        //End Of Added By Vidya J ON 26 July 2016 For Fujitsu Issue Fixing

					else
					{
						var objCustomFields=GetParentObjectReference('frmCustomeFields','txtValidationRules');
					 
					}
					 
					//window.opener.document.forms['frmCustomeFields'].elements['txtValidationRules'].value=strValidationRules;
					//var objCustomFields=window.opener.document.forms['frmCustomeFields'].elements['txtValidationRules'];
					//var objCustomFields=GetParentObjectReference('frmTaskCustomFields','txtValidationRules');
					 
				    objCustomFields.value = strValidationRules;
				    //Added By Vidya J ON 26 July 2016 For Fujitsu Issue Fixing
				    //Added By Bharat Tekade on 12th-July-2016 for NSDL Issue Fixing
				    window.opener.txtValidationRules_OnPropertyChange();
				    //End of Added By Bharat Tekade on 12th-July-2016 for NSDL Issue Fixing
				    //End Of Added By Vidya J ON 26 July 2016 For Fujitsu Issue Fixing
					 
				}
				//End Modification
				 
				window.close() ;
			}
			
			function Close_OnClick()
			{
				window.close(); 
			}
		</script>
	</body>
</HTML>
<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    .val-body {border: none !important;padding: 0px !important;margin: 0px !important;}
#frmValidationRules > table.clsTable.topInnerMenu > tbody > tr, #frmValidationRules > table.clsTable.footerMenuTable {background: #fff;}
#frmValidationRules #tblCap00 > tbody > tr {background-color: #4263c1;padding: 10px 5px 10px 15px !important;color: #fff;display: table-cell;}
#frmValidationRules #tblCap00 > tbody > tr > td {font-size: 16px !important;}
#frmValidationRules div#divList {width: 97% !important; margin: 0 auto;}
#frmValidationRules #divList > table > thead > tr {background: #e7edf0 !important;color: #464a4c;font-weight: 600 !important;}
#frmValidationRules #divList > table > thead > tr > th {padding: 8px;font-size: 14px !important;}
#frmValidationRules #divList > table > thead > tr > th:first-child {text-align:left;}
#frmValidationRules #divList > table > tbody > tr > td {padding: 8px !important;}
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
