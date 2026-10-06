Imports System.Text
Partial Public Class Home_PageProfile
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
#Region " Initialize Variables "
    Private sbHTML As StringBuilder
    Private m_lngEmployeeID As Long
    Private m_intUserID As Integer
    Protected m_strToken As String
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Call Initialize()
    End Sub
    Protected Sub WritePage()
        m_intUserID = HttpContext.Current.Session("intUserID")
        Call DrawPage()
    End Sub
    Private Sub DrawPage()
        Dim strSQL As String
        Dim reader As IDataReader
        Dim strEmployeeName As String
        Dim strRoleDescription As String
        Dim strDate As Date

        ' SP to get Profile details of logged user
        strSQL = "usp_GetUserProfileDetails " & m_intUserID.ToString
        ' Call to Execute SP 
        reader = CommonFunction.Data.GetDataReader(strSQL, True)

        While reader.Read()
            strEmployeeName = CommonFunctions.Data.CheckIsDBNull(reader("EmployeeName"), "")
            strRoleDescription = CommonFunctions.Data.CheckIsDBNull(reader("RoleDescription"), "")
            strDate = CommonFunctions.Data.CheckIsDBNull(reader("JoiningDate"), "")
        End While
        CommonFunction.Data.DisposeDataReader(reader)
        'CommonFunction.General.WriteHTML("<Div id='divUpperMain' Style='HEIGHT:500%;OVERFLOW:auto; WIDTH:99.9%; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<table border='1' height='99.99%' width ='99.99%'>")
        CommonFunction.General.WriteHTML("<tr height='60%'>")
        'My Profile
        CommonFunction.General.WriteHTML("<td width='33.33%' valign='top'>")
        CommonFunction.General.WriteHTML("<Div style='width: 315px; height: 300px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<div style='width: 100px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; padding-left:20px;'>My Profile</font>")
        CommonFunction.General.WriteHTML("</Div>")
        CommonFunction.General.WriteHTML("<div style='width: 100px; height: 120px; margin:10px 0px 0px 5px; border:1px solid black; float:left ;'>")
        CommonFunction.General.WriteHTML("Image" & vbCrLf)
        CommonFunction.General.WriteHTML("</Div>")

        CommonFunction.General.WriteHTML("<div style='width: 200px; height: 120px; margin:10px 0px 0px 5px; float:left ;'>")
        CommonFunction.General.WriteHTML("<table border='1' height='99.99%' width ='99.99%'>")
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("<td align='right'><font size='2' face='verdana'>Name :</font></td>")
        CommonFunction.General.WriteHTML("<td align='left'><font size='2' face='verdana'>" & strEmployeeName & "</font></td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("<td align='right'><font size='2' face='verdana'>Role :</font></td>")
        CommonFunction.General.WriteHTML("<td  align='left'><font size='2' face='verdana'>" & strRoleDescription & "</font></td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("<td align='right'><font size='2' face='verdana'>Joining Date :</font></td>")
        CommonFunction.General.WriteHTML("<td align='left'><font size='2' face='verdana'>" & strDate & "</font></td>")
        CommonFunction.General.WriteHTML("</tr> ")
        CommonFunction.General.WriteHTML("</table")
        CommonFunction.General.WriteHTML("</Div>")

        CommonFunction.General.WriteHTML("</Div>")
        CommonFunction.General.WriteHTML("</td>")
        'End OF My Profile

        'My Approvers
        CommonFunction.General.WriteHTML("<td width='33.33%' valign='top'>")
        CommonFunction.General.WriteHTML("<Div style='width: 315px; height: 300px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<div style='width: 200px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; padding-left:20px;'>My Approval</font>")
        CommonFunction.General.WriteHTML("</Div>")
        'Starts Projects'
        CommonFunction.General.WriteHTML("<div style='width: 300px; height: 83px; margin:5px 0px 0px 5px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<div style='width: 200px; margin:5px 0px 0px 5px'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; '> Projects</font> ")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</div>")
        'End OF Projects'

        'Starts Leaves'
        CommonFunction.General.WriteHTML("<div style='width: 300px; height: 83px; margin:5px 0px 0px 5px; border:1px solid black; overflow:auto ;'>")
        CommonFunction.General.WriteHTML("<div style='width: 200px; margin:5px 0px 0px 5px'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; '> Leaves</font> ")
        CommonFunction.General.WriteHTML("</div>")
        '---------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("<div style='width: 295px; height:auto;  margin:5px 0px 0px 2px;'>")
        CommonFunction.General.WriteHTML("<table border='0' height='99.99%' width ='99.99%' style='border: 1px solid black;border-collapse:collapse;' >")
        CommonFunction.General.WriteHTML("<tr style='border: 1px solid black;'>")
        CommonFunction.General.WriteHTML("<th align='left' width='33.33%' style='border: 1px solid black;'><font size='1' face='verdana'>Employee Name</font></th>")
        CommonFunction.General.WriteHTML("<th width='33.33%' style='border: 1px solid black;'><font size='1' face='verdana'>From Date</font></th>")
        CommonFunction.General.WriteHTML("<th width='33.33%' style='border: 1px solid black;'><font size='1' face='verdana'>To Date</font></th>")
        CommonFunction.General.WriteHTML("</tr>")
        'Define variable required
        Dim intLeaveID As Integer
        Dim strFromDate As Date
        Dim strToDate As Date

        
        strSQL = "usp_GetEmployeeLeaveDetails " & m_intUserID.ToString

        reader = CommonFunction.Data.GetDataReader(strSQL, True)

        While reader.Read()
            strEmployeeName = CommonFunctions.Data.CheckIsDBNull(reader("EmployeeName"), "")
            strFromDate = CommonFunctions.Data.CheckIsDBNull(reader("FromDate"), "")
            strToDate = CommonFunctions.Data.CheckIsDBNull(reader("ToDate"), "")
            intLeaveID = CommonFunctions.Data.CheckIsDBNull(reader("LeaveID"), "")

            'Code to generate PK Token
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(intLeaveID, String) + CType(m_intUserID, String) + "0" + "1209")
            'End OF Code to generate PK Token


            CommonFunction.General.WriteHTML("<tr style='border: 1px solid black;'>")
            CommonFunction.General.WriteHTML("<td align='left' style='border: 1px solid black;'><a style='cursor:hand;text-decoration:underline;' onclick=""javascript:ShowPopUp(" & intLeaveID & ",'" & m_strToken & "')""><font size='1' face='verdana'>" & strEmployeeName & "</font></a> </td>")
            CommonFunction.General.WriteHTML("<td align='center' style='border: 1px solid black;'><font size='1' face='verdana'>" & strFromDate & "</font></td>")
            CommonFunction.General.WriteHTML("<td align='center' style='border: 1px solid black;'><font size='1' face='verdana'>" & strToDate & "</font></td>")
            CommonFunction.General.WriteHTML("</tr>")

        End While

        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div>")


        'CommonFunction.General.WriteHTML("<div style='width: 295px; height:auto;  margin:5px 0px 0px 0px;'>")
        'CommonFunction.General.WriteHTML("<table border='0' height='99.99%' width ='99.99%' style='border: 1px solid black;border-collapse:collapse;' >")
        'CommonFunction.General.WriteHTML("<tr style='border: 1px solid black;'>")
        'CommonFunction.General.WriteHTML("<th align='left' width='33.33%' style='border: 1px solid black;'><font size='1' face='verdana'>Employee Name</font></th>")
        'CommonFunction.General.WriteHTML("<th width='33.33%' style='border: 1px solid black;'><font size='1' face='verdana'>From Date</font></th>")
        'CommonFunction.General.WriteHTML("<th width='33.33%' style='border: 1px solid black;'><font size='1' face='verdana'>To Date</font></th>")
        'CommonFunction.General.WriteHTML("</tr>")
        'CommonFunction.General.WriteHTML("<tr style='border: 1px solid black;'>")
        'CommonFunction.General.WriteHTML("<td align='left' style='border: 1px solid black; height: 34px;'><font size='1' face='verdana'>Whizible Administrator</font> </td>")
        'CommonFunction.General.WriteHTML("<td align='center' style='border: 1px solid black; height: 34px;'><font size='1' face='verdana'>27/12/2013</font></td>")
        'CommonFunction.General.WriteHTML("<td align='center' style='border: 1px solid black; height: 34px;'><font size='1' face='verdana'>30/12/2013</font></td>")
        'CommonFunction.General.WriteHTML("</tr>")
        'CommonFunction.General.WriteHTML("<tr>")
        'CommonFunction.General.WriteHTML("<td align='left' style='border: 1px solid black;'><font size='1' face='verdana'>Some Name</font> </td>")
        'CommonFunction.General.WriteHTML("<td align='center' style='border: 1px solid black;'><font size='1' face='verdana'>FromDate</font></td>")
        'CommonFunction.General.WriteHTML("<td align='center' style='border: 1px solid black;'><font size='1' face='verdana'>ToDate</font></td>")
        'CommonFunction.General.WriteHTML("</tr>")
        'CommonFunction.General.WriteHTML("<tr>")
        'CommonFunction.General.WriteHTML("<td align='left' style='border: 1px solid black;'><font size='1' face='verdana'>Some Name</font> </td>")
        'CommonFunction.General.WriteHTML("<td align='center' style='border: 1px solid black;'><font size='1' face='verdana'>FromDate</font></td>")
        'CommonFunction.General.WriteHTML("<td align='center' style='border: 1px solid black;'><font size='1' face='verdana'>ToDate</font></td>")
        'CommonFunction.General.WriteHTML("</tr>")
        'CommonFunction.General.WriteHTML("</table>")
        'CommonFunction.General.WriteHTML("</div>")

        '---------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("</div>")
        'End Of Leaves'


        CommonFunction.General.WriteHTML("<div style='width: 300px; height: 83px; margin:5px 0px 0px 5px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<div style='width: 200px; margin:5px 0px 0px 5px'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; '> Expense</font> ")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</div>")

        CommonFunction.General.WriteHTML("</Div>")
        CommonFunction.General.WriteHTML("</td>")
        'End Of My Approvers

        'My Alerts/Activity
        CommonFunction.General.WriteHTML("<td width='33.33%' valign='top'>")
        CommonFunction.General.WriteHTML("<Div style='width: 315px; height: 300px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<table border='1' height='99.99%' width ='99.99%'>")
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("<td width='99.99%' valign='top'>")

        CommonFunction.General.WriteHTML("<div style='width: 200px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; padding-left:20px;'>My Alerts</font>")
        CommonFunction.General.WriteHTML("</Div>")

        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("<td width='99.99%' valign='top'>")

        CommonFunction.General.WriteHTML("<div style='width: 200px; border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; padding-left:20px;'>Recent Activity</font>")
        CommonFunction.General.WriteHTML("</Div>")

        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</Div>")
        CommonFunction.General.WriteHTML("</td>")
        'End Of My Alerts/Activity

        CommonFunction.General.WriteHTML("</tr>")

        CommonFunction.General.WriteHTML("<tr height='40%'>")
        CommonFunction.General.WriteHTML("<td class='LowerInner' colspan='3'>")
        '-------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("<div style='width: 640px; height: 200px; border:1px solid black; float:left;'>")

        CommonFunction.General.WriteHTML("<div style='width: 305px; height: 190px; border:1px solid black; float:left; margin:5px 0px 5px 5px; '>")
        CommonFunction.General.WriteHTML("<div style='width: 200px; margin:5px 0px 0px 5px'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; '> Leaves</font> ")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</div>")

        CommonFunction.General.WriteHTML("<div style='width: 305px; height: 190px; border:1px solid black; float:left; margin:5px 0px 5px 10px;'>")
        CommonFunction.General.WriteHTML("<div style='width: 200px; margin:5px 0px 0px 5px'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; '> Leaves</font> ")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</div>")

        CommonFunction.General.WriteHTML("</div>")


        CommonFunction.General.WriteHTML("<div style='width: 315px; height: 200px; border:1px solid black; float:left;'>")

        CommonFunction.General.WriteHTML("<div style='width: 200px; margin:5px 0px 0px 5px'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; '> My Activity</font> ")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("<div style='width: 300px; height: 70px; margin :5px 5px 0px 5px;border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<div style='width: 200px; margin:5px 0px 0px 5px'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; '> My Tasks</font> ")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("<div style='width: 300px; height: 70px; margin :5px 5px 0px 5px;border:1px solid black;'>")
        CommonFunction.General.WriteHTML("<div style='width: 200px; margin:5px 0px 0px 5px'>")
        CommonFunction.General.WriteHTML("<font size='2' color='red' face='verdana' style='font-weight:bold; '> My Defects</font> ")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</div>")

        CommonFunction.General.WriteHTML("</div>")
        '-------------------------------------------------------------------------------------------------

        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")
        
        'CommonFunction.General.WriteHTML("</Div>")
    End Sub
    Private Sub Initialize()


        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : PARAG PATIL
        ' Created               : 27 AUG,2013
        ' Revisions             :
        '=====================================================================
        ' Mode of the  page

        m_lngEmployeeID = CType(Session("intUserID"), Long)

    End Sub

End Class