<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ResourceCalenderView.aspx.vb" Inherits="PbNIT.PM_ResourceCalenderView" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Resource Calendar View")%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	 
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added by Bharat T on 16th-Oct-2015*/
    .clsTable td
    {
           vertical-align:middle;
    }

    /*End of Added by Bharat T on 16th-Oct-2015*/
     /*Added By Vaijat K ON 23/12/2015*/
            u
            {
                cursor: pointer;
            }
    #txtMonth
    {
        width:30px !important;
    }
    #txtYear
    {
        width:40px !important;
    }
     /*Ended*/
</style>

<%--<script type="text/javascript">
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

</script>--%>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmResourceCalenderView" method="post" runat="server">
						 
									<%DrawPage()%>
							 
					</form>
				 
					<script language="javascript">
					var ProjectStartDate = "<%=ProjectStartDate%>";
					var ProjectEndDate = "<%=ProjectEndDate%>";
					
	<%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
    
	function NextMonth_clicked()
	{
		
		
		var objEmployee=GetObjectReference('frmResourceCalenderView','cboEmployee');
		
		var EmployeeID=objEmployee.value;
	
		var objtxtMonth=GetObjectReference('frmResourceCalenderView','txtMonth');
		var objtxtYear=GetObjectReference('frmResourceCalenderView','txtYear');
		var tempYear =<%=m_CurrYear%>;
		var tempMonth =objtxtMonth.value;
	
		
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
		//Modified by MrugajaB on 19th July 2006 for WhizibleSEM SP7
		//Purpose:when value 12/9999 is entered and next month clicked then page crashes
		if( tempMonth==12)
		{
			 if (objtxtYear.value==9999)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
		}	
		
		 if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
			
		//End Modification
		
		window.location.href = "PM_ResourceCalenderView.aspx?Month=" + "<%=m_intMonth+1%>"+ "&Year=" + "<%=m_intYear%>"+ "&employeeid=" + objEmployee.value   
	

	}
	
	
	function PreviousMonth_clicked()
	{try
	 {
		var objEmployee=GetObjectReference('frmResourceCalenderView','cboEmployee');
		
		var EmployeeID=objEmployee.value;
		
		var objtxtMonth=GetObjectReference('frmResourceCalenderView','txtMonth');
		var objtxtYear=GetObjectReference('frmResourceCalenderView','txtYear');
		var tempYear =<%=m_CurrYear%>;
		var tempMonth =objtxtMonth.value;
	
	
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
			
		 if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
						
		if(<%=m_intMonth%>!=1)
		{
			
			window.location.href = "PM_ResourceCalenderView.aspx?Month=" + "<%=m_intMonth-1%>"+ "&Year=" + "<%=m_intYear%>"+ "&Employeeid=" + objEmployee.value   
	
		}
		else{
			window.location.href = "PM_ResourceCalenderView.aspx?Month=" + "<%=m_intMonth+11%>"+ "&Year=" + "<%=m_intYear-1%>"+ "&employeeid=" + objEmployee.value   
	
		}
	 }
	 catch(ex){}
	}
	
function Year_OnClick(intMonth,intYear)
{
	var objOrganizationUnit=GetObjectReference('frmResourceCalenderView','cboOrganizationUnit');
	
	var objYear=GetObjectReference('frmResourceCalenderView','cboYear');
	var objMonth=GetObjectReference('frmResourceCalenderView','cboMonth');
	var objtxtOrganizationUnit=GetObjectReference('frmResourceCalenderView','txtOrganizationUnit');
	
	var txtOrganizationUnitID= objtxtOrganizationUnit.value;
	
	var OrganizationUnitID=objOrganizationUnit.value;
	
	var Year=objYear.value;
	var MonthID=objMonth.value;
	window.location.href = "PM_ResourceCalenderView.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + MonthID + "&Year=" + Year+ "&txtOrganizationUnit="+txtOrganizationUnitID 

}

