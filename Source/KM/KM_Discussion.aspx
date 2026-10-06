<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_Discussion.aspx.vb" Inherits="PbNIT.KM_Discussion"%>

<!DOCTYPE HTML>
<html>
  <%WritePageHead%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
   

       <%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>




<script src="../../responsive/responsive.js"></script>
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

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()" >
    <form id="frmKMDiscussion" name="frmKMDiscussion" method="post" runat="server">
		<%PageInit()%>
    </form>
    </body>
    <script language="javascript">
			var objdivlist;
			var objform;
			
			objform = GetFormReference('frmKMDiscussion');
			objdivlist = GetObjectReference('frmKMDiscussion','DivBody');
			
			function window_onload()		
			{
                    
				var intDivHeight ;
				var intDivHeightRisk;
				var browser = isIE();
				var mode = getParameterByName("Mode");
				//Commented and Added By Bharat To on 30th-Nov-2015
				//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				//if (navigator.appName == 'Netscape') {
				//    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			    //}
				if (browser == 'IE')
				{
				    if (mode == 'HISTORY')
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 22;
				    else
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 13;

				}
				else if (browser == 'FF')
				{
				    if (mode == 'HISTORY')
                        //Commented and Added by Dhanashri S on 3 Dec 2015 for IssueID:2573
				        //intDivHeight = window.innerHeight - objdivlist.offsetTop - 41;
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 21;
                        //End of Addition by Dhanashri S on 3 Dec 2015
				    else
                        //Commented and Added by Dhanashri S on 3 Dec 2015 for IssueID = 2573
				        //intDivHeight = window.innerHeight - objdivlist.offsetTop - 32;
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 12;
                       //End of Comment and Addition by Dhanashri S
				}
				else
				{
				    if (mode == 'HISTORY')
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 22;
				    else
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 13;
				}
			    //End of Commented and Added By Bharat To on 30th-Nov-2015
				
				if (intDivHeight < 100)
				intDivHeight = 100;


				objdivlist.style.height = intDivHeight + 'px'	;	
				
				var objtxtComments = GetObjectReference('frmKMDiscussion','txtComments');	
				if(objtxtComments)
				{	
					if(objtxtComments!=null || objtxtComments!='')
						objtxtComments.focus();
				}
					
				var dt=new Date(); 
				var hr=dt.getHours();
				var min=dt.getMinutes();			
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var mode = getParameterByName("Mode");
			    //Commented and Added By Bharat To on 30th-Nov-2015
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				var browser = isIE();
				if (browser == 'IE') {
				    if (mode == 'HISTORY')
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 22;
				    else
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 13;

				}
				else if (browser == 'FF') {
				    if (mode == 'HISTORY')
				        //Commented and Added by Dhanashri S on 3 Dec 2015 for IssueID:2573
				        //intDivHeight = window.innerHeight - objdivlist.offsetTop - 41;
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 21;
				        //End of Addition by Dhanashri S on 3 Dec 2015
				    else
				        //Commented and Added by Dhanashri S on 3 Dec 2015 for IssueID = 2573
				        //intDivHeight = window.innerHeight - objdivlist.offsetTop - 32;
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 12;
				    //End of Comment and Addition by Dhanashri S
				}
				else {
				    if (mode == 'HISTORY')
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 22;
				    else
				        intDivHeight = window.innerHeight - objdivlist.offsetTop - 13;
				}
			    //End of Commented and Added By Bharat To on 30th-Nov-2015
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight+'px'	;	
				var objTxt;
				objTxt = GetObjectReference('frmKMDiscussion','txtComments');
				if(objTxt)
				{
					if(objTxt!=null)
						objTxt.focus();
				}
			}
			
			
			function Save_OnClick()
			{
				var objTxt,strVal;
				var intLength,flag;
				
				objTxt = GetObjectReference('frmKMDiscussion','txtComments');
				flag = disallowBlank(objTxt,'Comments cannot be left blank.',true);
				if(flag==true)
					return;
				
				flag = disallowMaxlengthViolation(objTxt,7000,'Comments cannot be more than 7000 characters.',true);
				if(flag==true)
					return;
				
				
				if(flag==false)
				{			
				    objform.action = "KM_Discussion.aspx?Mode=<%=m_strMode%>&Action=SAVE&ProcedureID=<%=m_lngProcedureID%>&Fromwhere=<%=m_FromWhere%>";																				
					objform.submit();
						
				}
				//commented by AbhijeetCon 11 Nov 09
				//window.close();
				//End of comment by AbhijeetCon 11 Nov 09
			}
			
			function Version_OnClick(inProcedureID,intVersionID)
			{
				
				//commented and added by RohiniK on 10 Nov 09
				////objform.action = "KM_Discussion.aspx?Mode=EditHistory&ProcedureID="+inProcedureID+"&PKToken=<%=m_strToken%>";
				//window.open("../KM/KM_MyPage.aspx?Action=History&ActionLink=&PageNumber=&SpaceID=&Mode=view&Myflag=2&Fromwhere=&VersionID="+intVersionID+"&PageID="+inProcedureID,"_self","resizable=yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");																				

				var op = window.opener.location.href;

				if (op.indexOf("MasterTagID=3992") > -1) {
                    //Commented and added by bharat tekade on 2nd-feb-2016
				    //window.open("../KM/KM_MyPage.aspx?From=KA&Action=History&ActionLink=&PageNumber=&SpaceID=&Mode=view&Myflag=2&Fromwhere=&VersionID="+intVersionID+"&PageID="+inProcedureID,"_self","resizable=yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");																				
				    //window.location.href = "../KM/KM_MyPage.aspx?From=KA&Action=History&ActionLink=&PageNumber=&SpaceID=&Mode=view&Myflag=2&Fromwhere=&VersionID=" + intVersionID + "&PageID=" + inProcedureID;
				    //Added By Chakshuta H on 11th-Aug-2016  to generate and validate Token
				    $.ajax({
				        type: 'POST',
				        dataType: 'json',
				        contentType: 'application/json',
				        url: 'KM_Discussion.aspx/GenrateVersionToken',
				        data: JSON.stringify({ VersionID: intVersionID, PageID: inProcedureID, EmployeeId: "<%=Session("intUserID")%>" }),
                        success: function (Result) {

                            window.location.href = "../KM/KM_MyPage.aspx?From=KA&Action=History&ActionLink=&PageNumber=&SpaceID=&Mode=view&Myflag=2&Fromwhere=&VersionID=" + intVersionID + "&PageID=" + inProcedureID +"&PKToken="+Result.d;
                        },
                        error: function () {
                            //   alert("Error")
                        }
                    });

				    //End of Added By Chakshuta H on 11th-Aug-2016
				    
				}
				else {
				    //window.open("../KM/KM_MyPage.aspx?From=&Action=History&ActionLink=&PageNumber=&SpaceID=&Mode=view&Myflag=2&Fromwhere=&VersionID=" + intVersionID + "&PageID=" + inProcedureID, "_self", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 750) / 2 + ",width=900,height=750");
				    //window.location.href = "../KM/KM_MyPage.aspx?From=&Action=History&ActionLink=&PageNumber=&SpaceID=&Mode=view&Myflag=2&Fromwhere=&VersionID=" + intVersionID + "&PageID=" + inProcedureID;
				    //Added By Chakshuta H on 11th-Aug-2016  to generate and validate Token
				    $.ajax({
				        type: 'POST',
				        dataType: 'json',
				        contentType: 'application/json',
				        url: 'KM_Discussion.aspx/GenrateVersionToken',
				        data: JSON.stringify({ VersionID: intVersionID, PageID: inProcedureID, EmployeeId: "<%=Session("intUserID")%>" }),
				        success: function (Result) {

				            window.location.href = "../KM/KM_MyPage.aspx?From=&Action=History&ActionLink=&PageNumber=&SpaceID=&Mode=view&Myflag=2&Fromwhere=&VersionID=" + intVersionID + "&PageID=" + inProcedureID + "&PKToken=" + Result.d;
                        },
				        error: function () {
				            //   alert("Error")
				        }
				    });

				    //End of Added By Chakshuta H on 11th-Aug-2016
				    //End of Commented and added by bharat tekade on 2nd-feb-2016
				}
				//End of comment and addition by RohiniK on 10 Nov 09
				
			}
			
			function Back_OnClick()
			{
			     objform.action = "KM_Discussion.aspx?Mode=HISTORY&ProcedureID=<%=m_lngProcedureID%>&PKToken=<%=m_strToken%>";
			     objform.submit();
			}
			//added by RohiniK on 10 Nov 09
			function ShowLength()
			{
			    var objSp=GetObjectReference("","Spnlength");
			    var objDes=GetObjectReference("","txtComments");
			    objSp.innerHTML=objDes.value.length;
			}
			
		    function Rollback_OnClick(inProcedureID,intVersionID)
		    {	
		        var strMsg = "This will create new version and overwrite the existing content by the version you have selected. Do you want to continue ?"
		        var strResponse;
		        var strAction;
		        strResponse = window.confirm(strMsg);
		        if (strResponse==true)
		        {		    
		            var op = window.opener.location.href;		            
    				if(op.indexOf("MasterTagID=3992")>-1)
    				    strAction = "KM_Discussion.aspx?Mode=<%=m_strMode%>&From=KA&Fromwhere=Discussion&Action=ROLLBACK&PKToken=<%=m_strToken%>&PageID="+ inProcedureID+"&ProcedureID=" +inProcedureID+ "&VersionID="+intVersionID ;
	                else
	                    strAction = "KM_Discussion.aspx?Mode=<%=m_strMode%>&From=&Fromwhere=Discussion&Action=ROLLBACK&PKToken=<%=m_strToken%>&PageID="+ inProcedureID+"&ProcedureID=" +inProcedureID+ "&VersionID="+intVersionID ;
	                    
	                objform.action = strAction;
		            objform.submit();		  		           
		        }
		    }		    
		//End of addition by RohiniK on 10 Nov 09
   </script>
</html>
