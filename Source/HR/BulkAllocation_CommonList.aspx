
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
        font-size: 14px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }
  #tblFilter03968 .clsTRPageFilters td:nth-child(3) {
    display:none;
    }
   #tblFilter03968 .clsTRPageFilters  td:nth-child(4) {
    display:none;
    }
  .clsTRPageFilters  td:empty {
    display:none;
    }
    .clsTRPageFilters {
        background-color: transparent !important;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        var fmt = 'MMM, dd yyyy';
        var objResourceExpectedStartDate = GetObjectReference('frmCommonList', 'ExpectedStartDate');
        var dthidResourceExpectedStartDate = GetDateInFormat(objResourceExpectedStartDate.value, fmt, 'rev');

        var objResourceExpectedEndDate = GetObjectReference('frmCommonList', 'ExpectedEndDate');
        var dthidResourceExpectedEndDate = GetDateInFormat(objResourceExpectedEndDate.value, fmt, 'rev');
              
        document.getElementById("lblExpectedStartDate").innerText = dthidResourceExpectedStartDate;
        document.getElementById("lblExpectedEndDate").innerText = dthidResourceExpectedEndDate;
        CL_window_onload();
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Yogesh J ON 14/12/2015
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Remove plus(+)in Tablet and Mobile view
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        /*Generating 'id' for table row if it has no 'id'*/
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').find('tbody').find('tr').each(function () {

            var rowIndex = $(this).index();
            var attr = $(this).attr('id');
            // For some browsers, `attr` is undefined;
            // for others, `attr` is false. Check for both.
            if (typeof attr !== typeof undefined && attr !== false) {
            }

            else {
                $(this).attr('id', 'rowId' + rowIndex);
            }
        });

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('large_visible');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').after('<div id="reviewTypeContent"></div>');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
            /*$(this).find('a').css({'display':'none'});*/
            $(this).remove();

        });
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Apply Footable For Grids
        // Description:Footable is used for responsive grids that will collapse the data into the first two columns for smaller resolutions (tablets).
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        if ($('.clsGridTable').length > 0) {
            var divName = $('#divListPageTag').find('div:first').attr('id');
            dataCollapse(divName);
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/

        responsiveTopMenu();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Apply FooTable
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
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
            $('.clsTable:last').css({ 'display': 'none' });
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:19/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/


        /* Add class to Total Record Table*/
        $('.clsBody').find('table:last').prev().prev().addClass('recordTable');


    });// Ready Function Ends

    $(window).resize(function () {
        /*window_resize_hideshowtree();*/
        CL_window_onresize();
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Yogesh J ON 14/12/2015
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
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();

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
            $('.clsTable:last').css({ 'display': 'none' });
        }
        else {
            $('.clsTable:last').css({ 'display': 'block' });
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:21/01/2015
        /*---------------------------------------------------------*/

        responsiveFooterMenuResize();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });
</script>

<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>


<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BulkAllocation_CommonList.aspx.vb" Inherits="PbNIT.BulkAllocation_CommonList" %>
<script language='javascript' type="text/javascript"> 
//Added by SanaS on 12-Nov-2009 for Resource Allocation %validation 
        var objXHttp;
        var blnFlag = false;
    //Commented And Added By Vaijat K ON 17/11/2015
        //var strmsg;
		var strmsg = "";
		
		function HandlerOnReadyState()
		{	
			if (objXHttp.readyState==4)
			{
			    if (objXHttp.status==200)
			    {
				    if (objXHttp.responseText != null) 
				    {
					    strmsg=objXHttp.responseText
					    if(strmsg!="")
					    alert(strmsg);
					}
				}
			}
		}
