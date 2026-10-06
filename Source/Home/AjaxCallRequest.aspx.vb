Imports System.Web.Services

Public Class AjaxCallRequest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    <WebMethod>
    Public Function testmethod() As Integer
        Return "5"
    End Function

End Class