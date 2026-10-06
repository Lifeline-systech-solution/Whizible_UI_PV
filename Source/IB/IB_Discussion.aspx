<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_Discussion.aspx.vb" Inherits="PbNIT.IB_Discussion"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmDiscussion" name="frmDiscussion" method="post" runat="server">
		<%PageInit()%>
        
        <%--Added By Reshma Chavan on 9th April For Save Issue--%>
        <input type="hidden" id="OldStatusChangeTimeNew"/>
        <%--End of Added By Reshma Chavan on 9th April For Save Issue--%>
    </form>
  </body>
  <script language="javascript">
			var objdivlist;
			var objform;
		
			objform = GetFormReference('frmDiscussion');
			objdivlist = GetObjectReference('frmDiscussion','DivBody');
            
            <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
            
			'<%MyBase.InitializeResources("AppResources.IB_Discussion", "AppResources")%>';
			 //Modified by JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
				if(navigator.appName == 'Netscape')
				{
					intDivHeight = window.innerHeight  - objdivlist.offsetTop -40;
				}

				objdivlist.style.height = intDivHeight +'px'	;	
				
				var objtxtComments = GetObjectReference('frmDiscussion','txtComments');		
				if(objtxtComments!=null || objtxtComments!='')
					objtxtComments.focus();
					
					//shraddhaM
					var dt=new Date(); 
			var hr=dt.getHours();
			var min=dt.getMinutes();
	
			//Commented By ShraddhaM On 18 Aug 2006 to remove Timespan Code..
			/*if (hr<10)
				hr='0'+hr;
			if(min<10)
				min='0'+min;
		//Added by AmitJ for PSPL ISSue 22880		
		RenderedTime = hr+':'+min;
		RenderedMin = min;
		RenderedHr = hr;*/
			}
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight	+'px';	
				var objTxt;
				objTxt = GetObjectReference('frmDiscussion','txtComments');
				if(objTxt!=null)
					objTxt.focus();
			}
		//added by Nilesh on 8/1/2015 for loader add on save link
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
      //endded by Nilesh on 8/1/2015 for loader add on save link
			function Save_OnClick()
            {    
               // debugger;
			    //added by Nilesh on 8/1/2015 for loader add on save link
			    var Mode = (arguments.length > 0) ? arguments[0] : "0";
			    if (Mode == "0")
			    {
                     
			        setFrameLoader();
			        document.body.readonly=true;
			        window.setTimeout('Save_OnClick("1")',1)            
			    }
			    if (Mode == "1")
			    {
			  //endded by Nilesh on 8/1/2015 for loader add on save link
			        var objTxt,strVal;
			        var intLength,flag;
			        //Added by VijayD on 17 Aug 2009 For Maintaing Search Filter on the Issue_Entry Page	
			        var QuerystringFilter="&IssueListSearchValue=<%=m_StrIssueListSearchValue%>&IssueListSearchType=<%=m_strIssueListSearchType%>";
			        //End Addition By VijayD    
			        objTxt = GetObjectReference('frmDiscussion','txtComments');
			        flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_COMMENTS_EMPTY")%>',true);
			        if(flag==true)
			        {
			            RemoveFrameLoader();
			            return;
			        }
                    //debugger;
			        flag = disallowMaxlengthViolation(objTxt,7000,'<%=MyBase.GetResourceString("MSG_COMMENTS_MAX_LENGTH")%>',true);
                    if (flag == true) {
                        //Added By Dipali V On 7th June 2019 For Saving Issue
                        RemoveFrameLoader();
                        return;
                        //End of Added By Dipali V On 7th June 2019 For Saving Issue
                    }   
			        //Added by GaneshD on 08 Jun 2009 For Issue Base StatusFlow configuration
			        var validStatusNew;
			        var validStatusExist;

			        var objOldStatus = GetObjectReference('frmDiscussion','txtStatusOld');
			        var objNewStatus = GetObjectReference('frmDiscussion','cboStatus');

			        var objCompareStatus = GetObjectReference('frmDiscussion','CmbStatus');
			        var objPrevStatus = GetObjectReference('frmDiscussion','CmbPrevStatus');
			        var objStatusFlowCount = <%=m_StatusFlowCount%>
			        var statusFlag=0;

			        validStatusNew = ""
			        validStatusExist = "\n\n";

			        if(objOldStatus.value != objNewStatus.value) //If condition Added By purvaj on 12 Aug 2009 validation done only when status changed
                    {
                        
			            if(objStatusFlowCount > 0)
                        {
                            
			                for(i=0;i<=objCompareStatus.length-1;i++)
                            {
                                //alert(i);
                                //alert(objCompareStatus.length-1);
			                    validStatusExist = validStatusExist + (i + 1)+ ". " +objCompareStatus[i].value + "\n"
			                }
                            //alert(validStatusExist);
			                for(i=0;i<=objCompareStatus.length-1;i++)
			                {
			                    if(objCompareStatus[i].value == objNewStatus[objNewStatus.selectedIndex].value)
			                    {
			                        validStatusNew = objNewStatus[objNewStatus.selectedIndex].value;
			                        break;
			                    }
			                }
                        		
			                if(validStatusNew == "")
                            {
                                
			                    if(validStatusExist =="\n\n")
			                    {
			                        alert("This is the last status configured in the status flow.");
			                    }
			                    else
			                    {
			                        alert("Invalid Status '" + objNewStatus.value +"', Status can be change to one of the following " + validStatusExist);
                                }
                               
			                    return false;
			                }
			            }
			        }
			        //Addition End by GaneshD
				
			        if (("<%=m_LoginType%>" != 'C') && ("<%=m_IsIssueSLAApplicable%>" == 'True'))
                    {
                       
			            //Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 	
			            //Code Added By PradipK on 24 Feb 2006
			            var objStatusTime = GetObjectReference('frmDiscussion','txtStatusChangeTime');
			            //var objStatusDate = GetObjectReference('frmDiscussion','dtStatusChangeDate');
			            var objStatusDate = GetObjectReference('frmDiscussion','dtStatusChangeDate');
						 
						
			            var objCurrentChangeDate=GetObjectReference('frmDiscussion','FFE29587WHIZ_dtStatusChangeDate');
			            var objCurrentDate = GetObjectReference('frmDiscussion','CurrentDate');
			            //alert(objCurrentDate.value);
			            var objCurrentTime = GetObjectReference('frmDiscussion','CurrentTime');
			            var objReportedDate = GetObjectReference('frmDiscussion','ReportedDate');
			            var objReportedTime = GetObjectReference('frmDiscussion','ReportedTime');
			            var objOldStatus = GetObjectReference('frmDiscussion','txtOldStatus');
			            var objNewStatus = GetObjectReference('frmDiscussion','cboStatus');
			            var objOldStatusChangeDate = GetObjectReference('frmDiscussion','OldStatusChangeDate');
			            var objOldStatusChangeTime = GetObjectReference('frmDiscussion','OldStatusChangeTime');

                        //Added By Reshma Chavan on 9th April 2021 For Save Issue
                        var ConvertTime;
                        var time = objOldStatusChangeTime.value;
                        
                        if (time.indexOf('AM') > -1 || time.indexOf('PM') > -1) {
                            var hours = Number(time.match(/^(\d+)/)[1]);
                            var minutes = Number(time.match(/:(\d+)/)[1]);
                            var AMPM = time.match(/\s(.*)$/)[1];
                            if (AMPM == "PM" && hours < 12) hours = hours + 12;
                            if (AMPM == "AM" && hours == 12) hours = hours - 12;
                            var sHours = hours.toString();
                            var sMinutes = minutes.toString();
                            if (hours < 10) sHours = "0" + sHours;
                            if (minutes < 10) sMinutes = "0" + sMinutes;
                            ConvertTime = sHours + ":" + sMinutes;

                            $("#OldStatusChangeTimeNew").val(ConvertTime);
                        }
                        else {
                            $("#OldStatusChangeTimeNew").val(time);
                        }

                        var objOldStatusConvertTime = document.getElementById('OldStatusChangeTimeNew');
                        ////End of Added By Reshma Chavan on 9th April 2021 For Save Issue
                        
                        


                      
			            if (objStatusDate!=null)
                        {
                            
                            if (disallowBlank(objStatusDate, "Status Change Date should not be blank.", true)) {
                                RemoveFrameLoader();
                                return;
                            }
                            
                        }
                       
			            if (objStatusTime!=null)
                        {
                            
                            if (disallowBlank(objStatusTime, "Status Change Time should not be blank.", true)) {
                                RemoveFrameLoader();
                                return;
                            }
                            if (isTime(objStatusTime, "<%=mybase.GetResourceString("INVALIDTIME",false)%>") == false) {
                                RemoveFrameLoader();
                                return;
                            }
			            }
			            // Validation: If Status is not changed,Then Disallow to Change Status Change Date & Status Change Time .
										
			            if(objOldStatusChangeDate.value!='' && objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime !=null && objStatusDate!=null && objStatusTime!=null && objCurrentDate!=null && objCurrentTime!= null) 
                        {
                           
			                if (objOldStatus.value==objNewStatus.value )
                            {
                               
			                    if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
			                    {
			                        alert('Status change date and/or time will be not be changed for this status!');
			                        if(objOldStatusChangeDate.value!=objStatusDate.value )
			                            setFocus(objStatusDate);
                                    if (objOldStatusChangeTime.value != objStatusTime.value)
                                    {
                                        setFocus(objStatusTime);
                                        RemoveFrameLoader();
                                        return;
                                    }
			                    }
			                    //else
			                    //{
			                    // Status,Status Change Date,Status Change Time not changed... 
			                    //}
			                }
			            }


			            //ShraddhaM
			            /*var dat=new Date(); 
                                    var hrs=dat.getHours();
                                    var mins=dat.getMinutes();
                                    var CurrentTime	;
                                    var TimeSpanMin;
                                    var TimeSpanHr;
                                    var TimeSpan;
                                    if (hrs<10)
                                        hrs='0'+hrs;
                                    if(mins<10)
                                        mins='0'+mins;
                                        
                                CurrentTime = hrs+':'+mins;	
        
        
                                TimeSpanMin = mins - RenderedMin;
                                TimeSpanHr = hrs - RenderedHr;
                                
                                if (TimeSpanMin < 0 )
                                    {
                                        TimeSpanHr = TimeSpanHr - 1
                                        if (TimeSpanHr < 10)
                                                {
                                                    TimeSpanHr = '0'+TimeSpanHr 
                                                }
                                                
                                        TimeSpanMin = 60+(TimeSpanMin) 
                                                    
                                        if (TimeSpanMin  < 10)
                                            {
                                                TimeSpanMin  = '0'+TimeSpanMin
                                            }
                                    }
                                else
                                    if (TimeSpanHr < 10)
                                                {
                                                    TimeSpanHr = '0'+TimeSpanHr 
                                                }
                                                
                                    if (TimeSpanMin  < 10)
                                            {
                                                TimeSpanMin  = '0'+TimeSpanMin
                                            }
                                            
                                TimeSpan = TimeSpanHr+':'+TimeSpanMin*/
		
		
			            var TempObjTime ;
			            //ShraddhaM
			            //Validation :Status Change Status Date & Time Can not Be Greater than Current Date & time.
			            if (objStatusDate!=null && objStatusTime!=null)
			            {
                             
			                if(objOldStatus.value!=objNewStatus.value || objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value  )
			                {
			                    /*var objTimehr,objTimeMin;
						objTimeMin = Right(objStatusTime.value,2);
						objTimehr =Left(objStatusTime.value,2);				
						
						if (objTimeMin < 10)
										{
											objTimeMin = Right(objTimeMin,1);
										}
									if (TimeSpanMin < 10)
										{
											TimeSpanMin = Right(TimeSpanMin,1);							
										}
										
									
									
									if (objTimehr < 10)
										{
											objTimehr = Right(objTimehr,1);
										}
										
									if(TimeSpanHr < 10)	
										{
											TimeSpanHr = Right(TimeSpanHr,1);
										}												
									
									
						objTimeMin = parseInt(objTimeMin) + parseInt(TimeSpanMin); 
						objTimehr = parseInt(objTimehr) + parseInt(TimeSpanHr);											
						
						if (objTimeMin >= 60 )
							{
								objTimeMin =  objTimeMin - 60
								objTimehr =  objTimehr + 1		
							}
						if (objTimeMin < 10 )
							{
									objTimeMin = '0' + objTimeMin ;
							}
						if (objTimehr < 10 )	
							{
								objTimehr = '0' + objTimehr;
							}			
							
						if (objTimehr >= 24)	
							{
								objTimehr = parseInt(objTimehr) - 24;	
								//objDate = GetObjectReference('frmRequestDetails','CurrentDate1');
								objDate = GetObjectReference('frmDiscussion','CurrentDate1');
								
								var TempObjDate  = objDate.value;
								var StatusDate = new Date(objDate.value);									
									StatusDate = DateAdd(StatusDate,1,0,0);		
									
																												
									var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");																											 									
								
									StatusDate = StatusDate.getDate() + ', ' + Left(strMonths[StatusDate.getMonth()],3) + ' ' + StatusDate.getFullYear();  																																		
								
									StatusDate = GetDateInFormat(StatusDate,'dd, MMM yyyy');
									
									objDate.value = StatusDate 
								
								if (objTimehr < 10 )	
									{
										objTimehr = '0' + objTimehr;
									}										
								
							}
						
					
						objCurrentTime.value = objTimehr +':'+objTimeMin;*/
						
			                    if(objStatusDate!=null && objStatusTime!=null && objCurrentDate!=null && objCurrentTime!=null )
                                {
                                 
                                    if (disAllowDateTime1GreaterThanDateTime2(objStatusDate, objStatusTime, objCurrentDate, objCurrentTime, 'Status Change Date & Time should not be greater than Current Date & Time.'))
                                    {
                                        RemoveFrameLoader();
                                        return;
                                    }
			                    }
			                    //Validation :Status Change Status Date & Time Can not Be Less than Reported Date & time.

									
									
									
			                    if(objStatusDate!=null && objStatusTime!=null && objReportedDate!=null && objReportedTime!=null )
                                {
                                  
                                    if (disAllowDateTime1GreaterThanDateTime2(objReportedDate, objReportedTime, objStatusDate, objStatusTime, 'Status Change Date & Time should not be less than Reported Date & Time.')) {
                                        RemoveFrameLoader();
                                        return;
                                    }
			                    }
							
			                    //var objStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_dtStatusChangeDate');
									
			                    //alert(objOldStatusChangeDate.value);
			                    //alert(objStatusDate.value);
			                    //Validation :Status Change Status Date & Time Can not Be Less than Previous Status Change Date & Time.
			                    if (objOldStatus.value!=objNewStatus.value )
                                {
                                     
			                        if(objStatusDate!=null && objStatusTime!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime!=null )
			                        {
			                            if(objOldStatusChangeDate.value!="" && objOldStatusChangeTime.value!="" && objStatusDate.value!="" && objStatusTime.value!="" )
			                            {
                                           
                                            if (objOldStatusChangeDate.value == objStatusDate.value && objOldStatusChangeTime.value == objStatusTime.value) {
                                                alert("Status Change date & time should be greater than previous status Change date and time.");
                                                setFocus(objStatusTime);
                                                RemoveFrameLoader();
                                                return;
                                            }
                                            else {
                                                
                                              //Commented and Added By Reshma Chavan on 9th April 2021 For Save Issue
                                                //if (disAllowDateTime1GreaterThanDateTime2(objOldStatusChangeDate, objOldStatusChangeTime, objStatusDate, objStatusTime, 'Status Change date & time should be greater than previous status Change date and time.')) {                                                    
                                                if (disAllowDateTime1GreaterThanDateTime2(objOldStatusChangeDate, objOldStatusConvertTime, objStatusDate, objStatusTime, 'Status Change date & time should be greater than previous status Change date and time.')) {                                                    
                                                    RemoveFrameLoader();
                                                    return;
                                                }
                                                //End of Added By Reshma Chavan on 9th April 2021 For Save Issue
                                               
                                            }
                                            
			                            }
			                        }
                                }
                                
			                }

			            }
			            //End Addition By PradipK on 24 Feb 2006
                    }//End of modification by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
                    
			        if(flag==false)
			        {
			            //Added by MrugajaB for WhizibleSEM SP7
			            //objform.action = "IB_Discussion.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&IssueID=<%=m_lngIssueID%>";
			            objform.action = "IB_Discussion.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&IssueID=<%=m_lngIssueID%>&PageNumber=<%=request("PageNumber")%>&OrderBy=<%=request("OrderBy")%>&ASCDESC=<%=request("ASCDESC")%>&IssueNavigation=<%=request("IssueNavigation")%>";																				
			            //End Addition
                        
                        objform.submit();
                        
			            var openerHref = window.opener.location.href; 
			          
			        
			        //Integrated by MrugajaB for Whiziblesem SP7 Issue ID.4518 on 29th June 2006
			        //Integrated by SavitaS on 25 May 2006 for FourSoft IssueID 2002
			        //Added by ShubhadaL on 23 Feb 2006 for FourSoft - 927
			        // ShowToCustomer Checkbox goes blank when parent gets refreshed from DiscussionThread_Save click
			        openerHref += "&IsCustomerChecked=<%=m_Customer%>";
			        //End of addition by ShubhadaL on 23 Feb 2006 foe FourSoft - 927
			        //End Integration by SavitaS
			        //End Integration
			        window.opener.location.href= openerHref ; 
			        //Modified By ShraddhaM on 25 July 2006 for WhizibleSEM
			        //alert(window.opener.name);
								
			        if (window.location.href.indexOf('OrderBy=IssueID') >= 1)
			        {
			            //Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
			            //window.opener.location.href= "IB_IssueEntry.aspx?IssueNavigation=<%=request("IssueNavigation")%>&Mode=Edit&IssueID=<%=m_lngIssueID%>&PageNumber=<%=request("PageNumber")%>&ASCDESC=<%=request("ASCDESC")%>&OrderBy=<%=request("OrderBy")%>" ;  									
			            //Modified by SavitaS on 03 Sept 2006 for SP7 IssueID 6494 (Added m_strFromwhere variable in querystring)		
			            // Integrated by ArchanaN on 26 Apr 2006
			            //window.opener.location.href= "IB_IssueEntry.aspx?IssueNavigation=<%=request("IssueNavigation")%>&Mode=Edit&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&PageNumber=<%=request("PageNumber")%>&ASCDESC=<%=request("ASCDESC")%>&OrderBy=<%=request("OrderBy")%>&Fromwhere=<%=m_strFromwhere%>&FromReview=<%=m_strFromReview%>" ;  		
			            //Added by SrikanthY to Pass Parent Query's token if the discussion page called from Issue list of Request Screen
									
			            //Added Byu VijaYD On 17 Aug 2009 fOR Search Filter On On Issue Page
			            //window.opener.location.href= "IB_IssueEntry.aspx?IssueNavigation=<%=request("IssueNavigation")%>&Mode=Edit&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&PageNumber=<%=request("PageNumber")%>&ASCDESC=<%=request("ASCDESC")%>&OrderBy=<%=request("OrderBy")%>&Fromwhere=<%=m_strFromwhere%>&FromReview=<%=m_strFromReview%>&QueryToken=<%=m_PKQueryToken%>&QueryID=<%=m_Queryid%>";
			            window.opener.location.href= "IB_IssueEntry.aspx?IssueNavigation=<%=request("IssueNavigation")%>&Mode=Edit&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&PageNumber=<%=request("PageNumber")%>&ASCDESC=<%=request("ASCDESC")%>&OrderBy=<%=request("OrderBy")%>&Fromwhere=<%=m_strFromwhere%>&FromReview=<%=m_strFromReview%>&QueryToken=<%=m_PKQueryToken%>&QueryID=<%=m_Queryid%>"+QuerystringFilter; 
			            //End Addition By 17 Aug 2009
									 
			            //End of Addition by SrikanthY
			            // Integration Ends

			            //End of Modified by SavitaS on 03 Sept 2006 for SP7 IssueID 6494
			            //End of Commented and Modified by SavitaS on 19 Sept 2006 for Security Issue 6197
			        }
			            //Added by MonikaI. IssueID : 3926
			        else if(window.location.href.indexOf('FromWhere=DB')>=1)
			        {
			            //Commented and Modified By JyotiG
			            //Purpose : Developer Dashboard enhanced View
			            //Date : 18-Oct-2006
			            //Start
			            //window.opener.location.href= "../DB/DB_WhizibleToday.aspx?PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>" ;
			            if(window.location.href.indexOf('Dashboard=DEV')>=1)
			                window.opener.location.href= "../DB/DB_WhizibleToday.aspx?Dashboard=DEV&PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>" ;									
			            else
			                window.opener.location.href= "../DB/DB_WhizibleToday.aspx?Dashboard=PMDB&PageNumberPM=<%=request("PageNumberPM")%>&PageNumberIB=<%=request("PageNumberIB")%>&PageNumberDEL=<%=request("PageNumberDEL")%>&PageNumberRV=<%=request("PageNumberRV")%>" ;
			            //End of modification By JyotiG
			            //Added by MonikaI on 13th Oct 2006 IssueID : 6883
			            //window.close();
			            //End of addition by MonikaI
			        }
			            //End by MonikaI
			        else
			        {
			            //Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
			            //window.opener.location.href= "IBIssueList.aspx?PageNumber=<%=request("PageNumber")%>" ;
			            //Commented and Modified by MonikaI on 10th Oct 2006 IssueID : 6881
			            //window.opener.location.href= "IBIssueList.aspx?PageNumber=<%=request("PageNumber")%>&PKToken=<%=m_strToken%>" ;
			            // Integrated by ArchanaN on 26 Apr 2006
			            //Added by SrikanthY on 20 Dec 2006 topass query details if it called from Dashboard
			            if(window.location.href.indexOf('Fromwhere=HDASH')>=1)
			            {
			                //window.opener.location.href= "../CRM/CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&PKToken=<%=m_strToken%>&QueryID=<%=m_Queryid%>" ;
			                //window.opener.location.href= "../CRM/CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&PKToken=<%=m_PKQueryToken%>&QueryID=<%=m_Queryid%>" ;
			                window.opener.location.href= "../CRM/CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&PKToken=<%=m_PKQueryToken%>&QueryID=<%=m_Queryid%>&SortBy=<%=m_QuerySortBy%>&SortOrder=<%=m_QuerySortOrder%>" ;
			            }
			            else
			            {
			                //Commented and Added By VijayD On 18 August 2009
			                //window.opener.location.href= "IBIssueList.aspx?PageNumber=<%=request("PageNumber")%>&PKToken=<%=m_strToken%>&QueryID=<%=Session("intQueryID")%>"+QuerystringFilter; 
			                window.opener.location.href= "IBIssueList.aspx?PageNumber=<%=request("PageNumber")%>&PKToken=<%=m_strToken%>&QueryID=<%=Session("intQueryID")%>"+QuerystringFilter; 
			                //End Comment and Addition By VijayD On 18 August 2009
			            }
			            //End of Addition by SrikanthY
			            // Integration Ends

								
			            //End by MonikaI
			            //opener.location.href = opener.location.href;
			            //End of Commented and Modified by SavitaS on 19 Sept 2006 for Security Issue 6197 
			        }
					
			        //End Addition
			        //Integrated by SnehalV BFT Patch Integration as on 4th Oct 06
			        //Added By AmitJ For IssueId 3311 :
			        // Problem with issues with attachmnent
			        if (openerHref.indexOf('&AttachmentID') >= 1)
			        {
			            var Startpos;
			            var Endpos;							
			            Startpos=openerHref.indexOf('&AttachmentID');							
			            Endpos = openerHref.indexOf('&',Number(Startpos)+1);											
			            openerHref = replaceSubstring(openerHref,openerHref.substr(Startpos,Number(Endpos)- Number(Startpos)),'');
			        }

			        //End of Addition
			        //end of integration
	            	}
			    }


			}
                
		    
			
				// Added By PradipK on 13 March 2006 for SLA Management
			function Status_Onchange()
			{
			
			/*var objStatusTime = GetObjectReference('frmDiscussion','txtStatusChangeTime');
				var objStatusDate = GetObjectReference('frmDiscussion','dtStatusChangeDate');
				var WhizobjStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_dtStatusChangeDate');
				
	
				var objCurrentDate = GetObjectReference('frmDiscussion','CurrentDate');
				var WhizobjCurrentDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_CurrentDate');
				
				var objOldStatusChangeDate = GetObjectReference('frmDiscussion','OldStatusChangeDate');
				var WhizobjOldStatusChangeDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_OldStatusChangeDate');
				
				var objOldStatusChangeTime = GetObjectReference('frmDiscussion','OldStatusChangeTime');
				var objOldStatus = GetObjectReference('frmDiscussion','txtOldStatus');
				var objNewStatus = GetObjectReference('frmDiscussion','cboStatus');*/
				
			 
			var objStatusTime= GetObjectReference('frmDiscussion','txtStatusChangeTime');
			var objStatusDate=GetObjectReference('frmDiscussion','dtStatusChangeDate'); //dtStatusChangeDate
			  
			//var objCurrentDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_CurrentDate');
			if(navigator.appName == 'Netscape')
			{
			 
			var objCurrentDate=window.document.forms['frmDiscussion'].elements['CurrentDate'];
			}
			else
			{
				var objCurrentDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_CurrentDate');
			}
				//var objCurrentDate = GetObjectReference('frmDiscussion','CurrentDate');
				//var objWhizStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDate');
				var objWhizStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_dtStatusChangeDate');
				
				var objOldStatusChangeDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_OldStatusChangeDate');
				var objOldStatusChangeTime = GetObjectReference('frmDiscussion','OldStatusChangeTime');
				var objNewStatus = GetObjectReference('frmDiscussion','cboStatus');
				var objOldStatus = GetObjectReference('frmDiscussion','txtOldStatus');
				var d=new Date(); 
				var h= d.getHours();
				var m= d.getMinutes();		
	
				//Added By Amit J for PSPL IssueId  22880
				// Get StatusChangeTimeSpan = CurrentTime(clientTime)@(cboStatus_OnChange) - RenderedTime@(Windows_OnLoad)
				var StatusChangeTimeSpanHr;
				var StatusChangeTimeSpanMin;
				var StatusChangeTimeSpan;
	
				objTime=GetObjectReference('frmDiscussion','CurrentTime');
				TempObjTime = objTime.value		
			 
				/*var objTimehr,objTimeMin;
				objTimeMin = Right(objTime.value,2);
				objTimehr =Left(objTime.value,2);
	
				StatusChangeTimeSpanHr = h - RenderedHr;	
				StatusChangeTimeSpanMin = m - RenderedMin;	
			
				//StatusChangeTimeSpanHr = objTimehr - RenderedHr;	
				//StatusChangeTimeSpanMin = objTimeMin - RenderedMin;	
			
				if (StatusChangeTimeSpanMin < 0)
				{
					StatusChangeTimeSpanHr = StatusChangeTimeSpanHr - 1;
					if (StatusChangeTimeSpanHr < 10)
							{
							StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
							}
						
					StatusChangeTimeSpanMin = 60+(StatusChangeTimeSpanMin) ;
							
					if (StatusChangeTimeSpanMin  < 10)
					{
						StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
					}
				}
				else
					if (StatusChangeTimeSpanHr < 10)
						{
							StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
						}
						
					if (StatusChangeTimeSpanMin  < 10)
						{
							StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
						}
					
				StatusChangeTimeSpan = StatusChangeTimeSpanHr +':'+ StatusChangeTimeSpanMin;	
				//alert('StatusChangeTimeSpan'+StatusChangeTimeSpan);
		
		
		
				var objTimehr,objTimeMin;
				objTimeMin = Right(objTime.value,2);
				objTimehr =Left(objTime.value,2);
			
				//alert('objTimeMin'+objTimeMin);
				//alert('objTimehr'+objTimehr);
	
				StatusChangeTimeSpanHr = h - RenderedHr;	
				//alert('StatusChangeTimeSpanHr'+StatusChangeTimeSpanHr);
			
				StatusChangeTimeSpanMin = m - RenderedMin;	
				//alert('StatusChangeTimeSpanMin'+StatusChangeTimeSpanMin);
			
				//
				if (StatusChangeTimeSpanMin < 0)
				{
					StatusChangeTimeSpanHr = StatusChangeTimeSpanHr - 1;
					if (StatusChangeTimeSpanHr < 10)
							{
							StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
							}
						
					StatusChangeTimeSpanMin = 60+(StatusChangeTimeSpanMin) ;
							
					if (StatusChangeTimeSpanMin  < 10)
						{
						StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
						}
				}
				else
					if (StatusChangeTimeSpanHr < 10)
						{
							StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
						}
						
					if (StatusChangeTimeSpanMin  < 10)
						{
						StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
						}
					
				//
			
			
					objTimehr=Number(objTimehr)+Number(StatusChangeTimeSpanHr);
					if(objTimehr<10)
					{
						objTimehr='0'+objTimehr;
					}
					//alert(objTimehr);
			
					objTimeMin=Number(objTimeMin)+Number(StatusChangeTimeSpanMin);
					if(objTimeMin<10)
					{
						objTimeMin='0'+objTimeMin;
					}
					//alert(objTimeMin);
			
		//End of Addition;	
			//}//End of else
					//alert(objCurrentDate.value);
					if(navigator.appName == 'Netscape')
					{
						var objCurrentTime=window.document.forms['frmDiscussion'].elements['CurrentTime'];
					}
					else
					{ 
						var objCurrentTime=GetObjectReference('frmDiscussion','CurrentTime');			
					}
					//alert(objCurrentTime.value);
					//var objWhizStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDate');
					var objWhizStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_dtStatusChangeDate');
					//var objWhizStatusDate=window.document.forms['frmDiscussion'].elements['FFE29587WHIZ_txtchangedDate'];
					 
					//alert(objWhizStatusDate);
					//var objOldStatusChangeDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDatehidden1');
					//var objOldStatusChangeDate = GetObjectReference('frmDiscussion','txtchangedDatehidden1');
					if(navigator.appName == 'Netscape')
					{
						var objOldStatusChangeDate=window.document.forms['frmDiscussion'].elements['OldStatusChangeDate'];
					}
					else
					{
						var objOldStatusChangeDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_OldStatusChangeDate');
					}
					// txtchangedDatehidden1 
					//alert(objOldStatusChangeDate.value);
					//var objOldStatusChangeTime = GetObjectReference('frmDiscussion','txtchangedTimehidden1');
					//frmRequestDetails
					//var objOldStatusChangeTime = GetObjectReference('frmRequestDetails','txtchangedTimehidden1');
					if(navigator.appName == 'Netscape')
					{
						var objOldStatusChangeTime=window.document.forms['frmDiscussion'].elements['OldStatusChangeTime'];
					}
					else
					{
						var objOldStatusChangeTime = GetObjectReference('frmDiscussion','OldStatusChangeTime');	
					}
						//alert(objOldStatusChangeTime.value);
						//modification by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
					var objNewStatus = GetObjectReference('frmDiscussion','cbostatus');
					//end of modification by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
					//not getting value of new status.......................
					//alert('n'+objNewStatus.value);
					var objOldStatus = GetObjectReference('frmDiscussion','txtOldStatus');
					var d=new Date(); 
					var h=d.getHours();
					var m=d.getMinutes();
					var objReadOnlychangedDate = GetObjectReference('frmDiscussion','txtReadOnlychangedDate');
					if (h<10)
					h='0'+h;
					if(m<10)
					m='0'+m;			*/	
				var objReadOnlychangedDate = GetObjectReference('frmDiscussion','txtReadOnlychangedDate');
				if(objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime !=null && objStatusDate!=null && objStatusTime!=null ) 
				{
					if (objOldStatus.value==objNewStatus.value )
					{
						if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
						{
						//objStatusDate.value=objOldStatusChangeDa alert(objOldStatusChangeDate.value);
							objWhizStatusDate.value=objOldStatusChangeDate.value;
							objStatusTime.value=objOldStatusChangeTime.value;
							if(objReadOnlychangedDate!=null)
							objReadOnlychangedDate.value=objOldStatusChangeDate.value;
						}
					}
					else
					{
					 
							 
							objStatusDate.value=objCurrentDate.value;
							 
							objStatusDate.value = GetObjectReference('frmDiscussion','CurrentDate').value;
							 
							//addition by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
							if (objWhizStatusDate!=null)
							//end of addition by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
							objWhizStatusDate.value=objCurrentDate.value;
							objStatusTime.value=objTime.value;
							
							//objStatusTime.value=objTime.value+StatusChangeTimeSpan;
							 
							if(objReadOnlychangedDate!=null)
							objReadOnlychangedDate.value=objCurrentDate.value;

					}
				}    	 
			
				//Added by PrashantD on 14 April 2006 for SLA
				/*if ((objStatusDate!= null) && (objStatusTime!= null))
				{
					if (objOldStatus.value==objNewStatus.value )
					{
					objStatusDate.value =GetObjectReference('frmRequestDetails','txtchangedDatehidden1').value;
					objStatusTime.value = GetObjectReference('frmRequestDetails','txtchangedTimehidden1').value;
					}
					else 
					{
								if(navigator.appName == 'Netscape')
								{
									//objStatusDate.value = GetObjectReference('frmRequestDetails','CurrentDate').value;
										var objCurrentDate=window.document.forms['frmDiscussion'].elements['CurrentDate'];
									//	alert(objCurrentDate.value);
										objStatusDate.value = GetObjectReference('frmDiscussion','CurrentDate').value;
									//objStatusTime.value=h+':'+m;
								
									//Added by AmitJ For PSPL IssuId - 22880									
									// CurrentTime(servertime)@(cboStatus_OnChange)= StatusChangeTimeSpan + CurrentTime(ServerTime)@(Window_Onload)			
									objStatusTime.value = GetObjectReference('frmRequestDetails','CurrentTime').value;									
								
									var StatusHr;
									var StatusMin;					
									var StatusTime;		
								
									StatusHr = 	Left(objStatusTime.value,2);
									StatusMin = Right(objStatusTime.value,2);					
								
									if (StatusHr < 10)
										{
											StatusHr = Right(StatusHr,1);
										}
									if(StatusMin < 10)
										{
											StatusMin = Right(StatusMin,1);
										}
									
									StatusHr = parseInt(StatusHr)+ parseInt(StatusChangeTimeSpanHr);
									StatusMin = parseInt(StatusMin)	 + parseInt(StatusChangeTimeSpanMin);					
								
								
										if (StatusMin >= 60)
										{
											StatusMin = parseInt(StatusMin) - 60 ; 							
											StatusHr = parseInt(StatusHr) + 1 ;
									
										}	
										if (StatusMin < 10)
											{
												StatusMin = '0' + StatusMin;								
											}	
											
										if (StatusHr < 10)		
											{
												StatusHr = '0' + StatusHr;
											}
										
										if (StatusHr >= 24)
											{
												StatusHr = parseInt(StatusHr) - 24;	
												if (StatusHr < 10)		
													{
														StatusHr = '0' + StatusHr;
													}									
												objStatusDate.value = GetObjectReference('frmDiscussion','CurrentDate1').value;
												var StatusDate = new Date(objStatusDate.value);									
												StatusDate = DateAdd(StatusDate,1,0,0);																												
												var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");																											 																		
												StatusDate = StatusDate.getDate() + ', ' + Left(strMonths[StatusDate.getMonth()],3) + ' ' + StatusDate.getFullYear();  																																											
												StatusDate = GetDateInFormat(StatusDate,'dd, MMM yyyy');									
												objStatusDate.value = StatusDate 
											}										
				 					objStatusTime.value = StatusHr+':'+StatusMin;  
							 		
									//End of Addition by AmitJ
								}
							}
				}
				else
				{			
					objStatusDate.value = GetObjectReference('frmDiscussion','CurrentDate').value;
					//objStatusTime.value=h+':'+m;
					objStatusTime.value=objTime.value;
				}*/
				//Modified by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
				//if ("<%=m_LoginType%>" != 'C')
				//{
				/*var objStatusTime = GetObjectReference('frmDiscussion','txtStatusChangeTime');
				var objStatusDate = GetObjectReference('frmDiscussion','dtStatusChangeDate');
				var WhizobjStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_dtStatusChangeDate');
				
	
				var objCurrentDate = GetObjectReference('frmDiscussion','CurrentDate');
				var WhizobjCurrentDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_CurrentDate');
				
				var objOldStatusChangeDate = GetObjectReference('frmDiscussion','OldStatusChangeDate');
				var WhizobjOldStatusChangeDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_OldStatusChangeDate');
				
				var objOldStatusChangeTime = GetObjectReference('frmDiscussion','OldStatusChangeTime');
				var objOldStatus = GetObjectReference('frmDiscussion','txtOldStatus');
				var objNewStatus = GetObjectReference('frmDiscussion','cboStatus');
				
				///
				
				
				///
				var d=new Date(); 
				var h=d.getHours();
					var m=d.getMinutes();
	
				//alert(objCurrentDate.value);

				if (h<10)
					h='0'+h;
				if(m<10)
					m='0'+m;
				if(objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime !=null && objStatusDate!=null && objStatusTime!=null ) 
					{
						if (objOldStatus.value==objNewStatus.value )
						{
							if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
							{
																	    
								objStatusDate.value=objOldStatusChangeDate.value;
								WhizobjStatusDate.value= WhizobjOldStatusChangeDate.value;
								objStatusTime.value=objOldStatusChangeTime.value;
							}
						}
						else
						{
							objStatusDate.value=objCurrentDate.value;
							//Added by MrugajaB for WhizibleSEM SP7
							//Purpose:To select current date in DT Status change Date
							WhizobjStatusDate.value=WhizobjCurrentDate.value;
							//End Addition
							objStatusTime.value=h+':'+m
	
					}
				}  */
			//}// End of by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
			}
			//End Addition By PradipK on 13 March 2006 for SLA Management
		</Script>
</html>

<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>


<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
     /*Added by Kiran for Loader 2/11/15*/
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
        width: 100px;
        height: 100px;
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
   
    /*Added by Kiran for Loader 2/11/15*/

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
