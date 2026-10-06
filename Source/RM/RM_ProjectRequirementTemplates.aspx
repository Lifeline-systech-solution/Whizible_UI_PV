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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RM_ProjectRequirementTemplates.aspx.vb" Inherits="PbNIT.RM_ProjectRequirementTemplates"%>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Requirement Templates")%>
	<body class='clsBody' onload='window_onload()' onresize='window_onresize()'>
		<form name="frmRMTemplate" id="frmRMTemplate" method="post" action="RM_ProjectRequirementTemplates.aspx" >
			<%PageInit()%>
		</form>
		<script>

<%DrawTreeTemplateSection()%>

var objdivMenu = document.getElementById('divMenu');
var c,sourceIMG,mouseXY,objTbl,TRno,IsanyTextBoxBlank=false,FromShowDiv=true;
var arrHidCtrlIDs=[];
var objfrm;
var objdivlist = GetObjectReference('frmRMTemplate', 'sectionDiv');
var addIMGPath = "../../Images/TreeNodeImages/user.gif";
var deleteIMGPath = "../../Images/RM/delete.gif";
var addIMGToolTip = "Add child/sibling"
var deleteIMGToolTip = "Delete section"
var const_maxLength = 1000;
var borderedImg;
var isAnyActionisTaken=false;
var sectionToFocus=null;

<%' Added By SonalD on 13th Jan 2009 %>
<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
<%End If%>
<%' Added By SonalD on 13th Jan 2009 %>
        
function window_onload()
{
//debugger;
	//fousing first elem
	if (GetObjectReference('frmRMTemplate','txtTemplateTitle'))
	GetObjectReference('frmRMTemplate','txtTemplateTitle').focus();
	//Creating Sections
	var i=0,k=0,l;
	if (Tree.length>0 )
	{
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
					Tree[k][5]=document.getElementById(Tree[k][4]).rows.length; //1
				}
				else
				{
					createSibling(k)
					Tree[k][4]='tbl_1';
					Tree[k][5]=document.getElementById('tbl_1').rows.length; //TRno+1;//Tree[k][5]+1;
				}	
				
			
			
		}
	}
	//End of creating sections
	
	objfrm = GetFormReference('frmRMTemplate');

	if (document.getElementById("firstImg"))
	{
		document.getElementById("firstImg").onmousedown=showDiv;
		document.getElementById("firstImg").tblID='tbl_1';
		document.getElementById("firstImg").TRno='1';
		document.onmousedown=function(){ if(sectionToFocus){sectionToFocus.focus();sectionToFocus=null; } if (!FromShowDiv){FromShowDiv=false;objdivMenu.style.display="none";}}
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
	
		

}

function CreateMainTable()
{
var objSecDiv = GetObjectReference('frmRMTemplate','sectionDiv');
var tbl = document.createElement("TABLE");
var newRow,newCell,Textctrl,IMGctrl;

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
newCell.colSpan=2;
newCell.innerHTML="<B><%=MyBase.GetResourceString("LBL_SECTITLE")%></B>" //"Number"; //AppResource






newRow=tbl.insertRow(1);
newRow.className='clsTREven';
newRow.style.backgroundColor="white";

newCell=newRow.insertCell(0);
newCell.align='right';
newCell.innerHTML=Tree[0][2];

Textctrl = document.createElement("INPUT");
Textctrl.type="text";
Textctrl.style.width="500px";
Textctrl.className='clsTextBox';
Textctrl.style.borderRight = "Black 1px solid";
Textctrl.style.borderLeft = "Black 1px solid";
Textctrl.style.borderTop = "Black 1px solid";
Textctrl.style.borderBottom = "Black 1px solid";
Textctrl.maxLength = const_maxLength;

Textctrl.value=Tree[0][1];

IMGctrl= document.createElement("IMG");
IMGctrl.src=addIMGPath; //"../../Images/TreeNodeImages/user.gif";
IMGctrl.title=addIMGToolTip;
IMGctrl.onmousedown=function(ev){ showDiv(ev) };
IMGctrl.id="firstImg";

newCell=newRow.insertCell(1);
newCell.appendChild(Textctrl);
newCell.appendChild(IMGctrl);


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



TRno = source.parentNode.parentNode.rowIndex+1; //window.event.srcElement.TRno;// argTRno;
//sourceIMG = evt.target || evt.srcElement;


mouseXY=mouseCoords(evt);


objdivMenu.style.display='block';
objdivMenu.style.position = 'absolute';

/*
if (navigator.appName == 'Microsoft Internet Explorer')
	source.parentNode.appendChild(objdivMenu);
else
{
objdivMenu.style.left    = mouseXY.x;
objdivMenu.style.top      = mouseXY.y;
}
*/
objdivMenu.style.left    = mouseXY.x;
objdivMenu.style.top      = mouseXY.y;
		
}


