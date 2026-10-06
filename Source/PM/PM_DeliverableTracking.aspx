<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_DeliverableTracking.aspx.vb" Inherits="PbNIT.PM_DeliverableTracking" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
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
    #Deliverables {
        table-layout:fixed; /*Added by Yogesh J on 12-Feb-2016 for issue id=3157 */

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize='window_onresize()' onload='window_onload()'>
	 
					<form id="frmPM_DeliverableTracking" method="post" runat="server">
						<div v:shape='_x0000_s1025' class="shape" id="image" align="center" style='display:none'>
										<img src="file:///C:\Inetpub\wwwroot\SP4\Images\scrollbar.gif" width="200" height="10"
											align="left">
						</div>
									<%PageInit%>
					</form>
				
					<Script language="javascript">
		//******************************************************************************//
		//					Global Variable Declaration									//
		//*******************************************************************************//
		
		var objform=GetFormReference('frmPM_DeliverableTracking');
		var objdivlist=GetObjectReference('frmPM_DeliverableTracking','PageDiv');
		var blnStatus=true,SubTaskblnStatus=true,blncboChange=false;
		var blnSubTask=false;
		var strIsSaved ;
		var strTaskName,TaskID;
		var strActualWork;
		var strStartDate,strEndDate,Percentage;
		var req; 
		var xmlDoc;
		var Del =new Array();
		var SubTaskDel =new Array();
		var NoOfRows =new Array();
		var Element_Present = new Array();
		var SubTaskElement_Present = new Array();
		var Length=0;
		var intRowNumber=0;
		
		var objdivlist1=GetObjectReference('frmPM_TaskUpdation','DivList');
		
        //Added by Dhanashri S on 21 Dec 2015 For IssueID:2806
		document.body.onload = function () {
		   
		    //'Modified by ShraddhaM on Date 06 Jully,2006 for PMLifeLine Issue ID.4168
		    var intDivHeight;
		    var intDivListPageHeight;
		    var intDivHeightRisk;
		    var lc;
		    if (objdivlist != null) {
		        
		        if (WhichBrowser() == 'IE')
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
		        else if (WhichBrowser() == 'CR')
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
		        else if (WhichBrowser() == 'FF')
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
		        else {
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;// Added By Vaijat K ON 09/02/2016
		        }
		        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
		        
		        if (intDivHeight < 100)
		            intDivHeight = 100;
		        objdivlist.style.height = intDivHeight + 'px';
		        
		    }
		    if (objdivlist1 != null) {
		        intDivListPageHeight = intDivHeight;
		        objdivlist1.style.height = intDivListPageHeight + 'px';
		    }
		}
        //End of Addition by Dhanashri S on 21 Dec 2015 

		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
			//The div tag has id as PageDiv 
		function window_onload()
		{
		    
			//'Modified by ShraddhaM on Date 06 Jully,2006 for PMLifeLine Issue ID.4168
			var intDivHeight ;
			var intDivListPageHeight ;
			var intDivHeightRisk;
			var lc;
			if (objdivlist != null) {
                //dhn
			    if (WhichBrowser() == 'IE')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			    else if (WhichBrowser() == 'CR')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			    else if (WhichBrowser() == 'FF')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			    else {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;// Added By Vaijat K ON 09/02/2016
			    }
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
                //dhn
			    if (intDivHeight < 100)
				    intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + 'px';
			    
            }
			if (objdivlist != null)
			{
			    intDivListPageHeight = intDivHeight;
			    objdivlist1.style.height = intDivListPageHeight + 'px';
            }
			
		}
		
				
		function window_onresize()		
		{
			
			var intDivHeight ;
			var intDivHeightRisk;
			var intDivListPageHeight;
            //Commented And Added By Vaijat K ON 09/02/2016
			//if (objdivlist != null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
			//if (intDivHeight < 100)
			//	intDivHeight = 100;
					
			//objdivlist.style.height = intDivHeight	+ 'px';}
			//if (objdivlist != null) {
			//intDivListPageHeight = intDivHeight - 5 ;
		    //objdivlist1.style.height = intDivListPageHeight + 'px';}
			if (objdivlist != null) {
			    //dhn
			    if (WhichBrowser() == 'IE')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			    else if (WhichBrowser() == 'CR')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			    else if (WhichBrowser() == 'FF')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
			    //dhn
			    if (intDivHeight < 100)
			        intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + 'px';

			}
			if (objdivlist != null) {
                intDivListPageHeight = intDivHeight;

                //Commented and added by Chetan M on 7th Aug 2020 for javascript on click of parent task
                // objdivlist1.style.height = intDivListPageHeight + 'px';
                if (objdivlist1 != null) {
                    objdivlist1.style.height = intDivListPageHeight + 'px';
                }			   
                //End of Commented and added by Chetan M on 7th Aug 2020 for javascript on click of parent task
			}
            //Ended
		}
        //Added by Dhanashri S on 21 Dec 2015 For IssueID:2806
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
		//End of Addition by Dhanashri S on 21 Dec 2015
		//*******************************************************************************//
		//     Generate Request functions creates the XMLHTTP Request for the Server.    //
		//*******************************************************************************//
		function generateRequest(url) 
		{
		  
			var objimage=GetObjectReference('frmPM_DeliverableTracking','image')
		  	objimage.style.visibility="visible";
			// Mozilla and Friends 
			if (window.XMLHttpRequest) 
			{ 
			
				req = new XMLHttpRequest(); 
								
			} else if (window.ActiveXObject) { 
				// Internet Explorer 
				req = new ActiveXObject("Microsoft.XMLHTTP"); 
			} 
			
					
			req.onreadystatechange = processChoices;
			
			req.open("POST", url,true); 
			req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			req.send("ISTest=1");
			
			//delete req;
			return true;
		} 
		//*******************************************************************************//
		//          ProcessChoices function is called on STATE Change.                   //
		//*******************************************************************************//
		function processChoices() 
		{ 
		
		
			// wait until the request is done 
			if (req.readyState == 4) 
			{
				// Make sure request came back OK 
				if (req.status == 200) 
				{
				
				//Modified by Bharat T on 28th-Nov-2015
				    if (window.ActiveXObject || 'ActiveXObject' in window)
				        //Modified by Bharat T on 28th-Nov-2015
					{
						xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
						xmlDoc.async=false;
						xmlDoc.loadXML(req.responseText);
											
					}
					// code for Mozilla, etc.
					else if (document.implementation &&	document.implementation.createDocument)
					{

						xmlDoc= document.implementation.createDocument("","",null);
						if (WhichBrowser() == 'FF') {
						    xmlDoc.load(req.responseXML);
						}
					}
									
					   if(blnSubTask==false)
					   //If the Task is Clicked (For Task)
					   {
					  	   // Populate the Tasks table here..
					  	   //alert(req.responseText);
							var Rows=document.getElementById('TR' + (intRowNumber+1));
							var Col=document.getElementById('TD' + (intRowNumber+1));
							Rows.style.display="";
							Col.innerHTML=req.responseText;
					   }
					   if(blnSubTask==true)
					   //If the Task is Clicked (For SubTask)
					   {
					        //alert(req.responseText);
					        // Populate the SubTasks table here..
							var Rows=document.getElementById('TasksTR' + (intRowNumber+1) + '-' + TaskID);
							var Col =document.getElementById('TasksTD' + (intRowNumber+1) + '-' + TaskID);
							Rows.style.display="";
							Col.innerHTML=req.responseText;
					   }
					
			   }
			}
		 }
	
	
	function cboChange()
	{
	   //If the combo is changed the make the falg as true;
		blncboChange=true;
	
	}
	
		//*******************************************************************************//
		//   DisplayDeliverableDetails function is called when the '+' image is clicked. //
		//*******************************************************************************//
		function DisplayDeliverableDetails(intDeliverableTypeID,intUniqueID,intRowNo)
		{
					
			var objTr,i;
			var objimg;

			//Get the '+' and '-' image object	
			objimg = document.getElementById("imgAttachments" +  intDeliverableTypeID +"U" + intUniqueID);
			blnSubTask=false;
			// Get the combo values.
			var objcboDeliverable=GetObjectReference('frmPM_DeliverableTracking','cboDeliveriable');
			var objcboDepartment=GetObjectReference('frmPM_DeliverableTracking','cboDepartment');
			var objcboResource=GetObjectReference('frmPM_DeliverableTracking','cboResource');
			var objcboPackage=GetObjectReference('frmPM_DeliverableTracking','cboPackage');
			
			//Check for the existance of the task table
			for(i=0;i<Del.length;i++)
			{
			 //If the Task Table is Present and the table is 'Expanded'
			 if(Del[i]==intUniqueID && Element_Present[i]=="Y")
			  { 
				     	//Change the Status of Present="N"
						Element_Present[i]="N";
						objimg.src = '../../images/Plus.gif'
						blnStatus=false;
						//Hide the task table											
						var Rows=document.getElementById('TR' + (intRowNo+1))
						var Col=document.getElementById('TD' + (intRowNo+1))
						Rows.style.display="none";
						break;
              }	
              //If the Task table is present and the table is not Expanded.
              if(Del[i]==intUniqueID && Element_Present[i]=="N")
              {
						objimg.src = '../../images/Minus.gif';
						Element_Present[i]="Y";
						if (blncboChange==true)
						{
						   blnStatus=true;
						   break; 
						}
						else
							blnStatus=false;
						//If task table is present the SHOW the task table
						var Rows=document.getElementById('TR' + (intRowNo+1));
						var Col=document.getElementById('TD' + (intRowNo+1));
						Rows.style.display="";
						
						break;
              }              
              else
               blnStatus=true;
            } 
              
              //If the Task Table is loaded for the First time.
              if(blnStatus==true)
              {
					
					window.status="Processing Deliverables Please Wait...";
					var objimage=GetObjectReference('frmPM_DeliverableTracking','image');
              	    objimage.style.visibility="visible";
              	    Length=Del.push(intUniqueID);
                    Element_Present.push("Y");
					objimg.src = '../../images/Minus.gif'
		            blnStatus=true;
		            blncboChange=false;
		            var strURL="PM_DeliverableTracking.aspx?FromWhere=XMLHTTP&DeliverableTypeID=" + intDeliverableTypeID + "&DeliverableID=" + intUniqueID + "&Row=" + intRowNo + "&cboDeliverable=" + objcboDeliverable.value + "&cboDepartment=" + objcboDepartment.value + "&cboResource=" + objcboResource.value + "&cboPackage=" + objcboPackage.value; 
		  			intRowNumber=intRowNo;
		  			//Generate XMLHTTP Request.
		  			
		  			var val=generateRequest(strURL);
		  			
		  			if (val==true)
					{ 
						var objimage=GetObjectReference('frmPM_DeliverableTracking','image');
						objimage.style.visibility="hidden";
						window.status ="";
					}
              }
		}
				
  			
  			
 	//*******************************************************************************//
	//	     DisplayTraskDetails function is used to display the SubTask			 //
	//*******************************************************************************//
		function DisplayTaskDetails(intTaskID,intDeliverableTypeID,intDeliverableID,intRowNo)
		{
		
			var objTr,i;
			var objimg;

			objimg = document.getElementById("imgAttachments" + intTaskID);
			blnSubTask=true;
			TaskID=intTaskID;
			// Get the combo values.
			var objcboDeliverable=GetObjectReference('frmPM_DeliverableTracking','cboDeliveriable');
			var objcboDepartment=GetObjectReference('frmPM_DeliverableTracking','cboDepartment');
			var objcboResource=GetObjectReference('frmPM_DeliverableTracking','cboResource');
			var objcboPackage=GetObjectReference('frmPM_DeliverableTracking','cboPackage');
						
			//Check for the existance of the task table
			for(i=0;i<SubTaskDel.length;i++)
			{
			 //If the SubTask Table is Present and the table is 'Expanded'
			 if(SubTaskDel[i]==intTaskID && SubTaskElement_Present[i]=="Y")
			  {
				       
						//Change the Status of Present="N"
						SubTaskElement_Present[i]="N";
						objimg.src = '../../images/Plus.gif'
						SubTaskblnStatus=false;
						//Hide the task table											
						var Rows=document.getElementById('TasksTR' + (intRowNo+1) + '-' + TaskID)
						var Col= document.getElementById('TasksTD' + (intRowNo+1) + '-' + TaskID)
						Rows.style.display="none";
						//Col.innerHTML="";
					 	break;
              }	
              //If the SubTask table is present and the table is not Expanded.
              if(SubTaskDel[i]==intTaskID && SubTaskElement_Present[i]=="N")
              {
						objimg.src = '../../images/Minus.gif';
						SubTaskElement_Present[i]="Y";
						if (blncboChange==true)
						{   
						    SubTaskblnStatus=true;
							break;
						}
						else
							SubTaskblnStatus=false;
						
						//If task table is present the SHOW the Subtask table
						var Rows=document.getElementById('TasksTR' + (intRowNo+1) + '-' + TaskID);
						var Col= document.getElementById('TasksTD' + (intRowNo+1) + '-' + TaskID);
						Rows.style.display="";
						SubTaskblnStatus=false;
						break;
              }              
              else
               SubTaskblnStatus=true;
            } 
              
              //If the SubTask Table is loaded for the First time.
              if(SubTaskblnStatus==true)
              {
					window.status="Processing Tasks Please Wait...";
			   	    var objimage=GetObjectReference('frmPM_DeliverableTracking','image');
              	    objimage.style.visibility="visible";
                    Length=SubTaskDel.push(intTaskID);
                    SubTaskElement_Present.push("Y");
					objimg.src = '../../images/Minus.gif'
		            SubTaskblnStatus=true;
		            blncboChange=false;
		            var strURL="PM_DeliverableTracking.aspx?FromWhere=SUBTASK_XMLHTTP&DeliverableTypeID=" + intDeliverableTypeID + "&DeliverableID=" + intDeliverableID + "&Row=" + intRowNo + "&TaskID=" + intTaskID  + "&cboDeliverable=" + objcboDeliverable.value + "&cboDepartment=" + objcboDepartment.value + "&cboResource=" + objcboResource.value + "&cboPackage=" + objcboPackage.value;  
		  			intRowNumber=intRowNo;
		  			blnSubTask=true;
		  			//Generate XMLHTTP Request.
		  			var val=generateRequest(strURL);
		  			if (val==true)
					{ 
						var objimage=GetObjectReference('frmPM_DeliverableTracking','image');
						objimage.style.visibility="hidden";
						window.status="Done";
					}
              }
		}
				
	//*********************************************************************************************//
	//						The div tag has id as PageDiv										   //
	//*********************************************************************************************//				
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}			
		}
			
	    //**********************************************************************************************************//
		// On Click of any Deliverable  a new window showing all tasks corresponding to that Deliverable will appear//
		//**********************************************************************************************************//
		function EditDeliverableTasks(intDeliverableTypeID,intUniqueID)
		{
			     window.open("../General/CommonList.aspx?FromWhere=SM&MasterTagId=3098&DeliverableID="+ intUniqueID,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=550,width=850")
		}
	
	//***************************************************************************************************//
	//         Show On Click page will post back and show the data as per the Filters applied	         //
	//***************************************************************************************************//
		function Show_OnClick()		
		{
		    var objDate = GetObjectReference('frmPM_DeliverableTracking', 'dtDate');

		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
		    objform.action = "PM_DeliverableTracking.aspx?Show=1";
			objform.submit();
		}
			
				</Script>
			</body>
		</HTML>	
			<!-- This Function is Called for XMLHTTP Response -->
			<%XMLHTTP_PopulateTaskTable%>

