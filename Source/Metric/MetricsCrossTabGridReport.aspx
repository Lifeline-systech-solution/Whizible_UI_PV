<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MetricsCrossTabGridReport.aspx.vb" Inherits="PbNIT.MetricsCrossTabGridReport" %>

<html >
<%  CommonFunctions.General.PlotPageHeadTag("Cross Tab Report") %>

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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body class="clsBody" onload="window_onload()" onresize="window_onresize()"  >
    <form id="frmCrossTabGridReport" name="frmCrossTabGridReport"  runat="server" >
    <div id="fillDiv" style="filter: alpha(opacity=60);background-color:#d1d1d1;DISPLAY: none; Z-INDEX: 100; LEFT: 0px; VISIBILITY: visible; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%"></div>    
    
    <div id="pleasewaitscreen" style="position:absolute;z-index:105;top:30%;left:35%;display:none;">
 <table class="clsTable" border=1 cellpadding="0" cellspacing="0" height="200" width="300">
    <tr class="clsTREven">
  <td width="100%" height="100%" align="center" valign="middle">
   <br/><br/>   
            <b>Processing...  please wait...</b>
    <br/><br/>
  </td>
 </tr>
    </table>
</div>


        <% WritePage()%>
          &nbsp;
         <%-- <div id="divMain1" style="width:99.99%; height:300px">--%>
     <table id="tblGraphs"  cellspacing="0" align="center" class="clsTable"  cellpadding="0" runat="server">
    
    </table>
   <%-- </div>--%>
          </form>

    
     <script language="javascript" type="text/javascript">
     function ShowWait()
     {
         // alert();
         //Commented And Added By Vaijat K ON 19/11/2015
        // objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
         objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                 objWait.style.display="block";
                
     }
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
         var objfrm              = GetFormReference("frmCrossTabGridReport"); 
         var objDivMain          = GetObjectReference("frmCrossTabGridReport","DivMain"); 
         var objYAxis            = GetObjectReference("frmCrossTabGridReport","hdnDQYAxis"); 
         var objXAxis            = GetObjectReference("frmCrossTabGridReport","hdnDQXAxis");
         var objNoOfPages =  GetObjectReference('frmCrossTabGridReport','txtNoOfPages');
	    var objPageNumber = GetObjectReference("frmCrossTabGridReport","txtCurPageNumber"); 
	    var objDivpopup = document.getElementById("divTbl");
	    var objdivTblX = GetObjectReference("frmCrossTabGridReport","divTblX"); 
	    var objdivTblY = GetObjectReference("frmCrossTabGridReport","divTblY");
	    var objdivTblMainOtherView = GetObjectReference("frmCrossTabGridReport","divTblMainOtherView");
	    	    
	    var objdivTblXX = GetObjectReference("frmCrossTabGridReport","divTblXX"); 
	    var objdivTblYY = GetObjectReference("frmCrossTabGridReport","divTblYY"); 
	    var objTblOtherView = GetObjectReference("frmCrossTabGridReport","TblOtherView"); 
	    
	    var objTxtFYPeriod=GetObjectReference('','txtFYPeriod');
	    
        var objDivMainAdvancedFilters=GetObjectReference("frmCrossTabGridReport","divMainAdvancedFilters");
	    var objDivAdvancedFilters=GetObjectReference("frmCrossTabGridReport","divAdvancedFilters");
	    
