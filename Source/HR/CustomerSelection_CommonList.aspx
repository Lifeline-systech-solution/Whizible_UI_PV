<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CustomerSelection_CommonList.aspx.vb" Inherits="PbNIT.CustomerSelection_CommonList" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("")%>
<head>
    <title>Customer Selection</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" >

<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>


<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 14px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        CL_window_onload();
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
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
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').find('tbody').find('tr').each(function(){

            var rowIndex=$(this).index();
            var attr = $(this).attr('id');
            // For some browsers, `attr` is undefined;
            // for others, `attr` is false. Check for both.
            if (typeof attr !== typeof undefined && attr !== false)
            {
            }

            else
            {
                $(this).attr('id','rowId'+rowIndex);
            }
        });

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('large_visible');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').after('<div id="reviewTypeContent"></div>');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function()
        {
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

        if($('.clsGridTable').length > 0)
        {
            var divName=$('#divListPageTag').find('div:first').attr('id');
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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {
            $('.clsTable:last').css({'display':'none'});
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

    $(window).resize(function(){
        /*window_resize_hideshowtree();*/
        CL_window_onresize();

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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {
            $('.clsTable:last').css({'display':'none'});
        }
        else
        {
            $('.clsTable:last').css({'display':'block'});
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


</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    </form>



    <script language="javascript">
        var objdivlist;
        var objform;
		
        function CustomerName_OnClick(CustomerID,CustomerName,ParentTagID,IsloginCreated)
        { 
            //'Added by TruptiK on 20,May 2009 
            //'To give alert when customer login is not created and in helpdesk anyone is trying to add request on behalf of that customer.           
            if (IsloginCreated==0)
            {
                alert('You can not post request as login is not created for customer');
                return;
            }
            //Ended by TruptiK
				
            // Added by SrikanthY on 03 Jan 2007 For selecting Employees from employee list screen while adding new Request
            //if (ParentTagID == 3101)
            //{
            //addition done by SuchitraP on 11 Dec 2007 for selecting customer while adding an Opportunity
            var PtagID=<%=strPTag%>
				//alert(PtagID);
				if(PtagID==3851 || PtagID==3865)
			    {
				  
			        window.opener.document.forms['frmCommonPage'].elements['Prospect'].value=CustomerName;
			        window.opener.document.forms['frmCommonPage'].elements['CustomerID'].value=CustomerID;
			        window.close();
			    }
            else{
			    //End of addition by SuchitraP on 11 Dec 2007
			    //Commneted and added by ShraddhaM on 19,Sep 2009 to change add new functionality
				 
				 
				  window.opener.document.forms['frmRequestDetails'].elements['cboFunction'].value='';
			    window.opener.document.forms['frmRequestDetails'].elements['cboSubRequestType'].value='';
			    window.opener.document.forms['frmRequestDetails'].elements['cboRequestType'].value='';
				  
			    var URL = "CRM_RequestDetail.aspx?Mode=NEW&PageNumber=1&Customer="+CustomerID+"&Employee=&RTVal=C&ParentTagID=0&FromList=1&FromCL=1&OnBehalfOf=CUST"
    				
			    window.opener.document.forms['frmRequestDetails'].action = URL;
			    window.opener.document.forms['frmRequestDetails'].submit();
				    
			    //window.opener.document.forms['frmCommonPage'].elements['NonDatabase4'].value=CustomerName;
			    //window.opener.document.forms['frmCommonPage'].elements['NonDatabase5'].value=CustomerID;
			    //End of Commneted and added by ShraddhaM on 19,Sep 2009 to change add new functionality
			    window.close();
            }	
            //}
            // End of Addition by SrikanthY
								
            }
			
		
		
    </script>
</body>
</html>
