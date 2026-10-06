<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResourceAllocationDashbaord.aspx.vb" Inherits="PbNIT.ResourceAllocationDashbaord" %>

<html >
	<%CommonFunctions.General.PlotPageHeadTag("Resource Allocation Dashboard")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
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
        //COMMENTED BY NILESH G ON 6/11/2015 FOR ISSUE ID 1955
      //  responsiveFooterMenu();
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
       // COMMENTED BY NILESH G ON 6/11/2015 FOR ISSUE ID 1955
        // responsiveFooterMenuResize();
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
    <form id="frmRAD"  runat="server" style="text-decoration:none ">
    <%WritePage()%>
    </form>
</body>

<script type="text/javascript">

           //disableRightClick() 

	var objform,objdivlist ;
	var g_ProjectEmployeeRoleID,g_PKToken;
	objform = GetFormReference('frmRAD');
    objdivlist=GetObjectReference('frmRAD','PageDiv')
   		
function FinancialPeriodChange()
{
    objTxtFinancialPeriodCount= GetObjectReference('frmRAD','TxtPageNo') 
    objTxtFinancialPeriodCount.value = "1";
	objtxtFromDate = GetObjectReference('frmRAD','txtFromDate'); 
    objTxtFinancialPeriodCount= GetObjectReference('frmRAD','TxtFinancialPeriodCount') 
    objTxtFinancialPeriodCount.value = 0;
    objform.submit();
}

function Navigate(PageNo)
{
    objTxtFinancialPeriodCount= GetObjectReference('frmRAD','TxtFinancialPeriodCount') 
    //objtxtFromDate = GetObjectReference('frmRAD','txtFromDate'); 
    objTxtFinancialPeriodCount.value = PageNo;
    //objtxtFromDate.value="";
    //objform.action ="ResourceAllocationDashbaord.aspx"
    objform.submit();
}

function NavigatePage(PageNo)
{
    objTxtFinancialPeriodCount= GetObjectReference('frmRAD','TxtPageNo') 
    objTxtFinancialPeriodCount.value = PageNo;
    //objtxtFromDate.value="";    
    //objform.action ="ResourceAllocationDashbaord.aspx"    
    objform.submit(); 
}

window.status='';

