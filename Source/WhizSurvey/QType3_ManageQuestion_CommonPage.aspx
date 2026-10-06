<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QType3_ManageQuestion_CommonPage.aspx.vb" Inherits="Whiz.QType3_ManageQuestion_CommonPage"%>

<script laguage='javascript' type="text/javascript">
var oSubTagChk;
try{ 
        oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
        if(oSubTagChk!=null && oSubTagChk.length==0)
            {New_OnClick_Tab203();New_OnClick_Tab203();}
        focusOnFirstControl();
}
catch(e){}
    
function ValidateNoOfOpts()
{
    oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
    if(oSubTagChk==null || oSubTagChk.length<2)
    {
	    alert('Please add at least 2 options.');
	    try{MultiInsertSubTabOnClick('203');}
	    catch (ex){}
	    return false;
    }
    return true;
}
function CorrectValidationSelected()
{
    var oNoOfOptsReq=GetObjectReference('frmCommonPage','HowManyOptionsRequired');
    var iLen=0,iNoOfOptsReq=0;
    if (ValidateNoOfOpts()==false)
        return false;        
    else
        iLen=parseInt(oSubTagChk.length);
        
    if (oNoOfOptsReq!=null && oNoOfOptsReq.value!=='')
    {
        iNoOfOptsReq=parseInt(oNoOfOptsReq.value);

        if (iNoOfOptsReq>iLen)
        {
            alert("'# Options Rquired' should not be greater than " + iLen + " !");
            oNoOfOptsReq.focus();
            return false;
         }
    }
}
function HowManyOptsReq_Change(obj)
{
    var oNoOfOptsReq=GetObjectReference('frmCommonPage','HowManyOptionsRequired');
    if (obj!=null && oNoOfOptsReq!=null)
    {
        if (obj.selectedIndex==0)
            oNoOfOptsReq.value='';
    }
}
</script>