<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_List.aspx.vb" Inherits="PbNIT.KM_List"%>
<html>
   <%WritePageHead%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>



       <%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>



<script src="../../responsive/responsive.js"></script>
    <%--Code added by Shamkant S on 12-Oct-2015--%>
    <head>
        <style>
            .footerMenuTable {           
            position:relative; visibility:visible;
            }
/*Added By Chakshuta H on 3rd-Dec-2015 Purpose::QA issue fixing*/
TABLE.clsRoundedTableHeader {
    font-size: 10pt;
    font-family: Verdana,Arial;
    background-image: none;
    background-repeat: repeat;
    background-color: lightgray;
    color: #003091;
}
.clsRoundedTableMenu
{
    border: 1px solid;
    border-top-width: 1px;
    border-left-width: 1px;
    height: 50px;
}
table
{
border-collapse:separate !important;
}
/*Added By Dipali V On 20th Nov 2020 For GES Issues Fixing*/
            table tr td {
                word-break: break-word !important;
            }
/*End of Added By Dipali V On 20th Nov 2020 For GES Issues Fixing*/
/*End Of Added By Chakshuta H on 3rd-Dec-2015 Purpose::QA issue fixing*/
       
.clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    #txtPageNumber
     {
        height:20px;
     }

    /*added style by pradip on 30-03-2020 for overllaping issue*/
body.clsBody.newheight {
    height: auto!important; overflow:visible;
}
/*End style added by pradip on 30-03-2020*/

/*Added by pradip on 9-10-2020*/
table.clsTable{ height:auto;}
/*end added by pradip*/
</style>
       
    </head>
   <%-- End Code added by Shamkant S on 12-Oct-2015--%>


<script type="text/javascript">
   

    

    $(document).ready(function()
    {
     

        //Added by Nilesh g on 29/12/2015
        document.body.style.height = window.innerHeight - 3 + 'px';
        //endded by Nilesh g on 29/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px';//Added by Nilesh g on 29/12/2015
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

  <body  class="clsBody newheight">
    <form id="frmKMList" method="post" runat="server"  >

		<%PageInit()%>
		</form>
<Script>
	var objForm, objdivlist;
	
	objForm = GetFormReference('frmKMList');
	/*if(navigator.appName == 'Netscape')
	 objdivMain = document.getElementsByName('PageDiv');
	else */
	    objdivMain =GetObjectReference('frmKMList','PageDiv');
	
	objTDLeft = GetObjectReference('frmKMList','TD_Left');
	objTDRight = GetObjectReference('frmKMList','TD_Right');
	var objtxtpageNumber =  GetObjectReference('frmKMList','txtPageNumber');
	
	<%' Added By SonalD on 15th Jan 2009 %>
    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
    <%End If%>
    <%' Added By SonalD on 15th Jan 2009 %>
    var objdivSearchMain=GetObjectReference('frmKMList','divSearchMain');

    //dynamically set height
        //function resizeSection() {
        //    var bodyheight = $(window).height();
        //    $('.newheight').css({ 'height': bodyheight - -20, "overflow-y": "auto" });
        //}

        //$(window).on("load resize", function (e) {
        //    resizeSection(this);
        //});


	function window_onload()
    {




		var intDivHeight ;
		var HeightDiff ;
		var cnt=0;        
	
	        	
		if("<%=m_strTab%>" == "MY")
			//Comment and modification by SuchitraP
			//HeightDiff = 40
			HeightDiff = 60
		else	
		    //HeightDiff = 20
			HeightDiff = 0;//55
			//End by SuchitraP
		
	    //added by Nilesh g on 29/12/2015 for alignment of footer
	    if(objdivSearchMain!=null)
	    {
	        if(WhichBrowser() == 'IE')
	        {
	            intDivHeight = window.innerHeight - objdivSearchMain.offsetTop-15;
	        }
	        else if(WhichBrowser() == 'CR')
	        {
	           
	            intDivHeight = window.innerHeight - objdivSearchMain.offsetTop-26;
	           
	        }
	        else if(WhichBrowser() == 'FF')
	        {
	           
	            intDivHeight = window.innerHeight - objdivSearchMain.offsetTop-24;
	           
	        }
	        else
	            intDivHeight = window.innerHeight - objdivSearchMain.offsetTop;
	        objdivSearchMain.style.height = intDivHeight+'px';
	    }
	    //endded by Nilesh g on 29/12/2015 for alignment of footer
			
        //if(objdivMain!=null)
		//{
	
		//	intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - HeightDiff;
		//	if(navigator.appName == 'Netscape')
		//	{
					
		//	   	intDivHeight = window.innerHeight - objdivMain.offsetTop-40;
		//    }
		//    else
		//    {
		//        intDivHeight = document.body.offsetHeight - objdivMain.offsetTop -40;
		//    }
            
            
		//	if (intDivHeight < 100)	
		//	{intDivHeight = 100;}
			
		//	objdivMain.style.height = intDivHeight;	
			
			
	    //}

	    //Commented by Yogesh J on 08/Dec/2015 issue id=2659 
        //Commentd by Shamkant On 17 Nov 2015
        //if(document.body !=null)
        //{
        //    var intbodyheight = document.body.style.height;
        //    if(WhichBrowser() == 'IE')
        //    {
					
        //        intbodyheight = window.innerHeight - 7;
        //    }
        //    else if(WhichBrowser() == 'FF')
        //    {
        //        intbodyheight = window.innerHeight + 25 ;
        //    }
        //    else if(WhichBrowser() == 'CR')
        //    {
        //        intbodyheight = window.innerHeight - 5 ;
        //    }
        //    else
        //    {
        //        intbodyheight = window.innerHeight - 30;
        //    }
        //    if (document.body.style.height < 100)	
        //    {document.body.style.height= 100;}
        //    document.body.style.height= (intbodyheight) + 25 + 'px';
        //}
	    //commented ended by Shamkant on 17 nov 2015
	    //End of Comment by Yogesh J on 08/12/2015 issue id=2659 

		if(GetObjectReference('frmKMList','txtSearch'))
		    GetObjectReference('frmKMList','txtSearch').focus();//.document.getElementById('frmKMList','txtSearch')
		    
		    
		
	    if(GetObjectReference('frmKMList','divArticle_'+cnt))
	    {     
	        for(cnt=0;cnt<4;cnt++)
	        {
	            GetObjectReference('frmKMList','divArticle_'+cnt).style.display="none";
	        }
	    }
	}
  
	function window_onresize()		
	{
		var intDivHeight;
		var intbodyheight = document.body.style.height;
        //added by Nilesh g on 29/12/2015 for alignment of footer
		if(objdivSearchMain!=null)
		{
		    if(WhichBrowser() == 'IE')
		    {
		        intDivHeight = window.innerHeight - objdivSearchMain.offsetTop-15;
		    }
		    else if(WhichBrowser() == 'CR')
		    {
	           
		        intDivHeight = window.innerHeight - objdivSearchMain.offsetTop-26;
	           
		    }
		    else if(WhichBrowser() == 'FF')
		    {
	           
		        intDivHeight = window.innerHeight - objdivSearchMain.offsetTop-24;
	           
		    }
		    else
		        intDivHeight = window.innerHeight - objdivSearchMain.offsetTop;
		    objdivSearchMain.style.height = intDivHeight+'px';
		}
	    //endded by Nilesh g on 29/12/2015 for alignment of footer
	    //intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 50; Commented And Added By Vaijat K ON 24/11/2015
	    //Commented by Yogesh J on 08/Dec/2015 issue id=2659 
		    //if(WhichBrowser() == 'IE')
		    //{
					
		    //    intbodyheight = window.innerHeight - 7;
		    //}
		    //else if(WhichBrowser() == 'FF')
		    //{
		    //    intbodyheight = window.innerHeight - 7 ;
		    //}
		    //else if(WhichBrowser() == 'CR')
		    //{
		    //    intbodyheight = window.innerHeight - 5 ;
		    //}
		    //else
		    //{
		    //    intbodyheight = window.innerHeight - 30;
		    //}
		    //if (document.body.style.height < 100)	
		    //{document.body.style.height= 100;}
	    //document.body.style.height= (intbodyheight) + 25 + 'px';
	    //End of Comment by Yogesh J on 08/12/2015 issue id=2659 
	}
	//Commented added by Shamkant S on 17 Nov 2015
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
	//Commented ended by Shamkant s 0n 17 nov 2015
	
	
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
				var objtxtpageNumber =  GetObjectReference('frmKMList','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmKMList','txtNoOfPages');
								
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
					All_OnClick(objtxtpageNumber.value);
				}
			}
		
		}
		
		function All_OnClick(page)
		{
		    //objForm.action =  "KM_List.aspx?txtSearch="+ URIEncode("<%=m_strtxtSearch%>") + "&Fromwhere=<%=m_strFromWhere %>&Tab=<%=m_strTab%>&Subtab=<%=m_strSubTab%>&PageNumber=" +page;  
            
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
		        objForm.action =  "KM_List.aspx?txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Tab=<%=m_strTab%>&Subtab=<%=m_strSubTab%>&PageNumber=" +page;  
            objForm.submit();

		}
		

		function validateNumPaging()
		{
					
			var noOfPages = GetObjectReference('frmKMList','hidNoOfPages').value;		
			if(isNaN(objtxtpageNumber.value))
			{
				alert("Please enter numeric value");
				return false;
			}
			if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
			{
				alert("Please enter value within range of 1 to "+noOfPages.value);
				return false;
			}
			return true;
		}
		
		function ShowPreviousPage()
		{
			if (isBlank(objtxtpageNumber.value))
				All_OnClick(1);
			else
			{
				if(!validateNumPaging())
				return;
				
				if (objtxtpageNumber.value==1){alert("This is the first page");return;}
					objtxtpageNumber.value=objtxtpageNumber.value -1;
				All_OnClick(objtxtpageNumber.value);
			}
				
		}
		
		
		function ShowFirstPage()
		{
			if (isBlank(objtxtpageNumber.value))
				All_OnClick(1);
			else
			{
				if(!validateNumPaging())
				return;
				if (objtxtpageNumber.value==1){alert("This is the first page");return;}
				objtxtpageNumber.value=1;
				All_OnClick(objtxtpageNumber.value);
			}
		}
		
		
		function ShowNextPage()
		{
			var noOfPages = GetObjectReference('frmKMList','hidNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmKMList','txtPageNumber');
			if (isBlank(objtxtpageNumber.value))
				All_OnClick(1);
			else
			{
				if(!validateNumPaging())
				return;
				if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
					objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
				All_OnClick(objtxtpageNumber.value);
			}
		}
