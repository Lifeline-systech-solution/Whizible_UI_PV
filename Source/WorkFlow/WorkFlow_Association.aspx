<%@ Page Language="vb" AutoEventWireup="false" Codebehind="WorkFlow_Association.aspx.vb" Inherits="PbNIT.WorkFlow_Association"%>
<!DOCTYPE HTML>
<HTML>
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<% CommonFunctions.General.PlotPageHeadTag(MYBASE.GETRESOURCESTRING("PAGE_HEADER"))%>
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>  -->

<script src="../../responsive/responsive.js"></script>

    <head>
        <style type="text/css">
            .footerMenuTable {
           
            position:relative;
            }
         </style>
       
    </head>
   <%-- End Code added by Shamkant S on 12-Oct-2015--%>
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmWorkFlow_Association" method="post" runat="server">
					
									<%PageInit%>
						
					</form>
			
					<Script language="javascript">
		var objform=GetFormReference('frmWorkFlow_Association');
		var objdivlist = GetObjectReference('frmWorkFlow_Association', 'DivList');
		var ObjChkCorporateSelect = GetObjectReference('frmWorkFlow_Association','chkCorporateSelect',true);
		var ObjChkProjectSelect = GetObjectReference('frmWorkFlow_Association','chkProjectSelect',true);
		var ObjChkUnCheckedSelect = GetObjectReference('frmWorkFlow_Association','HDN_TXT_UNCHEKED');
		var objdivSubmit=GetObjectReference('frmWorkFlow_Association','divItem_SYS_SUBMIT')
		var objdivApprove=GetObjectReference('frmWorkFlow_Association','divItem_SYS_APPROVE')
		var objdivReject=GetObjectReference('frmWorkFlow_Association','divItem_SYS_REJECT')
		var objASubmit=GetObjectReference('frmWorkFlow_Association','hrf_Submit');
		var objAApprove=GetObjectReference('frmWorkFlow_Association','hrf_Approve');
		var objAReject=GetObjectReference('frmWorkFlow_Association','hrf_Reject');
		
		var objchkMsgIDs=GetObjectReference('frmWorkFlow_Association','chkMsgIDs',true);
		
			
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>

			 
		
		
		if(objdivSubmit!=null)
				objdivSubmit.style.display='block';
		if(objASubmit!=null)
				objASubmit.className='clsTabSelected';
						 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist != null)
			{
				//if (navigator.appName=="Netscape") 
				//{
				//	intDivHeight = (window.innerHeight - objdivlist.offsetTop - 10) + 604;
				//}
				//else
				//{  
				//	intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 10) + 604;
					
			    //}
			    // Added By Vidya J on 16 Nov 2015
			    if(WhichBrowser() == 'IE')
			    {
			        intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 579 ;
			        
			    }
			    else
			        if(WhichBrowser() == 'CR')
			        {
			            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 488;
			            
			        }
			        else
			            if(WhichBrowser() == 'FF')
			            {
			                intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 0) + 0;
			
			            }
			    //End of Added  by Vidya J on 16 Nov 2015
			    if (intDivHeight < 100)	intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + "px";
            }

				//objdivlist.style.height=intDivHeight;
			 
		}
					    // Added By Vidya J on 16 Nov 2015
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
		//End of Comment  by Vidya J on 16 Nov 2015
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = (window.innerHeight - objdivlist.offsetTop - 10) + 579;
				}
				else
				{  
					intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 10) + 488;
				}
				
				objdivlist.style.height=intDivHeight;
			}
		}	
		function Save_OnClick()
		{
			var URL;
			if("<%=m_strOperation%>"!="EDIT")
			{ 
			EnabledOrDesabledControl(false);
			URL="WorkFlow_Association.aspx?ActionMode=SAVE";
			}
			else
			{
				if(!validateControl()) return;
				var objchkActive=GetObjectReference('','chkActive');
				
				if (objchkActive!=null)
					objchkActive.disabled=false;
				
				URL="WorkFlow_Association.aspx?ActionMode=SAVE";
			}
			objform.action=URL;
			objform.submit();

		
		}
		/*<Summary>
				Author	:	PrashantSJ.
				Date	:	8th May 2008
				Purpose	:	Email Message releated functions.		
		</Summary>
		*/
		function validateControl()
		{
			for(i=0;i<=objchkMsgIDs.length-1;i++)
			{
				
				var objtASubject=GetObjectReference('','txtASubject'+String(objchkMsgIDs[i].value));
				var objtABody=GetObjectReference('','txtABody'+String(objchkMsgIDs[i].value));
				var objtAPurpose=GetObjectReference('','txtAPurpose'+String(objchkMsgIDs[i].value));
				var objtAComments=GetObjectReference('','txtAComments'+String(objchkMsgIDs[i].value));
				
					if(disallowBlank(objtASubject,'<%=MyBase.GetResourceString("MSG_BLANKSUBJECT")%>',true))
						return false;
					if(disallowBlank(objtABody,'<%=MyBase.GetResourceString("MSG_BLANKBODY")%>',true))
						return false;
					if(disallowMaxlengthViolation(objtASubject,100,replaceSubstring('<%=MyBase.GetResourceString("MSG_MAXLENSUBJECT")%>','<MAX_LEN>','100'),true))
						return false;
					if(disallowMaxlengthViolation(objtABody,4000,replaceSubstring('<%=MyBase.GetResourceString("MSG_MAXLENBODY")%>','<MAX_LEN>','4000'),true))
						return false;
					if(disallowMaxlengthViolation(objtAPurpose,100,replaceSubstring('<%=MyBase.GetResourceString("MSG_MAXLENPURPOSE")%>','<MAX_LEN>','100'),true))
						return false;
					if(disallowMaxlengthViolation(objtAComments,500,replaceSubstring('<%=MyBase.GetResourceString("MSG_MAXLENCOMMENTS")%>','<MAX_LEN>','500'),true))
						return false;					
			}
			return true;
		}
		function EnabledOrDesabledControl(EnabledOrDisabled)
		{
			var i=0;
			
			if (ObjChkCorporateSelect!=null){
				for(i=0;i<ObjChkCorporateSelect.length;i++){
					if (ObjChkCorporateSelect[i].disabled){
						ObjChkCorporateSelect[i].disabled = EnabledOrDisabled;
					}
				}
			}
			
			if (ObjChkProjectSelect!=null){
				ObjChkUnCheckedSelect.value = '';
				for(i=0;i<ObjChkProjectSelect.length;i++){
					if (ObjChkProjectSelect[i].disabled){
						ObjChkProjectSelect[i].disabled = EnabledOrDisabled;
					}
					if (ObjChkProjectSelect[i].checked==false){
						ObjChkUnCheckedSelect.value = ObjChkUnCheckedSelect.value + ObjChkProjectSelect[i].value+",";
					}
				}
			}
			
		
		}
		function Entity_OnClick(Entity,AttributeID)
		{
			//window.open("../DM/WorkFlow_Association.aspx?Mode=Corporate&FromWhere=PRO&Operation=EDIT&AttributeID="+AttributeID ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-400)/2 + ",width=800,height=400");
			window.location.href =  "../DM/WorkFlow_Association.aspx?Mode=Corporate&FromWhere=PRO&Operation=EDIT&AttributeID="+AttributeID+"&Attribute="+Entity;
		}
		function Back_OnClick()
		{
				window.location.href= "../DM/WorkFlow_Association.aspx?Mode=Corporate&FromWhere=PRO&Operation=&MasterTagID=3930";
		}
		function TabOnClick(TabID)
		{
				switch (TabID)
				{
					case 1 :
						if(objdivSubmit!=null)
							objdivSubmit.style.display='block';
						if(objdivApprove!=null)	
							objdivApprove.style.display='none';
						if(objdivReject!=null)	
							objdivReject.style.display='none';
							
						if(objASubmit!=null)
							objASubmit.className='clsTabSelected';
						if(objAApprove!=null)
							objAApprove.className='navtab';	
						if(objAReject!=null)
							objAReject.className='navtab';
									
						break;
					case 2 :
						if(objdivSubmit!=null)
							objdivSubmit.style.display='none';
						if(objdivApprove!=null)	
							objdivApprove.style.display='block';
						if(objdivReject!=null)	
							objdivReject.style.display='none';
							
						if(objASubmit!=null)
							objASubmit.className='navtab';
						if(objAApprove!=null)
							objAApprove.className='clsTabSelected';	
						if(objAReject!=null)
							objAReject.className='navtab';
							
						break;
					case 3 :
						if(objdivSubmit!=null)
							objdivSubmit.style.display='none';
						if(objdivApprove!=null)	
							objdivApprove.style.display='none';
						if(objdivReject!=null)	
							objdivReject.style.display='block';
							
						if(objASubmit!=null)
							objASubmit.className='navtab';
						if(objAApprove!=null)
							objAApprove.className='navtab';	
						if(objAReject!=null)
							objAReject.className='clsTabSelected';	
						break;				
				
				}
				
					
		}
		function Append_OnClick(ColumnName,MsgID)
		{
				var objtxtACN=GetObjectReference('','txtA'+ColumnName+String(MsgID))
				//Commentted and modified by SuchitraP on 16-Sep-2008 to identify Field combo
				//var objcboCN=GetObjectReference('','cboField'+String(MsgID))
				var objcboCN;
				if(ColumnName=='Subject')
				{
				    objcboCN=GetObjectReference('','cboField_Subject'+String(MsgID))
				}
				else
				{
				    objcboCN=GetObjectReference('','cboField_Body'+String(MsgID))
				}
			    //End by SuchitraP
			    
				var strAttribute;
				
				if(objcboCN!=null)
					strAttribute = objcboCN.value;
					
				if(objtxtACN!=null)	
					objtxtACN.value= objtxtACN.value + "  <" + strAttribute + ">";
					
				
		}
	//End of addition by PrashantSJ on 08th May 2008.
	
					</Script>
				
	</body>
</HTML>
