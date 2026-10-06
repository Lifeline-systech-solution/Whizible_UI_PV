<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QType9_ManageQuestion_CommonPage.aspx.vb" Inherits="Whiz.QType9_ManageQuestion_CommonPage"%>

<script laguage='javascript' type="text/javascript">
var oSubTagChk;
try{ 
        oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
        if(oSubTagChk!=null && oSubTagChk.length==0)
            {New_OnClick_Tab210();New_OnClick_Tab210();}
        focusOnFirstControl();
}
catch(e){}
    
function ValidateNoOfOpts()
{
    oSubTagChk=GetObjectReference('frmCommonPage','OptionText_English',true);
    if(oSubTagChk==null || oSubTagChk.length<2)
    {
	    alert('Please add at least 2 options.');
	    try{MultiInsertSubTabOnClick('210');}
	    catch (ex){}
	    return false;
    }
    return true;
}
function IsValidRange()
{
    var oRangeMin=GetObjectReference('frmCommonPage','Validation_Minimum');
    var oRangeMax=GetObjectReference('frmCommonPage','Validation_Maximum');
    var oValidationID=GetObjectReference('frmCommonPage','ValidationID');
    if (oValidationID!=null)
    {
        switch(oValidationID[oValidationID.selectedIndex].value)
        {
            case "7": //Decimal number
                if (oRangeMin!=null && oRangeMin.value!='')
                {
                    disallowNonNumeric(oRangeMin,"Please enter only numeric vale for 'Validation Minimum' !",true);
                    return false;
                }
                if (oRangeMax!=null && oRangeMax.value!='')
                {
                    disallowNonNumeric(oRangeMin,"Please enter only numeric vale for 'Validation Maximum' !",true);
                    return false;
                }
                break;
            case "9": //Text of specific length
                if (oRangeMin!=null && oRangeMin.value!='')
                {
                    disallowNegativeInteger(oRangeMin,"Please enter only positive integer vale for 'Validation Minimum' !",true);
                    return false;
                }
                if (oRangeMax!=null && oRangeMax.value!='')
                {
                    disallowNegativeInteger(oRangeMin,"Please enter only positive integer vale for 'Validation Maximum' !",true);
                    return false;
                }
                break;
            case "10": //Whole Number
                if (oRangeMin!=null && oRangeMin.value!='')
                {
                    disallowNegativeInteger(oRangeMin,"Please enter only positive integer vale for 'Validation Minimum' !",true);
                    return false;
                }
                if (oRangeMax!=null && oRangeMax.value!='')
                {
                    disallowNegativeInteger(oRangeMin,"Please enter only positive integer vale for 'Validation Maximum' !",true);
                    return false;
                }
                break;
            default:
                return true
                break;
        }
    }
    return true;
}
</script>