//End by SanaS on 12-Nov-2009 for Resource Allocation %validation 
function chkDelete_Onclick(strEmployeeID,strResourceDetails)
{
    var objChkDelete = GetObjectReference('frmCommonList','chkDelete',true);
    var objhidSelected = GetObjectReference('frmCommonList','hidSelected');

    var objhidResource_Details = GetObjectReference('frmCommonList','hidResource_Details',true);
    var objhidSel_Details = GetObjectReference('frmCommonList','hidSel_Details');

    var strSelected=objhidSelected.value;

    var strhidSel_Details = objhidSel_Details.value;

    if (objChkDelete != null)
    {
        for (var i =0 ;i<objChkDelete.length;i++)
        {
           if (objChkDelete[i].checked == true)
           {
               if(objChkDelete[i].value == strEmployeeID)
               {
                   strSelected =strSelected + objChkDelete[i].value + ',';
                   strhidSel_Details= strhidSel_Details + objhidResource_Details[i].value + ',';
                }
           }
           else
           {
                if(strSelected!='' && strSelected.match(objChkDelete[i].value)==strEmployeeID)
                {
                   strSelected=strSelected.replace(strEmployeeID+',', '');
                   strhidSel_Details = strhidSel_Details.replace(strResourceDetails+',', '');
                }
           }
        }
    }
    objhidSelected.value =strSelected;
    objhidSel_Details.value = strhidSel_Details;
}

function BulkAllocate_SelectAll_OnClick()
{
    //Added by TruptiK on 18-May-09
	BulkAllocate_ClearAll_OnClick();
	//End of Addition by TruptiK
    SelectAllCheckboxs('frmCommonList','chkDelete');
    
    var objChkDelete = GetObjectReference('frmCommonList','chkDelete',true);
    var objhidResource_Details = GetObjectReference('frmCommonList','hidResource_Details',true);

    for(var i=0;i<objChkDelete.length;i++)
    {
        chkDelete_Onclick( objChkDelete[i].value, objhidResource_Details[i].value);
    }
}

function BulkAllocate_ClearAll_OnClick()
{
    ClearAll_OnClick('frmCommonList','chkDelete');
    var objChkDelete = GetObjectReference('frmCommonList','chkDelete',true);
    var objhidResource_Details = GetObjectReference('frmCommonList','hidResource_Details',true);

    for(var i=0;i<objChkDelete.length;i++)
    {
        chkDelete_Onclick( objChkDelete[i].value, objhidResource_Details[i].value);
    }
}

