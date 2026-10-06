<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ETCApproval.aspx.vb" Inherits="PbNIT.PM_ETCApproval"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <%PlotHead()%>
  <%CommonFunctions.General.PlotPageHeadTag("")%>

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    
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


  <body MS_POSITIONING="GridLayout" class=clsBody onresize="window_onresize()" onload="window_onload()">

    <form id="frmETCAuthenticate" method="post" runat="server">
		<%DrawPage()%>
    </form>

  </body>
</HTML>

<script language =javascript >

	var objForm = GetFormReference('frmETCAuthenticate');
    
    <%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
    
	function optTaskType_onclick(strTaskType, strField, strSortOrder)
	{
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
		objForm.action = "PM_ETCApproval.aspx?ProjectID=<%=m_lngProjectID%>&MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&TaskType=" + strTaskType + "&Field=<%=m_strSortField%>&Order=<%=m_strSortOrder%>";
		objForm.submit();
	}

	// START : Commented & Modified By ParagD On 29-Aug-2006 
    // Purpose : Whiz SP 7.2 Release
	var strProjectStatus = "<%=m_blnProjectStatus%>";
	// END : Commented & Modified By ParagD On 29-Aug-2006 
		
	function Authenticate_OnClick()
	{
		// START : Commented & Modified By ParagD On 29-Aug-2006 
        // Purpose : Whiz SP 7.2 Release
        // We can authenticate an ETC of a closed / Onhold Project.
        // User will be given an alert if that Particular Project is "On Hold" OR "Closed"
		if(strProjectStatus == 'True') 
		{
			alert('ETC Cannot be Authenticated  as Project is Closed / On Hold ');
			return;
		}
		// END : Commented & Modified By ParagD On 29-Aug-2006 
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
		objForm.action = "PM_ETCApproval.aspx?ProjectID=<%=m_lngProjectID%>&Mode=AUTHENTICATE&MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&TaskType=<%=m_strSelectedType%>&Field=<%=m_strSortField%>&Order=<%=m_strSortOrder%>";
		objForm.submit();
		//added by harshada d for PMLifeLine SP7.3 this code will be executed if it is called from PMLifeLine today
		if ("<%=m_strFromWhere%>" == "DB")
		{
			window.opener.location.href=window.opener.location.href;
			//refreshParent('frmETCAuthenticate','DB_MyProjects.aspx','DB_MyProjects.aspx');
		}
	}
	
	function DeleteETC_OnClick()
	{
		
		//Added by PrashantD on 2 April 2007 for IssueID 11885
		var objchkDelete = GetObjectReference('frmETCAuthenticate','chkDelete',true)
		var i;
		for(i=0;i<objchkDelete.length;i++)
		{
			if (objchkDelete[i].checked == true)
			break;
		}
		
		if(i==objchkDelete.length)
		return;
		//End of addition by PrashantD on 2 April 2007
		
		// START : Commented & Modified By ParagD On 29-Aug-2006 
        // Purpose : Whiz SP 7.2 Release
        // We can authenticate an ETC of a closed / Onhold Project.
        // User will be given an alert if that Particular Project is "On Hold" OR "Closed"
         
		if(strProjectStatus == 'True') 
		{
			alert('ETC Cannot be deleted  as Project is Closed / On Hold ');
			return;
		}
		// END : Commented & Modified By ParagD On 29-Aug-2006 
		
		if (confirm("<%=MyBase.GetResourceString("MSG_CONFIRM")%>"))
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objForm.action = "PM_ETCApproval.aspx?ProjectID=<%=m_lngProjectID%>&Mode=DELETE&MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&TaskType=<%=m_strSelectedType%>&Field=<%=m_strSortField%>&Order=<%=m_strSortOrder%>";
			objForm.submit();
		}
	}
	
	function ShowWindow(intETCID)			
	{
		//Modified By VidyaJ - Browser Issue - IssueID - 809 
		// Show the Popup Input box to take input about the authenticated ETC hours
		//Modified by RajashriK for netscape implementation on 11.4.2005
		if(navigator.appName == 'Netscape')
			window.open ("PM_ETCApproval.aspx?ProjectID=<%=m_lngProjectID%>&MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=CHANGE&ETCID=" + intETCID + "&TaskType=<%=m_strSelectedType%>", "_new","resizable=yes,scrollbars=yes,left=150,top=200,width=500,height=350");
		else
			window.open ("PM_ETCApproval.aspx?ProjectID=<%=m_lngProjectID%>&MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=CHANGE&ETCID=" + intETCID + "&TaskType=<%=m_strSelectedType%>", "_new","resizable=yes,scrollbars=no,left=150,top=200,width=500,height=250");
		//End modification
		
		
	}

	function SortBy( strFieldName, strAscOrDesc)
	{	
		<%        If m_blnMPPTasks_Selected Then%>
			objForm.action = "PM_ETCApproval.aspx?ProjectID=<%=m_lngProjectID%>&MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&Field=" + strFieldName + "&Order=" + strAscOrDesc + "&TaskType=M";
		<%        Else%>
			objForm.action = "PM_ETCApproval.aspx?ProjectID=<%=m_lngProjectID%>&MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&Field=" + strFieldName + "&Order=" + strAscOrDesc + "&TaskType=O";
	    <%     End If%>
        
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
		objForm.submit();
	}
			
	function Save_OnClick()
	{
		// START : Commented & Modified By ParagD On 29-Aug-2006 
        // Purpose : Whiz SP 7.2 Release
        // We can authenticate an ETC of a closed / Onhold Project.
        // User will be given an alert if that Particular Project is "On Hold" OR "Closed"
        
		if(strProjectStatus == 'True') 
		{
			alert(strProjectStatus_msg);
			return;
		}
		// END : Commented & Modified By ParagD On 29-Aug-2006 
			
		var objtxtETC = GetObjectReference('frmETCAuthenticate','txtETC');
		var objoldVal = objtxtETC.value;
		var objVal = objtxtETC.value;
		//validations
        /*    Commented And Added By Sagar Nipane on 01-March-2019 for display efforts in HH:MM Format */
	    <%--if (disallowBlank(objtxtETC,'<%=MyBase.GetResourceString("MSG_BLANK")%>',true)) return;
		if (disallowNonNumeric(objtxtETC,'<%=MyBase.GetResourceString("MSG_NONNUMERIC")%>',true)) return;
		if (disallowMinValueViolation(objtxtETC,'<%=m_dblLowerLimit%>','<%=MyBase.GetResourceString("MSG_MIN_VAL")%>' + '<%=m_dblLowerLimit%>.',true)) return;
		
		if ( objtxtETC.value.indexOf(".",0) >= 0 ) 
		{
			// means decimal exists: Now we check if value is a multiple of the Min. Timesheet value
			if ( ( parseFloat(objtxtETC.value) / <%=commonfunctions.Application.MinHoursForDAEntry%> ) != ( parseInt( parseFloat(objtxtETC.value) / <%=commonfunctions.Application.MinHoursForDAEntry%> ) ) )
			{
				alert("Please specify the 'ETC (hrs)' in multiples of <%=commonfunctions.Application.MinHoursForDAEntry%> hours !! This is necessary because the user can only fill a minimum of <%=commonfunctions.Application.MinHoursForDAEntry%> hours in the timesheet.");
				//frmETCAuthenticate.txtETC.focus						
				return;
			}
		}--%>

	  
      
       
//  Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 
	    //if (objVal.indexOf(':') == -1) {
	    //    objtxtETC.value = objVal + ':00';
	    //    objVal = objtxtETC.value;
	    //}
	    // End of Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 

        if (disallowBlank(objtxtETC,"'ETC Hours' should not be left blank.",true)) return;
 //Below script for disallow special characters
        objtxtETC.value= objtxtETC.value.replace(":",".");
                        var isdigit = isNumeric(objtxtETC.value);
                        objtxtETC.value= objoldVal;
                       
                         if(isdigit == false)
                         {
                        alert("Please Enter only positive numeric value For ETC Hours in H:M format.");
                        setFocus(objtxtETC);
                                return false;
                        }

 if (objtxtETC.value.indexOf(':') == -1) {
            //alert('Please enter Review Work in (HH:MM) format.');
            //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            //setFocus(objtxtETC);
            //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            //return false;

            objtxtETC.value = objVal + ':00';
            objVal = objtxtETC.value;
        }
        if (objtxtETC.value.indexOf('.') >= 0) {
            objtxtETC.value = objoldVal;
            alert('Please enter ETC Hours in H:M format.');
           
            //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            setFocus(objtxtETC);
            //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            return false;
            
           
        }
        if (objtxtETC.value.indexOf(":") != -1) {
            objtxtETC.value = objtxtETC.value.replace(':', '.');
        }

        var blnResult = disallowSpecialCharacters(objtxtETC, "Please enter ETC Hours in H:M format.");
        
        if (blnResult == true) {
            objtxtETC.value = objoldVal;
            //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            setFocus(objtxtETC);
            //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            return false;
        }

        objtxtETC.value = objtxtETC.value.replace('.', ':');
        //End of script for disallow special characters

        var WorkHour = objtxtETC.value; 
        WorkHour = WorkHour.trim(); //Removing unnecessary spaces
        var idxColon = WorkHour.indexOf(':');
        var hrs = WorkHour.substring(0, idxColon);
        var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

        if (mins.length == 1 && mins > 5) {
            mins = mins + "0";
        }
        if (mins == "") {
                    //mins = "00";
                objtxtETC.value=objoldVal;
                   alert('Please enter ETC Hours in H:M format.');                  
                     //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            setFocus(objtxtETC);
            //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            return false;
        }
       
        //Validating Hours

         if(hrs.indexOf("-") != -1)
                            {
                            alert('Hours should not be less than or equal to zero (0).');
                             //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            setFocus(objtxtETC);
                            //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            return false;
        }

        if (hrs <= 0 && mins <= 0) {
            objtxtETC.value=objoldVal;
            alert('Hours should not be less than or equal to zero (0).');
            //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            setFocus(objtxtETC);
            //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            return false;
        }        

	    // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
        if (mins.length > 2) {
            alert("Please enter minutes in two decimal and less than 60.");
            setFocus(objtxtETC);
            return false;
        }
	    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

        //Validating Minutes range (0 - 59)
        if (mins > 59 || mins < 0) {
            objtxtETC.value=objoldVal;
            alert('Please enter minutes between (0-59) range');
            //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            setFocus(objtxtETC);
            //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            return false;
        }

        var MinDAENtryDisplay = "";
        var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
        //alert("MinHoursDAEntry:<%=CommonFunctions.Application.MinHoursForDAEntry%>");
        if (MinDAEntry == 0.25) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:15"
        }
        else if (MinDAEntry == 0.50) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:30"
        }
        else if (MinDAEntry == 0.75) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:45"
        }
        
        if ("<%=m_RestrictByMinHours%>" == 'True') {
            if (MinDAEntry == 0.016) {
            }
            else {
                var minutes = objtxtETC.value.split(':');
                var p = minutes[0];
                var dec = minutes[1];
                if (dec == undefined) { dec = 0; }
                d = (dec - 0) / 60 + (p - 0);

                if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                    //alert("Please enter the work hrs. in multiple of min.work hrs (" + MinDAENtryDisplay + ")");
                    alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                    setFocus(objtxtETC);
                    objtxtETC.value = objtxtETC.value.split('.').join(':');
                    return false;
                }
            }
        }
        
        if (objtxtETC.value.toString().indexOf(":") != -1) {
            var chkhr = objtxtETC.value.split(":")[0];
            var chkmin = objtxtETC.value.split(":")[1];
            if (chkhr.length == 1) {
                chkhr = "0" + chkhr;
                objtxtETC.value = chkhr + ":" + chkmin;
            }
            if (chkmin.length == 1) {
                chkmin = chkmin + "0";
                objtxtETC.value = chkhr + ":" + chkmin;
            }
        }
		//End of Adding By Sagar Nipane on 01-March-2019 for display efforts in HH:MM Format
	    //submit
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    var MenuTags = document.getElementsByTagName('A');
	    for (i = 0; i < MenuTags.length; i++) {
	        if (MenuTags[i].className == "Menu") {
	            //MenuTags[i].style.display= "none";
	            MenuTags[i].parentNode.style.display = "none";
	        }
	    }
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
		objForm.action = "PM_ETCApproval.aspx?ProjectID=<%=m_lngProjectID%>&MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=CHANGE&ACTION=SAVE&ETCID=<%=m_lngETCID%>&TaskType=<%=m_strSelectedType%>";
		objForm.submit();
	}
	
    var objdivlist = GetObjectReference('frmETCAuthenticate','divList');

	function window_onload()
    {
	    
		//Modified By VidyaJ - Browser Issue - IssueID - 809 
		//if condition is added by RajashriK for netscape implementation on 21.3.2005
		//Divlist is modified for netscape on 11.4.2005
	    if (objdivlist != null) 
	    {
			//if(navigator.appName == 'Netscape')
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop+120;
			//else
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    //commented added by Shamkant s on 18 Nov 2015
		        if(WhichBrowser()  == 'IE')
		        {
		            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 280 ;
		        }
		        else if(WhichBrowser()  == 'FF')
		        {
		            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 260;
		        }
		        else if(WhichBrowser()  == 'CR')
		        {
		            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop -40 ;
		            
		        }
		        else
		        {
		            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 280;
		        }
			if (intDivHeight < 100)	
				{intDivHeight = 100};
			
		objdivlist.style.height = intDivHeight + 'px';	
		}
	}
	//Commented added by Shamkant S on 18 Nov 2015
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
	//Commented ended by Shamkant s 0n 18 nov 2015
	function window_onresize()		
	{
	    
	    //Modified By VidyaJ - Browser Issue - IssueID - 809 
		if (objdivlist !=null) 
		{
			var intDivHeight;
			//if condition is added by RajashriK for netscape implementation on 21.3.2005
			//Divlist is modified for netscape on 11.4.2005
			
			if(navigator.appName == 'Netscape')
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop ;
			else
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				
				

			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;
		}	
		
			//-------------------------------------------------------------------
	//	refreshParent(parentFormName,submitToPage[,closeChildWindow])
	//		Refresh the parent window
	//		parentFormName		-	Parent Form Name
	//		submitToPage		-	Submit to page name
	//		closeChildWindow	-	Optional parameter
	//								If true then close the window
	//-------------------------------------------------------------------
		function refreshParent(parentFormName,parentPage,submitToPage) 
		{
			var closeChildWindow=(arguments.length>3)?arguments[3]:false;
       		var strParentPage;
			strParentPage = new String();
			strParentPage = opener.location.href;
			// If the document loaded in the parent window is the Page to submit, then refresh the page.
			if (strParentPage.toUpperCase().indexOf(parentPage.toUpperCase()) != -1)
			{
        		window.opener.document.forms[parentFormName].action = submitToPage;
        		window.opener.document.forms[parentFormName].submit();
			}
			if (closeChildWindow==true) { window.close(); }
		}	
	}
	</script>