//	    if('<%=m_strMode %>'=='Graph')
//	        objDivMain          = GetObjectReference("frmCrossTabGridReport","DivMain1"); 
	    
        function window_onload()
        {
            if(objDivMain!=null){ 

			var intDivHeight ;
                //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70;
			intDivHeight = window.innerHeight - objDivMain.offsetTop - 25;
			
			if (intDivHeight < 100) intDivHeight = 100;

                //Commented and added by Yogesh J on 11/12/2015
                //objDivMain.style.height = intDivHeight;
			objDivMain.style.height = intDivHeight + 'px';


            
            }
            
            if(objdivTblX!=null){

                   
                    if(objdivTblXX.scrollHeight > 200){
                       objdivTblXX.style.height = "70%";
                       objdivTblX.style.height ="50%";
                     }
                objdivTblX.style.display='none';
            
            }
	       if(objdivTblY!=null){

                   
                    if(objdivTblYY.scrollHeight > 200){
                        objdivTblYY.style.height =  "70%";
                         objdivTblY.style.height = "50%";
                    }
                     
                     	           
                objdivTblY.style.display='none';
            }
            
	       if(objdivTblMainOtherView!=null){

                if(objTblOtherView.scrollHeight > 200){
                    objTblOtherView.style.height =  "80%";
                     objdivTblMainOtherView.style.height = "52%";
                }                     	           
                    objdivTblMainOtherView.style.display='none';
           }
           
             if(objDivMainAdvancedFilters!=null){

                   
                    if(objDivAdvancedFilters.scrollHeight > 200){
                        objDivAdvancedFilters.style.height =  "70%";
                         objDivMainAdvancedFilters.style.height = "50%";
                    }
                     
                     	           
                objDivMainAdvancedFilters.style.display='none';
            }
			
           
        }
        function window_onresize()
        {
			var intDivHeight;
if(objDivMain!=null){ 
    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70;
    intDivHeight = window.innerHeight - objDivMain.offsetTop - 25;
			if (intDivHeight < 100) intDivHeight = 100;
           //Commented and added by Yogesh J on 11/12/2015
           //objDivMain.style.height = intDivHeight;
			objDivMain.style.height = intDivHeight + 'px';
			}
			
			  if(objdivTblX!=null){

                   
                    if(objdivTblXX.scrollHeight > 200){
                       objdivTblXX.style.height = "75%";
                       objdivTblX.style.height ="55%";
                     }
                objdivTblX.style.display='none';
            
            }
	       if(objdivTblY!=null){

                   
                    if(objdivTblYY.scrollHeight > 200){
                        objdivTblYY.style.height =  "70%";
                         objdivTblY.style.height = "50%";
                    }
                     
                     	           
                objdivTblY.style.display='none';
            }	
            
          if(objdivTblMainOtherView!=null){

                if(objTblOtherView.scrollHeight > 200){
                    objTblOtherView.style.height =  "80%";
                     objdivTblMainOtherView.style.height = "52%";
                }                     	           
                    objdivTblMainOtherView.style.display='none';
           }        
        }
   function OtherViewsLink_OnClick(CTReportID)
   {
            var Mode = (arguments.length>1)?arguments[1]:"0";
            if (Mode == "0")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                objWait.style.display="block";
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('OtherViewsLink_OnClick("'+CTReportID+'","1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                 OtherViewsLink_OnClick(CTReportID,"2")
//                 objWait.style.display="none";      
//                 document.getElementById('fillDiv').style.display="none";                                               
            }            
           if  (Mode == "2")
            { 
               ClearAll_OnClick('frmCrossTabGridReport','chkXAxisFilter');   
               ClearAll_OnClick('frmCrossTabGridReport','chkYAxisFilter');              
               objfrm.action = "MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&Mode=<%=m_strMode %>&CTReportID="+CTReportID;
               objfrm.submit();
            }   
   }
    function ViewReport_OnClick(format)
    {     
    
            var strYAxis = "",strXAxis="";
            if(objYAxis!=null){
                 strYAxis = objYAxis.value;
                 strYAxis = strYAxis.replace(/&/g,"AMPERCENT");
                 strYAxis =   strYAxis.replace(/%/g,"PERCENT");
            }
            if(objXAxis!=null){
                 strXAxis = objXAxis.value;
                 strXAxis =  strXAxis.replace(/&/g,"AMPERCENT");
                 strXAxis=  strXAxis.replace(/%/g,"PERCENT");
            }
            

            
            if (strXAxis!="" && strYAxis!=""){
               objfrm.action = "MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis="+strYAxis+"&DQXAxis="+strXAxis+"&CTReportID=<%=m_intCTReportID%>&Mode=DetailQuery&Action=Report&Format="+format+"&FYPeriodID=<%=m_strFYPeriod %>";
           }
            else
            {   objfrm.action = "MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&CTReportID=<%=m_intCTReportID%>&Mode=View&Action=Report&Format="+format+"&FYPeriodID=<%=m_strFYPeriod %>";
            }
           objfrm.submit();

    }
    function Detail_OnClick(strXAxis,strYAxis,strCTReportID)
    {       



             strYAxis = strYAxis.replace(/&/g,"AMPERCENT");
             strYAxis =   strYAxis.replace(/%/g,"PERCENT");
             strXAxis =  strXAxis.replace(/&/g,"AMPERCENT");
             strXAxis=  strXAxis.replace(/%/g,"PERCENT");
 
        
        if('<%=m_blnIsFYDriven.ToString() %>'=='True')
        window.open("../METRICS/MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis="+strYAxis+"&DQXAxis="+strXAxis+"&CTReportID=" + strCTReportID + "&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>","","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 570)/2) + ",width=900,height=570");
        else
        window.open("../METRICS/MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis="+strYAxis+"&DQXAxis="+strXAxis+"&CTReportID=" + strCTReportID + "&Mode=DetailQuery","","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 570)/2) + ",width=900,height=570");
            
    }
    function Export_OnClick()
    {
        //  ''Added BY Nilesh g on 1/2/2016 for url issue
        // window.open("../METRICS/MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&CTReportID=<%=m_intCTReportID%>&Mode=View&FYPeriodID=<%=m_strFYPeriod %>","","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 450)/2) + ",top=" + ((window.screen.height - 350)/2) + ",width=450,height=350");
        window.open("../METRICS/MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&CTReportID=<%=m_intCTReportID%>&Mode=View&FYPeriodID=<%=m_strFYPeriod %>&PKToken=<%=m_PKToken%>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 450) / 2) + ",top=" + ((window.screen.height - 350) / 2) + ",width=450,height=350");
        //  ''endded BY Nilesh g on 1/2/2016 for url issue
          
    }
    
    function txtPageNumber_OnBlur(obj)
    {

       if(!validateNumPaging())
			    return;
		
		    
    }

        function ShowPreviousPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
    			
			    if (objPageNumber.value==1){alert("This is the first page");return;}
				    objPageNumber.value = parseInt(objPageNumber.value) -1;
			            Page_OnClick(objPageNumber.value);
		    }
    			
	    }
	    function ShowFirstPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==1){alert("This is the first page");return;}
			    objPageNumber.value = 1;
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    function ShowNextPage()
	    {
	        
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==parseInt(objNoOfPages.value)){alert("This is the last page");return;}
				    objPageNumber.value = parseInt(objPageNumber.value)+1
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    function ShowLastPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(parseInt(objNoOfPages.value));
		    else
		    {	
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==parseInt(objNoOfPages.value)){alert("This is the last page");return;}
			    objPageNumber.value=parseInt(objNoOfPages.value);
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    /*function txtPageNumber_KeyPress(e)
	    {
		    var code;
			    if (e.keyCode) 
				    code = e.keyCode;
			    else
				    if (e.which) 
					    code = e.which;
    					
			    if(code==13) 
			    {
			   
			 		/* if(!validateNumPaging())
			                return;		*/
			                
			    /*if (!disallowBlank(objPageNumber,"Please Enter Page number",true) && (!disallowNonNumeric(objPageNumber,"Please Enter numeric value for Page number",true)) && (!disallowNegativeNumeric(objPageNumber,"Please Enter positive integer value for Page number",true)) & (!disallowNonInteger(objPageNumber,"Please Enter positive integer value for Page number",true)))				
				    {
					    if (Number(objPageNumber.value) ==0)
					    {
						    alert("Page number should be greater than zero!");
						    return;
					    }
    					
					    if(Number(objPageNumber.value) > Number(parseInt(objNoOfPages.value)) ) 
					    {
						    alert("Page number should not be greater than " + parseInt(objNoOfPages.value));
						    return;
					    }
					    Page_OnClick(objPageNumber.value);
				    }
				    
				    Page_OnClick(objPageNumber.value);
			    }
	    }*/
	
	    function validateNumPaging()
	    {

        if(disallowBlank(objPageNumber,"Please enter page number !",true))
		    return false;
		if(disallowNonNumeric(objPageNumber,"Page number should be numeric only !",true))
		    return false;
		if(disallowNegativeNumeric(objPageNumber,"Only positive number allowed !",true))
		    return false;            	    
		if(disallowNonInteger(objPageNumber,"Only positive integer number allowed !",true))
		    return false;
		    
		    if(isNaN(objPageNumber.value))
		    {
			    alert("Please enter numeric value");
			    objPageNumber.focus();
			    return false;
		    }
		    
		    if(parseInt(objNoOfPages.value)<parseInt(objPageNumber.value))
		    {
			    alert("Please enter value within range of 1 to "+parseInt(objNoOfPages.value));
			     objPageNumber.focus();
			    return false;
		    }
		    return true;
	    }
	function Page_OnClick(Page)
	{
            var Mode = (arguments.length>1)?arguments[1]:"0";
            if (Mode == "0")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                objWait.style.display="block";
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('Page_OnClick("'+Page+'","1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                 Page_OnClick(Page,"2")
            }            
           if  (Mode == "2")
            {       
                var strYAxis = "",strXAxis="";
                if(objYAxis!=null){
                     strYAxis = objYAxis.value;
                     strYAxis = strYAxis.replace(/&/g,"AMPERCENT");
                     strYAxis =   strYAxis.replace(/%/g,"PERCENT");
                }
                if(objXAxis!=null){
                     strXAxis = objXAxis.value;
                     strXAxis =  strXAxis.replace(/&/g,"AMPERCENT");
                     strXAxis=  strXAxis.replace(/%/g,"PERCENT");
                }
                

               
                
                if (strXAxis!="" && strYAxis!=""){
                   objfrm.action = "MetricsCrossTabGridReport.aspx?DQYAxis="+strYAxis+"&DQXAxis="+strXAxis+"&CTReportID=<%=m_intCTReportID%>&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>";
               }
                else
                {   objfrm.action = "MetricsCrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID%>&Mode=<%=m_strMode %>";
                }
                objfrm.submit();
            }
	}
	
	
	    function applyFilter()
        {
            var Mode = (arguments.length>0)?arguments[0]:"0";
            if (Mode == "0")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                objWait.style.display="block";
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('applyFilter("1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                 applyFilter("2")
            }            
           if  (Mode == "2")
            {               
                if('<%=m_strMode %>'=='Graph' && '<%=m_strFromWhere %>'=='')
                    objfrm.action = "MetricsCrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter";
               else
                    objfrm.action = "MetricsCrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>";
               objfrm.submit();
            }   
        }
        function SCX_OnClick()
        {
             var objChkXAxisFilter = GetObjectReference('frmCrossTabGridReport','chkXAxisFilter',true);
             var obSCFX = GetObjectReference('frmCrossTabGridReport','chkXAxisFilterAll');
            // var obhdnXAxisFilterString = GetObjectReference('frmCrossTabGridReport','hdnXAxisFilterString');
              //obhdnXAxisFilterString.value="";
             var isSelectedX=0;
	         if(objChkXAxisFilter!=null)
	         {    
	                for(i=0;i<objChkXAxisFilter.length;i++){
        	        
	                    if (objChkXAxisFilter[i].checked==false)
	                    {   isSelectedX = 1;
	                    }
	                }
	    
	        }
	        if(isSelectedX==1)
	           obSCFX.checked=false;
	           
	        if(isSelectedX==0)
	           obSCFX.checked=true;
        
        }
        
        function SCY_OnClick()
        {
             var objChkYAxisFilter = GetObjectReference('frmCrossTabGridReport','chkYAxisFilter',true);
             var obSCFY = GetObjectReference('frmCrossTabGridReport','chkYAxisFilterAll');
            // var obhdnYAxisFilterString = GetObjectReference('frmCrossTabGridReport','hdnYAxisFilterString');
            // obhdnYAxisFilterString.value="";
             var isSelectedY=0;
	         if(objChkYAxisFilter!=null)
	         {    
	                for(i=0;i<objChkYAxisFilter.length;i++){
        	        
	                    if (objChkYAxisFilter[i].checked==false)
	                    {   isSelectedY = 1;
	                    }
	                }
	    
	        }
	        if(isSelectedY==1)
	           obSCFY.checked=false;
	           
	           
	           
	        if(isSelectedY==0)
	           obSCFY.checked=true;
        
        }
        var SelectClearAllY=0;
        function SelectAndClearAllY_OnClick()
        {
                var obSCFilterY = GetObjectReference('frmCrossTabGridReport','chkYAxisFilterAll');
               // var obhdnYAxisFilterString = GetObjectReference('frmCrossTabGridReport','hdnYAxisFilterString');
              
                if(obSCFilterY!=null){
                    if(obSCFilterY.checked==true)
                        SelectClearAllY = 0;
                    else
                        SelectClearAllY = 1;
                }
                if(SelectClearAllY==0){
                
                    SelectAllCheckboxs('frmCrossTabGridReport','chkYAxisFilter');
                    SelectClearAllY = 1;
                }
                else
                {
                    ClearAll_OnClick('frmCrossTabGridReport','chkYAxisFilter');
                    // obhdnYAxisFilterString.value = "";
                    SelectClearAllY=0;
                }

        }
        
        var SelectClearAllX=0;
        function SelectAndClearAllX_OnClick()
        {
                var obSCFilterX = GetObjectReference('frmCrossTabGridReport','chkXAxisFilterAll');
                //var obhdnXAxisFilterString = GetObjectReference('frmCrossTabGridReport','hdnXAxisFilterString');
              
                if(obSCFilterX!=null){
                    if(obSCFilterX.checked==true)
                        SelectClearAllX = 0;
                    else
                        SelectClearAllX = 1;
                }
                if(SelectClearAllX==0){
                
                    SelectAllCheckboxs('frmCrossTabGridReport','chkXAxisFilter');
                    SelectClearAllX = 1;
                }
                else
                {
                    ClearAll_OnClick('frmCrossTabGridReport','chkXAxisFilter');
                   //  obhdnXAxisFilterString.value = "";
                    SelectClearAllX=0;
                }

        }
        
        var ShowFilterX='0';
        var ShowFilterY='0';
        var ShowOtherViewFilter = '0';
        var ShowAdvancedFilter='0';
        
        function showFiltersX(show)
        {
            var objtblFilter = GetObjectReference('frmCrossTabGridReport','divTblX');
            var objtblFilterY = GetObjectReference('frmCrossTabGridReport','divTblY');
            var objdivMainAdvancedFilters= GetObjectReference('frmCrossTabGridReport','divMainAdvancedFilters');
            
            var objHideFilterY =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilterY =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            
            
            var objHideFilter =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilter =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            
            var objHideAdvancedFilter =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');
            var objShowAdvancedFilter =GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');
            
            var objtblOtherViewFilter = GetObjectReference('frmCrossTabGridReport','divTblMainOtherView');
             
            if (ShowFilterX=='0')
            {
                objtblFilter.style.top=25;
                objtblFilter.style.left="57%";
                objtblFilter.zIndex=1;
                objtblFilter.style.display='';
                objShowFilter.style.display = 'None';
                objHideFilter.style.display = '';
                
                if(objShowFilterY!=null){
                objShowFilterY.style.display = '';
                objHideFilterY.style.display = 'none';}
                
                objtblFilterY.style.display = 'None';
                
                if(objtblOtherViewFilter!=null)
                objtblOtherViewFilter.style.display = 'None';
                
                if(objdivMainAdvancedFilters!=null)
                   objdivMainAdvancedFilters.style.display= 'None';
                   
                if(objShowAdvancedFilter!=null){
                objShowAdvancedFilter.style.display = '';
                objHideAdvancedFilter.style.display = 'none';}
                
                ShowFilterX='1';
                ShowFilterY ='0';
                ShowOtherViewFilter = '0';
                ShowAdvancedFilter='0';

            }
            else if(ShowFilterX=='1')
            {
                objtblFilter.style.display='none';
                ShowFilterX='0';    
                objShowFilter.style.display = '';
                objHideFilter.style.display = 'None';
            }
        }
        
       
        function showFiltersY(show)
        {
            var objtblFilter = GetObjectReference('frmCrossTabGridReport','divTblY');
            var objtblFilterX = GetObjectReference('frmCrossTabGridReport','divTblX');
            var objHideFilterX =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilterX =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            
            var objHideFilter =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilter =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            var objtblOtherViewFilter = GetObjectReference('frmCrossTabGridReport','divTblMainOtherView');
            
            var objdivMainAdvancedFilters= GetObjectReference('frmCrossTabGridReport','divMainAdvancedFilters');
            var objHideAdvancedFilter =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');
            var objShowAdvancedFilter =GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');

            
            if (ShowFilterY=='0')
            {
                objtblFilter.style.top=25;
                objtblFilter.style.left="62%";
                objtblFilter.zIndex=1;
                objtblFilter.style.display='';
                
                objShowFilter.style.display = 'None';
                
                objHideFilter.style.display = '';
                
                if(objShowFilterX!=null){
                objShowFilterX.style.display = '';
                objHideFilterX.style.display = 'none';}
                
                objtblFilterX.style.display = 'None';
                
                if(objtblOtherViewFilter!=null)
                objtblOtherViewFilter.style.display = 'None';
                
                if(objdivMainAdvancedFilters!=null)
                   objdivMainAdvancedFilters.style.display= 'None';
                   
                if(objShowAdvancedFilter!=null){
                objShowAdvancedFilter.style.display = '';
                objHideAdvancedFilter.style.display = 'none';}
                                
                ShowFilterY='1';
                ShowFilterX='0';
                ShowOtherViewFilter = '0';
                ShowAdvancedFilter='0';

            }
            else if(ShowFilterY=='1')
            {
                objtblFilter.style.display='none';
                ShowFilterY='0';    
                objShowFilter.style.display = '';
                objHideFilter.style.display = 'None';
            }
        }
        function showOtherViewFilters()
        {
            var objtblOtherViewFilter = GetObjectReference('frmCrossTabGridReport','divTblMainOtherView');
            
            var objtblFilterX = GetObjectReference('frmCrossTabGridReport','divTblX');
            var objtblFilterY = GetObjectReference('frmCrossTabGridReport','divTblY');
            
            var objHideFilterX =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilterX =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            
            var objHideFilterY =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilterY =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            
            var objdivMainAdvancedFilters= GetObjectReference('frmCrossTabGridReport','divMainAdvancedFilters');
            var objHideAdvancedFilter =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');
            var objShowAdvancedFilter =GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');

            
            if (ShowOtherViewFilter=='0')
            {
                objtblOtherViewFilter.style.top=25;
                objtblOtherViewFilter.style.left="50%";
                objtblOtherViewFilter.zIndex=1;
                objtblOtherViewFilter.style.display='';
                
                objtblFilterX.style.display = 'none';
                objtblFilterY.style.display = 'none';
                
                if(objShowFilterX!=null)  
                objShowFilterX.style.display = '';
                
                if(objHideFilterX!=null)
                objHideFilterX.style.display = 'none';
                
                if(objShowFilterY!=null)
                objShowFilterY.style.display = '';   
                    
                if(objHideFilterY!=null)       
                objHideFilterY.style.display = 'None';
                
                if(objdivMainAdvancedFilters!=null)
                   objdivMainAdvancedFilters.style.display= 'None';
                
                if(objShowAdvancedFilter!=null){
                objShowAdvancedFilter.style.display = '';
                objHideAdvancedFilter.style.display = 'none';}
                
                ShowFilterY='0';
                ShowFilterX='0';
                ShowOtherViewFilter = '1';
                ShowAdvancedFilter='0';

            }
            else if(ShowOtherViewFilter=='1')
            {
                objtblOtherViewFilter.style.display='none';
                ShowOtherViewFilter='0';    
            }
        
        }
         function CloseFilter()
        {
            var objHideFilterX =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilterX =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            var objHideFilterY =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilterY =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            
            var objShowFilterAdvanced=GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');
            var objHideFilterAdvanced =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');

            
            if(objShowFilterAdvanced!=null) objShowFilterAdvanced.style.display = '';
            if(objHideFilterAdvanced!=null) objHideFilterAdvanced.style.display = 'None';
             ShowAdvancedFilter='0'; 
            
            if(objShowFilterX!=null) objShowFilterX.style.display = '';
            if(objHideFilterX!=null) objHideFilterX.style.display = 'None';
             ShowFilterX='0'; 
            if(objShowFilterY!=null) objShowFilterY.style.display = '';
            if(objHideFilterY!=null) objHideFilterY.style.display = 'None';
             ShowFilterY='0'; 
            if(objdivTblY!=null) objdivTblY.style.display='none';
            if(objdivTblX!=null) objdivTblX.style.display='none';
            if(objdivTblMainOtherView!=null) objdivTblMainOtherView.style.display='none';
            ShowOtherViewFilter = '0';
            
            if(objDivMainAdvancedFilters!=null) objDivMainAdvancedFilters.style.display='none';
                        
        }
        
        function ShowFilterX_OnClick()
        {
            showFiltersX(1);
        }
        function HideFilterX_OnClick()
        {
            showFiltersX(0);
        }
        function ShowFilterX_OnClick()
        {
            showFiltersX(1);
        }
        function HideFilterX_OnClick()
        {
            showFiltersX(0);
        }
        
        function ShowFilterY_OnClick()
        {
            showFiltersY(1);
        }
        function HideFilterY_OnClick()
        {
            showFiltersY(0);
        }
        function OtherViews_OnClick()
        {
              showOtherViewFilters();
        }
        
