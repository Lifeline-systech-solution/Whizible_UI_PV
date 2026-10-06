<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DM_WorkFlowApprovals.aspx.vb" Inherits="PbNIT.DM_WorkFlowApprovals"%>
<HTML>
	<%DrawHeader%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    .footerMenuTable
    {
        position: relative;
    }
     /*Cmmented added by Shamkant S on  23 Nov 2015*/
     #txtPageNumber 
    {
        height:20px;
        
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {

        //Added By Dipali V On 1st Feb 2021 For Session Project Issues
        var ProjectName = '<%= Session("strProjectName") %>';
       
        if (ProjectName != "") {
            var HeaderCaption = $(parent.document.getElementById('mainHeadingProject'));
            HeaderCaption.text("");
            HeaderCaption.append(" Project : " + ProjectName);
            HeaderCaption.append(' <i class="fa fa-key" onclick="SetDefaultProject()" title="Set as default project" style="cursor:pointer;"></i>');
        }
      //End of Added By Dipali V On 1st Feb 2021 For Session Project Issues
                    
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
        //Commented And Added By Vaijat k ON 02/11/2015 Purpose: Custom Page Responsive
        //if ($('.clsgridtable').length > 0) {
        //    var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //}
        if ($('.clsBody').find('#frmDM_WorkFlowApprovals').find('#DivList').length > 0) {
            var divName = $('.clsBody').find('#frmDM_WorkFlowApprovals').find('#DivList').attr('id');
            dataCollapse(divName);
        }
        //End Added By Vaijat k ON 02/11/2015 Purpose: Custom Page Responsive
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmDM_WorkFlowApprovals" method="post" runat="server">
			<%PageInit%>
		</form>
		<SCRIPT language="javascript">
		 var objform=GetFormReference('frmDM_WorkFlowApprovals');
		 var objdivlist=GetObjectReference('frmDM_WorkFlowApprovals','DivList');
		 var objDivPopup=document.getElementById("divMNPopup");
		 
		var objNoOfPages = GetObjectReference('frmInitiateCompensation','hidNoOfPages');
		var objPageNumber =  GetObjectReference('frmInitiateCompensation','txtPageNumber');
	     
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		
		var isClickImagePopup = false;
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;
				}
				else
				{  
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop -15;
				}
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;	
			}
			document.onmousedown =function(evt){
 			if(!isClickImagePopup){
 			    objDivPopup.style.display="none"; 
				isClickImagePopup=false;
				}
			}
			document.onmousemove=function(evt){
			isClickImagePopup =false;}
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;
				}
				else
				{  
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 15;
				}
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;	
			}
		}	
		function EntityList_OnChange()
		{
				objform.action = "DM_WorkFlowApprovals.aspx";  
				objform.submit();
		
		}
		
		
		function FilterField_OnChange(strFilter)
		{ 
		    var strPagePath=(arguments.length>1)?arguments[1]:"../DM/DM_WorkFlowApprovals.aspx";
		    if (strFilter == 'opt')
			{
				objform.action = strPagePath;
				objform.submit(); 
			}
		}

        //Addition by SuchitraP on 24-July-2008 for CRM Workflow
        
        function CRMFilterField_OnChange(strFilter,strFromWhere)
        {
           //if(strFromWhere == 'CRM')
           //{   
                //var strPagePath="../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=20023";
                var strPagePath="../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035";
           //}
             
              if(!validateNumPaging())
			    return;
			        
            if (strFilter == 'opt')
			{
				objform.action = strPagePath;
				objform.submit(); 
			}
        }
        
        function SubmitterSelection()
        {
            var objSubmitter = GetObjectReference('frmDM_WorkFlowApprovals','CBO_Submitter');
            if(objSubmitter)
            { 
                window.open ("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=3936&FromWhere=RM", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
            }
        }
        
        function Show_Onclick()
        {
            
            var objProcedureTitle=GetObjectReference('frmDM_WorkFlowApprovals','TXT_KnowledgeManagement');
            var objSubject=GetObjectReference('frmDM_WorkFlowApprovals','TXT_Subject');
            var objSubmittedFrom=GetObjectReference('frmDM_WorkFlowApprovals','DT_SubmittedFrom');
            var objSubmittedTo=GetObjectReference('frmDM_WorkFlowApprovals','DT_SubmittedTill');
            var objWorkflow=GetObjectReference('frmDM_WorkFlowApprovals','CBO_Workflow');
		    var objWorkflowName=objWorkflow[objWorkflow.selectedIndex].text;
		    var objSubmitter=GetObjectReference('frmDM_WorkFlowApprovals','CBO_Submitter');
		    var objSubmitterName=objSubmitter[objSubmitter.selectedIndex].text;
		    if(objSubmittedFrom.value=='' && objSubmittedTo.value!='')
		    {
		        alert('Submitted From Date should not be blank..');
		        setFocus(objSubmittedFrom);
		        return;
		    }
		    if(objSubmittedTo.value=='' && objSubmittedFrom.value!='')
		    {
		        alert('Submitted To Date should not be blank..');
		        setFocus(objSubmittedTo);
		        return;
		    }
		    
		     if(!validateNumPaging())
			    return;
			    
			objform.action ="../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035&Workflow=<%=m_strWorkflow%>&WorkflowName="+objWorkflowName+"&Subject="+objSubject.value+"&SubmittedFrom="+objSubmittedFrom.value+"&SubmittedTo="+objSubmittedTo.value+"&Submitter=<%=m_strSubmitter%>&SubmitterName="+objSubmitterName; 
			objform.submit();     
        }
        
        function PublishKM_OnClick()
        {
                window.open("../General/CommonList.aspx?MasterTagID=8034", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 1150)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=1150,height=600");    
        }
        //End by SuchitraP
        
		function textSearch_OnKeyPress(e)
		{
			var code;
			//Addition by SuchitraP on 24-July-2008 for CRM workflow
			var objtxtEntityID=GetObjectReference('frmDM_WorkFlowApprovals','txtEntityID');
		    //if(objtxtEntityID.value == '20023')
		    if(objtxtEntityID.value == '8035')
			{
			    //var strPagePath="../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=20023";
			    var objWorkflow=GetObjectReference('frmDM_WorkFlowApprovals','CBO_Workflow');
		        var objWorkflowName=objWorkflow[objWorkflow.selectedIndex].text;
			    var strPagePath="../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035&Workflow=<%=m_strWorkflow%>&WorkflowName="+objWorkflowName;  
			    if (e.keyCode) code = e.keyCode;
				else if (e.which) code = e.which;
				if(code==13) {
					objform.action = strPagePath;
					objform.submit(); 
					}
			}
			else
			{
			//End by SuchitraP
        	    var strPagePath=(arguments.length>1)?arguments[1]:"../DM/DM_WorkFlowApprovals.aspx";
        	    if (e.keyCode) code = e.keyCode;
			    else if (e.which) code = e.which;
			    if(code==13) {
				    objform.action = strPagePath;
				    objform.submit(); 
			        }
        	}
			

		}
		
		var ShowFilter='0';
		function showFilters(show)
		{
		    var objtxtEntityID=GetObjectReference('frmDM_WorkFlowApprovals','txtEntityID');
		    //if(objtxtEntityID.value == '20023')
		    if(objtxtEntityID.value == '8035')
			{
			    return;
			    objtblFilter = GetObjectReference('frmDM_WorkFlowApprovals','tblFilter');
				//objcboEntityList = GetObjectReference('frmDM_WorkFlowApprovals','cboEntityList');
				objimgFilter =GetObjectReference('frmDM_WorkFlowApprovals','imgFilter');
				img1='../../Images/cssImages/Link images/close.gif';
				img2='../../Images/cssImages/Link Images/Filter.gif';    

				if (ShowFilter=='0')
				{
				//objcboEntityList.style.visibility = "hidden";
				objtblFilter.style.top=25;
				objtblFilter.style.left=0;
				objtblFilter.zIndex=99;
				objtblFilter.style.display='';
				objimgFilter.src=img1;
				objimgFilter.alt='Hide filter'
				ShowFilter='1';

				}
				else if(ShowFilter=='1')
				{
				objtblFilter.style.display='none';
				//objcboEntityList.style.visibility ="visible";
				objimgFilter.src=img2;
				ShowFilter='0';    
				objimgFilter.alt='Show filter' ;
				}
			}
			else
			{
		        objtblFilter = GetObjectReference('frmDM_WorkFlowApprovals','tblFilter');
		        objcboEntityList = GetObjectReference('frmDM_WorkFlowApprovals','cboEntityList');
			    objimgFilter =GetObjectReference('frmDM_WorkFlowApprovals','imgFilter');
			    img1='../../Images/cssImages/Link images/close.gif';
			    img2='../../Images/cssImages/Link Images/Filter.gif';    

			    if (ShowFilter=='0')
			    {
			    objcboEntityList.style.visibility = "hidden";
			    objtblFilter.style.top=25;
			    objtblFilter.style.left=0;
			    objtblFilter.zIndex=99;
			    objtblFilter.style.display='';
			    objimgFilter.src=img1;
			    objimgFilter.alt='Hide filter'
			    ShowFilter='1';

			    }
			    else if(ShowFilter=='1')
			    {
			    objtblFilter.style.display='none';
			    objcboEntityList.style.visibility ="visible";
			    objimgFilter.src=img2;
			    ShowFilter='0';    
			    objimgFilter.alt='Show filter' ;
			    }
			}
		}
		function applyFilter()
		{
		    var objtxtEntityID=GetObjectReference('frmDM_WorkFlowApprovals','txtEntityID');
			//if(objtxtEntityID.value == '20023')
			if(objtxtEntityID.value == '8035')
			{
				//objform.action = "DM_WorkFlowApprovals.aspx?EntityID=20023";  
				objform.action = "DM_WorkFlowApprovals.aspx?EntityID=8035";  
				objform.submit();
			
			}
			else
			{
			    objform.action = "DM_WorkFlowApprovals.aspx";  
			    objform.submit();
			}
		}

		function ClearFilter()
		{
		   //Addition by SuchitraP on 24-July-2008 for CRM workflow
		    var objtxtEntityID=GetObjectReference('frmDM_WorkFlowApprovals','txtEntityID');
			//if(objtxtEntityID.value == '20023')
			if(objtxtEntityID.value == '8035')
			{
		        //objform.action =  "DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=20023&Mode=CLEAR_FILTER";  
		        objform.action =  "DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035&Mode=CLEAR_FILTER";  
			    objform.submit();
		    }
		    else
		    {
		    //End by SuchitraP
			    objform.action =  "DM_WorkFlowApprovals.aspx?Mode=CLEAR_FILTER";  
			    objform.submit();
			}
			
		}
		var strPrimaryKey = "",strPageName="",strPKToken="",strInstanceID="",strWFPrimaryKey="",strProjectID="";
		var strAttributeName = "",strRowNumber = "",strQueryID="";
		
		var ie5=document.all&&document.getElementById
        var ns6=document.getElementById&&!document.all
    
		function ShowPopup(evt,PrimaryKey,PageName,PKToken,InstanceID,WFPrimaryKey,ProjectID,QueryID)
		{       
				isClickImagePopup				= true;
				strPrimaryKey					= PrimaryKey;
				strPageName						= PageName;
				strPKToken						= PKToken;
				strInstanceID					= InstanceID;
				strProjectID					= ProjectID;
				strQueryID                      = QueryID
				strWFPrimaryKey					= WFPrimaryKey;
				evt								= evt||window.event;
				objDivPopup.style.display		= "block";
				//mouseXY							= mouseCoords(evt);
				/*objDivPopup.style.left = mouseXY.x;
				objDivPopup.style.top = mouseXY.y;*/
				
            showmenuie(objDivPopup, evt)
            
		}
		function showmenuie(objdiv,objevent){

//var objdiv = GetObjectReference('',divCM);

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

    if (objDivH > 200)
        objDivH=200;
              
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
                 
  
  return false;
  
   }
   
		function mouseCoords(ev)
		{
			if(ev.pageX || ev.pageY){
			return {x:ev.pageX, y:ev.pageY};
			}
			return {
				x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
				y:ev.clientY + document.body.scrollTop  - document.body.clientTop
			};
		}
		function mouseOverPopupMenu(evt)
		{
		    //alert(source.parentNode);
			evt = evt || window.event;
			var source = evt.target || evt.srcElement;
			
			var objTblMN= source;
			while(objTblMN.tagName != "TABLE")
			objTblMN=objTblMN.parentNode;
			
			while(source.tagName != "TR")
			source=source.parentNode;

			for(c=0;c<objTblMN.rows.length;c++){
			objTblMN.rows[c].className="clsTROdd";
			
			}
				source.className="clsTRColumnHeader";
				source.style.cursor="pointer";
		      
		}
            //added by Nilesh g on 22/1/2015 for URL security Link
		function GenrateToken_mouseDownPopupMenu(strWFPrimaryKey) {
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'DM_WorkFlowApprovals.aspx/GenrateURLToken1',
		        //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
		        //data: JSON.stringify({ strWFPrimaryKey: strWFPrimaryKey }),
		        data: JSON.stringify({ WFInstanceID: strWFPrimaryKey, EmployeeID: "<%=Session("intUserID")%>" }),
		        //End of Addition by Dhanashri S on 11 Aug 2016
		        success: function (Result) {

		            window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID=" + strWFPrimaryKey + "&PKToken=" + Result.d + "&ForWorkflowFrom=WF&EmployeeID=<%=Session("intUserID")%>", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=910,height=600");
		        },
		        error: function () {
		        //    alert("Error")
		        }
		    });

		}
		    //endded by Nilesh g on 22/1/2015 for URL security Link
		 function mouseDownPopupMenu(AttributeName,RowNumber)
		{
		   
		        
		 		strAttributeName					= AttributeName;
				strRowNumber						= RowNumber;
	
			if (strProjectID=="-1")
			{
					switch(strRowNumber)
					{
                        case 1:
                            //alert(1);
							window.open(strPageName+"&FromWhere=CRM&FromCL=1&" + strAttributeName + "_PK=" + strPrimaryKey + "&PKToken=" + strPKToken+"&FromWorkFlow=1&QueryID=" + strQueryID + "&ForWorkflowFrom=WF" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=1000,height=600");
                            //Added By Dipali V On 1st Feb 2021 For Session Project Issues
                             window.location.reload();
                            //window.open("../../Source/General/Navigation.aspx?FromWhere=PM&FromOld=3936&FromWhereProjectId=" + strPrimaryKey + "&FromWhereData=C&PKToken=" + strPKToken + "&Mode=Edit", "_top");
                           //End of Added By Dipali V On 1st Feb 2021 For Session Project Issues
				   
                            //window.location.href = strPageName+"&FromWhere=CRM&FromCL=1&" + strAttributeName + "_PK=" + strPrimaryKey + "&PKToken=" + strPKToken+"&FromWorkFlow=1&QueryID=" + strQueryID + "";
							break;
						case 2:
                            //Commented and added by Nilesh g on 22/1/2016 for URL Issue
						    //window.open("../WorkFlow/WorkflowInfo.aspx?MasterTagID=1887&ParentTagID=0&WebFormID=3929&PrimaryKeyName=WorkflowInstanceID&InstanceID=" + strInstanceID + "&PrimaryKey=" + strWFPrimaryKey ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 725)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=725,height=500");
							//window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID="+strWFPrimaryKey+"&ForWorkflowFrom=WF","","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=910,height=600");	
						    GenrateToken_mouseDownPopupMenu(strWFPrimaryKey);
						    //end of Commented and added by Nilesh g on 22/1/2016 for URL Issue

						    break;

					}
				//window.open(strPageName+"&FromWhere=CB&" + strAttributeName + "_PK=" + strPrimaryKey + "&PKToken=" + strPKToken ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 725)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=725,height=500");
			}
			else
			{
			    var url = "DM_WorkFlowApprovals.aspx?Mode=SESSION_PROJECT";
			    var reqQuery = "ProjectID=" +strProjectID;
			
                loadXMLDoc(url, reqQuery);
               
			}

			//objform.action ="DM_WorkFlowApprovals.aspx?Mode=SESSION_PROJECT&ProjectID="+strProjectID;  
			//objform.submit(); 
		  	
	          
		 }
		 function ShowDetails(WFInstanceID,TagID,UniqueID)
		 {
		    //Commented and ADDED BY NILESH G ON 20/1/2016 FOR SECURITY URL ISSUE
		     //window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID="+WFInstanceID+"&TagID="+TagID+"&UniqueID="+UniqueID,"","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=910,height=600");	
		     GenrateToken(WFInstanceID, TagID, UniqueID);
		    
		 }
		    //Added by Nilesh Gundecha on 19/1/2015 for URL blocking issue

		 //added by Nilesh g on 22/1/2016 for URL Issue
		 function GenrateToken(WFInstanceID, TagID, UniqueID) {
		     $.ajax({
		         type: 'POST',
		         dataType: 'json',
		         contentType: 'application/json',
		         url: 'DM_WorkFlowApprovals.aspx/GenrateURLToken',
                 //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
		         //data: JSON.stringify({ WFInstanceID: WFInstanceID, TagID: TagID, UniqueID: UniqueID }),
		         data: JSON.stringify({ UniqueID: UniqueID, EmployeeID: "<%=Session("intUserID")%>", TagID: TagID, WFInstanceID: WFInstanceID }),
                 //End of Addition by Dhanashri S on 11 Aug 2016
		            success: function (Result) {
		               
		                OpenPage1(Result.d, WFInstanceID, TagID, UniqueID);
                  },
		            error: function () {
		              //  alert("Error")
		            }
		        });
            
		 }
		    //endded by Nilesh g on 22/1/2016 for URL Issue
        function OpenPage1(Result, WFInstanceID, TagID, UniqueID) {
		 
            window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID=" + WFInstanceID + "&PKToken=" + Result + "&TagID=" + TagID + "&UniqueID=" + UniqueID + "&EmployeeID=<%=Session("intUserID")%>&ForWorkflowFrom=flag", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=910,height=600");
               // window.open("CRM_RequestAssignment.aspx?Mode=ASSIGN_REQUESTS&QueryID=" + QueryID + "&PKToken=" + Result, "_Assignment", "resizable=yes,scrollbars=no,width=550,height=300");
            }
            //endded by Nilesh Gundecha on 19/1/2015 for URL blocking issue
	
		function ShowPreviousPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
    			
			    if (objPageNumber.value==1){alert("This is the first page");return;}
				    objPageNumber.value = parseInt(objPageNumber.value) -1;
			            Page_OnClick(objPageNumber.value);
		    }
    			
	    }
	    function ShowFirstPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==1){alert("This is the first page");return;}
			    objPageNumber.value = 1;
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    function ShowNextPage()
	    {
	        
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==parseInt(objNoOfPages.value)){alert("This is the last page");return;}
				    objPageNumber.value = parseInt(objPageNumber.value)+1
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    function ShowLastPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(parseInt(objNoOfPages.value));
		    else
		    {	
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==parseInt(objNoOfPages.value)){alert("This is the last page");return;}
			    objPageNumber.value=parseInt(objNoOfPages.value);
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    function Page_OnClick(Page)
	    {
	             objform.action = window.location.href;
                 objform.submit();
                
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
				  				
				    if (!disallowBlank(objPageNumber,"Please Enter Page number",true) && (!disallowNonNumeric(objPageNumber,"Please Enter numeric value for Page number",true)) && (!disallowNegativeNumeric(objPageNumber,"Please Enter positive integer value for Page number",true)) & (!disallowNonInteger(objPageNumber,"Please Enter positive integer value for Page number",true)))				
				    {
					    if (Number(objPageNumber.value) ==0)
					    {
						    alert("Page number should be greater than zero!");
						    return;
					    }
    					
					    if(Number(objPageNumber.value) > Number(parseInt(objNoOfPages.value)) ) 
					    {
						    alert("Page number should not be greater than " + parseInt(objNoOfPages.value));
						    return;
					    }
					    Page_OnClick(objPageNumber.value);
				    }
			    }
	    }
	
	    function validateNumPaging()
	    {

		    if(isNaN(Trim(objPageNumber.value)))
		    {
			    alert("Please enter numeric value");
			    objPageNumber.focus();
			    return false;
		    }
            //Added By Chakshuta H on 19th-Nov-2015 Purpose::QA issue fixing
		     if((objNoOfPages.value)==0 && (objPageNumber.value)>0)
		    {
			    alert("The page number should not be greater than the total pages.");
			    objPageNumber.focus();
			    return false;
		    }
            //End Of Addition By Chakshuta H on 19th-Nov-2015 Purpose::QA issue fixing
		    if(parseInt(objNoOfPages.value)<parseInt(objPageNumber.value))
		    {
			    alert("Please enter value within range of 1 to "+parseInt(objNoOfPages.value));
			     objPageNumber.focus();
			    return false;
		    }
            //Uncommented by Yogesh J on 24-Nov-2015
	        //return true;
		    return true;
	        //Ended by Yogesh J on on 24-Nov-2015 
	    }
	    
    function txtPageNumber_OnBlur(obj)
    {
    
       if(!validateNumPaging())
			    return;
		
		    
            }
            //Added by Usha Pandit On 02.12.2020 For opening correct popup on IE
            function state_changenew() {
                var Browser = isIE();
                if (g_objXHttp.readyState == 4) {
                    //debugger;
                    // Make sure request came back OK 
                    if (g_objXHttp.status == 200) {
                        //if (window.ActiveXObject)
                        if (Browser == 'IE') {
                            
                            //if (g_objXHttp.responseText != "")
                            //    ReloadFrames(g_objXHttp.responseText);
                           
                            switch (strRowNumber) {
                                case 1:
                                    //alert(2);
                                    window.open(strPageName + "&FromWhere=PM&" + strAttributeName + "_PK=" + strPrimaryKey + "&PKToken=" + strPKToken + "&ForWorkflowFrom=WF", "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 725) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=725,height=500");
                                     //Added By Dipali V On 1st Feb 2021 For Session Project Issues
                                     window.location.reload();
                                    // window.open("../../Source/General/Navigation.aspx?FromWhere=PM&FromOld=3936&FromWhereProjectId=" + strPrimaryKey + "&FromWhereData=C&PKToken=" + strPKToken + "&Mode=Edit", "_top");
                                   //End of Added By Dipali V On 1st Feb 2021 For Session Project Issues
				   
                                    break;
                                case 2:
                                    $.ajax({
                                        type: 'POST',
                                        dataType: 'json',
                                        contentType: 'application/json',
                                        url: 'DM_WorkFlowApprovals.aspx/GenrateURLToken1',
                                        data: JSON.stringify({ WFInstanceID: strWFPrimaryKey, EmployeeID: "<%=Session("intUserID")%>" }),
                                        success: function (Result) {

                                            //window.open("../WorkFlow/WorkflowInfo.aspx?MasterTagID=1887&ParentTagID=0&WebFormID=3929&PrimaryKeyName=WorkflowInstanceID&InstanceID=" + strInstanceID + "&PrimaryKey=" + strWFPrimaryKey ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 725)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=725,height=500");
                                            window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID=" + strWFPrimaryKey + "&ForWorkflowFrom=WF&EmployeeID=<%=Session("intUserID")%>&PkToken=" + Result.d, "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=910,height=600");
                                        },
                                        error: function () {
                                            alert("Error")
                                        }
                                    });
                                    break;

                            }
                        }
                        // code for Mozilla, etc.
                        else if (document.implementation && document.implementation.createDocument) {
                            xmlDoc = document.implementation.createDocument("", "", null);
                            xmlDoc.async = false;
                            if (Browser == 'FF')
                                xmlDoc.load(g_objXHttp.responseXML);
                        }
                        //Save the Result in a Global variable
                        strResult = g_objXHttp.responseText;
                    }
                    else {
                        //alert("Problem in saving data:" + xmlhttp.statusText)
                        alert("Problem in loading data, Please revisit the page");
                    }
                }
            }
            //End Of Added by Usha Pandit On 02.12.2020 For opening correct popup on IE
    
