<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ProjectDocuments.aspx.vb" Inherits="Whizible.PM_ProjectDocuments"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->	
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script> 

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

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

</script>--%>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
					<form id="frmProjectDocuments" name="frmProjectDocuments" method="post" encType="multipart/form-data"
						runat="server">
							<%PageInit()%>
					</form>
				
					<script language="javascript">
			var objdivlist;
			var objform;
			var strIsReview;				
			objform = GetFormReference('frmProjectDocuments');
			objdivlist = GetObjectReference('frmProjectDocuments','DivList');
            //Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
			objdivlistURL = GetObjectReference('frmProjectDocuments','divList');
            //End of Addition by Dhanashri S on 10 Dec 2015

			<%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
								
			'<%MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")%>';
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
				var intDivHeightRisk;
				strIsReview ='<%=Request.Querystring("IsReview")%>';
				//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				//'Modified by ShraddhaM on Date 06 Jully,2006 for PMLifeLine Issue ID.4168
			    //'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

            if(objdivlist!=null)
            {
                <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
                //Commented And Added By Vaijat K ON 30/11/2015
                //if(navigator.appName == 'Netscape')
                //{		  
                //    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
                //}
                //else
                //{
                //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
                //}
                //if (navigator.appName == 'Microsoft Internet Explorer') { 
                //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 46; 
                //}
                //else if (navigator.appName == 'Netscape') { 
                //    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46;
                //}
                //else { 
                //    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46; 
                //}
               
               
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 37; 
                //End Added By Vaijat K ON 30/11/2015
                 <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
				    if (intDivHeight < 100)
				        intDivHeight = 100; 
                <%'Commented And Edited  by KIRAN K K  For footer line alignment 16-11-15%>
                <%'objdivlist.style.height = intDivHeight;%>
                    objdivlist.style.height = intDivHeight+"px";	
                <%'Commented And Edited End by KIRAN K K  For footer line alignment 16-11-15%>
            }
			    //Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
			    if(objdivlistURL!=null)
			    {
			        var Mode = getParameterByName('Mode');
			        if(Mode=="UPLOAD")
			        {
			            intDivHeight = window.innerHeight - objdivlistURL.offsetTop - 47; 
			          
			        }
			        else
			        intDivHeight = window.innerHeight - objdivlistURL.offsetTop - 37; 
			        if (intDivHeight < 100)
			            intDivHeight = 100; 
			        objdivlistURL.style.height = intDivHeight + "px";	
			        
			    }
			    //End of Addition by Dhanashri S on 10 Dec 2015


            }
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
            if(objdivlist!=null)
            {
                <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
                //Commented And Added By Vaijat K ON 30/11/2015
                //if(navigator.appName == 'Netscape')
                //{		  
                //    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
                //}
                //else
                //{
                //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
                //}
                //if (navigator.appName == 'Microsoft Internet Explorer') { 
                //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 46; 
                //}
                //else if (navigator.appName == 'Netscape') { 
                //    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46;
                //}
                //else { 
                //    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46; 
                //}
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 37; 
                //End Added By Vaijat K ON 30/11/2015
                 <%'Commented And End Edited by KIRAN K K  For footer line alignment 16-11-15%>
				    if (intDivHeight < 100)
				        intDivHeight = 100;
                <%'Commented And Edited  by KIRAN K K  For footer line alignment 16-11-15%>
                <%'objdivlist.style.height = intDivHeight;%>
                objdivlist.style.height = intDivHeight+"px";	
                <%'Commented And Edited End by KIRAN K K  For footer line alignment 16-11-15%>      
				   
            }
			    //Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
			    if(objdivlistURL!=null)
			    {
			        var Mode = getParameterByName('Mode');
			        if(Mode=="UPLOAD")
			        {
			            intDivHeight = window.innerHeight - objdivlistURL.offsetTop - 47; 
			           
			        }
                    else
			        intDivHeight = window.innerHeight - objdivlistURL.offsetTop - 37; 
			        if (intDivHeight < 100)
			            intDivHeight = 100; 
			        objdivlistURL.style.height = intDivHeight + "px";	
			        
			    }
			    //End of Addition by Dhanashri S on 10 Dec 2015
            }
			function ListView_OnClick()
			{
				if ("<%=FromTimesheet%>"!="CreateTask")
				//Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                //Purpose : For paging and text search of a document.
				//objform.action = "PM_Projectdocuments.aspx?Mode=<%=CONST_MODE_LIST%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>";
				objform.action = "PM_Projectdocuments.aspx?Mode=<%=CONST_MODE_LIST%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>";
				//End By VarunA 0n 20-Jan-2009 RequestID-21539
				else
				    objform.action = "PM_Projectdocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_LIST%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>";
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.submit();
			}
			//Added by NitinC on 29 March 2011 for PMLifeLine
			function txtFileName_onkeydown() 
		    {
			    event.returnValue = false;	
		    }

		    function txtFileName_onbeforepaste() 
		    {
			    event.returnValue = false;	
		    }

		    function txtFileName_onpaste() 
		    {
			    event.returnValue = false;	
		    }
		    function RemoveAttachement(FileNO)
		    {
    		    //debugger;
			    var objTR = GetObjectReference('frmAttachment','FILENAME'+FileNO); 
			    var toRemoveFileControl = GetObjectReference('frmAttachment','txtFileName'+FileNO); 
			    var objFileGrid = GetObjectReference('frmAttachment','tblFiles'); 
    			
			    objFileGrid.deleteRow(objTR.rowIndex);
    			
			    toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
			    GetObjectReference('frmAttachment',"txtFileName"+FileCount).disabled=false;; 
    						   
			    if (objFileGrid.rows.length==1)
			    {

			       objFileGrid.style.display='none';
			    }
			       			
			    FileCount_toDisable--;
			    //FileCount--;
		    }
			//End of Added by NitinC on 29 March 2011 for PMLifeLine
			function DetailView_OnClick()
			{
				if ("<%=FromTimesheet%>"!="CreateTask")
				//Modified By VarunA 0n 20-Jan-2009 RequestID-21539
				    //Purpose : For paging and text search of a document.
                   
				   //objform.action = "PM_Projectdocuments.aspx?Mode=<%=CONST_MODE_DETAIL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>";
				    //Commented and added by Yogesh Jalamkar on 13-Aug-2016 for PKToken
				    //   objform.action = "PM_Projectdocuments.aspx?Mode=<%=CONST_MODE_DETAIL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>";
			           objform.action = "PM_Projectdocuments.aspx?Mode=<%=CONST_MODE_DETAIL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&PKToken=0";
				    //End of addition by Yogesh Jalamkar on 13-Aug-2016 for PKToken
				    //End By VarunA 0n 20-Jan-2009 RequestID-21539
				else
				  //  objform.action = "PM_Projectdocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_DETAIL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>";
			    objform.action = "PM_Projectdocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_DETAIL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&PKToken=0";
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
			    objform.submit();
			}
			function History_OnClick(DID,DRID)
			{
			  
			    //Commented and added by Yogesh J on 01-Feb-2016 to generate and pass Token
				//if(DRID != '0' && DRID != '')
				//	DID=DRID;
				//if ("<%=FromTimesheet%>"!="CreateTask")
			//	window.open("PM_ProjectDocuments.aspx?Mode=<%=CONST_MODE_HISTORY%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-600)/2 + ",width=500,height=600");
			//	else
			//	window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_HISTORY%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-600)/2 + ",width=500,height=600");
			    if(DRID != '0' && DRID != '')
			        DID=DRID; 
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'PM_ProjectDocuments.aspx/GenrateURLToken_Review_OnClick',
			        data: JSON.stringify({ DocumentID: DID, EmployeeID: "<%=Session("intUserID")%>",MasterTag: "<%=m_strMasterTagID%>"}),
			        success: function (Result) {   
			            //if(DRID != '0' && DRID != '')
			            //	DID=DRID;
			            if ("<%=FromTimesheet%>"!="CreateTask")
			            	window.open("PM_ProjectDocuments.aspx?Mode=<%=CONST_MODE_HISTORY%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&PKToken="+ Result.d +"&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-600)/2 + ",width=500,height=600");
			            	else
			                window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_HISTORY%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&PKToken="+ Result.d +"&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-600)/2 + ",width=500,height=600");
			        },
		     error: function () {
		       //  alert("Error")
		     }
		 });
			    //End of Addition by Yogesh J on 01-Feb-2016 to generate and pass Token
			}
			function Delete_OnClick()
			{
			    
				var intRowCnt,i,blnSelected=false,ans;
				var objChk;
				
				objChk = GetObjectReference('frmProjectDocuments','chkDelete',true);	
				intRowCnt = objChk.length;
				
				if(intRowCnt>0)
					for(i=0;i<intRowCnt;i++)
						if(objChk[i].checked==true)
							{
								blnSelected=true;
								break;  
							}

				if(blnSelected==false)
				{
					alert('<%=mybase.GetResourceString("MSG_NO_RECORD_SELECTED")%>');
					return;
				}
				
				ans = window.confirm('<%=mybase.GetResourceString("MSG_DELETE_CONFIRM")%>'); 
				//debugger;
				if(ans==true)
				{	if ("<%=FromTimesheet%>"!="CreateTask")
						{//Commented and Modified By JyotiG
						//Start_JG_12486_06-Apr-2007
						//objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&DocumentID=<%=m_strDocumentID%>&&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
						if (strIsReview =='Y')
							{objform.action="PM_ProjectDocuments.aspx?ParentToken=<%=m_strToken%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&DocumentID=<%=m_strDocumentID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";}
						else
						    //Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                            //Purpose : For paging and text search of a document.
							//{ objform.action="PM_ProjectDocuments.aspx?PkToken=<%=m_strToken%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&DocumentID=<%=m_strDocumentID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";}				
							{ objform.action="PM_ProjectDocuments.aspx?PkToken=<%=m_strToken%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&DocumentID=<%=m_strDocumentID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>";}				
							//End By VarunA 0n 20-Jan-2009 RequestID-21539
						//End_JG_12486_06-Apr-2007
						}
					else
						{	//Commented and Modified By JyotiG
							//Start_JG_12486_06-Apr-2007
							//objform.action="PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&DocumentID=<%=m_strDocumentID%>&&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
							objform.action="PM_ProjectDocuments.aspx?PkToken=<%=m_strToken%>&FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&DocumentID=<%=m_strDocumentID%>&&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
							//End_JG_12486_06-Apr-2007
				}
				    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
				    setFrameLoader();
				    //End of Addition by Dhanashri S on 12 Oct 2016
					objform.submit();
				}
			}
			function UploadDoc_OnClick()
			{
			   
				if ("<%=FromTimesheet%>"!="CreateTask")
				//Code modified By VidyaJ - Security issue - 6197
				//Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                //Purpose : For paging and text search of a document.
				//window.open("PM_ProjectDocuments.aspx?ParentTagID=0&Mode=<%=CONST_MODE_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_strProjectID%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
				    //window.open("PM_ProjectDocuments.aspx?ParentTagID=0&Mode=<%=CONST_MODE_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_strProjectID%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>","","resizable=yes,menubar=no,scrollbars=no,channelmode=yes"); // + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
				    //Commentd added by Shamkant S on 5 Dec 2015
                   
				   //window.open("PM_ProjectDocuments.aspx?ParentTagID=0&Mode=<%=CONST_MODE_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_strProjectID%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
				    window.open("PM_ProjectDocuments.aspx?ParentTagID=0&Mode=<%=CONST_MODE_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_strProjectID%>&PKToken=<%=m_PKToken%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");

				    //Commented Ended by Shamkant s on 5 Dec 2015
				//End By VarunA 0n 20-Jan-2009 RequestID-21539
				else
				    //Code modified By VidyaJ - Security issue - 6197
				    //window.open("PM_ProjectDocuments.aspx?ParentTagID=0&FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_strProjectID%>","","resizable=yes,menubar=no,scrollbars=no,channelmode=yes"); // + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
                    //Commentd added by Shamkant S on Dec 2015 -
				    window.open("PM_ProjectDocuments.aspx?ParentTagID=0&FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_strProjectID%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
						}


                        


						//Added by Parth.G
						var isValidFlag = false;
						async function forOnchange(file) {
                            //debugger
                            isValidFlag = false;
                            var Vfile = file
							var vflag = await validateForExe(Vfile);
                            if (vflag) {
								addFileinGrid();
                            }
                            
                        }

                        async function validateForExe(file) {
                            //debugger;
                            if (!file) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error("Please Select File");
                                return
                            }
                            //var fileData =file;
                            //console.log(fileData);
                            //added by Parth Godshelwar
                            var isValidTypeExeCheck;
                            var objFile = file;
                            var fileName = objFile.files[0].name;
                            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


							isValidTypeExeCheck = false;
                            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
                            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
                            isValidTypeExeCheck = ValidExtsExe.includes(extension);

							if (isValidTypeExeCheck) {
								const file = objFile.files[0];
								//await checkFileForExe(file);
								await validateDocFileForExe(file)
									.then(() => {
										//alertify.set('notifier', 'position', 'top-right');
										//alertify.success("File is valid and ready to upload.");
										alert("File is valid and ready to upload.");
										isValidFlag = true;
										//isValidFlag = true;
										//return true;
									})
									.catch(error => {
										console.log(error);
										//alertify.set('notifier', 'position', 'top-right');
										//alertify.error("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
										//alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
										alert("Upload restricted: This file contains an embedded executable (EXE) file.");
										isValidTypeExeCheck = false;
										//console.log($(objFile).val);
										$(objFile).val("");
										//console.log($(objFile).val);
										isValidFlag = false;
										/*$(objFileName).attr("placeholder", "Upload File");*/
										//showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
										//return false;
									});



								//if (!isValidTypeExeCheck) { }
								return isValidFlag;
							}
							else {
								return true;
							}
							//return isValidFlag;
							//
                            //$(objtxtFileName).val("");

                            //Ended by Parth Godshelwar

                        }


			async function Upload_OnClick()
			{
			    //debugger;
			    var strQueryString;
			    //var objtxtComments = GetObjectReference('frmAttachment','txtComments');
    			var i;
			    var objFileName 
    			var objcboCategory
    			var objcboSubCategory
			    var objcboChangeRequest
			    
			    var objtxthidcboCategory
			    var objtxthidcboSubCategory
			    var objtxthidcboChangeRequest
			    
			    var objFileGrid = GetObjectReference('frmAttachment','tblFiles');
			    objtxthidcboCategory = GetObjectReference('frmAttachment','txthidcboCategory'); 
			    objtxthidcboSubCategory = GetObjectReference('frmAttachment','txthidcboSubCategory'); 
			    objtxthidcboChangeRequest = GetObjectReference('frmAttachment','txthidcboChangeRequest'); 
			    
			    objtxthidcboCategory.value = ""
			    objtxthidcboSubCategory.value = ""
			    objtxthidcboChangeRequest.value = ""

              
			    
			    //Purpose : To attach a single file also. (Mozilla)
			    if (document.all)
			    {
			        if (objFileGrid.rows.length==1)
			        {
			         alert("Please select the file !")
			         return;
			        }
			    //Purpose : To attach a single file also. (Mozilla)
			    }
			    else
			    {
			        if (objFileGrid.rows.length==0)
			        {
			         alert("Please select the file !")
			         return;
			        }
                    //Added By Chakshuta H on 20th-Oct-2015 Purpose::Crash on Upload link
                    if (objFileGrid.rows.length==1)
			        {
			         alert("Please select the file !")
			         return;
			        }
                    //End of Addition By Chakshuta H on 20th-Oct-2015 Purpose::Crash on Upload link
				}


				
                
			    
			    for (i=0;i<FileCount;i++)
			    {
				    objFileName = GetObjectReference('frmAttachment','txtFileName'+i);
				    objcboCategory = GetObjectReference('frmAttachment','cboCategory'+i);
				    objcboSubCategory = GetObjectReference('frmAttachment','cboSubCategory'+i);
				    objcboChangeRequest = GetObjectReference('frmAttachment','cboChangeRequest'+i);
				    
				    if (objFileName!=null)
				    {
					    if (disallowBlank(objFileName,"Please select the file")	) {return;}
					    if (disallowSpecialCharacters(objFileName,'Special character # is not allowed',true,'#')) { return; }
				    }
				   
				    if (objcboCategory!=null)
					{
					    if (disallowBlank(objcboCategory,"Please select document category!")	) 
					    {
					        return;
					    }
					    else
					    {
					        objtxthidcboCategory.value = objtxthidcboCategory.value + "," + objcboCategory.value
					    }
					}
					//debugger;
					if (objcboSubCategory!=null)
					{
					    if (disallowBlank(objcboCategory,"Please select the file")	) 
					    {
					        return;
					    }
					    else
					    {
					        objtxthidcboSubCategory.value = objtxthidcboSubCategory.value + "," + objcboSubCategory.value
					    }
					}
					if (objcboChangeRequest!=null)
					{
					    if (disallowBlank(objcboCategory,"Please select the file")	) 
					    {
					        return;
					    }
					    else
					    {
					        objtxthidcboChangeRequest.value = objtxthidcboChangeRequest.value + "," + objcboChangeRequest.value
					    }
					}
			        //Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
					if (objFileName!=null)
					{ 
					   
					    var countOfDot, FileNameCharCount;
					    var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
						//Added By Usha Pandit on 09.01.2021 For MaxFileSize Declaration
                        var intMaxFileSize = '<%=ConfigurationManager.AppSettings("MaxFileSize")%>'
                        //End Of Added By Usha Pandit on 09.01.2021 For MaxFileSize Declaration
                        
					    var intActualFileSize = (objFileName.files['0'].size);

					    var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
					    var validateExtensions;

					    validateExtensions = strFileExtension.split(",");
					    if (strFileExtension.length > 0) {
					        var allowSubmit = false;
					        var file = objFileName.value;
					        var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();

					        for (var cnt = 0; cnt < validateExtensions.length ; cnt++) {
					            var strExtn;
					            strExtn = validateExtensions[cnt];
					            if (strExtn.toLowerCase() == extension)
					                //Commented and Added By Bharat Tekade on 9th-Jun-2016 for SEM Enhancement
					                //{ allowSubmit = false; }
					            { allowSubmit = true; }
					            //End of Commented and Added By Bharat Tekade on 9th-Jun-2016 for SEM Enhancement
					        }
					        if (allowSubmit == false) {
					            alert("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!");
					            return false;
					        }
					    }

					    if (objFileName.files['0'].name != '')
					        var countOfDot = objFileName.files['0'].name.split(".").length - 1;

					    if (countOfDot > 1) {
					        alert('File with two or more extensions is not allowed!');
					        return false;
					    }

					    if (objFileName.files['0'].name != '')
					        FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

					    if (FileNameCharCount > 120) {
					        alert('File name should not exceed 120 characters!');
					        return false;
					    }

					    if (intActualFileSize < intMinFileSize) {
					        alert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
					        return false;
					    }					     

                        //Added By Usha Pandit on 09.01.2021 For Excceded File size Validation 
                        if (intMaxFileSize < intActualFileSize) {
                            alert('File size should not be greater than or equal to ' + intMaxFileSize + ' bytes !');
                            ValidateAttachmentFlag = false;
                            return false;
                        }
                        //End Of Added By Usha Pandit on 09.01.2021 For Excceded File size Validation

					}
                    //End of Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement


                    //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
                    //var fileUpload = document.getElementById("txtFileName");
     //               var isValidTypeExeCheckFlag=false
     //               if (objFileName.value != "") {
     //                   var fileName = objFileName.value;
     //                   var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

     //                   //var objFileName = objFileName;
     //                   isValidTypeExeCheck = false;
     //                   const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
     //                   isValidTypeExeCheck = ValidExtsExe.includes(extension);

     //                   if (isValidTypeExeCheck) {
     //                       const file = objFileName.files[0];
     //                       //const error = await validateDocFileForExe(file);
     //                       //console.log(error);
     //                       //await checkFileForExe(file);
     //                       await validateDocFileForExe(file)
     //                           .then(() => {
     //                               alert('File is valid and ready to upload.');

     //                               isValidTypeExeCheckFlag = true
     //                           })
     //                           .catch(error => {
     //                               console.log(error);
     //                               alert('Upload restricted: The DOC file contains an embedded executable (EXE) file.');

     //                               isValidTypeExeCheck = false;
     //                               isValidTypeExeCheckFlag = false;
     //                               $(objtxtFileName).val("");
     //                               /*$(objFileName).attr("placeholder", "Upload File");*/
     //                               //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
     //                               return;
     //                           });



     //                       if (!isValidTypeExeCheck) {
     //                           return;
     //                       }
     //                   }

     //                   //$(objtxtFileName).val("");

     //                   //Ended by Parth Godshelwar
					//}
					//if (isValidTypeExeCheckFlag == false) {
					//	return false;
     //               }
     //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not


			    }
			    
			    objFileName = GetObjectReference('frmAttachment','txtFileName'+i);
			    if (objFileName !=null)
				    objFileName.disabled=true;
    		
			      			
			    if ("<%=FromTimesheet%>"!="CreateTask")
                    //Commented and Added by Yogesh Jalamkar on 13-Aug-2016
    			   // objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&FilterParameter="+escape('<%=Request.QueryString("FilterParameter")%>');
			      //  Added By Vidya J ON 1 Sep 2016 For HTMLENCODE
			        objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&FilterParameter="+escape('<%=Request.QueryString("FilterParameter")%>')+"&PKToken=<%=m_strToken%>";
			        //End of addition by Yogesh Jalamkar on 13-Aug-2016
			    else
			        //Commented and Added by Yogesh Jalamkar on 13-Aug-2016
				   // objform.action="PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
			        objform.action="PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>"+"&PKToken=<%=m_strToken%>";
			    //End of addition by Yogesh Jalamkar on 13-Aug-2016

			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016

			    objform.submit();

				
				
			    ///COMMENTED BY NITINC ON 01 APRIL 2011 FOR PMLifeLine
			    /*
				var objCbo,objTxt;
				var flag;
				
				objTxt = GetObjectReference('frmProjectDocuments','txtFileName');	
			flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_FILE_EMPTY")%>',true);
				if(flag==true)
					return;
					
									
				objCbo = GetObjectReference('frmProjectDocuments','cboCategory');	
				flag = disallowBlank(objCbo,'<%=MyBase.GetResourceString("MSG_CATEGORY_EMPTY")%>',true);
				if(flag==true)
					return;
					
				objTxt = GetObjectReference('frmProjectDocuments','txtDescription');	
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DESC_EMPTY")%>',true);
				if(flag==true)
					return;
					
				flag = disallowMaxlengthViolation(objTxt,3000,'<%=MyBase.GetResourceString("MSG_DESC_MAX_LEN")%>',true);
				if(flag==true)
					return;
				
				/// Added by Archanan on 1-Oct-2010
                    if ('<%=m_strExtensionList%>'!='')
                    {
			            if (ValidateFileExtensions('frmProjectDocuments','txtFileName','<%=m_strExtensionList%>')==false)
			                return;
                    }
			    /// End of Added by Archanan on 1-Oct-2010

				
				var objTbl = GetObjectReference('frmProjectDocuments','tblMsg');	
				objTbl.style.display='';
				document.body.style.cursor = "wait";
				//	Modified By		: NitinVS on 8 March 2005 for PBNITE SP2 
				//	Purpose			: To Send The UniqueID of the Parent Page as Querystring parameter
				
				//objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>";
				if ("<%=FromTimesheet%>"!="CreateTask")
				//Commented and modified by MonikaI on 4th Oct 2006 IssueID : 6636
				//objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
				//Modified & Commented By VarunA on 26-Feb-2008 IssueID-19003
				//Purpose : For not to having Assign Resource and Delete Resouce link, while editing a task in Risks
				//objform.action="PM_ProjectDocuments.aspx?PageType=<%=m_strPageType%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
				//End by MonikaI
				//Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                //Purpose : For paging and text search of a document.
				//objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&FilterParameter="+escape('<%=Request.QueryString("FilterParameter")%>');
				objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&FilterParameter="+escape('<%=Request.QueryString("FilterParameter")%>');
				//End By VarunA 0n 20-Jan-2009 RequestID-21539
				//End By VarunA on 26-Feb-2008 IssueID-19003
				else
				objform.action="PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_UPLOAD%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
				// End Modification By NitinVS on 8 March 2005 
				objform.submit();
			    */
				///END OF COMMENTED BY NITINC ON 01 APRIL 2011 FOR PMLifeLine
			}
			function Review_OnClick(DID)
			{
                //Commented and Added by Yogesh J on 01-Feb-2016 to generate and pass Token
				//if ("<%=FromTimesheet%>"!="CreateTask")
				//Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                //Purpose : For paging and text search of a document.
				//window.open("PM_ProjectDocuments.aspx?Mode=<%=CONST_MODE_REVIEW%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
			//	window.open("PM_ProjectDocuments.aspx?Mode=<%=CONST_MODE_REVIEW%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
				//End By VarunA 0n 20-Jan-2009 RequestID-21539
			//	else
		//		window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_REVIEW%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'PM_ProjectDocuments.aspx/GenrateURLToken_Review_OnClick',
			        data: JSON.stringify({ DocumentID: DID, EmployeeID: "<%=Session("intUserID")%>",MasterTag: "<%=m_strMasterTagID%>" }),
			        success: function (Result) {   
			            if ("<%=FromTimesheet%>"!="CreateTask")
			            window.open("PM_ProjectDocuments.aspx?Mode=<%=CONST_MODE_REVIEW%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&PKToken="+ Result.d +"&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
			            else
			                window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_REVIEW%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&PKToken="+ Result.d +"&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
			        },
			        error: function () {
			         //   alert("Error")
			        }
			    });
			    //End of Addition by Yogesh J on 01-Feb-2016 to generate and pass Token

			}
			function ReviewSave_OnClick()
			{
				var objTxt;
				var flag;
				
				objTxt = GetObjectReference('frmProjectDocuments','txtComments');	
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_COMMENTS_EMPTY")%>',true);
				if(flag==true)
					return;
					
				flag = disallowMaxlengthViolation(objTxt,500,'<%=MyBase.GetResourceString("MSG_COMMENTS_MAX_LEN")%>',true);
				if(flag==true)
					return;	
				if ("<%=FromTimesheet%>"!="CreateTask")
		//Commented and modified by MonikaI on 27-Sep-2006 IssueID : 6460
					//objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=<%=m_strDocumentID%>&UniqueID=<%=m_intUniqueID%>";
					//Modified By VarunA on 27-Feb-2008 IssueID-19003
					//Purpose : To have persist as case1, while editing in review it is changed to Case2 task (means Assign & Delete Resource Link is visible)
					//objform.action="PM_ProjectDocuments.aspx?PageType=<%=m_strPageType%>&ParentToken=<%=m_strParentToken%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=<%=m_strDocumentID%>&UniqueID=<%=m_intUniqueID%>";
					//Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                    //Purpose : For paging and text search of a document.
					//objform.action="PM_ProjectDocuments.aspx?PageType=<%=m_strPageType%>&ParentToken=<%=m_strParentToken%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=<%=m_strDocumentID%>&UniqueID=<%=m_intUniqueID%>&FilterParameter="+escape('<%=Request.QueryString("FilterParameter")%>');
					objform.action="PM_ProjectDocuments.aspx?PageType=<%=m_strPageType%>&ParentToken=<%=m_strParentToken%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=<%=m_strDocumentID%>&UniqueID=<%=m_intUniqueID%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&FilterParameter="+escape('<%=Request.QueryString("FilterParameter")%>');
					//End By VarunA 0n 20-Jan-2009 RequestID-21539
					//End By VarunA on 27-Feb-2008
				else
					//objform.action="PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=<%=m_strDocumentID%>&UniqueID=<%=m_intUniqueID%>";
					objform.action="PM_ProjectDocuments.aspx?ParentToken=<%=m_strParentToken%>&FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=<%=m_strDocumentID%>&UniqueID=<%=m_intUniqueID%>";
			    //End of modification by MonikaI
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016

				objform.submit();
			}
			function AttachURL_OnClick()
			{
				if ("<%=FromTimesheet%>"!="CreateTask")
				//Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                //Purpose : For paging and text search of a document.
				//window.open("PM_ProjectDocuments.aspx?Mode=<%=CONST_MODE_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
				    window.open("PM_ProjectDocuments.aspx?Mode=<%=CONST_MODE_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&PKToken=<%=str_Token%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
				//End By VarunA 0n 20-Jan-2009 RequestID-21539
				else
				window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=CONST_MODE_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
			}
			function Attach_OnClick()
			{
				var objCbo,objTxt;
				var flag;
				
				objTxt = GetObjectReference('frmProjectDocuments','txtURL');	
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_URL_EMPTY")%>',true);
				if(flag==true)
					return;
					
				flag = IsValidURL(objTxt.value);
				if(flag==false)
				{
					alert('<%=MyBase.GetResourceString("MSG_INVALID_URL")%>');
					flag=true;
					objTxt.focus();
					return;
                }
                //Added By Rutuja D. on 9 April 2020 IssueID = 23247
                else {            
                    var str = objTxt.value;
                    if (str.charAt(0) != 'h' && str.charAt(0) != 'H') {
                        alert('<%=MyBase.GetResourceString("MSG_INVALID_URL")%>');
					flag=true;
					objTxt.focus();
					return;
                    }
                //End Added By Rutuja D. on 9 April 2020 IssueID = 23247
                    
            
        }
				
				objCbo = GetObjectReference('frmProjectDocuments','cboAttachCategory');	
				flag = disallowBlank(objCbo,'<%=MyBase.GetResourceString("MSG_CATEGORY_EMPTY")%>',true);
				if(flag==true)
					return;
					
				objTxt = GetObjectReference('frmProjectDocuments','txtDescription');	
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DESC_EMPTY")%>',true);
				if(flag==true)
					return;
					
				flag = disallowMaxlengthViolation(objTxt,3000,'<%=MyBase.GetResourceString("MSG_DESC_MAX_LEN")%>',true);
				if(flag==true)
					return;
				if ("<%=FromTimesheet%>"!="CreateTask")
				//Commented and modified by MonikaI on 4th Oct 2006 IssueID : 6636
					//objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
					//Modified & Commented By VarunA on 26-Feb-2008 IssueID-19003
					//Purpose : For not to having Assign Resource and Delete Resouce link, while editing a task in Risks
					//objform.action="PM_ProjectDocuments.aspx?PageType=<%=m_strPageType%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
					//End by MonikaI
					//Modified By VarunA 0n 20-Jan-2009 RequestID-21539
                    //Purpose : For paging and text search of a document.
					//objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&FilterParameter="+escape('<%=Request.QueryString("FilterParameter")%>');
					objform.action="PM_ProjectDocuments.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>&PagingAlphabet=<%=m_strAlphabet%>&TextSearch=<%=HttpUtility.HtmlEncode(m_strtxtSearch)%>&CategoryID=<%=m_strDocumentcategoryID%>&SubCategoryID=<%=m_strsubCategoryID%>&FilterParameter="+escape('<%=Request.QueryString("FilterParameter")%>');
					//End By VarunA 0n 20-Jan-2009 RequestID-21539
					//End By VarunA on 26-Feb-2008 IssueID-19003
				else
				    objform.action="PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&UniqueID=<%=m_intUniqueID%>";
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.submit();
			}		
			function Download_OnClick(DID)
			{	if ("<%=FromTimesheet%>"!="CreateTask")
				window.open("PM_ViewDocument.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=" + DID ,"","left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
				else
				window.open("PM_ViewDocument.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=" + DID ,"","left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
			}
			function Document_OnClick(DID)
			{	
			
			    if ("<%=FromTimesheet%>"!="CreateTask")
				window.open("PM_ViewDocument.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=" + DID ,"","left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
				else
				window.open("PM_ViewDocument.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentID=" + DID ,"","left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
			  
			 
			}
			//COMMENTED BY NITINC ON 31 MARCH 2011 FOR WHIZBILESEM 10.0
			// Code Added by MrugajaB on 3rd Mar 2005 for Document Sub category
			// For Upload Document
			/*
			function cboCategory_OnChange()
			{
			    //Commented By MrugajaB on 4th Feb 2005
			
				var intCounter;
				var strString;
				var arrCatID
				var strCat
				
				//Populate Sub Category combo for selected category
				objCbo = GetObjectReference('frmPM_UploadDocument','cboCategory');	
				strString="	<select id=cboSubCategory name=cboSubCategory class=clsComboBox style='height=70px; width=400px'> ";								
				
				
				strString = strString + "<OPTION value =''" + "></OPTION>"
				for(intCounter=0;intCounter<  arrsubCategories.length;intCounter++) {
					
					strCat=arrsubCategories[intCounter]
					arrCatID =strCat.split(",");
					
					if(arrCatID[0]==objCbo.value)
					{
						strString=strString + "  <option value=  " + arrCatID[1] + " > " + arrCatID[2] + " </option>" ;
					}		
				}	
				strString=strString + " </select> "  
								  
				document.all.tdSubCategory.innerHTML=strString;								
			}
			*/
			//END OF COMMENTED BY NITINC ON 31 MARCH 2011 FOR PMLifeLine
			
			// Code Added by NitinC on 31 Mar 2011 for PMLifeLine
			// For Upload Document
			function cboCategory_OnChange(FCount)
			{
			    var intCounter;
				var strString;
				var arrCatID
				var strCat
				var intTdCounter;
				var strTd
				strTd = "tdSubCategory"+FCount;
				
				//Populate Sub Category combo for selected category
				objCbo = GetObjectReference('frmPM_UploadDocument','cboCategory'+FCount);	
				strString="	<select id=cboSubCategory"+FCount+" name=cboSubCategory"+FCount+" class=clsComboBox style='height=70px; width=175px'> ";								
				
				
				strString = strString + "<OPTION value =''" + "></OPTION>"
				for(intCounter=0;intCounter<  arrsubCategories.length;intCounter++) {
					
					strCat=arrsubCategories[intCounter]
					arrCatID =strCat.split(",");
					
					if(arrCatID[0]==objCbo.value)
					{
						strString=strString + "  <option value=  " + arrCatID[1] + " > " + arrCatID[2] + " </option>" ;
					}		
				}	
				strString=strString + " </select> "  
				
				GetObjectReference('frmPM_UploadDocument',strTd).innerHTML=strString;
			}
			             		
			//End of Code Added by NitinC on 31 Mar 2011 for PMLifeLine
			
			
			// For Upload URL
			function cboAttachCategory_OnChange()
			{
			/* Commented By NitinVS on 10 March 2005 for PBNITE SP2
			objCbo = GetObjectReference('frmPM_UploadDocument','cboAttachCategory');	
			objform.action="PM_ProjectDocuments.aspx?Iscombochange=ComboChange&Mode=<%=CONST_MODE_ATTACHURL%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&DocumentCategoryID=" + objCbo.value;
			//objform.submit();
			//End Comment BY NitinVS on 10 March 2005 for PBNITE SP2 */
			
			/* Added By NitinVS on 10 March 2005 For PBNITE SP2 */
				var intCounter;
				var strString;
				var arrCatID
				var strCat
				
				//Populate Sub Category combo for selected category
				objCbo = GetObjectReference('frmPM_UploadDocument','cboAttachCategory');	
				strString="	<select id=cboSubCategory name=cboSubCategory class=clsComboBox style='height=70px; width=400px'> ";								
				
				
				strString = strString + "<OPTION value =''" + "></OPTION>"
				for(intCounter=0;intCounter<  arrsubCategories.length;intCounter++) {
					
					strCat=arrsubCategories[intCounter]
					arrCatID =strCat.split(",");
					
					if(arrCatID[0]==objCbo.value)
					{
						strString=strString + "  <option value=  " + arrCatID[1] + " > " + arrCatID[2] + " </option>" ;
					}		
				}	
				strString=strString + " </select> "    
				document.all.tdSubCategory.innerHTML=strString;								
				/* End Addition By NitinVS on 10 MArch 2005 for PBNITE SP2 */
			} 		
						
			// Code Addition Ends
			// Added by NitinVS on 8 Apr 2005 for PBNITE SP2 
			// To Make the Document Sub category as blan when the pge loads
			var objDocumentSubCategory = GetObjectReference('frmPM_UploadDocument','cboSubCategory');	
			if (objDocumentSubCategory != null )
			{
				objDocumentSubCategory.length=0;
			}
			// End Addition by NitinVS on 8 Apr 2005 for PBNITE SP2
			
			//Added By VarunA 0n 20-Jan-2009 RequestID-21539
			function AlphaNumericPaging_OnClick(chr)
			{
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
	            objform.action = "PM_ProjectDocuments.aspx?FromWhere=PM&MasterTagId=467&PagingAlphabet=" + chr;
		        objform.submit();
	        }
	        	        
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
		            //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		            setFrameLoader();
		            //End of Addition by Dhanashri S on 12 Oct 2016
		        objform.action = "PM_ProjectDocuments.aspx?FromWhere=PM&MasterTagId=467";
		        objform.submit();
		        }
	        }
	        
	        function cboCategoryList_OnChange()
			{
			//Commented By MrugajaB on 4th Feb 2005
				var intCounter;
				var strString;
				var arrCatID
				var strCat
				
				//Populate Sub Category combo for selected category
				objCbo = GetObjectReference('frmPM_UploadDocument','cboCategory1');	
				strString="	<select id=cboSubCategory1 name=cboSubCategory1 class=clsComboBox style='height=70px; width=150px'> ";								
				
				strString = strString + "<OPTION value =''" + "></OPTION>"
				for(intCounter=0;intCounter<  arrsubCategories.length;intCounter++) {
					
					strCat=arrsubCategories[intCounter]
					arrCatID =strCat.split(",");
					
					if(arrCatID[0]==objCbo.value)
					{
						strString=strString + "  <option value=  " + arrCatID[1] + " > " + arrCatID[2] + " </option>" ;
					}		
				}	
				strString=strString + " </select> "    
				document.all.tdSubCategory.innerHTML=strString;								
			} 	
			
			function Show_OnClick()
	        {	
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
				 objform.action = "PM_ProjectDocuments.aspx?FromWhere=PM&MasterTagId=467";
		         objform.submit();
			}
			
			function Sort_OnClick(strFieldName, strAscOrDesc)
			{
				var objSortBy, objSortOrder;
				objSortBy = GetObjectReference('frmPM_UploadDocument','txthidSortBy');
				objSortOrder = GetObjectReference('frmPM_UploadDocument','txthidSortOrder');
				objSortBy.value = strFieldName;
				objSortOrder.value = strAscOrDesc;
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
				setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.submit();
			}
			
			function cboCategoryList_OnLoad()
			{
			//Commented By MrugajaB on 4th Feb 2005
				var intCounter;
				var strString;
				var arrCatID
				var strCat
				
				//Populate Sub Category combo for selected category
				objCbo = GetObjectReference('frmPM_UploadDocument','cboCategory1');
				objhidSubCate = GetObjectReference('frmPM_UploadDocument','txthidSubCategory');
				if (objCbo != null)
				{
					if(objCbo.value!='')
					{
						if(objhidSubCate != null)
						{
							var objhidSubCateValue = objhidSubCate.value;
							
							strString="	<select id=cboSubCategory1 name=cboSubCategory1 class=clsComboBox style='height=70px; width=150px'> ";								
								
							strString = strString + "<OPTION value =''" + "></OPTION>"
							for(intCounter=0;intCounter<  arrsubCategories.length;intCounter++) {
								
								strCat=arrsubCategories[intCounter]
								arrCatID =strCat.split(",");
								
								if(arrCatID[0]==objCbo.value)
								{
									if (objhidSubCateValue == arrCatID[1])
										strString=strString + "  <option selected='" + arrCatID[1] +"' value=  " + arrCatID[1] + " > " + arrCatID[2] + " </option>" ;
									else
										strString=strString + "  <option value=  " + arrCatID[1] + " > " + arrCatID[2] + " </option>" ;
								}		
							}	
							strString=strString + " </select> "    
							document.all.tdSubCategory.innerHTML=strString;	
						}
					}							
				}
			} 			
			cboCategoryList_OnLoad(); 
	        //End By VarunA 0n 20-Jan-2009 RequestID-21539
                    </script>
	</body>
</HTML>
