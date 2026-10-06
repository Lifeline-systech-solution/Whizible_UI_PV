
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectContractBy_Sites.aspx.vb"  Inherits="PbNIT.ProjectContractBy_Sites" %>
<HTML>
	<% CommonFunctions.General.PlotPageHeadTag("Commercial Details")%>
	<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
	<body class="clsBody" onload="window_onload()" onresize="window_onresize()">
	 
		<form id="frmContractRate" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
		
									
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		
        var objform=GetFormReference('frmContractRate');
		var objDivMain=GetObjectReference('frmContractRate','divPage');	 
		
	function History_OnClick(UniqueID,ProjectID)
	{
		
		window.open ("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=2251&UniqueID="+UniqueID+"&ProjectID="+ProjectID, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=700,height=500");
		
	}
	function RateChange_OnClick(FromWhich,PKID,UniqueID)
	{
	    //Commented and Added by Yogesh J on 01-Feb-2016 to generate and pass Token
	    //if (FromWhich.toUpperCase() == 'RESOURCE')
	    //    window.open("../PRJPROFIT/ProjectProfitBy_SiteRates.aspx?From=" + FromWhich + "&EmployeeBillingInfoID" + PKID + "&EmployeeID=" + UniqueID, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800) / 2) + ",top=" + ((window.screen.height - 400) / 2) + ",width=800,height=400");
	    //else
	    //    window.open("../PRJPROFIT/ProjectProfitBy_SiteRates.aspx?From=" + FromWhich + "&RoleID=" + UniqueID, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800) / 2) + ",top=" + ((window.screen.height - 400) / 2) + ",width=800,height=400");
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'ProjectContractBy_Sites.aspx/RateChange_OnClick',
	        data: JSON.stringify({ EmployeeID: UniqueID }),
			        success: function (Result) {
			            if (FromWhich.toUpperCase() == 'RESOURCE')
			                window.open("../PRJPROFIT/ProjectProfitBy_SiteRates.aspx?Fromwhere=PM&From=" + FromWhich + "&EmployeeBillingInfoID" + PKID + "&MToken="+Result.d+"&EmployeeID=" + UniqueID, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800) / 2) + ",top=" + ((window.screen.height - 400) / 2) + ",width=800,height=400");
			            else
			                window.open("../PRJPROFIT/ProjectProfitBy_SiteRates.aspx?Fromwhere=PM&From=" + FromWhich + "&MToken=" + Result.d + "&RoleID=" + UniqueID, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800) / 2) + ",top=" + ((window.screen.height - 400) / 2) + ",width=800,height=400");
			        },
			        error: function () {
			            //   alert("Error")
			        }
			    });
	    //  End of addition by Yogesh J on on 28-MAR-2016 to validate Token
	}
	
	function window_onload()
	{
	   
	        var intDivHeight=0;

		    if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
				   // intDivHeight = window.innerHeight - objDivMain.offsetTop - 30;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 25;
				}
				else
				{
				    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 37;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 25;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
					
		        /*Commented And Added by KIRAN K K For Height Issue fixing*/
				//objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight+'px';
		        /*Commented And Added by KIRAN K K For Height Issue fixing*/
				 
			}
	  }
	  function window_onresize()		
	   {		
		    var intDivHeight;
		    if(objDivMain)
		    {
		        // intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 37;
		        intDivHeight = window.innerHeight - objDivMain.offsetTop - 25;
			    if (intDivHeight < 100) intDivHeight = 100;
		        /*Commented And Added by KIRAN K K For Height Issue fixing*/
			   // objDivMain.style.height = intDivHeight;
			    objDivMain.style.height = intDivHeight+'px';
		        /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    
		    }
	   } 
	   
	   
	   function Save_OnClick(SectionID)
	   {
			
	   
	       if(!validateControl(SectionID)) return;
	             
	       
			objform.action="../PRJPROFIT/ProjectContractBy_Sites.aspx?TabSection="+SectionID;
			objform.submit();
	   } 
	      
	   
	 function validateControl(SectionID)
	{
	
	    if(SectionID=="1")
	    {
		        var objCeilingAmount=GetObjectReference('frmContractRate','CeilingAmount');
		        var objCAPHours=GetObjectReference('frmContractRate','CAPHours');
		        var objCAPDays=GetObjectReference('frmContractRate','CAPDays');
	            
		    
				if (disallowBlank(objCeilingAmount,'&#39;CAP Amount &#39; should not be left blank.',true) )
					{return false; }		   
				if(objCeilingAmount!=null)
				{
				    if(parseFloat(objCeilingAmount.value)==0)
				    {alert('CAP Amount should be greater than zero (0) !');setFocus(objCeilingAmount); return false;}
				}	
				if (disallowNonNumeric(objCeilingAmount,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objCeilingAmount,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}	
		
	            
	            if (disallowBlank(objCAPHours,'&#39;CAP Hours &#39; should not be left blank.',true) )
					{return false; }		   
				/*if(objCAPHours!=null)
				{
				    if(parseFloat(objCAPHours.value)==0)
				    {alert('CAP Amount should be greater than zero (0) !');setFocus(objCAPHours); return false;}
				}*/	
				if (disallowNonNumeric(objCAPHours,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objCAPHours,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}
				
				 if (disallowBlank(objCAPHours,'&#39;Minumum Hours &#39; should not be left blank.',true) )
					{return false; }	
					//CAP Days	   
				
				if (disallowBlank(objCAPDays,'&#39;Minumum Days &#39; should not be left blank.',true) )
					{return false; }	
				/*if(objCAPDays!=null)
				{
				    if(parseFloat(objCAPDays.value)==0)
				    {alert('Minumum Hours should be greater than zero (0) !');setFocus(objCAPDays); return false;}
				}*/	
				if (disallowNonNumeric(objCAPDays,'Please enter only positive numeric data !',true) == true)
					{	return false;		}			
				if(disallowNegativeNumeric(objCAPDays,'Please enter only positive numeric data !',true) == true)	
				{	return false;		}
				
				
	  }
	  else if(SectionID=="2")
	  {
	        var objSelect=GetObjectReference('frmContractRate','chkSelect',true);
	        
	       for (intCtr = 0;intCtr <= objSelect.length - 1; intCtr++)
	       { 
	       /* if (disallowBlank(GetObjectReference("frmCommonPage","Name"),'&#39;Name&#39; should not be left blank.',true) )
            {return false; }
            
            if (disallowDuplicates(GetObjectReference("frmCommonPage","Name"),arrName,'&#39;Name&#39; already exists.',true,false))
            {return false; }*/
            
        

            if (disallowBlank(GetObjectReference("frmCommonPage","WorkHrs"+objSelect[intCtr].value),'&#39;Working Hours&#39; should not be left blank.',true) )
            {return false; }

            if (disallowNonNumeric(GetObjectReference("frmCommonPage","WorkHrs"+objSelect[intCtr].value),'Please enter only  numeric values !!!',true))
            {return false; }

            if (disallowValueRangeViolation(GetObjectReference("frmCommonPage","WorkHrs"+objSelect[intCtr].value),1,24,'The value of &#39;Working Hours&#39; should be in the range of (1-24).',true))
            {return false; }


            if (disallowBlank(GetObjectReference("frmCommonPage","WeekDays"+objSelect[intCtr].value),'&#39;Week Days&#39; should not be left blank.',true) )
            {return false; }

            if (disallowValueRangeViolation(GetObjectReference("frmCommonPage","WeekDays"+objSelect[intCtr].value),1,7,'The value of &#39;Week Days&#39; should be in the range of (1-7).',true))
            {return false; }

            if (disallowNonInteger(GetObjectReference("frmCommonPage","WeekDays"+objSelect[intCtr].value),'Please enter only integer value',true))
            {return false; }            
            
	        var objNormalHrs = GetObjectReference("frmCommonPage","WorkHrs"+objSelect[intCtr].value);  
            var objExtraHrs = GetObjectReference("frmCommonPage","ExtraHoursCap"+objSelect[intCtr].value);  
            var NormalHrs;  var ExtraHrs;  
            if(objNormalHrs)
            {
                if(objNormalHrs.value == "")   {NormalHrs = 0;}  else  { NormalHrs = objNormalHrs.value;} 
            }
            if(objExtraHrs)
            { 
                if(objExtraHrs.value == "")  { ExtraHrs = 0;}  else   {ExtraHrs = objExtraHrs.value;}  
            }
            if((parseFloat(NormalHrs) + parseFloat(ExtraHrs)) > 24)  
            {   alert("Total of \"Working Hours\" and \"Extra Hours Cap\" should not be greater than 24");   
            objNormalHrs.focus();  return false;  }

            if (disallowNonNumeric(GetObjectReference("frmCommonPage","ExtraHoursCap"+objSelect[intCtr].value),'Please enter only  numeric values !!!',true))
            {return false; }

           /* if (disallowValueRangeViolation(GetObjectReference("frmCommonPage","ExtraHoursCap"+objSelect[intCtr].value),1,24,'The value of &#39;Extra Hour/Day(s) Cap&#39; should be in the range of (1-24).',true))
            {return false; }*/
      }         	        
	  }
		
   
		
		return true;
	}
	function Add_OnClick(TabSectionID)
	{
	        window.open ("../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=2251&FromCL=1&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1","", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");
	}
	function SiteName_OnClick(SiteID,PKToken)
	{
	        //"&PKToken=" + PKToken  +
	        window.open ("../General/CommonPage.aspx?ProjectSiteID_PK=" + SiteID + "&PKToken=" + PKToken  + "&MasterTagID=2251&FromCL=1&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1","", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");
	}
	function Rate_OnClick(strWhich,IsOffShore)
	{
	    if(strWhich=="Role")
	        window.open ("../PRJPROFIT/RoleRateDetails_CommonList.aspx?FromWhere=PM&MasterTagId=3969&IsOffShore="+IsOffShore,"", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=900,height=400");
	    else
	        window.open ("../PRJPROFIT/ManageResourceRoleRate_CommonList.aspx?FromWhere=PM&MasterTagId=3970&IsOffShore="+IsOffShore,"", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=900,height=400");
	    
	}
	function SiteRate_OnClick(ProjectSiteID)
	{
	    window.open ("../General/CommonList.aspx?FromWhere=PM&MasterTagId=3975&ProjectSiteID="+ProjectSiteID,"", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=700,height=400");
	    
	}
	
var objaShowNote=GetObjectReference('','aShowNote');
var objdivCQ=GetObjectReference('','divCQ');

	function CloseNote_OnClick()
    {
    
    
    if(objdivCQ!=null)
    {
            objdivCQ.style.display='none';
            
    }        
        
        
    }    
    function ShowInfoNote (ev)
    {
           
        if(objdivCQ!=null)
        {
            if(objdivCQ.style.display=='none')
            {
                showmenuie('divCQ',ev);
            }   
            else
            {
                objdivCQ.style.display='none';
            }
        }       
           
    } 
    
    var ie5=document.all&&document.getElementById
    var ns6=document.getElementById&&!document.all
    
    function showmenuie(divCM,objevent){

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
        
     if (objDivH >400)
        objDivH=400;
                 
    if (rightedge<objDivH)
    //move the horizontal position of the menu to the left by it's width
    objdiv.style.left=ie5? 
        document.body.scrollLeft+event.clientX-objDivH : 
        window.pageXOffset+objevent.clientX-objDivH
     
    else
    //position the horizontal position of the menu where the mouse was clicked
    objdiv.style.left=ie5? document.body.scrollLeft+event.clientX : 
        window.pageXOffset+objevent.clientX

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
        //Commented and added by Bharat T on 13th-Oct-2015
        //if(ie5)
        //    window.event.cancelBubble = true;
        //else if(ns6)
        //    e.stopPropagation();
        var e = e || event;
        if (e) {
            e.returnValue = false;
            e.cancelBubble = true;
            e.stopPropagation();
            e.preventDefault();
        }
        //End of Commented and added by Bharat T on 13th-Oct-2015
   
  
   return false;
  
   }
   
   function ReteMethod_OnChange(obj)
   {
        var alertMsg='';
        switch (String(obj.value))
        {
            case "1":
                alertMsg+='If your changing your rate method to Person Hour then your current billing structure will change \n';
                alertMsg+='and your rate structure will consider all rates in hourly basis \n';
                alertMsg+='i.e. Suppose,one of the employee having normal rate=100 per day or per month then \n after changing to person hour it will consider 100 per hour \n';
                break;
            case "2":
                alertMsg+='If your changing your rate method to Person Day then your current billing structure will change \n';
                alertMsg+='and your rate structure will consider all rates in daily basis and total actual hours will convert into days ';
                alertMsg+='i.e. Suppose,one of the employee having normal rate=100 per hour or per month then \n after changing to person hour it will consider 100 per day \n';
                break;
            case "3":
                alertMsg+='If your changing your rate method to Person Month then your current billing structure will change \n';
                alertMsg+='and your rate structure will consider all rates in monthly basis and total actual hours will convert into months ';
                alertMsg+='i.e. Suppose,one of the employee having normal rate=100 per hour or per day then \n after changing to person hour it will consider 100 per month \n';
                break;    
                    
        }
            
        alert(alertMsg);
        //alert(alertMsg); 
   }
  
		</script>
	</body>
</HTML>
