<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Create_Deliverables.aspx.vb" Inherits="PbNIT.Create_Deliverables" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Create_Deliverables")%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added By Rutuja D. on 20 April 2020 For IssueID = 23649*/
    #cboDeliverableType{
        width:200px;
    }
    /*End Added By Rutuja D. on 20 April 2020 For IssueID = 23649*/

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
            //Edited by KIRAN K K FOR Issue id: 1909 25-11-15
            $('.clsTable:last').css({ 'display': 'none' });
             
            //Edited end by KIRAN K K for Issue id: 1909 25-11-15
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
        if(windowWidth < 990)
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




	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmCreate_Deliverables" method="post">
		<%PageInit()%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmCreate_Deliverables');
		var objdivlist=GetObjectReference('frmCreate_Deliverables','divList');
		var strFromWhere = '<%=m_strFromWhere%>' ;
		//Addition of if condition by SuchitraP on 19-Sep-2008 
		var blnDisabled = '<%=m_blnDisabled%>';
		//End by SuchitraP
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
		    
			var intDivHeight ;
			var intDivHeightRisk;
			var strProjectsOnHold, objProject, strMode;
			strProjectsOnHold = "<%=m_strProjectsOnHold%>";
			
			//Addition of if condition by SuchitraP on 19-Sep-2008 
			if (blnDisabled != 'True')
			{
			var objprojectID = GetObjectReference('frmCreate_Deliverables','cboProject');
			}
			//End by SuchitraP
			var objDeliverableType = GetObjectReference('frmCreate_Deliverables','cboDeliverableType');
						
			if (objdivlist !=null) {
			    // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40 ;
                //Commented added by Shamkant S On 3 Dec 2015 issueid 2581
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40 +20;
			    
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}
			
			// Added by Jijesh on 21Aug2006
			<%if strOnloadClientScript<>""%>
			<%=strOnloadClientScript%>
			window.close();
			<%end if%>
			// Added by Jijesh on 21Aug2006
			if (strFromWhere == 'CRM')
			{
			    //Addition of if condition by SuchitraP on 19-Sep-2008 
			    if (blnDisabled !='True')
			    {
				    objprojectID.focus() ;
				}
				//End by SuchitraP
			}
			else
			{
			    
				objDeliverableType.focus() ;
			}
				
			if ("<%=m_strAction%>" != "SAVE")
				{
				//Addition of if condition by SuchitraP on 19-Sep-2008 
			    if (blnDisabled !='True')
			    {
			   
				if (strProjectsOnHold != "" && objprojectID.value!="" )
					{
					if (strProjectsOnHold.indexOf(',' + objprojectID.value + ',') != -1)
						{
						  	if (strMode != "Edit")
							{
							// Commented by GaneshD on 11 Sep 2009 For WhizibleSEM 9.0 IssueID-33240
							//objprojectID.value = "";
							// End of Modification by GaneshD
							}
							else
							{
								objprojectID.value = "'<%=strProjectID%>'";
							}
						return;
						}		
					}
				 }
				}
			}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			     //Commented added by Shamkant S On 3 Dec 2015 issueid 2581
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			    //objdivlist.style.height = intDivHeight ;
			objdivlist.style.height = intDivHeight + 'px' ;	}
		}	
			function CloseOnClick()
		{
			window.close(); 
		
		}
		
		function cboProject_OnChange()
		{
		//Modified by MrugajaB on 30th June 2006 for Whiziblesem SP7 Issue ID.4168
		var objprojectID = GetObjectReference('frmCreate_Deliverables','cboProject');
		//End Modification
		
		//Not allowing the user to Create Tasks against OnHold Projects
				var strProjectsOnHold, objProject, strMode;
				
				strProjectsOnHold = "<%=m_strProjectsOnHold%>"
				objProject = GetObjectReference('DA',"cboProject");
				strMode = "<%=m_strAction%>"
				
				if (strProjectsOnHold != "" && objProject.value!="" )
				{
					if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("You are not allowed to create task/issue against selected project as Project is On Hold");
						
							if (strMode != "Edit")
							{
								objProject.value = "";
								
							}
							else
							{
								objProject.value = "'<%=strProjectID%>'";
							}
							
						return;
					}			
				}	
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
		    //Commented Shamkant s on 21 Jan 2016  pass PKToken
		  //  objform.action = "Create_Deliverables.aspx?FromWhere=<%=m_strFromWhere%>&ChangeRequestID=<%=m_intChangeRequestID%>&IssueID=<%=m_intIssueID%>&QueryID=<%=m_intQueryID%>&ProjectID=" + objprojectID.value ;	
		    objform.action = "Create_Deliverables.aspx?FromWhere=<%=m_strFromWhere%>&PKToken=<%=m_PKToken_FromDT%>&ChangeRequestID=<%=m_intChangeRequestID%>&IssueID=<%=m_intIssueID%>&QueryID=<%=m_intQueryID%>&ProjectID=" + objprojectID.value ;
		    //Commented Ended By  Shamkant s on 21 Jan 2016
		    objform.submit();
		}
		function cboDeliverableType_OnChange()
		{
			//Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
			//Purpose : Firefox Support, Capital 'C' is changed to small 'c' for cboProject
			var objprojectID = GetObjectReference('frmCreate_Deliverables','cboProject');
			//Modification Ends by SantoshK on June 8, 2006
			var objDeliverableType = GetObjectReference('frmCreate_Deliverables','cboDeliverableType');
			//objform.action="";
			 
			 // 5-Sept-2006
			var str1 = "<%=m_ShowToCustomer%>";
		    //Commented added by Shamkant S on 20 Jan 2016 pass PKToken 
		   // objform.action="Create_Deliverables.aspx?ShowToCustomer=<%=m_ShowToCustomer%>&FromWhere=<%=m_strFromWhere%>&ChangeRequestID=<%=m_intChangeRequestID%>&IssueID=<%=m_intIssueID%>&QueryID=<%=m_intQueryID%>&ProjectID=" + objprojectID.value + "&DeliverableTypeID=" + objDeliverableType.value; 
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
		   objform.action="Create_Deliverables.aspx?ShowToCustomer=<%=m_ShowToCustomer%>&PKToken=<%=m_PKToken_FromDT%>&FromWhere=<%=m_strFromWhere%>&ChangeRequestID=<%=m_intChangeRequestID%>&IssueID=<%=m_intIssueID%>&QueryID=<%=m_intQueryID%>&ProjectID=" + objprojectID.value + "&DeliverableTypeID=" + objDeliverableType.value; 
		    //Commented Ended by Shamkant S on 20 Jan 2016
		    //window.open("Create_Deliverables.aspx?FromWhere=<%=m_strFromWhere%>&ChangeRequestID=<%=m_intChangeRequestID%>&IssueID=<%=m_intIssueID%>&QueryID=<%=m_intQueryID%>&ProjectID=" + objprojectID.value + "&DeliverableTypeID=" + objDeliverableType.value ,"_self");
			objform.submit();
		}
		function validate()
		{
				
				var arrayObject = "<%=m_strObjArray%>";
				var arrStrings; 
				arrStrings = arrayObject.split(",");
				var arrCaptions = "<%=m_strObj_captions%>" ;
				var stringCaptions = arrCaptions.split(",");
				var intCtr;
				var obj ;
				var strObjs = "" ;
				for(intCtr = 0; intCtr < arrStrings.length; intCtr++)
				{				
						obj = document.getElementById(arrStrings[intCtr]);
					             
						if (obj.name == "txtDeliverableSize")
						{
						   	if (disallowNonNumeric(obj,"Please enter a numeric value")) return false;
						   	//Modified and added by GaneshD on 26 Aug 2009 for Whiziblesm IssueID-32678
							//if(disallowNegativeNumeric(obj,'Please enter only positive numeric value ',true)==true)return false;
							if (disallowNegativeInteger(GetObjectReference("frmCreate_Deliverables","txtDeliverableSize"),'Please enter only positive Integer',true))
                            {
                             return false; 
                            }
					    // End of addition by GaneshD on 26 aug 2009
						}
						
                        
						if (obj.name == "txtDocumentNo")
						{
						
						var StrCodeTemplate ="<%=StrCodeTemplate%>" ;
						if (disallowSpecialCharacters(obj,'A Code Template cannot contain any of these /\\:*?<>|,"+- Characters '))return false;
						if (disallowMaxlengthViolation(obj,100,'Max Length of this field is 100 characters.',true))
							{ return false; }
							//if(StrCodeTemplate.substring(StrCodeTemplate.indexOf(','+ obj.value +',')) != "")
							if(StrCodeTemplate.indexOf(','+ obj.value +',')!= -1)
						{
							alert("Code Template Already Exists");
							return;					
						}
						}
						
						if (obj.name == "txtEfforts")
						{
							if (disallowNonNumeric(obj,"Please enter a numeric value")) return false;
							if(disallowNegativeNumeric(obj,'Please enter only positive numeric value !',true)==true) return false;
							var dblProjectEffort = <%=m_lngEstimatedEfforts%>
							if(obj.value > dblProjectEffort)
								{
								 alert("The total Effort(hrs) of this Deliverable should not exceed the Project Effort(" + dblProjectEffort + " hrs).");  
								return false;
								}  
						}
						if (obj.name == "txtDeliverableSize")
						{
							if (disallowNonNumeric(obj,"Please enter a numeric value")) return false;
							if(disallowNegativeNumeric(obj,'Please enter only positive numeric value!',true)==true) return false;
						}
						
						if (obj.name =="txtScheduledStartDate")
						{
							var objStartDt=GetObjectReference("frmCreate_Deliverables","txtScheduledStartDate");
							var objProjectStartDt=GetObjectReference("frmCreate_Deliverables","txtProjectStartDate");
							var objProjectEndDt=GetObjectReference("frmCreate_Deliverables","txtProjectEndDate");  
						if(disallowDate1LessThanDate2(objStartDt,objProjectStartDt,"Start Date should not be less than Project Start Date [" + objProjectStartDt.value + "].",false))  
						{    return false; }  
						if(disallowDate1LessThanDate2(objProjectEndDt,objStartDt,"Start Date should not be greater than Project End Date [" + objProjectEndDt.value + "].",false))  
								{    return false; } 						
						}
						
						
						
						if (obj.name =="txtEarliestCompletionDate")
						{
							var objEarliestEndDt=GetObjectReference("frmCreate_Deliverables","txtEarliestCompletionDate");  
							var objLatestEndDt=GetObjectReference("frmCreate_Deliverables","txtLatestCompletionDate");  
							var objProjectEndDt=GetObjectReference("frmCreate_Deliverables","txtProjectEndDate");  
							var objStartDt=GetObjectReference("frmCreate_Deliverables","txtScheduledStartDate");						 
							if(disallowDate1LessThanDate2(objProjectEndDt,objEarliestEndDt,"Completion Date should not be greater than Project End Date [" + objProjectEndDt.value + "].",false))  
							{   return false; }
							if(disallowDate1LessThanDate2(objEarliestEndDt ,objStartDt,"Start Date should not be greater than completion Date [" + objEarliestEndDt.value + "].",false))  
							{   return false; }
											
						}
						
						if (obj.name =="txtLatestCompletionDate")
						{
							var objEarliestEndDt=GetObjectReference("frmCreate_Deliverables","txtEarliestCompletionDate");  
							var objLatestEndDt=GetObjectReference("frmCreate_Deliverables","txtLatestCompletionDate");  
							var objProjectEndDt=GetObjectReference("frmCreate_Deliverables","txtProjectEndDate");  
							var objStartDt=GetObjectReference("frmCreate_Deliverables","txtScheduledStartDate");	
							if(disallowDate1LessThanDate2(objProjectEndDt,objLatestEndDt,"Completion Date should not be greater than Project End Date [" + objProjectEndDt.value + "].",false))  
							{   return false; }
							
							if(disallowDate1LessThanDate2(objLatestEndDt,objStartDt ,"Start Date should not be greater than completion Date [" + objLatestEndDt.value + "].",false))  
							{   return false; }
							
							if(disallowDate1LessThanDate2(objLatestEndDt ,objEarliestEndDt, "Earliest Completion Date should not be greater than Latest Completion Date [" + objLatestEndDt.value + "].",false))  
							{   return false; }
							
							
						}
						var objCustomNumeric = obj.name ;
						if ( objCustomNumeric.substring(0,objCustomNumeric.length-1)== "txtCustomFieldNumeric")
						{
						if (disallowNonNumeric(obj,"Please enter a numeric value")) return false;
						}
						
						if (obj.name == "txtTitle")
						{	
						var StrTitleList ="<%=StrTitleList%>" ;
						//var StrTitleList ='JSJDJ' ;
						
						if (disallowSpecialCharacters(obj,'A Title cannot contain any of these /\\:*?<>|,"+- Characters'))return false;
						if (disallowMaxlengthViolation(obj,100,'Max Length of this field is 100 characters.',true))
							{ return false; }
						 // if(StrTitleList.substring(StrTitleList.indexOf(','+ obj.value +',')) != "")
						   if(StrTitleList.indexOf(','+ obj.value +',')!= -1)
						{
							alert("Title Already Exists");
							return;					
						}
						}
											
						if ((obj.value=="") || (obj.value == null))
						{
						alert(stringCaptions[intCtr] + ' should not be left Blank' );
						setFocus(obj);
						return false ;
						strObjs = strObjs + stringCaptions[intCtr] + " , \n" ;
						}
						
				 }/*
				 if (strObjs!="")
				 {
					alert('Please enter the Following Values \n' + strObjs.substring(0,strObjs.length-4));
					 return false;
				 }*/
				 return true ;
			}
		
		function Save_OnClick()
		{
		
			if (validate()== true)
			{
			
			 
			 var strMode = '<%=m_strMode%>';
			 var objTitle=GetObjectReference("frmCreate_Deliverables","txtTitle");  
			 
			 
			// START : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2 
			// Hexaware Issue ID 2397.
			 
			// Modified By AmitJ  For Hexaware IssueId - 2397
			//  Issue : "Deliverable(Support-->Issue-->Convert To Deliverale) Not Getting Saved If Description Field Size is large"
			var objDescr = GetObjectReference("frmCreate_Deliverables","txtDescription");
			if (disallowMaxlengthViolation(objDescr,1000,'Max Length of Description field is 1000 characters.',true))  
				{
					 return; 
				}
			//End : Modified By AmitJ  For Hexaware IssueId - 2397
			// END : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2 
			 
			 var strFromWhere = '<%=m_strFromWhere%>' ;
			 objform.action = "Create_Deliverables.aspx?FromWhere=<%=m_strFromWhere%>&ChangeRequestID=<%=m_intChangeRequestID%>&IssueID=<%=m_intIssueID%>&QueryID=<%=m_intQueryID%>&Action=SAVE";
			//alert(<%=intScheduleID%>);
			if (strFromWhere == "CRM")
			{
			
			//'Modified by ShraddhaM on Date 10 Jully,2006 for WhizibleSEM Issue ID.4168
            
			var objDeliverableID=GetParentObjectReference('frmRequestDetails','DeliverableID');
			objDeliverableID.value= "<%=intScheduleID%>";
			var objDeliverableName=GetParentObjectReference('frmRequestDetails','txtDeliverableName');
			objDeliverableName.value=objTitle.value;  
			
			//Added by ShraddhaM to display Deliverable name
			
			var objProjID = GetObjectReference("frmCreate_Deliverables","cboProject");			 
			var objDelProjectID=GetParentObjectReference('frmRequestDetails','DelProjectID');					 
			
			objDelProjectID.value= objProjID.value;
			var objDelProjectName=GetParentObjectReference('frmRequestDetails','txtDelProjectName');
			objDelProjectName.value= objProjID.options[1].innerHTML;   
			
			//Ended by ShraddhaM
				//window.opener.document.forms['frmRequestDetails'].elements['DeliverableID'].value = "<%=intScheduleID%>";
				//window.opener.document.forms['frmRequestDetails'].elements['txtDeliverableName'].value =objTitle.value ;           
				//window.opener.location.href=window.opener.location.href;
				
				//window.close();
			}
			if (strFromWhere == "PM")
			{
			//'Modified by ShraddhaM on Date 10 Jully,2006 for WhizibleSEM Issue ID.4168
			//Commented and Modified bY JyotiG
			// Modified by ArchanaN for Hexaware Upgrade SP8 on 6 march 2007 IssueID = 11254%>
			//Start_JG_11492_14-Mar-2007
			//var objDeliverableID=GetParentObjectReference('frmCommonPage','DeliverableID');
			var objDeliverableID=GetObjectReference('frmCommonPage','txtDeliverableID');
			//End_JG_11492_14-Mar-2007
			objDeliverableID.value="<%=intScheduleID%>";
			 
			//window.opener.document.forms['frmCommonPage'].elements['DeliverableID'].value = "<%=intScheduleID%>";
			
			//Commented and Modified By JyotiG
			// Modified by ArchanaN for Hexaware Upgrade SP8 on 6 march 2007 IssueID = 11254%>
			//Start_JG_11492_14-Mar-2007
			//var objNonDatabase1=GetParentObjectReference('frmCommonPage','NonDatabase1');
			var objNonDatabase1=GetObjectReference('frmCommonPage','cboTitle');
			objNonDatabase1.value=objTitle.value;
			//End_JG_11492_14-Mar-2007
			
				//window.opener.document.forms['frmCommonPage'].elements['NonDatabase1'].value =objTitle.value ;           
			 //alert('path'+window.opener.location.href);
			}
			if (strFromWhere == "IB")
			{
			//'Modified by ShraddhaM on Date 10 Jully,2006 for WhizibleSEM Issue ID.4168

			//For Firefox
			var objDeliverableID=GetParentObjectReference('frmIBIssueEntry','DeliverableID');
			 
			objDeliverableID.value= "<%=intScheduleID%>";
			 
			var objDeliverableName=GetParentObjectReference('frmIBIssueEntry','txtDeliverableName');
			 
			objDeliverableName.value=objTitle.value;  
			//window.opener.document.forms['IB_IssueEntry'].elements['DeliverableID'].value = "<%=intScheduleID%>";
			//window.opener.document.forms['IB_IssueEntry'].elements['txtDeliverableName'].value =objTitle.value ;           
				
			}
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    var MenuTags = document.getElementsByTagName('A');
			    for (i = 0; i < MenuTags.length; i++) {
			        if (MenuTags[i].className == "Menu") {
			            //MenuTags[i].style.display= "none";
			            MenuTags[i].parentNode.style.display = "none";
			        }
			    }
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
		 objform.submit();  
			       
			////var parent=window.opener.opener;
			//Mrugaja
             ////if(parent!=null)
               ////{
				 /*if (strFromWhere =="CRM")
				 {
					window.opener.document.forms['frmRequestDetails'].elements['DeliverableID'].value = '<%=intScheduleID%>';
				//	window.opener.document.forms['frmRequestDetails'].elements['txtDeliverableName'].value =objTitle.value ;*/
					
				////	window.opener.opener.location.href=window.opener.opener.location.href;
				////	window.opener.location.href=window.opener.location.href;
					//window.opener.close();
				////  window.close();
				  ////}
			  ////else
				 ////{
					////window.opener.location.href=window.opener.location.href;
					////window.close();
				 /////}
				
			//'Modified by ShraddhaM on Date 10 Jully,2006 for WhizibleSEM Issue ID.4168
			//if(navigator.appName != 'Netscape')
			//{
					//'Modified by ShraddhaM on Date 11 July,2006 for WhizibleSEM Issue ID.4168
					if (strFromWhere == "PM")
					{				    
						var strOpenerURL = window.opener.location.href; 
						var strSubmitTo; 
  
						if ( strOpenerURL.indexOf('?') > 0 )
						{ 
						strOpenerURL = strOpenerURL.substring(0, strOpenerURL.indexOf('?'));
						} 
						strSubmitTo = strOpenerURL + '?FocusOn=SUBTAG&ChangeRequestID_PK=<%=m_intChangeRequestID%>'; 
					
						refreshParent('frmCommonPage',strOpenerURL,strSubmitTo);
												 					 
						
					//window.opener.location.href=openerHref;
					//window.opener.location.href= '../General/CommonPage.aspx?ChangeRequestId=128&FromWhere=PM&MasterTagId=1039' ;  
					 }
					  else
					  {		
							var openerHref = window.opener.location.href; 							

							if (openerHref.indexOf('IssueID') >= 1)
							{ 	
								
								//Added by PrashantD on 7 Mrach 2007 for IssueID 11102		
								if(window.opener.document.getElementById('txtPkToken'))
								if (openerHref.indexOf('PKToken')==-1)
								{
											openerHref = openerHref + "&PKToken="+window.opener.document.getElementById('txtPkToken').value; 
								}
								//End of addition by PrashantD
								//Added by PrashantD on 13 March 2007 for IssueID 11574
								else
								{
									var strFromPKToken = openerHref.substring(openerHref.indexOf('PKToken'),openerHref.length);
									if(strFromPKToken.indexOf('&')==-1) 
									{
										if( strFromPKToken.substring(8,strFromPKToken.length) == "")
											 openerHref = replaceSubstring(openerHref,'PKToken=','PKToken='+window.opener.document.getElementById('txtPkToken').value);
									}
									else if (strFromPKToken.substring(8,strFromPKToken.indexOf('&')) == "")
									openerHref = replaceSubstring(openerHref,'PKToken=','PKToken='+window.opener.document.getElementById('txtPkToken').value);
								}
								//End of addition by PrashantD on 13 March 2007
								openerHref = replaceSubstring(openerHref,'IssueID=0','IssueID=<%=m_intIssueID%>');
								
								//openerHref = replaceSubstring(openerHref,'ChangeRequestID=','ChangeRequestID=<%=m_intChangeRequestID%>');
							}
							
						
							
							//Added by MrugajaB on 25th July 2006 for Whiziblesem SP7
							if (openerHref.indexOf('CopyIssue') >= 1)
							{ 					
								openerHref = replaceSubstring(openerHref,'&Mode=CopyIssue','');
							}
							//End Addition 
							
							// START : Modified BY ParagD On 5-Sept-2006
							// Purpose : Whizible SP7 Issue : To persist ShowToCustomer flag for Issue
							openerHref = openerHref + "&ShowToCustomer=" + "<%=m_ShowToCustomer%>";
						 //Added by SavitaS on 03 Oct 2006 for SP7 IssueId 6648								
							//START: SnehalV Addition for SP7 Issue ID 6674 on 6th Oct 2006: 
							//Open Attachment Popup comes at the time of saving deliverable
							if (openerHref.indexOf('&AttachmentID') >= 1)
							{
								var Startpos;
								var Endpos;							
								Startpos=openerHref.indexOf('AttachmentID');							
								Endpos = openerHref.indexOf('&',Number(Startpos)+1);											
								openerHref = replaceSubstring(openerHref,openerHref.substr(Startpos,Number(Endpos)- Number(Startpos)),'');
								//openerHref = replaceSubstring(openerHref,'&AttachmentID=','');
							}
							//END: SnehalV Addition for SP7 Issue ID 6674 on 6th Oct 2006
			
							//Code is commented by PrashantD on 13 March 2007 for IssueID 11102
							/*
							if (!(openerHref.indexOf('PKToken') >= 1))
							{
							    openerHref = openerHref + "&PKToken=<%=m_PKToken%>";	
							//}*/	
							//End of comment by PrashantD on 13 March 2007
							//openerHref = openerHref + "&IssueNavigation=<%=request("IssueNavigation")%>";
							//End of added by SavitaS on 03 Oct 2006 for SP7 IssueId 6648
						<%'Added By NitinVS on 10 Mar 2007 for WhizibleSEM SP8 Regression ISsue 11482 %> 

						if(strFromWhere=="CRM")	
						{
							<%'Remove Save Action from the Query String %>
							if( openerHref.indexOf("&Action=SAVE")>=1)
							{	
								openerHref= replaceSubstring(openerHref,"&Action=SAVE","")
							}
							
							if(window.opener !=null && window.opener.frmRequestDetails != null && window.opener.frmRequestDetails.cboFunction != null)
							{
								window.opener.frmRequestDetails.cboFunction.style.disabled=false;
							}	
						}
							
						<%'End Addition By NitinVS on 10 Mar 2007 for WhizibleSEM SP8 Regression ISsue 11482 %> 
						
							//alert(openerHref);
							window.opener.location.href=openerHref;				  
							
							
					
							// END : Modified BY ParagD On 5-Sept-2006	
						
					  }
					  
					 //Added By JyotiG
					//Start_JG_CR_7146_09-Nov-2006
					 if (strFromWhere == "CRM") 		
					 {
					    //window.close();
					    //Addition by SuchitraP on 22-Sep-2008
					    var PageNumber = window.opener.document.getElementById('hidPageNumber').value 
					    window.opener.location.href = "../CRM/CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&PageNumber="+PageNumber+"&QueryID=<%=m_intQueryID%>&PKToken="+window.opener.document.getElementById('txtPkToken').value+"&ShowToCustomer=0"
					   	//End by SuchitraP
					}
					//End_JG_CR_7146_09-Nov-2006	
					
					
         	//}
         	}
		}
</Script>
</body>
</HTML>
