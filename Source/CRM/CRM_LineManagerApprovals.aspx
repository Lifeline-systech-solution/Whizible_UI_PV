<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_LineManagerApprovals.aspx.vb" Inherits="PbNIT.CRM_LineManagerApprovals" %>

<%  CommonFunctions.General.PlotPageHeadTag("Line Manager Approvals")%>

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
    /*Cmmented added by Shamkant S on  23 Nov 2015*/
     #txtPageNumber 
    {
        height:20px;
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
        //Commented And Added By Vaijat K ON 03/11/2015
        //if ($('.clsgridtable').length > 0) {
        //    var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //}
        if ($('.clsPageBody').find('#frmLineManagerApprovals').find('#PageDiv').length > 0) {
            var divName = $('.clsPageBody').find('#frmLineManagerApprovals').find('#PageDiv').attr('id');
            dataCollapse(divName);
        }
        //End Added By Vaijat K ON 03/11/2015
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

<body class="clsPageBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()">
	<form id="frmLineManagerApprovals" runat="server">
     <%WritePage()%>
    </form>
    <script language="javascript">
    
    var objform=GetFormReference('frmLineManagerApprovals');
	var objdivlist=GetObjectReference('frmLineManagerApprovals','PageDiv');
    var objDivNOI= GetObjectReference("frmLineManagerApprovals","DivNOI");
	var noOfPages = GetObjectReference('frmLineManagerApprovals','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmLineManagerApprovals','txtPageNumber');
						
    var isClickImagePopup = false;
    
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
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
				}
				else
				{  
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop -50;
				}
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivlist.style.height = intDivHeight + 'px';	//Added By Nilesh g on 11/12/2015
			}
			 
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
				}
				else
				{  
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
				}
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015
			}
		}	
		
		function close_OnClick()
		{
		    window.close();
		}
		var objTDRolledNow;
		var objContextMenu;
		document.onmouseup=function()
		{
			objContextMenu = GetObjectReference('frmLineManagerApprovals','divContextMenu');
			if(objContextMenu){objContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
		}
		 //Added parameter Token by Amit Mahadik on 23Mar2011 Purpose:PMLifeLine Show details of request
  function ShowPopup(ev,obj,QueryID,Token)
   //end Added parameter Token by Amit Mahadik on 23Mar2011 Purpose:PMLifeLine Show details of request
  {
    var LoginUser = "<%=session("intUserID")%>" ;	
			
	 
		objTDRolledNow=obj;obj.className='clsTDRolledOver';
	 
	var objContextMenu = GetObjectReference('frmLineManagerApprovals','divContextMenu');
	 
	var mousePosition = getMousePosition(ev,objContextMenu);
	 
	objContextMenu.style.visibility= 'visible';
	objContextMenu.style.position = 'absolute';
	//Commented And Added By Vaijat K ON 19/01/2016
      //objContextMenu.style.left = mousePosition.x;objContextMenu.style.top = mousePosition.y;
	if (WhichBrowser() == 'FF') {
	    objContextMenu.style.left = ev.pageX + 'px';
	    if (ev.pageY > 700) {
	        objContextMenu.style.bottom = ev.pageY + 'px'
	        objContextMenu.style.top = ev.pageY - 200 + 'px'
	    }
	    else {
	        objContextMenu.style.top = ev.pageY + 'px'
	    }
	}
	else {
	    objContextMenu.style.left = event.pageX + 'px';
	    if (event.pageY > 700) {
	        objContextMenu.style.bottom = event.pageY + 'px'
	        objContextMenu.style.top = event.pageY - 200 + 'px'
	    }
	    else {
	        objContextMenu.style.top = event.pageY + 'px'
	    }
	}
      //Ended
    var objTrMenuHR = GetObjectReference('frmLineManagerApprovals','trMenuHR');
	if(objTrMenuHR){objTrMenuHR.className='Menu_Hr';}
	var objApprove = GetObjectReference('frmLineManagerApprovals','tdApprove');
	var objReject = GetObjectReference('frmLineManagerApprovals','tdReject');
	 //Added by Amit Mahadik on 29Mar2011 Purpose:PMLifeLine Show details of request
	var objShowDetails = GetObjectReference('frmLineManagerApprovals','tdShowDetails');
	//end Added by Amit Mahadik on 29Mar2011 Purpose:PMLifeLine Show details of request
	
	objApprove.onclick=function()
	{
		   showCommentDiv(ev,obj,'A',QueryID);
	}
	
	objReject.onclick=function()
	{
		    showCommentDiv(ev,obj,'R',QueryID);
	}
	//Added by Amit Mahadik on 23Mar2011 Purpose:Encore Show details of request
	objShowDetails.onclick=function()
	{
		 ////alert('QueryID:'+ QueryID +" Token:"+Token);
		 window.open("CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&Approver=1&QueryID=" + QueryID + "&PKToken=" + Token ,"_requestdetail","resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"); 
	}
	//end Added by Amit Mahadik on 23Mar2011 Purpose:Encore Show details of request	
	
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
    
    function showCommentDiv(ev,obj,Action,QueryID)
    {
            var mousePosition = getMousePosition(ev,objDivNOI);
            var objtdComment = GetObjectReference('frmLineManagerApprovals','tdComment');
            //Modified  by vidyak for PMLifeLine SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
           var objstrComments=GetObjectReference('frmLineManagerApprovals','txtSubmitComments');
            if(objtdComment)
            {
                if(Action=='A')
                {
                    objtdComment.innerHTML = "<b>Add Approval Comments</b>";
                    objstrComments.value = 'Approved';                    
                }
                else if(Action=='R')
                {
                    objtdComment.innerHTML = "<b>Add Rejection Comments</b>";
                    objstrComments.value = 'Rejected';     
                }
            }
          //End Modified  by vidyak for PMLifeLine SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
            
            objDivNOI.setAttribute("Action",Action);
             objDivNOI.setAttribute("QueryID",QueryID);
             
			objDivNOI.style.width  = '305px';
			objDivNOI.style.height = '125px';
        //Commented And Added By Vaijat K ON 17/02/2016
        //objDivNOI.style.left = mousePosition.x;objDivNOI.style.top = mousePosition.y;
        
			if (WhichBrowser() == 'FF') {
			    objDivNOI.style.left = (ev.pageX - 10) + 'px';
			    if (ev.pageY > 700) {
			        objDivNOI.style.bottom = (ev.pageY - 10) + 'px'
			        objDivNOI.style.top = (ev.pageY - 160) + 'px'
			    }
			    else {
			        objDivNOI.style.top = (ev.pageY - 10) + 'px'
			    }
			}
			else {
			    objDivNOI.style.left = (event.pageX - 10) + 'px';
			    if (event.pageY > 700) {
			        objDivNOI.style.bottom = (event.pageY - 10) + 'px'
			        objDivNOI.style.top = (event.pageY - 160) + 'px'
			    }
			    else {
			        objDivNOI.style.top = (event.pageY - 10) + 'px'
			    }
			}
        //End Added By Vaijat K ON 17/02/2016
		    objDivNOI.style.position ='absolute';
			objDivNOI.style.display  = '';
			
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
		
function SubmitOK_Onclick()
{
    var Status = objDivNOI.getAttribute("Action");
    var QueryID = objDivNOI.getAttribute("QueryID");
    //Added By VarunA on 28-Nov-2008
    //Purpose : To have the comments as mandatory.
    var objstrComments=GetObjectReference('','txtSubmitComments',true);
    if(disallowBlank(objstrComments,'Comments cannot be left blank.')==true)
    { 
        /*if (objstrComments!= null)
        {
            objstrComments.focus();
        }*/
        return; 
    }
     if (disallowMaxlengthViolation(objstrComments,100,"Comments should not be more than 100 characters.")) 
     {
        return;
     }
    //End By VarunA on 28-Nov-2008 
    
    objform.action= "CRM_LineManagerApprovals.aspx?ACTION=SUBMIT&Filter=<%=m_strFilterID%>&Status="+Status+"&QueryID="+QueryID;
	objform.submit();
    
}
function Cancel_OnClick()
{
    var objstrComments=GetObjectReference('','txtSubmitComments');
    if (objDivNOI!= null)
	    objDivNOI.style.display="none"; 
	objstrComments.value='';    
}

//Added filter parameter to function OptFilter_OnChange and Querystring parameter By VarunA on 28-Nov-2008 IssueID-24169
//Purpose:All Types of Requests are been seen in all the pages when cliked on any radio button.
function OptFilter_OnChange(intFilter)
{
    //objform.action= "CRM_LineManagerApprovals.aspx?ACTION=FILTER";
    objform.action= "CRM_LineManagerApprovals.aspx?ACTION=FILTER&Filter="+intFilter;
	objform.submit();
}
//end by VarunA on 28-Nov-2008 IssueID-24169

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
				var objtxtpageNumber =  GetObjectReference('frmLineManagerApprovals','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmLineManagerApprovals','txtNoOfPages');
								
				//if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				if (!disallowBlank(objtxtpageNumber,"Please Enter Page Number.",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number must be Numeric.",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Page number must be Positive.",true)) & (!disallowNonInteger(objtxtpageNumber,"Page number must be Integer.",true)))				
				{
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Page number is not valid.");
						return;
					}
					Page_OnClick(objtxtpageNumber.value);
				}
			}
		
		}
		function Page_OnClick(page)
		{		        
				objform.action= "CRM_LineManagerApprovals.aspx?PageNumber="+page;
	            objform.submit();
		}
		

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
	var noOfPages = GetObjectReference('frmLineManagerApprovals','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmLineManagerApprovals','txtPageNumber');
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
	var noOfPages = GetObjectReference('frmLineManagerApprovals','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmLineManagerApprovals','txtPageNumber');
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
		
    </script>
</body> 
</html>
