Option Strict Off
Imports System.Text

Public Class Marquee
    Inherits System.Web.UI.Page
    Protected m_strMarquee As String = ""


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Protected Sub WritePageHead()
        'CommonFunctions.General.PlotPageHeadTag("Marquee", , , , "<style type=""text/css"">a:hover{ color:red; background-color:beige; font-weight:bolder; }</style>")
        CommonFunctions.General.PlotPageHeadTag("Marquee")
        'CommonFunction.General.WriteHTML("<Head>Marquee")
        'CommonFunction.General.WriteHTML("<style type=""text/css"">")
        'CommonFunction.General.WriteHTML("a:hover{ color:red; background-color:beige; font-weight:bolder;}")
        'CommonFunction.General.WriteHTML("</style>")
        'CommonFunction.General.WriteHTML("</Head>")
    End Sub

    Protected Sub WritePage()
        Dim intMenuGroupID As Integer = 0
        Dim drMarquee As IDataReader
        Dim strMarqueeText As String = ""
        Dim sbMarquee As New StringBuilder
        Dim intMarqueeType As Integer = 0
        Dim strFromWhere As String = ""


        If Not HttpContext.Current.Request("MenuGroupID") Is Nothing Then
            intMenuGroupID = HttpContext.Current.Request("MenuGroupID")
        End If

        If Not HttpContext.Current.Request("ShortName") Is Nothing Then
            strFromWhere = HttpContext.Current.Request("ShortName")
        End If

        If strFromWhere = "" Then
            drMarquee = CommonFunction.Data.GetDataReader("usp_Sel_tbl_HR_Marquee " + intMenuGroupID.ToString, True)
        Else
            drMarquee = CommonFunction.Data.GetDataReader("usp_Sel_tbl_HR_Marquee " + intMenuGroupID.ToString + "," + strFromWhere, True)
        End If



        While drMarquee.Read()
            strMarqueeText = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMarquee("MarqueeText"), ""), "")
            intMarqueeType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMarquee("LastUpdationType"), ""), "")
            strMarqueeText = HRCommonfunction.ReplacePlaceHolders(strMarqueeText)
            Try
                If intMarqueeType = 1 Then
                    'strMarqueeText = CommonFunction.Data.GetDataScalar(strMarqueeText, True)

                ElseIf intMarqueeType = 2 Then
                    strMarqueeText = CommonFunction.Data.GetDataScalar(strMarqueeText, True)
                End If
            Catch ex As Exception
                strMarqueeText = ""
            End Try
            If strMarqueeText <> "" Then
                sbMarquee.Append("&nbsp;&nbsp;<img  style='text-decoration:none' border='0' src='../../Images/green.gif' alt='' />&nbsp;&nbsp;")
                sbMarquee.Append(strMarqueeText.ToString)
            End If
        End While
        CommonFunction.Data.DisposeDataReader(drMarquee)
        'CommonFunction.General.WriteHTML("<Marquee onmouseover=""this.style.color='red'"" onmouseout=""this.style.color='Indigo'""  id=""marquee"" class=clsMarquee>" & sbMarquee.ToString() & "</Marquee>")
        CommonFunction.General.WriteHTML("<Marquee onclick=""CookieGroup()"" id=""marquee"" class=clsMarquee>" & sbMarquee.ToString() & "</Marquee>")
        sbMarquee = Nothing
    End Sub
End Class