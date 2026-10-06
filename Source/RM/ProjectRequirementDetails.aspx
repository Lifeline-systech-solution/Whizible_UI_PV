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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectRequirementDetails.aspx.vb" Inherits="PbNIT.ProjectRequirementDetails"%>
<%@ Register TagPrefix="ftb" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Requirement Templates")%>
	<body MS_POSITIONING="GridLayout" class='clsPageBody' onload='window_onload()' onresize='window_onresize()'>
		
					<form id="frmPrjReqDetails" method="post" runat="server" >
					
									<div id="divCt" style="DISPLAY:none">
										<div id="FreeTextCt" style="DISPLAY:none">
											<table cellpadding="0" cellspacing="0">
												<tr>
													<td>
														<FTB:FreeTextBox id="FreeTextBox1" runat="server" ButtonPath="../../images/ftb/officeXP/" Text="This is a test."
															ImageGalleryPath="images/RM/UploadedFiles/"></FTB:FreeTextBox>
													</td>
												</tr>
												<tr>
													<td align="right">
														<a class='Menu' href="Javascript:setFreeTB()">Set</a>
													</td>
												</tr>
											</table>
										</div>
									</div>
							<input type="hidden" name="hidSectionNums" id="hidSectionNums">
							
						
									<%PageInit()%>
						
					</form>
				
					<script>
	
		
		
		<%DrawTreeTemplateSection()%>

var objdivMenu = document.getElementById('divMenu');
var c,sourceIMG,mouseXY,objTbl,TRno,IsanyTextBoxBlank=false,FromShowDiv=true;
var arrHidCtrlIDs=[];
var arrHidEditedCtrlIDs=[];
var objfrm;
var objdivlist = GetObjectReference('frmRMTemplate', 'sectionDiv');
var addIMGPath = "../../Images/TreeNodeImages/user.gif";
var deleteIMGPath = "../../Images/RM/delete.gif";
var addIMGToolTip = "Click here to view action"
var deleteIMGToolTip = "Delete section"
var const_maxLength = 1000;
var borderedImg,IMGProgressctrl;

var childNodesLimit = 3;

var foucsedCt,hidFreeTxtValue,objdivCt,objFreeTxtCt,SecTBCt ;


var strKeyValueForDetails;

        <%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>

