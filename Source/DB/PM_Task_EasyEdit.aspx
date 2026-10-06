<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_Task_EasyEdit.aspx.vb" Inherits="PbNIT.PM_Task_EasyEdit" %>
<!DOCTYPE HTML>
<HTML>
	
		<%CommonFunctions.General.PlotPageHeadTag("Task",,,,"<script language='javascript' src='../DB/DateFormat.js'></script>" )%>
    <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
    <script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmPM_TaskEasyEdit" method="post">
			<% IsXMLHTTP_Off = true %>
			<% WritePage()%>
		</form>
		<script>

	var xmlhttp;
	var objfrm;
	var DT;
	objfrm = GetFormReference('frmPM_TaskEasyEdit');
	objdivlist = GetObjectReference('frmPM_TaskEasyEdit','DivList');
	
	    <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
	
	//objdivlist = GetObjectReference('frmPM_TaskEasyEdit','DivMain');
	 
	//Modified By ShraddhaM on 9 Aug 2006 for PMLifeLine
	//Purpose to get DateFormat And InputDateFormt
	
	var isEdit_anyCtrl = false;
				var dateFormat;
				dateFormat="<%=strDateFormat%>";
				 
				var dateInputFormat;
				dateInputFormat="<%=strInputFormat%>";
	var flag=0;	
	var oldValue=0;		
	var minHours="<%=CommonFunctions.Application.MinHoursForDAEntry%>";
				 
	var intCompanyHrsPerDay="<%=m_dblHoursPerDay%>";
	var strHolidays = "<%=m_strHolidays%>";
	
	var intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
	var intCompanyWeekDays = <%=m_lngWeekDays%>;
	var strResult='';
	var strLeaveMessage="<%=strLeaveMessage%>"
	var url;
	var flagURL=0;
	var oldUrl;
	var IsCallSave2=true;
	var IsCaseOneProject="<%=IsCaseOneProject%>";
	var ProjectStartDate="<%=ProjectStartDate%>";
	var ProjectEndDate="<%=ProjectEndDate%>";
	
	<%' Added by NitinVS on 12 July 2007 for PMLifeLine to validate for Resource Dates %>
	var strResourceValidation = "<%=m_bitResourceValidation%>";	 
	<%'End Addition By NitinVS on 12 July 2007 for PMLifeLine to validate for Resource Dates %>	
	
            var IsValid = true;
            
	function loadXMLDoc(url)
	{
			 
	//debugger;
		// code for Mozilla, etc.
		if (window.XMLHttpRequest)
		{
			xmlhttp=new XMLHttpRequest()
			xmlhttp.onreadystatechange=state_Change
			xmlhttp.open("GET",url,true)
			xmlhttp.send(null)
		}
		// code for IE
		else if (window.ActiveXObject)
		{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
			if (xmlhttp)
			{
			    
				xmlhttp.onreadystatechange=state_Change
				xmlhttp.open("GET",url,true)				 
				xmlhttp.send()			
			}
		}
		
		//return true;
	}

	function state_Change()
	{
	 
		if (xmlhttp.readyState==4)
		{
				if(xmlhttp.status==200)
				{
					strResult=xmlhttp.responseText;		
					      save_onClick_2();
				}	
				 
		}
	}		    
	
