
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <%CommonFunctions.General.PlotPageHeadTag("")%> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 12px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }
    /*Added By Vaijat K ON 08/12/2015 Issue ID-2606*/
    #divListPageTag
    {
        overflow:hidden !important;
    }
</style>


<%@ Page Language="vb" AutoEventWireup="false" Codebehind="prd_Customer_ProductVersion_CommonList.aspx.vb" Inherits="PbNIT.cPRD_Customer_ProductVersion_CommonList" %>

<script>

function CustomerOnChange()
{
	var objCustomer= GetObjectReference('frmCommonList','cboCustomer');
objfrm.action="../PRD/PRD_Customer_ProductVersion_CommonList.aspx?MasterTagID=3700&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&MODE=Change" + "&CustomerID="+objCustomer.value;
objfrm.submit();
return;
}

</script>
