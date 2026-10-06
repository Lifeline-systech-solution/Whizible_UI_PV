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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_InformativeSections.aspx.vb" Inherits="Whiz.PB_InformativeSections" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_InformativeSections", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout" class="clsTreeBody">
		<form id="frmInformativeSections" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
			var objdivlist;
			var objFrm;
			var objSelectedRow="";
			objFrm=GetFormReference('frmInformativeSections')
			objdivlist=GetObjectReference('frmInformativeSections','myDiv')
			
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
			
			
			
			function getParameter(queryString,parameterName)
			{
				// Add "=" to the parameter name (i.e. parameterName=value)
				var parameterName = parameterName + "=";
				if ( queryString.length > 0 )
				{
					// Find the beginning of the string
					begin = queryString.indexOf ( parameterName );
					// If the parameter name is not found, skip it, otherwise return the value
					if ( begin != -1 )
					{
						// Add the length (integer) to the beginning
						begin += parameterName.length;
						// Multiple parameters are separated by the "&" sign
						end = queryString.indexOf ( "&" , begin );
						if ( end == -1 )
						{
							end = queryString.length
						}
						// Return the string
						return unescape ( queryString.substring ( begin, end ) );
					}
						// Return "null" if no parameter has been found
						return "null";
				}
			}

			
			
			function SelectRow(RowID,IDValue,QueryStringParamName)
			{
			
				//Check if no row is selected or same row selected
				if (objSelectedRow != "")
				{
					//Deselect previous row
					objSelectedRow.className = "clsTREven";					
				}
				objSelectedRow=GetObjectReference('frmInformativeSections',RowID);
				objSelectedRow.className="clsTROdd";
				var strIDValue;
				strIDValue=IDValue;
				var strQueryStringParamName=QueryStringParamName;
				
				var framesetQuery = "";
				if(window.top.location.search != 0)
				{
				framesetQuery = window.top.location.search;
				} 
				else
				{
				framesetQuery = "?OpenFrameset";
				}
				var paramFromElement=getParameter(framesetQuery,'FromElement');
				var paramTagID=getParameter(framesetQuery,'TagID');
				//alert(paramTagID);
				var paramSubTagID=getParameter(framesetQuery,'SubTagID');
				var paramTitle=getParameter(framesetQuery,'TITLE');
				//alert(paramTitle);
				
				if(strQueryStringParamName=='ActionID')
				{
					//alert(paramTitle);
					if(paramFromElement=='Tag')
					{
						//alert(paramTagID);
						parent.frVerticalRight.location.href="PB_ActionProperties.aspx?ActionID="+ strIDValue + "&FromElement=" + paramFromElement + "&TagID=" + paramTagID + "&TITLE=" + paramTitle;
					}
					else(paramFromElement=='SubTag')
					{
						parent.frVerticalRight.location.href="PB_ActionProperties.aspx?ActionID="+ strIDValue + "&FromElement=" + paramFromElement + "&SubTagID=" + paramSubTagID + "&TITLE=" + paramTitle;
					}
				}
				else if(strQueryStringParamName=='GraphID')
				{
					parent.frVerticalRight.location.href="PB_GraphProperties.aspx?GraphID="+ strIDValue + "&TITLE=" + paramTitle;
				}
				else if(strQueryStringParamName=='RelatedDataID')
				{
					parent.frVerticalRight.location.href="PB_RelatedDataProperties.aspx?RelatedDataID="+strIDValue + "&TITLE=" + paramTitle;
				}
				//strSelectedSubTagID=SubTagID;
				//Open Canvas in rightside frame
				//parent.frVerticalRight.location.href="PB_TabCanvas.aspx?strQueryStringParamName=" + strIDValue;
			}
			
			
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
				if (intDivHeight < 100)
					intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';
					
				var framesetQuery = "";
				if(window.location.search != 0)
				{
				//framesetQuery = window.top.location.search;
				framesetQuery=window.location.search;
				} 
				else
				{
				framesetQuery = "?OpenFrameset";
				}
				
				//var paramDisplaySection=getParameter(framesetQuery,'DisplaySection');
				//var paramFromElement=getParameter(framesetQuery,'FromElement');]
				
				var paramFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
				var paramDisplaySection=GetObjectReference('frmInformativeSections','paramDisplaySection');
				//Modified By NileshD on 6 Nov. 2004
				if(paramFromElement.value=='Tag' || paramFromElement.value == 'SubTag')
				{
					if(paramDisplaySection.value=='A')
					{
					var objSection2 = document.getElementById("Section2");
						if(objSection2!=null)
						{
							ShowHide_Section2();
						}
						
						var objSection3 = document.getElementById("Section3");
						if(objSection3!=null)
						{
							ShowHide_Section3();
						}
				}
				 
				else if(paramDisplaySection.value=='G')	
					{
						var objSection1 = document.getElementById("Section1");
						if(objSection1!=null)
						{
							ShowHide_Section1();
						}
						
						var objSection3 = document.getElementById("Section3");
						if(objSection3!=null)	
						{
							ShowHide_Section3();
						}
					}
				else if(paramDisplaySection.value=='R')
					{
						var objSection1 = document.getElementById("Section1");
						if(objSection1!=null)
						{
							ShowHide_Section1();
						}
						
						var objSection2 = document.getElementById("Section2");
						if(objSection2!=null)
						{
						ShowHide_Section2();
						}
					}
				}
				
				//var paramFromElement;
				//paramFromElement=getParameter(framesetQuery,'FromElement');
			}
			
			
			function MenuLink_OnClick(straction)
			{
				if(straction=='DELETE1')
				{
					//var paramFromElement=getParameter(framesetQuery,'FromElement');
					//var paramTagID=getParameter(framesetQuery,'TagID');
					//var paramSubTagID=getParameter(framesetQuery,'SubTagID');
					
					var objParamFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
					var paramFromElement
					if (objParamFromElement != null)
						paramFromElement = getInputValue(objParamFromElement);
					
					var objRowCount;
					var rowCount;
					var rowCounter;
					var objDelete;
					objRowCount = GetObjectReference('frmInformativeSections','rowCount'+1);
					objDelete = GetObjectReference('frmInformativeSections','chkDeleteAction',1);
					if (objRowCount != null)
						rowCount = getInputValue(objRowCount);
					else
						rowCount = -1;
					if (rowCount != -1)
					{
						if (GetObjectReference('frmInformativeSections','chkDeleteAction') != null)
						{
							for(rowCounter=0; rowCounter<rowCount; rowCounter++)
							{
								if (objDelete[rowCounter].checked == true)
								{	
									if(paramFromElement=='Tag')
									{
										if(window.confirm("You are about to delete selected records. Click OK to delete the records."))
										{
											var objParamTagID=GetObjectReference('frmInformativeSections','paramTagID');
											var paramTagID;
											paramTagID = getInputValue(objParamTagID);
											var objform;
											objform=GetFormReference('frmInformativeSections');
											objform.action = "PB_InformativeSections.aspx?Action=ActionLinks&"+"FromElement=" + paramFromElement + "&TagID=" + paramTagID + "&DisplaySection=A"
											parent.frVerticalRight.location.href="PB_Instructions.aspx?FromWhere=InformativeSections";
											objform.submit();
										}
									}
									else if(paramFromElement=='SubTag')
									{
										if(window.confirm("You are about to delete selected records. Click OK to delete the records."))
										{	
											var objParamSubTagID=GetObjectReference('frmInformativeSections','paramSubTagID');
											var paramSubTagID;
											paramSubTagID = getInputValue(objParamSubTagID);
											var objform;
											objform=GetFormReference('frmInformativeSections');
											objform.action = "PB_InformativeSections.aspx?Action=ActionLinks" + "&FromElement=" + paramFromElement + "&SubTagID=" + paramSubTagID + "&DisplaySection=A"
											parent.frVerticalRight.location.href="PB_Instructions.aspx?FromWhere=InformativeSections";
											objform.submit();
										}
									}
									break;
								}
							}
						}
					}
				}	
				else if(straction=='DELETE2')
				{
					//alert(paramTagID);
					var objRowCount;
					var rowCount;
					var rowCounter;
					var objDelete;
					objRowCount = GetObjectReference('frmInformativeSections','rowCount'+2);
					objDelete = GetObjectReference('frmInformativeSections','chkDeleteGraph',1);
					if (objRowCount != null)
						rowCount = getInputValue(objRowCount);
					else
						rowCount = -1;
						
					var objParamFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
					var paramSubTagID=GetObjectReference('frmInformativeSections','paramSubTagID');
					
					if (rowCount != -1)
					{
						for(rowCounter=0; rowCounter<rowCount; rowCounter++)
						{
							if (objDelete[rowCounter].checked == true)
							{	
								if(window.confirm("You are about to delete selected records. Click OK to delete the records."))
								{
									var objform;
									objform=GetFormReference('frmInformativeSections');
									var paramTagID=GetObjectReference('frmInformativeSections','paramTagID');
									if (objParamFromElement.value == 'Tag')
									   {objform.action = "PB_InformativeSections.aspx?Action=Graphs" + "&DisplaySection=G" + "&FromElement=Tag" + "&TagID=" + paramTagID.value;}
									else if (objParamFromElement.value == 'SubTag')
									   {objform.action = "PB_InformativeSections.aspx?Action=Graphs" + "&DisplaySection=G" + "&FromElement=SubTag" + "&SubTagID=" + paramSubTagID.value;}
									parent.frVerticalRight.location.href="PB_Instructions.aspx?FromWhere=InformativeSections";
									objform.submit();	
								}
								break;
							}
						}
					}
				}
				else if(straction=='DELETE3')
				{
					var objRowCount;
					var rowCount;
					var rowCounter;
					var objDelete;
					objRowCount = GetObjectReference('frmInformativeSections','rowCount'+3);
					objDelete = GetObjectReference('frmInformativeSections','chkDeleteRelatedData',1);
					if (objRowCount != null)
						rowCount = getInputValue(objRowCount);
					else
						rowCount = -1;
						
					var objParamFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
					var paramSubTagID=GetObjectReference('frmInformativeSections','paramSubTagID');
					if (rowCount != -1)
					{
						for(rowCounter=0; rowCounter<rowCount; rowCounter++)
						{
							if (objDelete[rowCounter].checked == true)
							{	
								if(window.confirm("You are about to delete selected records. Click OK to delete the records."))
								{
									//alert(TagID);
									var objform;
									objform=GetFormReference('frmInformativeSections');
									var paramTagID=GetObjectReference('frmInformativeSections','paramTagID');
									if (objParamFromElement.value == 'Tag')
										{objform.action = "PB_InformativeSections.aspx?Action=RelatedData" + "&DisplaySection=R" + "&FromElement=Tag" + "&TagID=" + paramTagID.value;}
									else if (objParamFromElement.value == 'SubTag')
										{objform.action = "PB_InformativeSections.aspx?Action=RelatedData" + "&DisplaySection=R" + "&FromElement=SubTag" + "&SubTagID=" + paramSubTagID.value;}
									parent.frVerticalRight.location.href="PB_Instructions.aspx?FromWhere=InformativeSections";
									objform.submit();	
								}
								break;
							}
						}
					}
				}
			}
			
			
			
			function Menu_OnClick(straction)
			{
				//Modified By NileshD on 6 Nov. 2004
				var paramFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
				var paramTagID=GetObjectReference('frmInformativeSections','paramTagID');
				var paramTitle=GetObjectReference('frmInformativeSections','paramTitle');
				var paramSubTagID=GetObjectReference('frmInformativeSections','paramSubTagID');
				
				if(straction=='ADD_NEW1')
				{
					
					
					if(paramFromElement.value=='Tag')
					{
						parent.frVerticalRight.location.href="PB_ActionProperties.aspx?TagID="+ paramTagID.value + "&TITLE=" + paramTitle.value + "&FromElement=" + paramFromElement.value;
					}
					else if(paramFromElement.value=='SubTag')
					{
						parent.frVerticalRight.location.href="PB_ActionProperties.aspx?SubTagID="+paramSubTagID.value + "&TITLE=" + paramTitle.value + "&FromElement=" + paramFromElement.value;
					}
				}
				else if(straction=='ADD_NEW2')
				{
					if(paramFromElement.value=='Tag')
					{
						parent.frVerticalRight.location.href="PB_GraphProperties.aspx?" + "TITLE=" + paramTitle.value + "&TagID=" + paramTagID.value + "&FromElement=" + paramFromElement.value;
					}
					else if(paramFromElement.value=='SubTag')
					{
						parent.frVerticalRight.location.href="PB_GraphProperties.aspx?SubTagID="+paramSubTagID.value + "&TITLE=" + paramTitle.value + "&FromElement=" + paramFromElement.value;
					}
				}
				else if(straction=='ADD_NEW3')
				{
					if(paramFromElement.value=='Tag')
					{
						parent.frVerticalRight.location.href="PB_RelatedDataProperties.aspx?" + "TITLE=" + paramTitle.value + "&TagID=" + paramTagID.value + "&FromElement=" + paramFromElement.value;
					}
					else if(paramFromElement.value=='SubTag')
					{
						parent.frVerticalRight.location.href="PB_RelatedDataProperties.aspx?SubTagID="+paramSubTagID.value + "&TITLE=" + paramTitle.value + "&FromElement=" + paramFromElement.value;
					}
				}
			}
			function ShowGrid_Click1()
			{
								
				var paramFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
				var paramTitle=GetObjectReference('frmInformativeSections','paramTitle');
				var style = CentralizeWindow(800, 400) + "resizable=yes,scrollbar=yes,toolbar=no,location=no,directories=no,status=no,menubar=no"
				if(paramFromElement.value=='Tag')
				{
					var paramTagID=GetObjectReference('frmInformativeSections','paramTagID');
					window.open("PB_ActionLinksGridView.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value,"ActionsGridView", style);
				}
				else if(paramFromElement.value=='SubTag')
				{
					var paramSubTagID=GetObjectReference('frmInformativeSections','paramSubTagID');
					window.open("PB_ActionLinksGridView.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value,"ActionsGridView", style);
				}
			}
			function ShowGrid_Click2()
			{
								
				var paramFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
				var paramTitle=GetObjectReference('frmInformativeSections','paramTitle');
				var style = CentralizeWindow(800, 400) + "resizable=yes,scrollbar=yes,toolbar=no,location=no,directories=no,status=no,menubar=no"
				
				if(paramFromElement.value=='Tag')
				{	
					var paramTagID=GetObjectReference('frmInformativeSections','paramTagID');
					window.open("PB_GraphGridView.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value,"GraphGridView", style);
				}
				else if(paramFromElement.value=='SubTag')
				{
					var paramSubTagID=GetObjectReference('frmInformativeSections','paramSubTagID');
					window.open("PB_GraphGridView.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value,"GraphGridView", style);
				}
			}
			function ShowGrid_Click3()
			{
								
				var paramFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
				var paramTitle=GetObjectReference('frmInformativeSections','paramTitle');	
				var style = CentralizeWindow(800, 400) + "resizable=yes,scrollbar=yes,toolbar=no,location=no,directories=no,status=no,menubar=no"
				if(paramFromElement.value=='Tag')
				{
					var paramTagID=GetObjectReference('frmInformativeSections','paramTagID');
					window.open("PB_RelatedDataGridView.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value,"RelatedDataGridView",style);
				}
				else if(paramFromElement.value=='SubTag')
				{
					var paramSubTagID=GetObjectReference('frmInformativeSections','paramSubTagID');
					window.open("PB_RelatedDataGridView.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value,"RelatedDataGridView",style);	
				}
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
		
			function SyatemPool_OnClick(ProjectSpecific,SubTagLink,PageType)
			{
				var paramFromElement=GetObjectReference('frmInformativeSections','paramFromElement');
				var paramTagID=GetObjectReference('frmInformativeSections','paramTagID');
				var paramSubTagID=GetObjectReference('frmInformativeSections','paramSubTagID');
				var parentTagID=GetObjectReference('frmInformativeSections','parentTagID');
				var style = CentralizeWindow(600, 550) + "resizable=yes,scrollbar=yes,toolbar=no,location=no,directories=no,status=no,menubar=no"
				if(paramFromElement.value=='Tag')
				{window.open("../General/CommonList.aspx?FromWhere=SM&MasterTagID=1544&IsProjectSpecific=" + ProjectSpecific + "&IsSubTagLink=" + SubTagLink + "&PageType=" + PageType + "&Tag=" + paramTagID.value + "&ParentTag=0" ,"",style);}
				else if(paramFromElement.value=='SubTag')
				{window.open("../General/CommonList.aspx?FromWhere=SM&MasterTagID=1544&IsProjectSpecific=" + ProjectSpecific + "&IsSubTagLink=" + SubTagLink + "&PageType=" + PageType + "&Tag=" + paramSubTagID.value + "&ParentTag=" + parentTagID.value ,"",style);}
			}
			
		</script>
	</body>
</HTML>
