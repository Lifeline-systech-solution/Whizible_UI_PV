
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 

<script src="../../responsive/responsive.js"></script>


<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 12px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }

</style>

<script type="text/javascript">
    //$(document).ready(function () {
    //    CL_window_onload();
    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Web Form Extension Type
    //    // Description:Remove section header row in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:23/01/2015
    //    /*---------------------------------------------------------*/
    //    if ($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0) {
    //        removeSectionHeader();
    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Web Form Extension Type
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
    //    // Description:Remove plus(+)in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:17/01/2015
    //    /*---------------------------------------------------------*/

    //    /*Generating 'id' for table row if it has no 'id'*/
    //    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').find('tbody').find('tr').each(function () {

    //        var rowIndex = $(this).index();
    //        var attr = $(this).attr('id');
    //        // For some browsers, `attr` is undefined;
    //        // for others, `attr` is false. Check for both.
    //        if (typeof attr !== typeof undefined && attr !== false) {
    //        }

    //        else {
    //            $(this).attr('id', 'rowId' + rowIndex);
    //        }
    //    });

    //    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('large_visible');
    //    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').after('<div id="reviewTypeContent"></div>');
    //    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
    //    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
    //        /*$(this).find('a').css({'display':'none'});*/
    //        $(this).remove();

    //    });
    //    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Apply Footable For Grids
    //    // Description:Footable is used for responsive grids that will collapse the data into the first two columns for smaller resolutions (tablets).
    //    // By Whom: Miiint
    //    // When:17/01/2015
    //    /*---------------------------------------------------------*/

    //    if ($('.clsGridTable').length > 0) {
    //        var divName = $('#divListPageTag').find('div:first').attr('id');
    //        dataCollapse(divName);
    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Apply FooTable
    //    /*---------------------------------------------------------*/


    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/

    //    responsiveTopMenu();

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/


    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
    //    // Description:Apply FooTable
    //    // By Whom: Miiint
    //    // When:17/01/2015
    //    /*---------------------------------------------------------*/

    //    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('hidden-sm hidden-xs');
    //    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Apply FooTable
    //    /*---------------------------------------------------------*/


    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Remove footer
    //    // Description:Display none footer in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:16/01/2015
    //    /*---------------------------------------------------------*/
    //    /* Display none footer in Tablet and Mobile view*/

    //    var windowWidth = $(window).width();
    //    if (windowWidth < 992) {
    //        $('.clsTable:last').css({ 'display': 'none' });
    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Remove footer
    //    /*---------------------------------------------------------*/


    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    //    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:19/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveFooterMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    //    /*---------------------------------------------------------*/


    //    /* Add class to Total Record Table*/
    //    $('.clsBody').find('table:last').prev().prev().addClass('recordTable');


    //});// Ready Function Ends

    //$(window).resize(function () {
    //    /*window_resize_hideshowtree();*/
    //    CL_window_onresize();

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-collapse & close for tablet view
    //    // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
    //    // By Whom: Miiint
    //    // When:17/02/2015
    //    /*---------------------------------------------------------*/
    //    collapseDivsResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-collapse & close for tablet view
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveTopMenuResize();

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/


    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Remove footer
    //    // Description:Display none footer in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:16/01/2015
    //    /*---------------------------------------------------------*/
    //    /* Display none footer in Tablet and Mobile view*/

    //    var windowWidth = $(window).width();
    //    if (windowWidth < 992) {
    //        $('.clsTable:last').css({ 'display': 'none' });
    //    }
    //    else {
    //        $('.clsTable:last').css({ 'display': 'block' });
    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Remove footer
    //    /*---------------------------------------------------------*/


    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    //    // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:21/01/2015
    //    /*---------------------------------------------------------*/

    //    responsiveFooterMenuResize();

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //});
</script>

<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>


<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_PipeLine_Addition_CommonList.aspx.vb" Inherits="PbNIT.HR_PipeLine_Addition_CommonList" %>


<SCRIPT>
var objTbl = GetObjectReference('','tblGrid03874')
/*
var objRolesCount;
objRolesCount=document.createElement("INPUT");
objRolesCount.name="noOfRows";
objRolesCount.type="hidden";
objRolesCount.value=1;
*/

