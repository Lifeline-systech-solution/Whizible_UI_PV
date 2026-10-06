<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UnauthorizePage.aspx.vb" Inherits="PbNIT.UnauthorizePage" %>

<!DOCTYPE html>

<html>
       <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head runat="server">
 <%--   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">    
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">

</head>
<body class="clsBody" MS_POSITIONING="GridLayout">
    <form id="form1" method="post" runat="server">
        <div class="container-fluid pt-1 pb-1 mb-1 text-right">
           <div style="text-align:center;font-size:15px;">
               You are not authorized to view this record.
           </div>             
           <%-- <a href="../NewAPI/Resources/RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-toggle="tooltip" data-placement="bottom" title="Back to Resource Configuration">Back</a>--%>
        </div>
    </form>
</body>
</html>
