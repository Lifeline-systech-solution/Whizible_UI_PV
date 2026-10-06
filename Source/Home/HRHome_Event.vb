Option Strict Off

Imports System.Xml
Imports System.IO
Imports System.Text


Public Class HRHome_Event
    Inherits System.Web.UI.Page

    Private m_intUserID As String = ""

    Private Sub InitializeData()
        '=====================================================================
        ' Procedure Name        : InitializeData()
        ' Purpose               : To initialize the variables.
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : August 18, 2008
        ' Revisions             :
        '=====================================================================
        m_intUserID = HttpContext.Current.Session("intUserID").ToString

    End Sub
    Public Function BeforeControlMenuPlot(ByRef Args As Menuitem_Home, ByRef cancel As Boolean) As String
        '=====================================================================
        ' Procedure Name        : BeforeControlMenuPlot()
        ' Purpose               : To handle Events related to HRHome Page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : August 19, 2008
        ' Revisions             :
        '=====================================================================
        'Added By PiyushB on 18-Aug-2008
        'Purpose : To check Number of Licenses Available before adding new Employee and give alert if Number of Employee exceeds License limit.
        Dim strSQEL As String = ""
        Dim strEmployeeDeclarationID As String = ""

        Select Case Args.SystemControlItem.ToString.ToUpper
            'Added by SujitG on 2 Dec 2008
        Case "INITIATE INDUCTION PROCESS"
                Dim drCompanyInformation As IDataReader
                Dim objValidatePW As Authentication.PWEncryption
                Dim intNoOfUsers As Integer
                Dim strEncryptedNoOfUsers As String
                Dim strEncryptedLicenseCode As String
                Dim intLicenseCode As Integer
                Dim strCSPLEmail As String
                Dim strEncryptedResult As String
                Dim blnCInfoManipulated As Boolean
                Dim intAllowedNoOfUsers As Integer
                Dim intActualNoOfUsers As Integer
                Dim blnRestrictExcessLogins As Boolean

                ' Get the number of licensed users as stored in the database.
                drCompanyInformation = CommonFunction.Data.GetDataReader("SELECT TOP 1 NoOfUsers, EncryptedUserNo, LicenseCode, EncryptedLicenseCode, CSPLEmail FROM tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drCompanyInformation.Read
                    intNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("NoOfUsers")), Integer)
                    strEncryptedNoOfUsers = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("EncryptedUserNo")).ToString.Trim
                    intLicenseCode = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("LicenseCode")), Integer)
                    strEncryptedLicenseCode = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("EncryptedLicenseCode")).ToString.Trim
                    strCSPLEmail = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("CSPLEmail")).ToString.Trim
                End While
                CommonFunction.Data.DisposeDataReader(drCompanyInformation)

                'Check if the no of users is manipulated
                objValidatePW = New Authentication.PWEncryption("PBN", intNoOfUsers.ToString)
                strEncryptedResult = objValidatePW.Encrypt
                objValidatePW = Nothing

                ' Compare the actual value with the encrypted value.
                If strEncryptedResult <> strEncryptedNoOfUsers Then blnCInfoManipulated = True

                'Check if the license code is manipulated
                objValidatePW = New Authentication.PWEncryption("PBN", intLicenseCode.ToString)
                strEncryptedResult = objValidatePW.Encrypt()
                objValidatePW = Nothing

                'Compare the actual value with the encrypted value.
                If strEncryptedResult <> strEncryptedLicenseCode Then blnCInfoManipulated = True

                drCompanyInformation = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_UserLicenseInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drCompanyInformation.Read
                    intAllowedNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("AllowedNoOfUsers")), Integer)
                    intActualNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("ActualNoOfUsers")), Integer)
                    blnRestrictExcessLogins = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("RestrictExcessLogins")), Boolean)
                End While
                CommonFunction.Data.DisposeDataReader(drCompanyInformation)
                If blnCInfoManipulated = True Or (blnRestrictExcessLogins = True And (intAllowedNoOfUsers <= intActualNoOfUsers)) Then ' Removed And strPrimaryKey = ""
                    Args.ToBeInsertedInDynamicFunction = Args.ToBeInsertedInDynamicFunction.ToString + " alert(""Number of License excedds available limit!! "");  return;"
                End If
                'End of addition by SujitG on 2 Dec 2008

            Case "INITIATE EMPLOYEE INDUCTION"
                Dim drCompanyInformation As IDataReader
                Dim objValidatePW As Authentication.PWEncryption
                Dim intNoOfUsers As Integer
                Dim strEncryptedNoOfUsers As String
                Dim strEncryptedLicenseCode As String
                Dim intLicenseCode As Integer
                Dim strCSPLEmail As String
                Dim strEncryptedResult As String
                Dim blnCInfoManipulated As Boolean
                Dim intAllowedNoOfUsers As Integer
                Dim intActualNoOfUsers As Integer
                Dim blnRestrictExcessLogins As Boolean


                ' Get the number of licensed users as stored in the database.
                drCompanyInformation = CommonFunction.Data.GetDataReader("SELECT TOP 1 NoOfUsers, EncryptedUserNo, LicenseCode, EncryptedLicenseCode, CSPLEmail FROM tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drCompanyInformation.Read
                    intNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("NoOfUsers")), Integer)
                    strEncryptedNoOfUsers = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("EncryptedUserNo")).ToString.Trim
                    intLicenseCode = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("LicenseCode")), Integer)
                    strEncryptedLicenseCode = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("EncryptedLicenseCode")).ToString.Trim
                    strCSPLEmail = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("CSPLEmail")).ToString.Trim
                End While
                CommonFunction.Data.DisposeDataReader(drCompanyInformation)

                'Check if the no of users is manipulated
                objValidatePW = New Authentication.PWEncryption("PBN", intNoOfUsers.ToString)
                strEncryptedResult = objValidatePW.Encrypt
                objValidatePW = Nothing

                ' Compare the actual value with the encrypted value.
                If strEncryptedResult <> strEncryptedNoOfUsers Then blnCInfoManipulated = True

                'Check if the license code is manipulated
                objValidatePW = New Authentication.PWEncryption("PBN", intLicenseCode.ToString)
                strEncryptedResult = objValidatePW.Encrypt()
                objValidatePW = Nothing

                'Compare the actual value with the encrypted value.
                If strEncryptedResult <> strEncryptedLicenseCode Then blnCInfoManipulated = True

                drCompanyInformation = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_UserLicenseInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drCompanyInformation.Read
                    intAllowedNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("AllowedNoOfUsers")), Integer)
                    intActualNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("ActualNoOfUsers")), Integer)
                    blnRestrictExcessLogins = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("RestrictExcessLogins")), Boolean)
                End While
                CommonFunction.Data.DisposeDataReader(drCompanyInformation)

                If blnCInfoManipulated = True Or (blnRestrictExcessLogins = True And (intAllowedNoOfUsers <= intActualNoOfUsers)) Then ' Removed And strPrimaryKey = ""
                    'Variable ToBeInsertedInDynamicFunction is made to give an alert and return ifno of license exceeds capacity
                    Args.ToBeInsertedInDynamicFunction = Args.ToBeInsertedInDynamicFunction.ToString + " alert(""Number of License excedds available limit!! "");  return;"

                End If
                'Addition  Ended By PiyushB on 18-Aug-2008
                'Added by NishikantS on 4 Sep 2008 for Tax Declaration
            Case "SUBMIT TAX DECLARATION"
                strSQEL = ""
                strSQEL = "SELECT tbl_FA_Employee_Declaration_Master.EmployeeDeclarationID FROM tbl_FA_Employee_Declaration_Master LEFT JOIN tbl_HR_FinancialYear_Master ON tbl_FA_Employee_Declaration_Master.FinancialYearID = tbl_HR_FinancialYear_Master.FinancialYearID WHERE tbl_HR_FinancialYear_Master.IsCurrentFY = 1 AND tbl_FA_Employee_Declaration_Master.EmployeeID = " + HttpContext.Current.Session("intUserID").ToString
                strEmployeeDeclarationID = CommonFunction.Data.GetDataScalar(strSQEL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                If strEmployeeDeclarationID <> "" Then
                    Args.PageURL = "../PayRoll/EmployeeDeclarations_CommonPage.aspx?EmployeeDeclarationID_PK=" + strEmployeeDeclarationID + "&MasterTagID=2610&FromWhere=PL&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
                Else
                    Args.ToBeInsertedInDynamicFunction = Args.ToBeInsertedInDynamicFunction.ToString + " alert(""Tax declaration for Current Finanical year is not Initiated\n To check previous records click on History link."");  return;"

                End If
                'End of Addition by NishikantS on 4 Sep 2008
            Case "MY BENEFIT CLAIM"
                Dim strCurrentFinancialYearID As String = ""
                strCurrentFinancialYearID = CommonFunction.Data.GetSQLDataScalar("SELECT FinancialYearID FROM tbl_HR_FinancialYear_Master WHERE IsCurrentFY=1").ToString
                Args.PageURL = "../HR/HR_Benefits_AllResources_CommonList.aspx?MasterTagID=6193&FromWhere=BC&FromTree=1&From_Where=HRHome&EmployeeID=" + HttpContext.Current.Session("intUserID").ToString() + "&FinancialYearID=" + strCurrentFinancialYearID
            Case "SUBMIT MY TAX DECLARATION"
                Dim strCurrentFinancialYearID As String = ""
                strCurrentFinancialYearID = CommonFunction.Data.GetDataScalar("SELECT FinancialYearID FROM tbl_HR_FinancialYear_Master WHERE IsCurrentFY=1", True).ToString
                strEmployeeDeclarationID = CommonFunction.Data.GetDataScalar("SELECT EmployeeDeclarationID FROM tbl_FA_Employee_Declaration_Master WHERE EmployeeID = " + HttpContext.Current.Session("intUserID").ToString + " AND FinancialYearID =" + strCurrentFinancialYearID, True).ToString
                If strEmployeeDeclarationID = "" Then
                    Args.ToBeInsertedInDynamicFunction = Args.ToBeInsertedInDynamicFunction.ToString + " alert(""Income Tax Declaration process not initiated. !!! "");  return;"

                Else
                    Args.PageURL = "../PayRoll/EmployeeDeclarations_CommonPage.aspx?ReferenceParameter=0&AccessTagID=2610&MasterTagID=2610&FromWhere=PL&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&From_Where=HRHome&EmployeeDeclarationID_PK=" & strEmployeeDeclarationID
                End If


        End Select
    End Function
    Public Function Before_LastUpdateLinkPrint(ByRef Args As Menuitem_Home, ByRef cancel As Boolean) As String
        '=====================================================================
        ' Procedure Name        : Before_LastUpdateLinkPrint()
        ' Purpose               : To handle Events related to HRHome Page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : Sep 09, 2008
        ' Revisions             :
        '=====================================================================

        Dim blnShowLastUpdateRecord As Boolean
        Dim intlastUpdationType As Integer = 0
        Dim strLastUpdationHTML As String = ""
        Dim strlastUpdateValueQuery As String = ""
        Dim strPlaceholder As String = ""
        Dim strLastUpdationSP As String = ""
        Dim intPlaceHolderCount As Integer = 0
        Dim drReplacePlaceHolder As IDataReader
        Dim intCount As Integer = 0
        Dim strPrimaryKeySQL As String = ""
        Dim intPrimaryKeyValue As String = ""
        Dim strPKToken As String = ""

        Select Case Args.TagID.ToString
            Case "2294"
                If Args.LastUpdateHTML.ToString.IndexOf("<PKToken>") > 0 Then
                    strPrimaryKeySQL = HRCommonfunction.ReplacePlaceHolders(Args.LastUpdatePrimaryKeySQL)
                    If strPrimaryKeySQL <> "" Then
                        intPrimaryKeyValue = Args.PrimaryKeyValue.ToString
                        Args.PKToken = CommonFunctions.Security.Token.GetToken(CType(intPrimaryKeyValue, String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                        Args.LastUpdateHTML = Args.LastUpdateHTML.Replace("<PKToken>", Args.PKToken)
                    End If
                End If
        End Select
    End Function

    Public Function After_LastUpdateLinkPrint(ByRef Args As Menuitem_Home, ByRef cancel As Boolean) As String
        '=====================================================================
        ' Procedure Name        : After_LastUpdateLinkPrint()
        ' Purpose               : To handle Events related to HRHome Page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : Sep 09, 2008
        ' Revisions             :
        '=====================================================================
    End Function

    Public Sub New()

    End Sub
End Class
Public Class Menuitem_Home
    Protected strControlItemID As String = ""
    Protected strControlItem As String = ""
    Protected strItemDescription As String = ""
    Protected strImageName As String = ""
    Protected strPriorityNumber As String = ""
    Protected strTagID As String = ""
    Protected strParentControlItemID As String = ""
    Protected strIsContentOfMore As String = ""
    Protected strMenuGroupID As String = ""
    Protected strOrderNumber As String = ""
    Protected strRowNumber As String = ""
    Protected strcountSQL As String = ""
    Protected strPageURL As String = ""
    Protected strToolTip As String = ""
    Protected strPageWidth As String = ""
    Protected strPageHeight As String = ""
    Protected strToBeInsertedInDynamicFunction As String = ""
    Protected strProcess As String = ""
    Protected strIsSubTag As String = ""
    Protected strInsertAfterControlItem As String = ""
    Protected strSystemControlItem As String = ""
    Protected strGroupingOn As String = ""
    Protected strOrderingProcess As String = ""
    'Added by SujitG on 05 Sep 2008
    Protected strInsertInUpdateLink As String = ""
    'End of addition by SujitG on 05 Sep 2008 
    'Added by SujitG on 09 Sep 2008 
    Protected m_intShowLastUpdated As Integer = 0
    Protected m_blnShowLastUpdated As Boolean = False
    Protected m_intLastUpdationType As Integer = 0
    Protected m_strLastUpdateHTML As String = ""
    Protected m_strLastUpdateValueQuery As String = ""
    Protected m_strLastUpdatePrimaryKeySQL As String = ""
    Protected m_strPKToken As String = ""
    Protected m_intPrimaryKeyValue As Integer = 0
    Protected m_blnApplyTagSecurity As Boolean = True

    'End of addition by SujitG on 09 Sep 2008


    Public Property ControlItemID() As String
        Get
            Return strControlItemID.ToString
        End Get
        Set(ByVal value As String)
            strControlItemID = value.ToString
        End Set
    End Property
    Public Property ControlItem() As String
        Get
            Return strControlItem
        End Get
        Set(ByVal value As String)
            strControlItem = value.ToString
        End Set
    End Property
    Public Property ItemDescription() As String
        Get
            Return strItemDescription
        End Get
        Set(ByVal value As String)
            strItemDescription = value.ToString
        End Set
    End Property
    Public Property ImageName() As String
        Get
            Return strImageName.ToString
        End Get
        Set(ByVal value As String)
            strImageName = value.ToString
        End Set
    End Property
    Public Property PriorityNumber() As String
        Get
            Return strPriorityNumber
        End Get
        Set(ByVal value As String)
            strPriorityNumber = value
        End Set
    End Property
    Public Property ApplyTagSecurity() As Boolean
        Get
            Return m_blnApplyTagSecurity
        End Get
        Set(ByVal value As Boolean)
            m_blnApplyTagSecurity = value
        End Set
    End Property

    Public Property TagID() As String
        Get
            Return strTagID
        End Get
        Set(ByVal value As String)
            strTagID = value
        End Set
    End Property
    Public Property ParentControlItemID() As String
        Get
            Return strParentControlItemID
        End Get
        Set(ByVal value As String)
            strParentControlItemID = value
        End Set
    End Property
    Public Property IsContentOfMore() As String
        Get
            Return strIsContentOfMore
        End Get
        Set(ByVal value As String)
            strIsContentOfMore = value
        End Set
    End Property
    Public Property MenuGroupID() As String
        Get
            Return strMenuGroupID
        End Get
        Set(ByVal value As String)
            strMenuGroupID = value
        End Set
    End Property
    Public Property OrderNumber() As String
        Get
            Return strOrderNumber
        End Get
        Set(ByVal value As String)
            strOrderNumber = value
        End Set
    End Property
    Public Property RowNumber() As String
        Get
            Return strRowNumber
        End Get
        Set(ByVal value As String)
            strRowNumber = value
        End Set
    End Property
    Public Property countSQL() As String
        Get
            Return strcountSQL
        End Get
        Set(ByVal value As String)
            strcountSQL = value
        End Set
    End Property
    Public Property PageURL() As String
        Get
            Return strPageURL
        End Get
        Set(ByVal value As String)
            strPageURL = value
        End Set
    End Property
    Public Property ToolTip() As String
        Get
            Return strToolTip
        End Get
        Set(ByVal value As String)
            strToolTip = value
        End Set
    End Property
    Public Property PageWidth() As String
        Get
            Return strPageWidth
        End Get
        Set(ByVal value As String)
            strPageWidth = value
        End Set
    End Property
    Public Property PageHeight() As String
        Get
            Return strPageHeight
        End Get
        Set(ByVal value As String)
            strPageHeight = value
        End Set
    End Property
    Public Property ToBeInsertedInDynamicFunction() As String
        Get
            Return strToBeInsertedInDynamicFunction
        End Get
        Set(ByVal value As String)
            strToBeInsertedInDynamicFunction = value
        End Set
    End Property
    Public Property Process() As String
        Get
            Return strProcess
        End Get
        Set(ByVal value As String)
            strProcess = value
        End Set
    End Property
    Public Property IsSubTag() As String
        Get
            Return strIsSubTag
        End Get
        Set(ByVal value As String)
            strIsSubTag = value
        End Set
    End Property
    Public Property InsertAfterControlItem() As String
        Get
            Return strInsertAfterControlItem
        End Get
        Set(ByVal value As String)
            strInsertAfterControlItem = value

        End Set
    End Property
    Public Property SystemControlItem() As String
        Get
            Return strSystemControlItem
        End Get
        Set(ByVal value As String)
            strSystemControlItem = value
        End Set
    End Property
    Public Property GroupingOn() As String
        Get
            Return strGroupingOn
        End Get
        Set(ByVal value As String)
            strGroupingOn = value
        End Set
    End Property
    Public Property OrderingProcess() As String
        Get
            Return strOrderingProcess
        End Get
        Set(ByVal value As String)
            strOrderingProcess = value

        End Set
    End Property
    'Added by SujitG on 05 Sep 2008
    Public Property UpdateLinkHTML() As String
        Get
            Return strInsertInUpdateLink
        End Get
        Set(ByVal value As String)
            strInsertInUpdateLink = value
        End Set
    End Property
    'End of addition by SujitG on 05 Sep 2008 

    'Added by SujitG on 09 Sep 2008 
    Public Property ShowLastUpdated() As Boolean
        Get
            Return m_blnShowLastUpdated
        End Get
        Set(ByVal value As Boolean)
            m_blnShowLastUpdated = value
        End Set
    End Property
    Public Property LastUpdationType() As Integer
        Get
            Return m_intLastUpdationType
        End Get
        Set(ByVal value As Integer)
            m_intLastUpdationType = value
        End Set
    End Property
    Public Property LastUpdateHTML() As String
        Get
            Return m_strLastUpdateHTML
        End Get
        Set(ByVal value As String)
            m_strLastUpdateHTML = value
        End Set
    End Property
    Public Property LastUpdateValueQuery() As String
        Get
            Return m_strLastUpdateValueQuery
        End Get
        Set(ByVal value As String)
            m_strLastUpdateValueQuery = value
        End Set
    End Property
    Public Property LastUpdatePrimaryKeySQL() As String
        Get
            Return (m_strLastUpdatePrimaryKeySQL)
        End Get
        Set(ByVal value As String)
            m_strLastUpdatePrimaryKeySQL = value
        End Set
    End Property
    Public Property PKToken() As String
        Get
            Return m_strPKToken
        End Get
        Set(ByVal value As String)
            m_strPKToken = value
        End Set
    End Property
    Public Property PrimaryKeyValue() As Integer
        Get
            Return m_intPrimaryKeyValue
        End Get
        Set(ByVal value As Integer)
            m_intPrimaryKeyValue = value
        End Set
    End Property
    'End of addition by SujitG on 09 Sep 2008



    Public Sub New()

    End Sub

End Class
Public Class DocumentTemplate
    Public Sub New()

    End Sub
    Public Function ReplacePlaceHolders(ByVal strSourceFile As String, ByVal strDestFile As String, ByVal strPlaceHolder As String(), ByVal strReplacementValue As String(), Optional ByVal intTemplateID As Integer = 0, Optional ByVal intPrimaryKeyValue As Integer = 0) As String
        '=====================================================================
        ' Procedure Name        : ReplacePlaceHolders()
        ' Purpose               : To replace placeholders in document 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB,SujitG
        ' Created               : Nov 28, 2008
        ' Revisions             :
        '=====================================================================
        Dim intLoopCount As Integer
        Dim intArrayLoopCount As Integer
        'Dim strFileText() As String = File.ReadAllLines("C:\Documents and Settings\piyushb\Desktop\Resume_Utility_3.doc")


        Dim strFileText() As String '= FileReadAllLines(strSourceFile)
        Dim i As Integer = 0
        Try
            ' Create an instance of StreamReader to read from a file.
            Dim sr As StreamReader = New StreamReader(strSourceFile)
            Dim line As String
            ' Read and display the lines from the file until the end 
            ' of the file is reached.
            Do
                strFileText(i) = sr.ReadLine()
                i += 1
            Loop Until line Is Nothing
            sr.Close()
        Catch E As Exception
        End Try





        Dim intFieldsCount As Integer = 0

        intArrayLoopCount = strPlaceHolder.Length
        intLoopCount = strFileText.Length
        While intArrayLoopCount > 0
            intArrayLoopCount = intArrayLoopCount - 1
            'strFileText(intLoopCount) = strFileText(intLoopCount).Replace("PlaceHolder_EmployeeName", "Piyush Bhatewara")
            strFileText(2) = strFileText(2).Replace(strPlaceHolder(intArrayLoopCount), strReplacementValue(intArrayLoopCount))
        End While

        '''''''''''''''''''''''''''''''''''''''''''
        '''SubTagDetails(intTemplateID, intPrimaryKeyValue)

        Dim sbSystemPlaceholderName As New StringBuilder
        Dim sbSource As New StringBuilder
        Dim sbForeignKeyName As New StringBuilder
        Dim sbIsStoredProcedure As New StringBuilder

        Dim strSystemPlaceholderNames As String = ""
        Dim strSource As String = ""
        Dim strForeignKeyNames As String = ""
        Dim strIsStoredProcedure As String = "'"

        Dim drSubTagList As IDataReader
        Dim strTable As String = ""
        Dim strSQLQuery As String = ""

        drSubTagList = CommonFunction.Data.GetDataReader("usp_Sel_SubTagDetails_ForDocument " + intTemplateID.ToString, True)
        While drSubTagList.Read()
            sbSystemPlaceholderName.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTagList("SystemPlaceholderName"), ""), "") & ",")
            sbSource.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTagList("Source"), ""), "") & ",")
            sbForeignKeyName.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTagList("ForeignKeyName"), ""), "") & ",")
            If drSubTagList("IsStoredProcedure") = True Then
                sbIsStoredProcedure.Append("1,")
            Else
                sbIsStoredProcedure.Append("0,")
            End If
        End While
        CommonFunction.Data.DisposeDataReader(drSubTagList)
        strSystemPlaceholderNames = sbSystemPlaceholderName.ToString()
        strSource = sbSource.ToString()
        strForeignKeyNames = sbForeignKeyName.ToString()
        strIsStoredProcedure = sbIsStoredProcedure.ToString()

        If strSystemPlaceholderNames <> "" Then
            strSystemPlaceholderNames = strSystemPlaceholderNames.Substring(0, strSystemPlaceholderNames.Length - 1)
            strSource = strSource.Substring(0, strSource.Length - 1)
            strForeignKeyNames = strForeignKeyNames.Substring(0, strForeignKeyNames.Length - 1)
            strIsStoredProcedure = strIsStoredProcedure.Substring(0, strIsStoredProcedure.Length - 1)

            Dim arrSystemPlaceholderName() As String = strSystemPlaceholderNames.Split(",")
            Dim arrSelectionProcedureName() As String = strSource.Split(",")
            Dim arrForeignKeyName() As String = strForeignKeyNames.Split(",")
            Dim arrIsStoredProcedure() As String = strIsStoredProcedure.Split(",")

            For intLoopCount = 0 To arrSystemPlaceholderName.Length - 1
                If strFileText(2).IndexOf(arrSystemPlaceholderName(intLoopCount)) > 0 Then
                    Dim dtDataTable As DataTable
                    If arrIsStoredProcedure(intLoopCount) = "1" Then
                        dtDataTable = CommonFunction.Data.GetDataTable(arrSelectionProcedureName(intLoopCount) & " " & intPrimaryKeyValue.ToString, True)
                    Else
                        strSQLQuery = "SELECT * FROM " + arrSelectionProcedureName(intLoopCount) + " WHERE " + arrForeignKeyName(intLoopCount) + "=" + intPrimaryKeyValue.ToString
                        dtDataTable = CommonFunction.Data.GetDataTable(strSQLQuery, True)
                    End If
                    strTable = CreateTable(dtDataTable)
                    strFileText(2) = strFileText(2).Replace(arrSystemPlaceholderName(intLoopCount), strTable)
                    dtDataTable.Dispose()
                    strTable = ""
                    strSQLQuery = ""
                End If
            Next
        End If

        ''''''''''''''''''''''''''''''''''''''''''''''
        'File.WriteAllLines("C:\Documents and Settings\piyushb\Desktop\Resume_Utility_4.doc", strFileText)
        Dim sw As StreamWriter = New StreamWriter(strDestFile)
        ' Add some text to the file.
        sw.Write(strFileText)
        sw.Close()
        'File.WriteAllLines(strDestFile, strFileText)

    End Function

    Public Function SubTagDetails(ByVal intTemplateID As Integer, ByVal intPrimaryKeyValue As Integer)
        Dim sbSystemPlaceholderName As New StringBuilder
        Dim sbSource As New StringBuilder
        Dim strSystemPlaceholderNames As String = ""
        Dim strSource As String = ""
        Dim drSubTagList As IDataReader
        drSubTagList = CommonFunction.Data.GetDataReader("usp_Sel_SubTagDetails_ForDocument " + intTemplateID.ToString, True)
        While drSubTagList.Read()
            sbSystemPlaceholderName.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTagList("SystemPlaceholderName"), ""), "") & ",")
            sbSource.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTagList("Source"), ""), "") & ",")
        End While
        strSystemPlaceholderNames = sbSystemPlaceholderName.ToString()
        strSource = sbSource.ToString()
        If strSystemPlaceholderNames <> "" Then
            strSystemPlaceholderNames = strSystemPlaceholderNames.Substring(0, strSystemPlaceholderNames.Length - 1)
            strSource = strSource.Substring(0, strSource.Length - 1)
            Dim arrSystemPlaceholderName() As String = strSystemPlaceholderNames.Split(",")
            Dim arrSelectionProcedureName() As String = strSource.Split(",")
        End If
        CommonFunction.Data.DisposeDataReader(drSubTagList)


    End Function

    Public Function CreateXMLTable()
        Dim strReplacementString As String = ""
        Dim strTableFormat As String
        Dim strFileText() As String '= 
        'File.ReadAllLines("C:\Documents and Settings\piyushb\Desktop\Sujit\TableSample.xml")
        Dim i As Integer = 0
        Try
            ' Create an instance of StreamReader to read from a file.
            Dim sr As StreamReader = New StreamReader("C:\Documents and Settings\piyushb\Desktop\Sujit\TableSample.xml")
            Dim line As String
            ' Read and display the lines from the file until the end 
            ' of the file is reached.
            Do
                strFileText(i) = sr.ReadLine()
                i += 1
            Loop Until line Is Nothing
            sr.Close()
        Catch E As Exception
        End Try


        'strFileText(2) = strFileText(2).Replace("PLACEHOLDERTABLE", "<w:tbl><w:tblPr><w:tblpPr w:leftFromText=""180"" w:rightFromText=""180"" w:vertAnchor=""text"" w:tblpX=""2089"" w:tblpY=""2266"" /><w:tblW w:w=""0"" w:type=""auto"" /><w:tblBorders><w:top w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:left w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:bottom w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:right w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:insideH w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:insideV w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /></w:tblBorders></w:tblPr><w:tblGrid><w:gridCol w:w=""1620"" /><w:gridCol w:w=""1620"" /><w:gridCol w:w=""1440"" /></w:tblGrid><w:tr><w:trPr><w:trHeight w:val=""540"" /></w:trPr><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>Name</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>Role</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w=""1440"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>Amount</w:t></w:r></w:p></w:tc></w:tr><w:proofErr w:type=""spellStart"" /><w:tr><w:trPr><w:trHeight w:val=""345"" /></w:trPr><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>SujitG</w:t></w:r> <w:proofErr w:type=""spellEnd"" /></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w=""1440"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>8000</w:t></w:r></w:p></w:tc></w:tr></w:tbl>")
        'strFileText(2) = strFileText(2).Replace("PLACEHOLDERTABLE", "<w:tbl><w:tr><w:trPr><w:trHeight w:val=""540"" /></w:trPr><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>Name</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>Role</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w=""1440"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>Amount</w:t></w:r></w:p></w:tc></w:tr><w:proofErr w:type=""spellStart"" /><w:tr><w:trPr><w:trHeight w:val=""345"" /></w:trPr><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>SujitG</w:t></w:r> <w:proofErr w:type=""spellEnd"" /></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w=""1440"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr><w:r><w:t>8000</w:t></w:r></w:p></w:tc></w:tr></w:tbl>")
        'strReplacementString = "<w:tbl><w:tblPr><w:tblpPr w:leftFromText=""180"" w:rightFromText=""180"" w:vertAnchor=""text"" w:tblpX=""2089"" w:tblpY=""2266"" /><w:tblW w:w=""0"" w:type=""auto"" /><w:tblBorders><w:top w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:left w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:bottom w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:right w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:insideH w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /><w:insideV w:val=""single"" w:sz=""4"" wx:bdrwidth=""10"" w:space=""0"" w:color=""auto"" /></w:tblBorders></w:tblPr><w:tblGrid><w:gridCol w:w=""1620"" /><w:gridCol w:w=""1620"" /><w:gridCol w:w=""1440"" /></w:tblGrid>"
        'strReplacementString = strReplacementString + "<w:tr><w:trPr><w:trHeight w:val=""540"" /></w:trPr><w:tc><w:tcPr><w:tcW w:w=""1620"" w:type=""dxa"" /></w:tcPr><w:p><w:pPr><w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" />"

        'strFileText(2) = strFileText(2).Replace("PLACEHOLDERTABLE", CreateTable())
        'File.WriteAllLines(, strFileText)
        Dim sw As StreamWriter = New StreamWriter("C:\Documents and Settings\piyushb\Desktop\Sujit\TableSample.xml")
        ' Add some text to the file.
        sw.Write(strFileText)
        sw.Close()
        'File.WriteAllLines(strDestFile, strFileText)
        ''OpenFile("C:\Documents and Settings\piyushb\Desktop\Sujit", "Table2.xml")
    End Function
    ' ''Protected Sub OpenFile(ByVal strFilePath, ByVal strOriginalFileName)
    ' ''    Response.Clear()
    ' ''    Response.ContentType = "Application/pdf/html/csv/excel/rtf/xml/text/msp/doc"
    ' ''    'add the file name to the header
    ' ''    Response.AddHeader("Content-Disposition", "attachment;filename=" + strOriginalFileName.ToString)

    ' ''    Dim iStream As System.IO.Stream
    ' ''    'Process.Start(strFilePath)
    ' ''    ' Buffer to read 10K bytes in chunk:
    ' ''    Dim buffer(10000) As Byte

    ' ''    ' Length of the file:
    ' ''    Dim length As Integer

    ' ''    ' Total bytes to read:
    ' ''    Dim dataToRead As Long

    ' ''    'Identify the file to download including its path.
    ' ''    'Dim filepath As String = strFileName

    ' ''    ' Identify the file name.
    ' ''    Dim filename As String = System.IO.Path.GetFileName(strFilePath)
    ' ''    If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then
    ' ''        Try
    ' ''            ' Open the file.
    ' ''            iStream = New System.IO.FileStream(strFilePath, System.IO.FileMode.Open, _
    ' ''                                                    IO.FileAccess.Read, IO.FileShare.Read)
    ' ''            ' Total bytes to read:
    ' ''            dataToRead = iStream.Length
    ' ''            Response.ContentType = "application/octet-stream"
    ' ''            Response.AddHeader("Content-Disposition", "attachment; filename=" & strOriginalFileName)
    ' ''            ' Read the bytes.
    ' ''            While dataToRead > 0
    ' ''                ' Verify that the client is connected.
    ' ''                If Response.IsClientConnected Then
    ' ''                    ' Read the data in buffer
    ' ''                    length = iStream.Read(buffer, 0, 10000)
    ' ''                    ' Write the data to the current output stream.
    ' ''                    Response.OutputStream.Write(buffer, 0, length)
    ' ''                    ' Flush the data to the HTML output.
    ' ''                    Response.Flush()

    ' ''                    ReDim buffer(10000) ' Clear the buffer
    ' ''                    dataToRead = dataToRead - length
    ' ''                Else
    ' ''                    'prevent infinite loop if user disconnects
    ' ''                    dataToRead = -1
    ' ''                End If
    ' ''            End While
    ' ''        Catch ex As Exception
    ' ''            ' Trap the error, if any.
    ' ''            Response.Write("Error : " & ex.Message)
    ' ''        Finally
    ' ''            If IsNothing(iStream) = False Then
    ' ''                ' Close the file.
    ' ''                iStream.Close()
    ' ''                Response.End()
    ' ''            End If
    ' ''        End Try
    ' ''    Else
    ' ''        Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
    ' ''    End If
    ' ''End Sub

    Public Function CreateTable(ByVal dtEmployeeDetails As DataTable) As String
        'Dim dsEmployeeDetails As DataSet = CommonFunction.Data.GetDataSet("usp_Sel_EmployeeDetails  61", "Employee")
        'Dim dtEmployeeDetails As DataTable = CommonFunction.Data.GetDataTable("usp_Sel_EmployeeDetails 61", True)
        Dim sbTable As New StringBuilder("")
        Dim iForCols As Integer = 0
        Dim CountTblColumns, CountTblRows As Integer
        Dim iForRows As Integer
        Dim blnFirst As Boolean = True
        CountTblRows = dtEmployeeDetails.Rows.Count + 1
        CountTblColumns = dtEmployeeDetails.Columns.Count


        If CountTblRows > 1 Then
            sbTable.Append("<w:tbl><w:tr>")
            sbTable.Append("<w:trPr><w:trHeight w:val=""540"" /></w:trPr>")
            For iForCols = 0 To CountTblColumns - 1
                sbTable.Append("<w:tc>")
                sbTable.Append("<w:tcPr><w:tcW w:w=""1000"" w:type=""dxa"" /></w:tcPr>")
                sbTable.Append("<w:p>")
                sbTable.Append("<w:pPr>")
                sbTable.Append("<w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" />")
                sbTable.Append("</w:pPr>")
                sbTable.Append("<w:r><w:t>")
                sbTable.Append(dtEmployeeDetails.Columns(iForCols).ColumnName)
                sbTable.Append("</w:t></w:r>")
                sbTable.Append("</w:p></w:tc>")
            Next
            sbTable.Append("</w:tr>")
        End If

        If CountTblRows > 1 Then
            For iForRows = 0 To CountTblRows - 2
                sbTable.Append("<w:tr>")
                sbTable.Append("<w:trPr><w:trHeight w:val=""540"" /></w:trPr>")
                For iForCols = 0 To CountTblColumns - 1
                    sbTable.Append("<w:tc>")
                    sbTable.Append("<w:tcPr><w:tcW w:w=""1000"" w:type=""dxa"" /></w:tcPr>")
                    sbTable.Append("<w:p><w:pPr>")
                    sbTable.Append("<w:framePr w:hspace=""180"" w:wrap=""around"" w:vanchor=""text"" w:hanchor=""text"" w:x=""2089"" w:y=""2266"" /></w:pPr>")
                    sbTable.Append("<w:r><w:t>")
                    sbTable.Append(CommonFunction.Data.CheckIsDBNull(dtEmployeeDetails.Rows(iForRows).Item(iForCols).ToString, ""))
                    sbTable.Append("</w:t></w:r>")
                    sbTable.Append("</w:p></w:tc>")
                Next
                sbTable.Append("</w:tr>")
            Next
        End If

        If CountTblRows > 1 Then
            sbTable.Append("</w:tbl>")
        End If

        Return sbTable.ToString()
    End Function

End Class