function createChild(TreeNo)
{
var seqNumber;	
var IMGctrl,Textctrl,tblID;
tblID=objTbl.id;

IMGctrl= document.createElement("IMG");
IMGctrl.src=addIMGPath;//"../../Images/TreeNodeImages/user.gif";
IMGctrl.title=addIMGToolTip;
IMGctrl.onmousedown=function(ev){ showDiv(ev) };



IMGDelctrl= document.createElement("IMG");
IMGDelctrl.src=deleteIMGPath;//"../../Images/TreeNodeImages/page.gif";
IMGDelctrl.title=deleteIMGToolTip;
IMGDelctrl.onmousedown=function(ev){ deleteSection(ev) };


Textctrl = document.createElement("INPUT");
Textctrl.type="text";
Textctrl.style.width="500px";
Textctrl.maxLength = const_maxLength;
Textctrl.className='clsTextBox';
Textctrl.style.borderRight = "Black 1px solid";
Textctrl.style.borderLeft = "Black 1px solid";
Textctrl.style.borderTop = "Black 1px solid";
Textctrl.style.borderBottom = "Black 1px solid";

if(TreeNo)
Textctrl.value=Tree[TreeNo][1];


objdivMenu.style.display='none';
	
	
	var objTbl_1 =GetObjectReference('frmRMTemplate',tblID+"_"+TRno);
	
	if(objTbl_1)
	{
		seqNumber = GetSeqNum(objTbl_1,"c");
		
		if (!TreeNo)
		{
			
			var counter,dotC=0;
			for(counter=0;counter<seqNumber.length;counter++)
			if(seqNumber.charAt(counter)==".")
			dotC++;
			if(dotC>=9)
			{
			alert("Can not add child after 10th level");
			return;
			}
		}
		newRow = objTbl_1.insertRow(objTbl_1.rows.length);
		newRow.className='clsTREven';
		newRow.style.backgroundColor="white";
		
		newCell=newRow.insertCell(0);
		newCell.innerHTML=seqNumber;
		newCell=newRow.insertCell(1);
		//++TRno;
		IMGctrl.tblID=objTbl_1.id;
		IMGctrl.TRno=objTbl_1.rows.length;
		IMGDelctrl.tblID=objTbl_1.id;
		IMGDelctrl.TRno=objTbl_1.rows.length;
	
	
		newCell.appendChild(Textctrl);
		newCell.appendChild(IMGctrl);
		newCell.appendChild(IMGDelctrl);
		
		
	
	}
	else
	{
	
		objparentTbl=GetObjectReference('frmRMTemplate',tblID);
		newParentRow = objparentTbl.insertRow(TRno); //objparentTbl.rows.length);
		newParentRow.className='clsTREven';
		newParentRow.style.backgroundColor="white";
		
		newParentCell=newParentRow.insertCell(0);
		newParentCell=newParentRow.insertCell(1);
		
		newParentCell.innerHTML="<table class=clsTable ID="+tblID+"_"+TRno+">"

		objTbl_1=GetObjectReference('frmRMTemplate',tblID+"_"+TRno);

		seqNumber = GetSeqNum(objTbl_1,"c"); 
		if (!TreeNo)
		{
			
			var counter,dotC=0;
			for(counter=0;counter<seqNumber.length;counter++)
			if(seqNumber.charAt(counter)==".")
			dotC++;
			if(dotC>=9)
			{
			alert("2Can not add child after 10th level");
			objparentTbl.deleteRow(TRno);
			return;
			}
		}
		newRow = objTbl_1.insertRow(objTbl_1.rows.length);
		newRow.className='clsTREven';
		newRow.style.backgroundColor="white";
		newCell=newRow.insertCell(0);
		newCell.innerHTML=seqNumber;
		newCell=newRow.insertCell(1);
		
		
		
		
		IMGctrl.tblID=objTbl_1.id;
		IMGctrl.TRno=objTbl_1.rows.length;
		IMGDelctrl.tblID=objTbl_1.id;
		IMGDelctrl.TRno=objTbl_1.rows.length;
		
		newCell.appendChild(Textctrl);
		newCell.appendChild(IMGctrl);
		newCell.appendChild(IMGDelctrl);
	
	}

if(!TreeNo)
{
	isAnyActionisTaken = true;	
	sectionToFocus = Textctrl;
}
return(tblID+"_"+TRno);
}

