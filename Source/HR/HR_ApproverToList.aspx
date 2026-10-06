<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_ApproverToList.aspx.vb" Inherits="PbNIT.HR_ApproverToList"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Release")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added by Yogesh J on 25-NOV-2015*/
    .footerMenuTable {
        position:relative!important;
    }

    body.clsBody
    {
        -ms-overflow-style:auto;
    }
    #Approver
    {
        background-color:#f0d1a1;
    }
    /*Added by Shamkant s on 17 Dec 2015*/
    #tblForm023{
        visibility:visible;
    }
    /*Ended by Shamkant s on 17 Dec 2015*/
    /*End of addition by Yogesh J on 25-NOV-2015  */
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmHR_ApproverToList" name="frmHR_ApproverToList" method="post" runat="server">
						
			<%NewInitPage%>
		</form>
		<script>
		var objForm = GetFormReference('frmHR_ApproverToList');
		var objDivMain = GetObjectReference('frmHR_ApproverToList','DivMain');
		var strApprover = <%=m_strApproverID%>;
		    var brw = isIE();
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
			function window_onload()		
			{ //debugger;
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168
				
			if(navigator.appName == 'Netscape')
			{	//Commented and added by Yogesh J on 25-NOV-2015	
			   // intDivHeight =window.innerHeight  - objDivMain.offsetTop -40 ;
			    intDivHeight =window.innerHeight  - objDivMain.offsetTop -4 ;
			  //End of addition by Yogesh J on 25-NOV-2015	
		    }
		    else
			{
			    //Commented and added by Yogesh J on 25-NOV-2015	
			    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
			    intDivHeight =window.innerHeight  - objDivMain.offsetTop - 4 ;
			    //End of addition by Yogesh J on 25-NOV-2015	
		    }
				if (intDivHeight < 100)
				    intDivHeight = 100;
                //commented and added by Yogesh J on 04 Oct 2015
				//objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight+ "px"	;
			    //End of addition by Yogesh J on 04 Oct 2015
				objDivMain.clientHeight = intDivHeight;
			
				
				
				var objdivTblGrid=GetObjectReference("frmHR_ApproverToList","divTblGrid");
				if(objdivTblGrid !=null)
				{
				    if(brw=="FF")
				    {
				        objdivTblGrid.style.height = intDivHeight-195+ "px";
				        //alert(objDivTblGrid.style.height);
				    }
				    else
				        objdivTblGrid.style.height = intDivHeight-185+ "px";
				}


				var objDApprover = GetObjectReference("frmHR_ApproverToList","ReportingTo");
				var objLeavingDate=GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtLeavingDate");
				var objProjectReleaseDt = GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtProjectActualEndDate");
				
				if(objProjectReleaseDt)
				objProjectReleaseDt.focus();
				else if (objDApprover!=null)
					objDApprover.focus();
				else
					if (objLeavingDate!=null)
						objLeavingDate.focus();
					
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
					//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
			    //intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
			    intDivHeight =window.innerHeight  - objDivMain.offsetTop - 4 ;
		    }
		    else
		    {
			    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
			    intDivHeight =window.innerHeight  - objDivMain.offsetTop - 4 ;
		    }
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight +'px' ;	
				
			}
		function Save_OnClick()
		{
			
			var objDApprover = GetObjectReference("frmHR_ApproverToList","ReportingTo");
			var strMSG;
			
			
			var objJoiningDate=GetObjectReference("frmHR_ApproverToList","txtJoiningDate");
			var objCurrentDate=GetObjectReference("frmHR_ApproverToList","txtCurrentDate");
			var objActualLeavingDate=GetObjectReference("frmHR_ApproverToList","txtLeavingDate");

			//Added by PrashantD
			var objActualEndDate=GetObjectReference("frmHR_ApproverToList","txtProjectActualEndDate");

			if (objActualEndDate != null )
			{
				if (objActualEndDate.value=='')
				{
					alert("Project Release Date should not be blank.");
					GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtProjectActualEndDate").focus();
					return;
				}
				if (disallowDate1GreaterThanDate2(objActualEndDate,objCurrentDate,"Project Release Date can not be future date.")== true) //{D
				{
					GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtProjectActualEndDate").focus();
					return;
				}
			}
					
			var objProjectIDs = GetObjectReference("frmHR_ApproverToList","cboProjectID",true);
			var objProjectResp,objApprovalResp,objIRGenerator,objRApprover,objworkflowApprover
			
				
			
			var objChkbox,i,isManAlert=true;
			//Added By VarunA on 31-Aug-2009 RequestD-22509
			//Purpose : Not to release for those project where resource MPP task is not completed or it is not being marked as void.
			var objHidTaskStatus;
			//End By VarunA on 31-Aug-2009 RequestD-22509
			if(objProjectIDs.length > 0)
			{
			
				for(i=0;i<objProjectIDs.length;i++)
				{
				
			
					objChkbox = GetObjectReference("frmHR_ApproverToList","chkSelect"+objProjectIDs[i].value);
					//Added By VarunA on 31-Aug-2009 RequestD-22509
					//Purpose : Not to release for those project where resource MPP task is not completed or it is not being marked as void.
					objHidTaskStatus = GetObjectReference("frmHR_ApproverToList","txthidMppTask"+objProjectIDs[i].value);
					//End By VarunA on 31-Aug-2009 RequestD-22509
					if(objChkbox)
					{
						if(objChkbox.checked==true && objChkbox.disabled==false )
						{
							
							objProjectResp = GetObjectReference("frmHR_ApproverToList","cboProjectResp"+objProjectIDs[i].value);
							objApprovalResp = GetObjectReference("frmHR_ApproverToList","cboApprovalResp"+objProjectIDs[i].value);
							objIRGenerator = GetObjectReference("frmHR_ApproverToList","cboInvoiceGenerator"+objProjectIDs[i].value);
							objRApprover = GetObjectReference("frmHR_ApproverToList","cboIRApprover"+objProjectIDs[i].value);
							objworkflowApprover = GetObjectReference("frmHR_ApproverToList","cboEmployeeforworkflow"+objProjectIDs[i].value);
							
							if(objProjectResp && objProjectResp.value=="")
							{ alert("Please transfer Project Responsibilities of project"); setFocus(objProjectResp); return; }
							
							if(objApprovalResp && objApprovalResp.value=="")
							{ alert("Please transfer Approval Responsibilities of project"); setFocus(objApprovalResp); return; }
							
							if(objIRGenerator && objIRGenerator.value=="")
							{ alert("Please transfer Invoice Generation Responsibilities of project"); setFocus(objIRGenerator); return; }
							
							if(objRApprover && objRApprover.value=="")
							{ alert("Please transfer IR/PIR Approval Responsibilities of project"); setFocus(objRApprover); return; }
							
							if(objworkflowApprover && objworkflowApprover.value=="")
							{ alert("Please transfer Workflow Approval Responsibilities"); setFocus(objworkflowApprover); return; }
							
							//Added By VarunA on 31-Aug-2009 RequestD-22509
							//Purpose : Not to release for those project where resource MPP task is not completed or it is not being marked as void.
							if(objHidTaskStatus!=null && objHidTaskStatus.value!='')
							{	
								if(objHidTaskStatus.value==1)
								{
									alert("Please complete the MPP task or mark it as void for the following project." + "<%=strProjectName%>");
									return;
								}
							}
							//End By VarunA on 31-Aug-2009 RequestD-22509
							
							isManAlert=false;
						}
						else if(objChkbox.disabled==true)
						//Added By VarunA on 31-Aug-2009 RequestD-22509
						//Purpose : Not to release for those project where resource MPP task is not completed or it is not being marked as void.
						{
							isManAlert=false;
							if(objHidTaskStatus!=null && objHidTaskStatus.value!='')
							{	
								if(objHidTaskStatus.value==1)
								{
									alert("Please complete the MPP task or mark it as void for the following project." + "<%=strProjectName%>");
									return;
								}
							}
						}
						//End By VarunA on 31-Aug-2009 RequestD-22509
					}
				}
				if(isManAlert)
				{
					alert("Please transer responsiblities to release resource")
					return;
				}
				
			}
			
			
			// added By purvaj on 10 Nov 2008 for whiziblesem 8.0 helpdesk workflow approval
            var objEmployeeforHDworkflow = GetObjectReference('frmHR_ApproverToList','cboEmployeeforHDworkflow');
			if(objEmployeeforHDworkflow !=null && objEmployeeforHDworkflow.value == '')
			{
			    alert('Please select New Knowledge Management Workflow Approver to transfer responsibilities.');
			    return;
			}
			// end addition purvaj
			
			if(disallowDate1GreaterThanDate2(objActualLeavingDate,objCurrentDate,"Leaving can not be future date.")== true) //{D
			{
				GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtLeavingDate").focus();
				return;
			}
				
				var checkCorpReportingTo;	
				
				checkCorpReportingTo = true;
				if(objProjectIDs.length > 0)
				{
					for(i=0;i<objProjectIDs.length;i++)
					{
						objChkbox = GetObjectReference("frmHR_ApproverToList","chkSelect"+objProjectIDs[i].value);
						if(objChkbox && objChkbox.checked==false)
						{
							checkCorpReportingTo = false;
							break;
						}
					}
					
				}
				
					if (objDApprover != null)
					{
						if(objDApprover.value == '' && checkCorpReportingTo == true)
						{
							strMSG='New Reporting To should not be blank';
							alert(strMSG);
							objDApprover.focus();
							return;
						}
					}
					if(objActualLeavingDate.value=="" && checkCorpReportingTo == true)
					{
						alert("Please enter leaving date");
						GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtLeavingDate").focus();
						return;
					}
					
				//Modified By VarunA on 11-Dec-2008 RequestID-17231
				//Purpose : To have leaving date greater than or equal to joining date.
				if (disallowDate1GreaterThanDate2(objJoiningDate,objActualLeavingDate,"Please enter Leaving Date greater than or equal to Joining Date.")== true)
				{ 
					GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtLeavingDate").focus();
					return;
				}
				//End By VarunA on 11-Dec-2008 RequestID-17231
				
				if(objActualLeavingDate.value!="" && checkCorpReportingTo == true)
				{
					var MaxDa = GetObjectReference('','MAXDA');
					if (disallowDate1GreaterThanDate2(MaxDa,objActualLeavingDate,"Resource has filled timesheet for "+MaxDa.value+".\nPlease enter Leaving Date greater than or equal to "+MaxDa.value)== true)
					{
						GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtLeavingDate").focus();
						return;
					}
				}
				
				if (disallowDate1GreaterThanDate2(objJoiningDate,objActualLeavingDate,"Please enter Leaving Date greater than or equal to Joining Date.")== true)
				{ 
					GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtLeavingDate").focus();
					return;
				}
				
				//Added by PrashantD
				if (disallowDate1GreaterThanDate2(objActualEndDate,objActualLeavingDate,"Please enter Leaving Date greater than or equal to Project Release Date.")== true)
				{
					GetObjectReference("frmHR_ApproverToList","FFE29587WHIZ_txtLeavingDate").focus();
					return;
				}
				//End of addition by PrashantD
				
				
				
				
			var PER_DA_Date;
			if(objProjectIDs.length > 0)
			{
			
				for(i=0;i<objProjectIDs.length;i++)
				{
				
			
					objChkbox = GetObjectReference("frmHR_ApproverToList","chkSelect"+objProjectIDs[i].value);
					if(objChkbox && objChkbox.checked == true)
					{
						PER_DA_Date = GetObjectReference("frmHR_ApproverToList","PER_DA_Date"+objProjectIDs[i].value);
						var PrjName;
						if(GetObjectReference('','PrjName'+objProjectIDs[i].value))
						PrjName = "Please enter Project Release Date for project '"+GetObjectReference('','PrjName'+objProjectIDs[i].value).innerHTML+"' greater than or equal to "+PER_DA_Date.value
						
						else
						PrjName ="Please enter Project Release Date greater than or equal to "+PER_DA_Date.value;
						
						if (disallowDate1GreaterThanDate2(PER_DA_Date,objActualEndDate,PrjName)== true)
						{
						return;
						}
					}
				}
			}
				
			
				
				
				if(!confirm("Are you sure, you want to release resource?"))
				return; 
				
			if(objProjectIDs.length > 0)
			{
				for(i=0;i<objProjectIDs.length;i++)
				{
					objChkbox = GetObjectReference("frmHR_ApproverToList","chkSelect"+objProjectIDs[i].value);
					if(objChkbox && objChkbox.disabled==true)
					objChkbox.disabled=false;
				}
			}
			//return;
				objForm.action = "../HR/HR_ApproverToList.aspx?ApproverID=<%=m_strApproverID%>&Action=SAVE";
				objForm.submit();
				
			}
			
			function Close_OnClick()
			{
				window.close();
			}
			function ShowHistory_OnClick()
			{
				window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagId=<%=m_TagShowHistory%>","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			}
			function Paging_OnClick(str)
			{
								
				objForm.action = "HR_ApproverToList.aspx?Alphabet=" + str;
				objForm.submit();	
			}
			
		var chkProjID;
			function chkSelect_onclick(ProjectID)
			{ 
					var objBlank;
					var objchk = GetObjectReference('','chkSelect'+ ProjectID)
					objBlank = GetObjectReference('','cboblank'+ ProjectID,true);
					
					for(j=0;j<objBlank.length;j++)
					{
						if(objchk.checked)							
						objBlank[j].disabled=false;
						else
						objBlank[j].disabled=true;
					}
				if(objchk.checked)	
				{
					if(!GetObjectReference('','cboProjectResp'+ ProjectID) && !GetObjectReference('','cboApprovalResp'+ ProjectID) && !GetObjectReference('','cboInvoiceGenerator'+ ProjectID) && !GetObjectReference('','cboIRApprover'+ ProjectID))
					{				
						chkProjID=ProjectID;
					
						var url= "HR_ApproverToList.aspx?FromXML=1&ApproverID="+strApprover+"&ProjectID="+ProjectID;
						loadXMLDoc(url,'');	
					}
					else
					{
						if(GetObjectReference('','cboProjectResp'+ ProjectID))
						GetObjectReference('','cboProjectResp'+ ProjectID).disabled=false;
						if(GetObjectReference('','cboApprovalResp'+ ProjectID))
						GetObjectReference('','cboApprovalResp'+ ProjectID).disabled=false;
						if(GetObjectReference('','cboInvoiceGenerator'+ ProjectID))
						GetObjectReference('','cboInvoiceGenerator'+ ProjectID).disabled=false;
						if(GetObjectReference('','cboIRApprover'+ ProjectID))
						GetObjectReference('','cboIRApprover'+ ProjectID).disabled=false;
						// Added By purvaj on 17 nov 2008 for Whiziblesem 8.0 workflow approvals release resorce
						if(GetObjectReference('','cboEmployeeforworkflow'+ ProjectID))
						GetObjectReference('','cboEmployeeforworkflow'+ ProjectID).disabled=false;
						//end addition purvaj
					}
				}
				else
				{
					if(GetObjectReference('','cboProjectResp'+ ProjectID))
					GetObjectReference('','cboProjectResp'+ ProjectID).disabled=true;
					if(GetObjectReference('','cboApprovalResp'+ ProjectID))
					GetObjectReference('','cboApprovalResp'+ ProjectID).disabled=true;
					if(GetObjectReference('','cboInvoiceGenerator'+ ProjectID))
					GetObjectReference('','cboInvoiceGenerator'+ ProjectID).disabled=true;
					if(GetObjectReference('','cboIRApprover'+ ProjectID))
					GetObjectReference('','cboIRApprover'+ ProjectID).disabled=true;
    				// Added By purvaj on 17 nov 2008 for Whiziblesem 8.0 workflow approvals release resorce
		    		if(GetObjectReference('','cboEmployeeforworkflow'+ ProjectID))
					GetObjectReference('','cboEmployeeforworkflow'+ ProjectID).disabled=true;
	    			//end addition purvaj

				}
						
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
				
				var strProjIDs=GetObjectReference('','cboProjectID',true);
				var strBlank = "<SELECT  id=cboBlank" +chkProjID+ " name=cboBlank"+chkProjID+" class=clsComboBox style='width:150px ' ><FONT size=1><OPTION value =''></OPTION><OPTION selected value =''></OPTION></FONT></SELECT>";
				strBlank = strBlank + "<IMG src='../../Images/Star.gif' border=0>";
				
				if (parseInt(xmlhttp.readyState)==4) 
				{ 
					if (xmlhttp.status==200)
					{
						var arr=xmlhttp.responseText.split("$___#");
						var cbochkSel=GetObjectReference('','chkSelect'+ chkProjID);
						document.getElementById("TDProjectResp"+chkProjID).innerHTML = arr[0];
						document.getElementById("TDApprovalResp"+chkProjID).innerHTML = arr[1];
						document.getElementById("TDIRGenerator"+chkProjID).innerHTML = arr[2];
						document.getElementById("TDIRApprover"+chkProjID).innerHTML = arr[3];
						//Added By PurvaJ on 26 May 2008 Configurable workflow
						document.getElementById("TDWorkflowapprover"+chkProjID).innerHTML = arr[4];
						// End Addition PurvaJ
							
					}
				}
				
			}
			
function ResourceSelection()
{
window.open ("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=23&FromWhere=RM", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
}
						</script>
	</body>
</HTML>
<script>
	window.focus();
</script>
