<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Prioritization.aspx.vb" Inherits="PbNIT.PM_Prioritization" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <%CommonFunctions.General.PlotPageHeadTag("Prioritization")%>
    
    <title>Prioritization</title>
</head>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script language="javascript" src="../General/CommonFunctions.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>  -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    //$(document).ready(function () {
    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Web Form Extension Type
    //    // Description:Remove section header row in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:23/01/2015
    //    /*---------------------------------------------------------*/
    //    if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
    //        removeSectionHeader();
    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
    //    /*---------------------------------------------------------*/
    //    if ($('.clsgridtable').length > 0) {
    //        var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
    //        dataCollapse(divName);
    //    }
    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveTopMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveFooterMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Sub Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveSubTableTopMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Sub Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveSubTableFooterMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Remove footer
    //    // Description:Display none footer in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:16/01/2015
    //    /*---------------------------------------------------------*/
    //    /* Display none footer in Tablet and Mobile view*/

    //    var windowWidth = $(window).width();
    //    if (windowWidth < 992) {

    //    }
    //    else {

    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Remove footer
    //    /*---------------------------------------------------------*/

    //    $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Responsive Navigation Tabs
    //    // Description:Display navigation tabs in dropdown
    //    // By Whom: Miiint
    //    // When:07/02/2015
    //    /*---------------------------------------------------------*/
    //    $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
    //    $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
    //    var responsiveNavigationClass = 'responsiveNavigationTabsClass';
    //    var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
    //    if (windowWidth < 992) {
    //        responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
    //    }
    //    else {
    //        $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
    //    }

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Responsive Navigation Tabs
    //    /*---------------------------------------------------------*/

    //    $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
    //    $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
    //    // Description:removing plus sign with footable functionality for 'Total' column
    //    // By Whom: Miiint
    //    // When:27/04/2015
    //    /*---------------------------------------------------------*/

    //    if (windowWidth < 1040) {
    //        var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
    //        if (text == "Total") {
    //            $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
    //            $('#tblGrid1053121').find('tr:last').css('display', 'none');
    //        }
    //    }

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
    //    /*---------------------------------------------------------*/
    //});

    //$(window).resize(function () {
    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Top Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveTopMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    //    // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:10/02/2015
    //    /*---------------------------------------------------------*/
    //    responsiveFooterMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveSubTableTopMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-FooterMenuDropDown
    //    // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:28/05/2015
    //    /*---------------------------------------------------------*/
    //    responsiveSubTableFooterMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-FooterMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Remove footer
    //    // Description:Display none footer in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:16/01/2015
    //    /*---------------------------------------------------------*/
    //    /* Display none footer in Tablet and Mobile view*/

    //    var windowWidth = $(window).width();
    //    if (windowWidth < 992) {

    //    }
    //    else {

    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Remove footer
    //    /*---------------------------------------------------------*/
    //    $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Responsive Navigation Tabs
    //    // Description:Display navigation tabs in dropdown
    //    // By Whom: Miiint
    //    // When:07/02/2015
    //    /*---------------------------------------------------------*/
    //    responsiveNavigationTabsResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Responsive Navigation Tabs
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-collapse & close for tablet view
    //    // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
    //    // By Whom: Miiint
    //    // When:17/02/2015
    //    /*---------------------------------------------------------*/
    //    collapseDivsResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-collapse & close for tablet view
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
    //    // Description:removing plus sign with footable functionality for 'Total' column
    //    // By Whom: Miiint
    //    // When:27/04/2015
    //    /*---------------------------------------------------------*/

    //    if (windowWidth < 1040) {
    //        var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
    //        if (text == "Total") {
    //            $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
    //            $('#tblGrid1053121').find('tr:last').css('display', 'none');
    //        }
    //    }

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
    //    /*---------------------------------------------------------*/

    //});

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



