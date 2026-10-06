
<!--Including files & Libraries by Miiint Solutions-->

<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

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



<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DemandTypes_CommonPage.aspx.vb" Inherits="PbNIT.DemandTypes_CommonPage"%>
    <script>
      function enablecontrols()
		{
			var objApplicable = GetObjectReference('frmCommonPage','chkApplicable',true);
			var objMandatory=GetObjectReference('frmCommonPage','chkMandatory',true);
			var objEditable =GetObjectReference("frmCommonPage","chkEditable",true);
			
			if (objApplicable==null || objMandatory==null || objEditable==null ) return;
			
				for (i=0;i<objApplicable.length;i++) 
					objApplicable[i].disabled=false;
			
				for (i=0;i<objMandatory.length;i++) 
					objMandatory[i].disabled=false;
					
				for (i=0;i<objEditable.length;i++) 
					objEditable[i].disabled=false;
		}
   
   function Applicable_Click(id,value)
{
 var objApplicable = GetObjectReference("frmCommonPage","chkApplicable",true); 
 var objMandatory =GetObjectReference("frmCommonPage","chkMandatory",true);
 var objEditable =GetObjectReference("frmCommonPage","chkEditable",true);
  
 var i = 0;
 for ( i=0;i<objApplicable.length;i++)
 if  (objApplicable[i].value == value)
 break;
 if (objApplicable[i].checked==true){objMandatory[i].disabled = false; objEditable[i].disabled = false;  } 
 else {objMandatory[i].checked=false;objMandatory[i].disabled = true; objEditable[i].checked=false; objEditable[i].disabled = true;} 
 }  
    var objTbl = GetObjectReference('','tblGrid392830029');           
    var objtxtHidRC=GetObjectReference('','txtHidRC');
    var noOfRows;
    
    if (objtxtHidRC!=null)
		noOfRows=parseInt(objtxtHidRC.value);
    else
		noOfRows=0;
		 
function ShowHide_SectionTR()
{
   createNewRow();
}

function createNewRow()
{

    noOfRows = noOfRows + 1;
  
    var strcombohtml;

    var startMandHTML = " "
    var NewTR,newTD;
    var strFrequencyHTML;
    var strHTML;
    var strHTML1;
    var strHTML2;
    var strHTMLAmount;

    NewTR = objTbl.insertRow(objTbl.rows.length);
    NewTR.className = 'clsTREven';

    NewTD = NewTR.insertCell(0);
	NewTD.align='center';
	NewTD.innerHTML = "<td align='center'></td>";
	
	//BusinessGroup
	NewTD = NewTR.insertCell(1);
	NewTD.align='center';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_Sel_tbl_CNF_BusinessGroup 1", 150, "", "onchange=BusinessGroup_Change", True, True, , True, , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboBG/g,"cboBG" + noOfRows)
	strcombohtml = strcombohtml.replace(/BusinessGroup_Change/g,"BusinessGroup_Change(0,"+ noOfRows +")");
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	//OrganizationUnit
	NewTD = NewTR.insertCell(2);
	NewTD.align='center';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_Sel_PM_LocationList", 150, "","onchange=OUPool_OnChange", True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboOU/g,"cboOU" + noOfRows)
	strcombohtml = strcombohtml.replace(/OUPool_OnChange/g,"OUPool_OnChange(this,0," + noOfRows+")");
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	
	//Delivery Unit
	NewTD = NewTR.insertCell(3);
	NewTD.align='center';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboDU", "usp_Sel_tbl_PM_ResourcePool", 150, "", "onchange=DUPool_OnChange", True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboDU/g,"cboDU" + noOfRows)
	strcombohtml = strcombohtml.replace(/DUPool_OnChange/g,"DUPool_OnChange(this,0," + noOfRows+")");
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	
    //Delivery Team
	NewTD = NewTR.insertCell(4);
	NewTD.align='center';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboDT", "usp_Sel_tbl_PM_GroupMaster", 150, "", , True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboDT/g,"cboDT" + noOfRows)
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
   
   //Project Type
	NewTD = NewTR.insertCell(5);
	NewTD.align='center';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboPT", "usp_Sel_tbl_PRS_ProjectTypes", 150, "", , True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboPT/g,"cboPT" + noOfRows)
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	
	NewTD = NewTR.insertCell(6);
	NewTD.align='center';
	NewTD.innerHTML = "<td width='2%'> <IMG BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'deleteRow(this)'></td>";	
}
 function deleteRow(evt)
    {
        //Commented By PrashantSJ on 1st Apr 2008
        //noOfRows = noOfRows - 1;
        //End of comment by PrashantSJ on 1st Apr 2008
        //var objTbl = GetObjectReference('','tblEDList');
        objTbl.deleteRow(evt.parentNode.parentNode.rowIndex);
    }

	function SaveRecords()
	{
		if(!validateControls()) return;
		var objform=GetFormReference('frmCommonPage');
		var objPKvalue=GetObjectReference('frmCommonPage','NatureofDemandID_PK');
		
		objform.action='../DM/DemandTypes_CommonPage.aspx?NatureofDemandID_PK='+objPKvalue.value+'&MasterTagID=3928&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&SubTagID=30029&Action=SAVE&RowCount='+noOfRows;
		objform.submit();
	}
	function validateControls()
	{
	 var arrAttributes = new Array();
     var c=0;
     
	 for (var intCount=1;intCount<=noOfRows;intCount++)
      {
           objcboBG= GetObjectReference("","cboBG"+intCount);
           objcboOU= GetObjectReference("","cboOU"+intCount);
           objcboDU= GetObjectReference("","cboDU"+intCount);
           objcboDT= GetObjectReference("","cboDT"+intCount);
		   objcboPT= GetObjectReference("","cboPT"+intCount);
		 
		   if(isBlank(objcboBG.value)==true) 
          {
              alert("Business Group should not be left blank.");
              setFocus(objcboBG);
              return false;
          }    
          arrAttributes[c]=String(objcboBG.value)+String(objcboOU.value)+String(objcboDU.value)+String(objcboDT.value)+String(objcboPT.value);
          c+=1;
      }
      
     arrAttributes.sort(sortNumber) 
     for (i=1;i<arrAttributes.length;i++) 
     {
        if (arrAttributes[i]==arrAttributes[i-1]) 
        {
            alert("Same attribute combination should not be allowed !");
            //setFocus(objEDShort);
             return false;   
             break;
         }
      }
      
      return true;  
	}
	
	 function sortNumber(a, b)
    {return a - b} 
    
   </script>
