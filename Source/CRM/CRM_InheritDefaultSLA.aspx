<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_InheritDefaultSLA.aspx.vb" Inherits="PbNIT.CRM_InheritDefaultSLA" %>

<!DOCTYPE HTML>
<html>

<%  CommonFunctions.General.PlotPageHeadTag("Apply default SLA")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="frmInheritDefaultSLA" runat="server" method="post">
    <%PageInit()%>
     
    </form>
    
     <script language="javascript">
    var objdivlist = GetObjectReference('frmInheritDefaultSLA', 'PageDiv');
    var objform = GetFormReference('frmInheritDefaultSLA');
    
    function window_onresize()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (navigator.appName == 'Microsoft Internet Explorer')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 260;
			}
			else
			{
				intDivHeight = window.innerHeight + 260;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
					
			objdivlist.style.height = intDivHeight + 'px';//PX Added By Nilesh g on 11/12/2015
			//CallOnLoad()		
		}

		function window_onload()
		{
								
				var intDivHeight ;
				var intDivHeightRisk;
				var lc;
				if (navigator.appName == 'Microsoft Internet Explorer'){
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 260;
				}
				else{
				intDivHeight = window.innerHeight - objdivlist.offsetTop + 260;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight + 'px';//PX Added By Nilesh g on 11/12/2015
				objdivlist.HEIGHT = intDivHeight;
				//CallOnLoad()
				
		}
		function insBlankOpt(objCbo)
        {
            objOption = new Option();
                  objOption.text =  "";
                  objOption.value = "";

            if(navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER')
                   objCbo.add(objOption);
            else
                   objCbo.add(objOption,null);
        }
		   function cboDepartment_onChange(IDIndex)
        {    
             
           var objcboDepartment = GetObjectReference('frmAddCustomerSLA','cboDepartment');   
           
            url= "CRM_InheritDefaultSLA.aspx?FromXML=1&From=Dept&DepartmentID=" + objcboDepartment.value;
            loadXMLDoc1(url,'');
           
        }
        function cboRequestType_onChange()
        {
            var objcboRequestType = GetObjectReference('frmAddCustomerSLA','cboRequestType'); 
            var objcboDepartment = GetObjectReference('frmAddCustomerSLA','cboDepartment');  
           
            url= "CRM_InheritDefaultSLA.aspx?FromXML=1&From=RequestType&DepartmentID=" + objcboDepartment.value + "&RequestTypeID=" + objcboRequestType.value;
            loadXMLDoc1(url,'');
        }
         function loadXMLDoc1(url,reqQuery)	
        {  
            
            if (window.XMLHttpRequest) {
            xmlhttp=new XMLHttpRequest();
            xmlhttp.onreadystatechange= state_Change1;
            if (ns) {xmlhttp.open('GET',url,true);
                      xmlhttp.send(null);
            }
            else {xmlhttp.open('POST',url,false);
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send(reqQuery);}
            }else if (window.ActiveXObject){
            xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
            if (xmlhttp) {xmlhttp.onreadystatechange=state_Change1;
            xmlhttp.open('POST',url,false);
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send(reqQuery);}}
        }
        function state_Change1()
        {     
            var strIDsAndNames,objOption,objCbo;

            if (parseInt(xmlhttp.readyState)==4) 
            { 
                if (xmlhttp.status==200)
                {
                
                    strIDsAndNames = xmlhttp.responseText.split("$___#");
                    
                    //alert(xmlhttp.responseText);
                    if(strIDsAndNames[0] == "Dept")
                    { 
                        var objCbo=GetObjectReference('','cboRequestType');    
                    }
                    if(strIDsAndNames[0] == "RequestType")
                    { 
                        
                        var objCbo=GetObjectReference('','cboSubrequestType');    
                    }     
                
                   // else
                    //{ 
                        
                        objCbo.innerHTML = "";
                        insBlankOpt(objCbo);
                        
                        for(var i = 1;i<strIDsAndNames.length-1;i=i+2)
                        { objOption = new Option();
                         objOption.text =  strIDsAndNames[i+1];
                         objOption.value = strIDsAndNames[i];
                         if(navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER')
                         objCbo.add(objOption);
                         else
                         objCbo.add(objOption,null);
                         
                        }
                    //}
                }
         }
        }//Function end
		function Apply_onClick()
		{
		     var DepartmentID,RequestTypeID,SubRequestTypeID;
		     var objcboDepartment = GetObjectReference('frmInheritDefaultSLA','cboDepartment');  
		     var objcboRequestType = GetObjectReference('frmInheritDefaultSLA','cboRequestType');
		     var objcboSubRequestType = GetObjectReference('frmInheritDefaultSLA','cboSubrequestType');
		        if (objcboDepartment!=null)
		        {
		            DepartmentID=objcboDepartment.value;
		        }
		        
	            if (objcboRequestType!=null)
	            {
		            RequestTypeID=objcboRequestType.value;
	            }
	            
	            if (objcboSubRequestType!=null)
	            {
	                SubRequestTypeID=objcboSubRequestType.value;
	            }
		       
		        if (objcboDepartment.value=='')
		        {
		            alert('Please select Department');
		            return;
		        }
		       
		        if (objcboRequestType.value=='')
		        {
		            alert('Please select request type');
		            return;
		        }
		        if (objcboSubRequestType.value=='')
		        {
		            alert('Please select Sub request type');
		            return;
		        }
		      
		    objform.action="CRM_InheritDefaultSLA.aspx?Action=Apply";
		    objform.submit();
		}
		
		function Close_onClick()
		{
		    window.close();
		}
		
		</script>
</body>
</html>
