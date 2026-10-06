<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Schedule_Timesheet.aspx.vb" Inherits="PbNIT.Schedule_Timesheet"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	   <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
	<% CommonFunctions.General.PlotPageHeadTag("Timesheet")%>
		<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
		<script language='javascript' src='../AdvancedTimesheet/timesheet.js'></script>
<%--	    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
		<script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added By Bharat T on 26th-Oct-2015*/
    .footerMenuTable
    {
           position:relative;
    }
    /*End of Added By Bharat T on 26th-Oct-2015*/
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

	<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmScheduleTS" method="post" runat="server">
			<%PageInit()%>
	    </form>

	<script language="javascript">
		
									
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		
        var objform=GetFormReference('frmScheduleTS');
		var objDivMain=GetObjectReference('frmScheduleTS','divPage');	 
		var objimgFilter =GetObjectReference('frmScheduleTS','imgFilter');
        var objcboproject=GetObjectReference('frmScheduleTS','cboProject');
		var objcboTaskTypeFilter=GetObjectReference('frmScheduleTS','cboTaskTypeFilter');
		var objcboPeriod=GetObjectReference('frmScheduleTS','cboPeriod');
		var objlblFilter=GetObjectReference('frmScheduleTS','lblFilter');
		var objCheckbox = GetObjectReference('frmScheduleTS','chkSelect',true);
	    var strRestrict_MPPTasks = '<%=m_blnRestrict_MPPTasks%>';
		var strRestrict_AssignedTasks = '<%=m_blnRestrict_AssignedTasks%>';
		var ie5=document.all&&document.getElementById
        var ns6=document.getElementById&&!document.all
		
	function window_onload()
	    {
	        var intDivHeight=0;

		    if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivMain.offsetTop-10 ;
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop -10;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
					
					
		        //Commented and added by nilesg g on 11/12/2015 for add PX
		        //objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight+'px';
			}
		AddFilterToolTip();	
	
		    
	  }
	  
	   function AddFilterToolTip()
	   {
	     var ToolTip,filterText,strProject,strTaskType,strPeriod;
	     
	     if(String(objcboproject.options[objcboproject.selectedIndex].text)!='')
	            strProject="'"+String(objcboproject.options[objcboproject.selectedIndex].text) +"'";
	      else
	             strProject='None';
	      
	      if(String(objcboPeriod.options[objcboPeriod.selectedIndex].text)!='')
	            strPeriod="'"+String(objcboPeriod.options[objcboPeriod.selectedIndex].text)+"'";
	      else
	             strPeriod='None';
	             
	      if(String(objcboTaskTypeFilter.options[objcboTaskTypeFilter.selectedIndex].text)!='')
	            strTaskType="'"+String(objcboTaskTypeFilter.options[objcboTaskTypeFilter.selectedIndex].text)+"'";
	      else
	             strTaskType='None';
	                          
	     ToolTip='Filter :->'+'\n'+'Project : '+strProject+'\n'+'Task Type : '+strTaskType+'\n'+'Period : '+ strPeriod;
	     filterText='[ Project : '+strProject+' ]'+' [Task Type : '+strTaskType +' ]'+' [Period : '+ strPeriod+']';
		 objimgFilter.alt=ToolTip;
		 
		 if(objlblFilter!=null)
		    objlblFilter.innerHTML=filterText;
	   }
	  function window_onresize()		
	   {		
		    var intDivHeight;
		    if(objDivMain)
		    {
			    intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 10;
			    if (intDivHeight < 100)	intDivHeight = 100;
		        //Commented and added by nilesg g on 11/12/2015 for add PX
		        //objDivMain.style.height = intDivHeight;
			    objDivMain.style.height = intDivHeight+'px';
		    }
	   } 
	
	    var ShowFilter='0';
	   function Filter_OnClick(show,e)
	    {
           //Commented And Added By Vaijat K ON 21/12/2015 IssueID-2800
	       //objDivFilter = GetObjectReference('frmScheduleTS','DivFilter');
	       objDivFilter = GetObjectReference('frmScheduleTS','divFilter');
        //Ended
	    img1='../../Images/cssImages/Link images/close.gif';
	    img2='../../Images/cssImages/Link images/Filter.gif';    

   
        if (ShowFilter=='0')
        {
      /*  objDivFilter.style.top= objimgFilter.style.top+20;//40; //20
        objDivFilter.style.left=500; //600
        objDivFilter.zIndex=99;
        objDivFilter.style.display='block';*/
        objimgFilter.src=img1;
       // objimgFilter.alt='Hide filter'
        ShowFilter='1';
        showmenuie(objDivFilter,e);
        }
        else if(ShowFilter=='1')
        {
        
        objDivFilter.style.display='none';
        objimgFilter.src=img2;
        ShowFilter='0';    
        //objimgFilter.alt='Show Filter' ;
        }
       
    }
    function showmenuie(objdiv,objevent){

//var objdiv = GetObjectReference('',divCM);

   objdiv.style.display='';
   objdiv.style.position = 'absolute'; 
   //Commented By Vaijat K ON 21/12/2015
    //Find out how close the mouse is to the corner of the window
    //var rightedge=ie5? document.body.clientWidth-event.clientX : 
    //    window.innerWidth-objevent.clientX
    //var bottomedge=ie5? document.body.clientHeight-event.clientY : 
    //    window.innerHeight-objevent.clientY

    //if the horizontal distance isn't enough to accomodate the width of 
        //the context menu
        //Ended
    var objDivH =objdiv.offsetWidth;

    if (objDivH > 400)
        objDivH=400;
        //Commented By Vaijat K ON 21/12/2015
    //if (rightedge<objDivH)
    ////move the horizontal position of the menu to the left by it's width
    //objdiv.style.left=ie5? 
    //    document.body.scrollLeft+event.clientX-objDivH : 
    //    window.pageXOffset+objevent.clientX-objDivH
     
    //else
    ////position the horizontal position of the menu where the mouse was clicked
    //objdiv.style.left=ie5? document.body.scrollLeft+event.clientX : 
    //    window.pageXOffset+objevent.clientX

    ////same concept with the vertical position
    //if (bottomedge<objdiv.offsetHeight)
    //    objdiv.style.top=(ie5? 
    //    document.body.scrollTop+event.clientY-objdiv.offsetHeight : 
    //    window.pageYOffset+objevent.clientY-objdiv.offsetHeight) +10
    //else
    //objdiv.style.top=(ie5? document.body.scrollTop+event.clientY: 
    //    window.pageYOffset+objevent.clientY) + 10
        
        //(document.body.scrollTop==0 ? 100 : 0)
        
        //objdiv.style.top=objdiv.style.top-100;
        //Commented And Added By Vaijat K ON 21/12/2015 IssueID-2800
  //if(ie5)
  //      window.event.cancelBubble = true;
  //  else if(ns6)
        //      e.stopPropagation();
        //Ended
        //Added By Vaijat K ON 21/12/2015
    if (WhichBrowser() != 'FF'){
        objdiv.style.right= event.pageX  + 'px';
        objdiv.style.left= event.pageX-300  + 'px';
        objdiv.style.top= event.pageY + 'px';
    }
    else
    {
        objdiv.style.right= objevent.pageX  + 'px';
        objdiv.style.left= objevent.pageX-300  + 'px';
        objdiv.style.top= objevent.pageY + 'px';
    }
    if (!e) var e = window.event
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
        
  
  return false;
  
    }
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
	   function Project_OnKeyUp(objtxt,evt)
	   {
	
	    if(String(objtxt.value) !='' && String(objtxt.value) !=']' && String(objtxt.value) !='[')
	    {
	      
	      if(String(objtxt.value).indexOf("]") >=0  ||  String(objtxt.value).indexOf("[") >=0 )
	        return;
	        
		     var patt1 = new RegExp(String(objtxt.value),"ig");
		     var blnIsApply=false;
    		 
		     for(i=1;i< objcboproject.length;i++)
		     {
			    if(patt1.test(String(objcboproject.options[i].text)))
			    {
				    objcboproject.selectedIndex=i;
				    blnIsApply=true;
				    break;
			    }
    			
		     }
    		    
		        if(blnIsApply)
		        {
		            var code;
	                if (evt.keyCode) code = evt.keyCode;
	                else if (evt.which) code = evt.which;
	                if(code==13) 
			            applyFilter(0);
			    }        
		}	    
	   }
	   function applyFilter(IsClear)
	   {
	     if(parseInt(IsClear)==1)
	     {
			objcboproject.value='';
			objcboTaskTypeFilter.value='';
			objcboPeriod.value='';	
				
	     }
	        strLocation = "Schedule_Timesheet.aspx?FromWhere=DA&PageNumber=1";
		    objform.action = strLocation
			objform.submit();
	   }

	    
	   function SelectOnClick(objchk,flag)
	   {
	        var objtxtPostHrs=GetObjectReference('frmScheduleTS','txtPostHrs'+objchk.value);
	        var objchkIsTaskComplete=GetObjectReference('frmScheduleTS','chkIsTaskComplete'+objchk.value);
	        var objdtEndDate=GetObjectReference('frmScheduleTS','FFE29587WHIZ_dtEndDate'+objchk.value);	
	        var objimgCal=GetObjectReference('frmScheduleTS','imgCal_'+objchk.value);
	        
	        if(objchk.checked==true)
	        {
	           	            
	            objtxtPostHrs.disabled=false;
	            objchkIsTaskComplete.disabled=false;
	            //objdtEndDate.disabled=false;
	           
	            
	            if(parseInt(flag)==0)
	                objtxtPostHrs.focus();
	             
	            
	        }
	        else
	        {
	            objtxtPostHrs.disabled=true;
	            objchkIsTaskComplete.disabled=true;
	           // objdtEndDate.disabled=true;
	           
		                    
	        }
	      
	      // RestrictTask(objchk);
	   }
	   
	   function RestrictTask(objchk)
	   {
	     var blnRestrict=false;
	   
	     if(objchk.checked==true)
	     {
	        var objstartDate=GetObjectReference('','txtHidTSD'+objchk.value);
	        var objendDate=GetObjectReference('','txtHidTED'+objchk.value);
	        var objwt=GetObjectReference('','txtHidWT'+objchk.value);
	        var objBE=GetObjectReference('','tdBE'+objchk.value);
	        var objdtEndDate=GetObjectReference('frmScheduleTS','dtEndDate'+objchk.value);
	        
	        //if(getDate(new Date()) < getDate(objstartDate.value) || getDate(new Date()) > getDate(objendDate.value) || parseFloat(objBE.innerHTML) < = 0 )
	        if(getDate(objdtEndDate.value) < getDate(objstartDate.value) || getDate(objdtEndDate.value) > getDate(objendDate.value) )
	        {
	            if(objwt.value=='O' && strRestrict_AssignedTasks=='True')
	                blnRestrict=true;
	        
	            if(objwt.value=='M' && strRestrict_MPPTasks=='True')
	                blnRestrict=true;  
	                
	           if(blnRestrict)
	            {
	                alert('Post Till Date should be between task planned start [ '+ objstartDate.value +' ] and end date [ '+ objendDate.value +' ]');
	                //objchk.checked=false;
	                setFocus(objdtEndDate);
	                return false;
	            }
	            
	       }
	     }
	        return true;
	   }
	   
	   //------------------------------------------------------------------------------
