<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QType6_ManageQuestion_CommonPage.aspx.vb" Inherits="Whiz.QType6_ManageQuestion_CommonPage"%>

<script laguage='javascript' type="text/javascript">
/*Options Subtag*/
var oSubTagChk;
try{ 
        oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
        if(oSubTagChk!=null && oSubTagChk.length==0)
            {New_OnClick_Tab206();New_OnClick_Tab206();}
        focusOnFirstControl();
}
catch(e){}
    
/*Rows Subtag*/
try{
        oSubTagChk=GetObjectReference('frmCommonPage','RowText_English',true);
        if(oSubTagChk!=null && oSubTagChk.length==0)
            {New_OnClick_Tab207();New_OnClick_Tab207();}
        focusOnFirstControl();
}
catch(e){}
 
    
function ValidateNoOfOpts()
{
    oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
    if(oSubTagChk==null || oSubTagChk.length<2)
    {
	    alert('Please add at least 2 options.');
	    try{MultiInsertSubTabOnClick('206');}
	    catch (ex){}
	    return false;
    }
    return true;
}

function ValidateNoOfRows()
{
    oSubTagChk=GetObjectReference('frmCommonPage','RowText_English',true);
    if(oSubTagChk==null || oSubTagChk.length<2)
    {
	    alert('Please add at least 2 rows.');
	    try{MultiInsertSubTabOnClick('207');}
	    catch (ex){}
	    return false;
    }
    return true;
}    
</script>
