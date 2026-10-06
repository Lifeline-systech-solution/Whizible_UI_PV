<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AlertLevel_CommonPage.aspx.vb" Inherits="PbNIT.AlertLevel_CommonPage"%>
<script>
function SaveRecords()
	{
		if(!validateControls()) return;
		var objform=GetFormReference('frmCommonPage');
		var objPKvalue=GetObjectReference('frmCommonPage','txtNOIID');
		var objOrderNumber=GetObjectReference('frmCommonPage','OrderNumber');
		var token=GetObjectReference('frmCommonPage','txtToken');
		var objAlert=GetObjectReference('frmCommonPage','Alert');
		    
		
		alert(objOrderNumber.value);
		alert(objAlert.value)
		if (objAlertColor.value=="")
		{
		    alert('Color should not be left blank');
           return;
		}
		if (objOrderNumber.value>9)
		{
		    alert('Please Enter value between 0 to 9');
		    return;
		}
		 if (objAlert.value=="");
        {
          alert('value should not be left blank');
           return;
        }
        if (objOrderNumber.value=="")
        {
             alert('Order Number should not be left blank');
            return;
        }
		if(isNaN(objOrderNumber.value) || objOrderNumber.value<=0 || disallowNonInteger(objOrderNumber.value))
		{
		     alert('"Please enter the positive numeric value"');
		    return;
		}
       
		objform.action='../General/AlertLevel_CommonPage.aspx?AlertID_PK='+objPKvalue.value+'&PKToken='+ token +'&MasterTagID=20031&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&Action=SAVE';
		alert(objform.action);
		objform.submit();
	}
</Script>