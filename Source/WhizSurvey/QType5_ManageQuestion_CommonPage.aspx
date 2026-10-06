<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QType5_ManageQuestion_CommonPage.aspx.vb" Inherits="Whiz.QType5_ManageQuestion_CommonPage"%>

<script laguage='javascript' type="text/javascript">
/*Options SubTag*/
var oSubTagChk;
try{ 
        oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
        if(oSubTagChk!=null && oSubTagChk.length==0)
            {New_OnClick_Tab204();New_OnClick_Tab204();}
        focusOnFirstControl();
}
catch(e){}

/*Rows SubTag*/
try{
        oSubTagChk=GetObjectReference('frmCommonPage','RowText_English',true);
        if(oSubTagChk!=null && oSubTagChk.length==0)
            {New_OnClick_Tab205();New_OnClick_Tab205();}
        focusOnFirstControl();

}
catch(e){}

function ValidateNoOfOpts()
{
    oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
    if(oSubTagChk==null || oSubTagChk.length<2)
    {
	    alert('Please add at least 2 options.');
	    try{MultiInsertSubTabOnClick('204');}
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
	    try{MultiInsertSubTabOnClick('205');}
	    catch (ex){}
	    return false;
    }
    return true;
}    
</script>
