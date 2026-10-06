<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Test_Case_Responses.aspx.vb" Inherits="PbNIT.Test_Case_Responses"%>
<!DOCTYPE HTML>
<HTML>
	 <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("")%>

<%--	<%CommonFunctions.General.PlotPageHeadTag("Test Case Response")%>
  
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js" type="text/javascript"></script>


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
<%--End of Commented and Added By Yogesh Jalamkar on 18th-September-2015 for Responsive Page--%>
	<body class='clsBody' onload='window_onload()' onresize='window_onresize()'>
	    <!--Modified By VarunA on 25-Sep-2008 IssueID-22556 -->
	    <!--<form name="frmTestCaseResponse" method="post" action="Test_Case_Responses.aspx">-->
		<form id="frmTestCaseResponse" name="frmTestCaseResponse" method="post" action="Test_Case_Responses.aspx">
		<!--End By VarunA on 25-Sep-2008 -->
			<%PageInit()%>
			<script language="javascript">
			
var iProjectID=<%=m_intProjectID.toString%>
var isPageInSubmitProcess = false;			
var Flag = true;
var regIds=[];
var currPageNo=1;
var objfrm = GetFormReference('frmTestCaseResponse');
var objPageNo = GetObjectReference('frmTestCaseResponse', 'txtPageNumber');
var objimgPrev = GetObjectReference('frmTestCaseResponse', 'imgPrev');
var objimgNext = GetObjectReference('frmTestCaseResponse', 'imgNext');
var objhidNoOfPages = GetObjectReference('frmTestCaseResponse', 'hidNoOfPages');
var objcboTestSet = GetObjectReference('frmTestCaseResponse', 'cboTestSet');
var objhidNoOfAlteredTestCases  = GetObjectReference('frmTestCaseResponse', 'hidNoOfAlteredTestCases');


var objhidAddRemBKMK = GetObjectReference('frmTestCaseResponse', 'hidAddRemBKMK');

var objdivlist = GetObjectReference('frmTestCaseResponse', 'divPage');

//For Book Marks
var objhidPostForBKMKID  = GetObjectReference('frmTestCaseResponse', 'hidPostForBKMKID');
//objhidPostForBKMKID.value="Prashant";

var isBKMKClicked = false;
var arrBKMKs_PGs = new Array();
var isPrevBKMKonCurrPage=true;
var isNextBKMKonCurrPage=true;
var isPrevBKMK = false;
var isNextBKMK = false;
var ptr_arrBKMKs_PGs = -1;

var ptr_arrPrevBKMK = -1;
var ptr_arrNextBKMK = -1;
var isReqPostPrevBKMK = false;
var isReqPostNextBKMK = false;
var newNextBKMK;
var newPrevBKMK;
var iPageNo=objPageNo.value; //This extra variables because objPageNo.value might be blank.
if (iPageNo=="")
iPageNo = 1;

            <%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>

function window_onresize()
{
		var intDivHeight ;
		var intDivHeightRisk;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
		}
		else{
		intDivHeight = window.innerHeight - 42;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
				
		objdivlist.style.height = intDivHeight;
		if (Flag == true)
		objdivlist.HEIGHT = intDivHeight;
		else
		objdivlist.HEIGHT = intDivHeight-94;
		
		
}

