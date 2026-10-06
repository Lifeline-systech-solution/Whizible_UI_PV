<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DB_CustomerFieldLock.aspx.vb" Inherits="PbNIT.DB_CustomerFieldLock" %>

<!DOCTYPE HTML>
<html>
    <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
<% CommonFunctions.General.PlotPageHeadTag("Manager Corner")%>
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
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
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

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()">
    <form id="frmGrievances" runat="server">
      <%WritePage%> 
    </form>
<script type ="text/javascript" >
var objfrm = GetFormReference('frmGrievances');
var objTbl = GetObjectReference('','tblGrid');
var objdivlist=GetObjectReference('frmGrievances','divLisBt');
var noOfRows = <%=m_intRowCount%>;
//var isActive =<%=m_isActive%>;

        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>

function createNewRow()
{
/*if (noOfRows ==0)
    {txtnoitems.innerText="";
    noOfRows = 1;
    }
    else */
noOfRows = noOfRows + 1;
// Plot Date Control
var strDateobject = '<%= CommonFunctions.HTMLControls.DrawDateControl("AdditionDate" , "AdditionDate" , , , m_CurrentDate, , "frmGrievances", , ,"readOnly" , True, returnHTML:=True).ToString.Replace("\","\\").Replace("'", "\'") %>' 

    NewTR = objTbl.insertRow(objTbl.rows.length-1);
    NewTR.className = 'clsTROdd';
    
    /*NewTD = NewTR.insertCell(0);
	NewTD.align='left';
	 NewTD.width ='2%'
	NewTD.innerHTML = "<td> <IMG BORDER=0 src='../../images/delete.gif' onclick = 'deleteRow(this,"+noOfRows+")'></td>";		
	*/
    NewTD = NewTR.insertCell(0);	
    NewTD.align='LEFT';
    NewTD.width ='20%'
    NewTD.innerHTML = "<br><b> By : </b><%=m_strUser%> <br> <b>On : </b>"+ strDateobject; 

  //if (isActive == 0)
  //{
    NewTD = NewTR.insertCell(1);	
    NewTD.align='left';
    NewTD.innerHTML = "<textarea  rows='20' cols='80' name=txtNote" + noOfRows +" id=txtNote" + noOfRows +" class=clsTextArea style='width:600px  ; height:50px  ; text-align:Left ;   overflow-x: hidden;overflow-y:hidden ;' ></Textarea>"
	
	var strHTML = "<td><u   style='CURSOR:hand' onclick='Save_OnClick(" +noOfRows+ ")'> <Img Border=0 src='../../Images/cssImages/Link images/save.gif'></u></td>";
	
    NewTD = NewTR.insertCell(2);	
    NewTD.align='center';     
    NewTD.width ='5%'
    NewTD.innerHTML=strHTML; 
    
    //var strHTML = "<td><u  valign=top style='CURSOR:hand' onclick='deleteRow(this,"+noOfRows+")'><Img Border=0 src='../../Images/cssImages/Link images/Delete.gif'></u></td><br>";
   
	//NewTD = NewTR.insertCell(2);	
    //NewTD.align='center';     
    //NewTD.width ='5%'
    //NewTD.innerHTML = strHTML;
 //}   
}


  
 function AddNewRec_OnClick(objControl)
 {
      createNewRow();
 }
  
 function Save_OnClick(intRowCount)
 {
    var intEmployeeID = GetObjectReference('','txtEmployeeID').value;
    var strNote = GetObjectReference('','txtNote'+intRowCount).value;
    var url=new String();
	var objFromDate,objToDate,objWorkHours,objEmployeeID;
	var objchkAssign,intCnt;
	var strHtm='';
    
    
    
    
    if(strNote=="")
    {
        alert("Note should not left blank.");
           return;
    }
    
    
    if(strNote.length>1000)
    {
        alert("Length of the note should not be greater than 2000 characters.");
           return;
    }
    
    //var intTagID = GetObjectReference('','txtTagID').value;
    
    objfrm.action ="../DB/DB_CustomerFieldLock.aspx?Action=save&intRowCount="+intRowCount+"&EmployeeID="+intEmployeeID; //+"&MasterTagID="+intTagID;
    objfrm.submit(); 
 }    
 
 
function Close_click()
{
    window.close();

}
 function window_onload()
	{
	
		var intDivHeight ;
		var intDivListPageHeight ;
		var intDivHeightRisk;
		var lc;
		
		/*if (objdivlist != null) {
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop;		
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objdivlist.style.height = intDivHeight+410;
		
		}*/
	
	
		
		if (objdivlist !=null) {
		    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    if (intDivHeight < 100)	intDivHeight = 100;
		    objdivlist.style.height = intDivHeight+410+'px' ;//Added By Nilesh g on 11/12/2015;	
        }
		
			
	}
	 function window_onresize()
    {
		var intDivHeight ;
		var intDivListPageHeight ;
		var intDivHeightRisk;
		var lc;
		if (objdivlist != null) {
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;
		    //objdivlist.style.height = intDivHeight+100
	}       
</script>
</body>
</html>