function loadXMLDoc(url,reqQuery)
{
   // debugger
    //Added by Usha Pandit On 02.12.2020 For opening correct popup on IE
    //var state_change;
    var Browser = isIE();
    if (Browser == 'IE') {
        g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
        g_objXHttp.onreadystatechange = state_changenew;
        //prepare the call, http method=GET, false=asynchronous call
        g_objXHttp.open("GET", url + "&" + reqQuery, true)
        g_objXHttp.send(false)


        //nv_ref
        //xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
        //xmlhttp.onreadystatechange = state_change;
        ////prepare the call, http method=GET, false=asynchronous call
        //xmlhttp.open("GET", url + "&" + reqQuery, true)
        //xmlhttp.send(false)
    }
    else {
        //End Of Added by Usha Pandit On 02.12.2020 For opening correct popup on IE
        // code for Mozilla, etc.
        if (window.XMLHttpRequest) {            
            xmlhttp = new XMLHttpRequest()
            xmlhttp.onreadystatechange = state_Change;
            if (ns) {
                xmlhttp.open("GET", url + "&" + reqQuery, true)
                xmlhttp.send(false)
            }
            else {
                xmlhttp.open("POST", url, true)
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(reqQuery)
            }
        }
        // code for IE
        else if (window.ActiveXObject) {            
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
            if (xmlhttp) {
                xmlhttp.onreadystatechange = state_Change
                xmlhttp.open("GET", url, true)
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(reqQuery)
            }
        }
    }
}

	    
function state_Change()
{
    
	// if xmlhttp shows "loaded"
	if (xmlhttp.readyState==4)
	{
	// if "OK"
		if (xmlhttp.status==200)
		{
			//alert(xmlhttp.responseText);
           // debugger;
            if (xmlhttp.responseText != "")
                //Commented by Usha Pandit On 02.12.2020 For opening correct popup on IE
			//ReloadFrames(xmlhttp.responseText);	
                //End Of Commented by Usha Pandit On 02.12.2020 For opening correct popup on IE
				//alert(strPageName);
	        switch(strRowNumber)
	        {
		        case 1:
		              // alert(3);
                    window.open(strPageName + "&FromWhere=PM&" + strAttributeName + "_PK=" + strPrimaryKey + "&PKToken=" + strPKToken + "&ForWorkflowFrom=WF", "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 725) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=725,height=500");
                    // window.location.reload();
                    //Added By Dipali V On 1st Feb 2021 For Session Project Issues
                     window.location.reload();
                    // window.open("../../Source/General/Navigation.aspx?FromWhere=PM&FromOld=3936&FromWhereProjectId=" + strPrimaryKey + "&FromWhereData=C&PKToken=" + strPKToken + "&Mode=Edit", "_top");
                 //End of Added By Dipali V On 1st Feb 2021 For Session Project Issues
				        break;
	            case 2:
	                $.ajax({
	                    type: 'POST',
	                    dataType: 'json',
	                    contentType: 'application/json',
	                    url: 'DM_WorkFlowApprovals.aspx/GenrateURLToken1',
	                    data: JSON.stringify({ WFInstanceID: strWFPrimaryKey, EmployeeID: "<%=Session("intUserID")%>" }),
	                    success: function (Result) {
	                        
				        //window.open("../WorkFlow/WorkflowInfo.aspx?MasterTagID=1887&ParentTagID=0&WebFormID=3929&PrimaryKeyName=WorkflowInstanceID&InstanceID=" + strInstanceID + "&PrimaryKey=" + strWFPrimaryKey ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 725)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=725,height=500");
	                        window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID="+strWFPrimaryKey+"&ForWorkflowFrom=WF&EmployeeID=<%=Session("intUserID")%>&PkToken=" + Result.d,"","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=910,height=600");	
	                    },
	                    error: function () {
	                        alert("Error")
	                    }
	                });
				        break;

	        }
			
					
		}
		else
		{
			//alert("Problem in saving data:" + xmlhttp.statusText)
			alert("Problem in loading data, Please revisit the page");
		}
	}
}

