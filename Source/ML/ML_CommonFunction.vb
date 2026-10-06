Imports System
Imports System.IO
Imports System.XML
Imports System.Security
Imports System.Security.Cryptography


Namespace MLCommonFunction
    Public Class ML_CommonFunction
        'Encryption and decryption Code Start
        ' <summary>
        ' Encrypts specified plaintext using Rijndael symmetric key algorithm
        ' and returns a base64-encoded result.
        ' </summary>
        ' <param name="plainText">
        ' Plaintext value to be encrypted.
        ' </param>
        ' <param name="passPhrase">
        ' Passphrase from which a pseudo-random password will be derived. The 
        ' derived password will be used to generate the encryption key. 
        ' Passphrase can be any string. In this example we assume that this 
        ' passphrase is an ASCII string.
        ' </param>
        ' <param name="saltValue">
        ' Salt value used along with passphrase to generate password. Salt can 
        ' be any string. In this example we assume that salt is an ASCII string.
        ' </param>
        ' <param name="hashAlgorithm">
        ' Hash algorithm used to generate password. Allowed values are: "MD5" and
        ' "SHA1". SHA1 hashes are a bit slower, but more secure than MD5 hashes.
        ' </param>
        ' <param name="passwordIterations">
        ' Number of iterations used to generate password. One or two iterations
        ' should be enough.
        ' </param>
        ' <param name="initVector">
        ' Initialization vector (or IV). This value is required to encrypt the 
        ' first block of plaintext data. For RijndaelManaged class IV must be 
        ' exactly 16 ASCII characters long.
        ' </param>
        ' <param name="keySize">
        ' Size of encryption key in bits. Allowed values are: 128, 192, and 256. 
        ' Longer keys are more secure than shorter keys.
        ' </param>
        ' <returns>
        ' Encrypted value formatted as a base64-encoded string.
        ' </returns>
        Public Shared Function Encrypt(ByVal plainText As String) As String

            ' Convert strings into byte arrays.
            ' Let us assume that strings only contain ASCII codes.
            ' If strings include Unicode characters, use Unicode, UTF7, or UTF8 
            ' encoding.

            Dim passPhrase As String = "Pas5pr@se"  ' can be any string
            Dim saltValue As String = "s@1tValue"      ' can be any string
            Dim hashAlgorithm As String = "SHA1"     ' can be "MD5"
            Dim passwordIterations As Integer = 2  ' can be any number
            Dim initVector As String = "@1B2c3D4e5F6g7H8" ' must be 16 bytes
            Dim keySize As Integer = 256 ' can be 192 or 128
            Dim initVectorBytes As Byte()
            initVectorBytes = Encoding.ASCII.GetBytes(initVector)
            Dim saltValueBytes As Byte()
            saltValueBytes = Encoding.ASCII.GetBytes(saltValue)

            ' Convert our plaintext into a byte array.
            ' Let us assume that plaintext contains UTF8-encoded characters.
            Dim plainTextBytes As Byte()
            plainTextBytes = Encoding.UTF8.GetBytes(plainText)

            ' First, we must create a password, from which the key will be derived.
            ' This password will be generated from the specified passphrase and 
            ' salt value. The password will be created using the specified hash 
            ' algorithm. Password creation can be done in several iterations.
            Dim password As PasswordDeriveBytes
            password = New PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations)

            ' Use the password to generate pseudo-random bytes for the encryption
            ' key. Specify the size of the key in bytes (instead of bits).
            Dim keyBytes As Byte()
            keyBytes = password.GetBytes(keySize / 8)

            ' Create uninitialized Rijndael encryption object.
            Dim symmetricKey As RijndaelManaged
            symmetricKey = New RijndaelManaged()

            ' It is reasonable to set encryption mode to Cipher Block Chaining
            ' (CBC). Use default options for other symmetric key parameters.
            symmetricKey.Mode = CipherMode.CBC

            ' Generate encryptor from the existing key bytes and initialization 
            ' vector. Key size will be defined based on the number of the key 
            ' bytes.
            Dim encryptor As ICryptoTransform
            encryptor = symmetricKey.CreateEncryptor(keyBytes, initVectorBytes)

            ' Define memory stream which will be used to hold encrypted data.
            Dim memoryStream As MemoryStream
            memoryStream = New MemoryStream()

            ' Define cryptographic stream (always use Write mode for encryption).
            Dim cryptoStream As CryptoStream
            cryptoStream = New CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write)
            ' Start encrypting.
            cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length)

            ' Finish encrypting.
            cryptoStream.FlushFinalBlock()

            ' Convert our encrypted data from a memory stream into a byte array.
            Dim cipherTextBytes As Byte()
            cipherTextBytes = memoryStream.ToArray()

            ' Close both streams.
            memoryStream.Close()
            cryptoStream.Close()

            ' Convert encrypted data into a base64-encoded string.
            Dim cipherText As String
            cipherText = Convert.ToBase64String(cipherTextBytes)

            ' Return encrypted string.
            Encrypt = cipherText
        End Function

        ' <summary>
        ' Decrypts specified ciphertext using Rijndael symmetric key algorithm.
        ' </summary>
        ' <param name="cipherText">
        ' Base64-formatted ciphertext value.
        ' </param>
        ' <param name="passPhrase">
        ' Passphrase from which a pseudo-random password will be derived. The 
        ' derived password will be used to generate the encryption key. 
        ' Passphrase can be any string. In this example we assume that this 
        ' passphrase is an ASCII string.
        ' </param>
        ' <param name="saltValue">
        ' Salt value used along with passphrase to generate password. Salt can 
        ' be any string. In this example we assume that salt is an ASCII string.
        ' </param>
        ' <param name="hashAlgorithm">
        ' Hash algorithm used to generate password. Allowed values are: "MD5" and
        ' "SHA1". SHA1 hashes are a bit slower, but more secure than MD5 hashes.
        ' </param>
        ' <param name="passwordIterations">
        ' Number of iterations used to generate password. One or two iterations
        ' should be enough.
        ' </param>
        ' <param name="initVector">
        ' Initialization vector (or IV). This value is required to encrypt the 
        ' first block of plaintext data. For RijndaelManaged class IV must be 
        ' exactly 16 ASCII characters long.
        ' </param>
        ' <param name="keySize">
        ' Size of encryption key in bits. Allowed values are: 128, 192, and 256. 
        ' Longer keys are more secure than shorter keys.
        ' </param>
        ' <returns>
        ' Decrypted string value.
        ' </returns>
        ' <remarks>
        ' Most of the logic in this function is similar to the Encrypt 
        ' logic. In order for decryption to work, all parameters of this function
        ' - except cipherText value - must match the corresponding parameters of 
        ' the Encrypt function which was called to generate the 
        ' ciphertext.
        ' </remarks>
        Public Shared Function Decrypt(ByVal cipherText As String) As String

            ' Convert strings defining encryption key characteristics into byte
            ' arrays. Let us assume that strings only contain ASCII codes.
            ' If strings include Unicode characters, use Unicode, UTF7, or UTF8
            ' encoding.
            Dim passPhrase As String = "Pas5pr@se"  ' can be any string
            Dim saltValue As String = "s@1tValue"      ' can be any string
            Dim hashAlgorithm As String = "SHA1"     ' can be "MD5"
            Dim passwordIterations As Integer = 2  ' can be any number
            Dim initVector As String = "@1B2c3D4e5F6g7H8" ' must be 16 bytes
            Dim keySize As Integer = 256 ' can be 192 or 128
            Dim initVectorBytes As Byte()
            initVectorBytes = Encoding.ASCII.GetBytes(initVector)

            Dim saltValueBytes As Byte()
            saltValueBytes = Encoding.ASCII.GetBytes(saltValue)

            ' Convert our ciphertext into a byte array.
            Dim cipherTextBytes As Byte()
            cipherTextBytes = Convert.FromBase64String(cipherText)

            ' First, we must create a password, from which the key will be 
            ' derived. This password will be generated from the specified 
            ' passphrase and salt value. The password will be created using
            ' the specified hash algorithm. Password creation can be done in
            ' several iterations.
            Dim password As PasswordDeriveBytes
            password = New PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations)

            ' Use the password to generate pseudo-random bytes for the encryption
            ' key. Specify the size of the key in bytes (instead of bits).
            Dim keyBytes As Byte()
            keyBytes = password.GetBytes(keySize / 8)

            ' Create uninitialized Rijndael encryption object.
            Dim symmetricKey As RijndaelManaged
            symmetricKey = New RijndaelManaged()

            ' It is reasonable to set encryption mode to Cipher Block Chaining
            ' (CBC). Use default options for other symmetric key parameters.
            symmetricKey.Mode = CipherMode.CBC

            ' Generate decryptor from the existing key bytes and initialization 
            ' vector. Key size will be defined based on the number of the key 
            ' bytes.
            Dim decryptor As ICryptoTransform
            decryptor = symmetricKey.CreateDecryptor(keyBytes, initVectorBytes)

            ' Define memory stream which will be used to hold encrypted data.
            Dim memoryStream As MemoryStream
            memoryStream = New MemoryStream(cipherTextBytes)

            ' Define memory stream which will be used to hold encrypted data.
            Dim cryptoStream As CryptoStream
            cryptoStream = New CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read)

            ' Since at this point we don't know what the size of decrypted data
            ' will be, allocate the buffer long enough to hold ciphertext;
            ' plaintext is never longer than ciphertext.
            Dim plainTextBytes As Byte()
            ReDim plainTextBytes(cipherTextBytes.Length)

            ' Start decrypting.
            Dim decryptedByteCount As Integer
            decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length)

            ' Close both streams.
            memoryStream.Close()
            cryptoStream.Close()

            ' Convert decrypted data into a string. 
            ' Let us assume that the original plaintext string was UTF8-encoded.
            Dim plainText As String
            plainText = Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount)

            ' Return decrypted string.
            Decrypt = plainText
        End Function
        'Encryption and decryption Code End

        Public Shared Function Validate_Modulexml(ByVal m_Filepath As String) As String 'integer 
            Dim m_strAvailable As String
            Dim strAvailableLicences As String = ""
            Dim m_strModules As String = ""
            Dim strlicences As String
            Dim strModuleID As String
            Dim strcompanyname As String = ""
            Dim m_intAlloted As Integer
            Dim m_TotalLicences As Integer = 0
            Dim m_noofSystemModules As Integer
            Dim dXMLSet As New DataSet()
            Dim dXMLRdr As DataTableReader
            Dim m_strcompanyname_1 As String = ""
            Dim m_strcompanyname_2 As String = ""
            Dim i As Integer = 0
            Dim strXMLPath As String = m_Filepath
            Dim Modules(20) As Integer
            Dim drCompany As IDataReader
            Validate_Modulexml = ""
            drcompany = CommonFunctions.Data.GetDataReader("select CompanyName,NoOfUsers from tbl_pm_companyinformation", True)
            If drcompany.Read Then
                m_TotalLicences = drcompany("NoOfUsers")
                strcompanyname = drcompany("CompanyName")
            End If
            drcompany.Dispose()
            Try
                If CommonFunctions.FileDirectory.IsFileExists(strXMLPath) Then
                    dXMLSet.ReadXml(strXMLPath)
                    dXMLRdr = dXMLSet.CreateDataReader()

                    While dXMLRdr.Read()
                        strlicences = Decrypt(dXMLRdr("Licences_Text").ToString())
                        strModuleID = strlicences.Substring(strlicences.IndexOf("/") + 1, strlicences.LastIndexOf("/") - (strlicences.IndexOf("/") + 1))
                        If i = 0 Then
                            m_strcompanyname_1 = strlicences.Substring(0, strlicences.IndexOf("/"))
                        Else
                            m_strcompanyname_2 = m_strcompanyname_1
                        End If
                        m_strcompanyname_1 = strlicences.Substring(0, strlicences.IndexOf("/"))
                        strlicences = strlicences.Substring(strlicences.LastIndexOf("/") + 1)
                        'Modified By AmmitJ on 15-Apr-2010
                        If strlicences = "" Then
                            strlicences = "0"
                        End If
                        'End of Modificaitons
                        m_intAlloted = CommonFunctions.Data.GetDataScalar("select ISNULL(Count(UniqueID),0) as Alloted FROM tbl_PM_Login_AccessibleModules Where ModuleID=" + strModuleID.ToString + " AND IsActive=1", True)
                        m_strAvailable = CType(strlicences, Double) - m_intAlloted
                        If CType(strlicences, Double) < m_intAlloted Then
                            Validate_Modulexml = "Validation Key has Invalid Licences."

                            Exit While
                        End If
                        If CType(strlicences, Double) > m_TotalLicences Then
                            Validate_Modulexml = "Validation Key Exceeds User Licences."

                            Exit While
                        End If
                        If strcompanyname.ToUpper <> m_strcompanyname_1.ToUpper Then
                            Validate_Modulexml = "Validation Key  has Invalid Company Key."

                            Exit While
                        End If
                        If i = 0 Then
                            strAvailableLicences = m_strAvailable
                            m_strModules = strModuleID
                        Else
                            If m_strcompanyname_1.ToUpper <> m_strcompanyname_2.ToUpper Then
                                Validate_Modulexml = "Validation Key  has Invalid Company Key."
                                Exit While
                            End If
                            strAvailableLicences = strAvailableLicences + "," + m_strAvailable
                            m_strModules = m_strModules + "," + strModuleID
                        End If
                        i = i + 1
                    End While
                    dXMLRdr.Close()
                    dXMLSet.Dispose()
                    m_noofSystemModules = CommonFunctions.Data.GetDataScalar("Select Count(ModuleTagID) as Modules from tbl_PM_SystemModules", True)
                    strcompanyname = CommonFunctions.Data.GetDataScalar("Select Companyname from tbl_PM_companyinformation", True)
                    If Validate_Modulexml = "" Then
                        If strcompanyname.ToUpper <> m_strcompanyname_1.ToUpper Then
                            Validate_Modulexml = "Validation Key  has Invalid Company Key."
                        End If
                    End If
                    If (i <> m_noofSystemModules) And Validate_Modulexml = "" Then
                        Validate_Modulexml = "Validation Key  has Invalid Modules Key."
                    End If
                    If Validate_Modulexml = "" Then
                        If CommonFunctions.Data.GetDataScalar("usp_Validate_ModulesXML '" + m_strModules.ToString + "','" + strAvailableLicences.ToString + "'", True) = 0 Then
                            Validate_Modulexml = "Validation Key Corrupted."
                        End If
                    End If
                Else
                    Validate_Modulexml = "Validation Key does not exist."
                End If
            Catch ex As Exception
                Validate_Modulexml = "Validation Key Corrupted."
            Finally
            End Try
        End Function
    End Class

End Namespace
