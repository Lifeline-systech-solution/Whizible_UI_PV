<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_RequestList.aspx.vb" Inherits="PbNIT.CRM_RequestList"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Request List")%>


<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>


<style>
     #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 50%;
        padding: 30px 15px 0px;
        border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;
        background: url("../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
        width: 64px;
        height: 64px;
        /*z-index: 99;
            height: 100%;*/
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
    }

    #fillDiv {
        opacity: 0.4;
        background-color: ghostwhite;
        /*DISPLAY: none;*/
        Z-INDEX: 100;
        LEFT: 0px;
        VISIBILITY: visible;
        WIDTH: 100%;
        POSITION: absolute;
        TOP: 0px;
        HEIGHT: 100%;
        float: right;
    }
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
    #tblActivityDtls
    {
            background-color: #f6eee4; /*Added By Vaijat K ON 22/12/2015*/
    }
     #tblContextMenu {
        width:auto;
    }
    #divTblX {
        background-color:rgb(246, 238, 228); /*Added by Yogesh J on 15-Jan-2016*/
    }
    #tblRequestorDtls {
        background-color: #f6eee4; /*Added By Vaijat K ON 04/02/2015*/
    }
</style>
     <script type="text/javascript">
        
         // Added by Kiran for Loader 2/11/15
         function setFrameLoaded()
         { 
             //Added by swapnil aswale on 14-12-2015 for Mulitple Login
             $("#frmMain").contents().find("a").click(function(){
                 $.ajax({url: "MultipleLogin.aspx", success: function(result){
                        
                 }});

             });
             //Ended
               
             //Added by swapnil aswale on 14-12-2015 for Mulitple Login
             //$("#frmMain").contents().find("#frmSub").find("a").click(function(){
             //    $.ajax({url: "MultipleLogin.aspx", success: function(result){
	          
             //    }});

             //});
             //Ended 

             jQuery("#preloader").fadeOut("slow");
             jQuery("#fillDiv").fadeOut("slow"); 
             jQuery("#preloader").remove();
             jQuery("#fillDiv").remove();
             //=====================
             jQuery("#preloader").remove();
             jQuery("#fillDiv").remove();
             //===========================
             RemoveFrameLoader();
         }
         function setFrameLoader()
         {   
        
             $("HTML").append("<div id='preloader'></div>"); 
             $("HTML").append("<div id='fillDiv'></div>");  
         }
         function RemoveFrameLoader()
         {   
             jQuery("#preloader").remove();
             jQuery("#fillDiv").remove();
             jQuery("#preloader").fadeOut("slow");
             jQuery("#fillDiv").fadeOut("slow"); 
             jQuery("#preloader").remove();
             jQuery("#fillDiv").remove();
         }
      
         //End by KIran for Loader 2/11/15
        </script>
