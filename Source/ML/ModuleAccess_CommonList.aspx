<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ModuleAccess_CommonList.aspx.vb" Inherits="PbNIT.ModuleAccess_CommonList"%>

<script language=javascript >
    
    function EmployeeAccess(RemainingLicences,Shortname)
    {
        window.open ("../ML/EmployeeAccess_CommonList.aspx?FromWhere=SM&MasterTagID=20098&RemainingLicences=" + RemainingLicences + "&Shortname=" + Shortname,"MyPage","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400");
    }

</script>