function window_onload()
{
//hide num paging if page no is less than 2
if(objhidNoOfPages.value < 2)
GetObjectReference('frmTestCaseResponse', 'TDPaging').innerHTML="";
//objcboTestSet.focus();
		var intDivHeight ;
		var intDivHeightRisk;
		var lc;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop - 42;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
    //Comment added on 11 Dec 2015 by Viraj P
    //objdivlist.style.height = intDivHeight;	
		objdivlist.style.height = intDivHeight + 'px';

		objdivlist.HEIGHT = intDivHeight;
		//For BookMarks
		var arrCounter=1;
		var FirstBKMKCurrPage = GetObjectReference('frmTestCaseResponse', 'FirstBKMKCurrPage').value;
		arrBKMKs_PGs = GetObjectReference('frmTestCaseResponse', 'allBKMK').value.split(",");
		
		
		//var objdivBK = GetObjectReference('frmTestCaseResponse', 'divBK');
		var objTDPrevBK = GetObjectReference('frmTestCaseResponse', 'tdPrevBKMK');
		var objTDNextBK = GetObjectReference('frmTestCaseResponse', 'tdNextBKMK');
		
		
	
    //Added By Bharat T on 14th-Oct-2015
    //var objPrevBKMK = GetObjectReference('frmTestCaseResponse', 'PrevBKMK');
		var objPrevBKMK = GetObjectReference('frmTestCaseResponse', 'prevBKMK');
    //End of Added By Bharat T on 14th-Oct-2015
		var objNextBKMK = GetObjectReference('frmTestCaseResponse', 'nextBKMK');
		
		
		//Setting prev bookmark href
		//objdivBK.removeChild(objPrevBKMK); //remove comment if want to display image althogh prev BKMK is not present
		
			//pages 1=CaseId 2=Page
			
			//Prev bkmk may present on same page. ( I exclude FirstBKMKCurrPage as prev bkmk)
		
			if(objhidPostForBKMKID.value != "")
			{
				arrCounter=1;
				while(arrCounter<arrBKMKs_PGs.length)
				{
					if (objhidPostForBKMKID.value==arrBKMKs_PGs[arrCounter]) 
					if(arrBKMKs_PGs[arrCounter-1] == iPageNo)
					{
						isReqPostPrevBKMK = false;
						objTDPrevBK.removeChild(objPrevBKMK);
						objPrevBKMK.href="#BKMK"+arrBKMKs_PGs[arrCounter-2];
						objTDPrevBK.appendChild(objPrevBKMK);
						ptr_arrPrevBKMK = arrCounter-2;
						break;
					}
					arrCounter+=2;
				}
			}
			if(ptr_arrPrevBKMK == -1)
			{
				//If curr page =1 find bkmk for prev image from last page in array.
				//if curr page=3 find bkmk for prev image from 2 to 0. then last page to 4.
				arrCounter=arrBKMKs_PGs.length-1; 
				while(0 < arrCounter)
				{
					if ((iPageNo-1) >= arrBKMKs_PGs[arrCounter])
					{
						objTDPrevBK.removeChild(objPrevBKMK);
						objPrevBKMK.href="#BKMK"+arrBKMKs_PGs[arrCounter-1];
						objTDPrevBK.appendChild(objPrevBKMK);
						
						ptr_arrPrevBKMK = arrCounter-1;
						isReqPostPrevBKMK = true;
						break;
					}
					arrCounter-=2;
					//arrCounter+=2;
				}
				if(ptr_arrPrevBKMK == -1) //Still not found bkmk, bkmk will last bkmk of array
				if(arrBKMKs_PGs.length>2)
				{
						objTDPrevBK.removeChild(objPrevBKMK);
						objPrevBKMK.href="#BKMK"+arrBKMKs_PGs[arrBKMKs_PGs.length-2];
						objTDPrevBK.appendChild(objPrevBKMK);
						
						ptr_arrPrevBKMK = arrBKMKs_PGs.length-2;
						isReqPostPrevBKMK = true;
				}
			}
		
		//end of setting first bookmark href
		
		
		
		//Setting next book mark
		
		objTDNextBK.removeChild(objNextBKMK);
		
		//if FirstBKMKCurrPage is  not blank and page is not set bkmk on load then 
		//bkmk will be on next pages.
		//Still not, it will be first bkmk on array
	
		if(objhidPostForBKMKID.value != "")
			{
				arrCounter=arrBKMKs_PGs.length-2;
				while(arrCounter>0)
				{
					if (objhidPostForBKMKID.value==arrBKMKs_PGs[arrCounter]) 
					{
						if (arrBKMKs_PGs.length > arrCounter+3)
						{
							if(arrBKMKs_PGs[arrCounter+3] != iPageNo)
								isReqPostNextBKMK = true;
								//objTDNextBK.removeChild(objNextBKMK);
								objNextBKMK.href="#BKMK"+arrBKMKs_PGs[arrCounter+2];
								//objTDNextBK.appendChild(objNextBKMK);
								ptr_arrNextBKMK = arrCounter+2;
								break;
							
						}
						else
						{
								isReqPostNextBKMK = true;
								//objTDNextBK.removeChild(objNextBKMK);
								objNextBKMK.href="#BKMK"+arrBKMKs_PGs[1];
								//objTDNextBK.appendChild(objNextBKMK);
								ptr_arrNextBKMK = 1;
						}
						
					}
					arrCounter-=2;
				}
			}
			
		
		if(ptr_arrNextBKMK==-1)
		{
				if (FirstBKMKCurrPage != "" && !GetObjectReference('frmTestCaseResponse', 'hidIsPostForBKMK'))
				{
				
					objNextBKMK.href="#BKMK"+FirstBKMKCurrPage;
					
					arrCounter=1;
					while(arrBKMKs_PGs.length > arrCounter)
					{
						if(arrBKMKs_PGs[arrCounter] == FirstBKMKCurrPage )
						{
							ptr_arrNextBKMK=arrCounter;	
							break;
						}
						arrCounter+=2;
					}
					
					//objdivBK.appendChild(objNextBKMK);  //appending ctrl only when next BKMK is present
				}
				
				else 
				{
					//if FirstBKMKCurrPage is not blank. But page is set bkmk on load then 
					//ptrs of next should not on self. It should points to next bkmk
					if(FirstBKMKCurrPage != "" && GetObjectReference('frmTestCaseResponse', 'hidIsPostForBKMK'))
					{
					
						//set arrCounter to FirstBKMKCurrPage
						arrCounter=1;
						while (arrCounter < arrBKMKs_PGs.length)
						{ 
							if(arrBKMKs_PGs[arrCounter]==FirstBKMKCurrPage)	
							{
								if((arrCounter+3) < arrBKMKs_PGs.length)
								{
									if(arrBKMKs_PGs[arrCounter+3] != iPageNo)
									isReqPostNextBKMK = true;
									objNextBKMK.href="#BKMK"+arrBKMKs_PGs[arrCounter+2];
									ptr_arrNextBKMK = arrCounter+2;
								}
								
								break;
							}
							arrCounter+=2; 
						}
						if(ptr_arrNextBKMK==-1)
						{
							if(arrBKMKs_PGs[1]!=FirstBKMKCurrPage)	
								isReqPostNextBKMK = true;
							objNextBKMK.href="#BKMK"+arrBKMKs_PGs[1];
							ptr_arrNextBKMK = 1;
						}
						
										
					}
					else 
					{
						//if FirstBKMKCurrPage is blank i.e. Next BKMK is not on curr page but
						// BKMK may present on next page. 
						//still not found bkmk then it will first bkmk of array
					
					arrCounter=2;
					while(arrBKMKs_PGs.length > arrCounter)
					{
						
						if ((iPageNo+1) <= arrBKMKs_PGs[arrCounter])
						{
							objNextBKMK.href="#BKMK"+arrBKMKs_PGs[arrCounter-1];
							ptr_arrNextBKMK = arrCounter-1;
							isReqPostNextBKMK = true;
							break;
						}
						arrCounter+=2;
						
					}
					
					if(ptr_arrNextBKMK == -1)
					{
						objNextBKMK.href="#BKMK"+arrBKMKs_PGs[1];
						ptr_arrNextBKMK = 1;
						isReqPostNextBKMK = true;
					}
					//objdivBK.appendChild(objNextBKMK);  //appending ctrl only when next BKMK is present
					}
				}
			
			}
			
			objTDNextBK.appendChild(objNextBKMK); //remove comment if want to display image althogh next BKMK is not present
		//end of setting next bookmark href
		
		//processBKMK  prevBKMK isPrevBKMKonCurrPage
		
if(ptr_arrNextBKMK==-1 || ptr_arrPrevBKMK==-1)
{

objTDNextBK.removeChild(objNextBKMK);
objTDPrevBK.removeChild(objPrevBKMK);

GetObjectReference('frmTestCaseResponse', 'divBKTbl').style.display="none";


}
if(objhidPostForBKMKID.value!="")		
isBKMKClicked=true;		
objhidPostForBKMKID.value="";
//debugger;
}

