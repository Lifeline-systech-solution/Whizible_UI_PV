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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectRequirementDetailsView.aspx.vb" Inherits="PbNIT.ProjectRequirementDetailsView"%>

<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Requirement Templates")%>
	<body MS_POSITIONING="GridLayout" class='clsPageBody' onload='window_onload()' onresize='window_onresize()'>
		<form id="frmPrjReqDetailsView" method="post" runat="server">
<!--			<div id="divCt" style="DISPLAY:none">
				<div id="FreeTextCt" style="DISPLAY:none">&nbsp;
				</div>
			</div>
	-->
			<%PageInit()%>
		</form>
		<script>
	
		
		
		<%DrawTreeTemplateSection()%>

//var objdivMenu = document.getElementById('divMenu');
var c,sourceIMG,mouseXY,objTbl,TRno,IsanyTextBoxBlank=false,FromShowDiv=true;
var arrHidCtrlIDs=[];
var objfrm;
var objdivlist = GetObjectReference('frmPrjReqDetailsView', 'sectionDiv');
var addIMGPath = "../../Images/TreeNodeImages/user.gif";
var deleteIMGPath = "../../Images/RM/delete.gif";
var addIMGToolTip = "Click here to view action"
var deleteIMGToolTip = "Delete section"
var const_maxLength = 1000;
var borderedImg;

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

objdivCt = document.getElementById('divCt');
objFreeTxtCt = document.getElementById('FreeTextCt');
	//fousing first elem
	if (GetObjectReference('frmPrjReqDetailsView','txtTemplateTitle'))
	GetObjectReference('frmPrjReqDetailsView','txtTemplateTitle').focus();
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
	
	objfrm = GetFormReference('frmPrjReqDetailsView');
	hidFreeTxtValue=document.getElementById('FreeTextBox1');
	if (document.getElementById("firstImg"))
	{
		document.getElementById("firstImg").onmousedown=showDiv;
		document.getElementById("firstImg").tblID='tbl_1';
		document.getElementById("firstImg").TRno='1';
							
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
var objSecDiv = GetObjectReference('frmPrjReqDetailsView','sectionDiv');
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

newCell=newRow.insertCell(0);
newCell.width="10px";
newCell.vAlign="center";
newCell.align="right";


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
function createChild(TreeNo)
{

var seqNumber;	
var IMGctrl,tblID;
tblID=objTbl.id;

//objdivMenu.style.display='none';
var objTbl_1 =GetObjectReference('frmPrjReqDetailsView',tblID+"_"+TRno);
	if(objTbl_1)
	{
		seqNumber = GetSeqNum(objTbl_1,"c");
		
		
		newRow = objTbl_1.insertRow(objTbl_1.rows.length);
		newRow.className='clsTREven';
		newRow.style.backgroundColor="white";
		
		newCell=newRow.insertCell(0);
	
		newCell=newRow.insertCell(1);
		newCell.style.fontWeight="bolder";
		newCell.innerHTML=seqNumber;

		newCell=newRow.insertCell(2);

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
	
		objparentTbl=GetObjectReference('frmPrjReqDetailsView',tblID);
		
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
		
		objTbl_1=GetObjectReference('frmPrjReqDetailsView',tblID+"_"+TRno);

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
		
		
		newCell=newRow.insertCell(1);
		newCell.style.fontWeight="bolder";
		newCell.innerHTML=seqNumber;
		newCell=newRow.insertCell(2);
		
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

	newRow = objTbl.insertRow(TRno+1);//objTbl.rows.length);
	newRow.className='clsTREven';
	newRow.style.backgroundColor="white";
	newCell=newRow.insertCell(0);
		
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
function Print_Click()
{
	GetObjectReference(objfrm.id,'tblMenuB').style.display='none';
	GetObjectReference(objfrm.id,'tblMenuU').style.display='none';
	window.print();
}

		</script>
	</body>
</HTML>