function createSibling(TreeNo)
{
var incr,IMGctrl,Textctrl,IMGDelctrl;
IMGctrl= document.createElement("IMG");
IMGctrl.src=addIMGPath;//"../../Images/TreeNodeImages/user.gif";
IMGctrl.title=addIMGToolTip;
IMGctrl.tblID=objTbl.id;
IMGctrl.TRno=objTbl.rows.length+1;
IMGctrl.onmousedown=function(ev){ showDiv(ev) };

IMGDelctrl= document.createElement("IMG");
IMGDelctrl.src=deleteIMGPath;//"../../Images/TreeNodeImages/page.gif";
IMGDelctrl.title=deleteIMGToolTip;
IMGDelctrl.tblID=objTbl.id;
IMGDelctrl.TRno=objTbl.rows.length+1;
IMGDelctrl.onmousedown=function(ev){ deleteSection(ev) };


Textctrl = document.createElement("INPUT");
Textctrl.type="text";
Textctrl.style.width="500px";
Textctrl.maxLength = const_maxLength;
Textctrl.className='clsTextBox';
Textctrl.style.borderRight = "Black 1px solid";
Textctrl.style.borderLeft = "Black 1px solid";
Textctrl.style.borderTop = "Black 1px solid";
Textctrl.style.borderBottom = "Black 1px solid";

if(TreeNo)
Textctrl.value=Tree[TreeNo][1];
	objdivMenu.style.display='none';
	
	
	
	newRow = objTbl.insertRow(objTbl.rows.length);
	newRow.className='clsTREven';
	newRow.style.backgroundColor="white";
	newCell=newRow.insertCell(0);
	newCell.align='right';
	newCell.innerHTML= GetSeqNum(objTbl,"s")//objTbl.rows.length;
	newCell=newRow.insertCell(1);
	//++TRno;
	newCell.appendChild(Textctrl);
	newCell.appendChild(IMGctrl);
	newCell.appendChild(IMGDelctrl);
if(!TreeNo)	
{
isAnyActionisTaken = true;		
sectionToFocus = Textctrl;
}
}

