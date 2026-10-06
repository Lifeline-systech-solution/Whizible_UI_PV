<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_Employeeselection.aspx.vb" Inherits="PbNIT.KM_Employeeselection"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	 <%WritePageHead%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->



       <%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>


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

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmKMEmpList" method="post" runat="server">
		<%WritePage%>
		</form>
	<script>
	var objForm, objdivlist;
	
	objForm = GetFormReference('frmKMEmpList');
	objdivlist = GetObjectReference('frmKMEmpList','divList');
	objtxtUsers = GetObjectReference('frmKMEmpList','txtUsers');
	objtxtUserIDs = GetObjectReference('frmKMEmpList','txtUserIDs');
	var MaxPages = <%=m_intTotalNoOfRows%>/50
	
	        <%' Added By SonalD on 13th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 13th Jan 2009 %>
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
	function window_onload()
	{
		var intDivHeight ;
		if(objdivlist)
		{
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
		    //if(navigator.appName == 'Netscape')
		    //{
		    //    intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 100)  ;
		    //}
            //Commented added by Shamkant S on 10 Nov 2015
			//if(WhichBrowser() == 'IE')
			//{
			//	intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 100) -252 ;
			//}
			//else if(WhichBrowser() == 'CR')
			//{
			//    intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 100) -248 ;
			//}
			//else 
			//{
			//    intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 100) -276 ;
		    //}
		    intDivHeight = (window.innerHeight - objdivlist.offsetTop) - 4 ; // Added By Vaijat K ON 24/11/2015 Issue ID-2383
			if (intDivHeight < 100)	intDivHeight = 100;
			//objdivlist.style.height = intDivHeight ;
			objdivlist.style.height = intDivHeight + 'px' ;	
			
		}
		<%  If IsPostBack() = False Then %>
		objtxtUsers.value = window.opener.<%=m_strParentformName%>.<%=m_strParentUsersControl%>.value 
		<%end if %>
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		if(objdivlist)
		{
		    intDivHeight = (window.innerHeight - objdivlist.offsetTop) - 4 ; // Added By Vaijat K ON 24/11/2015 Issue ID-2383
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';
		}
	}
	function Select_OnClick()
	{
	   
		var objCheckbox = GetObjectReference('frmKMEmpList','chkSelect',true);
		var intItems;
		var intCtr;
		var strUserIDs = "";
		var strUsers = "";
		var flag;
		/*if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].checked == true)
					{
					 strUserIDs = strUserIDs + objCheckbox[intCtr].value.substring(0,objCheckbox[intCtr].value.indexOf("-->")) + ',' 
					 strUsers = strUsers  + objCheckbox[intCtr].value.substring(objCheckbox[intCtr].value.indexOf("-->")+3) + ','
					}					
				}		
		}*/
		
		
		/*for(var i=0;i<objCheckbox.length-1;i++)
		{
		    if(objCheckbox[i].checked==true)
		    {
		        flag=1;
		        break;
		    }
		}*/
		
		if(GetObjectReference('frmKMEmpList','txtUsers').value=='')
		{
		    alert('Please select atleast one user.');
		    return;
		}
		
		window.opener.<%=m_strParentformName%>.<%=m_strParentUsersControl%>.value = objtxtUsers.value ;
		window.opener.<%=m_strParentformName%>.<%=m_strParentUserIDsControl%>.value = objtxtUserIDs.value ;
		window.close();
	}
	function Clear_Click()
	{
		ClearAll_OnClick('frmKMEmpList','chkSelect');
		objtxtUserIDs.value = '';
		objtxtUsers.value = '';
	}
	function SelectAll_Click()
	{
	
		var objCheckbox = GetObjectReference('frmKMEmpList','chkSelect',true);
		var intItems;
		var intCtr;
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
						
			if(intItems > 1) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].checked == false)
						{
					    objCheckbox[intCtr].checked = true;	
                        //Commented and Added By Bharat T on 19th-Nov-2015
					    //objCheckbox[intCtr].fireEvent('Onclick');						
					    objCheckbox[intCtr].onclick();
					    //Ended of Commented and Added By Bharat T on 19th-Nov-2015
						}
				}
			}
			else
			{
                //Added By Chakshuta H on 24th-Aug-2016 Purpose:QA issue fixing
			    if(objCheckbox[0]!=undefined)
			    {
			        //End Of Added By Chakshuta H on 24th-Aug-2016 Purpose:QA issue fixing
			        if (objCheckbox[0].checked == false)
			        {
			            objCheckbox[0].checked = true;	
			            //Commented and Added By Bharat T on 19th-Nov-2015
			            //objCheckbox[0].fireEvent('Onclick');	
			            objCheckbox[0].onclick();
			            //End of Commented and Added By Bharat T on 19th-Nov-2015
			        }
			    }
			}
		}
	}
	function ClearAll_Click()
	{
		var objCheckbox = GetObjectReference('frmKMEmpList','chkSelect',true);
		var intItems;
		var intCtr;
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
						
			if(intItems > 1) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].checked == true)
						{
					    objCheckbox[intCtr].checked = false;		
					    //Commented and Added By Bharat T on 19th-Nov-2015
					    //objCheckbox[intCtr].fireEvent('Onclick');
					    objCheckbox[intCtr].onclick();
					    //End of Commented and Added By Bharat T on 19th-Nov-2015
						}
				}
			}
			else
			{
			    //Added By Chakshuta H on 24th-Aug-2016 Purpose:QA issue fixing
			    if(objCheckbox[0]!=undefined)
			    {
			        //End Of Added By Chakshuta H on 24th-Aug-2016 Purpose:QA issue fixing
			        if (objCheckbox[0].checked == true)
			        {
			            objCheckbox[0].checked = false;		
			            //Commented and Added By Bharat T on 19th-Nov-2015
			            //objCheckbox[0].fireEvent('Onclick');
			            objCheckbox[0].onclick();
			            //End of Commented and Added By Bharat T on 19th-Nov-2015
			        }
			    }
			}
		}
	}
	
		
	function Filter_OnChange()
	{
	objForm.action = "KM_Employeeselection.aspx?Filter=1";
	objForm.submit();
	}
	function Checked(strID,strUser,objCheckBox)
	{
	var strUserIDs ,strUsers
	 strUserIDs = 	objtxtUserIDs.value;		
	 strUsers = 	objtxtUsers.value;
		if (objCheckBox.checked == true)
		{
		 objtxtUserIDs.value = strUserIDs + strID + ',' ;
		 objtxtUsers.value = strUsers  + strUser + ',' ;
		}
		else
		{
		 strUserIDs = ',' + strUserIDs ;
		 strUsers =  ',' + strUsers ;
		 strUserIDs = strUserIDs.replace(',' + strID + ',',',')
		 strUsers = strUsers.replace(',' + strUser + ',',',')
		 
		 strUserIDs = strUserIDs.substring(1)
		 strUsers = strUsers.substring(1)
		 
		 objtxtUserIDs.value = strUserIDs 
		 objtxtUsers.value = strUsers  
		}
	}
	function AlphaNumericPaging_OnClick(chr)
		{
			objForm.action = "KM_Employeeselection.aspx?Filter=1&PagingAlphabet=" + chr;
			objForm.submit();
		}

	function Page_OnClick(Page)
	{
			objForm.action = "KM_Employeeselection.aspx?PageNumber=" + Page ;
			objForm.submit();
	}
	
	var noOfPages = GetObjectReference('frmKMEmpList','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmKMEmpList','txtPageNumber');
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
				var objtxtpageNumber =  GetObjectReference('frmKMEmpList','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmKMEmpList','txtNoOfPages');
								
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
	function txtEmp_KeyPress(e)
	{
		var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
		if(code==13) 
		{
		objForm.action = "KM_Employeeselection.aspx?Filter=1";
		objForm.submit();
		}
	}
	</script>
	</body>
</HTML>
