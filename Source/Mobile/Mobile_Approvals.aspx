<%@ Page Language="VB" AutoEventWireup="false" Inherits="PbNIT.Mobile_Approvals" Codebehind="Mobile_Approvals.aspx.vb" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<body>
    <mobile:Form id="frmMobileApprovals" runat="server"  >
   <mobile:Link ID="Link1"  Runat="server"   NavigateUrl="Mobile_Approvals.aspx?Mode=Logout" >Logout</mobile:Link>
   <br />
<%--    <mobile:Link ID="LnkLeaveApproval" Runat="server" NavigateUrl="Mobile_LeaveApprovalList.aspx" >Leave Approvals</mobile:Link>
    <mobile:Link ID="LnkRTApprovals" Runat="server" NavigateUrl="Mobile_RTApprovalList.aspx" >Resource Timesheet Approvals</mobile:Link>
    <mobile:Link ID="LnkProjectApprovals" Runat="server" NavigateUrl="Mobile_ProjectApprovalList.aspx" >Project Approvals</mobile:Link>
    <mobile:Link ID="LnkHelpDesk" Runat="server" NavigateUrl="Mobile_HelpDeskRequests.aspx" >HelpDesk  Requests</mobile:Link>
    <mobile:Link ID="LnkProjectTimeSheet" Runat="server" NavigateUrl="Mobile_PTApprovalList.aspx"  >Project Timesheet Approval</mobile:Link>
--%>    
    <mobile:Link ID="LnkLeaveApproval" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?Mode=Leave" >Leave Approvals</mobile:Link>
    <mobile:Link ID="LnkRTApprovals" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?Mode=ResourceTimesheet" >Resource Timesheet Approvals</mobile:Link>
    <mobile:Link ID="LnkProjectApprovals" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?Mode=Project" >Project Approvals</mobile:Link>
    <mobile:Link ID="LnkHelpDesk" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?Mode=HelpDesk" >HelpDesk  Requests</mobile:Link>
    <mobile:Link ID="LnkProjectTimeSheet" Runat="server" NavigateUrl="Mobile_RequestlList.aspx?Mode=ProjectTimesheet"  >Project Timesheet Approval</mobile:Link>
    <mobile:Label ID="LblNoRequests" Runat="server"  Visible="False">There are no requests pending for approval.</mobile:Label>
    <br />
    <mobile:Link ID="LnkLogOut"  Runat="server"   NavigateUrl="Mobile_Approvals.aspx?Mode=Logout" >Logout</mobile:Link>
    </mobile:Form>
</body>
</html>
