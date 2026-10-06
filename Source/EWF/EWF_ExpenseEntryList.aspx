<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EWF_ExpenseEntryList.aspx.vb" Inherits="PbNIT.EWF_ExpenseEntryList" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("EWF_ExpenseEntryList")%>
  

<%--   Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade
  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added by Pradip P on 12 May 2021 for Allignment issue*/
.clsTable .clsTRMenu td a{ display:inline-block; vertical-align:middle;}
input:not([type=button]){margin-top:0;}
/*End of Added by Pradip P on 12 May 2021 for Allignment issue*/
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

	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		
					<form id="frmEWF" name="frmEWF" method="post" runat="server">
						
									<%PageInit%>
							
					</form>
				
					<SCRIPT language="javascript">
					    var objform = GetFormReference('frmEWF');
		  //Commented and added by Yogesh J on 09-OCT-2015
		//var objdivlist = GetObjectReference('frmEWF', 'PageDiv');
					    var objdivlist = GetObjectReference('frmEWF', 'DivMain');
	    //End of addition by Yogesh J  09-OCT-2015
		
		 <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
		   
			var intDivHeight ;
			var intDivHeightRisk;
			
			if (objdivlist != null) {
                //Commented and added by S J on 09-OCT-2015
                //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40 ;
			    // if (intDivHeight < 100)	intDivHeight = 100 ;
			    // objdivlist.style.height = intDivHeight ;	

			    if (WhichBrowser() == 'IE') {
                    
			        // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40 + 700;
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 47;//Added By Shamkant s on 15 Dec 2015 
			       
			        if (intDivHeight < 100) intDivHeight = 100 + "px";
			        objdivlist.style.height = intDivHeight + "px";
			      
			    }
			    else if (WhichBrowser() == 'CR') {
			       // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40 + 720;
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 47;//Added By Shamkant s on 15 Dec 2015 
			        if (intDivHeight < 100) intDivHeight = 100 + "px";
			        objdivlist.style.height = intDivHeight + "px";
			        
			    }
			    else {
			      //  intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40 + 695;
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 47;//Added By Shamkant s on 15 Dec 2015 
			        if (intDivHeight < 100) intDivHeight = 100 + "px";
			        objdivlist.style.height = intDivHeight + "px";
			      
			    }
			}
			    //End of addition by Yogesh J  09-OCT-2015
		}  
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			   // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 47;//Added By Shamkant s on 15 Dec 2015 
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		
	  //Added by Yogesh J on 09-OCT-2015
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
        //End of Addition by Yogesh J on 09-OCT-2015
		function Edit_OnClick(ExpensesEntryID,strPKToken)
		{
		var objtxtDate = GetObjectReference('frmEWF','txtDate');
		//var strPKToken="<%=m_strPKToken_Expense_EntryList%>"
		//'Modified By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
		window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=EDIT&MasterTagID=3556&ExpensesEntryID="+ ExpensesEntryID + "&PkToken=" + strPKToken + "&txtDate=" + objtxtDate.value ,"Expense" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");
		//'Ended By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
		}
		
		function Expenses_OnClick(strPkToken)
		{
		//Modified by MrugajaB on Date 3rd July 2006 for WhizibleSEM Issue ID.4168
		//var objtxtDate = GetObjectReference('frmEWF','txtdate');
		var objtxtDate = GetObjectReference('frmEWF','txtDate');
		//End Modification
		////////////window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=ADD_NEW&MasterTagID=3556&PkToken=" + strPkToken + "&txtDate=" + objtxtDate.value ,"Expense" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");
		    //"resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=720,height=420"

		//Added by Dhanashri S on 1 April 2016 for to generate and validate Token
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    contentType: 'application/json',
		    url: 'EWF_ExpenseEntryList.aspx/GenrateExpensesToken',
		    data: JSON.stringify({ txtDate: objtxtDate.value }),
		            success: function (Result) {
		                window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=ADD_NEW&MasterTagID=3556&PkToken=" + strPkToken + "&txtDate=" + objtxtDate.value + "&PKExpensesToken=" + "<%=m_strPKToken_Expense_EntryList_ForADDNEW%>" , "Expense", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 720) / 2 + ",top=" + (window.screen.height - 420) / 2 + ",width=700,height=375");
		            },
		            error: function () {
		                alert("Error")
		            }
		        });

		    //End of addition by Dhanashri S on 1 April 2016
		}
				
		function Delete_OnClick()
			{
			var objDelete = GetObjectReference('frmEWF','chkDelete',1);
			var blnIsRecordSelected = false;
		
			for(intCnt = 0;intCnt<objDelete.length;intCnt++)
			{ 
				/*if (objform.chkDelete[intCnt].checked == true )*/
				if (objDelete[intCnt].checked == true )
				{blnIsRecordSelected = true; break;}
			}

			if (blnIsRecordSelected == false) { return;} 
				//if (window.confirm('<%=MyBase.GetResourceString("VALIDATE_DELETE")%>') == true)
				if (window.confirm('Are you sure you want to delete this Expense Entry?') == true)
				{
					objform.action = "../EWF/EWF_ExpenseEntryList.aspx?Action=Delete";
					objform.submit();
				}
			}

			function callcalendar(formname,datefield)
			{
				var objdateObject=GetObjectReference(formname,datefield)
				var dtval;
				if(objdateObject.value =='')
					dtval='None';
				else
					dtval=objdateObject.value;
				calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield +'&formname=' + formname + '&dateval=' + dtval + '&FromWhere=EWFLIST','calendar_window','top=0,left=0,width=348,height=260');calendar_window.focus();
			}		
			
			//***** Code Added by SandipL on 2 Dec 2005 -- To solve refresh problem due to editable Date Control 	
			function change_date(e)
			{
			  var keynum
			  if(window.event) // IE
	          {
	               keynum = e.keyCode
			   }
			else if(e.which) // Netscape/Firefox/Opera
			 {
			   keynum = e.which
			 }
            if (keynum==13)
            {
		         window.focus()
	         }
           }
		//***** End addition by SandipL on 2 dec 2005	
			
			//Code Added By SantoshK on 22 May 2006
			//Expenses Entry Tabular View - Bristlecone Customization
			function WeeklyView_OnClick()
			{
			   

				//Modified by SantoshK on 5 july 2006 for Mozilla support
				//Changed txtdate to txtDate
				var objtxtDate = GetObjectReference('frmEWF','txtDate');
				//Modification ends by SantoshK on 5 July 2006
				window.location.href = "EWF_WeeklyView.aspx?txtDate=" + objtxtDate.value;
			}
			//Addition ends by SantoshK on 22 may 2006	
		
					</SCRIPT>
				</TD>
			</TR>
		</TABLE>
	</body>
</HTML>
