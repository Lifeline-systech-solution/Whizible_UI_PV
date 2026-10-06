<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QType8_ManageQuestion_CommonPage.aspx.vb" Inherits="Whiz.QType8_ManageQuestion_CommonPage"%>

<script laguage='javascript' type="text/javascript">
var oSubTagChk;
try{ 
        oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
        if(oSubTagChk!=null && oSubTagChk.length==0)
            {New_OnClick_Tab209();New_OnClick_Tab209();}
        focusOnFirstControl();
}
catch(e){}
    
function ValidateNoOfOpts()
{
    oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
    if(oSubTagChk==null || oSubTagChk.length<2)
    {
	    alert('Please add at least 2 options.');
	    try{MultiInsertSubTabOnClick('209');}
	    catch (ex){}
	    return false;
    }
    return true;
}
</script>