Public Class CRM_DepartmentMaster
    Inherits WebPages.Template.WhizTemplate
    Protected str_RequestTypeID As String
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Private WithEvents m_objConfigureHRMGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objRoleMappingGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objGroupEmailGrid As New WebPages.Template.GenericGrid
    ''Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    Private WithEvents m_objProjectMappingGrid As New WebPages.Template.GenericGrid
    ''End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    Private WithEvents m_objCustomerMappingGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objWorkingHoursGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objDepartmentGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objRequestTypeGrid As New WebPages.Template.GenericGrid
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private Shared m_objCurrentTagAccess As WebPage.Templates.AccessRights
    Private Shared m_objSubTabAccess As WebPage.Templates.AccessRights
    Protected Shared TagID As Integer = 396
    Protected Shared m_intRoleID As Integer = 0
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected m_strUserName As String = ""
    Protected Shared strLoginType = ""

    Public txtSQLQuery As New System.Text.StringBuilder
    Public strSQLQuery As String
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=center width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Protected WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)

        Dim strUserName As String = ""
        Dim intUserID As Integer
        strUserName = CType(HttpContext.Current.Session("strUserName"), String)
        intUserID = CType(HttpContext.Current.Session("intUserID"), Integer)

        GetAccessRights()

    End Sub

    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	25 NOV 2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

    End Sub
    <System.Web.Services.WebMethod()>
    Private Shared Function GetCurrentTagAccessRights(ByVal CurrentTagID As String)
        '=====================================================================
        ' Procedure Name        :	GetCurrentTagAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	03 DEC 2017
        ' Revisions             :
        '=====================================================================
        Try
            m_objCurrentTagAccess = New WebPage.Templates.AccessRights
            Dim objGlobal As New WebPage.Templates.WhizGlobal(HttpContext.Current.Session("strUserName"), CurrentTagID, m_intRoleID, CType(HttpContext.Current.Session("intUserID"), Integer), strLoginType)
            m_objCurrentTagAccess.GetAccess(objGlobal)
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteRequestDepartment(ByVal RequestDepartmentID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteRequestDepartment
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Department
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   27 Nov 2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim strResult As String
        Dim index As Integer = 0
        arrDelete = RequestDepartmentID.Split(",")
        Try
            For index = 0 To arrDelete.Length - 1
                strSQL = "exec usp_NG2_Del_tbl_PM_DepartmentMaster  " & arrDelete(index) & ""
                strResult = strResult + " " + CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0")
            Next
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteMappedRole(ByVal FunctionRoleID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteMappedRole
        ' Parameters Passed		:	FunctionRoleID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Mapped ROle
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   28 Nov 2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0

        Try
            GetSubTabAccessRights(119, TagID)
            If m_objSubTabAccess.Delete = True Then
                strSQL = "exec USP_NG2_DEL_Mapped_Roles " & FunctionRoleID & ""
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If

        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteGroupEmail(ByVal DepartmentGroupID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteGroupEmail
        ' Parameters Passed		:	DepartmentGroupID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Group Email
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 Nov 2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0

        Try
            GetSubTabAccessRights(2121, TagID)
            If m_objSubTabAccess.Delete = True Then
                strSQL = "exec USP_NG2_DEL_Group_Email " & DepartmentGroupID & ""
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If

        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCustomerMapping(ByVal DeptCustMappingID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteCustomerMapping
        ' Parameters Passed		:	DeptCustMappingID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Customer Mapping
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0

        Try
            GetSubTabAccessRights(3376, TagID)
            If m_objSubTabAccess.Delete = True Then
                strSQL = "exec USP_NG2_DEL_Customer_Mapping " & DeptCustMappingID & ""
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteConfiguredHRM(ByVal FunctionCRMID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteConfiguredHRM
        ' Parameters Passed		:	FunctionCRMID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Configured HRM
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0

        Try
            GetSubTabAccessRights(118, TagID)
            If m_objSubTabAccess.Delete = True Then
                strSQL = "EXEC USP_NG2_DEL_Configured_HRMs " & FunctionCRMID & ""
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    ''Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteProjectMapping(ByVal FunctionProjectID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteConfiguredHRM
        ' Parameters Passed		:	FunctionCRMID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Configured HRM
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================

        Dim strSQL As String = ""

        Dim strResult As String = ""

        Try
            GetSubTabAccessRights(120, TagID)
            If m_objSubTabAccess.Delete = True Then
                strSQL = "EXEC USP_NG2_DEL_Project_Mapping " & FunctionProjectID & ""
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If
            strResult = "Success"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    ''End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteRequestTypeMapping(ByVal DepartmentID As String, ByVal RequestTypeID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteRequestTypeMapping
        ' Parameters Passed		:	DepartmentID, RequestTypeID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete existing entries from tbl_CRM_Function_RequestTypes for that Department
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0
        Try
            'GetCurrentTagAccessRights(3746)
            'If m_objCurrentTagAccess.Delete = True Then
            If RequestTypeID = "" Or RequestTypeID Is Nothing Then
                strSQL = "EXEC usp_Del_tbl_CRM_Function_RequestTypes_Mapping " & DepartmentID & ", NULL"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Else
                strSQL = "EXEC usp_Del_tbl_CRM_Function_RequestTypes_Mapping " & DepartmentID & "," & RequestTypeID & ""
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If
            'End If
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetSubTabAccessRights(ByVal SubtagID As Integer, ByVal TagID As String)
        '=====================================================================
        ' Procedure Name        :	GetSubTabAccessRights
        ' Purpose               :	Get the Access Details for the Sub Tag 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	4-NOV-2017
        ' Revisions             :
        '=====================================================================
        Try
            m_objSubTabAccess = New WebPage.Templates.AccessRights
            Dim objGlobal As New WebPage.Templates.WhizGlobal(HttpContext.Current.Session("strUserName"), SubtagID, m_intRoleID, HttpContext.Current.Session("intUserID"), strLoginType, False, TagID)
            m_objSubTabAccess.GetAccess(objGlobal)

            'GetSubTabAccessRights(3365, RequestTypeTagID)

            'If m_objSubTabAccess.View Then
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    <System.Web.Services.WebMethod>
    Public Shared Function GetDepartmentDetails(ByVal DepartmentID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetDepartmentDetails
        ' Parameters Passed		:	DepartmentID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Get Department Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   25 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            'Dim objSetting As New CRM_RequestSetting()
            Dim AddAccess As String = ""
            Dim EditAccess As String = ""
            Dim DeleteAccess As String = ""
            Dim ViewAccess As String = ""
            Dim insertSuccess As Integer = 0

            'AddAccess = m_objAccess.Add
            'EditAccess = m_objAccess.Edit
            'DeleteAccess = m_objAccess.Delete
            'ViewAccess = m_objAccess.View

            'If ViewAccess = "True" Then


            Dim strResult As String = ""
            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))
            Dim drGetRole As IDataReader
            drGetRole = CommonFunction.Data.GetDataReader("EXEC USP_NG2_SEL_tbl_PM_DepartmentMaster_Details " & DepartmentID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetRole.Read Then
                If Not IsDBNull(drGetRole(0)) Then
                    strResult = strResult + CType(drGetRole(0), String)
                Else
                    strResult = strResult + ""
                End If
                If Not IsDBNull(drGetRole(1)) Then
                    strResult = strResult + "," + CType(drGetRole(1), String)
                Else
                    strResult = strResult + "," + ""
                End If
                If Not IsDBNull(drGetRole(2)) Then
                    strResult = strResult + "," + CType(drGetRole(2), String)
                Else
                    strResult = strResult + "," + ""
                End If
                If Not IsDBNull(drGetRole(3)) Then
                    strResult = strResult + "," + CType(drGetRole(3), String)
                Else
                    strResult = strResult + "," + ""
                End If
                If Not IsDBNull(drGetRole(4)) Then
                    strResult = strResult + "," + CType(drGetRole(4), String)
                Else
                    strResult = strResult + "," + ""
                End If
                If Not IsDBNull(drGetRole(5)) Then
                    strResult = strResult + "," + CType(drGetRole(5), String)
                Else
                    strResult = strResult + "," + ""
                End If
                If Not IsDBNull(drGetRole(6)) Then
                    strResult = strResult + "," + CType(drGetRole(6), String)
                Else
                    strResult = strResult + "," + ""
                End If
                If Not IsDBNull(drGetRole(7)) Then
                    strResult = strResult + "," + CType(drGetRole(7), String)
                Else
                    strResult = strResult + "," + ""
                End If
                If Not IsDBNull(drGetRole(8)) Then
                    'Commented and Added by Usha Pandit on 17.05.2019 for getting correcte result of IsSupportDepartment Check
                    'strResult = strResult + "," + CType(drGetRole(7), String)
                    strResult = strResult + "," + CType(drGetRole(8), String)
                    'End of Added by Usha Pandit on 17.05.2019 for getting correcte result of IsSupportDepartment Check
                Else
                    strResult = strResult + "," + ""
                End If
            End If

            CommonFunction.Data.DisposeDataReader(drGetRole)

            Return strResult
            'End If

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveDepartment(ByVal DepartmentID As String, ByVal Department As String, ByVal DepartmentHeadID As String, ByVal DepartmentCode As String, ByVal ExposeToCustomer As String, ByVal ExposeToProductExecution As String, ByVal IsShowToCustomer As String, ByVal IsSpportDepartment As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveDepartment
        ' Parameters Passed		:	DepartmentID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Department Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   25 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If DepartmentHeadID = "" Then
                DepartmentHeadID = "NULL"
            End If
            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

            'drGetRole = CommonFunction.Data.GetDataReader("EXEC USP_NG2_UPD_tbl_PM_DepartmentMaster_Details " & DepartmentID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) HttpContext.Current.Session("strUserName")
            Dim strSQL As String = "exec USP_NG2_INS_UPD_tbl_PM_DepartmentMaster_Details  " & DepartmentID & ", '" & Department & "'," & DepartmentHeadID & ",'" & DepartmentCode & "'," & ExposeToCustomer & "," & ExposeToProductExecution & "," & IsShowToCustomer & ",'" & HttpContext.Current.Session("strUserName") & "'" & "," & IsSpportDepartment & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)


            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function SaveMappedRole(ByVal DepartmentID As String, ByVal RoleID As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveMappedRole
        ' Parameters Passed		:	DepartmentID, RoleID, IsDefaultRole
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Mapped Role Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   28 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If
            If RoleID = "" Or RoleID Is Nothing Then
                RoleID = "0"
            End If

            Dim strSQL As String = "EXEC usp_Ins_tbl_CRM_Function_Roles  " & DepartmentID & ", " & RoleID
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    ''Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    <System.Web.Services.WebMethod>
    Public Shared Function SaveProjectMapping(ByVal DepartmentID As String, ByVal ProjectID As String, ByVal IsDefaultProject As String, ByVal FunctionProjectID As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveProjectMapping
        ' Parameters Passed		:	DepartmentID, ProjectID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Project Department Mapping
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   20 May 2019
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            Dim strSQL As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If
            If IsDefaultProject = "" Or IsDefaultProject Is Nothing Then
                IsDefaultProject = "0"
            End If

            If FunctionProjectID = "" Or FunctionProjectID = "0" Then
                strSQL = "EXEC USP_NG2_INS_UPD_Project_Mapping  " & DepartmentID & ", " & ProjectID & ", " & IsDefaultProject
            Else
                strSQL = "EXEC USP_NG2_INS_UPD_Project_Mapping  " & DepartmentID & ", " & ProjectID & ", " & IsDefaultProject & ", " & FunctionProjectID
            End If


            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    ''End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveGroupEmail(ByVal DepartmentID As String, ByVal GroupName As String, ByVal Email As String, ByVal Description As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveGroupEmail
        ' Parameters Passed		:	DepartmentID, GroupName, Email, Description
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Group Emails
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If

            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

            'drGetRole = CommonFunction.Data.GetDataReader("EXEC USP_NG2_UPD_tbl_PM_DepartmentMaster_Details " & DepartmentID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) HttpContext.Current.Session("strUserName")
            Dim strSQL As String = "EXEC USP_NG2_INS_Group_Email  " & DepartmentID & ", '" & GroupName & "', '" & Email & "', '" & Description & "'"

            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SaveWorkingHours(ByVal DepartmentID As String, ByVal IsWorking As String, ByVal FromTime As String, ByVal ToTime As String, ByVal UniqueID As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveWorkingHours
        ' Parameters Passed		:	DepartmentID, IsWorking, FromTime, ToTime, UniqueID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Mapped Working Hours
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If
            If IsWorking = "" Or IsWorking Is Nothing Then
                IsWorking = "0"
            End If
            If UniqueID = "" Or UniqueID Is Nothing Then
                UniqueID = "0"
            End If
            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

            'drGetRole = CommonFunction.Data.GetDataReader("EXEC USP_NG2_UPD_tbl_PM_DepartmentMaster_Details " & DepartmentID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) HttpContext.Current.Session("strUserName")
            Dim strSQL As String = "EXEC USP_NG2_UPD_Working_Hours  " & DepartmentID & ", " & IsWorking & ", '" & FromTime & "', '" & ToTime & "', " & UniqueID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)


            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveCustomerMapping(ByVal DepartmentID As String, ByVal CustomerID As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveCustomerMapping
        ' Parameters Passed		:	DepartmentID, GroupName, Email, Description
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Customer Mapping
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If

            If CustomerID = "" Or CustomerID Is Nothing Then
                CustomerID = "0"
            End If

            Dim strSQL As String = "EXEC USP_NG2_INS_Customer_Mapping  " & DepartmentID & ", " & CustomerID & ""

            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveRequestApproval(ByVal DepartmentID As String, ByVal RequestTypeID As String, ByVal SubRequestTypeID As String, ByVal IsApprovalRequired As String, ByVal GroupName As String, ByVal GroupEmail As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveRequestApproval
        ' Parameters Passed		:	DepartmentID, RequestTypeID, SubRequestTypeID, IsApprovalRequired
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Request Approval
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim strSQL As String = ""
            Dim strResult As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If

            If RequestTypeID = "" Or RequestTypeID Is Nothing Then
                RequestTypeID = "0"
            End If

            If SubRequestTypeID = "" Or SubRequestTypeID Is Nothing Then
                SubRequestTypeID = "0"
            End If

            If IsApprovalRequired = "" Or IsApprovalRequired Is Nothing Then
                IsApprovalRequired = "0"
            End If
            If IsApprovalRequired = "0" Then
                IsApprovalRequired = "NULL"
            End If

            If GroupName Is Nothing Or GroupEmail Is Nothing Or GroupName = "null" Or GroupEmail = "null" Then
                strSQL = "EXEC usp_Ins_tbl_CRM_Function_RequestTypes_Mapping  " & DepartmentID & ", " & RequestTypeID & ", " & SubRequestTypeID & ", NULL, NULL, " & IsApprovalRequired & ""
            Else
                strSQL = "EXEC usp_Ins_tbl_CRM_Function_RequestTypes_Mapping  " & DepartmentID & ", " & RequestTypeID & ", " & SubRequestTypeID & ", '" & GroupName & "', '" & GroupEmail & "', " & IsApprovalRequired & ""

            End If


            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveRequestTypeMapping(ByVal DepartmentID As String, ByVal FunctionRequestTypeID As String, ByVal GroupName As String, ByVal GroupEmail As String, ByVal IsApprovalRequired As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveRequestTypeMapping
        ' Parameters Passed		:	DepartmentID, FunctionRequestTypeID, GroupName, GroupEmail, IsApprovalRequired
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Request Approval
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   01 DEC 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim strSQL As String = ""
            Dim strResult As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If

            If FunctionRequestTypeID = "" Or FunctionRequestTypeID Is Nothing Then
                FunctionRequestTypeID = "0"
            End If



            If IsApprovalRequired = "" Or IsApprovalRequired Is Nothing Then
                IsApprovalRequired = "0"
            End If
            If IsApprovalRequired = "0" Then
                IsApprovalRequired = "NULL"
            End If

            If GroupName Is Nothing Or GroupEmail Is Nothing Or GroupName = "null" Or GroupEmail = "null" Then
                strSQL = "EXEC USP_NG2_UPD_Request_Mapping  " & FunctionRequestTypeID & "," & DepartmentID & ", NULL, NULL, " & IsApprovalRequired & ""
            Else
                strSQL = "EXEC USP_NG2_UPD_Request_Mapping  " & FunctionRequestTypeID & ", " & DepartmentID & ", '" & GroupName & "', '" & GroupEmail & "', " & IsApprovalRequired & ""

            End If


            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveConfiguredHRM(ByVal DepartmentID As String, ByVal EmployeeID As String, ByVal SendMail As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveConfiguredHRM
        ' Parameters Passed		:	DepartmentID, HRMID, SendMail
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save New Configured HRM
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If
            If EmployeeID = "" Or EmployeeID Is Nothing Then
                EmployeeID = "0"
            End If
            If SendMail = "" Or SendMail Is Nothing Then
                SendMail = "0"
            End If
            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

            'drGetRole = CommonFunction.Data.GetDataReader("EXEC USP_NG2_UPD_tbl_PM_DepartmentMaster_Details " & DepartmentID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) HttpContext.Current.Session("strUserName")
            Dim strSQL As String = "EXEC USP_NG2_INS_Configured_HRMs  " & EmployeeID & ", " & DepartmentID & ", " & SendMail
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function UpdateMappedRole(ByVal FunctionRoleID As String, ByVal RoleID As String) As String
        '=====================================================================
        ' Procedure  Name		:	UpdateMappedRole
        ' Parameters Passed		:	DepartmentID, RoleID, IsDefaultProject
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update Mapped Role Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If FunctionRoleID = "" Or FunctionRoleID Is Nothing Then
                FunctionRoleID = "0"
            End If
            If RoleID = "" Or RoleID Is Nothing Then
                RoleID = "0"
            End If

            Dim strSQL As String = "EXEC USP_NG2_UPD_Mapped_Roles  " & FunctionRoleID & ", " & RoleID
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)


            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function UpdateGroupEmail(ByVal DepartmentGroupID As String, ByVal GroupName As String, ByVal Email As String, ByVal Description As String) As String
        '=====================================================================
        ' Procedure  Name		:	UpdateGroupEmail
        ' Parameters Passed		:	DepartmentGroupID, GroupName, Email, Description
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update Group Emails
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If DepartmentGroupID = "" Or DepartmentGroupID Is Nothing Then
                DepartmentGroupID = "0"
            End If

            Dim strSQL As String = "EXEC USP_NG2_UPD_Group_Email  " & DepartmentGroupID & ", '" & GroupName & "', '" & Email & "', '" & Description & "'"
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function UpdateCustomerMapping(ByVal DepartmentID As String, ByVal CustomerID As String, ByVal DeptCustMappingID As String) As String
        '=====================================================================
        ' Procedure  Name		:	UpdateCustomerMapping
        ' Parameters Passed		:	DepartmentGroupID, GroupName, Email, Description
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update Customer Mapping
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If

            If CustomerID = "" Or CustomerID Is Nothing Then
                CustomerID = "0"
            End If

            If DeptCustMappingID = "" Or DeptCustMappingID Is Nothing Then
                DeptCustMappingID = "0"
            End If

            Dim strSQL As String = "EXEC USP_NG2_UPD_Customer_Mapping  " & DeptCustMappingID & ", " & CustomerID & ", " & DepartmentID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function UpdateConfiguredHRM(ByVal FunctionCRMID As String, ByVal SendMail As String) As String
        '=====================================================================
        ' Procedure  Name		:	UpdateConfiguredHRM
        ' Parameters Passed		:	FunctionCRMID, SendMail
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Update Configured HRM Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            If FunctionCRMID = "" Or FunctionCRMID Is Nothing Then
                FunctionCRMID = "0"
            End If
            If SendMail = "" Or SendMail Is Nothing Then
                SendMail = "0"
            End If

            Dim strSQL As String = "EXEC USP_NG2_UPD_Configured_HRMs  " & FunctionCRMID & ", " & SendMail & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function DeleteDepartmentDetails(ByVal DepartmentID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteDepartmentDetails
        ' Parameters Passed		:	DepartmentID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Department Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   25 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_RequestSetting()
            Dim strResult As String = ""
            Dim strSQL As String = "exec usp_Del_tbl_PM_DepartmentMaster  " & DepartmentID & ", '" & strResult & "'"
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetGridData(ByVal GridParam As Object, ByVal Id As Integer) As String
        '=====================================================================
        ' Procedure  Name		:	GetGridData
        ' Parameters Passed		:	GridParam
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Get Department Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   25 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_DepartmentMaster

            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))
            strGridHTML.Append(objSetting.WriteHelpdeskMasterGrid(GridParam("cityName"), Id))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetGridDataWithRequestType(ByVal GridParam As Object, ByVal Id As Integer, ByVal RequestType As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetGridDataWithRequestType
        ' Parameters Passed		:	GridParam
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Get Department Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   25 Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_DepartmentMaster

            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))
            Dim strDepartmentAndRequest As String = Id & "|" & RequestType
            strGridHTML.Append(objSetting.WriteHelpdeskMasterGrid(GridParam("cityName"), strDepartmentAndRequest))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function CheckDepartmentInUse(ByVal DepartmentID As String) As String
        '=====================================================================
        ' Procedure  Name		:	CheckDepartmentInUse
        ' Parameters Passed		:	DepartmentID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Check if department is in use
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   06 Dec 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            If DepartmentID = "" Then
                DepartmentID = "NULL"
            End If
            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

            'drGetRole = CommonFunction.Data.GetDataReader("EXEC USP_NG2_UPD_tbl_PM_DepartmentMaster_Details " & DepartmentID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) HttpContext.Current.Session("strUserName")
            Dim strSQL As String = "exec usp_NG2_Chk_Department_In_Use  " & DepartmentID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)


            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    Private Function WriteHelpdeskMasterGrid(ByVal strWhichGrid As String, ByVal RequestTypeID As String) As String
        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        str_RequestTypeID = RequestTypeID

        If strWhichGrid = "Department" Then

            intNoOfDataColumn = 6
            strDivID = "divDepartment"
            strSQLQuery = "USP_NG2_SEL_tbl_PM_DepartmentMaster_Records"

            arrstrActualList = {"DepartmentCode", "Department", "ExposeToCustomer", "Edit", "Select", "Delete"}
            arrstrUserFriendlyList = {"Short Name", "Department", "Expose To Customer", "Edit", "Select", "Delete"}
            arrstrLinkArray = {"", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=center", "align=left", "align=left", "align=left"}

            objGrid = m_objDepartmentGrid
        End If

        If strWhichGrid = "ConfigureHRM" Then

            intNoOfDataColumn = 4
            strDivID = "divConfigureHRM"
            strSQLQuery = "USP_NG2_SEL_Configured_HRMs " & RequestTypeID

            arrstrActualList = {"UserName", "SendMail", "Edit", "Delete"}
            arrstrUserFriendlyList = {"Resource", "Send Mail", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=center", "align=left"}

            objGrid = m_objConfigureHRMGrid
        End If

        If strWhichGrid = "RoleMapping" Then

            intNoOfDataColumn = 1
            strDivID = "divRoleMapping"
            strSQLQuery = "USP_NG2_SEL_Mapped_Roles " & RequestTypeID

            arrstrActualList = {"RoleDescription", "Delete"}
            arrstrUserFriendlyList = {"Role", "Delete"}
            arrstrLinkArray = {"", ""}
            arrCheckBoxArray = {"", ""}
            arrWidthArray = {"align=left", "align=center"}

            objGrid = m_objRoleMappingGrid
        End If

        ''Added by Usha Pandit on 20.05.2019 for Project Mapping sub tab display under Department Master
        If strWhichGrid = "ProjectMapping" Then

            intNoOfDataColumn = 4
            strDivID = "divProjectMapping"
            strSQLQuery = "USP_NG2_SEL_Project_Mapping " & RequestTypeID

            arrstrActualList = {"ProjectName", "IsDefaultProject", "Edit", "Delete"}
            arrstrUserFriendlyList = {"Project Name", "Default", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=center", "align=center"}

            objGrid = m_objProjectMappingGrid
        End If
        ''End of Added by Usha Pandit on 20.05.2019 for Project Mapping sub tab display under Department Master

        If strWhichGrid = "GroupEmail" Then

            intNoOfDataColumn = 4
            strDivID = "divGroupEmail"
            strSQLQuery = "USP_NG2_SEL_Group_Email " & RequestTypeID

            arrstrActualList = {"GroupName", "EmailAlias", "Edit", "Delete"}
            arrstrUserFriendlyList = {"Group Name", "Email", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=center", "align=center"}

            objGrid = m_objGroupEmailGrid
        End If

        If strWhichGrid = "CustomerMapping" Then

            intNoOfDataColumn = 3
            strDivID = "divCustomerMapping"
            strSQLQuery = "USP_NG2_SEL_Customer_Mapping " & RequestTypeID

            arrstrActualList = {"CustomerName", "Edit", "Delete"}
            arrstrUserFriendlyList = {"Customer Name", "Edit", "Delete"}
            arrstrLinkArray = {"", "", ""}
            arrCheckBoxArray = {"", "", ""}
            arrWidthArray = {"align=left", "align=center", "align=center"}

            objGrid = m_objCustomerMappingGrid
        End If

        If strWhichGrid = "RequestTypeMapping" Then


            intNoOfDataColumn = 6
            strDivID = "divRequestTypeMapping"

            If RequestTypeID.Contains("|") Then
                Dim strDeptAndRequest As String() = RequestTypeID.Split("|")

                strSQLQuery = "USP_NG2_SEL_RequestType_Department_Mapping " & strDeptAndRequest(0) & "," & strDeptAndRequest(1)
            Else
                strSQLQuery = "USP_NG2_SEL_Request_Mapping " & RequestTypeID
            End If


            arrstrActualList = {"RequestType", "SubRequestType", "GroupEmail", "ReportingToApproval", "Select", "Edit"}
            arrstrUserFriendlyList = {"Request Type", "Sub Request Type", "Group Email", "Approval Required", "Select", "Edit"}
            arrstrLinkArray = {"", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center"}

            objGrid = m_objRequestTypeGrid
        End If

        If strWhichGrid = "WorkingHours" Then

            intNoOfDataColumn = 5
            strDivID = "divWorkingHours"
            strSQLQuery = "USP_NG2_SEL_Working_Hours " & RequestTypeID

            arrstrActualList = {"WeekDay", "IsWorking", "FromTime", "ToTime", "Edit"}
            arrstrUserFriendlyList = {"Week Days", "Working Day", "From Time", "To Time", "Edit"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=center"}



            objGrid = m_objWorkingHoursGrid
        End If
        '/*Changed By Yasmin on 25th july 2018*/

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            '.ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = strDivID
            .SQL = strSQLQuery
            '.ColNameToolTipOnEachRow = True
            .UseSQL = True
            '.ClientSideSortFunctionName = "Sort_OnClickwe_For_CRM"
            '.SortBy = strSortBy
            '.SortOrder = strSortOrder
            ' .CurrentPage = m_intPageNumber
            ' .PageSize = m_intNoOfRecordInGrid
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With

        'intRecordCount = m_objGridAttachment.NoOfRows

        objGrid = Nothing

        Return strGridHTML.ToString
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetDepartmentHead(ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	Default_GetDepartmentHead
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get DepartmentHead
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   25 NOV 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_Sel_tbl_PM_DepartmentMaster_DepartmentHeads " & DepartmentID

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetCustomers(ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	Default_GetCustomers
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Customers
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 NOV 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_Sel_tbl_PM_Customer "

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetDepartmentResource(ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	Default_GetDepartmentResource
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Department Specific Resources
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 NOV 2017
        '=====================================================================.
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "USP_NG2_SEL_Configured_Department_Resource " & DepartmentID

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetRequestMapDepartment(ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	Default_GetRequestMapDepartment
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Map Departments
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   28 NOV 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            'strSQL = "usp_sel_tbl_PM_DepartmentMaster_DepartmentID "
            strSQL = "USP_NG2_SEL_tbl_PM_DepartmentMaster_Departments "

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetRequestMapRequestType(ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	Default_GetRequestMapRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Map Request Types
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   28 NOV 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            'strSQL = "usp_Sel_tbl_CRM_RequestType_RequestTypeID "
            strSQL = "USP_NG2_SEL_tbl_CRM_RequestType_RequestTypeID "
            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetRoles(ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	Default_GetRoles
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Roles for selected Department
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   28 NOV 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_Sel_tbl_PM_Role_For_Department " & DepartmentID

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    ''Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetProjects(ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	Default_GetProjects
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Projects for selected Department
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   20 May 2019
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtProjects As DataTable
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_Sel_tbl_PM_Project_PopulateCombo " & DepartmentID

            dtProjects = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtProjects)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue

    ''Added by Usha Pandit on 22.05.2019 for History ModifiedBy drop down refresh issue
    <System.Web.Services.WebMethod()>
    Public Shared Function Default_GetModifiedBy()
        '=====================================================================
        ' Procedure  Name		:	Default_GetModifiedBy
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Modified By Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   22 May 2019
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtModifiedBy As DataTable
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter " & TagID

            dtModifiedBy = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtModifiedBy)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)

            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function
    ''End of Added by Usha Pandit on 22.05.2019 for History ModifiedBy drop down refresh issue
    <System.Web.Services.WebMethod()>
    Public Shared Function ExposeToCustomer(ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	ExposeToCustomer
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Check ExposeToCustomer
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 NOV 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""


            Dim strScript As String()


            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))
            Dim drGetRole As IDataReader
            drGetRole = CommonFunction.Data.GetDataReader("EXEC usp_NG2_Chk_Expose_To_Customer " & DepartmentID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetRole.Read Then
                If Not IsDBNull(drGetRole(0)) Then
                    strResult = CType(drGetRole(0), String)
                Else
                    strResult = ""
                End If
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    '<System.Web.Services.WebMethod()>
    'Public Shared Function GetRequestTypeMapping(ByVal DepartmentID As String)
    '    '=====================================================================
    '    ' Procedure  Name		:	GetRequestTypeMapping
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To Get Request Type Mapping
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Usha Pandit
    '    ' Created				:   28 NOV 2017
    '    '=====================================================================
    '    Dim strResult As String = ""
    '    Dim strSQL As String = ""
    '    Dim dtDefectType As DataTable
    '    Dim strValidation As String = ""
    '    Dim strPlotHtml As String = ""
    '    Dim strHTML As New StringBuilder()
    '    Dim strScript As String()

    '    ' Dim m_strUserID As String

    '    strSQL = "USP_NG2_SEL_Request_Mapping " & DepartmentID

    '    dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

    '    strResult = GetSerialized(dtDefectType)

    '    strScript = strResult.Split("|")

    '    strHTML.Append(strScript(0) + vbCrLf)
    '    Return strResult & "|" & strHTML.ToString

    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetRequestTypeDepartmentMapping(ByVal DepartmentID As String, ByVal RequestTypeID As String)
        '=====================================================================
        ' Procedure  Name		:	GetRequestTypeDepartmentMapping
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Request Type Department Mapping
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 NOV 2017
        '=====================================================================
        Dim strResult As String = ""
        Dim strSQL As String = ""
        Dim dtDefectType As DataTable
        Dim strValidation As String = ""
        Dim strPlotHtml As String = ""
        Dim strHTML As New StringBuilder()
        Dim strScript As String()

        If DepartmentID = "" Or DepartmentID Is Nothing Then
            DepartmentID = "0"
        End If
        If RequestTypeID = "" Or RequestTypeID Is Nothing Then
            RequestTypeID = "0"
        End If

        strSQL = "USP_NG2_SEL_RequestType_Department_Mapping " & DepartmentID & ", " & RequestTypeID

        dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

        strResult = GetSerialized(dtDefectType)

        strScript = strResult.Split("|")

        strHTML.Append(strScript(0) + vbCrLf)
        Return strResult & "|" & strHTML.ToString

    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDuplicateDepartment(ByVal DepartmentCode As String, ByVal Department As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure  Name		:	CheckDuplicateDepartment
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Department
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   26 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            'If (DepartmentCode = "") Then
            '    DepartmentCode = "NULL"
            'End If
            'If (Department = "") Then
            '    Department = "NULL"
            'End If

            strSQL = "usp_NG2_Chk_tbl_PM_Department_Validation '" & DepartmentCode & "','" & Department & "','" & Flag & "'"
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDuplicateGroupEmail(ByVal DepartmentID As String, ByVal GroupName As String, ByVal Email As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure  Name		:	CheckDuplicateGroupEmail
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate GroupName and Email
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            'If (DepartmentCode = "") Then
            '    DepartmentCode = "NULL"
            'End If
            'If (Department = "") Then
            '    Department = "NULL"
            'End If

            strSQL = "usp_NG2_Chk_GroupEmail_Validation '" & GroupName & "','" & Email & "','" & Flag & "'," & DepartmentID
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDuplicateCustomer(ByVal DepartmentID As String, ByVal CustomerID As String) As String
        '=====================================================================
        ' Procedure  Name		:	CheckDuplicateCustomer
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Customer
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If
            If CustomerID = "" Or CustomerID Is Nothing Then
                CustomerID = "0"
            End If
            strSQL = "usp_NG2_Chk_Duplicate_Customer " & DepartmentID & "," & CustomerID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDuplicateRole(ByVal DepartmentID As String, ByVal RoleID As String) As String
        '=====================================================================
        ' Procedure  Name		:	CheckDuplicateRole
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Role
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   30 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If DepartmentID = "" Or DepartmentID Is Nothing Then
                DepartmentID = "0"
            End If
            If RoleID = "" Or RoleID Is Nothing Then
                RoleID = "0"
            End If
            strSQL = "usp_NG2_Chk_Duplicate_Role " & DepartmentID & "," & RoleID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Protected Function PlotHTML() As String
        '=====================================================================
        ' Procedure  Name		:	PlotHTML
        ' Parameters Passed		:	None
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To generate Department Tab Dynamically
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   25 Nov 2017
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        Dim AddAccess As String = ""
        Dim EditAccess As String = ""
        Dim DeleteAccess As String = ""
        Dim ViewAccess As String = ""
        Dim insertSuccess As Integer = 0
        Dim EnableProductExecution As String = ""

        Dim strSQL1 As String = "usp_Sel_EnableProductExecution "
        EnableProductExecution = CommonFunctions.Data.GetDataScalar(strSQL1, True)

        'AddAccess = m_objAccess.Add
        'EditAccess = m_objAccess.Edit
        'DeleteAccess = m_objAccess.Delete
        'ViewAccess = m_objAccess.View

        'strGridHTML.Append("<div id='divMainBlock' style='overflow:hidden;width:100%;'>")

        'strGridHTML.Append("<div id='Department' style='overflow:auto;width:103%;' class='tabcontent1 h-form h-type clsSettingstabs'>")

        'strGridHTML.Append("<div id='divMainBlock' style='overflow:hidden;width:100%;'>")

        'strGridHTML.Append("<div id='divSubMainBlock' style='overflow:auto;width:102%;'>")

        '/*change By Kashish for ui change*/
        strGridHTML.Append("<div id='divMainBlock' style='overflow:auto;width:100%;'>")
        'If m_objAccess.View = False Then

        strGridHTML.Append("<div id='Department' class='tabcontent1 h-form h-type clsSettingstabs'>")

        strGridHTML.Append("<div class='type-top-bar top-bar' id='divDatatableSearchButton'>")

        '/*Changed By Yasmin on 25th july 2018*/

        'strGridHTML.Append("<ul class='left'>")
        'strGridHTML.Append("<li class='left search-bar'>")
        'strGridHTML.Append("<i class='fa fa-search faSettingSearch' aria-hidden='true'></i>")
        ''strGridHTML.Append("<button class='search-bt'><i class='fa fa-search' aria-hidden='true'></i></button>")
        'strGridHTML.Append("<input type='text' id='SearchRequestDepartment' placeholder='Search in table'  title='Type here to search '>")
        'strGridHTML.Append("</li>")
        'strGridHTML.Append("</ul>")
        strGridHTML.Append("<ul class='left'>")
        strGridHTML.Append("<li class='search-bar'>")
        strGridHTML.Append("<div class='left search-bar'>")
        strGridHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        strGridHTML.Append("<input type='text' id='SearchRequestDepartment' placeholder='Search in table' >")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</li>")
        strGridHTML.Append("</ul>")


        strGridHTML.Append("<ul class='right'>")
        strGridHTML.Append("<li class='clearall'>")
        If m_objAccess.Add = True Then
            strGridHTML.Append("<button type='button' id='btnDepartment' onclick='Add_Department()' title='Add Department' class='btn btn-default' style='color:black!important;background-color:white!important'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
            'strGridHTML.Append("<a onclick='Add_Department()'>Add<i class='fa fa-plus' aria-hidden='true'></i></a></li>")
        End If
        strGridHTML.Append("<li class='clearall'>")
        If m_objAccess.Delete = True Then
            strGridHTML.Append("<button onclick='DeleteSelectedepartment()' type='button' class='btn btn-default' title='Delete Department' style='color:black!important;background-color:white!important'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
            'strGridHTML.Append("<a onclick='DeleteSelectedepartment()' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></a></li>")
        End If
        'strGridHTML.Append("<li class='clearall'>")
        'strGridHTML.Append("<button type='button' onclick='fnClearAll()' class='btn btn-default'>Clear All</button></li>")
        strGridHTML.Append("</ul>")

        strGridHTML.Append("</div>")

        strGridHTML.Append("<div id='divForDepartment'>")

        strGridHTML.Append("<div class='table-responsive' id='divtblDepartmen'>")
        strGridHTML.Append(WriteHelpdeskMasterGrid("Department", ""))
        strGridHTML.Append("</div>")

        strGridHTML.Append("</div>")

        'strGridHTML.Append("<div class='bottom-bar' style='height:260px;overflow:auto;'>")
        strGridHTML.Append("<div class='bottom-bar' style='height:100%;'>")



        strGridHTML.Append("<div class='pannel-section'>")
        strGridHTML.Append("<div class='col-md-12 col-sm-12'>")
        strGridHTML.Append("<div class='panel-group wrap' id='accordion6' role='tablist' aria-multiselectable='true'>")
        '/*Added By Kashish for ui change*/
        strGridHTML.Append("<div class=''>")
        'strGridHTML.Append("<div class='panel-heading' role='tab' id='headingOne6'>")
        'strGridHTML.Append("<h3><span>Department Master<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
        'strGridHTML.Append("<h4 class='panel-title'>")
        'strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion6' href='#collapseOne5' aria-expanded='true' aria-controls='collapseOne6'>")
        'strGridHTML.Append("<i class='fa fa-plus'></i>")
        'strGridHTML.Append("<i class='fa fa-minus'></i>")
        'strGridHTML.Append("</a>")
        'strGridHTML.Append("</h4>")
        'strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOne6' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne6'>")
        '/*Added By Kashish for ui change*/
        strGridHTML.Append("<div class=''>")
        'strGridHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        'strGridHTML.Append("<div class='form-group'>")



        ''Department Master Heading
        'strGridHTML.Append("<div class='panel-heading' role='tab' id='headingOne' style='margin-bottom:20px;'>")
        'strGridHTML.Append("<h3><span>Department Master<i class='fa fa-plus'  style='float: none;padding-left: 10px;'></i></span></h3>")
        'strGridHTML.Append("<h4 class='panel-title'>")
        'strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne5' aria-expanded='true' aria-controls='collapseOne'>")
        'strGridHTML.Append("<i class='fa fa-plus'></i>")
        'strGridHTML.Append("<i class='fa fa-minus'></i>")
        'strGridHTML.Append("</a>")
        'strGridHTML.Append("</h4>")
        'strGridHTML.Append("</div>")


        strGridHTML.Append("<div class='panel-group wrap' id='accDepMaster' role='tablist' aria-multiselectable='true'>")
        strGridHTML.Append("<div class='panel'>")
        '/*Added By Kashish for ui change*/
        strGridHTML.Append("<div class='panel-heading' role='tab' id='panelDepartmentAdd' style='display: grid;width: 100%;'>")
        strGridHTML.Append("<h3 style='font-size: 13px;'><span>Add New Department</span></h3>")
        strGridHTML.Append("<h4 class='panel-title'>")
        strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' onclick='ShowHidecollapseOneDept()' aria-expanded='true' aria-controls='collapseOne'>")
        strGridHTML.Append("<i  id='faplus'  title='Expand' class='fa fa-plus' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("<i id='faminus' title='Hide' class='fa fa-minus' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("</a>")
        strGridHTML.Append("</h4>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOneDept' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strGridHTML.Append("<div class='panel-body'  id='panelDepartment'>")
        ''Department Master Heading
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2 clsSubTagFont' for='request type'>Short Name *</label>")
        strGridHTML.Append("<div class='col-sm-4'>")

        'strGridHTML.Append("<input type='text' style='width: 100px;' class='form-control' id='txtDepartmentCode' name='requesttype'>")

        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDepartmentCode", "txtDepartmentCode", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Short Name'", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")
        strGridHTML.Append("<label class='control-label col-sm-3 clsSubTagFont' for='request type'>Expose to Customer</label>")
        strGridHTML.Append("<div class='col-sm-3'>")
        strGridHTML.Append("<input type='checkbox' style='width: 11px;' onclick='andExposeToCustomer()' id='chkExposeToCustomer'>")

        '<%-- <%=CommonFunctions.HTMLControls.DrawCheckBox("chkExposeToCustomer", "chkExposeToCustomer", "clsCheckbox", False, "", , "language=Javascript OnClick=chkShow_OnClick() ", True)%>--%>
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2 clsSubTagFont' for='request type'>Department *</label>")
        strGridHTML.Append("<div class='col-sm-4'>")

        'strGridHTML.Append("<input type='text' style='width: 219px;' class='form-control' id='txtDepartment' name='txtDepartment'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDepartment", "txtDepartment", "form-control", , , , , , , , , , "class = 'form-control' placeholder='Enter Department'", returnHTML:=True, EnableHTMLEncode:=True))
        strGridHTML.Append("</div>")

        If EnableProductExecution = "True" Then
            strGridHTML.Append("<label class='control-label col-sm-3 clsSubTagFont' for='request type'>Expose to Product Execution </label>")
            strGridHTML.Append("<div class='col-sm-3'>")
            strGridHTML.Append("<input type='checkbox' style='width: 11px;' id='chkExposeToProductExecution'>")
            strGridHTML.Append("</div>")
        Else
            'strGridHTML.Append("<div class='col-sm-3'>")
            'strGridHTML.Append("</div>")
        End If
       


        strGridHTML.Append("</div>")
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2 clsSubTagFont' id='lblDepartmentHead' for='request type'>Department Head</label>")
        strGridHTML.Append("<div class='col-sm-4'>")

        strGridHTML.Append("<select class='form-control' id='cboDepartmentHead' style='width: 200px;margin-top: -5px !important;'>")
        strGridHTML.Append("<option>Select Resource</option>")
        'strGridHTML.Append("<option>2</option>")
        'strGridHTML.Append("<option>3</option>")
        'strGridHTML.Append("<option>4</option>")
        strGridHTML.Append("</select>")

        'strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDepartmentHead", "usp_Sel_tbl_PM_DepartmentMaster_DepartmentHeads ", , , "class='form-control' ", True))
        strGridHTML.Append("</div>")
        strGridHTML.Append("<label class='control-label col-sm-3 clsSubTagFont' for='request type'>Allow to delete Discussion Thread</label>")
        strGridHTML.Append("<div class='col-sm-3'>")
        strGridHTML.Append("<input type='checkbox' style='width: 11px;' id='chkAllowToDelete'>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2 clsSubTagFont' id='lblDepartmentHead' for='request type'></label>")
        strGridHTML.Append("<div class='col-sm-4'>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<label class='control-label col-sm-3 clsSubTagFont' for='request type'>Is Support Department</label>")
        strGridHTML.Append("<div class='col-sm-3'>")
        strGridHTML.Append("<input type='checkbox' style='width: 11px;' id='chkIsSupportDepartment'>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("</div>")


        strGridHTML.Append("<div class='form-group'>")

        strGridHTML.Append("<div class='col-sm-12'>")
        strGridHTML.Append("<div class='left'>")
        'strGridHTML.Append("<button onclick='document.getElementById('id15').style.display=""block""' type='button' class='btn btn-default' style='background-color: #647ea8; color: #fff;'>Work Hours</button>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div class='right'>")
        'strGridHTML.Append("<button onclick='document.getElementById('id09').style.display=""block""' type='button' class='btn btn-default reply-btn' style='background-color: #343660; color: #fff;' title='Request Type Mapping'>Request Type Mapping</button>")
        'strGridHTML.Append("<button type='button' class=btn btn-default' style='background-color: #343660; color: #fff;'>Working Hours</button>")
        If m_objAccess.Edit = True And m_objAccess.Add = True Then
            strGridHTML.Append("<button type='button' id='btnSave' style='margin-left: 2px;font-size: 11px;line-height: 10px;' onclick='SaveDepartmentDetails(&quot;Save&quot;)' class='btn btn-default save'>Save</button>")

            strGridHTML.Append("<button type='button' id='btnSaveAndAdd' onclick='SaveDepartmentDetails(&quot;SaveAndAdd&quot;)' class='btn btn-default save' style='background-color: #343660; color: #fff;margin-left: 2px;font-size: 11px;line-height: 10px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='padding-left: 5px; padding-left: 5px;'></i></button>")
        End If
        strGridHTML.Append("<button type='button' id='btnShowHistory' style='display: none;margin-left: 2px;font-size: 11px;line-height: 10px;' onclick='ShowHistory()' class='btn btn-default save'>Show History</button>")
        strGridHTML.Append("<button type='button' class='btn btn-default save' onclick='minimizePanel(&quot;panelDepartment&quot;)' style='border:none;border-left:1px solid;font-size: 11px;line-height: 12px;margin-left: 0px;'>Cancel</button>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("</div>")
        'strGridHTML.Append("</form>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '<!-- end of panel -->
        strGridHTML.Append("</div>")
        '<!-- end of #accordion -->

        'strGridHTML.Append("</div>")
        '<!-- end of wrap -->
        'Else
        '    strGridHTML.Append("<div class='bottom-bar' style='height:100%;'>")
        '    strGridHTML.Append("No Access")
        '    strGridHTML.Append("</div>")
        'End If

        ''Horizontal Tabs

        strGridHTML.Append("<div class='clsHideHorizontalDiv col-sm-12' id='DivHorizontal'>")

        strGridHTML.Append("<div class='h-tabs'>")

        strGridHTML.Append("<div class='tab' id='divDepartmentTabs'>")
        strGridHTML.Append(GetTabs())
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        'end of h-tab
        strGridHTML.Append("<div id='ConfigureHRM' class='tabcontent4' style='display: block;'>")
        strGridHTML.Append("<div class='type-top-bar top-bar'>")

        GetSubTabAccessRights(118, TagID)
        If m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<ul class='right'>")
            strGridHTML.Append("<li class='clearall'>")
            strGridHTML.Append("<button type='button' onclick='AddConfigureHRM()' class='btn btn-default' style='color:black!important;background-color:white!important' title='Add HRM'>Add<i class='fa fa-plus' aria-hidden='true' style='position: relative;display: inline-block;left:0px;top:auto;color: #647ea8;padding-left: 5px;'></i></button></li>")
            'strGridHTML.Append("<a id='btnAddConfigureHRM' onclick='AddConfigureHRM()'>Add<i class='fa fa-plus' aria-hidden='true' style='display:block!important;'></i></a></li>")

            'strGridHTML.Append("<button type='button' id='btnDepartment' onclick='Add_Department()'  class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")

            strGridHTML.Append("</ul>")
        End If

        strGridHTML.Append("</div>")


        strGridHTML.Append("<div id='divForConfigureHRM'>")
        strGridHTML.Append("<div class='table-responsive'>")
        'strGridHTML.Append("<table class='table table-bordered table-stripped' id='tblConfigureHRM'>")
        'strGridHTML.Append("<thead class='clsSubTagFont'>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<th>Resource</th>")
        'strGridHTML.Append("<th>Send Mail</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Edit</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Delete</th>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</thead>")
        'strGridHTML.Append("<tbody>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<td>CR</td>")
        'strGridHTML.Append("<td>Yes</td>")
        'strGridHTML.Append("<td><button class='edit-bt'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("<td><button class='delet-btn'><i class='fa fa-trash-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</tbody>")
        'strGridHTML.Append("</table>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("</div>")


        strGridHTML.Append("<div class='pannel-section'>")
        strGridHTML.Append("<div class='col-md-12 col-sm-12'>")

        strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true' id='gridtab'>")
        strGridHTML.Append("<div class='panel' id='gridtab'>")
        strGridHTML.Append("<div class='panel-heading' role='tab' id='panelHRMAdd' style='width: 100%;'>")
        strGridHTML.Append("<h3 style='font-size: 13px;'><span>Add New HRM</span></h3>")
        strGridHTML.Append("<h4 class='panel-title'>")
        strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne11' aria-expanded='true' aria-controls='collapseOne'>")
        strGridHTML.Append("<i class='fa fa-plus' title='Expand' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("</a>")
        strGridHTML.Append("</h4>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOne11' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strGridHTML.Append("<div class='panel-body' id='panelHRM'>")
        'strGridHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Resource*</label>")
        strGridHTML.Append("<div class='col-sm-4'>")
        strGridHTML.Append("<select class='form-control' id='cboResource' style='width: 200px;margin-top: 0px!important;'>")
        strGridHTML.Append("<option>Admin</option>")
        strGridHTML.Append("<option>2</option>")
        strGridHTML.Append("<option>3</option>")
        strGridHTML.Append("<option>4</option>")
        strGridHTML.Append("</select>")
        strGridHTML.Append("</div>")

        'strGridHTML.Append("</div>")
        'strGridHTML.Append("<div class='form-group'>")
        '/*Added By Yasmin on 27th july 2018*/
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Send Mail</label>")
        strGridHTML.Append("<div class='col-sm-4'>")
        strGridHTML.Append("<input type='checkbox' style='width:12px;' id='chkSendEmail'>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<div class='right' style='margin-right: 15px;'>")
        GetSubTabAccessRights(118, TagID)
        If m_objSubTabAccess.Edit = True And m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<button class='btn btn-default save' id='btnSaveConfigureHRM' onclick='saveConfigureHRM(&quot;Save&quot;)' style='background-color:#343660;color:#fff;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save</button>")
            strGridHTML.Append("<button class='btn btn-default save'  id='btnSaveAndAddConfigureHRM' onclick='saveConfigureHRM(&quot;SaveAndAdd&quot;)'  style='background-color:#343660;color:#fff;border-left:1px solid;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='position: relative;display: inline-block;left:3px;top:auto;color:white;'></i></button>")
        End If
        strGridHTML.Append("<button type='button' class='btn btn-default save' onclick='minimizePanel(&quot;panelHRM&quot;)' style='border:none;border-left:1px solid;line-height: 12px;margin-left: 2pxfont-size: 11px;margin-left: 2px;'>Cancel</button>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        'strGridHTML.Append("</form>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '<!-- end of panel -->
        strGridHTML.Append("</div>")
        '<!-- end of #accordion -->

        strGridHTML.Append("</div>")
        '<!-- end of wrap -->

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div id='RoleMapping' class='tabcontent4' style='display: none;'>")
        strGridHTML.Append("<div class='type-top-bar top-bar'>")
        GetSubTabAccessRights(119, TagID)
        If m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<ul class='right'>")
            strGridHTML.Append("<li class='clearall'>")
            strGridHTML.Append("<button type='button' onclick='AddRoleMapping()' class='btn btn-default' style='color:black!important;background-color:white!important' title='Add Role'>Add<i class='fa fa-plus' aria-hidden='true' style='position: relative;display: inline-block; left: 0px; top: auto; color: #647ea8; padding-left: 5px;'></i></button></li>")

            'strGridHTML.Append("<a id='btnAddProjectMapping' onclick='AddProjectMapping()'>Add<i class='fa fa-plus' aria-hidden='true'></i></a></li>")

            strGridHTML.Append("</ul>")
        End If
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div id='divForRoleMapping'>")
        strGridHTML.Append("<div class='table-responsive'>")

        'strGridHTML.Append("<table class='table table-bordered table-stripped' id='tblProjectMapping'>")
        'strGridHTML.Append("<thead class='clsSubTagFont'>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<th>Project</th>")
        'strGridHTML.Append("<th>Default</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Edit</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Delete</th>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</thead>")
        'strGridHTML.Append("<tbody>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<td>Microlink:SAP Pvt Ltd.</td>")
        'strGridHTML.Append("<td>Yes</td>")
        'strGridHTML.Append("<td><button class='edit-bt'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("<td><button class='delet-btn'><i class='fa fa-trash-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</tbody>")
        'strGridHTML.Append("</table>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")


        strGridHTML.Append("<div class='pannel-section'>")
        strGridHTML.Append("<div class='col-md-12 col-sm-12'>")

        strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strGridHTML.Append("<div class='panel'>")
        'change by Yasmin S on 13/11/18
        strGridHTML.Append("<div class='panel-heading' role='tab' id='panelRoleAdd'>")
        strGridHTML.Append("<h3 style='font-size: 13px;width:20%;'><span>Map Role</span></h3>")
        strGridHTML.Append("<h4 class='panel-title'>")
        strGridHTML.Append("<a role='button' data-toggle='collapse' style='margin-top:-0.5%;' data-parent='#accordion' href='#collapseOne22' aria-expanded='true' aria-controls='collapseOne'>")
        strGridHTML.Append("<i class='fa fa-plus' title='Expand'></i>")
        strGridHTML.Append("<i class='fa fa-minus' title='Hide'></i>")
        strGridHTML.Append("</a>")
        strGridHTML.Append("</h4>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOne22' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strGridHTML.Append("<div class='panel-body' id='panelRole'>")


        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Role*</label>")
        strGridHTML.Append("<div class='col-sm-4'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRoles", "select 1", , , "class='form-control' ", False, True))
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<div class='right' style='margin-right: 15px;'>")
        GetSubTabAccessRights(119, TagID)
        If m_objSubTabAccess.Edit And m_objSubTabAccess.Add Then
            strGridHTML.Append("<button class='btn btn-default save' id='btnSaveMappedRole' onclick='saveMappedRole(&quot;Save&quot;)' style='background-color:#343660;color:#fff;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save</button>")
            strGridHTML.Append("<button  class='btn btn-default save' onclick='saveMappedRole(&quot;SaveAndAdd&quot;)' style='background-color:#343660;color:#fff;border-left:1px solid;margin-left: 5px;margin-right: 2px;line-height: 10px;font-size: 11px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        strGridHTML.Append(" <button class='btn btn-default save' onclick='minimizePanel(&quot;panelRole&quot;)' style='border:none;border-left:1px solid;line-height: 12px;font-size: 11px;margin-left: 0px;margin-right: 0px;'>Cancel</button>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        'strGridHTML.Append("</form>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '<!-- end of panel -->
        strGridHTML.Append("</div>")
        '<!-- end of #accordion -->

        strGridHTML.Append("</div>")
        '<!-- end of wrap -->

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div id='GroupEmail' class='tabcontent4' style='display: none;'>")
        strGridHTML.Append("<div class='type-top-bar top-bar'>")
        GetSubTabAccessRights(2121, TagID)
        If m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<ul class='right'>")
            strGridHTML.Append("<li class='clearall'>")

            strGridHTML.Append("<button type='button'  onclick='AddGroupEmail()' class='btn btn-default' style='color:black!important;background-color:white!important' title='Add Group Email'>Add<i class='fa fa-plus' aria-hidden='true' style='position: relative;display: inline-block;left: 0px;top: auto;color: #647ea8;padding-left: 5px;'></i></button></li>")
            'strGridHTML.Append("<a id = 'btnAddGroupEmail' onclick='AddGroupEmail()'>Add<i class='fa fa-plus' aria-hidden='true'></i></a></li>")

            strGridHTML.Append("</ul>")
        End If
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div id='divForGroupEmail'>")
        strGridHTML.Append("<div class='table-responsive'>")

        'strGridHTML.Append("<table class='table table-bordered table-stripped' id='tblGroupEmail'>")
        'strGridHTML.Append("<thead class='clsSubTagFont'>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<th>Group Name</th>")
        'strGridHTML.Append("<th>Email</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Edit</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Delete</th>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</thead>")
        'strGridHTML.Append("<tbody>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<td>")
        'strGridHTML.Append("<select class='form-control' id='sel1' style='width:280px;'>")
        'strGridHTML.Append("<option>Microlink:SAP Pvt Ltd.</option>")
        'strGridHTML.Append("<option>2</option>")
        'strGridHTML.Append("<option>3</option>")
        'strGridHTML.Append("<option>4</option>")
        'strGridHTML.Append("</select>")
        'strGridHTML.Append("</td>")
        'strGridHTML.Append("<td>Ramdil@hexaware.com</td>")
        'strGridHTML.Append("<td><button class='edit-bt'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("<td><button class='delet-btn'><i class='fa fa-trash-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</tbody>")
        'strGridHTML.Append("</table>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")


        strGridHTML.Append(" <div class='pannel-section'>")
        strGridHTML.Append("<div class='col-md-12 col-sm-12'>")

        strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strGridHTML.Append("<div class='panel'>")
        strGridHTML.Append("<div class='panel-heading' role='tab' id='panelGroupEmailAdd'>")
        strGridHTML.Append("<h3 style='font-size: 13px;'><span>Add New Group</span></h3>")
        strGridHTML.Append("<h4 class='panel-title'>")
        strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne33' aria-expanded='true' aria-controls='collapseOne'>")
        strGridHTML.Append("<i class='fa fa-plus' title='Expand' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("</a>")
        strGridHTML.Append("</h4>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOne33' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strGridHTML.Append("<div class='panel-body' id='panelGroupEmail'>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Group Name*</label>")
        strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append("<input type='text' style='width: 350px;' class='form-control' id='txtGroupName' name='requesttype'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtGroupName", "txtGroupName", "form-control", , , , , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Email*</label>")
        strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append("<input type='text' style='width: 350px;' class='form-control' id='txtEmail' name='requesttype'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEmail", "txtEmail", "form-control", , , , , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Description</label>")
        strGridHTML.Append("<div class='col-sm-10'>")

        strGridHTML.Append("<textarea style='width:400px;' class='form-control' rows='3' id='txtDescription'></textarea>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<div class='right' style='margin-right: 15px;'>")
        GetSubTabAccessRights(2121, TagID)
        If m_objSubTabAccess.Edit = True And m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<button class='btn btn-default save' id='btnSaveGroupEmail' onclick = 'saveGroupEmail(&quot;Save&quot;)' style='background-color:#343660;color:#fff;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save</button>")
            strGridHTML.Append("<button class='btn btn-default save'  id='btnSaveAndAddGroupEmail' onclick = 'saveGroupEmail(&quot;SaveAndAdd&quot;)' style='background-color:#343660;color:#fff;border-left:1px solid;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        strGridHTML.Append("<button type='button' class='btn btn-default save' onclick='minimizePanel(&quot;panelGroupEmail&quot;)' style='border:none;border-left:1px solid;line-height: 12px;font-size: 11px;margin-left: 0px;'>Cancel</button>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '<!-- end of panel -->
        strGridHTML.Append("</div>")
        '<!-- end of #accordion -->

        strGridHTML.Append("</div>")
        '<!-- end of wrap -->

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")


        ''Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
        strGridHTML.Append("<div id='ProjectMapping' class='tabcontent4' style='display: none;'>")
        strGridHTML.Append("<div class='type-top-bar top-bar'>")
        GetSubTabAccessRights(120, TagID)
        If m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<ul class='right'>")
            strGridHTML.Append("<li class='clearall'>")

            strGridHTML.Append("<button type='button'  onclick='AddProjectMapping()' class='btn btn-default' style='color:black!important;background-color:white!important' title='Add Group Email'>Add<i class='fa fa-plus' aria-hidden='true' style='position: relative;display: inline-block;left: 0px;top: auto;color: #647ea8;padding-left: 5px;'></i></button></li>")


            strGridHTML.Append("</ul>")
        End If
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div id='divForProjectMapping'>")
        strGridHTML.Append("<div class='table-responsive'>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append(" <div class='pannel-section'>")
        strGridHTML.Append("<div class='col-md-12 col-sm-12'>")

        strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strGridHTML.Append("<div class='panel'>")
        strGridHTML.Append("<div class='panel-heading' role='tab' id='panelProjectMappingAdd'>")
        strGridHTML.Append("<h3 style='font-size: 13px;'><span>Add New Project</span></h3>")
        strGridHTML.Append("<h4 class='panel-title'>")
        strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne33' aria-expanded='true' aria-controls='collapseOne'>")
        strGridHTML.Append("<i class='fa fa-plus' title='Expand' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("</a>")
        strGridHTML.Append("</h4>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOne33' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strGridHTML.Append("<div class='panel-body' id='panelProjectMapping'>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Project Name*</label>")
        strGridHTML.Append("<div class='col-sm-4'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjects", "select 1 ", , , "class='form-control' ", False, True))
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Is Default</label>")
        strGridHTML.Append("<div class='col-sm-4'>")
        strGridHTML.Append("<input type='checkbox' style='width:12px;' id='chkIsDefaultProject'>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        'strGridHTML.Append("<div class='form-group'>")
        'strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Email*</label>")
        'strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEmail", "txtEmail", "form-control", , , , , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))
        'strGridHTML.Append("</div>")
        'strGridHTML.Append("</div>")

        'strGridHTML.Append("<div class='form-group'>")
        'strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Description</label>")
        'strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append("<textarea style='width:400px;' class='form-control' rows='3' id='txtDescription'></textarea>")

        'strGridHTML.Append("</div>")
        'strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<div class='right' style='margin-right: 15px;'>")
        GetSubTabAccessRights(120, TagID)
        If m_objSubTabAccess.Edit = True And m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<button class='btn btn-default save' id='btnSaveProjectMapping' onclick = 'saveProjectMapping(&quot;Save&quot;)' style='background-color:#343660;color:#fff;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save</button>")
            strGridHTML.Append("<button class='btn btn-default save'  id='btnSaveAndAddProjectMapping' onclick = 'saveProjectMapping(&quot;SaveAndAdd&quot;)' style='background-color:#343660;color:#fff;border-left:1px solid;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        strGridHTML.Append("<button type='button' class='btn btn-default save' onclick='minimizePanel(&quot;panelProjectMapping&quot;)' style='border:none;border-left:1px solid;line-height: 12px;font-size: 11px;margin-left: 0px;'>Cancel</button>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '<!-- end of panel -->
        strGridHTML.Append("</div>")
        '<!-- end of #accordion -->

        strGridHTML.Append("</div>")
        '<!-- end of wrap -->

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        ''End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue


        strGridHTML.Append("<div id='CustomerMapping' class='tabcontent4  h-form h-type' style='display: none;'>")
        strGridHTML.Append("<div class='type-top-bar top-bar'>")
        GetSubTabAccessRights(3376, TagID)
        If m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<ul class='right'>")
            strGridHTML.Append("<li class='clearall'>")

            strGridHTML.Append("<button type='button' id='btnAddCustomerMapping' onclick='AddCustomerMapping()' class='btn btn-default' style='color:black!important;background-color:white!important'>Add<i class='fa fa-plus' style='position:relative' aria-hidden='true'></i></button></li>")
            'strGridHTML.Append("<a id='btnAddCustomerMapping' onclick='AddCustomerMapping()'>Add<i class='fa fa-plus' aria-hidden='true'></i></a></li>")

            strGridHTML.Append("</ul>")
        End If
        strGridHTML.Append("</div>")


        strGridHTML.Append("<div id='divForCustomerMapping'>")
        strGridHTML.Append("<div class='table-responsive'>")

        'strGridHTML.Append("<table class='table table-bordered table-stripped' id='tblCustomerMapping'>")
        'strGridHTML.Append("<thead class='clsSubTagFont'>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<th>Customer Name</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Edit</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Delete</th>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</thead>")
        'strGridHTML.Append("<tbody>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<td>Microlink:SAP Pvt Ltd.</td>")
        'strGridHTML.Append("<td><button class='edit-bt'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("<td><button class='delet-btn'><i class='fa fa-trash-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</tbody>")
        'strGridHTML.Append("</table>")


        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='pannel-section'>")
        strGridHTML.Append("<div class='col-md-12 col-sm-12'>")

        strGridHTML.Append("<div class='panel-group wrap clsPanelCustomerMapping' id='accordion' role='tablist' aria-multiselectable='true'>")
        strGridHTML.Append("<div class='panel'>")
        strGridHTML.Append("<div class='panel-heading' role='tab' id='panelCustomerMappingAdd' style=''>")
        strGridHTML.Append("<h3 style='font-size: 13px;'><span>Map Customer to Department</span></h3>")
        strGridHTML.Append("<h4 class='panel-title'>")
        strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne44' aria-expanded='true' aria-controls='collapseOne'>")
        strGridHTML.Append("<i class='fa fa-plus' title='Expand' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("</a>")
        strGridHTML.Append("</h4>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOne44' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strGridHTML.Append("<div class='panel-body' id='panelCustomerMapping'>")
        'strGridHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Customer Name*</label>")
        strGridHTML.Append("<div class='col-sm-4'>")
        strGridHTML.Append("<select class='form-control' id='cboCustomers' style='width:280px;margin-top: 0px!important;'>")
        strGridHTML.Append("<option>Admin</option>")
        strGridHTML.Append("<option>2</option>")
        strGridHTML.Append("<option>3</option>")
        strGridHTML.Append("<option>4</option>")
        strGridHTML.Append("</select>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<div class='right' style='margin-right: 15px;'>")
        GetSubTabAccessRights(3376, TagID)
        If m_objSubTabAccess.Edit = True And m_objSubTabAccess.Add = True Then
            strGridHTML.Append("<button class='btn btn-default save' id='btnSaveCustomerMap' onclick='saveCustomerMapping(&quot;Save&quot;)' style='background-color:#343660;color:#fff;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save</button>")
            strGridHTML.Append("<button class='btn btn-default save' id='btnSaveAndAddCustomerMap' onclick='saveCustomerMapping(&quot;SaveAndAdd&quot;)' style='background-color:#343660;color:#fff;border-left:1px solid;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        strGridHTML.Append("<button type='button' class='btn btn-default save' onclick='minimizePanel(&quot;panelCustomerMapping&quot;)' style='border:none;border-left:1px solid;line-height: 12px;font-size: 11px;margin-left: 2px;'>Cancel</button>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        'strGridHTML.Append("</form>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '<!-- end of panel -->
        strGridHTML.Append("</div>")
        '<!-- end of #accordion -->

        strGridHTML.Append("</div>")
        '<!-- end of wrap -->

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '/*Changed By Yasmin on 25th july 2018*/

        strGridHTML.Append("<div id='RequestTypeMapping' class='tabcontent4' style='display: none;'>")
        strGridHTML.Append("<div class='type-top-bar top-bar' style='border:none;'>")
        strGridHTML.Append("<ul style='display: inline-block;'>")
        strGridHTML.Append("<li class='left search-bar'>")
        strGridHTML.Append("<div class='left search-bar'><i class='fa fa-search faSettingSearch' style='color:black!important' aria-hidden='true'></i><input type='text' id='SearchRquestType' placeholder='Search in table'  style='margin-top:3px!important;'></div>")
        strGridHTML.Append("</li>")

        strGridHTML.Append("</ul>")
        strGridHTML.Append("<ul class='right'>")
        'strGridHTML.Append("<li>")
        'strGridHTML.Append("<select class='form-control' id='cboRequestMapDepartment' style='width:220px;'>")
        'strGridHTML.Append("<option>Department</option>")
        'strGridHTML.Append("<option>2</option>")
        'strGridHTML.Append("<option>3</option>")
        'strGridHTML.Append("<option>4</option>")
        'strGridHTML.Append("</select>")
        'strGridHTML.Append("</li>")
        strGridHTML.Append("<li class='right search-bar'>")
        strGridHTML.Append("<select class='form-control' id='cboRequestMapRequestType' style='width:220px;'>")
        strGridHTML.Append("<option>Request Type</option>")
        strGridHTML.Append("<option>2</option>")
        strGridHTML.Append("<option>3</option>")
        strGridHTML.Append("<option>4</option>")
        strGridHTML.Append("</select>")

        strGridHTML.Append("</li>")

        strGridHTML.Append("</ul>")
        strGridHTML.Append("</div>")


        strGridHTML.Append("<div id='divForRequestTypeMapping'>")
        strGridHTML.Append("<div id='tblRequestTypeMappingdiv' class='table-responsive' style = 'border-bottom: none;'>")

        'strGridHTML.Append("<table class='table table-bordered table-stripped' id='tblRequestTypeMapping'>")
        'strGridHTML.Append("<thead class='clsSubTagFont'>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<th>Request Type</th>")
        'strGridHTML.Append("<th>Sub Request Type</th>")
        'strGridHTML.Append("<th>Group Email</th>")
        'strGridHTML.Append("<th>Approval  Required</th>")
        'strGridHTML.Append("<th>Select</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Edit</th>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</thead>")
        'strGridHTML.Append("<tbody>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<td>Enable to view</td>")
        'strGridHTML.Append("<td>Download Reports</td>")
        'strGridHTML.Append("<td></td>")
        'strGridHTML.Append("<td><input type='checkbox' id='checkall'></td>")
        'strGridHTML.Append("<td><input type='checkbox' id='checkall'></td>")
        'strGridHTML.Append("<td><button class='edit-bt'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</tbody>")
        'strGridHTML.Append("</table>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<div class='right' style='margin-right: 14px;'>")
        strGridHTML.Append("<button type='button' onclick='saveRequestApproval()' style='margin-left: 2px;' class='btn btn-default save'>Save</button>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")


        strGridHTML.Append("<div class='pannel-section'>")
        strGridHTML.Append("<div class='col-md-12 col-sm-12'>")

        strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strGridHTML.Append(" <div class='panel'>")
        strGridHTML.Append("<div class='panel-heading' role='tab' id='panelRequestTypeAdd'>")
        strGridHTML.Append("<h3 style='font-size: 13px;'><span>Request Type Mapping</span></h3>")
        strGridHTML.Append("<h4 class='panel-title'>")
        strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne55' aria-expanded='true' aria-controls='collapseOne'>")
        strGridHTML.Append(" <i class='fa fa-plus' title='Expand'  style = 'line-height: 0px;'></i>")
        strGridHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("</a>")
        strGridHTML.Append("</h4>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOne55' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strGridHTML.Append("<div class='panel-body' id='panelRequestType'>")
        'strGridHTML.Append("<form class='form-horizontal' action='/action_page.php'>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Department</label>")
        strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append("<input type='text' style='width:445px;' disabled class='form-control' id='txtRequestTypeDepartment' name='requesttype'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestTypeDepartment", "txtRequestTypeDepartment", "form-control", , , , , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Request Type</label>")
        strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append("<input type='text' style='width:445px;' disabled class='form-control' id='txtRequestType' name='requesttype'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestType", "txtRequestType", "form-control", , , , , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Sub Request Type</label>")
        strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append("<input type='text' style='width:445px;' disabled class='form-control' rows='4' id='txtSubRequestType'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubRequestType", "txtSubRequestType", "form-control", , , , , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Group Name</label>")
        strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append("<input type='text' style='width:445px;' class='form-control' id='txtRequestTypeGroupName' name='requesttype'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestTypeGroupName", "txtRequestTypeGroupName", "form-control", , , , , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Group Email</label>")
        strGridHTML.Append("<div class='col-sm-10'>")

        'strGridHTML.Append("<input type='text' style='width:445px;' class='form-control' rows='4' id='txtRequestTypeGroupEmail'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestTypeGroupEmail", "txtRequestTypeGroupEmail", "form-control", , , , , , , , , , "class='form-control'", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Approval Required</label>")
        strGridHTML.Append("<div class='col-sm-10'>")
        strGridHTML.Append("<input type='checkbox' style='width: 11px;outline:none' id='chkApprovalRequired'>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        'strGridHTML.Append("<div class='form-group'>")
        'strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Group Name</label>")
        'strGridHTML.Append("<div class='col-sm-4'>")
        'strGridHTML.Append("<select class='form-control' id='sel1' style='width:280px;'>")
        'strGridHTML.Append("<option>Admin</option>")
        'strGridHTML.Append("<option>2</option>")
        'strGridHTML.Append("<option>3</option>")
        'strGridHTML.Append("<option>4</option>")
        'strGridHTML.Append("</select>")
        'strGridHTML.Append(" </div>")
        'strGridHTML.Append("</div>")
        'strGridHTML.Append("<div class='form-group'>")
        'strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Group Email</label>")
        'strGridHTML.Append("<div class='col-sm-4'>")
        'strGridHTML.Append("<select class='form-control' id='sel1' style='width:280px;'>")
        'strGridHTML.Append("<option>Admin</option>")
        'strGridHTML.Append("<option>2</option>")
        'strGridHTML.Append("<option>3</option>")
        'strGridHTML.Append("<option>4</option>")
        'strGridHTML.Append("</select>")
        'strGridHTML.Append("</div>")
        'strGridHTML.Append("</div>")
        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append(" <div class='right' style='margin-right: 15px;'>")
        'GetCurrentTagAccessRights(3746)
        'If m_objCurrentTagAccess.Edit = True Then
        strGridHTML.Append("<button class='btn btn-default save' id='btnSaveRequestTypeMapp' onclick='saveCurrentRequestTypeMapping()' style='background-color:#343660;color:#fff;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save</button>")

        strGridHTML.Append("<button type='button' class='btn btn-default save' onclick='minimizePanel(&quot;panelRequestType&quot;)' style='border:none;border-left:1px solid;line-height: 12px;line-height: 12px;font-size: 11px;margin-left: 2px;'>Cancel</button>")
        'End If
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        'strGridHTML.Append("</form>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '<!-- end of panel -->
        strGridHTML.Append("</div>")
        '<!-- end of #accordion -->

        strGridHTML.Append("</div>")
        '<!-- end of wrap -->

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div id='WorkingHours' class='tabcontent4' style='display: none;'>")
        'strGridHTML.Append("<div class='type-top-bar top-bar'>")
        'strGridHTML.Append("<ul class='right'>")
        'strGridHTML.Append("<li class='clearall'>")
        ''strGridHTML.Append("<button type='button' class='btn btn-default' onclick='addWorkingHours()' >Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        'strGridHTML.Append("</ul>")
        'strGridHTML.Append("</div>")

        strGridHTML.Append("<div id='divForWorkingHours'>")
        strGridHTML.Append("<div class='table-responsive'>")

        'strGridHTML.Append("<table class='table table-bordered table-stripped' id='tblWorkingHours'>")
        'strGridHTML.Append("<thead class='clsSubTagFont'>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<th>Week Days</th>")
        'strGridHTML.Append("<th>Working Days</th>")
        'strGridHTML.Append("<th>From Time</th>")
        'strGridHTML.Append("<th>To Time</th>")
        'strGridHTML.Append("<th class = 'clsEditCenterAlign'>Edit</th>")
        ''strGridHTML.Append("<th>Delete</th>")
        'strGridHTML.Append("</tr>")
        'strGridHTML.Append("</thead>")
        'strGridHTML.Append("<tbody>")
        'strGridHTML.Append("<tr>")
        'strGridHTML.Append("<td>1-Monday</td>")
        'strGridHTML.Append("<td><input type='checkbox' id='checkall'></td>")
        'strGridHTML.Append("<td>10:00 PM</td>")
        'strGridHTML.Append("<td>11:00 PM</td>")
        'strGridHTML.Append("<td><button class='edit-bt'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("<td><button class='delet-btn'><i class='fa fa-trash-o' aria-hidden='true'></i></button></td>")
        'strGridHTML.Append("</tr>	")
        'strGridHTML.Append("</tbody>")
        'strGridHTML.Append("</table>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")



        strGridHTML.Append("<div class='pannel-section'>")
        strGridHTML.Append("<div class='col-md-12 col-sm-12'>")

        strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strGridHTML.Append("<div class='panel'>")
        strGridHTML.Append("<div class='panel-heading' role='tab' id = 'panelWorkingHoursAdd' style='width: 1000px;'>")
        strGridHTML.Append("<h3 style='font-size: 13px;'><span>Department working hours</span></h3>")
        strGridHTML.Append("<h4 class='panel-title'>")
        strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne66' aria-expanded='true' aria-controls='collapseOne'>")
        strGridHTML.Append("<i class='fa fa-plus' title='Expand'style = 'line-height: 0px;'></i>")
        strGridHTML.Append("<i class='fa fa-minus' title='Hide' style = 'line-height: 0px;'></i>")
        strGridHTML.Append("</a>")
        strGridHTML.Append("</h4>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("<div id='collapseOne66' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strGridHTML.Append("<div class='panel-body' id = 'panelWorkingHours'>")
        'strGridHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        'strGridHTML.Append("<div class='form-group'>")
        'strGridHTML.Append("<label class='control-label col-sm-2' for='request type'>Week Day*</label>")
        'strGridHTML.Append("<div class='col-sm-4'>")
        'strGridHTML.Append("<select class='form-control' id='sel1' style='width:280px;'>")
        'strGridHTML.Append("<option>Admin</option>")
        'strGridHTML.Append("<option>2</option>")
        'strGridHTML.Append("<option>3</option>")
        'strGridHTML.Append("<option>4</option>")
        'strGridHTML.Append("</select>")
        'strGridHTML.Append("</div>")
        'strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group' style='margin-bottom: 0px;'>")
        strGridHTML.Append("<label class='control-label col-sm-2 topMargin'  for='request type'>Week Day*</label>")
        strGridHTML.Append("<div class='col-sm-4'>")

        'strGridHTML.Append("<input type='text' style='width: 50px;' class='form-control' id='txtWeekDay' name='txtWeekDay' disabled>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWeekDay", "txtWeekDay", "form-control", , , , , , , , , , "  class='form-control' ", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")

        strGridHTML.Append("<label class='control-label col-sm-2 topMargin' for='request type'>Is Working Day?</label>")
        strGridHTML.Append("<div class='col-sm-4'>")

        strGridHTML.Append("<input type='checkbox' style='width: 11px;outline:none; ' id='chkIsWorkingDay' onclick='checkWorkDay()'>")

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<label class='control-label col-sm-2 topMargin' for='request type'>From Time*</label>")
        strGridHTML.Append("<div class='col-sm-4'>")

        'strGridHTML.Append("<input type='text' style='width: 150px;' class='form-control' id='txtFromTime' name='txtFromTime'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFromTime", "txtFromTime", "form-control", , , , , , , , , , "  class='form-control' ", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")

        strGridHTML.Append("<label class='control-label col-sm-2 topMargin' for='request type'>To Time*</label>")
        strGridHTML.Append("<div class='col-sm-4'>")

        'strGridHTML.Append("<input type='text' style='width: 150px;' class='form-control' id='txtToTime' name='txtToTime'>")
        strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtToTime", "txtToTime", "form-control", , , , , , , , , , "  class='form-control' ", returnHTML:=True, EnableHTMLEncode:=True))

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")


        strGridHTML.Append("<div class='form-group'>")
        strGridHTML.Append("<div class='right' style='margin-right: 15px;'>	")
        'Commented and Added by Usha Pandit on 17.05.2019 for Save button display issue
        'GetCurrentTagAccessRights(3820)
        'If m_objCurrentTagAccess.Edit = True Then
        'strGridHTML.Append("<button id='btnSaveWorkHrs' onclick='saveWorkingHours(&quot;Save&quot;)' class='btn btn-default save' style='background-color:#343660;color:#fff;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save</button>")
        'End If
        strGridHTML.Append("<button id='btnSaveWorkHrs' onclick='saveWorkingHours(&quot;Save&quot;)' class='btn btn-default save' style='background-color:#343660;color:#fff;margin-left: 2px;line-height: 10px;font-size: 11px;'>Save</button>")
        'End of Added by Usha Pandit on 17.05.2019 for Save button display issue

        'strGridHTML.Append("<button id='btnSaveAndAddWorkHrs' class='btn btn-default' onclick='saveWorkingHours(&quot;SaveAndAdd&quot;)'  style='background-color:#343660;color:#fff;border-left:1px solid;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        strGridHTML.Append("<button type='button' class='btn btn-default save' onclick='minimizePanel(&quot;panelWorkingHours&quot;)' style='border:none;border-left:1px solid;line-height: 12px;font-size: 11px;margin-left: 2px;'>Cancel</button>")
        'strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        'strGridHTML.Append("</form>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        '<!-- end of panel -->
        strGridHTML.Append("</div>")
        '<!-- end of #accordion -->

        strGridHTML.Append("</div>")
        '<!-- end of wrap -->

        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")




        strGridHTML.Append("</div>")


        ''Horizontal tabs
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")
        strGridHTML.Append("</div>")

        'strGridHTML.Append("</div>")
        'divSubMainblock end

        strGridHTML.Append("</div>")
        'divMainblock end
        CommonFunctions.General.WriteHTML(strGridHTML.ToString)

    End Function

    Public Function GetTabs(Optional ByVal DepartmentID As String = "")
        Dim strGridHTML As New StringBuilder()
        GetSubTabAccessRights(118, TagID)
        If m_objSubTabAccess.View = True Then
            strGridHTML.Append("<button id='btnConfigureHRM' class='tablinks4 active clsSubtags' onclick='openCity4(event, ""ConfigureHRM"")' id='defaultOpen4'>Configure HRM</button>")
        End If
        If (DepartmentID <> "") Then
            Dim strsql As String = "usp_NG2_chk_RequestTypeMappedForDepartment " & DepartmentID
            Dim strResult As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, True))
            If strResult = "1" Then
                GetSubTabAccessRights(119, TagID)
                If m_objSubTabAccess.View = True Then
                    strGridHTML.Append("<button id='btnRoleMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""RoleMapping"")'>Role Mapping</button>")
                End If
            End If
        End If
        ''Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
        GetSubTabAccessRights(120, TagID)
        If m_objSubTabAccess.View = True Then
            strGridHTML.Append("<button id='btnProjectMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""ProjectMapping"")'>Project Mapping</button>")
        End If
        ''End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
        GetSubTabAccessRights(2121, TagID)
        If m_objSubTabAccess.View = True Then
            strGridHTML.Append("<button id='btnGroupEmail' class='tablinks4 clsSubtags' onclick='openCity4(event, ""GroupEmail"")'>Group Email</button>")
        End If
        GetSubTabAccessRights(3376, TagID)
        If m_objSubTabAccess.View = True Then
            strGridHTML.Append("<button id='btnCustomerMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""CustomerMapping"")'>Customer Mapping</button>")
        End If
        GetCurrentTagAccessRights(396)
        If m_objCurrentTagAccess.View = True Then
            strGridHTML.Append("<button id='btnRequestTypeMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""RequestTypeMapping"")'>Request Type Mapping</button>")
        End If
        GetCurrentTagAccessRights(396)
        If m_objCurrentTagAccess.View = True Then
            strGridHTML.Append("<button id='btnWorkingHours' class='tablinks4 clsSubtags' onclick='openCity4(event, ""WorkingHours"")'>Working Hours</button>")
        End If

        Return strGridHTML.ToString()
    End Function


    Private Sub m_objDepartmentGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objDepartmentGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToUpper = "SHORT NAME" Then
            Cancel = True
            Args.ApplyHTMLEncode = False
            Args.ApplySorting = True
            Args.TDStyle = " "

            Args.StringToBeInserted = "<th align='center' tyle='width: 204px;'> Short Name <i class='fa fa-sort' aria-hidden='true'></i></th>"
        End If

        If Args.ColumnName.ToUpper = "DEPARTMENT" Then
            Cancel = True
            Args.ApplyHTMLEncode = False
            Args.ApplySorting = True
            Args.TDStyle = " "

            Args.StringToBeInserted = "<th align='center' tyle='width: 221px;'> Department <i class='fa fa-sort' aria-hidden='true'></i></th>"
        End If

        If Args.ColumnName.ToUpper = "EXPOSE TO CUSTOMER" Then
            Cancel = True
            Args.ApplyHTMLEncode = False
            Args.ApplySorting = True
            Args.TDStyle = " "

            Args.StringToBeInserted = "<th align='center' tyle='width: 224px;'> Expose To Customer <i class='fa fa-sort' aria-hidden='true'></i></th>"
        End If

        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        'End If
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th style='width: 176px;'><input type=checkbox name='sample' onclick='SelectMultipleDepartment()' id='chkDepartmentSelectAll' class='selectall' title='Select All' /></th>"
        End If
        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'DeleteDepartment'><i class='fa fa-trash-o' aria-hidden='true' onclick=""DeleteDepartment(" & Args.DataReader("DepartmentID") & ")""></i></TD>"

        End If
    End Sub
    Private Sub m_objDepartmentGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objDepartmentGrid.DataRowTD_BeforePrint
        'Commented and added by Usha Pandit on 25.11.2017

        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td><input type=checkbox name='chkDepartmentSelect' title='select' /></td>"
        'End If


        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            If CheckDepartmentInUse(Args.DataReader("DepartmentID")) = 1 Then
                Args.StringToBeInserted = "<td align='center'  title='Department in use. Can not delete' ><input type=checkbox name='sample[]' disabled id ='chkDepartmentSelect' value='" & Args.DataReader("DepartmentID") & "' /></td>"
            Else
                Args.StringToBeInserted = "<td align='center'  title='Delete Department' ><input type=checkbox name='sample[]' id ='chkDepartmentSelect'  value='" & Args.DataReader("DepartmentID") & "' /></td>"
            End If
        End If
        'If Args.DataField.ToUpper = "DEPARTMENT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td align='center' Title = 'Department'><a href='#' onclick=""getEntityDetails(" & Args.DataReader("DepartmentID") & ")"">" & Args.DataReader("Department") & "</a></TD>"

        'End If

        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Edit Department'><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;' onclick=""getEntityDetails(" & Args.DataReader("DepartmentID") & ")""></i></TD>"

        End If

        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'DeleteDepartment'><i class='fa fa-trash-o' aria-hidden='true' onclick=""DeleteDepartment(" & Args.DataReader("DepartmentID") & ")""></i></TD>"

        End If

        'End of Commented and added by Usha Pandit on 25.11.2017
        '<i class="fa fa-pencil-square-o" aria-hidden="true"></i>

        '<i class="fa fa-trash-o" aria-hidden="true"></i>DeleteDepartment
    End Sub
    Private Sub m_objConfigureHRMGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objConfigureHRMGrid.ColumnHeaderTD_BeforePrint

    End Sub
    Private Sub m_objConfigureHRMGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objConfigureHRMGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'EditConfigureHRM' class = 'clsEditCenterAlign'><button class='edit-bt' onclick=""updateConfigureHRM(" & Args.DataReader("FunctionCRMID") & "," & Args.DataReader("CRMID") & ",&quot;" & Args.DataReader("SendMail") & "&quot;,&quot;" & Args.DataReader("UserName") & "&quot;)""><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;'></i></button></td>"
            Args.StringToBeInserted = "<td align='center' Title = 'Edit  HRM' class = 'clsEditCenterAlign'><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;' onclick=""updateConfigureHRM(" & Args.DataReader("FunctionCRMID") & "," & Args.DataReader("CRMID") & ",&quot;" & Args.DataReader("SendMail") & "&quot;,&quot;" & Args.DataReader("UserName") & "&quot;)""></i></td>"

        End If
        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'DeleteConfigureHRM' class = 'clsEditCenterAlign'><button style='border: none;' class='delet-btn' onclick = 'deleteConfigureHRM(" & Args.DataReader("FunctionCRMID") & ")'><i class='fa fa-trash-o' aria-hidden='true'></i></td>"
            Args.StringToBeInserted = "<td align='center' Title = 'Delete  HRM' class = 'clsEditCenterAlign'><i class='fa fa-trash-o' aria-hidden='true' onclick = 'deleteConfigureHRM(" & Args.DataReader("FunctionCRMID") & ")'></i></td>"

        End If
    End Sub
    Private Sub m_objRoleMappingGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objRoleMappingGrid.ColumnHeaderTD_BeforePrint

    End Sub
    Private Sub m_objRoleMappingRoleMappingGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objRoleMappingGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' Title = 'Delete Mapped Role' class = 'clsEditCenterAlign'><i class='fa fa-trash-o' aria-hidden='true' onclick = 'deleteMappedRole(" & Args.DataReader("FunctionRoleID") & ")'></i></td>"
        End If
    End Sub

    ''Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    Private Sub m_objProjectMappingGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objProjectMappingGrid.ColumnHeaderTD_BeforePrint

    End Sub
    Private Sub m_objProjectMappingGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objProjectMappingGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Edit Project Mapping' class = 'clsEditCenterAlign'><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;' onclick=""updateProjectMapping(&quot;" & Args.DataReader("FunctionID") & "&quot;,&quot;" & Args.DataReader("ProjectID") & "&quot;,&quot;" & Args.DataReader("ProjectName") & "&quot;,&quot;" & Args.DataReader("IsDefaultProject") & "&quot;," & Args.DataReader("FunctionProjectID") & ")""></i></td>"

        End If
        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Project Mapping' class = 'clsEditCenterAlign'><i class='fa fa-trash-o' aria-hidden='true' onclick = 'deleteProjectMapping(" & Args.DataReader("FunctionProjectID") & ")'></i></td>"

        End If
    End Sub
    ''End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
    Private Sub m_objGroupEmailGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGroupEmailGrid.ColumnHeaderTD_BeforePrint

    End Sub
    Private Sub m_objGroupEmailGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGroupEmailGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'EditGroupEmail' class = 'clsEditCenterAlign'><button class='edit-bt' onclick=""updateGroupEmail(&quot;" & Args.DataReader("GroupName") & "&quot;,&quot;" & Args.DataReader("EmailAlias") & "&quot;,&quot;" & Args.DataReader("Description") & "&quot;," & Args.DataReader("DepartmentGroupID") & ")""><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;'></i></button></td>"

            Args.StringToBeInserted = "<td align='center' Title = 'Edit Group Email' class = 'clsEditCenterAlign'><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;' onclick=""updateGroupEmail(&quot;" & Args.DataReader("GroupName") & "&quot;,&quot;" & Args.DataReader("EmailAlias") & "&quot;,&quot;" & Args.DataReader("Description") & "&quot;," & Args.DataReader("DepartmentGroupID") & ")""></i></td>"

        End If
        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'DeleteGroupEmail' class = 'clsEditCenterAlign'><button style='border: none;' class='delet-btn' onclick = 'deleteGroupEmail(" & Args.DataReader("DepartmentGroupID") & ")'><i class='fa fa-trash-o' aria-hidden='true'></i></td>"

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Group Email' class = 'clsEditCenterAlign'><i class='fa fa-trash-o' aria-hidden='true' onclick = 'deleteGroupEmail(" & Args.DataReader("DepartmentGroupID") & ")'></i></td>"

        End If
    End Sub

    Private Sub m_objCustomerMappingGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objCustomerMappingGrid.ColumnHeaderTD_BeforePrint

    End Sub
    Private Sub m_objCustomerMappingGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objCustomerMappingGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'EditCustomerMapping' class = 'clsEditCenterAlign'><button class='edit-bt' onclick=""updateCustomerMapping(" & Args.DataReader("DeptCustMappingID") & "," & Args.DataReader("CustomerID") & ")""><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;'></i></button></td>"
            If Args.DataReader("ExposeToCustomer") = "1" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Customer Mapping' class = 'clsEditCenterAlign'><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;' onclick=""updateCustomerMapping(" & Args.DataReader("DeptCustMappingID") & "," & Args.DataReader("CustomerID") & ")""></i></td>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Can not Edit Customer' class = 'clsEditCenterAlign'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></td>"
            End If


        End If
        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'DeleteCustomerMapping' class = 'clsEditCenterAlign'><button style='border: none;' class='delet-btn' onclick = 'deleteCustomerMapping(" & Args.DataReader("DeptCustMappingID") & ")'><i class='fa fa-trash-o' aria-hidden='true'></i></td>"
            Args.StringToBeInserted = "<td align='center' Title = 'Delete Customer Mapping' class = 'clsEditCenterAlign'><i class='fa fa-trash-o' aria-hidden='true' onclick = 'deleteCustomerMapping(" & Args.DataReader("DeptCustMappingID") & ")'></i></td>"

        End If
    End Sub


    Private Sub m_objRequestTypeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objRequestTypeGrid.ColumnHeaderTD_BeforePrint

    End Sub
    Private Sub m_objRequestTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objRequestTypeGrid.DataRowTD_BeforePrint
        'If Args.DataField.ToUpper = "EDIT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td align='center' Title = 'EditRequestTypeMapping' class = 'clsEditCenterAlign'><button class='edit-bt' onclick=""updateRequestTypeMapping(" & Args.DataReader("FunctionRequestTypeID") & "," & Args.DataReader("FunctionID") & ",&quot;" & Args.DataReader("Department") & "&quot;,&quot;" & Args.DataReader("RequestType") & "&quot;,&quot;" & Args.DataReader("SubRequestType") & "&quot;,&quot;" & Args.DataReader("GroupName") & "&quot;,&quot;" & Args.DataReader("GroupEmail") & "&quot;," & Args.DataReader("ReportingToApproval") & ")""><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;'></i></button></td>"

        'End If


        If Args.DataField.ToUpper = "REPORTINGTOAPPROVAL" Then
            Cancel = True
            If Args.DataReader("ReportingToApproval") = "false" Then

                Args.StringToBeInserted = "<td align='center'><input type='checkbox' style='width: 14px;' id='chkApproval' name='chkApproval'  value = " & Args.DataReader("SubRequestTypeID") & " ></td>"

            Else

                Args.StringToBeInserted = "<td align='center'><input type='checkbox' style='width: 14px;' id='chkApproval' name='chkApproval'  value = " & Args.DataReader("SubRequestTypeID") & " checked></td>"

            End If
        End If
        '/*Changed By Yasmin on 26th july 2018*/
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            If Args.DataReader("IsMapp") = "0" Then

                Args.StringToBeInserted = "<td align='center'><input type='checkbox' style='width: 14px;' id='chkSelect' name='chkSelect'  value = " & "&quot;" & Args.DataReader("RequestTypeID") & "|" & Args.DataReader("SubRequestTypeID") & "|" & "False" & "|" & Args.DataReader("GroupName") & "|" & Args.DataReader("GroupEmail") & "&quot;" & "></td>"

            Else

                Args.StringToBeInserted = "<td align='center'><input type='checkbox' style='width: 14px;' id='chkSelect' name='chkSelect'  value = " & "&quot;" & Args.DataReader("RequestTypeID") & "|" & Args.DataReader("SubRequestTypeID") & "|" & "False" & "|" & Args.DataReader("GroupName") & "|" & Args.DataReader("GroupEmail") & "&quot;" & " checked></td>"

            End If
        End If
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            If Args.DataReader("IsMapp") = "0" Then
                'Args.StringToBeInserted = "<td align='center'><button class='edit-bt' disabled><i style = 'margin-top: 8px;' class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>"
                Args.StringToBeInserted = "<td align='center'  title='You can not edit this record.'><i style = 'margin-top: 8px;' class='fa fa-pencil-square-o' aria-hidden='true' disabled></i></td>"
            Else
                'Args.StringToBeInserted = "<td align='center' Title = 'EditRequestTypeMapping' class = 'clsEditCenterAlign'><button class='edit-bt' onclick=""updateRequestTypeMapping(" & Args.DataReader("FunctionRequestTypeID") & "," & Args.DataReader("FunctionID") & ",&quot;" & Args.DataReader("Department") & "&quot;,&quot;" & Args.DataReader("RequestType") & "&quot;,&quot;" & Args.DataReader("SubRequestType") & "&quot;,&quot;" & Args.DataReader("GroupName") & "&quot;,&quot;" & Args.DataReader("GroupEmail") & "&quot;,&quot;" & Args.DataReader("ReportingToApproval") & "&quot;)""><i style = 'margin-top: 8px;' class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;'></i></button></td>"

                Args.StringToBeInserted = "<td align='center' Title = 'Edit Request Type Mapping' class = 'clsEditCenterAlign'><i style = 'margin-top: 8px;' class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;' onclick=""updateRequestTypeMapping(" & Args.DataReader("FunctionRequestTypeID") & "," & Args.DataReader("FunctionID") & ",&quot;" & Args.DataReader("Department") & "&quot;,&quot;" & Args.DataReader("RequestType") & "&quot;,&quot;" & Args.DataReader("SubRequestType") & "&quot;,&quot;" & Args.DataReader("GroupName") & "&quot;,&quot;" & Args.DataReader("GroupEmail") & "&quot;,&quot;" & Args.DataReader("ReportingToApproval") & "&quot;)""></i></td>"
            End If
        End If
    End Sub

    Private Sub m_objWorkingHoursGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objWorkingHoursGrid.ColumnHeaderTD_BeforePrint

    End Sub
    Private Sub m_objWorkingHoursGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objWorkingHoursGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            'Args.StringToBeInserted = "<td align='center' Title = 'EditWorkingHours' class = 'clsEditCenterAlign'><button class='edit-bt' onclick=""updateWorkingHours(&quot;" & Args.DataReader("IsWorking") & "&quot;,&quot;" & Args.DataReader("FromTime") & "&quot;,&quot;" & Args.DataReader("ToTime") & "&quot;," & Args.DataReader("UniqueID") & ",&quot;" & Args.DataReader("WeekDay") & "&quot;)""><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;'></i></button></td>"

            Args.StringToBeInserted = "<td align='center' Title = 'Edit Working Hours' class = 'clsEditCenterAlign'><i class='fa fa-pencil-square-o' onclick=""updateWorkingHours(&quot;" & Args.DataReader("IsWorking") & "&quot;,&quot;" & Args.DataReader("FromTime") & "&quot;,&quot;" & Args.DataReader("ToTime") & "&quot;," & Args.DataReader("UniqueID") & ",&quot;" & Args.DataReader("WeekDay") & "&quot;)"" aria-hidden='true' style='cursor:pointer;'></i></button></td>"

        End If
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function ShowMailHistoryDetails(ByVal UniqueID As Integer)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryDetails                              '
        ' Purpose				:   Call ShowMailHistoryGrid function                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Try
            Dim objSetting As New CRM_DepartmentMaster
            Dim strHTML As New StringBuilder("")
            Dim str As String = objSetting.ShowMailHistoryGrid(UniqueID, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    Public Function ShowMailHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryGrid                                 '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   UniqueID                                            '
        ' Returns               :   grid                                                '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Dim strHTML As New StringBuilder("")
        Dim txtSQLQuery As New StringBuilder

        If (storedprocedure = Nothing) Then
            txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 396 & "','" & UniqueID & "'")
        Else
            txtSQLQuery.Append(storedprocedure)
        End If
        '/*Changed By Yasmin on 25th july 2018*/

        strSQLQuery = txtSQLQuery.ToString

        arrColumnHeadingList.Add("Modified Date")
        arrColumnHeadingList.Add("Field Modified")
        arrColumnHeadingList.Add("Modified By")
        arrColumnHeadingList.Add("Value")

        arrActualColumnNames.Add("Date")
        arrActualColumnNames.Add("FieldName")
        arrActualColumnNames.Add("ModifiedBy")
        arrActualColumnNames.Add("Value")
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = 4
            .PrimaryKey = "LogID"
            .TDStyleArray = arrWidthArray
            '.ColNameToolTipOnEachRow = False
            .DIVID = "ShowHistoryGrid"
            .DIVStyle = "overflow: auto"
            .SQL = strSQLQuery
            '.ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            strHTML.Append(.DrawGrid())
        End With

        Return strHTML.ToString()

    End Function
    Public Function GetArray(ByVal arrList As ArrayList) As String()
        '================================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : tejal D
        ' Created               : 
        ' Revisions             :
        '===============================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    'Public Function ShowMailHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
    '    '*******************************************************************************'
    '    ' Function Name	        :	ShowMailHistoryGrid                                 '
    '    ' Purpose				:   Plotting the grid                                   '
    '    ' Parameters Passed     :   UniqueID                                            '
    '    ' Returns               :   grid                                                '
    '    ' Author                :   Vaijat K                                     '
    '    '*******************************************************************************'
    '    Dim strHTML As New StringBuilder("")
    '    Dim txtSQLQuery As New StringBuilder
    '    Dim arrColumnHeadingList As String()
    '    Dim arrActualColumnNames As String()
    '    Dim m_objGridHistory As New WebPages.Template.GenericGrid
    '    txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '396','" & UniqueID & "'")
    '    arrColumnHeadingList(0) = ("Modified Date")
    '    arrColumnHeadingList(1) = ("Field Modified")
    '    arrColumnHeadingList(2) = ("Modified By")
    '    arrColumnHeadingList(3) = ("Value")

    '    arrActualColumnNames(0) = ("Date")
    '    arrActualColumnNames(1) = ("FieldName")
    '    arrActualColumnNames(2) = ("ModifiedBy")
    '    arrActualColumnNames(3) = ("Value")

    '    m_objGridHistory = New WebPages.Template.GenericGrid
    '    With m_objGridHistory
    '        .ActualColumnArray = (arrActualColumnNames)
    '        .UserFriendlyColumnArray = (arrColumnHeadingList)
    '        .NoOfDataColumns = 4
    '        .PrimaryKey = "LogID"
    '        .ColNameToolTipOnEachRow = False
    '        .DIVID = "ShowHistoryGrid"
    '        .DIVStyle = "overflow: auto !important"
    '        .SQL = txtSQLQuery.ToString
    '        .ColNameToolTipOnEachRow = True
    '        .UseSQL = True
    '        .returnHTML = True
    '        .IgnoreHTMLEncode = arrIgnoreHTMLEncode

    '        strHTML.Append(.DrawGrid())
    '    End With
    '    m_objGridHistory = Nothing
    '    Return strHTML.ToString()

    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function FilteredHistory(ByVal newModifiedField As String, ByVal MessageID As Integer, ByVal newModifiedBy As String)
        '================================================================================
        ' Procedure Name        : FilteredHistory()	
        ' Purpose               : Get Email setting details for selected filter
        ' Description           : Get Email setting details for selected filter
        ' Parameters Passed     : newModifiedField
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Varsha Jorwekar
        ' Created               : 01-Dec-2017
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            Dim objSetting As New CRM_DepartmentMaster
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 396, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"

            Dim str As String = objSetting.ShowMailHistoryGrid(MessageID, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function CheckRequestType(ByVal DepartmentID As String)
        Try
            Dim crm_department As New CRM_DepartmentMaster
            Return crm_department.GetTabs(DepartmentID)
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function


End Class