function Employee_OnClick(intMonth,intYear)
{
	
	var objEmployee=GetObjectReference('frmResourceCalenderView','cboEmployee');
	
	var objtxtMonth=GetObjectReference('frmResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmResourceCalenderView','txtYear');
	
	var Year=objtxtYear.value;
	var MonthID=objtxtMonth.value;
	var EmployeeID=objEmployee.value;
	
	var tempMonth =objtxtMonth.value;
	
	
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
		
		 if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
			
	 window.location.href = "PM_ResourceCalenderView.aspx?Month=" + MonthID + "&Year=" + Year+ "&employeeid=" + objEmployee.value   
	

}

function Month_OnClick(intMonth,intYear)
{
	var objOrganizationUnit=GetObjectReference('frmResourceCalenderView','cboOrganizationUnit');
	
	var objYear=GetObjectReference('frmResourceCalenderView','cboYear');
	var objMonth=GetObjectReference('frmResourceCalenderView','cboMonth');
	var objtxtOrganizationUnit=GetObjectReference('frmResourceCalenderView','txtOrganizationUnit');
	
	var txtOrganizationUnitID= objtxtOrganizationUnit.value;
	
	var OrganizationUnitID=objOrganizationUnit.value;
	
	var Year=objYear.value;
	var Month=objMonth.value;
	window.location.href = "PM_ResourceCalenderView.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + Month + "&Year=" + Year+ "&txtOrganizationUnit="+txtOrganizationUnitID 
}