////Added By Amol Changle On: 09 Feb 2009
//Purpose: To view reports Financial year wise          
        function ShowPreviousFY(Title)
        {
            var Mode = (arguments.length>1)?arguments[1]:"0";
            if (Mode == "0")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');

                 if (Title !="")   
                 {
                 objWait.style.display="block";
                 document.getElementById('fillDiv').style.display="block";                                                                   
                 }
                 window.setTimeout('ShowPreviousFY("'+Title+'","1")',1)
            }
            
            if (Mode == "1")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                ShowPreviousFY(Title,"2");
                if (Title =="")
                {
                    objWait.style.display="none";
                     document.getElementById('fillDiv').style.display="none";                                                                   
                }               
            }    
            if (Mode == "2")
            {
                if(Title=='')
                {   
                   alert('This is First Financial Period.');
                   return;
                }
                
                if(objTxtFYPeriod==null)
                    return;
                  
                objTxtFYPeriod.value=parseInt(objTxtFYPeriod.value)-1;
                objfrm.submit();         
            }
        
        }
      
        function ShowNextFY(Title)
        {   
            var Mode = (arguments.length>1)?arguments[1]:"0";
            if (Mode == "0")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');

                 if (Title !="")   
                 {
                    objWait.style.display="block";
                    document.getElementById('fillDiv').style.display="block";                        
                    document.body.readonly=true;
                 }
                 window.setTimeout('ShowNextFY("'+Title+'","1")',1)            
            }
            if(Mode == "1")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
             ShowNextFY(Title,"2");
             if (Title =="")
             {
                 objWait.style.display="none";      
                 document.getElementById('fillDiv').style.display="none";                                               
             }       
            }
            
            if(Mode == "2")
            { 
                if(Title=='')
                {   
                   alert('This is Last Financial Period.');
                   return;
                }
                
                if(objTxtFYPeriod==null)
                    return;
                  
                objTxtFYPeriod.value=parseInt(objTxtFYPeriod.value)+1;
                objfrm.submit();              
            
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
			    
			      if(validateNumPaging()) {
					Page_OnClick(objPageNumber.value);
					}
					else{ return; }
					
			}
		    else
		    return;
	}
        
