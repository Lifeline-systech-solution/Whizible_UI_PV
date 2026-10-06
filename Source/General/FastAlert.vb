Imports PbNIT

Public Class FastAlert
    Public Shared Function SendSMS(ByVal Message As String, ByVal PhNO As String)
        Dim strProxyURL As String = ""
        Dim proxyUser, proxyPassword, proxyDomain As String
        Dim proxy As System.Net.IWebProxy
        Dim URI As System.Uri
        Dim credentials As System.Net.NetworkCredential
        Dim webObject As New SMSService.falertwsdl
        'provide credentials or bypass proxy
        'proxy.IsBypassed = True

        If CommonFunctions.General.GetApplicationKeySetting("ProxyURL") <> "" Then
            strProxyURL = CommonFunctions.General.GetApplicationKeySetting("ProxyURL")
            URI = New System.Uri(strProxyURL)
            proxy = New System.Net.WebProxy(URI, True)

            proxyUser = CommonFunctions.General.GetApplicationKeySetting("ProxyUserName")
            proxyPassword = CommonFunctions.General.GetApplicationKeySetting("ProxyPassword")
            proxyDomain = CommonFunctions.General.GetApplicationKeySetting("ProxyDomain")

            If proxyUser <> "" AndAlso proxyPassword <> "" Then
                credentials = New System.Net.NetworkCredential(proxyUser, proxyPassword)
                If proxyDomain <> "" Then
                    credentials.Domain = proxyDomain
                End If
                'set local proxy settings to the service object
                proxy.Credentials = credentials
                webObject.Proxy = proxy

            Else
                'set local proxy settings to the service object
                webObject.Proxy = proxy
                proxy.Credentials = credentials
                webObject.UseDefaultCredentials = True
            End If
        Else
            'proxy.IsBypassed() = True
            webObject.UseDefaultCredentials = True
        End If
        Try
            'send SMS
            webObject.SendSMS("compulink", "Compulink", "tollfree", Message, PhNO.ToString)
            'webObject.SendBulkSMS()
        Catch ex As Exception
            CommonFunction.General.WriteLog()
        End Try
    End Function
End Class






