<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UnlockUser_CommonList.aspx.vb" Inherits="PbNIT.UnlockUser_CommonList" %>

<script>
    function LockUnlock_Onclick() {
     
        var objform = GetFormReference('frmCommonList');
        objform.action = "../PasswordManagement/UnlockUser_CommonList.aspx?Action=Save";
        objform.submit();
    }
</script>