function onClickBKMK(arg)
{
if (isTestSetBlank() == true)
return;

var objdivBK = GetObjectReference('frmTestCaseResponse', 'divBK');
	
    //Added By Bharat T on 14th-Oct-2015
    //var objPrevBKMK = GetObjectReference('frmTestCaseResponse', 'PrevBKMK');
var objPrevBKMK = GetObjectReference('frmTestCaseResponse', 'prevBKMK');
    //End of Added By Bharat T on 14th-Oct-2015
var objNextBKMK = GetObjectReference('frmTestCaseResponse', 'nextBKMK');
var FirstBKMKCurrPage = GetObjectReference('frmTestCaseResponse', 'FirstBKMKCurrPage').value;
var objTDPrevBK = GetObjectReference('frmTestCaseResponse', 'tdPrevBKMK');
var objTDNextBK = GetObjectReference('frmTestCaseResponse', 'tdNextBKMK');
//debugger;
if(arg == 'prev') //if of arg == 'prev
{

	if (isReqPostPrevBKMK == true)
	{
	//alert("Prev Submit");
		objPageNo.value=arrBKMKs_PGs[ptr_arrPrevBKMK+1];
		GetObjectReference('frmTestCaseResponse', 'hidAction').value = "GOTOBOOKMK";
		objhidPostForBKMKID.value = arrBKMKs_PGs[ptr_arrPrevBKMK];
		SubmitPage("#BKMK"+arrBKMKs_PGs[ptr_arrPrevBKMK]);
	}
	
	
	if (isBKMKClicked == true) //this condn true when  bkmk cliked on second time
	{
	//Setting curr next bkmk as prev bkmk
	
		ptr_arrNextBKMK =ptr_arrNextBKMK-2
		if (ptr_arrNextBKMK<1)
		ptr_arrNextBKMK = ptr_arrPrevBKMK+2
		if (ptr_arrNextBKMK>=arrBKMKs_PGs.length)
		ptr_arrNextBKMK = 1; 
		
		newNextBKMK = document.createElement("A");
		newNextBKMK.innerHTML = "<Img Border=0 src='../../Images/BookMark/NextBKMK.gif' align='top'>"
		newNextBKMK.id="nextBKMK";
		newNextBKMK.title="Move the caret to the next bookmark";
		newNextBKMK.onclick=function(){ onClickBKMK('next'); };
		newNextBKMK.onblur=function(){ onBlurBKMK('next'); };
		newNextBKMK.href = "#BKMK"+arrBKMKs_PGs[ptr_arrNextBKMK];
		if (iPageNo != arrBKMKs_PGs[ptr_arrNextBKMK+1])
		isReqPostNextBKMK = true;
		else
		isReqPostNextBKMK = false;
		
		//ptr_arrNextBKMK =ptr_arrNextBKMK-2
		
	}
	
	if (0 < ptr_arrPrevBKMK-2 && ptr_arrPrevBKMK != -1)
	{
	
		ptr_arrPrevBKMK -=2;
		if(iPageNo != arrBKMKs_PGs[ptr_arrPrevBKMK+1])
		isReqPostPrevBKMK = true;
		
		newPrevBKMK = document.createElement("A");
		newPrevBKMK.innerHTML = "<Img Border=0 src='../../Images/BookMark/PrevBKMK.gif' align='top'>"
		newPrevBKMK.id="prevBKMK";
		newPrevBKMK.title="Move the caret to the previous bookmark";
		newPrevBKMK.onclick=function(){ onClickBKMK('prev'); };
		newPrevBKMK.onblur=function(){ onBlurBKMK('prev'); };
		
		newPrevBKMK.href = "#BKMK"+arrBKMKs_PGs[ptr_arrPrevBKMK];
		
	}
	else
	{
		/*	
		if(objPageNo.value != arrBKMKs_PGs[ptr_arrPrevBKMK+1])
		isReqPostPrevBKMK = true;
		*/
		
		newPrevBKMK = document.createElement("A");
		newPrevBKMK.innerHTML = "<Img Border=0 src='../../Images/BookMark/PrevBKMK.gif' align='top'>"
		newPrevBKMK.id="PrevBKMK";
		newPrevBKMK.title="Move the caret to the previous bookmark";
		newPrevBKMK.onclick=function(){ onClickBKMK('prev'); };
		newPrevBKMK.onblur=function(){ onBlurBKMK('prev'); };
		
		ptr_arrPrevBKMK =arrBKMKs_PGs.length-2;
		newPrevBKMK.href = "#BKMK"+arrBKMKs_PGs[ptr_arrPrevBKMK];
		
		if(iPageNo != arrBKMKs_PGs[ptr_arrPrevBKMK+1])
		isReqPostPrevBKMK = true;
		
	} 
	
	
	
} //if of arg == 'prev
else if(arg == 'next') //if of arg == 'next'
{
//alert("Next " + arrBKMKs_PGs[ptr_arrNextBKMK]);
	if (isReqPostNextBKMK == true)
	{
		objPageNo.value=arrBKMKs_PGs[ptr_arrNextBKMK+1];
		GetObjectReference('frmTestCaseResponse', 'hidAction').value = "GOTOBOOKMK";
		objhidPostForBKMKID.value = arrBKMKs_PGs[ptr_arrNextBKMK];
		SubmitPage("#BKMK"+arrBKMKs_PGs[ptr_arrNextBKMK]);
		return;
	}
	
	if (isBKMKClicked == true) //this condn true when next bkmk cliked on second time
	{
	//Setting curr next bkmk as prev bkmk
		ptr_arrPrevBKMK =ptr_arrPrevBKMK+2;
		if  (ptr_arrPrevBKMK >= arrBKMKs_PGs.length)
			ptr_arrPrevBKMK =1;
		
		newPrevBKMK = document.createElement("A");
		newPrevBKMK.innerHTML = "<Img Border=0 src='../../Images/BookMark/PrevBKMK.gif' align='top'>"
		newPrevBKMK.id="prevBKMK";
		newPrevBKMK.title="Move the caret to the previous bookmark";
		newPrevBKMK.onclick=function(){ onClickBKMK('prev'); };
		newPrevBKMK.onblur=function(){ onBlurBKMK('prev'); };
		newPrevBKMK.href = "#BKMK"+arrBKMKs_PGs[ptr_arrPrevBKMK];
		
		if(iPageNo != arrBKMKs_PGs[ptr_arrPrevBKMK+1])
		isReqPostPrevBKMK = true;
		else
		isReqPostPrevBKMK = false;
		
		//ptr_arrPrevBKMK =ptr_arrNextBKMK-2;
		
	}
	
	if (arrBKMKs_PGs.length > ptr_arrNextBKMK+2)
	{
		ptr_arrNextBKMK +=2;
		//setPtrPrevBKMK();
		//ptr_arrPrevBKMK=ptr_arrNextBKMK
		
		if(iPageNo != arrBKMKs_PGs[ptr_arrNextBKMK+1])
		isReqPostNextBKMK = true;
		
		newNextBKMK = document.createElement("A");
		newNextBKMK.innerHTML = "<Img Border=0 src='../../Images/BookMark/NextBKMK.gif' align='top'>"
		newNextBKMK.id="nextBKMK";
		newNextBKMK.title="Move the caret to the next bookmark";
		newNextBKMK.onclick=function(){ onClickBKMK('next'); };
		newNextBKMK.onblur=function(){ onBlurBKMK('next'); };
		
		newNextBKMK.href = "#BKMK"+arrBKMKs_PGs[ptr_arrNextBKMK];
		
	}
	else
	{
		/*
		if(objPageNo.value != arrBKMKs_PGs[ptr_arrNextBKMK+1])
		isReqPostNextBKMK = true;
		*/
		
		newNextBKMK = document.createElement("A");
		newNextBKMK.innerHTML = "<Img Border=0 src='../../Images/BookMark/NextBKMK.gif' align='top'>"
		newNextBKMK.id="nextBKMK";
		newNextBKMK.title="Move the caret to the next bookmark";
		newNextBKMK.onclick=function(){ onClickBKMK('next'); };
		newNextBKMK.onblur=function(){ onBlurBKMK('next'); };
		
		ptr_arrNextBKMK =1;
		newNextBKMK.href = "#BKMK"+arrBKMKs_PGs[ptr_arrNextBKMK];
		
		if(iPageNo != arrBKMKs_PGs[ptr_arrNextBKMK+1])
		isReqPostNextBKMK = true;
	} 
	
	
	
	
	
} //if of arg == 'next'

isBKMKClicked = true;

return;
//end of setting next bookmark href


}

