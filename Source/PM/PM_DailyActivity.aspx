<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_DailyActivity.aspx.vb" Inherits="PbNIT.PM_DailyActivity" EnableEventValidation="false" %>
<!DOCTYPE HTML>
<HTML>
	
        <!--Including files & Libraries by Miiint Solutions-->
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>

		
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta http-equiv="X-UA-Compatible" content="IE=5,8,9,11">
		<meta http-equiv="X-UA-Compatible" content="chrome=1">
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
		<meta charset="UTF-8">
		
		<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
		<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
		<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    
	<% MyBase.InitializeResources("AppResources.PM_DailyActivity", "AppResources") %>
	
     <!-- Code Added by swapnil a on 17-06-2015 Purpose:TimesheetResponsive-->
    <style type="text/css">
        .ui-datepicker 
        {
            width: 98%;
            padding: .2em .2em 0;
            display: none;
            background-color:white;
        }
    pre { margin: 0; }
        .ui-state-default, .ui-widget-content .ui-state-default
        {
            font-weight: normal;
        }
        .ui-jqgrid .ui-jqgrid-htable th div {overflow: hidden; position:relative; height:37px;}
        #jqgh_ProjectlistGrid_Work
        {
            padding-top:10px;
            }
        #jqgh_ProjectlistGrid_ActualWork{padding-top:10px;}
        #jqgh_ProjectlistGrid_TaskName{padding-top:10px;}
       
         #FFE29587WHIZ_txtDate
        {
            padding-top:0px !important;
        }
        /*Added by Nilesh g on 5/12/2015 for issue id 2629*/
        table
        {
            width:100% !important;
        }
          body {
             border: none!important; 
             margin-left: 0px!important; 
             margin-right: 0px!important; 
        }
          /*Added By Vaijat K ON 31/12/2015*/
        .center-caption {
            /*margin-top: 15%;*/
            text-align: center;
            width: 100%;
        }
        #DivCustomTimeSheet {
            margin-top : 0px !important;
        }
         body {
         font-size:12px !important;
     }
     table td {
         font-size:12px !important;
     }
        /*ENDED*/
    </style>
     <!-- Ended by swapnil a on 17-06-2015 Purpose:TimesheetResponsive-->
	<script type="text/javascript">
		//code shifted to declare dblPreviousHours before PageInit() method
		  var dblPreviousHours=0;
	</script>  

    <script type="text/javascript">
      
        //$(function () {
           
        //    $('nav#menu').mmenu();
            
        //    //  $("#mm-0").before("<div style='width:100%;height:100%;background:#FDF4E8'></div>");
        //    jQuery("#mm-0").before("<div style='width:100%;height:100%;background-image: url(../../img/1920/OpenVCE-Poster-Gold-Background.jpg);'> <table style='margin-left:10%'><tr><td> <img id='imgEmployee'  src='../../img/1920/no-photo.png' alt='No Image' style='margin-top:20px;width:75px;height: 75px;margin-right: 9%;' align='right' /></td><td><label id='cpName' style=color='white';font-weight:100' class='cpHome'></label><br><label id='cpRole' style='font-weight:100' class='cpHome'></label> </td></tr></table> </div>")
        //    $.ajax({
        //        type: 'POST',
        //        dataType: 'JSON',
        //        contentType: 'application/json',
        //        url: '../General/Navigation.aspx/GetEmployeeImagePath',
         //       data: JSON.stringify({ intEmployeeID: "<%=Session("intUserID")%>" }),
        //        success: function (Result) {
        //            if (String(Result.d) != "") {
        //                document.getElementById("imgEmployee").src = Result.d;
        //            }
        //    }
        //});
           // $('#cpName').text('<%=Session("strUserName")%>');
           // $('#cpRole').text('<%=Session("RoleDesc")%>');
        //});
        //function logout()
       // {
        //    window.location.href = '<%= ResolveUrl("../../default.aspx") %>';
       // }
        //$(document).ready(function(){ 
        //    $("a").click(function () {
                  
        //    $.ajax({
        //        url: "../Home/MultipleLogin.aspx", success: function (result) {
                  
        //        }
        //    });
        //});});
       // $(document).ready(function(){
           
           // $("#txtHours").blur(function(){
                //Hours_OnChange('<%=EXPIRY_OF_TASK%>','<%=EXPIRY_OF_TASK_FORWARD%>','<%=m_blnProjectBackdateEntry%>','<%=m_blnProjectFwddateEntry%>')
           // });
       // });
    </script>
    
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
      
					<form id="DA" name="DA" method="post" runat="server">   
                         <div id="MainDiv" style="float: left; width: 100%;">
                              <% If Session("Mobile") <> "Mobile" Then%>
                                  <%PageInit()%>
                             <% End If  %>	
            </div>                    
             </form>
			 
       
        <script type="text/javascript">
            
						var objdivlist;
			            var objform;
			            var dblAllocatedHours=0;
			            var dblActualHours=0;		
			            var	intTaskComplete=0;
			            var dtmStartDate=0;
			            var dtmEndDate=0;
			            var IsHoliday =0;
			            var para = {};
			            var strTaskType=""
			            var blnSaveClicked = false;
			            var blnHaveSubTaskType = '<%=m_blnHaveSubTaskTypes%>';
					
			
					    // Code Added by swapnil a on 17-06-2015 Purpose:TimesheetResponsive
					    //jQuery(document).ready(function ()
					   // { 
                          
					        //if ($(window).width() <= 768) {
					            //$('#lbl_user').text('<%=Session("strUserName")%>'+ "("+ '<%=Session("RoleDesc")%>'+ ")");
					      
					      
					            //var intDivHeight = window.innerHeight - 411 ;
					            //if (intDivHeight < 257)
					            //    intDivHeight =247;

					            //$("#divMenuContent").css("height",intDivHeight + 'px');
					            ///*Ended*/
					      
					            //para={intUserID:'<%=Session("intUserID")%>',strLoginType:"E"};
					    //    GetProjectListForEmployee();
					    //    }
					      
					      
					    //});
					    //function GetProjectListForEmployee()
					    //{      
					    //    try {
                                
					    //        $.ajax({
					    //            type: "GET", //GET or POST or PUT or DELETE verb
					    //            url: path+"GetProjectListForTimesheet", // Location of the service
					    //            data: para,
					    //            contentType: "application/json;charset=utf-8", // content type sent to server
					    //            dataType: "jsonp", //Expected data format from server
					    //            success: function (data) {//On Successfull service call 
					    //                $("#DDLProject").append("<option value='0' selected='selected'>Select Project</option>");
					    //                $("#DDLTask").append("<option value='0' selected='selected'>Select Task</option>");
					    //                $.each(JSON.parse(data), function (id, obj) 
					    //                { 
					    //                    $("#DDLProject").append("<option value="+obj.ProjectID+">"+obj.ProjectName+"</option>");
                                      
					                       
                               
					    //                });
                                    
                        
					    //            },
					    //            error: function (xhr) {
					    //                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

					    //            }
					    //        });
					    //        document.getElementById("DDLProject").value = "0";
					    //    } catch (exception) { }

					    //}
					    //$(window).resize(function(){
					    //    /*Added By Vaijat K ON 31/12/2015*/
					    //    var intDivHeight = window.innerHeight - 411;
					    //    if (intDivHeight < 257)
					    //        intDivHeight =257;
					    //    $("#divMenuContent").css("height",intDivHeight + 'px');
					    //    /*Ended*/
					    //});
            
					    // Ended by swapnil a on 17-06-2015 Purpose:TimesheetResponsive 	
					    function getFormattedDate(date)
					    {
					        var today = date;
					        var dd = today.getDate();
					        var mm = today.getMonth()+1; //January is 0!

					        var yyyy = today.getFullYear();
					        if(dd<10){
					            dd='0'+dd
					        } 
					        if(mm<10){
					            mm='0'+mm
					        } 
					        dateFormat = dd+'/'+mm+'/'+yyyy;

					        document.getElementById("DivDAYTimeSheet").innerHTML = "<b>"+dateFormat+"</b>";
					       

					    }

					    /*******  Bind Project  *******/
					    function BindProject(Date)
					    {
					        // AJAX CALL TO PAGE AND BIND LIST TO DROPDOWN
					   
					        url= "Action=GETPROJECTTIMESHEET";   
					        result1 = ValidateData(url,0,0,0,0); 
					    }

                       

			function TaskClick(blnShowSubTaskTypes, intSubTaskTypeID)							
			{//debugger;
				objForm = GetFormReference('DA');
				objcboTask = GetObjectReference('DA', 'cboTask');
				objDivCode = GetObjectReference('DA', 'DivCode');
				objchkCompleteTask = GetObjectReference('DA', 'chkCompleteTask');
				objlblTaskName = GetObjectReference('DA', 'lblTaskName');
				objtxtActualPercentComplete = GetObjectReference('DA', 'txtActualPercentComplete');
				var strETCValue = "";
				var strTaskInfo;

				if (objcboTask.value != "")
				{
					strTaskInfo = objcboTask.value.split("|");
					
					strTaskType = strTaskInfo[0];
					intTaskID = strTaskInfo[1];
					dblAllocatedHours = strTaskInfo[2];
					dblActualHours = strTaskInfo[3];		
					intTaskComplete = strTaskInfo[5];
					dtmStartDate = GetDateInFormat(strTaskInfo[6], "MMM, dd yyyy");
					dtmEndDate = GetDateInFormat(strTaskInfo[7], "MMM, dd yyyy")
					dblActualPercentComplete = strTaskInfo[8];
					
					// Display the Selected Task on the label below the Task combobox.
					objlblTaskName.innerHTML = "Selected Task : " + objcboTask.options[objcboTask.selectedIndex].text;
					
					//Modified Code For IssueID - 542 - SP4
					//Cannot add ETC for completed tasks	
					if ((strTaskType == "M" || strTaskType == "O") && intTaskComplete=="0")
					{
						//Display the ETC textbox.
						dblAllocatedHours = dblAllocatedHours - 0;
						dblActualHours = dblActualHours - 0;
						strHTML = '<%=MyBase.GetResourceString("ETC_MESSAGE1")%><B>' + dblAllocatedHours.toFixed(2) + '</B> &nbsp;&nbsp;<%=MyBase.GetResourceString("ETC_MESSAGE2")%> <B>' + dblActualHours.toFixed(2) + '</B>&nbsp;<BR> <%=MyBase.GetResourceString("ETC_MESSAGE3")%>';
						//strHTML = " Allocated Work (hrs): <B>" + dblAllocatedHours.toFixed(2) + "</B> &nbsp;&nbsp;Actual Work (hrs): <B>" + dblActualHours.toFixed(2) + "</B>&nbsp;<BR> Do you need more than the allocated time to complete this task? ";
						//strHTML = strHTML + '<BR> If yes, enter the additional estimated time to complete (ETC) <Input Type=TextBox maxlength=4 class=clsTextBox name=txtETC value='" + strETCValue + "' style='width:30;text-align:Right'>";
						strHTML = strHTML + '<%=MyBase.GetResourceString("ETC_MESSAGE4")%>';
						strHTML = strHTML + "<Input Type=TextBox maxlength=5 class=clsTextBox name=txtETC value='" + strETCValue + "' style='width:45;text-align:Right'>";
						strHTML = strHTML + "<BR> <%=MyBase.GetResourceString("START_DATE")%> <I>" + dtmStartDate + "</I> &nbsp;&nbsp; <%=MyBase.GetResourceString("END_DATE")%> <I>" +  dtmEndDate + "</I>&nbsp;";
						strETCValue = "";
						
						objDivCode.innerHTML = strHTML;
					}
					 /*added by harshada d for showing startdate and end date in issues tasks for whiziblesem 6 for issue id 3139 
					 DA - issue task should show plaaned work hours and start/end date*/
					else
					{
					if ((strTaskType == "B")&& intTaskComplete=="0")
					{
						dblAllocatedHours = dblAllocatedHours - 0;
						dblActualHours = dblActualHours - 0;
						strHTML = '<%=MyBase.GetResourceString("ETC_MESSAGE1")%><B>' + dblAllocatedHours.toFixed(2) + '</B> &nbsp;&nbsp;<%=MyBase.GetResourceString("ETC_MESSAGE2")%> <B>' + dblActualHours.toFixed(2)+ '</B>';
						strHTML = strHTML + "<BR> <%=MyBase.GetResourceString("START_DATE")%> <I>" + dtmStartDate + "</I> &nbsp;&nbsp; <%=MyBase.GetResourceString("END_DATE")%> <I>" +  dtmEndDate + "</I>&nbsp;";
						strETCValue = "";
						
						objDivCode.innerHTML = strHTML;
						}
					else
						{
						 /*end of addition by harshada d for showing startdate and end date in issues tasks for whiziblesem 6 for issue id 3139 
						 DA - issue task should show plaaned work hours and start/end date*/
						objDivCode.innerHTML = "";
						}
						}
								
					if (strTaskType == "M" || strTaskType == "O" || strTaskType == "D" || strTaskType == "B")
					{
						//Display the Task Type for the Assigned Task and Disable it
						var intTaskType = strTaskInfo[9];
						objTaskType = GetObjectReference('DA', 'cboTaskType');
						
						if (Trim(intTaskType).length != 0 && (Trim(intTaskType) - 0) > 0)
						{
							if (objTaskType != null)
							{
								objTaskType.value = intTaskType;
								objTaskType.disabled = true;
							}
						}
						else
						{
							if (objTaskType != null)
							{
								/*
								Modified By		:	HiteshS on 29th Jan.2005
								IssueID			:	15652
								Description		:	Commented line so that TaskType combo value 
													is not cleared on click of Task Combo.
								*/
								//objTaskType.value = "";
								/*
								End Of Modification By HiteshS on 29th Jan.2005
								*/
								objTaskType.disabled = false;
							}
						}
					}
				
					if (strTaskType != "D")
					{
						dblActualPercentComplete = dblActualPercentComplete - 0;
						
						objtxtActualPercentComplete.value = dblActualPercentComplete.toFixed(2);
						if(intTaskComplete == "1")
						{
							objtxtActualPercentComplete.disabled = true;
							if ( objchkCompleteTask != null )
								{
									objchkCompleteTask.disabled = true;
									objchkCompleteTask.checked = true;
								}
						}
						else
						{
							objtxtActualPercentComplete.disabled = false;
								if ( objchkCompleteTask != null )
								{

									objchkCompleteTask.disabled = false;
									objchkCompleteTask.checked = false;
								}
						}
						
						//Display the Task Notes link.
						objlblTaskName.innerHTML = objlblTaskName.innerHTML + "&nbsp;[<a style='TEXT-DECORATION: none' HREF='javascript:ShowTaskNotes(" + intTaskID + ")'><font Size=1 Face=verdana color=black><b>Show Task Notes</b></font></a>]";
					}
					if (strTaskType != "D")
					{
						if (intTaskComplete == "1")
						{
							if (objchkCompleteTask != null)
							{
								objchkCompleteTask.checked = true;
								objchkCompleteTask.disabled = true;
							}
						}
					}
					else
					{
						if (objchkCompleteTask != null)
						{
							objchkCompleteTask.checked = false;
							objchkCompleteTask.disabled = false;
						}
					}
					
					//Refresh the SubTaskType combo if the Task Type is Assigned Tasks
					if (strTaskType == "M" || strTaskType == "O" || strTaskType == "D" || strTaskType == "B")
					{
						intSubTaskTypesIDs = strTaskInfo[10];
						
						if (intSubTaskTypesIDs != "")
						{
							var strOuterHTML = "<SELECT class=clsComboBox id=cboSubTaskType name=cboSubTaskType style='WIDTH:300px; HEIGHT:70px'>";
							
							if (intSubTaskTypesIDs.indexOf(",") > 0 )
							{
								arrIDs = intSubTaskTypesIDs.split(",");
							}
							else
							{	
								var arrIDs = new String(1);
								arrIDs[0] = Trim(intSubTaskTypesIDs);
							}
							//## Added By PrasannaP 25th May 2004
							<% If m_blnTaskTypesApplicable = True %>
							for(intCnt=0; intCnt < arrIDs.length;  intCnt++)
							{
								for(intArrCnt = 0; intArrCnt < arrSubTaskTypes.length ; intArrCnt++)
								{
									if (arrSubTaskTypes[intArrCnt].indexOf(":" + Trim((arrIDs[intCnt]) + ",")) >= 0 )
									{
										arrValue = arrSubTaskTypes[intArrCnt].split(",");
										if( Trim(intSubTaskTypeID) != "" )
										{
											if (Trim(intSubTaskTypeID) == Trim(arrValue[0]) )
												strOuterHTML = strOuterHTML + "<OPTION selected value = " + Right(arrValue[0], arrValue[0] - 1) + ">" + arrValue[1] + "</OPTION>"
											else
												strOuterHTML = strOuterHTML + "<OPTION value = " + Right(arrValue[0], arrValue[0].length -1) + ">" + arrValue[1] + "</OPTION>"
										}
										else
										{
											strOuterHTML = strOuterHTML + "<OPTION value = " + Right(arrValue[0], arrValue[0].length -1) + ">" + arrValue[1] + "</OPTION>"
										}
										break;
									}
								}
							}
							<% End If %>
							strOuterHTML = strOuterHTML + "</SELECT>"
							
							//Refresh the SubTaskType Combo only if SubTaskType is applicable for the Project selected
							if( blnShowSubTaskTypes == "True" )
							{
								if (GetObjectReference('DA', 'tdSubTaskType') != null)
								{ 
								
									GetObjectReference('DA', 'tdSubTaskType').innerHTML = strOuterHTML;
								}
							}
						}
						else
						{
							if (GetObjectReference('DA', 'tdSubTaskType') != null)
							{
								GetObjectReference('DA', 'tdSubTaskType').innerHTML = "<SELECT class=clsComboBox id=cboSubTaskType name=cboSubTaskType style='WIDTH:300px; HEIGHT:70px'></SELECT>";
							}
						}
					}
					
					/* Added By NitinVS on 21 March 2005 for WhizibleSEM SP3 
					To Populate the Sub Task Combo on taskChange */
					strTaskInfo = objcboTask.value.split("|");
					var intTaskTypeID = strTaskInfo[9];
					var intSubtaskType 
				
					
					// Modified By NitinVS on 30 MAy 2005 for IssueID 18718 
					
					if (intSubTaskTypeID== "" ||intSubTaskTypeID== "0"){
						intSubtaskType = strTaskInfo[10];
						
					}else{
					
						intSubtaskType = intSubTaskTypeID
						}
				// End Modification By NitinVS on 30 May 2005 for IssueID 18718
								
					if (intTaskTypeID != "" || intTaskTypeID != null)
						{	var objcboSubTaskType =  GetObjectReference('DA', 'cboSubTaskType');
							var cboLength = 0
							var intlength = arrsubtask.length
							objcboSubTaskType.length =0 ;
							

					// To Select the Task type Associated with the Task 
					
					var objcboTaskType = GetObjectReference('DA', 'cboTaskType');
						
					if (objcboTaskType != null )
					{
						for (i=0;i< objcboTaskType.length; i++)
						{ 
							if (intTaskTypeID == objcboTaskType.options[i].value)
								{
									objcboTaskType.selectedIndex = i 
									
									break; 
								}
						}
					}							
						
						// the array contains three elements tasktypeid ,subtasktypeid and subtaskName
								//objcboSubTaskType.add(new Option('','',0));	
								//Modified by NiranjanK on Date June 09,2006 for WhizibleSEM Issue ID.4168
								var objNewElement;
								var strVal,strText;
								objNewElement = document.createElement("OPTION");
								objNewElement.innerHTML = '';
								objNewElement.value = '';
								objNewElement.selected = true;
								objcboSubTaskType.appendChild(objNewElement);
								objcboSubTaskType.disabled=false;
								
								//End of modification by NiranjanK June 09,2006 for WhzibleSEM Issue ID.4168
							for (i=0;i<intlength;i++)				
								{ 
									if ( arrsubtask[i][0] ==  intTaskTypeID ) 
										{	
										
												
												//Modified by NiranjanK on Date June 09,2006 for WhizibleSEM Issue ID.4168
												var objNewElement;
												objNewElement = document.createElement("OPTION");
												objNewElement.innerHTML = arrsubtask[i][2];
												objNewElement.value = arrsubtask[i][1];
												objNewElement.selected = false;
												objcboSubTaskType.appendChild(objNewElement);
												
												//objcboSubTaskType.add(new Option(arrsubtask[i][2], arrsubtask[i][1],cboLength));
												cboLength += 1; 
											
											 if (arrsubtask[i][1]== intSubtaskType )
											{ 
												//objcboSubTaskType.add(new Option(arrsubtask[i][2], arrsubtask[i][1],0));
												//objcboSubTaskType.selectedIndex = cboLength;
												strVal = arrsubtask[i][1];
												strText = arrsubtask[i][2];
												//strVal = cboLength;
												if (blnHaveSubTaskType == 'True')	
												{
													objNewElement.selected = true;
													objcboSubTaskType.disabled=true;
												}
																								
											}

										}	
								}
										

								if (strVal!= null)
								{
									GetObjectReference('DA', 'cboSubTaskType').value = strVal;
								}
								
						}
						else
						{
							var objcboSubTaskType =  GetObjectReference('DA', 'cboSubTaskType');
							objcboSubTaskType.length =0 ;
							
						}

				// End Addition By NitinVS  on 21 March 2005 for Whi zibleSEM SP3 	
				}	
				else
				{
					objDivCode.innerHTML = "";
					objlblTaskName.innerHTML = "";
					strTaskType = "";
					intTaskID = "";
					intTaskComplete = "";
					dblActualHours = 0;
					dblAllocatedHours = 0;
					dtmStartDate = "";
					dtmStartDate = "";
					if (GetObjectReference('DA', 'cboTaskType') != null)
					{
						GetObjectReference('DA', 'cboTaskType').disabled = false;
					}
					
					if(blnShowSubTaskTypes == "True")
					{
						if (GetObjectReference('DA', 'tdSubTaskType') != null)
						{
							GetObjectReference('DA', 'tdSubTaskType').innerHTML = "<SELECT class=clsComboBox id=cboSubTaskType name=cboSubTaskType style='WIDTH:300px; HEIGHT:70px'></SELECT>";
						}
					}
					
				}	
						
			}
		//***** Code Added by SandipL on 2 Dec 2005 -- To solve refresh problem due to editable Date Control 	
			function change_date(e)
			{
			  var keynum
			  if(window.event) // IE
	          {
	               keynum = e.keyCode
			   }
			else if(e.which) // Netscape/Firefox/Opera
			 {
			   keynum = e.which
			 }
            if (keynum==13)
            {
              //document.forms['DA'].action = 'PM_DailyActivity.aspx?FromWhere=DA&txtDate='+ document.forms['DA'].elements['txtDate'].value;
	          //document.forms['DA'].submit()
	         /* window.location = 'PM_DailyActivity.aspx?FromWhere=DA&txtDate='+ document.forms['DA'].elements['txtDate'].value;
	          window.opener = 'PM_DailyActivity.aspx?FromWhere=DA&yes=yes&txtDate='+ document.forms['DA'].elements['txtDate'].value;
	          window.document.refresh; */
	         window.focus()
	         }
           }
		//***** End addition by SandipL on 2 dec 2005	
			function ShowTaskNotes(intTaskID)
			{
				//alert('For time being this feature is not available');
				window.open("PM_DailyActivityMatrix.aspx?TaskNotes=1&TaskID=" + intTaskID,"","resizable=no,scrollbars=no,width=500,height=275,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 250)/2 + ",status =no,titlebar=no,location=no");
			}

		
					</script>
				
			<script language="javascript">
			  
			objform=GetFormReference('DA');
			objDivMain=GetObjectReference('DA','DivMain');
				<%'Added by NitinVs on 14 Aug 2007 for WhizibleSEM 7 %>			
			objDivTaksList = GetObjectReference('DA','DivTaksList');
				<%'End Added by NitinVs on 14 Aug 2007 for WhizibleSEM 7 %>			
			var dblPreviousHourValue = 0.00;
			
		    <%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
			function window_onload()		
			{
			    //var div = document.getElementsByTagName('div')[0];
			    //div.remove();

          
			    //var div1 = document.getElementsByTagName('div')[0];
			    //div1.remove();

			    //$('nav#menu').mmenu();
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				
				document.body.style.visibility='visible';
			
				//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				
				//Modified by MonikaI on Date 11 July,2006 for WhizibleSEM_Whiz2 Issue ID.4168
			

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight = window.innerHeight  - objDivMain.offsetTop - 25 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
				//End of modification by MonikaI
				if (intDivHeight < 100)
				intDivHeight = 100;
				objDivMain.style.height = intDivHeight + 'px'	;

				
				<%'Added by NitinVs on 14 Aug 2007 for WhizibleSEM 7 %>				
				if(objDivTaksList != null)
				{
					objDivTaksList.style.height = intDivHeight - 60 + 'px';
				}
				<%'End Added by NitinVs on 14 Aug 2007 for WhizibleSEM 7 %>				
			}
			function window_onresize()		
			{
				
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
					//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight = window.innerHeight  - objDivMain.offsetTop - 25 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight + "px"	;	
				<%'Added by NitinVs on 14 Aug 2007 for WhizibleSEM 7 %>
				if(objDivTaksList != null)
				{
				    objDivTaksList.style.height = intDivHeight-60 + 'px';;
				}				
				<%'End Added by NitinVs on 14 Aug 2007 for WhizibleSEM 7 %>				
			}
			
			function PreviousDay_OnClick()
			{
				var PreviousDay = new Date();
				var strDay;
				var splitArr;
			
				objform=GetFormReference('DA');
				objDateBox = GetObjectReference('DA', 'txtDate');
				if (objDateBox.value == "" || objDateBox.value == null)
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_DATE")%>');
					return;
				}
				
				splitArr = objDateBox.value.split("-");
				PreviousDay = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), -1, 0, 0);
				splitArr = PreviousDay.toLocaleString().split(" ");
				objDateBox.value = splitArr[2].substring(0, splitArr[2].length-1) + "-" + splitArr[1].substring(0,3)  + "-" + splitArr[3];
				objform.action = "PM_DailyActivity.aspx?txtDate=" + objDateBox.value;
				objform.action = "PM_DailyActivity.aspx?Move=Previous";
				objform.submit();
			}
			
			function NextDay_OnClick()
			{
				var PreviousDay = new Date();
				var strDay;
				var splitArr;
				objform=GetFormReference('DA');
				objDateBox = GetObjectReference('DA', 'txtDate');
				if (objDateBox.value == "" || objDateBox.value == null)
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_DATE")%>');
					return;
				}
				splitArr = objDateBox.value.split("-");
				PreviousDay = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), 1, 0, 0)
				
				splitArr = PreviousDay.toLocaleString().split(" ");
				objDateBox.value = splitArr[2].substring(0, splitArr[2].length-1) + "-" + splitArr[1].substring(0,3)  + "-" + splitArr[3];
				objform.action = "PM_DailyActivity.aspx?Move=Next";
				objform.submit();
			}
			
			function Expenses_OnClick()
			{
				objDate = GetObjectReference('DA', 'txtDate');
				window.open("../General/CommonList.aspx?MasterTagID=2170&FromWhere=PM&DADate="+ objDate.value, "Expenses", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=800,height=450");
			}
			
			function UpdateTask_OnClick()
			{
				objDate = GetObjectReference('DA', 'txtDate');
				if (objDate.value == "" || objDate.value == null)
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_DATE")%>');
					return;
				}
				//Modified By VivekP On 16 JUN 2005 For WhizibleSem SP3
				//window.open("PM_DailyActivity.aspx?Mode=New&txtDate=" + objDate.value,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=720,height=430");
				
			    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
			    //window.open("PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New&txtDate=" + objDate.value,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=800,height=430");
			    window.open("PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New&FromWhere=UpdateTask&txtDate=" + objDate.value,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=800,height=430");
			    //End of Addition by Dhanashri S on 11 Aug 2016

			    //End Of Modification By VivekP On 16 jun 2005
			}
			
			function ProjectComboSubmit(strMode)
			{
			    
				//Added by Priyanka, 9th Sep 2004
				//Not allowing the user to fill DA against OnHold Projects
				var strProjectsOnHold, objProject, strMode;
				
				strProjectsOnHold = "<%=m_strProjectsOnHold%>"
				objProject = GetObjectReference('DA',"cboProject");
				strMode = "<%=m_strParamMode%>"
				if (strProjectsOnHold != "")
				{
					if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("<%=m_strProjectsOnHoldMsg%>");
						if ("<%=m_strFirstNotOnHoldProject%>" != "0")
						{
							if (strMode != "Edit")
							{
								objProject.value = "<%=m_strFirstNotOnHoldProject%>";
							}
						}
						Task_OnClick();
						return;
					}			
				}	
				//End of Addition
				
				/*<Summary>
							Added By: PrashantSJ
							Date: 27th May 2008
							Purpose: DA blocked for particular project from project workflow.
				</Summary>*/
				strDABlockedProjects="<%=m_strProjectsDABlocked%>";
				if (strDABlockedProjects != "")
				{
					if (strDABlockedProjects.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("<%=m_strProjectsDABlockedMsg%>");
						if ("<%=m_strFirstNotOnHoldProject%>" != "0")
						{
							if (strMode != "Edit")
							{
								objProject.value = "<%=m_strFirstNotOnHoldProject%>";
							}
						}
						Task_OnClick();
						return;
					}			
				}	
				//End of addition by PrashantSJ on 27th May 2008
						
				objForm = GetFormReference('DA');
				//Modified by VivekP On 16 JUN 2005 for whiziblesem SP3
			    //objForm.action = "PM_DailyActivity.aspx?Mode=New&ShowClose=<%=m_strParamShowCloseLink%>"

			    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
			    //objForm.action = "PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New&ShowClose=<%=m_strParamShowCloseLink%>"
			    objForm.action = "PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New&FromWhere=UpdateTask&ShowClose=<%=m_strParamShowCloseLink%>"
			    //End of Addition by Dhanashri S on 11 Aug 2016
				//End Of Modification on 16 Jun 2005 by vivekP
				objForm.submit();
				
				
			}
			//Added by VidyaJ - IssueID - 294 - SP4
			
			strMode = "<%=m_strParamMode%>" 
		
			if (strMode!='List')
					TaskClick('<%=m_blnTaskTypesApplicable%>','<%=m_strSubTaskTypeID%>');
					
			function Task_OnClick()
			{
				objForm = GetFormReference('DA');
					//Modified by VivekP On 16 JUN 2005 for whiziblesem SP3
			    //objForm.action = "PM_DailyActivity.aspx?Mode=New";

			    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
				//objForm.action = "PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New";
				objForm.action = "PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New&FromWhere=UpdateTask";
			    //End of Addition by Dhanashri S on 11 Aug 2016

				//End Of Modification on 16 Jun 2005 by vivekP
				objForm.submit();
			}
			function TaskType_OnChange()
			{
				objForm = GetFormReference('DA');
				objForm.action = "PM_DailyActivity.aspx?Mode=New&ShowClose=<%=m_strParamShowCloseLink%>";
				objForm.submit();
			}

			function EnableControls()
			{
				GetObjectReference('DA', 'cboProject').disabled = false;
				GetObjectReference('DA', 'cboTask').disabled = false;
				GetObjectReference('DA', 'txtHours').disabled = false;
				GetObjectReference('DA', 'optGeneralTasks').disabled = false;
				GetObjectReference('DA', 'optProjectTasks').disabled = false;
				GetObjectReference('DA', 'optAssignedTasks').disabled = false;
				GetObjectReference('DA', 'optDefectTasks').disabled = false;
				//Start-AUJ-22Jan2007
				var objNormal = GetObjectReference('DA', 'optDATypeNormal');
				var objOT = GetObjectReference('DA', 'optDATypeOT');
				var objOS = GetObjectReference('DA', 'optDATypeOS');
				
				if (objNormal != null) objNormal.disabled = false;
				if (objOT != null) objOT.disabled = false;
				if (objOS != null) objOS.disabled = false;
				//End-AUJ-22Jan2007
				//Added by VivekP on 13th June 2005
				GetObjectReference('DA', 'cboSubTaskType').disabled = false;
				//End Addition
				objcboTaskType = GetObjectReference('DA', 'cboTaskType')
				if (objcboTaskType != null )
					objcboTaskType.disabled = false;
			}
			
			function CheckForDurationChange()
			{
			
				var blnDateViolation;
				var blnHoursViolation;
				var strMessage = "";
				var strResponse;
		
				var blnPromptOnDurationChange;
				var blnRestrictDurationChange;	
		
				blnPromptOnDurationChange = false;
				blnRestrictDurationChange = false;
				
				objtxtDate = GetObjectReference('DA', 'txtDate');
				objtxtHours = GetObjectReference('DA', 'txtHours');
				
				if(strTaskType == "M") 
				{
					blnPromptOnDurationChange = true;
					if ("<%=m_blnStatus_MPPTasks%>" == "True")
					{
						blnRestrictDurationChange = true;
					}
				}
				else if(strTaskType == "O")
				{
					blnPromptOnDurationChange = true;
					if ("<%=m_blnStatus_AssignedTasks%>" == "True")
					{
						blnRestrictDurationChange = true;
					}
				}
				else if(strTaskType == "B")
				{
					blnPromptOnDurationChange = true;
					if ("<%=m_blnStatus_AssignedTasks%>" == "True")
					{
						blnRestrictDurationChange = true;
					}
				}
			
				blnDateViolation = false;
				blnHoursViolation = false;

				if( (compareDates(objtxtDate.value, dtmStartDate) < 0) || (compareDates(objtxtDate.value, dtmEndDate) > 0) )
				{
				 
						<% If m_strParamMode = "Edit" Then %>
							if(blnRestrictDurationChange == true) 
							{
						<% End If %>
								blnDateViolation = true;
								strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT1")%>' + dtmStartDate + '<%=MyBase.GetResourceString("OVERSHOOT2")%>' + dtmEndDate + "].\n"
						<% If m_strParamMode = "Edit" Then %>
							}
						<% End If %>
				}
				//If previously the actual hours has crossed the allocated hours, then do not bother to display the message again.		
				
				dblCurrentHours = objtxtHours.value - 0;
				<% If m_strParamMode = "Edit" Then %>		
				if ((dblPreviousHours-0) < dblCurrentHours)
				{
					<% End If %>					
					
					dblCurrentTotalHours = (dblActualHours-0) - (dblPreviousHours-0) + (dblCurrentHours-0);
					if ((dblCurrentTotalHours-0) > (dblAllocatedHours-0))
					{
						blnHoursViolation = true;
						if (blnRestrictDurationChange==true) 
						{
							strMessage = strMessage + replaceSubstring('<%=MyBase.GetResourceString("OVERSHOOT3")%>','<=>',(dblAllocatedHours + ""));
							if(strTaskType != "B")
							    strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT4")%>';
						}
						else
						{
							strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT5")%>' + dblAllocatedHours + '<%=MyBase.GetResourceString("OVERSHOOT6")%>' + ((dblActualHours-0) - (dblPreviousHours-0) + (dblCurrentHours-0)) + '<%=MyBase.GetResourceString("OVERSHOOT7")%>';
						}
					}	
				<% If m_strParamMode = "Edit" Then %>
				}
				<% End If %>

				//If the entry date is not within the specified date range, or the actual work hours is exceeding the estimated hours, then pop up the message.				
				if (blnDateViolation==true || blnHoursViolation==true)
				{
					if(blnPromptOnDurationChange==true)
					{
						if(blnRestrictDurationChange==true)
						{
							strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT8")%>';
							strResponse = alert(strMessage);
							strResponse = false;
						}
						else
						{
							strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT9")%>';
							strResponse = window.confirm(strMessage);
						}
					}
					else
					{
						strResponse = true;
					}
								
					if (strResponse==true)
					{
						objtxtDurationChange = GetObjectReference('DA', 'txtIsDurationChange');
						objtxtDurationChange.value = "1";
					}
					else
					{
						return false;
					}
				}
				return true;
			}

			//Code for validating controls and refreshing the page when the Save link is clicked.
			function Save_OnClick(intFlag)
            {
                //debugger
				var objActualPercentComplete;
				objForm = GetFormReference('DA');
				var intBackDating;
				
				//Added by Priyanka, 9th Sep 2004
				//Not allowing the user to fill DA against OnHold Projects
				var strProjectsOnHold, objProject, strMode;
				strProjectsOnHold = "<%=m_strProjectsOnHold%>"
				objProject = GetObjectReference('DA',"cboProject");
				strMode = "<%=m_strParamMode%>"
				if (strProjectsOnHold != "")
				{
					if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("<%=m_strProjectsOnHoldMsg%>");
						if ("<%=m_strFirstNotOnHoldProject%>" != "0")
						{
							if (strMode != "Edit") 
							{
								objProject.value = "<%=m_strFirstNotOnHoldProject%>";
							}
						}
						return;
					}				
				}
				//End of Addition
				
				/*<Summary>
							Added By: PrashantSJ
							Date: 27th May 2008
							Purpose: DA blocked for particular project from project workflow.
				</Summary>*/
				strDABlockedProjects="<%=m_strProjectsDABlocked%>";
				if (strDABlockedProjects != "")
				{
					if (strDABlockedProjects.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("<%=m_strProjectsDABlockedMsg%>");
						if ("<%=m_strFirstNotOnHoldProject%>" != "0")
						{
							if (strMode != "Edit")
							{
								objProject.value = "<%=m_strFirstNotOnHoldProject%>";
							}
						}
						return;
					}			
				}	
				//End of addition by PrashantSJ on 27th May 2008
				
				objDate = GetObjectReference('DA', 'txtDate');
				if (objDate.value == "" || objDate.value == null)
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_DATE")%>');
					return;
				}
				
