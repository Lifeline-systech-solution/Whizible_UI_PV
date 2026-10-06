<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
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
            $('.clsTable:last').css({ 'display': 'none' });
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
            $('.clsTable:last').css({ 'display': 'none' });
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RT_RowwiseApprovers.aspx.vb" Inherits="PbNIT.RT_RowwiseApprovers" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<HEAD>
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		
		<script language='javascript' src='../General/CommonFunctions.js'></script>
		<script language='javascript' src='../General/CommonValidations.js'></script>
	</HEAD>
	<BODY class=clsBody onresize=window_onresize() onload=window_onload()>
		<%If Request.QueryString("Mode") <> "SetDefaultApprover" Then %>
			<div id='Headtbl'>
				<%PlotHeader()%>
			</div>
		<script>
		
		<%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
        
		function ItemTab_OnClick(strWhich)
		{	
			if (strWhich=='Expense')
			window.location.href = '../EWF/EWF_RowwiseApprovers.aspx';	
		}		
		</script>
		<%End If%>
		<form id="frmRowwiseApprovers" name="frmRowwiseApprovers" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
		    var objDivMain = GetObjectReference('frmRowwiseApprovers', 'DivMain');
		    var objDivList = GetObjectReference('frmRowwiseApprovers', 'DivList');
		    
			var objForm;
			objForm = GetFormReference('frmRowwiseApprovers');
			var blnApproverChanged
			blnApproverChanged=false;
			var blnExternalApproverChanged
			blnExternalApproverChanged=false;
			
			<%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
			function cboApprover_onChange(intindex)
			{
				blnApproverChanged=true;
				var objcboExternalApprover = GetObjectReference('frmRowwiseApprovers','cboExternalApprover' + intindex );
				if (objcboExternalApprover != null)
					objcboExternalApprover.value = ''	;			
				//alert(blnApproverChanged);
			}
			
			function cboExternalApprover_onChange(intindex)
			{
				blnExternalApproverChanged=true;
				var objcboApprover = GetObjectReference('frmRowwiseApprovers','cboApprover' + intindex);
				if (objcboApprover != null)
					objcboApprover.value = '' 	;			
				//alert(blnApproverChanged);
			}
			
			function window_onload()		
			{
			        
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
			    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40
                //commented added by shamkant s on 19 nov 2015
			    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40 - 90;
				intDivHeight = window.innerHeight - objDivMain.offsetTop-13;
				if (intDivHeight < 100)
				intDivHeight = 100;
				objDivMain.style.height = intDivHeight + 'px';
				if (objDivList != null) {
				    objDivList.style.height = intDivHeight - 10 + 'px';
				}
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
			    //	intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				intDivHeight = window.innerHeight - objDivMain.offsetTop-13;
				if (intDivHeight < 100)
					intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objDivMain.style.height = intDivHeight;
				
				objDivMain.style.height = intDivHeight + 'px';
				if (objDivList != null)
				{
				   objDivList.style.height = intDivHeight - 10 + 'px';
				}
			}
		
			function Save_OnClick()
			{
					//alert('in');
					var intLength;
					var blnFound;
					var objApprover;
					var IsCheckBoxCheced;
					IsCheckBoxCheced = false
					blnFound ='true';
					var blnApproverSet;
					blnApproverSet = getApproverSet(); 
					
					var objNewApprover = GetObjectReference('frmRowwiseApprovers','txtNewApprover');
					if (objNewApprover.value == "")
					{
						alert('Select the New Approver');
						return;
					}
					
					var objCheckbox = GetObjectReference('frmRowwiseApprovers','chkEmployeeID',true);
					var intItems;
					var intCtr;
					
					if (objCheckbox != null)
					{
						intItems = objCheckbox.length;
						if(intItems > 1) 
						{
							for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
							{
								if (objCheckbox[intCtr].disabled == false)
								{
									if (objCheckbox[intCtr].checked == true)
									{
										IsCheckBoxCheced = true ;
										break;
									}
								}						
							}
						}
						else if(intItems == 1)
						{
							if (objCheckbox[0].disabled == false) 
							{
								if (objCheckbox[0].checked == true)
							 		IsCheckBoxCheced = true ;						
							}
						}	
					}
			
				
				
					if (IsCheckBoxCheced == false)
					{
						alert('Select atleast one employee to set approver');
						return;
					}
					
					//alert(blnApproverSet);	
					if(blnApproverChanged==true && blnApproverSet==1)
					{
						if(!window.confirm("Please check that all the previously generated timesheets are verified before changing the approver.Do you want to continue now?")) 
						{
							return;
						}	
						
					}
					if(blnFound=='true') 
					{	
						//Commented and Modified by JyotiG
						//Start_JG_11107_02-Apr-2007
						//objForm.action = "RT_RowwiseApprovers.aspx?Mode=Save&Alphabet=<%=m_strAlphabet%>"  
						objForm.action = "RT_RowwiseApprovers.aspx?Mode=Save&Alphabet=<%=Server.URLEncode(m_strAlphabet)%>"  
						//End_JG_11107_02-Apr-2007
						objForm.submit();
					}	
			}
			 
			function SetDefaultApprover_OnClick()
			{
				//Modified By VarunA on 6-July-2007 Whizible 7.0 Development & Release
				//window.open("RT_RowwiseApprovers.aspx?Mode=SetDefaultApprover","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=320,height=170")
				window.open("RT_RowwiseApprovers.aspx?Mode=SetDefaultApprover","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=500,height=170")
				//End By VarunA on 6-July-2007
			}
			
			function SaveDefaultApprover_OnClick()
			{
				    var objParent = GetParentFormReference('frmRowwiseApprovers');
				    objForm.action = "RT_RowwiseApprovers.aspx?Mode=SaveDefaultApprover"  
					objForm.submit();
					objParent.submit();
					
				    /*objParent.reload();
					objForm.action = "RT_RowwiseApprovers.aspx?Mode=SaveDefaultApprover"  
					objForm.submit();*/
					window.close();
			}
			 
			function ShowHistory_OnClick()
			{
				window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagId=<%=m_TagShowHistory%>","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			}
			
			function Paging_OnClick(str)
			{
				
				objForm.action = "RT_RowwiseApprovers.aspx?Alphabet=" + str;
				objForm.submit();	
			}
			
			function SelectAll_OnClick()
			{
				SelectAllCheckboxs('frmRowwiseApprovers','chkEmployeeID'); 
			}	
			
			function ClearAll_Click()
			{
				ClearAll_OnClick('frmRowwiseApprovers','chkEmployeeID'); 
			}
					
			function Filter_OnChange()
			{
				objForm.action = "RT_RowwiseApprovers.aspx"
				objForm.submit();
			}
			function SelectNewApprover()
			{
				window.open ("RT_SelectNewApprover.aspx", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=400");
			}
			
		</script>
	</BODY>
</HTML>