var startImgHTML = "<IMG src='../../Images/Star.gif' border=0> ";
var NewTR,NewTD,objTbl,ctrl;
var strRoleHTML,strSkillHTML;
strRoleHTML = GetObjectReference('','cboRole').innerHTML;
strSkillHTML = GetObjectReference('','cboSkill').innerHTML;
 


if (objTbl)
{
NewTR = objTbl.insertRow(objTbl.rows.length)
NewTR.className = 'clsTREven';
NewTD = NewTR.insertCell(0)
NewTD.colSpan = '3';
NewTD.style.textAlign='center';
NewTD.innerHTML="Click here to add another role"
NewTD.onmousedown = createNewRow;

}

function validData()
{
var objCboRole = GetObjectReference('','cboRole',true);
var objCboSkill = GetObjectReference('','cboSkill',true);
var objtxtSkill = GetObjectReference('','txtFTE',true);
var objOpportunityID = GetObjectReference('','Opportunity_ID');
var objform=GetFormReference('frmCommonList');
var i=0;
var j=1;
while(i<objtxtSkill.length)
{
	if (disallowNegativeNumeric(objtxtSkill[i] ,'Please enter only positive numeric values !!!',true))
	{
		return true; 
	}	
	
	//Comment and modified by SuchitraP on 25-Dec-2007
	/*if ((objtxtSkill[i].value < 1)  || (objtxtSkill[i].value>100))
		 
	{alert('Please enter the Total FTE value between 1 to 100.');
		return true; 
	}*/
	if(objtxtSkill[i].value ==0)
	{ 
	  alert("'Total FTE' should be greater than zero");
	  objtxtSkill[i].focus();
	  return true;
	}
	
		if (objtxtSkill[i].value % 0.25!=0)
			{
			  alert('Please enter Total FTE in multiples of 0.25');
			  objtxtSkill[i].focus();
			  return true;
			}
	
	//End of Comment and modification by SuchitraP on 25-Dec-2007
i++;

}
/*
for(i=0;i<objCboRole.length;i++)
{
for(j=i+1;j<objCboRole.length;j++)
		{	
			if (objCboRole[i].value == objCboRole[j].value && objCboSkill[i].value == objCboSkill[j].value)
			{
				alert("'"+objCboRole[i].options[objCboRole[i].selectedIndex].text + "' Role for '"+ objCboSkill[i].options[objCboSkill[i].selectedIndex].text + "' skill alredy exists.");
				objCboSkill[i].focus(); return true; 

			}
		}
}*/
	
}


function createNewRow()
{
var objRoles = GetObjectReference('','cboRole',true);
var noOfRows = objRoles.length;
	var ctrlRole;
	NewTR = objTbl.insertRow(objTbl.rows.length-1)
	NewTR.className = objTbl.rows[objTbl.rows.length-1].className;
	
	NewTD = NewTR.insertCell(0);
	NewTD.align='center';
	NewTD.innerHTML = "<SELECT id=cboRole name=cboRole class=clsComboBox style='width:200px ' >" + strRoleHTML + "</SELECT>" + startImgHTML;
	
	NewTD = NewTR.insertCell(1);
	NewTD.align='center';
	NewTD.innerHTML = "<SELECT id=cboSkill name=cboSkill class=clsComboBox style='width:200px ' >" + strSkillHTML + "</SELECT>" + startImgHTML;
	
	NewTD = NewTR.insertCell(2);
	NewTD.align='center';
	//Comment and modification by SuchitraP on 25-Dec-2007
	//NewTD.innerHTML = "<Input  Type=Textbox  name=txtFTE id=txtFTE class='clsTextBox' style='width:50px  ; text-align:Right' maxlength=3 value=''  >" + startImgHTML;
	NewTD.innerHTML = "<Input  Type=Textbox  name=txtFTE id=txtFTE class='clsTextBox' style='width:60px  ; text-align:Right' maxlength=6 value=''  >" + startImgHTML;
	//End of Comment and modification by SuchitraP on 25-Dec-2007
	
	//objRolesCount.value = parseInt(noOfRows)+1;
}

</SCRIPT>