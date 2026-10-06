<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Advanced_Timesheet.aspx.vb"  Inherits="PbNIT.Advanced_Timesheet" %>
<HTML>
	 <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
	<% CommonFunctions.General.PlotPageHeadTag("Timesheet")%>
	
	<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
	
<head>

<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
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
    /* ADDED BY PUNEET M ON 18-11-2015 */
    #txtPageNumber {
        height: 20px;
        margin-top:0px !important;
    }
    #calendar tr th {
        color:black !important;
    }
    #calendar tr td table tr td a {
        color:black !important;
    }
    #calendar tr td table tr td {
        color:black !important;
    }
    /* ENDED BY PUNEET M ON 18-11-2015 */
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
 
</head>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmAdvancedTimesheet" method="post" runat="server">
			<%PageInit()%>
			<table class="clsTable" cellSpacing="0" cellpadding="0" width="100%">
				<tr class="clsTRBlank">
					<td class="clsTDBlank" id="tdCalender" vAlign="top" align="left">
						<div id="divCal" style="WIDTH: 100%">
                            <%--<asp:calendar id="calendar1" runat="server" ShowGridLines="True" DayNameFormat="FirstLetter" BorderColor="InactiveCaption"      
								BackColor="White" Width="216px" Height="184px" CssClass="clsTREven" ForeColor="ActiveBorder" NextPrevFormat="ShortMonth"    >
								<TodayDayStyle BackColor="LavenderBlush" Font-Bold="True" Font-Overline="False" BorderStyle="Double" BorderColor="InactiveCaption" BorderWidth="2px" ></TodayDayStyle>
								<SelectorStyle BackColor="#F7F7F7"></SelectorStyle>
								<DayStyle Font-Bold="True"></DayStyle>
								<DayHeaderStyle Font-Size="Smaller" HorizontalAlign="Justify" VerticalAlign="Middle" BackColor="#F7F7F7"></DayHeaderStyle>
								<SelectedDayStyle BackColor="#8080FF"></SelectedDayStyle>
								<TitleStyle Font-Bold="True" BackColor="#F7F7F7"></TitleStyle>
								<WeekendDayStyle  ></WeekendDayStyle>
								<OtherMonthDayStyle Font-Italic="True" BackColor="Transparent" ForeColor="Transparent" ></OtherMonthDayStyle>
							</asp:calendar>--%>
                            <%-- COMMENTED AND BY PUNEET M ON 18-11-2015 Issue ID: 2057 --%>
                            <asp:calendar id="calendar" runat="server" ShowGridLines="True" DayNameFormat="FirstLetter" BorderColor="InactiveCaption"      
								BackColor="White" Width="216px" Height="184px" CssClass="clsTREven" ForeColor="Black" NextPrevFormat="ShortMonth"    >
								<TodayDayStyle BackColor="LavenderBlush" Font-Bold="True" Font-Overline="False" BorderStyle="Double" BorderColor="InactiveCaption" BorderWidth="2px" ></TodayDayStyle>
								<SelectorStyle BackColor="#F7F7F7"></SelectorStyle>
								<DayStyle Font-Bold="True"></DayStyle>
								<DayHeaderStyle Font-Size="Smaller" HorizontalAlign="Justify" VerticalAlign="Middle" BackColor="#F7F7F7"></DayHeaderStyle>
								<SelectedDayStyle BackColor="#8080FF"></SelectedDayStyle>
								<TitleStyle Font-Bold="True" BackColor="#F7F7F7"></TitleStyle>
								<WeekendDayStyle  ></WeekendDayStyle>
								<OtherMonthDayStyle Font-Italic="True" BackColor="Transparent" ForeColor="#B4B4B4" ></OtherMonthDayStyle>
							</asp:calendar>
                            </br>
							<font color="red">RED</font> indicates non-working day
							<br/>
							(Holiday, leave or Weekend)&nbsp;&nbsp;&nbsp;<IMG src="../../Images/arrow_right.gif" border="0"/>
						</div>
					</td>
					<td id='tdGrid' vAlign="top" align="left" style="width:80%;" >
						<!--<div id="divPage" style="OVERFLOW: auto; WIDTH: 100%">-->
						<%DrawPage()%>
						<!--</div>-->
						</td>
				</tr>
			</table>
			
		</form>
		
		<script language="javascript">
			var arrAlltxtboxIDs=new Array();
		var arrMessages = new Array();
		arrMessages[0] = "";
		arrMessages[1] = "<%=MyBase.GetResourceString("MSG_ENTRYDATE")%>";
		arrMessages[2] = "<%=MyBase.GetResourceString("MSG_PROJECTSCHEDULE")%>";
		arrMessages[3] = "<%=MyBase.GetResourceString("MSG_EXCEED_ALLOCATED")%>";
		arrMessages[4] = "<%=MyBase.GetResourceString("MSG_BLANK_PERCENT")%>";
		arrMessages[5] = "<%=MyBase.GetResourceString("MSG_RANGE_0_100")%>";
		arrMessages[6] = "<%=MyBase.GetResourceString("MSG_RANGE_ACTUAL_HOURS")%>";
		arrMessages[7] = "<%=MyBase.GetResourceString("MSG_TIMESHEET_BLOCKED")%>";
		arrMessages[8] = "<%=MyBase.GetResourceString("MSG_PROJECTSCHEDULE_2")%>";
		arrMessages[9] = "<%=MyBase.GetResourceString("MSG_MSN")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[10] = "<%=MyBase.GetResourceString("MSG_MFN")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[11] = "<%=MyBase.GetResourceString("MSG_SNET")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[12] = "<%=MyBase.GetResourceString("MSG_SNLT")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[13] = "<%=MyBase.GetResourceString("MSG_FNET")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[14] = "<%=MyBase.GetResourceString("MSG_FNLT")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[15] = "<%=MyBase.GetResourceString("MSG_INVELID_CELLS")%>";
		arrMessages[16] = "<%=MyBase.GetResourceString("MSG_BLANK_HOURS")%>";
		arrMessages[17] = "Please enter numeric value for Actual % Complete !"//"<%=MyBase.GetResourceString("MSG_NUMERIC_VALUE")%>";
		arrMessages[18] = '<%=m_strProjectsOnHoldMsg%>';
		arrMessages[19] = "<%=MyBase.GetResourceString("MSG_DESC_LENGTH")%>";
		arrMessages[20] = "<%=MyBase.GetResourceString("MSG_MULTIPLE")%>";
		arrMessages[21] = "<%=MyBase.GetResourceString("MSG_ADJUST")%>";
		arrMessages[22] = "<%=MyBase.GetResourceString("MSG_CONTINUE")%>";
		arrMessages[23] = "<%=MyBase.GetResourceString("MSG_STOP")%>";
		arrMessages[24] = "<%=MyBase.GetResourceString("MSG_RT")%>";
		arrMessages[25] = "<%=MyBase.GetResourceString("MSG_CONFIRM_DELETE")%>";
		arrMessages[26] = "<%=MyBase.GetResourceString("MSG_CONFIRM_BEFORE_ACTION")%>";
		arrMessages[27] = "<%=MyBase.GetResourceString("MSG_NUMERIC_DURATION")%>";
		arrMessages[28] = "<%=MyBase.GetResourceString("MSG_HOURS_PER_DAY")%>";
		
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		
        var objform=GetFormReference('frmAdvancedTimesheet');
		var objDivMain=GetObjectReference('frmAdvancedTimesheet','divPage');	 
		var objtdCalender=GetObjectReference('frmAdvancedTimesheet','tdCalender');	 
		
		var objcboproject=GetObjectReference('frmAdvancedTimesheet','cboProject');
		var objcboTaskTypeFilter=GetObjectReference('frmAdvancedTimesheet','cboTaskTypeFilter');
		var objcboOtherFilter=GetObjectReference('frmAdvancedTimesheet','cboOtherFilter');
		var objimgFilter =GetObjectReference('frmAdvancedTimesheet','imgFilter');
		var objlblSave=GetObjectReference('frmAdvancedTimesheet','lblSave');
		var objlblFilter=GetObjectReference('frmAdvancedTimesheet','lblFilter');

	function window_onload()
	    {
	        var intDivHeight=0;

		    if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
				    //Commented by Yogesh J on 23/12/2015
				    //intDivHeight = window.innerHeight -  objDivMain.offsetTop-10 ; //130
				    intDivHeight = window.innerHeight -  objDivMain.offsetTop-16 ;
				}
				else
				{    //Commented by Yogesh J on 23/12/2015
				    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop-10;
				    intDivHeight = window.innerHeight -  objDivMain.offsetTop-16 ;
				    //End of comment by Yogesh J on 23/12/2015
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
					
				//Commented and added by nilesg g on 11/12/2015 for add PX
		        //objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight+'px';
				
			}
		
			AddFilterToolTip();
	  }
	  function window_onresize()		
	   {		
		    var intDivHeight;
		    if(objDivMain)
		    {
		        //Commented by Yogesh J on 23/12/2015
		        // intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 16;
		        intDivHeight = window.innerHeight -  objDivMain.offsetTop-16 ;
		        //End of comment by Yogesh J on 23/12/2015
			    if (intDivHeight < 100)	intDivHeight = 100;
		        //Commented and added by nilesg g on 11/12/2015 for add PX
		        //objDivMain.style.height = intDivHeight;
			    objDivMain.style.height = intDivHeight+'px';
		    }
	   } 
	   function AddFilterToolTip()
	   {
	     var ToolTip,filterText,strProject,strTaskType;
	     if(String(objcboproject.options[objcboproject.selectedIndex].text)!='')
	            strProject="'"+String(objcboproject.options[objcboproject.selectedIndex].text) +"'";
	      else
	             strProject='None';
	      
	      if(String(objcboTaskTypeFilter.options[objcboTaskTypeFilter.selectedIndex].text)!='')
	            strTaskType="'"+String(objcboTaskTypeFilter.options[objcboTaskTypeFilter.selectedIndex].text)+"'";
	      else
	             strTaskType='None';
	             
	                    
	     //ToolTip='Filter :->'+'\n'+'Project : '+strProject+'\n'+'Task Type : '+strTaskType;//+'\n'+'Duration : '+String(objcboOtherFilter.options[objcboOtherFilter.selectedIndex].text)
	     filterText='[Project : '+strProject+'] '+' [Task Type : '+strTaskType+' ]';//+'\n'+'Duration : '+String(objcboOtherFilter.options[objcboOtherFilter.selectedIndex].text)
		 //objimgFilter.alt=ToolTip;
		 
		 if(objlblFilter!=null)
		    objlblFilter.innerHTML=filterText;
	   }
	    function trim(str, chars) {
            return ltrim(rtrim(str, chars), chars);
        }
        function ltrim(str, chars) {
        chars = chars || '\\s';
        return str.replace(new RegExp("^[" + chars + "]+", 'g'), '');
        }

        function rtrim(str, chars) {
        chars = chars || '\\s';
        return str.replace(new RegExp("[" + chars + "]+$", 'g'), '');
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
	   
	   function AlertShow_Onclick()
	   {
		var objdivHeader=GetObjectReference('frmAdvancedTimesheet','divHeader');
		var objimgAS=GetObjectReference('frmAdvancedTimesheet','imgAS');
		
		if (objdivHeader.style.display=='')
		{
			objdivHeader.style.display='none';
			objimgAS.src='../../Images/cssImages/arrow_blue_right.gif'
			//objimgAS.alt='Show Calender';
		}	
		else
		{
			objdivHeader.style.display='';
			objimgAS.src='../../Images/cssImages/arrow_blue_left.gif'
			//objimgAS.alt='Hide Calender';
		}
	   }
	   
	   var objtxtHrLastvalue='';
	   
	   function txtHr_OnFocus(obj)
	   {
				if(obj.value=='' || parseInt(obj.value)==0)
					obj.value=objtxtHrLastvalue;
	   }
	   
	   function txtHr_OnBlur(obj)
	   {
				objtxtHrLastvalue=obj.value;
	   }
	   	   
	   function Pane_Onclick()
	   {
		var objdivCal=GetObjectReference('frmAdvancedTimesheet','divCal');
		var objPaneImg=GetObjectReference('frmAdvancedTimesheet','imgPane');
		var objtdGrid=GetObjectReference('frmAdvancedTimesheet','tdGrid');
		
		if (objdivCal.style.display=='')
		{
			objdivCal.style.display='none';
			objPaneImg.src='../../Images/cssImages/arrow_blue_right.gif'
			objPaneImg.alt='Show Calendar';
			objtdGrid.style.width='100%';
		}	
		else
		{
			objdivCal.style.display='';
			objPaneImg.src='../../Images/cssImages/arrow_blue_left.gif'
			objPaneImg.alt='Hide Calendar';
			objtdGrid.style.width='80%';
		}
	   }
	    var ShowFilter='0';
	    
    function Filter_OnClick(show,e)
    {
     
        var objDivFilter = GetObjectReference('frmAdvancedTimesheet','divFilter');
     
          var img1='../../Images/cssImages/Link images/close.gif';
	      var  img2='../../Images/cssImages/Link images/Filter.gif';   
	    
        if(ShowFilter=='0')
        {
      /* objDivFilter.style.top= objimgFilter.style.top;//40; //20
        objDivFilter.style.left=350; //600
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

	   function Tab_OnClick(TabSection)
	   {
	         var PageURL;
	         
	      
	     
	         switch (String(TabSection))   
	         {
	         case "2" :  
	                //PageURL="Advanced_Timesheet.aspx?FromWhere=DA&FromDate=<%=CommonFunctions.Dates.GetDate(m_strInputDate)%>&TabSection="+TabSection;
	                PageURL="Advanced_Timesheet.aspx?FromWhere=DA&FromDate=<%=m_strInputDate%>&TabSection="+TabSection;
	                break;
	         case "3" :  
	                //PageURL="Advanced_Timesheet.aspx?FromWhere=DA&FromDate=<%=CommonFunctions.Dates.GetDate(m_strInputDate)%>&TabSection="+TabSection;
	                PageURL="Advanced_Timesheet.aspx?FromWhere=DA&FromDate=<%=m_strInputDate%>&TabSection="+TabSection;
	                break;
	         default:
	                PageURL="Advanced_Timesheet.aspx?FromWhere=DA&TabSection="+TabSection;
	         }     
	      
		     objform.action = PageURL;
		     objform.submit();
	   }
	   
	     var ShowTH='0';
	     var ie5=document.all&&document.getElementById
         var ns6=document.getElementById&&!document.all
    
    function ShowTheme(show,e)
    {
        var objDivTheme = GetObjectReference('frmAdvancedTimesheet','divTheme');
        var objimgTheme=GetObjectReference('frmAdvancedTimesheet','imgTheme');
        
	  
        if (ShowTH=='0')
        {
       /* objDivTheme.style.top= objimgTheme.style.top;//40; //20
        objDivTheme.style.left=320; //600
        objDivTheme.zIndex=99;
        objDivTheme.style.display='block';*/
      
        ShowTH='1';
        showmenuie(objDivTheme,e);
        }
        else if(ShowTH=='1')
        {
        
        objDivTheme.style.display='none';
      
        ShowTH='0';    
      
        }
       
    }
    
    function ThemeOnClick(ThemeID)
    {
        strLocation = "Advanced_Timesheet.aspx?Filter=1&FromWhere=DA&ThemeID="+ThemeID;
		objform.action = strLocation
		objform.submit();      
    }
    function DefaultTheme_OnClick()
    {
         
		objform.action = "Advanced_Timesheet.aspx?Filter=1&Mode=DEFAULTTHEME&FromWhere=DA";
		objform.submit();      
    }
	   function Apply_OnClick(IsClear)
	   {
	
			var objtxtWHours=GetObjectReference('','txtWorkHours');	
			
			if(parseInt(IsClear)==0)
			{
		        if(disallowBlank(objtxtWHours,"Please enter numeric value !",true))
	                return ;
	            if(disallowNonNumeric(objtxtWHours,"Page number should be numeric only !",true))
	                return ;
	            if(disallowNegativeNumeric(objtxtWHours,"Only positive number allowed !",true))
	                 return ;  
		    }         
			for(var i=0;i<arrAlltxtboxIDs.length;i++)
			{
				objTH = document.getElementById (arrAlltxtboxIDs[i]);
				
				 
		    
				if((objTH.value=='' || parseInt(objTH.value)==0) && parseInt(IsClear)==0)
				{
					objTH.value=objtxtWHours.value;		
					SendXMLHTTP_Save(objTH);		
				}	
				else if(parseInt(IsClear)==1)
					objTH.value='';	
					
				
			}
			
	   }
	   function applyFilter(IsClear)
	   {
	     if(parseInt(IsClear)==1)
	     {
			objcboproject.value='';
			objcboTaskTypeFilter.value='';
			//objcboOtherFilter.value='';	
				
	     }
	        strLocation = "Advanced_Timesheet.aspx?PageNumber=1&Filter=1";
		    objform.action = strLocation
			objform.submit();
	   }
	   function CopyHr(Direction)
	   {
		
	   }
	   function ScheduleTS_OnClick()
	   {
		 window.open("../AdvancedTimesheet/Schedule_Timesheet.aspx?FromWhere=DA","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500"); 
	   }
		
		if(GetObjectReference('frmAdvancedTimesheet','txtNoOfPages'))
		{	
			var noOfPages = GetObjectReference('frmAdvancedTimesheet','txtNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmAdvancedTimesheet','txtPageNumber');
		}
		
	    function txtPageNumber_KeyPress(e)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
			
				var objtxtpageNumber =  GetObjectReference('frmAdvancedTimesheet','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmAdvancedTimesheet','txtNoOfPages');
				if (!disallowBlank(objtxtpageNumber,"Please enter page number !",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number should be numeric only !",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Only positive number allowed !",true)) & (!disallowNonInteger(objtxtpageNumber,"Only positive integer number allowed !",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
					
						alert("Invalid Page Number !");
						return;
					}
					Page_Onclick(objtxtpageNumber.value);
				}	
			}
		
		}