function GetSeqNum(objTbl,wN) //wn - Which node sibling or child
{
		
	var preSeq,postSeq,seq;
	
	if(objTbl.parentNode.tagName == "TD")
	{
		
		
		//comment For mozillaa
		//preSeq=objTbl.parentNode.parentNode.previousSibling.firstChild.innerHTML;
		preSeq=objTbl.parentNode.parentNode.parentNode.parentNode.rows[objTbl.parentNode.parentNode.rowIndex-1].cells[0].innerHTML
		
		
		
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
	
	
	

	
	//if(wN == 's')
	//{
		for(c=objTbl.rows.length-1;c>=0;c--)
		{
			if(objTbl.rows[c].cells[0].innerHTML!="")
			{
				seq=objTbl.rows[c].cells[0].innerHTML;
				
				
				
				for(incr=seq.length-1;incr>-1;incr--)
				{
					if(seq.charAt(incr) == ".")
					break;
				}
				
				if(incr != -1)
				postSeq=seq.substring(incr+1,seq.length);
				else
				postSeq=seq;
				
				
				
				//postSeq = parseInt(seq.substring(seq.length-1,seq.length));
				++postSeq;
				if(preSeq.length==1)
				return(postSeq);
				else
				return(preSeq+postSeq)
				
			}
		}
		return(preSeq+"1");
	//}
}

function deleteSection(evt)
{

	evt = window.event || evt ;
	var source = evt.target || evt.srcElement;

	if (!FromShowDiv){FromShowDiv=false;objdivMenu.style.display="none";}

	objTbl = document.getElementById(source.tblID);
	TRno = source.parentNode.parentNode.rowIndex+1;
	
	
	
	if(!confirm("Deleting section '"+source.parentNode.parentNode.cells[0].innerHTML+"' will delete all subSections under it.\n Do you want to continue?"))
	return;
	
		
		
	if(source.parentNode.parentNode.previousSibling)
	{
		//if(source.parentNode.parentNode.previousSibling.childNodes[0].innerHTML != "<%=MyBase.GetResourceString("LBL_SECNUMBER")%>"  ) //Appresource
		//{
			if(objTbl.rows.length>TRno)
			if(objTbl.rows[TRno].cells[0].innerHTML =="")
			objTbl.deleteRow(TRno);
			objTbl.deleteRow(TRno-1);
			
			if(objTbl.rows.length==0)
			{
				//objTbl.parentChild.removeChild(objTbl);
				objTbl.parentNode.parentNode.parentNode.parentNode.deleteRow(objTbl.parentNode.parentNode.rowIndex);
			}	
			
		//}
	}
	else
	{
		if(objTbl.rows.length>TRno)
			if(objTbl.rows[TRno].cells[0].innerHTML =="")
			objTbl.deleteRow(TRno);
			objTbl.deleteRow(TRno-1);
			
			if(objTbl.rows.length==0)
			{
				objTbl.parentNode.parentNode.parentNode.parentNode.deleteRow(objTbl.parentNode.parentNode.rowIndex);
			}
			
	}
	borderedImg = null;

	ModifyNumericBullets(objTbl,TRno)
	
}

function ModifyNumericBullets(objTbl,TRno)
{

	var c1=TRno-1;
	var seqNum,incr;
	while(c1<objTbl.rows.length)
	{
		if(objTbl.rows[c1].cells[0].innerHTML=="")
		{
			if(objTbl.rows[c1].cells[1].firstChild.tagName=="TABLE")
			ModifyNumericBullets(objTbl.rows[c1].cells[1].firstChild,1)
			
		}
		else
		{
		
			
			
				var preSeqNum;
				if(c1==0)
				{
					seqNum=objTbl.rows[c1].parentNode.parentNode.parentNode.parentNode.previousSibling.cells[0].innerHTML;
					objTbl.rows[c1].cells[0].innerHTML=seqNum+".1";
					
				}	
				else
				{
					if(objTbl.rows[c1-1].cells[0].innerHTML=="")
						seqNum=objTbl.rows[c1-2].cells[0].innerHTML;
					else
						seqNum=objTbl.rows[c1-1].cells[0].innerHTML;
				
					
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
							
						objTbl.rows[c1].cells[0].innerHTML=preSeqNum+seqNum;
						
					}
				}
			
			
		}
		c1++;
	}
}



function window_onresize()
{
	/*	var intDivHeight ;
		
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
		}
		else{
		intDivHeight = window.innerHeight - 42;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
				
		objdivlist.style.height = intDivHeight;
		*/
		
}

