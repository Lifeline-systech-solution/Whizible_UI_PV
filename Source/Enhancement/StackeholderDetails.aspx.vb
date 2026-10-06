Imports System.Text
Public Class StackeholderDetails
    Inherits WebPages.Template.WhizTemplate
    Private sbHTML As New System.Text.StringBuilder
    Private m_strClsTREven As String = "'clsTREven'"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub
    Public Sub PageInit()
        DrawPage()
    End Sub
    Private Sub DrawPage()
        Response.Write("<DIV ID='PageDiv' Style='Height:100%;WIDTH:100%;OVERFLOW:auto;'>")
        DrawUIControls()
        Response.Write("</DIV>")
    End Sub

    Private Sub DrawUIControls()
        sbHTML.Append("<TABLE style='width:99%' id='tblTxtCmd' class=clsGridTable   style='border:solid;border-color :black;' >")
        Dim Ds As DataSet
        Dim strchk As String
        Dim strchk1 As String
        Dim EmailId As String
        Dim qut As String
        qut = Request.QueryString("CalPIOut")
        sbHTML.Append("<div ID=divTblGrid style='overflow:auto;'>")
        'sbHTML.Append("<Table name='QTasks' id='QTasks' class='clsGridTable' width=99.9% cellspacing=1 cellpadding=0><THead class='clsTRColumnHeader'>" + vbCrLf)
        sbHTML.Append("<THead class='clsTRColumnHeader'>" + vbCrLf)
        sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap >Name</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap >Power/Intensity</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' style='padding-left:10px' nowrap >Email ID</TH>")

        sbHTML.Append("</THead>")
        Ds = CommonFunctions.Data.GetDataSet("usp_Sel_Stackeholder_Cal_tbl_PM_EPC_Stackeholder_Detail  " & qut & "", "tbl_PM_EPC_Stackeholder_Detail")
        For Each Dr As DataRow In Ds.Tables(0).Rows
            strchk = Dr("Name").ToString()
            strchk1 = Dr("CalPI").ToString()
            EmailId = Dr("EmailID").ToString()
            sbHTML.Append("<TR><TD>" + strchk + "</TD><TD>" + strchk1 + "</TD><TD><a href='#'>" + EmailId + "</a></TD></TR>")
        Next
        
        sbHTML.Append("</TABLE>")
        Response.Write(sbHTML.ToString())
    End Sub
End Class