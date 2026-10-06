Public Class SPApprovalsFields
    Private m_strSPAUserName As String
    Private m_strSPAPassword As String
    Private m_strSPALoginTime As String
    Private m_SPAHostName As String

    Public Property SPAUserName() As String
        Get
            SPAUserName = m_strSPAUserName
        End Get
        Set(ByVal Value As String)
            m_strSPAUserName = Value
        End Set
    End Property
    Public Property SPAPassword() As String
        Get
            SPAPassword = m_strSPAPassword
        End Get
        Set(ByVal Value As String)
            m_strSPAPassword = Value
        End Set
    End Property
    Public Property SPALoginTime() As String
        Get
            SPALoginTime = m_strSPALoginTime
        End Get
        Set(ByVal Value As String)
            m_strSPALoginTime = Value
        End Set
    End Property
    Public Property SPAHostName() As String
        Get
            SPAHostName = m_SPAHostName
        End Get
        Set(ByVal Value As String)
            m_SPAHostName = Value
        End Set
    End Property
End Class
