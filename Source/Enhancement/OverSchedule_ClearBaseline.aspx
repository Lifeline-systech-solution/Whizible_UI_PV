<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OverSchedule_ClearBaseline.aspx.vb" Inherits="PbNIT.OverSchedule_ClearBaseline" %>

<!DOCTYPE html>

<html>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <% CommonFunctions.General.PlotPageHeadTag("Clear Baseline")%>
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<head runat="server">
    <title>Clear Baseline</title>

</head>
<body>
    <form id="frmOSClearBaseline" runat="server">
        <%PageInit()%>	
    </form>
    
    <script language= "javascript" type="text/javascript" >
    var objform = GetFormReference('frmOSClearBaseline');
    var objDivMain=GetObjectReference('frmOSClearBaseline','divList');

     var objchkSelect = GetObjectReference('frmOSClearBaseline', 'chkSelect', true)

     function ClearBaseline_OnClick() {
         var TotalRows = objchkSelect.length;
         var LoopCtr;
         var flag = false;

         for (LoopCtr = 0; LoopCtr < TotalRows; LoopCtr++) {
             if (objchkSelect[LoopCtr].checked == true) {
                 flag = true;
                 break;
             }
             else {
                 flag = false;
             }
         }
         if (flag != true) {
             alert("Please select at least one record!");
             return;
         }

         objform.action = '../Enhancement/OverSchedule_ClearBaseline.aspx?Action=ClearBaseline';
         objform.submit();
     }


 function ClearAll_OnClick() {
     var LoopCtr;
     var TotalRows = objchkSelect.length;

             if (TotalRows == 0) { alert("There are no attributes to clear"); return; }
             else if (TotalRows == 1) {
                 objchkSelect[0].checked = false;
             }
             else {
                 for (LoopCtr = 0; LoopCtr < TotalRows; LoopCtr++)
                 {
                     if (objchkSelect[LoopCtr].disabled != true)
                        objchkSelect[LoopCtr].checked = false;
                 }
             }     
 }
 function SelectAll_OnClick() {
     var LoopCtr;
     var TotalRows = objchkSelect.length;

     if (TotalRows == 0) { alert("There are no attributes to select"); return; }
     else if (TotalRows == 1) {
         objchkSelect[0].checked = true;
     }
     else {
         for (LoopCtr = 0; LoopCtr < TotalRows; LoopCtr++)
         {
             if (objchkSelect[LoopCtr].disabled != true)
                objchkSelect[LoopCtr].checked = true;
         }
     }
     
 }
 
    </script>
</body>
</html>
;