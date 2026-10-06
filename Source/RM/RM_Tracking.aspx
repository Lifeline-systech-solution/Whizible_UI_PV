<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%CommonFunctions.General.PlotPageHeadTag("")%>--%>
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RM_Tracking.aspx.vb" Inherits="PbNIT.RM_Tracking"%>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Requirement Tracking")%>
	<body class='clsPageBody' onload="window_onLoad()">
			<form name="frmRMTracking" id="frmRMTracking" method="post">
						
									<% InitPage() %>
							
	<div id=divExtraInfo style="WIDTH: 300px;DISPLAY:none " >
<table style="Position:relative;top:5;Z-INDEX:10" width=100% ><tr>
<td align=right ><img  src='../../Images/RM/Corner.gif'></td>
</tr></table>
<table id=tblExtraInfo  class=clsGridTable cellspacing=1 width=100%>
<tr class=clsTREven>
<td>Start Date</td>
<td>23-March-2006</td>
</tr>
<tr class=clsTROdd>
<td>End Date</td>
<td>30-March-2006</td>
</tr>
</table>
</div>
					</form>
				
					<STYLE type="text/css"> .FixedTD { POSITION: relative; TOP:expression(document.getElementById('divTbl').scrollTop -1 ); }
	
	
	</STYLE>
				
			<script>
		
		var ReqS=[],objfrm,objDivPopup,objdivDocMNPopup,objTblDoc,objTbl,c,TRno,PrjReqID=0,Curr_ReqSDetaNo;
		var plusImgPath="../../Images/RM/Plus.gif"; //"C:/Inetpub/wwwroot/Whiz9/Images/RM/Plus.gif"; //
		var minusImgPath="../../Images/RM/Minus.gif"; //"C:/Inetpub/wwwroot/Whiz9/Images/RM/Minus.gif";
		var IMGpopup,IMGDocPopup,isClickImagePopup=false,isMenuPopuped=false,mouseXY;
		var ReqSDeta=[];
		var TDMouseOver;
		var objTblExtraInfo,objDivExtraInfo;
		var iUploClickedPrjReqID=null;

		// ProjectRequirementID (0) | ParentProjectRequirementID (1) | ReqTitle (2) |
		// PSD (3) | PED (4) | Documents (5) | IsExpand (6) | PKToken of ProjectRequirementID (7) | Color (8) |
        // Requirement Code (9) | ASD (10) | AED (11) | PHRS (12) | AHRS (13) | Priority (14) | Status (15) |
        // ImpactID (16) | PKToken (17) | BSD (18) | BED (19) | BHRS (20) | ChkDisabed (21)
		<% CreateTableData %>
		
		<%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>		
		
		function window_onLoad()
		{
			objfrm = GetFormReference("frmRMTracking");
			
			if (!document.getElementById("divTbl"))
			return;
			
			document.getElementById("cboView").onchange=cboView_onchange;
			objTblExtraInfo = document.getElementById("tblExtraInfo");
			objDivExtraInfo = document.getElementById("divExtraInfo");
			
			objDivPopup=document.getElementById("divMNPopup");
			objdivDocMNPopup=document.getElementById("divDocMNPopup");
			objTblDoc=document.getElementById("tblDocMNPopup");
			
			
			IMGpopup=document.createElement("IMG");
			IMGDocpopup=document.createElement("IMG");
			
			IMGpopup.src="../../Images/RM/MenuDown.gif"; //"C:/Inetpub/wwwroot/Whiz9/Images/RM/MenuDown.gif"
			IMGDocpopup.src="../../Images/RM/MenuDown.gif"; //"C:/Inetpub/wwwroot/Whiz9/Images/RM/MenuDown.gif"
			IMGpopup.onclick=function(evt){showPopup(evt);};
			IMGDocpopup.onclick=function(evt){showDocPopup(evt);};
			
			
			
			for(c=0;c<ReqS.length;c++)
			{
				ReqSDeta[c]=ReqS[c].split("|");
			}
			CreateMainTable();

			document.onmousedown=function(evt){
			if(!isClickImagePopup){
				objDivPopup.style.display="none"; 
				objdivDocMNPopup.style.display="none"; 
				isClickImagePopup=false;isMenuPopuped=false;
				}
				document.getElementById("divMNNew").style.display="none";
				document.getElementById("divMNAction").style.display="none";
				objDivExtraInfo.style.display="none";
				
			}
			document.onmousemove=function(evt){
						isClickImagePopup =false;}
		}
		
		function CreateMainTable()
		{
			var row,cell;
			
			
				objTbl=document.createElement("TABLE");
				objTbl.className='clsGridTable';
				objTbl.cellPadding=0;
				objTbl.cellSpacing=1;
				objTbl.width="99.9%";
				
				
				objTbl.createTHead();
				objTbl.tHead.className='clsTRColumnHeader';
				row=objTbl.tHead.insertRow(0);
				
				cell=row.insertCell(0);
				cell.className="FixedTD";
				cell.width="30px";
				
				cell=row.insertCell(1);
				cell.className="FixedTD";
				cell.innerHTML="<B><%= MyBase.GetResourceString("LBL_REQUIREMENT")%></B>"; //"<B>Requirements</B>";
				
				cell=row.insertCell(2);
				cell.className="FixedTD";
				cell.width="40px";
				cell.innerHTML="<B><%= MyBase.GetResourceString("LBL_REQUIREMENTCODE")%></B>"; //"<B>Requirements</B>";
				
				cell=row.insertCell(3);
				cell.className="FixedTD";
				cell.innerHTML="<B><%= MyBase.GetResourceString("LBL_DOCUMENTS")%></B>"; //"<B>Documents</B>";
				cell.align="center";
				cell.width="80px";
				cell=row.insertCell(4);
				cell.className="FixedTD";
				cell.innerHTML="<B>Priority</B>"; //"<B>Start Date</B>";
				cell.width="90px";
				cell=row.insertCell(5);
				cell.className="FixedTD";
				cell.innerHTML="<B>Status</B>"; //"<B>Finished Date</B>";
				cell.width="90px";
				
				cell=row.insertCell(6);
				cell.className="FixedTD";
				cell.width="30px";
				
				
				document.getElementById("divTbl").appendChild(objTbl);

			TRno=0;
			for(c=0;c<ReqSDeta.length;c++)
			{
				if(ReqSDeta[c][1]==0)
				{ TRno++;createRow(c,10,0);}
			}
		}
		function createRow(ReqSDetaNo,pL,RMparentID)
		{
			var row,c1,blnPlusMinus=false;
			row=objTbl.insertRow(TRno);
			row.className="clsTREvenRow";
			row.RMparentID = RMparentID;
			row.RMID=ReqSDeta[ReqSDetaNo][0];
			row.ReqSDetaNo=ReqSDetaNo;
			row.pL=pL;
			for(c1=0;c1<ReqSDeta.length;c1++)
			{
				if(ReqSDeta[ReqSDetaNo][0]==ReqSDeta[c1][1])
				break;
				
			}
			if(c1!=ReqSDeta.length)
			blnPlusMinus=true;
			
			createCells(ReqSDetaNo,row,pL,blnPlusMinus);
			if(blnPlusMinus)
				row.isParent=1;
			else
				row.isParent=0;
				
			if(ReqSDeta[ReqSDetaNo][6]=="1")
			{
				if(blnPlusMinus)
				{
					TRno=TRno+1;
					createRow(c1,pL+15,ReqSDeta[c1][1])
					for(c1++;c1<ReqSDeta.length;c1++)
					{
						if(ReqSDeta[ReqSDetaNo][0]==ReqSDeta[c1][1])
						{ TRno=TRno+1; createRow(c1,pL+15,ReqSDeta[c1][1]) } 
					}
				}
			}
			
		}
		function createCells(ReqSDetaNo,row,pL,blnPlusMinus)
		{
			var cell;
			cell=row.insertCell(0); //chk box
			if(blnPlusMinus )
				cell.innerHTML="<input disabled type=checkbox class=clsCheckBox id=chk"+ReqSDeta[ReqSDetaNo][0] + " name="+ ReqSDeta[ReqSDetaNo][0]+">";
			else
				cell.innerHTML="<input name=chk  type=checkbox class=clsCheckBox id=chk"+ReqSDeta[ReqSDetaNo][0] + " value="+ ReqSDeta[ReqSDetaNo][0]+">";
			
			cell=row.insertCell(1); //requirement
			
			if(blnPlusMinus)
			{
				if(ReqSDeta[ReqSDetaNo][6]=="1")
				cell.innerHTML="<IMG valign=center expand='true' onclick=EM(event) src="+minusImgPath+">"+ReqSDeta[ReqSDetaNo][2];
				else
				cell.innerHTML="<IMG valign=center expand='false' onclick=EM(event) src="+plusImgPath+">"+ReqSDeta[ReqSDetaNo][2];

			cell.style.paddingLeft=pL;
			}	
			else
			{
			cell.innerHTML=ReqSDeta[ReqSDetaNo][2];
			cell.style.paddingLeft=pL+15;
			}
			cell.className="clsTDEvenRow";
			cell.onmouseover=function(evt){ onTDMouseOver(evt) }
			
			cell.style.borderLeft="thin solid "+ReqSDeta[ReqSDetaNo][8]
			
			cell=row.insertCell(2); //Code
			cell.innerHTML=ReqSDeta[ReqSDetaNo][9];
			
			cell=row.insertCell(3); //Documents
			cell.align="center";
			cell.innerHTML="("+ReqSDeta[ReqSDetaNo][5]+")";
			cell.onmouseover=function(evt){ onDocTDMouseOver(evt) }
			
			cell=row.insertCell(4); //
			cell.innerHTML=ReqSDeta[ReqSDetaNo][14];
			
			cell=row.insertCell(5);
			cell.innerHTML=ReqSDeta[ReqSDetaNo][15];
			
			cell=row.insertCell(6);
			cell.innerHTML="<IMG src='../../Images/RM/ShowExtra.gif' alt='Show Details' onclick=ShowExtraInfoDialog(event)>";;
			
			
		}
		function EM(evt) //Expand/Minimize
		{
			
			evt = evt || window.event;
			
			var source=evt.target||evt.srcElement;
			
			var arrParentRMIDs=[],c1,ReqSDetaC; //ReqSDetaC belongs counter of ReqSDeta for source row
			arrParentRMIDs[0]=source.parentNode.parentNode.RMID;
			
			for(c=0;c<ReqSDeta.length;c++)
			{
				if(source.parentNode.parentNode.RMID == ReqSDeta[c][0])
				{ ReqSDetaC=c;break; }
			}

			if(source.expand=="true") //Minimize
			{	
			
				ReqSDeta[ReqSDetaC][6]="0";
				source.expand = "false";
				source.src=plusImgPath;
				//alert(source.parentNode.parentNode.RMparentID);
				//alert(source.parentNode.parentNode.isParent);
				for(c=source.parentNode.parentNode.rowIndex+1;c<objTbl.rows.length;c++)
				{
					if(objTbl.rows[c].isParent=="1")
					arrParentRMIDs[arrParentRMIDs.length]=objTbl.rows[c].RMID;
					
					for(c1=0;c1<arrParentRMIDs.length;c1++)
					{	
						if(objTbl.rows[c].RMparentID == arrParentRMIDs[c1] )
						{
							objTbl.deleteRow(c); 
							c--;
							break;
						}
					}
					
					if(c1==arrParentRMIDs.length)
					break;
					
					
				}
				
				
			}
			else //Maxmize
			{
				ReqSDeta[ReqSDetaC][6]="1";
				source.expand = "true";
				source.src=minusImgPath;
				TRno=source.parentNode.parentNode.rowIndex;
				for(c=0;c<ReqSDeta.length;c++)
				{
					if(ReqSDeta[c][1]==arrParentRMIDs[0])
					{
						TRno++;createRow(c,source.parentNode.parentNode.pL+15,ReqSDeta[c][1]);
					}
					
				}
			}
		}
		
		function onTDMouseOver(evt)
		{
			if(isMenuPopuped)
			return;
			evt=evt||window.event; source=evt.target|| evt.srcElement; 
			
			if (source.tagName =="IMG")
			return;
			
			if(TDMouseOver && evt.srcElement != TDMouseOver )
				TDMouseOver.className="clsTDEvenRow"; 
			
			TDMouseOver=source;
			TDMouseOver.className="clsTDEven";
			if(IMGpopup.parentNode)
			IMGpopup.parentNode.removeChild(IMGpopup);
			if(IMGDocpopup.parentNode)
			IMGDocpopup.parentNode.removeChild(IMGDocpopup);
			
			TDMouseOver.appendChild(IMGpopup);
			
			
		}
		function onDocTDMouseOver(evt)
		{
			if(isMenuPopuped)
			return;
			evt=evt||window.event; source=evt.target|| evt.srcElement; 
			
			if (source.tagName =="IMG")
			return;
			
			if(TDMouseOver && evt.srcElement != TDMouseOver )
				TDMouseOver.className="clsTDEvenRow"; 
			
			TDMouseOver=source;
			TDMouseOver.className="clsTDEven";
			if(IMGDocpopup.parentNode)
			IMGDocpopup.parentNode.removeChild(IMGDocpopup);
			
			if(IMGpopup.parentNode)
			IMGpopup.parentNode.removeChild(IMGpopup);
			
			
			TDMouseOver.appendChild(IMGDocpopup);
		}
		function mouseOverPopupMenu(evt)
		{
			evt = evt || window.event;
			var source = evt.target || evt.srcElement;
			
			var objTblMN= source;
			while(objTblMN.tagName != "TABLE")
			objTblMN=objTblMN.parentNode;
			
			while(source.tagName != "TR")
			source=source.parentNode;
			
			
			for(c=0;c<objTblMN.rows.length;c++)
			objTblMN.rows[c].className="clsTROdd";
			
			source.className="clsTRColumnHeader";
		}
		
		/*
		function mouseOverDocPopupMenu(evt)
		{
			evt=window.event||evt;
			var source=evt.srcElement||evt.target;
			
			for(c=0;c<objTblDoc.rows.length;c++)
			objTblDoc.rows[c].className='clsTROdd';
			
			source.parentNode.className='clsTRColumnHeader';
			
		}
		*/
		function mouseDownPopupMenu(TRid)
		{
			//alert(PrjReqID);
			//var ReqSDetaNo;
			if(TRid=="RequTR")
			{	
				//for(c=0;c<ReqSDeta.length;c++)	if(ReqSDeta[c][0]==PrjReqID)	break;
				//if(c!=ReqSDeta.length)
				window.open ("../RM/ProjectRequirements_CommonPage.aspx?ProjectID="+document.getElementById("cboProject").value+"&ProjectRequirementID_PK="+PrjReqID+"&PKToken="+ReqSDeta[Curr_ReqSDetaNo][7]+"&MasterTagID=3714&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
			}
			else if(TRid=="DetaTR")
				window.open ("../RM/ProjectRequirementDetails.aspx?ProjectID="+document.getElementById("cboProject").value+"&ProjectRequirementID="+PrjReqID,"", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
			else if(TRid == "ImpaTR")
				window.open ("../RM/ImpactAnalysis_CommonPage.aspx?ProjectID="+document.getElementById("cboProject").value+"&FromWhere=DB&MasterTagID=3718&ProjectRequirementID="+PrjReqID+"&ProjectRequirement_ImpactID_PK="+ReqSDeta[Curr_ReqSDetaNo][16]+"&PKToken="+ReqSDeta[Curr_ReqSDetaNo][17]+"&PagingAlphabet=&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
			else if (TRid == "UploTR")
				window.open ("../RM/DocumentReview_CommonList.aspx?ProjectID="+document.getElementById("cboProject").value+"&FromWhere=DB&MasterTagId=3721&ProjectRequirementId="+PrjReqID,"", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
			else if (TRid == "MappTR")
				window.open ("../RM/RM_ProjectRequirementMapping.aspx?ProjectID="+document.getElementById("cboProject").value+"&ProjectRequirementId="+PrjReqID,"", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
			else if (TRid == "ShowTR")	//Show traceability for particular requirement
				window.open ("../RM/Requirement_Tracking.aspx?ProjectID="+document.getElementById("cboProject").value+ "&ProjectRequirementId="+PrjReqID,"", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=1000,height=300");
			
		}
		function mouseDownPopupMainMenu(TRid)
		{
			if (TRid == "MNRequTR")
				window.open("../RM/ProjectRequirements_CommonPage.aspx?ProjectID="+document.getElementById("cboProject").value+"&Mode=ADD_NEW&MasterTagID=3714&FromWhere=DB&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
			else if (TRid == "MNTempTR")
				window.open("../RM/RM_ProjectRequirementTemplates.aspx?Mode=ADD_NEW&ProjectID="+document.getElementById("cboProject").value+"&MasterTagID=3733&FromWhere=DB&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=540");
			else if (TRid == "MNDeleTR" )
			{
				objfrm.action="../RM/RM_Tracking.aspx?Action=DELETE"
				objfrm.submit();
			}
			//added added by RohiniK on 21 Jun 07 - For Weserve RTM change -added TR Phase Master 
			else if (TRid == "MNTRPhase" )
			{
				//Comment and addition by SuchitraP on 13 Sept 2007 
				//window.open("../RM/RTM_TRPhase_CommonList.aspx?FromWhere=DB&MasterTagId=10058&ProjectID="+document.getElementById("cboProject").value,"", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=530");
				window.open("../RM/RTM_TRPhase_CommonList.aspx?FromWhere=DB&MasterTagId=3839&ProjectID="+document.getElementById("cboProject").value,"", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=530");
				//End of Comment and addition by SuchitraP on 13 Sept 2007
			}
			//End of addition by RohiniK on 21 Jun 07 - For Weserve RTM change 
			else if (TRid == "MNViewTempTR")
			window.open ("../RM/RMTemplate_CommonList.aspx?FromWhere=DB&MasterTagId=3733&ProjectID="+document.getElementById("cboProject").value,"", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=530");
			
			//added by RohiniK on 16 Aug 07 --for Project -all requirement Tamplate display
			else if (TRid == "MNViewPrjTemp")
				window.open ("../RM/ProjectRequirementTemplateDetails.aspx?ProjectID="+document.getElementById("cboProject").value,"", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
			//end of addition by RohiniK on 16 Aug 07 --for Project -all requirement Tamplate display
				
		}
		function mouseDownDocPopupMenu(evt)
		{
			evt=window.event||evt;
			var source=evt.srcElement||evt.target;
			//alert(source.innerHTML);
			if (source.ProjectDocumentRefTypeID != "OPENPOPUP")
			window.open("ViewDocument.aspx?FromWhere=RM&ProjectID="+document.getElementById("cboProject").value+"&ProjectDocumentRefTypeID=" + source.ProjectDocumentRefTypeID +"&ProjectRequirementID=" + PrjReqID,"","left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
			else
			window.open ("../RM/DocumentReview_CommonList.aspx?ProjectID="+document.getElementById("cboProject").value+"&FromWhere=DB&MasterTagId=3721&ProjectRequirementId="+iUploClickedPrjReqID,"", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
			
			
			
		}
		function showPopup(evt)
		{
			evt=evt||window.event;
			
			var source=evt.target || window.event.srcElement;
			isClickImagePopup=true;
			isMenuPopuped=true;
			
			PrjReqID=source.parentNode.parentNode.RMID;
			Curr_ReqSDetaNo=source.parentNode.parentNode.ReqSDetaNo;
			
			objDivPopup.style.display="block";
			mouseXY=mouseCoords(evt);
			
			objDivPopup.style.position = 'absolute';
			objDivPopup.style.left    = mouseXY.x;
			objDivPopup.style.top      = mouseXY.y;
		}
		function showDocPopup(evt)
		{
			evt=evt||window.event;
			
			var source=evt.target || window.event.srcElement;
			isClickImagePopup=true;
			isMenuPopuped=true;
			
			PrjReqID=source.parentNode.parentNode.RMID;
			iUploClickedPrjReqID = PrjReqID;
			
			mouseXY=mouseCoords(evt);
			
			objdivDocMNPopup.style.position = 'absolute';
			objdivDocMNPopup.style.left    = mouseXY.x;
			objdivDocMNPopup.style.top      = mouseXY.y;
			
			
			loadXMLDoc("../RM/RM_Tracking.aspx?ProjectRequirementID="+PrjReqID+"&Action=GETDOCUMENTS","1=1")
			
			
			
		}
		
		function mouseCoords(ev){
				if(ev.pageX || ev.pageY){
				return {x:ev.pageX, y:ev.pageY};
				}
				return {
					x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
					y:ev.clientY + document.body.scrollTop  - document.body.clientTop
				};
			}
		function createDocumentPopup(Rows)
		{
			//added by RohiniK on 30 Jun 07 for WeServe --Page crashes clicking on small window if no doc uploaded.
			if (!Rows)
				return;
			//End of addition by RohiniK on 30 Jun 07
				
			var row,cell;

			for(c=0;c<objTblDoc.rows.length;c++)
			{
				objTblDoc.deleteRow(c);	
				c--;
			}
			

			var arrRows=Rows.split("|");
			for(c=0;c<arrRows.length && c <=6 ;c=c+2)
			{
				row=objTblDoc.insertRow(objTblDoc.rows.length);
				cell=row.insertCell(0);
				cell.ProjectDocumentRefTypeID=arrRows[c+1];
				cell.innerHTML=arrRows[c];
				cell.onmouseover=mouseOverPopupMenu;//mouseOverDocPopupMenu;
				cell.onmousedown=mouseDownDocPopupMenu;
				row.className='clsTROdd';
				
			}
			if(c<arrRows.length)
			{
				row=objTblDoc.insertRow(objTblDoc.rows.length);
				cell=row.insertCell(0);
				cell.ProjectDocumentRefTypeID="OPENPOPUP";
				cell.align="center";
				cell.innerHTML="...";
				cell.onmouseover=mouseOverPopupMenu;//mouseOverDocPopupMenu;
				cell.onmousedown=mouseDownDocPopupMenu;
				row.className='clsTROdd';
			}
			objTblDoc.rows[0].className='clsTRColumnHeader';
			objdivDocMNPopup.style.display="block";
			
		
		}		
		
		
//xmlHttp functions
var xmlhttp;
function loadXMLDoc(url,reqQuery,isAsync)
{
	if(!isAsync )
	isAsync = false;


// code for Mozilla, etc.

if (window.XMLHttpRequest)
  {
  
		xmlhttp=new XMLHttpRequest()
		xmlhttp.onreadystatechange=state_Change;
		if (ns)
		{
			xmlhttp.open("GET",url+"&"+reqQuery,isAsync)
			xmlhttp.send(false)
		}
		else
		{
			xmlhttp.open("POST",url,isAsync)
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlhttp.send(reqQuery)
		}
  
  
  }
	// code for IE
else if (window.ActiveXObject)
	{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
		if (xmlhttp)
		{
			xmlhttp.onreadystatechange=state_Change
			xmlhttp.open("POST",url,isAsync)
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
 			xmlhttp.send(reqQuery)
		}
	}

}

function state_Change()
{
// if xmlhttp shows "loaded"
if (xmlhttp.readyState==4)
  {
  // if "OK"
  if (xmlhttp.status==200)
  {
	createDocumentPopup(xmlhttp.responseText);
  }
  else
  {
  alert("Problem in saving data:" + xmlhttp.statusText)
  }
  }
}		
function cboProject_onChange()
{

	objfrm.action="../RM/RM_Tracking.aspx";
	objfrm.submit();
}
function cboView_onchange()
{
	objfrm.action="../RM/RM_Tracking.aspx";
	objfrm.submit();
}
function showMenu(evt,divMenu)
{
	evt = window.event || evt;
	var source = evt.target || evt.srcElement;
	
	var menu = document.getElementById(divMenu);
	document.getElementById("divMNNew").style.display="none";
	document.getElementById("divMNAction").style.display="none";
	var LeftTop = GetObjectPosition(source);
	menu.style.display="block";
	menu.style.position="absolute";
	menu.style.left=LeftTop.left;
	menu.style.top=LeftTop.top+source.offsetHeight; 
	
}
function GetObjectPosition(obj)
{

	if(!obj.parentNode)
	return{left:0,top:0};
	
	var position=GetObjectPosition(obj.parentNode);
	return{left:obj.offsetLeft+position.left,top:obj.offsetTop+position.top};
	
}

function ShowExtraInfoDialog(evt)
{
	evt = evt || window.event;
	var source=event.srcElement || evt.target;
	var row,cell;
	var ReqSDetaNo= source.parentNode.parentNode.ReqSDetaNo;
	
	for(c=objTblExtraInfo.rows.length-1;c>=0;c--)
		objTblExtraInfo.deleteRow(c);
	
	objTblExtraInfo.createTHead();
	objTblExtraInfo.tHead.className='clsTRColumnHeader';
	row=objTblExtraInfo.tHead.insertRow(objTblExtraInfo.rows.length);
//	row.className="clsTRColumnHeader";
	cell=row.insertCell(0);
	cell.width="10px";
	cell.align="right";
	cell=row.insertCell(1);
	cell.width="80px";
	cell.innerHTML="<B><%= MyBase.GetResourceString("LBL_PSD")%></B>";
	cell=row.insertCell(2);
	cell.width="80px";
	cell.innerHTML="<B><%= MyBase.GetResourceString("LBL_PED")%></B>";
	cell=row.insertCell(3);
	cell.align='right';
	cell.width="80px";
	cell.innerHTML="<B>Efforts (Hrs) </B>";
	
	row=objTblExtraInfo.insertRow(objTblExtraInfo.rows.length);
	row.className="clsTREven";
	cell=row.insertCell(0);
	cell.align="right";
	cell.innerHTML="<B>Current</B>";
	cell=row.insertCell(1);
	cell.innerHTML=ReqSDeta[ReqSDetaNo][3];
	cell=row.insertCell(2);
	cell.innerHTML=ReqSDeta[ReqSDetaNo][4];
	cell=row.insertCell(3);
	cell.align='right';
	cell.innerHTML=ReqSDeta[ReqSDetaNo][12];
	
	row=objTblExtraInfo.insertRow(objTblExtraInfo.rows.length);
	row.className="clsTREven";
	cell=row.insertCell(0);
	cell.align="right";
	cell.innerHTML="<B>Baseline</B>";
	cell=row.insertCell(1);
	cell.innerHTML=ReqSDeta[ReqSDetaNo][18];
	cell=row.insertCell(2);
	cell.innerHTML=ReqSDeta[ReqSDetaNo][19];
	cell=row.insertCell(3);
	cell.align='right';
	cell.innerHTML=ReqSDeta[ReqSDetaNo][20];
	
	row=objTblExtraInfo.insertRow(objTblExtraInfo.rows.length);
	row.className="clsTREven";
	cell=row.insertCell(0);
	cell.align="right";
	cell.innerHTML="<B>Actual</B>";
	cell=row.insertCell(1);
	cell.innerHTML=ReqSDeta[ReqSDetaNo][10];
	cell=row.insertCell(2);
	cell.innerHTML=ReqSDeta[ReqSDetaNo][11];
	cell=row.insertCell(3);
	cell.align='right';
	cell.innerHTML=ReqSDeta[ReqSDetaNo][13];
			
	objDivExtraInfo.style.display="block";
	objDivExtraInfo.style.position="absolute";
	mouseXY=mouseCoords(evt);
	objDivExtraInfo.style.left=mouseXY.x-objDivExtraInfo.clientWidth;
	objDivExtraInfo.style.top=mouseXY.y;

}
function cboDashboard_OnChange() 
{ 
// For selecting the user's e-DB 
var objcboDashboard; 
objcboDashboard = GetObjectReference('Graph','cboDashboard'); 
var strPageName; 
var arr; 
strPageName = objcboDashboard.value; 
if (trimString(strPageName + "") != "") 
{ 
arr = strPageName.split("|"); 
if (isSubstringExists(arr[0],'?')) 
{ 
window.location.href = "" + arr[0] + "&DashboardID=" + arr[1]; 
} 
else 
{ 
window.location.href = "" + arr[0] + "?DashboardID=" + arr[1]; 
} 
} 
else 
{ 
window.location.href = "../DB/DB_InitiativeStageDelays_Dashboard.aspx?DashboardID=0"; 
}
} 
			</script>
		
	</body>
</HTML>