//integrated by RohiniK on 03 Nov 09
/*
		function cboDateFilter_OnChange()	
        {
            objForm.action =  "KM_List.aspx?Fromwhere=LatestFeatured&SelectList=1&txtSearch="<%=m_strtxtSearch%>;  
			objForm.submit();
        }
        */
		function Show_OnClick()
		{
	/*	    var objEditToMe = GetObjectReference('frmKMList','chkEditToMe');
		    if (objEditToMe.checked == true)
		        objEditToMe.value = 1;
		        */
		    var objCurrentPageNumber1;
            var objCurrentPageNumber2;
            var objCurrentPageNumber3;
    
            objCurrentPageNumber1 = GetObjectReference('frmKMList','txtCurrentPage1');
            objCurrentPageNumber1.value = 0 ;
            
            objCurrentPageNumber2 = GetObjectReference('frmKMList','txtCurrentPage2');
            objCurrentPageNumber2.value = 0 ;
                      
            objCurrentPageNumber3 = GetObjectReference('frmKMList','txtCurrentPage3');
            objCurrentPageNumber3.value = 0 ;
            
		    /*objForm.action =  "KM_List.aspx?Fromwhere=LatestFeatured&SelectList=1&txtSearch="<%=m_strtxtSearch%> + "&PageNumber=1";  */
            
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
		    objForm.action =  "KM_List.aspx?Fromwhere=LatestFeatured&SelectList=1&PageNumber=1";  
			objForm.submit();
		}
