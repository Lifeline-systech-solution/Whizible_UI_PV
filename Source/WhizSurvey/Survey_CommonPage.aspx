<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Survey_CommonPage.aspx.vb" Inherits="Whiz.Survey_CommonPage"%>
<script language="javascript" type="text/javascript">
function CreateCat_OnClick()
{
    window.open('../WhizSurvey/SurveyCategory_CommonPage.aspx?Mode=ADD_NEW&FromSurvey=1&MasterTagID=1784','_new',"resizable=no,scrollbars=no,left=" + ((window.screen.width - 920)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=920,height=400");
}

var objfrm;
var objdivlist;
var objdivS1;
objfrm = GetFormReference('frmCommonPage')
objdivlist=GetObjectReference('frmCommonPage','divPage');
function table_window_onresize()
{
    CP_window_onresize();
    objDiv = document.getElementById("tblInnerDiv");
    if(document.getElementById('divListTag')==null)
    {
        objDiv.style.height=parseInt(objdivlist.style.height.replace("px",""))-25;
    }
}
function table_window_onload()
{
    CP_window_onload();
    objDiv = document.getElementById("tblInnerDiv");
    if(document.getElementById('divListTag')==null)
    {
       objDiv.style.height=parseInt(objdivlist.style.height.replace("px",""))-25;
    }
}

document.body.onresize=table_window_onresize;
document.body.onload=table_window_onload;
</script>