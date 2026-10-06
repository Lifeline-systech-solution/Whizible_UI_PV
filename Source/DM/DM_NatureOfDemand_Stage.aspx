<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DM_NatureOfDemand_Stage.aspx.vb" Inherits="PbNIT.DM_NatureOfDemand_Stage"%>
<HTML>
	<%DrawHeader%>


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
        //Added By Usha Pandit On 09.04.2021 for selecting correct resource checkbox value
        var objSelect = GetObjectReference('frmDM_NatureOfDemand_Stage', 'chkSelect', true);
        var selected = false; 
        var objTxt = GetObjectReference('','txtPKIDList');
        var strPKIDList = new String(objTxt.value);

        
        for (i = 0; i < objSelect.length; i++) {
            if (strPKIDList.indexOf(objSelect[i].value) == 0 && strPKIDList.indexOf(objSelect[i].value + ",", 0) == 0) {                
                objSelect[i].checked = true;
            }            
        }
        //End Of Added By Usha Pandit On 09.04.2021 for selecting correct resource checkbox value
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



	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmDM_NatureOfDemand_Stage" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmDM_NatureOfDemand_Stage');
		var objdivlist=GetObjectReference('frmDM_NatureOfDemand_Stage','PageDiv');
		var objm_stageWithoutApprover = '<%=m_stageWithoutApprover%>';
		//The div tag has id as PageDiv 
		var objdivgrid=GetObjectReference('frmDM_NatureOfDemand_Stage','DivList');
		
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>

			 
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			 if (navigator.appName=="Netscape") 
			 {
			 intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			 }
			 else
			 {  
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			}
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;	
			if (objdivgrid != null) objdivgrid.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015; 		
			}	
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			 if (navigator.appName=="Netscape") 
			 {
			 intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			 }
			 else
			 {  
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			}
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;	
			if (objdivgrid != null) objdivgrid.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;			
			}
		}	
		
		function SelectStage_OnClick()
		{
			if (validate()== false) return;
			
			/*if (objm_stageWithoutApprover != "0")
			{
				alert("Please set stake holders for stages!");
			}*/
			enablecontrols();
			
			objform.action = "DM_NatureOfDemand_Stage.aspx?NatureOfDemandID=<%=m_strNatureOfDemandID%>&ACTION=SAVE&MODE=STAGE";
			objform.submit();
		}
		
		function SelectProjectStage_OnClick()
		{
		
			if (validate()== false) return;
			
			/*if (objm_stageWithoutApprover != "0")
			{
				alert("Please set stake holders for stages!");
			}*/
			enablecontrols();
			
			objform.action = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&ACTION=SAVE&MODE=PROJECT_STAGE";
			objform.submit();
		
		}
		
		//Addition by SuchitraP on 16 July 2008 for CRM Workflow stages
		function SelectCRMStage_OnClick()
		{
		   if (validate()== false) return;
		   
		   enablecontrols();
			
		   objform.action = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&ACTION=SAVE&MODE=CRM_PROJECT_STAGE";
		   objform.submit();
		}
		//End by SuchitraP
		
		function validate()
		{
			
			var arrOrderNo = new Array() 
			var count = 0
			// Order Number of all the stages should be consecutive 
			var objSelect = GetObjectReference('frmDM_NatureOfDemand_Stage','chkSelect',true);
			// Committee Approval Stage Should not be mandatory
			// Added check to validate for At least 1 Approval stage Exists other than 1 and 10 
			
			if (objSelect==null ) return false;
			
			for (i=0 ;i< objSelect.length   ; i++  )
			{
				if (objSelect[i].checked==true)
				{	
					// Added for NEU Requirement 
					 objtxtOrderNo=GetObjectReference('frmDM_NatureOfDemand_Stage','txtOrderNo'+String(objSelect[i].value));
					 //objtxtCompletionDays=GetObjectReference('frmDM_NatureOfDemand_Stage','txtCompletionDays'+String(objSelect[i].value));
					//if (objtxtOrderNo == null || objtxtCompletionDays==null) return false;
					if (objtxtOrderNo == null ) return false;
			
					count += 1; 
					//if (disallowNonInteger(objtxtCompletionDays,'Please specify Positive Integer \'Days for Completion\' ', true)==true) return false;
					
					/*if (objtxtCompletionDays.value==0)
						{
							alert('\'Days for Completion\' should not be zero.');
							objtxtCompletionDays.focus();	
							return false;
						}
						*/
					/*else
					{objtxtCompletionDays.value=''	}*/
				}
						
			}
			
			if( count <= 2 ) 
			{
				alert("Please select at least 3 stages of approval.");
				return false;	
			}	 
			else
			{
				count=0;
			}
		
			for (i=0 ;i< objSelect.length -1  ; i++  )
			{	
				
				if (objSelect[i].checked==true)
				{	
					objtxtOrderNo=GetObjectReference('frmDM_NatureOfDemand_Stage','txtOrderNo'+String(objSelect[i].value));
					 //objtxtCompletionDays=GetObjectReference('frmDM_NatureOfDemand_Stage','txtCompletionDays'+String(objSelect[i].value));
					 
					// for Selected stage order number is mandatory 
					if (disallowBlank(objtxtOrderNo,'Order Number is mandatory for selected stage.', true)==true) return false;
					
					//disallowNegativeNumeric disallowNonNumeric disallowNonInteger
					if (disallowNonInteger(objtxtOrderNo,'Please specify Positive Integer Order Number ', true)==true) return false;
					
					//Disallow Zero Value 
					if (objtxtOrderNo.value==0)
					{
						alert('Order Number should not be zero.');
						objtxtOrderNo.focus();	
						return false;
					}
					
					//if (disallowBlank(objcboCheckList[i],'Checklist is mandatory for selected stage.', true)==true) return false;
						
					if (disallowNegativeNumeric(objtxtOrderNo,'Please specify Positive Integer Order Number ', true)==true) return false;
					
					//if (disallowNonInteger(objtxtCompletionDays,'Please specify Positive Integer \'Days for Completion\' ', true)==true) return false;
					
					//if (disallowNegativeNumeric(objtxtCompletionDays,'Please specify Positive Integer \'Days for Completion\' ', true)==true) return false;
					arrOrderNo[count] = objtxtOrderNo.value;
					count+=1;
				}
				else
				{
				}	
			}
			
			// Sort the array and if the elements are not consecutive then return 
			arrOrderNo.sort(sortNumber) 
			for (i=1;i<arrOrderNo.length ;i++)
			{	
				
				if (arrOrderNo[i] - 1 != arrOrderNo[i-1] )
				{
					alert("Please specify consecutive order number to selected stages"); 
					return false;
				}	
			}
			
			// set the order number of Archive stage 
			//objtxtOrderNo[objtxtOrderNo.length-2].value =  arrOrderNo[arrOrderNo.length-1]* 1.00  + 1.00 ;
			objtOrderNo=GetObjectReference('frmDM_NatureOfDemand_Stage','txtOrderNo3');
			objtOrderNo.value =  arrOrderNo[arrOrderNo.length-1]* 1.00  + 1.00 ;
			return true;
		}
		
		function sortNumber(a, b)
		{
		return a - b
		}

		function enablecontrols()
		{
			var objSelect = GetObjectReference('frmDM_NatureOfDemand_Stage','chkSelect',true);
			//var objtxtOrderNo=GetObjectReference('frmDM_NatureOfDemand_Stage','txtOrderNo',true);
			
			
			if (objSelect==null ) return;
			
				for (i=0;i<objSelect.length;i++) 
				{
					objtxtONo=GetObjectReference('frmDM_NatureOfDemand_Stage','txtOrderNo'+String(objSelect[i].value));
					//objtxtCD=GetObjectReference('frmDM_NatureOfDemand_Stage','txtCompletionDays'+String(objSelect[i].value));
					
					objSelect[i].disabled=false;
			
					if(objtxtONo!=null)
						objtxtONo.disabled=false;
						
					//if(objtxtCD!=null)	
					//	objtxtCD.disabled=false;
				}
		}
		
		function SelectStakeholder_OnClick()
		{
			var objSelect = GetObjectReference('frmDM_NatureOfDemand_Stage','chkSelect',true);
			var selected = false ;
			var Defaultselected = false ;
		
			for (i=0;i<objSelect.length;i++)  
			{
				if (objSelect[i].checked==true) 
				{
					selected = true; 
				}	
			}

			
			/*if (selected==false)
				{
					alert("Please select at least one Role !");
				}
			else*/
			{	
			objform.action = "DM_NatureOfDemand_Stage.aspx?NatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&NatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&ACTION=SAVE&MODE=STAKEHOLDER";
			objform.submit();				
			}
				
		}
		function SelectProjectApprovers_OnClick()
		{
			var objSelect = GetObjectReference('frmDM_NatureOfDemand_Stage','chkSelect',true);
			var selected = false ;
			var Defaultselected = false ;
			for (i=0;i<objSelect.length;i++)  
			{
				if (objSelect[i].checked==true) 
				{
					selected = true; 
				}	
			}
					
			/*if (selected==false)
				{
				/*for(i=0;i<objcboCheckList.length;i++) objcboCheckList[i].disabled= false;*/
				/*alert("Please select at least one Approver.");
				}
			else
			{*/	
			    //Added by SuchitraP on 4-Aug-2008 for CRM Workflow
    			if('<%=m_strTagID%>'=='8036')
    			{
    			    objform.action = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&ProjectNatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&ACTION=SAVE&MODE=PROJECT_APPROVER&MasterTagID=8036";
			        objform.submit();				
    			}
    			else
    			{
    			//End of addition by SuchitraP
			        objform.action = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&ProjectNatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&ACTION=SAVE&MODE=PROJECT_APPROVER";
			        objform.submit();				
			    }
			//}
		
		}
		
		function SelectProjectOwners_OnClick()
		{
			var objSelect = GetObjectReference('frmDM_NatureOfDemand_Stage','chkSelect',true);
			var selected = false ;
			var Defaultselected = false ;
			for (i=0;i<objSelect.length;i++)  
			{
				if (objSelect[i].checked==true) 
				{
					selected = true; 
				}	
			}
					
			if (selected==false)
				{
				/*for(i=0;i<objcboCheckList.length;i++) objcboCheckList[i].disabled= false;*/
				alert("Please select at least one Owner.");
				}
			else
			{	
			objform.action = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&ACTION=SAVE&MODE=PROJECT_OWNER";
			objform.submit();				
			}
		
		}
		function SelectProjectStakeholder_OnClick()
		{
		
			var objSelect = GetObjectReference('frmDM_NatureOfDemand_Stage','chkSelect',true);
			var selected = false ;
			var Defaultselected = false ;
			for (i=0;i<objSelect.length;i++)  
			{
				if (objSelect[i].checked==true) 
				{
					selected = true; 
				}	
			}
					
			/*if (selected==false)
				{*/
				/*for(i=0;i<objcboCheckList.length;i++) objcboCheckList[i].disabled= false;*/
			/*	alert("Please select at least one Role");
				}
			else*/
			{	//Added by SuchitraP on 4-Aug-2008 for CRM Workflow
			    if('<%=m_strTagID%>'=='8036')
    			{
			        objform.action = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&ProjectNatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&ACTION=SAVE&MODE=PROJECT_STAKEHOLDER&MasterTagID=8036";
			        objform.submit();				
    			}
    			else
    			{
    			//End of addition by SuchitraP
			        objform.action = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&ProjectNatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&ACTION=SAVE&MODE=PROJECT_STAKEHOLDER";
			        objform.submit();				
			    }
			}
		
		}
		function CurrentInitiative(NatureofDemandID,RequestStageID)
		{
			window.open("DM_NatureOfDemand_Stage.aspx?NatureOfDemandID="+NatureofDemandID+"&RequestStageID="+RequestStageID+"&MODE=PENDINGINITIATIVES", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=700,height=444")
		}	
		function ProjectCurrentInitiative(ProjectNatureofDemandID,RequestStageID)
		{
				window.open("DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID="+ProjectNatureofDemandID+"&RequestStageID="+RequestStageID+"&MODE=PENDINGINITIATIVES", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=700,height=444")
			
		}
		

	function Page_Onclick(strPageNo)
	{
			var URL;
			
			switch("<%=m_StrMode.toUpper()%>")
			{
				case "STAKEHOLDER" :
					URL = "DM_NatureOfDemand_Stage.aspx?NatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&NatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&MODE=<%=m_StrMode%>&PageNumber=" + URIEncode(strPageNo);
					break;
				case "PROJECT_STAKEHOLDER" :
				    if ('<%=m_strTagID%>' == '8036')
				    {
				        URL = "DM_NatureOfDemand_Stage.aspx?MasterTagID=8036&ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&ProjectNatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&MODE=<%=m_StrMode%>&PageNumber=" + URIEncode(strPageNo);
				    }
				    else
				    {
					    URL = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&ProjectNatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&MODE=<%=m_StrMode%>&PageNumber=" + URIEncode(strPageNo);
					}
					break;
				case "PROJECT_APPROVER" :
				    if ('<%=m_strTagID%>' == '8036')
				    {
				        URL = "DM_NatureOfDemand_Stage.aspx?MasterTagID=8036&ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&ProjectNatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&MODE=<%=m_StrMode%>&PageNumber=" + URIEncode(strPageNo);
				    }
				    else
				    {
					    URL = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&ProjectNatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&MODE=<%=m_StrMode%>&PageNumber=" + URIEncode(strPageNo);
					}
					break;		
				case "PROJECT_OWNER" :
					URL = "DM_NatureOfDemand_Stage.aspx?ProjectNatureOfDemandID=<%=m_strNatureOfDemandID%>&MODE=<%=m_StrMode%>&PageNumber=" + URIEncode(strPageNo);
					break;		
				case "CORPORATE_APPROVER" :
					URL = "DM_NatureOfDemand_Stage.aspx?NatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&NatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&MODE=<%=m_StrMode%>&PageNumber=" + URIEncode(strPageNo);
					break;		

				default:
	
			}
				
			
			objform.action =URL
			objform.submit();
	}
	function Filter_OnChange()
	{
		objform.submit();
	}
	function chkRS_OnClick(objchkSelect)
	{
		var objtxtON=GetObjectReference('','txtOrderNo'+objchkSelect.value);
		var objcbochklist=GetObjectReference('','cboCheckList'+objchkSelect.value);
		//var objtxtCD=GetObjectReference('','txtCompletionDays'+objchkSelect.value);
		var objchkETL=GetObjectReference('','chkETL'+objchkSelect.value);
		var objchkEOHL=GetObjectReference('','chkEOHL'+objchkSelect.value);
		//var objchkESL=GetObjectReference('','chkESL'+objchkSelect.value);
		
		if(objtxtON!=null && objcbochklist!=null)
		{
			if(objchkSelect.checked==true)
			{
				objtxtON.readOnly=false;
				objcbochklist.disabled=false;
				//objtxtCD.readOnly=false;
			}
			else
			{
				objtxtON.readOnly=true;
				//objtxtCD.readOnly=true;
				objcbochklist.disabled=true;
			}
		}
		
			if(objchkSelect.checked==true)
			{
				
				if(objchkETL!=null)
					objchkETL.disabled=false;
					
				if(objchkEOHL !=null)	
					objchkEOHL.disabled=false;
				
				//if(objchkESL!=null)	
				//	objchkESL.disabled=false;
				
			}
			else
			{
				if(objchkETL!=null)
					objchkETL.disabled=true;
					
				if(objchkEOHL !=null)	
					objchkEOHL.disabled=true;
				
				//if(objchkESL!=null)		
				//	objchkESL.disabled=true;
			}
		
			
		
	}
	function chkSelect_OnClick(obj)
			{
				//PURPOSE: To update the ReviewerID list when a reviewer is selected / removed.
				var objTxt,strPKIDList;
				
				objTxt = GetObjectReference('','txtPKIDList');
				
				strPKIDList = new String(objTxt.value);
				
				var PKID = obj.value;
				
				//If the resource has been added to the list of reviewers, then...
				if(obj.checked==true)
				{
					//if not in the list then add 
					if(strPKIDList.indexOf("," + PKID +",",0)==-1)
					{
						strPKIDList = strPKIDList + PKID + ",";
						objTxt.value = strPKIDList; 
					}    			
				}
				else
				{
					if(strPKIDList.indexOf("," + PKID +",",0) != -1)
					{
						//Remove the Employee ID from the comma separated list.
						strPKIDList = replaceSubstring(strPKIDList,"," + PKID + ",","," );
						objTxt.value = strPKIDList; 
                    }
                    //Added By Usha Pandit On 09.04.2021 for selecting correct resource checkbox value
                    if (strPKIDList.indexOf(PKID) == 0 && strPKIDList.indexOf(PKID + ",", 0) == 0) {
                        strPKIDList = replaceSubstring(strPKIDList, PKID + ",", ",");
                        objTxt.value = strPKIDList;
                    }
                    //End Of Added By Usha Pandit On 09.04.2021 for selecting correct resource checkbox value
				}		
						
			}


function SelectCorporateApprovers_OnClick()
		{
			var objSelect = GetObjectReference('frmDM_NatureOfDemand_Stage','chkSelect',true);
			var selected = false ;
			var Defaultselected = false ;
			
			
			
			objform.action = "DM_NatureOfDemand_Stage.aspx?NatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&NatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&ACTION=SAVE&MODE=CORPORATE_APPROVER";
			objform.submit();				
			
		
		}			
		
function Filter_OnKeyPress(e)
        {
        var code;
        //var strPagePath=
        if (e.keyCode) code = e.keyCode;
        else if (e.which) code = e.which;

        if(code==13) 
        {
           objfrm.action = "DM_NatureOfDemand_Stage.aspx?NatureOfDemandID=<%=m_strNatureOfDemandID%>&RequestStageID=<%=m_strRequestStageID%>&NatureOfDemandStageID=<%=m_strNatureOfDemandStageID%>&ACTION=SAVE&MODE=<%=m_StrMode.toUpper()%>";
           objfrm.submit(); 

        }

}


		</Script>
	</body>
</HTML>