<%--<script type="text/javascript">
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
            //removeSectionHeader();        // Commented by Puneet M on 02-Nov-2015
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        // Commented by Puneet M On 02-Nov-2015
        //if($('.clsgridtable').length > 0)
        //{
        //    var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //}
        // Added by puneet m on 02-Nov-2015
        //debugger;
        if($('.clsPageBody').find("#frmRequestList").find("#divList").length > 0)
        {
            var divName=$('.clsPageBody').find("#frmRequestList").find("#divList").attr('id');
            divDatacollapse(divName);
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

</script>--%>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsPageBody" onresize="window_onresize()" onload="window_onload()"  onmouseup="Doc_OnmouseUp()">
		<form id='frmRequestList' method='post' runat='server'>
		<div id="fillDiv" style="DISPLAY: none;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>			
		
		<%WritePage()%>
		
	    <div id='divStatistics' style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;height:200px;POSITION: absolute; TOP: 165px;Z-INDEX:19000;background-color: white;'>
        </div>
          
       <div id='divTblX' style='overflow:auto;position:absolute;border-right: black 1px outset;border-top: black 1px outset;border-left: black 1px outset;border-bottom: black 1px outset;' >
       </div>
		</form>
		
		<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></DIV>
		<div id="fillDivDB" style="DISPLAY: none;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>
		<script language="javascript">
		var objform;
		var objdivlist;
		
		var currentRow = 0;
        var highlightedRow;
        var trs ;
        var FeedBackQueryID ; 
		objform = GetFormReference('frmRequestList');
		objdivlist = GetObjectReference('frmRequestList','divList');
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		var LoginType="<%=m_strLoginType%>";
		
		function SetFilters_OnClick()
		{
			window.open ("CRM_FilterList.aspx?FromWhere=<%=m_strMode%>","_Filters","resizable=yes,scrollbars=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=850,height=400");
		}
	
		function ClearFilters_OnClick()
		{
			objform.action = "CRM_RequestList.aspx?Action=CLEAR_FILTERS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&Mode=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>";		
			objform.submit();
		}
	
		function AddNew_OnClick()
		{
		//alert(window.opener.document.forms[0].name);
		//Commented by ShraddhaM to change add new functionality
		//End of comment by ShraddhaM to change add new functionality				
			
			//Added by ShraddhaM to change add new functionality
			   				
		    window.open("CRM_RequestDetail.aspx?PKToken=<%=m_PKToken_ADDNEW%>&Mode=NEW&PageNumber=1&Customer=&Employee=&RTVal=I&ParentTagID=0&FromList=1&FromCL=1&OnBehalfOf=SELF","_requestdetail","resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"); 
		   
			//Ended by ShraddhaM to change add new functionality
		}
		
		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
		
		// Modified By NitinVS on 10 Aug 2005 for PMLifeLine SP4 IssueID 2 		
		// Changed the height to 625 and Top to 75

		//function Discussion_OnClick(queryid)
		function Discussion_OnClick(queryid,Token,FromWhere)
		{
			//window.open("CRM_DiscussionThread.aspx?QueryID=" + queryid ,"_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
			window.open("CRM_DiscussionThread.aspx?QueryID=" + queryid + "&PKToken=" + Token + "&FromWhere=" + FromWhere,"_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
		}
		// End Modification By NitinVS on 10 Aug 2005 for PMLifeLine IssueID 2 	
		// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
	
	// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
	//integrated by harshada d on 19 DEC 2005 
	//Added by ManishK On 21th Nov 2005 for No of attachments to the Issue 
	
	//function Document_OnClick(intQueryID)
	function Document_OnClick(intQueryID,strToken)
	{
					//window.open ("../DB/DocumentType.aspx?QueryID=" + intQueryID + "&TagID=0&DocumentType=CRM","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
					window.open ("../DB/DocumentType.aspx?QueryID=" + intQueryID + "&TagID=0&DocumentType=CRM&PKToken=" + strToken,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	//End of addition by ManishK On 21th Nov 2005 for No of attachments to the Issue 
	//end integration by harshada d on 19 DEC 2005
	// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
	
//harshada
		function OnBehalfOfCustomerList_OnClick()
		{
			window.open('../General/CommonList.aspx?MasterTagID=3581&FromWhere=CRM','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 960)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=950,height=500');
		}
//harshada
		function Delete_OnClick(msg)
		{
			// Added By NitinVS on 13 Mar 2007 for PMLifeLine issueuId 11346
			var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmRequestList','chkDelete')
			if (blnIsRecordSelected == false) {return;}		
			// End Added By NitinVS on 13 Mar 2007 for PMLifeLine issueuId 11346			
			if (confirm(msg))
			{
			// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
			// objform.action = "CRM_RequestList.aspx?Action=DELETE&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&Mode=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_RequestList.aspx?Action=DELETE&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&Mode=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>&PKToken=<%=m_PKToken_Go_Behalf_ADD%>";
			// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
			objform.submit(); 
			}
		}
		
		function Escalate_OnClick(QueryID)
		{
			if (confirm("Are you sure you want to escalate the request?")) 
			{
				objform.action = "CRM_RequestList.aspx?Action=ESCALATE&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&Mode=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>&EscalateQueryID=" + QueryID  ;
				objform.submit();
			}
		}
		
		function Page_OnClick(page)
		{
			objform.action = "CRM_RequestList.aspx?SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&Mode=<%=m_strMode%>&PageNumber=" + page;
			objform.submit();
		}
		
		//Added by Bharat
		function View_onClick(evt)
        { 
		  
             var objdivTblX = GetObjectReference('frmRequestList','divTblX');
             var url="CRM_XMLHttp.aspx?Page=RequestList&FromXML=1&Action=ShowView&From=<%=m_strMode%>&SelectClearAllX=" + SelectClearAllX;
 		     mousePosition = getMousePosition(evt,objdivTblX);		  
	         loadXMLDoc(url,'')       	
                                
                               
        }
		//Ended By Bharat
		
		
		// Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		// function Query_OnClick(queryid)
		function Query_OnClick(queryid,Token)
		{
			 
			//Commented and added by ShraddhaM on 1,Aug 2007			 
			//To persists Paging number after saving reuest from edit mode
			//window.open("CRM_RequestDetail.aspx?Mode=EDIT&FromList=1&FromWhere=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>&QueryID=" + queryid + "&PKToken=" + Token,"_requestdetail","resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"); 
			window.open("CRM_RequestDetail.aspx?Mode=EDIT&FromList=1&FromWhere=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>&QueryID=" + queryid + "&PKToken=" + Token,"_requestdetail","resizable=yes,scrollbars=yes,left=100,top=100,height=600,width=700"); 
			//End of Addition by ShraddhaM on 1,Aug 2007
		}
		
		function cboStatus_OnChange()
		{
			objform.action = "CRM_RequestList.aspx?Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Mode=<%=m_strMode%>";
			objform.submit();
		}
	
		function cboFilter_OnChange()
		{
			objform.action = "CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Mode=<%=m_strMode%>";
			objform.submit();
		}
		
		function Refresh_OnClick()
		{//debugger;
		    setFrameLoaded();
		    objform.action = "CRM_RequestList.aspx?SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Mode=<%=m_strMode%>";
			objform.submit();
		}
		function optRequest_OnClick(mode)
		{
			switch(true)
			{
			 //Added by PrashantSJ on 08 Nov 2006 For PMLifeLine Enhacement Build 1
               //Purpose: To add new section called My e-Dashboard
			case (mode==0):
				window.location.href = "CRM_MyDashboard.aspx?Mode=MD";
				break;
				//End of addition by PrashantSJ on 08 Nov 2006
			case (mode==1):
				window.location.href = "CRM_Dashboard.aspx?Mode=DB";
				break;
			case (mode==2):
				objform.action = "CRM_RequestList.aspx?Mode=SR";
				objform.submit();
				break;
			case (mode==3):
				objform.action = "CRM_RequestList.aspx?Mode=AR";
				objform.submit();
				break;
			default:
				break;
			}
		}
	
		function Sort_OnClick(sortby,sortorder)
		{
			objform.action = "CRM_RequestList.aspx?Mode=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>&SortBy=" + sortby + "&SortOrder=" + sortorder;
			objform.submit();  
		}
		
		function SetDefault_OnClick(value)
		{
		if (value==0)
		{
			objform.action = "CRM_RequestList.aspx?Action=SET_DEFAULT_MODE&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Mode=<%=m_strMode%>"
		}
		else
		{
			objform.action = "CRM_RequestList.aspx?Action=RESET_DEFAULT_MODE&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Mode=<%=m_strMode%>"
		}
			objform.submit();
		}
	
		function window_onload()
		{
		   // debugger;
			var intDivHeight;
			var intDivHeightRisk;
			window.name="RequestList";
			 
				//alert('doc'+document.body.offsetHeight);
				//alert('list'+objdivlist.offsetTop);
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			//alert(intDivHeight);
			if (intDivHeight < 100)	intDivHeight = 100;
			//'Modified by ShraddhaM on Date 22 June,2006 for PMLifeLine Issue ID.4168
			if(navigator.appName == 'Netscape')
			{
                //coomented by Shamkant S on 5 Nov 2015
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 80 
			    intDivHeight = window.innerHeight - objdivlist.offsetTop -50 ;
                
			}
			//'Ended by ShraddhaM on Date 22 June,2006 for PMLifeLine Issue ID.4168
			objdivlist.style.height = intDivHeight + 'px';	
			
			//harshada d for PMLifeLine for helpdesk enhancements 1936
			objform.action = "CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=<%=m_strMode%>";
			//end of addition by harshada d for PMLifeLine for helpdesk enhancements
			//alert(window.name);
			 
			 
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
						
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			//if (intDivHeight < 100)	intDivHeight = 100;
			 
		    //objdivlist.style.height = intDivHeight;		
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
		    //alert(intDivHeight);
			if (intDivHeight < 100)	intDivHeight = 100;
		    //'Modified by ShraddhaM on Date 22 June,2006 for PMLifeLine Issue ID.4168
			if(navigator.appName == 'Netscape')
			{
			    //coomented by Shamkant S on 5 Nov 2015
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 80 
			    intDivHeight = window.innerHeight - objdivlist.offsetTop -50 ;
                
			}
		    //'Ended by ShraddhaM on Date 22 June,2006 for PMLifeLine Issue ID.4168
			objdivlist.style.height = intDivHeight + 'px';	
		}
		
		
			
		// Added By NitinVS on 22 July 2005 for PSPL, To Give Search facility 
		function GO_OnClick(FromWhere)
		{
			var objtxtRequestId;
			objtxtRequestId = GetObjectReference('frmRequestList','txtRequestId');
			
			if (!disallowBlank(objtxtRequestId,"<%=mybase.GetResourceString("ENTERREQUESTID")%>",true) && (!disallowNonNumeric(objtxtRequestId,"<%=mybase.GetResourceString("NUMERIC")%>",true)) && (!disallowNegativeNumeric(objtxtRequestId,"<%=mybase.GetResourceString("POSITIVE")%>",true)) & (!disallowNonInteger(objtxtRequestId,"<%=mybase.GetResourceString("INTEGER_REQUESTID")%>",true)) )
			{
					if (Number(objtxtRequestId.value) ==0)
					{
						alert("Request ID should be greater than zero!");
						return;
					}	
			objform.action = "CRM_RequestList.aspx?&Search=1&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Mode=<%=m_strMode%>&QueryID=" + objtxtRequestId.value;
			objform.submit();  
			}
		}
		
		function txtRequestID_OnKeyPress(e)		
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				GO_OnClick("<%=m_strMode%>");
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
				var objtxtpageNumber =  GetObjectReference('frmRequestList','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmRequestList','txtNoOfPages');
								
				if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						return;
					}
					Page_OnClick(objtxtpageNumber.value);
				}
			}
		
		}

		function cboDepartment_OnChange()
		{
			objform.action = "CRM_RequestList.aspx?Action=SET_DEFAULT_DEPARTMENT&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Mode=<%=m_strMode%>";
			objform.submit();
		}
		// End Addition By NitinVS on 22 July 2005 for PSPL, To Give Search facility 
		//Added by SrikanthY on 02 Mar 2007 To provide New feature Show Report
        function ShowReport_OnClick()
		{
			window.open ("CRM_ShowReport.aspx?mode=<%=m_strmode%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=300");
		}
		//End of Addition by SrikanthY on 02 03 2007
		//Added by PrashantD on 23 May 2007 for CleanUp Activity
