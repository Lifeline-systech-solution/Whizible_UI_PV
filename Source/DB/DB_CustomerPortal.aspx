<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DB_CustomerPortal.aspx.vb" Inherits="PbNIT.DB_CustomerPortal" %>
<HTML>
<%CommonFunctions.General.PlotPageHeadTag("CUSTOMER")%>
    <%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
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

	<body class="clsFullPageBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()">
		<STYLE type="text/css"> 
	        #PictBox .PictBox_content { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; }
	    </STYLE>
	    
	 <form id="frmCustomerPortal" method="post" runat="server" enctype='multipart/form-data'>
                    <%WritePage()%>

<script language="javascript">
var objfrm = GetFormReference('frmCustomerPortal');
var objdivlist = GetObjectReference('frmCustomerPortal', 'PageDiv');
var objdivlist1 = GetObjectReference('frmCustomerPortal', 'divList');
var objdivlist2 = GetObjectReference('frmCustomerPortal', 'divList1');

        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>

function window_onload()
{
		var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;
        }
			
			
			if (objdivlist1 !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist1.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist1.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;
        }
}


function window_onresize()
{
   var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015	
        }
			if (objdivlist1 !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist1.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist1.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015
        }
			
			
    	
}

function Customer_OnClick()
{
    window.open("../DB/CustomerSelection_customerPortal_CommonList.aspx?FromWhere=SM&MasterTagID=20034", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
}
function comboChanged()
{  
    //alert(parent.document.getElementsByTagName("frame")[1].action);
    var objFrame=GetObjectReference('frmFrame','CustomerInfo');
    var Objcombo=GetObjectReference('frmCustomerPortal','cboCustomer');
    parent.document.getElementsByTagName("frame")[0].src="../DB/DB_CustomerPortal.aspx?mode=Header&CustomerID="+ Objcombo.value;
    //parent.document.getElementsByTagName("frame")[1].src="../DB/DB_CustomerPortal.aspx?Opreation=GeneralInfo&CustomerID="+ Objcombo.value;
    //parent.document.getElementsByTagName("frame")[2].src="../DB/DB_CustomerPortal.aspx?Opreation=DetailInfo";
    parent.document.getElementsByTagName("frame")[1].src="../DB/DB_CustomerPortal.aspx?mode=Main&CustomerID="+ Objcombo.value;
}
function td_OnClick(intTdId)
{
        parent.document.getElementsByTagName("frame")[1].src="../DB/DB_CustomerPortal.aspx?Mode=Main&Action=" +intTdId;
        objTD1 = document.getElementById("TD1");
        objTD2 = document.getElementById("TD2");
        objTD3 = document.getElementById("TD3");
        objTD4 = document.getElementById("TD4");
        objTD5 = document.getElementById("TD5");
        objTD6 = document.getElementById("TD6");
        objTD7 = document.getElementById("TD7");
        objTD8 = document.getElementById("TD8");
        
        if (intTdId==1)
        {
            objTD1.innerHTML = "<font color=red>Projects</font>";
            objTD2.innerHTML = "SOA";
            objTD3.innerHTML = "Upcoming Invoices";
            objTD4.innerHTML = "Invoices not Paid";
            objTD5.innerHTML = "Issues";
            objTD6.innerHTML = "Help Desk";
            objTD7.innerHTML = "Customer Details"; 
            objTD8.innerHTML = "Field Logs";
        }
        if (intTdId==2)
        {
            objTD1.innerHTML = "Projects";
            objTD2.innerHTML = "<font color=red>SOA</font>";
            objTD3.innerHTML = "Upcoming Invoices";
            objTD4.innerHTML = "Invoices not Paid";
            objTD5.innerHTML = "Issues";
            objTD6.innerHTML = "Help Desk";
            objTD7.innerHTML = "Customer Details"; 
            objTD8.innerHTML = "Field Logs";
        }
         if (intTdId==3)
        {
            objTD1.innerHTML = "Projects";
            objTD2.innerHTML = "SOA";
            objTD3.innerHTML = "<font color=red>Upcoming Invoices</font>";
            objTD4.innerHTML = "Invoices not Paid";
            objTD5.innerHTML = "Issues";
            objTD6.innerHTML = "Help Desk";
            objTD7.innerHTML = "Customer Details"; 
            objTD8.innerHTML = "Field Logs";
        }
         if (intTdId==4)
        {
            objTD1.innerHTML = "Projects";
            objTD2.innerHTML = "SOA";
            objTD3.innerHTML = "Upcoming Invoices"
            objTD4.innerHTML = "<font color=red>Invoices not Paid</font>";
            objTD5.innerHTML = "Issues";
            objTD6.innerHTML = "Help Desk";
            objTD7.innerHTML = "Customer Details"; 
            objTD8.innerHTML = "Field Logs";
        }
        
          if (intTdId==5)
        {
            objTD1.innerHTML = "Projects";
            objTD2.innerHTML = "SOA";
            objTD3.innerHTML = "Upcoming Invoices"
            objTD4.innerHTML = "Invoices not Paid";
            objTD5.innerHTML = "<font color=red>Issues</font>";
            objTD6.innerHTML = "Help Desk";
            objTD7.innerHTML = "Customer Details"; 
            objTD8.innerHTML = "Field Logs";
        
        }
        
          if (intTdId==6)
        {
            objTD1.innerHTML = "Projects";
            objTD2.innerHTML = "SOA";
            objTD3.innerHTML = "Upcoming Invoices"
            objTD4.innerHTML = "Invoices not Paid";
            objTD5.innerHTML = "Issues";
            objTD6.innerHTML = "<font color=red>Help Desk</font>";
            objTD7.innerHTML = "Customer Details"; 
            objTD8.innerHTML = "Field Logs";
        }
        
        
        
           if (intTdId==7)
        {
            objTD1.innerHTML = "Projects";
            objTD2.innerHTML = "SOA";
            objTD3.innerHTML = "Upcoming Invoices"
            objTD4.innerHTML = "Invoices not Paid";
            objTD5.innerHTML = "Issues";
            objTD6.innerHTML = "Help Desk";
            objTD7.innerHTML = "<font color=red>Customer Details</font>";
            objTD8.innerHTML = "Field Logs";
        }
        
        
           if (intTdId==8)
        {
            objTD1.innerHTML = "Projects";
            objTD2.innerHTML = "SOA";
            objTD3.innerHTML = "Upcoming Invoices"
            objTD4.innerHTML = "Invoices not Paid";
            objTD5.innerHTML = "Issues";
            objTD6.innerHTML = "Help Desk";
            objTD7.innerHTML = "Customer Details";
            objTD8.innerHTML = "<font color=red>Field Logs</font>";
        }
}
function Show_OnClick()
		{
		    objfrm.action='DB_CustomerPortal.aspx?Mode=Main&Action=4';
			objfrm.submit();
		}
function ItemTab_OnClick(strWhich)
		{ 
			if (strWhich =='In ProgressProject')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Main&Action=1&Grid=InProgressProject';
			objfrm.submit();
			}
			if (strWhich =='ClosedProjects')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Main&Action=1&Grid=ClosedProjects';
			objfrm.submit();
			}
			if (strWhich =='In Progress')
			{
				objfrm.action='DB_CustomerPortal.aspx?Mode=Milestone&Grid=InProgress';
				objfrm.submit();
			}
			if (strWhich =='Planned')
			{
				objfrm.action='DB_CustomerPortal.aspx?Mode=Milestone&Grid=Planned';
				objfrm.submit();
				}
			if (strWhich =='Completed')
			{
				objfrm.action='DB_CustomerPortal.aspx?Mode=Milestone&Grid=Completed';
				objfrm.submit();
			}
			if (strWhich =='PlannedDel')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Deliverables&Grid=PlannedDel';
			objfrm.submit();
			}
				if (strWhich =='In ProgressDel')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Deliverables&Grid=InProgressDel';
			objfrm.submit();
			}
			if (strWhich =='CompletedDel')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Deliverables&Grid=CompletedDel';
			objfrm.submit();
			}
			
			if (strWhich =='PlannedTasks')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Tasks&Grid=PlannedTasks';
			objfrm.submit();
			}
				if (strWhich =='In ProgressTasks')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Tasks&Grid=InProgressTasks';
			objfrm.submit();
			}
			if (strWhich =='CompletedTasks')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Tasks&Grid=CompletedTasks';
			objfrm.submit();
			}
			if (strWhich =='Pending')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Invoices&Grid=Pending';
			objfrm.submit();
			}
			if (strWhich =='InvoiceGenerated')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Invoices&Grid=InvoiceGenerated';
			objfrm.submit();
			}
			if (strWhich =='PaymentReceipt')
			{
			objfrm.action='DB_CustomerPortal.aspx?Mode=Invoices&Grid=PaymentReceipt';
			objfrm.submit();
			}
		}
		function ShowDetails(milestoneid)
		{
		   window.open("DB_CustomerPortal.aspx?Details=TaskDetails&Milestoneid="+milestoneid, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
		}
		function Close_Click()
		{
		    window.close();
		}
		
		function ShowDetailsofDeliverables(ScheduleID)
		{
		    window.open("DB_CustomerPortal.aspx?Details=DelTaskDetails&DeliverableID="+ScheduleID, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
		}
		
		function ViewReport(ProjectID)
		{
		    window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=20001&UNIQUEID="+ProjectID,"","resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
		}
		function ResourceUtilization(ProjectID)
		{
		    window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport.aspx?Mode=Generate&PROJECTREPORT=1&BUID=&OUID=&DUID=&ResourceID=&DateRangeID=10&FromWhere=DB&ProjectID="+ProjectID,"","resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
		}
    function Document_OnClick(intQueryID,strToken)
	{
	//window.open ("../DB/DocumentType.aspx?QueryID=" + intQueryID + "&TagID=0&DocumentType=CRM","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	window.open ("../DB/DocumentType.aspx?QueryID=" + intQueryID + "&TagID=0&DocumentType=CRM&PKToken=" + strToken,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	
	
	function ShowSLA_OnClick(QueryID)
{
	window.open ("../CRM/CRM_SLADetails.aspx?Mode=DB&RequestSLA=1&QueryID="+QueryID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
}

function Name_OnClick(Customer)
{
    objfrm.action='DB_CustomerPortal.aspx?Mode=DisplayMenu';
	objfrm.submit();
}

function AMCDetails_OnClick(CustomerProductVersionID)
{
     window.open("DB_CustomerPortal.aspx?Details=AMC&CustomerProductVersionID="+CustomerProductVersionID,"" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
	
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

var objTDRolledNow;
		var objContextMenu;
		document.onmouseup=function()
		{
			objContextMenu = GetObjectReference('frmCustomerPortal','divContextMenu');
			if(objContextMenu){objContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
			
			objdivLegendsContextMenu = GetObjectReference('frmCustomerPortal','divLegendsContextMenu');
			if(objdivLegendsContextMenu){objdivLegendsContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
			
		}
		
		
function ShowContextMenu(ev,obj,blnSendMail,intEmployeeID,strStartDate,strEndDate,PkToken)
{
 var LoginUser = "<%=session("intUserID")%>" ;	
			
	if(obj)
	{
		objTDRolledNow=obj;obj.className='clsTDRolledOver';
	}
	var objContextMenu = GetObjectReference('frmCustomerPortal','divContextMenu');
	 
	var mousePosition = getMousePosition(ev,objContextMenu);
	 
	objContextMenu.style.visibility= 'visible';
	objContextMenu.style.position = 'absolute';
	
	objContextMenu.style.left = mousePosition.x;objContextMenu.style.top = mousePosition.y;
	
	
	
}

function Discussion_OnClick(QueryID,PKToken)
 {
    window.open("DB_CustomerPortal.aspx?Details=Discussionthread&QueryID="+QueryID,"" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
 }
</SCRIPT>
</FORM>
   </BODY>
	    </HTML>