function validate_BulkAllocation()
{
    var fmt = 'MMM, dd yyyy';
    var objhidProjectStartDate = GetObjectReference('frmCommonList','hidProjectStartDate'); 
    var dthidProjectStartDate =GetDateInFormat(objhidProjectStartDate.value, fmt, 'rev'); 

    var objhidProjectEndDate = GetObjectReference('frmCommonList','hidProjectEndDate'); 
    var dthidProjectEndDate =GetDateInFormat(objhidProjectEndDate.value, fmt, 'rev'); 

    var objResourceExpectedStartDate = GetObjectReference('frmCommonList','ExpectedStartDate'); 
    var dthidResourceExpectedStartDate =GetDateInFormat(objResourceExpectedStartDate.value, fmt, 'rev'); 

    var objResourceExpectedEndDate = GetObjectReference('frmCommonList','ExpectedEndDate'); 
    var dthidResourceExpectedEndDate=GetDateInFormat(objResourceExpectedEndDate.value, fmt, 'rev'); 

    var objChkDelete = GetObjectReference('frmCommonList','chkDelete',true);
    var objhidSel_Details=GetObjectReference('frmCommonList','hidSel_Details');
       
    if(trimString(objhidSel_Details.value) == ""){alert('Please Select at least one Resource.'); return false;}
    if(disallowBlank(GetObjectReference('frmCommonList','ExpectedStartDate'),'&#39;Start Date&#39; should not be left blank.',true) )  {return false; } 
    if(disallowBlank(GetObjectReference('frmCommonList','ExpectedEndDate'),'&#39;End Date&#39; should not be left blank.',true) ){return false; }
    if(disallowBlank(GetObjectReference('frmCommonList','AllocationRole'),'&#39;Role&#39; should not be left blank.',true) ) {return false; } 
    if(disallowBlank(GetObjectReference('frmCommonList','ReportingTo'),'&#39;Reporting To&#39; should not be left blank.',true) ) {return false; } 
    if(disallowBlank(GetObjectReference('frmCommonList','ResourceStatus'),'&#39;Status &#39; should not be left blank.',true) ) {return false; } 
    if(disallowBlank(GetObjectReference('frmCommonList','ResourceStatus'),'&#39;Status&#39; should not be left blank.',true) ) {return false; } 
    if(DateDiff(dthidResourceExpectedStartDate,dthidResourceExpectedEndDate, 'd')<0 ) { alert('Please enter End Date greater than Start Date'); return false; } 
    //if (disallowBlank(GetObjectReference('frmCommonList','ResourcePercentage'),'&#39;% Allocation&#39; should not be left blank.',true) ) {return false; }
    //if (disallowNegativeNumeric(GetObjectReference('frmCommonList','ResourcePercentage'),'Please enter only positive numeric value for &#39;% Allocation&#39;',true)) {return false; }
    // Added by Sagar N on 14-May-2019 Purpose :: IssueID: 18837
    var objResourcePercent = $('table[id=tbl_AllocationDetails]').find('label');
    var fltResourcePercent = 0;
    var intCounter = 0;
    objResourcePercent.each(function () {
        if (intCounter == 2) {
            fltResourcePercent = parseFloat($(this).text());
        }
         intCounter++; 
    });
    if (fltResourcePercent <= 0) {
        alert("Resource percentage should be greater than '0'");
        return false;
    }
    // End of Added by Sagar N on 14-May-2019 Purpose :: IssueID: 18837

    if((dthidProjectStartDate != null) && (dthidProjectEndDate != null) && (dthidResourceExpectedStartDate != null) && (dthidResourceExpectedEndDate != null)) 
    { 
        if((DateDiff(dthidResourceExpectedStartDate,dthidProjectStartDate, 'd')>0 ) || (DateDiff(dthidResourceExpectedStartDate,dthidProjectEndDate, 'd')<0 ) || (DateDiff(dthidResourceExpectedEndDate,dthidProjectEndDate, 'd')<0 )) 
            if((DateDiff(dthidResourceExpectedStartDate,dthidProjectStartDate, 'd')>0 )||(DateDiff(dthidResourceExpectedStartDate,dthidProjectEndDate, 'd')<0 ) || (DateDiff(dthidResourceExpectedEndDate,dthidProjectEndDate, 'd')<0 )) 
            {
                var strMsg='Start Date and End Date should be between the Project Start date (<=>) and End date (<==>).'; 
                strMsg = replaceSubstring(strMsg, '<=>', dthidProjectStartDate); 
                strMsg = replaceSubstring(strMsg, '<==>', dthidProjectEndDate); 
                alert(strMsg); 
                return false; 
            } 
    } 

    var strSel_Details=objhidSel_Details.value;
    var arrSel_Details = strSel_Details.split(',');
    var bitRejected_JoiningDate; var bitRejected_LeavingDate; 
    var strRejected_JoiningDate; var strRejected_LeavingDate;
    var intCount_JoiningDate_Rejection; var intCount_LeavingDate_Rejection; 

    strRejected_JoiningDate=''; 
    strRejected_LeavingDate=''
    bitResourceRejected = false;
    bitRejected_JoiningDate=false;
    bitRejected_LeavingDate=false;
    intCount_JoiningDate_Rejection = 0; 
    intCount_LeavingDate_Rejection = 0; 
   
    for (var i =0 ;i<arrSel_Details.length-1;i++) 
    { 
        var strInnerArray = arrSel_Details[i]; 
        var objInnerArray = strInnerArray.split('::'); 

        var dthidSelected_JoiningDate=GetDateInFormat(objInnerArray[1], fmt, 'rev'); 
        if((dthidResourceExpectedStartDate != null) && (dthidSelected_JoiningDate != null)) 
        { 
            	//Modification by SuchitraP on 24-Apr-2009 for IssueID : 30244
			//Purpose : Allow to allocate resource on project on his joining date
            //if(DateDiff(dthidResourceExpectedStartDate, dthidSelected_JoiningDate, 'd')>=0) 
            if(DateDiff(dthidResourceExpectedStartDate, dthidSelected_JoiningDate, 'd')>0) 
            //End by SuchitraP on 24-Apr-2009
            { 
                bitRejected_JoiningDate = true; 
                intCount_JoiningDate_Rejection = intCount_JoiningDate_Rejection + 1; 
                strRejected_JoiningDate = strRejected_JoiningDate + intCount_JoiningDate_Rejection + ': ' + objInnerArray[0] + '\n'; 
            } 
        } 
        var dthidSelected_TLeavingDate=GetDateInFormat(objInnerArray[2], fmt, 'rev'); 
        
        if((dthidResourceExpectedEndDate != null) && (dthidSelected_TLeavingDate != null) && (trimString(dthidSelected_TLeavingDate) != "")) 
        { 
            if(DateDiff(dthidSelected_TLeavingDate, dthidResourceExpectedEndDate, 'd')>=0) 
            { 
                bitRejected_LeavingDate = true; 
                intCount_LeavingDate_Rejection = intCount_LeavingDate_Rejection + 1; 
                strRejected_LeavingDate = strRejected_LeavingDate + intCount_LeavingDate_Rejection + ': ' + objInnerArray[0] + '\n'; 
            } 
        } 
    } 
    if (bitRejected_JoiningDate == true) 
    { 
        alert('Following resources cannot be allocated on the project as joining date of following resources is not between Start Date and End date of allocation \n  ' + strRejected_JoiningDate ); 
        return false; 
    }
    if (bitRejected_LeavingDate == true) 
    { 
    
        
        alert('Following resources cannot be allocated on the project as End Date of the allocation is greater than or equal to Tentative Leaving date of resources,  \n  ' + strRejected_LeavingDate ); 
        return false; 
    }
    
    if(arrSel_Details.length-1>50)
    {
    alert('You can not assign more than 50 resources');
    return;
    }
   //added by SanaS
    var objhidSelected = GetObjectReference('frmCommonList','hidSelected');
    var strSelected=objhidSelected.value;
   
    strUrl = '../General/XMLHttp.aspx?TagID=3968&FromDate='+objResourceExpectedStartDate.value+'&ToDate='+objResourceExpectedEndDate.value+'&SelectedEmployee='+strSelected;
		   if (document.all)
		    { 
				objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
				objXHttp.onreadystatechange = HandlerOnReadyState; 
				objXHttp.open('GET',strUrl, false); 
				objXHttp.send();           
			}  
			else  
			{
				objXHttp = new XMLHttpRequest();  
				objXHttp.onreadystatechange = HandlerOnReadyState(); 
				objXHttp.open('GET',strUrl, false);
				objXHttp.send(null);  
			}

		 
            if (strmsg=="")
             {
             return true;
             }
           
   //End by SanaS
   
    //return true;
}
function Allocate_OnClick()
{
if(!validate_BulkAllocation()) {return false; }
//Commented and Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
//objfrm.action = 'BulkAllocation_CommonList.aspx?Action=Save'
var objchkBillable = GetObjectReference('frmCommonList','chkBillable');
objfrm.action = 'BulkAllocation_CommonList.aspx?Action=Save&IsBillable='+objchkBillable.checked
//End of Commented and Added By Aniruddh Gujar on 13-Aug-2014 Purpose::Issue fixing of PMLifeline Sp2 Hot fixes
objfrm.submit(); return;
}
function CL_window_onresize()
{
    var intDivHeight ;
    var intDivHeightRisk;
    var intDivListPageHeight ;
    if (objdivlistPage != null) 
	{
        if (navigator.appName == 'Microsoft Internet Explorer')
        {
	        //intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 67;
	        //intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 67 - 120;
           intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 67 - 120-45; //added by shamkant S on 7 Dec 2015 
        }
		else
		{
			//intDivHeight = window.innerHeight - objdivlistPage.offsetTop - 67;
			//intDivHeight = window.innerHeight - objdivlistPage.offsetTop - 67 - 120;
          intDivHeight = window.innerHeight - objdivlistPage.offsetTop - 67 - 120- 45;//added by shamkant s on 7 Dec 2015
		}
		if (intDivHeight < 100)
			intDivHeight = 100;

		objdivlistPage.style.height = intDivHeight;
	}
    if (objdivlist != null) 
    {
        intDivListPageHeight = intDivHeight - 5 ;
        if (parseFloat(objdivlist.style.height) > intDivListPageHeight){objdivlist.style.height = intDivListPageHeight;}
        else if(parseFloat(objdivlist.style.height) < intDivListPageHeight)
        {
            if(divHeight < intDivListPageHeight){objdivlist.style.height = divHeight;}
            else if(divHeight > intDivListPageHeight){objdivlist.style.height = intDivListPageHeight;}
        }
    }
	try{hideAll();} catch(e){}
	
}
function CL_window_onload()
{
	if (window.opener == null)
	    window.open('../../Default.aspx?Message=InvalidLogin','_top');
	var intDivHeight ;
	var intDivListPageHeight ;
	var intDivHeightRisk;
	var lc;
	if (objdivlistPage != null) {
	if (navigator.appName == 'Microsoft Internet Explorer'){
	// intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 67;
    //intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 67 - 120;
     //Added by Shamkant S on 7 Dec 2015
	intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 67 - 120-45;
	}
	else{
	// intDivHeight = window.innerHeight - objdivlistPage.offsetTop - 67 ;
     //intDivHeight = window.innerHeight - objdivlistPage.offsetTop - 67 - 120;
	intDivHeight = window.innerHeight - objdivlistPage.offsetTop - 67 - 120-45; //added by shamkant S on 7 Dec 2015
	}
	if (intDivHeight < 100)
		intDivHeight = 100;
	objdivlistPage.style.height = intDivHeight;}
	if (objdivlist != null) {
	intDivListPageHeight = intDivHeight;
	if(isNaN(parseFloat(objdivlist.style.height))){objdivlist.style.height=intDivListPageHeight;}divHeight=parseFloat(objdivlist.style.height);
	if (parseFloat(objdivlist.style.height) > intDivListPageHeight){objdivlist.style.height = intDivListPageHeight;}}


	
	//alert(document.getElementById("lblExpectedEndDate").value);

}

