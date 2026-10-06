<%@ Page Language="VB" AutoEventWireup="true" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        If Request.HttpMethod <> "POST" Then
            Response.StatusCode = 405
            Response.End()
            Return
        End If

        Dim json As String = ""
        Using reader As New StreamReader(Request.InputStream)
            json = reader.ReadToEnd()
        End Using

        Dim serializer As New JavaScriptSerializer()
        Dim data = serializer.Deserialize(Of Dictionary(Of String, Object))(json)

        Dim email As String = data("email").ToString()
        Dim name As String = data("name").ToString()

        ' 🔐 Create Session
        Session("ADUser") = email
        Session("UserName") = name

        Response.StatusCode = 200
        Response.End()

    End Sub

</script>
