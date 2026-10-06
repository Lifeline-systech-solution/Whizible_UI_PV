<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QuestionLibrary_CommonPage.aspx.vb" Inherits="Whiz.QuestionLibrary_CommonPage"%>
<script language="javascript" type="text/javascript">

function StandardDelete()
{
//Standard delete logic for subtag
var blnIsRecordSelected=false;
blnIsRecordSelected=IsCheckboxSelected('frmCommonList','chkDelete212');
if (blnIsRecordSelected == false) {return;}
    if (confirm('Are you sure, you want to delete the selected records?')) 
    {
        var table =  document.getElementById('tblGrid1789212');
        var len;
        var Subtract;
        if(document.getElementById('tblGrid1789212_SummaryExists')==null)
        {
            len=table.rows.length;
            Subtract=1;
        }
        else
        {
            len=table.rows.length-1;
            Subtract=2;
        }
        var RecordCount=len-1;
        for (var i = 1; i < len; i++)
        {
            var objDelete;
            if(document.getElementById('ShowDeleteColumnFirst212').value=='True')
                objDelete=table.rows[i].cells[0].firstChild;
            else
                objDelete=table.rows[i].cells[table.rows[i].cells.length-1].firstChild;
            if(objDelete.checked==true && objDelete.id=='chkDelete212')
            {
                table.deleteRow(i);
                i=i-1;
                len=len-1;
            }
        }
        try
        {
            document.getElementById('RecordCountOnTab212').innerHTML=document.getElementById('RecordCountOnTab212').innerHTML.replace('(' + (RecordCount) + ')' ,'(' + (table.rows.length - Subtract) + ')');
        }
        catch (e) {}
        try
        {
            document.getElementById('RecordCountOnGrid212').innerHTML=document.getElementById('RecordCountOnGrid212').innerHTML.replace(' :' + (RecordCount) ,' :' + (table.rows.length - Subtract));
        }
        catch (e) {}
        if(document.getElementById('tblGrid1789212_SummaryExists')!=null)
            SetMultiInsertSubtagSummaryTotal(document.getElementById('tblGrid1789212_SummaryExists').value);
    }
    
//To rearrange rating numbers.
var count=0;
var objLastRow=GetObjectReference('frmCommonPage','OptionText_English',true);
for(count=0; count<objLastRow.length;count++)
{
    objLastRow[count].value=count+1;
    objLastRow[count].disabled=true;
}

}

function InsertInSaveClickJSFunction()
{
var cnt=0;
var objLastRow=GetObjectReference('frmCommonPage','OptionText_English',true);
var iLen=objLastRow.length;
for(cnt=0; cnt < iLen; cnt++)
{
    if(disallowNegativeInteger(GetObjectReference('frmCommonPage','OptionText_English',true)[cnt],'Please enter only positive Integer',true))
        return false;

    if (CheckDuplicate_MultiInsertGrid('OptionText_English','&#39;Option&#39; already exists.',cnt,false,false)==false)
        return false;
}
//Enable all the controls to save them.
for(cnt=0; cnt<iLen;cnt++)
{
    objLastRow[cnt].disabled=false;
}
return true;

}


function InsertInNewClickJSFunction()
{
var ControlDef_OptionText_English_212='';
try{ControlDef_OptionText_English_212=document.getElementById('ControlDef_OptionText_English_212').value;} catch (e) {}
AddNewRow_MultiInsertGrid('212','tblGrid1789212',ControlDef_OptionText_English_212);

var count=0;
var objLastRow=GetObjectReference('frmCommonPage','OptionText_English',true);
objLastRow[objLastRow.length-1].focus();
for(count=0; count<objLastRow.length;count++)
{
    objLastRow[count].value=count+1;
    objLastRow[count].disabled=true;
}
}

var objfrm;
var objdivlist;
objfrm = GetFormReference('frmCommonPage')
objdivlist=GetObjectReference('frmCommonPage','divPage');
function table_window_onresize()
{
    CP_window_onresize();
    objDiv = document.getElementById("tblInnerDiv");
    
    var oSuTagDiv212=document.getElementById('divListTag212');
    var oSuTagDiv213=document.getElementById('divListTag213');
    if(oSuTagDiv212==null)
    {
        objDiv.style.height=objdivlist.style.height;
    }
    else
    {
        var iHeight=parseInt(objdivlist.style.height.replace("px",""))-400;
        if(iHeight<100) iHeight=100;
        objDiv.style.height=iHeight;
        oSuTagDiv212.style.height=250;
        if(oSuTagDiv213!=null)
            oSuTagDiv213.style.height=oSuTagDiv212.style.height;
    }
}
function table_window_onload()
{
    CP_window_onload();
    objDiv = document.getElementById("tblInnerDiv");
    
    var oSuTagDiv212=document.getElementById('divListTag212');
    var oSuTagDiv213=document.getElementById('divListTag213');
    if(oSuTagDiv212==null)
        objDiv.style.height=objdivlist.style.height;
    else
    {
        objDiv.style.height=parseInt(objdivlist.style.height.replace("px",""))-400;
        oSuTagDiv212.style.height=250;
        
        if(oSuTagDiv213!=null)
            oSuTagDiv213.style.height=oSuTagDiv212.style.height;
    }
        
}

document.body.onresize=table_window_onresize;
document.body.onload=table_window_onload;
</script>