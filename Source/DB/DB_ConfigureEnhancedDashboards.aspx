<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DB_ConfigureEnhancedDashboards.aspx.vb" Inherits="PbNIT.DB_ConfigureEnhancedDashboards"%>
<!DOCTYPE HTML>
<html>
  <%CommonFunctions.General.PlotPageHeadTag("Configure Enhanced Dashboards")%>

  <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
   
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

  <body class='clsBody' onload='window_onload()' onresize='window_onresize()' >
    <form name="frmConfigureEnhancedDashboards" id="frmConfigureEnhancedDashboards" method="post" >
		<%PageInit()%>
	</form>
	
	<script>
	
		var objdivMenu = document.getElementById('divMenu');
		var c,sourceIMG,mouseXY,objTbl,TRno,IsanyTextBoxBlank=false,FromShowDiv=true;
		var arrHidCtrlIDs=[];
		var objfrm = GetFormReference('frmConfigureEnhancedDashboards');
		var objdivlist = GetObjectReference('frmConfigureEnhancedDashboards', 'divPage');
		var addIMGPath = "../../Images/TreeNodeImages/user.gif";
		var deleteIMGPath = "../../Images/TreeNodeImages/delete.gif";
		var addIMGToolTip = "Create Menu/Submenu"
		var deleteIMGToolTip = "Delete Row"
		var ImageClicked, borderedImg;
        
        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
        
		function window_onload()
		{
			if (GetObjectReference(objfrm,'txtDBName'))
			GetObjectReference(objfrm,'txtDBName').focus();
	
			if (document.getElementById("firstImg1"))
			{
				document.getElementById("firstImg1").onmousedown=showDiv;
				document.getElementById("firstImg1").tblID='tbl_1';
				document.getElementById("firstImg1").TRno='1';
				document.onmousedown=function(){ if (!FromShowDiv){FromShowDiv=false;objdivMenu.style.display="none";}}
				document.onmousemove=function(evt){
				FromShowDiv =false;
					evt = window.event || evt ;
					var source = evt.target || evt.srcElement;
					if (source.tagName =="IMG")
					{
						if(borderedImg)
						borderedImg.border=0;
						
						source.border=1;
						source.bgColor="red";
						borderedImg = source;
					}
					else if(borderedImg)
					borderedImg.border=0;
					}
									
			}
			var intDivHeight, lc;
			if (navigator.appName == 'Microsoft Internet Explorer')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
			}
			else
			{
				intDivHeight = window.innerHeight - objdivlist.offsetTop - 42;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;
		}

		function showDiv(evt)
		{
			evt = window.event || evt;
			var source = evt.target || evt.srcElement;
			if (source.tagName=="IMG")
				source.border=2;
			ImageClicked=source.id;

			FromShowDiv = true;
			objdivMenu.style.display='block';
			objTbl = document.getElementById(source.tblID);
			TRno = source.parentNode.parentNode.rowIndex+1; //window.event.srcElement.TRno;// argTRno;
			mouseXY=mouseCoords(evt);

			objdivMenu.style.position = 'absolute';
			objdivMenu.style.top      = mouseXY.y;
			objdivMenu.style.left    = mouseXY.x;
		}

		function createChild(obj)
		{
			var strtempImageClicked = ImageClicked;
			var strRelation= GetObjectReference(objfrm,'hidRelation').value;
			var Clickedid= strtempImageClicked.substring(strtempImageClicked.indexOf('g')+1);
			var tempval="";
			var ChildIDGenerated="1", strNewChildID="";
			var arrElements=strRelation.split(",");
			var RowNo;
			for (var i=0;i<arrElements.length;i++)
			{
				if(arrElements[i].substring(0,arrElements[i].indexOf('_')) == Clickedid)
					tempval=arrElements[i];
			}
			if (tempval!="")
			{
				ChildIDGenerated=parseInt(tempval.substring(tempval.indexOf('_')+1))+parseInt(1);
			}
			//alert(Clickedid+"_"+ChildIDGenerated);
			strNewChildID=Clickedid+"_"+ChildIDGenerated;
			objdivMenu.style.display="none";
			
			var incr,IMGctrl,CaptionCtrl,IMGDelctrl, TDCtrl, OrderNoCtrl, BlankTDCtrl, ImageCtrl, HrefCtrl, IMGHrefCtrl;
			objTbl = document.getElementById('tbl_1');
			
			OrderNoCtrl = document.createElement("INPUT");
			OrderNoCtrl.type="text";
			OrderNoCtrl.id="txtOrderNo_"+strNewChildID;
			OrderNoCtrl.name="txtOrderNo_"+strNewChildID;
			OrderNoCtrl.style.width="25px";
			OrderNoCtrl.className='clsTextBox';

			CaptionCtrl = document.createElement("INPUT");
			CaptionCtrl.type="text";
			CaptionCtrl.id="txtCaption_"+strNewChildID;
			CaptionCtrl.name="txtCaption_"+strNewChildID;
			CaptionCtrl.style.width="150px";
			CaptionCtrl.className='clsTextBox';

			ImageCtrl = document.createElement("INPUT");
			ImageCtrl.type="text";
			ImageCtrl.id="txtImage_"+strNewChildID;
			ImageCtrl.name="txtImage_"+strNewChildID;
			ImageCtrl.style.width="150px";
			ImageCtrl.title="Images are expected to be present in [Site Folder]->Images->DB folder.";
			ImageCtrl.className='clsTextBox';

			HrefCtrl = document.createElement("INPUT");
			HrefCtrl.type="text";
			HrefCtrl.id="txtHref_"+strNewChildID;
			HrefCtrl.name="txtHref_"+strNewChildID;
			HrefCtrl.style.width="280px";
			HrefCtrl.className='clsTextBox';

			IMGDelctrl= document.createElement("IMG");
			IMGDelctrl.src=deleteIMGPath;
			IMGDelctrl.title=deleteIMGToolTip;
			IMGDelctrl.id="deleteImg"+strNewChildID;
			IMGDelctrl.onmousedown=function(){deleteSection(strNewChildID+"")};

			IMGHrefCtrl= document.createElement("IMG");
			IMGHrefCtrl.src="../../Images/TreeNodeImages/Lookup.gif";
			IMGHrefCtrl.title="Click to select Dashboards";
			IMGHrefCtrl.id="HrefImg"+strNewChildID;
			IMGHrefCtrl.onmousedown=function(){OpenPopUp(strNewChildID+"")};
			
			TDCtrl = document.createElement("TD");
			TDCtrl.appendChild(OrderNoCtrl);

			BlankTDCtrl=document.createElement("TD");

			objdivMenu.style.display='none';
			//-Start--Calculate Row No, where to be inserted.
			var arr1Parents = GetObjectReference(objfrm, 'hidParentIDs').value.split(",");
			var arr1Childs = GetObjectReference(objfrm, 'hidRelation').value.split(",");
			var CntParents=0, CntChilds=0;
			for (var x=0;x<arr1Parents.length;x++)
			{
				if(arr1Parents[x] <= Clickedid)
				{
					CntParents = CntParents+1;
					
					for(var y=0;y<arr1Childs.length;y++)
					{
						if(arr1Childs[y].substring(0, arr1Childs[y].indexOf('_'))==arr1Parents[x])
							CntChilds = CntChilds +1;
					}
					//alert('CntChilds='+CntChilds);
				}	
				//alert('ParentCnt='+CntParents);
			}
			//alert(CntParents);
			//alert(CntChilds);
			RowNo=CntParents+CntChilds+1;
			/*evt = window.event || evt ;
			var source = evt.target || evt.srcElement;

			var objTbl1 = document.getElementById(source.tblID);
			var RowNo = source.parentNode.parentNode.rowIndex;
			alert(RowNo);*/
			//-End--Calculate Row No
			newRow = objTbl.insertRow(RowNo);
			newRow.className='clsTREven';
			newRow.id=strNewChildID
			
			newCell=newRow.insertCell(0);
			newCell.appendChild(BlankTDCtrl);
			
			newCell=newRow.insertCell(1);
			newCell.appendChild(OrderNoCtrl);
			
			newCell=newRow.insertCell(2);
			newCell.appendChild(CaptionCtrl);
			
			newCell=newRow.insertCell(3);
			newCell.appendChild(ImageCtrl);
				
			newCell=newRow.insertCell(4);
			newCell.appendChild(HrefCtrl);
			newCell.appendChild(IMGHrefCtrl);
			newCell.appendChild(IMGDelctrl);
			if(GetObjectReference(objfrm, 'hidRelation').value=="")
			GetObjectReference(objfrm, 'hidRelation').value=strNewChildID;
			else
			GetObjectReference(objfrm, 'hidRelation').value=GetObjectReference(objfrm, 'hidRelation').value+","+strNewChildID;
		}

		function createSibling(obj)
		{
			var incr,IMGctrl,CaptionCtrl,IMGDelctrl, TDCtrl, OrderNoCtrl, BlankTD1Ctrl, BlankTD2Ctrl, BlankTD3Ctrl;
			objTbl = document.getElementById('tbl_1');
			var ParentCnt;
			ParentCnt = GetObjectReference(objfrm, 'hidParent').value;

			IMGctrl= document.createElement("IMG");
			IMGctrl.src=addIMGPath;
			IMGctrl.title=addIMGToolTip;
			IMGctrl.tblID=objTbl.id;
			IMGctrl.id="firstImg"+parseInt(parseInt(ParentCnt)+parseInt(1));
			IMGctrl.onmousedown=function(ev){ showDiv(ev) };

			OrderNoCtrl = document.createElement("INPUT");
			OrderNoCtrl.type="text";
			OrderNoCtrl.id="txtOrderNo_"+parseInt(parseInt(ParentCnt)+parseInt(1));
			OrderNoCtrl.name="txtOrderNo_"+parseInt(parseInt(ParentCnt)+parseInt(1));
			OrderNoCtrl.style.width="25px";
			OrderNoCtrl.className='clsTextBox';
			
			BlankTD1Ctrl=document.createElement("TD");
			BlankTD1Ctrl.innerHTML="-";
			
			BlankTD2Ctrl=document.createElement("TD");
			BlankTD2Ctrl.innerHTML="-";
			
			BlankTD3Ctrl=document.createElement("TD");
			BlankTD3Ctrl.innerHTML="-";
			
			CaptionCtrl = document.createElement("INPUT");
			CaptionCtrl.type="text";
			CaptionCtrl.id="txtCaption_"+parseInt(parseInt(ParentCnt)+parseInt(1));
			CaptionCtrl.name="txtCaption_"+parseInt(parseInt(ParentCnt)+parseInt(1));
			CaptionCtrl.style.width="150px";
			CaptionCtrl.className='clsTextBox';
			
			IMGDelctrl= document.createElement("IMG");
			IMGDelctrl.src=deleteIMGPath;
			IMGDelctrl.title=deleteIMGToolTip;
			IMGDelctrl.id="deleteImg"+parseInt(parseInt(ParentCnt)+parseInt(1));
			IMGDelctrl.onmousedown=function(){deleteSection(parseInt(ParentCnt)+1+"")};

			TDCtrl = document.createElement("TD");
			TDCtrl.appendChild(OrderNoCtrl);
			objdivMenu.style.display='none';
				
			newRow = objTbl.insertRow(objTbl.rows.length);
			newRow.className='clsTREven';
			newRow.id=parseInt(ParentCnt)+1;
			
			newCell=newRow.insertCell(0);
			newCell.appendChild(IMGctrl);
			newCell.appendChild(OrderNoCtrl);
			
			newCell=newRow.insertCell(1);
			newCell.appendChild(BlankTD1Ctrl);
			
			newCell=newRow.insertCell(2);
			newCell.appendChild(CaptionCtrl);
			newCell.appendChild(IMGDelctrl);
			
			newCell=newRow.insertCell(3);
			newCell.appendChild(BlankTD2Ctrl);
			
			newCell=newRow.insertCell(4);
			newCell.appendChild(BlankTD3Ctrl);
			
			GetObjectReference(objfrm, 'hidParent').value=parseInt(parseInt(ParentCnt)+parseInt(1));
			GetObjectReference(objfrm, 'hidParentIDs').value=GetObjectReference(objfrm, 'hidParentIDs').value + ','+parseInt(parseInt(ParentCnt)+parseInt(1));
			//alert(GetObjectReference(objfrm, 'hidParentIDs').value);
		}

		function deleteSection(evt)
		{
			var name="deleteImg"+evt;
			var index=evt.indexOf('_');
			var objImgRef, objParentImgRef;
			var str;
			str='';

			if (index != -1)
			{
				//child deletion
				objImgRef = GetObjectReference(objfrm, name);
				objParentImgRef = objImgRef.parentNode.parentNode;
				objParentImgRef.style.display="none";
				//alert(GetObjectReference(objfrm, 'tbl_1').rows.length);
				
				var arrElements =  GetObjectReference(objfrm,'hidRelation').value.split(",");
				for (var i=0;i<arrElements.length;i++)
				{
					if(evt !=arrElements[i])
					str=str+arrElements[i]+',';
				}
				GetObjectReference(objfrm,'hidRelation').value=str.substring(0, str.length-1);
				
				var evt1 = window.event || evt ;
				var source = evt1.target || evt1.srcElement;

				var objTbl1 = document.getElementById(source.tblID);
				var TRno = source.parentNode.parentNode.rowIndex;
				
				GetObjectReference(objfrm, 'tbl_1').deleteRow(TRno);
			}
			else
			{
				if (confirm('With parent deletion all its children will be deleted. Do you want to continue?')==false) return;
				if(GetObjectReference(objfrm,'hidParentIDs'))
				{
					if(parseInt(GetObjectReference(objfrm,'hidParent').value)=="1")
					{
						alert("There should be at least one parent menu. So you can not delete it.");
						return;
					}
				}
				//parent deletion i.e. delete parent and its childs.
				//objImgRef = GetObjectReference(objfrm, "deleteImg"+evt)
				objImgRef = document.getElementById("deleteImg"+evt);
				objParentImgRef = objImgRef.parentNode.parentNode;
				objParentImgRef.style.display="none";
				
				var evt1 = window.event || evt ;
				var source = evt1.target || evt1.srcElement;

				var objTbl1 = document.getElementById(source.tblID);
				var TRno = source.parentNode.parentNode.rowIndex;
				GetObjectReference(objfrm, 'tbl_1').deleteRow(TRno);
					
				var arrElements =  GetObjectReference(objfrm,'hidParentIDs').value.split(",");
				//alert(evt);
				for (var i=0;i<arrElements.length;i++)
				{
					if(evt !=arrElements[i])
					str=str+arrElements[i]+',';
				}
				GetObjectReference(objfrm,'hidParentIDs').value=str.substring(0, str.length-1);
				GetObjectReference(objfrm,'hidParent').value=parseInt(GetObjectReference(objfrm,'hidParent').value)-1;
				/*alert('ParentIDs='+GetObjectReference(objfrm,'hidParentIDs').value);
				alert('Parents='+GetObjectReference(objfrm,'hidParent').value);
				alert('Relation='+GetObjectReference(objfrm,'hidRelation').value);*/
				//alert('TRno='+TRno);
				str="";
				
				var strVal= GetObjectReference(objfrm,'hidRelation').value;
				var arrElements =  GetObjectReference(objfrm,'hidRelation').value.split(",");
				var arrsubelements, j, k, arrElements1;
				//var tempcnt=0;
				for (var i=0;i<arrElements.length;i++)
				{
					arrsubelements=arrElements[i].split("_");
					if(arrsubelements[0]==evt)
					{
						//alert('TempCnt'+tempcnt);
						objImgRef = document.getElementById("deleteImg"+arrElements[i]);
						objParentImgRef = objImgRef.parentNode.parentNode;
						objParentImgRef.style.display="none";
						//alert('Deleting Row...'+parseInt(parseInt(TRno)+parseInt(tempcnt)));
						//GetObjectReference(objfrm, 'tbl_1').deleteRow(parseInt(parseInt(TRno)+parseInt(tempcnt)));
						GetObjectReference(objfrm, 'tbl_1').deleteRow(objParentImgRef.rowIndex);
						//tempcnt=parseInt(tempcnt)+parseInt(1);
						
						arrElements1="";
						arrElements1 = strVal.split(",");
						str='';
						for (k=0;k<arrElements1.length;k++)
						{
							if(arrElements[i] !=arrElements1[k])
							str=str+arrElements1[k]+',';
						}
						GetObjectReference(objfrm,'hidRelation').value=str.substring(0, str.length-1);
						strVal = GetObjectReference(objfrm,'hidRelation').value;
					}
				}
				//alert('After relation'+GetObjectReference(objfrm,'hidRelation').value);
			}
				/*alert('ParentIDs='+GetObjectReference(objfrm,'hidParentIDs').value);
				alert('Parents='+GetObjectReference(objfrm,'hidParent').value);
				alert('Relation='+GetObjectReference(objfrm,'hidRelation').value);*/
		}

		function window_onresize()
		{
			var intDivHeight ;
			if (navigator.appName == 'Microsoft Internet Explorer')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
			}
			else
			{
				intDivHeight = window.innerHeight - 42;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;
		}

		function Save_Click()
		{
			//alert('ParentValues='+GetObjectReference(objfrm,'hidParentIDs').value);
			//alert('TotalParents='+GetObjectReference(objfrm,'hidParent').value);
			//alert('RelationValues='+GetObjectReference(objfrm,'hidRelation').value);
			//alert('TableRows='+GetObjectReference(objfrm,'tbl_1').rows.length);*/
			//return;
			var objDBTitle = GetObjectReference(objfrm,'txtDBName');
			if(isBlank(objDBTitle.value))
			{ alert("'Dashboard Name' should not be left blank."); objDBTitle.focus(); return; }
				
			if(document.getElementById("tbl_1")!=null)
			{
				var arrNoOfParents= GetObjectReference(objfrm, 'hidParentIDs').value.split(",");
				var arrChilds= GetObjectReference(objfrm, 'hidRelation').value.split(",");
				for(var i = 0;i<=arrNoOfParents.length;i++)
				{
					if (disallowBlank(document.getElementById("txtOrderNo_"+arrNoOfParents[i]), 'Order Number Should not be left blank.') == true)
					{
						document.getElementById("txtOrderNo_"+arrNoOfParents[i]).focus();
						return;
					}
					if (disallowNonInteger(document.getElementById("txtOrderNo_"+arrNoOfParents[i]), 'Please provide Integer value.') == true)
					{
						document.getElementById("txtOrderNo_"+arrNoOfParents[i]).focus();
						return;
					}
					if (disallowBlank(document.getElementById("txtCaption_"+arrNoOfParents[i]), "'Caption' should not be blank.") == true)
					{
						document.getElementById("txtCaption_"+arrNoOfParents[i]).focus();
						return;
					}
				}
				for(var j=0;j<arrChilds.length;j++)
				{
					if (disallowBlank(document.getElementById("txtOrderNo_"+arrChilds[j]), 'Order Number Should not be left blank.') == true)
					{
						document.getElementById("txtOrderNo_"+arrChilds[j]).focus();
						return;
					}
					if (disallowNonInteger(document.getElementById("txtOrderNo_"+arrChilds[j]), 'Please provide Integer value.') == true)
					{
						document.getElementById("txtOrderNo_"+arrChilds[j]).focus();
						return;
					}
					if (disallowBlank(document.getElementById("txtCaption_"+arrChilds[j]), "'Caption' should not be blank.") == true)
					{
						document.getElementById("txtCaption_"+arrChilds[j]).focus();
						return;
					}
					if (disallowBlank(document.getElementById("txtHref_"+arrChilds[j]), "'Dashboard/Page URL' should not be left blank.") == true)
					{
						document.getElementById("txtHref_"+arrChilds[j]).focus();
						return;
					}
				}
			}
			objfrm.action="../DB/DB_ConfigureEnhancedDashboards.aspx?Action=SAVE"
			objfrm.submit();
		}
		
		function mouseOnmenu(TRid)
		{
			document.getElementById("siblTR").className="clsTROdd"
			document.getElementById("chldTR").className="clsTROdd"
			document.getElementById(TRid).className="clsTRColumnHeader"
		}

		function mouseCoords(ev)
		{
			if(ev.pageX || ev.pageY)
			{
				return {x:ev.pageX, y:ev.pageY};
			}
			return {
				x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
				y:ev.clientY -30 // + document.body.scrollTop  - document.body.clientTop
				};
		}
		function Back_Click()
		{
			objfrm.action="../General/CommonList.aspx?FromWhere=SM&MasterTagId=3722";
			objfrm.submit();
		}
		function OpenPopUp(elementclickid)
		{
			window.open ("../General/CommonList.aspx?FromWhere=&MasterTagID=3726&ParentControl=txtHref_"+elementclickid, "","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height -450)/2 + ",width=800,height=450");
		}
		
	</script>
  </body>
</html>