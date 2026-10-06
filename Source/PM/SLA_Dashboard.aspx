<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SLA_Dashboard.aspx.vb" Inherits="PbNIT.SLA_Dashboard" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
    <%--'=====================================================================
    ' Page Name             : SLA_Dashboard
    ' Purpose               : 
    ' Description           : 
    ' Parameters Passed     : 
    ' Returns               : 
    ' Parameters Affected   : 
    ' Assumptions           : 
    ' Dependencies          : 
    ' Author                : Amit Mahadik
    ' Created               : 28th January 2013
    ' Revisions             : 
    '=====================================================================--%>
<HTML>

<head>

<style type="text/css">
{TABLE
{TABLE-LAYOUT: fixed;}
THEAD TH.divListTag {POSITION: relative;}
THEAD TH.divListTag.locked {POSITION: relative;}
THEAD TH.divListTag {Z-INDEX:10; ; TOP:expression(document.getElementById('divContainer').scrollTop -1)}


THEAD TH.clsTDSortColHeader {POSITION: relative;}
THEAD TH.clsTDSortColHeader.locked {POSITION: relative;}
THEAD TH.clsTDSortColHeader {Z-INDEX:10; ; TOP:expression(document.getElementById('divContainer').scrollTop -1)}


TR.clsTHHeaderSLA
{
	padding-right: 1pt;
	padding-left: 1pt;
	padding-bottom: 1pt;
	padding-top: 1pt;
	font-weight: normal;
	font-size: 11px;
	color: black;
	font-family: Verdana, Arial;
	height: 22px;
	background-color: #EEECE1;
	border:1px solid black;

}
.clsTDHeaderSLA
{
	padding-right: 1pt;
	padding-left: 1pt;
	padding-bottom: 1pt;
	padding-top: 1pt;
	font-weight: bold;
	font-size: 11px;
	color: black;
	font-family: Verdana, Arial;
	height: 22px;
	background-color: #EEECE1;
	border-right:1px solid black;
	text-align: center;
}
.clsTDHeaderTitleSLA
{
	padding-right: 1pt;
	padding-left: 1pt;
	padding-bottom: 1pt;
	padding-top: 1pt;
	font-weight: bold;
	font-size: 11px;
	color: black;
	font-family: Verdana, Arial;
	height: 22px;
	background-color: #EEECE1;
	border-right:1px solid black;
	border-bottom:1px solid black;
	text-align: center;
}
TR.clsTRRow
{
	padding-right: 1pt;
	padding-left: 1pt;
	padding-bottom: 1pt;
	padding-top: 1pt;
	font-weight: normal;
	font-size: 11px;
	color: black;
	font-family: Verdana, Arial;
	height: 22px;
	border:1px solid black;
}
.clsTDWhite
{
	padding-right: 1pt;
	padding-left: 1pt;
	padding-bottom: 1pt;
	padding-top: 1pt;
	font-weight: normal;
	font-size: 11px;
	color: black;
	font-family: Verdana, Arial;
	height: 22px;
	background-color: #FFFFFF;
	border-right:1px solid black;
	border-top:1px solid black;
}
.clsTDPink
{
	padding-right: 1pt;
	padding-left: 1pt;
	padding-bottom: 1pt;
	padding-top: 1pt;
	font-weight: normal;
	font-size: 11px;
	color: black;
	font-family: Verdana, Arial;
	height: 22px;
	background-color: #F2DDDC;
	border-right:1px solid black;
	border-top:1px solid black;
	text-align: center;
}
.clsTDGreen
{
	padding-right: 1pt;
	padding-left: 1pt;
	padding-bottom: 1pt;
	padding-top: 1pt;
	font-weight: normal;
	font-size: 11px;
	color: black;
	font-family: Verdana, Arial;
	height: 22px;
	border-right:1px solid black;
	border-top:1px solid black;
	background-color: #D7E4BC;
	text-align: center;
}
.clsTableSLA
{
    FONT-SIZE: 10pt;
    FONT-FAMILY: Verdana, Arial;
    BACKGROUND-IMAGE: none;
    BACKGROUND-REPEAT: repeat;
    BACKGROUND-COLOR: transparent; 
	border:1px solid black;
}
</style>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        width: 35%;
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
	<%PlotHead()%>
	<body MS_POSITIONING="GridLayout" class=clsBody onload="window_onload()" onresize="window_onresize()" >

		<form id="frmSLA_Dashboard" method="post" runat="server" name="frmSLA_Dashboard">
       
			<%DrawPage()%>
		
		</form>
 
	
<script language=javascript>
	

	
	var objdivContainer = GetObjectReference('frmSLA_Dashboard','divContainer');

	
	
	//2 Main Sections of frmSLA_Dashboard 
    //Default all Expanded
	var imgSummaryShowHide1 = GetObjectReference('','imgSummaryShowHide1');   
    var divSection1 = GetObjectReference('','divSection1');      
	        imgSummaryShowHide1.src='../../Images/minus.gif';         
            divSection1.style.display='';
            imgSummaryShowHide1.setAttribute("Collapse","Y");
            
    var imgSummaryShowHide2 = GetObjectReference('','imgSummaryShowHide2');   
    var divSection2 = GetObjectReference('','divSection2');      
	        imgSummaryShowHide2.src='../../Images/minus.gif';         
            divSection2.style.display='';
            imgSummaryShowHide2.setAttribute("Collapse","Y");
            

		
	function HideDiv(strDivName, strLabelName)
	{		
		var objDiv;
		var objLabel;
		objDiv = GetObjectReference('frmSLA_Dashboard',strDivName);
		objLabel = GetObjectReference('frmSLA_Dashboard',strLabelName);
		
		objDiv.style.visibility = "hidden";
		objDiv.style.display = "none";
		objLabel.style.color = "#000000";		
	}
	
	function ShowDiv(strDivName, strLabelName)
	{	
		var strSelectedColor = "#000000";
		var objDiv;
		var objLabel;
		objDiv = GetObjectReference('frmSLA_Dashboard',strDivName);
		objLabel = GetObjectReference('frmSLA_Dashboard',strLabelName);
		
		if (objDiv.style.visibility == "hidden")
		{
			objDiv.style.visibility = "visible";
			objDiv.style.display = "block";			
			objLabel.style.color = strSelectedColor;
		}
		else
		{
			objDiv.style.visibility = "hidden";
			objDiv.style.display = "none";					
			//objLabel.style.color = "#FFFFFF";
		}				
	
	}

	
	function window_onload() 
	{	

	   	
	   	        ObjTd=GetObjectReference('','tdTree');
                ObjImg=GetObjectReference('','ImgShowHide');
                ObjLeftnavigation=GetObjectReference('','tblLeftNavigation');
                  
                if(ObjTd!=null && ObjImg!=null)
                {
                    
                        ObjTd.style.display='none';
                        ObjImg.src='../../Images/Home/RightMove.gif';
                        ObjLeftnavigation.style.display='';
                }
	   	
	   	
	    auto_reload();
		var intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop - 30;
	
		if (intDivHeight < 100) 
			intDivHeight = 100;	// Let the minimum height of the div tag be 100
			
		objdivContainer.style.height = intDivHeight;
		//if (objdivInner!=null)
		//objdivInner.style.height=intDivHeight-45;		
		
	}
	
	function window_onresize()		
	{
		var intDivHeight; 
		intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop - 30;
		if (intDivHeight < 100) intDivHeight = 100;	// Let the minimum height of the div tag be 100
		objdivContainer.style.height = intDivHeight
	}	
		
    function ShowDescription_onClick(imgSummaryShowHideID,SectionID,FromWhere)
    {  
    
        var objImg = GetObjectReference('',imgSummaryShowHideID);   
        var objDiv = GetObjectReference('',SectionID);                
        var IsCollapse = objImg.getAttribute("Collapse");  
        
	                ExpandCollapse(imgSummaryShowHideID,SectionID,FromWhere);

    }

    function ExpandCollapse(imgSummaryShowHideID,SectionID,FromWhere)
    {
        var objImg = GetObjectReference('',imgSummaryShowHideID);   
        var objDiv = GetObjectReference('',SectionID);                
        var IsCollapse = objImg.getAttribute("Collapse");     
        if(IsCollapse=="Y")
            {   
                  Collapse(objImg,objDiv);
            }
            else if(IsCollapse=="N")
            {   
                  Expand(objImg,objDiv);
            }    
    }
    
    function Expand(objImg,objDiv)
    {
                objImg.src='../../Images/minus.gif';          
                objDiv.style.display='';            
                objImg.setAttribute("Collapse","Y");
    }
    
    function Collapse(objImg,objDiv)
    {
                objImg.src='../../Images/plus.gif';         
                objDiv.style.display='none';
                objImg.setAttribute("Collapse","N");
    }
    
function RequestToCurrentSLADashboard()
{
    var strUrl = "../PM/PM_XMLHttp.aspx?TagID=-1&Mode=SLA&ProjectName=" + "0";
    var strResult = GetCurrentSLADashboard(strUrl);
    var divSection1 = GetObjectReference('','divSection1'); 
    divSection1.innerHTML=strResult;
    
    //RequestToListofOpenIncidentsByProject();
    
    auto_reload(); 
   //alert(strResult);
}
var brw = isIE();

function GetCurrentSLADashboard(url)
{
    // TO SEE IF WE ARE RUNNING IN IE 
				var strResult;				
	            strNavigator = navigator.appName;
				strNavigator = strNavigator.toUpperCase();
    //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')  Commented and added by Nilesh g on 10/12/2015
				if (brw == "IE")
				{ 
					g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
					//hook the event handler
					g_objXHttp.onreadystatechange = state_change_SLA_Dashboard;
					//prepare the call, http method=GET, false=asynchronous call
					g_objXHttp.open("GET",url, false);
					//finally send the call
					g_objXHttp.send();
				}
				else
				{
				
					// Mozilla - based browser , Netscape
					g_objXHttp = new XMLHttpRequest();
					//hook the event handler
					g_objXHttp.onreadystatechange = state_change_SLA_Dashboard;
					//prepare the call, http method=GET, false=asynchronous call
					g_objXHttp.open("GET",url, false);
					//finally send the call
					g_objXHttp.send(null);
				}	
				if ( g_objXHttp.responseText != null)
				{
					//xmlDoc= document.implementation.createDocument("","",null);
					//xmlDoc.async=false;
					
					//xmlDoc.load(g_objXHttp.responseXML);
					strResult = g_objXHttp.responseText;																						
			    }
			    return strResult;	
 }

            function state_change_SLA_Dashboard() 
			{
				//debugger;
				// wait until the request is done 
				//if (req.readyState == 4) 				
				if (g_objXHttp.readyState == 4) 
				{					
			   		// Make sure request came back OK 
					//if (req.status == 200) 
					if (g_objXHttp.status == 200) 
					{				 
					    //if (window.ActiveXObject)Commented and added by Nilesh g on 10/12/2015
					    if (brw == "IE")
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
							//xmlDoc.loadXML(req.responseText);
							xmlDoc.loadXML(g_objXHttp.responseText);												
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							xmlDoc.async=false;
						    //xmlDoc.load(req.responseXML);
							if (brw == "FF")//added by Nilesh g on 10/12/2015
							xmlDoc.load(g_objXHttp.responseXML);
						}										
						//Save the Result in a Global variable
							//strResult=req.responseText;
							strResult=g_objXHttp.responseText;													
						
					}					
				}
			}
			

