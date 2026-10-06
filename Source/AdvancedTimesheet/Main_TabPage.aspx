<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Main_TabPage.aspx.vb" Inherits="PbNIT.Main_TabPage" %>

<html >
     <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("Main Tab View")%>

<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
   
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

<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<link rel='stylesheet' type='text/css' href='../General/tab-view.css'/>
<script language='javascript' src='../AdvancedTimesheet/timesheet.js'></script>
<body id='tab1' class='clsPopUpBody'  onresize="window_onresize()" onload="window_onload()">
		<form id="frmMain_TabPage" method="post" >
           <!-- <asp:Panel ID="Panel1" runat="server" Height="50px" Width="879px" BackColor='lightblue' style="border-bottom :lightblue 1px outset;"   >
            </asp:Panel>-->
                       
			<%PageInit()%>
			
			 <iframe name='frmSub' id='frmSub' onLoad='calcHeight()'  src='' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>
			<input type=hidden name='hidDefaultPageURL' id='hidDefaultPageURL' value=''>
    </form>
    
<script language="javascript">
    
    var objform=GetFormReference('frmMain_TabPage');
    var objDivMain=GetObjectReference('frmMain_TabPage','divGroupItems');
    var xmlhttp;
    var URL = GetObjectReference('','hidDefaultPageURL');
    var objAllTab=GetObjectReference('','atab1',true);
           
    if(GetObjectReference('frmGanttChartView','txtNoOfPages'))
		{	
			var noOfPages = GetObjectReference('frmGanttChartView','txtNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmGanttChartView','txtPageNumber');
		}
		
   function calcHeight()
	{	
	    var height=window.innerWidth;//Firefox
	    if (document.body.clientHeight)
	    {
		    height=document.body.clientHeight;//IE
	    }
    	     	
	    document.getElementById("frmSub").style.height=parseInt(height-document.getElementById("frmSub").offsetTop )+"px";
	   
	  
	}
	
	function TabGroupOnClick(GroupTabID)
	{
	    var URL='../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA&GroupTabID='+GroupTabID;
	    loadXMLDoc(URL,'')
	    
	  // objform.action='../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA&GroupTabID='+GroupTabID;
	  // objform.submit();
	}
	function TabItemOnClick(PageName,TagID,evt)
	//function TabItemOnClick(PageName)
	{
	    /*var PageNo;
	    var URL;
	     if(objtxtpageNumber!=null)
	    	     URL='../AdvancedTimesheet/Main_TabPage.aspx?IsXMLHTTP=1&FromWhere=DA&TabGroupItemID='+TabGroupItemID+"&GroupTabID="+TabGroupID+"&PageNumber="+objtxtpageNumber.value;
	     else
	             URL='../AdvancedTimesheet/Main_TabPage.aspx?IsXMLHTTP=1&FromWhere=DA&TabGroupItemID='+TabGroupItemID+"&GroupTabID="+TabGroupID;
	             	     
	     loadXMLDoc(URL,'');
	     */
	   
	     document.getElementById("frmSub").src=PageName;
	     calcHeight();
	     
	      var objTab=GetObjectReference('','atab1_'+TagID);
	     
    	  
	         if(objAllTab!=null)
	         {
    	  
	            for(i=0;i<objAllTab.length;i++)
	            {
    	        
	                objAllTab[i].className='';
	            }
	         }
	          if(objTab!=null )
	                objTab.className='selectedTab';
	     
	}
	
	function window_onresize()
    {
        calcHeight();
    }
    function window_onload()
    {
    
          /* var intDivHeight=0;

		    if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivMain.offsetTop-10 ; //130
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop-10 ;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
					
					
				objDivMain.style.height = intDivHeight;
				
			}			*/
       
			 document.getElementById("frmSub").src="<%=m_strDefaultPageURL %>";
        
             calcHeight();
    }


 function loadXMLDoc(url,reqQuery)
{
// code for Mozilla, etc.
if (window.XMLHttpRequest)
{
    xmlhttp=new XMLHttpRequest()
    xmlhttp.onreadystatechange=state_Change;
if (ns)
{
    xmlhttp.open("GET",url+"&"+reqQuery,true)
    xmlhttp.send(false)
}

else
{
    xmlhttp.open("POST",url,true)
    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlhttp.send(reqQuery)

}
}

// code for IE
else if (window.ActiveXObject)
    {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
        if (xmlhttp)
        {
            xmlhttp.onreadystatechange=state_Change
            xmlhttp.open("POST",url,true)
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send(reqQuery)
        }
    }
}

function state_Change()
{
// if xmlhttp shows "loaded"
if (xmlhttp.readyState==4)
  {
  // if "OK"
  if (xmlhttp.status==200)
  {

        if(xmlhttp.responseText!="")
        {
            objDivMain.innerHTML=xmlhttp.responseText;
   /* var URL = GetObjectReference('','hidDefaultPageURL');*/
         //document.getElementById("frmSub").src=URL.value;
        //calcHeight();
         if(objAllTab!=null)
	         {
    	  
	            for(i=0;i<objAllTab.length;i++)
	            {
    	        
	                objAllTab[i].className='';
	            }
	         }
        }
  }
  else
  {
  alert("Problem in transfering data:" + xmlhttp.statusText)
  }
  }
}
function ShowPreviousPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_Onclick(objtxtpageNumber.value);
	}
		
}

function ShowNextPage()
{
 
    
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{  
		
		if (objtxtpageNumber.value==parseInt(noOfPages)){alert("This is the last page");return;}	
			 
		objtxtpageNumber.value=parseInt(objtxtpageNumber.value) + 1;
				 
		Page_Onclick(objtxtpageNumber.value);
		 
	}
}


  function Page_Onclick(PageNumber)
		{     
			
//			// Modified by SandipL on 3 Feb 2006 
			strLocation = "Main_TabPage.aspx?IsXMLHTTP=1&PageNumber=" + String(parseInt(PageNumber));
//		
//			/*objform.action = strLocation
//			objform.submit();*/
//			
            loadXMLDoc(strLocation,'')

         //    objform.submit();
		}

	   </script>


    
</body>
</html>