function save_onClick_2()
	{
	flagURL=1;
	 
		var objBaselineStartDate;  
	
			if(strResult!=null)
			{
				if(strResult!='')
				{
					 
					strResult=strResult.split("<==>");
				 
							var intCount, Count;
								for(intCount=0;intCount<strResult.length;intCount++)
								{
									 
									strLH=strResult[intCount];	
									
									strLH=strLH.split("<==>");
									 
										
											for(Count=0;Count<strLH.length;Count++)
											{	
												if(strLH[Count]!='')
												{
													if(strLH[Count]!=' ')
                                                    {
														if(confirm(strLH[Count]+ ' \n Do you want to continue ?')==false)
														{
															strResult="";
															IsCallSave2=false;
															
															return;
														}
														else
														{			 													 
			 													IsCallSave2=false;
			 													loadXMLDoc(oldUrl);
														}
													}
												}
											 
											}	
									 
								}
					
					
				}
			}	
	}//End of Function..
	
	function PlotControls(args)
	{	 
	
		if (IsEdit == true )		
		{
			//To change folder Image with Opening Folder Image.. 
			var objImg= GetObjectReference('frmPM_TaskEasyEdit','folderimg'+args);			 
			objImg.src="../../images/TreeNodeImages/folderopen.gif";
			
			appendControl("StartDate_"+args,"text","Date");
			appendControl("EndDate_"+args,"text","Date");
			appendControl("Planned_"+args,"text","Numeric");
			//appendControl("UpdateBaseline_"+args,"checkbox","chk");
		}
		 
	}

	function appendControl(args,ctrlType,ctrlCaption)
	{
		var lblValue;
		var lblName;
		 
		flag=0
		var objTD = GetObjectReference('frmPM_TaskEasyEdit',"TD"+args); //document.getElementById("TD"+args)
		if (objTD)
		{
			//Modified By ShraddhaM on 2/08/2006 for PMLifeLine issue ID : 4182
			if (GetObjectReference('frmPM_TaskEasyEdit',"ctr"+args)== null )
			{
				var lblCtrl = GetObjectReference('frmPM_TaskEasyEdit',"lbl"+args);
				 
				lblValue =lblCtrl.innerHTML;
			
				var intIndexQuote, intIndex;
				 
				intIndex = objTD.innerHTML.indexOf("tdParent");
				intIndexQuote = objTD.innerHTML.indexOf(">");
				lblName = objTD.innerHTML.substring(intIndex, intIndexQuote-1);
				var strParentID = lblName.split("_");
				var control;
				var objControl;
		 			
				//Addition of control for Description
				control = document.createElement("INPUT");
				control.type=ctrlType;
				//control.id="ctr"+args+"_"+strParentID[1];
				var hidDate;
				var dateImg;
				
				 
                if (ctrlCaption == "Date") {
                    if (navigator.appName != 'NetScape') //PMLifeLine Text box
                    {
                        control.id = "FFE29587WHIZ_ctr" + args;
                        control.hidID = "ctr" + args;
                        hidDate = document.createElement("INPUT");
                        hidDate.type = "HIDDEN";
                        hidDate.id = "ctr" + args;
                        hidDate.name = "ctr" + args;

                        flag = 0;
                        DT = GetFormat(lblValue, dateFormat, dateInputFormat);

                        lblValue = DT;

                        oldValue = lblValue;
                        //Commented By Usha Pandit On 20.04.2020 for validation alert is not getting closed
                        //control.onblur = function () {

                            //return DateControl_StandardOnblur('frmPM_TaskEasyEdit',this.id,dateInputFormat,'Invalid Date format or Invalid Date.');

                            //SendXMLHTTP_Save(this.id, lblValue);

                        //};
                        //End Of Commented By Usha Pandit On 20.04.2020 for validation alert is not getting closed

                        dateImg = document.createElement("A");

                        dateImg.href = "javascript:callcalendarNew('frmPM_TaskEasyEdit','ctr" + args + "','hid" + args + "')";

                        //dateImg.href= "javascript:New_callcalendar('frmPM_TaskEasyEdit','"+lblValue+"','" + control.id+"')";
                        dateImg.innerHTML = "<img Border=0 valign=Top src='../../images/Calendar.gif' alt='Click here for calendar...' title='" + dateInputFormat + "'> </img>"

                    }

                }
                else {
                    control.id = "ctr" + args;

                    //Commented By Usha Pandit On 20.04.2020 for validation alert is not getting closed
                    //control.onblur = function () {

                        //SendXMLHTTP_Save(this.id, lblValue);
                        //return DateControl_StandardOnblur('frmPM_TaskEasyEdit',this.hidID,dateInputFormat,'Invalid Date format or Invalid Date.');
                    //};
                    //End Of Commented By Usha Pandit On 20.04.2020 for validation alert is not getting closed 

                }
				
				
				control.name=lblName;
				control.value = lblValue;
				 
				objTD.removeChild(GetObjectReference('frmPM_TaskEasyEdit',"lbl"+args));
				objTD.appendChild(control);
				
				
				if(hidDate != null) 
				{
				objTD.appendChild(hidDate);
				DateControl_StandardOnblur('frmPM_TaskEasyEdit',control.hidID,dateInputFormat,'Invalid Date format or Invalid Date.');
				}
				if (dateImg != null)
				objTD.appendChild(dateImg);			
				
				objControl=GetObjectReference('frmPM_TaskEasyEdit',control.id);
						
				if ((control.id).match("Date") != null)
			 	{
						if (ctrlType=="text")
						{
							objControl.className="clsTextbox";
							objControl.style.textAlign="left";
							objControl.style.width=80;
						}
				}
				else
				{
						if (ctrlType=="text")
						{
							objControl.className="clsTextbox";
							objControl.style.textAlign="right";
							objControl.style.width=50;
							objControl.maxLength=10;
						}
				}
			
			}
		}
	
	}
	
	/************************ Added By VijayD 25 May 2009********************************
            Purpose: To validate Task assignment for baseline
     ************************ ***********************************************************/
	var strResult;
	var brw = isIE();
            function ValidateTask_Baseline(url) 
			{ 		
			// TO SEE IF WE ARE RUNNING IN IE 
						strNavigator = navigator.appName;
						strNavigator = strNavigator.toUpperCase();
					//Commented and added by Nilesh g on 10/12/2015 for issue id 2721
						    //if (strNavigator == 'MICROSOFT INTERNET EXPLORER')
					  if (brw == "IE")
						{ 
							g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
							//hook the event handler
							g_objXHttp.onreadystatechange = TaskValidation_state_change;
							//prepare the call, http method=GET, false=asynchronous call
							g_objXHttp.open("GET",strUrl, false);
							//finally send the call
							g_objXHttp.send();
						}
						else
						{
						
							// Mozilla - based browser , Netscape
							g_objXHttp = new XMLHttpRequest();
							//hook the event handler
							g_objXHttp.onreadystatechange = TaskValidation_state_change;
							//prepare the call, http method=GET, false=asynchronous call
							g_objXHttp.open("GET",strUrl, false);
							//finally send the call
							g_objXHttp.send(null);
							
							if ( g_objXHttp.responseText != null)
							{
								xmlDoc= document.implementation.createDocument("","",null);
								xmlDoc.async=false;
							    //added by Nilesh g on 10/12/2015 for issue id 2721
								if (brw == "FF")
								xmlDoc.load(g_objXHttp.responseXML);
								strResult=g_objXHttp.responseText;
						     }
							
						}
					return 	strResult;			
			} 
			
			function TaskValidation_state_change() 
			{			
				if (g_objXHttp.readyState == 4) 
				{
					
			   		// Make sure request came back OK 
					if (g_objXHttp.status == 200) 
					{
				 
					    //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
					    //if (window.ActiveXObject)
					    if (brw=="IE")
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
							xmlDoc.loadXML(g_objXHttp.responseText);
												
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							xmlDoc.async=false;
						    //added by Nilesh g on 10/12/2015 for issue id 2721
							if (brw == "FF")
							xmlDoc.load(g_objXHttp.responseXML);
						}
										
						//Save the Result in a Global variable
							strResult=g_objXHttp.responseText;		
							
				    }
				}
			}
		//************************End Addition By VijayD 25 May 2009**************************//	
			
	function SendXMLHTTP_Save(id,oldValue)
    {         
	    var objEvent = document.getElementById(id);
		var value = objEvent.value;
		
		<%' Modified by NitinVS on 13 July 2007 for PMLifeLine to validate for resource allocation. %>
		var resourceValidationEmpID ;
		var resourceValidationstartDt ;
		var resourceValidationEndDt ;
		
/************************ Added By VijayD 25 May 2009********************************
        Purpose: To validate Task assignment for baseline
 ************************ ***********************************************************/		 
        var controlName=objEvent.id;
        var startDate,EndDate,value1,Efforts, strField,strTaskID;
        if (controlName.match("Planned") != null)
        {
           var objEvent = document.getElementById(id);
    	   Efforts = objEvent.value;	
           
           strTaskID=objEvent.id;
               strTaskID=strTaskID.replace("ctrPlanned_","");
               strField = strTaskID.substring(0, strTaskID.lastIndexOf("_")); 
           
           var  objEfforts="FFE29587WHIZ_" + controlName.replace("Planned","StartDate");
                StartDate = document.getElementById(objEfforts).value;
			    StartDate=ConvertIntoDate(StartDate,dateInputFormat);  
				
           var  objEndDate="FFE29587WHIZ_"+ controlName.replace("Planned","EndDate");    
                EndDate = document.getElementById(objEndDate).value;
			    EndDate=ConvertIntoDate(EndDate,dateInputFormat);
		//Added by NitinC on 20 Jan 2012 for PMLifeLine - Agile Module (Issue Fix : 58849)
    		if("<%=m_intFlag%>"=="1")
            {
                  if(!ValidateUSDates(StartDate,EndDate,Efforts,strField))
                  {
                       return;
                  }	
            }
            //End of Added by NitinC on 20 Jan 2012 for PMLifeLine - Agile Module (Issue Fix : 58849)

			var Str=new String(parseInt(Efforts)); 
		    if(Str.indexOf('NaN')==-1) 	      
		    strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId="+strField+"&StartDate=" + encodeURIComponent(StartDate) + "&EndDate=" + encodeURIComponent(EndDate)+ "&DeliverableID=NULL&ModuleID=NULL&SubProjectID=NULL&MilestoneID=NULL&Work="+String(Efforts);
		   else 
		    strUrl ='';           
        }
	 	else if (controlName.match("Date") != null)
	     {	
           var value1;			
             
	    	if(controlName.match("StartDate") != null)
			{
				//Purpose : To have correct format date value
				StartDate = GetFormatDate('frmPM_TaskEasyEdit',controlName.substring(13),dateInputFormat,'Invalid Date format or Invalid Date.');
				if (StartDate!=false)
				{
				    StartDate = ConvertIntoDate(StartDate,dateInputFormat);
				    value1 = StartDate;
				}
				else
				{
				    return;
				}
				var objEndDate=controlName.replace("Start","End");
				    EndDate = document.getElementById(objEndDate).value;
				    EndDate=ConvertIntoDate(EndDate,dateInputFormat);
				
	           var  objEfforts=controlName.replace("StartDate","Planned").replace("FFE29587WHIZ_","");
                    Efforts = document.getElementById(objEfforts).value; 
               
               strTaskID=objEvent.id;
               strTaskID=strTaskID.replace("FFE29587WHIZ_ctrStartDate_","");
               strField = strTaskID.substring(0, strTaskID.lastIndexOf("_"));     
               
			}//if
            else if(controlName.match("EndDate") != null)
			{
				//Purpose : To have correct format date value
				
				EndDate = GetFormatDate('frmPM_TaskEasyEdit',controlName.substring(13),dateInputFormat,'Invalid Date format or Invalid Date.');
			 
				if (EndDate!=false)
				{
				    EndDate = ConvertIntoDate(EndDate,dateInputFormat);
				    value1 = EndDate;
				}
				else
				{    
				    return;
				}
				var objStartDate=controlName.replace("End","Start");
				    StartDate = document.getElementById(objStartDate).value;
				    StartDate=ConvertIntoDate(StartDate,dateInputFormat);  
				
			   var  objEfforts=controlName.replace("EndDate","Planned").replace("FFE29587WHIZ_","");
                    Efforts = document.getElementById(objEfforts).value;
                    
               strTaskID=objEvent.id;              
               strTaskID=strTaskID.replace("FFE29587WHIZ_ctrEndDate_","");
               strField = strTaskID.substring(0, strTaskID.lastIndexOf("_"));                    
			}//else	
			//Added by NitinC on 20 Jan 2012 for PMLifeLine - Agile Module (Issue Fix : 58849)
    		if("<%=m_intFlag%>"=="1")
            {
                  if(!ValidateUSDates(StartDate,EndDate,Efforts,strField))
                  {
                       return;
                  }	
            }
            //End of Added by NitinC on 20 Jan 2012 for PMLifeLine - Agile Module (Issue Fix : 58849)

			  var Str=new String(parseInt(Efforts)); 
		    if(Str.indexOf('NaN')==-1) 	     
		         strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId="+strField+"&StartDate=" + encodeURIComponent(StartDate) + "&EndDate=" + encodeURIComponent(EndDate)+ "&DeliverableID=NULL&ModuleID=NULL&SubProjectID=NULL&MilestoneID=NULL&Work="+String(Efforts);
		    else 
		        strUrl ='';
			
             //ValidateTask_Baseline(strUrl);				
		 }//else if

//************************End Addition By VijayD 25 May 2009**************************//
        
        //End Addition By VijayD On 27 May 2009 
        
		if (objEvent.type == "checkbox")
		{

			if (objEvent.checked == true)
				value = 1 ;
			else
				value = 0 ;
			 url = "../DB/PM_Task_EasyEdit.aspx?FromXML=1&TaskID="+ objEvent.id +"&Value="+ value +"&UpdateBaseline="+ value;
			//document.getElementById("p").value=url;
			
			//Commneted by GokulP on 21 Sept 2009 to remove Task Validation as Discuss with PrashantSJ
            //Added By VijayD On 20 August 2009
            
            //if	(strUrl!='') 
            //{
            //   ValidateTask_Baseline(strUrl);	
            //  if(strResult!=null && strResult!="")
            // {
            //    alert(strResult);
            //   return ;	
            // }    	    
            //}	
           //End Addition By VijayD On 20 August 2009    
           
           //End of Commnete by GokulP on 21 Sept 2009 to remove Task Validation as Discuss with PrashantSJ
           
			loadXMLDoc(url);
		}
		else
		{	 			 
				//Modified By ShraddhaM on 10 Aug 2006 for PMLifeLine
				var controlName=objEvent.id;
				 
			 	if (controlName.match("Date") != null)
			 	 {			 	
			 	               //Modified By VarunA 6-Aug-2008 RequestID-14286
			 	               //Purpose : To have correct format date value
			 	               //var value1=ConvertIntoDate(value,dateInputFormat);
			 	               var value1
			 	             
			 	               var objvalue	= GetFormatDate('frmPM_TaskEasyEdit',controlName.substring(13),dateInputFormat,'Invalid Date format or Invalid Date.');			
			 	                
			 	               if(objvalue!=false)
			 	               {
			 	                    objvalue = ConvertIntoDate(objvalue,dateInputFormat);
								    value1 = objvalue
								}
								else
								{ 
								    return
								}
			 	               //End By VarunA 6-Aug-2008 RequestID-14286
			 				   
			 					
								 oldUrl = "../DB/PM_Task_EasyEdit.aspx?FromXML=1&TaskID="+ objEvent.id +"&Value="+ value1;
								 
								//Added By ShraddhaM on 22 Aug 2006
									
									if(controlName.match("StartDate") != null)
									{ 
									    //var EmpName=FieldName.replace("FFE29587WHIZ_ctrStartDate","TDEmployeeName");
									    var EmpID=controlName.replace("FFE29587WHIZ_ctrStartDate","hidEmpID");
										var objEmpID = document.getElementById(EmpID);
										var EmployeeID=objEmpID.value;
										
										//Added By VarunA 6-Aug-2008 RequestID-14286
										//Purpose : To have correct format date value
										var StartDate = GetFormatDate('frmPM_TaskEasyEdit',controlName.substring(13),dateInputFormat,'Invalid Date format or Invalid Date.');
										
										//alert(StartDate);
										
										if (StartDate!=false)
										{
										    StartDate = ConvertIntoDate(StartDate,dateInputFormat);
										    value1 = StartDate
										}
										else
										{
										    return
										}
										//End By VarunA 6-Aug-2008 RequestID-14286
										
										var objEndDate=controlName.replace("Start","End");
										var EndDate = document.getElementById(objEndDate).value;
										//convert Start and end Dates in dd-MMM-yyy format
										//then replace those variable in following url
										EndDate=ConvertIntoDate(EndDate,dateInputFormat);
										//Commented By VarunA 6-Aug-2008 RequestID-14286
										//Purpose : To have correct format date value										
										//var StartDate=ConvertIntoDate(objEvent.value,dateInputFormat);
										//End By VarunA 6-Aug-2008 RequestID-14286
										 
										url = "../DB/PM_Task_EasyEdit.aspx?FromXML=1&TaskID="+ objEvent.id +"&Value="+ value1 + "&EmployeeID=" +EmployeeID + "&startDate=" + StartDate +"&endDate="+ EndDate;
									 
										if (DateControl_StandardOnblur('frmPM_TaskEasyEdit',controlName.replace("FFE29587WHIZ_",""),dateInputFormat,'Invalid Date format or Invalid Date.')==false)
										{		 
											IsValid=false;
											return;
										}										
										resourceValidationEmpID = EmployeeID;
										resourceValidationstartDt = getDate(document.getElementById( controlName.replace("FFE29587WHIZ_","") ).value );
										resourceValidationEndDt =  getDate(document.getElementById( controlName.replace("FFE29587WHIZ_","").replace("ctrStartDate","ctrEndDate") ).value);
									
									}
									else if(controlName.match("EndDate") != null)
									{
										//var EmpName=FieldName.replace("FFE29587WHIZ_ctrEndDate","TDEmployeeName");
										var EmpID=controlName.replace("FFE29587WHIZ_ctrEndDate","hidEmpID");
										var objEmpID = document.getElementById(EmpID);
										var EmployeeID=objEmpID.value;
										
										//Added By VarunA 6-Aug-2008 RequestID-14286
										//Purpose : To have correct format date value
										var EndDate = GetFormatDate('frmPM_TaskEasyEdit',controlName.substring(13),dateInputFormat,'Invalid Date format or Invalid Date.');
										if (EndDate!=false)
										{
										    EndDate = ConvertIntoDate(EndDate,dateInputFormat);
										    value1 = EndDate
										}
										else
										{
										    return ;
										}
										//End By VarunA 6-Aug-2008 RequestID-14286
										
										var objStartDate=controlName.replace("End","Start");
										var StartDate = document.getElementById(objStartDate).value;
										//alert('StartDate '+StartDate);
										StartDate=ConvertIntoDate(StartDate,dateInputFormat);
										//alert('StartDate '+StartDate);
										//Commented By VarunA 6-Aug-2008 RequestID-14286
										//Purpose : To have correct format date value	
										//var EndDate=ConvertIntoDate(objEvent.value,dateInputFormat);
										//End By VarunA 6-Aug-2008 RequestID-14286
										url = "../DB/PM_Task_EasyEdit.aspx?FromXML=1&TaskID="+ objEvent.id +"&Value="+ value1 + "&EmployeeID=" +EmployeeID + "&startDate=" +StartDate +"&endDate="+EndDate;

										if (DateControl_StandardOnblur('frmPM_TaskEasyEdit',controlName.replace("FFE29587WHIZ_",""),dateInputFormat,'Invalid Date format or Invalid Date.')==false)
										{		 
											IsValid=false;
											return;
										}
										resourceValidationEmpID = EmployeeID;
										resourceValidationstartDt = getDate( document.getElementById( controlName.replace("FFE29587WHIZ_","") ).value ) ;
										resourceValidationEndDt =  getDate( document.getElementById( controlName.replace("FFE29587WHIZ_","").replace("ctrStartDate","ctrEndDate") ).value ) ;

									}	

								//Endded By ShraddhaM on 22 Aug 2006							
																		
				                //alert('606');
								if (IsValidData(objEvent.id, value,oldValue)== true)
								{	
									if(strResourceValidation=="True")
									{
										if (ValidateResourceDate(resourceValidationEmpID,resourceValidationstartDt,resourceValidationEndDt)==false)
											return;
									}
									    //Commneted by GokulP on 21 Sept 2009 to remove Task Validation as Discuss with PrashantSJ
			 					         //Added By VijayD On 20 August 2009
		 	                            //if	(strUrl!='' ) 
                                        //{
                                        //    ValidateTask_Baseline(strUrl);	
                                        //    if(strResult!=null && strResult!="")
                                        //    {
                                        //        alert(strResult);
                                        //        return ;	
                                        //    }    	    
                                        //}	
                                       //End Addition By VijayD On 20 August 2009    
                                       //End of Commnet by GokulP on 21 Sept 2009 to remove Task Validation as Discuss with PrashantSJ
                                       loadXMLDoc(url); 			 									 							
			 										 							 
								}
								else
								{
									//objEvent.value=oldValue;
								}
			 	 }
			  	else
			 	{
			 	 
			 		//var url = "../DB/PM_Task_EasyEdit.aspx?FromXML=1&TaskID="+ objEvent.id +"&Value="+ value;
					 if (controlName.match("Date") == null)
			 		 {   

							 		 //alert('630');
							if (IsValidData(objEvent.id, value,oldValue)== true)
							{			
								resourceValidationEmpID = document.getElementById( controlName.replace("ctrPlanned","hidEmpID") ).value 
								resourceValidationstartDt = getDate(document.getElementById( controlName.replace("ctrPlanned","ctrStartDate") ).value );
								resourceValidationEndDt =  getDate(document.getElementById( controlName.replace("ctrPlanned","ctrEndDate")).value);
								
								if(strResourceValidation=="True")
								{							
									if (ValidateResourceDate(resourceValidationEmpID,resourceValidationstartDt,resourceValidationEndDt)==false)
										return;
								}
									
						<%' End Modification by NitinVS on 13 July 2007 for PMLifeLine %>							
							
							oldUrl = "../DB/PM_Task_EasyEdit.aspx?FromXML=1&TaskID="+ objEvent.id +"&Value="+ value;
								
										var EmpID=controlName.replace("ctrPlanned","hidEmpID");
										//alert(objEvent.id);
										var objEmpID = document.getElementById(EmpID);
										var EmployeeID=objEmpID.value;
									var StartDateID="FFE29587WHIZ_"+controlName.replace("Planned","StartDate");			
									var StartDateValue = document.getElementById(StartDateID).value;
										//alert('StartDateID '+StartDateValue);
									var EndDateID="FFE29587WHIZ_"+controlName.replace("Planned","EndDate");
									var EndDateValue = document.getElementById(EndDateID).value;
								
								
										 StartDateValue=ConvertIntoDate(StartDateValue,dateInputFormat);
								 //alert(StartDateValue);
										 EndDateValue=ConvertIntoDate(EndDateValue,dateInputFormat);
										
									 
			 					url = "../DB/PM_Task_EasyEdit.aspx?FromXML=1&TaskID="+ objEvent.id +"&Value="+ value + "&EmployeeID=" +EmployeeID + "&startDate=" +StartDateValue +"&endDate="+EndDateValue;
								//Commneted by GokulP on 21 Sept 2009 to remove Task Validation as Discuss with PrashantSJ		 					
			 					 //Added By VijayD On 20 August 2009
		 	                    //if	(strUrl!='' ) 
                                //{
                                //    ValidateTask_Baseline(strUrl);	
                                //    if(strResult!=null && strResult!="")
                                //    {
                                //        alert(strResult);
                                //        return ;	
                                //    }    	    
                                //}	
                               //End Addition By VijayD On 20 August 2009     
                               //End of Commnet by GokulP on 21 Sept 2009 to remove Task Validation as Discuss with PrashantSJ
                               loadXMLDoc(url);
							}
							else
							{
								//objEvent.value=oldValue;
							}
					}
			 	} 
    		}
    	}

	function showHide_div()
	{
		//Modified By ShraddhaM on 11 Aug 2006 for PMLifeLine
		var objDIV= GetObjectReference('frmPM_TaskEasyEdit','Show');
		var objimg= GetObjectReference('frmPM_TaskEasyEdit','imgShowHide');
		var objDivStatus= GetObjectReference('frmPM_TaskEasyEdit','hidFilterDivStatus');

		if ( objDivStatus.value == 'Open' )
			{
				objDIV.style.display='none';
				objimg.src='../../Images/plus.gif';
				objDivStatus.value = "Close";
				return;
			}
		else
			{
				objDIV.style.display='';
				objimg.src='../../Images/minus.gif';
				
				objDivStatus.value = "Open";
				return;
			}
	}
		
	function filterChange()
	{
		var intProjectID = GetObjectReference('frmPM_TaskEasyEdit','cboProject');
		var intEmployeeID=GetObjectReference('frmPM_TaskEasyEdit','cboEmployee');
		
		objFromDate = GetObjectReference('frmPM_TaskEasyEdit','txtFromDate');
		objToDate = GetObjectReference('frmPM_TaskEasyEdit','txtToDate');
		 
		objfrm.action="../DB/PM_Task_EasyEdit.aspx?TaskID=<%=strTaskID%>&ProjectID="+intProjectID.value+"&EmployeeID="+intEmployeeID.value+"&IsEdit="+IsEdit ;
		objfrm.submit();
		
		<% if IsXMLHTTP_Off = true %>
        if (isEdit_anyCtrl == true)
            if (confirm("Do you want to save changes?")) {

                //Added by Tejal D date 12/10/2016 to set setFrameLoader
                setFrameLoader();
                //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
                objfrm.action = "PM_Task_EasyEdit.aspx?Action=Save&TaskID=<%=strTaskID%>&ProjectID=" + intProjectID.value + "&EmployeeID=" + intEmployeeID.value + "&IsEdit=" + IsEdit;
            }
            else {
                //Added by Tejal D date 12/10/2016 to set setFrameLoader
                setFrameLoader();
                //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
                objfrm.action = "PM_Task_EasyEdit.aspx?TaskID=<%=strTaskID%>&ProjectID=" + intProjectID.value + "&EmployeeID=" + intEmployeeID.value + "&IsEdit=" + IsEdit;
                objfrm.submit();
            }
        <%  End if %>
	}

	function window_onresize()
	{
	}
	function window_onload()
	{
			var intDivHeight;
			var intDivHeightRisk;
			
			if (intDivHeight < 100)	intDivHeight = 100;
			 
			if(navigator.appName == 'Netscape')
			{
			intDivHeight = window.innerHeight - objdivlist.offsetTop -60 ;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;	
			}
			else 
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 80;
				objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;	
			} 
			
		
		<% if blnIsEdit = true  then %>
		IsEdit = 1;
		<% end if %>		
				
			objFromDate = GetObjectReference('frmPM_TaskEasyEdit','FFE29587WHIZ_txtFromDate');
			objToDate = GetObjectReference('frmPM_TaskEasyEdit','FFE29587WHIZ_txtToDate');
			//alert(objFromDate.value);
		//alert(objToDate.value);
		//var objToDate=GetObjectReference('frmPM_TaskEasyEdit','txtToDate');
		//var objFromDate=GetObjectReference('frmPM_TaskEasyEdit','txtFromDate');
		//alert(objToDate.value);
		//alert(objFromDate.value);
				
	}
	function editAll_onClick(args)
	{
	 
		var TaskIDs = new String(GetObjectReference('frmPM_TaskEasyEdit','hidTaskIDs'+args).value).split(",");
		var count = 0;
		while (count < TaskIDs.length)
		{
			if (IsEdit == true)
			{
			 
			//<% if blnIsEdit = true  then %>
			
				appendControl("TDStartDate"+TaskIDs[count],"text");
				appendControl("TDEndDate"+TaskIDs[count],"text");
				appendControl("TDPlanned"+TaskIDs[count],"text");
				appendControl("TDAct"+TaskIDs[count],"text");
			//<% end if %>
			}
			count++;
		}
	}
	
	function PreviousWeek_OnClick()
	{
		var intProjectID, strTaskType, intCnt, objTaskType;
		var objTaskFilter=GetObjectReference('frmPM_TaskEasyEdit','optMainTaskFilter',true);
		//Replace the character '&#39' with the single quotes " ' "
		var msg=replaceSubstring("<%=Mybase.GetResourceString("PERVIOUS_WEEK_ALERT")%>","&#39;","'");
		var objToDate=GetObjectReference('frmPM_TaskEasyEdit','txtToDate');
		var objFromDate=GetObjectReference('frmPM_TaskEasyEdit','txtFromDate');
		objFromDate.value="<%=Date.Parse(DateAdd("d",-7,m_dtFromDate1))%>";
		objToDate.value="<%=Date.Parse(DateAdd("d",-7,m_dtToDate1))%>";
		//<%=Date.Parse(DateAdd("d",-6,m_dtFromDate1))%>&ToDate=<%=Date.Parse(DateAdd("d",-6,m_dtToDate1))%>";
		if((objTaskFilter[1].checked)==false)
		{
			alert(msg);
			return ;			 
		}
		intProjectID = GetObjectReference('frmPM_TaskEasyEdit','cboProject').value;
		strTaskType='O';
		var objintProjectID=GetObjectReference('frmPM_TaskEasyEdit','cboProject');
		  if(intProjectID=='')
		{
			alert('Please select the Project');
			setFocus(objintProjectID);
			return;
		}
		//  Purpose-To pass EmployeeID into Querystring 
		var intEmployeeID ;
		intEmployeeID = GetObjectReference('frmPM_TaskEasyEdit','cboEmployee').value;

		if (IsValidInput() == true)
		{
            
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
			objfrm.action = "PM_Task_EasyEdit.aspx?FromWhere=PM&Mode=List&Weekly=True&ProjectID=" + intProjectID + "&EmployeeID=" + intEmployeeID + "&TaskType='O'&FromDate=<%=Date.Parse(DateAdd("d",-7,m_dtFromDate1))%>&ToDate=<%=Date.Parse(DateAdd("d",-7,m_dtToDate1))%>";
			//objfrm.action = "PM_Task_EasyEdit.aspx?FromWhere=PM&Mode=List&Weekly=True&FromDate=" + txtFromDate + "&ToDate=" + txtToDate + "&ProjectID=" + intProjectID + "&TaskType='O'&EmployeeID=" + intEmployeeID + "&IsEdit="+IsEdit;
			
			objfrm.submit();
		}			
		//End intigrated by harshk for issueid 190
	}
		
	function NextWeek_OnClick()
	{
		var intProjectID, strTaskType, objTaskType, intCnt;
		var objTaskFilter=GetObjectReference('frmPM_TaskEasyEdit','optMainTaskFilter',true);
		var msg=replaceSubstring("<%=Mybase.GetResourceString("NEXT_WEEK_ALERT")%>","&#39;","'");
		var txtToDate=GetObjectReference('frmPM_TaskEasyEdit','txtToDate').value;
		var txtFromDate=GetObjectReference('frmPM_TaskEasyEdit','txtFromDate').value;
		  
		var objToDate=GetObjectReference('frmPM_TaskEasyEdit','txtToDate');
		var objFromDate=GetObjectReference('frmPM_TaskEasyEdit','txtFromDate');
		objFromDate.value="<%=Date.Parse(DateAdd("d",7,m_dtFromDate1))%>";
		objToDate.value="<%=Date.Parse(DateAdd("d",7,m_dtToDate1))%>";
		 
		if((objTaskFilter[1].checked)==false)
		{
			alert(msg);
			return ;			 
		}
	
		intProjectID = GetObjectReference('frmPM_TaskEasyEdit','cboProject').value;
		var objintProjectID=GetObjectReference('frmPM_TaskEasyEdit','cboProject');
		  if(intProjectID=='')
		{
			alert('Please select the Project');
			setFocus(objintProjectID);
			return;
		}
		objTaskType = GetObjectReference('frmPM_TaskEasyEdit','optTaskType',true);
		strTaskType = 'O';
		//  Purpose-To pass EmployeeID into Querystring 
		var intEmployeeID;
		intEmployeeID = GetObjectReference('frmPM_TaskEasyEdit','cboEmployee').value;
		if (IsValidInput() == true)
		{
		
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
			objfrm.action = "PM_Task_EasyEdit.aspx?FromWhere=PM&Mode=List&Weekly=True&ProjectID=" + intProjectID + "&EmployeeID=" + intEmployeeID + "&TaskType='O'&FromDate=<%=Date.Parse(DateAdd("d",7,m_dtFromDate1))%>&ToDate=<%=Date.Parse(DateAdd("d",7,m_dtToDate1))%>";
			//objfrm.action = "PM_Task_EasyEdit.aspx?FromWhere=PM&Mode=List&Weekly=True&ProjectID=" + intProjectID + "&EmployeeID=" + intEmployeeID + "&TaskType='O'&FromDate="+txtFromDate+"&ToDate="+txtToDate;
			//objfrm.action = "PM_Task_EasyEdit.aspx?FromWhere=PM&Mode=List&Weekly=True&FromDate=" + txtFromDate + "&ToDate=" + txtToDate + "&ProjectID=" + intProjectID + "&TaskType='O'&EmployeeID=" + intEmployeeID + "&IsEdit="+IsEdit;
			
			objfrm.submit();
		}
	}
	function Show_OnClick()
	{
	
		var objFromDate, objToDate, intProjectID, strTaskType, objTaskType, intCnt;
		objFromDT=GetObjectReference('frmPM_TaskEasyEdit','txtFromDate');
		objFromDate = GetObjectReference('frmPM_TaskEasyEdit','txtFromDate').value;
		//alert(objFromDate);
		objToDT = GetObjectReference('frmPM_TaskEasyEdit','txtToDate');
		objToDate = GetObjectReference('frmPM_TaskEasyEdit','txtToDate').value;
		//alert(objToDate);
		objintProjectID = GetObjectReference('frmPM_TaskEasyEdit','cboProject');
		intProjectID = GetObjectReference('frmPM_TaskEasyEdit','cboProject').value;
		 
		//objTaskType='O';
		// Purpose-To pass EmployeeID into Querystring 
		var intEmployeeID ;
		intEmployeeID = GetObjectReference('frmPM_TaskEasyEdit','cboEmployee').value;
		 
		var objAllTasks;
		objTaskType = 'O';
		objEmployee = GetObjectReference('frmPM_TaskEasyEdit','cboEmployee');
		 
		if ((strTaskType=='A') && (intEmployeeID==''))
		{
			alert("Resource Selection is mandatory if 'Show All Tasks Assigned' is selected")
			return;
		} 
			/*
		if (IsValidInput() == true)
		{
		 
			objfrm.action = "PM_Task_EasyEdit.aspx?FromWhere=PM&Mode=List&Weekly=True&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&ProjectID=" + intProjectID + "&TaskType='O'&EmployeeID=" + intEmployeeID + "&IsEdit="+IsEdit;
			objfrm.submit();
		}*/
		 
		if(intProjectID=='')
		{
			alert('Please select the Project');
			setFocus(objintProjectID);
			return;
		}
		if (IsValidInput() == true)
		{
		    //alert('here');
            
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
			objfrm.action = "PM_Task_EasyEdit.aspx?FromWhere=PM&Mode=List&Weekly=True&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&ProjectID=" + intProjectID + "&TaskType='O'&EmployeeID=" + intEmployeeID + "&IsEdit="+IsEdit;
			
			objfrm.submit();
			
		}		
		
	}	
		
	function optTasks_OnClick(Show)
	{
	 
		var strFromDateVal, strToDateVal, objFromDate, objToDate;
		var txtToDate=GetObjectReference('frmPM_TaskEasyEdit','txtToDate');
		var txtFromDate=GetObjectReference('frmPM_TaskEasyEdit','txtFromDate');
		  
		//Get ObjectReference for SPAN tag
		var objSpanFromDt=GetObjectReference('frmPM_TaskEasyEdit','FromDate');
		var objSpanToDt=GetObjectReference('frmPM_TaskEasyEdit','ToDate');
		//Purpose : To show date controls if Show All Tasks is clicked.
		objStarID = GetObjectReference('frmPM_TaskEasyEdit','StarID');
		objStarIDTo = GetObjectReference('frmPM_TaskEasyEdit','StarIDTo');
		  		 
		objFromDate = GetObjectReference('frmPM_TaskEasyEdit','FFE29587WHIZ_txtFromDate');
		objToDate = GetObjectReference('frmPM_TaskEasyEdit','FFE29587WHIZ_txtToDate');
		 
		
	}
	
	function IsValidInput()
	{
	    var objFromDate, objToDate;
		var objEmployee;
		
		objFromDate = GetObjectReference('frmPM_TaskEasyEdit','txtFromDate');
		objToDate = GetObjectReference('frmPM_TaskEasyEdit','txtToDate');
		
		if(disallowDate1GreaterThanDate2(objFromDate, objToDate, "'From Date' should not be greater than 'To Date'", true))
			return false;
			
		return true;
	}
	function Save_OnClick()
	{
	    if(flag==1)
	    {
		    alert('Your Data is not valid');	
		    <%'Added By nitinVS on 2 May 2007 for PMLifeLine regression Fixes %>
		    return;	 
		    <% ' End Addition By nitinVS on 2 May 2007 for PMLifeLine regression Fixes %>
	    }
	    else
        {
            //var inValidDataExists = false;
            //$(".clsInvalid").each(function () {
            //    inValidDataExists = true;
            //    var curid = this.id;
            //    var oldid = curid.toString().replace("ctrPlanned_", "hidPlanned_");
            //    var oldval = $("#" + oldid).val();
            //    SendXMLHTTP_Save(this.id, oldval);                
            //});
            //Added By Usha Pandit On 20.04.2020 for validation alert is not getting closed 
            IsValid = true;            
            $('input[type="text"]').each(function () {
                if (this.id.toString().indexOf("FFE29587WHIZ_ctrStartDate_") != -1) {
                    var curid = this.id;
                    var oldid = curid.toString().replace("FFE29587WHIZ_ctrStartDate_", "hidStartDate_");
                    var oldval = $("#" + oldid).val();
                    SendXMLHTTP_Save(this.id, oldval);
                    if (IsValid == false) {
                        //$('*[id*=FFE29587WHIZ_ctrEndDate_]').trigger('blur');
                        //$('*[id*=ctrPlanned_]').trigger('blur');
                        //$("#" + curid).focus();
                        return false;
                    }                    
                }
                if (this.id.toString().indexOf("FFE29587WHIZ_ctrEndDate_") != -1) {
                    var curid = this.id;
                    var oldid = curid.toString().replace("FFE29587WHIZ_ctrEndDate_", "hidEndDate_");
                    var oldval = $("#" + oldid).val();
                    SendXMLHTTP_Save(this.id, oldval);
                    if (IsValid == false) {
                        //$('*[id*=FFE29587WHIZ_ctrStartDate_]').trigger('blur');
                        //$('*[id*=ctrPlanned_]').trigger('blur');
                        //$("#" + curid).focus();
                        return false;
                    } 
                }
                if (this.id.toString().indexOf("ctrPlanned_") != -1) {
                    var curid = this.id;
                    var oldid = curid.toString().replace("ctrPlanned_", "hidPlanned_");
                    var oldval = $("#" + oldid).val();                    
                    SendXMLHTTP_Save(this.id, oldval);
                    if (IsValid == false) {
                        //$('*[id*=FFE29587WHIZ_ctrStartDate_]').trigger('blur');
                        //$('*[id*=FFE29587WHIZ_ctrEndDate_]').trigger('blur');
                        //$("#" + curid).focus();
                        return false;
                    } 
                }
            });
            if (IsValid == false) {
                return;
            }
            //End Of Added By Usha Pandit On 20.04.2020 for validation alert is not getting closed 
            //if (inValidDataExists == true) {
            //    if (IsValid == false) {
            //        return;
            //    }
            //}
	        //Added By VijayD On24 August 2009
            var objFromDate, objToDate, intProjectID, intEmployeeID ;
            intProjectID = GetObjectReference('frmPM_TaskEasyEdit','cboProject');
            intEmployeeID=GetObjectReference('frmPM_TaskEasyEdit','cboEmployee');
		    objFromDate = GetObjectReference('frmPM_TaskEasyEdit','txtFromDate');
		    objToDate = GetObjectReference('frmPM_TaskEasyEdit','txtToDate');
    		if(intProjectID=='')
		    {
			    alert('Please select the Project');
			    setFocus(intProjectID);
			    return;
		    }		 
            <% if IsXMLHTTP_Off = true then %>
            if (IsValidInput() == true)
            {
                //Added by Tejal D date 12/10/2016 for FOR SAVE ISSUE 
                //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
                var MenuTags = document.getElementsByTagName('A');
                for (i = 0; i < MenuTags.length; i++) {
                    if (MenuTags[i].className == "Menu") {
                        //MenuTags[i].style.display= "none";
                        MenuTags[i].parentNode.style.display = "none";
                    }
                }
                setFrameLoader();
                //ADDED BY Tejal D ON 12/2/2016 FOR SAVE ISSUE  
                // End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 

                //End of Addtion by tejal Deshmukh date 12/10/2016  FOR SAVE ISSUE 

                objfrm.action="../DB/PM_Task_EasyEdit.aspx?FromXML=0&Action=Save&TaskID=<%=strTaskID%>&ProjectID="+intProjectID.value+"&EmployeeID="+intEmployeeID.value+"&IsEdit="+IsEdit ;
                objfrm.submit();		
            }			
	        <% else %>
	        //Added by Tejal D date 12/10/2016 for FOR SAVE ISSUE 
	        //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
	        var MenuTags = document.getElementsByTagName('A');
	        for (i = 0; i < MenuTags.length; i++) {
	            if (MenuTags[i].className == "Menu") {
	                //MenuTags[i].style.display= "none";
	                MenuTags[i].parentNode.style.display = "none";
	            }
	        }
	        setFrameLoader();
	        //ADDED BY Tejal D ON 12/2/2016 FOR SAVE ISSUE  
	        // End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 

	        //End of Addtion by tejal Deshmukh date 12/10/2016  FOR SAVE ISSUE 

                objfrm.action = "PM_Task_EasyEdit.aspx?TaskID=<%=strTaskID%>&ProjectID="+intProjectID.value+"&EmployeeID="+intEmployeeID.value+"&IsEdit="+IsEdit ;
                objfrm.submit();
		    <% end if %>		
		    //End Addition By VijayD On24 August 2009
	    }
	}