function ReloadFrames(strMainPage)
{
    try {
        //Commented and Added by PrashantSJ on 20th June 2008
        //Purpose: commented code won't be work on firefox or netscap.

        /*parent.frames['link'].document.location.reload();
        parent.frames['Main'].document.location.href =strMainPage;*/

        //Added and commented by PrashantSJ on 07th Sept 2009
        //alert(document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.forms(0).action);
        //Commented And Added By Usha Pandit On 13.10.2020 For javascript error
        //parent.parent.frames['link'].document.location.reload();
        if (parent.parent.frames['link'] != undefined) {
            parent.parent.frames['link'].document.location.reload();
        }
        else {
            parent.parent.frames['frmNewVersion'].document.location.reload();
        }
        //End Of Added By Usha Pandit On 13.10.2020 For javascript error on new tree

        //parent.parent.frames['Main'].document.location.reload();
        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.forms(0).submit();
        /*parent.document.getElementById("frmHome").action="../Home/Home.aspx?FromWhere=PM"; 
        parent.document.getElementById("frmHome").submit();*/
        //window.opener.opener.location.href=window.opener.opener.location.href;
        //window.parent.frames['frmMain'].frameElement.src='../DM/DM_WorkFlowApprovals.aspx?FromWhere=PM&MasterTagID=3936';
        //objform.action = "../General/Navigation.aspx?subPage=../Home/Home.aspx?FromWhere=PM"; 
        //Commented by Yogesh Jalamkar on 16-Aug-2016 For Pop up window is not coming in IE
        //   objform.submit();
        //End of addition by Yogesh Jalamkar on 16-Aug-2016

        /*document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=PM"; 
        document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=PM"; */
        //.href="../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=PM"; 
        //objform.action = "../General/Navigation.aspx?subPage=../Home/Home.aspx&"+strMainPage;  
        //parent.document.getElementById("frmHome").submit();

        //parent.parent.frames['Main'].document.location.href =strMainPage;

        //window.parent.document.frames['link'].location.reload();
        //window.parent.document.frames['Main'].location.href= strMainPage; 
        //End of addition by PrashantSJ on 20th June 2008
    }
    catch (ex) {
        alert(ex.message);
    }
}

					</SCRIPT>
		</body>
</HTML>
