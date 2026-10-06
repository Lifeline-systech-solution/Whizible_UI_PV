<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FontSettings_CommonPage.aspx.vb" Inherits="Whiz.FontSettings_CommonPage"%>

<script language="javascript" type="text/javascript">
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