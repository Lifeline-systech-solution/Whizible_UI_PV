<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DB_WhizibleToday_Filter.aspx.vb" Inherits="PbNIT.DB_WhizibleToday_Filter" %>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
		<title>PMLifelineToday Filters</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		</LINK>
		<script language='javascript' src='../General/CommonFunctions.js'></script>
	    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 

		<%CommonFunctions.General.PlotPageHeadTag("WhizibleToday Filters")%>
     <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->

<script src="../../responsive/responsive.js"></script>

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="FrmWhizibleTodayFilter" method="post" runat="server">
			<%WritePage()%>
		</form>
		<script language="Javascript">
		var objform;
		var objdivlist;

		var objcboProject;
		var objdtStartDate;
		var objdtEndDate;
		var objcboResource;
		var objcbStatus;
		var objXHttp;
		var global_strDependentCtrl;
		var global_strFrm;

		objform = GetFormReference('FrmWhizibleTodayFilter');
		objdivlist = GetObjectReference('FrmWhizibleTodayFilter','divList');

		objcboProject = GetObjectReference('FrmTrackingDetails','cboProject');
		objcboResource = GetObjectReference('FrmTrackingDetails','cboResource');
/*		objdtStartDate = GetObjectReference('FrmTrackingDetails','dtStartDate');
		objdtEndDate = GetObjectReference('FrmTrackingDetails','dtEndDate');
		objcbStatus = GetObjectReference('FrmTrackingDetails','cbPMStatus');
		
		function validate()
		{
			if (objcboProject.value == "" and objcboResource.value == "")
			{
				alert ('Select Atleast One Field.')
				return true;
			}
		}
*/		

        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
        
		function Clear_OnClick()
		{
			//Commented And Modified By JyotiG
			//Date : 17-Oct-2006
			//Purpose : Developer Dasboard Enhanced View
			//Start
			//objform.action = "DB_WhizibleToday_Filter.aspx?Action=ClearFilter&FromWhere=<%=request("FromWhere")%>";
			if ("<%=strDashBoard%>" == "DEV" )
				objform.action = "DB_WhizibleToday_Filter.aspx?Dashboard=DEV&Action=ClearFilter&FromWhere=<%=request("FromWhere")%>";
			else
				objform.action = "DB_WhizibleToday_Filter.aspx?Dashboard=PMDB&Action=ClearFilter&FromWhere=<%=request("FromWhere")%>";
				
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
			objform.submit();
			//Commented And Modified By JyotiG
			//Date : 17-Oct-2006
			//Purpose : Developer Dasboard Enhanced View
			//Start
			//window.opener.location.href= "../DB/DB_WhizibleToday.aspx?Mode=Clear&FromWhere=<%=request("FromWhere")%>&PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>" ;
			if ("<%=strDashBoard%>" == "DEV" )
				window.opener.location.href= "../DB/DB_WhizibleToday.aspx?Dashboard=DEV&Mode=Clear&FromWhere=<%=request("FromWhere")%>&PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>" ;
			else
				window.opener.location.href= "../DB/DB_WhizibleToday.aspx?Dashboard=PMDB&Mode=Clear&FromWhere=<%=request("FromWhere")%>&PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>" ;
			//End    
            //Commented And Added By Usha Pandit On 20.05.2020 For closing popup only after refreshing parent
			//window.close();
            window.onunload = refreshParent;
            //End Of Added By Usha Pandit On 20.05.2020 For closing popup only after refreshing parent
            } 
            //Commented And Added By Usha Pandit On 20.05.2020 For closing popup only after refreshing parent
            function refreshParent() {
                window.opener.location.reload();
                window.close();
            }
            //End Of Added By Usha Pandit On 20.05.2020 For closing popup only after refreshing parent
		function Apply_OnClick()
		{
			<%--if ("<%=request("FromWhere")%>" == 'PM')
			{
				var str1 = "&Project=" + objcboProject.value + "&Resource=" + objcboResource.value
			}
			else if ("<%=request("FromWhere")%>" == 'IB')
			{
				var str1 = "&Project=" + objcboProject.value + "&Resource=" + objcboResource.value
			}
			else if ("<%=request("FromWhere")%>" == 'DEL')
			{
				var str1 = "&Project=" + objcboProject.value + "&Resource=" + objcboResource.value
			}
			else if ("<%=request("FromWhere")%>" == 'RV')
			{--%>
	
			if(objcboResource !=null)//Added By JyotiG
			{
				if (objcboResource.value == 'undefined')
				{
					var str1 = "&Project=" + objcboProject.value + "&Resource="
				}
				else
				{
					var str1 = "&Project=" + objcboProject.value + "&Resource=" + objcboResource.value
				}
			//Added By JyotiG
			//Start				
			}
			else
				var str1 = "&Project=" + objcboProject.value 				
			//End				
//			}
			//Commented And Modified By JyotiG
			//Date : 17-Oct-2006
			//Purpose : Developer Dasboard Enhanced View
			//Start
			//objform.action = "DB_WhizibleToday_Filter.aspx?Action=ApplyFilter&FromWhere=<%=request("FromWhere")%>";
			if ("<%=strDashBoard%>" == "DEV" )
				objform.action = "DB_WhizibleToday_Filter.aspx?Dashboard=DEV&Action=ApplyFilter&FromWhere=<%=request("FromWhere")%>";
			else
				objform.action = "DB_WhizibleToday_Filter.aspx?Dashboard=PMDB&Action=ApplyFilter&FromWhere=<%=request("FromWhere")%>";
			//End				
			objform.submit();
			//Commented And Modified By JyotiG
			//Date : 17-Oct-2006
			//Purpose : Developer Dasboard Enhanced View
			//Start
			//window.opener.location.href= "../DB/DB_WhizibleToday.aspx?Mode=Filter&FromWhere=<%=request("FromWhere")%>&PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>"+str1 ;
			if ("<%=strDashBoard%>" == "DEV" )
				window.opener.location.href= "../DB/DB_WhizibleToday.aspx?Dashboard=DEV&Mode=Filter&FromWhere=<%=request("FromWhere")%>&PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>"+str1 ;
			else
				window.opener.location.href= "../DB/DB_WhizibleToday.aspx?Dashboard=PMDB&Mode=Filter&FromWhere=<%=request("FromWhere")%>&PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>"+str1 ;	
			//End
            //Commented And Added By Usha Pandit On 20.05.2020 For closing popup only after refreshing parent
			//window.close();
            window.onunload = refreshParent;
            //End Of Added By Usha Pandit On 20.05.2020 For closing popup only after refreshing parent
		}
		
		function Close_OnClick()
		{
			window.close();
		}
		
		function Help_OnClick()
		{
			window.open ("../General/Help.aspx?HelpID=PM%20Dashboard%20Outlook%20View%20-%20Whizible%20Today","_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
		}
		
		function onSelection(strFormName,strMainCtrl,strDependentCtrl)
		{	
				var objCbo; 
				var strUrl;
				global_strFrm = strFormName; 
				global_strDependentCtrl = strDependentCtrl;

				if(objcboProject.value == '')
				{	//Commented and Modified By JypotiG
					//objcboResource.selectedIndex=0;
					//Start_7388_01-Nov-2006
					if(objcboResource !=null)
						{
							objcboResource.selectedIndex=0;
						}	
					//End_7388_01-Nov-2006	
				}
				if (objcboProject != null)
					{
							strUrl = new String();
							strUrl = "DB_CommonPage.aspx?DependentControlName=" + strDependentCtrl + "&CboValue=" + objcboProject.value;
							if (objcboProject.selectedIndex>-1)
							{
								//INSTANTIATE XmlHttpRequest
								// Checking if IE-specific document.all collection exists 
								// TO SEE IF WE ARE RUNNING IN IE 
								if (document.all)
								{ 
									objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
									//hook the event handler
									objXHttp.onreadystatechange = HandlerOnReadyState;
									//prepare the call, http method=GET, false=asynchronous call
									objXHttp.open("GET",strUrl, false);
									//finally send the call
									objXHttp.send();          
								} 
								else 
								{ 
									// Mozilla - based browser 
									objXHttp = new XMLHttpRequest(); 
									//hook the event handler
									objXHttp.onreadystatechange = HandlerOnReadyState();
									//prepare the call, http method=GET, false=asynchronous call
									objXHttp.open("GET",strUrl, false);
									//finally send the call
									objXHttp.send(null);
								}
							}
					}
		} 


		function HandlerOnReadyState() 
		{ 
				if (objXHttp.readyState==4)
				{
					var i=0;
					var objOption;
					var strText = new String();
					var arrValue = new Array();
					var arrStr = new Array();
					if(objcboResource !=null)//Added By JyotiG
					{
						objcboResource.innerHTML = "";
						//responseXML contains an XMLDOM object
						if (objXHttp.responseText != null)
						{
							strText = objXHttp.responseText;
							if (strText.indexOf("::") != -1) 
							{
								strText = strText.substring(0, strText.indexOf("::"));
							}
							arrStr = strText.split("|");
						}
						for (i=0; i<arrStr.length; i++)
						{
							objOption = new Option();
							arrValue = arrStr[i].split("->");
							objOption.text =  arrValue[0];
							objOption.value = arrValue[1];
							objcboResource.add(objOption);
							objOption = null;
						}
					}//Added By jyotiG						
				}
		} 


		function GetXmlHttpObject()
		{
			var objXMLHttp=null;
			if (window.XMLHttpRequest)
			{
				objXMLHttp=new XMLHttpRequest();
			}
			else if (window.ActiveXObject)
			{
				objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
			return objXMLHttp;
		} 	
		
				
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;	
			objcboProject.focus();					
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;		
		}

	
		</script>
	</body>
</HTML>
