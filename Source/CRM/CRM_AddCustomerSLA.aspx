<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_AddCustomerSLA.aspx.vb" Inherits="PbNIT.CRM_AddCustomerSLA" %>



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

<html  >
<%  CommonFunctions.General.PlotPageHeadTag("Add Customer SLA")%>
<head runat="server">
    <title>Add Customer SLA</title>
</head>
<body class='clsBody' onload='window_onload()' onresize='window_onresize()'>
    <form id="frmAddCustomerSLA" runat="server">
     <% PageInit()%>
    </form>
     <script language="javascript">
    var CreateRowCount = 0;  
	 
    objform=GetFormReference('frmAddCustomerSLA');
	objdivlist=GetObjectReference('frmAddCustomerSLA','divPage');
	var iterator = 1;
	var IsTrue;
        IsTrue = 1;		    
	var strDepartmentHTML,strRequestTypeHTML,strSubRequestTypeHTML,strSLAHTML;		
	if(GetObjectReference('frmAddCustomerSLA','cboDepartment1'))	  
        strDepartmentHTML = GetObjectReference('frmAddCustomerSLA','cboDepartment1').innerHTML;
    if(GetObjectReference('frmAddCustomerSLA','cboRequestType1'))	 
        strRequestTypeHTML = GetObjectReference('frmAddCustomerSLA','cboRequestType1').innerHTML;		
    if(GetObjectReference('frmAddCustomerSLA','cboSubRequestType1'))	 
	    strSubRequestTypeHTML = GetObjectReference('frmAddCustomerSLA','cboSubRequestType1').innerHTML;	
	if(GetObjectReference('frmAddCustomerSLA','cboSLA1'))	 
	    strSLAHTML = GetObjectReference('frmAddCustomerSLA','cboSLA1').innerHTML;
	  
	
	 