function createHiddenControls(objTbl,TRno)
{
	var hidCtrl;
	var c1=TRno;
	
	while(c1<objTbl.rows.length)
	{
		if(objTbl.rows[c1].cells[0].innerHTML=="")
		{
			if(objTbl.rows[c1].cells[1].firstChild.tagName=="TABLE")
			createHiddenControls(objTbl.rows[c1].cells[1].firstChild,0)
			
		}
		else
		{
			if(GetObjectReference('frmRMTemplate',objTbl.rows[c1].cells[0].innerHTML))
			//document.removeChild(GetObjectReference('frmRMTemplate',objTbl.rows[c1].cells[0].innerHTML));
			objfrm.removeChild(GetObjectReference('frmRMTemplate',objTbl.rows[c1].cells[0].innerHTML));
			
			if(isBlank(objTbl.rows[c1].cells[1].firstChild.value))
			{	
			
					if(IsanyTextBoxBlank==false)
					{
						IsanyTextBoxBlank=true;
						alert("Please enter value for Section Title "+ objTbl.rows[c1].cells[0].innerHTML );
						objTbl.rows[c1].cells[1].firstChild.focus();
					}
			}
			
			
			hidCtrl=document.createElement("INPUT");
			hidCtrl.type="hidden";
			hidCtrl.name=objTbl.rows[c1].cells[0].innerHTML;
			hidCtrl.id=objTbl.rows[c1].cells[0].innerHTML;
			hidCtrl.value=objTbl.rows[c1].cells[1].firstChild.value;
			
			
			objfrm.appendChild(hidCtrl);
			arrHidCtrlIDs.push(hidCtrl.name);
			//create element
		}
		c1++;
	}

}


function Save_Click()
{
	var objTempTitle = GetObjectReference(objfrm.id,'txtTemplateTitle');
	//var objTempCode = GetObjectReference(objfrm.id,'txtTemplateCode');
	if(isBlank(objTempTitle.value))
	{ alert("Please enter Template Title"); objTempTitle.focus(); return; }
	//if(isBlank(objTempCode.value))
	//{ alert("Please enter Template Code"); objTempCode.focus(); return; }
	
	var allTitles  = GetObjectReference('frmRMTemplate','cboAllTemplateTitles');
	var i=0;
	for(i=0;i<allTitles.options.length;i++)
	{
		if (objTempTitle.value == allTitles.options[i].value)
		{
			alert("Template '" + objTempTitle.value + "' is already exists. Please enter different Template title.");
			return;
		}
	}
	
	if(document.getElementById("tbl_1"))
	{
		arrHidCtrlIDs=null;
		arrHidCtrlIDs=new Array();
		createHiddenControls(document.getElementById("tbl_1"),1);
		if(IsanyTextBoxBlank==true)
		{
			for(c=0;c<arrHidCtrlIDs.length;c++)
			objfrm.removeChild(GetObjectReference('frmRMTemplate',arrHidCtrlIDs[c]));
			arrHidCtrlIDs=null;
			arrHidCtrlIDs=new Array();
			IsanyTextBoxBlank=false;
			return;
		}
		GetObjectReference('frmRMTemplate','hidSectionNums').value=arrHidCtrlIDs;
	}
	
	objfrm.action="../RM/RM_ProjectRequirementTemplates.aspx?Action=SAVE"
	objfrm.submit();
}
function mouseOnmenu(TRid)
{
	document.getElementById("siblTR").className="clsTROdd"
	document.getElementById("chldTR").className="clsTROdd"
	document.getElementById(TRid).className="clsTRColumnHeader"
}

function mouseCoords(ev){
	if(ev.pageX || ev.pageY){
	
		return {x:ev.pageX, y:ev.pageY};
	}
	//debugger;
	return {
	
		x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
		y:ev.clientY + document.body.scrollTop  - document.body.clientTop
	};
}
function Back_Click()
{

	if(isAnyActionisTaken)
	if(!confirm("Going back would lose changes. Do you want to continue?"))
	return;
	
	objfrm.action="../RM/RMTemplate_CommonList.aspx?FromWhere=DB&MasterTagId=3733&ProjectID="+GetObjectReference('','hidProjectID').value;

	objfrm.submit();
}

		</script>
	</body>
</HTML>