function Show_clicked()
{

	
	var objtxtMonth=GetObjectReference('frmResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmResourceCalenderView','txtYear');
	
	var ObjcboEmployee = GetObjectReference('frmResourceCalenderView','cboEmployee');
	
	
	var tempYear =<%=m_CurrYear%>;
	var tempMonth =objtxtMonth.value;
	var preYear =tempYear-1; 
	 
	if (isBlank(Trim(tempMonth))==true)
	{
		alert("'Month' can not be blank !")
		objtxtMonth.focus();
		return;
	}
		
	if (isBlank(Trim(objtxtYear.value))==true)
	{
		alert("'Year' can not be blank !")
		objtxtYear.focus();
		return;
	}
		

	if(Trim(objtxtYear.value)<= 0)
	{
		alert("Please Enter Valid Year ")
		objtxtYear.focus();
		return;
	} 
	if(Trim(tempMonth)<=0 ||Trim(tempMonth)>12 )
	{
		alert("Please enter value between '1-12' for month !")
		objtxtMonth.focus();
		return;
	}
	
	var Year=Trim(objtxtYear.value);
	var Month=Trim(objtxtMonth.value);
	
	if(isInteger(Month)==false)
	{
		alert("Please enter only numeric value for 'Month'!");
		objtxtMonth.focus();
		return;
	}
	if(isInteger(Year)==false )
	{
		alert("Please enter only numeric value for 'Year'!");
		objtxtYear.focus();
		return;
	}
	
	 if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
			
			
	 //Modified By : SujataK
     //Modified On : 6/4/2006
     //For         : Resource Calender View
     //Issue ID    : 3106  
     
	window.location.href = "PM_ResourceCalenderView.aspx?Month=" + Month + "&Year=" + Year+ "&employeeid=" + ObjcboEmployee.value   
	//End of Modification
    

}

	 
	var objdivlist=GetObjectReference('frmResourceCalenderView','divContainer');
		function window_onload()
		{
			
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
				}	
			
		    //CallOnLoadForTW()
            <%--Commented by Bharat T on 16th-Oct-2015--%>
		    //CallOnLoad() 
            <%--End of Commented by Bharat T on 16th-Oct-2015--%>
		
		}
			
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) 
			{
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;
				if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
				objdivlist.style.height = intDivHeight + 'px';
				
			}
			//CallOnLoad() 
		}	
		
		 
 
	function CallOnLoad()
			{	
			
			 
				var xl = tblHeader.offsetLeft;				
				var yt = tblHeader.offsetTop;				
				var tl = tblHeader;
				while (tl.tagName != "BODY") 
						{
							tl = tl.offsetParent;
							xl = xl + tl.offsetLeft;
							yt = yt + tl.offsetTop;
						}
				
								var headerTableRow = tblHDF.rows[0];						 			
								var originalTableRow = tblHeader.rows[0];									 
								headerTableRow.height =originalTableRow.offsetHeight;
							for (var i = 0; i < 1; i++) 
							{
								var O_Width = originalTableRow.cells[i].offsetWidth;
								var O_Height = originalTableRow.cells[i].offsetHeight;
								var In_HTML = originalTableRow.cells[i].innerHTML;							
												
								headerTableRow.cells[i].width = O_Width; 
								headerTableRow.cells[i].height = O_Height; 
								headerTableRow.cells[i].innerHTML = In_HTML; 
								headerTableRow.cells[i].align = 'center';
							}			
														   
										
								//divList.style.width = tblList.offsetWidth + 20 + 'px';
								tblHDF.style.left =xl; 
								tblHDF.style.top = yt ; //176
								tblHDF.style.position = 'absolute';
								tblHDF.style.display="block";
								
				
			}
			
	
		
		function LoadHrsDetails(intProjectID,intEmployeeID,strStartDate,strEndDate)
		{
			 
			window.open("../PM/PM_ResourceCalenderViewDetails.aspx?EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate + "&ProjectID=" + intProjectID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
			 
	
		}		
		
				
		function Close_OnClick()
		{
			window.close();
			
		}
		
		
		var objTDRolledNow;
		var objContextMenu;
		document.onmouseup=function()
		{
			objContextMenu = GetObjectReference('frmResourceCalenderView','divContextMenu');
			if(objContextMenu){objContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
		}

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
function ShowContextMenu(ev,obj,intProjectEmployeeRoleID,intProjectID,blnSendMail,intEmployeeID,strStartDate,strEndDate,PkToken)
{
 var LoginUser = "<%=session("intUserID")%>" ;	
			
	if(obj)
	{
		objTDRolledNow=obj;obj.className='clsTDRolledOver';
	}
	var objContextMenu = GetObjectReference('frmResourceCalenderView','divContextMenu');
	 
	var mousePosition = getMousePosition(ev,objContextMenu);
	 
	objContextMenu.style.visibility= 'visible';
	objContextMenu.style.position = 'absolute';
    //Commented And Added By Vaijat K ON 23/12/2015
    //objContextMenu.style.left = mousePosition.x;objContextMenu.style.top = mousePosition.y;
	if (WhichBrowser() !="FF"){
	    objContextMenu.style.left = event.pageX + 'px';
	    objContextMenu.style.top = event.pageY + 'px';
	}
	else{
	    //var e = (window.event) ? window.event : evt;
	    objContextMenu.style.left = ev.pageX + 'px';
	    objContextMenu.style.top = ev.pageY + 'px';
	}
    //Ended
	var strHref='../SM/PB_ModifyAccess.aspx';


	var objSendMail = GetObjectReference('frmResourceCalenderView','tdSendMail');
	
			if(objSendMail)
			{
				objSendMail.onclick=function()
				{		
						
						if(blnSendMail == 1) 
						{		 
							window.open("../General/SendEmail.aspx?MessageID=489&StartDate='" + strStartDate + "'&EmployeeID=" + intEmployeeID + "&ProjectID=" + intProjectID + "&LoginUser=" + LoginUser ,"","resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
						}
						
						else
						{
							alert('All Daily Activities are filled for this Month');
				}
			}
	}

	var objShowTasks = GetObjectReference('frmResourceCalenderView','tdShowTasks');
	var objUpdateSkill = GetObjectReference('frmResourceCalenderView','tdUpdateSkill');
	var objDelegateTasks = GetObjectReference('frmResourceCalenderView','tdDelegateTasks');
	var objResourceLoading = GetObjectReference('frmResourceCalenderView','tdResourceLoading');
	var objResourceAllocation = GetObjectReference('frmResourceCalenderView','tdResourceAllocation');
 

	objShowTasks.onclick=function()
	{
	    //window.open("../PM/PM_ResourceCalenderViewDetails.aspx?EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate + "&ProjectID=" + intProjectID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");

	    //Added by Dhanashri S on 29 Mar 2016 Purpose: To generate and validate Token
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'PM_ResourceCalenderView.aspx/GenrateShowTasksToken',
	        data: JSON.stringify({ EmployeeID: intEmployeeID ,ProjectID: intProjectID ,FromDate: strStartDate, ToDate: strEndDate  }),
	        success: function (Result) {
	            window.open("../PM/PM_ResourceCalenderViewDetails.aspx?EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate + "&ProjectID=" + intProjectID + "&PKShowTasksToken="+ Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");

	        },
	        error: function () {
	            //alert("Error")
	        }
	    });
	   
	    //End of addition by Dhanashri S on 29 Mar 2016
	}
	if(objUpdateSkill != null)
	{
		objUpdateSkill.onclick=function()
		{
			window.open ("../PM/PM_UpdateEmployeeSkills.aspx?Mode=UpdateSkills&ProjectEmployeeRoleID=" + intProjectEmployeeRoleID + "&PKToken=" + PkToken ,"", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=650,height=550");
		}
	}
	
	var objtdHrLine = GetObjectReference('frmResourceCalenderView','tdHrLine');
		if (objDelegateTasks)
		if(parseInt(intEmployeeID)== parseInt(LoginUser))
		{			 
		
			 objDelegateTasks.style.display = "none";			 
			 objtdHrLine.style.display = "none";
		}
		else
		{
			objDelegateTasks.style.display = "";			 
			 objtdHrLine.style.display = "";
		}
	if(objDelegateTasks != null)
	{
		objDelegateTasks.onclick=function()
		{
			window.open("../PM/PM_TaskDelegation.aspx?ProjectEmployeeRoleID=" + intProjectEmployeeRoleID,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-750)/2 + ",top=" + (window.screen.height-550)/2 + ",width=750,height=550");
		}
	}
	objResourceLoading.onclick=function()
	{
		window.open("../PM/PM_ResourceHistory.aspx?ProjectEmployeeRoleID=" + intProjectEmployeeRoleID + "&PKToken=" + PkToken ,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-750)/2 + ",top=" + (window.screen.height-550)/2 + ",width=750,height=550");
	}
	
	objResourceAllocation.onclick=function()
	{
		//Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited  				
		//window.open("../General/CommonPage.aspx?ProjectEmployeeRoleId_PK=" + intProjectEmployeeRoleID + "&PKToken=" + PkToken + "&MasterTagID=1019&FromWhere=PM&From=RCV" ,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-750)/2 + ",top=" + (window.screen.height-550)/2 + ",width=750,height=550");
		window.open("../PM/Resources_CommonPage.aspx?ProjectEmployeeRoleId_PK=" + intProjectEmployeeRoleID + "&PKToken=" + PkToken + "&MasterTagID=1019&FromWhere=PM&From=RCV" ,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-750)/2 + ",top=" + (window.screen.height-550)/2 + ",width=750,height=550");
		//End of Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 
	}
	
	var objTrMenuHR = GetObjectReference('frmResourceCalenderView','trMenuHR');
	if(objTrMenuHR){objTrMenuHR.className='Menu_Hr';}
	 
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

					</script>
				    <!--Modified By VarunA on 24-Sep-2008 IssueID-22506 -->
				    <!--Purpose : To have proper alignment in Mozilla -->
        <%--Commented by Bharat T on 16th-Oct-2015--%>
					<!--<table id="tblHDF" cellSpacing="1" cellPadding="1" border="0" bgcolor='#ffffff' style="LEFT: 9px; POSITION: absolute; TOP: 77px" >-->
<%--					<table id="tblHDF" cellSpacing="0" cellPadding="1" border="0" bgcolor='#ffffff' style="LEFT: 3px; POSITION: absolute; TOP: 120px" >
					<!--End By VarunA on 24-Sep-2008 IssueID-22506 -->
						<tr class='clsTRColumnHeader'>
							<TD colspan="33"></TD>
						</tr>
					</table>--%>
        <%--End of Commented by Bharat T on 16th-Oct-2015--%>
				 
	</body>
</HTML>