function window_onload()
{	
		var intDivHeight ;
		var intDivHeightRisk;
		if (navigator.appName == 'Microsoft Internet Explorer')
		{
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop - 42;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objdivlist.style.height = intDivHeight;
		objdivlist.HEIGHT = intDivHeight;
		
}

function window_onresize()
{
    var intDivHeight ;
    var intDivHeightRisk;
    if (navigator.appName == 'Microsoft Internet Explorer'){
    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
    }
    else{
    intDivHeight = window.innerHeight - 42;
    }
    if (intDivHeight < 100)
	    intDivHeight = 100;
    		
    objdivlist.style.height = intDivHeight;

		 
}
function ShowSLA_OnClick()
{
    var objCustomer = GetObjectReference('frmAddCustomerSLA','cboCustomer');
     var objDeptFilter = GetObjectReference('frmAddCustomerSLA','cboDepartment');
    var CustomerID,DeptID;
    if (objCustomer.value=='')
       {
        alert('Please select the customer');
        return;
       }
      
        CustomerID=objCustomer.value;
        DeptID=objDeptFilter.value;
        objform.action='CRM_AddCustomerSLA.aspx?DrawSLATable=1&CustomerID=' + CustomerID +'&FilterDeptID='+ DeptID;
        objform.submit();
} 
function cboCustomer_onChange()
{
 var objCustomer = GetObjectReference('frmAddCustomerSLA','cboCustomer');
    var CustomerID;
    if (objCustomer.value=='')
       {
        objform.action='CRM_AddCustomerSLA.aspx?DrawSLATable=0';
        objform.submit();
        return;
       }
        CustomerID=objCustomer.value;
        objform.action='CRM_AddCustomerSLA.aspx?CustomerID=' + CustomerID;
        objform.submit();
    
}

function cboDepartmentFilter_onChange()
{
    var objCustomer = GetObjectReference('frmAddCustomerSLA','cboCustomer');
     var objDeptFilter = GetObjectReference('frmAddCustomerSLA','cboDepartment');
    var CustomerID,DeptID;
    
        CustomerID=objCustomer.value;
        DeptID=objDeptFilter.value;
        objform.action='CRM_AddCustomerSLA.aspx?DrawSLATable=1&CustomerID=' + CustomerID +'&FilterDeptID='+ DeptID;
        objform.submit();
        
}
   function Close_OnClick()
   {
    window.close();
   }
    
    function createNewRow(From)
    {
        
        CreateRowCount = parseInt(CreateRowCount) + 1;
        
	    var ctrlRole;
	    if(From==2)
	    {
	        var objTbl = GetObjectReference('frmAddCustomerSLA','CustomerSLA');
	    }
    		
        var Cnt;
        var ControlID
    			
	    ControlID = objTbl.rows.length - 2;	 	 
    	  
    	//alert(CreateRowCount);   
	    //NewTR = objTbl.insertRow(CreateRowCount + 1)
	    Cnt = objTbl.rows.length - 1;
	    NewTR = objTbl.insertRow(Cnt + 1)
	    NewTR.className = objTbl.rows[1].className;
    	 
	   // Cnt = objTbl.rows.length - 2;
	      	
	    NewTD = NewTR.insertCell(0);
	    NewTD.align='left';
	    NewTD.innerHTML = "<IMG BORDER=0 src='../../images/delete.gif' onclick = 'deleteRow(this,"+Cnt+","+From+")'>" ;//+ startImgHTML;
    	    	
	    if(From==2)
	    {
	        NewTD = NewTR.insertCell(1);
	        NewTD.align='center';
	        NewTD.innerHTML = "<SELECT id=cboDepartment" +Cnt + " name=cboDepartment"+Cnt+" class=clsComboBox style='width:200px ' onchange=cboDepartment_onChange("+Cnt+")  >" + strDepartmentHTML + "</SELECT><IMG src='../../Images/Star.gif' border=0>" ;//+ startImgHTML;
        	
	        NewTD = NewTR.insertCell(2);
	        NewTD.align='center';
	        NewTD.innerHTML = "<SELECT id=cboRequestType"+Cnt+" name=cboRequestType"+Cnt+" class=clsComboBox style='width:200px ' onchange=cboRequestType_onChange("+Cnt+")   >" + strRequestTypeHTML + "</SELECT><IMG src='../../Images/Star.gif' border=0>";// + startImgHTML;
        	
	        NewTD = NewTR.insertCell(3);
	        NewTD.align='center';
	        NewTD.innerHTML = "<SELECT id=cboSubRequestType"+Cnt+" name=cboSubRequestType"+Cnt+" class=clsComboBox style='width:220px '>" + strSubRequestTypeHTML + "</SELECT><IMG src='../../Images/Star.gif' border=0>";// + startImgHTML;
        	
	        NewTD = NewTR.insertCell(4);
	        NewTD.align='center';
	        NewTD.innerHTML = "<SELECT id=cboSLA"+Cnt+" name=cboSLA"+Cnt+" class=clsComboBox style='width:220px '>" + strSLAHTML + "</SELECT><IMG src='../../Images/Star.gif' border=0>";// + startImgHTML;
	        
	        NewTD = NewTR.insertCell(5);
	        NewTD.align='center';
	        NewTD.innerHTML = "";// + startImgHTML;
        	
	    }
    		 
    }

    function deleteRow(objImg, rowID,From)
    {   
    			 
			    if(From==2)
	            {
	                var objTbl = GetObjectReference('frmAddCustomerSLA','CustomerSLA');
	            }
    	        	
			    var rowNo=objImg.parentElement.parentElement.rowIndex
    			
			    objTbl.deleteRow(rowNo);
    		 
    			
    }
    		
           function cboDepartment_onChange(IDIndex)
        {    
             
           var objcboDepartment = GetObjectReference('frmAddCustomerSLA','cboDepartment'+IDIndex);   
           
            url= "CRM_AddCustomerSLA.aspx?FromXML=1&From=Dept&DepartmentID=" + objcboDepartment.value;
            loadXMLDoc1(url,'',IDIndex);
           
        }
        function cboRequestType_onChange(IDIndex)
        {
            var objcboRequestType = GetObjectReference('frmAddCustomerSLA','cboRequestType'+IDIndex); 
            var objcboDepartment = GetObjectReference('frmAddCustomerSLA','cboDepartment'+IDIndex);  
           
            url= "CRM_AddCustomerSLA.aspx?FromXML=1&From=RequestType&DepartmentID=" + objcboDepartment.value + "&RequestTypeID=" + objcboRequestType.value;
            loadXMLDoc1(url,'',IDIndex);
        }
         function cboSubRequestType_onChange(IDIndex)
         {
          
         }
        function loadXMLDoc1(url,reqQuery,IDIndex)	
        {  
                iterator = IDIndex;
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
        function ApplyAllSLA_OnClick()
        {
            
           var objCustomer = GetObjectReference('frmAddCustomerSLA','cboCustomer');
           var CustomerID;
           if (objCustomer!=null && objCustomer.value=='')
           {
            alert('Please select the customer');
            return;
           }
      
            CustomerID=objCustomer.value;
           // window.open ("../CRM/CRM_InheritDefaultSLA.aspx?Mode=ApplyALLSLA&CustomerID=" + CustomerID + ",," "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=700,height=250");
            window.open ("../CRM/CRM_InheritDefaultSLA.aspx?CustomerID="+ CustomerID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=700,height=250");
            
            
        }
        function Save_OnClick()
        {
            var i=1,j;
            var objDept,objRequestType,objSubRequestType,objSLA;
            var DeptID,ReqTypeID,SubReqTypeID,SLAID,FilterDeptID;
            var CombinationComparison;
            var objTbl = GetObjectReference('frmAddCustomerSLA','CustomerSLA');
            var TableRows = objTbl.rows.length;
             var objCustomer = GetObjectReference('frmAddCustomerSLA','cboCustomer');
             var objDeptFilter = GetObjectReference('frmAddCustomerSLA','cboDepartment');
             if (objCustomer!=null)
            CustomerID=objCustomer.value;  
             FilterDeptID=objDeptFilter.value;

             CombinationComparison='';
              for(i=1;i<=TableRows-2;i++)
                {
                objRequestType=GetObjectReference('','cboRequestType'+i);    
                objDept=GetObjectReference('','cboDepartment'+i);    
                objSubRequestType=GetObjectReference('','cboSubRequestType'+i);    
                objSLA=GetObjectReference('','cboSLA'+i); 
              if (objDept!=null)
              {  
                if (objDept.value=='')
                {
                   alert('Please select department');
                   objDept.focus();
                    return; 
                }   
                if (objRequestType.value=='')
                {
                   alert('Please select request type');
                   objRequestType.focus();
                    return; 
                }   
                if (objSubRequestType.value=='')
                {
                    alert('Please select sub request type');
                    objSubRequestType.focus();
                    return;
                }   
                
                if (objSLA.value=='')
                {
                    alert('Please select SLA type');
                    objSLA.focus();
                    return;
                }
               }                
              }
            for(i=1;i<=TableRows-2;i++)
            {
                objRequestType=GetObjectReference('','cboRequestType'+i);    
                objDept=GetObjectReference('','cboDepartment'+i);    
                objSubRequestType=GetObjectReference('','cboSubRequestType'+i);    
                objSLA=GetObjectReference('','cboSLA'+i); 
                objSLACombination=GetObjectReference('','cboSLACombination');
                   
                if (objDept!=null)
                {
                    
                    CombinationComparison=objDept.value+'|'+objRequestType.value+'|'+objSubRequestType.value+'|'+objSLA.value;
                    for(j=0;j<=objSLACombination.length-1;j++)
                    {
                                               
                          if (CombinationComparison ==objSLACombination.options[j].value)
                           {
                           // alert(CombinationComparison +'=='+ objSLACombination.options[j].value);
                            alert('This type of SLA is already exists/defined for this customer');
                            objSLA.focus();
                            return;
                           }
                    }
                }
            }
            CreateRowCount=CreateRowCount+2;
           //objform.action='CRM_AddCustomerSLA.aspx?CustomerID=' + CustomerID + '&Action=SAVE&NoOfRows=' + CreateRowCount;
           objform.action='CRM_AddCustomerSLA.aspx?CustomerID=' + CustomerID + '&Action=SAVE&DrawSLATable=1&NoOfRows=' + CreateRowCount +'&FilterDeptID='+ FilterDeptID;
          
            //objform.action='CRM_AddCustomerSLA.aspx?Action=SAVE';
            objform.submit();
        }
         
function DeleteRecords()
{    
    var objCustomer = GetObjectReference('frmAddCustomerSLA','cboCustomer');
     var objDeptFilter = GetObjectReference('frmAddCustomerSLA','cboDepartment');
     var objChkDelete = GetObjectReference('frmAddCustomerSLA','chkDelete');
    var CustomerID,DeptID;
    
    var blnIsRecordSelected=false;
    if (objChkDelete!=null)
    blnIsRecordSelected=IsCheckboxSelected('frmAddCustomerSLA','chkDelete');
    if (blnIsRecordSelected == false) {return;}
     CustomerID=objCustomer.value;
     DeptID=objDeptFilter.value;

    if(confirm("Are you sure, you want to delete the selected records?"))
    
    {
    objform.action='CRM_AddCustomerSLA.aspx?CustomerID=' + CustomerID + '&Action=DELETE&DrawSLATable=1&NoOfRows=' + CreateRowCount +'&FilterDeptID='+ DeptID;
    objform.submit()
    }
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
                var objCbo=GetObjectReference('','cboRequestType'+iterator);    
            }
            if(strIDsAndNames[0] == "RequestType")
            { 
                
                var objCbo=GetObjectReference('','cboSubRequestType'+iterator);    
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
} 
</script>
</body>
</html>
