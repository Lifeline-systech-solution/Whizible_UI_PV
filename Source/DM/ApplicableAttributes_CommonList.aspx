


<!--Including files & Libraries by Miiint Solutions-->
 
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>


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

    /* new css 03-12-19 start here */

        .clsBody {background-color:#fff !important;border:none !important;}
        #frmCommonList > table.clsTable.topInnerMenu > tbody > tr > td:nth-child(2), .tasktype-wrap > table:nth-child(7), #frmCustomeFields > table.clsTable.topInnerMenu > tbody > tr > td:nth-child(1) {background-color:#fff;}
        #frmCommonList #tblCap03935 > tbody > tr > td {background-color: #4263c1;padding: 10px 5px 10px 15px !important;color:#fff;font-size:16px !important;}
        #frmCommonList > table.clsTable.footerMenuTable > tbody > tr,  #frmCommonList > table.clsTable.recordTable > tbody > tr > td, #frmCommonList > table.clsTable.recordTable {display:none;}
        #frmCommonList #tblGrid03935 {width:97% !important;margin:0 auto;}
        #frmCommonList #tblGrid03935 > thead > tr th {background: #e7edf0 !important;color: #464a4c !important;font-weight: 600 !important;font-size: 14px !important;}
        #tblGrid03935 > thead > tr th, #tblGrid03935 > tbody > tr > td {padding:8px 2px !important;}

    /* new css 03-12-19 end here */

    /*added by pradipon 9-10-2020*/
   .clsBody .Menu{color:#464a4c!important;}
    /*End added by pradipon 9-10-2020*/

</style>

<script type="text/javascript">
    $(document).ready(function () {
        CL_window_onload();
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
            //Commented by swapnil aswale on 26th Nov 2015
          //  dataCollapse(divName);
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

<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ApplicableAttributes_CommonList.aspx.vb" Inherits="PbNIT.ApplicableAttributes_CommonList" %>

    <script>
     
   
  
    var objTbl = GetObjectReference('','tblGrid03935');           
    var objtxtHidRC=GetObjectReference('','txtHidRC');
    var noOfRows;
    
    if (objtxtHidRC!=null)
		noOfRows=parseInt(objtxtHidRC.value);
    else
		noOfRows=0;
		
    NewTR1 = objTbl.insertRow(objTbl.rows.length);
    NewTR1.className = 'clsTRBlank';
    NewTD1 = NewTR1.insertCell(0);
   	NewTD1.align='left';
	NewTD1.innerHTML = "<td width=10px ALIGN='center' colspan='7'><A href='javascript:ShowHide_SectionTR()'><Img Border=0 id=tdShowHide Src='../../Images/cssImages/Link images/add.gif' title='Click here to add new record'></A></td>";	
	NewTD1 = NewTR1.insertCell(1);
	NewTD1 = NewTR1.insertCell(2);
	NewTD1 = NewTR1.insertCell(3);
	NewTD1 = NewTR1.insertCell(4);
	NewTD1 = NewTR1.insertCell(5);
    
		 
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
   
    NewTR = objTbl.insertRow(objTbl.rows.length-1);
    NewTR.className = 'clsTREven';

    /*NewTD = NewTR.insertCell(0);
	NewTD.align='center';
	NewTD.innerHTML = "<td align='center'></td>";*/
	
	NewTD = NewTR.insertCell(0);
	NewTD.align='left';
	NewTD.innerHTML = "<td > <IMG BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'deleteRow(this)'></td>";	
	
	//BusinessGroup
	NewTD = NewTR.insertCell(1);
	NewTD.align='left';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_Sel_tbl_CNF_BusinessGroup 1", 150, "", "onchange=BusinessGroup_Change", True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboBG/g,"cboBG" + noOfRows)
	strcombohtml = strcombohtml.replace(/BusinessGroup_Change/g,"BusinessGroup_Change(0,"+ noOfRows +")");
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	//OrganizationUnit
	NewTD = NewTR.insertCell(2);
	NewTD.align='left';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_Sel_PM_LocationList 0", 150, "","onchange=OUPool_OnChange", True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboOU/g,"cboOU" + noOfRows)
	strcombohtml = strcombohtml.replace(/OUPool_OnChange/g,"OUPool_OnChange(this,0," + noOfRows+")");
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	
	//Delivery Unit
	NewTD = NewTR.insertCell(3);
	NewTD.align='left';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboDU", "usp_Sel_tbl_PM_ResourcePool 0", 150, "", "onchange=DUPool_OnChange", True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboDU/g,"cboDU" + noOfRows)
	strcombohtml = strcombohtml.replace(/DUPool_OnChange/g,"DUPool_OnChange(this,0," + noOfRows+")");
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	
    //Delivery Team
	NewTD = NewTR.insertCell(4);
	NewTD.align='left';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboDT", "usp_Sel_tbl_PM_GroupMaster 0", 150, "", , True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboDT/g,"cboDT" + noOfRows)
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
   
   //Project Type
	NewTD = NewTR.insertCell(5);
	NewTD.align='left';
	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboPT", "usp_Sel_Practice", 150, "", , True, True, , , , , 1).ToString.Replace("'","\'") %>'
	strcombohtml = strcombohtml.replace(/cboPT/g,"cboPT" + noOfRows)
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	
	
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
		var objform = GetFormReference('frmCommonList'); 
		var objPKvalue=GetObjectReference('frmCommonList','txtNOIID'); 
		objform.action='../DM/ApplicableAttributes_CommonList.aspx?NatureofDemandID='+objPKvalue.value+'&MasterTagID=3935&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&Action=SAVE&RowCount='+noOfRows;
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
		 
		  if(objcboBG!=null && objcboOU!=null && objcboDU!=null && objcboDT!=null && objcboPT!=null)
		 {
		   if(isBlank(objcboBG.value)==true && isBlank(objcboPT.value)==true) 
          {
              alert("Select at least one field value !");
              setFocus(objcboBG);
              return false;
          }   
          
          arrAttributes[c]=String(objcboBG.value)+String(objcboOU.value)+String(objcboDU.value)+String(objcboDT.value)+String(objcboPT.value);
          c+=1;
        }  
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
