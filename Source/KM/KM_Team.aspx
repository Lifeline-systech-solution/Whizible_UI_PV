<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_Team.aspx.vb" Inherits="PbNIT.KM_Team"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML >
	<%WritePageHead%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>


<%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 16/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 16/12/2015
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

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmKMTeam" method="post" runat="server">
					
									<%WritePage%>
								
					</form>
				
					<script>
		
	objForm = GetFormReference('frmKMTeam');
	objdivMain = GetObjectReference('frmKMTeam', 'divMain');
	objchkEdit = GetObjectReference('frmKMTeam','chkEdit');	
	objchkView = GetObjectReference('frmKMTeam','chkView');	
	objtxtTitle = GetObjectReference('frmKMTeam','txtTitle');
	objtxtDescription = GetObjectReference('frmKMMySpace','txtDescription');
	
	<%' Added By SonalD on 15th Jan 2009 %>
    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
    <%End If%>
    <%' Added By SonalD on 15th Jan 2009 %>

	
	function window_onload()
	{	
	   
		var intDivHeight ;
		if(objdivMain)
		{
		    
            //Commented added by Shamkant S on 24 Nov 2015
			//if(navigator.appName == 'Netscape')
			//{
			//	intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35 ;
			//}
			//if (WhichBrowser() == 'IE')
		    //{
		    //	intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35 + 370;
			//}
			//else if (WhichBrowser() == 'FF') {
			//    intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35 + 355;
			//}
			//else if (WhichBrowser() == 'CR') {
			//    intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35 + 360;
			//}
			//else
			//{
			//    intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35 + 370;
		    //}
		    intDivHeight = window.innerHeight - objdivMain.offsetTop - 35;
            //Commented ended by Shamkant s on 24 Nov 2015
			if (intDivHeight < 100) intDivHeight = 100;
		    //objdivMain.style.height = intDivHeight;
			objdivMain.style.height = intDivHeight + 'px';
			
		}
		if (objchkView)
		{
			ShowHideTr('tr_ViewUsers',objchkView)	
		}
		if (objchkEdit)
		{
		ShowHideTr('tr_EditUsers',objchkEdit)	
		}
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
	function window_onresize()		
	{
		var intDivHeight;
		if(objdivMain)
		{
		    //intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35;
		    intDivHeight = window.innerHeight - objdivMain.offsetTop - 35;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivMain.style.height = intDivHeight +'px';
		}
	}
	
	function Save_OnClick()
	{
	    //debugger;
	    var objtxtPK=GetObjectReference('frmKMTeam','txtPK').value;
	    //var objhidTeamName=GetObjectReference('frmKMMyPage','hidTeamName').value;
	    
		if (disallowBlank(objtxtTitle,"Team Name should not be left blank"))return;
		if (disallowBlank(objtxtDescription,"Description should not be left blank"))return;
		if (disallowMaxlengthViolation(objtxtTitle,50,"Team Name should not exceed 50 characters.")) return;
		if (disallowMaxlengthViolation(objtxtDescription,1000,"Description should not exceed 1000 characters.")) return;
		if ((GetObjectReference('frmKMTeam','chkEdit').checked == true && GetObjectReference('frmKMTeam','txtEditUsers').value=='') || (GetObjectReference('frmKMTeam','chkView').checked == true && GetObjectReference('frmKMTeam','txtViewUsers').value=='') || (GetObjectReference('frmKMTeam','chkEdit').checked == true && GetObjectReference('frmKMTeam','txtEditUsers').value=='' && GetObjectReference('frmKMTeam','chkView').checked == true && GetObjectReference('frmKMTeam','txtViewUsers').value==''))
		{
		    alert('Please select atleast one user.');
		    return;
        }


       <%-- var objhidTeamName = "<%=strTeamNameDB %>"--%>
        //Added  By Usha P On 1july 2020 For Javascript
        var objhidTeamName = '<%=strTeamNameDB.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n").Replace(" ", String.Empty).Replace("\n", Environment.NewLine).Replace(vbCr, "").Replace(vbLf, "") %>';
        //Added  By Usha P On 1july 2020 For Javascript
     
        
		if(objhidTeamName.indexOf(','+Trim(objtxtTitle.value)+',')>=0 && '<%=strflag%>' == '1')
	     {
	        alert('Team "' + objtxtTitle.value + '" already created.');
         // Commented By Rutuja D. on 30 March 2020 For Issueid = 23165
	        //objtxtTitle.value='';
	        //objtxtDescription.value='';
         //End Commented By Rutuja D. on 30 March 2020 For Issueid = 23165

            objtxtTitle.focus();
	        return;
	     }
	     else
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

		        objForm.action = "KM_Team.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Mode=<%=m_strMode%>&Action=SAVE";
		        objForm.submit();	
        		
            //Commented By Vaijat K ON 24/11/2015 Issue ID-2149
	            //if(objtxtPK!='')
	            //{
                 // if(window.opener != null )  		    
                 // {
	               // if( window.opener.opener != null )
	                //{
        		        
	                   // window.opener.opener.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Tab=MY&Subtab=MY TEAMS";
	                    //window.opener.frmCommonList.action="CommonList.aspx?MasterTagID=20040";
	                    //window.opener.frmCommonList.action="CommonList.aspx?MasterTagID=3961";
	                    //window.opener.frmCommonList.submit();

	                    //Commented and added by Yogesh J on 11-Nov-2015
	                    //window.opener.document.forms[0].action = "CommonList.aspx?MasterTagID=3961";
	                    //window.opener.document.forms[0].action = "../General/CommonList.aspx?MasterTagID=3961";
                        //End of comment and addition by Yogesh J on 11-Nov-2015
	                   // window.opener.document.forms[0].submit();
	                   // window.close();
	               // }
	               // else
	               // {   
	                //    if('<%=m_strFrom%>'=='Home')
	               //       {       
	                            
	                   //        window.opener.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Tab=HOME&txtSearch="+window.opener.document.getElementById('txtSearch').value;
	                //      }
	                 //   else
	                   //   {    
	                   //        window.opener.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Tab=MY&Subtab=MY TEAMS";
	                   //   }
	                    //window.close();
	                //}
                 // }  		        
	           // }
	           // else
	           // {		
	           //     //window.opener.frmKMList.submit();
                 // if(window.opener != null )  		    
                //  {		 
                       
	              //  window.opener.document.forms[0].submit();
		          //} 
	            //}
	       }
    }
    
	function validateHeaderSection()
	{
	    
		if (disallowBlank(objtxtTitle,"Title should not be left blank"))return;
		if (disallowBlank(objtxtDescription,"Description should not be left blank"))return;
		
	}
	
	function UserSelection_Onclick(strMode)
	{
			objtxtViewUserIDs = GetObjectReference('frmKMTeam','txtViewUserIDs');
			objtxtEditUserIDs = GetObjectReference('frmKMTeam','txtEditUserIDs');
			
		if (strMode == "View")
		{
		    //Commented and added by Yogesh J on 10-Nov-2015
			//window.open("KM_EmployeeSelection.aspx?UsersTextBox=txtViewUsers&UserIDsTextBox=txtViewUserIDs&FormName=frmKMTeam&UserIDs=" +objtxtViewUserIDs.value ,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=850,height=400");
			window.open("KM_EmployeeSelection.aspx?UsersTextBox=txtViewUsers&UserIDsTextBox=txtViewUserIDs&FormName=frmKMTeam&UserIDs=" + objtxtViewUserIDs.value, "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 850) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=850,height=500");
            //End of addition by Yogesh J on 10-Nov-2015
		}
		else
		{
            //Commented and added by Yogesh J on 10-Nov-2015
		    //window.open("KM_EmployeeSelection.aspx?UsersTextBox=txtEditUsers&UserIDsTextBox=txtEditUserIDs&FormName=frmKMTeam&UserIDs=" + objtxtEditUserIDs.value, "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 850) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=850,height=400");
		    window.open("KM_EmployeeSelection.aspx?UsersTextBox=txtEditUsers&UserIDsTextBox=txtEditUserIDs&FormName=frmKMTeam&UserIDs=" + objtxtEditUserIDs.value, "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 850) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=850,height=500");
		    //End of addition by Yogesh J on 10-Nov-2015
		}	
	}
	
	function ShowHideTr(strTrName,objCheckBox)
	{
	
		objTr = GetObjectReference('frmKMTeam',strTrName);
		if (objCheckBox.checked == true)
		objTr.style.display = ""
		else
		objTr.style.display = "None"
		 	
	}
	
	function AddSpace_OnClick(strFrom)
	{
	    
	    //window.open("KM_SpaceListing.aspx?PageNumber=<%=m_strPagingNumber %>&From=" + strFrom + "&txtSearch=<%=m_strtxtSearch %>&TeamID=<%=m_intTeamID%>", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");	
	    //Added By Chakshuta H on 11th-Aug-2016  to generate and validate Token
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'KM_Team.aspx/GenrateAddSpaceToken',
	        data: JSON.stringify({ TeamID: "<%=m_intTeamID%>", EmployeeID: "<%=Session("intUserID")%>" }),
           success: function (Result) {

               //window.open("../../Source/KM/KM_ArticleRating.aspx?From=<%=m_strFromWhere%>&PKToken=" + Result.d + "&ProcedureID=" + ArticleID + "", null, "resizable=no,scrollbars=yes,left=" + (window.screen.width - 400) / 2 + ",top=" + (window.screen.height - 290) / 2 + ",width=400,height=290");
               window.open("KM_SpaceListing.aspx?PageNumber=<%=m_strPagingNumber %>&From=" + strFrom + "&txtSearch=<%=m_strtxtSearch %>&TeamID=<%=m_intTeamID%>&PkToken="+ Result.d +"", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");	
		        },
		        error: function () {
		            //   alert("Error")
		        }
       });

	    //End of Added By Chakshuta H on 11th-Aug-2016
				
	}
	
	function DeleteSpace_OnClick()
	{
		var blnIsRecordSelected=false;
		blnIsRecordSelected=IsCheckboxSelected('frmKMTeam','chkDelete')
		if (blnIsRecordSelected == false) { alert("Please select atleast one Space to delete.");return;}
		
		if (confirm("Are you sure you want to delete the Spaces?")==true)
		{
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
		    objForm.action = "KM_Team.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Action=DELETE_SPACES&TeamID=<%=m_intTeamID%>";
		    objForm.submit();	
		}
		//window.opener.location.href = window.opener.location.href;    
		//window.close();
	}
	
	//Addition by SuchitraP on 3 July 2008
	function Space_OnClick(SpaceID,strMode,TeamID)
	{

	    //Added by Dhanashri S on 29 Mar 2016 Purpose: To generate and validate Token
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'KM_Team.aspx/GenrateSpaceToken',
	        data: JSON.stringify({ SpaceID: SpaceID, TeamID: TeamID, EmployeeId: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            //window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID + "&PKCommentToken=" + Result.d + "&Fromwhere=Discussion&PKToken=" + strToken, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=525");
	                if(TeamID==0)
	                {
	                    if('<%=m_strFromWhere %>' != '' && '<%=m_strFrom %>' == '')
	                        window.open("KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Mode=" + strMode + "&TeamID=" + TeamID + "&SpaceID=" + SpaceID + "&PKToken=" + Result.d, "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
	                    else if('<%=m_strFrom %>' != '' && '<%=m_strFromWhere %>' == '')
	                        window.open("KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Mode=" + strMode + "&TeamID=" + TeamID + "&SpaceID=" + SpaceID + "&PKToken=" + Result.d, "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
	                }
	                else
	                {
	                    //window.location.href="KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Subtab=MY TEAM&From=Manage&TeamID="+TeamID+"&Mode="+strMode+"&SpaceID=" + SpaceID,"","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650";
	                    if('<%=m_strFromWhere %>' != '' && '<%=m_strFrom %>' == '')
	                        window.open("KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Subtab=MY TEAM&From=Manage&TeamID=" + TeamID + "&Mode=" + strMode + "&SpaceID=" + SpaceID + "&PKToken=" + Result.d, "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
	                    else if('<%=m_strFrom %>' != '' && '<%=m_strFromWhere %>' == '')    
	                        window.open("KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Subtab=MY TEAM&From=Manage&TeamID=" + TeamID + "&Mode=" + strMode + "&SpaceID=" + SpaceID + "&PKToken=" + Result.d, "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
	                }
	        },
	        error: function () {
	             //alert("Error")
	        }
	    });

	    //End of addition by Dhanashri S on 29 Mar 2016
	}
	//End by SuchitraP
	
	//Addition by SuchitraP on 25-Aug-2008 for Adding New Space under MyTeam
	function AddNewSpace_OnClick()
	{
	    //debugger;
	    
	    //if('<%=m_strFromWhere %>' != '' && '<%=m_strFrom %>' == '')
	    //    window.open("KM_MySpace.aspx?Myflag=1&Flag=1&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Mode=ADD_NEW&TeamID=<%=m_intTeamID%>","","resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");
	    //else if('<%=m_strFrom %>' != '' && '<%=m_strFromWhere %>' == '')
	    //    window.open("KM_MySpace.aspx?Myflag=1&Flag=1&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Mode=ADD_NEW&TeamID=<%=m_intTeamID%>", "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");



	    //Added by Dhanashri S on 29 Mar 2016 Purpose: To generate and validate Token
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'KM_Team.aspx/GenrateAddNewSpaceToken',
	        data: JSON.stringify({ TeamID: "<%=m_intTeamID%>", EmployeeId: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            
	            //window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID + "&PKCommentToken=" + Result.d + "&Fromwhere=Discussion&PKToken=" + strToken, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=525");
	            if ('<%=m_strFromWhere %>' != '' && '<%=m_strFrom %>' == '')
	                window.open("KM_MySpace.aspx?Myflag=1&Flag=1&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Mode=ADD_NEW&TeamID=<%=m_intTeamID%>&Pktoken="+ Result.d + "", "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
	             else if ('<%=m_strFrom %>' != '' && '<%=m_strFromWhere %>' == '')
	                 window.open("KM_MySpace.aspx?Myflag=1&Flag=1&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFrom %>&Mode=ADD_NEW&TeamID=<%=m_intTeamID%>&Pktoken=" + Result.d + "", "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
	        },
	        error: function () {
	            alert("Error")
	        }
	    });

	    //End of addition by Dhanashri S on 29 Mar 2016
	    
	}
	//End by SuchitraP
	
	//Added by SuchitraP on 30-Sep-2008 for IssueID 22958
    //If User want to Edit another Space after editing previous space window had to be closed initially
	function Back_OnClick(strFrom)
	{
	   
	    if(strFrom == 'Search')
	    {
	        if('<%=m_strActionLink %>'=='More')
	        {
	            window.location.href="../Km/KM_List.aspx?Action=More&Tab=HOME&From=Teams&FromWhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>";
	        }
	        else
	        {   
	            window.location.href="../Km/Km_List.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&SelectList=3&txtSearch=<%=m_strtxtSearch %>";
	        }
	    }
        else if (strFrom == 'LatestFeatured')
	    {
          window.location.href="../Km/Km_List.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&SelectList=3&txtSearch=<%=m_strtxtSearch %>";
	    }	    
	    else
	    {   
	        window.location.href="../KM/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&Tab=MY&Subtab=MY TEAMS&SelectList=6&txtSearch=<%=m_strtxtSearch %>";
	    }
	    
	}
	//End by SuchitraP
	
	</script>
				
	</body>
</HTML>