<%--End of Commented and Added By Ankit P on 16th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()" style="visibility:hidden">
		
		<form id="frmPrioritization" name="frmPrioritization" method="post" runat="server" >
					<iframe id="iFloatingMenu" name="iFloatingMenu" style="display:none;z-index:100; position:absolute;overflow:visible;" ></iframe>

			<%PageInit()%>
		<%-- '=========================About this Page============================================
        ' Page Name             : Prioritization
        ' Purpose               : Prioritization of Story ,Bug features for whizibleSEM 10.0
        ' Description           : THIS PAGE AND CODE(VB.NET,JAVA SCRIPT,HTML,CSS ETC.) DEVELOPED BY AMIT MAHADIK 
        ' 
        ' 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : June 2011
        ' Revisions             :
        
        document.getElementById("check1").checked
        '=====================================================================--%>
				
		
			</form>		
	
		<script language="Javascript">
		
		    var objform = GetFormReference('frmPrioritization');
		    var objDivMain = GetObjectReference('frmPrioritization', 'DivMain');
		var isValid =0;
		var TimerID = 0;
		var oEl     = null;
		var oTarget = null;
		var beginDrag = false;
		var tmpHTML = "";
		var Priority;	
		var arrElements;
		//debugger;		
		var strCsvIDS=GetObjectReference('frmCommonList','txtHid',true);		
		var i;
		var str='';
        var len=strCsvIDS.length;
        for(i=0;i<len;i++)
        {
          str=str+strCsvIDS[i].value+','
        }          
        arrElements=str.split(",");
        //debugger;
		function killTimer()
		{
			if (TimerID != 0 )
			{
				clearTimeout(TimerID);
				TimerID = 0;
			}
		}
		var flagSubmit = true;
			var controlArray;
			
			
			
				
			var blnisSaved = 0; 
			
					
		function fnShowDragWindow() 
		{
			var obj = document.all("DW");
			
			killTimer();
			
			if (oEl == null)  
			{
				return;
			}
			
			obj.style.top		= oEl.offsetTop;
			obj.style.left		= oEl.offsetLeft;
			obj.style.height	= oEl.offsetHeight - 3;
			obj.style.width		= oEl.offsetWidth - 3;
			//obj.innerText		= oEl.SpecimenId;
			obj.innerHTML		= oEl.innerHTML;
			obj.style.display	= "block";
			obj.style.zIndex = 999;
			//Added By Aniruddh Gujar on 21-JAN-2016 Purpose::Whiz SEm Regression Issue fixing
			obj.style.color = "black";
		    //End of Added By Aniruddh Gujar on 21-JAN-2016 Purpose::Whiz SEm Regression Issue fixing
			
            //Commented and Modified By Aniruddh Gujar on 21-JAN-2016 Purpose::Whiz SEm Regression Issue fixing
			//window.document.attachEvent( "onmousemove"  , fnMove );
			//window.document.attachEvent( "onscroll"  , fnMove );
			//window.document.attachEvent( "onmousemove" , fnCheckState );
			//window.document.attachEvent( "onmouseup"    , fnRelease );
		    //window.document.attachEvent( "onselectstart", fnSelect );
			window.document.addEventListener("onmousemove", fnMove);
			window.document.addEventListener("onscroll", fnMove);
			window.document.addEventListener("onmousemove", fnCheckState);
			window.document.addEventListener("onmouseup", fnRelease);
			window.document.addEventListener("onselectstart", fnSelect);
		    //End of Commented and Modified By Aniruddh Gujar on 21-JAN-2016 Purpose::Whiz SEm Regression Issue fixing
			//window.document.attachEvent("onmouseover",setTarget);
			
			beginDrag = true;
		}
		
		function setTarget(id)
		{
		    //debugger;
			var src = document.getElementById(id);
			
			if (src == null) 
			{
				return;
			}
			
			if (src.target == 'true')
			{
				oTarget = src;
				
			}
			else
			{
				oTarget = null;	
			}
		}
		
		function BeginDrag(id)
		{
		    //debugger;
			// Get the item to be dragged.
			oEl = document.getElementById(id);
			
			// Is there an item?
			if(oEl == null)
			{
				return;
			}
			
			tmpHTML = oEl.innerHTML;
			// Set the window timeout.
			TimerID = setTimeout(fnShowDragWindow, 1);
		}			
		
		
		function fnCheckState()
		{
			if(event.button != 1)
			{
				fnRelease();
			}
		}
		
		function fnSelect()
		{
			return false;
		}
		
		
		function fnMove()
		{
			if (event.button != 1)
			{
				fnRelease();
				return;
			}
			
			var obj = document.all("DW");
			
			obj.style.top = event.clientY - (obj.offsetHeight / 2 )  + window.document.body.scrollTop;  
			obj.style.left = event.clientX  + window.document.body.scrollLeft;
			obj.style.backgroundColor = "gray" //amit
			window.status = 'Top=' + obj.style.top + ' Left=' + obj.style.left;
			
			if (event.clientY > window.document.body.clientHeight - 10 )
			{
				//window.scrollBy(0, 10);
			}
			else if (event.clientY < 10)
			{
				//window.scrollBy(event.clientX, -10);
			}
			
		}
		 function getIndex(ArrayList,element)
          {
               for (i=0;i< ArrayList.length;i++)
                  {
                    if (ArrayList[i]== element)
                       {
                           break;
                       }

                    }
               return i;
           }
		function fnRelease()
		{
		
		    if (beginDrag == false) return;
		       				    
			window.document.detachEvent( "onmousemove" , fnMove );
			window.document.detachEvent( "onscroll" , fnMove );
			window.document.detachEvent( "onmousemove" , fnCheckState );
			window.document.detachEvent( "onmouseup" , fnRelease );
			window.document.detachEvent( "onselectstart", fnSelect );
			//window.document.detachEvent( "onmouseover", setTarget );
			
			var obj = document.all("DW");
			
			if (oTarget != null) 
			{	
				var targetHTML = oTarget.innerHTML;
				var targetSpecId = oTarget.SpecimenId;
				var sourceSpecId = oEl.SpecimenId;
					//alert("targetSpecId:"+targetSpecId);
					//alert("sourceSpecId:"+sourceSpecId);
					//============================================
					

                        var sourceElement = targetSpecId;
                        var destinationElement = sourceSpecId;
                       // debugger;
                       //*******************************AJAX CALL to save priority when dragged and dropped*****************************************
                        var strUrl="../PM/AjaxCallIteration.aspx?Flag=UpdPrioritize&SourceElement=" + sourceElement + "&DestinationElement=" + destinationElement;// +"&ID="+ ReleaseID;
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
				                    //strText = objXHttp.responseText;  
				                    //arrStr = strText.split(',');
                                    //strTextisValid = arrStr[0];    
                                    //strTextReleaseStartDate = arrStr[1];    
                                    //strTextReleaseEndDate = arrStr[2];    
					                    if (strText != 'TRUE')           
					                    { 
						                    //isValid = 0;
						                    //alert('Start Date and End Date should be between Release Dates i.e. '+ strTextReleaseStartDate + ' and ' + strTextReleaseEndDate);return;
					                    }
				                }
				            }
                        }
                       if (isValid == 0)           
		                { 
		                //return;
		                }
                        //************************************************************************
                        var sourceIndex = getIndex(arrElements ,sourceElement)
                        var destinationIndex = getIndex(arrElements ,destinationElement)


                       // var sourceIndex = getIndex(arrElements ,sourceElement)
                       // var destinationIndex = getIndex(arrElements ,destinationElement)

                        arrElements.splice(sourceIndex ,1);
                        arrElements.splice(sourceIndex ,0,destinationElement);
                        arrElements.splice(destinationIndex ,1,"$###$");

                        var PHIndex = getIndex(arrElements ,"$###$")
                        arrElements.splice(PHIndex ,1,sourceElement);

                        //alert(arrElements);  //prioritize list
					//============================================
				oEl.innerHTML = targetHTML;
		
				oEl.SpecimenId = targetSpecId;
				oTarget.SpecimenId = sourceSpecId;
				
				oTarget.innerHTML = tmpHTML;
				
				// Is the container empty?
				if(oTarget.innerHTML != "")
				{
					//oTarget.style.backgroundColor="beige";
				}
				else
				{
					//oTarget.style.backgroundColor = "turquoise";
				}
				
				if(oEl.innerHTML != "")
				{
					//oEl.style.backgroundColor = "beige"
				}
				else
				{
					//oEl.style.backgroundColor = "turquoise"
				}
			}
			
			killTimer();
			
			obj.style.display	= "none";
			oEl					= null;
			oTarget				= null;
			beginDrag			= false;
			TimerID				= 0;
			
			//Added by swapnil aswale
			window.open ("../PM/EditEfforts_CommonList.aspx?MasterTagID=9001&FromWhere=PM", "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=750,height=400");
			
			//ended by swapnil aswale
		}
		
		
		function CancelDrag()
		{
			if (beginDrag == false)
			{
				killTimer();
			}
		}
			
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
		
				document.body.style.visibility='visible';
				 
				//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
					

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
			//Commented and added by Yogesh J on 11/12/2015
			    //objDivMain.style.height = intDivHeight	;
			objDivMain.style.height = intDivHeight + 'px';
				
				intMaxEntry = 24;
				
			
			}
			
			function window_onresize()		
			{
				
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
					

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
				if (intDivHeight < 100)
					intDivHeight = 100;
				//objDivMain.style.height = intDivHeight	;	
				
			}
