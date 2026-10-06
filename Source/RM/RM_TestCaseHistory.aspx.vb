Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.Data
Imports CommonFunctions.General
Public Class RM_TestCaseHistory
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
#Region "Variables"
    Private m_strRequirmentTitle As String
    Private m_strRevisionTitles As String = ""
    Private m_strRevisionIDs As String = ""
    Private m_strProjectID As String
    Private m_strProjectRequirementID As String
    Private arrCounter As Integer
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Response.Write(PageCaption.GetPageCaptions(, "Test Case History", "Requirement : " + m_strRequirmentTitle, , True))

    End Sub
    Private Sub InitializeVaribles()
        m_strProjectID = Request.QueryString("ProjectID")
        m_strProjectRequirementID = Request.QueryString("ProjectRequirementID")
        m_strRequirmentTitle = CType(CommonFunction.Data.GetDataScalar("Select ReqTitle FROM tbl_RM_ProjectRequirements WHERE ProjectRequirementID = " + Request.QueryString("ProjectRequirementID"), MyBase.UseSQL), String)
    End Sub
    Protected Sub PageInit()
        InitializeVaribles()

        Dim dr As IDataReader
        Dim drRevision As IDataReader
        Dim divCounter As Integer = 0
        DrawMenu()
        CommonFunction.General.WriteHTML("<BR>")
        DrawPageCaption()

        CommonFunction.General.WriteHTML("<DIV id=divListTag Style='overflow:auto;height:400px;width:100%;z-index=2;'>")

        dr = CommonFunction.Data.GetDataReader("usp_Sel_MappedTestSets " + m_strProjectID + "," + m_strProjectRequirementID, MyBase.UseSQL)
        While dr.Read
            m_strRevisionIDs = ""
            m_strRevisionTitles = ""
            drRevision = CommonFunction.Data.GetDataReader("usp_Sel_Combo_TestSetHistory_Revision " + m_strProjectID + "," + dr("ProjectTestSetID").ToString, MyBase.UseSQL)
            While drRevision.Read
                m_strRevisionIDs += drRevision("ProjectTestSetID").ToString + ","
                m_strRevisionTitles += drRevision("Revision").ToString + ","
            End While
            If m_strRevisionIDs <> "" Then
                m_strRevisionIDs = m_strRevisionIDs.Substring(0, m_strRevisionIDs.Length - 1)
                m_strRevisionTitles = m_strRevisionTitles.Substring(0, m_strRevisionTitles.Length - 1)
            End If
            divCounter += 1
            CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
            CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
            CommonFunction.General.WriteHTML("<TD  align=Left width='1%'><A href='Javascript:showHide_divFilter(" + divCounter.ToString + ")'>")
            CommonFunction.General.WriteHTML("<Img Border=0 id=PM" + divCounter.ToString + " Src='../../Images/minus.gif' title=''></A></TD>")
            CommonFunction.General.WriteHTML("<TD> " + dr("TestSetName").ToString + "</TD>")
            CommonFunction.General.WriteHTML("</TR></TABLE>")
            CommonFunction.General.WriteHTML("<DIV id=div" + divCounter.ToString + ">")
            DrawHistory()
            CommonFunction.General.WriteHTML("</DIV>")
            CommonFunction.Data.DisposeDataReader(drRevision)
        End While


        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.Data.DisposeDataReader(dr)


        CommonFunction.General.WriteHTML("<BR>")
        DrawLegends()
        CommonFunction.General.WriteHTML("<BR>")
        DrawMenu()

        ' Added  Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added  Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting

    End Sub
    Private Sub DrawHistory()
        Dim strCss As String = "clsTREven"
        Dim dr As IDataReader


        Dim arrRevisionTitles As String() = m_strRevisionTitles.Split(CChar(","))

        Dim prev_TestSet As String = "<NOTHING>"
        Dim prev_TestCaseCode As String = "<NOTHING>"
        'Dim prev_TestSession As String

        dr = CommonFunction.Data.GetDataReader("usp_Sel_ProjectTestSetHistory " + m_strProjectID + ",'" + m_strRevisionIDs + "',''", MyBase.UseSQL)

        CommonFunction.General.WriteHTML("<TABLE  class='clsGridTable' width=99.9% cellspacing=1 cellpadding=0>")
        CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader'>")
        CommonFunction.General.WriteHTML("<TH width=100px class='divListTag' align='right' nowrap  >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_CASE_CODE"))
        CommonFunction.General.WriteHTML("</TH>")
        'CommonFunction.General.WriteHTML("<TH class='divListTag' align='Left' >" + MyBase.GetResourceString("LBL_TEST_SESSION_RESULTS") + "</TH>")
        arrCounter = 0
        While arrCounter < arrRevisionTitles.Length
            If arrRevisionTitles(arrCounter) <> "" Then
                CommonFunction.General.WriteHTML("<TH class='divListTag' align='Left' nowrap >" + arrRevisionTitles(arrCounter) + "</TH>")
            End If
            arrCounter += 1
        End While
        CommonFunction.General.WriteHTML("</THEAD>")
        While dr.Read
            If prev_TestCaseCode = "<NOTHING>" Then
                CommonFunction.General.WriteHTML("")
                CommonFunction.General.WriteHTML("<TR class=" + strCss + "><TD align=right >" + dr("TestCaseCode").ToString + "</TD>")
                If strCss = "clsTREven" Then
                    strCss = "clsTROdd"
                Else
                    strCss = "clsTREven"
                End If
                CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
                If Not IsDBNull(dr("Title")) Then
                    If Not IsDBNull(dr("ColorCode")) Then
                        If dr("ColorCode").ToString = "" Then
                            CommonFunction.General.WriteHTML("<TD></TD>")
                        Else
                            CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                            + "Conducted By: " + dr("EmployeeName").ToString + vbNewLine _
                            + "Date: " + dr("ResponseDate").ToString + "' bgcolor=" + dr("ColorCode").ToString + "></TD>")
                        End If
                    Else
                        CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                        + "Conducted By: " + vbNewLine _
                        + "Date: ' bgcolor=white >" _
                        + "<IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
                    End If
                Else
                    CommonFunction.General.WriteHTML("<TD></TD>")
                End If
            Else
                If prev_TestSet <> dr("ProjectTestSetID").ToString And prev_TestCaseCode = dr("TestCaseCode").ToString Then
                    CommonFunction.General.WriteHTML("")
                    CommonFunction.General.WriteHTML("</TR></TABLE>")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
                    If Not IsDBNull(dr("Title")) Then
                        If Not IsDBNull(dr("ColorCode")) Then
                            If dr("ColorCode").ToString = "" Then
                                CommonFunction.General.WriteHTML("<TD></TD>")
                            Else
                                CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                                + "Conducted By: " + dr("EmployeeName").ToString + vbNewLine _
                                + "Date: " + dr("ResponseDate").ToString + "' bgcolor=" + dr("ColorCode").ToString + "></TD>")
                            End If
                        Else
                            CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                            + "Conducted By: " + vbNewLine _
                            + "Date: ' bgcolor=white >" _
                            + "<IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
                        End If
                    Else
                        CommonFunction.General.WriteHTML("<TD></TD>")
                    End If

                ElseIf prev_TestSet = dr("ProjectTestSetID").ToString And prev_TestCaseCode = dr("TestCaseCode").ToString Then
                    If Not IsDBNull(dr("Title")) Then
                        If Not IsDBNull(dr("ColorCode")) Then
                            If dr("ColorCode").ToString = "" Then
                                CommonFunction.General.WriteHTML("<TD></TD>")
                            Else
                                CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                                + "Conducted By: " + dr("EmployeeName").ToString + vbNewLine _
                                + "Date: " + dr("ResponseDate").ToString + "' bgcolor=" + dr("ColorCode").ToString + "></TD>")
                            End If
                        Else
                            CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                            + "Conducted By: " + vbNewLine _
                            + "Date: ' bgcolor=white >" _
                            + "<IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
                        End If
                    Else
                        CommonFunction.General.WriteHTML("<TD></TD>")
                    End If

                Else 'means prev_TestCaseCode = dr("TestCaseCode").ToString 
                    CommonFunction.General.WriteHTML("")
                    CommonFunction.General.WriteHTML("</TR></TABLE></TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    CommonFunction.General.WriteHTML("<TR  class=" + strCss + "><TD align=right>" + dr("TestCaseCode").ToString + "</TD>")
                    If strCss = "clsTREven" Then
                        strCss = "clsTROdd"
                    Else
                        strCss = "clsTREven"
                    End If
                    CommonFunction.General.WriteHTML("<TD><TABLE cellpadding=0 cellspacing=1 style='table-layout:fixed'><TR>")
                    If Not IsDBNull(dr("Title")) Then
                        If Not IsDBNull(dr("ColorCode")) Then
                            If dr("ColorCode").ToString = "" Then
                                CommonFunction.General.WriteHTML("<TD></TD>")
                            Else
                                CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                                + "Conducted By: " + dr("EmployeeName").ToString + vbNewLine _
                                + "Date: " + dr("ResponseDate").ToString + "' bgcolor=" + dr("ColorCode").ToString + "></TD>")
                            End If
                        Else
                            CommonFunction.General.WriteHTML("<TD width=20px height=20px Title='Test Session:" + dr("Title").ToString + vbNewLine _
                            + "Conducted By: " + vbNewLine _
                            + "Date: ' bgcolor=white >" _
                            + "<IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
                        End If
                    Else
                        CommonFunction.General.WriteHTML("<TD></TD>")
                    End If

                End If
            End If

            prev_TestSet = dr("ProjectTestSetID").ToString
            prev_TestCaseCode = dr("TestCaseCode").ToString
            'prev_TestSession = dr("TestSessionID").ToString

            

        End While
        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.General.WriteHTML("</TR></TABLE></TD></TR>")

        CommonFunction.General.WriteHTML("</TABLE>")


    End Sub
    Private Sub DrawLegends()
        Dim drLegends As IDataReader
        CommonFunction.General.WriteHTML("<DIV  Style='overflow:auto;height=50px;width:100%;z-index=2;'>")
        CommonFunction.General.WriteHTML("<TABLE class=clsTable width=99.9%  cellpadding=0 cellspacing=0  >")
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption >")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.General.WriteHTML("<TABLE>")
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption >")
        drLegends = CommonFunction.Data.GetDataReader("SELECT TestResult,ColorCode  FROM tbl_TCM_TestResultMaster order by TestResult", MyBase.UseSQL)

        While drLegends.Read()
            CommonFunction.General.WriteHTML("<TD nowrap >" + drLegends("TestResult").ToString + ": </TD>")
            CommonFunction.General.WriteHTML("<TD nowrap align=left width=20px height=20px bgcolor=" + drLegends("ColorCode").ToString + "> </TD>")
        End While
        CommonFunction.Data.DisposeDataReader(drLegends)
        CommonFunction.General.WriteHTML("<TD nowrap >No Response: </TD>")
        CommonFunction.General.WriteHTML("<TD nowrap align=left width=20px height=20px bgcolor=white><IMG width=20px height=20px src=../../Images/NoResponse.gif></TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")




    End Sub
    Private Sub DrawMenu()
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList

        arrMenu.Add("Close")
        arrMenuToolTip.Add("Close")
        arrCSFunction.Add("Close_OnClick()")


        arrMenu.Add("?")
        arrMenuToolTip.Add("Help")
        arrCSFunction.Add("Help_OnClick('RM_SM_TEMP')")



        CommonFunction.General.WriteHTML(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
End Class
