<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script type="text/javascript" src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>
<link href="../General/loaderStylesheet.css" rel="stylesheet" />
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
        // Starts Feature Tag:whiz41-Web Form Extension Typedip
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
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15 */
            $(".clsTRMenu").eq(1).css('display','none');
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15*/
        }
        else
        {
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15 */
            $(".clsTRMenu").eq(1).css('display','block');
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15*/
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
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15 */
            $(".clsTRMenu").eq(1).css('display','none');
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15*/
        }
        else
        {
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15 */
            $(".clsTRMenu").eq(1).css('display','block');
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15*/
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
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15 */
            $(".clsTRMenu").eq(1).css('display','none');
            /*Edited by KIRAN K K FOR Issue number:2144 27-11-15*/
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRO_ProjectTypeConfiguration.aspx.vb" Inherits="PbNIT.PRO_ProjectTypeConfiguration" %>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strPageTitle)%>
	<body MS_POSITIONING="GridLayout" class="clsbody" onresize="window_onresize()" onload="window_onload()">

	<form id="frmProjectType" method="post" runat="server">
	<%PageInit()%>
	</form>
	<script language="javascript">

	var objForm = GetFormReference('frmProjectType');
	
	<%' Added By SonalD on 13th Jan 2009 %>
    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
	
	function URLEncode(strQSParameter) 		
	{
	// PURPOSE: To handle the special characters in the query string.
		
		strQSParameter = replaceSubstring(strQSParameter, "%", "%25");
		strQSParameter = replaceSubstring(strQSParameter, "#", "%23");			
		strQSParameter = replaceSubstring(strQSParameter, "&", "%26");
		strQSParameter = replaceSubstring(strQSParameter, "+", "%2B");
		strQSParameter = replaceSubstring(strQSParameter, "?", "%3F");						
			
		URLEncode = strQSParameter;			
							
        }
        //Added By Usha Pandit On 13.05.2020 For not allowing to enter duplicate order numbers
        function hasDuplicates(iterable) {
            return new Set(iterable).size !== iterable.length;
        }
        //End Of Added By Usha Pandit On 13.05.2020 For not allowing to enter duplicate order numbers
	function ShowActivity(intProcessID,intProjectTypeID)
	{	
		window.open("PRO_ProjectTypeConfiguration.aspx?FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngTagID%>&Flag=ACTIVITY&ProcessID=" + intProcessID + "&TypeID=" + intProjectTypeID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=550,height=400");
	}
	
	function SaveProcess_OnClick(intProjectTypeID)
	{	
		//Integrated by MrugajaB on 28th July 2005 for PMLifeLine sp4 Issue ID.90
		// added by harshada d on 06/07/2005 for SA issue id 19847 chkIsProjectCreationWorkflowReqd is getting disabled and unchecked 
		enableControls();
		// end of addition by harshada d on 06/07/2005 for SA issue id 19847
	    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For SAVE Issue
		var MenuTags = document.getElementsByTagName('A');
		for (i = 0; i < MenuTags.length; i++) {
		    if (MenuTags[i].className == "Menu") {
		        //MenuTags[i].style.display= "none";
		        MenuTags[i].parentNode.style.display = "none";
		    }
		}
		//setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
	    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For SAVE Issue
		objForm.action = "PRO_ProjectTypeConfiguration.aspx?FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngTagID%>&Mode=SAVEPROCESS&FLAG=SDLC&TypeID=" + intProjectTypeID;
		objForm.method = "Post";
		objForm.submit();
	}
	
	//Integrated by MrugajaB on 28th July 2005 for PMLifeLine sp4 Issue ID.90
	// added by harshada d on 06/07/2005 for SA issue id 19847 chkIsProjectCreationWorkflowReqd is getting disabled and unchecked 
	function enableControls()
	{
		var objtxtPrjType = GetObjectReference('frmProjectType','txtProjectType');
		var objcboPMI = GetObjectReference('frmProjectType','cboPMI');
		var objcboOUPool = GetObjectReference('frmProjectType','cboOUPool');
		var objcboProjectType = GetObjectReference('frmProjectType','cboProjectType');
		var objchkIsProjectCreationWorkflowReqd = GetObjectReference('frmProjectType','chkIsProjectCreationWorkflowReqd');
		// Integrated by ArchanaN on 26 Apr 2007
	
		//Integrated by PrashantD on 1 March 2007 for Product Execution Project
	//	<!-- Added By ParagD 29-May-2006 -->
	//	<!-- RoamWare Customization -->
		var objChkProductExecution = GetObjectReference('frmProjectType','chkIsProductExecutionProject');				
		if(objChkProductExecution != null)  objChkProductExecution.disabled = false;
	//	<!-- END : Added By ParagD 29-May-2006 -->
		//End of addition by PrashantD on 1 March 2007			
				 
		 // Integration Ends

		///modifiedby harshk for sp4 issueid 515 on 05/10/2005
		if(objtxtPrjType != null)objtxtPrjType.disabled = false;
		if(objcboPMI != null)objcboPMI.disabled = false;
		if(objcboOUPool != null)objcboOUPool.disabled = false;
		if(objcboProjectType != null)objcboProjectType.disabled = false;
		if(objchkIsProjectCreationWorkflowReqd != null)objchkIsProjectCreationWorkflowReqd.disabled = false;
		///End modifiedby harshk for sp4 issueid 515 on 05/10/2005
		}
		// end of addition by harshada d on 06/07/2005 for SA issue id 19847
		//end Integration
	function SaveActivity_OnClick(intProcessID,intProjectTypeID)
	{
		//Integrated by MrugajaB on 28th July 2005 for PMLifeLine sp4 Issue ID.90
		// added by harshada d on 06/07/2005 for SA issue id 19847 chkIsProjectCreationWorkflowReqd is getting disabled and unchecked 
		enableControls();
	    // end of addition by harshada d on 06/07/2005 for SA issue id 19847
	    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For SAVE Issue
		var MenuTags = document.getElementsByTagName('A');
		for (i = 0; i < MenuTags.length; i++) {
		    if (MenuTags[i].className == "Menu") {
		        //MenuTags[i].style.display= "none";
		        MenuTags[i].parentNode.style.display = "none";
		    }
		}
		setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
	    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For SAVE Issue
	   	objForm.action = "PRO_ProjectTypeConfiguration.aspx?FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngTagID%>&Mode=SAVEACTIVITY&FLAG=ACTIVITY&ProcessID=" + intProcessID + "&TypeID=" + intProjectTypeID;
		objForm.method = "Post";
		objForm.submit();
	}
	
	function Back_OnClick()
	{
		location.href= "../General/CommonList.aspx?FromWhere=<%=m_strFromWhere%>&MasterTagId=<%=m_lngTagID%>";
	}
	
	function PMI_Changed()
	{
		// URL encoded the Project Type name and the PMI name before passing in the QueryString.
		var objcboPMI = GetObjectReference('frmProjectType','cboPMI');
		var objtxtPrjType = GetObjectReference('frmProjectType','txtProjectType');
		// Integrated by ArchanaN on 26 Apr 2007
		// Added By NitinVS on 2 Jun 2006 for RoamWare Customization 
		var objChkProductExecution = GetObjectReference('frmProjectType','chkIsProductExecutionProject');				
		if(objChkProductExecution != null)  objChkProductExecution.disabled = false;
		// Added By NitinVS on 2 Jun 2006 for RoamWare Customization 
	    // Integration Ends

	    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
		setFrameLoader();
	    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
		//objForm.action = "PRO_ProjectTypeConfiguration.aspx?Mode=ADD_NEW&ProjectTypeID=" + URLEncode(objtxtPrjType.value) + "&PMIID=" + URLEncode(objcboPMI.value);
		objForm.action = "PRO_ProjectTypeConfiguration.aspx?MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=ADD_NEW&PMIID=" + objcboPMI.value;
		objForm.method = "Post";
	   
		objForm.submit();
	}
	
	function OU_OnChange()
	{		
	    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
	    setFrameLoader();
	    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
	    objForm.action = "PRO_ProjectTypeConfiguration.aspx?MasterTagID=<%=m_lngTagID%>&FromWhere=<%=m_strFromWhere%>&Mode=ADD_NEW";
		objForm.submit();
	}
	
	    function SaveType_OnClick() {//debugger;
	        //Integrated by MrugajaB on 28th July 2005 for PMLifeLine sp4 Issue ID.90
	        // added by harshada d on 06/07/2005 for SA issue id 19847 chkIsProjectCreationWorkflowReqd is getting disabled and unchecked 
	        //COMMENTED BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-149
	        //enableControls();
	        //END OF COMMENTING BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-149
	        // end of addition by harshada d on 06/07/2005 for SA issue id 19847

	        //Added by NitinC on 16 March 2012 For PMLifeLine - Agile Methodology [Issue Fix 60601]


	        //Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
	        var Mode = (arguments.length > 0) ? arguments[0] : "0";
	        if (Mode == "0") {
	            document.body.readonly = true;
	            window.setTimeout('SaveType_OnClick("1")', 1);
	            //setFrameLoader();
	        }
	        if (Mode == "1") {
	            //setFrameLoader();
                var IsAgile;
                //debugger;
                //Added By Dipali V On 2nd Dec 2020 Page Contioue loading
                if (document.getElementById('chkIsAgileMethodFollowed') != null) {
                    var IsAgileChecked = GetObjectReference('frmProjectType', 'chkIsAgileMethodFollowed').checked;
                    if (IsAgileChecked == true) {
                        IsAgile = 1
                    }
                    else {
                        IsAgile = 0
                    }
                }
                //End of Added By Dipali V On 2nd Dec 2020 Page Contioue loading
	            //End of Added by NitinC on 16 March 2012 For PMLifeLine 11.0 - Agile Methodology [Issue Fix 60601]
	            if (ValidateData() == true) {

	                //ADDED BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-149
	                enableControls();
	                //END OF ADDITION BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-149
	                //setFrameLoader();
	                //Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For SAVE Issue
	                var MenuTags = document.getElementsByTagName('A');
	                for (i = 0; i < MenuTags.length; i++) {
	                    if (MenuTags[i].className == "Menu") {
	                        //MenuTags[i].style.display= "none";
	                        MenuTags[i].parentNode.style.display = "none";
	                    }
	                }
	                setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
	                //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For SAVE Issue
	                objForm.action = "PRO_ProjectTypeConfiguration.aspx?Mode=SAVE&FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngTagID%>&IsAgile=" + IsAgile;
	                objForm.method = "Post";
	                objForm.submit();
	                RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
	            }
	        }
	    }
	//Added By JyotiG
	//Start_JG_CR_7187_06-Nov-2006
	//Added For History functionality
	function ShowHistory_OnClick(intTypeID)
	{//m_lngProjectTypeID
		window.open("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=1037&ProjectID=0&UniqueID=<%=m_lngProjectTypeID%>" , "","resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
	}
	//End Addition
	//End_JG_CR_7187_06-Nov-2006
	function ValidateData()
	{
		var objtxtPrjType = GetObjectReference('frmProjectType','txtProjectType');
		var objcboPMI = GetObjectReference('frmProjectType','cboPMI');
		
		if (disallowBlank(objtxtPrjType, "<%=MyBase.GetResourceString("SPECIFY_PRACTICE")%>")) {
		  
		    return false;
		}
	    if (disallowMaxlengthViolation(objtxtPrjType, 100, "<%=MyBase.GetResourceString("SELECT_PROJECT_PMI")%>")) {
	      
	        return false;
	    }
	    
		// Validation : Check Duplication.						
	    var intUBound
	    var strProjectType
	    var intCtr
        var strProjectTypeArray = "";//Added By Dipali V On 30th Jun 2020 For Javascript Issue
	    intUBound = strProjectTypeArray.length	    
	    strProjectType = objtxtPrjType.value	    
		for(intCtr = 0; intCtr < intUBound; intCtr++)
		{				
			if( trimString(strProjectType).toUpperCase() == trimString(strProjectTypeArray[intCtr]).toUpperCase() )
			{
			    alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_TYPE_EXISTS",False)%>", "<PROJECT_TYPE>", strProjectType));
			   
				objtxtPrjType.focus();
				return false;
			}			
		}
		
	    //Special character check for the ProjectType
	    if(objcboPMI.value=="")
	    {
	        alert("<%=MyBase.GetResourceString("MSG_NOT_BLANK")%>");
	     
	       objcboPMI.focus(); 
		   return false;	  
		}
		
		//var objOUPool=GetObjectReference('frmProjectType','cboOUPool');
		//if (disallowBlank(objOUPool,"<%=MyBase.GetResourceString("SPECIFY_OU")%>")) return false;
		
		var objNewProjectType=GetObjectReference('frmProjectType','cboProjectType');
		if (disallowBlank(objNewProjectType, "<%=MyBase.GetResourceString("SPECIFY_PROJECT_TYPE")%>")) {
		  
		    return false;
		}
		if (disallowSpecialCharacters(objtxtPrjType,"",true,"[/:*?+\"><|,\\\\]")==true) 
		{
		//Commented and Modified By JyotiG
		//Start_JG_4206_30-Oct-2006
		//alert("Special Characters * \ | : ? , + < > /  are not allowed for Practice")
		    alert("Special Characters " + '/:*?+\"><|,' + " \\ are not allowed for Practice");
		 
		//End_JG_4206_30-Oct-2006
		return false; 
		}
		//Added By JyotiG
		//Start_JG_CR_7187_06-Nov-2006
		var objchkIsActive = GetObjectReference('frmProjectType','chkIsActive');
		var strMsg;
		if (objchkIsActive.checked == false )
		{

		    strMsg = confirm('Project created from now onwards will not be able to select this practice.' + '\n Do you want to Continue?');

			if (strMsg == false)				
				{	objchkIsActive.checked =true;
					return false; 
			}

		}	
		//End_JG_CR_7187_06-Nov-2006
		return true;
	}
		
	var objdivlist = GetObjectReference('frmProjectType','divList');
	function window_onload()
	{

		var intDivHeight ;
		if (intDivHeight < 100)
			intDivHeight = 100;
						 
	    //'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
        
	    //Commented and added by Yogesh J on 19-Nov-2015
		//	 if(navigator.appName == 'Netscape')
			     if( WhichBrowser() == 'FF')
			     {
		  
			        // intDivHeight = window.innerHeight  - objdivlist.offsetTop - 20 ;
			         intDivHeight = window.innerHeight  - objdivlist.offsetTop - 20;
	          	} 
		  else
			     {
			      
			         //   intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 20;
			         intDivHeight = window.innerHeight  - objdivlist.offsetTop - 21;
			         //End of addition by Yogesh J on 19-Nov-2015
		    }
				if (intDivHeight < 100)
			intDivHeight = 100;
			 
	    // Let the minimum height of the div tag be 100
	    /*Commented And Added by KIRAN K K For Height Issue fixing*/
	    //objdivlist.style.height = intDivHeight	;
				objdivlist.style.height = intDivHeight + 'px';
	    /*Commented And Added by KIRAN K K For Height Issue fixing*/ 
				
		
	}

        //Added by Yogesh J on 19-Nov-2015
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
	    //End of addition by Yogesh J on 19-Nov-2015
	function window_onresize()		
	{
	    var intDivHeight;
		
	    //'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
	
	    //Commented and added by Yogesh J on 19-Nov-2015
	    //  if(navigator.appName == 'Netscape')
	     if( WhichBrowser() == 'FF')
	        //End of addition by Yogesh J on 19-Nov-2015
		    {
		  
	           intDivHeight =window.innerHeight  - objdivlist.offsetTop - 25 ;
	     
		    }
		    else
		    {
	            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 25;
	          
		    }
		if (intDivHeight < 100 )
			 intDivHeight = 100;	// Let the minimum height of the div tag be 100
	    /*Commented And Added by KIRAN K K For Height Issue fixing*/
	    //objdivlist.style.height = intDivHeight;
		objdivlist.style.height = intDivHeight + 'px';
	    /*Commented And Added by KIRAN K K For Height Issue fixing*/ 
				
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
		var objTemp;
			
		
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
											
					}		
					
					objTemp = GetObjectReference(strFormName,'txtPercentageEfforts' + intCtr);
					if (objTemp != null)
						objTemp.disabled = false;
					
					objTemp = GetObjectReference(strFormName,'txtOrderNumber' + intCtr);
					if (objTemp != null)
						objTemp.disabled = false;
				}
			}
			// Else, if single element exists, then...
			else if(intItems == 1)
			{
				if (objCheckbox[0].disabled == false) 
					objCheckbox[0].checked = true;
										
				objTemp = GetObjectReference(strFormName,'txtPercentageEfforts' + intCtr);
				if (objTemp != null)
					objTemp.disabled = false;	
				
				objTemp = GetObjectReference(strFormName,'txtOrderNumber' + intCtr);
				if (objTemp != null)
					objTemp.disabled = false;			
			}
		}
	}
	
	
	
	//////////////////////////////////////////////////////////////////
	
	//Added by ShraddhaM on Date 13 June,2006 for PMLifeLine Issue ID.4168

	
	function SelectAllCheck_OnClick(strFormName, strCheckbox,cnt)
	//Pass FormName and the Checkbox's ID
	{
	//alert('hi');
	var i=0;
	var strCheckbox1=strCheckbox;
	for(i=0;i<=cnt;i++)
	{
		//alert(strCheckbox);
		strCheckbox=strCheckbox+ i;
		//alert(strCheckbox);
		
		var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
		var intItems;
		var intCtr=0;
		var objTemp;
		
		//alert(objCheckbox + '0');
			
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
			
			//alert(intItems);
			
			/*if(intItems > 1) 
			{
			//alert('hi1');
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
				//objCheckbox=objCheckbox
					//alert('hi2');
					if (objCheckbox[intCtr].disabled == false)
					{
					//alert('hi3');
						objCheckbox[intCtr].checked = true;	
											
					}		
					
					objTemp = GetObjectReference(strFormName,'txtPercentageEfforts' + intCtr);
					if (objTemp != null)
						objTemp.disabled = false;
					
					objTemp = GetObjectReference(strFormName,'txtOrderNumber' + intCtr);
					if (objTemp != null)
						objTemp.disabled = false;
				}
			}*/
			// Else, if single element exists, then...
			//else
			 if(intItems == 1)
			{
				if (objCheckbox[0].disabled == false) 
					objCheckbox[0].checked = true;
															
				objTemp = GetObjectReference(strFormName,'txtPercentageEfforts' + intCtr);
				if (objTemp != null)
					objTemp.disabled = false;	
				
				objTemp = GetObjectReference(strFormName,'txtOrderNumber' + intCtr);
				if (objTemp != null)
					objTemp.disabled = false;			
			}
		}
		strCheckbox=strCheckbox1;
		}//end of for loop
	}
	//Ended by ShraddhaM on Date 13 June,2006 for PMLifeLine Issue ID.4168
	/////////////////////////////////////////////////////////////////