//			function Name_OnClick(ID,Flag)
//			{
//			    //debugger;
//			    if (Flag == "RELEASE")
//			    {
//			        window.open("../General/CommonPage.aspx?ReleaseID_PK=" + ID +"&MasterTagID=8083&FromWhere=PM" ,"","left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-400)/2 + ",width=600,height=400");
//			        
//			        //../General/CommonPage.aspx?MastertagID=20121&<PARAMETERS>,"MyPage","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400"
//			        //http://localhost/WhizibleSEM10.0/Source/General/CommonPage.aspx?ReleaseID_PK=18&PKToken=CtkJ4r9WgFYvvlNmMoZ0/w&MasterTagID=8083&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1
//			    }
//			    if (Flag == "ITERATION")
//			    {
//			        window.open("../General/CommonPage.aspx?IterationID_PK=" + ID +"&MasterTagID=8084&FromWhere=PM" ,"","left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-400)/2 + ",width=600,height=400");
//			    } 
//			}
//			
			
			function GetPrioritizeList() 
		    {
		    
             var isStory;
             var isBug ;
             var isFeature;
            // debugger;
             if(document.getElementById("chkStory").checked){isStory=1} else {isStory=0}
            ////Commented by NitinC on 05 April 2012 For WhizibleSEM 11.0
            if(document.getElementById("chkBug").checked){isBug=1} else {isBug=0}
            ////End of Commented by NitinC on 05 April 2012 For WhizibleSEM 11.0

              //if(document.getElementById("chkFeature").checked){isFeature=1} else {isFeature=0}
           
           
		        //objform.action = "PM_Prioritization.aspx?isStory="+isStory+"&isBug="+isBug+"&isFeature="+isFeature+"&isList=0";
                
                objform.action = "PM_Prioritization.aspx?isStory="+isStory+"&isBug="+isBug+"&isList=0";
  
		        objform.submit();
			 
			}	
			function Efforts(evt)
			{
			   
			    alert('This is efforts!');
			}
			
			//Added by NitinC on 14 July 2011 for WhizibleSEM v10.0 (Agile Methodology)
			var objFrame=GetObjectReference('','iFloatingMenu');
			var ie5=document.all&&document.getElementById
			
			function ShowFloatingmenu(Mode,ev)
            {
                window.open ("../PM/EditEfforts_CommonList.aspx?MasterTagID=9001&FromWhere=PM", "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=750,height=400");
                /*
                    //debugger;
                        var ObjSearch;
                        
                        if(objFrame==null)
                            return;
                        
                        objFrame.style.display='';
                       
                        
                       
                        if(Mode=='Efforts')
                        {
                            objFrame.style.height="350px";//"225px";
                            objFrame.style.width="600px";
                        }    
                            
                        //objFrame.src='../PM/Scrum_FloatingMenu.aspx?Mode=GoTO&TagID=0&TemplateID=DB';
                        objFrame.src='../PM/EditEfforts_CommonList.aspx?MasterTagID=9001';
                        
                        
                        //showmenuie('iFloatingMenu',ev);
                            
                       
                    showFloatingmenu='1'; */
            }
            function showmenuie(divCM,objevent)
            {

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
                        
                     if (objDivH >400)
                        objDivH=400;
                                 
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
                        e.stopPropagation();
                   
                  
                   return false;
  
            }
            /*function EditRow(strScrumPrioritizeID)
            {//debugger;
                var objFileGrid = GetObjectReference('frmPrioritization','tblList');
               var src = document.getElementById(strScrumPrioritizeID);
               var old_att;
               for(i=0;i<src.attributes.length;i++)
               {
                   if(src.attributes[i].nodeName == "onmouseup" || src.attributes[i].nodeName == "onmousedown" || src.attributes[i].nodeName == "onmouseover" || src.attributes[i].nodeName == "onmouseout")
                   {
                        attnode=src.attributes[i];
                        old_att=src.removeAttributeNode(attnode);
                   }
               }
            }*/
			//End Addition
			
			
		</script>
	<%--	DRAG DROP WINDOW--%>
		    <DIV class="clsDragWindow" id="DW" align="center" noWrap style="color:White; border:solid 2px black;background-image: url(../images/table_head_bg.gif);"></DIV>
	</body>
</html>
