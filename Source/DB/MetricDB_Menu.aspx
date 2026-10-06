<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MetricDB_Menu.aspx.vb" Inherits="PbNIT.MetricDB_Menu" %>
<!DOCTYPE HTML>
<html>
 	<%CommonFunctions.General.PlotPageHeadTag("Menu")%>
<!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
    <script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    body div table tr td:first-child{
    padding-top:0px !important;
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
      //  responsiveFooterMenu();  commented by Nilesh g on 23/11/2015 
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
       
        //  responsiveFooterMenuResize();  commented by Nilesh g on 23/11/2015
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

 	<script language="javascript" src ="../General/radmenu_client.js" >  </script>
<LINK rel='stylesheet' type='text/css' href='../General\WindowsXP.css'></LINK>
  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
     <%-- Commented By Dipali V On 8th May 2020 For Issue Id 24247--%>
   <%-- <form id="frmMenu"  method="post" runat="server" >--%>
      <%-- Commented and added by Chetan M on 20 Nov 2020 for Set scroll height --%>
       <%--<form id="frmMenu"  method="post" runat="server" style="height:610px;overflow:auto">--%>
       <form id="frmMenu"  method="post" runat="server">
             <%-- End of Commented and added by Chetan M on 20 Nov 2020 for Set scroll height --%>
         <%-- End of   Commented By Dipali V On 8th May 2020 For Issue Id 24247--%>
			<%PageInit%>
    </form>
	<Script language="javascript">
	
		var objform=GetFormReference('frmMenu');
		var objdivlist=GetObjectReference('frmMenu','PageDiv');
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
          <%-- Commented and added by Chetan M on 20 Nov 2020 for Set scroll height --%>
         function resizeSection(tag) {
                 var divhieghtscroll = $(window).height();
                $('#frmMenu').css({ 'height': divhieghtscroll - 50, "overflow-y": "auto" });               
            }

            $(window).on("load resize scroll", function (e) {
                resizeSection(this);
            });
          <%--End of Commented and added by Chetan M on 20 Nov 2020 for Set scroll height --%>
		//The div tag has id as PageDiv 
		function window_onload()
		{
            //commented and added by Nilesh G on 23/11/2015
			//var intDivHeight ;
			//var intDivHeightRisk;
			//if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//if (intDivHeight < 100)	intDivHeight = 100;
			//objdivlist.style.height = intDivHeight;	}
		    //ShowHideMenu(); // jp_28Jul2006			
		    //var objDivMenu1 = GetObjectReference('frmMenu', 'DivMenu1');
		    var objDivMenu1 = document.body;
		    intDivHeight = window.innerHeight - objDivMenu1.offsetTop;
		    document.body.style.height = window.innerHeight - 3 +"px";
		    var brw=WhichBrowser();
		    if(intDivHeight < 100)
		    {
		        objDivMenu1.style.height = 100 + 'px';
			
		    }
		    else if(brw == 'IE')                                         
		    {   
              //Commented by Yogesh J on 10/12/2015     
		      //  objDivMenu1.style.height = (intDivHeight - 12) + "px";
		        objDivMenu1.style.height = (intDivHeight - 3) + "px";
                
		    }
		    else if(brw == 'CR')
		    {
		        //Commented by Yogesh J on 10/12/2015     
		        //objDivMenu1.style.height = (intDivHeight - 15) + "px";
		        objDivMenu1.style.height = (intDivHeight - 3) + "px";
		    }
		    else if(brw == 'FF')
		    {
		        //Commented by Yogesh J on 10/12/2015     
		        //objDivMenu1.style.height = (intDivHeight - 45) + "px";
		        objDivMenu1.style.height = (intDivHeight - 5) + "px";
		    }
		    else
		        objDivMenu1.style.height = intDivHeight + 'px';
       	
		    //end of commented and added by Nilesh G on 23/11/2015
		}
		
		function window_onresize()		
		{
		    //commented and added by Nilesh G on 23/11/2015
			//var intDivHeight;
			//var intDivHeightRisk;
			//if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//if (intDivHeight < 100)	intDivHeight = 100;
		    //objdivlist.style.height = intDivHeight;	}

		    //var objDivMenu1 = GetObjectReference('frmMenu', 'DivMenu1');
		    var objDivMenu1 = document.body;
		    intDivHeight = window.innerHeight - objDivMenu1.offsetTop;
		   
		    var brw = WhichBrowser();
		    if (intDivHeight < 100) {
		        objDivMenu1.style.height = 100 + 'px';
		       
		    }
		    else if (brw == 'IE') {

		        objDivMenu1.style.height = (intDivHeight - 5) + "px";
		    }
		    else if (brw == 'CR') {

		        objDivMenu1.style.height = (intDivHeight - 5) + "px";
		    }
		    else if (brw == 'FF') {

		        objDivMenu1.style.height = (intDivHeight - 7) + "px";
		    }
		    else
		        objDivMenu1.style.height = intDivHeight + 'px';


		    //else if (brw == 'CR') {

		    //    objDivMenu1.style.height = (intDivHeight - 50) + "px";
		    //}
		    //else if (brw == 'FF') {

		    //    objDivMenu1.style.height = (intDivHeight - 45) + "px";
		    //}
		    //else
		    //    objDivMenu1.style.height = intDivHeight + 'px';
		    //end of commented and added by Nilesh G on 23/11/2015
		}
	    //commented and added by Nilesh G on 23/11/2015
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
	    //end of commented and added by Nilesh G on 23/11/2015

	/*	'Modified by JijeshP on 31st July 2006 for PMLifeLine Issue ID.3735
		function ShowHideMenu() 
		{
			var objtdShowHide_ShowHideMenu = document.getElementById("tdShowHide_ShowHideMenu");
			var objDivMenu = document.getElementById("DivMenu");
			var strDisplay=(arguments.length>0)?arguments[0]:objDivMenu.style.display;
			
			if (strDisplay != "none") 
			{ 
			objDivMenu.style.display="none";
			//objtdShowHide_ShowHideMenu.src='../../Images/plus.gif';
			}
			else
			{ 
			objDivMenu.style.display="";
			//objtdShowHide_ShowHideMenu.src='../../Images/minus.gif';
			}
		}
		
		function divOnMouseOver(obj)
		{
			//alert(obj.style.cursor)
			obj.style.cursor="hand"
		}
		'Modified by JijeshP on 31st July 2006 for PMLifeLine Issue ID.3735
		' Commented to include new function for PMLifeLine Integration Purpose
		*/
		function ShowHideMenuOld() 
		{	/*Code Modified by SantoshK on 16th May 2006*/
			var objtdShowHide_ShowHideMenu = document.getElementById("tdShowHide_ShowHideMenu");
			var objDivMenu1 = document.getElementById("DivMenu1");
			var objDivMenu2 = document.getElementById("DivMenu2");
			var strDisplay1=(arguments.length>0)?arguments[0]:objDivMenu1.style.display;
			var strDisplay2=(arguments.length>0)?arguments[0]:objDivMenu2.style.display;
			
			if (strDisplay1 != "none") 
			{ 
			objDivMenu1.style.display="none";
			objDivMenu2.style.display="";						
			//objtdShowHide_ShowHideMenu.src='../../Images/plus.gif';
			}
			//else
			//{ 
			//objDivMenu1.style.display="";
			//objDivMenu2.style.display="none";
			////objtdShowHide_ShowHideMenu.src='../../Images/minus.gif';
			//}
			
			if (strDisplay2 != "none") 
			{ 
			objDivMenu2.style.display="none";
			objDivMenu1.style.display="";						
			//objtdShowHide_ShowHideMenu.src='../../Images/plus.gif';
			}
			//else
			//{ 
			//objDivMenu2.style.display="";
			//objDivMenu1.style.display="none";
			//objtdShowHide_ShowHideMenu.src='../../Images/minus.gif';
			//}
			/*Modifcation Ends by SantoshK on 16th May 2006*/
		}
		// Modified by JijeshP on 31st July 2006 for PMLifeLine Issue ID.3735
		// Included function for PMLifeLine1.0 Integration Purpose
		function ShowHideMenu(MenuID) 
		{	
			var NoMenu = 1;

			NoOfSections = parseInt(<%=m_NoSections%>);
			if (MenuID==null)
			{
				for (NoMenu = 1; NoMenu<= NoOfSections; NoMenu++)
				{	
					var objDivMenu = GetObjectReference('frmMenu', 'DivMenu' + NoMenu);
					
					if (objDivMenu!=null)
					{
					if (NoMenu ==1)
						objDivMenu.style.display="";
					else
						objDivMenu.style.display="none";
					}	
				}
			}
			else
			{
<% 'Modified By NitinVS on 29 May 2007 for PMLifeLine to hide other groups %>			
<% If 1=0 ' To hide commented part from client script %>
/*				var objDivMenu = GetObjectReference('frmMenu', 'DivMenu' + MenuID);
				var strDisplay = objDivMenu.style.display;
				if (strDisplay=="")
					objDivMenu.style.display="none";
				else
					objDivMenu.style.display="";
*/
<% End If %>
				for (NoMenu = 1; NoMenu<= NoOfSections; NoMenu++)
				{	
					var objDivMenu = GetObjectReference('frmMenu', 'DivMenu' + NoMenu);
					
					if (objDivMenu!=null)
					{
						if (NoMenu == MenuID)
						{
							if (objDivMenu.style.display=="none")
								objDivMenu.style.display="";
							else
								objDivMenu.style.display="none";	
						}	
						else
							objDivMenu.style.display="none";
						}	
				}					
			}
<% ' End Modification By NitinVS on 29 May 2007 for PMLifeLine to hide other groups %>						
		}
		// JijeshP Modification Ends...	
		
		function divOnMouseOver(obj)
		{
			//alert(obj.style.cursor)
			obj.style.cursor="hand"
		}

	</Script>
  </body>
</html>
