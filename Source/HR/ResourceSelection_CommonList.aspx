<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ResourceSelection_CommonList.aspx.vb" Inherits="PbNIT.ResourceSelection_CommonList" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
    <% CommonFunctions.General.PlotPageHeadTag("Resource Selection")%>

<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
<script src="../../responsive/responsive.js"></script>


<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 12px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }

</style>
    <%--Commented and added by Yogesh J on 02-Oct-2015--%>
    <style>
#txtNumPaging1 {

    vertical-align:bottom;
    height: 20px !important;
}
        #thisIsADummyControl {
            display:none;
        }
</style>
     <%--End of addition by Yogesh J on 02-Oct-2015--%>
<script type="text/javascript">
    $(document).ready(function () {
        CL_window_onload();
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Yogesh J ON 15/12/2015 for pop up bottom issue
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Remove plus(+)in Tablet and Mobile view
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        /*Generating 'id' for table row if it has no 'id'*/
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').find('tbody').find('tr').each(function () {

            var rowIndex = $(this).index();
            var attr = $(this).attr('id');
            // For some browsers, `attr` is undefined;
            // for others, `attr` is false. Check for both.
            if (typeof attr !== typeof undefined && attr !== false) {
            }

            else {
                $(this).attr('id', 'rowId' + rowIndex);
            }
        });

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('large_visible');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').after('<div id="reviewTypeContent"></div>');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
            /*$(this).find('a').css({'display':'none'});*/
            $(this).remove();

        });
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Apply Footable For Grids
        // Description:Footable is used for responsive grids that will collapse the data into the first two columns for smaller resolutions (tablets).
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        if ($('.clsGridTable').length > 0) {
            var divName = $('#divListPageTag').find('div:first').attr('id');
            dataCollapse(divName);
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/

        responsiveTopMenu();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Apply FooTable
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
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
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:19/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/


        /* Add class to Total Record Table*/
        $('.clsBody').find('table:last').prev().prev().addClass('recordTable');


    });// Ready Function Ends

    $(window).resize(function () {
        /*window_resize_hideshowtree();*/
        CL_window_onresize();
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Yogesh J ON 15/12/2015 for pop up bottom issue
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
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();

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
            $('.clsTable:last').css({ 'display': 'block' });
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:21/01/2015
        /*---------------------------------------------------------*/

        responsiveFooterMenuResize();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });
</script>

