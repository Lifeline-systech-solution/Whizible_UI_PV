<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QType4_ManageQuestion_CommonPage.aspx.vb" Inherits="Whiz.QType4_ManageQuestion_CommonPage"%>

<script language="javascript" type="text/javascript">
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
                    if(disallowNonNumeric(oRangeMin,"Please enter only numeric vale for 'Validation Minimum' !",true))
                        return false;
                }
                if (oRangeMax!=null && oRangeMax.value!='')
                {
                    if(disallowNonNumeric(oRangeMin,"Please enter only numeric vale for 'Validation Maximum' !",true))
                        return false;
                }
                break;
            case "9": //Text of specific length
                if (oRangeMin!=null && oRangeMin.value!='')
                {
                    if(disallowNegativeInteger(oRangeMin,"Please enter only positive integer vale for 'Validation Minimum' !",true))
                        return false;
                }
                if (oRangeMax!=null && oRangeMax.value!='')
                {
                    if(disallowNegativeInteger(oRangeMin,"Please enter only positive integer vale for 'Validation Maximum' !",true))
                        return false;
                }
                break;
            case "10": //Whole Number
                if (oRangeMin!=null && oRangeMin.value!='')
                {
                    if(disallowNegativeInteger(oRangeMin,"Please enter only positive integer vale for 'Validation Minimum' !",true))
                        return false;
                }
                if (oRangeMax!=null && oRangeMax.value!='')
                {
                    if(disallowNegativeInteger(oRangeMin,"Please enter only positive integer vale for 'Validation Maximum' !",true))
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
var objfrm;
var objdivlist;
objfrm = GetFormReference('frmCommonPage')
objdivlist=GetObjectReference('frmCommonPage','divPage');
function table_window_onresize()
{
    CP_window_onresize();
    objDiv = document.getElementById("tblInnerDiv");
    objDiv.style.height=objdivlist.style.height;
}
function table_window_onload()
{
    CP_window_onload();
    objDiv = document.getElementById("tblInnerDiv");
    objDiv.style.height=objdivlist.style.height;
}

document.body.onresize=table_window_onresize;
document.body.onload=table_window_onload;
</script>