<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CustomerMapping_CommonList.aspx.vb" Inherits="PbNIT.CustomerMapping_CommonList"%>
<script>
     
   
  
    var objTbl = GetObjectReference('','tblGrid03963');           
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
		var objform=GetFormReference('frmCommonList');
		var objPKvalue=GetObjectReference('frmCommonList','txtNOIID');
		
		objform.action='../General/CustomerMapping_CommonList.aspx?CustomerID='+objPKvalue.value+'&MasterTagID=3963&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&Action=SAVE&RowCount='+noOfRows;
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