//window resize for Common Page
	function window_onresize()
	{
		var intDivHeight ;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
		}
		else {
            //Commented by Yogesh J on 14/12/2015 for pop up bottom line issue
		    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 10;
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;
		    //End of comment by Yogesh J 
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
				
		objdivlist.style.height = intDivHeight +'px';
    }

	function window_onload()
	{
	
		var intDivHeight ;
		var lc;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
		}
		else {
		    //Commented by Yogesh J on 14/12/2015 for pop up bottom line issue
		    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 10;
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;
            //End of comment by Yogesh J 
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px'	;
	}
    function showResourceDetails(employeeId,FinancialPeriod,FinancialPeriodCount)
    {
        objtxtFromDate = GetObjectReference('frmRAD', 'txtFromDate');
        
        //Commented and added by Nilesh g on 29-Jan-2016 to generate token
        // window.open("ResourceAllocationDashbaord.aspx?Mode=RESOURCE&EmployeeId="+employeeId+"&FinancialType="+FinancialPeriod+"&FinancialPeriodCount="+ FinancialPeriodCount ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 330)/2 + ",width=650,height=330")
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'ResourceAllocationDashbaord.aspx/GenrateURLToken_RequestShow_TaskType',
            data: JSON.stringify({ employeeId: employeeId, FinancialPeriod: FinancialPeriod, FinancialPeriodCount: FinancialPeriodCount }),
            success: function (Result) {
                 window.open("ResourceAllocationDashbaord.aspx?Mode=RESOURCE&FROM=RESOURCE&EmployeeId=" + employeeId + "&PKToken=" + Result.d + "&FinancialType=" + FinancialPeriod + "&FinancialPeriodCount=" + FinancialPeriodCount, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 330) / 2 + ",width=650,height=330")
            },
            error: function () {
                //alert("Error")
            }
        });
    }
    
 
 


    function ApplyFilter()
    {
        objTxtFinancialPeriodCount= GetObjectReference('frmRAD','TxtPageNo') 
        objTxtFinancialPeriodCount.value = "1";

        objform.submit();    
    }
    function ClearFilter()
    {
        objTxtFinancialPeriodCount= GetObjectReference('frmRAD','TxtPageNo') 
        objTxtFinancialPeriodCount.value = "1";
        
        objBusinessGroup= GetObjectReference('frmRAD','cboBusinessGroup'); 
        if (objBusinessGroup !=null)
              objBusinessGroup.selectedIndex = 0;
        objLocation= GetObjectReference('frmRAD','cboLocation'); 
        if (objLocation !=null)
               objLocation.selectedIndex = 0;
        objRole= GetObjectReference('frmRAD','cboRole') ;
        if (objRole !=null)
               objRole.selectedIndex = 0;
        objGrade= GetObjectReference('frmRAD','cboGrade') ;
        if (objGrade !=null)
               objGrade.selectedIndex = 0;
        objDeployable= GetObjectReference('frmRAD','cboDeployable'); 
        if (objDeployable !=null)
               objDeployable.selectedIndex = 0;
        objAllocation= GetObjectReference('frmRAD','cboAllocationPercentage'); 
        if (objAllocation !=null)
               objAllocation.selectedIndex = 0;

        objform.submit();  
    }
    
    
    function AdvanceFilters()
    {
        objdivFilter = GetObjectReference('frmRAD','divFilter');
        if( objdivFilter.style.display =="none")
        {
            objdivFilter.style.display="";
        }
        else
        {
            objdivFilter.style.display="none";        
        }
    }
    function KeyPressOnClick(e)
   {
        var keynum;
        var keychar;
        var numcheck;

        if(window.event) // IE
	        {
    	        keynum = e.keyCode;
	        }
        else if(e.which) // Netscape/Firefox/Opera
	        {
	            keynum = e.which;
	        }   
   
        if(keynum==13)
        {
            objTxtFinancialPeriodCount= GetObjectReference('frmRAD','TxtPageNo') 
            objTxtFinancialPeriodCount.value = "1";
            objform.submit();     
        }
   }
	//added by RohiniK on 3 Sep 09 for V2 Customization
   function ExportToExcel(EmployeeId)
   {
		var FinancialPeriod ="<%=m_FinancialPeriod%>";
       var dtFromDate = GetObjectReference('frmRAD', 'txtFromDate').value;
       //Commneted and Added by Nikhil A on 15-March-2021 for showing selected page data in Excel report
       var TxtPageNo = GetObjectReference('frmRAD', 'TxtPageNo').value;
       // window.open("ResourceAllocationDashbaord.aspx?Mode=PRINT&FromWhere=RM&MasterTagId=3982&EmployeeId=" +EmployeeId+"&FinancialType="+FinancialPeriod+"&SpecificDate="+dtFromDate);
      //End of added By Nikhil A on 15-March-2021 for showing selected page data in Excel report
		//alert("dtFromDate=" + dtFromDate);
        window.open("ResourceAllocationDashbaord.aspx?Mode=PRINT&FromWhere=RM&MasterTagId=3982&EmployeeId=" +EmployeeId+"&FinancialType="+FinancialPeriod+"&SpecificDate="+dtFromDate +"&TxtPageNo="+TxtPageNo );
   }
   //End of addition by RohiniK on 3 Sep 09 for S1 Customization    
   
   function SwitchToScheduleMode()
   {		
        window.open("../Home/ResourceGanttChartView.aspx?FromWhere=MDB", "_self");
   }
   //Added by SanaS  on 11-Sep-2009 
    function showProjectResourceDetails(ProjectEmployeeroleID,ProjectID,PKToken)
    {
        
        var strUrl; 
        g_ProjectEmployeeRoleID=ProjectEmployeeroleID;
        g_PKToken=PKToken;
	    strUrl = new String();
	    strUrl = '../General/XMLHttp.aspx?TagID=20053&ProjectID=' + ProjectID;
    		//Commented and added by Nilesh g on 21/1/2015 for window open issue						
	    //if (document.all)
	    //{ 
		//    objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
		//    objXHttp.onreadystatechange = HandlerOnReadyState; 
		//    objXHttp.open('GET', strUrl, false); 
		//    objXHttp.send();           
	    //}
	    //else  
	    //{
		//    objXHttp = new XMLHttpRequest();  
		//    objXHttp.onreadystatechange = HandlerOnReadyState(); 
		//    objXHttp.open('GET', strUrl, false);
		//    objXHttp.send(null);  
        //}
	    var Browser = isIE();
        if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
        {
            //Added By Usha Pandit On 06.04.2020 for redirecting to Resource allocation page for Save issue
            window.parent.close();
            //End Of Added By Usha Pandit On 06.04.2020 for redirecting to Resource allocation page for Save issue
            objXHttp = new ActiveXObject('Msxml2.XMLHTTP');
            objXHttp.onreadystatechange = HandlerOnReadyState;
            objXHttp.open('GET', strUrl, false);
            objXHttp.send();

            //Added By Usha Pandit On 06.04.2020 for redirecting to Resource allocation page for Save issue
            if (objXHttp.responseText != null) {
                xmlDoc = document.implementation.createDocument("", "", null);
                xmlDoc.async = false;
                if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                    xmlDoc.load(objXHttp.responseXML);
                strResult = objXHttp.responseText;

                window.open("../PM/Resources_CommonPage.aspx?ProjectEmployeeRoleId_PK=" + g_ProjectEmployeeRoleID + "&PKToken=" + g_PKToken + "&MasterTagID=1019&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&PagingNumber=1", "ResourceAllocation", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800) / 2) + ",top=" + ((window.screen.height - 600) / 2) + ",width=800,height=600", "_self");
            }
            //End Of Added By Usha Pandit On 06.04.2020 for redirecting to Resource allocation page for Save issue
        }
        else {
            //Added By Usha Pandit On 06.04.2020 for redirecting to Resource allocation page for Save issue
            if (Browser == "CR") {
                window.parent.close();
            }

            //End Of Added By Usha Pandit On 06.04.2020 for redirecting to Resource allocation page for Save issue
            objXHttp = new XMLHttpRequest();
            objXHttp.onreadystatechange = HandlerOnReadyState;
            objXHttp.open('GET', strUrl, false);
            objXHttp.send(null);
            
            if (objXHttp.responseText != null) {
                
                xmlDoc = document.implementation.createDocument("", "", null);
                xmlDoc.async = false;
                if (Browser == "FF") {
                    window.parent.close();
                }
//Commented By Usha Pandit On 16.04.2020 for Save issue on mozilla browser
                //if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                //    xmlDoc.load(objXHttp.responseXML);
//End Of Commented By Usha Pandit On 16.04.2020 for Save issue on mozilla browser
                strResult = objXHttp.responseText;
                
                //Commented And Added By Usha Pandit On 06.04.2020 for redirecting to Resource allocation page for Save issue
                //window.open('../General/CommonPage.aspx?ProjectEmployeeRoleId_PK=' + g_ProjectEmployeeRoleID + '&PKToken=' + g_PKToken + '&MasterTagID=1019&FromWhere=PM', 'ResourceAllocation', 'resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 750) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=750,height=500');
                window.open("../PM/Resources_CommonPage.aspx?ProjectEmployeeRoleId_PK=" + g_ProjectEmployeeRoleID + "&PKToken=" + g_PKToken + "&MasterTagID=1019&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&PagingNumber=1", "ResourceAllocation", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800) / 2) + ",top=" + ((window.screen.height - 600) / 2) + ",width=800,height=600", "_self");
                //End Of Added By Usha Pandit On 06.04.2020 for redirecting to Resource allocation page for Save issue

            }
        }
        //end of Commented and added by Nilesh g on 21/1/2015 for window open issue
    }
    
    function HandlerOnReadyState()
		{						
			if (objXHttp.readyState == 4)
			{
			    if (objXHttp.responseText == 'True') 				
			    
			    window.open('../General/CommonPage.aspx?ProjectEmployeeRoleId_PK='+g_ProjectEmployeeRoleID+'&PKToken='+g_PKToken+'&MasterTagID=1019&FromWhere=PM','ResourceAllocation','resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 750)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=750,height=500');																	
			}
		}
		function RefreshView()
		{
		 objform.submit(); 
		}
		
   //end addition by SanaS   on 11-Sep-2009 
   function Allocate_onClick(stremployeeid)
	{	
	   
       //Commented and added by Nilesh g on 29-Jan-2016 to generate token
       // window.open('../HR/ResourceAllocation_RAD.aspx?MODE=NEW&EmployeeID='+stremployeeid+'&FROM=RAD','ResourceAllocation','resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 750)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=650,height=350');																	
       $.ajax({
           type: 'POST',
           dataType: 'json',
           contentType: 'application/json',
           url: 'ResourceAllocationDashbaord.aspx/GenrateURLToken_EmployeeId',
           data: JSON.stringify({ stremployeeid: stremployeeid }),
           success: function (Result) {
       //        window.open("ResourceAllocationDashbaord.aspx?Mode=RESOURCE&FROM=RESOURCE&EmployeeId=" + employeeId + "&PKToken=" + Result.d + "&FinancialType=" + FinancialPeriod + "&FinancialPeriodCount=" + FinancialPeriodCount, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 330) / 2 + ",width=650,height=330")
               window.open('../HR/ResourceAllocation_RAD.aspx?MODE=NEW&PKToken=' + Result.d + '&EmployeeID=' + stremployeeid + '&FROM=RAD', 'ResourceAllocation', 'resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 750) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=650,height=350');
           },
           error: function () {
               //alert("Error")
           }
       });
	
	}
</script>
</html>

