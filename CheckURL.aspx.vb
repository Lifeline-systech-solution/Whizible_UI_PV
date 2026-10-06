Imports System
Imports System.IO
Imports System.Xml
Imports System.Security
Imports System.Security.Cryptography
Imports Whizible
Imports System.Configuration
Imports CommonFunctions
Partial Public Class CheckURL
    Inherits System.Web.UI.Page
    'Inherits WebPage.Templates.WhizTemplate
    Public m_strLoginName As String = ""
    Public m_blnIsWindowsAuthenticated As Boolean = False
    Dim m_windows As String = ""
    Public m_blnIsValidDomain As Boolean = True

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
        'Using writer As New System.IO.StreamWriter("c:\log1.txt", True)
        '    writer.WriteLine("-----------------------------------------------------")
        '    writer.WriteLine("1")
        '    writer.WriteLine("-----------------------------------------------------")
        'End Using
            'respond back to client
            Dim Response As New StreamWriter(HttpContext.Current.Response.OutputStream)
            'Response.Write("Hello")
            'Response.Close()
            'Context.Response.OutputStream.Close()

            Dim settingsReader As AppSettingsReader = New AppSettingsReader()

            Dim strAuthenticationType As [String] = DirectCast(settingsReader.GetValue("AuthenticationType", GetType([String])), String)
            Dim WhizServiceUrl As [String] = DirectCast(settingsReader.GetValue("WhizServiceUrl", GetType([String])), String)
            Dim strLDAPServerList As [String] = DirectCast(settingsReader.GetValue("LDAPServerName", GetType([String])), String)
            Dim ValidDomain As [String] = DirectCast(settingsReader.GetValue("ValidDomains", GetType([String])), String)
        'Using writer As New System.IO.StreamWriter("c:\log1.txt", True)
        '    writer.WriteLine("-----------------------------------------------------")
        '    writer.WriteLine("2" + strAuthenticationType)
        '    writer.WriteLine("3" + WhizServiceUrl)
        '    writer.WriteLine("4" + strLDAPServerList)
        '    writer.WriteLine("5" + strLDAPServerList)
        'End Using
            'respond back to client
            m_blnIsWindowsAuthenticated = IsWindowsAuthenticated(m_strLoginName, sender)
            If m_blnIsWindowsAuthenticated = True Then
                m_windows = "True"
            Else
                m_windows = "False"
            End If
        'Using writer As New System.IO.StreamWriter("c:\log1.txt", True)
        '    writer.WriteLine("5")

        'End Using
            Response.Write("Hello" + "," + strAuthenticationType + "," + WhizServiceUrl + "," + strLDAPServerList + "," + ValidDomain + "," + m_windows)

            Response.Close()
            Context.Response.OutputStream.Close()
            'return strIntegrate;


    End Sub
    Private Function IsWindowsAuthenticated(ByRef LoginName As String, ByVal sender As System.Object) As Boolean
        '=====================================================================
        ' Procedure  Name		:	IsWindowsAuthenticated
        ' Parameters Passed		:	By Ref Login Name, By Val sender object(page)
        ' Returns				:	True/False
        ' Parameters Affected	:	None
        ' Purpose				:	To check if windows security is enabled
        ' Description			:	If the windows security is enabled Login Name is set
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Rajanikant 
        ' Created				:	June 04,2004
        '=====================================================================
        If CType(sender, CheckURL).User.Identity.IsAuthenticated Then
            IsWindowsAuthenticated = True
            LoginName = ExtractUserName(sender)
        Else
            IsWindowsAuthenticated = False : LoginName = ""
        End If
    End Function

    Private Function ExtractUserName(ByVal sender As System.Object) As String
        '=====================================================================
        ' Procedure  Name		:	ExtractUserName
        ' Parameters Passed		:	By Val sender object(page)
        ' Returns				:	The user name
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	Domain is separated.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Rajanikant 
        ' Created				:	June 04,2004
        '=====================================================================
        Dim strUserName As String = ""
        strUserName = CType(sender, CheckURL).User.Identity.Name.ToString
        strUserName = Replace(strUserName, "\", "/")
        ' see of the domain is valid
        m_blnIsValidDomain = IsValidDomain(strUserName)
        strUserName = strUserName.Substring(strUserName.LastIndexOf("/") + 1)

        Return strUserName
    End Function

    Private Function IsValidDomain(ByVal UserName As String) As Boolean
        '=====================================================================
        ' Procedure  Name		:	IsValidDomain
        ' Parameters Passed		:	By Val UserName with Domain Name
        ' Returns				:	The user name
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	Domain is separated.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Rajanikant 
        ' Created				:	June 04,2004
        ' Revisions             :   made the domain-name check case-insensitive
        '                           Rajanikant Khethawatt Dec 07,2004
        '=====================================================================
        Dim strDomain As String = ""
        Dim strValidDomains As String = ""

        ' the list of domains from web.config file
        strValidDomains = "sentt"

        ' if domains are specified check within them
        If Trim(strValidDomains & "") <> "" Then
            IsValidDomain = False
            UserName = Replace(UserName, "\", "/")
            strDomain = Replace(UserName, UserName.Substring(UserName.LastIndexOf("/")), "")
            strDomain = strDomain.Substring(strDomain.LastIndexOf("/") + 1)
            If InStr("/" & UCase(Trim(strValidDomains & "")) & "/", "/" & UCase(Trim(strDomain & "")) & "/") > 0 Then
                IsValidDomain = True
            End If
        Else
            ' when no domains are sepcified..allow all domains
            IsValidDomain = True
        End If
    End Function

     


     

     

     
End Class