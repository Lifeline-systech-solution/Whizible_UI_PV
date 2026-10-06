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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_ControlList.aspx.vb" Inherits="Whiz.PB_ControlList" %>

<!DOCTYPE HTML>
<HTML>
		<% MyBase.InitializeResources("Resources.PB_ControlList", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body class="clsTreeBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()" style="overflow-y:auto;">   <%-- Puneet M ON 27-11-2015 overflow-y --%>
		<form id="frmControlList" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
			var objdivlist;
			var objSelectedRow="";
			var objFromElement;
			var fromElement;
			var objTagSubTagID;
			var tagSubTagID;
			objdivlist=GetObjectReference('frmControlList','outerDiv');
			objFromElement = GetObjectReference('frmControlList', 'fromElement');
			fromElement = getInputValue(objFromElement);
			objTagSubTagID = GetObjectReference('frmControlList','tagSubTagID');
			tagSubTagID = getInputValue(objTagSubTagID);
			function window_onresize()		
			{
				
				var intDivHeight ;
				var intDivHeightRisk;
								intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
						if (intDivHeight < 100)
					intDivHeight = 100;
						

			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
						objdivlist.style.height = intDivHeight + 'px';

			}
			
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var objSection;
				var objRowCount;
				var row;
				var framesetQuery = "";
				var paramDisplaySection;
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
				if (intDivHeight < 100)
					intDivHeight = 100;

			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';

				if (window.top.location.search != 0)
					framesetQuery = window.top.location.search;
				else
					framesetQuery = "?OpenFrameset";
				paramDisplaySection = getParameter(framesetQuery,'DisplaySection');
				//Modified ReqID - WAF3_PB_48 NinadP
				if (paramDisplaySection == 'H')
				{
				    if ('<%=m_strSectionID%>'=='1')
				        ShowHide_Section2();
				    else if('<%=m_strSectionID%>'=='5')
				        ShowHide_Section1();
				    else
					    ShowHide_Section2();
			    }
				else if (paramDisplaySection == 'F')	
					ShowHide_Section1();
				try 
				    { 
    				    ShowHide_Section3(); 
                    } 
                    catch ( e ) 
                    { 
                    } 
               //End Modification By - Ninad : Req ID - WAF3_PB_48 : Dt 23 May 2007
			}
			function getParameter(queryString,parameterName)
			{
				var parameterName = parameterName + "=";
				if ( queryString.length > 0 )
				{
					begin = queryString.indexOf ( parameterName );
					if ( begin != -1 )
					{
						begin += parameterName.length;
						end = queryString.indexOf ( "&" , begin );
						if ( end == -1 )
						{
							end = queryString.length
						}
						return unescape ( queryString.substring ( begin, end ) );
					}
					return "null";
				}
			}
			function SelectControlTag(RowID, uniqueID)
			{
				var fromElement;
				if (objSelectedRow != "")
					objSelectedRow.className = "clsTREven";					
				objSelectedRow=GetObjectReference('frmControlList',RowID);
				objSelectedRow.className="clsTROdd";
				if (window.top.location.search != 0)
					framesetQuery = window.top.location.search;
				else
					framesetQuery = "?OpenFrameset";
				fromElement = getParameter(framesetQuery,'FromElement');
				if (fromElement == 'Tag')
				{
					parent.frVerticalRight.location.href="PB_ControlProperties.aspx?FromElement=Tag&" + "ControlTagID=" + uniqueID;
				}
				else
				{
					parent.frVerticalRight.location.href="PB_ControlProperties.aspx?FromElement=SubTag&" + "SubControlTagID=" + uniqueID;
				}
			}
			
			function Menu_OnClick(MenuID)
			{
				var objForm;
				var objAction;
				var objControlType;
				var objSection;
				var objrowCount;
				var rowCount = 0;
				var row;
				var check = true;
				var objSelect;
				objForm = GetFormReference('frmControlList');
				objAction = GetObjectReference('frmControlList','action');
				objControlType = GetObjectReference('frmControlList','controlType');
				
				<%MyBase.InitializeResources("Resources.PB_CommonValidations", "Resources")%>				
				if (MenuID == 'ADD')
				{
					objRowCount =  GetObjectReference('frmControlList','rowCountAvailControls');
					objSelect = GetObjectReference('frmControlList','chkSelect',1);
					objSection = GetObjectReference('frmControlList', 'cboSection',1);
					if(objRowCount != null)
						rowCount = getInputValue(objRowCount);
					if (GetObjectReference('frmControlList','chkSelect') != null)
					{
						for(rowCounter=0; rowCounter<=rowCount; rowCounter++)
						{
							if (objSelect[rowCounter].checked == true)
							{
								if (fromElement == 'Tag')
								{
									for(row=0; row<=rowCount; row++)
									{
										if(objSelect[row].checked == true)
										{
											if(disallowBlank(objSection[row],'<%=MyBase.GetResourceString("DISALLOW_BLANK")%>',true)== true)
											{
												check = false;
												break;
											}
										}
									}
								}
								if (check == true)
								{
									if (fromElement == 'Tag')
									{
										for(row=0; row<=rowCount; row++)
										{
											if(objSelect[row].checked == false)
												objSection[row].disabled = true;
										}
									}
									if(objAction != null)
									{
										objAction.value = 'Add';
										objForm.submit();
									}
								}
								break;
							}
						}
					}
				}
				else 
				{
					objAction.value = 'Insert';
					objControlType.value = MenuID;
					objForm.submit();
					objAction.value = 'none';
				}
			}
			function Save_OnClick(section)
			{
				var objSection;
				var objAction;
				var objForm;
				var objRowCount;
				var rowCount;
				objSection = GetObjectReference('frmControlList','section');
				objAction = GetObjectReference('frmControlList','action');
				objRowCount = GetObjectReference('frmControlList','rowCountHeaderFooter' + section);
				if (objRowCount != null)
					rowCount = getInputValue(objRowCount);
				else
					rowCount = -1;
				objForm = GetFormReference('frmControlList');
				objSection.value = section;
				objAction.value = 'Save';
				if (rowCount != -1)
					objForm.submit();
			}
			function GridView_Click()
			{
				var framesetQuery = "";
				var style;
				if(window.top.location.search != 0)
				{
					framesetQuery = window.top.location.search;
				} 
				else
				{
					framesetQuery = "?OpenFrameset";
				}
				var paramFromElement=getParameter(framesetQuery,'FromElement')
				var paramSubTagID=getParameter(framesetQuery,'SubTagID');
				var paramTagID=getParameter(framesetQuery,'TagID')
				
				if(fromElement=='Tag')
				{
					style = CentralizeWindow(800, 600) + ",resizable=yes,scrollbar=yes,toolbar=no,location=no,directories=no,status=no,menubar=no"
					window.open("PB_ControlGridView.aspx?FromElement=" + fromElement + "&TagID=" + tagSubTagID,"ControlsGridView",style);
				}
				else if(fromElement=='SubTag')
				{
					style = CentralizeWindow(850, 600) + ",resizable=yes,scrollbar=yes,toolbar=no,location=no,directories=no,status=no,menubar=no"
					window.open("PB_ControlGridView.aspx?FromElement=" + fromElement + "&SubTagID=" + tagSubTagID,"ControlsGridView",style);
				}
			}
			<% 'Added By UmeshJ May 11, 2007 WAF3_PB_44 START %>
			function TabControls_OnClick()
			{
			    var style;
				if(fromElement=='Tag')
				{
					style = CentralizeWindow(710, 475) + ",resizable=yes,scrollbar=no,toolbar=no,location=no,directories=no,status=no,menubar=no" //Modified By Ninad on 18 Mar 2008, WAF3_PB_62 - UI Design Template
					window.open("../General/SmartNavigation.aspx?MasterTagID=1853&FromWhere=SM&Is_SubTag=0&TagID=" + tagSubTagID,"TabControls",style);
				}
				else if(fromElement=='SubTag')
				{
					style = CentralizeWindow(710, 475) + ",resizable=yes,scrollbar=no,toolbar=no,location=no,directories=no,status=no,menubar=no" //Modified By Ninad on 18 Mar 2008, WAF3_PB_62 - UI Design Template
					window.open("../General/SmartNavigation.aspx?MasterTagID=1853&FromWhere=SM&Is_SubTag=1&TagID=" + tagSubTagID,"TabControls",style);
				}			
			}
			<% 'Added By UmeshJ May 11, 2007 WAF3_PB_44 END %>
			function cboSection_OnChange(row)
			{
				var objSection;
				var objSelect;
				objSection = GetObjectReference('frmControlList','cboSection',1);
				objSelect = GetObjectReference('frmControlList','chkSelect',1);
				if (objSection[row].value != "")
					objSelect[row].checked = true;
				else
					objSelect[row].checked = false;
			}
			
			function chkSelect_OnClick(row)
			{
				var objSection;
				var objSelect;
				objSection = GetObjectReference('frmControlList','cboSection',1);
				objSelect = GetObjectReference('frmControlList','chkSelect',1);
				if (objSelect[row].checked == false)
					objSection[row].selectedIndex = -1;
				else
					objSection[row].selectedIndex = 1;
			}
			
			function SelectAll_OnClick()
			{
				var objRowCount;
				var rowCounter;
				var totalRowCount;
				objRowCount = GetObjectReference('frmControlList','rowCountAvailControls');
				if (objRowCount != null)
					totalRowCount = getInputValue(objRowCount);
				else
					totalRowCount = 0;
				//Commented By NileshD on 21 Sept. 2004
				//TO resolve the issue if only one entry is present and click on 'Select ALL' it is not selected
				//if (totalRowCount != 0)
				//{
					var objSelect = GetObjectReference('frmControlList','chkSelect',1);
					var objSection = GetObjectReference('frmControlList','cboSection',1);
					for(rowCounter=0; rowCounter <= totalRowCount; rowCounter++)
					{
						objSelect[rowCounter].checked = true;
						if (GetObjectReference('frmControlList','cboSection') != null)
							objSection[rowCounter].value = 1;
					}
				//}
			
			}
			function CentralizeWindow(width, height)
			{
				var styleHeightWidth;
				var left;
				var top;
				left = 512-(width/2);
				top = 350-(height/2);
				styleHeightWidth = "height=" + height + ",width=" + width + ",left=" + left + ",top=" + top;
				return styleHeightWidth;
			}
			function Sort_OnClick(SortBy, SortOrder)
			{
				var objForm = GetFormReference('frmControlList');
				var objFromElement = GetObjectReference('frmControlList', 'fromElement');
				var objTagSubTagID = GetObjectReference('frmControlList', 'tagSubTagID');
				var objControlNameSortOrder = GetObjectReference('frmControlList', 'controlNameSortOrder');
				//objForm.Action = "PB_ControlList.aspx?FromElement=" + objFromElement.value + "&TagID=" + objTagSubTagID.value + "&SubTagID=" + objTagSubTagID.value; 
				GetObjectReference('frmControlList', 'SortBy').value = SortBy;
				GetObjectReference('frmControlList', 'SortOrder').value = SortOrder;
				objForm.submit();
			}
			
		</script>
	</body>
</HTML>