//Purpose : Select all check boxes
//------------------------------------------------------------------------------
	function SelectAll_OnClick(strFormName, strCheckbox)
	//Pass FormName and the Checkbox's ID
	{
		var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
		var intItems;
		var intCtr;
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
			if(intItems > 1) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].disabled == false)
					{
						objCheckbox[intCtr].checked = true;
					
						SelectOnClick(objCheckbox[intCtr],intCtr);
					}	
				}
			}
			// Else, if single element exists, then...
			else if(intItems == 1)
			{
				if (objCheckbox[0].disabled == false) 
				{
					objCheckbox[0].checked = true;						
					SelectOnClick(objCheckbox[0],0);
				}	
			}
		}
	
	}

//------------------------------------------------------------------------------
//Purpose : Clear all check boxes
//------------------------------------------------------------------------------
	function ClearAll_OnClick(strFormName, strCheckbox)
	//Pass FormName and the Checkbox's ID
	{
		var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
		var intItems;
		var intCtr;
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
						
			if(intItems > 1) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].disabled == false)
					{
						objCheckbox[intCtr].checked = false;							
						SelectOnClick(objCheckbox[intCtr],intCtr);
					}	
				}
			}
			// Else, if single element exists, then...
			else if(intItems == 1)
			{
				if (objCheckbox[0].disabled == false) 
				{
					objCheckbox[0].checked = false;						
					SelectOnClick(objCheckbox[0],0);
				}	
			}
		}
	 
	}
	
	   
        if(GetObjectReference('','txtNoOfPages'))
		{	
			var noOfPages = GetObjectReference('','txtNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('','txtPageNumber');
		}
		
	function Page_Onclick(PageNumber)
	{
		
		// Modified by SandipL on 3 Feb 2006 
		strLocation = "Schedule_Timesheet.aspx?FromWhere=DA&PageNumber=" + String(parseInt(PageNumber));
	
		objform.action = strLocation
		objform.submit();
	
	}
	function Save_OnClick()
	{
	    if(!validateControl()) return;
	    if(!validateNumPaging()) return;
	    
	     objform.action = "Schedule_Timesheet.aspx?FromWhere=DA&Action=SAVE";
		objform.submit();
	}
	function validateNumPaging()
    {

        if(objtxtpageNumber==null)
		    return false;
	   if(disallowBlank(objtxtpageNumber,"Please enter page number !",true))
		    return false;
		if(disallowNonNumeric(objtxtpageNumber,"Page number should be numeric only !",true))
		    return false;
		if(disallowNegativeNumeric(objtxtpageNumber,"Only positive number allowed !",true))
		    return false;            	    
		if(disallowNonInteger(objtxtpageNumber,"Only positive integer number allowed !",true))
		    return false;
		
		
		    
		if (Number(objtxtpageNumber.value) ==0)
		{
						alert("Page number should be greater than zero!");
						return false;
		}        
	    
	
	    if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
	    {
		    alert("Please enter value within range of 1 to "+noOfPages);
		    return false;
	    }
	    return true;
    }

	function validateControl()
	{
	  
		var intItems;
		var intCtr;
		var blnSelected=false;
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
			if(intItems > 0) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].checked== true)
					{
						//blnSelected=true;	
						var objtxtPostHrs=GetObjectReference('frmScheduleTS','txtPostHrs'+objCheckbox[intCtr].value);
						var objtdAW=GetObjectReference('frmScheduleTS','tdAW_'+objCheckbox[intCtr].value);
						var objdtEndDate=GetObjectReference('frmScheduleTS','dtEndDate'+objCheckbox[intCtr].value);
						
						if(parseFloat(objtxtPostHrs.value) <=0)
						{
						    alert('Value should be greater than zero !');
						    objtxtPostHrs.focus();
						    return false;
						}
						if (disallowBlank(objtxtPostHrs, "Post Effort On Working Day should not be blank !",true))
				        {	return false;	}
				        
				        if (disallowNonNumeric(objtxtPostHrs,'Please enter numeric value !',true))
				        {		return false;		}
				        
                        if (disallowValueRangeViolation(objtxtPostHrs,0,<%=m_dblTotalWorkHours%>,'The range for actual working hours is ' + (<%=m_dblTotalWorkHours%> - 0).toFixed(2) + ']' ,true))
				           {     return false ;       }
				        if(parseFloat(objtdAW.innerHTML) <  parseFloat(objtxtPostHrs.value))
				        { alert('Post effort should be less than or equal to allocated work hours !'); objtxtPostHrs.focus(); return false;}  
				        
				        if (disallowBlank(objdtEndDate, "Post task end date should not be blank !",true))
				        {	return false;	}
				        
				        if(!RestrictTask(objCheckbox[intCtr]))
				            return false;
					}	
				}
			}
			
		}   
	
	
	  /*  if(!blnSelected)
	    {
	        alert('Please select at least one task !');
	        return false;
	    }*/    
	    return true;
	}	
	
	function Delete_OnClick()
	{
	    var intItems;
		var intCtr;
		var blnSelected=false;
		
		if (objCheckbox != null)
		{
			
				for (intCtr = 0;intCtr <= objCheckbox.length - 1; intCtr++)
				{
					if (objCheckbox[intCtr].checked== true)
					{
						blnSelected=true;	
						break;
					}
				}		
		}	
		
		if(!blnSelected) { alert('Please select atleast one task for delete !'); return; }
		
		
	    objform.action = "Schedule_Timesheet.aspx?FromWhere=DA&Action=DELETE";
		objform.submit();
	}
	function Selection_OnClick(obj)
	{
	    objform.action = "Schedule_Timesheet.aspx?FromWhere=DA&PageNumber=1";
		objform.submit();
	}
	  </script> 	    
  </body>
</html>