var noOfPages = GetObjectReference('frmDashboard','hidNoOfPages').value;
var objtxtpageNumber =  GetObjectReference('frmDashboard','txtPageNumber');
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
//End of addition by PrashantD on 23 May 2007
<%'Added by SandipL%>
function ShowSLA_Onclick()
{
    
var objFilter = GetObjectReference('frmRequestList','cboFilter');
    //window.open ("CRM_SLA.aspx?Mode=<%=m_strMode%>&FilterID=" + objFilter.value,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
    //Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
  
    $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: 'CRM_RequestList.aspx/GenrateShowSLATokenSR',
        data: JSON.stringify({ FilterID: objFilter.value}),
        success: function (Result) {
           
           // window.open ("CRM_SLA.aspx?Mode=DB&FilterID=" + objFilter.value+"&PkShowSLAToken="+Result.d,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
            window.open ("CRM_SLA.aspx?Mode=<%=m_strMode%>&FilterID=" + objFilter.value+"&PkShowSLATokenSR="+Result.d,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");

        },
        error: function () {
            
        }
    });

    //End Of Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
}
function ShowCounter_Onclick()
{
    debugger;
    var objFilter = GetObjectReference('frmDashboard','cboFilter');
    alert('hi' + objFilter.value)
window.open ("CRM_CounterGraphs.aspx?Mode=<%=m_strMode%>&FilterID=" + objFilter.value,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
}
function RequestSLA_OnClick(QueryID)
{
	window.open ("CRM_SLADetails.aspx?Mode=<%=m_strMode%>&RequestSLA=1&QueryID="+QueryID,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
}

<%'End addition by SandipL%>
//Added by ShraddhaM on 9,Sept 2008
//Purpose : For Line Manager Approval Functionality
function RequestApprovals_onClick()
{
    window.open("../CRM/CRM_LineManagerApprovals.aspx", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 700)/2 + ",width=950,height=700");
}
//End of addition bby ShraddhaM on 9,Sept 2008

//--Added by ShraddhaM on 6,Apr 2009 for PMLifeLine
//--Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page

function ShowDescription_onClick(QueryID)
{
     
    var i=1;
    var objTD = GetObjectReference('',QueryID);
    var objDiv = GetObjectReference('','Summary'+QueryID);
    var objImg = GetObjectReference('','imgSummaryShowHide'+QueryID);
              
     
    var IsCollapse = objImg.getAttribute("Collapse");    
    
    
  if(navigator.appName != 'Netscape')
  { 
        if(IsCollapse=="Y")
        {
            //alert('Y');
                objTD.style.borderBottom = '1px solid gray';
                while(i<objTD.parentNode.children.length)
                {
                    objTD.nextSibling.style.borderBottom = '1px solid gray';    
                    //objTD.style.borderBottom = '0px solid gray';    
                    objTD = objTD.nextSibling;
                    i=i+1;
                }
                //objImg.setAttribute("Collapse","N");
                 
               
        }
        else
        { 
            objTD.style.borderBottom = '0px solid gray';         
            
            while(i<objTD.parentNode.children.length)
            {  
                objTD.nextSibling.style.borderBottom = '0px solid gray';    
                //objTD.style.borderBottom = '0px solid gray';    
                objTD = objTD.nextSibling;
                i=i+1;
            }
            
        }
   }
    //objTD.parentNode.style.borderBottom = '';
    
    
        var objTR = GetObjectReference('frmRequestList','Description'+QueryID);
        
        if(IsCollapse=="Y")
        {   
            //objImg.src='../../../responsive/images/plus.gif';
            objImg.src='../../images/plus.gif';
            objTR.style.display='none';
            objDiv.style.display='none';
            objImg.setAttribute("Collapse","N");
        }
        else if(IsCollapse=="N")
        {   
            //objImg.src='../../../responsive/images/minus.gif';
            objImg.src='../../images/minus.gif';
            objTR.style.display=''; 
            objDiv.style.display='';            
            objImg.setAttribute("Collapse","Y");
        }
        
}
function AssignToMe_onClick(QueryID)
{
    
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=Assign&QueryID=" + QueryID;
			
	loadXMLDoc(url,'')	
	
    
}
var objdiv = GetObjectReference('','divATT');
var displayDiv; 
displayDiv=false;
function AddActivity_onClick(QueryID)
{
    var url="CRM_RequestList.aspx?FromXML=1&Action=AddActivity&QueryID=" + QueryID;
			
	loadXMLDoc(url,'')	
      
}

    
function SaveActivity_OnClick(QueryID)
{ 
    FeedBackQueryID = QueryID;
     //Added by VijayD on 11 Jun 2009 for StatusFlow configuration
      // Commented by GaneshD on 06 Oct 2009 as the status dropdown shows only those statuses which are configured
            /*
   if (ValidateStatusFlow(QueryID)==false)
   {
        return false;
   }
   */
   // End of modification by GaneshD on 06 Oct 2009
   // Addition end by ViajyD on 11 Jun 2009   
   
    var StatusID = GetObjectReference('frmRequestList','hidStatus'+QueryID);
    var OldStatusID = GetObjectReference('frmRequestList','hidoldStatusID'+QueryID);
    var FromWhere = "<%=m_strMode%>";
     
      
      
    if(GetObjectReference('frmRequestList','hidActivityID'+QueryID))
    {
        var ActivityID = GetObjectReference('frmRequestList','hidActivityID'+QueryID).value;
        var Time= GetObjectReference('frmRequestList','txtTime'+QueryID).value;     
        var TotalTodaysTime = GetObjectReference('frmRequestList','TimeSpent'+QueryID).getAttribute('TodaysTotalTimeSpent');
    
        var objTime;
        
         if(parseFloat(Time) < 0 && Time != '')
         {
            alert('Please enter positive number');
            setFocus(GetObjectReference('frmRequestList','txtTime'+QueryID));
            return;
         }
        if(isNumeric(Time)==false && Time != '')
        {
            alert('Please enter numeric value');
            setFocus(GetObjectReference('frmRequestList','txtTime'+QueryID));
            return;
        }
        if(Time != '' && ActivityID=='')
        {
            alert('Please select the Activity');
            setFocus(GetObjectReference('frmRequestList','hidActivityID'+QueryID));
            return;
        }
        if(Time == '' && ActivityID!='')
        { 
            alert('Please enter Time');
            setFocus(GetObjectReference('frmRequestList','txtTime'+QueryID));
            return;
        }     
        //alert(parseFloat(TotalTodaysTime));
        if(parseFloat(TotalTodaysTime) + parseFloat(Time) > 24*60)
        {
            //alert('Time should be less than total minutes in one day i.e. 1440 minutes \n You can add more '+(1440 - Number(TotalTodaysTime)) +' minutes for today.');
            alert('Total minutes in one day should be less than equal to 1440 minutes. \n You can add more '+(1440 - parseFloat(TotalTodaysTime)) +' minutes for today.');
            
            setFocus(GetObjectReference('frmRequestList','txtTime'+QueryID));
            return;
        }  
        
       if(StatusID != null && OldStatusID != null )
       {
            if(OldStatusID.value != StatusID.value && FromWhere == 'SR' && StatusID.value == '2')
            {   
                
                    showCommentDiv(event) 
                
            }
             else
                {        
                    SaveData(QueryID)
                }
        }
        else
                {        
                    SaveData(QueryID)
                }
    }
    else
    {  
        //var url="CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID="+StatusID.value+"&QueryID=" + QueryID;
     if(StatusID != null && OldStatusID != null )
       {
		     if(OldStatusID.value != StatusID.value && FromWhere == 'SR' && StatusID.value == '2')
            {
                    
                   showCommentDiv(event) 
                 
            }
             else
                {        
                    SaveData(QueryID)
                }
        }
        else
                {        
                    SaveData(QueryID)
                }
    }
    //var url="CRM_RequestList.aspx?FromXML=1&Action=SaveActivity&Time="+Time+"&ActivityID="+ActivityID+"&QueryID=" + QueryID;
		
	
	 
}

function SaveData(QueryID,SaveFeedBack)
{
    
     var StatusID = GetObjectReference('frmRequestList','hidStatus'+QueryID);
     if(SaveFeedBack == '1')
     {  
        var objFeedBackDiv = GetObjectReference('frmRequestList','cboFeedbackDiv');
        var objFeedBackCommentsDiv = GetObjectReference('frmRequestList','txtSubmitCommentsDiv');
     }
     
    
     if(GetObjectReference('frmRequestList','hidActivityID'+QueryID))
     {
         var ActivityID = GetObjectReference('frmRequestList','hidActivityID'+QueryID).value;
         var Time= GetObjectReference('frmRequestList','txtTime'+QueryID).value;     
         var TotalTodaysTime = GetObjectReference('frmRequestList','TimeSpent'+QueryID).getAttribute('TodaysTotalTimeSpent');
    
           if(SaveFeedBack == 1)
           { 
                 var url="CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&FeedBackID="+objFeedBackDiv.value+"&FeedBackComment="+objFeedBackCommentsDiv.value+"&statusID="+StatusID.value+"&Time="+Time+"&ActivityID="+ActivityID+"&QueryID=" + QueryID;
         
           }
           else
            {
                 var url="CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID="+StatusID.value+"&Time="+Time+"&ActivityID="+ActivityID+"&QueryID=" + QueryID;
         
           }
           if(Time == '')
	            objTime = 0;
            else
                objTime = Time;
		    GetObjectReference('frmRequestList','TimeSpent'+QueryID).setAttribute('TodaysTotalTimeSpent',parseFloat(TotalTodaysTime) + parseFloat(objTime));
     } 
    else
     { 
        if(SaveFeedBack == 1)
        {
                var url="CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&FeedBackID="+objFeedBackDiv.value+"&FeedBackComment="+objFeedBackCommentsDiv.value+"&statusID="+StatusID.value+"&QueryID=" + QueryID;
                
		}
		else
		{
                var url="CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID="+StatusID.value+"&QueryID=" + QueryID;
		}
     }
     loadXMLDoc(url,'')	
}
function SearchActivity(QueryID,evt)
{   
    var Activity = GetObjectReference('frmRequestList','txtActivity'+QueryID);
    
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=SearchActivity&Activity="+Activity.value+"&QueryID=" + QueryID;
			
	loadXMLDoc(url,'')	
	//showmenuie(Activity,evt,displayDiv,QueryID,250)
	showmenuieDA(objdiv,evt);
}
function ShowStatus(QueryID,evt)
{  
    var Status = GetObjectReference('frmRequestList','txtStatus'+QueryID);
   
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowStatus&QueryID=" + QueryID;
			
    loadXMLDoc(url,'')	
    displayDiv = true; // Added By Vaijat K ON 28/12/2015
	showmenuie(Status,evt,displayDiv,QueryID,100)
	
	
}

function ShowDetailActivity(evt,QueryID)
{
     var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowDetailActivity&QueryID=" + QueryID;
	 var objdivActivityDtls = document.getElementById('divActivityDtls');
	 
	 objdivActivityDtls.style.display=""; 			
	 
	 loadXMLDoc(url,'')	

	
var mousePosition = getMousePosition(evt,objdivActivityDtls);	  
	/*	           
    objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
    objdivActivityDtls.style.width=700;
    objdivActivityDtls.style.top = (window.screen.height - 500)/2; 
    if( objdivActivityDtls.offsetHeight > 400)
    {
        
        objdivActivityDtls.style.height = 400;     
    }
    else
    {
        objdivActivityDtls.style.height = ( objdivActivityDtls.offsetHeight  ) +"px";         
    }*/

  //  showmenuieDA(objdivActivityDtls,evt);
	  showRequester('divActivityDtls',evt);
}

function ShowRequestorDetails(evt,QueryID,RequestorType)
{   
     
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowRequestorDetails&RequestorType="+RequestorType+"&QueryID=" + QueryID;
	var objdivActivityDtls = document.getElementById('divActivityDtls');
   
     objdivActivityDtls.style.innerHTML ="";
   //  objdivActivityDtls.style.height=0;
     
    objdivActivityDtls.style.display="";
    				
	loadXMLDoc(url,'')	
	var objdivActivityDtls = document.getElementById('divActivityDtls');
	var mousePosition = getMousePosition(evt,objdivActivityDtls);	  
    /*objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
    objdivActivityDtls.style.width=700;
    objdivActivityDtls.style.top = (window.screen.height - 500)/2;  		           
            
//    objdivActivityDtls.style.left = 200//mousePosition.x;objdivActivityDtls.style.top = mousePosition.y;  
//    objdivActivityDtls.style.width=700;
    //objdivActivityDtls.style.height=200;
    objdivActivityDtls.style.display=""; 
    //showmenuieDA(objdivActivityDtls,evt);*/
    
     showRequester('divActivityDtls',evt);
	
}
function ShowStatistics(evt,QueryID,RequestorType)
{
     var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowStatistics&RequestorType="+RequestorType+"&QueryID=" + QueryID;
     var objdivActivityDtls = document.getElementById('divStatistics');
     objdivActivityDtls.style.innerHTML ="";
   //  objdivActivityDtls.style.height=0;
     
     objdivActivityDtls.style.display="";     			
	 loadXMLDoc(url,'')	
	 //var mousePosition = getMousePosition(evt,objdivActivityDtls);

    /*objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
    objdivActivityDtls.style.width=700;
    objdivActivityDtls.style.top = (window.screen.height - 500)/2;  

    if( objdivActivityDtls.offsetHeight > 400)
    {
        
        objdivActivityDtls.style.height = 400;     
    }
    else
    {
        objdivActivityDtls.style.height = ( objdivActivityDtls.offsetHeight  ) +"px";         
    }
    
    objdivActivityDtls.style.display=""; */
    
     showRequester('divStatistics',evt);
     

}
function showRequester(divCM,objevent){

var objdiv = GetObjectReference('',divCM);

   objdiv.style.display='';
   objdiv.style.position = 'absolute'; 
   
    //Find out how close the mouse is to the corner of the window
    var rightedge=ie5? document.body.clientWidth-event.clientX : 
        window.innerWidth-objevent.clientX
    var bottomedge=ie5? document.body.clientHeight-event.clientY : 
        window.innerHeight-objevent.clientY

    //if the horizontal distance isn't enough to accomodate the width of 
    //the context menu
    var objDivH =objdiv.offsetWidth;

    /*if (objDivH > 200)
        objDivH=200;*/
        
  objdiv.style.left=0;
                 
    /*if (rightedge<objDivH)
    //move the horizontal position of the menu to the left by it's width
    objdiv.style.left=ie5? 
        document.body.scrollLeft+event.clientX-objDivH : 
        window.pageXOffset+objevent.clientX-objDivH
     
    else
    //position the horizontal position of the menu where the mouse was clicked
    objdiv.style.left=ie5? document.body.scrollLeft+event.clientX : 
        window.pageXOffset+objevent.clientX*/

    //same concept with the vertical position
    if (bottomedge<objdiv.offsetHeight)
        objdiv.style.top=(ie5? 
        document.body.scrollTop+event.clientY-objdiv.offsetHeight : 
        window.pageYOffset+objevent.clientY-objdiv.offsetHeight) +10
    else
    objdiv.style.top=(ie5? document.body.scrollTop+event.clientY: 
        window.pageYOffset+objevent.clientY) + 10
        
        //(document.body.scrollTop==0 ? 100 : 0)
        
        //objdiv.style.top=objdiv.style.top-100;
    if(ie5)
        window.event.cancelBubble = true;
    else if(ns6)
        //Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
        //e.stopPropagation();
        objevent.stopPropagation();
        //End Of Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
    if (WhichBrowser() != 'FF'){
        objdiv.style.left = 0 + 'px';
        if (event.pageY > 700){
            objdiv.style.top= event.pageY - 100 + 'px';
        }
        else{
            objdiv.style.top= event.pageY + 'px';
        }
    }
    else
    {
        objdiv.style.left = 0 + 'px';
        if (event.pageY > 700){
            objdiv.style.top= objevent.pageY - 100 + 'px';
        }
        else{
            objdiv.style.top= objevent.pageY + 'px';
        }
    }
    objdiv.style.height = "auto";
   return false;
  
   }
function showmenuieDA(objdiv,objevent){

//var objdiv = GetObjectReference('',divCM);

   objdiv.style.display='';
   objdiv.style.position = 'absolute'; 
   objdiv.style.width=150;
   
    //Find out how close the mouse is to the corner of the window
    var rightedge=ie5? document.body.clientWidth-event.clientX : 
        window.innerWidth-objevent.clientX
    var bottomedge=ie5? document.body.clientHeight-event.clientY : 
        window.innerHeight-objevent.clientY

    //if the horizontal distance isn't enough to accomodate the width of 
    //the context menu
    var objDivH =objdiv.offsetWidth;

  if (objDivH > 600)
        objDivH=600;

                
   if (rightedge<objDivH)
    //move the horizontal position of the menu to the left by it's width
    objdiv.style.left=ie5? 
        document.body.scrollLeft+event.clientX-objDivH : 
        window.pageXOffset+objevent.clientX-objDivH
     
    else
    //position the horizontal position of the menu where the mouse was clicked
    objdiv.style.left=ie5? document.body.scrollLeft+event.clientX : 
        window.pageXOffset+objevent.clientX

    //same concept with the vertical position
  /*  if (bottomedge<objdiv.offsetHeight)
        objdiv.style.top=(ie5? 
        document.body.scrollTop+event.clientY-objdiv.offsetHeight : 
        window.pageYOffset+objevent.clientY-objdiv.offsetHeight) +10
    else
    objdiv.style.top=(ie5? document.body.scrollTop+event.clientY: 
        window.pageYOffset+objevent.clientY) + 10*/
        
     objdiv.style.top=   objevent.clientY;
        
        //(document.body.scrollTop==0 ? 100 : 0)
        
        //objdiv.style.top=objdiv.style.top-100;
  if(ie5)
        window.event.cancelBubble = true;
    else if(ns6)
        //Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
        //e.stopPropagation();
        objevent.stopPropagation();
        //End Of Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
   
  if (WhichBrowser() != 'FF'){
      objdiv.style.left = event.pageX + 'px';
      if (event.pageY > 700){
          objdiv.style.bottom= event.pageY + 'px';
          objdiv.style.top= event.pageY - 100 + 'px';
      }
      else{
          objdiv.style.top= event.pageY + 'px';
      }
  }
  else
  {
      objdiv.style.left = objevent.pageX + 'px';
      if (event.pageY > 700){
          objdiv.style.bottom= objevent.pageY + 'px';
          objdiv.style.top= objevent.pageY - 100 + 'px';
      }
      else{
          objdiv.style.top= objevent.pageY + 'px';
      }
  }
  return false;
  
   }
function CloseDiv()
{
    var objdivActivityDtls = document.getElementById('divActivityDtls')
    
	if(objdivActivityDtls)
	objdivActivityDtls.style.display="none";
	
	var objdivStatistics = document.getElementById('divStatistics');
	
	if(objdivStatistics)
	objdivStatistics.style.display="none";
	 
}

function Attribute_OnClick(Activity,QueryID)
{    
   GetObjectReference('frmRequestList','txtActivity'+QueryID).value = Activity;
   objdiv.style.display='none';
}
function loadXMLDoc(url,reqQuery)	
{
if (window.XMLHttpRequest) {
xmlhttp=new XMLHttpRequest();
xmlhttp.onreadystatechange= state_Change;
if (ns) {xmlhttp.open('GET',url,true);
          xmlhttp.send(null);
}
else {xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}
}else if (window.ActiveXObject){
xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
if (xmlhttp) {xmlhttp.onreadystatechange=state_Change;
xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}}
}

function state_Change() 
{
	var FromWhere;
	var QueryID;
	if (parseInt(xmlhttp.readyState)==4) 
	{ 
		if (xmlhttp.status==200)
		{
		    var result = xmlhttp.responseText.split("$_$");
		    QueryID = result[1]; 
		    
		    if(result[0] == 'SaveActivity')
		    {
		            var objtxtSavingLable = GetObjectReference('frmRequestList','txtSavingLable'+QueryID);
		        
		            objtxtSavingLable.style.display = '';
		        
		        var objActivity = GetObjectReference('frmRequestList','txtActivity'+QueryID);
		        if(objActivity)
		        {
		            var objTotalTime = GetObjectReference('frmRequestList','TotalTime'+QueryID);
		            //var TotalTime = GetObjectReference('frmRequestList','TotalTime'+QueryID).innerText;
		            var TotalTime = GetObjectReference('frmRequestList','TotalTime'+QueryID).getAttribute('TotalTime');		        
		            var objActivityID = GetObjectReference('frmRequestList','hidActivityID'+QueryID);
		            var objTime=GetObjectReference('frmRequestList','txtTime'+QueryID);
       		         
		            var NewTotalTime = TotalTime //TotalTime.substring(start+1,stop);    		             
    		        		        
		            if(objTime.value != '')
		            {
		                var ConvertedTime = parseFloat(NewTotalTime) + parseFloat((parseFloat(objTime.value)/60).toFixed(2));
        		        
		                objTotalTime.innerHTML = '<U><B><A onClick=ShowDetailActivity(event,' + QueryID + ') >Total Time Spent </A></U>&nbsp;:&nbsp;' + ConvertedTime + '&nbsp;Hrs</B>&nbsp;&nbsp;'
		                GetObjectReference('frmRequestList','TotalTime'+QueryID).setAttribute('TotalTime',ConvertedTime);
    		            
		            }	
		          }	 
		          
		          var objStatus = GetObjectReference('frmRequestList','Status'+QueryID);
		          var objNewStatus = GetObjectReference('frmRequestList','txtStatus'+QueryID); 			        	       
		           
		          //To Change status in Grid column  
		          if(objStatus)   
		          objStatus.innerHTML = objNewStatus.value
		           
		        var objtxtTime = GetObjectReference('frmDashboard','txtTime'+QueryID) ;
                var objtxtActivity = GetObjectReference('frmDashboard','txtActivity'+QueryID) ; 
                var objimgActivity = GetObjectReference('frmDashboard','imgActivity'+QueryID) ; 
                var objbtnSave = GetObjectReference('frmDashboard','btnSave'+QueryID) ;  
        
                var  objtxtStatus = GetObjectReference('frmDashboard','txtStatus'+QueryID) ;  
                var  objhidtxtStatus = GetObjectReference('frmDashboard','hidStatus'+QueryID) ;
        		        
		            
                        if(objhidtxtStatus.value != 2)
                                {   if(objtxtTime){
                                    objtxtTime.disabled = false;      
                                    objtxtActivity.disabled = false;      
                                    objimgActivity.onClick = "SearchActivity(" + QueryID + ",event)";
                                    objbtnSave.disabled = false; 
                                    }  
                                }   
                                else     
                                { 
                                    if(objtxtTime){
                                    objtxtTime.disabled = true;      
                                    objtxtActivity.disabled = true;      
                                    objimgActivity.onClick = "";
                                    objbtnSave.disabled = true;   
                                    }
                                }



        
		        var StatusID = GetObjectReference('frmRequestList','hidStatus'+QueryID);
		         
		        if(StatusID.value==2)
		        {
		        var objtxtStatus = GetObjectReference('','txtStatus' +QueryID);
		        var objimgStatus = GetObjectReference('','imgStatus' +QueryID);		        
		        objtxtStatus.disabled=true;
		        objtxtStatus.onclick='';
		        objimgStatus.onclick='';
		        }
		        		 
		        if(objActivity)
		        {       
		            objActivity.value = '';
		            objActivityID.value = '';
		            objTime.value = '';
		            setFocus(objTime);
		        }
		        
		        var code ;
		        code = "var objtxtSavingLable = GetObjectReference('frmRequestList','txtSavingLable"+QueryID+"'); objtxtSavingLable.style.display = 'none';"
		        setTimeout(code,400);
		        
		        if(objdiv)
		        {
		            objdiv.style.display='none';
		        }
		    }
//		    else if(result[0] =='SaveStatus')
//		    {
//		        var StatusID = GetObjectReference('frmMyDashboard','hidStatus'+QueryID);
//		        //alert(StatusID);
//		        if(StatusID.value==2)
//		        {
//		        var objtxtStatus = GetObjectReference('','txtStatus' +QueryID);
//		        var objimgStatus = GetObjectReference('','imgStatus' +QueryID);		        
//		        objtxtStatus.disabled=true;
//		        objtxtStatus.onclick='';
//		        objimgStatus.onclick='';
//		        }
//		    }
		    else if(result[0] == 'Assign') 	
		    {
		        var objAssignTo = GetObjectReference('','AssignTo' +QueryID);
		   
                objAssignTo.innerHTML = '<B><FONT color=red>Assigned To me</FONT></B>';
		    }
		    else if(result[0] == '')
		    { 		         
		        document.getElementById('divATT').innerHTML = '';		        
		        document.getElementById('divATT').style.display='none';
		        displayDiv = false;
		        
		    }
		    //Added by GaneshD on 31 Aug 2009 for PMLifeLine IssueID-32677
		     else if(result[0] == 'NotValidStatus') 	
		    {
		       displayDiv = false;
		        alert(result[2]);
		        return;
		    }
		    // End of addition by GaneshD
		    
		    else
		     {   	         
		       if(result[1] != '') 	         
		        {
		            if(result[1] == 'ShowView')
		            {
		                         var objdivTblX = GetObjectReference('frmRequestList','divTblX');
	                            objdivTblX.innerHTML = result[0];	
                                objdivTblX.style.left = mousePosition.x + "px";
                                objdivTblX.style.top = mousePosition.y + "px";
                                //objdivTblX.style.width=200;     
                                objdivTblX.style.display="";
                                var objdivTblXX = GetObjectReference('frmRequestList','divTblXX');
                                var objTblXX = GetObjectReference('frmRequestList','TblXX');
		                       
		                       var objchkAll = GetObjectReference('frmRequestList','chkAll');
		                       var objchkField = GetObjectReference('frmRequestList','chkField',true);
		                     		                      
		                      var Ischeck;
		                      
		                      for(i=0;i<objchkField.length;i++)
		                      {
		                        if(objchkField[i].checked==true)
		                        {
		                              Ischeck = true;
		                        }
		                        else
		                        {
		                             Ischeck = false;
		                             break;
		                        }
		                      }
		                      if(Ischeck==true)
		                      {
		                        objchkAll.checked=true
		                      }
		    
		            }
		            else if(result[1] == 'ShowStatistic')
		            {
		                 var objdivActivityDtls = document.getElementById('divStatistics')
		                 objdivActivityDtls.innerHTML = result[0];
		            }
		            else
		            {
		                document.getElementById('divATT').innerHTML = result[0];	    
                        document.getElementById('divATT').style.display="";
			            displayDiv = true;
			        }
		        }
		        
		        else
		        {    
		        
		            var objdivActivityDtls = document.getElementById('divActivityDtls');
		            objdivActivityDtls.innerHTML = result[0];
		             
		            			     
		        }
		        
		     }
		     		
		    
			
		}
	}
	
}
 var ie5=document.all&&document.getElementById
 var ns6=document.getElementById&&!document.all
 
 
 function pos(ctrl,arg)
 {    
  
    var a=ctrl,b=arg;        
    var d=0;        
    while(a)        
    {        
    d+=a[b];
           
     a=a.offsetParent
            
    }        
    return d
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
        
        objContextMenu.style.left = intX + "px";
        objContextMenu.style.top = intY + "px";
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}

function showmenuie(element,objevent,displayDiv,QueryID,width)
{  //debugger;     
    //objdiv.style.position = 'absolute';
    var ret = new Point();
    if(displayDiv == true)
    {
         
        objdiv.style.display='';
        //objdiv.style.position = 'absolute'; 
        objdiv.style.height='200px'; 
       
        
        for(; 
            element && element != document.body;
            ret.translate(element.offsetLeft, element.offsetTop), element = element.offsetParent
            );                  

        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
         
        if (intBottom - ret.y < objdiv.offsetHeight)
        {ret.y = ret.y - objdiv.offsetHeight;}
         
        
        if(navigator.appName != 'Netscape')
        { 
            //objdiv.style.left = ret.x + 4;
            objdiv.style.left = ret.x + 4 + "px";
        }  
        else
        {
            // objdiv.style.left = ret.x + 6;
            objdiv.style.left = ret.x + 6 + "px";
        }          
         
        if(navigator.appName != 'Netscape')
        {
            //objdiv.style.top=ret.y - 5 - objdivlist.scrollTop ; //- objdiv.style.height ;
            objdiv.style.top=ret.y + "px"; - objdivlist.scrollTop ; //- objdiv.style.height ;
           
        }
        else
        { 
            //objdiv.style.top=ret.y + 15 - objdivlist.scrollTop ; //- objdiv.style.height ;
            //objdiv.style.top=ret.y +15-objdivlist.scrollTop ;
            objdiv.style.top=ret.y  + "px";//-objdivlist.scrollTop ;
        } 
        
        objdiv.style.width = width;
        objdiv.style.display=''; 
    
        var table = document.getElementById('tblContextMenu');
        if (table != null){
            trs = table.getElementsByTagName('tr');
             
            highlightRow( trs[currentRow] );
        }
            
    }
    //else{
   //Added By Vaijat K ON 28/12/2015
        if (WhichBrowser() != 'FF'){
            objdiv.style.left =ret.x + 'px';
            if (event.pageY > 700){
                objdiv.style.bottom= event.pageY + 'px';
                objdiv.style.top= event.pageY - 50 + 'px';
            }
            else{
                objdiv.style.top= event.pageY + 'px';
            }
        }
        else
        {
            objdiv.style.left = ret.x  + 'px';
            
            if (objevent.pageY > 700){
                objdiv.style.bottom= objevent.pageY + 'px';
                objdiv.style.top= objevent.pageY -50  + 'px';
            }
            else{
                objdiv.style.top= objevent.pageY + 'px';
            }
        }
    //ended
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
  

  function Doc_OnmouseUp()
  {
  if(document.getElementById('divATT'))
    document.getElementById('divATT').style.display="none";
   
  }

function SelectStaus(QueryID,evt)    
{
    alert('SelectStaus');
} 

function Point(x,y)
{    
        this.x = x || 0;
        this.y = y || 0;
        this.toString = function(){ 
            return this.x+', '+this.y;
        };
        this.translate = function(dx, dy){ 
            this.x += dx || 0;
            this.y += dy || 0;
        };
        
        this.getX = function(){   return this.x; }
        this.getY = function(){   return this.y; }
        this.equals = function(anotherpoint){  
            return anotherpoint.x == this.x && anotherpoint.y == this.y;

        };
} 

function DisplayColor(tr,curRow)
{
  tr.style.backgroundColor = '3366FF' ; 
 highlightedRow = tr;
}

function RemoveColor(tr,curRow)
{
  tr.style.backgroundColor  = '#ffffff';

}
 
function copytext(evt,Control,Text,QueryID,ID)
{   
      
 //var keyID = (window.event) ? event.keyCode : e.keyCode;
  
 //if(keyID == 13 || keyID ==0)
 //{    
  
  if( Control == 'txtStatus')
  {
    if(LoginType=='E')
	{
        var objOldStatusDate = GetObjectReference('frmRequestList','hidStatusChangeDate')
        var objOldStatusTime = GetObjectReference('frmRequestList','hidStatusChangeTime')
        var objCurrentDate = GetObjectReference('frmRequestList','hidCurrentDate')
        var objCurrentTime = GetObjectReference('frmRequestList','hidCurrentTime')
        
          var objtxtTime = GetObjectReference('frmDashboard','txtTime'+QueryID) ;
                var objtxtActivity = GetObjectReference('frmDashboard','txtActivity'+QueryID) ; 
                 var objhidtxtActivity = GetObjectReference('frmRequestList','hidActivityID'+QueryID) ; 
                var objimgActivity = GetObjectReference('frmDashboard','imgActivity'+QueryID) ; 
                var objbtnSave = GetObjectReference('frmDashboard','btnSave'+QueryID) ;  
        
                var  objtxtStatus = GetObjectReference('frmDashboard','txtStatus'+QueryID) ;  
                var  objhidtxtStatus = GetObjectReference('frmDashboard','hidStatus'+QueryID) ;
        		        
                               /*     if(objtxtTime)		        
                                    {
                                    objtxtTime.disabled = false;      
                                    objtxtActivity.disabled = false;      
                                    objimgActivity.onClick = "SearchActivity(" + QueryID + ",event)";
                                    objbtnSave.disabled = false; 
                                    }  */
            if(objtxtTime)
            {
                  if(ID!=2)
                   {
                        objtxtTime.disabled = false;      
                        objtxtActivity.disabled = false;      
                        objimgActivity.onClick = "SearchActivity(" + QueryID + ",event)";
                        objimgActivity.disabled=false;
                        objbtnSave.disabled = false;   
                   }
                   else
                   {
                        objtxtTime.disabled = true;      
                        objtxtActivity.disabled = true; 
                        objtxtTime.value='';       
                        objtxtActivity.value='';   
                        objhidtxtActivity.value='';     
                        //objimgActivity.onClick = "";
                        objimgActivity.disabled=true;
                        
                   } 
            }
            
        if(objOldStatusDate.value==objCurrentDate.value && objOldStatusTime.value==objCurrentTime.value) 
	    {												  
	    	    alert("Status Change date & time should be greater than previous status Change date '"+objOldStatusDate.value+"' and time '"+objOldStatusTime.value+"'.");		
			    return;
	    }
	}
    GetObjectReference('frmRequestList','hidStatus'+QueryID).value =  ID;
//    var StatusID = GetObjectReference('frmRequestList','hidStatus'+QueryID);
//	var url="CRM_Dashboard.aspx?FromXML=1&Action=SaveStatus&statusID="+StatusID.value+"&QueryID=" + QueryID;
//			
//	loadXMLDoc(url,'')	
  }
  else if(Control == 'txtActivity')
  {
    GetObjectReference('frmRequestList','hidActivityID'+QueryID).value = ID;
  }
  GetObjectReference('frmRequestList',Control+QueryID).value = Text;
  objdiv.style.display='none';
 //}   
}

 function highlightRow(tr) {  
                            tr.style.backgroundColor = '3366FF' ; 
                            highlightedRow = tr;

 
                        }


function dehighlightRow(tr) {
                            tr.style.backgroundColor = '#ffffff';
                                table = null;
                                trs = null;
                        }

 


function processKeys( e )
                        { 
                                if(document.getElementById('tblContextMenu' ))
                                {
                                var table = document.getElementById('tblContextMenu' );
                                var numRows = table.rows.length;
                                var keyID = (window.event) ? event.keyCode : e.keyCode;
                                
     

                                switch (keyID)
                                {
                                        // Key up.
                                        case 38:
                                        if (parseInt(currentRow) == parseInt(0))
                                        {
// reached the top of the table; do nothing. 
                                                return true;
                                        } else
                                        {
                                                // move one row up.
                                                scrollRow( "up" );
                                                //setCurrentRow( currentRow );
      //currentRow = currentRow - 1;
                                                return false;
                                        }
                                        break;

                                        // Key down.
                                        case 40: 
     
     //alert(numRows);
                                        if (currentRow == (numRows - 1))
                                        {
// reached the end of the table; do nothing 
                                                return true;
                                        } else
                                        {
                                                scrollRow( "down" );
                                                //setCurrentRow( currentRow );
    
      //currentRow = currentRow  + 1;

                                                 
                                        }
                                        break;
                                      }
                                }


function scrollRow ( dir )
                                {  
                                        var trs =
document.getElementById('tblContextMenu').getElementsByTagName('tr');
                                        if (dir == "up")
                                        {
dehighlightRow ( trs[ currentRow ] ); 
                                                currentRow--;
highlightRow( trs[ currentRow ] ); 
                                        } else if (dir == "down")
                                    {
                                        dehighlightRow( trs[ currentRow ] );
                                        currentRow++;
                                        highlightRow( trs[ currentRow ] );
                                    }
                                }
                        }
var SelectClearAllX=0;
/*function View_onClick(evt)
{ 

 var objdivTblX = GetObjectReference('frmRequestList','divTblX');
     var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowView&From=<%=m_strMode%>&SelectClearAllX=" + SelectClearAllX;
			 mousePosition = getMousePosition(evt,objdivTblX);		  
	 loadXMLDoc(url,'') 
  
	 
}*/
 function CloseFilter()
 {
    var objdivTblX = GetObjectReference('frmRequestList','divTblX');
    if(objdivTblX);
    objdivTblX.style.display='none';
    
 }
 function applyFilter()
 {    
      
    objform.action = "CRM_RequestList.aspx?Mode=<%=m_strMode%>&Action=APPLYVIEW";		    
    objform.submit();
    //Commented by bharat tekade on 19th-june-2014
   // window.location.href  = window.location.href ;
   //ended by bharat tekade
    
 }
  
 
 function SelectAndClearAll_OnClick()
 {
    var obSCFilterX = GetObjectReference('frmRequestList','chkAll');
                 
                if(obSCFilterX!=null){
                    if(obSCFilterX.checked==true)
                        SelectClearAllX = 0;
                    else
                        SelectClearAllX = 1;
                }
                if(SelectClearAllX==0){
                
                    SelectAllCheckboxs('frmRequestList','chkField');
                    SelectClearAllX = 1;
                }
                else
                {
                    ClearAll_OnClick('frmRequestList','chkField');
                   //  obhdnXAxisFilterString.value = "";
                    SelectClearAllX=0;
                }
 }
 
 function Requestor_keypress(e)
 {
     
    if(e.keyCode == 13)
    {         
        objform.action = "CRM_RequestList.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_REQUESTORFILTER";		    
        objform.submit();
    }
    
 }
 
//Ended by ShraddhaM on 7,Apr 2009 for PMLifeLine

//Added by VijayD on 11 Jun 2009 for StatusFlow configuration
function ValidateStatusFlow(QueryID)
{
    var validStatusNew;
    var validStatusExist;

    var objOldStatus = GetObjectReference('frmRequestList','txtOldStatus'+QueryID);
    var objNewStatus = GetObjectReference('frmRequestList','txtStatus'+QueryID);

    var objCompareStatus = GetObjectReference('frmRequestList','CmbStatus'+QueryID);
    var objPrevStatus = GetObjectReference('frmRequestList','CmbPrevStatus'+QueryID);
    var objStatusFlowCount = GetObjectReference('frmRequestList','StatusFlowCount'+QueryID);
    var intStatusFlowCount = objStatusFlowCount.value;
    var statusFlag=0;
    validStatusNew = ""
    validStatusExist = "\n\n";

        if(intStatusFlowCount > 0)
        {
    		
            for(i=0;i<=objCompareStatus.length-1;i++)
            {
                validStatusExist = validStatusExist + (i + 1)+ ". " +objCompareStatus[i].value + "\n"
            }
    		
            for(i=0;i<=objCompareStatus.length-1;i++)
            {
                if(objCompareStatus[i].value == objNewStatus.value)
                {
                    validStatusNew = objNewStatus.value;
                    break;
                }
            }
            if (objNewStatus.value==objOldStatus.value)
            {
                validStatusNew=objNewStatus.value;           
            }
            
            if(validStatusNew == "")
            {
                if(validStatusExist =="\n\n")
                {
                    alert("'"+objOldStatus.value +"' is the last status configured in the status flow.");
                }
                else
                {
                    alert('Invalid Status, Status can be change to one of the following ' + validStatusExist);
                }               
                return false;
            }
         }		
         return true;
}

// Addition end by ViajyD on 11 Jun 2009   

function ApplyAdvancedFilter()
{
		objform.action = "CRM_RequestList.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_SEARCH_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
		objform.submit();
    
}
function cboSearch_OnChange()
  {
    var ojbSearchFieldvalue =  GetObjectReference('frmRequestList','cboSelectSearch').value;
    var cboPriority = GetObjectReference('frmRequestList','cboPriority');
    //var cboAssignedTo = GetObjectReference('frmRequestList','cboAssignedTo');
    //var cboCustomer = GetObjectReference('frmRequestList','cboCustomer');
    //var cboEmployee = GetObjectReference('frmRequestList','cboEmployee');
    //var cboLocation = GetObjectReference('frmRequestList','cboLocation');
    var cboRequestType = GetObjectReference('frmRequestList','cboRequestType');
    //var cboSubRequestType = GetObjectReference('frmRequestList','cboSubRequestType');
    var txtSubject = GetObjectReference('frmRequestList','txtSubject');
    var cboSeverity = GetObjectReference('frmRequestList','cboSeverity');
    var searchfor = GetObjectReference('frmRequestList','searchfor');
    cboPriority.style.display="none";
    //cboAssignedTo.style.display="none";
    //cboCustomer.style.display="none";
    //cboEmployee.style.display="none";
    //cboLocation.style.display="none";
    cboRequestType.style.display="none";
    //cboSubRequestType.style.display="none";
    txtSubject.style.display="none";
    cboSeverity.style.display="none";    
    
    switch (ojbSearchFieldvalue)
    {
        case "Priority":
            searchfor.style.display="";  
            cboPriority.style.display="";
        break;        

        case "Request Type":
            searchfor.style.display="";          
            cboRequestType.style.display="";
        break;        

        case "Subject":
            searchfor.style.display="";          
            txtSubject.style.display="";
        break;
        
        case "Severity":
            searchfor.style.display="";          
            cboSeverity.style.display="";
        break;    
        default:
            
            cboPriority.style.display="none";
            //cboAssignedTo.style.display="none";
            //cboCustomer.style.display="none";
            //cboEmployee.style.display="none";
            //cboLocation.style.display="none";
            cboRequestType.style.display="none";
            //cboSubRequestType.style.display="none";
            txtSubject.style.display="none";
            cboSeverity.style.display="none";    
            searchfor.style.display="none";     
    }
    
     
//			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
//			objform.submit();
  
  }
   function cboDateFilter_OnChange()	
        {
			objform.action = "CRM_RequestList.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_DATEFILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.submit();
        
        }
        
        function Flag_OnClick(QueryID,PKToken)
		{
            //window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=0&ContextID=" + QueryID + "&PKToken=" + PKToken + "&ContextType=HelpDeskRequest&FromWhere=DB&FromWhich=HelpDesk","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
            //Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'CRM_RequestList.aspx/GenrateFlagToken_RequestList',
                data: JSON.stringify({ ProjectID: 0, ContextID: QueryID}),
			        success: function (Result) {
			            window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=0&ContextID=" + QueryID + "&PKToken=" + PKToken + "&ContextType=HelpDeskRequest&FromWhere=DB&FromWhich=HelpDesk&PkFlagToken_RequestList="+Result.d,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );

			        },
			        error: function () {
			            //alert("Error")
			        }
			    });

            //End of addition by Chakshuta H on 1st-Aug-2016
		}
		
		