function onBlurBKMK(arg)
{

//var objdivBK = GetObjectReference('frmTestCaseResponse', 'divBK');
var objTDPrevBK = GetObjectReference('frmTestCaseResponse', 'tdPrevBKMK');
var objTDNextBK = GetObjectReference('frmTestCaseResponse', 'tdNextBKMK');
	
    //Added By Bharat T on 14th-Oct-2015
    //var objPrevBKMK = GetObjectReference('frmTestCaseResponse', 'PrevBKMK');
var objPrevBKMK = GetObjectReference('frmTestCaseResponse', 'prevBKMK');
    //End of Added By Bharat T on 14th-Oct-2015
var objNextBKMK = GetObjectReference('frmTestCaseResponse', 'nextBKMK');
var FirstBKMKCurrPage = GetObjectReference('frmTestCaseResponse', 'FirstBKMKCurrPage').value;

var ctrl;

if (arg =='next')
{

	if (typeof(newNextBKMK) != "undefined")
	{
		if (typeof(newPrevBKMK) != "undefined")
		{
		objTDPrevBK.removeChild(objPrevBKMK);
		objTDPrevBK.appendChild(newPrevBKMK); //Next BookMark will become Prev BookMark
		}
		
		objTDNextBK.removeChild(objNextBKMK);
		objTDNextBK.appendChild(newNextBKMK);
		
		newPrevBKMK = undefined;
		newNextBKMK = undefined;
	}
}
else if(arg =='prev')
{

	if (typeof(newPrevBKMK) != "undefined")
	{
		
		objTDPrevBK.removeChild(objPrevBKMK);
		objTDPrevBK.appendChild(newPrevBKMK);
		
		if (typeof(newNextBKMK) != "undefined")
		{
		objTDNextBK.removeChild(objNextBKMK);
		objTDNextBK.appendChild(newNextBKMK);
		}
		newPrevBKMK = undefined;
		newNextBKMK = undefined;
	}

}

/*var ctrl = document.createElement("A");
ctrl.innerHTML = "<Img Border=0 src='../../Images/BookMark/PrevBKMK.gif' align='top'>"
ctrl.id="nextBKMK";
ctrl.onclick=function(){ onClickBKMK('next'); };
ctrl.href = "#BKMK"+arrBKMKs_PGs[ptr_arrNextBKMK];
objdivBK.appendChild(ctrl); */
	
}