function window_onload()
{

//setInterval(checkAddDeleteSection,120000);
objdivCt = document.getElementById('divCt');
objFreeTxtCt = document.getElementById('FreeTextCt');
	//fousing first elem
	if (GetObjectReference('frmRMTemplate','txtTemplateTitle'))
	GetObjectReference('frmRMTemplate','txtTemplateTitle').focus();
	//Creating Sections
	var i=0,k=0,l;
	if (Tree.length>0 )
	{
	
		IMGProgressctrl=document.createElement("IMG");
		IMGProgressctrl.style.width = "100%"
		IMGProgressctrl.src="../../Images/RM/ProgressBar.gif";
		
		CreateMainTable();
		
		for(k=1;k<Tree.length;k++)
		{
			if(Tree[k][3]!="")
			{
				for(i=k-1;i>-1;i--)
				{
					if(Tree[i][0]==Tree[k][3])
					break;
				}
			}
			else
			{
				for(i=k-1;i>-1;i--)
				{
					if(Tree[i][3]=="")
					break;
					
				}
				
			}
				TRno=Tree[i][5];
				objTbl = document.getElementById(Tree[i][4]);
				
				if (Tree[k][3]!='')
				{
					Tree[k][4]=createChild(k)
					Tree[k][5]=document.getElementById(Tree[k][4]).rows.length; //1;
				}
				else
				{
					TRno=objTbl.rows.length;
					createSibling(k)
					Tree[k][4]='tbl_1';
					Tree[k][5]=document.getElementById('tbl_1').rows.length; //TRno+1;//Tree[k][5]+1;
				}	
			
		}
	}
	//End of creating sections
	
	objfrm = GetFormReference('frmPrjReqDetails');
	hidFreeTxtValue=document.getElementById('FreeTextBox1');
	if (document.getElementById("firstImg"))
	{
		document.getElementById("firstImg").onmousedown=showDiv;
		document.getElementById("firstImg").tblID='tbl_1';
		document.getElementById("firstImg").TRno='1';
		document.onmousedown=function(){ if (!FromShowDiv){FromShowDiv=false;objdivMenu.style.display="none";}}
		document.onmousemove=function(evt){
						FromShowDiv =false;
							evt = window.event || evt ;
							var source = evt.target || evt.srcElement;
							if (source.tagName =="IMG")
							{
								if(borderedImg)
								borderedImg.border=0;
								
								if(source.tblID)
								{
									source.border=1;
									source.bgColor="red";
									borderedImg = source;
								}
							}
							else if(borderedImg)
							borderedImg.border=0;
						
							}
		document.getElementById('editTR').onmousedown=function(evt){showSectionTextBox(evt);}
		document.getElementById('siblTR').onmousedown=function(evt){createSibling(evt);}
		document.getElementById('chldTR').onmousedown=function(evt){createChild(evt);}
		document.getElementById('deleteTR').onmousedown=function(evt){deleteSection(evt);}
							
	}
	
		var intDivHeight ;

		if(objdivlist)
		{
			if (navigator.appName == 'Microsoft Internet Explorer'){
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
			}
			else{
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 42;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight;
		}
}

function window_onresize()
{
	var intDivHeight ;
	var intDivHeightRisk;
	if (navigator.appName == 'Microsoft Internet Explorer'){
	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
	}
	else{
	intDivHeight = window.innerHeight - 42;
	}
	if (intDivHeight < 100)
		intDivHeight = 100;
			
	objdivlist.style.height = intDivHeight;
	
}


function CreateMainTable()
{
var objSecDiv = GetObjectReference('frmRMTemplate','sectionDiv');
var tbl = document.createElement("TABLE");
//tbl.border=1;
var newRow,newCell,IMGctrl;

tbl.className='clsGridTable';
tbl.style.backgroundColor="white";
tbl.cellSpacing=0;//1;
tbl.cellPadding=0;
tbl.width='100%';
tbl.id=Tree[0][4];


tbl.createTHead();

tbl.tHead.className='clsTRColumnHeader';
newRow=tbl.tHead.insertRow(0);

newCell=newRow.insertCell(0);
newCell.colSpan=3;
newCell.innerHTML="<B><%=MyBase.GetResourceString("LBL_SECTITLE")%></B>" //"Number"; //AppResource

newRow=tbl.insertRow(1); 
newRow.className='clsTREven';
newRow.style.backgroundColor="white";

IMGctrl= document.createElement("IMG");
IMGctrl.src=addIMGPath; 
IMGctrl.title=addIMGToolTip;
IMGctrl.onmousedown=function(ev){ showDiv(ev) };
IMGctrl.id="firstImg";

newCell=newRow.insertCell(0);
newCell.width="10px";
newCell.vAlign="center";
newCell.align="right";

//newCell.noWrap=true;
newCell.appendChild(IMGctrl);

newCell=newRow.insertCell(1);
newCell.style.fontWeight="bolder";
newCell.width="15px";
newCell.align='left';
newCell.innerHTML=Tree[0][2];

newCell=newRow.insertCell(2);
newCell.width="98%";

newCell.style.fontWeight="bolder";
newCell.innerHTML=Tree[0][1];


//Extra Addition for FreeTextBox
newRow=tbl.insertRow(2);
newRow.className='clsTREven';
newRow.style.backgroundColor="white";
newCell=newRow.insertCell(0);
newCell=newRow.insertCell(1);
newCell=newRow.insertCell(2);
newCell.innerHTML=Tree[0][6];

//End of extra addition
objSecDiv.appendChild(tbl);

}

function showDiv(evt)
{

evt = window.event || evt ;
var source = evt.target || evt.srcElement;

if (source.tagName=="IMG")
	source.border=2;

FromShowDiv = true;

objTbl = document.getElementById(source.tblID);

TRno = source.parentNode.parentNode.rowIndex+1; 

mouseXY=mouseCoords(evt);

objdivMenu.style.display='block';
objdivMenu.style.position = 'absolute';

objdivMenu.style.left    = mouseXY.x;
objdivMenu.style.top      = mouseXY.y;
		
}


function createChild(TreeNo)
{

var seqNumber;	
var IMGctrl,tblID;
tblID=objTbl.id;

IMGctrl= document.createElement("IMG");
IMGctrl.src=addIMGPath;
IMGctrl.title=addIMGToolTip;
IMGctrl.onmousedown=function(ev){ showDiv(ev) };


objdivMenu.style.display='none';
var objTbl_1 =GetObjectReference('frmRMTemplate',tblID+"_"+TRno);
	if(objTbl_1)
	{
		seqNumber = GetSeqNum(objTbl_1,"c");
		
		
		newRow = objTbl_1.insertRow(objTbl_1.rows.length);
		newRow.className='clsTREven';
		newRow.style.backgroundColor="white";
		
		newCell=newRow.insertCell(0);
		newCell.appendChild(IMGctrl);
		
		newCell=newRow.insertCell(1);
		newCell.style.fontWeight="bolder";
		newCell.innerHTML=seqNumber;

		newCell=newRow.insertCell(2);

		IMGctrl.tblID=objTbl_1.id;
		IMGctrl.TRno=objTbl_1.rows.length;
		
		
		newCell.style.fontWeight="bolder";
		if(TreeNo)
		newCell.innerHTML=Tree[TreeNo][1];
		else
		newCell.innerHTML="";
		
		//Extra Addition for FreeTextBox
		newRow = objTbl_1.insertRow(objTbl_1.rows.length);
		newRow.className='clsTREven';
		newRow.style.backgroundColor="white";
		newCell=newRow.insertCell(0);
		newCell=newRow.insertCell(1);
		newCell=newRow.insertCell(2);
		if(TreeNo)
		newCell.innerHTML=Tree[TreeNo][6];
		//End of extra addition
	
	}
	else
	{
	
		objparentTbl=GetObjectReference('frmRMTemplate',tblID);
		
		if(objparentTbl.rows.length >= (TRno+1))
		newParentRow = objparentTbl.insertRow(TRno+1); 
		else
		newParentRow = objparentTbl.insertRow(TRno); 
		
		newParentRow.className='clsTREven';
		newParentRow.style.backgroundColor="white";
		
		newParentCell=newParentRow.insertCell(0);
		newParentCell=newParentRow.insertCell(1);
		newParentCell=newParentRow.insertCell(2);
		
		
		newParentCell.innerHTML="<table  class=clsTable ID="+tblID+"_"+TRno+">"
		
		objTbl_1=GetObjectReference('frmRMTemplate',tblID+"_"+TRno);

		seqNumber = GetSeqNum(objTbl_1,"c"); 
		if (!TreeNo)
		{
			
			var counter,dotC=0;
			for(counter=0;counter<seqNumber.length;counter++)
			if(seqNumber.charAt(counter)==".")
			dotC++;
			if(dotC>=childNodesLimit)
			{
				alert("Can not add child after "+childNodesLimit+"th level");
				try{objparentTbl.deleteRow(TRno+1);}catch(e){objparentTbl.deleteRow(TRno);}
			return;
			}
		}
		newRow = objTbl_1.insertRow(objTbl_1.rows.length);
		newRow.className='clsTREven';
		newRow.style.backgroundColor="white";
		
		newCell=newRow.insertCell(0);
		newCell.appendChild(IMGctrl);
		
		newCell=newRow.insertCell(1);
		newCell.style.fontWeight="bolder";
		newCell.innerHTML=seqNumber;
		newCell=newRow.insertCell(2);
		
		IMGctrl.tblID=objTbl_1.id;
		IMGctrl.TRno=objTbl_1.rows.length;
		
		newCell.style.fontWeight="bolder";
		if(TreeNo)
		newCell.innerHTML=Tree[TreeNo][1];
		else
		newCell.innerHTML="";
		
		//Extra Addition for FreeTextBox
		newRow = objTbl_1.insertRow(objTbl_1.rows.length);
		newRow.className='clsTREven';
		newRow.style.backgroundColor="white";
		newCell=newRow.insertCell(0);
		newCell=newRow.insertCell(1);
		newCell=newRow.insertCell(2);
		if(TreeNo)
		newCell.innerHTML=Tree[TreeNo][6];
		//End of extra addition
	
	}

return(tblID+"_"+TRno);
}


function createSibling(TreeNo)
{

var incr,IMGctrl;//,IMGDelctrl;
IMGctrl= document.createElement("IMG");
IMGctrl.src=addIMGPath;
IMGctrl.title=addIMGToolTip;
IMGctrl.tblID=objTbl.id;
if(TRno+1 >= objTbl.rows.length)
{
TRno = objTbl.rows.length-1;
}
else
{
	if(!TreeNo)
	{
		if(objTbl.rows[TRno+1].cells[2].firstChild.tagName == "TABLE")
		{
			TRno=TRno+1;
		}

	}
}




IMGctrl.TRno=TRno+1; //objTbl.rows.length+1;
IMGctrl.onmousedown=function(ev){ showDiv(ev) };



objdivMenu.style.display='none';

	newRow = objTbl.insertRow(TRno+1);//objTbl.rows.length);
	newRow.className='clsTREven';
	newRow.style.backgroundColor="white";
	newCell=newRow.insertCell(0);
	newCell.appendChild(IMGctrl);
	
	newCell=newRow.insertCell(1);

	newCell.style.fontWeight="bolder";
	newCell.innerHTML= GetSeqNum(objTbl,"s");
	newCell=newRow.insertCell(2);
	
	newCell.style.fontWeight="bolder";
	if(TreeNo)
	newCell.innerHTML=Tree[TreeNo][1];
	else
	newCell.innerHTML="";
	
	
	//Extra Addition for FreeTextBox
		newRow = objTbl.insertRow(TRno+2);//objTbl.rows.length);
		newRow.className='clsTREven';
		newRow.style.backgroundColor="white";
		newCell=newRow.insertCell(0);
		newCell=newRow.insertCell(1);
		newCell=newRow.insertCell(2);
		if(TreeNo)
		newCell.innerHTML=Tree[TreeNo][6];
	//End of extra addition
	
if(!TreeNo)
ModifyNumericBullets(objTbl,TRno+2);
	
	
}

function GetSeqNum(objTbl,wN) //wn - Which node sibling or child
{
		
	var preSeq,postSeq,seq;
	
	if(1==1) //wN!='s')
	{
			if(objTbl.parentNode.tagName == "TD")
			{
				//comment For mozillaa
				//preSeq=objTbl.parentNode.parentNode.previousSibling.firstChild.innerHTML;
				preSeq=objTbl.parentNode.parentNode.parentNode.parentNode.rows[objTbl.parentNode.parentNode.rowIndex-2].cells[1].innerHTML
				
				preSeq = preSeq+".";
			}
			else
			{
				
				preSeq = objTbl.id.substring(4);
				for(c=0;c<preSeq.length;c++)
				{
					if(preSeq.charAt(c)=="_")
					preSeq = preSeq.substring(0,c)+"."+preSeq.substring(c+1,preSeq.length);
				}
				preSeq = preSeq.substring(0,preSeq.length-1)

			}
				for(c=objTbl.rows.length-1;c>=0;c--)
				{
					if(objTbl.rows[c].cells[1].innerHTML!="")
					{
						seq=objTbl.rows[c].cells[1].innerHTML;
						
						for(incr=seq.length-1;incr>-1;incr--)
						{
							if(seq.charAt(incr) == ".")
							break;
						}
						
						if(incr != -1)
						postSeq=seq.substring(incr+1,seq.length);
						else
						postSeq=seq;
						
						++postSeq;
						if(preSeq.length==1)
						return(postSeq);
						else
						return(preSeq+postSeq)
						
					}
				}
				return(preSeq+"1");
	}
	
}

function deleteSection(evt)
{

	if(objTbl.id=="tbl_1" && TRno==2)
	{
	alert("Can not delete section 1");
	return;
	}

	if(foucsedCt)
	{
		try {
		FTB_CopyHtmlToHidden(FreeTextBox1_editor,document.getElementById('FreeTextBox1'),FreeTextBox1_HtmlMode);
		foucsedCt.removeChild(objFreeTxtCt);
		objdivCt.appendChild(objFreeTxtCt);
		foucsedCt.innerHTML=hidFreeTxtValue.value;
		if(SecTBCt)
		{SecTBCt.innerHTML = SecTBCt.firstChild.value;SecTBCt=null;}
		} catch(e){alert("Error 1001");}
		foucsedCt=null;
	}
	

	evt = window.event || evt ;
	var source = evt.target || evt.srcElement;

	if (!FromShowDiv){FromShowDiv=false;objdivMenu.style.display="none";}

	if(!confirm("Deleting section '"+objTbl.rows[TRno-1].cells[1].innerHTML+"' will delete all subSections under it.\n Do you want to continue?"))
	return;
	
	
	
			
			if(objTbl.rows.length>TRno+1)
			if(objTbl.rows[TRno+1].cells[0].innerHTML =="")
			{ objTbl.deleteRow(TRno+1); }
			
			objTbl.deleteRow(TRno);
			objTbl.deleteRow(TRno-1);
			
			
			if(objTbl.rows.length==0)
			{
				//objTbl.parentChild.removeChild(objTbl);
				objTbl.parentNode.parentNode.parentNode.parentNode.deleteRow(objTbl.parentNode.parentNode.rowIndex);
			}	
			
	borderedImg = null;
		
	ModifyNumericBullets(objTbl,TRno);
	
}

function ModifyNumericBullets(objTbl,TRno)
{

	var c1=TRno-1;
	var seqNum,incr;
	while(c1<objTbl.rows.length)
	{
		if(objTbl.rows[c1].cells[1].innerHTML=="")
		{
			if(objTbl.rows[c1].cells[2].firstChild)
			if(objTbl.rows[c1].cells[2].firstChild.tagName=="TABLE")
			ModifyNumericBullets(objTbl.rows[c1].cells[2].firstChild,1)
			
		}
		else
		{
		
			var preSeqNum;
			if(c1==0)
			{
				seqNum=objTbl.rows[c1].parentNode.parentNode.parentNode.parentNode.previousSibling.previousSibling.cells[1].innerHTML
				objTbl.rows[c1].cells[1].innerHTML=seqNum+".1";
				
			}	
			else
			{
				if(c1>=2 &&  objTbl.rows[c1-2].cells[1].innerHTML=="" ) //blank rows second col
					seqNum=objTbl.rows[c1-3].cells[1].innerHTML;
				else if(c1>=1 && objTbl.rows[c1-1].cells[1].innerHTML==""  )
					seqNum=objTbl.rows[c1-2].cells[1].innerHTML;
				else
					seqNum=objTbl.rows[c1].cells[1].innerHTML;
			
				
				if (seqNum != "")
				{
					for(incr=seqNum.length-1;incr>-1;incr--)
					{
						if(seqNum.charAt(incr) == ".")
						break;
					}
					
					if(incr != -1)
					preSeqNum=seqNum.substring(0,incr+1);
					else
					preSeqNum="";
					
					if(c1!=0)
					{
						seqNum=parseInt(seqNum.substring(incr+1,seqNum.length));
						seqNum++;
					}
					else
					{
						seqNum=".1";
					}
						
					objTbl.rows[c1].cells[1].innerHTML=preSeqNum+seqNum;
					
				}
			}
		
		}
		c1++;
	}
}

function createHiddenControls(objTbl,TRno)
{

	var hidCtrl;
	var c1=TRno;
	
	while(c1<objTbl.rows.length)
	{
		if(objTbl.rows[c1].cells[1].innerHTML=="")
		{
			if(objTbl.rows[c1].cells[2].firstChild)
			if(objTbl.rows[c1].cells[2].firstChild.tagName=="TABLE")
			createHiddenControls(objTbl.rows[c1].cells[2].firstChild,0)
			c1--;
		}
		else
		{
			
			
			if(isBlank(objTbl.rows[c1].cells[2].innerHTML))
			{	
			
					if(IsanyTextBoxBlank==false)
					{
						IsanyTextBoxBlank=true;
						alert("Please enter value for Section Title "+ objTbl.rows[c1].cells[1].innerHTML );
						//objTbl.rows[c1].cells[2].firstChild.focus(); create here text box and set focus
					}
			}
			
			
			if(GetObjectReference('frmPrjReqDetails',objTbl.rows[c1].cells[1].innerHTML))
			{
				GetObjectReference('frmPrjReqDetails',objTbl.rows[c1].cells[1].innerHTML).value=objTbl.rows[c1].cells[2].innerHTML;
				arrHidCtrlIDs.push(objTbl.rows[c1].cells[1].innerHTML);	
			}
			else
			{
				hidCtrl=document.createElement("INPUT");
				hidCtrl.type="hidden";
				hidCtrl.name=objTbl.rows[c1].cells[1].innerHTML;
				hidCtrl.id=objTbl.rows[c1].cells[1].innerHTML;
				hidCtrl.value=objTbl.rows[c1].cells[2].innerHTML;
				objfrm.appendChild(hidCtrl);
				arrHidCtrlIDs.push(hidCtrl.name);	
			}
			
			
			
			//create element
		}
		c1=c1+2;
	}

}



function mouseOnmenu(TRid)
{
	document.getElementById("siblTR").className="clsTROdd"
	document.getElementById("chldTR").className="clsTROdd"
	document.getElementById("editTR").className="clsTROdd"
	document.getElementById("deleteTR").className="clsTROdd"
	document.getElementById(TRid).className="clsTRColumnHeader"
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
function Back_Click()
{
	
	objfrm.action="../General/CommonList.aspx?FromWhere=SM&MasterTagId=3717";

	objfrm.submit();
}

function createDetailKeyValues(objTbl,TRno)
{
	var c1=TRno;
	
	while(c1<objTbl.rows.length)
	{
		
		strKeyValueForDetails = strKeyValueForDetails + "&Deta"+objTbl.rows[c1].cells[1].innerHTML +"="+escape(objTbl.rows[c1+1].cells[2].innerHTML);
			
		
		
		if((c1+2)<objTbl.rows.length && objTbl.rows[c1+2].cells[2].firstChild)
		{
			if(objTbl.rows[c1+2].cells[2].firstChild.tagName=="TABLE")
			{
				createDetailKeyValues(objTbl.rows[c1+2].cells[2].firstChild,0)
				c1=c1+3;
			}
			else
			c1=c1+2;
		}
		else
		c1=c1+2;
			
		
		
	}

}

function createSectionKeyValues()
{
if(document.getElementById("tbl_1"))
	{
		arrHidCtrlIDs=null;
		arrHidCtrlIDs=new Array();
		createHiddenControls(document.getElementById("tbl_1"),1);
		if(IsanyTextBoxBlank==true)
		{
			
			for(c=0;c<arrHidCtrlIDs.length;c++)
			GetObjectReference(objfrm.id,arrHidCtrlIDs[c]).parentNode.removeChild(GetObjectReference(objfrm.id,arrHidCtrlIDs[c]));
			arrHidCtrlIDs=null;
			arrHidCtrlIDs=new Array();
			return("");
		}
		GetObjectReference(objfrm.id,'hidSectionNums').value=arrHidCtrlIDs;
	}
	var hidArrCtrl = GetObjectReference(objfrm.id,'hidSectionNums').value.split(",");
	var strSendToServer="";
	for(c=0;c<hidArrCtrl.length;c++)
	{
		strSendToServer = strSendToServer+"&"+hidArrCtrl[c]+"="+escape(document.getElementById(hidArrCtrl[c]).value);
	}
	//strSendToServer = strSendToServer.substring(1,strSendToServer.length);
	var strSendToServer1 = "hidProjectRequirementID="+document.getElementById('hidProjectRequirementID').value;
	strSendToServer1 = strSendToServer1 +"&cboRMTemplate="+document.getElementById('cboRMTemplate').value;
	strSendToServer = strSendToServer1+"&hidSectionNums="+document.getElementById('hidSectionNums').value + strSendToServer ;

	return (strSendToServer);
}
function createFormKeyValues()
{
	var strSectionKeyValue=createSectionKeyValues();

	strKeyValueForDetails = "";
	createDetailKeyValues(document.getElementById('tbl_1'),1);
	return(strSectionKeyValue+strKeyValueForDetails);
}


function showFreeTextBox(evt)
{
evt = evt || window.event;

var source = evt.target || evt.srcElement;
var srcTable;
srcTable=objTbl; 
		

try  ///////////////////
{ ///////////////////
		

if(foucsedCt)
{
	FTB_CopyHtmlToHidden(FreeTextBox1_editor,document.getElementById('FreeTextBox1'),FreeTextBox1_HtmlMode);
	foucsedCt.removeChild(objFreeTxtCt);
	objdivCt.appendChild(objFreeTxtCt);
	foucsedCt.innerHTML=hidFreeTxtValue.value;
}

FreeTextBox1_editor.document.body.innerHTML=hidFreeTxtValue.value;

foucsedCt=srcTable.rows[TRno].cells[2];

hidFreeTxtValue.value=foucsedCt.innerHTML; 

foucsedCt.innerHTML="";

var objCon = foucsedCt;

objdivCt.removeChild(objFreeTxtCt);

objCon.appendChild(objFreeTxtCt);
objFreeTxtCt.style.display="block";

FreeTextBox1_editor.document.body.innerHTML=hidFreeTxtValue.value;

} ///////////////////
catch(e) {

hidFreeTxtValue=document.getElementById('FreeTextBox1');
var oDesignView=document.getElementById('FTB_FreeTextBox1_DesignModeDiv');
if(foucsedCt)
{
	foucsedCt.removeChild(objFreeTxtCt);
	objdivCt.appendChild(objFreeTxtCt);
	foucsedCt.innerHTML=hidFreeTxtValue.value;
}
foucsedCt=srcTable.rows[TRno].cells[2];

hidFreeTxtValue.value=foucsedCt.innerHTML; 
oDesignView.innerHTML=foucsedCt.innerHTML; 

foucsedCt.innerHTML="";

var objCon = foucsedCt;

objdivCt.removeChild(objFreeTxtCt);

objCon.appendChild(objFreeTxtCt);
objFreeTxtCt.style.display="block";


}

}

//xmlHttp functions
var xmlhttp;
function loadXMLDoc(url,reqQuery)
{
// code for Mozilla, etc.

if (window.XMLHttpRequest)
  {
  
		xmlhttp=new XMLHttpRequest()
		xmlhttp.onreadystatechange=state_Change;
		if (ns)
		{
			xmlhttp.open("GET",url+"&"+reqQuery,true)
			xmlhttp.send(false)
		}
		else
		{
			xmlhttp.open("POST",url,true)
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
			xmlhttp.open("POST",url,true)
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
	alert("Requirement is saved");
	showMenu();
	arrHidEditedCtrlIDs=[];
  }
  else
  {
  alert("Problem in saving data:" + xmlhttp.statusText)
  }
  }
}

function hideMenu()
{
	GetObjectReference(objfrm.id,"tblMenuU").style.display="none";
	GetObjectReference(objfrm.id,"tblMenuB").style.display="none";
	if(IMGProgressctrl)
	GetObjectReference(objfrm.id,"divMenuB").appendChild(IMGProgressctrl);
	
}
function showMenu()
{
	GetObjectReference(objfrm.id,"tblMenuU").style.display="block";
	GetObjectReference(objfrm.id,"tblMenuB").style.display="block";
	GetObjectReference(objfrm.id,"divMenuB").removeChild(IMGProgressctrl);
}

function Save_Click()
{
	hideMenu();
	var strKeyValue,url;
	
	if(document.getElementById('tbl_1'))
	{
		url="ProjectRequirementDetails.aspx?Mode=XMLHTTP";

		if(foucsedCt)
			{
				try {
				FTB_CopyHtmlToHidden(FreeTextBox1_editor,document.getElementById('FreeTextBox1'),FreeTextBox1_HtmlMode);
				foucsedCt.removeChild(objFreeTxtCt);
				objdivCt.appendChild(objFreeTxtCt);
				foucsedCt.innerHTML=hidFreeTxtValue.value;
				} catch(e){}
				foucsedCt=null;
			}
		if(SecTBCt)
		{SecTBCt.innerHTML = SecTBCt.firstChild.value;SecTBCt=null;}
		
		url=url+"&SaveSectionAndDetails=TRUE"; 

		
		strKeyValue=createFormKeyValues();
		strKeyValue=strKeyValue+"&hidEditedSectionNums="+arrHidEditedCtrlIDs;
		if(IsanyTextBoxBlank==true)
			{  IsanyTextBoxBlank=false; showMenu();}
		else
		loadXMLDoc(url,strKeyValue);
	
	}
	else
	{
		objfrm.action='ProjectRequirementDetails.aspx?Mode=SAVE';
		objfrm.submit();
	}
}
function showSectionTextBox(ev)
{
	var Textctrl;
	ev = ev || window.event;
	
	
	
	
	for(c=0;c<arrHidEditedCtrlIDs.length;c++)
	{
		if(arrHidEditedCtrlIDs[c]==objTbl.rows[TRno-1].cells[1].innerHTML)
		break;
	}
	if(c==arrHidEditedCtrlIDs.length) // || arrHidEditedCtrlIDs.length == 0)
	arrHidEditedCtrlIDs.push(objTbl.rows[TRno-1].cells[1].innerHTML)
	
	
	
	if(SecTBCt)
	{SecTBCt.innerHTML = SecTBCt.firstChild.value; SecTBCt=null;}

	Textctrl = document.createElement("INPUT");
	Textctrl.type="text";
	Textctrl.style.width="500px";
	Textctrl.className='clsTextBox';
	Textctrl.style.borderRight = "Black 1px solid";
	Textctrl.style.borderLeft = "Black 1px solid";
	Textctrl.style.borderTop = "Black 1px solid";
	Textctrl.style.borderBottom = "Black 1px solid";
	Textctrl.maxLength = const_maxLength;

	Textctrl.value=objTbl.rows[TRno-1].cells[2].innerHTML;
	objTbl.rows[TRno-1].cells[2].innerHTML = "";
	objTbl.rows[TRno-1].cells[2].appendChild(Textctrl);

	SecTBCt = objTbl.rows[TRno-1].cells[2];
	
	showFreeTextBox(ev);
	
}
function setFreeTB()
{
if(SecTBCt)
	{ SecTBCt.innerHTML = SecTBCt.firstChild.value;  SecTBCt=null; }

if(foucsedCt)
{
	try {
	FTB_CopyHtmlToHidden(FreeTextBox1_editor,document.getElementById('FreeTextBox1'),FreeTextBox1_HtmlMode);
	foucsedCt.removeChild(objFreeTxtCt);
	objdivCt.appendChild(objFreeTxtCt);
	foucsedCt.innerHTML=document.getElementById('FreeTextBox1').value;
	} catch(e){alert("Error");}
			
			foucsedCt=null;
}
		
}
function View_Click()
{
	window.open("ProjectRequirementDetailsView.aspx?ProjectRequirementID="+document.getElementById("hidProjectRequirementID").value+"","_new","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
}
function History_Click()
{
	window.open("RM_DetailsHistory.aspx?ProjectRequirementID="+document.getElementById("hidProjectRequirementID").value,"_new","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=950,height=600");
}
					</script>
				
	</body>
</HTML>