//End Addition         

function ViewGraph_OnClick()
{
       
//        if('<%=m_blnIsFYDriven.ToString() %>'=='True')
//        window.open("../Payroll/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph&FYPeriodID=<%=m_strFYPeriod %>","_self","resizable=no,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 570)/2) + ",width=900,height=570");
//        else
//        window.open("../Payroll/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph","_self","resizable=no,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 570)/2) + ",width=900,height=570");


//        if('<%=m_blnIsFYDriven.ToString() %>'=='True')
//        objfrm.action= "../Payroll/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph&FYPeriodID=<%=m_strFYPeriod %>";
//        else
            var Mode = (arguments.length>0)?arguments[0]:"0";
            if (Mode == "0")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                objWait.style.display="block";
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('ViewGraph_OnClick("1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                 ViewGraph_OnClick("2")
            }            
           if  (Mode == "2")
            {       
               // objfrm.action="../METRICS/MetricsCrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph";
               objfrm.action = "../METRICS/MetricsCrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph&PKToken=<%=m_PKToken%>";
                objfrm.submit();             
            }
}       
//Commented and Added on 2nd Feb 2015 for Java script Error 
//function CboGraphType_OnChange(ObjGraphType)
//{
//    if(ObjGraphType==null)
//        return;
//        
//    for(i=0;i<ObjGraphType.length;i++)
//    {
//        objRow=GetObjectReference('','TR_'+ObjGraphType.options[i].value);
//        
//        if(ObjGraphType.options[i].value==ObjGraphType.value)
//            objRow.style.display='';
//        else
//            objRow.style.display='none';
//    }
//}