function saveConfirmMessage()
{
return (confirm("Do you want to save changed results of Test cases"));
}

function showHide_divFilter()
{		
	var objDIV = GetObjectReference('frmTestCaseResponse', 'pageFilterDiv');
	var objimg = GetObjectReference('frmTestCaseResponse', 'pageFilterImg');
	if (Flag==true)
	{
		objDIV.style.display='none';
		objimg.src='../../Images/plus.gif';
		Flag=false;
		objdivlist.style.height = objdivlist.HEIGHT+94; 
		
	}
	else{
		objDIV.style.display='';
		objimg.src='../../Images/minus.gif';
		Flag=true;
	
		objdivlist.style.height = objdivlist.HEIGHT; 
		
	}
}
function SortBy(order)
{

	var objhidOrderBy = GetObjectReference('frmTestCaseResponse', 'hidOrderBy');
	objhidOrderBy.value = order;
	//objfrm.action = "Test_Case_Responses.aspx?Action=Order"
	//objfrm.submit();
	SubmitPage("?Action=Order");

}
function isTestSetBlank()
{	//Start_JG_11494_14-Mar-2007
	var objDIV = GetObjectReference('frmTestCaseResponse', 'pageFilterDiv');
	//End_JG_11494_14-Mar-2007
	if(objcboTestSet.value=="")
	{
		alert("Please select Test Set");
		//Commented and Modified by JyotiG
		//Issue :  1. Go to Project --> Test Case Management --> Test Session  2. Open a record in Edit mode --> Click on Test Execution 3. Collapse the filrer section and Click on "Link to Issue Base" 4. Select OK to alert 
		//Java Script Error
		//Start_JG_11494_14-Mar-2007
		/*objcboTestSet.focus();*/
		if (objDIV.style.display!='none')
		{
			objcboTestSet.focus();
	    } 
	    //End_JG_11494_14-Mar-2007
		return true;
		
	}
	return false;
}
function txtPageNumber_KeyPress(e)
{
	if (isTestSetBlank() == true)
	return;
	
	var code;
	
	
		
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	
	if ((code >= 48 && code <=57) == false)
	{
		if(navigator.appName == 'Microsoft Internet Explorer')
			e.keyCode = 0
		 else
		 	return false;
	}	
	
	if(code==13) 
	if (disallowNegativeNumeric(objPageNo,'Please enter positive numeric value') == false )
	{ 
		if (objPageNo.value < 1  || objhidNoOfPages.value < parseInt(objPageNo.value) )
		{
			alert("Please enter value within range of 1 to "+ objhidNoOfPages.value);
			return;
		}
			//objfrm.action = "Test_Case_Responses.aspx?Action=Paging";
			GetObjectReference('frmTestCaseResponse', 'hidIsShowAll').value="FALSE";
			SubmitPage("?Action=Paging");
	}
}

