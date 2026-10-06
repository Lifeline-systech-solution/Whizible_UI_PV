<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DocumentAccess_CommonList.aspx.vb" Inherits="PbNIT.DocumentAccess_CommonList" %>
<script>
    function Save_onClick() {


        var objForm = GetFormReference('frmCommonList');
        //var IntDocumentId = GetObjectReference('frmCommonList','DocumentId');
        //var IntRoleId = GetObjectReference('frmCommonList','cboRole');
        //var BoolIsAllowed = GetObjectReference('frmCommonList','chkSelectAccess');
        // var IntAuthorisedBy = GetObjectReference('frmCommonList','');&roleid=45&IntDocumentId"+IntDocumentId.value+"&IntRoleId="+IntRoleId+"&BoolIsAllowed="+BoolIsAllowed+"

        //Find chkd and unchkd
        var ObjChkProjectSelect = GetObjectReference('frmCommonList', 'chkSelectAccess', true);
        // var ObjChkUnCheckedSelect = GetObjectReference('frmCommonList', 'HDN_TXT_UNCHEKED');

        //if (ObjChkProjectSelect != null) {
        //    ObjChkUnCheckedSelect.value = '';
        //    for (i = 0; i < ObjChkProjectSelect.length; i++) {
        //        if (ObjChkProjectSelect[i].checked == false) {
        //            ObjChkUnCheckedSelect.value = ObjChkUnCheckedSelect.value + ObjChkProjectSelect[i].value + ",";
        //        }
        //    }
        //}

        objForm.action = "DocumentAccess_CommonList.aspx?Action=Save&RoleID=" + <%=Request.QueryString("RoleID")%> +"";
        objForm.submit();
    }
</script>