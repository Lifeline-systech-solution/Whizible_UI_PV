Public Class CreateNewPassword

#Region "Member Declaration"

    Protected random As Random = New Random()
    Protected strRandomAlphabates As String = ""
    Protected strRandomNumerals As String = ""
    Protected strRandomSpecialChars As String = ""

    Protected strRandomExtraChars As String = ""
    Protected minStringLength As Integer = 1
    Protected FinalString As String = ""

    Protected m_blnEnablePassLength As Boolean = False
    Protected m_intMinLength As Integer = 0
    Protected m_intMaxLength As Integer = 0

    Protected m_blnEnableAlphaNumSpeChar As Boolean = False
    Protected m_intNumberOfAlpha As Integer = 0
    Protected m_intNumberOfNumerals As Integer = 0
    Protected m_intNumberOfSpecialChars As Integer = 0

    Protected ExtraCharCount As Integer = 0
    Protected strSpecialCharacters As String = ""
#End Region


    Public Sub New()
        'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
        'Put user code to initialize the page here
        Dim drCompanyInfo As IDataReader
        'Get data reader Object    
        drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drCompanyInfo.Read Then
            m_blnEnablePassLength = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePWDLength"), "0"), Boolean)
            m_intMinLength = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MiniPwdLength"), "0"))
            m_intMaxLength = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MaxPwdLength"), "0"))

            m_blnEnableAlphaNumSpeChar = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableAlphaNumSpecialChar"), "0"), Boolean)
            m_intNumberOfAlpha = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfAlpha"), "0"))
            m_intNumberOfNumerals = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfNumerals"), "0"))
            m_intNumberOfSpecialChars = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfSpecial"), "0"))
        End If
        If drCompanyInfo.IsClosed = False Then
            drCompanyInfo.Close()
        End If
        'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization

        If m_blnEnablePassLength = True Then
            'min and Max + 1
            minStringLength = random.Next(m_intMinLength, m_intMaxLength)
        Else
            minStringLength = 6
        End If

        strSpecialCharacters = ConfigurationManager.AppSettings.Get("SpecialCharactersList")
               
    End Sub

    Public Function CreatePassword()
        ExtraCharCount = minStringLength - (m_intNumberOfAlpha + m_intNumberOfNumerals + m_intNumberOfSpecialChars)

        If m_blnEnableAlphaNumSpeChar = True Then
            'Specific number of Random Alphabets
            strRandomAlphabates = RandomString(m_intNumberOfAlpha)

            'Specific number of  Random Numerals
            strRandomNumerals = RandomNumbers(m_intNumberOfNumerals)

            'Specific number of  Random Speacial Characters
            strRandomSpecialChars = RandomSpecialCharacters(m_intNumberOfSpecialChars)

            strRandomExtraChars = RandomExtraCharacters(ExtraCharCount)
        Else
            'Specific number of Random Alphabets
            strRandomAlphabates = RandomString(3)

            'Specific number of  Random Numerals
            strRandomNumerals = RandomNumbers(2)

            'Specific number of  Random Speacial Characters
            strRandomSpecialChars = RandomSpecialCharacters(1)

            strRandomExtraChars = ""
        End If


        FinalString = strRandomAlphabates & strRandomNumerals & strRandomSpecialChars & strRandomExtraChars

        FinalString = ShuffleString(FinalString)

        Return FinalString
    End Function

    Private Function RandomString(ByVal count As Integer) As String
        Dim prng As New Random

        'valid chars in random string
        Const randCH As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

        Dim sb As New System.Text.StringBuilder
        For i As Integer = 1 To count
            sb.Append(randCH.Substring(prng.Next(0, randCH.Length), 1))
        Next
        Return sb.ToString()
    End Function

    Private Function RandomNumbers(ByVal count As Integer) As String
        Dim prng As New Random

        'valid numbers in random string
        Const randCH As String = "1234567890"

        Dim sb As New System.Text.StringBuilder
        For i As Integer = 1 To count
            sb.Append(randCH.Substring(prng.Next(0, randCH.Length), 1))
        Next
        Return sb.ToString()
    End Function
    Private Function RandomSpecialCharacters(ByVal count As Integer) As String
        Dim prng As New Random

        'valid special characters in random string

        'Const randCH As String = "*$-+?_&=!%{}/@"
        Dim randCH As String = strSpecialCharacters

        Dim sb As New System.Text.StringBuilder
        For i As Integer = 1 To count
            sb.Append(randCH.Substring(prng.Next(0, randCH.Length), 1))
        Next
        Return sb.ToString()
    End Function
    Private Function RandomExtraCharacters(ByVal count As Integer) As String
        Dim prng As New Random

        'valid chars in random string
        Dim randCH As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890" & strSpecialCharacters

        Dim sb As New System.Text.StringBuilder
        For i As Integer = 1 To count
            sb.Append(randCH.Substring(prng.Next(0, randCH.Length), 1))
        Next
        Return sb.ToString()
    End Function
    Private Function ShuffleString(ByVal strInput As String) As String

        Dim strOutput As String = ""
        Dim rand As New System.Random
        Dim intPlace As Integer

        While strInput.Length > 0

            intPlace = rand.Next(0, strInput.Length)
            strOutput += strInput.Substring(intPlace, 1)
            strInput = strInput.Remove(intPlace, 1)

        End While

        Return strOutput

    End Function
End Class
