<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MyPreferences_CommonList.aspx.vb" Inherits="PbNIT.MyPreferences_CommonList" %>

<script>
function validatecontrol()
{
/*var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmCommonList','chkDelete')
if (blnIsRecordSelected == false) {return false;}*/
var objtxtHidUCS = GetObjectReference('frmCommonList','txtHidUCS');
var strUCboxes="";
var objCheckbox = GetObjectReference('frmCommonList','chkDelete',true);
var objcmbHid =GetObjectReference('frmCommonList','cmbHid');
var intItems;
var intCtr;
var c=0;
var IsSelected=false;
if (objCheckbox != null)
{
	intItems = objCheckbox.length;
	for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
	{
	if(objCheckbox[intCtr].checked == true)
	{
		var objtxtON=GetObjectReference('frmCommonList','txtOrderNo'+objCheckbox[intCtr].value)
		if(objtxtON!=null)
		{	
			if (disallowBlank(objtxtON,'Order No. should not be blank !',true))
					return false;
			if (disallowNegativeInteger(objtxtON,'Please enter only positive integer only !',true))
					return false;
			if(parseInt(objtxtON.value) == 0)
			{ alert('Order No should be greater than zero !');return false;}	
		
		IsSelected = true;
	  }
	}
	else { strUCboxes=strUCboxes + String(objCheckbox[intCtr].value)+','}		
   }
	
}
 if(objtxtHidUCS!=null)
	objtxtHidUCS.value=strUCboxes
	

 if(IsSelected == false)
 {
    alert('select atleast one tab');
    return false;
 }
	return true;
}
</script>