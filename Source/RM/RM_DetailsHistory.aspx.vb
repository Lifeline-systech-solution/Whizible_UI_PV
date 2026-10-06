Public Class RM_DetailsHistory
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
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region
#Region "Variables"
    Private strProjectRequirementID As String
    Private strLeftDetailBaseLineNo As String
    Private strRightDetailBaseLineNo As String
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        strProjectRequirementID = Request.QueryString("ProjectRequirementID")
        If Request.Form("hidProjectRequirementID") <> "" Then
            strProjectRequirementID = Request.Form("hidProjectRequirementID")
        End If
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + strProjectRequirementID + ">")

        If Request.Form("cboLeftDoc") <> "" Then
            strLeftDetailBaseLineNo = Request.Form("cboLeftDoc")
        Else
            strLeftDetailBaseLineNo = "-1"
        End If
        If Request.Form("cboRightDoc") <> "" Then
            strRightDetailBaseLineNo = Request.Form("cboRightDoc")
        Else
            strRightDetailBaseLineNo = "-1"
        End If

        ShowHistory()
    End Sub
    Private Sub ShowHistory()
        CommonFunction.General.WriteHTML("<BR>")
        DrawMenu()
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<div id=PageDiv style=""WIDTH:100%;HEIGHT:200px"">")
        CommonFunction.General.WriteHTML("<table class=clsTable width=100% cellpadding=0 cellspacing=0>")
        CommonFunction.General.WriteHTML("<tr class=clsTREven>")
        CommonFunction.General.WriteHTML("<td align=right>Left Details</td>")

        CommonFunction.General.WriteHTML("<td >")
        CommonFunction.HTMLControls.DrawComboBox("cboLeftDoc", "usp_Sel_RMDetailHistory_Combo " + strProjectRequirementID, , strLeftDetailBaseLineNo, , True, IsMandatory:=True)
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align=right >Right Details</td>")
        CommonFunction.General.WriteHTML("<td>")
        CommonFunction.HTMLControls.DrawComboBox("cboRightDoc", "usp_Sel_RMDetailHistory_Combo " + strProjectRequirementID, , strRightDetailBaseLineNo, , True)
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")
        Dim LeftDt As System.Data.DataTable = New System.Data.DataTable("LeftDT")
        Dim RightDt As System.Data.DataTable = New System.Data.DataTable("RightDT")
        Dim LDr As IDataReader
        Dim RDr As IDataReader
        Dim row As DataRow
        Dim LC, RC, prevRC, prevLC, C As Integer
        Dim blnLToRMatched As Boolean = False
        Dim blnRToLMatched As Boolean = False

        LC = 0
        RC = 0
        prevRC = 0
        prevLC = 0
        C = 0

        LDr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_ProjectRequirementSectionDetails_History " + strProjectRequirementID + "," + strLeftDetailBaseLineNo, MyBase.UseSQL)
        RDr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_ProjectRequirementSectionDetails_History " + strProjectRequirementID + "," + strRightDetailBaseLineNo, MyBase.UseSQL)

        LeftDt.Columns.Add("SectionNumber", Type.GetType("System.String"))
        LeftDt.Columns.Add("SectionTitle", Type.GetType("System.String"))
        LeftDt.Columns.Add("Details", Type.GetType("System.String"))

        RightDt.Columns.Add("SectionNumber", Type.GetType("System.String"))
        RightDt.Columns.Add("SectionTitle", Type.GetType("System.String"))
        RightDt.Columns.Add("Details", Type.GetType("System.String"))



        While LDr.Read
            row = LeftDt.NewRow()
            row(0) = LDr(0)
            row(1) = LDr(1)
            row(2) = LDr(2)
            LeftDt.Rows.Add(row)
        End While
        While RDr.Read
            row = RightDt.NewRow()
            row(0) = RDr(0)
            row(1) = RDr(1)
            row(2) = RDr(2)
            RightDt.Rows.Add(row)
        End While
        CommonFunction.General.WriteHTML("<TABLE class=clsGridTable width=100%  cellspacing=1 cellpadding=0>")

        While LC < LeftDt.Rows.Count
            prevRC = RC
            prevLC = LC

            While RC < RightDt.Rows.Count And LC < LeftDt.Rows.Count
                If LeftDt.Rows(LC).Item(1).ToString = RightDt.Rows(RC).Item(1).ToString Then
                    If LeftDt.Rows(LC).Item(2).ToString.Length = RightDt.Rows(RC).Item(2).ToString.Length Then
                        If LeftDt.Rows(LC).Item(2).ToString = RightDt.Rows(RC).Item(2).ToString Then
                            blnLToRMatched = True
                            Exit While
                        End If
                    End If
                End If
                RC += 1
            End While


            If blnLToRMatched = False Then
                RC = prevRC
                While LC < LeftDt.Rows.Count And RC < RightDt.Rows.Count
                    If LeftDt.Rows(LC).Item(1).ToString = RightDt.Rows(RC).Item(1).ToString Then
                        If LeftDt.Rows(LC).Item(2).ToString.Length = RightDt.Rows(RC).Item(2).ToString.Length Then
                            If LeftDt.Rows(LC).Item(2).ToString = RightDt.Rows(RC).Item(2).ToString Then
                                blnRToLMatched = True
                                Exit While
                            End If
                        End If
                    End If
                    LC += 1
                End While
            End If
            If blnRToLMatched = False Then
                LC = prevLC
            End If
            If blnLToRMatched = True Then
                C = prevRC
                While C < RC
                    CommonFunction.General.WriteHTML("<TR class=clsTREven >")
                    CommonFunction.General.WriteHTML("<TD>")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD>")
                    CommonFunction.General.WriteHTML(RightDt.Rows(C).Item(1).ToString)
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    'Detail
                    CommonFunction.General.WriteHTML("<TR class=clsTREven>")
                    CommonFunction.General.WriteHTML("<TD>")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD>")
                    CommonFunction.General.WriteHTML(RightDt.Rows(C).Item(2).ToString)
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    C += 1
                End While
                CommonFunction.General.WriteHTML("<TR class=clsTREven style='BACKGROUND-COLOR:white;'>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(LeftDt.Rows(LC).Item(1).ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(RightDt.Rows(RC).Item(1).ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
                'Detail
                CommonFunction.General.WriteHTML("<TR class=clsTREven style='BACKGROUND-COLOR:white;'>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(LeftDt.Rows(LC).Item(2).ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(RightDt.Rows(RC).Item(2).ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")

            ElseIf blnRToLMatched = True Then
                C = prevLC
                While C < LC
                    CommonFunction.General.WriteHTML("<TR class=clsTREven>")
                    CommonFunction.General.WriteHTML("<TD>")
                    CommonFunction.General.WriteHTML(LeftDt.Rows(LC).Item(1).ToString)
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD>")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    'Detail
                    CommonFunction.General.WriteHTML("<TR class=clsTREven>")
                    CommonFunction.General.WriteHTML("<TD>")
                    CommonFunction.General.WriteHTML(LeftDt.Rows(LC).Item(2).ToString)
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD>")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    C += 1
                End While
                CommonFunction.General.WriteHTML("<TR class=clsTREven style='BACKGROUND-COLOR:white;'>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(LeftDt.Rows(LC).Item(1).ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(RightDt.Rows(RC).Item(1).ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
                'Detail
                CommonFunction.General.WriteHTML("<TR class=clsTREven style='BACKGROUND-COLOR:white;'>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(LeftDt.Rows(LC).Item(2).ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(RightDt.Rows(RC).Item(2).ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
            Else
                CommonFunction.General.WriteHTML("<TR class=clsTREven >")
                CommonFunction.General.WriteHTML("<TD>")
                If LC < LeftDt.Rows.Count Then
                    CommonFunction.General.WriteHTML(LeftDt.Rows(LC).Item(1).ToString)
                End If
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                If RC < RightDt.Rows.Count Then
                    CommonFunction.General.WriteHTML(RightDt.Rows(RC).Item(1).ToString)
                End If
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
                'Detail
                CommonFunction.General.WriteHTML("<TR class=clsTREven >")
                CommonFunction.General.WriteHTML("<TD>")
                If LC < LeftDt.Rows.Count Then
                    CommonFunction.General.WriteHTML(LeftDt.Rows(LC).Item(2).ToString)
                End If
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                If RC < RightDt.Rows.Count Then
                    CommonFunction.General.WriteHTML(RightDt.Rows(RC).Item(2).ToString)
                End If
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
            End If

            blnRToLMatched = False
            blnLToRMatched = False
            LC += 1
            RC += 1
        End While
        While RC < RightDt.Rows.Count
            'Section Title
            CommonFunction.General.WriteHTML("<TR class=clsTREven >")
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(RightDt.Rows(RC).Item(1).ToString)
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
            'Detail
            CommonFunction.General.WriteHTML("<TR class=clsTREven>")
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(RightDt.Rows(RC).Item(2).ToString)
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
            RC += 1
        End While
        CommonFunction.General.WriteHTML("</TABLE>")

        CommonFunction.Data.DisposeDataReader(LDr)
        CommonFunction.Data.DisposeDataReader(RDr)

        CommonFunction.General.WriteHTML("</div>")
    End Sub

    Private Sub DrawMenu()
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList

        arrMenu.Add("Show")
        arrMenuToolTip.Add("Show")
        arrCSFunction.Add("Show_Click()")
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