function CboGraphType_OnChange(ObjGraphType)
{
    if(ObjGraphType==null)
        return;
        
    for(i=0;i<ObjGraphType.length;i++)
    {
        objRow=GetObjectReference('','TR_'+ObjGraphType.options[i].value);
        
        if(ObjGraphType.options[i].value==ObjGraphType.value)
        {
            
            if(objRow!=null)    //Added By Parag Patil
                objRow.style.display='';
        }    
        else
        {
            if(objRow!=null)    //Added By Parag Patil
                objRow.style.display='none';
        }     
            
            
    }
}
//End of Comment and Addition on 2nd Feb 2015
function GridView_OnClick()
{
            var Mode = (arguments.length>0)?arguments[0]:"0";
            if (Mode == "0")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                objWait.style.display="block";
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('GridView_OnClick("1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented And Added By Vaijat k ON 19/11/2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                 GridView_OnClick("2")
            }            
           if  (Mode == "2")
            {       
            //window.location.href="../Payroll/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&FromWhere=Graph"  
            objfrm.action="../METRICS/MetricsCrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&FromWhere=Graph"  ;
             objfrm.submit();  
             }
}
      
    function GraphDetail_OnClick(strText,strYAxis,strXAxis)
    {       

            var index=strXAxis.split("series")[1];
            
            strXAxis=arrSeries[index-1];

             strYAxis = strYAxis.replace(/&/g,"AMPERCENT");
             strYAxis =   strYAxis.replace(/%/g,"PERCENT");
             strYAxis =   strYAxis.replace(/#/g,"<HASH>");
             strXAxis =  strXAxis.replace(/&/g,"AMPERCENT");
             strXAxis=  strXAxis.replace(/%/g,"PERCENT");
             strXAxis=  strXAxis.replace(/#/g,"<HASH>");
        
        if('<%=m_blnIsFYDriven.ToString() %>'=='True')
        window.open("../METRICS/MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis="+strYAxis+"&DQXAxis="+strXAxis+"&CTReportID=<%=m_intCTReportID.ToString() %>&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>","","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 570)/2) + ",width=900,height=570");
        else
        window.open("../METRICS/MetricsCrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis="+strYAxis+"&DQXAxis="+strXAxis+"&CTReportID=<%=m_intCTReportID.ToString() %>&Mode=DetailQuery","","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 570)/2) + ",width=900,height=570");
            
    }  
    
    function ShowHelpDeskAnalytics()
    {
        window.open("../Home/DetailView.aspx?MenuGroupId=<%=m_strMenuGroupId%>","_self")
    }
    
            function ShowAdvancedFilters_OnClick()
        {
            ShowAdvancedFilters(1);
        }
        function HideAdvancedFilters_OnClick()
        {
            ShowAdvancedFilters(0);
        }
        
         function ShowAdvancedFilters(show)
        {
            var objtblFilterX = GetObjectReference('frmCrossTabGridReport','divTblX');
            var objtblFilterY = GetObjectReference('frmCrossTabGridReport','divTblY');
            var objtblFilter  = GetObjectReference('frmCrossTabGridReport','divMainAdvancedFilters');
            
            var objHideFilterY =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilterY =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            
            
            var objHideFilterX =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilterX =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            
            var  objShowFilter=GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');
            var objHideFilter =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');
            
             var objtblOtherViewFilter = GetObjectReference('frmCrossTabGridReport','divTblMainOtherView');
             
            if (ShowAdvancedFilter=='0')
            {
                objtblFilter.style.top=25;
                objtblFilter.style.left="47%";
                objtblFilter.zIndex=1;
                objtblFilter.style.display='';
                objShowFilter.style.display = 'None';
                objHideFilter.style.display = '';
                
                if(objShowFilterX!=null){
                objShowFilterX.style.display = '';
                objHideFilterX.style.display = 'none';}
                
                objtblFilterX.style.display = 'None';
                
                if(objShowFilterY!=null){
                objShowFilterY.style.display = '';
                objHideFilterY.style.display = 'none';}
                
                objtblFilterY.style.display = 'None';
                
                if(objtblOtherViewFilter!=null)
                objtblOtherViewFilter.style.display = 'None';
                
                ShowAdvancedFilter='1';
                ShowFilterX='0';
                ShowFilterY ='0';
                ShowOtherViewFilter = '0';

            }
            else if(ShowAdvancedFilter=='1')
            {
                objtblFilter.style.display='none';
                ShowAdvancedFilter='0';    
                objShowFilter.style.display = '';
                objHideFilter.style.display = 'None';
            }
        }
    
            function applyAdvancedFilter()
        {
            if(!ValidateAdvancedFilters()) return;
             
            if('<%=m_strMode %>'=='Graph' && '<%=m_strFromWhere %>'=='')
                objfrm.action = "MetricsCrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter";
           else
                objfrm.action = "MetricsCrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>";
           objfrm.submit();
        }
        
        function ClearAdvancedFilter()
        {   
            ClearFilter();
        
            if('<%=m_strMode %>'=='Graph' && '<%=m_strFromWhere %>'=='')
                objfrm.action = "MetricsCrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter";
           else
                objfrm.action = "MetricsCrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>";
           objfrm.submit();
        }
    
         </script>
</body>
</html>