//Added by NitinC on 20 Jan 2012 for PMLifeLine - Agile Module (Issue Fix : 58849)
function ValidateUSDates(StartDate,EndDate,CurrentWork,TaskID)
{
    //Validation with user story startdate and end date 
    //debugger;
    
    var isValid =1;
    var strUrl="../PM/AjaxCallIteration.aspx?Flag=GraphicalView&StartDate=" + StartDate + "&EndDate=" + EndDate +"&ID="+ TaskID;
    if (document.all)  
    {   objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
        objXHttp.onreadystatechange = HandlerOnReadyState;
        objXHttp.open('GET',strUrl, false); 
        objXHttp.send();          
    }  
    else  {
    objXHttp = new XMLHttpRequest(); 
    objXHttp.onreadystatechange = HandlerOnReadyState(); 
    objXHttp.open('GET',strUrl, false);
    objXHttp.send(null);  
    }
    var strDateMsg='';
    var objXHttp;
    var blnFlag = false;        
    var strText = new String();
    var arrStr = new Array();   
    function HandlerOnReadyState()
    {
        if (objXHttp.readyState==4)
        {
            if (objXHttp.responseText != null) 
            {
                strText = objXHttp.responseText;  
                arrStr = strText.split(',');
                strTextisValid = arrStr[0];  //Is Valid StartDate and EndDate of task  
                strTextReleaseStartDate = arrStr[1];    //User Story Start Date 
                strTextReleaseEndDate = arrStr[2]; //User Story End Date
                strInitialEstimate = arrStr[3];  // User Story Initial Estimate 
                strTextUserStoryName = arrStr[4]; //User Story Name 
                strEffort = arrStr[5]; // Sum of efforts of all task entered till date for that user story 
                intSum =  parseInt(strEffort) + parseInt(CurrentWork) // Sum of current effort and calculated all efforts till date        
                if (strTextisValid == 0)           
                { 
                    isValid = 0;
                    alert('Start Date and End Date should be between User Story : "'+strTextUserStoryName+'" Dates i.e. '+ strTextReleaseStartDate + ' and ' + strTextReleaseEndDate);
                    return false;
                }
                if (parseInt(intSum) > parseInt(strInitialEstimate))
                {
			        
                    var cnf = confirm('Your planned Estimate for User Story ['+strTextUserStoryName+'] is : '+strInitialEstimate+' hrs\nAnd till date you have estimated hours for tasks under this user story is : '+intSum+' hrs\nNow you have entered '+CurrentWork+' hrs which will break your estimation. \nSystem will automatically increase your estimated hrs for user story.\nDo you want to save anyway?');
                    if (cnf == false){isValid = 0; return false;}
                    if (cnf == true){isValid = 1; return true;}
                }
            }
        }
    }
    if (isValid == 0)           
    { 
        return false;
    }
    else
    {
        return true;
    }    
}
//End of Added by NitinC on 20 Jan 2012 for PMLifeLine - Agile Module (Issue Fix : 58849)
	function IsValidData(FieldName, Fieldvalue,oldValue)
    {  
                
				var arrstrings;				
				var objFieldName= GetObjectReference('frmPM_TaskEasyEdit',''+ FieldName + '');				 
				ProjectStartDate="<%=ProjectStartDate%>";
				ProjectEndDate="<%=ProjectEndDate%>";
				if(FieldName.match("Planned") !=null)
				{
					arrstrings = FieldName.split("_");
				}
				else
				{
					arrstrings = objFieldName.hidID.split("_");
				}
				
		 
				if (arrstrings[0].match("Date") != null)
				{
						//To validate date format..	
						//DateControl_StandardOnblur('frmPM_TaskEasyEdit',objFieldName.hidID,dateInputFormat,'Invalid Date format or Invalid Date.');
						if (disallowBlank(objFieldName , "Start Date/ End Date should not be empty! ", "frmPM_TaskEasyEdit") == true)
						{
							flag=1;
							Fieldvalue = (Fieldvalue-0).toFixed(2);
							IsValid=false;
							<% ' Modified By NitinVS on 12 Apr 2007 for PMLifeLine Regression, changed to "retrun false" from  "return" %>
							return false;
							<% ' End Modification By NitinVS on 12 Apr 2007 for PMLifeLine Regression %>
						}
						<%' Added By NitinVS on 17 Apr 2007 for PMLifeLine regression Issue Fixes %>
						<%' to validate for empty other date and effort as these are mandatory %>
						if(FieldName.match("StartDate") != null)
						{
							objOtherDate = GetObjectReference('frmPM_TaskEasyEdit',''+ FieldName.replace("StartDate","EndDate") + '');	
							
							if (disallowBlank(objOtherDate , "End Date should not be empty! ", "frmPM_TaskEasyEdit") == true)
							{
								flag=1;
								Fieldvalue = (Fieldvalue-0).toFixed(2);
								IsValid=false;
								return false;
							}							
							
						}
						else if (FieldName.match("EndDate") != null)
						{
							objOtherDate = GetObjectReference('frmPM_TaskEasyEdit',''+ FieldName.replace("EndDate","StartDate") + '');	
							if (disallowBlank(objOtherDate , "Start Date should not be empty! ", "frmPM_TaskEasyEdit") == true)
							{
								flag=1;
								Fieldvalue = (Fieldvalue-0).toFixed(2);
								IsValid=false;
								return false;
							}														
						}
						
						<%' End Addition By NitinVS on 17 Apr 2007 for PMLifeLine regression Issue Fixes %>
						 
						if (DateControl_StandardOnblur('frmPM_TaskEasyEdit',objFieldName.hidID,dateInputFormat,'Invalid Date format or Invalid Date.')==false)
						{		 
							IsValid=false;
							return false;
						}
						 
				}
				else
				{
							var oldval=objFieldName.value;
							if (disallowBlank(objFieldName , "Planned work hours should not be empty! ", "frmPM_TaskEasyEdit") == true)
							{
								flag=1;
								Fieldvalue = (Fieldvalue-0).toFixed(2);
								IsValid=false;
								return false;
							}
							if (disallowNonNumeric1(objFieldName , "Please enter only valid numeric Data!", "frmPM_TaskEasyEdit") == true)
							{
							flag=1;
							IsValid=false;
								return false;
							}
							
						<%' Added By NitinVS on 17 Apr 2007 for PMLifeLine regression Issue Fixes %>
						<%' to validate for empty other date and effort as these are mandatory %>

							objOtherEndDate = GetObjectReference('frmPM_TaskEasyEdit',''+ FieldName.replace("Planned","EndDate") + '');
							objOtherStartDate = GetObjectReference('frmPM_TaskEasyEdit',''+ FieldName.replace("Planned","StartDate") + '');
							
							if (disallowBlank(objOtherEndDate , "End Date should not be empty! ", "frmPM_TaskEasyEdit") == true)
							{
								flag=1;
								Fieldvalue = (Fieldvalue-0).toFixed(2);
								IsValid=false;
								return false;
							}
							
							if (disallowBlank(objOtherStartDate , "Start Date should not be empty! ", "frmPM_TaskEasyEdit") == true)
							{
								flag=1;
								Fieldvalue = (Fieldvalue-0).toFixed(2);
								IsValid=false;
								return false;
							}							
						
						<%' End Addition By NitinVS on 17 Apr 2007 for PMLifeLine regression Issue Fixes %>
													
							//////////////////////////////////////////////////////////////////////////////////////////////////
							//For Case 2 and 3 project validations..
							if(IsCaseOneProject=="False")
							{
							
							
										var objParentPlanned = GetObjectReference('frmPM_TaskEasyEdit','' + FieldName + '', false);
										//document.getElementsByName(document.getElementById(FieldName))
										
										var strID = FieldName.split("_");
										var objParentPlannedHrs = GetObjectReference('frmPM_TaskEasyEdit','tdPlanned_' + strID[2] + "_" + strID[2] + '', false);
										 			
										var PlannedHours = GetObjectReference('frmPM_TaskEasyEdit','hidPlanned_' + strID[2] + '', true);
										var ThisPlanned =  GetObjectReference('frmPM_TaskEasyEdit','hidPlanned_' + strID[1] + '_' + strID[2] + '');
										ThisPlanned.value = Fieldvalue;
										var intCnt, ChildPlanned=0, TotalChildlanned=0;
										for (intCnt=1; intCnt<PlannedHours.length; intCnt++)
										{
											ChildPlanned = parseFloat(PlannedHours[intCnt].value);
											TotalChildlanned = TotalChildlanned + ChildPlanned;
										}
										 
										// alert('hi');
										//alert(PlannedHours[0].value);
										 //alert(TotalChildlanned);
										 
										//Modified by vidyak on 09 Sep 2010 for Display Planned Efforts related Alerts  on Restrict Duration/Work Change for Assigned tasks flag.
		                                //Added if(TaskRistValidation == "True")
		                                var TaskRistValidation = "<%=CommonFunctions.Application.RestrictDurationChange_O%>";
                                        if(TaskRistValidation == "True")
                                        {
										 // added By purvaj on 28 Nov 2008 for PMLifeLine 
										         var ActualHours = GetObjectReference('frmPM_TaskEasyEdit','hidtxtActual'+strID[1]);
										         if (ActualHours !=null && parseFloat(Fieldvalue) < parseFloat(ActualHours.value))
										         {
										            alert('Planned Hours Should be greater than actual hours (' +ActualHours.value+')');
										            if(flag != 1 )
											        setFocus(objFieldName);
											        flag=0;
											        IsValid=false;
											        return false;
										         }
                                         }	//End  if(TaskRistValidation == "True")									         
										    
										 // End addition purvaj
		 //Added by TruptiK
 	 //Purpose:-To add validation for Date.
							var objactualStartDate=GetObjectReference('frmPM_TaskEasyEdit','hidtxtActualStartDate'+strID[1]);
							
							 if (objactualStartDate.value !='' && Fieldvalue > objactualStartDate.value)
							 {
							//
								flag=0;
								IsValid=false;
								return false;					
								
							}
							//End	
										if (PlannedHours[0].value < TotalChildlanned)
										{
											alert("Planned Hours should not be greater than the Parent Planned Hours.");
											if(flag != 1 )
											setFocus(objFieldName);
											flag=1;
											
											//select(objFieldName);
											//alert(oldval);		
											//alert(objFieldName.value);
											//objFieldName.value=oldval;										 
											IsValid=false;
											return false;
										}
										//
										
										//
							}//End of Case Checking..
			//////////////////////////////////////////////////////////////////////////////////////////
			
							//Modified By ShraddhaM	on 21 Aug 2006 for PMLifeLine
							if(FieldName.match("Planned") !=null)
							{
								var StartDateID="FFE29587WHIZ_"+FieldName.replace("Planned","StartDate");			
								var StartDateValue = document.getElementById(StartDateID).value;
								//alert('StartDateID '+StartDateValue);
								var EndDateID="FFE29587WHIZ_"+FieldName.replace("Planned","EndDate");
								var EndDateValue = document.getElementById(EndDateID).value;
								//alert(EndDateValue);
								var FieldNameObj= document.getElementById(FieldName);
								
								var ConvertedStartDateFormat=ConvertIntoDate(StartDateValue,dateInputFormat);
								var ConvertedStartDate=new Date(ConvertedStartDateFormat);
								
								var ConvertedEndDateFormat=ConvertIntoDate(EndDateValue,dateInputFormat);
								var ConvertedEndDate=new Date(ConvertedEndDateFormat);
				     							 
								var TotalDays=DateDiff(ConvertedStartDate,ConvertedEndDate,"d");
								<%'Added By nitinVS on 27 Mar 2007 for PMLifeLine Regression IssueID 11907%>
								<% 'When Dates are invalid set focus on date field %> 
								if(StartDateValue=="")
								{
									alert("Start Date should not be empty.");
									setFocus(document.getElementById(StartDateID));
									IsValid=false;
									return false;
								}				
												
								if(EndDateValue=="")
								{
									alert("Start Date should not be empty.");
									setFocus(document.getElementById(EndDateID));
									IsValid=false;
									return false;
								}				
								
								TotalDays=Number(TotalDays)+1;
								
								if( TotalDays <=0 )
								{
									alert("Either Start Date or End Date are not valid");
									setFocus(document.getElementById(StartDateID));
									IsValid=false;
									return false;
								}
								<% 'End Addition  By nitinVS on 27 Mar 2007 for PMLifeLine Regression IssueID 11907 %>
								var HrsPerDay=Number(Fieldvalue)/Number(TotalDays);
							 
                                if (Number(HrsPerDay) > 24) {
                                    alert('You cannot assign more than 24 hours work per day');

                                    setFocus(FieldNameObj);
                                    IsValid = false;                                   
                                    return false;
                                }
                                else if (Number(HrsPerDay) > Number(intCompanyHrsPerDay)) {
                                    //alert('1212');

                                    var strMsg = "<%=MyBase.GetResourceString("WORK_PER_DAY_EXEEDS_MAX")%>";
                                    strMsg = replaceSubstring(strMsg, "<=>", HrsPerDay.toString());
                                    strMsg = replaceSubstring(strMsg, "<==>", intCompanyHrsPerDay.toString());
                                    
                                    if (!confirm(strMsg)) {
                                        IsValid = false;
                                        return false;

                                    }
                                }
										//For Project Work HRs Validation TO Case 1 Project
										if(IsCaseOneProject=="True")
										{
											 
											var objTotalAllocatedTaskLCE;
											var CWork = parseFloat(Fieldvalue);
											objTotalAllocatedTaskLCE = parseFloat("<%=m_dblTotalAllocatedTaskLCE%>");		
														//alert(oldValue);		
											//Check whether the Total work hours assigned to the Tasks are more then the work hours for Project
											if(CWork + (parseFloat("<%=m_dblTotalAllocatedTaskLCE%>")-oldValue) > parseFloat("<%=m_dblTotalLCE%>"))
											{
												 	var dblBalancedHrs;
													dblBalancedHrs = <%=m_dblTotalLCE%> - <%=m_dblTotalAllocatedTaskLCE%>  ;
													dblBalancedHrs =dblBalancedHrs + parseFloat(oldValue);
													strMsg = "<%=MyBase.GetResourceString("ASSIGNEDTASKS_WORKHOURS_NOT_MORE_THAN_PROJECT_WORKHOURS")%>";
													strMsg = replaceSubstring(strMsg, "<=>", parseFloat("<%=m_dblTotalLCE%>").toFixed(2));
													strMsg = replaceSubstring(strMsg, "<==>", dblBalancedHrs.toFixed(2));
													alert(strMsg);
													IsValid=false;
													return false;
												}
												
										 // added By purvaj on 28 Nov 2008 for PMLifeLine 
										 //if(FieldName.match("Planned") != null)
				                        // {
					                        var arrTaskIDs = FieldName.split("_");
    			                         //}
										 var ActualHours = GetObjectReference('frmPM_TaskEasyEdit','hidtxtActual'+arrTaskIDs[1]);
										 //alert(FieldName);
                                         //Modified by vidyak on 09 Sep 2010 for Display Planned Efforts related Alerts  on Restrict Duration/Work Change for Assigned tasks flag.
		                                //Added if(TaskRistValidation == "True")
		                                var TaskRistValidation = "<%=CommonFunctions.Application.RestrictDurationChange_O%>";
                                        if(TaskRistValidation == "True")
                                        {
										     if (ActualHours !=null && parseFloat(Fieldvalue) < parseFloat(ActualHours.value))
										     {
										        alert('Planned Hours Should be greater than actual hours (' +ActualHours.value+')');
										        setFocus(FieldNameObj);
											    IsValid=false;
											    return false;
										     }
                                        }	//End if(TaskRistValidation == "True")									  
										 // End addition purvaj
										 
											}
																						
										//End of For Project Work HRs Validation TO Case 1 Project
										
										
							}
							//Ended By ShraddhaM on 21 Aug 2006 for PMLifeLine
			
				}
		
		 
		 
		 
					if (arrstrings[0].match("EndDate") != null)
					{ 
							//Parent Task Dependent validation..
							if(IsCaseOneProject=="False")
							{
							        //Modified By VarunA on 19-Aug-2008 RequestID-14286
							        //Purpose : To have the task start date
									//var objFieldName1= GetObjectReference('frmPM_TaskEasyEdit','hidEndDate_' + arrstrings[2]+ '_' + arrstrings[2]);
									var objFieldName1= GetObjectReference('frmPM_TaskEasyEdit','ctrStartDate_' + arrstrings[1] + '_' + arrstrings[2]);
									//End BY VarunA on 19-Aug-2008 RequestID-14286
												
									var objParentEndDate= GetObjectReference('frmPM_TaskEasyEdit','hidEndDate_' + arrstrings[2] + '_' + arrstrings[2]);
									
									//Modified By VarunA on 19-Aug-2008 RequestID-14286
									//if(disallowDate1GreaterThanDate2(objFieldName1 , objFieldName, "'From Date' should not be greater than 'To Date'", true))
									if(disallowDate1GreaterThanDate2(objFieldName,objFieldName1, "'From Date' should not be greater than 'To Date'", true))
									//End BY VarunA on 19-Aug-2008 RequestID-14286
									{
										IsValid=false;
										return false;
									}	
									var objParentPlanned = GetObjectReference('frmPM_TaskEasyEdit','' + FieldName + '', false);
									
									//Modified By ShraddhaM on 9 Aug 2006 for PMLifeLine
									
									var objParentStartDate= GetObjectReference('frmPM_TaskEasyEdit','hidStartDate_' + arrstrings[2] + "_" + arrstrings[2]);
									
										var objFlag=TaskEdit_DisallowDate1GreaterThanDate2(objParentStartDate.value,objParentEndDate.value,objFieldName.value,dateInputFormat,dateFormat)
										//alert('objFlag'+objFlag);
										 
											 
										if(objFlag==false)
										{
											flag=1;
											alert('Date should be between the Parent Task Start Date And End Date');
											//objFieldName.value=oldValue;
											//setFocus(objFieldName);	
											//objFieldName.value=oldValue;
											IsValid=false;
											return false;				
										}
									}//End of case Checking If clause..
							//End of Parent Task Dependent validation..
											var dtCurrentEndDate=objFieldName.value;
											
											dtCurrentEndDate=ConvertIntoDate(dtCurrentEndDate,dateInputFormat);
																						 
											var StartDateID=FieldName.replace("End","Start");
											
											var dtCurrentStartDate = document.getElementById(StartDateID).value;
											dtCurrentStartDate=ConvertIntoDate(dtCurrentStartDate,dateInputFormat);
																						
											var OldProjectStartDate=ProjectStartDate;
											var OldProjectEndDate=ProjectEndDate;																			 
																						
											ProjectStartDate=getDate(ProjectStartDate);
											ProjectEndDate=getDate(ProjectEndDate);
																						
											var TaskStartDate=new Date(dtCurrentStartDate);
											var TaskEndDate=new Date(dtCurrentEndDate);
											
											var dtCurrentStartDate=new Date(dtCurrentStartDate);
											var dtCurrentEndDate= new Date(dtCurrentEndDate);
												
												if(TaskStartDate > TaskEndDate)
												{
												    alert('Start Date Should not be greater than End Date');
												   	IsValid=false;
													return false;
												}
						
							  
 	 //Added by TruptiK
 	 //Purpose:-To add validation for Date.
							var objactualStartDate=GetObjectReference('frmPM_TaskEasyEdit','hidtxtActualStartDate'+ arrstrings[1]);
					
							
                        var actualStartDate = getDate(objactualStartDate.value);

                        var NewTaskEndDate = getDate(TaskEndDate);
                        //var TaskEndDate=getDate(TaskEndDate);
							
                        //debugger;
                       // alert(actualStartDate.toLocaleDateString());
                       // alert(TaskEndDate.toLocaleDateString());
                       // alert(NewTaskEndDate.toLocaleDateString());
                        //alert(objactualStartDate.value);
                        //Commented & Added By Dipali V On 17th July 2020 For alert issue
                        //if (objactualStartDate.value != '' && TaskEndDate <= actualStartDate)
                        //if (TaskEndDate != actualStartDate) {
                        if (objactualStartDate.value != '' && TaskEndDate.toLocaleDateString() < actualStartDate.toLocaleDateString())
                             //End of Commented & Added By Dipali V On 17th July 2020 For alert issue
							 {
							
								alert('Planned End Date should not be less than Actual Start Date('+objactualStartDate.value+')');
								if(flag != 1 )
								setFocus(objFieldName);
								flag=0;
								IsValid=false;
								return false;					
								
							}
							//End	
							  
							  
							  //Dates should not in between the Projects start and End dates.
								dtProjectStartDate = ProjectStartDate;								
								dtProjectEndDate = ProjectEndDate;
							
								if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (TaskStartDate != null) && (TaskEndDate != null))
								{
							
									if((TaskStartDate < dtProjectStartDate) || (TaskEndDate > dtProjectEndDate))
									{	
										
										strMsg="<%=MyBase.GetResourceString("TASKDATES_BETWEEN_PROJECTDATES")%>";
									
										strMsg = replaceSubstring(strMsg, "<=>","<%=ProjectStartDate%>");
										
										strMsg = replaceSubstring(strMsg, "<==>","<%=ProjectEndDate%>");
										alert(strMsg);		
										IsValid=false;	
										return false;
									}
								}
		
											
											var intHolidays=0;
											var bitHoliday = false;
											var intDays;
											var intCnt;
											var intCount;
											var dtHoliday;
											var strMsg;
											var dtCurrentDate;
											//var strStartingDay;
											var intCnt1;
											if(strHolidays != "")
											{		
												strMsg="<%=MyBase.GetResourceString("THEDATES")%>\n";
												strHolidayList = strHolidays.split(',');
												
												for(intCount=0; intCount < strHolidayList.length-1 ; intCount++)
												{					
													intDays = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d");
												
															intCnt1=0;					
															for(intCnt=0; intCnt1 <=intDays;intCnt1++)
															{
																
																  
																dtCurrentDate = DayAdd(dtCurrentEndDate, intCnt);
																
																dtHoliday = getDate(strHolidayList[intCount]);	
																
																	if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()) && (dtCurrentDate.getYear() == dtHoliday.getYear()))
																	{
																		
																		bitHoliday=true;
																		 
																		strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
																		strMsg = strMsg + "-" + dtCurrentDate.getYear() + "\n";
																		intHolidays = intHolidays + 1;
																	}
																//}
																intCnt=intCnt-1;
															}
															
															
												}
											}
											
								
												if(bitHoliday == true)			
                                                {
                                                    
													if(! confirm(strMsg + "<%=MyBase.GetResourceString("DATE_HOLIDAY_MSG")%>"))
													{
														//setFocus(objFieldName);
														IsValid=false;
														return false;
													}
												}		

												for(intCnt=0; intCnt <= DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d"); intCnt++)
												{
													dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt); 
													 
													//Purpose:To give alert for weekend based on Staring day of week set at carporate level. 
													switch(strStartingDay) 
													{
													case "1" :
														if(DatePart("w", dtCurrentDate, 2) > intCompanyWeekDays)		// Need to do
														intHolidays = intHolidays + 1;
														break
													case "2" :
														if(DatePart("w", dtCurrentDate, 3) > intCompanyWeekDays)		
														intHolidays = intHolidays + 1;
														break
													case "3" :
														if(DatePart("w", dtCurrentDate, 4) > intCompanyWeekDays)		
														intHolidays = intHolidays + 1;
														break
													case "4" :
														if(DatePart("w", dtCurrentDate, 5) > intCompanyWeekDays)		
														intHolidays = intHolidays + 1;
														break
													case "5" :
														if(DatePart("w", dtCurrentDate, 6) > intCompanyWeekDays)		
														intHolidays = intHolidays + 1;
														break
													case "6" :
														if(DatePart("w", dtCurrentDate, 7) > intCompanyWeekDays)		
														intHolidays = intHolidays + 1;
														break
													case "7" :
														if(DatePart("w", dtCurrentDate, 1) > intCompanyWeekDays)		
														intHolidays = intHolidays + 1;
														break
													}
										 
												}//End of For Loop..

						 
						
									var ConvertedStartDate=new Date(dtCurrentStartDate);
									var ConvertedEndDate=new Date(dtCurrentEndDate);
			     									
									var PlannedID=FieldName.replace("FFE29587WHIZ_ctrEndDate","ctrPlanned");			
								
									var PlannedValue = document.getElementById(PlannedID).value;
									//alert(PlannedValue);
									var oldPlannedValue=PlannedValue;
								
									var TotalDays=DateDiff(ConvertedStartDate,ConvertedEndDate,"d");
							
									TotalDays=Number(TotalDays)+1;
										
										var HrsPerDay=PlannedValue/TotalDays;
										
											if(HrsPerDay > 24)
											{
												alert('You Can not assign more than 24 hrs per day');					
												//alert("<%=MyBase.GetResourceString("WORK_PER_DAY_MORE_THAN_24")%>");
												//setFocus(objFieldName);
												//objFieldName.value=oldValue;
												 
												 IsValid=false;
												return false;
                        }	
                        //Commented By Usha Pandit On 20.04.2020 for duplicate confirmation appearing multiple times 
											<%--else if(HrsPerDay > intCompanyHrsPerDay)
											{ 
												var strMsg = "<%=MyBase.GetResourceString("WORK_PER_DAY_EXEEDS_MAX")%>";
												strMsg = replaceSubstring(strMsg,"<=>",HrsPerDay.toString());
												strMsg = replaceSubstring(strMsg,"<==>",intCompanyHrsPerDay.toString());
												//strMsg="'You are assigning <=> hours work per day. \n(OU working hours per day are <==> hours.) \nDo you wish to continue?";
												//confirm('You are assigning <=> hours work per day. \n(OU working hours per day are <==> hours.) \nDo you wish to continue?')
                                               
                                                
                                                if (!confirm(strMsg)) {
                                                    IsValid = false;
                                                    return false;
                                                    //setFocus(FieldName);
                                                    //return false;
                                                }
                                                    
											}--%>
                        //End Of Commented By Usha Pandit On 20.04.2020 for duplicate confirmation appearing multiple times 
										//}
									//Ended By ShraddhaM on 21 Aug 2006 for PMLifeLine
									
									
				}//End of EndDate IF..
				else
				{
					 
						if (arrstrings[0].match("StartDate") != null)
						{
						 
							//Parent Task Dependent validation..	
							if(IsCaseOneProject=="False")
							{							
							            var objFieldName1= GetObjectReference('frmPM_TaskEasyEdit','ctrEndDate_' + arrstrings[1] + '_' + arrstrings[2]);
										
										var objParentStartDate= GetObjectReference('frmPM_TaskEasyEdit','hidStartDate_' + arrstrings[2] + "_" + arrstrings[2]);
										
										if(disallowDate1GreaterThanDate2(objFieldName , objFieldName1, "'From Date' should not be greater than 'To Date'", true))
											return false;
											
										//Modified By ShraddhaM on 9 Aug 2006 for PMLifeLine
											
										var objParentEndDate= GetObjectReference('frmPM_TaskEasyEdit','hidEndDate_' + arrstrings[2] + '_' + arrstrings[2]);
										
										
										var objFlag=TaskEdit_DisallowDate1GreaterThanDate2(objParentStartDate.value,objParentEndDate.value,objFieldName.value,dateInputFormat,dateFormat)
											 
										if(objFlag==false)
										{
											flag=1;
											alert('Date should be between the Parent Task Start Date And End Date');	
											//objFieldName.value=oldValue;
											//setFocus(objFieldName);
											IsValid=false;
											return false;				
										}
								}//End of Case Checkinh IF Clause..
							// End of Parent Task Dependent validation..
							
							//if(disallowDate1GreaterThanDate2(objFieldName , objFieldName1, "'From Date' should not be greater than 'To Date'", true))
											//return false;
							var dtCurrentStartDate=objFieldName.value;
							
							dtCurrentStartDate=ConvertIntoDate(dtCurrentStartDate,dateInputFormat);
							
							var EndDateID=FieldName.replace("Start","End");
							
							var dtCurrentEndDate = document.getElementById(EndDateID).value;
							dtCurrentEndDate=ConvertIntoDate(dtCurrentEndDate,dateInputFormat);
							
							var dtCurrentStartDate=new Date(dtCurrentStartDate);
							var dtCurrentEndDate= new Date(dtCurrentEndDate);
								 			
								var OldProjectStartDate=ProjectStartDate;
								var OldProjectEndDate=ProjectEndDate;																			 
											
											 //ProjectStartDate=new Date(ProjectStartDate);
											 //ProjectEndDate=new Date(ProjectEndDate);
								ProjectStartDate=getDate(ProjectStartDate);
								ProjectEndDate=getDate(ProjectEndDate);

								var TaskStartDate=new Date(dtCurrentStartDate);
								var TaskEndDate=new Date(dtCurrentEndDate);
											
												
											
												if(TaskStartDate > TaskEndDate)
												{
													alert('Start Date Should not be greater than End Date');
													//Added By VarunA 6-Aug-2008 RequestID-14286
													//Purpose : When the start date is only changed, and when we click on save then the changes is not been made.
													setFocus(document.getElementById(EndDateID.replace("End","Start")));
													//End By VarunA 6-Aug-2008 RequestID-14286
													IsValid=false;
													return false;
												}
														
														
														

								//Dates should not in between the Projects start and End dates.
		  //Added by TruptiK
 	 //Purpose:-To add validation for Date.
							var objactualStartDate=GetObjectReference('frmPM_TaskEasyEdit','hidtxtActualStartDate'+ arrstrings[1]);
							//alert(arrstrings[1]);
							//alert(objFieldName.value);
							var actualStartDate=getDate(objactualStartDate.value);
							
							
							 
							 if (objactualStartDate.value !='' && TaskStartDate > actualStartDate)
							 {
							//
								alert('Planned start date should not be greater than Actual Start Date('+objactualStartDate.value+')');
								if(flag != 1 )
								setFocus(objFieldName);
								flag=0;
								IsValid=false;
								return false;					
								
							}
							//End	
								dtProjectStartDate = ProjectStartDate;
							
								dtProjectEndDate = ProjectEndDate;
								
								if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (TaskStartDate != null) && (TaskEndDate != null))
								{
								
									if((TaskStartDate < dtProjectStartDate) || (TaskEndDate > dtProjectEndDate))
									{	
										
										strMsg="<%=MyBase.GetResourceString("TASKDATES_BETWEEN_PROJECTDATES")%>";
										
										strMsg = replaceSubstring(strMsg, "<=>","<%=ProjectStartDate%>");
									
										strMsg = replaceSubstring(strMsg, "<==>","<%=ProjectEndDate%>");
										alert(strMsg);	
										IsValid=false;		
										return false;
									}
								}			  
										
											
							var intHolidays=0;
							var bitHoliday = false;
							var intDays;
							var intCnt;
							var intCount;
							var dtHoliday;
							var strMsg;
							var dtCurrentDate;
							var strStartingDay;
							if(strHolidays != "")
							{		
								strMsg="<%=MyBase.GetResourceString("THEDATES")%>\n";
								strHolidayList = strHolidays.split(',');
								var dtCurrentStartDate=new Date(dtCurrentStartDate);
								
									 
									for(intCount=0; intCount < strHolidayList.length-1 ;intCount++)
									{
									 
										intDays = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d");
										//alert(intDays);
										for(intCnt=0; intCnt <= intDays;intCnt++)
										{
										
											dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
											
											//if(DatePart("w", dtCurrentDate, 2) <= intCompanyWeekDays)		//Need to do
											//{
												dtHoliday = getDate(strHolidayList[intCount]);
												
												if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()) && (dtCurrentDate.getYear() == dtHoliday.getYear()))
												{
													 
													bitHoliday=true;
													 
													strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
													strMsg = strMsg + "-" + dtCurrentDate.getYear() + "\n";
													intHolidays = intHolidays + 1;
												}
											
											
										}//for loop..
									}//For loop..
								}//If of Holidyas Ends..
				 
				
									if(bitHoliday == true)			
                                    {
                                        
										if(! confirm(strMsg + "<%=MyBase.GetResourceString("DATE_HOLIDAY_MSG")%>"))
										{
											
											IsValid=false;
											return false;
										}
									}		
									 
										var strStartingDay="<%=m_strStartingDayOfWeek%>";
										var intCompanyWeekDays = <%=m_lngWeekDays%>;
										
										for(intCnt=0; intCnt <= DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d"); intCnt++)
										{
											dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt); 
											
											//Purpose:To give alert for weekend based on Staring day of week set at carporate level. 
											
											switch(strStartingDay) 
											{
											case "1" :
												if(DatePart("w", dtCurrentDate, 2) > intCompanyWeekDays)		// Need to do
												intHolidays = intHolidays + 1;
												break
											case "2" :
												if(DatePart("w", dtCurrentDate, 3) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "3" :
												if(DatePart("w", dtCurrentDate, 4) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "4" :
												if(DatePart("w", dtCurrentDate, 5) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "5" :
												if(DatePart("w", dtCurrentDate, 6) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "6" :
												if(DatePart("w", dtCurrentDate, 7) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "7" :
												if(DatePart("w", dtCurrentDate, 1) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											}
								 
										}//End of For Loop..

										///////////////////////////////////
										
										dblAvgHoursPerDay = 0;
																				
										dblTotalDuration = DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d") + 1;
										
										if(dblTotalDuration - intHolidays == 0)
										{
											
											//Remove the Comments after inserting the DatePart function.
											if(!confirm("<%=MyBase.GetResourceString("DAYS_ARE_HOLIDAYS")%>"))
											{
												IsValid=false;
												return false;			
											}	
											dblTotalDuration = DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d") + 1;
											//dblAvgHoursPerDay = dblTotalWork/dblTotalDuration;
											
										}
										//////////////////////////////////////
										
									var ConvertedStartDate=new Date(dtCurrentStartDate);
						
									var ConvertedEndDate=new Date(dtCurrentEndDate);
			     																		
					 
									var PlannedID=FieldName.replace("FFE29587WHIZ_ctrStartDate","ctrPlanned");			
									
									var PlannedValue = document.getElementById(PlannedID).value;
									var oldPlannedValue=PlannedValue;
									
									var TotalDays=DateDiff(ConvertedStartDate,ConvertedEndDate,"d");
									
									 TotalDays=Number(TotalDays)+1;
									 
								<%'Added By nitinVS on 27 Mar 2007 for PMLifeLine Regression IssueID 11907%>
								<% 'When Dates are invalid set focus on date field %> 
							
								if( TotalDays <=0 )
								{
									alert("Either Start Date or End Date are not valid");
									setFocus(document.getElementById(dtCurrentStartDate));
									IsValid=false;
									return false;
								}
								<% 'End Addition  By nitinVS on 27 Mar 2007 for PMLifeLine Regression IssueID 11907 %>									 
						
									var HrsPerDay=PlannedValue/TotalDays;
						 	
                            if (HrsPerDay > 24) {
                                alert('You Can not assign more than 24 hrs per day');
                                //alert("<%=MyBase.GetResourceString("WORK_PER_DAY_MORE_THAN_24")%>");
                                //setFocus(objFieldName);
                                //objFieldName.value=oldValue;
                                PlannedValue = oldPlannedValue;
                                IsValid = false;
                                return false;
                            }
                            //Commented By Usha Pandit On 20.04.2020 for duplicate confirmation appearing multiple times 
                            <%--else if (HrsPerDay > intCompanyHrsPerDay) {
                                var strMsg = "<%=MyBase.GetResourceString("WORK_PER_DAY_EXEEDS_MAX")%>";
                                strMsg = replaceSubstring(strMsg, "<=>", HrsPerDay.toString());
                                strMsg = replaceSubstring(strMsg, "<==>", intCompanyHrsPerDay.toString());

                                if (!confirm(strMsg)) {
                                    IsValid = false;
                                    return false;

                                }
                            }--%>
                            //End Of Commented By Usha Pandit On 20.04.2020 for duplicate confirmation appearing multiple times 
									
						//}
					//Ended By ShraddhaM on 21 Aug 2006 for PMLifeLine
				//return;
				//End of Modification
			}
		}
		 
		//var objFieldName= GetObjectReference('frmPM_TaskEasyEdit',''+ FieldName + '');
		  
						if (arrstrings[0].match("Planned") != null)
						{
						  						 
						  	var StartDateID="FFE29587WHIZ_"+FieldName.replace("Planned","StartDate");			
							var StartDateValue = document.getElementById(StartDateID).value;
										
							var EndDateID="FFE29587WHIZ_"+FieldName.replace("Planned","EndDate");
							var EndDateValue = document.getElementById(EndDateID).value;
								
								
							dtCurrentStartDate=ConvertIntoDate(StartDateValue,dateInputFormat);
								
							dtCurrentEndDate=ConvertIntoDate(EndDateValue,dateInputFormat);
							
							var dtCurrentStartDate=new Date(dtCurrentStartDate);
							var dtCurrentEndDate= new Date(dtCurrentEndDate);
								
											var OldProjectStartDate=ProjectStartDate;
											var OldProjectEndDate=ProjectEndDate;																			 
											
											ProjectStartDate=getDate(ProjectStartDate);
											ProjectEndDate=getDate(ProjectEndDate);
											
											var TaskStartDate=new Date(dtCurrentStartDate);
											var TaskEndDate=new Date(dtCurrentEndDate);
											
											
						objCurrentWork = objFieldName;
						
						if(disallowBlank(objCurrentWork, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>", true))
						return false;
						if(disallowMinValueViolation(objCurrentWork, 0.00001, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>",true))
						return false;
			
												if(TaskStartDate > TaskEndDate)
												{
													alert('Start Date Should not be greater than End Date');
													IsValid=false;
													return false;
												}				
																										
			  
												//Dates should not in between the Projects start and End dates.
												dtProjectStartDate = ProjectStartDate;
											
												dtProjectEndDate = ProjectEndDate;
											
												if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (TaskStartDate != null) && (TaskEndDate != null))
												{
												
													if((TaskStartDate < dtProjectStartDate) || (TaskEndDate > dtProjectEndDate))
													{	
														
														strMsg="<%=MyBase.GetResourceString("TASKDATES_BETWEEN_PROJECTDATES")%>";
													
														strMsg = replaceSubstring(strMsg, "<=>","<%=ProjectStartDate%>");
														
														strMsg = replaceSubstring(strMsg, "<==>","<%=ProjectEndDate%>");
														alert(strMsg);	
														IsValid=false;		
														return false;
													}
												}
											
											
							var intHolidays=0;
							var bitHoliday = false;
							var intDays;
							var intCnt;
							var intCount;
							var dtHoliday;
							var strMsg;
							var dtCurrentDate;
							var strStartingDay;
							if(strHolidays != "")
							{		
							
								strMsg="<%=MyBase.GetResourceString("THEDATES")%>\n";
								strHolidayList = strHolidays.split(',');
								//var dtCurrentStartDate=new Date(dtCurrentStartDate);
								
									
									for(intCount=0; intCount < strHolidayList.length-1 ;intCount++)
									{
									 
										intDays = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d");
										//alert(intDays);
										for(intCnt=0; intCnt <= intDays;intCnt++)
										{
										
											dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
											
											//if(DatePart("w", dtCurrentDate, 2) <= intCompanyWeekDays)		//Need to do
											//{
												dtHoliday = getDate(strHolidayList[intCount]);
												
												if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()) && (dtCurrentDate.getYear() == dtHoliday.getYear()))
												{
													 
													bitHoliday=true;
													 
													strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
													strMsg = strMsg + "-" + dtCurrentDate.getYear() + "\n";
													intHolidays = intHolidays + 1;
												}
											
											
										}//for loop..
									}//For loop..
								}//If of Holidyas Ends..
				 
				
									if(bitHoliday == true)			
                                    {
                                        
										if(! confirm(strMsg + "<%=MyBase.GetResourceString("DATE_HOLIDAY_MSG")%>"))
										{
											
											IsValid=false;
											return false;
										}
									}		

										for(intCnt=0; intCnt <= DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d"); intCnt++)
										{
											dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt); 
											 
											//Purpose:To give alert for weekend based on Staring day of week set at carporate level. 
											switch(strStartingDay) 
											{
											case "1" :
												if(DatePart("w", dtCurrentDate, 2) > intCompanyWeekDays)		// Need to do
												intHolidays = intHolidays + 1;
												break
											case "2" :
												if(DatePart("w", dtCurrentDate, 3) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "3" :
												if(DatePart("w", dtCurrentDate, 4) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "4" :
												if(DatePart("w", dtCurrentDate, 5) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "5" :
												if(DatePart("w", dtCurrentDate, 6) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "6" :
												if(DatePart("w", dtCurrentDate, 7) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											case "7" :
												if(DatePart("w", dtCurrentDate, 1) > intCompanyWeekDays)		
												intHolidays = intHolidays + 1;
												break
											}
								 
										}//End of For Loop..

		
									var ConvertedStartDate=new Date(dtCurrentStartDate);						
									var ConvertedEndDate=new Date(dtCurrentEndDate);																	
					 				var PlannedID=FieldName.replace("FFE29587WHIZ_ctrStartDate","ctrPlanned");										
									var PlannedValue = document.getElementById(PlannedID).value;
									var oldPlannedValue=PlannedValue;
									//alert(PlannedValue);
									var TotalDays=DateDiff(ConvertedStartDate,ConvertedEndDate,"d");
											//alert('t'+TotalDays);
									TotalDays=Number(TotalDays)+1;						
									var HrsPerDay=PlannedValue/TotalDays;						 
						 
						 
						 	if((objFieldName.value / <%=CommonFunctions.Application.MinHoursForDAEntry%>) != parseInt(objFieldName.value / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
									{										 
										 
											var strMsg = "<%=MyBase.GetResourceString("VALID_WORK")%>";
											strMsg = replaceSubstring(strMsg, "<==>", "<%=CommonFunctions.Application.MinHoursForDAEntry%>");
										alert(strMsg);
										//objFieldName.value=oldValue;
										//setFocus(objFieldName);
										IsValid=false;
										return false;
										 
									}
							//}
						}
				
	return true;
	}
	function disallowNonNumeric1(obj,msg,frm)
	{
	
		if ( disallowNonNumeric(obj,msg) == true )
		{
			if ((arguments.length>3)?arguments[3]:true)
			{
				window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
			}
			//flagSubmit = false;
			return true;	
		}
		//flagSubmit = true;
		return false;
	}
	
	var IsEdit = 0;
	
	function Help_OnClick(HelpID)
	{
		 
		window.open("../General/Help.aspx?HelpID=" + HelpID ,"_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250"); 

		//<a class='Menu' href='javascript:Help_OnClick('TaskEdit') title='Help'>?</a>
	}

	<%' Added By NitinVS on 12 July 2007 for PMLifeLine to Validate for Resource dates%>
	function ValidateResourceDate(strReID,objSDt,objEDt)
	{
		var objResourceStartDate,objResourceEndDate,objEmp
		var dtResourceStartDate,dtResourceEndDate
		var intIndex=0;
		var strMsg;

		objResourceStartDate = GetObjectReference('frmPM_TaskEasyEdit','cboResourceStartDate');
		objResourceEndDate = GetObjectReference('frmPM_TaskEasyEdit','cboResourceEndDate');
		if(objResourceStartDate !=null && objResourceEndDate !=null )
		{
			for(j=0;j<objResourceStartDate.options.length;j++)
			{
				if(objResourceStartDate.options[j].value == strReID)
				{
					dtResourceStartDate = getDate(objResourceStartDate[j].text);
					dtResourceEndDate = getDate(objResourceEndDate[j].text);
					if(DateDiff(objSDt,dtResourceStartDate,  "d")>0)
					{
						strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_ON_PROJECT")%>';
						strMsg = replaceSubstring(strMsg, '<==>', objResourceStartDate[j].text);
						strMsg = replaceSubstring(strMsg, '<===>', objResourceEndDate[j].text);
						alert(strMsg);
						return false;
					}
					if(DateDiff(dtResourceEndDate, objEDt, "d")>0)
					{
						strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_ON_PROJECT")%>';
						strMsg = replaceSubstring(strMsg, '<==>', objResourceStartDate[j].text);
						strMsg = replaceSubstring(strMsg, '<===>', objResourceEndDate[j].text);
						alert(strMsg);
						return false;
					}				
				}
			}			

		}
		return true;
	}	
<%' End Addition By NitinVS on 12 July 2007 for PMLifeLine to Validate for Resource dates%>

function ValidateTaskEfforts()
{
    return false;
}
        </script>
	</body>
</HTML>
