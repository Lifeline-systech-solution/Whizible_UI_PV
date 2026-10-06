<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="KM_SpaceAndPageView.aspx.vb" Inherits="PbNIT.KM_SpaceAndPageView" %>
<html >
<%CommonFunctions.General.PlotPageHeadTag("View Details")%>


<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body  class="clsBody" onload="window_onload()"> <!--onresize="window_onresize()" -->
    <form id="frmKMSpaceAndPage" method="post" runat="server">
		<%WritePage%>
		</form>
<script language='javascript' type="text/javascript">
	
	var objForm = GetFormReference('frmKMSpaceAndPage');
    var objdivMain = GetObjectReference('frmKMSpaceAndPage', 'divMain');
    
    <%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
    
	function window_onload()
	{
		var intDivHeight ;
		var HeightDiff = 0;//60;
		
		if(objdivMain)
		{
			intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - HeightDiff;
			if(navigator.appName == 'Netscape')
			{
			   	intDivHeight = window.innerHeight - objdivMain.offsetTop-40;
		    }
		    else
		    {
		        intDivHeight = document.body.offsetHeight - objdivMain.offsetTop -40;
		    }

			if (intDivHeight < 100)	intDivHeight = 100;
			objdivMain.style.height = intDivHeight +'px';	
		}
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		if(objdivMain)
		{
			intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 50;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivMain.style.height = intDivHeight +'px';
		}
	}
	
	function Back_OnClick()
	{
	   window.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Tab=MY&Subtab=MY TEAMS&SelectList=6";
	}
	
	//Added SpaceID by SuchitraP
	function Page_OnClick(PageID,strMode,SpaceID,strFrom)
	{
	   
		if(SpaceID==0)
		{
		    //window.open("KM_PageView.aspx?Fromwhere="+strFrom+"&txtSearch=&SpaceID="+SpaceID+"&Mode="+strMode+"&PageID=" + PageID,"","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=900,height=650");
		    //Added by Vidya J on 29-Mar-2016  to generate and validate Token
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'KM_SpaceAndPageView.aspx/GenrateURLToken',
		        data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", SpaceID: SpaceID, PageID: PageID }),
		        success: function (Result) {
		           
		         window.open("KM_PageView.aspx?Fromwhere="+strFrom+"&txtSearch=&SpaceID="+SpaceID+"&Mode="+strMode+" &PKToken="+Result.d+"&PageID=" + PageID,"","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=900,height=650");
		    },
		    error: function () {
		      //  alert("Error")
		    }
		});

		    //End of addition by Vidya J on 29-Mar-2016



			
		}
		else
		//End by SuchitraP
		{
		    //window.open("KM_MyPage.aspx?Myflag=2&Fromwhere="+strFrom+"&txtSearch=&SpaceID="+SpaceID+"&Mode="+strMode+"&PageID=" + PageID,"","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=900,height=650");
		    //Added by Vidya J on 29-Mar-2016  to generate and validate Token
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'KM_SpaceAndPageView.aspx/GenrateURLToken',
		        data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", SpaceID: SpaceID, PageID: PageID }),
		        success: function (Result) {

		            window.open("KM_PageView.aspx?Fromwhere=" + strFrom + "&txtSearch=&SpaceID=" + SpaceID + "&Mode=" + strMode + " &PKToken=" + Result.d + "&PageID=" + PageID, "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=900,height=650");
		        },
		        error: function () {
		            alert("Error")
		        }
		    });

		    //End of addition by Vidya J on 29-Mar-2016

		}
	
	}	
	</script>
</body>
</html>
