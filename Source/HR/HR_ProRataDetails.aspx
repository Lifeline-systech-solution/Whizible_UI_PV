<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_ProRataDetails.aspx.vb" Inherits="PbNIT.HR_ProRataDetails" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Pro Rata Details")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

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



	<body class='clsBody' onload='window_onload()' onresize='window_onresize()'>
		<form name="frmProRataDetails" id="frmProRataDetails" method="post" runat="server">
					<%PageInit()%>
					
		</form>
<script language="javascript">
var objdivlist = GetObjectReference('frmProRataDetails', 'divPage');

var objfrm = GetFormReference('frmProRataDetails');
var Flag = true;

            <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
  function window_onload()
{


		var intDivHeight ;
		var intDivHeightRisk;
		var lc;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
		}
		else {
		    //Commented by Yogesh J on 15/12/2015 for pop up bottom line issue
		    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 35;
            //End of comment by Yogesh J 
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objdivlist.style.height = intDivHeight + 'px';

	//	objdivlist.HEIGHT = intDivHeight;
		
		
		
		
}
function Designation_onchange()
{
	
    objfrm.action="../HR/HR_ProRataDetails.aspx";
    objfrm.submit();
}

function LeaveType_onchange()
{
    objfrm.action="../HR/HR_ProRataDetails.aspx";
    objfrm.submit();
}


function txtEmployeeName_onKeyPress(e)
{
	var code;
	if (e.keyCode) 
			code = e.keyCode;
	else
		if (e.which) 
			code = e.which;
					
	if(code==13) 
	{
		objfrm.action="../HR/HR_ProRataDetails.aspx";
        objfrm.submit();		
	}
	
}

function Save_Click()
{
	
	
	var objhidUniqueIDs = GetObjectReference('frmProRataDetails','hidUniqueIDs');
	var arrUniqueIDs = objhidUniqueIDs.value.split(",");
	var c;
	for(c=0;c<arrUniqueIDs.length-1;c++)
	//Modified By VarunA on 20-Mar-2009 IssueID-28539
	//Purpose : Change of ProRata multiples from .5 to .25
	//Added By VarunA on 17-Dec-2007 IssueID-15347 PMLifeLine Development & Release
	//Purpose : To have the ProRata multiple of .5
	{
		obj_ProRata = GetObjectReference('frmProRataDetails','txtProRata'+arrUniqueIDs[c]);
		if(obj_ProRata.value!="")
		if(obj_ProRata.value % 0.25 != 0)
		{
			alert("Pro-Rata should be in multiples of 0.25");
			obj_ProRata.focus();
			return;
		}
	//End By VarunA on 17-Dec-2007
	/*if (!isNumeric(GetObjectReference('frmProRataDetails','txtProRata'+arrUniqueIDs[c]).value))*/
	if (disallowNegativeNumeric(GetObjectReference('frmProRataDetails','txtProRata'+arrUniqueIDs[c])))
	{
		alert("Please enter positive numeric value");
		GetObjectReference('frmProRataDetails','txtProRata'+arrUniqueIDs[c]).focus();
		return;	
	}
	}
	
	//Addition done by SuchitraP on 4-JUN-2007 for IssueID 13525
	var objUpperMenu=GetObjectReference('frmProRataDetails','divUpperMenu');
	if(objUpperMenu)
	{
	   objUpperMenu.style.display='none';
	}
	//end on 4-JUN-2007 for IssueID 13525
	
	//Addition done by SuchitraP on 4-JUN-2007 for IssueID 13525
	var objBottomMenu=GetObjectReference('frmProRataDetails','divBottomMenu');
	if(objBottomMenu)
	{
	    // objBottomMenu.style.display='none';
	    objBottomMenu.style.visibility = 'hidden';
	}
	//end on 4-JUN-2007 for IssueID 13525
	
    objfrm.action='../HR/HR_ProRataDetails.aspx?Action=Save';
	objfrm.submit();
}

function window_onresize()
{
var intDivHeight ;
var intDivHeightRisk;
if (navigator.appName == 'Microsoft Internet Explorer'){
intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
}
else {
    //Commented by Yogesh J on 15/12/2015 for pop up bottom line issue
    //intDivHeight = window.innerHeight - 42;
    intDivHeight = window.innerHeight - objdivlist.offsetTop - 35;
  

}
if (intDivHeight < 100)
	intDivHeight = 100;
		
objdivlist.style.height = intDivHeight+'px';

		if (Flag == true)
		objdivlist.HEIGHT = intDivHeight;
		else
		objdivlist.HEIGHT = intDivHeight-26;
}


/*function Sort_OnClick(sortby,sortorder)
{
	objfrm.action = "HR_ProRataDetails.aspx?SortBy=" + sortby + "&SortOrder=" + sortorder;
	objfrm.submit();  
}*/


	</script>
  </body>
</html>
