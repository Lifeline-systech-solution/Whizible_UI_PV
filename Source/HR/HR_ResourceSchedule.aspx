<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_ResourceSchedule.aspx.vb" Inherits="PbNIT.HR_ResourceSchedule" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>

<%CommonFunctions.General.PlotPageHeadTag("Resource Schedule")%>
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

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmHR_ResourceSchedule" method="post" runat="server">
        <%PageInit()%>
    </form>

    <script language="javascript">
      
        var objform=GetFormReference('frmHR_ResourceSchedule');
        var objdivlist=GetObjectReference('frmHR_ResourceSchedule','PageDiv');
				
        //<%'The div tag has id as PageDiv%> PageDiv
		
        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
        function window_onload()
        {
            var intDivHeight ; var intDivHeightRisk;
			
            if (objdivlist !=null) 
            {
                objdivlist.style.height=200;
                if (navigator.appName=="Netscape") 
                {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop -40 ;
                }
                else
                { 
                    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop -40;
                }
                if (intDivHeight < 100)	
                    intDivHeight = 100; 
                objdivlist.style.height = intDivHeight +'px';	
            }			
		
        }
		
        function window_onresize()		
        {
            var intDivHeight; var intDivHeightRisk;
			
            if (objdivlist !=null)
            {
                if (navigator.appName=="Netscape") 
                {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
                }
                else
                {  
                    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
                }
                if (intDivHeight < 100)	
                    intDivHeight = 100; 
                objdivlist.style.height = intDivHeight +'px';	
            }
		    <% ' CallOnLoad('tbl1','tblListH1',0); %>
			<% ' CallOnLoad('tbl1','tblListH1',1); %>
		}
        function Sort_OnClick(sortby, sortorder)
        {
            var intProject;
            intProject=<%=strProjectID%>;
			window.location.href = "HR_ResourceSchedule.aspx?Project=" + intProject + "&SortBy=" + sortby + "&SortOrder=" + sortorder ; 
        }
		
        function SelectRow_OnClick(intEmployeeID)
		
        {
		 
            var DashBoardViewDate = '<%=strDashBoardViewDate.substring(0,strDashBoardViewDate.LastIndexof("/").Tostring +5)%>';
		    //var DashBoardViewDate = '06/06/2007';
		 
		    //alert(DashBoardViewDate)        
		    //window.open ("../General/CommonList.aspx?MasterTagID=20004&EmployeeID=" + intEmployeeID + "","","menubar=no,resizable=yes,scrollbars=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=700,height=500");
		    window.open ("../General/CommonList.aspx?DashBoardViewDate='"+DashBoardViewDate+"'&MasterTagID=20004&EmployeeID=" + intEmployeeID + "","","menubar=no,resizable=yes,scrollbars=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=700,height=500");
		}
		
			
		function Close_Click()
		{
		    window.close();
		}	
				
		function Status_Onclick(strStatus)
		{
		    objform.action = "HR_ResourceSchedule.aspx";
		    objform.submit();
		}

		function cboBG_Onchange()		
		{
		    //objform.action = "HR_ResourceSchedule.aspx";
		    //objform.submit();
		}
		function cboPM_Onchange()		
		{
		    //objform.action = "HR_ResourceSchedule.aspx";
		    //objform.submit();
		}
		function cboOU_Onchange()		
		{
		    //objform.action = "HR_ResourceSchedule.aspx";
		    //objform.submit();
		}
		
				
		function cboDashboard_OnChange()
		    // For selecting the user's e-DB 
		{
		    var objcboDashboard;
		    objcboDashboard = GetObjectReference('Graph','cboDashboard');

		    var strPageName;
		    var arr;
		
		    strPageName = objcboDashboard.value;
		    if (trimString(strPageName + "") != "") 
		    {
		        arr = strPageName.split("|");
		        if (isSubstringExists(arr[0],'?'))
		        {
		            window.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
		        }
		        else
		        {
		            window.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
		        }
		    }
		    else
		    {
		        window.location.href = "../HR/HR_ResourceSchedule.aspx?DashboardID=0"; 	
		    }

		}		
		//Code added by RathinP on 25-May-2007
		function cboDepartment_OnChange(Department)
		{
		    //objform.action = "HR_ResourceSchedule.aspx?Department=" + Department;
		    //objform.submit();
			
		}
		function View_OnChange(View)
		{
		    
		    //objform.action = "HR_ResourceSchedule.aspx?View=" + View;
		    //objform.submit();
			
		}
		function cboRole_OnChange(Role)
		{
		    //objform.action = "HR_ResourceSchedule.aspx?Role=" + Role;
		    //objform.submit();
			
		}
		function cboReportingTo_OnChange(ReportingTo)
		{
		    //objform.action = "HR_ResourceSchedule.aspx?ReportingTo=" + ReportingTo;
		    //objform.submit();
			
		}
		
		function Show_OnClick()
		{
		    //alert("<%=strFromWhere%>");
		    objform.action = "HR_ResourceSchedule.aspx?Mode=Show&FromWhere=<%=strFromWhere%>";
		    objform.submit();
		    //alert("It is called Show")
			
		}
		//End of code addition by RathinP on 21-May-2007
    </script>


</body>
</html>