//Trupti
							var strjoinigdate=GetObjectReference('DA','hdnJoiningdate');
								
								if(strjoinigdate != '')
								{
									var dtjoinigdate=getDate(strjoinigdate.value);
									var dtcurrentdate=getDate(objDate.value);
									//var dtCurrentDate1=getEntryDate(objCellToBeValidated);	
									//if(disallowDate1GreaterThanDate2(dtCurrentDate1 ,dtjoinigdate, "'Joining Date' should not be greater than DA entry date.", true)) 				
								//alert(dtCurrentDate1);
								//alert(dtjoinigdate);
								//alert(getDate(strTaskStartDate));
								//alert(strTaskStartDate);
								//alert(strjoinigdate.value);
									if(dtjoinigdate > dtcurrentdate)
									{
										alert('You can not log efforts before joining date ('+ strjoinigdate.value+ ')');
										//setFocus_TS(objCellToBeValidated); 
										return;
									}
								
								}
								//end by Trupti
				//end
				intBackDating = "<%=EXPIRY_OF_TASK%>";
				
				//Added By PrasannaP on 15th May 2004
				var strProjectBackdateEntry = "No";
				if (GetObjectReference('DA', 'ProjectBackdateEntry') != null)
				{
					strProjectBackdateEntry = GetObjectReference('DA', 'ProjectBackdateEntry').value;
				}
				
				if (intBackDating.length != 0)
				{
					if (strProjectBackdateEntry != "Yes" )
					{
						objDateBox = GetObjectReference('DA', 'txtDate');
						splitArr = objDateBox.value.split("-");
						cmpDate = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), ( intBackDating - 0 ), 0, 0);
						
						if ( DateDiff(cmpDate, new Date('<%=Date.Now.ToString()%>'), "d") > 0 )
						{
							alert('<%=MyBase.GetResourceString("DATE_BLOCKED")%>');
							return;
						}
					}
				}

				//25th May 2004
				intFwdDating = "<%=EXPIRY_OF_TASK_FORWARD%>";
				
				//Added By PrasannaP on 15th May 2004
				var strProjectFwddateEntry = "No";
				if (GetObjectReference('DA', 'ProjectFwddateEntry') != null)
				{
					strProjectFwddateEntry = GetObjectReference('DA', 'ProjectFwddateEntry').value;
				}
				
				if (intFwdDating.length != 0)
				{
					if (strProjectFwddateEntry != "Yes" )
					{
						objDateBox = GetObjectReference('DA', 'txtDate');
						splitArr = objDateBox.value.split("-");
						cmpDate = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), ( -intFwdDating - 0 ), 0, 0);
						if ( DateDiff(cmpDate, new Date('<%=Date.Now.ToString("dd MMM yyyy")%>'), "d") < 0 )
						{
							alert('<%=MyBase.GetResourceString("DATE_BLOCKED")%>');
							return;
						}
					}
				}
				
				//Addition Ends				

				objchkCompleteTask = GetObjectReference('DA', 'chkCompleteTask');
				objtxtDate = GetObjectReference('DA', 'txtDate');
				objtxtDescription = GetObjectReference('DA', 'txtDescription');
				
				objtxtHours = GetObjectReference('DA', 'txtHours');
				if ( disallowBlank(GetObjectReference('DA', 'txtDate'), '<%=MyBase.GetResourceString("VALIDATE_EMPTY_DATE")%>' ) == true )
				{
					return;
				}
				if (disallowNonNumeric(objtxtHours,'<%=MyBase.GetResourceString("VALIDATE_NONNUMERIC_HOURS")%>',1) == true)
				{
					return;
				}
				
				if (disallowValueRangeViolation(objtxtHours,0,<%=m_dblTotalWorkHours%>,'<%=MyBase.GetResourceString("VALIDATE_RANGE_HOURS")%>' + (<%=m_dblTotalWorkHours%> - 0).toFixed(2) + ']' ,1) == true)
				{
					
					return;
				}

                //Added by Chetan M on 20 Nov 2020 for IssueID 28392
                if (<%=CommonFunctions.Application.MinHoursForDAEntry%> != "0.016") {
                    //End of Added by Chetan M on 20 Nov 2020 for IssueID 28392
                    if ((((objtxtHours.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) - 0).toFixed(0) != ((objtxtHours.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_MULTIPLE_HOURS")%>' + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
					//alert("Enter Hours multiples of " + + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
					objtxtHours.focus();
					return;
                    }
                    //Added by Chetan M on 20 Nov 2020 for IssueID 28392
                }
                //End of Added by Chetan M on 20 Nov 2020 for IssueID 28392
				

				if (disallowBlank(GetObjectReference('DA', 'cboProject'), '<%=MyBase.GetResourceString("VALIDATE_EMPTY_PROJECT")%>') == true)
					return;
				<% If m_blnTaskTypeMandatoryInDA = True Then %>
					objcboTaskType = GetObjectReference('DA', 'cboTaskType');
					if (objcboTaskType != null)
					{	//Commented and Modified By JyotiG
						//Start
						//Issue ID : 6918
						//if (disallowBlank(GetObjectReference('DA', 'cboTaskType'), '<%=MyBase.GetResourceString("VALIDATE_EMPTY_TASK_TYPE")%>') == true)
						if (disallowBlank(objcboTaskType, '<%=MyBase.GetResourceString("VALIDATE_EMPTY_TASK_TYPE")%>') == true)
						//End od modification By JyotiG
							return;
					}
				<% End If %>
				if (disallowBlank(GetObjectReference('DA', 'cboTask'), '<%=MyBase.GetResourceString("VALIDATE_EMPTY_TASK")%>') == true)
					return;
				<% If m_blnTaskTypeMandatoryInDA = True Then %>
					objcboSubTaskType = GetObjectReference('DA', 'cboSubTaskType');
					if (objcboSubTaskType != null)
					{
						if (disallowBlank(objcboSubTaskType, '<%=MyBase.GetResourceString("VALIDATE_EMPTY_SUBTASK")%>') == true)
							return;
					}
				<% End If %>
				
				if (disallowBlank(GetObjectReference('DA', 'txtHours'), '<%=MyBase.GetResourceString("VALIDATE_EMPTY_HOURS_WORKD")%>') == true)
					return;
				
				objActualPercentComplete = GetObjectReference('DA', 'txtActualPercentComplete');
				
				if (objActualPercentComplete != null) 
				{
					//objActualPercentComplete.value = trim(objActualPercentComplete.value)
					if (disallowBlank(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_ACTUAL_COMPLETE")%>') == true)
						return;
					
					if (disallowNegativeNumeric(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_RANGE_PERCENT_COMPLETE")%>') == true)
						return;
							
					if (disallowNonNumeric(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ACTUAL_COMPLETE")%>') == true)
						return;
					
					if (objActualPercentComplete.value > 100)
					{
						alert('<%=MyBase.GetResourceString("VALIDATE_RANGE_PERCENT_COMPLETE")%>');
						objActualPercentComplete.focus();
						return;
					}
				}
				objtxtETC = GetObjectReference('DA', 'txtETC');

				if (objtxtETC != null) 
				{
					//objtxtETC.value = trim(objtxtETC.value);
				}
				
				// Get the lower limit of the allowable ETC limit. 
				
				dblCurrentHours = objtxtHours.value;
				dblCurrentTotalHours = dblActualHours - dblPreviousHours + dblCurrentHours;
				
				if (dblAllocatedHours > dblCurrentTotalHours)
				{
					dblETCLowerLimit =  dblCurrentTotalHours - dblAllocatedHours ;
				}
				else
				{
					dblETCLowerLimit = 0;
				}
				
				if (objtxtETC != null)
				{
					if(objtxtETC.value != "")
					{
							if(objchkCompleteTask != null && objchkCompleteTask.checked == true && objchkCompleteTask.disabled == false)
							{
								alert('<%=MyBase.GetResourceString("VALIDATE_ETC")%>');
								objtxtETC.focus();
								return;
							}
					}	
					if (disallowNonNumeric(objtxtETC, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ETC")%>') == true)
						return;
					
					//Initially the validation was - "Only positive non-zero value allowed"
					//This validation is changed to allow negative numbers as well. Only 0 will not be allowed.
					
					if (objtxtETC.value == "0")
					{
						alert('<%=MyBase.GetResourceString("VALIDATE_EMPTY_ETC")%>');
						objtxtETC.focus();
						return;
					}
									
					//Validation - Check if the ETC (hrs) specified for each resource is a multiple of 0.5 hours.
					//alert('<%=m_dblMinHoursForDAEntry%>');
					if ( (((objtxtETC.value-0) / <%=m_dblMinHoursForDAEntry%>)-0).toFixed(0) != ((objtxtETC.value-0) / <%=m_dblMinHoursForDAEntry%>) )
					{
						alert('<%=MyBase.GetResourceString("VALIDATE_ETC_MULTIPLES1")%>' + '<%=m_dblMinHoursForDAEntry%>' + '<%=MyBase.GetResourceString("VALIDATE_ETC_MULTIPLES2")%>' + '<%=m_dblMinHoursForDAEntry%>' + '<%=MyBase.GetResourceString("VALIDATE_ETC_MULTIPLES3")%>');
						objtxtETC.focus();
						return;
					}	
					
					if ((objtxtETC.value-0) < (dblETCLowerLimit-0))
					{
						
						alert('<%=MyBase.GetResourceString("VALIDATE_RANGE_ETC")%>' + dblETCLowerLimit + ' !!');
						objtxtETC.focus();
						return;
					}
				}
								
				//Validation for Description textarea.
				//PrasannaP May 18th 2004
				//if (disallowBlank(objtxtDescription , '<%=MyBase.GetResourceString("VALIDATE_EMPTY_DESCRIPTION")%>') == true)
				//	return;
				//End

				if(disallowMaxlengthViolation(objtxtDescription, 2000, '<%=MyBase.GetResourceString("VALIDATE_RANGE_DESCRIPTION")%>', true) == true)
				{
					return;
				}
				//PrashantSJ 18th Sept
				if ((strTaskType == "M" || strTaskType == "O" || strTaskType == "B" ) && (objtxtHours.value != "0"))
				{	
					if (CheckForDurationChange()==false )
					{
						return;
					}
				}
                
				var objcboMPPConstraints = GetObjectReference('DA', 'cboMPPTaskConstraints');
				if (objcboMPPConstraints != null)
				{
					var objcboTask = GetObjectReference('DA', 'cboTask');
					var fmt = "MMM, dd yyyy";
					var arrSplitConstraints = (objcboMPPConstraints.options[objcboTask.selectedIndex].text).split("|");
					var objtxtDate = GetObjectReference('DA', 'txtDate');
					var objchkCompleteTask = GetObjectReference('DA', 'chkCompleteTask');
					<%If m_blnEnforceConstraints = True Then%>
					switch(arrSplitConstraints[0])
					{
						case '0':
							break;
						case '1':
							break;
						case '2':
							if ((DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") != 0 && trimString(arrSplitConstraints[3]) == "0") || (DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") > 0))
							{
								alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("MUST_START_ON"))%>", '<=>', arrSplitConstraints[1]) + ' ' + arrSplitConstraints[1]);
								return;
							}
							break;
						case '3':
							if ((DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") > 0 && ( objchkCompleteTask != null && objchkCompleteTask.checked == true)) || (DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") < 0))
							if ((DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") > 0 ) || (DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") < 0))
							{
								alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("MUST_FINISH_ON"))%>", '<=>', arrSplitConstraints[1]) + ' ' + arrSplitConstraints[1]);
								return;
							}
							break;
						case '4':
							if ((DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") > 0 && trimString(arrSplitConstraints[3]) == "0") || DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") > 0)
							{
								alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("START_NO_EARLIER_THAN"))%>", '<=>', arrSplitConstraints[1]) + ' ' + arrSplitConstraints[1]);
								return;
							}
							break;
						case '5':
							if (DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") < 0 && trimString(arrSplitConstraints[3]) == "0")
							{
								alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("START_NO_LATER_THAN"))%>", '<=>', arrSplitConstraints[1]) + ' ' + arrSplitConstraints[1]);
								return;
							}
							break;
						case '6':
							if (DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") > 0 && ( objchkCompleteTask !=null && objchkCompleteTask.checked == true))
							if (DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") > 0)
							{
								alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("FINISH_NO_EARLIER_THAN"))%>", '<=>', arrSplitConstraints[1]) + ' ' + arrSplitConstraints[1]);
								return;
							}
							break;
						case '7':
							if (DateDiff(GetDateInFormat(objtxtDate.value, fmt, "rev"), arrSplitConstraints[1], "d") < 0 )
							{
								alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("FINISH_NO_LATER_THAN"))%>", '<=>', arrSplitConstraints[1]) + ' ' + arrSplitConstraints[1]);
								return;
							}
							break;
					}
					<% End If %>
				}
				EnableControls();
				
				//If the task is marked as complete, then set the value of 'Actual % Complete' to 100.
				
				if(objActualPercentComplete != null && objchkCompleteTask != null ) 
				{
					if(objchkCompleteTask.checked == true)
						objActualPercentComplete.value = 100;
				}
				
				strHREF = "";
				var strFrmWh ;
				strFrmWh = "<%=m_strParamFromWhere%>";
				if ("<%=Request.QueryString("From")%>" == "Proxy")
				{	//Commented and Modified By JyotiG
					//Start
					//Issue ID : 6807
					if (strFrmWh=="SimpleDA" || strFrmWh=="WTimeSheet" )
						strHREF = "PM_DailyActivity.aspx?RefreshDetailsWindow=" + intFlag + "&Action=Save&Mode=New&DailyActivityID=<%=m_strParamDailyActivityID%>&ShowClose=<%=m_strParamShowCloseLink%>&EmployeeID=<%=m_strSessionUserID%>&From=Proxy";
					else
						strHREF = "PM_DailyActivity.aspx?FromTimesheet=CreateTask&RefreshDetailsWindow=" + intFlag + "&Action=Save&Mode=New&DailyActivityID=<%=m_strParamDailyActivityID%>&ShowClose=<%=m_strParamShowCloseLink%>&EmployeeID=<%=m_strSessionUserID%>&From=Proxy";
					//strHREF = "PM_DailyActivity.aspx?RefreshDetailsWindow=" + intFlag + "&Action=Save&Mode=New&DailyActivityID=<%=m_strParamDailyActivityID%>&ShowClose=<%=m_strParamShowCloseLink%>&EmployeeID=<%=m_strSessionUserID%>&From=Proxy";
					//End od modification By JyotiG
				}
				else
				{
				//Modified By vivekP On 16 Jun 2005 For WhizibleSem SP3
				//strHREF = "PM_DailyActivity.aspx?RefreshDetailsWindow=" + intFlag + "&Action=Save&Mode=New&DailyActivityID=<%=m_strParamDailyActivityID%>&ShowClose=<%=m_strParamShowCloseLink%>";
				//Commented And Modified By JyotiG
				//Start
				//Issue ID : 6807
				if (strFrmWh=="SimpleDA" || strFrmWh=="WTimeSheet" )
				  	strHREF = "PM_DailyActivity.aspx?RefreshDetailsWindow=" + intFlag + "&Action=Save&Mode=New&DailyActivityID=<%=m_strParamDailyActivityID%>&ShowClose=<%=m_strParamShowCloseLink%>";
				else
				  	strHREF = "PM_DailyActivity.aspx?FromTimesheet=CreateTask&RefreshDetailsWindow=" + intFlag + "&Action=Save&Mode=New&DailyActivityID=<%=m_strParamDailyActivityID%>&ShowClose=<%=m_strParamShowCloseLink%>";
				//strHREF = "PM_DailyActivity.aspx?RefreshDetailsWindow=" + intFlag + "&Action=Save&Mode=New&DailyActivityID=<%=m_strParamDailyActivityID%>&ShowClose=<%=m_strParamShowCloseLink%>";
				//End od modification By JyotiG
				}
				
				//End Of modification by VivekP On 16 Jun for WhizibleSem sp3
				strHREF = strHREF + " <%
					If m_strParamFromWhere <> "" Then 
						Response.Write("&FromWhere=" & m_strParamFromWhere)
					End If
				%> " 
				
				objtxtDate = GetObjectReference('DA', 'txtDate');
				if (blnSaveClicked == false)
				{
                    

				    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
				    var MenuTags = document.getElementsByTagName('A');
				    for(i = 0; i < MenuTags.length; i++)
				    {
				        if (MenuTags[i].className == "Menu")
				        {
				            //MenuTags[i].style.display= "none";
				            MenuTags[i].parentNode.parentNode.style.display= "none";
				        }
				    }
				    //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
				    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
				    //objForm.action = strHREF + "&txtDate=" + objtxtDate.value ;
				    objForm.action = strHREF + "&FlagMove=save&txtDate=" + objtxtDate.value ;
				    //End of Addition by Dhanashri S on 11 Aug 2016
					blnSaveClicked = true;
					objForm.submit();
				}
			}			
			
			//Modified by MrugajaB on 19th Sept 2006 for Whiziblesem SP7 Issue ID.6197
			function Edit_OnClick(strDaID, blnExpired, blnProjectExpiredSetting, strToken)
			{
				objtxtDate = GetObjectReference('DA', 'txtDate');
				//window.open("PM_DailyActivity.aspx?Mode=Edit&txtDate=" + objtxtDate.value + "&DailyActivityID=" + strDaID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=720,height=420");
				if(blnProjectExpiredSetting == "True")
				{
				    //Commented and Added by Dhanashri S on 23 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
				    //window.open("PM_DailyActivity.aspx?Mode=Edit&txtDate=" + objtxtDate.value + "&DailyActivityID=" + strDaID + "&PkToken=" + strToken, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");
				    window.open("PM_DailyActivity.aspx?Mode=Edit&txtDate=" + objtxtDate.value + "&DailyActivityID=" + strDaID + "&FromWhere=DA&PkToken=" + strToken, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");
				    //End of comment and addition by Dhanashri S on 23 Aug 2016 
				}
				else
				{
					if (blnExpired=="False")
					{
					    //Commented and Added by Dhanashri S on 23 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
					    //window.open("PM_DailyActivity.aspx?Mode=Edit&txtDate=" + objtxtDate.value + "&DailyActivityID=" + strDaID + "&PkToken=" + strToken, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");
					    window.open("PM_DailyActivity.aspx?Mode=Edit&txtDate=" + objtxtDate.value + "&DailyActivityID=" + strDaID + "&FromWhere=DA&PkToken=" + strToken, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");
					    //End of comment and addition by Dhanashri S on 23 Aug 2016 
					}
					else
					{
						alert("Timesheet entry has been blocked. You cannot edit previously entered tasks.");
						return;
					}
				}
			}
			//End Modification
						
			function Delete_OnClick()
			{
				//Code Added By VidyaJ - issueID - 11764
				var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmCommonList','chkDelete')
				if (blnIsRecordSelected == false) {return;}

				if (window.confirm('<%=MyBase.GetResourceString("VALIDATE_DELETE")%>') == true)
				{
				    objform = GetFormReference('DA');
				    //objform.action = "PM_DailyActivity.aspx?Mode=List&Action=Delete";
					objform.action = "PM_DailyActivity.aspx?Mode=List&Action=Delete&FromWhere=DA";
					objform.submit();
				}
			}
			
			function IncludeCompletedTasks(intFlag)
			{
				objForm = GetFormReference('DA');
				objForm.action = "PM_DailyActivity.aspx?Mode=<%=m_strParamMode%>&IncludeCompletedTasks=" + intFlag;
				objForm.submit();
			}

			function SelectTask(strTaskType)
			{
			    var strQueryString, objCombobox,strTaskType,projectid,TaskTypeID;
			    strQueryString = "PM_TaskSelection.aspx?ProjectID=" + GetObjectReference('DA', 'cboProject').value;
			    //added by nilesh gundecha for url issue fixing on 5/2/2016
			    projectid=GetObjectReference('DA', 'cboProject').value;
				
				objCombobox = GetObjectReference('DA', 'cboTaskType');
				if(objCombobox != null)
				{
				    strQueryString = strQueryString + "&TaskTypeID=" + GetObjectReference('DA', 'cboTaskType').value;
				    //added by nilesh gundecha for url issue fixing on 5/2/2016
				    TaskTypeID=GetObjectReference('DA', 'cboTaskType').value;
				}
				strQueryString = strQueryString + "&TaskType=" + strTaskType;
				strQueryString = strQueryString + "&IncludeCompletedTasks=" + <% 
				If m_blnIncludeCompletedTasks = True Then 
					Response.Write("1")
				Else 
					Response.Write("0") 
				End If
				%>;

			    //commented and added by nilesh g on 5/2/2016 for url issue
			    //window.open(strQueryString, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=750,height=400");
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'PM_DailyActivity.aspx/GenrateURLToken',
			        data: JSON.stringify({ strTaskType: strTaskType,projectid:projectid,TaskTypeID:TaskTypeID}),
			        success: function (Result) {
			             window.open(strQueryString + "&PKToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=750,height=400");
			            },
			        error: function () {
			              //alert("Error")
			        }
			    });	
			    //end of commented and added by nilesh g on 5/2/2016 for url issue
			}
			
			function WeeklyView_OnClick()
			{
				
				objDate = GetObjectReference('DA', 'txtDate');
				if (objDate.value == "" || objDate.value == null)
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_DATE")%>');
					return;
				}
				objToDate=GetObjectReference('DA', 'hdntxtToDate');
				objFromDate=GetObjectReference('DA', 'hdntxtFromDate');


				window.location.href = "PM_DailyActivityMatrix.aspx?Pktoken=<%=m_strPkToken%>&TagID=10&ProjectID=<%=Session("intProjectID")%>&ShowDetails=0&FromDate=" + objFromDate.value + "&ToDate=" + objToDate.value;
			  
				
			}
			
			//Added By SavitaS on 11 Jan 2006 to add "Weekly Timesheet" Link 
			//modified by Harshk on 03 Feb 2006
			/*function WeeklyTimesheet_OnClick()
			{
				objDate = GetObjectReference('DA', 'txtDate');
				if (objDate.value == "" || objDate.value == null)
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_DATE")%>');
					//return;
				//}
				//objToDate=GetObjectReference('DA', 'hdntxtToDate');
				//objFromDate=GetObjectReference('DA', 'hdntxtFromDate');
				//window.location.href = "../Timesheet/TS_WeeklyTimesheet.aspx?FromWhere=DT&MasterTagId=3082&FromDate=" + objFromDate.value + "&ToDate=" + objToDate.value;
			//}*/
			//End modified by Harshk on 03 Feb 2006
			//End Addition by SavitaS
			function durationFocused()
			{
				objDuration=GetObjectReference('DA', 'txtHours');
				if (objDuration.value == "")
				{
					dblPreviousHourValue = 0.00;
				}
				else
				{
					dblPreviousHourValue = (objDuration.value-0).toFixed(2);
				}
			}
			
			function durationBlur()
			{
				objDuration=GetObjectReference('DA', 'txtHours');
				if (objDuration.value.replace(/(^\s+|\s+$)/g, "") != "" && disallowNonNumeric(objDuration, '', 0) == false)
				{
					objDuration.value = (objDuration.value-0).toFixed(2);
				}
			}

			function taskTypeTimesheet_OnClick()
			{
				objDate=GetObjectReference('DA', 'txtDate');
				window.open("PM_TaskTypeTimesheet.aspx?EntryDate=" + objDate.value, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2  + ",top=" + (window.screen.height - 600)/2 + ",width=850,height=600");
			}
			
			<% If m_strParamMode = "List" %>
			// fn.. to display the calendar control
			function callcalendar(formname,datefield)
			{
				var objdateObject=GetObjectReference(formname,datefield)
				var dtval;
				
				
				if(objdateObject.value =='')
					dtval='None';
				else
					dtval=objdateObject.value;
				calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield +'&formname=' + formname + '&dateval=' + dtval+'&FromWhere=DA','calendar_window','top=0,left=0,width=348,height=260');calendar_window.focus();
			}
			<% End If %>

			function TaskReports_OnClick()
			{
				objDate = GetObjectReference('DA', 'txtDate');
				if (objDate.value == "" || objDate.value == null)
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_DATE")%>');
					return;
				}
				objDate = GetObjectReference('DA', 'txtDate');
				window.open("../PM/PM_TaskReports.aspx?ReportType=1&rdPeriod=Daily&DADate=" + objDate.value ,"Reports","resizable=yes,scrollbars=yes,width=750,height=400,Left=10,Top=20");
			}
			//Added  By VivekP n 2 jun 2005
			function CreateTask_OnClick(){
			//var objfrm;
			var val=GetObjectReference('DA', 'cboProject').value;
			window.open("../PM/PM_TaskAssignment.aspx?FromTimesheet=CreateTask&PageNumber=-1&Mode=New&ProjectID=" + val , "_popup","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 530)/2) + ",width=700,height=530");
			//objfrm.submit();
			//alert(GetObjectReference('DA', 'cboProject').value);
			//strQueryString = "PM_TaskSelection.aspx?ProjectID=" + GetObjectReference('DA', 'cboProject').value
			//alert(ProjectID);
			}
			
			//End Of addition On 2 jun 2005

// addded By purvaj on 30 Sept 2008 for WhizibleSEM 8.0, to display whether seleted date is holiday or leave			
function loadXMLDoc(url,reqQuery)
{
// code for Mozilla, etc.
if (window.XMLHttpRequest)
  {
		xmlhttp=new XMLHttpRequest()
		xmlhttp.onreadystatechange=state_Change;
		if (ns)
		{
			xmlhttp.open("GET",url+"&"+reqQuery,true)
			xmlhttp.send(false)
			if (xmlhttp.responseText != null)
            {
            xmlDoc= document.implementation.createDocument("","",null);
            xmlDoc.async=false;
            xmlDoc.load(xmlhttp.responseXML);
            state_Change(); 
            }
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
			xmlhttp.onreadystatechange=state_Change
			xmlhttp.open("POST",url,true)
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
 			xmlhttp.send(reqQuery)
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
            var objTDNote = GetObjectReference('DA', 'tdHolidayComment');
            if(xmlhttp.responseText == 'True')
            {
                if(ns)
                {
                    if ( document.getElementById("tdHolidayComment")!=null)
                        document.getElementById("tdHolidayComment").innerHTML = '<%=MyBase.GetResourceString("NOTE") %>';
                    
                 }
                else
                {
                    if (objTDNote != null)
                        objTDNote.innerHTML = '<%=MyBase.GetResourceString("NOTE") %>';
                 }
             }
             else
             {
                if(ns)
                {
                    if ( document.getElementById("tdHolidayComment")!=null)
                        document.getElementById("tdHolidayComment").innerHTML = '';
                 }
                else
                {
                    if (objTDNote != null)
                        objTDNote.innerHTML = '';
                 }
             }
		}
		else
		{
			//alert("Problem in saving data:" + xmlhttp.statusText)
			alert("Problem in loading data, Please revisit the page");
		}
	}
}
/*function DateOnchange()
{
	// addded By purvaj on 30 Sept 2008 for WhizibleSEM 8.0, to display whether seleted date is holiday or leave
	loadXMLDoc('../PM/PM_DailyACtivity.aspx','FromXML=1&txtDate='+document.getElementById('txtDate'));
	//END addtion Purvaj

}*/
//End addition Purvaj
function SelectProject(obj)
{
    var objCP=GetObjectReference('','cboProject');
    var cboProjectID;
    
    if(objCP.selectedIndex > -1)
    {
        cboProjectID=objCP.options[objCP.selectedIndex].value;
        window.open("TimesheetProjectList_CommonList.aspx?MasterTagID=3990&cboProjectID="+cboProjectID,"","resizable=yes,scrollbars=no,width=700,height=400,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 400)/2 + ",status =no,titlebar=no,location=no");    
    }
    else
        alert('No active projects accessible !');        
}

function Hours_OnChange(intBackDate, intForwardDate, m_blnProjectBackdateEntry, m_blnProjectFwddateEntry) {
    if (document.getElementById("DDLProject").value == "0") {
    }
    else if (document.getElementById("DDLTask").value == "0" || document.getElementById("DDLTask").value == "") {
    }
    else  if (document.getElementById("txtHours").value == "") {
    }
    else{
        var objTextBox = document.getElementById("txtHours")
        intBackDating = intBackDate;
        intFwdDating = intForwardDate;
        strProjectBackdateEntry = m_blnProjectBackdateEntry;
        strProjectFwddateEntry = m_blnProjectFwddateEntry;
        objEntryDate = document.getElementById('bDate')
        objEntryDate = objEntryDate.innerHTML;
        if (intBackDating.length != 0) {
            if (strProjectBackdateEntry != "True") {
                if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate, '', "rev")), intBackDating, 0, 0), new Date('<%=Date.Now().toString()%>'), "d") > 0) {
                    alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
                    objTextBox.value = "";
                    //dblHours[intRow][intCol] = -1;
                    return;
                }
            }
        }

        if (intFwdDating.length != 0) {
            if (strProjectFwddateEntry != "True") {
                if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate, '', "rev")), -(intFwdDating - 0), 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") < 0) {
                    alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
                    objTextBox.value = "";
                    //dblHours[intRow][intCol] = -1;
                    return;
                }
            }
        }
    }
}
              
		</script>
	</body>
</HTML>