function RestrictNonNumeric(obj) {
    if (obj == null) { return false; }
    if (isBlank(getInputValue(obj))) { return false; }

    var dofocus = (arguments.length > 1) ? arguments[1] : true;
    if (!isNumeric(getInputValue(obj))) {
        if (dofocus) {
            setFocus(obj);
        }
        return true;
    }
    return false;
}
function applyFilter() {
    var objhidSelected = GetObjectReference('frmCommonList', 'hidSelected');
    var objform = GetFormReference('frmCommonList');
    var RoleDescription = GetObjectReference('frmCommonList', 'RoleDescription');
    var Designationname = GetObjectReference('frmCommonList', 'Designationname');
    var Department = GetObjectReference('frmCommonList', 'Department');
    var BusinessGroup = GetObjectReference('frmCommonList', 'BusinessGroup');
    var Location = GetObjectReference('frmCommonList', 'Location');
    var EmployeeName = GetObjectReference('frmCommonList', 'EmployeeName');
    var ExpectedStartDate = GetObjectReference('frmCommonList', 'ExpectedStartDate');
    var ExpectedEndDate = GetObjectReference('frmCommonList', 'ExpectedEndDate');
    var ResourcePercentage = GetObjectReference('frmCommonList', 'ResourcePercentage');
    


    //debugger;

    if (ExpectedStartDate.value == "")
    {
        alert("Please Enter Start Date");
        return;
    }

    if (ExpectedEndDate.value == "") {
        alert("Please Enter End Date");
        return;
    }

    if (ExpectedEndDate.value == "") {
        alert("Please Enter End Date");
        return;
    }


    var fmt = 'MMM, dd yyyy';
    var objhidProjectStartDate = GetObjectReference('frmCommonList', 'hidProjectStartDate');
    var dthidProjectStartDate = GetDateInFormat(objhidProjectStartDate.value, fmt, 'rev');

    var objhidProjectEndDate = GetObjectReference('frmCommonList', 'hidProjectEndDate');
    var dthidProjectEndDate = GetDateInFormat(objhidProjectEndDate.value, fmt, 'rev');
    var objResourceExpectedStartDate = GetObjectReference('frmCommonList', 'ExpectedStartDate');
    var dthidResourceExpectedStartDate = GetDateInFormat(objResourceExpectedStartDate.value, fmt, 'rev');

    var objResourceExpectedEndDate = GetObjectReference('frmCommonList', 'ExpectedEndDate');
    var dthidResourceExpectedEndDate = GetDateInFormat(objResourceExpectedEndDate.value, fmt, 'rev');
   
   
   //alert(ExpectedStartDate);
   if ((dthidProjectStartDate != null) && (dthidProjectEndDate != null) && (dthidResourceExpectedStartDate != null) && (dthidResourceExpectedEndDate != null)) {
       if ((DateDiff(dthidResourceExpectedStartDate, dthidProjectStartDate, 'd') > 0) || (DateDiff(dthidResourceExpectedStartDate, dthidProjectEndDate, 'd') < 0) || (DateDiff(dthidResourceExpectedEndDate, dthidProjectEndDate, 'd') < 0))
           if ((DateDiff(dthidResourceExpectedStartDate, dthidProjectStartDate, 'd') > 0) || (DateDiff(dthidResourceExpectedStartDate, dthidProjectEndDate, 'd') < 0) || (DateDiff(dthidResourceExpectedEndDate, dthidProjectEndDate, 'd') < 0)) {
               var strMsg = 'Start Date and End Date should be between the Project Start date (<=>) and End date (<==>).';
               strMsg = replaceSubstring(strMsg, '<=>', dthidProjectStartDate);
               strMsg = replaceSubstring(strMsg, '<==>', dthidProjectEndDate);
               alert(strMsg);
               return ;
           }
   }
    //alert(ResourcePercentage.value);
    if (ResourcePercentage.value == "" || ResourcePercentage.value =="0") {
        alert("Please Enter Resource Percentage");
        return;
    }
        //Added by Swapnagandha K.
        else {

            if (ResourcePercentage.defaultValue != ResourcePercentage.value) {
                objhidSelected.value = "";
            }
        }
        //End by Swapnagandha K.
    if (RestrictNonNumeric(ResourcePercentage) == true) {
        alert("Please Enter numeric value");
        return;
    }
    setFrameLoader();
    objform.action = "BulkAllocation_CommonList.aspx?MasterTagID=3968&ApplyFilters=1&Action=applyfilter&RoleDescription=" + RoleDescription.value + "&Designationname=" + Designationname.value + "&Department=" + Department.value + "&BusinessGroup=" + BusinessGroup.value + "&Location=" + Location.value + "&EmployeeName=" + EmployeeName.value + "&ExpectedStartDate=" + ExpectedStartDate.value + "&ExpectedEndDate=" + ExpectedEndDate.value + "&ResourcePercentage=" + ResourcePercentage.value + "";
    objform.submit();
}