//End of integratition by RohiniK on 03 Nov 09
		
		
		function ShowLastPage()
		{
			var noOfPages = GetObjectReference('frmKMList','hidNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmKMList','txtPageNumber');
			if (isBlank(objtxtpageNumber.value))
				All_OnClick(noOfPages);
			else
			{	
				if(!validateNumPaging())
				return;
				if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
				objtxtpageNumber.value=noOfPages;
				All_OnClick(objtxtpageNumber.value);
			}
		}
		
	function Tab_Onclick(strTab)
	{
		window.location.href = "KM_List.aspx?Tab=" + strTab	
	}
	function SubTab_Onclick(strTab,strSubTab)
	{
		window.location.href = "KM_List.aspx?Tab=" + strTab	 + "&Subtab=" + strSubTab
	}
	
	function Edit_OnClick(intPageID,strmode,strFrom)
	{
	    window.location.href="../KM/KM_MyPage.aspx?EditClick=1&Mode="+strmode+"&Myflag=2&Fromwhere="+strFrom+"&PageID="+intPageID+"&txtSearch=<%=m_strtxtSearch %>";
	}
	
	function ArticleEdit_OnClick(ArticleID,Mode,strFrom)
	{
	    window.open("KM_PageView.aspx?ActionLink=<%=m_strAction %>&Fromwhere="+strFrom+"&Mode="+Mode+"&txtSearch=<%=m_strtxtSearch %>&PageID=" + ArticleID,"_self","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
	}

	function AddNew_OnClick(strTabName,strSubTabName)
	{
		/*if (strTabName  == 'TEAM')
		{
		window.open("KM_Team.aspx","","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=750,height=600");
		}
		else*/
		
			if (strSubTabName == "MY PAGES")
			{
				//window.open("KM_MyPage.aspx","","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");
				window.open("KM_MyPage.aspx?Myflag=1&PageNumber=<%=m_strPagingNumber %>&Mode=ADD_NEW&Fromwhere=MyArticle","_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");
			}
			else if (strSubTabName == "MY SPACES")
			{
				//window.open("KM_MySpace.aspx?Tab="+strTabName+"&Subtab="+strSubTabName,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=750,height=600");
				window.open("KM_MySpace.aspx?Myflag=1&PageNumber=<%=m_strPagingNumber %>&Mode=ADD_NEW&Fromwhere=MySpace&Tab="+strTabName+"&Subtab="+strSubTabName,"_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=750,height=600");
			}
			else if (strSubTabName == "MY BLOGS")
			{
				window.open("KM_MyBlog.aspx","","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=750,height=600");
			}	
			else if (strSubTabName == "MY TEAMS")
			{
				//window.open("KM_Team.aspx?Tab="+strTabName+"&Subtab="+strSubTabName,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=750,height=600");
				window.open("KM_Team.aspx?Myflag=1&PageNumber=<%=m_strPagingNumber %>&Mode=ADD_NEW&Fromwhere=MyTeam&Tab="+strTabName+"&Subtab="+strSubTabName,"_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=750,height=600");
			}	
				
			
	}

	function Page_OnClick(PageID,strMode,strFrom)
	{
		
		if (strMode == 'Edit')
		{
			//window.open("KM_MyPage.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&Mode="+strMode+"&Fromwhere="+strFrom+"&PageID=" + PageID,"_self","resizable=Yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
			window.open("KM_PageView.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&Mode="+strMode+"&Fromwhere="+strFrom+"&PageID=" + PageID,"_self","resizable=Yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
		}
		else
		{
			window.open("KM_PageView.aspx?PageNumber=<%=m_strPagingNumber %>&Mode="+strMode+"&Fromwhere="+strFrom+"&PageID=" + PageID,"_self","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
	    }
	}
	
	function SpacePage_OnClick(PageID,strMode,strFrom)
	{
	    
	    if (strMode.toUpperCase() == 'EDIT')
		{   
			window.open("KM_MyPage.aspx?ActionLink=<%=m_strAction %>&SpaceID=0&PrimaryKey=<%=m_strPrimaryKey %>&Myflag=2&PageNumber=<%=m_strPagingNumber %>&Mode="+strMode+"&Fromwhere=MySpace&PageID=" + PageID,"_self","resizable=Yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
		}
		else if (strMode.toUpperCase() == 'VIEW')
		{   
			window.open("KM_MyPage.aspx?ActionLink=<%=m_strAction %>&SpaceID=0&PrimaryKey=<%=m_strPrimaryKey %>&Myflag=2&PageNumber=<%=m_strPagingNumber %>&Mode="+strMode+"&Fromwhere=MySpace&PageID=" + PageID,"_self","resizable=Yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
		}
		else
		{   
			window.open("KM_PageView.aspx?PageNumber=<%=m_strPagingNumber %>&Mode="+strMode+"&Fromwhere=MySpace&PageID=" + PageID,"_self","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
	    }
	}
	
	function Space_OnClick(SpaceID,strMode,strFrom)
	{
	    
	    if(strFrom=='MyTeam')
	    {
	        window.open("KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Subtab=MY TEAM&From=Manage&SpaceID=" + SpaceID + "&Mode=" + strMode,"_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");
	    }
	    else
	    {
		    window.open("KM_MySpace.aspx?ActionLink=<%=m_strAction %>&Myflag=2&PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Subtab=MY SPACE&From=Manage&SpaceID=" + SpaceID + "&Mode=" + strMode,"_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");
		}
	}
	
		
	function TeamSpace_OnClick(SpaceID,strMode,strFrom,TeamID)
	{
	    if(strFrom=='MyTeam')
	    {
	        window.open("KM_MySpace.aspx?ActionLink=<%=m_strAction %>&PrimaryKey=<%=m_strPrimaryKey %>&Popup=1&Myflag=5&TeamID="+TeamID+"&PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Subtab=MY TEAM&From=Manage&SpaceID=" + SpaceID + "&Mode=" + strMode,"_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");
	    }
	    else
	    {
		    window.open("KM_MySpace.aspx?Myflag=2&TeamID="+TeamID+"&PageNumber=<%=m_strPagingNumber %>&PrimaryKey=<%=m_strPrimaryKey %>&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Subtab=MY SPACE&From=Manage&SpaceID=" + SpaceID + "&Mode=" + strMode,"_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");
		}
	}
	
	function Shift_onClick()
	{
	if (objTDLeft.style.display == "")
		{
		objTDLeft.style.display = "None"
		}
	else
		{
		objTDLeft.style.display = ""
		}
	}
	
	//Added intPKID by SuchitraP on 29-Aug-2008
	function Delete_OnClick(intPKID)
	{
	    //Commented by SuchitraP on 29-Aug-2008
		//var blnIsRecordSelected=false;
		//blnIsRecordSelected=IsCheckboxSelected('frmKMList','chkDelete')
		//if (blnIsRecordSelected == false) { alert("Please select atleast one item to delete");return;}
	    //End of Comment by SuchitraP
	    //Modification by SuchitraP on 29-Aug-2008
	    //objForm.action = "KM_List.aspx?Action=Delete&Tab=<%=m_strTab%>&Subtab=<%=m_strSubTab%>"
	    if (confirm("Are you sure you want to delete the record?")==true)
		{
		    objForm.action = "KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Action=Delete&Tab=<%=m_strTab%>&Subtab=<%=m_strSubTab%>&DeletionID="+intPKID;
		    //End by SuchitraP
		    objForm.submit();
		}	
	
	}
	function Team_OnChange()
	{	
	    //Added by Tejal D date 12/10/2016 to set setFrameLoader
	    setFrameLoader();
	    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
		objForm.action = "KM_List.aspx?Tab=TEAM"
		objForm.submit();
	
	}
	function Edit_TeamDetails(TeamID,strMode,strFrom)
	{
		//objcboTeam = GetObjectReference('frmKMList','cboTeam');
		//if (objcboTeam.value>0)
				window.open("KM_Team.aspx?ActionLink=<%=m_strAction %>&Myflag=2&PageNumber=<%=m_strPagingNumber %>&From="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Mode=" + strMode + "&TeamID=" + TeamID ,"_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=750,height=600");
		//else
		  //alert("Please select team");
		
	}
	function Add_Space()
	{
	objcboTeam = GetObjectReference('frmKMList','cboTeam');
	window.open("KM_SpaceListing.aspx?TeamID=" + objcboTeam.value,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");	
	}
	function Paging_Onclick(PageNumber,strPagingQuery)
	{
	
		
	    //Added by Tejal D date 12/10/2016 to set setFrameLoader
	    setFrameLoader();
	    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
		objForm.action = "KM_List.aspx?IsPaging=1&Tab=<%=m_strTab%>&Subtab=<%=m_strSubTab%>&" + strPagingQuery + "=" + PageNumber;
		objForm.submit();
	}
	function Paging_PrevOnclick(intPrevStartPage,intPageCount,strPagingQuery,strPagingDivName)
	{
		objtblPaging = GetObjectReference('frmKMList','tblPaging');
		objdivPaging = GetObjectReference('frmKMList',strPagingDivName);
		var intCount = 0,intNewEndPage=1,intNewStartPage=1;
		
		intNewStartPage = parseInt(intPrevStartPage) - 10;
		intNewEndPage = parseInt(intNewStartPage) + 9;
		if (parseInt(intNewEndPage) > parseInt(intPageCount))
			intNewEndPage = intPageCount;
		var strtblInnetHTML = "<Table id='tblPaging' width=99.99% class=clstable><TBODY><TR class=clsTREven><TD>Result Pages ";
		if (parseInt(intNewStartPage) > 10)
			strtblInnetHTML = strtblInnetHTML + "<a style=\"font-size:120%;\" href=\"javascript:Paging_PrevOnclick(" + intNewStartPage  + "," + intPageCount + ",'" + strPagingQuery + "','" + strPagingDivName + "')\">Prev</a>&nbsp;&nbsp;&nbsp;&nbsp;"
		for(intCount=intNewStartPage;intCount<=intNewEndPage;intCount++)
		{		
		strtblInnetHTML = strtblInnetHTML + "<a style=\"font-size:120%;\" href=\"javascript:Paging_Onclick(" + parseInt(intCount)  + ",'" + strPagingQuery + "')\">" + parseInt(intCount) + "</a>&nbsp;&nbsp;&nbsp;&nbsp;"
		}
		strtblInnetHTML = strtblInnetHTML + "<a style=\"font-size:120%;\" href=\"javascript:Paging_NextOnclick(" + intNewStartPage + "," + intPageCount +  ",'" + strPagingQuery + "','" + strPagingDivName + "')\"> Next</a>"
		strtblInnetHTML = strtblInnetHTML + "</TD></TR></TBODY>"
		objdivPaging.innerHTML = strtblInnetHTML;
	
	}
	function Paging_NextOnclick(intPrevStartPage,intPageCount,strPagingQuery,strPagingDivName)
	{
		objtblPaging = GetObjectReference('frmKMList','tblPaging');
		objdivPaging = GetObjectReference('frmKMList',strPagingDivName);
		
		var intCount = 0,intNewEndPage=1,intNewStartPage=1;
		intNewStartPage = parseInt(intPrevStartPage) + 10;
		intNewEndPage = parseInt(intNewStartPage) + 9;
		if (parseInt(intNewEndPage) > parseInt(intPageCount))
			intNewEndPage = intPageCount;
		var strtblInnetHTML = "<Table id='tblPaging' width=99.99% class=clstable><TBODY><TR class=clsTREven><TD>Result Pages ";
		strtblInnetHTML = strtblInnetHTML + "<a style=\"font-size:120%;\" href=\"javascript:Paging_PrevOnclick(" + intNewStartPage  + "," + intPageCount + ",'" + strPagingQuery + "','" + strPagingDivName + "')\">Prev</a>&nbsp;&nbsp;&nbsp;&nbsp;"
		for(intCount=intNewStartPage;intCount<=intNewEndPage;intCount++)
		{		
		strtblInnetHTML = strtblInnetHTML + "<a style=\"font-size:120%;\" href=\"javascript:Paging_Onclick(" + parseInt(intCount)  + ",'" + strPagingQuery + "')\">" + parseInt(intCount) + "</a>&nbsp;&nbsp;&nbsp;&nbsp;"
		}
		if (parseInt(intPageCount) > parseInt(intNewEndPage))
			strtblInnetHTML = strtblInnetHTML + "<a style=\"font-size:120%;\" href=\"javascript:Paging_NextOnclick(" + intNewStartPage + "," + intPageCount +  ",'" + strPagingQuery + "','" + strPagingDivName + "')\"> Next</a>"
		strtblInnetHTML = strtblInnetHTML + "</TD></TR></TBODY>"
		objdivPaging.innerHTML = strtblInnetHTML;
	}
	
	//Addition by SuchitraP on 26-Aug-2008
	    function Product_OnClick()
	    {
	        //alert(parent.document.getElementsByTagName("outerframe")[1].src);
	         if('<%=m_strFrom%>'=='Product')
	        {
	            return;
	        }
	        else
	        {
	            window.location.href="Collateral/Collateral.aspx"
	        }
	    }
	    
	    function Home_OnClick(strTab)
	    {
	    
	        if('<%=m_strFrom%>'=='Product')
	        {
	           parent.location.href = "KM_List.aspx?Tab=" + strTab	
	        }
	        else
	        {
	           //window.location.href = "KM_List.aspx?Tab=" + strTab	
	           window.location.href = "KM_Home.aspx?SelectList=1"
	        }
	    
	       
	    }
	    
	    function My_OnClick(strTab)
	    {
	        if('<%=m_strFrom%>'=='Product')
	        {	
	            parent.location.href = "KM_List.aspx?Tab=" + strTab	
	        }
	        else
	        {
	            window.location.href = "KM_List.aspx?Tab=" + strTab
	        }
	    }
	    
	    function Team_OnClick(strTab)
	    {
	        if('<%=m_strFrom%>'=='Product')
	        {
	            parent.location.href = "KM_List.aspx?Tab=" + strTab	
	        }
	        else
	        {
	            window.location.href = "KM_List.aspx?Tab=" + strTab
	        }
	    }
	    
	   
	    function ShowContextMenu(WhichClick)
		{
			/*if(obj)
			{
				objTDRolledNow=obj;obj.className='clsTDRolledOver';
			}
			var objContextMenu = GetObjectReference('frmKMList','divContextMenu');
			 
			var mousePosition = getMousePosition(ev,objContextMenu);
			 
			objContextMenu.style.visibility= 'visible';
			objContextMenu.style.position = 'absolute';
			
			
			objContextMenu.style.left = mousePosition.x;
			objContextMenu.style.top = mousePosition.y;
			
			var objTrMenuHR = GetObjectReference('frmKMList','trMenuHR');
			if(objTrMenuHR){objTrMenuHR.className='Menu_Hr';}
			var objMyPages  = GetObjectReference('frmKMList','tdMyPages');
			var objMySpaces = GetObjectReference('frmKMList','tdMySpaces');
			var objMyTeam  = GetObjectReference('frmKMList','tdMyTeam');
									
			objMyPages.onclick=function()
			{
				window.location.href = "KM_List.aspx?Tab=MY&Subtab=MY PAGES"
			}
			
			objMySpaces.onclick=function()
			{
				window.location.href = "KM_List.aspx?Tab=MY&Subtab=MY SPACES"
			}
			
			objMyTeam.onclick=function()
			{
				window.location.href = "KM_List.aspx?Tab=MY&Subtab=MY TEAMS"
				
			}*/
	        if(WhichClick=='MY PAGES')
	        {
	            window.location.href = "KM_List.aspx?Tab=MY&Subtab=MY PAGES";
	        }
	        
	        if(WhichClick=='MY SPACES')
	        {
	            window.location.href = "KM_List.aspx?Tab=MY&Subtab=MY SPACES";
	        }
	        
	        if(WhichClick=='MY TEAMS')
	        {
	            window.location.href = "KM_List.aspx?Tab=MY&Subtab=MY TEAMS";
	        }
		}
		
		var objTDRolledNow;
		var objContextMenu;
		document.onmouseup=function()
		{
			objContextMenu = GetObjectReference('frmKMList','divContextMenu');
			if(objContextMenu){objContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
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
		        
				objContextMenu.style.left = intX-85;
				objContextMenu.style.top = intY;
			}  
		      
			return {x:objContextMenu.style.left,y:objContextMenu.style.top};
			
		}
		
		function ShowHideGroup_Onclick(intPKID)
	    {
    	   
	        var objMenuTable=GetObjectReference('frmKMList',"tblGroup" + intPKID);
	        var objMenuImage=GetObjectReference('frmKMList',"imgGroup" + intPKID);
	        if (objMenuTable.style.display=="none")
	        {
	            objMenuTable.style.display="";
	            objMenuImage.src = "../../Images/MoveUp.GIF";
	        }
	        else
	        {
	             objMenuTable.style.display="none";
	             objMenuImage.src = "../../Images/MoveDown.GIF"
            }

            $(".clsRoundedTableMenu").removeClass("footerMenuTable");  //added by pradip on 30-03-2020
        

	    }
	    
	    function ShowDetails_Onclick(intPKID,strFrom)
	    {
	       
	       window.location.href="KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&Action=More&Tab=<%=m_strTab%>&Subtab=<%=m_strSubTab%>&PrimaryKey="+intPKID;
	    }
	    
	    function ShowDetailsHome_Onclick(WhichClick)
	    {
	        
	        if(WhichClick==1)
	        {
	           window.location.href="KM_List.aspx?Action=More&Tab=HOME&From=Articles&FromWhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch%>";
	        }
	        else if(WhichClick==2)
	        {
	          window.location.href="KM_List.aspx?Action=More&Tab=HOME&From=Spaces&FromWhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch%>";
	        }
	        else
	        {
	          window.location.href="KM_List.aspx?Action=More&Tab=HOME&From=Teams&FromWhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch%>";
	        }
	    }
	    
	    function AddPage_OnClick(intPKID)
	    {
	        window.open("KM_PageListings.aspx?FromWhere=MySpace&SpaceID="+intPKID+"","","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");	
	    }
	    
	    function AddSpace_OnClick(intPKID)
	    {
		    window.open("KM_SpaceListing.aspx?FromWhere=MyTeam&TeamID="+intPKID+"","","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");	
	    }
	    
	    function HomePage_OnClick(strTab,searchtxt)
	    {
	           window.location.href = "KM_List.aspx?Tab="+strTab+"&txtSearch="+searchtxt
	           
	    }
	    
	    function Manage_OnClick(strTab,strSubtab)
	    {
	        
	        if(strSubtab == "MY PAGES")
	        {   
	            //window.open("../General/CommonList.aspx?MasterTagID=20038", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
	            window.open("../General/CommonList.aspx?From=Manage&MasterTagID=3959", "_self", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
	        }
	        else if(strSubtab == "MY SPACES")
	        {
	            //window.open("../General/CommonList.aspx?MasterTagID=20039", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
	            window.open("../General/CommonList.aspx?From=Manage&MasterTagID=3960", "_self", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
	        }
	        else if(strSubtab == "MY TEAMS")
	        {
	            //window.open("../General/CommonList.aspx?MasterTagID=20040", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
	            window.open("../General/CommonList.aspx?From=Manage&MasterTagID=3961", "_self", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
	        }
	    }
	    
	    function SpaceView_OnClick(PkID)
	    {
	        window.location.href="../KM/KM_SpaceAndPageView.aspx?PrimaryKey="+PkID+"&Mode=SpaceView";
	    }
	    
	    function PageView_OnClick(PkID)
	    {   
	        window.location.href="../KM/KM_SpaceAndPageView.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&PrimaryKey="+PkID+"&Mode=PageView";
	    }
	    
	    function Back_OnClick(strTab,strSubTab)
	    {
	        if(strSubTab=="MY SPACES")
	        {
	            window.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Tab=MY&Subtab=MY SPACES";
	        }
	        else if(strSubTab=="MY TEAMS")
	        {
	            window.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Tab=MY&Subtab=MY TEAMS";
	        }
	    }
	    
	    
	    function Article_OnClick(ArticleID)
	    {
	         var cnt;
	         var strArt='<%=StrArticleID %>';
	         var arr=strArt.split(',');
	         var flag=0;
	         
	         for(cnt=0;cnt<arr.length-1;cnt++)
	         {
	            if(ArticleID==arr[cnt])
	            {
	                flag=cnt;
	                break;
	            }
     
	         }
	        
	         if(flag==0)
	         {
	            //debugger;
	            GetObjectReference('frmKMList','divPage').style.display="none";
	            GetObjectReference('frmKMList','divArticle_0').style.display="";
	            //GetObjectReference('frmKMList','divArticle_1').style.display="none";
	            //GetObjectReference('frmKMList','divArticle_2').style.display="none";
	            //GetObjectReference('frmKMList','divArticle_3').style.display="none";
	            //GetObjectReference('frmKMList','divArticle_4').style.display="none";
	         }
	         else if(flag==1)
	         {
	            GetObjectReference('frmKMList','divPage').style.display="none";
	            GetObjectReference('frmKMList','divArticle_0').style.display="none";
	            GetObjectReference('frmKMList','divArticle_1').style.display="";
	            //GetObjectReference('frmKMList','divArticle_2').style.display="none";
	           // GetObjectReference('frmKMList','divArticle_3').style.display="none";
	            //GetObjectReference('frmKMList','divArticle_4').style.display="none";
	         }
	         else if(flag==2)
	         {
	            GetObjectReference('frmKMList','divPage').style.display="none";
	            GetObjectReference('frmKMList','divArticle_0').style.display="none";
	            GetObjectReference('frmKMList','divArticle_1').style.display="none";
	            GetObjectReference('frmKMList','divArticle_2').style.display="";
	            //GetObjectReference('frmKMList','divArticle_3').style.display="none";
	            //GetObjectReference('frmKMList','divArticle_4').style.display="none";
	         }
	         else if(flag==3)
	         {
	            GetObjectReference('frmKMList','divPage').style.display="none";
	            GetObjectReference('frmKMList','divArticle_0').style.display="none";
	            GetObjectReference('frmKMList','divArticle_1').style.display="none";
	            GetObjectReference('frmKMList','divArticle_2').style.display="none";
	            GetObjectReference('frmKMList','divArticle_3').style.display="";
	            //GetObjectReference('frmKMList','divArticle_4').style.display="none";
	         }
	         else if(flag==4)
	         {
	            GetObjectReference('frmKMList','divPage').style.display="none";
	            GetObjectReference('frmKMList','divArticle_0').style.display="none";
	            GetObjectReference('frmKMList','divArticle_1').style.display="none";
	            GetObjectReference('frmKMList','divArticle_2').style.display="none";
	            GetObjectReference('frmKMList','divArticle_3').style.display="none";
	            GetObjectReference('frmKMList','divArticle_4').style.display="";
	         }
	           
	    }
	    
	    function RateArticle(ArticleID)
	    {
	        //Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
	        //window.open("../../Source/KM/KM_ArticleRating.aspx?From=HOME&ProcedureID="+ArticleID+"" ,null,"resizable=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 290)/2 + ",width=400,height=290");
	        $.ajax({
	            type: 'POST',
	            dataType: 'json',
	            contentType: 'application/json',
	            url: 'KM_List.aspx/GenrateRateArticleToken',
	            data: JSON.stringify({ProcedureID:ArticleID, EmployeeID: "<%=Session("intUserID")%>" }),
		        success: function (Result) {
		            // window.open("../PM/PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeIDList=" + strEmployeeList + "&PKToken="+ Result.d +"&FromDate=" + objCurrentStartDate.value + "&ToDate=" + objCurrentEndDate.value, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=650,height=450");	            
		            window.open("../../Source/KM/KM_ArticleRating.aspx?From=HOME&ProcedureID="+ArticleID+"&PkToken="+ Result.d +"" ,null,"resizable=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 290)/2 + ",width=400,height=290");

		        },
		        error: function () {
		            //  alert("Error")
		        }
	        });
	        //End of Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
		    
		}
		
		function Article_OnClick(ArticleID,Mode,strFrom)
		{

		    //window.open("KM_MyPage.aspx?PageID="+ArticleID,"_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650"");
		    
		    if (Mode == 'Edit')
		    {
			    window.open("KM_MyPage.aspx?Myflag=2&Mode="+Mode+"&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&PageID=" + ArticleID,"_self","resizable=Yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
		    }
		    if (Mode == 'view')
		    {
			    window.open("KM_MyPage.aspx?Myflag=2&Mode="+Mode+"&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&PageID=" + ArticleID+"&Mode=VIEW","_self","resizable=Yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
		    }		    
		    else
		    {
			    window.open("KM_PageView.aspx?Fromwhere="+strFrom+"&Mode="+Mode+"&txtSearch=<%=m_strtxtSearch %>&PageID=" + ArticleID,"_self","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
			}
		}
		
		function HomeBack_OnClick(From)
		{
		   window.location.href="../Km/Km_List.aspx?FromWhere="+From+"&SelectList=3&txtSearch=<%=m_strtxtSearch %>";
		}
		
		function Document_OnClick(intProcedureID,strToken)
		{
		    //Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
		    window.open ("../DB/DocumentType.aspx?ProcedureID=" + intProcedureID + "&TagID=0&DocumentType=KM&PKToken=" + strToken,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		    //$.ajax({
		    //    type: 'POST',
		    //    dataType: 'json',
		    //    contentType: 'application/json',
		    //    url: 'KM_List.aspx/GenrateDocumentToken',
		    //    data: JSON.stringify({ProcedureID:intProcedureID, EmployeeID: "<%=Session("intUserID")%>" }),
		    //success: function (Result) {
		        // window.open("../PM/PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeIDList=" + strEmployeeList + "&PKToken="+ Result.d +"&FromDate=" + objCurrentStartDate.value + "&ToDate=" + objCurrentEndDate.value, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=650,height=450");
		     //   window.open ("../DB/DocumentType.aspx?ProcedureID=" + intProcedureID + "&TagID=0&DocumentType=KM&PKToken=" + strToken,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");

		   // },
		   // error: function () {
		        //  alert("Error")
		   // }
           // });
		    //End Of Commented an Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
		}
	//End by SuchitraP
	
	   function ShowDiscussions_OnClick(intProcedureID,strToken)
	   {
	       window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID +"&Fromwhere=<%=m_strFromWhere%>&PKToken=" + strToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");
	       //Added by Dhanashri S on 29 Mar 2016 Purpose: To generate and validate Token
	       //$.ajax({
	       //    type: 'POST',
	       //    dataType: 'json',
	       //    contentType: 'application/json',
	       //    url: 'KM_List.aspx/GenrateDiscussionToken',
	       //    data: JSON.stringify({ ProcedureID: intProcedureID }),
	       //    success: function (Result) {
	               //window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID + "&PKDiscussionToken=" + Result.d + "&Fromwhere=<%=m_strFromWhere%>&PKToken=" + strToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");
	       //        window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID +"&Fromwhere=<%=m_strFromWhere%>&PKToken=" + strToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");

	        //   },
	       //    error: function () {
	               // alert("Error")
	       //    }
	       //});

	       //End of addition by Dhanashri S on 29 Mar 2016
	   }
	   
	   
	   function Previous_Onclick(intcount)
       {
//            var objCurrentPageNumber = GetObjectReference('','txtCurrentPage'+intcount);
//            objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) - 1 ;
//            var objhidFromwhere = GetObjectReference('','txtFromwhere').value;
//            var objhidtxtSearch = GetObjectReference('','txtSearchChar').value;
//            var intMenuClick = intcount;
//            if (parseInt(objCurrentPageNumber.value)>=0)
//            {
//               
//                ///Km/Km_List.aspx?Fromwhere=Search&SelectList=3&txtSearch=art
//                //var url="Km_List.aspx?IsXMLHTTP=1&Fromwhere=Search&txtSearch=art&SelectList=3&PageNumber="+objCurrentPageNumber.value;
//                var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber.value;
//            loadXMLDoc(url);
//            }else
//            {
//                alert('This is the first page.')
//                objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) + 1 ;
//                return;
//            }

            var objCurrentPageNumber1;
            var objCurrentPageNumber2;
            var objCurrentPageNumber3;
    
            if(intcount ==1)
            {   objCurrentPageNumber1 = GetObjectReference('','txtCurrentPage1');
                objCurrentPageNumber1.value = parseInt(objCurrentPageNumber1.value) - 1 ;
            }
           
            if(intcount ==2)
            {   objCurrentPageNumber2 = GetObjectReference('','txtCurrentPage2');
                objCurrentPageNumber2.value = parseInt(objCurrentPageNumber2.value) - 1 ;
            }
            
            if(intcount ==3)
            {   objCurrentPageNumber3 = GetObjectReference('','txtCurrentPage3');
                objCurrentPageNumber3.value = parseInt(objCurrentPageNumber3.value) - 1 ;
            }
            
            var objRecCnt_Art = <%=Recordcount_Article %>;
            var objRecCnt_Spc = <%=Recordcount_Space %>;
            var objRecCnt_Team = <%=Recordcount_Team %>;
            var objhidFromwhere = GetObjectReference('','txtFromwhere').value;
            var objhidtxtSearch = GetObjectReference('','txtSearchChar').value;
            var intMenuClick = intcount;
//integrated by RohiniK on 03 Nov 09
var objEditToMe = GetObjectReference('frmKMList','chkEditToMe');
            var objEditToMeValue = 0;
		    if (objEditToMe.checked == true)
		       objEditToMeValue  = 1;
		       
		    var objcboDateFilter = GetObjectReference('frmKMList','cboDateFilter');
            var objcboDateFilterValue = 0;
		    if (objcboDateFilter != null)
		       objcboDateFilterValue = objcboDateFilter.value;
		   
//End of integratition by RohiniK on 03 Nov 09
            
            if(objCurrentPageNumber1!=null)
            {
                if(objCurrentPageNumber1.value>= 0 && intcount ==1)
                {
                   //integrated by RohiniK on 03 Nov 09
                    //var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber1.value;
                    var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber1.value +"&EditToMeValue=" +objEditToMeValue +"&cboDateFilterValue=" +objcboDateFilterValue;
                   
                    //End of integratition by RohiniK on 03 Nov 09
                    //alert(url);
                    loadXMLDoc(url);   
                }
                else
                {
                    alert('This is the first page.')
                    objCurrentPageNumber1.value = parseInt(objCurrentPageNumber1.value) + 1 ;
                    return;
                }   
            }
   
            
            if(objCurrentPageNumber2!=null)
            {
                if(objCurrentPageNumber2.value>=0 && intcount ==2)
                {
                    //integrated by RohiniK on 03 Nov 09
                   // var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber2.value;
                   var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber2.value+"&EditToMeValue=" +objEditToMeValue+"&cboDateFilterValue=" +objcboDateFilterValue;
                   //End of integratition by RohiniK on 03 Nov 09
                    
                    loadXMLDoc(url);   
                }
                else
                {
                    alert('This is the first page.')
                    objCurrentPageNumber2.value = parseInt(objCurrentPageNumber2.value) + 1 ;
                    return;
                }   
            }

                         
            if( objCurrentPageNumber3!=null)
            {
                if(objCurrentPageNumber3.value>=0 && intcount ==3)
                {
                    //integrated by RohiniK on 03 Nov 09
					//var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber3.value;
					var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber3.value+"&EditToMeValue=" +objEditToMeValue+"&cboDateFilterValue=" +objcboDateFilterValue;
					//End of integratition by RohiniK on 03 Nov 09
                    
                    loadXMLDoc(url);   
                }
                else
                {
                    alert('This is the first page.')
                    objCurrentPageNumber3.value = parseInt(objCurrentPageNumber3.value) + 1 ;
                    return;
                }  
            }

       }

       function Next_Onclick(intcount)
       {
            var objCurrentPageNumber1;
            var objCurrentPageNumber2;
            var objCurrentPageNumber3;
    
            if(intcount ==1)
            {   objCurrentPageNumber1 = GetObjectReference('','txtCurrentPage1');
                objCurrentPageNumber1.value = parseInt(objCurrentPageNumber1.value) + 1 ;
            }
           
            if(intcount ==2)
            {   objCurrentPageNumber2 = GetObjectReference('','txtCurrentPage2');
                objCurrentPageNumber2.value = parseInt(objCurrentPageNumber2.value) + 1 ;
            }
            
            if(intcount ==3)
            {   objCurrentPageNumber3 = GetObjectReference('','txtCurrentPage3');
                objCurrentPageNumber3.value = parseInt(objCurrentPageNumber3.value) + 1 ;
            }
            
            var objRecCnt_Art = <%=Recordcount_Article %>;
            var objRecCnt_Spc = <%=Recordcount_Space %>;
            var objRecCnt_Team = <%=Recordcount_Team %>;
            var objhidFromwhere = GetObjectReference('','txtFromwhere').value;
            var objhidtxtSearch = GetObjectReference('','txtSearchChar').value;
            var intMenuClick = intcount;
            
//integrated by RohiniK on 03 Nov 09
  var objEditToMe = GetObjectReference('frmKMList','chkEditToMe');
            var objEditToMeValue = 0;
		    if (objEditToMe.checked == true)
		       objEditToMeValue  = 1;
            
            var objcboDateFilter = GetObjectReference('frmKMList','cboDateFilter');
            var objcboDateFilterValue = 0;
		    if (objcboDateFilter != null)
		       objcboDateFilterValue = objcboDateFilter.value;
		       
//End of integratition by RohiniK on 03 Nov 09
            if(objCurrentPageNumber1!=null)
            {
                if(objCurrentPageNumber1.value<objRecCnt_Art && intcount ==1)
                {
                    //integrated by RohiniK on 03 Nov 09
                    //var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber1.value;
                    var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber1.value+"&EditToMeValue=" +objEditToMeValue+"&cboDateFilterValue=" +objcboDateFilterValue;
                   
                   //End of integratition by RohiniK on 03 Nov 09
                    //alert(url);
                    loadXMLDoc(url);   
                }
                else
                {
                    alert('This is the last page.')
                    objCurrentPageNumber1.value = parseInt(objCurrentPageNumber1.value) - 1 ;
                    return;
                }   
            }
            
            if(objCurrentPageNumber2!=null)
            {
                if(objCurrentPageNumber2.value<objRecCnt_Spc && intcount ==2)
                {
                     //integrated by RohiniK on 03 Nov 09
				     //var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber2.value;
                      var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber2.value+"&EditToMeValue=" +objEditToMeValue+"&cboDateFilterValue=" +objcboDateFilterValue;
                     //End of integratition by RohiniK on 03 Nov 09
                   
                    loadXMLDoc(url);   
                }
                else
                {
                    alert('This is the last page.')
                    objCurrentPageNumber2.value = parseInt(objCurrentPageNumber2.value) - 1 ;
                    return;
                }   
            }
            
            if(objCurrentPageNumber3!=null)
            {
                if(objCurrentPageNumber3.value<objRecCnt_Team && intcount ==3)
                {
                    //integrated by RohiniK on 03 Nov 09
					//var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber3.value;
					var url="Km_List.aspx?IsXMLHTTP=1&MenuClick="+intMenuClick+"&Fromwhere="+objhidFromwhere+"&txtSearch="+objhidtxtSearch+"&SelectList=<%=strSelectList %>&PageNumber="+objCurrentPageNumber3.value+"&EditToMeValue=" +objEditToMeValue+"&cboDateFilterValue=" +objcboDateFilterValue;
					//End of integratition by RohiniK on 03 Nov 09
                    
                    loadXMLDoc(url);   
                }
                else
                {
                    alert('This is the last page.')
                    objCurrentPageNumber3.value = parseInt(objCurrentPageNumber3.value) - 1 ;
                    return;
                }  
            } 
              
       }
        
    
        function loadXMLDoc(url,reqQuery)

        {
        // code for Mozilla, etc.
            if (window.XMLHttpRequest)
            {
                xmlhttp=new XMLHttpRequest()
                xmlhttp.onreadystatechange=xmlhttpChange;

                if (ns)
                {
                    xmlhttp.open("GET",url+"&"+reqQuery,true)
                    xmlhttp.send(false)
                }
                else
                {
                    xmlhttp.open("POST",url,true)
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(reqQuery)
                }
            }
            // code for IE
            else if (window.ActiveXObject)
            {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
                if (xmlhttp)
                {
                    xmlhttp.onreadystatechange=xmlhttpChange
                    xmlhttp.open("POST",url,true)
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(reqQuery)
                }
            }
        }
     
        function xmlhttpChange()
	    {
		        if (xmlhttp.readyState==4)
		        {
		 	        if (xmlhttp.status==200)
			        {	
				        var objTab;
				        var HTML; 
				        HTML = xmlhttp.responseText;
				        objTab = GetObjectReference('frmKMList','SearchMain');
				        if (objTab != null)
				        {
					        objTab.outerHTML =HTML ;
			            }
            						
			          }
		         }
        }
</script>
  

  </body>
</html>
