<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home_PageProfile.aspx.vb" Inherits="PbNIT.Home_PageProfile" %>

<!DOCTYPE>

<html>
<head runat="server">
    <title>Untitled Page</title>
        <script language="javascript">
            function ShowPopUp(LeaveID,PkToken)
            {
                //debugger;
                //alert(PkToken);
                
                //window.open("../../Source/HR/EmployeeLeaves_CommonPage.aspx?LeaveID_PK=1129&PKToken=7gsyur70S9qapoHEyZ7C2A&MasterTagID=1209&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"); 
                //window.open("../../Source/HR/EmployeeLeaves_CommonPage.aspx?LeaveID_PK=1129&PKToken=7gsyur70S9qapoHEyZ7C2A&MasterTagID=1209&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","","_Self"); 
                //window.open("../../Source/HR/EmployeeLeaves_CommonPage.aspx?LeaveID_PK=1129&PKToken=7gsyur70S9qapoHEyZ7C2A&MasterTagID=1209&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","","resizable=yes,scrollbars=no,Left=100,Top=100,height=550,width=650"); 
                //window.open("../../Source/HR/EmployeeLeaves_CommonPage.aspx?LeaveID_PK="+LeaveID+"&PKToken=7gsyur70S9qapoHEyZ7C2A&MasterTagID=1209&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","","resizable=yes,scrollbars=no,Left=100,Top=100,height=550,width=650"); 
                
                window.open("../../Source/HR/EmployeeLeaves_CommonPage.aspx?LeaveID_PK="+LeaveID+"&PKToken="+PkToken+"&MasterTagID=1209&FromWhere=Home&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","","resizable=yes,scrollbars=no,Left=100,Top=100,height=550,width=650"); 
                //window.open("../RT/RT_ResourceTimesheetView.aspx","","resizable=yes,scrollbars=no,Left=100,Top=100,height=550,width=650");
                
                //location.href="../../Source/HR/EmployeeLeaves_CommonPage.aspx?LeaveID_PK="+LeaveID+"&PKToken=7gsyur70S9qapoHEyZ7C2A&MasterTagID=1209&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
                //location.href="../../Source/HR/EmployeeLeaves_CommonPage.aspx?LeaveID_PK="+LeaveID+"&MasterTagID=1209&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
                //location.href="../../Source/HR/EmployeeLeaves_CommonPage.aspx?LeaveID_PK="+LeaveID+"&MasterTagID=1209&FromWhere=RM";
                
                //window.open("../HR/EmployeeLeaves_CommonPage.aspx","","resizable=yes,scrollbars=no,Left=100,Top=100,height=550,width=650");
            }
    </Script>    
</head>
<body>
    <form id="frmHomePageProfile" runat="server">
     <%WritePage()%>
    </form>
   
</body>
</html>