//------------------------------------------------------------------------------
//Purpose : Clear all check boxes
//------------------------------------------------------------------------------
	function ClearAll_OnClick(strFormName, strCheckbox)
	//Pass FormName and the Checkbox's ID
	{
		var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
		var intItems;
		var intCtr;
		var objTemp;
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
			 
					//alert(intItems);	
			if(intItems > 1) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].disabled == false)
						objCheckbox[intCtr].checked = false;	
						
								
						
					objTemp = GetObjectReference(strFormName,'txtPercentageEfforts' + intCtr);
					if (objTemp != null)
					{
						objTemp.value = 0;
						objTemp.disabled = true;
					}
					objTemp = GetObjectReference(strFormName,'txtOrderNumber' + intCtr);
					if (objTemp != null)
					{
						objTemp.value = 0;
						objTemp.disabled = true;			
					}
				}
			}
			// Else, if single element exists, then...
			else if(intItems == 1)
			{
				if (objCheckbox[0].disabled == false) 
					objCheckbox[0].checked = false;						
				
				objTemp = GetObjectReference(strFormName,'txtPercentageEfforts' + intCtr);
				if (objTemp != null)
					objTemp.disabled = true;			
				
				objTemp = GetObjectReference(strFormName,'txtOrderNumber' + intCtr);
				if (objTemp != null)
					objTemp.disabled = true;			
			}
		}
	
	}
	
	//////////////////////
	
	//Added by ShraddhaM on Date 13 June,2006 for PMLifeLine Issue ID.4168
	function ClearAllCheck_OnClick(strFormName, strCheckbox,cnt)
	//Pass FormName and the Checkbox's ID
	{
	
	//alert('hi');
	var i=0;
	var strCheckbox1=strCheckbox;
	for(i=0;i<=cnt;i++)
	{
		//alert(strCheckbox);
		strCheckbox=strCheckbox+ i;
		//alert(strCheckbox);
		
		var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
		var intItems;
		var intCtr;
		var objTemp;
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
			 
					//alert(intItems);	
			/*if(intItems > 1) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].disabled == false)
						objCheckbox[intCtr].checked = false;	
						
								
						
					objTemp = GetObjectReference(strFormName,'txtPercentageEfforts' + intCtr);
					if (objTemp != null)
					{
						objTemp.value = 0;
						objTemp.disabled = true;
					}
					objTemp = GetObjectReference(strFormName,'txtOrderNumber' + intCtr);
					if (objTemp != null)
					{
						objTemp.value = 0;
						objTemp.disabled = true;			
					}
				}
			}*/
			// Else, if single element exists, then...
			//else 
			if(intItems == 1)
			{
				if (objCheckbox[0].disabled == false) 
					objCheckbox[0].checked = false;						
				
				objTemp = GetObjectReference(strFormName,'txtPercentageEfforts' + intCtr);
				if (objTemp != null)
					objTemp.disabled = true;			
				
				objTemp = GetObjectReference(strFormName,'txtOrderNumber' + intCtr);
				if (objTemp != null)
					objTemp.disabled = true;			
			}
		}
		strCheckbox=strCheckbox1;
		}//end of for
	
	}
	//Ended by ShraddhaM on Date 13 June,2006 for PMLifeLine Issue ID.4168
	
	<%'Added By MahendraV On 4:45 PM 5/18/2007 for PMLifeLine'%> 
	<%'Note: jabascript sort mathod NOT sorted correctly (by numeric value). To'%>  
	<%'solve this problem, we must add a function that handles this problem:'%> 
	<%'Start_MV_5/18/2007'%> 
	function sortNumber(a,b)
	{
		return a - b
	}
	<%'End_MV_5/18/2007'%> 
	
	
	/////////////////////
	//added by HrshK for sp4 issueid 113
	
	function IsorderUnique()
	{	
		var objhdnCount = GetObjectReference('frmProjectType','txtCount');
		var index = 0;
			
		//Modified by ShraddhaM on Date 12 June,2006 for PMLifeLine Issue ID.4168
		//var intTot = parseInt((objhdnCount == "") ? "0" : objhdnCount);
		//Ended by ShraddhaM on Date 12 June,2006 for PMLifeLine Issue ID.4168
		
		<%'Added By MahendraV for PMLifeLine On 4:45 PM 5/18/2007'%>
		<%'I have added new code in place of old code.'%>
		<%'Old code was for checking unique phase order number'%>
		<%'New code is for checking phase order number should be in consecutive order and unique'%>
		<%'Start_MV_5/18/2007'%>
		
		var intTot = parseInt((objhdnCount.value == "") ? "0" : objhdnCount.value);
		var arrOrderNumber=new Array();
		var count=0;
		//Modified By VarunA on 10-June-2009 RequestID-21096
		//Purpose : In Configure Phases it wasn't taking the last column.
		//for (index=0; index < intTot - 1; index++)
		for (index=0; index < intTot; index++)
		//End By VarunA on 10-June-2009 RequestID-21096
		{
				var objChk = 	GetObjectReference('frmProjectType','chkParameter' + index);
				if(objChk != null)
				{
					if(objChk.checked == true)
					{
						arrOrderNumber[count]=GetObjectReference('frmProjectType','txtOrderNumber' + index).value;
						count++;
					}
				}
		}
		
		arrOrderNumber.sort(sortNumber);
		for(index=0; index < arrOrderNumber.length-1; index++)
		{
			if(arrOrderNumber.length==1)
			{
				if(arrOrderNumber[index]!=1)
				{
					alert("Phase order number should start with 1")
					return false;
				}
			}
			else
			{
				if(arrOrderNumber[0]!=1)
				{
					alert("Phase order number should start with 1");
					return false;
				}
				if((parseInt(arrOrderNumber[index])+1)!= parseInt(arrOrderNumber[index+1]))
				{
					alert("Phase order number should be in consecutive order");
					return false;
				}
				
			
			}
		
		}
		
		<% 'End_MV_5/18/2007 ' %>
		
		return true;
	}


		</script>
				 
	</body>
</HTML>