function NumPageing_OnClick(arg)
{
	/* When disable images available		
	if (objPageNo.value == 1)
	{
	objimgNext.src = "../../Images/NavPreviousDisable.gif"
	objimgPrev.src = "../../Images/NavPreviousDisable.gif"
		
	}*/
	if (objhidNoOfPages.value==0)
	return;
	var strFormAction;
	
	if (isTestSetBlank() == true)
	return;
	
	
	if(Number(objhidNoOfPages.value)<Number(objPageNo.value))
	{
		alert("Please enter value within range of 1 to "+objhidNoOfPages.value);
		return;
	}
	
	strFormAction="?Action=Paging";
	GetObjectReference('frmTestCaseResponse', 'hidIsShowAll').value="FALSE";
	
	if( arg =='F' )
	{
		if (Number(objPageNo.value)==1){alert("This is the first page");return;}
		
		objPageNo.value=1;
		//objfrm.action = "Test_Case_Responses.aspx?Action=Paging";
		
	}
	else if ( arg =='L' )
	{
		if (Number(objPageNo.value)==Number(objhidNoOfPages.value)){alert("This is the last page");return;}
		
		objPageNo.value=objhidNoOfPages.value;
		//objfrm.action = "Test_Case_Responses.aspx?Action=Paging";
		
	
	}
	else if (arg == "-1")
	{
		if (Number(objPageNo.value)==1){alert("This is the first page");return;}
		
		if(objPageNo.value == "")
		objPageNo.value=1;
		else
		objPageNo.value=objPageNo.value - 1;
		//objfrm.action = "Test_Case_Responses.aspx?Action=Paging";
		
	}
	else if (arg == "1")
	{
		if (Number(objPageNo.value)==Number(objhidNoOfPages.value)){alert("This is the last page");return;}
		
		if(objPageNo.value == "")
		objPageNo.value=1;
		else
		objPageNo.value=parseInt(objPageNo.value) + 1;
		//objfrm.action = "Test_Case_Responses.aspx?Action=Paging";
		
	}
	else if (arg = "0")
	{
	
		objPageNo.value="";
		//objfrm.action = "Test_Case_Responses.aspx?Action=Paging&Show=ALL";
		//strFormAction="?Action=Paging&Show=ALL";
		GetObjectReference('frmTestCaseResponse', 'hidIsShowAll').value="TRUE";
	
	}

	//objfrm.submit();
	SubmitPage(strFormAction);
}
		
	


