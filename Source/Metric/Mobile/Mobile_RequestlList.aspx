<%@ Page Language="VB" AutoEventWireup="false" Inherits="PbNIT.Mobile_RequestList" Codebehind="Mobile_RequestlList.aspx.vb" %>

<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
    <mobile:Form ID="frmRequestList" Runat="server">
    <mobile:Label ID="PageCaption" Font-Bold="True" Runat="server">Leave Approvals</mobile:Label> 
    <br />
    <mobile:Link ID="LnkBack1" Runat="server" NavigateUrl="Mobile_Approvals.aspx" BreakAfter="False">Back</mobile:Link> | 
    <mobile:Link ID="LnkLogOut1" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?Mode=LogOut" BreakAfter="False">Logout</mobile:Link> 
    <mobile:Label ID="LblBar4" Runat ="server" BreakAfter="False" >&nbsp;|&nbsp;</mobile:Label>    
    <mobile:Command ID="CmdApprove" Runat="server" BreakAfter="False" Format="Link">Approve</mobile:Command>
    <mobile:Label ID="LblBar5" Runat ="server" BreakAfter="False" >&nbsp;|&nbsp;</mobile:Label>   
    <mobile:Command ID="CmdReject" Runat="server" Format="Link">Reject</mobile:Command> <br />
    <mobile:Link ID="LnkFirst" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?PageNo=1" BreakAfter="False">First</mobile:Link>
    <mobile:Label ID="LblBar1" Runat ="server" BreakAfter="False"  >&nbsp;|&nbsp;</mobile:Label> 
    <mobile:Link ID="LnkPrevious" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?PageNo=1" BreakAfter="False">Previous</mobile:Link>
    <mobile:Label ID="LblBar2" Runat ="server"  BreakAfter="False" >&nbsp;|&nbsp;</mobile:Label>  
    <mobile:Link ID="LnkNext" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?PageNo=1" BreakAfter="False">Next</mobile:Link>
    <mobile:Label ID="LblBar3" Runat ="server" BreakAfter="False" >&nbsp;|&nbsp;</mobile:Label>   
    <mobile:Link ID="LnkLast" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?PageNo=1">Last</mobile:Link> <br />
    
     <br />
    </mobile:Form>
</body>
</html>
