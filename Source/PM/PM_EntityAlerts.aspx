<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EntityAlerts.aspx.vb" Inherits="PbNIT.PM_EntityAlerts" %>

 
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Alerts")%>
    
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


	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmEntityAlerts" method="post" runat="server">
						 
									<%WritePage()%>
							 
		</form>
		<script language="javascript">
					
		var objPageDiv=GetObjectReference('frmEntityAlerts','PageDiv');
		var objform=GetFormReference('frmEntityAlerts');			
					
		var objlstProject_FieldList = GetObjectReference('frmEntityAlerts','lstProject_FieldList');
        var objlstProject_SelectedFields = GetObjectReference('frmEntityAlerts','lstProject_SelectedFields');
        var objAlertName = GetObjectReference('frmEntityAlerts','txtAlertName');
        
        <%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
        
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objPageDiv !=null) {
			intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 30;
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			//objPageDiv.style.height = intDivHeight;	
			objPageDiv.style.height = intDivHeight + 'px';
			}		
			var refresh = <%=m_intRefreshParent%>;
			
			if (refresh == 1)
		    {
		    refreshParent('frmCommonList','CommonList.aspx','../General/CommonList.aspx?MasterTagId=3939');
		    }
		}
			
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objPageDiv !=null) 
			{
				intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 30;
				if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objPageDiv.style.height = intDivHeight;	
				objPageDiv.style.height = intDivHeight + 'px';
			}
			 
		}	
		
		function Save_OnClick(EmployeeAlertID)
		{
		
		    /*if(objlstProject_SelectedFields.options.length == 0)
	        {
	            alert("Please select at least one test");
    	        	        
	            return;
	        }*/
    	    
    	    if (disallowBlank(objAlertName,'Alert Name should not be blank !',true))
		    return; 
		
	        if(objlstProject_SelectedFields)
	        {
	            for(i=0;i<objlstProject_SelectedFields.options.length;i++)
	            {
	               objlstProject_SelectedFields.options[i].selected=true;
	            }
	        }
	        //COMMENTED AND ADDED BY NILESH G ON 30/8/2016 PURPOSE: PK TOKEN SECURITY
		    // objform.action="../PM/PM_EntityAlerts.aspx?AlertEntityID=<%=strAlertEntityID %>&action=SAVE";
		    objform.action="../PM/PM_EntityAlerts.aspx?AlertEntityID=<%=strAlertEntityID %>&action=SAVE&PKToken=<%=m_TokenKEY%>";
		    //END OF COMMENTED AND ADDED BY NILESH G ON 30/8/2016 PURPOSE: PK TOKEN SECURITY
		    objform.submit();
		    window.opener.location.href="../PM/PM_CreateEmployeeWiseAlerts.aspx";
		}
		function SaveandAdd_OnClick()
		{
		    objform.action="../PM/PM_EntityAlerts.aspx?AlertEntityID=<%=strAlertEntityID %>action=SAVEADD";
		    objform.submit();
		}
		
	
    
		function selectAlerts(EmployeeAlertID)
		{
		    //PM_CreateEmployeeWiseAlerts.aspx
		    window.open ("../PM/PM_CreateEmployeeWiseAlerts.aspx?EmployeeAlertID=" + EmployeeAlertID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=380");

		}
		
		function MoveSelectedTo_Custom(objListBox1,objListBox2)	
	{
		var optTag;
		if (objListBox1.selectedIndex == -1)
		{
			return;
		}
		objListBox2.SelectedIndex = -1;
		//Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
		//Purpose : Firefox Support, () changed to [] and innerHTML chaned to innerHTML
		while (objListBox1.selectedIndex != -1)
		{
			optTag = document.createElement("OPTION");
			if(objListBox2.id == "lstSort_SelectedFields"){
				//optTag.innerHTML = trimString(objListBox1.options(objListBox1.selectedIndex).innerHTML) + " ASC";
				optTag.innerHTML = trimString(objListBox1.options[objListBox1.selectedIndex].innerHTML) + " ASC";
				optTag.value = trimString(objListBox1.options[objListBox1.selectedIndex].value) + " ASC";
			}			
			else if(objListBox2.id == "lstSort_FieldList"){
				//optTag.innerHTML = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerHTML," ASC","");
				//optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				optTag.innerHTML = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].innerHTML," ASC","");
				optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				optTag.value = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].value," ASC","");
				optTag.value= replaceSubstring(optTag.value," DESC","");
			}
			else{			
				//optTag.innerHTML = trimString(objListBox1.options(objListBox1.selectedIndex).innerHTML);
				optTag.innerHTML = trimString(objListBox1.options[objListBox1.selectedIndex].innerHTML);
				optTag.value = trimString(objListBox1.options[objListBox1.selectedIndex].value);
			}
			//append the tag						
			objListBox2.appendChild(optTag);						
			if (objListBox1.length > 0)
			{
				if (objListBox1.selectedIndex != -1)
				{
					objListBox1.remove(objListBox1.selectedIndex);						
				}
			}
			//Modification Ends by SantoshK on June 8, 2006
		}
	}
	
	function MoveAllTo_Custom(objListBox1,objListBox2)	
	{		
	
		var optTag;
		if (objListBox1.length == 0)
		{
			return;
		}
		//Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
		//Purpose : Firefox Support, () changed to [] and innerHTML chaned to innerHTML
		objListBox2.SelectedIndex = -1;
		while (objListBox1.length >0)
		{
			optTag = document.createElement("OPTION");
			if(objListBox2.innerTextid == "lstSort_SelectedFields"){
				//optTag.Text = trimString(objListBox1.options(0).innerHTML) + " ASC";
				optTag.innerHTML = trimString(objListBox1.options[0].innerHTML) + " ASC";
				optTag.value = trimString(objListBox1.options[0].value) + " ASC";
			}			
			else if(objListBox2.id == "lstSort_FieldList"){
				//optTag.innerHTML = replaceSubstring(objListBox1.options(0).innerHTML," ASC","");
				//optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				optTag.innerHTML = replaceSubstring(objListBox1.options[0].innerHTML," ASC","");
				optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				optTag.value = replaceSubstring(objListBox1.options[0].value," ASC","");
				optTag.value= replaceSubstring(optTag.value," DESC","");
			}
			else{		
				//optTag.innerHTML = trimString(objListBox1.options(0).innerHTML);
				optTag.innerHTML = trimString(objListBox1.options[0].innerHTML);
				optTag.value = trimString(objListBox1.options[0].value);				
			}
			//append the tag						
			objListBox2.appendChild(optTag);						
			objListBox1.remove(0);						
		}
		//Modification Ends by SantoshK on June 8, 2006
	}	
	
    function btnProject_AddSelected_OnClick_Custom()
	{
		MoveSelectedTo_Custom(objlstProject_FieldList, objlstProject_SelectedFields);
	}
				
	function btnProject_RemoveSelected_OnClick_Custom()
	{
		MoveSelectedTo_Custom(objlstProject_SelectedFields, objlstProject_FieldList);
	}
				
	function btnProject_AddAll_OnClick_Custom() 
	{
		MoveAllTo_Custom(objlstProject_FieldList, objlstProject_SelectedFields );							
	}
				
	function btnProject_RemoveAll_OnClick_Custom() 
	{
	     
		MoveAllTo_Custom(objlstProject_SelectedFields, objlstProject_FieldList);
	}

	function lstProject_FieldList_OnDblClick_Custom() 								
	{
		MoveSelectedTo_Custom(objlstProject_FieldList, objlstProject_SelectedFields);
	}
	
	function lstProject_SelectedFields_OnDblClick_Custom() 						
	{
		MoveSelectedTo_Custom(objlstProject_SelectedFields, objlstProject_FieldList);
	}
	/*========================== for Display Fields=====================*/
	
		
		</script>
</body>
</html>