function TestSet_onChange()
{
	if (isTestSetBlank() == true)
	return;
	
	objPageNo.value="1";
	//objfrm.action = "Test_Case_Responses.aspx?Action=Filter";
	SubmitPage("?Action=Filter");
}
function UserStory_onChange()
{
	if (isTestSetBlank() == true)
	return;
	
	objPageNo.value="1";
	//objfrm.action = "Test_Case_Responses.aspx?Action=Filter";
	SubmitPage("?Action=Filter");
}
function currResult_onChange(regId)
{

	reqisterTestCase(regId);
}
function time_onChange(regId)
{
	var objtxtActStaffTime = GetObjectReference('frmTestCaseResponse', 'txtActStaffTime'+regId);
	if (disallowNegativeNumeric(objtxtActStaffTime,'Please enter positive numeric value within range of 0 to 99.9') == true)
		setFocus(GetObjectReference('frmTestCaseResponse', 'txtActStaffTime'+regId));
	
	else if (objtxtActStaffTime.value < 0 || objtxtActStaffTime.value > 99.9 )
	{
		alert('Please enter positive numeric value within range of 0 to 99.9');	
		setFocus(GetObjectReference('frmTestCaseResponse', 'txtActStaffTime'+regId));
	}
	else
		reqisterTestCase(regId);
		
		
}
function notes_onChange(regId,srcObjID)
{
	reqisterTestCase(regId);
}
function reqisterTestCase(regId)
{
	var i =0;
	while(regIds.length > i)
	{
		if ( regIds[i] == regId )
		return;	
		i++;
	}
	
	regIds.push(regId);

	
}

