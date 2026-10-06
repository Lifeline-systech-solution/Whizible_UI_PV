Imports CommonFunctions.General
Public Class Token

    Private Shared ReadOnly SECRET_CODE As String = "H3#@*LLSlifeline31q4l1ncL#123456789@RFHF#N3fNM><#WH$O@#!FN#LNl33N#LNFl#J#Y$#IOHhnf;123456789;3qrthl3qFramework123456789"

    Public Shared Function GetToken(ByVal Pageurl As String) As String
        '=====================================================================
        ' Function Name	    	:	GetToken
        ' Parameters Passed		:	url
        ' Returns				:	Token 
        ' Parameters Affected	:	None
        ' Purpose				:	To get the token
        ' Author				:	SajiU
        ' Created				:   6 April 2015
        '=====================================================================
        Dim strToken As String = ""
        Dim strInput As String = ""
        Dim hashByte As Byte()
        strInput = (String.Concat(SECRET_CODE, Pageurl, SECRET_CODE))

        Dim encoder As New System.Text.UTF8Encoding
        Dim md5hasher As New System.Security.Cryptography.MD5CryptoServiceProvider
        hashByte = md5hasher.ComputeHash(encoder.GetBytes(strInput))
        strToken = Convert.ToBase64String(hashByte).TrimEnd("=".ToCharArray())
        strToken = Replace(Replace(Replace(strToken, "+", ""), "#", ""), "&", "")
        hashByte = Nothing
        encoder = Nothing
        md5hasher = Nothing
        Return strToken
    End Function
    Public Shared Function ValidateUserToken(ByVal PageUrl As String, ByVal Token As String) As Boolean
        '=====================================================================
        ' Function Name	    	:	ValidateUserToken
        ' Parameters Passed		:	pageurl,token
        ' Returns				:	Token 
        ' Purpose				:	Validate the token
        ' Author				:	SajiU
        ' Created				:  06-April-15
        '=====================================================================
        ValidateUserToken = False
        If String.Compare(GetToken(PageUrl), Token) = 0 Then Return True

    End Function
    Public Shared Function EncryptString(ByVal Decrypted As String) As String

        Dim intStrArr() As String

        ReDim intStrArr(Len(Decrypted))
        Dim strEncryptedString As String
        Dim intEncryptNum As Integer
        Dim i As Integer
        intEncryptNum = 1
        Try
            If Len(Decrypted) > 0 Then
                For i = 1 To Len(Decrypted)
                    intStrArr(i) = CType(Asc(Mid(Decrypted, i, 1)) + intEncryptNum, String)
                    intEncryptNum = intEncryptNum + 2
                Next
                strEncryptedString = Join(intStrArr, "-")
                If Mid(strEncryptedString, 1, 1) = "-" Then
                    strEncryptedString = Mid(strEncryptedString, 2, Len(strEncryptedString) - 1)
                End If
            Else
                strEncryptedString = ""
            End If
        Catch ex As Exception
            Err.Raise(Err.Number, "EcryptString", ex.Message)
        End Try
        Return strEncryptedString

    End Function

    Public Shared Function DecryptString(ByVal Encrypted As String) As String
        Dim intStrArr() As String
        Dim intEncryptNum As Integer
        Dim intCount As Integer
        Try
            If Encrypted & "" <> "" Then
                intStrArr = Encrypted.Split(New Char() {"-"c})
                intEncryptNum = 1
                For intCount = 0 To intStrArr.Length - 1
                    intStrArr(intCount) = Chr(CType(intStrArr(intCount), Integer) - intEncryptNum)
                    intEncryptNum = intEncryptNum + 2
                Next

                DecryptString = Join(intStrArr, "")
            Else
                DecryptString = Encrypted
            End If
        Catch ex As Exception
            Err.Raise(Err.Number, "DecryptString", ex.Message)
        End Try

    End Function

    ''Added By Dipali V Purpose::To decrypt Password
    Public Shared Function GetUserNameToken(ByVal Pageurl As String) As String
        '=====================================================================
        ' Function Name	    	:	GetToken
        ' Parameters Passed		:	url
        ' Returns				:	Token 
        ' Parameters Affected	:	None
        ' Purpose				:	To get the token
        ' Author				:	   Dipali V
        ' Created				:   8/1/2016
        '=====================================================================
        Dim strToken As String = ""
        Dim strInput As String = ""
        Dim hashByte As Byte()
        strInput = (String.Concat(SECRET_CODE, Pageurl, SECRET_CODE))

        Dim encoder As New System.Text.UTF8Encoding
        Dim md5hasher As New System.Security.Cryptography.SHA256CryptoServiceProvider
        hashByte = md5hasher.ComputeHash(encoder.GetBytes(strInput))
        strToken = Convert.ToBase64String(hashByte).TrimEnd("=".ToCharArray())
        strToken = Replace(Replace(Replace(strToken, "+", ""), "#", ""), "&", "")
        hashByte = Nothing
        encoder = Nothing
        md5hasher = Nothing
        Return strToken
    End Function
    Public Shared Function ValidateUserNameToken(ByVal PageUrl As String, ByVal Token As String) As Boolean
        '=====================================================================
        ' Function Name	    	:	ValidateUserNameToken
        ' Parameters Passed		:	pageurl,token
        ' Returns				:	Token 
        ' Purpose				:	Validate the token
        ' Author				:   Dipali V
        ' Created				:  8/1/2016
        '=====================================================================
        ValidateUserNameToken = False
        If String.Compare(GetUserNameToken(PageUrl), Token) = 0 Then Return True

    End Function
    ''End of Added By Dipali V Purpose::To decrypt Password

End Class