function auto_reload()
{
    setTimeout('RequestToCurrentSLADashboard()',300000);//TIME IN MILISECOND 5 MINUTE=300000 MILISECOND       
}
    
function HideTree()
    {

        ObjTd=GetObjectReference('frmHome','tdTree');
        ObjImg=GetObjectReference('frmHome','ImgShowHide');
        //added by purvaj
        ObjLeftnavigation=GetObjectReference('frmHome','tblLeftNavigation');
        //end adition purvaj
        
        if(ObjTd!=null && ObjImg!=null)
        {
            if(ObjImg.src.toUpperCase().match('RIGHTMOVE.GIF'))
            {
                ObjTd.style.display='';
                ObjImg.src="../../Images/Home/LeftMove.gif"//'../../Images/Home/LeftMove.gif';
                ObjLeftnavigation.style.display='none';
            }
            else
            {
                ObjTd.style.display='none';
                ObjImg.src="../../Images/Home/RightMove.gif"
                ObjLeftnavigation.style.display='';
            }
        }
        /*ObjTd=GetObjectReference('','tdDot0');
        if(ObjTd!=null)
            ObjTd.style.display='none';
            
        ObjTd=GetObjectReference('','tdDot1');
        if(ObjTd!=null)
            ObjTd.style.display='none';
            
        ObjTd=GetObjectReference('','tdDot2');
        if(ObjTd!=null)
            ObjTd.style.display='none';*/
    }
    //////////////05-02-2013
