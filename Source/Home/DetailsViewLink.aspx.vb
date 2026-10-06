Option Strict Off
Public Class DetailsViewLink
    Inherits System.Web.UI.Page
    Protected m_intMenuGroupID As Integer = 0
    Protected m_intMarqueeSectionHeight As Integer = 0
    Protected m_strFromWhere As String = ""


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not HttpContext.Current.Request("FromWhere") Is Nothing Then
            m_strFromWhere = HttpContext.Current.Request("FromWhere")
        End If
        If Not HttpContext.Current.Request("MenuGroupID") Is Nothing Then
            m_intMenuGroupID = HttpContext.Current.Request("MenuGroupID")
        End If
        m_intMarqueeSectionHeight = CommonFunction.Data.GetDataScalar("usp_Sel_tbl_MarqueeHeigth", True)
    End Sub
End Class