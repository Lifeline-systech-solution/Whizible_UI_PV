<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_SpaceListing.aspx.vb" Inherits="PbNIT.KM_SpaceListing"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	   <%WritePageHead%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>



<%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>


    <script type="text/javascript" src="../../responsive/responsive.js"></script>


   
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    .footerMenuTable {
        position:relative;
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
            /*Edited by KIRAN K K For Issue Id:2135*/
            $('.footerMenuTable').css('display', 'none');
            /*Edited by KIRAN K K For Issue Id:2135*/
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
            /*Edited by KIRAN K K For Issue Id:2135*/
            $('.footerMenuTable').css('display', 'none');
            /*Edited by KIRAN K K For Issue Id:2135*/
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
            /*Edited by KIRAN K K For Issue Id:2135*/
           $('.footerMenuTable').css('display', 'none');
            /*Edited by KIRAN K K For Issue Id:2135*/
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

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmKMSpaceList" method="post" runat="server">
		<%WritePage%>
		</form>
<Script>
	var objForm, objdivlist;
	
	objForm = GetFormReference('frmKMSpaceList');
	objdivlist = GetObjectReference('frmKMSpaceList','divList');
	
	<%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
	
	function window_onload()
	{
	   
		var intDivHeight ;
		if(objdivlist)
		{
            //Commented and Added by Yogesh J on 20-NOV-2015
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			//if(navigator.appName == 'Netscape')
			//{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 100;
			//}
		    if (WhichBrowser() == 'FF') {
                //Commented and Added by Dhanashri S on 1 Dec 2015 Issue ID:2135
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 4;
                //commented Added by Shamkant s on 24 Nov 2015 
		        //intDivHeight = window.innerHeight - objdivlist.offsetTop - 28;
                //End of Comment and Addition by Dhanashri S on 1 Dec 2015
		    }
		    else if (WhichBrowser() == 'IE') {
		        //Commented and Added by Dhanashri S on 1 Dec 2015 Issue ID:2135
		      // intDivHeight = window.innerHeight - objdivlist.offsetTop - 3;
		       //intDivHeight = window.innerHeight - objdivlist.offsetTop - 28;
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 4;
		        //End of Comment and Addition by Dhanashri S on 1 Dec 2015
		    }
		    else {
		        //Commented and Added by Dhanashri S on 1 Dec 2015 Issue ID:2135
		       intDivHeight = window.innerHeight - objdivlist.offsetTop - 4;
		        //intDivHeight = window.innerHeight - objdivlist.offsetTop - 28;
		        //End of Comment and Addition by Dhanashri S on 1 Dec 2015
		    }
            //End of Addition by Yogesh J on 20-Nov-2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + "px";	
		}
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		if(objdivlist)
		{
		    //Commented and Added by Yogesh J on 20-NOV-2015
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			//if (intDivHeight < 100)	intDivHeight = 100;
		    //objdivlist.style.height = intDivHeight;
		    if (WhichBrowser() == 'FF') {
		        //Commented and Added by Dhanashri S on 1 Dec 2015 Issue ID:2135
		        //intDivHeight = window.innerHeight - objdivlist.offsetTop - 28;
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 4;
		        //End of Comment and Addition by Dhanashri S on 1 Dec 2015
		    }
		    else {
		        //Commented and Added by Dhanashri S on 1 Dec 2015 Issue ID:2135
		        //intDivHeight = window.innerHeight - objdivlist.offsetTop - 28;
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 4;
		        //End of Comment and Addition by Dhanashri S on 1 Dec 2015
		    }
		    //End of Addition by Yogesh J on 20-Nov-2015
		    if (intDivHeight < 100) intDivHeight = 100;
		    objdivlist.style.height = intDivHeight + "px";
		}
	}
    // Added by Yogesh J on 20-NOV-2015
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
    //End of Addition by Yogesh J on 20-Nov-2015

    //Commented and Added by Usha Pandit on 17.01.2019 for added space not getting display in spacelist without refresh
	function Select_OnClickold()
	{
	    
		var blnIsRecordSelected=false;
		blnIsRecordSelected=IsCheckboxSelected('frmKMSpaceList','chkSelect')
		if (blnIsRecordSelected == false) { alert("Please select atleast one Page to add");return;}
	    //Commented and added by Nilesh g on 19/8/2016 Purpose : PkToken Issue
	    //objForm.action = "KM_SpaceListing.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Action=SELECT&TeamID=<%=m_lngTeamID%>";
	    //Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
	    objForm.action = "KM_SpaceListing.aspx?PKToken=<%=m_strPKtoken%>&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Action=ADDSPACE&TeamID=<%=m_lngTeamID%>";
	    //End Of Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
	    //end of Commented and added by Nilesh g on 19/8/2016 Purpose : PkToken Issue
	    objForm.submit();
		
       if ( window.opener != null ) 
       {		
		    if (window.opener.frmKMTeam)
		    {
		    
		        //window.opener.frmKMTeam.action = "KM_Team.aspx?TeamID=<%=m_lngTeamID%>"
			    //window.opener.frmKMTeam.submit();
			   window.opener.document.forms[0].action = "KM_Team.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&TeamID=<%=m_lngTeamID%>"
		        window.opener.document.forms[0].submit();
		      
			    if("<%=m_strFrom %>"=="Home")
			    {
			        
			        window.opener.opener.location.href="../km/KM_List.aspx?Tab=HOME&txtSearch="+window.opener.opener.document.getElementById('txtSearch').value;
			    }
			    else
			    {
    			   
			        /*window.opener.opener.document.forms[0].action = "../km/KM_List.aspx?Tab=MY&Subtab=MY TEAMS"
			        window.opener.opener.document.forms[0].submit();*/
			        // window.location.href="../KM/KM_List.aspx?Fromwhere=MyTeam&Tab=MY&Subtab=MY TEAMS&SelectList=6&txtSearch=";  Commented by Vaijat K ON 09/12/2015 IssueID-2662
			    }
		    }
		    else if(window.opener.frmKMList)
		    {
    		    
			    //window.opener.frmKMList.submit();
			    window.opener.document.forms[0].submit();
		    }
       }

		//window.close(); Commented by Vaijat K ON 09/12/2015 IssueID-2662
	}

    function Select_OnClick() {

        var blnIsRecordSelected = false;
        blnIsRecordSelected = IsCheckboxSelected('frmKMSpaceList', 'chkSelect')

        var strSelectedIDs = $('input[id=chkSelect]:checked').map(function () {
            return this.value;
        }).get().join(',');

        if (blnIsRecordSelected == false) { alert("Please select atleast one Space to add"); return; }
        //Commented and added by Nilesh g on 19/8/2016 Purpose : PkToken Issue
        //objForm.action = "KM_SpaceListing.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Action=SELECT&TeamID=<%=m_lngTeamID%>";
        //Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
        //objForm.action = "KM_SpaceListing.aspx?PKToken=<%=m_strPKtoken%>&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Action=ADDSPACE&TeamID=<%=m_lngTeamID%>";
        //End Of Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
        //end of Commented and added by Nilesh g on 19/8/2016 Purpose : PkToken Issue
        //objForm.submit();

        var strAction = 'SELECT';
        var lngTeamID = '<%=m_lngTeamID%>';

        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'KM_SpaceListing.aspx/PerformAddition',
            data: JSON.stringify({ strAction: strAction, lngTeamID: lngTeamID, strSelectedIDs: strSelectedIDs }),
            success: function (Result) {
                if (window.opener != null) {
                    if (window.opener.frmKMTeam) {

                        window.opener.document.forms[0].action = "KM_Team.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&TeamID=<%=m_lngTeamID%>"
                        window.opener.document.forms[0].submit();

                        if ("<%=m_strFrom %>" == "Home") {

                    window.opener.opener.location.href = "../km/KM_List.aspx?Tab=HOME&txtSearch=" + window.opener.opener.document.getElementById('txtSearch').value;
                }
                else {
                }

                window.close();
            }
            else if (window.opener.frmKMList) {
                window.opener.document.forms[0].submit();
            }
        }
            },
            error: function () {
                // alert("Error")
            }
        });

        //window.close(); //Commented by Vaijat K ON 09/12/2015 IssueID-2662
}


    //End of Commented and Added by Usha Pandit on 17.01.2019 for added space not getting display in spacelist without refresh

	function txtSearch_KeyPress(e)
	{
		var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
		if(code==13) 
		{
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
		objForm.action = "KM_SpaceListing.aspx?Filter=1";
		objForm.submit();
		}
	}
	function AlphaNumericPaging_OnClick(chr)
	{
	    //Added by Tejal D date 12/10/2016 to set setFrameLoader
	    setFrameLoader();
	    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
		objForm.action = "KM_SpaceListing.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Filter=1&PagingAlphabet=" + chr;
		objForm.submit();
	}
		
	// Paging scripts
	function Page_OnClick(Page)
	{
	    //Added by Tejal D date 12/10/2016 to set setFrameLoader
	    setFrameLoader();
	    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader

	    //Commented and Added by Usha Pandit on 17.01.2019 for issue you are not authorised to view the records
	    //objForm.action = "KM_SpaceListing.aspx?txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&PageNumber=" + Page;
	    objForm.action = "KM_SpaceListing.aspx?PKToken=<%=m_strPKtoken%>&TeamID=<%=m_lngTeamID%>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&PageNumber=" + Page;
	    //End of Commented and Added by Usha Pandit on 17.01.2019 for issue you are not authorised to view the records

	    objForm.submit();
	}
	
	var noOfPages = GetObjectReference('frmKMSpaceList','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmKMSpaceList','txtPageNumber');
	function validateNumPaging()
	{

		if(isNaN(objtxtpageNumber.value))
		{
			alert("Please enter numeric value");
			return false;
		}
		if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
		{
			alert("Please enter value within range of 1 to "+noOfPages);
			return false;
		}
		return true;
	}
	function ShowPreviousPage()
	{
		if (isBlank(objtxtpageNumber.value))
			Page_OnClick(1);
		else
		{
			if(!validateNumPaging())
			return;
			
			if (objtxtpageNumber.value==1){alert("This is the first page");return;}
				objtxtpageNumber.value=objtxtpageNumber.value -1;
			Page_OnClick(objtxtpageNumber.value);
		}
			
	}
	function ShowFirstPage()
	{
		if (isBlank(objtxtpageNumber.value))
			Page_OnClick(1);
		else
		{
			if(!validateNumPaging())
			return;
			if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=1;
			Page_OnClick(objtxtpageNumber.value);
		}
	}
	function ShowNextPage()
	{
		if (isBlank(objtxtpageNumber.value))
			Page_OnClick(1);
		else
		{
			if(!validateNumPaging())
			return;
			if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
				objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
			Page_OnClick(objtxtpageNumber.value);
		}
	}
	function ShowLastPage()
	{
		if (isBlank(objtxtpageNumber.value))
			Page_OnClick(noOfPages);
		else
		{	
			if(!validateNumPaging())
			return;
			if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
			objtxtpageNumber.value=noOfPages;
			Page_OnClick(objtxtpageNumber.value);
		}
	}
	function txtPageNumber_KeyPress(e)
	{
		var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				var objtxtpageNumber =  GetObjectReference('frmKMSpaceList','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmKMSpaceList','txtNoOfPages');
								
				if (!disallowBlank(objtxtpageNumber,"Please Enter Page number",true) && (!disallowNonNumeric(objtxtpageNumber,"Please Enter numeric value for Page number",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Please Enter positive integer value for Page number",true)) & (!disallowNonInteger(objtxtpageNumber,"Please Enter positive integer value for Page number",true)))				
				{
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Page number should not be greater than " + objtxtNoOfPages.value);
						return;
					}
					Page_OnClick(objtxtpageNumber.value);
				}
			}
	}
	//End paging scripts
	</script>
  </body>
</html>
