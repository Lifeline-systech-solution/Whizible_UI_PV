Imports RadarLibrary

Public Class DB_Radar
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objDBRadar As RadarLibrary.DBRadar


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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
    End Sub
    Protected Sub radar()
        Dim strSQL As String
        Dim strImgURL As String = "../../images/star.gif"

        strSQL = "select ProjectName,"
        Select Case Trim(Request.QueryString("ID").ToString & "")
            Case "1"
                strSQL += "ScheduleVariance from tbl_DB_RadarValues"
                strImgURL = "../../images/GREENDOT.gif"
            Case "2"
                strSQL += "EffortVariance from tbl_DB_RadarValues"
                strImgURL = "../../images/GREENBOB.gif"
            Case "3"
                strSQL += "PercentAmountOutstanding from tbl_DB_RadarValues"
                strImgURL = "../../images/GREENDOT.gif"
            Case "4"
                strSQL += "PercentBilled from tbl_DB_RadarValues"
                strImgURL = "../../images/GREENBOB.gif"
            Case "5"
                strSQL += "PercentDefectFixing from tbl_DB_RadarValues"
                strImgURL = "../../images/GREENDOT.gif"
            Case "6"
                strSQL += "PercentComplete from tbl_DB_RadarValues"
                strImgURL = "../../images/GREENBOB.gif"
            Case Else
                strSQL += "PercentComplete from tbl_DB_RadarValues"
        End Select
        Response.Write(PlotRadar(strSQL, strImgURL))
    End Sub


    Private Function PlotRadar(ByVal SQL As String, ByVal imgURL As String, Optional ByVal maxvalue As Double = 100) As String
        Dim colClicks As String() = {"javascript:click()"}

        m_objDBRadar = New DBRadar
        With m_objDBRadar
            .RadarMaxValue = 100
            .DefaultPlotImageURL = imgURL
            .BackImageURL = "../../images/radaranimation.gif"

            .ConnectionString = CommonFunctions.Application.ConnectionString
            .SQLQuery = SQL
            .ColumnImageClickURL = colClicks

            .BackImage.Width = 250
            .BackImage.Height = 250
            .DigitsAfterDecimal = 2
            .HandleNullAsZero = True
            PlotRadar = m_objDBRadar.GetHTML
        End With
        m_objDBRadar = Nothing

    End Function

    Private Sub m_objDBRadar_DataPoint_Render(ByVal sender As Object, ByVal e As System.EventArgs) Handles m_objDBRadar.DataPoint_Render
        Dim obj As New RadarPoint("")
        Dim img As New RadarPointImage("../../images/radaranimation.gif")
        obj = CType(sender, RadarPoint)
        img = obj.PlotImage
        img.Border = 1
        img.URL = obj.PlotImageURL
        img.Width = 15
        img.Height = 15

        obj = CType(sender, RadarPoint)
        img.ClickURL = "javascript:Point_OnClick('" & Replace(obj.ToolTipText, obj.PlotPercentage.ToString, "") & "'," & obj.PlotPercentage & ")"
        Select Case Trim(Request.QueryString("ID").ToString & "")
            Case "1"
                If obj.PlotPercentage > 10 And obj.PlotPercentage < 30 Then
                    img.URL = "../../images/YELLOWDOT.gif"
                ElseIf obj.PlotPercentage > 30 Then
                    img.URL = "../../images/REDDOT.gif"
                End If
            Case "2"
                If obj.PlotPercentage > 10 And obj.PlotPercentage < 30 Then
                    img.URL = "../../images/YELLOWBOB.gif"
                ElseIf obj.PlotPercentage > 30 Then
                    img.URL = "../../images/REDBOB.gif"
                End If
            Case "3"
                If obj.PlotPercentage > 10 And obj.PlotPercentage < 30 Then
                    img.URL = "../../images/YELLOWDOT.gif"
                ElseIf obj.PlotPercentage > 30 Then
                    img.URL = "../../images/REDDOT.gif"
                End If
            Case "4"
                If obj.PlotPercentage > 10 And obj.PlotPercentage < 30 Then
                    img.URL = "../../images/YELLOWBOB.gif"
                ElseIf obj.PlotPercentage < 10 Then
                    img.URL = "../../images/REDBOB.gif"
                End If
            Case "5"
                If obj.PlotPercentage > 30 And obj.PlotPercentage < 80 Then
                    img.URL = "../../images/YELLOWDOT.gif"
                ElseIf obj.PlotPercentage < 30 Then
                    img.URL = "../../images/REDDOT.gif"
                End If
            Case "6"
                If obj.PlotPercentage > 30 And obj.PlotPercentage < 60 Then
                    img.URL = "../../images/YELLOWBOB.gif"
                ElseIf obj.PlotPercentage > 30 Then
                    img.URL = "../../images/REDBOB.gif"
                End If
        End Select
        obj.PlotImage = img
        obj = Nothing
    End Sub

End Class

