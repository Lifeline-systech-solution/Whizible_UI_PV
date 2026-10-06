<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PB_ParentTag.aspx.vb" Inherits="Whiz.PB_ParentTag" %>
<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_ParentTag", "Resources")%>
	<% CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%> 
	<body class="clsBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
					<form id="frmParentTag" method="post" runat="server">
									<%PageInit%>
					</form>
					<script language="javascript">
					GetObjectReference('frmParentTag','txtTitle').focus(); //Added by Ninad to set focus on Node name 
			var objdivlist;
			objdivlist=GetObjectReference('frmParentTag','InitialDiv')
			<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize and onload
	'WAF3_PB_42 April 13, 2007 END%>
			
						 
			function Module_OnChange()
			{
				var objForm;
				var flag;
		
				objForm = GetObjectReference('frmParentTag','frmParentTag');
				objTitle = GetObjectReference('frmParentTag','txtTitle');
				objOrderNumber = GetObjectReference('frmParentTag', 'txtOrderNumber');
				if (objOrderNumber != null)
					objOrderNumber.value = "";
				//objHidden = GetObjectReference('frmParentTag','txtInputHidden');
				//objHidden.value = "ModuleChanged";
				objForm.submit();
			}
			
			function Save_OnClick()
			{
				var objForm;
				var flag;
				var orderFlag = "True";
				objHidden = GetObjectReference('frmParentTag','txtInputHidden');
				objForm = GetObjectReference('frmParentTag','frmParentTag');
				objTitle = GetObjectReference('frmParentTag','txtTitle');
				objModules = GetObjectReference('frmParentTag','cboModules');
				objOrderNumber = GetObjectReference('frmParentTag', 'txtOrderNumber');
				objtxtTreeNodeImageName = GetObjectReference('frmParentTag', 'txtTreeNodeImageName');
				if (objOrderNumber == null)
					orderFlag = "False"
				<%MyBase.InitializeResources("Resources.PB_CommonValidations", "Resources")%>
				
				flag = disallowBlank(objTitle, "<%=MyBase.GetResourceString("DISALLOW_BLANK")%>")
				if (flag == false)
				{
					 //Req ID   :   WAF3_PB_IssueFixes 2
					flag = disallowSpecialCharacters(objTitle, "<%=MyBase.GetResourceString("DISALLOW_NON_ALPHABETS")%>",true,'[:*?+\"><|,\\\\]')
				if (flag == false)
					{
						flag = disallowBlank(objModules,  "<%=MyBase.GetResourceString("DISALLOW_BLANK")%>");
						if (flag == false)
						{
							flag = disallowBlank(GetObjectReference('frmParentTag', 'cboParentTag'), "<%=MyBase.GetResourceString("DISALLOW_BLANK")%>");
							if (flag == false)
							{
								if (orderFlag == "True")
								{
									if (ValidateOrderNumber(objOrderNumber) == false)
									{
										alert('<%=MyBase.GetResourceString("DISALLOW_NON_NUMERIC")%>');
										objOrderNumber.focus();
										return;
									}
									flag = disallowBlank(objOrderNumber,  "<%=MyBase.GetResourceString("DISALLOW_BLANK")%>");
								}
								if (flag==false)
								{
									flag = disallowSpecialCharacters(objtxtTreeNodeImageName, "<%=MyBase.GetResourceString("DISALLOW_NON_ALPHABETS")%>");
									if (flag==false)
									{
										<%MyBase.InitializeResources("Resources.PB_Resources", "Resources")%>
										//alert("<%=MyBase.GetResourceString("PAGE_CREATED")%>");
										objHidden.value="True"
										objForm.submit();
									}
								}								
							}
						}
					}
				}
			}
			//Added By Ninad Req ID WAF3_PB_48
			function Back_OnClick()
		    {
			    window.location.href = "../SM/WAF_CommonList.aspx?&MasterTagID=1058&FromWhere=SM";
		    }
		    //End Added By Ninad Req ID WAF3_PB_48
			
			function ValidateOrderNumber(obj)
			{
				var i,j;
				var valid=true;
				var found=false;
				var orderNumber = obj.value;
				var str = "0123456789.";
				
				if(orderNumber.charAt(0) == '.' || orderNumber.charAt(orderNumber.length-1) == '.')
					valid=false;
				if(valid==true && isSubstringExists(orderNumber,'..')==true)
					valid=false;
				if(valid==true)
				{
					for(i=0;i < orderNumber.length;i++)
					{
						for(j=0;j<str.length;j++)
						{
							if(orderNumber.charAt(i) == str.charAt(j))	
							{
								found=true;
								break;
							}
						}		
						if(found==true)
							found=false;
						else
						{
							valid=false;
							break;
						}
					}
				}				
				return valid;
			}
			
			function cboParentTag_OnChange()
			{
				var objForm;
				var flag;
				objForm = GetObjectReference('frmParentTag','frmParentTag');
				objOrderNumber = GetObjectReference('frmParentTag', 'txtOrderNumber');
				objOrderNumber.value = "";
				objForm.submit();
			}
					</script>
	</body>
</HTML>
