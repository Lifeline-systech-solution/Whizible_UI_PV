<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TimeSheet.aspx.vb" Inherits="PbNIT.PM_TimeSheet"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("TimeSheet")%>
<script type="text/javascript" src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added by Yogesh J on 05/12/2015*/
    pre {
        width:500px;
    }
    /*End of addition by Yogesh J on 05/12/2015*/

#DivTaskList
{
overflow: scroll;
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
     //   responsiveFooterMenu();
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
      //  responsiveSubTableFooterMenu();
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
       // responsiveFooterMenuResize();
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
      //  responsiveSubTableFooterMenuResize();
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body class="clsBody" MS_POSITIONING="GridLayout" onResize="window_onResize()" onload="window_onload() " >
		<form id="frmTimeSheet" method="post" runat="server">
			<%BuildPage()%>
		</form>
		<script language="javascript">
	
	var objfrmTimeSheet = GetFormReference('frmTimeSheet');
	var objchkWSRStatus = GetObjectReference('frmTimeSheet','chkWSRStatus',1);
	var objchkWSR = GetObjectReference('frmTimeSheet','chkWSR',1);
	var objtxtFromDate = GetObjectReference('objfrmTimeSheet','txtFromDate');
	var objtxtToDate = GetObjectReference('objfrmTimeSheet','txtToDate');
		    // Added By Vidya J on 17-11-2015
	var objtblheight=document.getElementById('tbltm');
		    //End of Added By Vidya J on 17-11-2015
	var objDivTaskList = GetObjectReference('objfrmTimeSheet','DivTaskList');
	var objDivResources = GetObjectReference('objfrmTimeSheet','DivResources');
	var objDivTimeSheet = GetObjectReference('objfrmTimeSheet','DivTimeSheet');
	

		 
	
	//Added by HarshK for sp4 issue id 561
	var strOverlapValidation = '<%=m_strOverlapValidation%>';
	//End Added by HarshK for sp4 issue id 561
	//Added By VivekP On 2 August 2005 For SP4 PMLifeLine IssueID-87
	<%If blnSendEmail = True Then%>
		<%IF blnShowPopup = True Then%>
			<%IF blnAuthenticateFlag = True Then%>
			window.open("../General/SendEmail.aspx?MessageID=3&TimeSheetID=<%=intTimeSheetNo%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
			<%End If%>
		<%End If%>
	<%End If%>
	//End Of Addition On 2 August 2005 For SP4 PMLifeLine IssueID-87
			<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		    // Added By Vidya J on 17-11-2015
            
		    function window_onload()
		    {     
		        //debugger;
		       
		        var intDivHeight ;
		        //Added by Yogesh J on 03-Dec-2015
             if (objDivTaskList!=null) //Added By Vaijat K ON 03/11/2015
		        {
		            if(WhichBrowser() == 'IE')
		            {
		                intDivHeight = window.innerHeight -  objDivTaskList.offsetTop - 28;
		            }
		            else
		            {
		                intDivHeight = window.innerHeight -  objDivTaskList.offsetTop - 29;
		            }
		            if (intDivHeight < 100)	intDivHeight = 100;
		            objDivTaskList.style.height=intDivHeight + "px";
		          
		        }
		         else if (objDivResources !=null)
		        {
		            if(objDivResources.style.height==210)
		            {
		                if(WhichBrowser() == 'IE')
		                {
		                    intDivHeight = window.innerHeight -  objDivResources.offsetTop - 26;
		                }
		                else
		                {
		                    intDivHeight = window.innerHeight -  objDivResources.offsetTop - 29;
		                }
		          //  if (intDivHeight < 100)	intDivHeight = 100;
		          // objDivResources.style.height=intDivHeight + "px";
		            }
		        }
		       
		        else if ( objDivTimeSheet !=null)
		        {
		           
		           
		                if(WhichBrowser() == 'IE')
		                {
		                    intDivHeight = window.innerHeight -   objDivTimeSheet.offsetTop - 26;
		                }
		                else
		                {
		                    intDivHeight = window.innerHeight -   objDivTimeSheet.offsetTop - 29;
		                }
		                if (intDivHeight < 100)	intDivHeight = 100;
		                objDivTimeSheet.style.height=intDivHeight + "px";

		            
		        }
		            //End of addition by Yogesh J on on 03-Dec-2015
		        else if (objtblheight !=null) 
		        {

		            if(WhichBrowser() == 'IE')
		            {
		                //Commented and Added By Bharat T on 24th-Nov-2015
		                //intDivHeight = document.body.offsetHeight - objtblheight.offsetTop + 690 ;
		                intDivHeight = window.innerHeight -  objtblheight.offsetTop - 28;
		                //End of Commented and Added By Bharat T on 24th-Nov-2015
			        
		            }
		            else
		                if(WhichBrowser() == 'CR')
		                {
		                    //Commented and Added By Bharat T on 24th-Nov-2015
		                    //intDivHeight = document.body.offsetHeight - objtblheight.offsetTop + 678 ;
		                    intDivHeight = window.innerHeight -  objtblheight.offsetTop - 29;
		                    //End of Commented and Added By Bharat T on 24th-Nov-2015
			            
		                }
		                else
		                    if(WhichBrowser() == 'FF')
		                    {
		                        //Commented and Added By Bharat T on 24th-Nov-2015
		                        //intDivHeight = document.body.offsetHeight - objtblheight.offsetTop  + 700;
		                        intDivHeight = window.innerHeight -  objtblheight.offsetTop - 28;
		                        //End of Commented and Added By Bharat T on 24th-Nov-2015
			
		                    }
		            if (intDivHeight < 100)	intDivHeight = 100;
		            objtblheight.style.height=intDivHeight + "px";
		        }
		       
		    }

 
		    function window_onResize()
		    {     			     
		        var intDivHeight ;
		        //Added by Yogesh J on 03-Dec-2015
            if (objDivTaskList!=null)
		        {
		            if(WhichBrowser() == 'IE')
		            {
		                intDivHeight = window.innerHeight -  objDivTaskList.offsetTop - 30;
		            }
		            else
		            {
		                intDivHeight = window.innerHeight -  objDivTaskList.offsetTop - 29;
		            }
		            if (intDivHeight < 100)	intDivHeight = 100;
		            objtblheight.style.height=objDivTaskList + "px";
		        }
            else if (objDivResources !=null)
		        {
		            if(WhichBrowser() == 'IE')
		            {
		                intDivHeight = window.innerHeight -  objDivResources.offsetTop - 26;
		            }
		            else
		            {
		                intDivHeight = window.innerHeight -  objDivResources.offsetTop - 29;
		            }
		           // if (intDivHeight < 100)	intDivHeight = 100;
		           // objDivResources.style.height=intDivHeight + "px";
		        }
		        else if ( objDivTimeSheet !=null)
		        {
		           
		           
		            if(WhichBrowser() == 'IE')
		            {
		                intDivHeight = window.innerHeight -   objDivTimeSheet.offsetTop - 26;
		            }
		            else
		            {
		                intDivHeight = window.innerHeight -   objDivTimeSheet.offsetTop - 29;
		            }
		            if (intDivHeight < 100)	intDivHeight = 100;
		            objDivTimeSheet.style.height=intDivHeight + "px";
		            
		        }
		        //End of addition by Yogesh J on on 03-Dec-2015
		        else if (objtblheight !=null) 
		        {

		            if(WhichBrowser() == 'IE')
		            {
		                //Commented and Added By Bharat T on 24th-Nov-2015
		                //intDivHeight = document.body.offsetHeight - objtblheight.offsetTop + 690 ;
		                intDivHeight = window.innerHeight -  objtblheight.offsetTop - 30;
		                //End of Commented and Added By Bharat T on 24th-Nov-2015
			        
		            }
		            else
		                if(WhichBrowser() == 'CR')
		                {
		                    //Commented and Added By Bharat T on 24th-Nov-2015
		                    //intDivHeight = document.body.offsetHeight - objtblheight.offsetTop + 678 ;
		                    intDivHeight = window.innerHeight -  objtblheight.offsetTop - 29;
		                    //End of Commented and Added By Bharat T on 24th-Nov-2015
			            
		                }
		                else
		                    if(WhichBrowser() == 'FF')
		                    {
		                        //Commented and Added By Bharat T on 24th-Nov-2015
		                        //intDivHeight = document.body.offsetHeight - objtblheight.offsetTop  + 700;
		                        intDivHeight = window.innerHeight -  objtblheight.offsetTop - 32;
		                        //End of Commented and Added By Bharat T on 24th-Nov-2015
			
		                    }
		            if (intDivHeight < 100)	intDivHeight = 100;
		            objtblheight.style.height=intDivHeight + "px";
		        }
		      
		       
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
		    //End of Added By Vidya J on 17-11-2015
	function Generate_OnClick(strFromDate,strTodate)
		    {  
	   
		if(<%=intDAExceedStatusFlag%> == 0)
		{
			//Check for invalid dates
			if((objtxtFromDate.value=="")||(objtxtToDate.value==""))
			{
				alert("Please enter valid dates in the 'From and To' date fields.");
				setFocus(objtxtFromDate);
				return;
			}
			
			//Check for FromDate>ToDate
			if(compareDates(objtxtFromDate.value,objtxtToDate.value)==1)
			{
				//Modified by HarshK for sp4 issueID 568 on 13/10/2005
				alert(replaceSubstring("<%=mybase.GetResourceString("FROMDATE>TODATE")%>","&#39;","'"));
				//ENd Modified by HarshK for sp4 issueID 568 on 13/10/2005
				setFocus(objtxtFromDate);
				return;
			}
			
			//Check for future date
			if(compareDates(objtxtFromDate.value,getDate1(1))==1)
			{
				//Modified by HarshK for sp4 issueID 568 on 13/10/2005
				alert(replaceSubstring("<%=MYBASE.GetResourceString("FUTUREFROMDATE")%>","&#39;","'"));
				//End Modified by HarshK for sp4 issueID 568 on 13/10/2005
				setFocus(objtxtFromDate);
				return;
			}
			//added by harshK for sp4 issueid 561
			
			if(strOverlapValidation != 'False')
			{ 
				//Added By VivekP On 1 August 2005 For SP4 PMLifeLine IssueID-87
				var dateCount=parseInt("<%=dateCount%>");
				
				var strFromDateVal="<%=strFromDateVal%>";
				var	strFromDateValList = strFromDateVal.split(',');
					//alert(strFromDateVal);
				var strToDateVal="<%=strToDateVal%>";
				var strToDateValList=strToDateVal.split(',');
				//alert(strToDateVal);
				
				for(counter=0;counter<dateCount;counter++)
				{
				
				var strFromDateValNew=getDate(objtxtFromDate.value);
				var strToDateValNew=getDate(objtxtToDate.value);
				
				var strFromDateVal=getDate(strFromDateValList[counter]);
				var strToDateVal=getDate(strToDateValList[counter]);
				
					//Commented by ShraddhaM on 20,Mar 2009 for PMLifeLine
				//Purpose : Disallow to generate timsheet for dates of generated timesheet
				//if((strFromDateValNew>=strFromDateVal&&strFromDateValNew<=strToDateVal) || (strToDateValNew>=strFromDateVal&&strToDateValNew<=strToDateVal) || (strFromDateValNew>=strFromDateVal&&strToDateValNew>=strToDateVal) || ( strFromDateValNew>=strFromDateVal&&strToDateValNew<=strToDateVal) || strFromDateValNew <= strFromDateVal)
					if(strFromDateValNew <= strToDateVal && strToDateValNew >= strFromDateVal)
					{
						alert("Project Timesheet already exists in the given date range.");
						return; 
					}
					
				}
				//End Of Addition By vivekP On 1 August 2005 For SP4 PMLifeLine IssueID-87
			}
			//End added by harshK for sp4 issueid 561
			
			
			//Else submit form
			
			objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=Generate&StartDate=" + strFromDate + "&EndDate=" + strTodate

			
			objfrmTimeSheet.submit();
		}
		else
		{
			alert("For this period some employees are entered daily activity after closing of project")
			objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=DAExceed&StartDate=" + strFromDate + "&EndDate=" + strTodate
			objfrmTimeSheet.submit();
		}
			
	}
	
	function StillGenerate_OnClick(strFromDate,strTodate)
	{
		objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=StillGenerate&StartDate=" + strFromDate + "&EndDate=" + strTodate
		objfrmTimeSheet.submit();
	}
	
	
	function View_OnClick()
	{
		//Check for valid dates
		/*if(!IsDate(objtxtFromDate)||(!IsDate(objtxtToDate)))
		{
			alert("Please enter valid dates in the 'From and To' date fields.");
			setFocus(objtxtFromDate);
			return;
		}*/
		//Added by bharat tekade on 5th-sep-2014 purpose:pmlifeline_sp2 issue solving
		if ((objtxtFromDate.value!="") || (objtxtToDate.value!=""))
		{
			if((objtxtFromDate.value==""))
			{
				alert("Please enter valid dates in the 'From' date fields.");
				setFocus(objtxtFromDate);
				return;
			}
			else
			{
			    if ((objtxtToDate.value==""))
			    {
				    alert("Please enter valid dates in the 'To' date fields.");
				    setFocus(objtxtFromDate);
				    return;
			    }
			}
		}
		//Ended by bharat tekade
		//Check forFromDate>ToDate
		if(compareDates(objtxtFromDate.value,objtxtToDate.value)==1)
		{
			//Modified by HarshK for sp4 issueID 568 on 13/10/2005
			alert(replaceSubstring("<%=mybase.GetResourceString("FROMDATE>TODATE")%>","&#39;","'"));
			//End Modified by HarshK for sp4 issueID 568 on 13/10/2005
			setFocus(objtxtFromDate);
			return;
		}
		
		//Else submit form
		/*objfrmTimeSheet.action="PM_TimeSheet.aspx?Mode=View&TimeSheetNo=<%=intTimeSheetNo%>";
		objfrmTimeSheet.submit();		*/
		//Modified By VidyaJ for Empower IssueID - 19110
		
		// START : Commented and modified by ParagD 25-Sept-2006 : Security Issue 6197
		// window.open("PM_TimeSheet.aspx?Mode=View&TimeSheetNo=<%=intTimeSheetNo%>&StartDate=" + objtxtFromDate.value + "&EndDate=" + objtxtToDate.value + "","_self")
		window.open("PM_TimeSheet.aspx?MasterTagID=1049&Mode=View&TimeSheetNo=<%=intTimeSheetNo%>&StartDate=" + objtxtFromDate.value + "&EndDate=" + objtxtToDate.value + "&PKToken=<%=m_strToken_ViewAndGenerate%>"  + "","_self")
		// END : Commented and modified by ParagD 25-Sept-2006 : Security Issue 6197
	}

	function EditTask(strTimeSheetID, intTimeSheetNumber)
    {
        //Commented And Added By Reshma Chavan on 12th April 2020 For Page Crash
		//objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=Edit&TimeSheetID=" + strTimeSheetID + "&TimeSheetNo=" + intTimeSheetNumber;
		objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=Edit&TimeSheetID=" + strTimeSheetID + "&TimeSheetNo=" + intTimeSheetNumber + "&PKToken=<%=m_strToken_ViewAndGenerate%>";
         //End of Commented And Added By Reshma Chavan on 12th April 2020 For Page Crash

        objfrmTimeSheet.submit(); 
	}

	function WSR_Status(intGroupNumber,strTimeSheetIDList)
	{ 
	
		var strTimeSheetIDs = new String();
		strTimeSheetIDs = strTimeSheetIDList;
		var ArrTimeSheetId = strTimeSheetIDs.split(',');
		
		//Modified Code For issueid - 555 - SP4
		if (objchkWSRStatus[intGroupNumber-1] ==null		)
			return;
			
		if(objchkWSRStatus[intGroupNumber-1].checked)
		{ 
		
			for(inti=0;inti<ArrTimeSheetId.length;inti++)
				for(intj=0;intj<objchkWSR.length;intj++)
				{
					if(ArrTimeSheetId[inti]==objchkWSR[intj].value)
					{
						objchkWSR[intj].checked=true;
						break;
					}
				}
		}	
		else
		{
			for(inti=0;inti<ArrTimeSheetId.length;inti++)
				for(intj=0;intj<objchkWSR.length;intj++)
				{
					if(ArrTimeSheetId[inti]==objchkWSR[intj].value)
					{
						objchkWSR[intj].checked=false;
						break;
					}
				}
		}
	}
	
	function Delete_OnClick()
	{
	    //Added by GaneshD on 01 Sep 2009 for PMLifeLine IssueID-33002
	   var blnIsRecordSelected=false;
	   blnIsRecordSelected=IsCheckboxSelected('frmTimeSheet','chkDelete')
        if (blnIsRecordSelected == false)
         {
            alert('Please select at least one task.');
            return;  
          }
          if(blnIsRecordSelected == true)
          // end of addition by GaneshD on 01 Sep 2009
	   if (confirm('<%=mybase.GetResourceString("CONFIRMDELETE")%>'))
	   {
			objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=Delete&TimeSheetNo=<%=intTimeSheetNo%>";
			objfrmTimeSheet.submit();
	   }
	}
	
	function Authenticate_OnClick()	
	{
		//Commented and Modified By JyotiG
		//Issue ID : 7128 
		//Date : 26-Oct-2006
		//Start
		//if("<%=ApproverName%>"=="")
		//{
		//alert("Project Timesheet can not be sent for approval, since no approvers are present.");
		//return;
		//}
		if("<%=m_strAuthenticatedBy%>"=="C")
		{
			if("<%=ApproverName%>"=="")
			{
			alert("Project Timesheet can not be sent for approval, since no active stakeholders are present.");
			return;
			}
		}	
		else
		{
			if("<%=ApproverName%>"=="")
			{
			alert("Project Timesheet can not be sent for approval, since no approvers are present.");
			return;
			}
		}
		//End of modification By JyotiG
		
		//added by harshK for sp4 issueid 555
		if(objchkWSR.length <= 0)
		{
			alert('Project Timesheet can not be sent for approval, since no Task present.')
			return;
		}
		//End added by harshK for sp4 issueid 555
		objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=Authenticate&TimeSheetNo=<%=intTimeSheetNo%>";
		objfrmTimeSheet.submit();
	}
	
	function ReGenerate_OnClick()
	{
		
		objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=Regenerate&TimeSheetNo=<%=intTimeSheetNo%>";
		objfrmTimeSheet.submit();
		
		//end of modification By vivekP on 10 august 2005 IssueID-87
	}
	
	/*function FMAuthenticate_OnClick()
	{
		objfrmTimeSheet.action="TimeSheet.aspx?Mode=FMAuthenticate&TimeSheetNo=<%=intTimeSheetNo%>&GenerateInvoice=No";
		objfrmTimeSheet.submit();
	}*/
	
	function GenerateWSR(intTimeSheetNo,intProjectID)
	{
	// START : Added By ParagD On 14-Sept-2006 : Security Issue 6197
	// window.open("PM_WSREntry.aspx?TimeSheetNo=<%=intTimeSheetNo%>&ProjectID=<%=m_ProjectId%>","","resizable=yes,scrollbars=yes,width=500,height=570,LEft=5,Top=5,menubar=no");
	window.open("PM_WSREntry.aspx?MasterTagID=1049&TimeSheetNo=<%=intTimeSheetNo%>&ProjectID=<%=m_ProjectId%>&PKToken=<%=m_strToken_ViewAndGenerate%>","","resizable=false,scrollbars=yes,width=500,height=570,LEft=5,Top=5,menubar=no");
	// END : Added By ParagD On 14-Sept-2006 : Security Issue 6197
	}
	
	<%--function StatusChange() 
	{
		objfrmTimeSheet.action=="TimeSheet.aspx?Mode=StatusChange&TimeSheetID=<%=strTimeSheetID%>";
		objfrmTimeSheet.submit();
	}
	--%>
	function Back_OnClick(strOrderBy,strAscOrDesc)
	{
		//Commented & Added By Dipali V On 25th Aug 2023 For Change Page 
		//window.location.href ="../General/CommonList.aspx?MasterTagID=1049&FromWhere=PM";
        window.location.href ="../NewAPI/PM/PM_ProjectTimesheetlist.aspx?MasterTagId=1049";
		//window.location.href ="../General/CommonList.aspx?MasterTagID=3059&FromWhere=PM";
		//Commented & Added By Dipali V On 25th Aug 2023 For Change Page 
	}
	
	function UpdateWSR()
	{
		//objfrmTimeSheet.action="PM_TimeSheet.aspx?Mode=WSREntry&TimeSheetNo=<%=intTimeSheetNo%>";
		objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=WSREntry&TimeSheetNo=<%=intTimeSheetNo%>";
		objfrmTimeSheet.submit();
	}
	
	function UploadWSR()
	{
	    /// Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
		//window.open("../General/Attachment.aspx?show=1&FromWhere=WSR&ID=<%=intTimeSheetNo%>&ProjectID=<%=m_ProjectId%>","","resizable=yes,width=550,height=150,Left=100,Top=100");
		window.open("../General/Attachment.aspx?TagID=1049&show=1&FromWhere=WSR&ID=<%=intTimeSheetNo%>&ProjectID=<%=m_ProjectId%>","","resizable=yes,width=550,height=150,Left=100,Top=100");
	    /// End of Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
	}
	
	function Save_OnClick()
	{
	//Modified By VivekP On 19 Sep 2004 For Sp4
		var objtxtTask = GetObjectReference('frmTimeSheet','txtTask');
		var objcboHours = GetObjectReference('frmTimeSheet','cboHours');
		var intduration=objcboHours.value;
		//alert("<%=intSumDurationOld%>"+" "+"<%=intTaskDuration%>");
		var intsumDurationNew=parseFloat("<%=intSumDurationOld%>")-parseFloat("<%=intTaskDuration%>");
		var intsumDuration=parseFloat(intsumDurationNew)+parseFloat(intduration);
		//alert(intsumDuration);
		if(intsumDuration>24)
		{
		alert("Total work(hrs) should not exceeds 24 for resource \'<%=strEmployeeName%>\' on date \'<%=strEntryDateName%>\'.");
		setFocus(objcboHours);
		return;
		}
	//End Of Modification By VivekP On 19 Sep 2004 For Sp4
		if(disallowBlank(objtxtTask,"<%=mybase.GetResourceString("DESCRIPTIONEMPTY")%>",true))
		{
			return;
		}
		objtxtTask.value = Trim(objtxtTask.value);
		//modified by HarshK for sp4 issueid 136 (single quote replaced by double quote)
		if(disallowMaxlengthViolation(objtxtTask,8000,"<%=MYBASE.gETrESOURCEsTRING("DESCRIPTIONMAXLENGTH")%>",true))
		{
			return;
		}
		//End modification by HarshK for sp4 issueid 136
		objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=Save&TimeSheetID=<%=strTimeSheetID%>&TimeSheetNo=<%=intTimeSheetNo%>";
		objfrmTimeSheet.submit();
	}
	
	function SendMail_OnClick()
	{
		window.open("../General/SendEmail.aspx?MessageID=3&TimeSheetID=<%=intTimeSheetNo%>", "","resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
	}
	
	
	function UpdateResourceEfforts()
	{
		window.open("PM_SiteResourceTimesheet.aspx?TimesheetID=<%=intTimeSheetNo%>","","resizable=yes,width=800,height=550,Left=100,Top=100");	
	}
	
	
	//Added the Parameters for Year and Month by DipaliS
	function ViewSiteCalendar(Year,Month)
	{ //Added By Vidya J ON 1 Feb 2016
	    $.ajax({
	    type: 'POST',
	    dataType: 'json',
	    contentType: 'application/json',
	    url: 'PM_TimeSheet.aspx/GenrateURLToken_Calender',
	    data: JSON.stringify({Year: Year, Month: Month,EmployeeID: '<%=Session("intUserID")%>'}),
	    success: function (Result) {
	                                              
	   window.open("PM_SiteCalendar.aspx?FromTimeSheet=1&Year="+ Year + " &Month= "+ Month + " &PKToken=" +Result.d,"","resizable=yes,width=800,height=550,Left=100,Top=100");	
	 },
	    error: function ()
	    {
			/// alert("Error")
	    }

	});
	    //End Of Added By Vidya J ON 1 Feb 2016          

	   
	}
	/*
	Code Added by DipaliS
	Date	:	5 Oct 2004
	Purpose	:	For OnSite-OffShore Changes
	*/
	function FreezeProjectTimesheet()
	{
		objfrmTimeSheet.action="PM_TimeSheet.aspx?MasterTagID=1049&Mode=FreezeTimeSheet&TimeSheetID=<%=strTimeSheetID%>&TimeSheetNo=<%=intTimeSheetNo%>";
		objfrmTimeSheet.submit();
	}
	//End Addition by DipaliS
	//Added by VivekP On 19 Sep 2005 For PMLifeLine Sp4
	function ShowHistory_OnClick()
	{
		window.open("../General/CommonList.aspx?ShowHistory=1&MasterTagID=2100&IsSubTagID=0&TagID=1049&ProjectID=0&UniqueID=<%=intTimeSheetNo%>", "","resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
	}
	//End Of Addition by VivekP On 19 Sep 2005 For PMLifeLine Sp4
	// added by harshada d for PMLifeLine SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
	// ' Added by PrashantD
	function EasyEdit_onClick()
	{
	
		var xmlhttp;
	
	// code for Mozilla, etc.
		if (window.XMLHttpRequest)
			xmlhttp=new XMLHttpRequest()
		
		// code for IE
		else if (window.ActiveXObject)
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
		
		if (xmlhttp!=null)
		xmlhttp = 1;
		else
		xmlhttp = 0;
		
		// START : Added By ParagD On 14-Sept-2006 : Security Issue 6197
		// window.open("../PM/PM_Timesheet_EasyEntry.aspx?xmlhttp="+xmlhttp+"&TimeSheetID=<%=intTimeSheetNo%>", "","resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + 0 + ",top=" + 0 + ",width=900,height=600");
		window.open("../PM/PM_Timesheet_EasyEntry.aspx?xmlhttp="+xmlhttp+"&TimeSheetID=<%=intTimeSheetNo%>&PKToken=<%=m_strToken_ViewAndGenerate%>", "","resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + 0 + ",top=" + 0 + ",width=900,height=600");
		// END : Added By ParagD On 14-Sept-2006 : Security Issue 6197
	}
	// end of addition by harshada d for PMLifeLine SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
        </script>
	</body>
</HTML>