<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>


	<body MS_POSITIONING="GridLayout" onUnload="logoutMe()">
		<form id="Form1" method="post" runat="server">
		</form>


	<script language="javascript">
			var objdivlist;
			var objform;
		
			function EmployeeName_OnClick(EmpID,EmpName,Per,JDate,ParentTagID,Address,Phone,TentJoinDt)
			{ 
			
				var str,intPer;				
				if (ParentTagID == 1019)
				{
				   
					intPer = new Number(Per);
					//Comment and addition done by SuchitraP on 15 Oct 2007
					//Resource % allocation Validation
					//intPer = 100 - intPer;
					//alert(<%=m_SettingValueResAll%>);
					intPer = <%=m_SettingValueResAll%> - intPer;
					//End of comment and modification by SuchitraP on 15 Oct 2007
					window.opener.document.forms['frmCommonPage'].elements['NonDatabase1'].value=EmpName;
					window.opener.document.forms['frmCommonPage'].elements['EmployeeID'].value=EmpID;
					window.opener.document.forms['frmCommonPage'].elements['ResourcePercentage'].value=intPer;
					window.opener.document.forms['frmCommonPage'].elements['NonDatabase3'].value=JDate;
					window.opener.document.forms['frmCommonPage'].elements['NonDatabase6'].value=TentJoinDt;
					
					//Added by Dhanashri Samudra ON 3rd April 2014
					//Purpose:Pass the current EmployeeID to the function 
					setbillable(EmpID);
					//End of Addition by Dhanashri Samudra ON 3rd April 2014
										
				}			
				// Added by SrikanthY on 03 Jan 2007 For selecting Employees from employee list screen while adding new Request
			else if (ParentTagID == 3101)
				{
				    //Commneted and added by ShraddhaM on 19,Sep 2009 to change add new functionality
				      window.opener.document.forms['frmRequestDetails'].elements['cboFunction'].value='';
				      window.opener.document.forms['frmRequestDetails'].elements['cboSubRequestType'].value='';
				      window.opener.document.forms['frmRequestDetails'].elements['cboRequestType'].value='';
				  
				    var URL = "CRM_RequestDetail.aspx?Mode=NEW&PageNumber=1&Customer=&Employee="+EmpID+"&RTVal=E&ParentTagID=0&FromList=1&FromCL=1&OnBehalfOf=EMP"
    				
				    window.opener.document.forms['frmRequestDetails'].action = URL;
				    window.opener.document.forms['frmRequestDetails'].submit();
				    
					//window.opener.document.forms['frmCommonPage'].elements['NonDatabase3'].value=EmpName;
					//window.opener.document.forms['frmCommonPage'].elements['Customer'].value=EmpID;
					//End of Commneted and added by ShraddhaM on 19,Sep 2009 to change add new functionality
					window.close();
						
				}				
				//Added By ShraddhaM on 13,July 2007 for Data CleanUp Activity
				//ParentTagID == 0 is From CRM
				//For  HelpDesk --> Request Details PAge AssignTo Link
			else if (ParentTagID == 0 && "<%=m_FromWhere%>" == "CRM")
				{
					 
					window.opener.document.forms['frmRequestDetails'].elements['cboAssignTo'].value=EmpName;
					window.opener.document.forms['frmRequestDetails'].elements['hidtxtAssignTo'].value=EmpID;
					window.close();						
				}
				//For  HelpDesk --> E-Dashboard --> Filters
				else if (ParentTagID == 0 && "<%=m_FromWhere%>" == "CRMFilters" )
				{					
					window.opener.document.forms['frmFilterDetails'].elements['txtValue'].value=EmpName;
					//window.opener.document.forms['frmFilterDetails'].elements['hidtxtAssignTo'].value=EmpID;
					
					window.close();						
				}
				//For  HelpDesk --> E-Dashboard --> Assign Multiple Requests
				else if (ParentTagID == 0 && "<%=m_FromWhere%>" == "CRMEDashboard")
				{					 
					window.opener.document.forms['frmRequestAssignment'].elements['txtAssignTo'].value=EmpName;
					window.opener.document.forms['frmRequestAssignment'].elements['cboAssignTo'].value=EmpID;
					window.close();						
				}
				//End of Addition By ShraddhaM on 13,July 2007 for Data CleanUp Activity
				//Added by ShraddhaM on 28,Nov 2007 for Soft Booking Resource Selection
				else if (ParentTagID == 3859 && "<%=m_FromWhere%>" == "SoftBooking")
				{					 
					window.opener.document.forms['frmCommonPage'].elements['NonDatabase5'].value=EmpName;
					window.opener.document.forms['frmCommonPage'].elements['EmployeeID'].value=EmpID;
					window.close();						
				}
				//End of addition by ShraddhaM on 28,Nov 2007
			else if (ParentTagID == 3851)
			{
					window.opener.document.forms['frmCommonPage'].elements['NonDatabase3'].value=EmpName;
					window.opener.document.forms['frmCommonPage'].elements['RaisedBy'].value=EmpID;
					window.close();
			}
			//Added by ShraddhaM on 18,Jan 2008 for ReportingTo Selection on Employee Maintenance Page.
			else if (ParentTagID == 23)
			{
					window.opener.document.forms[0].elements['ReportingTo'].value=EmpID;
					//window.opener.document.forms['frmCommonPage'].elements['RaisedBy'].value=EmpID;
					window.close();
			}
			//End of addition by ShraddhaM on 18,Jan 2008 for ReportingTo Selection on Employee Maintenance Page.
			//Added by SuchitraP on 5,Aug 2008 for Submitter Selection on CRM Workflow Page.
			else if (ParentTagID == 3936)
			{
					window.opener.document.forms[0].elements['CBO_Submitter'].value=EmpID;
					window.close();
			}
			//End of addition by SuchitraP on 5,Aug 2008 for Submitter Selection on CRM Workflow Page.
			///Added by ArchanaN for Tentatative joining Date on Project level resoucre allocation
			else if(ParentTagID == 1019)
			{
			  window.opener.document.forms['frmCommonPage'].elements['NonDatabase6'].value=TentJoinDt;
			}
			///Added by ArchanaN for Tentatative joining Date on Project level resoucre allocation
			else
		
			  {				 	 
				  window.opener.document.forms['frmCommonPage'].elements['NonDatabase2'].value=EmpName;
				  window.opener.document.forms['frmCommonPage'].elements['EmployeeID'].value=EmpID;
				  window.opener.document.forms['frmCommonPage'].elements['Address'].value=Address;
				  window.opener.document.forms['frmCommonPage'].elements['Telephone'].value=Phone;		  
				  window.opener.document.forms['frmCommonPage'].elements['NonDatabase3'].value=JDate;						
				  window.opener.window.loadXMLDoc('../HR/EmployeeLeaves_CommonPage.aspx','FromXML=1&EmployeeID='+EmpID);
				  window.close();
				  return;
				 
				  
				  			  
				  var objfrm;
				  var strURL;
				  var objEmployee;
				  objfrm = GetParentFormReference('frmCommonPage');   
				  objEmployee=GetParentObjectReference('frmCommonPage','NonDatabase2');   
				  objEmployee.disabled=false;
				  strURL = window.opener.location.href;
				  
					if(strURL.indexOf("&EmployeeID=") > 0)
					{
					strURL = strURL.substring(0, strURL.indexOf("&EmployeeID="));
					}
					objfrm.action = strURL + "&EmployeeID=" + EmpID;    
					objfrm.submit();   
					
					}
				 					
					window.close();		
			 				
			}
			

    function PayrollemployeeOnClick(EmployeeId,CurrencyID)
    {
		window.opener.document.forms['frmCommonPage'].elements['EmployeeID'].value=EmployeeId;
		window.opener.document.forms['frmCommonPage'].elements['CurrencyID'].value=CurrencyID;
		window.close();
    }		
		                                                
	function logoutMe()
	{              
        if(window.event.clientX < 0 && window.event.clientY < 0)
        {
            //alert("Close Button clicked");
        }
    }
    
    //Added By Dhanashri Samudra on 3rd April 2014
    //Pupose:To get the resource from current Page
    function setbillable(EmployeeID)
    {
           var strUrl = "../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&TagID=1019&Action=VAL&FromWhere=NRA&EmployeeID="+EmployeeID;     
           var strResult = ValidateResourceOnProject(strUrl); 
               
                 if(strResult == "True")
                 {
                    //window.opener.document.forms['frmCommonPage'].elements['ResourceStatus'].options[1].selected=true;
                    //window.opener.document.forms['frmCommonPage'].elements['ResourceStatus'].disabled=true;
                    
                        window.opener.document.forms['frmCommonPage'].elements['IsResourceBillable'].checked=true;
                        //window.opener.document.forms['frmCommonPage'].elements['IsResourceBillable'].disabled=true;  
                  }
                  else
                  {
                        window.opener.document.forms['frmCommonPage'].elements['IsResourceBillable'].checked=false;
                        //window.opener.document.forms['frmCommonPage'].elements['IsResourceBillable'].disabled=true;
                       
                  }
    }
    
     function ValidateResourceOnProject(url) 
    {// TO SEE IF WE ARE RUNNING IN IE 
        var strResult;
        strNavigator = navigator.appName; strNavigator = strNavigator.toUpperCase();
        var browser = WhichBrowser();
        if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
        {
            g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");	
            //hook the event handler
            g_objXHttp.onreadystatechange = state_change_del_validation;
            //prepare the call, http method=GET, false=asynchronous call
            g_objXHttp.open("GET", url, false); g_objXHttp.send();
        }
            //added By Bharat T on 13th-Oct-2015
        else if (browser == 'IE') {
            g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
            //hook the event handler
            g_objXHttp.onreadystatechange = state_change_del_validation;
            //prepare the call, http method=GET, false=asynchronous call
            g_objXHttp.open("GET", url, false);
            //finally send the call
            g_objXHttp.send();
        }
            //End of Added By Bharat T on 13th-Oct-2015
            else{// Mozilla - based browser , Netscape
            g_objXHttp = new XMLHttpRequest();
            //hook the event handler
            g_objXHttp.onreadystatechange = state_change_del_validation;
            //prepare the call, http method=GET, false=asynchronous call
            g_objXHttp.open("GET",url, false);
            //finally send the call	
            g_objXHttp.send(null);
        }
        if ( g_objXHttp.responseText != null)
        {
        //xmlDoc.load(g_objXHttp.responseXML);
        strResult = g_objXHttp.responseText;
        } 
        return strResult;
    } 
        	
        function state_change_del_validation(){if (g_objXHttp.readyState == 4) 
        {	
            if (g_objXHttp.status == 200)
                {
                //Commented and added By Bharat T on 13th-Oct-2015
                //if (window.ActiveXObject)
                if (window.ActiveXObject || "ActiveXObject" in window)
                    //End of Commented and added By Bharat T on 13th-Oct-2015
                        {
                            xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                            xmlDoc.async=false;xmlDoc.loadXML(g_objXHttp.responseText);
                        }
                    // code for Mozilla, etc.
                    else if (document.implementation && document.implementation.createDocument)
                    {
                            xmlDoc= document.implementation.createDocument("","",null);
                            xmlDoc.async=false;xmlDoc.load(g_objXHttp.responseXML);
                    }
                //Save the Result in a Global variable				
                    strResult=g_objXHttp.responseText;
             }
        }
    }
	    //End of Addition by Dhanashri Samudra ON 3rd April 2014
        //Added By Bharat T on 13th-Oct-2015
        function WhichBrowser() {

            var brwser = '';
            var ua = navigator.userAgent, tem,
            M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                //return 'IE '+(tem[1] || '');
                return 'IE';
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'CR';
            }
            else if (M[1] === 'Firefox') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'FF';
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
            //return M.join(' ');
            return brwser;
        }
        //End of Added By Bharat T on 13th-Oct-2015
			</Script>
</body>
</HTML>
