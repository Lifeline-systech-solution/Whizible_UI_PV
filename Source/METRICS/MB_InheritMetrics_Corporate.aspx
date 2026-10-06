<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MB_InheritMetrics_Corporate.aspx.vb" Inherits="PbNIT.MB_InheritMetrics_Corporate" %>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Inherit Metrics")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
	<script type="text/javascript" src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added By Bharat T on 15th-Oct-2015*/
    .footerMenuTable
    {
        position:relative;
    }
    /*Ended By Bharat T on 15th-Oct-2015*/
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

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
	<STYLE type="text/css"> .FixedTD { POSITION: relative; TOP:expression(document.getElementById('divTblGrid').scrollTop -1 );}
	    #Tajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; }
	    #Tajax_tooltipObj DIV { POSITION: absolute; }
	    #Bajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; }
	    #Bajax_tooltipObj DIV { POSITION: absolute; }
	    #Tajax_tooltipObj .ajax_tooltip_TLarrow { BACKGROUND-POSITION: right top; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/cssImages/TLarrow.gif'); WIDTH: 40px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 63px }
	    #Bajax_tooltipObj .ajax_tooltip_BRarrow { BACKGROUND-POSITION: bottom right ; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/cssImages/BRarrow.gif'); BACKGROUND-REPEAT: no-repeat; }
	    #Tajax_tooltipObj .ajax_tooltip_Tcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; top:18px }
	    #Bajax_tooltipObj .ajax_tooltip_Bcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; }
	</STYLE>
	
		<form id='frmMetric' method='post' runat='server'>
			<%InitPage()%>
		</form>		
		<script language="javascript">
		objfrm = GetFormReference('frmMetric');
		var intcnt = "<%=m_intCnt%>";
		 var MaxPages = <%=m_intTotalNoOfRows%>/50
		 
		for(var cnt=1;cnt<intcnt;cnt++)
		{
		    GetObjectReference('frmMetric','trProjLevel_'+cnt).style.display="none";
		}
		
		
		function Select_Onclick(intCnt)
		{
		    if (GetObjectReference('frmMetric','chkSelect_'+intCnt).checked==true)
		    {
		        GetObjectReference('frmMetric','trProjLevel_'+intCnt).style.display="";
		        GetObjectReference('frmMetric','chkSelect_'+intCnt).value=1;
		     }
		    else    
		    {
		        GetObjectReference('frmMetric','trProjLevel_'+intCnt).style.display="none";
		        GetObjectReference('frmMetric','chkSelect_'+intCnt).value=0;
		    }
		    
		}
		
		function SelectAll_Onclick()
		{ 
		    
		    for(var cnt=1;cnt<intcnt;cnt++)
		    {
		        if (GetObjectReference('frmMetric','chkSelectAll').checked==true)
	            {
	                GetObjectReference('frmMetric','chkSelect_'+cnt).checked=true;
	                GetObjectReference('frmMetric','chkSelect_'+cnt).value=1;
	                GetObjectReference('frmMetric','trProjLevel_'+cnt).style.display="";
	            }
		        else    
	            {
	                GetObjectReference('frmMetric','chkSelect_'+cnt).checked=false;
	                GetObjectReference('frmMetric','chkSelect_'+cnt).value=0;
	                GetObjectReference('frmMetric','trProjLevel_'+cnt).style.display="none";
	            }
		   }
		}
		function FilterOnChange()
		{
		    var Category =    GetObjectReference('frmMetric','cboCategory').value;
		    var MetricName =    GetObjectReference('frmMetric','txtMetricFlt').value;
		    var noOfPages = GetObjectReference('','hidNoOfPages').value;
		    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		    var MenuTags = document.getElementsByTagName('A');
		    for (i = 0; i < MenuTags.length; i++) {
		        if (MenuTags[i].className == "Menu") {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.style.display = "none";
		        }
		    }
		    setFrameLoader();
		    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		    objfrm.action="MB_InheritMetrics_Corporate.aspx?Fromwhere=MB&MetricName="+MetricName+"&CategoryID="+Category+"&PageNumber="+noOfPages;;
		    objfrm.submit();
		}
		
		function txtName_OnKeyPress()
		{
		    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		    setFrameLoader();
		    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
			var key;
			key = window.event.keyCode;
			if (key == 13)
			{
				var Category =    GetObjectReference('frmMetric','cboCategory').value;
		        var MetricName =    GetObjectReference('frmMetric','txtMetricFlt').value;
		        var noOfPages = GetObjectReference('','hidNoOfPages').value;
		        objfrm.action="MB_InheritMetrics_Corporate.aspx?Fromwhere=MB&MetricName="+MetricName+"&CategoryID="+Category+"&PageNumber="+noOfPages;
		        objfrm.submit();
			}
		}
		
		function Save_OnClick()
		{  
		    if(validateControl()!=true) return false;
		    
		    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		    var MenuTags = document.getElementsByTagName('A');
		    for (i = 0; i < MenuTags.length; i++) {
		        if (MenuTags[i].className == "Menu") {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.style.display = "none";
		        }
		    }
		    setFrameLoader();
		    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		    objfrm.action="MB_InheritMetrics_Corporate.aspx?Action=SAVE";
		    objfrm.submit();
		}
		
		function validateControl()
		{
		    for(var cnt=1;cnt<intcnt;cnt++)
		    {
		    
	            var fltUCL = parseFloat(GetObjectReference('frmMetric','txUCL_'+cnt).value);
	            var fltLCL = parseFloat(GetObjectReference('frmMetric','txLCL_'+cnt).value);
		        var fltUSL = parseFloat(GetObjectReference('frmMetric','txtUSL_'+cnt).value);
		        var fltLSL = parseFloat(GetObjectReference('frmMetric','txtLSL_'+cnt).value);
		        var fltTarget= parseFloat(GetObjectReference('frmMetric','txtTarget_'+cnt).value);
		        
		        if (GetObjectReference('frmMetric','chkSelect_'+cnt).checked==true)
		        {
		        
		            if (disallowNonNumeric(GetObjectReference('frmMetric','txtLSL_'+cnt),'Please enter numeric values for LSL!!!',false))
                    {
                        setFocus(GetObjectReference('frmMetric','txtLSL_'+cnt));
                        return; 
                    }
		            if (disallowNonNumeric(GetObjectReference('frmMetric','txtUSL_'+cnt),'Please enter numeric values for USL!!!',false))
                    {
                        setFocus(GetObjectReference('frmMetric','txtUSL_'+cnt));
                        return; 
                    }
		            
		          if (disallowNonNumeric(GetObjectReference('frmMetric','txtTarget_'+cnt),'Please enter numeric values for Target!!!',false))
                    {
                        setFocus(GetObjectReference('frmMetric','txtTarget_'+cnt));
                        return; 
                    }
		            
		        
		            if (fltLSL < fltLCL || fltLSL > fltUCL)
		            {
                        alert("LSL should be in between LCL and UCL.")
                        //Added By Usha Pandit On 18.05.2020 For setting focus to control
                        setFocus(GetObjectReference('frmMetric', 'txtLSL_' + cnt));
                        //End Of Added By Usha Pandit On 18.05.2020 For setting focus to control
		                return false;
		            }
		         
		            if (fltLSL > fltUSL)
		            {
                        alert("USL should be greater than LSL.")
                        //Added By Usha Pandit On 18.05.2020 For setting focus to control
                        setFocus(GetObjectReference('frmMetric', 'txtUSL_' + cnt));
                        //End Of Added By Usha Pandit On 18.05.2020 For setting focus to control
		                return false;
		            }
		               
    		        if (fltUSL < fltLCL || fltUSL > fltUCL)
		            {
                        alert("USL should be in between LCL and UCL.")
                        //Added By Usha Pandit On 18.05.2020 For setting focus to control
                        setFocus(GetObjectReference('frmMetric', 'txtUSL_' + cnt));
                        //End Of Added By Usha Pandit On 18.05.2020 For setting focus to control
		                return false;
		            }
    		        
		            if (fltTarget < fltLSL || fltTarget > fltUSL)
		            {
                        alert("Target should be in between LSL and USL.")
                        //Added By Usha Pandit On 18.05.2020 For setting focus to control
                        setFocus(GetObjectReference('frmMetric', 'txtTarget_' + cnt));
                        //End Of Added By Usha Pandit On 18.05.2020 For setting focus to control
		                return false;
		            }	
		            if (fltTarget == 0 || fltUSL == 0 || fltLSL == 0)
		            {
                        alert("Target should be in between LSL and USL.")
                        //Added By Usha Pandit On 18.05.2020 For setting focus to control
                        setFocus(GetObjectReference('frmMetric', 'txtTarget_' + cnt));
                        //End Of Added By Usha Pandit On 18.05.2020 For setting focus to control
		                return false;
		            }	
		            	            	           		        
		           
		          
		       }
		        
		            
		    }
		     
		    return true;
		}
		
			function Page_OnClick(Page)
	        { 
			    var Category =    GetObjectReference('frmMetric','cboCategory').value;
		        var MetricName =    GetObjectReference('frmMetric','txtMetricFlt').value;
		        var PageNumber =  GetObjectReference('','txtPageNumber');
			    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		        var MenuTags = document.getElementsByTagName('A');
		        for (i = 0; i < MenuTags.length; i++) {
		            if (MenuTags[i].className == "Menu") {
		                //MenuTags[i].style.display= "none";
		                MenuTags[i].parentNode.style.display = "none";
		            }
		        }
		        setFrameLoader();
			    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		        objfrm.action="MB_InheritMetrics_Corporate.aspx?MetricName="+MetricName+"&CategoryID="+Category+"&PageNumber="+Page;
		        objfrm.submit();		    
	        }
        	
	        var noOfPages = GetObjectReference('','hidNoOfPages').value;
	        var objtxtpageNumber =  GetObjectReference('','txtPageNumber');
	        function validateNumPaging()
	        {

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
			        Page_OnClick(1);
		        else
		        {
			        if(!validateNumPaging())
			        return;
        			
			        if (objtxtpageNumber.value==1){alert("This is the first page");return;}
				        objtxtpageNumber.value=objtxtpageNumber.value -1;
			        Page_OnClick(objtxtpageNumber.value);
		        }
        			
	        }
	        function ShowFirstPage()
	        {
		        if (isBlank(objtxtpageNumber.value))
			        Page_OnClick(1);
		        else
		        {
			        if(!validateNumPaging())
			        return;
			        if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			        objtxtpageNumber.value=1;
			        Page_OnClick(objtxtpageNumber.value);
		        }
	        }
	        function ShowNextPage()
	        {
		        if (isBlank(objtxtpageNumber.value))
			        Page_OnClick(1);
		        else
		        {
			        if(!validateNumPaging())
			        return;
			        if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
				        objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
			        Page_OnClick(objtxtpageNumber.value);
		        }
	        }
	        function ShowLastPage()
	        {
		        if (isBlank(objtxtpageNumber.value))
			        Page_OnClick(noOfPages);
		        else
		        {	
			        if(!validateNumPaging())
			        return;
			        if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
			        objtxtpageNumber.value=noOfPages;
			        Page_OnClick(objtxtpageNumber.value);
		        }
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
				        var objtxtpageNumber =  GetObjectReference('frmCompensationEmployeeSelection','txtPageNumber');
				        var objtxtNoOfPages = GetObjectReference('frmCompensationEmployeeSelection','txtNoOfPages');
        								
				        if (!disallowBlank(objtxtpageNumber,"Please Enter Page number",true) && (!disallowNonNumeric(objtxtpageNumber,"Please Enter numeric value for Page number",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Please Enter positive integer value for Page number",true)) & (!disallowNonInteger(objtxtpageNumber,"Please Enter positive integer value for Page number",true)))				
				        {
					        if (Number(objtxtpageNumber.value) ==0)
					        {
						        alert("Page number should be greater than zero!");
						        return;
					        }
        					
					        if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					        {
						        alert("Page number should not be greater than " + objtxtNoOfPages.value);
						        return;
					        }
					        Page_OnClick(objtxtpageNumber.value);
				        }
			        }
	        }
	        function Attributes_onChecked(Cnt)
	        {
	             if(GetObjectReference('frmMetric','chkDelApplicable_'+Cnt).checked==true)
	                GetObjectReference('frmMetric','chkDelApplicable_'+Cnt).value=1;
	             if(GetObjectReference('frmMetric','chkPhaseApplicable_'+Cnt).checked==true)
	                GetObjectReference('frmMetric','chkPhaseApplicable_'+Cnt).value=1;
	             if(GetObjectReference('frmMetric','chkMileApplicable_'+Cnt).checked==true)
	                GetObjectReference('frmMetric','chkMileApplicable_'+Cnt).value=1;
	        }
		</script>
</html>