function RequestToListofOpenIncidentsByProject()
{
    var strUrl = "../PM/PM_XMLHttp.aspx?TagID=-1&Mode=OPENINCIDENTSBYPROJECT&ProjectName=" + "0";
    var strResult = GetListofOpenIncidentsByProject(strUrl);
    var divSection2 = GetObjectReference('','divSection2'); 
    divSection2.innerHTML=strResult;    
}

function GetListofOpenIncidentsByProject(url)
{
    // TO SEE IF WE ARE RUNNING IN IE 
				var strResult;				
	            strNavigator = navigator.appName;
				strNavigator = strNavigator.toUpperCase();
				if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
				{ 
					g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
					//hook the event handler
					g_objXHttp.onreadystatechange = state_change_OpenIncidentsByProject;
					//prepare the call, http method=GET, false=asynchronous call
					g_objXHttp.open("GET",url, false);
					//finally send the call
					g_objXHttp.send();
				}
				else
				{
				
					// Mozilla - based browser , Netscape
					g_objXHttp = new XMLHttpRequest();
					//hook the event handler
					g_objXHttp.onreadystatechange = state_change_OpenIncidentsByProject;
					//prepare the call, http method=GET, false=asynchronous call
					g_objXHttp.open("GET",url, false);
					//finally send the call
					g_objXHttp.send(null);
				}	
				if ( g_objXHttp.responseText != null)
				{
					//xmlDoc= document.implementation.createDocument("","",null);
					//xmlDoc.async=false;
					
					//xmlDoc.load(g_objXHttp.responseXML);
					strResult = g_objXHttp.responseText;																						
			    }
			    return strResult;	
 }

            function state_change_OpenIncidentsByProject() 
			{
				//debugger;
				// wait until the request is done 
				//if (req.readyState == 4) 				
				if (g_objXHttp.readyState == 4) 
				{					
			   		// Make sure request came back OK 
					//if (req.status == 200) 
					if (g_objXHttp.status == 200) 
					{				 
					    //if (window.ActiveXObject)Commented and added by Nilesh g on 10/12/2015
					    if (brw == "IE")
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
							//xmlDoc.loadXML(req.responseText);
							xmlDoc.loadXML(g_objXHttp.responseText);												
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							xmlDoc.async=false;
						    //xmlDoc.load(req.responseXML);
							if (brw == "FF")//added by Nilesh g on 10/12/2015
							xmlDoc.load(g_objXHttp.responseXML);
						}										
						//Save the Result in a Global variable
							//strResult=req.responseText;
							strResult=g_objXHttp.responseText;													
						
					}					
				}
			}
			
    function OpenSLAFilters(PrferenceID_PK)
	{
	    window.open("../PM/SLA_Dashboard_FilterPreferences_CommonPage.aspx?PrferenceID_PK=" + PrferenceID_PK + "&MasterTagID=20143&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1", "","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height -760)/2 + ",width=480,height=390");
	   // window.open("../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=20143&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1", "","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height -760)/2 + ",width=800,height=660");
	}


</script>
    
	</body>
</HTML>