function openIssueBase()
{
var TestSessionID = GetObjectReference('frmTestCaseResponse', 'hidSessionID').value;
var ProjectTestSetID = GetObjectReference('frmTestCaseResponse', 'cboTestSet').value;
var IsTestSessionClosed=GetObjectReference('frmTestCaseResponse', 'hidIsTestSessionClosed').value;
var TestSectionID=GetObjectReference('frmTestCaseResponse', 'cboTestSection').value;

if (isTestSetBlank() == true)
    return;
    //Commented and added by Yogesh Jalamkar on 02-Mar-2016 to pass Token
//window.open("../TCM/TCM_IssueEntry.aspx?IsTestSessionClosed="+IsTestSessionClosed+"&TestSessionID="+TestSessionID+"&ProjectTestSetID="+ProjectTestSetID+"&TestSectionID="+TestSectionID ,"", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
//return;
$.ajax({
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json',
    url: 'Test_Case_Responses.aspx/GenrateURLToken_OpenIssue',
    data: JSON.stringify({ TestSession:TestSessionID, ProjectTestID: ProjectTestSetID, TestSectionID: TestSectionID }),
	    success: function (Result) {   
	        window.open("../TCM/TCM_IssueEntry.aspx?IsTestSessionClosed="+IsTestSessionClosed+"&TestSessionID="+TestSessionID+"&ProjectTestSetID="+ProjectTestSetID+"&TestSectionID="+TestSectionID +"&PKToken="+Result.d,"", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
	        return;
	    },
	    error: function () {
	        //  alert("Error")
	    }
	});
    //End of addition by Yogesh Jalamkar on 02-Mar-2016 to pass Token
	
}

function onSaveValidations()
{
	var counter = 0;
	var objtxtActStaffTime; 
	while (regIds.length >= counter)
	{
		objtxtActStaffTime = GetObjectReference('frmTestCaseResponse', 'txtActStaffTime' + regIds[counter]);
		if (objtxtActStaffTime != null)
		{
			if (disallowNegativeNumeric(objtxtActStaffTime,'Please enter positive numeric value within range of 0 to 99.9') == true)
			{
			
				setFocus(objtxtActStaffTime);
				return false;
				
			}
			else if (objtxtActStaffTime.value < 0 || objtxtActStaffTime.value > 99.9 )
			{
				alert('Please enter positive numeric value within range of 0 to 99.9');
				setFocus(objtxtActStaffTime);
				return false;
			}
		
			//objtxtActStaffTime.value = parseInt(objtxtActStaffTime.value);
		}
		
		counter++;
	}
		objhidNoOfAlteredTestCases.value = regIds;
		
		if (isTestSetBlank() == true)
		return;
		if (objhidNoOfAlteredTestCases.value == '')
		{
			alert("Please edit atleast one Test case")
			return false;
		}
	
	return true;
}

function Save_Click()
{
	if (onSaveValidations())
	//window.opener.location.href=window.opener.location.href;
	
		//objfrm.action = "Test_Case_Responses.aspx?Action=Save";
		//objfrm.submit();
		SubmitPage("?Action=SAVE",false);
		
}

function preopentextdialog(frmName,txtObject,title,IsDisable,idNo)
{

	var	objText=GetObjectReference(frmName,txtObject);
	var strAddress;
	strAddress = objText.value; 
	opentextdialog(frmName,txtObject,"Notes",IsDisable);
	
	
	if (strAddress != objText.value)
	{
		notes_onChange(idNo,objText.id);
	
	}
	
}
function placeHolder_onClick(bkTestCaseID,bkmkID)
{
	
	if(isTestSetBlank()== true)
	return;
	
	if (bkmkID == 0)
	{
		objhidAddRemBKMK.value = "0,"+bkTestCaseID;
	}
	else
	{
		objhidAddRemBKMK.value = bkmkID+","+bkTestCaseID;
	}
	
	GetObjectReference('frmTestCaseResponse', 'hidAction').value = "BOOKMK";
	SubmitPage("#BKMK"+bkTestCaseID);

	
}

function SubmitPage(queryString,blnDisplaySaveConfirm)
{
	if (typeof(blnDisplaySaveConfirm) == "undefined")
	blnDisplaySaveConfirm = true;
	

	if (isPageInSubmitProcess != true )
	{
		if(regIds.length > 0)
		if(<%=blnIsTestSessionClosed.toString.toLower%>==false)
		if(blnDisplaySaveConfirm && saveConfirmMessage() )
		{
			if (!onSaveValidations())
			return;
			
			GetObjectReference('frmTestCaseResponse', 'hidActionMode').value="SAVE";
			
			
		}

		
		objfrm.action = "Test_Case_Responses.aspx"+queryString;
		isPageInSubmitProcess = true;
		objfrm.submit();
	}
	else
	alert("Please wait previous action in progress");
}

function showTestCaseHistory_onClick(PTestCaseID)
{
	window.open("../TCM/Test_Case_History.aspx?ProjectTestCaseID="+PTestCaseID+"", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=600,height=600");
}

function showTestCaseDetails_onClick(PTestCaseID)
{
	window.open("../General/CommonPage.aspx?FromWhere=SM&MasterTagID=3684&Mode=Edit&ProjectTestCaseID="+PTestCaseID, "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
}
function addAttachemnt(PTestCaseID,SessionID)
{

	window.open ('../TCM/TCM_MultiAttachment.aspx?IsTestSessionClosed='+GetObjectReference('frmTestCaseResponse', 'hidIsTestSessionClosed').value+'&TestSessionID='+SessionID+'&ProjectTestCaseID='+PTestCaseID, "_new","resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=550,height=300");										
}

function setAttachmentNo(id,no)
{
	GetObjectReference('frmTestCaseResponse', id).innerHTML = no;
	
}
function showIssueDetailsLink(strIssueIDs)
{

	var arrIssueIDs = strIssueIDs.split(",");
	
	var counter =0;
	var objTD;
	while(arrIssueIDs.length > counter)
	{
		
		
		objTD = GetObjectReference('frmTestCaseResponse', 'TDIBDetails'+arrIssueIDs[counter+2]);
		if (objTD)
		objTD.innerHTML="<A href='JavaScript:showIssueDetails_onClick("+arrIssueIDs[counter]+",\""+ arrIssueIDs[counter+1]+"\")' Title='Click here to open Issue Details' ><%=MyBase.GetResourceString("LNK_ISSUE_DETAILS")%></A>";
	
		counter+=3;
	}
	
}
function showIssueDetails_onClick(iIssueID,strPKToken)
{
	window.open ("../IB/IB_IssueEntry.aspx?ProjectID=" + iProjectID + "&FromWhere=DB&IssueID=" + iIssueID + "&PKToken="+ strPKToken +"&OrderBy=IssueID", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");			
}

function showTestSetHistory_onClick()
{
	if(isTestSetBlank()== true)
	    return;
//Commented and added by Yogesh Jalamkar on 02-Mar-2016 to pass Token
//	window.open ("../TCM/TestSet_History.aspx?FromWhere=PM&MasterTagID=&TestSetID="+objcboTestSet.value, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=800,height=500");
	$.ajax({
	    type: 'POST',
	    dataType: 'json',
	    contentType: 'application/json',
	    url: 'Test_Case_Responses.aspx/GenrateURLToken_showTestSetHistory',
	    data: JSON.stringify({ TestSetID: objcboTestSet.value, EmployeeID: "<%=Session("intUserID")%>" }),
          success: function (Result) {   
              window.open ("../TCM/TestSet_History.aspx?FromWhere=PM&MasterTagID=&TestSetID="+objcboTestSet.value+"&PKToken="+Result.d, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=800,height=500");

          },
         error: function () {
          //  alert("Error")
         }
     });
    //End of addition by Yogesh Jalamkar on 02-Mar-2016 to pass Token
}

	
			</script>
		</form>
	</body>
</HTML>