function showCommentDiv(ev)
{                
                //objcboRequestType.style.visibility = 'hidden';

                //objcboSubRequestType.style.visibility = 'hidden';
                
                objFeedBackDiv = GetObjectReference('frmRequestList','DivFeedBack');
                var mousePosition = getMousePosition(ev,objFeedBackDiv);
			    objFeedBackDiv.style.width  = '405px';
			    objFeedBackDiv.style.height  = '150px';
			    objFeedBackDiv.style.left =  mousePosition.x+ "px";
			    objFeedBackDiv.style.top =  mousePosition.y+ "px";	     
		        objFeedBackDiv.style.position ='absolute';
			    objFeedBackDiv.style.display  = '';
			    document.getElementById('fillDiv').style.display="";
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
        //Commented by Yogesh J on 15-Jan-2016
        //objContextMenu.style.left = intX - 450 + "px";
        objContextMenu.style.left = intX  + "px";
        //End of comment by Yogesh J 
        objContextMenu.style.top = intY  + "px";
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}
function SubmitOK_Onclick()
{
    var objFeedBack = GetObjectReference('frmRequestList','cboFeedback');
    var objFeedBackComments = GetObjectReference('frmRequestList','txtFeedbackComments');    
    var objFeedBackDiv = GetObjectReference('frmRequestList','cboFeedbackDiv');
    var objFeedBackCommentsDiv = GetObjectReference('frmRequestList','txtSubmitCommentsDiv');
    var objDiv = GetObjectReference('frmRequestList','DivFeedBack');
    
     if(Trim(objFeedBackCommentsDiv.value) == '')
     {
        alert('Please Enter Feedback comments');
        return;
     } 
     
    //objFeedBack.value = objFeedBackDiv.value;
    //objFeedBackComments.value = objFeedBackCommentsDiv.value;
        
     
    objDiv.style.display  = 'none';
    document.getElementById('fillDiv').style.display="none";
       
    
     SaveData(FeedBackQueryID,'1')
     
     //objcboRequestType.style.visibility = '';
     //objcboSubRequestType.style.visibility = '';
}
function Cancel_OnClick()
{    
   /*  var objOldStatus = GetObjectReference('frmRequestList','hidoldStatusID');
     var objNewStatus = GetObjectReference('frmRequestList','cboStatus');
     // GetObjectReference('frmRequestList','hidStatus'+QueryID).value =  ID;
    var objOldStatusChangeDate=window.document.forms['frmRequestList'].elements['txtchangedDatehidden1'];
    var objOldStatusChangeTime=window.document.forms['frmRequestList'].elements['txtchangedTimehidden1'];
	var objWhizStatusDate = GetObjectReference('frmRequestList','FFE29587WHIZ_txtchangedDate');				 					 
	var objOldStatusChangeDate_Control=window.document.forms['frmRequestList'].elements['FFE29587WHIZ_txtchangedDatehidden1'];
	
	var objCurrentChangeDate = GetObjectReference('frmRequestList','txtchangedDate');
	var objCurrentChangeTime = GetObjectReference('frmRequestList','txtchangedTime');
		*/			 
    
    //objcboRequestType.style.visibility = '';
    //objcboSubRequestType.style.visibility = '';
    //objCurrentChangeDate.value = objOldStatusChangeDate.value;
    //objCurrentChangeTime.value = objOldStatusChangeTime.value;
    //objNewStatus.value = objOldStatus.value;
    //objWhizStatusDate.value=objOldStatusChangeDate_Control.value 
    objFeedBackDiv = GetObjectReference('frmRequestList','DivFeedBack');
    objFeedBackDiv.style.display  = 'none';
    document.getElementById('fillDiv').style.display="none";
    
    
}


//Added by Amit Mahadik on 19 August 2011 PMLifeLine (FAQ)
function Faq_OnClick(DeptMode,UserID,DepartmentName)
{
    window.open("../CRM/FrequentlyAskQuestions_CommonList.aspx?MasterTagId=9017&Mode=RO&QueryID=NULL&DeptFlag=" + DeptMode + "&eid="+ UserID +"&DepartmentName="+ DepartmentName +"  ","FAQ","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
}
//End Added by Amit Mahadik on 19 August 2011 PMLifeLine (FAQ)

 </script>
</body>
</HTML>
