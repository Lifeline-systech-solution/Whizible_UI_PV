<%@ Page Language="VB" AutoEventWireup="false" Inherits="PbNIT.Mobile_RequestApprovalRejection" Codebehind="Mobile_RequestApprovalRejection.aspx.vb" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<body>
    <mobile:Form id="frmRequestApprovalRejection" runat="server" >
     <mobile:Link ID="LnkBack1"  Runat="server"  NavigateUrl="Mobile_RequestApprovalRejection.aspx"  BreakAfter="False" >Back</mobile:Link> |
    <mobile:Link ID="LnkLogOut1"  Runat="server"  NavigateUrl="Mobile_RequestApprovalRejection.aspx?Mode=Logout" >Logout</mobile:Link>
<br />
<%--   <mobile:Textview Runat="Server" ID="EmployeeName" ></mobile:Textview>
    <mobile:Textview Runat="Server" ID="FromDate"   ></mobile:Textview> 
    <mobile:Textview Runat="Server" ID="ToDate" ></mobile:Textview> 
    <mobile:Textview Runat="Server" ID="LeaveType"  ></mobile:Textview> 
    <mobile:Textview Runat="Server" ID="LeaveBalance"  ></mobile:Textview> 
    <mobile:Textview Runat="Server" ID="IsHalfDay"  ></mobile:Textview> 
    <br />
    <mobile:Label Runat="Server" Font-Bold="True"  ID="lblComment" >Comment: </mobile:Label>     
    <mobile:TextBox Runat="server" ID="txtComment" Size="50" MaxLength="200" ></mobile:TextBox>  
    <mobile:RequiredFieldValidator Runat="server"   ID="ValidateComment" ErrorMessage="Please, Enter Comment" ControlToValidate="txtComment" ></mobile:RequiredFieldValidator>   
    <mobile:Command runat="server" ID="CmdApprove" OnClick="Approve_OnClick"  BreakAfter="False"  >Approve</mobile:Command> 
    <mobile:Command runat="server" ID="CmdReject" OnClick="Reject_OnClick" >Reject</mobile:Command> 
    <br />
    <mobile:Link ID="LnkBack"  Runat="server"  NavigateUrl="Mobile_LeaveApprovalList.aspx"  BreakAfter="False" >Back</mobile:Link> |
    <mobile:Link ID="LnkLogOut"  Runat="server"  NavigateUrl="Mobile_LeaveApprovals.aspx?Mode=Logout"  BreakAfter="False" >Logout</mobile:Link>
--%> 
</mobile:Form>
      
</body>
</html>
