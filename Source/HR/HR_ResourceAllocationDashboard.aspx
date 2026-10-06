<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_ResourceAllocationDashboard.aspx.vb" Inherits="PbNIT.HR_ResourceAllocationDashboard" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>

    <%  CommonFunctions.General.PlotPageHeadTag("Resource Allocation Dashboard")%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="frmResAllocationDashboard" runat="server" method="post">
    <%PageInit()%>
    <DIV class="DtlDIV" id="DtlDIV"  style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;height:200px;POSITION: absolute; TOP: 165px;Z-INDEX:19000;background-color: white; '></DIV>
    </form>
    
    <script language="javascript">
    var objdivlist = GetObjectReference('frmRCVProjectAllocation', 'DivMain');
    var objform = GetFormReference('frmResAllocationDashboard');
    
    function window_onresize()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (navigator.appName == 'Microsoft Internet Explorer')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			}
			else
			{
				intDivHeight = window.innerHeight - 60;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
					
			objdivlist.style.height = intDivHeight +'px';
			//CallOnLoad()		
		}

		function window_onload()
		{
								
				var intDivHeight ;
				var intDivHeightRisk;
				var lc;
				if (navigator.appName == 'Microsoft Internet Explorer'){
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
				}
				else{
				intDivHeight = window.innerHeight - objdivlist.offsetTop - 60;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight;
				objdivlist.HEIGHT = intDivHeight +'px';
				//CallOnLoad()
				
		}
		
		function ApplyFilters()
		{
		    objform.action = "HR_ResourceAllocationDashboard.aspx";
		    objform.submit();
		}
		function ShowEmployees(RoleID,LocationID,FromDate,FromWhere)
		{   
		   /* var URL;
		    var objdivTblX = GetObjectReference('frmDashboard','DtlDIV');
		    URL = "HR_ResourceAllocationDashboard.aspx?FromXML=1&LocationID="+LocationID+"&FromDate="+FromDate+"&For=EmpDtls&FromWhere="+FromWhere+"&RoleID="+RoleID;
		    //mousePosition = getMousePosition(event,objdivTblX);	
		    loadXMLDoc(URL,'');*/
		    
		    window.open("HR_ResourceAllocationDashboardDetails.aspx?Location="+LocationID+"&FromDate="+FromDate+"&RoleID="+RoleID+"&FromWhere="+FromWhere,"_AllocationDetials","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=400");    
		    
		}
		
		
function getMousePosition(ev,objContextMenu)
{
	
	var intX,intY,intBottom;	  
    if (objContextMenu)
    {
   
        objContextMenu.style.display='';
        intX = ev.clientX;
        intY = ev.clientY;
        
        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
        if (intBottom - intY < objContextMenu.offsetHeight)
        {intY = intY - objContextMenu.offsetHeight;}
        
        objContextMenu.style.left = intX;
        objContextMenu.style.top = intY;
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
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
	if (parseInt(xmlhttp.readyState)==4) { 
		if (xmlhttp.status==200) {
		    
			objDiv = document.getElementById('DtlDIV');
			
			objDiv.innerHTML = xmlhttp.responseText;
			 
                                 
                                objDiv.style.width = "500px";
                                objDiv.style.width = "700px";
                                objDiv.style.left=50;
                                objDiv.style.Top=50;
                                objDiv.style.display="";
                                
                                //showRequester('DtlDIV',event);
		}
	}	
}


function showRequester(divCM,objevent){

var objdiv = GetObjectReference('',divCM);

   objdiv.style.display='';
   objdiv.style.position = 'absolute'; 
   
    //Find out how close the mouse is to the corner of the window
    var rightedge=ie5? document.body.clientWidth-event.clientX : 
        window.innerWidth-objevent.clientX
    var bottomedge=ie5? document.body.clientHeight-event.clientY : 
        window.innerHeight-objevent.clientY

    //if the horizontal distance isn't enough to accomodate the width of 
    //the context menu
    var objDivH =objdiv.offsetWidth;

    /*if (objDivH > 200)
        objDivH=200;*/
        
 
    objdiv.style.left=0;
                 
    /*if (rightedge<objDivH)
    //move the horizontal position of the menu to the left by it's width
    objdiv.style.left=ie5? 
        document.body.scrollLeft+event.clientX-objDivH : 
        window.pageXOffset+objevent.clientX-objDivH
     
    else
    //position the horizontal position of the menu where the mouse was clicked
    objdiv.style.left=ie5? document.body.scrollLeft+event.clientX : 
        window.pageXOffset+objevent.clientX*/

    //same concept with the vertical position
    if (bottomedge<objdiv.offsetHeight)
        objdiv.style.top=(ie5? 
        document.body.scrollTop+event.clientY-objdiv.offsetHeight : 
        window.pageYOffset+objevent.clientY-objdiv.offsetHeight) +10
    else
    objdiv.style.top=(ie5? document.body.scrollTop+event.clientY: 
        window.pageYOffset+objevent.clientY) + 10
        
        //(document.body.scrollTop==0 ? 100 : 0)
        
        //objdiv.style.top=objdiv.style.top-100;
    if(ie5)
        window.event.cancelBubble = true;
    else if(ns6)
        e.stopPropagation();
   
  
   return false;
  
   }
   
function Close_Click()
{
    window.close();
}

function CloseDiv()
{
    var objdivActivityDtls = document.getElementById('DtlDIV')
    
	if(objdivActivityDtls)
	objdivActivityDtls.style.display="none";
	 
}
function ShowAllocation_onClick(EmployeeID,FinancialPeriodCount)
{  
    window.open("ResourceAllocationDashbaord.aspx?Mode=RESOURCE&EmployeeId="+EmployeeID+"&FinancialType=D&FinancialPeriodCount="+FinancialPeriodCount,"_Allocation","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=400");    
}
function ExportToExcel()
   {		
        window.open("HR_ResourceAllocationDashboard.aspx?Mode=PRINT");
         
   }
   
    </script>
</body>
</html>