function Percentage_OnClick(EmpID) {
 //   debugger;
    var str;
    //str = new String(EmpID);
   // EmpID = str.substr(0, str.indexOf('|'));
    var ExpectedStartDate = GetObjectReference('frmCommonList', 'ExpectedStartDate');
    var ExpectedEndDate = GetObjectReference('frmCommonList', 'ExpectedEndDate');

    var fmt = 'MMM, dd yyyy';
  
  //  alert(EmpID);
    var objResourceExpectedStartDate = GetObjectReference('frmCommonList', 'ExpectedStartDate');
    var dthidResourceExpectedStartDate = GetDateInFormat(objResourceExpectedStartDate.value, fmt, 'rev');

    var objResourceExpectedEndDate = GetObjectReference('frmCommonList', 'ExpectedEndDate');
    var dthidResourceExpectedEndDate = GetDateInFormat(objResourceExpectedEndDate.value, fmt, 'rev');

  //  alert(dthidResourceExpectedEndDate);

    //setFrameLoader();
    window.open("../PM/PM_ProjectDetails.aspx?ShowOnGoing=1&Mode=ProjectDetails&strFlag=BulkAllocation&EmployeeID=" + EmpID + "&ExpectedStartDate=" + dthidResourceExpectedStartDate + "&ExpectedEndDate=" + dthidResourceExpectedEndDate + "", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=700,height=500");

  
}

 </script>