function validateNumPaging()
{

        if(disallowBlank(objtxtpageNumber,"Please enter page number !",true))
		    return false;
		if(disallowNonNumeric(objtxtpageNumber,"Page number should be numeric only !",true))
		    return false;
		if(disallowNegativeNumeric(objtxtpageNumber,"Only positive number allowed !",true))
		    return false;            	    
		if(disallowNonInteger(objtxtpageNumber,"Only positive integer number allowed !",true))
		    return false;
		    
	if(isNaN(objtxtpageNumber.value))
	{
		alert("Please enter numeric value");
		return false;
	}
	
	if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
	{
		alert("Please enter value within range of 1 to "+noOfPages);
		return false;
	}
	return true;
}
function ShowPreviousPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_Onclick(objtxtpageNumber.value);
	}
		
}
function ShowFirstPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		Page_Onclick(objtxtpageNumber.value);
	}
}
function ShowNextPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{  

		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==parseInt(noOfPages)){alert("This is the last page");return;}		 
		objtxtpageNumber.value=parseInt(objtxtpageNumber.value) + 1;
				 
		Page_Onclick(objtxtpageNumber.value);
		 
	}
}
function ShowLastPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(noOfPages);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		Page_Onclick(objtxtpageNumber.value);
	}
}

		function Page_Onclick(PageNumber)
		{
			
		    // Modified by SandipL on 3 Feb 2006 
            //commented and nilesh g on 15/6/2016 for issue Easitimeshhet
			// strLocation = "Advanced_Timesheet.aspx?FromPaging=1&PageNumber=" + String(parseInt(PageNumber));
		    strLocation = "Advanced_Timesheet.aspx?FromPaging=1&FromDate=<%=m_strInputDate%>&PageNumber=" + String(parseInt(PageNumber));
		    //end of commented and nilesh g on 15/6/2016 for issue Easitimeshhet
			objform.action = strLocation
			objform.submit();
		
		}
		
		function RemoveAlert_OnClick()
		{
			var objtblalert=GetObjectReference('frmAdvancedTimesheet','tblAlert');
			objtblalert.style.display='none';	
		}
		
		
			
			function Save_OnClick()
			{ 
				if (arrEditedCells.length > 0 || arrTxtBox.length > 0 || arrChkBox.length > 0)
				{
					var ObjForm = GetFormReference('frmAdvancedTimesheet');
					var objtxtTabSection=GetObjectReference('frmAdvancedTimesheet','txtTabSection');
					
					if(checkInvalidCells() == false)
					return;
				
					
					if(String(objtxtTabSection.value)=="5")
					{
						for(var i=0;i<arrAlltxtboxIDs.length;i++)//column wise total of edited cell
						{
							objTH = document.getElementById(arrAlltxtboxIDs[i]);
							SendXMLHTTP_Save(objTH);
						}	
					}	
					BuiltValueString();
				
					if(objlblSave!=null)
					{
					    if(objlblSave.style.display=='')
					        objlblSave.style.display='none';
					}
					
					objform.action = "Advanced_Timesheet.aspx?Mode=save&FromWhere=DA";
					objform.submit();
					
				}
			}
			/////////////////////////////////////////Timesheet Script //////////////////////////////////////////////////////////////
			//var strCurrentDate = '<%=m_strCurrentDate%>';
	
	

		var flagSubmit = true;
		var intBackDating = '<%=m_strBackdatingExpiry%>';
		var intFwdDating = '<%=m_strFwddatingExpiry%>';
		var strRestrict_MPPTasks = '<%=m_blnRestrict_MPPTasks%>';
		var strRestrict_AssignedTasks = '<%=m_blnRestrict_AssignedTasks%>';
		var strDetail='<%=m_strDetail%>';
	//	var strProjectsOnHold = '<%=m_strProjectsOnHold%>';
		var intMaxHoursPerDay = 24;
		//-----------------------------
		
		//-----------------------------
				//width="183"					
	
					
			
			var ElementClicked="";
			var StartingElement = "";
			var StartingCol=0;
			var StartingRow=0;
			var strBgcolor="#faebd7";
			var strBaseColor='<%=CellColor%>';
			var strRedColor = '<%=ERROR_COLOR%>';
			var strYellowColor = '<%=WARNING_COLOR%>';
			var strBorderColor = '<%=DISABLED_COLOR%>';
			var strImgSourceRed = '<%=ERROR_IMAGE%>';
			var strImgSourceYellow = '<%=WARNING_IMAGE%>';
			var strAnchorID="";
			var strAnchorCellID="";
			var xPos,yPos;
			var intSrNo = 0;
			//------------------Arrays-------------------------------------
		
			var arrEditedCells = new Array();//contains edited cells
			var arrInvalidCells = new Array();//contains objects of errorcell
			var arrProjectTasks = new Array();//contains objects of ProjectTasks
			var arrTxtBox = new Array();//contains taskids of edited text box
			var arrChkBox = new Array();//contains taskids of edited check box
			//-------------------------------------------------------------
			//-----Object for error cells---------------------------------------------
			//-----status and messages will be associate with this object-------------
			function CellErrors(Status,TaskID,CellIndex,strCellid)
			{
				this.Status = Status;//status-- warning or error
				this.TaskID = TaskID;
				this.CellIndex = CellIndex;
				this.id = strCellid;
				this.EMsg = new Array();//array for error messages
				this.WMsg = new Array();//array for warning messages
			}
			//-----End Object for error cells-----------------------------------------
			//------------------------------------------------------------------------
			//-----Object for Task Details---------------------------------------------
			function ProjectTasks(ProjectID,TaskID,MaxEntry,blnProjectBackdateEntry,blnProjectFwddateEntry,ConstraintType,ConstraintDate,WhichTask,EnforceConstraint,blnTimeBookedAgainstTask)
			{
				this.ProjectID = ProjectID;
				this.TaskID = TaskID;
				this.WhichTask = WhichTask;
				this.MaxEntry=MaxEntry;//maximum entry per day
				this.ProjectBackdateEntry = blnProjectBackdateEntry;
				this.ProjectFwddateEntry = blnProjectFwddateEntry;
				this.ConstraintType=ConstraintType;
				this.ConstraintDate=ConstraintDate;
				this.EnforceConstraint = EnforceConstraint;
				this.TimeBookedAgainstTask = blnTimeBookedAgainstTask;
				this.Response = 0;
			}
			//-----End Object for error cells-----------------------------------------
			//------------------------------------------------------------------------
			
			function setFocus_TS (obj)
			{
			var FocusTosetobj = GetObjectReference("frmAdvancedTimesheet", obj);
				if (FocusTosetobj != null)
				{
				    objtxtHrLastvalue='';
					FocusTosetobj.value='';
					FocusTosetobj.select();
					FocusTosetobj.focus();
					
				}
			}
			function checkInvalidCells()
			{
				var StrTN,intIndex=0;
				var strTasks=new String();
				var blnStop = false;
				if(arrInvalidCells.length > 0)
				{
					for(var i=0;i<arrInvalidCells.length;i++)
					{	if(arrInvalidCells[i].Status == "ERROR")
						{
							blnStop = true;
						}
						 
						StrTN = getTaskName(arrInvalidCells[i].id);
						//if (strTasks.indexOf(StrTN) == -1)
						//{getEntryDate(strCellID)
						//'shraddha
						 
							strTasks += ++intIndex + ": " + StrTN + " : " + getDate3(getEntryDate(arrInvalidCells[i].id)) +'\n';
						//}
					}
					if(blnStop == true)
					{ 
					 
						alert(arrMessages[15] + strTasks + '\n' + arrMessages[23]);
						return false;
					}
					else
					{
					 
						if (window.confirm(arrMessages[15] + strTasks + '\n' + arrMessages[22]))
						return true;
						return false;
					}
				}
				return true;
			}
			
			
			
			function TaskLink_OnClick(TaskID,ProjectID,PkToken)
			{
				var ObjForm = GetFormReference('frmAdvancedTimesheet');
				/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
				if ("<%=m_strFromWhere%>" == "Proxy")
				{
                    //Commented and added by Nilesh g on 22/1/2016 for increase width of window
				    //window.open("../PM/PM_DailyActivity.aspx?&From=Proxy&EmployeeID=<%=m_strSessionUserID%>&FromWhere=WTimeSheet&WhatToShow=Entry&ShowClose=1&ProjectID=" + ProjectID + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=420");
				    //window.open("../PM/PM_DailyActivity.aspx?&From=Proxy&EmployeeID=<%=m_strSessionUserID%>&FromWhere=WTimeSheet&WhatToShow=Entry&ShowClose=1&ATS_PkToken=" + PkToken + "&ProjectID=" + ProjectID + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=800,height=420");
				    window.open("../PM/PM_DailyActivity.aspx?&From=Proxy&EmployeeID=<%=m_strSessionUserID%>&FromWhere=WTimeSheet&WhatToShow=Entry&ShowClose=1&PkToken=" + PkToken + "&ProjectID=" + ProjectID + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=800,height=420");
				}
				else
				{
				    //Commented and added by Nilesh g on 22/1/2016 for increase width of window
				    //window.open("../PM/PM_DailyActivity.aspx?FromWhere=ATS&WhatToShow=Entry&ShowClose=1&ProjectID=" + ProjectID + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=420");
				    //window.open("../PM/PM_DailyActivity.aspx?FromWhere=ATS&WhatToShow=Entry&ShowClose=1&ATS_PkToken=" + PkToken + "&ProjectID=" + ProjectID + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=800,height=420");
				    window.open("../PM/PM_DailyActivity.aspx?FromWhere=ATS&WhatToShow=Entry&ShowClose=1&PkToken=" + PkToken + "&ProjectID=" + ProjectID + "&TaskID=" + TaskID +"&EmployeeID=<%=m_strSessionUserID%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=800,height=420");
				}
				/*Addition End by SantoshK on 20th March 2006*/
			}
				
			//Modified By VidyaJ - SP8 Performance 
			function ShowDetails_OnClick(TaskID,Detail,Day)
			{
				var strQueryString;
				/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
				if ("<%=m_strFromWhere%>" == "Proxy")
				{
					strQueryString = "../TimeSheet/TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&ShowDetails=1&MasterTagID=3583";
				}
				else
				{
					strQueryString = "../TimeSheet/TS_WeeklyTimesheet.aspx?ShowDetails=1&MasterTagID=3583&Fromwhere=ATS";
				}
				/*Addition End by SantoshK on 20th March 2006*/
				
				//strQueryString = "TS_WeeklyTimesheet.aspx?ShowDetails=1&MasterTagID=3583";
				strQueryString = strQueryString + "&TaskDAID=" + TaskID;
				strQueryString = strQueryString + "&Detail=" + Detail;//m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")
				strQueryString = strQueryString + "&hdnStartDate=" + '<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>';
			    if(Day != null && Day != '') strQueryString = strQueryString + "&Day=" + Day;
			    //Added By Vidya J ON 28-01-2016 For PkToken Validation 
			    if(Day != null && Day != '')
			    {
			        $.ajax({
			            type: 'POST',
			            dataType: 'json',
			            contentType: 'application/json',
			            url: 'Advanced_Timesheet.aspx/GenrateURLToken_ShowDetails_OnClick',
                        //Commented nad Added by Dhanashri S on 11 Aug 2016
			            //data: JSON.stringify({ TaskDAID: TaskID, Detail: Detail , hdnStartDate:'<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>',Day:Day,ShowDetails:"1",MasterTagID:"3583"}),
			            data: JSON.stringify({ TaskDAID: TaskID,EmployeeID: "<%=Session("intUserID")%>",MasterTagID:"3583", Detail: Detail , hdnStartDate:'<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>',Day:Day,ShowDetails:"1"}),
				        //End of Comment and Addition by Dhanashri S on 11 Aug
			            success: function (Result) {
		                    
			            
			                //strQueryString = strQueryString + "&Token_ShowDetails=" + Result.d;
			                strQueryString = strQueryString + "&PkToken=" + Result.d +"&EmployeeID=<%=m_strSessionUserID%>";
				            window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");

				        },
				        error: function () {
				            //alert("Error")
				        }
				    });
                }
                else
                {
                    $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        contentType: 'application/json',
                        url: 'Advanced_Timesheet.aspx/GenrateURLToken_ShowDetail_OnClick',
                        //data: JSON.stringify({ TaskDAID: TaskID, Detail: Detail , hdnStartDate:'<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>'}),
                        data: JSON.stringify({ TaskDAID: TaskID, EmployeeID: "<%=Session("intUserID")%>",Detail: Detail , hdnStartDate:'<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>'}),
				        success: function (Result) {
		                    
			            
				            //strQueryString = strQueryString + "&Token_ShowDetails=" + Result.d +"&EmployeeID=<%=m_strSessionUserID%>";
				            strQueryString = strQueryString + "&PkToken=" + Result.d +"&EmployeeID=<%=m_strSessionUserID%>";
				            window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");

				        },
				        error: function () {
				            // alert("Error")
				        }
				    });
                }
			    //window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");
			    //End Of Addition By Vidya J ON 28-01-2016 For PkToken Validation 
			        
			    //window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");
			}
			function ShowWorkDone(dblHours)
			{
				alert(dblHours + " hours have been uploaded from the MPP !!");
			}
			
			function InsertIntoArray(arr,strData)
			{
				//alert('strData='+strData);
				var strArrValues = arr.join();
				//alert('strArrValues'+strArrValues);
				if(strArrValues.search(strData) == -1)
				{
					arr.push(strData);
					arr.sort();
				}
			}
			
			function RemoveFromArray(arr,strData)
			{
				for(var i=0; i < arr.length; i++)
				{
					if(arr[i] == strData)
					{
						arr.splice(i,1);
					}
				}
			}
			
			function ClearArray(arr)
			{
				arr.splice(0,arr.length);
			}
			
			function getTaskID(strCellID)
			{	//to get task id associate with sell
				var strTaskID;
				var startIndex = strCellID.indexOf("_") + 1;
				strTaskID = strCellID.substring(startIndex);
				return strTaskID;
			}
			
			function getTaskName(strCellID)
			{//take data cellid as argument and return corrosponding task name
			 
				var strTaskID = getTaskID(strCellID);
				 
				var strName=getTaskName_TaskID(strTaskID);
				 
				return strName;
			}
			
			function getTaskName_TaskID(strTaskID)
			{//take taskid as argument and return corrosponding task name
				var strTNID = "TDS0_" + strTaskID;
				var objTN = document.getElementById (strTNID);
				 
				var strName="";
				if(objTN != null)
				{
					//'Modified by ShraddhaM on Date 17 July,2006 for PMLifeLine Issue ID.4873

					if(navigator.appName == 'Netscape')
					{
						strName = objTN.innerHTML;
					}
					else
					{
						strName = objTN.innerText;
					}
					return strName;
					 
				}
			}
			function getTaskStartDate(strCellID)
			{//take taskid as argument and return corrosponding task start date
				var strTaskID = getTaskID(strCellID);
				var strTNID = "TDS1_" + strTaskID;
				var objTSD = document.getElementById (strTNID);
				var strDate="";
				if(objTSD != null)
				{
					strDate = objTSD.value;//innerHTML;
					if(strDate.substring(strDate.indexOf('=')+1) != null)
					{
						strDate = strDate.substring(strDate.indexOf('=')+1)
					}
				}
				return strDate;
			}
			function getEntryDate(strCellID)
			{
			//return entry date of cell
				var intIndex=getCellIndex(strCellID) - 0;
				var objDT = document.getElementById ('hdnStartDate');
				var dtSDate = getDate(objDT.value);
				//var dtSDate = GetDateInFormat(objDT.value, '-', "rev");
				return DateAdd(dtSDate, intIndex - 3, 0, 0);//cell index start with 3
			}
			
			function getDate3(ObjDate)
			{
				var dateString;
				var months = new Array(13);
				months[0] = "January";
				months[1] = "February";
				months[2] = "March";
				months[3] = "April";
				months[4] = "May";
				months[5] = "June";
				months[6] = "July";
				months[7] = "August";
				months[8] = "September";
				months[9] = "October";
				months[10] = "November";
				months[11] = "December";
				var now = ObjDate;
				var monthnumber = now.getMonth();
				var monthname = months[monthnumber];
				var monthday = now.getDate();
				var year = now.getYear();
				if(year < 2000) { year = year + 1900; }
				
				dateString = monthday + '-' + Left(monthname,3) + '-' + year;
				return dateString;
			} 
			function getTaskEndDate(strCellID)
			{//take taskid as argument and return corrosponding task end date
				var strTaskID = getTaskID(strCellID);
				var strTNID = "TDS2_" + strTaskID;
				var objTSD = document.getElementById (strTNID);
				var strDate="";
				if(objTSD != null)
				{
					strDate = objTSD.value;//innerHTML;
					if(strDate.substring(strDate.indexOf('=')+1) != null)
					{
						strDate = strDate.substring(strDate.indexOf('=')+1)
					}
				}
				return strDate;
			}
			
			function getCellIndex(strCellID)
			{	// to get index of cell
				var intCellIndex=-1;
				intCellIndex = strCellID.charAt(3);
				return intCellIndex;
			}
			
			function Set_as_ErrorCell(strCellID,strStatus)
			{//to set cell as error cell and return error object --arrInvalidCells
			
				var strTaskID = getTaskID(strCellID);
				var ObjE = document.getElementById (strCellID);
				if(ObjE != null)
				{
					/*if(strStatus == "ERROR")
					{
						ObjE.innerHTML = ObjE.innerHTML + getImageText(strCellID,strImgSourceRed);
									
					}
					else
					{
						ObjE.innerHTML = ObjE.innerHTML + getImageText(strCellID,strImgSourceYellow);
					}*/
					
					arrInvalidCells.push(new CellErrors(strStatus,strTaskID,getCellIndex(strCellID),strCellID));
					return arrInvalidCells[arrInvalidCells.length-1];
				}
			}
			
			function getImageText(strCellID,strSource)
			{
				var strImg = "<img id=img_" + strCellID + "  src='" + strSource + "' onmousemove=msoCommentShow('com3_','" + strCellID + "')>";
				return strImg;
				
			}
			
			function Reset_ErrorCell(strCellID)
			{//to reset cell 
				var ObjE = document.getElementById (strCellID);
				if(ObjE != null)
				{//alert(ObjE.style.BORDERTOP);
						ObjE.innerHTML = ObjE.innerHTML;
					for(var i=0; i< arrInvalidCells.length;i++)
					{
						if(arrInvalidCells[i].id == strCellID)
						{
							arrInvalidCells[i] = null;//set object null
							arrInvalidCells.splice(i,1);//remove from array
						}
					}
				}
			}
			
			function isCellBlank(strCellID)
			{//return true if cell is blank otherwise false
				var ObjV = document.getElementById (strCellID);
				if(ObjV != null)
				{
					if(ObjV.innerHTML != "")
					{
						return false;
					}
					{
						return true;
					}
				}
			}
			
			function isCellBlank_1(strCellID)
			{//return true if cell is blank otherwise false
				var ObjV = document.getElementById (strCellID);
				if(ObjV != null)
				{
					if(ObjV.value != "")
					{
						return false;
					}
					{
						return true;
					}
				}
			}
			
			function isCellDisabled(strCellID)
			{
				var ObjV = document.getElementById (strCellID);
				if(ObjV.style.borderTopColor != strBorderColor)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			function isInvalidCell(strCellID)
			{//if given cellid is present in error array then return true else return false
				for(var i=0;i<arrInvalidCells.length;i++)
				{
					if(arrInvalidCells[i].id == strCellID )
					{
						return true;
					}
				}
				return false;
			}
			
			function getCellValue(strCellID)
			{//to get cell value as float
				var fltValue;
				var ObjV = document.getElementById (strCellID);
				if(ObjV != null)
				{
					if(ObjV.value != "")
					{
						//fltValue = parseFloat(ObjV.innerHTML);
						fltValue = parseFloat(ObjV.value);
						return fltValue;
					}
				}
				return null;
			}			

			function getCellStatus(strCellID)
			{//return ERROR for invalid cell, WARNING for warning cells anf VALID for valid cells
				for(var i=0;i<arrInvalidCells.length;i++)
				{
					if(arrInvalidCells[i].id == strCellID )
					{
						return arrInvalidCells[i].Status;
					}
				}
				return "VALID";
			}
			
			function getAllocatedWork(strCellID)
			{//returns allocated work for task
				var fltValue;
				var strAW = 'TDA_' + getTaskID(strCellID);
				var ObjAW = document.getElementById (strAW);
				if(ObjAW != null)
				{
					if(ObjAW.innerHTML != "")
					{
						fltValue = parseFloat(ObjAW.innerHTML);
						return fltValue;
					}
					else
					{
						return 0;
					}
				}
			}
			function getActualWork(strCellID)
			{//returns actual work for task
				var fltValue;
				var strAW = 'TDB_' + getTaskID(strCellID);
				var ObjAW = document.getElementById (strAW);
				if(ObjAW != null)
				{
					if(ObjAW.innerText != "")					
					{
						fltValue = parseFloat(ObjAW.innerText);					
						return fltValue;
					}
					return 0;
				}
			}
			function getRowTotal(strCellID)
			{//return total of 7 days for given cellID
				var _strTaskID = getTaskID(strCellID);
				return getRowTotal_Task(_strTaskID);
			}
			function getRowTotal_Task(strTaskID)
			{//return total of 7 days for given taskid
				var fltValue;
				var flt_1=0,flt_2=0,flt_3=0,flt_4=0,flt_5=0,flt_6=0,flt_7=0;
				var strID_1;
				strID_1 = 'ctr3_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_1 = getCellValue(strID_1);	}
				else
				{flt_1 = 0;	}
				
				strID_1 = 'ctr4_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_2 = getCellValue(strID_1);	}
				else{flt_2 = 0;	}
				
				strID_1 = 'ctr5_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_3 = getCellValue(strID_1);}
				else
				{flt_3 = 0;}
				
				strID_1 = 'ctr6_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_4 = getCellValue(strID_1);	}
				else
				{flt_4 = 0;}
				
				strID_1 = 'ctr7_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_5 = getCellValue(strID_1);	}
				else
				{flt_5 = 0;}
				
				strID_1 = 'ctr8_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_6 = getCellValue(strID_1);	}
				else
				{flt_6 = 0;}
				
				strID_1 = 'ctr9_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_7 = getCellValue(strID_1);	}
				else
				{flt_7 = 0;}
				
				fltValue = parseFloat(flt_1) + parseFloat(flt_2) + parseFloat(flt_3) + parseFloat(flt_4) + parseFloat(flt_5) + parseFloat(flt_6) + parseFloat(flt_7);
				return fltValue;
			}
			
			function getErrorObj(strCellID)
			{//return error object(class CellErrors) or null
				for(var i=0;i<arrInvalidCells.length;i++)
				{
					if(arrInvalidCells[i].id == strCellID)
					{
						return arrInvalidCells[i];
					}
				}
				return null;
			}
			
			function getErrorMessages(strCellID)
			{//return all messages
				var strTemp ="";
				intSrNo = 0;
				var objE = getErrorObj(strCellID);
				for(var i=0;i< objE.EMsg.length;i++)
				{
					strTemp = strTemp + (++intSrNo) + ": " + objE.EMsg[i] + "\n";
				}
				return strTemp;
			}
			
			function getWarningMessages(strCellID)
			{//return all warnings
				var strTemp ="";
				var objE = getErrorObj(strCellID);
				for(var i=0;i< objE.WMsg.length;i++)
				{
					strTemp = strTemp + (++intSrNo) + ": " + objE.WMsg[i] + "\n";
				}
				return strTemp;
			}
			
			function getImageObject(strCellID)
			{
				return document.getElementById ('img_' + strCellID);
			}
			
			function setImage(ObjError,Status)
			{
				if(ObjError != null)
				{
					var strCellID = ObjError.id;
					var ObjC = document.getElementById (strCellID);
					
					if(ObjError.EMsg.length <= 0)
					{ObjError.Status = Status;}
					
					
					if(Status == 'ERROR')
					{
						ObjError.Status = Status;
						//ObjC.innerHTML = ObjC.innerText + getImageText(strCellID,strImgSourceRed);
					}
					else if(ObjError.Status == "ERROR")
					{
						//ObjC.innerHTML = ObjC.innerText + getImageText(strCellID,strImgSourceRed);
					}
					else
					{
						//ObjC.innerHTML = ObjC.innerText + getImageText(strCellID,strImgSourceYellow);
					}
					//end of code modification by harshadad for PMLifeLine SP7 on 18 th July 2006
				}
			}
			function getColumnTotal(strCellID)
			{
				var fltTot=0.0;
				var strIndex = getCellIndex(strCellID);
				//var strID = 'TDA' + strIndex;
				//var objTot = document.getElementById (strID);
				var objTot = document.getElementById (strCellID);
				var objTemp, valTemp=0.0;
				/*if (objTot != null && objTot.innerHTML != "")//total for all project
				{
					fltTot += parseFloat(objTot.innerHTML);
				}*/
				for(var i=0;i<arrEditedCells.length;i++)//column wise total of edited cell
				{
					if(strIndex == getCellIndex(arrEditedCells[i]))
					{
						valTemp=0.0;
						objTemp = document.getElementById (arrEditedCells[i]);
						valTemp = objTemp.value;
						if (valTemp != '')
						fltTot += parseFloat(valTemp);
					}
				}
				return fltTot;
			}
			
			
			function ConstraintValidation(strCellID)
			{
				var strErrorMessage;
				var ConstraintType = getConstraintType(strCellID);
				var strConstraintDate = getConstraintDate(strCellID);
				var dtConstraintDate = getDate(strConstraintDate);
				var dtEntryDate = getEntryDate(strCellID);
				var strEntryDate = dtEntryDate.toDateString();
				var blnTimeBookedAgainstTask = isTimeBookedAgainstTask(strCellID);
				var blnTaskMarkedAsComplete ;
				var ObjCK = GetObjectReference('frmAdvancedTimesheet', 'chkTaskCompleted_' + getTaskID(strCellID));
				if (ObjCK != null)
				{
					blnTaskMarkedAsComplete = ObjCK.checked;
				}
				switch(ConstraintType)
				{
					case '0':
						//as soon as possible
						break;
					case '1':
						//as late as possible
						break;
					case '2':
						//Must Start on
						if ((DateDiff(dtEntryDate, dtConstraintDate, "d") != 0 && blnTimeBookedAgainstTask == false) || (DateDiff(dtEntryDate, dtConstraintDate, "d") > 0))
						{
							//blnConstraintViolated = true;
							strErrorMessage = arrMessages[9].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '3'://Must Finish on
						if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0))
						{
							strErrorMessage = arrMessages[10].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '4':
						//start no earlier than
						if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTimeBookedAgainstTask == false) || DateDiff(dtEntryDate, dtConstraintDate, "d") > 0)
						{	
							strErrorMessage = arrMessages[11].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '5':
						//Start no later than 
						if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0 && blnTimeBookedAgainstTask == false)
						{
							strErrorMessage = arrMessages[12].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '6':
						//Finish no eariler than
						if (DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete)
						{
							strErrorMessage = arrMessages[13].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '7':
						//finish no later than
						if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0)
						{
							strErrorMessage = arrMessages[14].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
				}
			}
			function chkTaskCompleted_OnClick(objCheckBox)
			{
				if(isEnforceConstraint(objCheckBox.id) != false)
				{
					var strMessage='';
					var ConstraintType = getConstraintType(objCheckBox.id);
					var strConstraintDate = getConstraintDate(objCheckBox.id);
					var dtConstraintDate = getDate(strConstraintDate);
					var strEntryDate;
					var dtEntryDate;
					var blnTimeBookedAgainstTask = isTimeBookedAgainstTask(objCheckBox.id);
					var fmt = "dummy";
					var strTaskID = getTaskID(objCheckBox.id);
					
					var blnDisplayMessage;
					var blnTaskMarkedAsComplete;
										
					blnTaskMarkedAsComplete = objCheckBox.checked;
					blnDisplayMessage = true
					
					for(var intCol=3; intCol<=9; intCol++)
					{
						var strCellID = "TDD" + intCol + "_" + strTaskID;
						dtEntryDate = getEntryDate(strCellID);
						strEntryDate = dtEntryDate.toDateString();
						if (getCellValue(strCellID) != null)
						{
							fmt = "dummy1";
							switch(ConstraintType)
							{
								case '0':
									//as soon as possible
									break;
								case '1':
									//as late as possible
									break;
								case '2':
									//Must Start on
									if ((DateDiff(dtEntryDate, dtConstraintDate, "d") != 0 && blnTimeBookedAgainstTask == false) || (DateDiff(dtEntryDate, dtConstraintDate, "d") > 0))
									{
										strMessage =   arrMessages[9].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '3':
									//Must Finish on
									if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0))
									{
										strMessage =  arrMessages[10].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '4':
									//start no earlier than
									if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTimeBookedAgainstTask == false) || DateDiff(dtEntryDate, dtConstraintDate, "d") > 0)
									{
										strMessage =  arrMessages[11].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '5':
									//Start no later than 
									if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0 && blnTimeBookedAgainstTask == false)
									{
										strMessage =  arrMessages[12].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '6':
									//Finish no eariler than
									if (DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete)
									{
										strMessage =  arrMessages[13].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '7':
									//finish no later than
									if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0)
									{
										strMessage =  arrMessages[14].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
							}
							
							if (strMessage != "")
							{
								if (blnDisplayMessage == true)
								{
									alert(strMessage);
								}
								switch(ConstraintType)
								{
									case '3':
										if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0))
										{
											objCheckBox.checked = false;
											GetObjectReference('frmAdvancedTimesheet', strCellID).innerHTML = "";
											fmt = "dummy1";
										}
										break;
									case '7':
										if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0)
										{
											objCheckBox.checked = false;
											GetObjectReference('frmAdvancedTimesheet', strCellID).innerHTML = "";
										}
										break;
									case '6':
										objCheckBox.checked = false;
										break;
								}
								
								blnDisplayMessage = false;
							}
						}
					}//End of for loop
					
					if (ConstraintType == '6' && fmt == "dummy")
					{
						if (arguments.length > 1 && DateDiff(arguments[1], dtConstraintDate, "d") > 0 ) 
						{
							blnDisplayMessage = false;
						}
						else if (arguments.length == 1)
						{
							blnDisplayMessage = false;
						}
						if (blnDisplayMessage == false)
						{
							objCheckBox.checked = false;
							alert(arrMessages[13].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n');
						}
					}

					if (ConstraintType == '3' && fmt == "dummy")
					{
						if (arguments.length > 1 && DateDiff(arguments[1], dtmConstraintDate, "d") != 0 ) 
						{
							blnDisplayMessage = false;
						}
						else if (arguments.length == 1)
						{
							blnDisplayMessage = false;
						}
						if (blnDisplayMessage == false)
						{
							objCheckBox.checked = false;
							alert(arrMessages[10].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n');
						}
					}
				}//End of if(isEnforceConstraint(objCheckBox.id) != false)
				//Track of edited or clicked check box
				InsertIntoArray(arrChkBox,getTaskID(objCheckBox.id) + ':' + getProjectID(objCheckBox.id));
			}
			
			function ValidationForBackDateEntry(strCellID)
			{
				var strErrorMessage;
				if(intBackDating.length != 0)
				{
					if (isProjectBackdateEntry(strCellID) != true)
					{
						if (DateDiff(DateAdd(new Date(getEntryDate_1(strCellID)), intBackDating, 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") > 0 )
						{
							//strErrorMessage = arrMessages[7] + '\n';
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							//Commented by PrashantSJ
							alert("<%=MyBase.GetResourceString("MSG_TIMESHEET_BLOCKED")%>");
							setFocus_TS(strCellID);
							return false;
						}
					}
				}
			}
			function ValidationForForwardDateEntry(strCellID)
			{
				var strErrorMessage;
				if(intFwdDating.length != 0)
				{//alert(intFwdDating);
					if (isProjectForwarddateEntry(strCellID) != true)
					{
						if (DateDiff(DateAdd(new Date(getEntryDate(strCellID)), -(intFwdDating-0), 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") < 0 )
						{
							//strErrorMessage = arrMessages[7] + '\n';
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							//commented by PrashantSJ
							alert("<%=MyBase.GetResourceString("MSG_TIMESHEET_BLOCKED")%>");
							setFocus_TS(strCellID);
							return false;
						}
					}
				}
			}
			function ValidationForWorkPerDay(strCellID)
			{
				var fltColTotal = getColumnTotal(strCellID);
				var intMax = getMaxEntry(strCellID) - 0;
				var intIndex = getCellIndex(strCellID);// == 3
				var EntryOn=0;
				switch(intIndex)
				{
					case '3':
						EntryOn = <%=m_dblEntryDay1%>;
						break;
					case '4':
						EntryOn = <%=m_dblEntryDay2%>;
						break;
					case '5':
						EntryOn = <%=m_dblEntryDay3%>;
						break;
					case '6':
						EntryOn = <%=m_dblEntryDay4%>; 
						break;
					case '7':
						EntryOn = <%=m_dblEntryDay5%>; 
						break;
					case '8':
						EntryOn = <%=m_dblEntryDay6%>; 
						break;
					case '9':
						EntryOn = <%=m_dblEntryDay7%>; 
						break;
				}
				var strErrorMessage;
				//
				if(parseFloat(fltColTotal) + parseFloat(EntryOn) > parseFloat(intMax))
				{
					strErrorMessage = arrMessages[28].replace('<=>',intMax) + '\n';
					//ProcessError(strCellID,"ERROR",strErrorMessage);
					alert(strErrorMessage);
					setFocus_TS(strCellID);
					return false;
				}
			}
			function ProcessError(strCellID,Status,strMsg)
			{
				if(isInvalidCell(strCellID) == false)// check if already exixt in arrInvalidCells array
				{
					var objEC = Set_as_ErrorCell(strCellID,Status);
				}
				else
				{
					var objEC = getErrorObj(strCellID);
					setImage(objEC,Status);
				}
				if(Status = "ERROR")
				{
					objEC.EMsg.push(strMsg);//atteching message to cell
				}
				else
				{
					objEC.WMsg.push(strMsg);//atteching message to cell
				}
			}
			function isProjectBackdateEntry(strCellID)
			{	var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ProjectBackdateEntry;
					}
				}
			}
			function isProjectForwarddateEntry(strCellID)
			{	var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ProjectFwddateEntry;
					}
				}
			}
			function getMaxEntry(strCellID)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].MaxEntry;
					}
				}
				//return 24;
			}
			function getTaskType(strCellID)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].WhichTask;
					}
				}	
			}
			function isEnforceConstraint(strCellID)
			{//its a project specific property and if its true then function will return true
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].EnforceConstraint;
					}
				}
			}
			function getConstraintType(strCellID)
			{//return constraint type(task specific)
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ConstraintType;
					}
				}
			}
			function getConstraintDate(strCellID)
			{//return constraint date(task specific)
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ConstraintDate;
					}
				}
			}
			function isTimeBookedAgainstTask(strCellID)
			{//if time booked agained task then return true
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].TimeBookedAgainstTask;
					}
				}
			}
			function getProjectID(strCellID)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ProjectID;
					}
				}
			}	
			function getResponse(strCellID)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].Response;
					}
				}
			}
			function setResponse(strCellID,intResponse)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						arrProjectTasks[i].Response = intResponse;
					}
				}
			}
			function CallOnMouseMove(ObjCell,RowNo,ColNo,strProjectID)
			{
				//var ObjTable = document.getElementById ("tbl_" + strProjectID);
				var ObjTable = document.getElementById ("tblList");
				var CurrentElement = ObjCell.id;
				var StartSelection = false;
				var startCellIndex;
				
				if (event.button==1) 
				{ 
					//alert(RowNo + '-' + ColNo);
					ElementClicked = "";
					for(var i=0; i< ObjTable.rows.length ; i++)
					{
						for(var j=2;j<= 9; j++ )
						{
							if( j >= StartingCol && j <= ColNo && i <= RowNo && i >= StartingRow)
							{	
								if(ObjTable.rows[i].cells[j] != null )
								{
									var strTdcolor = ObjTable.rows[i].cells[j].bgColor;
									if(strTdcolor != "" && strTdcolor != strRedColor && strTdcolor != strYellowColor && ObjTable.rows[i].cells[j].style.borderTopColor != strBorderColor)
									{
										ObjTable.rows[i].cells[j].bgColor=strBgcolor;
										ElementClicked = ElementClicked + ObjTable.rows[i].cells[j].id + ",";
									}
								}
							}
							else
							{
								if(ObjTable.rows[i].cells[j] != null )
								{
									var strTdcolor = ObjTable.rows[i].cells[j].bgColor;
									if(strTdcolor != "" && strTdcolor != strRedColor && strTdcolor != strYellowColor && ObjTable.rows[i].cells[j].style.borderTopColor != strBorderColor)
									{
										ObjTable.rows[i].cells[j].bgColor=strBaseColor;
									}
									
								}
								
							}
							
						}
					}
				}
			}

			
			function ResetCell(ObjCell)
			{
				ObjCell.bgColor = strBaseColor;
				ElementClicked = ElementClicked.replace(ObjCell.id,'');
			}
			function ResetCells()
			{//to unselect selected cells
				var arrElements =  ElementClicked.split(",");
				for (var i=0; i < arrElements.length; i++)
				{
					var obj1 ;
					obj1 = document.getElementById (arrElements[i]);
					
					if(obj1 != null)
					{
					
						obj1.className = "";
						obj1.bgColor=strBaseColor;
					}
				}
				ElementClicked = "";
			}


			
			function SendXMLHTTP_Save(obj)
			{ 
	 			//var obj = document.getElementById(id);
	 			var id=obj.id;
				var value = eval(obj.value-0);
		
				if (value !="")
				obj.value=value.toFixed(2);
				if ((((obj.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)-0).toFixed(0) != ((obj.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) || isNaN(obj.value))
				{
					alert(arrMessages[20] + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
					obj.value = "";
					obj.focus();
					return;
				}
				if((obj.value-0) > intMaxHoursPerDay || (obj.value-0)< 0)
				{
					alert(arrMessages[6].replace('<=>',intMaxHoursPerDay) + '\n');
					obj.value = "";
					obj.focus();
					return;
				}
				if(value!="")
				ElementClicked=ElementClicked+id+","
				
				InsertIntoArray(arrEditedCells, id); //Track of edited cells
			
				ValidateEditedCells_1(id);
				
				
			}
			
			function GTS_OnClick()
			{
				return;
			}
			
			function getEntryDate_1(strCellID)
			{
				var intIndex=getCellIndex(strCellID) - 0;
				var objDT = document.getElementById ('hdnStartDate');
				
				var dtSDate = objDT.value.replace("-", "");
				return DateAdd(new Date(dtSDate), intIndex - 3, 0, 0);//cell index start with 3
			}
			function ValidateEditedCells_1(objCellToBeValidated)
			{
				var _blnStatus = true;
				var fltActualWork;
				var fltAllocatedWork;
				var fltRowTotal;
				var strErrorMessage='';
				
						//Clear all error and warning messages if any
						var _Obj = getErrorObj(objCellToBeValidated);
						if(_Obj != null){ClearArray(_Obj.EMsg); ClearArray(_Obj.WMsg); }
						//=====================================
						fltCurrentCellValue = getCellValue(objCellToBeValidated);
						if(fltCurrentCellValue != null)
						{
							fltRowTotal = getRowTotal(objCellToBeValidated);
							fltAllocatedWork = getAllocatedWork(objCellToBeValidated);
							fltActualWork = getActualWork(objCellToBeValidated);
							var strTaskStartDate = trimString(getTaskStartDate(objCellToBeValidated));
							var strTaskEndDate = trimString(getTaskEndDate(objCellToBeValidated));
							var strWhichTask = getTaskType(objCellToBeValidated);
							var blnRestrictDurationChange = false;
							
							//validation for backdate entry
							if(ValidationForBackDateEntry(objCellToBeValidated) == false)
							{
								return;
							}
							//validation for forward date entry
							if(ValidationForForwardDateEntry(objCellToBeValidated) == false)
							{
								return;
							}
							//total work per day should not be between 0 to 24
							if(ValidationForWorkPerDay(objCellToBeValidated) == false)
							{
								return;
							}
							//----------------------------------------------------------------------------------
							//constraint validation
							if(isEnforceConstraint(objCellToBeValidated) != false)
							{
								if(ConstraintValidation(objCellToBeValidated) == false)
								{
									return;
								}
							}
						
							//-------------------------------------------------------------------------------
							//if entry is not allowed for mpp and assigned task
							if(strWhichTask == "M")
							{
								if(strRestrict_MPPTasks == 'True')
								{
									blnRestrictDurationChange = true;
									return;
								}
							}
							else if(strWhichTask == "O")
							{
								if(strRestrict_AssignedTasks == 'True')
								{
									blnRestrictDurationChange = true;									
								}
							}
							else if(strWhichTask == "B")
							{
								if(strRestrict_AssignedTasks == 'True')
								{
									blnRestrictDurationChange = true;									
								}
							}
							else
							{
								blnRestrictDurationChange = true;
							}
							//entry date should be between task start date and end date.///Schedule Variance
							if (getTaskType(objCellToBeValidated)=='O' || getTaskType(objCellToBeValidated)== 'M' || getTaskType(objCellToBeValidated)== 'B' )
							{
								if(strTaskStartDate != '' && strTaskEndDate != '')
								{
									var dtTaskStartDate = getDate(strTaskStartDate);
									var dtTaskEndDate = getDate(strTaskEndDate);
									var dtCurrentDate = getEntryDate(objCellToBeValidated);
									if(dtCurrentDate < dtTaskStartDate || dtCurrentDate > dtTaskEndDate)
									{
										strErrorMessage = arrMessages[1].replace('<=>',strTaskStartDate).replace('<==>',strTaskEndDate) + '\n';
										if(isInvalidCell(objCellToBeValidated) == false)// check if already exixt in arrInvalidCells array
										{
											if (blnRestrictDurationChange == true)
											{	
												alert(strErrorMessage);
												setFocus_TS(objCellToBeValidated); return false;												
											}
											else
											{
												if (window.confirm(strErrorMessage))
													return true;
												setFocus_TS(objCellToBeValidated); return false;
											}
										}
										else
										{
											var objEC = getErrorObj(objCellToBeValidated);
											if (blnRestrictDurationChange == true)
											{	
												alert(strErrorMessage);
												setFocus_TS(objCellToBeValidated);return false;
											}
											else
											{
												if (window.confirm(strErrorMessage))
													return true;
												setFocus_TS(objCellToBeValidated); return false;
											}
										}
										_blnStatus = false;
									}
								}
								//Actual efforts should be less or equal to allocated efforts///Efforts Variance
								if(parseFloat(fltRowTotal) + parseFloat(fltActualWork) > parseFloat(fltAllocatedWork))
								{
									strErrorMessage = arrMessages[3].replace('<=>',fltAllocatedWork).replace('<==>',(fltRowTotal + fltActualWork)) + '\n';
									if(isInvalidCell(objCellToBeValidated) == false)// check if already exixt in arrInvalidCells array
									{
										if (blnRestrictDurationChange == true)
										{	
											alert(strErrorMessage);
											setFocus_TS(objCellToBeValidated);return false;
										}
										else
										{
											if (window.confirm(strErrorMessage))
												return true;
											setFocus_TS(objCellToBeValidated);return false;
										}
									}
									else
									{
										var objEC = getErrorObj(objCellToBeValidated);
										if (blnRestrictDurationChange == true)
										{	
											alert(strErrorMessage);
											setFocus_TS(objCellToBeValidated);return false;
										}
										else
										{
											if (window.confirm(strErrorMessage))
												return true;
											setFocus_TS(objCellToBeValidated);return false;
										}
									}
									_blnStatus = false;
								}
							}
									
							if (_blnStatus == true)//if all condition satisfied then reset cell
							{
								//Reset_ErrorCell(arrEditedCells[i]);
							}
						}
						else
						{
							//Reset_ErrorCell(objCellToBeValidated);
						}
						var obj = document.getElementById(objCellToBeValidated);
						if(obj.value!='')
					      objtxtHrLastvalue=obj.value;
				}
			
			
			function txtPercentComplete_OnBlur(objTextbox)
			{			
				//Purpose	:	To perform the validations for the 'Actual % Complete' textbox.
				objtxtActualComplete = GetObjectReference('frmAdvancedTimesheet', objTextbox.id);
				if (disallowBlank1(objtxtActualComplete, arrMessages[4], "frmAdvancedTimesheet") == true)
				{
					return;
				}
				if (disallowNonNumeric1(objtxtActualComplete, arrMessages[17], "frmAdvancedTimesheet") == true)
				{
					return;
				}
				if (disallowValueRangeViolation1(objtxtActualComplete, 0, 100, arrMessages[5], "frmAdvancedTimesheet") == true)
				{
					return;
				}
			}
			
			function BuiltValueString()
			{	var strQueryString="";
				var objHdn1 = document.getElementById ('hdnQueryString');
				var objHdn2 = document.getElementById ('hdnTP');
				var objHdn3 = document.getElementById ('hdnChk');
				for(var i=0;i<arrEditedCells.length;i++)
				{	var cellValue = getCellValue(arrEditedCells[i]);
					var strTaskId = getTaskID(arrEditedCells[i]);
					var strProjectID = getProjectID(arrEditedCells[i]);
					var strCellIndex = getCellIndex(arrEditedCells[i]);
					var strResponse = getResponse(arrEditedCells[i]);
					strQueryString += cellValue + ':' + strCellIndex + ':' + strTaskId + ':' + strProjectID + ':' + strResponse + ';' ;
				}
				objHdn1.value = strQueryString;
				strQueryString = "";
				for(var i=0;i<arrTxtBox.length;i++)
				{strQueryString += arrTxtBox[i] + ';';}
				objHdn2.value = strQueryString;
				strQueryString = "";
				for(var i=0;i<arrChkBox.length;i++)
				{strQueryString += arrChkBox[i] + ';';}
				objHdn3.value = strQueryString;
			}
			function txtPercentComplete_OnChange(ObjTextBox)
			{	var strTaskID = getTaskID(ObjTextBox.id);
				var strProjectID = getProjectID(ObjTextBox.id);
				InsertIntoArray(arrTxtBox,strTaskID + ':' + strProjectID);
			}
		function disallowBlank1(obj,msg,frm) 
		{
			if ( disallowBlank(obj,msg) == true )
			{
				if ((arguments.length>3)?arguments[3]:true)
				{
					window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
				}
				flagSubmit = false;
				return true;	
			}
			flagSubmit = true;
			return false;
		}
		function disallowNonNumeric1(obj,msg,frm)
		{
			if ( disallowNonNumeric(obj,msg) == true )
			{
				if ((arguments.length>3)?arguments[3]:true)
				{
					window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
				}
				flagSubmit = false;
				return true;	
			}
			flagSubmit = true;
			return false;
		}
		function disallowValueRangeViolation1(obj,minVal,maxVal,msg,frm) 
		{	if ( disallowValueRangeViolation(obj,minVal,maxVal,msg) == true )
			{	if((arguments.length>5)?arguments[5]:true)
				{
					window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
				}
				flagSubmit = false;
				return(true);	
			}
			flagSubmit = true;
			return(false);
		}
		
		function showmenuie(objdiv,objevent){

//var objdiv = GetObjectReference('',divCM);

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
            //Commented and Added By Bharat T on 26th-oct-2015
  //if(ie5)
  //      window.event.cancelBubble = true;
  //  else if(ns6)
  //      e.stopPropagation();

     var e = e||event; 
      if (e) 
      { 
          e.returnValue = false; 
          e.cancelBubble = true;
          e.stopPropagation();
          e.preventDefault();
      }
		    //End of Commented and Added By Bharat T on 26th-oct-2015
   
  
  return false;
  
   }
	
					
			//////////////////////////////////////////////////////////////////////////////////////////////////////
			
		</script>
	
		
		<!--End of addition by PrashantSJ on 13th Jan 2009 Purpose: To have Reporting Date column should be static -->
		<%DrawAfterForm%>
	
	
	</body>
</HTML>
