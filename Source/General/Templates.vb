Imports System.Resources
Imports System.Reflection
Imports System.Threading
Imports System.Globalization
Namespace WebPage
    Namespace Templates
        Public Class WhizTemplate
            Inherits WebPages.Template.WhizTemplate
            'Private m_GlobalObject As New WebPage.Templates.Global()
            'Public Shadows ReadOnly Property GlobalObject() As WebPage.Templates.Global
            '    Get
            '        Return m_GlobalObject
            '    End Get
            'End Property
            'Public Shadows Sub FillGlobalObject(ByVal LCID As Integer, Optional ByVal UseHashTable As String = "N", Optional ByVal FromWhere As String = "", Optional ByVal ParentTagID As Long = 0, Optional ByVal returnHTML As Boolean = False)
            '    '=====================================================================
            '    ' Procedure Name		:	FillGlobalObject
            '    ' Parameters Passed		:	LCID
            '    '                           UseHashTable
            '    '                           FromWhere
            '    '                           ParentTagID
            '    '                           returnHTML
            '    ' Returns				:	None
            '    ' Parameters Affected	:	None
            '    ' Purpose				:	To initialize the page specific resources
            '    ' Description			:	
            '    ' Assumptions			:	None
            '    ' Dependencies			:	None
            '    ' Author				:	AshishR
            '    ' Created				:	Oct 9 2003
            '    ' Revisions				:	
            '    '=====================================================================
            '    Try

            '        If Not HttpContext.Current.Session("intProjectID") Is Nothing Then
            '            m_GlobalObject.ProjectID = CType(HttpContext.Current.Session("intProjectID"), Long)
            '        End If
            '        If FromWhere.Trim = "" Then
            '            If Not HttpContext.Current.Request.QueryString("FromWhere") Is Nothing Then
            '                m_GlobalObject.FromWhere = HttpContext.Current.Request.QueryString("FromWhere").ToString
            '            End If
            '        Else
            '            m_GlobalObject.FromWhere = FromWhere.ToString
            '        End If
            '        If Not HttpContext.Current.Request.QueryString("TagID") Is Nothing Then
            '            m_GlobalObject.TagID = CType(HttpContext.Current.Request.QueryString("TagID"), Long)
            '        End If
            '        If Not HttpContext.Current.Session("intLoginID") Is Nothing Then
            '            m_GlobalObject.LoginID = CType(HttpContext.Current.Session("intLoginID"), Long)
            '        End If
            '        If Not HttpContext.Current.Session("LoginType") Is Nothing Then
            '            m_GlobalObject.LoginType = HttpContext.Current.Session("LoginType").ToString
            '        End If
            '        If Not HttpContext.Current.Session("IsCreatedByCustomer") Is Nothing Then
            '            m_GlobalObject.IsCustomerCreated = CType(HttpContext.Current.Session("IsCreatedByCustomer"), Boolean)
            '        End If

            '        If Not HttpContext.Current.Session("intPostID") Is Nothing Then
            '            m_GlobalObject.RoleID = CType(HttpContext.Current.Session("intPostID"), Long)
            '        End If

            '        If Not HttpContext.Current.Session("intRoleLevel") Is Nothing Then
            '            m_GlobalObject.RoleLevel = CType(HttpContext.Current.Session("intRoleLevel"), Integer)
            '        End If
            '        If Not HttpContext.Current.Session("strUserName") Is Nothing Then
            '            m_GlobalObject.UserName = HttpContext.Current.Session("strUserName").ToString
            '        End If
            '        If Not HttpContext.Current.Session("intUserID") Is Nothing Then
            '            m_GlobalObject.UserID = CType(HttpContext.Current.Session("intUserID"), Long)
            '        End If
            '        m_GlobalObject.LCID = LCID
            '        m_GlobalObject.ParentTagID = ParentTagID
            '        m_GlobalObject.returnHTML = returnHTML
            '        m_GlobalObject.UseHashTable = UseHashTable
            '        m_GlobalObject.clsTable = ""
            '        m_GlobalObject.clsTR = ""
            '    Catch ex As Exception
            '        Err.Raise(Err.Number, "Template->FillGlobalObject", ex.Message)
            '    End Try

            'End Sub
            'Public Shadows Sub ApplySecurity(Optional ByVal ApplySecurity As Boolean = False, Optional ByVal SecurityLevel As Integer = 2, Optional ByVal ApplySQLKeyWordSecurity As Boolean = False, Optional ByVal ApplyPortSecurity As Boolean = False, Optional ByVal ApplyPatternSecurity As Boolean = False, Optional ByVal TagID As Long = 0, Optional ByVal ParentTagID As Long = 0)
            '    '=====================================================================
            '    ' Procedure Name		:	ApplySecurity
            '    ' Parameters Passed		:	ApplySecurity - Optional Whether to apply the security
            '    '                           SecurityLevel - Optional Security level- Default 2
            '    '                           ApplySQLKeyWordSecurity -Optional Whether to apply sql Key Words security Default Flase
            '    '                           ApplyPortSecurity - Optional whether to apply port checking default=false
            '    '                           ApplyPatternSecurity - Optional Whether to apply Pattern Security default = flase
            '    ' Returns				:	None
            '    ' Parameters Affected	:	None
            '    ' Purpose				:	To apply the security to all forms control
            '    ' Description			:	
            '    ' Assumptions			:	None
            '    ' Dependencies			:	None
            '    ' Author				:	AshishR
            '    ' Created				:	Sep 29 2003
            '    ' Revisions				:	
            '    '=====================================================================
            '    Dim intCount As Integer
            '    Try
            '        If TagID = 0 Then
            '            'loop to all form controls

            '            For intCount = 0 To HttpContext.Current.Request.Form.Count - 1
            '                Dim strKey As String = HttpContext.Current.Request.Form.GetKey(intCount)
            '                Dim strValue As String = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.Get(intCount))
            '                If strValue = Nothing Then strValue = ""
            '                'Check apply security parameter of this function and application level settings (ApplyWebSecurity)
            '                If strKey <> "_VIEWSTATE" Then
            '                    If ApplySecurity = True And CommonFunctions.General.GetApplicationKeySetting("ApplyWebSecurity") = "Y" Then
            '                        'add parameter into the hash table
            '                        m_htFormsCollection.Add(strKey, Utilities.Security.SecurityBuilder.CheckUserInput(strValue, SecurityLevel, ApplySQLKeyWordSecurity, ApplyPortSecurity, ApplyPatternSecurity))
            '                    Else
            '                        m_htFormsCollection.Add(strKey, strValue)
            '                    End If
            '                End If

            '            Next

            '        Else
            '            Dim blnEnterInLoop As Boolean = False
            '            Dim strSQL As String
            '            If HttpContext.Current.Request.Form.Count > 0 Then
            '                Dim dr_ControlTagMaster As IDataReader

            '                If ParentTagID = 0 Then
            '                    strSQL = "EXEC usp_Sel_v_tbl_UI_ControlTagMaster_Security " + TagID.ToString

            '                Else
            '                    strSQL = "EXEC usp_Sel_v_tbl_UI_SubControlTagMaster_Security " + TagID.ToString
            '                End If
            '                dr_ControlTagMaster = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            '                Dim blnInforcePageLevelSecurity As Boolean = False
            '                Dim blnConsiderControlLevelSecurity As Boolean = False
            '                Dim blnDontApplySecurity As Boolean = False
            '                Dim strValue As String
            '                'If dr_ControlTagMaster.Read Then
            '                'End If
            '                While dr_ControlTagMaster.Read

            '                    If blnEnterInLoop = False Then

            '                        If dr_ControlTagMaster("SecuritySettingsCL").ToString = "P" Then
            '                            blnInforcePageLevelSecurity = True
            '                        ElseIf dr_ControlTagMaster("SecuritySettingsCL").ToString = "C" Then
            '                            blnConsiderControlLevelSecurity = True
            '                        ElseIf dr_ControlTagMaster("SecuritySettingsCL").ToString = "N" Or dr_ControlTagMaster("SecuritySettingsCL").ToString.Trim = "" Then
            '                            blnDontApplySecurity = True

            '                        End If
            '                        blnEnterInLoop = True

            '                    End If


            '                    If Not HttpContext.Current.Request.Form.Get(dr_ControlTagMaster("ControlName").ToString) Is Nothing Then
            '                        strValue = HttpContext.Current.Request.Form.Get(dr_ControlTagMaster("ControlName").ToString)
            '                    Else
            '                        strValue = ""
            '                    End If
            '                    If blnDontApplySecurity = True Then
            '                        strValue = CommonFunctions.General.BuildQueryString(strValue)
            '                    Else
            '                        If blnConsiderControlLevelSecurity = True Then

            '                            If dr_ControlTagMaster("SecuritySettings").ToString = "C" Then
            '                                strValue = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.Get(dr_ControlTagMaster("ControlName").ToString))
            '                                If CommonFunctions.General.GetApplicationKeySetting("ApplyWebSecurity") = "Y" Then
            '                                    strValue = Utilities.Security.SecurityBuilder.CheckUserInput(strValue, SecurityLevel, True, True, True)
            '                                End If

            '                            Else
            '                                strValue = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.Get(dr_ControlTagMaster("ControlName").ToString))
            '                            End If
            '                        ElseIf blnInforcePageLevelSecurity = True Then
            '                            strValue = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.Get(dr_ControlTagMaster("ControlName").ToString))
            '                            If CommonFunctions.General.GetApplicationKeySetting("ApplyWebSecurity") = "Y" Then
            '                                strValue = Utilities.Security.SecurityBuilder.CheckUserInput(strValue, SecurityLevel, True, True, True)
            '                            End If
            '                        End If

            '                    End If
            '                    m_htFormsCollection.Add(dr_ControlTagMaster("ControlName").ToString, strValue)
            '                End While
            '                dr_ControlTagMaster.Close()
            '                dr_ControlTagMaster = Nothing
            '            End If

            '        End If
            '    Catch ex As Exception
            '        Err.Raise(Err.Number, "Template->ApplySecurity", ex.Message)
            '    End Try
            'End Sub

        End Class 'Template
        Public Class PageCaption 'PageCaption
            Inherits WebPages.Template.PageCaption
            ''=====================================================================
            '' Class	Name	        :	PageCaption
            '' Purpose				:	This is a wrapper class of cPageCaption
            '' Description			:	
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	AshishR
            '' Created				:	Sep 3, 2003
            '' Revisions				:	
            ''=====================================================================

            'Public Shared Function GetPageCaptions(Optional ByVal WhizGlobal As WebPages.Template.IGlobal = Nothing, Optional ByVal LeftCaption As String = "", Optional ByVal RightCaption As String = "", Optional ByVal MiddleCaption As String = "", Optional ByVal ReturnHTML As Boolean = False) As String

            '    'Create the object of page caption class
            '    Dim objPageCaption As New WebPage.UI.cPageCaption()

            '    If Not Global Is Nothing Then
            '        objPageCaption.LoginID = WhizGlobal.LoginID
            '        objPageCaption.TagID = WhizGlobal.TagID
            '        objPageCaption.ParentTagID = WhizGlobal.ParentTagID
            '        objPageCaption.RoleID = WhizGlobal.RoleID
            '        objPageCaption.ProjectID = WhizGlobal.ProjectID
            '        objPageCaption.LoginType = WhizGlobal.LoginType
            '        objPageCaption.UserID = WhizGlobal.UserID
            '        objPageCaption.IsCustomerCreated = WhizGlobal.IsCustomerCreated
            '        objPageCaption.UseHashTable = WhizGlobal.UseHashTable.ToString
            '    End If
            '    objPageCaption.LeftPageCaption = LeftCaption.ToString
            '    objPageCaption.MiddlePageCaption = MiddleCaption.ToString
            '    objPageCaption.RightPageCaption = RightCaption.ToString
            '    objPageCaption.returnHTML = ReturnHTML
            '    objPageCaption.IsPageCaption = True
            '    objPageCaption.clsTR = "clsTRPageCaption"

            '    'return the object
            '    Dim strReturnCaption As String = objPageCaption.DrawPageCaption.ToString
            '    'Destory the object
            '    objPageCaption = Nothing
            '    'Return the string
            '    Return strReturnCaption

            'End Function
        End Class 'End PageCaption

        Public Class SectionTitle 'SectionTitle
            Inherits WebPages.Template.SectionTitle
            '=====================================================================
            ' Class	Name	        :	SectionTitle
            ' Purpose				:	This is a wrapper class of cPageCaption as Section Title
            ' Description			:	
            ' Assumptions			:	None
            ' Dependencies			:	None
            ' Author				:	UmeshJ
            ' Created				:	Nov 06, 2003
            ' Revisions				:	
            '=====================================================================
            'Private strClientSideScript As String = ""
            'Private strLinkNames As String()
            'Private strLinkFunctions As String()
            'Private strLinkTooltips As String()

            'Public WriteOnly Property LinkNames() As String()
            '    Set(ByVal Value As String())
            '        strLinkNames = Value
            '    End Set
            'End Property

            'Public WriteOnly Property LinkFunctions() As String()
            '    Set(ByVal Value As String())
            '        strLinkFunctions = Value
            '    End Set
            'End Property

            'Public WriteOnly Property LinkTooltips() As String()
            '    Set(ByVal Value As String())
            '        strLinkTooltips = Value
            '    End Set
            'End Property

            'Public ReadOnly Property ClientsideScript() As String
            '    Get
            '        Return strClientSideScript
            '    End Get
            'End Property


            'Public Sub New()

            'End Sub

            'Public Function GetSectionTitle(ByVal LeftSectionTitle As String, ByVal divID_SectionTag As String, ByVal FunctionName As String, Optional ByVal clsSectionHeader As String = "clsTRSectionHeader", _
            '        Optional ByVal RightSectionTitle As String = "", Optional ByVal MiddleSectionTitle As String = "", Optional ByVal ImgSrcHideSection As String = "../../Images/minus.gif", Optional ByVal ImgSrcShowSection As String = "../../Images/plus.gif", _
            '        Optional ByVal TooltipHideSection As String = "", Optional ByVal TooltipShowSection As String = "", Optional ByVal ReturnHTML As Boolean = False, Optional ByVal blnSaveUserPreference As Boolean = False, Optional ByVal AllowHideShow As Boolean = True, Optional ByVal ShowHideLinks As Boolean = True) As String

            '    'Create the object of page caption class
            '    Dim objSectionTitle As New WebPage.UI.cSectionTitle()

            '    With objSectionTitle
            '        .clsTR = clsSectionHeader
            '        .returnHTML = ReturnHTML
            '        .AllowHideShow = AllowHideShow
            '        .TooltipHideSection = TooltipHideSection
            '        .TooltipShowSection = TooltipShowSection
            '        .ImgSrcHideSection = ImgSrcHideSection
            '        .ImgSrcShowSection = ImgSrcShowSection
            '        .FunctionName = FunctionName
            '        .divID_SectionTag = divID_SectionTag
            '        .SaveUserPreference = blnSaveUserPreference
            '        'Link specific
            '        .LinkSeperatorHTML = "|"
            '        .LinkNames = strLinkNames
            '        .LinkFunctions = strLinkFunctions
            '        .LinkTooltips = strLinkTooltips
            '        .ShowHideLinks = ShowHideLinks
            '        GetSectionTitle = .DrawSectionTitle(LeftSectionTitle, RightSectionTitle, MiddleSectionTitle)
            '        strClientSideScript = .ClientSideScript
            '    End With
            '    'Destory the object
            '    objSectionTitle = Nothing

            'End Function

        End Class 'End SectionTitle

        Public Class AccessRights                'AccessRights
            Inherits WebPages.Template.AccessRights

            '=====================================================================
            ' Class	Name	        :	AccessRights
            ' Purpose				:	This is a wrapper class of WebPage.Security.cAccessRights
            '                               
            ' Description			:	
            ' Assumptions			:	None
            ' Dependencies			:	None
            ' Author				:	AshishR
            ' Created				:	Sep 3, 2003
            ' Revisions				:	
            '=====================================================================
            'Private blnAdd As Boolean
            'Private blnEdit As Boolean
            'Private blnView As Boolean
            'Private blnDelete As Boolean
            'Private blnAccess As Boolean

            'Public Sub GetAccess(ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal ModuleAccess As Boolean = False)
            '    'Create the object of cAccessRights class
            '    Dim objAccessRights As New WebPage.Security.cAccessRights(WhizGlobal)
            '    objAccessRights.GetAccess(ModuleAccess)
            '    blnAdd = objAccessRights.Add
            '    blnEdit = objAccessRights.Edit
            '    blnDelete = objAccessRights.Delete
            '    blnView = objAccessRights.View
            '    blnAccess = objAccessRights.IsModuleAccessible
            '    objAccessRights = Nothing
            'End Sub
            'Public Property Add() As Boolean
            '    Get
            '        Return blnAdd
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        blnAdd = Value
            '    End Set
            'End Property

            'Public Property Edit() As Boolean
            '    Get
            '        Return blnEdit
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        blnEdit = Value
            '    End Set
            'End Property

            'Public Property Delete() As Boolean
            '    Get
            '        Return blnDelete
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        blnDelete = Value
            '    End Set
            'End Property

            'Public Property View() As Boolean
            '    Get
            '        Return blnView
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        blnView = Value
            '    End Set
            'End Property
            'Public ReadOnly Property Access() As Boolean
            '    Get
            '        Return blnAccess
            '    End Get
            'End Property


        End Class ' End AccessRights
        Public Class HeaderFooter
            Inherits WebPages.Template.HeaderFooter
            ''Property Variables
            'Private strHeaderFooter As String = ""
            'Private enmDisplayPosition As UI.cHeaderFooter.HeaderFooterDisplayPosition

            'Enum HeaderFooterDisplayPosition
            '    LIST_HEADER
            '    LIST_FOOTER
            '    UI_HEADER
            '    UI_FOOTER
            'End Enum

            'Public WriteOnly Property HeaderFooter() As String
            '    Set(ByVal Value As String)
            '        strHeaderFooter = Value
            '    End Set
            'End Property

            'Public WriteOnly Property DisplayPosition() As HeaderFooterDisplayPosition
            '    Set(ByVal Value As HeaderFooterDisplayPosition)
            '        enmDisplayPosition = CType(Value, UI.cHeaderFooter.HeaderFooterDisplayPosition)
            '    End Set
            'End Property
            'Public Function DrawHeaderFooter(Optional ByVal WhizGlobal As WebPages.Template.IGlobal = Nothing, Optional ByVal returnHTML As Boolean = False) As String
            '    Dim objHeaderFooter As New WebPage.UI.cHeaderFooter()

            '    If Not Global Is Nothing Then
            '        objHeaderFooter.TagID = WhizGlobal.TagID
            '        objHeaderFooter.ParentTagID = WhizGlobal.ParentTagID
            '        objHeaderFooter.DisplayPosition = enmDisplayPosition
            '        objHeaderFooter.UseHashTable = WhizGlobal.UseHashTable
            '    End If
            '    objHeaderFooter.clsTable = "clsTable"
            '    objHeaderFooter.clsTR = "clsTRPageHeader"
            '    objHeaderFooter.DisplayPosition = enmDisplayPosition
            '    objHeaderFooter.HeaderFooter = strHeaderFooter.ToString
            '    objHeaderFooter.returnHTML = returnHTML
            '    DrawHeaderFooter = objHeaderFooter.DrawHeaderFooter()
            '    objHeaderFooter = Nothing
            'End Function

        End Class

        Public Class DynamicMenu
            Inherits WebPages.Template.DynamicMenu
            '=====================================================================
            ' Class	Name	        :	DynamicMenu
            ' Purpose				:	This is a wrapper class of CommonEngine.General.cDynamicMenu
            '                               
            ' Description			:	
            ' Assumptions			:	None
            ' Dependencies			:	None
            ' Author				:	UmeshJ
            ' Created				:	October 3, 2003
            ' Revisions				:	
            '=====================================================================
            'Private strLinkSQL As String
            'Private strUniqueID As String = ""
            'Private lngRecordCount As Long
            'Private enmDisplayposition As WebPage.UI.cDynamicMenu.LinkDisplayPosition
            'Private strClientsideScript As String
            'Private strEnabledControls As String
            'Private blnIsListPageLink As Boolean
            'Private strCommonQueryString As String = ""
            'Private strSubTagCommonQueryString As String = ""
            'Private strValidationRules As String
            'Private blnReturnClientsideScript As Boolean
            'Private strMessageForDeleteConfirm As String = "Are you sure you want to delete the selected records?"
            'Private strMessageForPagingSelect As String = "Select"
            'Private strAddNewMode_UIPage As String = "CommonPage.aspx"
            'Private strNavigationLinkSysNames As String()
            'Private strNavigationLinkNames As String()
            'Private strNavigationLinkFunctions As String()
            'Private strNavigationLinkTooltips As String()
            'Private strPagingFunctionName As String = "Page_Onclick"
            'Private blnShowSaveLink As Boolean = True
            'Private blnAddNewMode_UIPageOpenInWindow As Boolean = False
            'Private blnEditMode_UIPageOpenInWindow As Boolean = False
            'Private strMasterPrimaryKeyValue As String = ""
            'Private strAddNewLinkOnUI_CommonQueryString As String = ""
            'Private strDeletionCheckboxName As String = "chkDelete"
            'Private strSubTagID As String
            'Enum LinkDisplayPosition
            '    LIST_HEAD
            '    LIST_FOOT
            '    UI_HEAD
            '    UI_FOOT
            'End Enum

            ''Sub Tag ID..will be required for Plotting Sub Tag System Links
            'Public WriteOnly Property SubTagID() As String
            '    Set(ByVal Value As String)
            '        strSubTagID = Value
            '    End Set
            'End Property
            'Public WriteOnly Property DeletionCheckboxName() As String
            '    Set(ByVal Value As String)
            '        strDeletionCheckboxName = Value
            '    End Set
            'End Property
            'Public WriteOnly Property AddNewLinkOnUI_CommonQueryString() As String
            '    Set(ByVal Value As String)
            '        strAddNewLinkOnUI_CommonQueryString = Value
            '    End Set
            'End Property
            'Public WriteOnly Property LinkSQL() As String
            '    Set(ByVal Value As String)
            '        strLinkSQL = Value
            '    End Set
            'End Property
            'Public WriteOnly Property UniqueID() As String
            '    Set(ByVal Value As String)
            '        strUniqueID = Value
            '    End Set
            'End Property

            'Public WriteOnly Property MasterPrimaryKeyValue() As String
            '    Set(ByVal Value As String)
            '        strMasterPrimaryKeyValue = Value
            '    End Set
            'End Property

            'Public WriteOnly Property RecordCount() As Long
            '    Set(ByVal Value As Long)
            '        lngRecordCount = Value
            '    End Set
            'End Property
            'Public WriteOnly Property Displayposition() As LinkDisplayPosition
            '    Set(ByVal Value As LinkDisplayPosition)
            '        enmDisplayposition = CType(Value, WebPage.UI.cDynamicMenu.LinkDisplayPosition)
            '    End Set
            'End Property
            'Public WriteOnly Property IsListPageLink() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnIsListPageLink = Value
            '    End Set
            'End Property
            'Public WriteOnly Property ReturnClientsideScript() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnReturnClientsideScript = Value
            '    End Set
            'End Property

            'Public WriteOnly Property EnabledControls() As String
            '    Set(ByVal Value As String)
            '        strEnabledControls = Value
            '    End Set
            'End Property

            'Public ReadOnly Property ClientsideScript() As String
            '    Get
            '        Return strClientsideScript
            '    End Get
            'End Property

            'Public WriteOnly Property CommonQueryString() As String
            '    Set(ByVal Value As String)
            '        strCommonQueryString = Value
            '    End Set
            'End Property

            'Public WriteOnly Property SubTagCommonQueryString() As String
            '    Set(ByVal Value As String)
            '        strSubTagCommonQueryString = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ValidationRules() As String
            '    Set(ByVal Value As String)
            '        strValidationRules = Value
            '    End Set
            'End Property

            'Public WriteOnly Property MessageForDeleteConfirm() As String
            '    Set(ByVal Value As String)
            '        strMessageForDeleteConfirm = Value
            '    End Set
            'End Property

            'Public WriteOnly Property MessageForPagingSelect() As String
            '    Set(ByVal Value As String)
            '        strMessageForPagingSelect = Value
            '    End Set
            'End Property

            'Public WriteOnly Property AddNewMode_UIPage() As String
            '    Set(ByVal Value As String)
            '        strAddNewMode_UIPage = Value
            '    End Set
            'End Property

            'Public WriteOnly Property PagingFunctionName() As String
            '    Set(ByVal Value As String)
            '        strPagingFunctionName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property NavigationLinkSysNames() As String()
            '    Set(ByVal Value As String())
            '        strNavigationLinkSysNames = Value
            '    End Set
            'End Property

            'Public WriteOnly Property NavigationLinkNames() As String()
            '    Set(ByVal Value As String())
            '        strNavigationLinkNames = Value
            '    End Set
            'End Property

            'Public WriteOnly Property NavigationLinkFunctions() As String()
            '    Set(ByVal Value As String())
            '        strNavigationLinkFunctions = Value
            '    End Set
            'End Property

            'Public WriteOnly Property NavigationLinkTooltips() As String()
            '    Set(ByVal Value As String())
            '        strNavigationLinkTooltips = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ShowSaveLink() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnShowSaveLink = Value
            '    End Set
            'End Property

            'Public WriteOnly Property AddNewMode_UIPageOpenInWindow() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnAddNewMode_UIPageOpenInWindow = Value
            '    End Set
            'End Property

            'Public WriteOnly Property EditMode_UIPageOpenInWindow() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnEditMode_UIPageOpenInWindow = Value
            '    End Set
            'End Property

            'Public Function DrawMenu(ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal Add As Boolean = False, _
            '    Optional ByVal Edit As Boolean = False, Optional ByVal Delete As Boolean = False, Optional ByVal View As Boolean = False, _
            '    Optional ByVal ShowBackLink As Boolean = False, Optional ByVal EnablePaging As Boolean = False, _
            '    Optional ByVal PagingAlphabet As String = "-1", Optional ByVal returnHTML As Boolean = False, Optional ByVal WindowHeight As Long = 600, Optional ByVal WindowWidth As Long = 700, Optional ByVal ConsiderAccessRights As Boolean = True) As String

            '    Dim cObjMenu As New WebPage.UI.cDynamicMenu(WhizGlobal)
            '    With cObjMenu
            '        'Link specific
            '        .Add = Add
            '        .Edit = Edit
            '        .Delete = Delete
            '        .View = View
            '        .cssMenuClass = "Menu"
            '        .UniqueID = strUniqueID
            '        .ShowBackLink = ShowBackLink
            '        .ShowSaveLink = blnShowSaveLink
            '        .IsListPageLink = blnIsListPageLink
            '        .EnabledControls = strEnabledControls
            '        .ValidationRules = strValidationRules
            '        .CommonQueryString = strCommonQueryString
            '        'Sub Tag Properties :Begin
            '        .SubTagCommonQueryString = strSubTagCommonQueryString
            '        .SubTagID = strSubTagID
            '        'Sub Tag Properties :End
            '        .MessageForPagingSelect = strMessageForPagingSelect
            '        .MessageForDeleteConfirm = strMessageForDeleteConfirm
            '        .RecordCount = lngRecordCount
            '        .AddNewMode_UIPage = strAddNewMode_UIPage
            '        .NavigationLinkNames = strNavigationLinkNames
            '        .NavigationLinkSysNames = strNavigationLinkSysNames
            '        .NavigationLinkFunctions = strNavigationLinkFunctions
            '        .NavigationLinkTooltips = strNavigationLinkTooltips
            '        .WindowHeight = WindowHeight
            '        .WindowWidth = WindowWidth
            '        .AddNewMode_UIPageOpenInWindow = blnAddNewMode_UIPageOpenInWindow
            '        .EditMode_UIPageOpenInWindow = blnEditMode_UIPageOpenInWindow
            '        .MasterPrimaryKeyValue = strMasterPrimaryKeyValue
            '        .AddNewLinkOnUI_CommonQueryString = strAddNewLinkOnUI_CommonQueryString
            '        'Paging Properties
            '        If EnablePaging = True Then
            '            .EnablePaging = True
            '            .PagingAlphabet = PagingAlphabet
            '            .LinkSQL = strLinkSQL
            '            .cssPagingClass = "PagingNormal"
            '            .cssPagingSelectedClass = "PagingSelected"
            '            .PagingFunctionName = strPagingFunctionName
            '            .DisplayPosition = enmDisplayposition
            '            .PagingSeperatorHTML = "|"
            '        Else
            '            .DisplayPosition = enmDisplayposition
            '        End If
            '        'generic
            '        .DeletionCheckboxName = strDeletionCheckboxName
            '        .clsTable = "clsTable"
            '        .clsTR = "clsTRMenu"
            '        .TableStyle = "border=0 cellspacing=0 cellpadding=0 width='100%'"
            '        .MenuLinkAlignment = "Right"
            '        .LinkSeperatorHTML = "|"
            '        .ReturnClientsideScript = blnReturnClientsideScript
            '        .ConsiderAccessRights = ConsiderAccessRights
            '        .returnHTML = returnHTML
            '        DrawMenu = .DrawMenu()
            '        strClientsideScript = .ClientsideScript
            '    End With
            '    cObjMenu = Nothing

            'End Function

        End Class

        Public Class PageLegends
            Inherits WebPages.Template.PageLegends
            '=====================================================================
            ' Class	Name	        :	PageLegends
            ' Purpose				:	This is a wrapper class of CommonEngine.General.cPageLegends
            '                               
            ' Description			:	
            ' Assumptions			:	None
            ' Dependencies			:	None
            ' Author				:	UmeshJ
            ' Created				:	October 3, 2003
            ' Revisions				:	
            '=====================================================================

            'Public Shared Function DrawPageLegends(ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal HTMLTagImageArray As String() = Nothing, _
            '    Optional ByVal HTMLTagCaptionArray As String() = Nothing, Optional ByVal returnHTML As Boolean = False, Optional ByVal HTMLLegend As String = "") As String
            '    Dim cObjPageLegends As New WebPage.UI.cPageLegends()
            '    'Properties from the global object
            '    If Not Global Is Nothing Then
            '        cObjPageLegends.LoginID = WhizGlobal.LoginID
            '        cObjPageLegends.TagID = WhizGlobal.TagID
            '        cObjPageLegends.ParentTagID = WhizGlobal.ParentTagID
            '        cObjPageLegends.RoleID = WhizGlobal.RoleID
            '        cObjPageLegends.ProjectID = WhizGlobal.ProjectID
            '        cObjPageLegends.LoginType = WhizGlobal.LoginType
            '        cObjPageLegends.UserID = WhizGlobal.UserID
            '        cObjPageLegends.IsCustomerCreated = WhizGlobal.IsCustomerCreated
            '    End If
            '    cObjPageLegends.HTMLTagImageArray = HTMLTagImageArray
            '    cObjPageLegends.HTMLTagCaptionArray = HTMLTagCaptionArray
            '    cObjPageLegends.returnHTML = returnHTML
            '    cObjPageLegends.HTMLLegend = HTMLLegend
            '    'ProjectByNet Template Specific Common Properties
            '    cObjPageLegends.clsTable = "clsTable"
            '    cObjPageLegends.TableStyle = "CellSpacing=0 width='100%'"
            '    cObjPageLegends.clsTR = "clsTRBlank"
            '    cObjPageLegends.EnclosingBrackets = True
            '    cObjPageLegends.StartEnclosingBracket = "("
            '    cObjPageLegends.EndEnclosingBracket = ")"
            '    DrawPageLegends = cObjPageLegends.DrawPageLegends()
            '    cObjPageLegends = Nothing
            'End Function
        End Class

        Public Class Paging
            Inherits WebPages.Template.Paging
            '=====================================================================
            ' Class	Name	        :	Paging
            ' Purpose				:	This is a wrapper class of CommonEngine.General.cPaging
            '                               
            ' Description			:	
            ' Assumptions			:	None
            ' Dependencies			:	None
            ' Author				:	UmeshJ
            ' Created				:	November 12, 2003
            ' Revisions				:	
            '=====================================================================
            'Public Shared Function DrawPaging(ByVal PagingAlphabet As String, ByVal SQL As String, Optional ByVal MessageForPagingSelect As String = "", Optional ByVal ClientSideFunctionName As String = "Page_Onclick", Optional ByVal PagingFieldName As String = "", Optional ByVal ReturnHTML As Boolean = True, Optional ByVal cssPagingClass As String = "PagingNormal", Optional ByVal cssSelectedClass As String = "PagingSelected") As String
            '    Dim objcPaging As New WebPage.UI.cPaging()
            '    With objcPaging
            '        .SQL = SQL
            '        .PagingAlphabet = PagingAlphabet
            '        .ClientSideFunctionName = ClientSideFunctionName
            '        .PagingFieldName = PagingFieldName
            '        .MessageForPagingSelect = MessageForPagingSelect
            '        .ReturnHTML = ReturnHTML
            '        .cssClass = cssPagingClass
            '        .cssSelectedClass = cssSelectedClass
            '        '.PagingAlphabetFontColor = "#FFCC00"
            '        '.NonPagingAlphabetFontColor = "WHITE"
            '        .LinkSeperatorHTML = "|"
            '        DrawPaging = objcPaging.DrawPaging.ToString
            '    End With
            '    objcPaging = Nothing
            'End Function

        End Class
        '=====================================================================
        ' Class	Name	        :	StaticMenu
        ' Purpose				:	This is a wrapper class of WebPage.UI.cStaticMenu
        '                               
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	October 7, 2003
        ' Revisions				:	
        '=====================================================================
        Public Class StaticMenu
            Inherits WebPages.Template.StaticMenu
            ''=====================================================================
            ''' Function  Name		:	DrawMenu
            ''' Parameters Passed	:	LinkArray
            '''                          ClientSideFunctionNamesArray
            '''                          ToolTipArray
            '''                          Optional returnHTML
            ''' Returns				:	Static Menu string
            ''' Parameters Affected	:	None
            ''' Purpose				:	to draw the static menu.
            ''' Description			:	
            ''' Assumptions			:	None
            ''' Dependencies			:	None
            ''' Author				:	AshishR
            ''' Created				:	Sep 29 2003
            ''' Revisions				:	
            '''=====================================================================
            'Public Shared Function DrawMenu(ByVal LinkArray As String(), ByVal ClientSideFunctionNamesArray As String(), ByVal ToolTipArray As String(), Optional ByVal returnHTML As Boolean = True, Optional ByVal PagingString As String = "", Optional ByVal cssClass As String = "") As String
            '    'Create the object of static menu class
            '    Dim objStaticMenu As New WebPage.UI.cStaticMenu()

            '    objStaticMenu.clsTable = "clsTable"
            '    If cssClass.Trim = "" Then
            '        objStaticMenu.clsTR = "clsTRMenu"
            '    Else
            '        objStaticMenu.clsTR = cssClass
            '    End If
            '    objStaticMenu.LinkSeperator = "|"
            '    objStaticMenu.cssClass = "Menu"
            '    objStaticMenu.TableStyle = "cellspacing=0 cellpadding=0 width='100%'"
            '    'objStaticMenu.LinkStyle = "TEXT-DECORATION:NONE"
            '    objStaticMenu.MenuAlignment = "right"
            '    If PagingString.Trim <> "" Then objStaticMenu.PageingString = PagingString
            '    objStaticMenu.ClientSideFunctionNames = ClientSideFunctionNamesArray
            '    objStaticMenu.ToolTip = ToolTipArray
            '    objStaticMenu.MenuNames = LinkArray
            '    objStaticMenu.returnHTML = returnHTML
            '    'call the draw method    
            '    DrawMenu = objStaticMenu.DrawMenu
            '    'destory the object
            '    objStaticMenu = Nothing

            'End Function
        End Class

        Public Class WhizGlobal
            Inherits WebPages.Template.WhizGlobal
            ''=====================================================================
            '' Class	Name	        :	Global
            '' Purpose				:	This is a global class and will be used to 
            ''                           only data transfer.    
            '' Description			:	
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	AshishR
            '' Created				:	Sep 3, 2003
            '' Revisions				:	
            ''=====================================================================
            'Private lngTagID As Long
            'Private lngRoleID As Long
            'Private lngUserID As Long
            'Private strLoginType As String = ""
            'Private lngParentTagID As Long
            'Private blnIsCustomerCreated As Boolean
            'Private lngLoginID As Long
            'Private lngProjectID As Long
            'Private strUserName As String = ""
            'Private strClsTR As String = ""
            'Private strClsTable As String = ""
            'Private blnReturnHTML As Boolean
            'Private strTableStyle As String = ""
            'Private intRoleLevel As Integer
            'Private strFromWhere As String = ""
            'Private strUseHashTables As String = ""
            'Private lngLCID As Long

            Sub New()
                MyBase.returnHTML = True
                MyBase.FromWhere = ""
                MyBase.UseHashTable = "N"
            End Sub

            Sub New(ByVal UserName As String, ByVal TagID As Long, ByVal RoleID As Long, ByVal UserID As Long, ByVal LoginType As String, Optional ByVal IsCustomerCreated As Boolean = False, Optional ByVal ParentTagID As Long = 0, Optional ByVal LoginID As Long = 0, Optional ByVal ProjectID As Long = 0, Optional ByVal clsTR As String = "", Optional ByVal clsTable As String = "", Optional ByVal TableStyle As String = "", Optional ByVal returnHTML As Boolean = True, Optional ByVal RoleLevel As Integer = 3, Optional ByVal FromWhere As String = "", Optional ByVal UseHashTables As String = "N", Optional ByVal LCID As Long = 1033)
                MyBase.TagID = TagID
                MyBase.RoleID = RoleID
                MyBase.UserID = UserID
                MyBase.LoginType = LoginType
                MyBase.ParentTagID = ParentTagID
                MyBase.IsCustomerCreated = IsCustomerCreated
                MyBase.LoginID = LoginID
                MyBase.ProjectID = ProjectID
                MyBase.UserName = UserName.ToString
                MyBase.clsTR = clsTR.ToString
                MyBase.clsTable = clsTable.ToString
                MyBase.returnHTML = returnHTML
                MyBase.TableStyle = TableStyle.ToString
                MyBase.RoleLevel = RoleLevel
                MyBase.FromWhere = FromWhere.ToString
                MyBase.UseHashTable = UseHashTables.ToString
                MyBase.LCID = LCID
            End Sub
            'Public Property LCID() As Long
            '    Get
            '        Return lngLCID
            '    End Get
            '    Set(ByVal Value As Long)
            '        lngLCID = Value
            '    End Set
            'End Property
            'Public Property TagID() As Long
            '    Get
            '        Return lngTagID
            '    End Get
            '    Set(ByVal Value As Long)
            '        lngTagID = Value
            '    End Set
            'End Property
            'Public Property RoleID() As Long
            '    Get
            '        Return lngRoleID
            '    End Get
            '    Set(ByVal Value As Long)
            '        lngRoleID = Value
            '    End Set
            'End Property
            'Public Property UserID() As Long
            '    Get
            '        Return lngUserID
            '    End Get
            '    Set(ByVal Value As Long)
            '        lngUserID = Value
            '    End Set
            'End Property
            'Public Property LoginType() As String
            '    Get
            '        Return strLoginType
            '    End Get
            '    Set(ByVal Value As String)
            '        strLoginType = Value
            '    End Set
            'End Property
            'Public Property ParentTagID() As Long
            '    Get
            '        Return lngParentTagID
            '    End Get
            '    Set(ByVal Value As Long)
            '        lngParentTagID = Value
            '    End Set
            'End Property
            'Public Property IsCustomerCreated() As Boolean
            '    Get
            '        Return blnIsCustomerCreated
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        blnIsCustomerCreated = Value
            '    End Set
            'End Property
            'Public Property LoginID() As Long
            '    Get
            '        Return lngLoginID
            '    End Get
            '    Set(ByVal Value As Long)
            '        lngLoginID = Value
            '    End Set
            'End Property
            'Public Property ProjectID() As Long
            '    Get
            '        Return lngProjectID
            '    End Get
            '    Set(ByVal Value As Long)
            '        lngProjectID = Value
            '    End Set
            'End Property
            'Public Property UserName() As String
            '    Get
            '        Return strUserName
            '    End Get
            '    Set(ByVal Value As String)
            '        strUserName = Value
            '    End Set
            'End Property
            'Public Property clsTR() As String
            '    Get
            '        Return strClsTR.ToString
            '    End Get
            '    Set(ByVal Value As String)
            '        strClsTR = Value.ToString

            '    End Set
            'End Property
            'Public Property clsTable() As String
            '    Get
            '        Return strClsTable.ToString
            '    End Get
            '    Set(ByVal Value As String)
            '        strClsTable = Value.ToString
            '    End Set
            'End Property
            'Public Property TableStyle() As String
            '    Get
            '        Return strTableStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        strTableStyle = Value.ToString
            '    End Set
            'End Property
            'Public Property returnHTML() As Boolean
            '    Get
            '        Return blnReturnHTML
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        blnReturnHTML = Value
            '    End Set
            'End Property
            'Public Property RoleLevel() As Integer
            '    Get
            '        Return intRoleLevel
            '    End Get
            '    Set(ByVal Value As Integer)
            '        intRoleLevel = Value
            '    End Set
            'End Property
            'Public Property FromWhere() As String
            '    Get
            '        Return strFromWhere
            '    End Get
            '    Set(ByVal Value As String)
            '        strFromWhere = Value.ToString
            '    End Set
            'End Property
            'Public Property UseHashTable() As String
            '    Get
            '        Return strUseHashTables.ToString
            '    End Get
            '    Set(ByVal Value As String)
            '        strUseHashTables = Value
            '    End Set
            'End Property
        End Class

        Public Class HttpApplicationTemplate
            Inherits WebPages.Template.HttpApplicationTemplate
            Protected Overrides Sub Application_OnStart(ByVal sender As Object, ByVal e As System.EventArgs)
                CommonFunctions.General.GetCorporateSettings(True)
                CommonFunction.General.LoadCompanyApplicationSettings()
                'added by SachinR   on 01 Nov 2004
                'create hashtable for the deliverable field config objects
                CommonEngine.HashTables.Deliverable.CreateDeliverableHashTable()
                'addition end   on 01 Nov 2004
                ' Added By MahendraV On 10:38 AM 10/1/2007 For WhizibleSEM 7.1 Customization 
                ' Purpose : To remember user information of current computer for Show Pending Approvals.
                ' Start_MV_10/1/2007
                Application.Add("LoginUsers", New Hashtable)
                ' End_MV_10/1/2007
            End Sub

            Protected Overrides Sub Application_OnEnd(ByVal sender As Object, ByVal e As System.EventArgs)
                'added by SachinR   on 01 Nov 2004
                'dispose hashtable for the deliverable field config objects
                ' CommonEngine.HashTables.Deliverable.ClearHashTable()
                'addition end   on 01 Nov 2004
            End Sub
        End Class

        Public Class ClientSideTabs
            Inherits WebPages.Template.ClientSideTabs
            '=====================================================================
            ' Class	Name	        :	ClientSideTabs
            ' Purpose				:	This class is used for drawing the Tabs
            ' Description			:	Same as above
            ' Assumptions			:	None
            ' Dependencies			:	None
            ' Author				:	Rajanikant
            ' Created				:	Dec 24,2003
            ' Revisions				:	
            '=====================================================================
            ''Property Variables
            'Private strTabNameArray() As String
            'Private strTabInformationArray() As String
            'Private strTooltipArray() As String
            'Private strTabOnclickFunctionName As String
            'Private strDIVIDArray() As String

            'Private strClientSideScript As String = ""
            'Private strSelectedTab As String = ""
            'Private blnShowTabInformationOnSameRow As Boolean = True
            'Private strAlign As String = ""
            'Private blnNoWrap As Boolean = True
            'Private strFormName As String = ""

            'Private blnReturnHTML As Boolean = True
            'Private intTagWidthInPixel As Integer = 20
            ''Class Variables
            'Private m_objGlobal As WebPages.Template.IGlobal

            'Public WriteOnly Property FormName() As String
            '    Set(ByVal Value As String)
            '        strFormName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property DIVIDArray() As String()
            '    Set(ByVal Value As String())
            '        strDIVIDArray = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ShowTabInformationOnSameRow() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnShowTabInformationOnSameRow = Value
            '    End Set
            'End Property

            'Public WriteOnly Property TabNameArray() As String()
            '    Set(ByVal Value As String())
            '        strTabNameArray = Value
            '    End Set
            'End Property

            'Public WriteOnly Property TabInformationArray() As String()
            '    Set(ByVal Value As String())
            '        strTabInformationArray = Value
            '    End Set
            'End Property

            'Public WriteOnly Property TooltipArray() As String()
            '    Set(ByVal Value As String())
            '        strTooltipArray = Value
            '    End Set
            'End Property

            'Public WriteOnly Property TabOnclickFunctionName() As String
            '    Set(ByVal Value As String)
            '        strTabOnclickFunctionName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property SelectedTab() As String
            '    Set(ByVal Value As String)
            '        strSelectedTab = Value
            '    End Set
            'End Property

            'Public WriteOnly Property Align() As String
            '    Set(ByVal Value As String)
            '        strAlign = Value
            '    End Set
            'End Property

            'Public WriteOnly Property NoWrap() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnNoWrap = Value
            '    End Set
            'End Property


            'Public WriteOnly Property ReturnHTML() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnReturnHTML = Value
            '    End Set
            'End Property

            'Public ReadOnly Property ClientSideScript() As String
            '    Get
            '        ClientSideScript = strClientSideScript
            '    End Get
            'End Property

            'Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            '    'Assign the Parameter values to the local variables
            '    m_objGlobal = WhizGlobal
            'End Sub

            'Public Sub New()

            'End Sub

            'Public Function DrawTabs() As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawTabs
            '    ' Description           :   This method will build the complete HTML
            '    '                           Table for the Tabs
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Return the HTML string for the caption to the caller  
            '    '                          when returnHTML=true else will write the reponse
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : cClientSideTabs
            '    ' Author                : Rajanikant
            '    ' Created               : Dec 24,2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim objTab As New WebPage.UI.cClientSideTabs()
            '    With objTab
            '        .Align = strAlign
            '        .DIVIDArray = strDIVIDArray
            '        .FormName = strFormName
            '        .NoWrap = blnNoWrap
            '        .ReturnHTML = blnReturnHTML
            '        .SelectedTab = strSelectedTab
            '        .ShowTabInformationOnSameRow = blnShowTabInformationOnSameRow
            '        .TabInformationArray = strTabInformationArray
            '        .TabNameArray = strTabNameArray
            '        .TabOnclickFunctionName = strTabOnclickFunctionName
            '        .TooltipArray = strTooltipArray
            '        .clsTab = "navtab"
            '        .clsTable = "clsTable"
            '        .clsTabSelected = "clsTabSelected"
            '        .TableStyle = " BORDER=0 cellspacing=0 "
            '        .DrawTabs()
            '        strClientSideScript = .ClientSideScript
            '    End With
            '    objTab = Nothing

            'End Function


        End Class

        Public Class RoleLevelAccessFilters
            Inherits WebPages.Template.RoleLevelAccessFilters
            ''=====================================================================
            '' Class	Name	        :	RoleLevelAccessRights
            '' Purpose				:	This is a wrapper class for getting the role
            ''                           level access filters
            '' Description			:	The class has a method GetAccessFilters()
            '' Assumptions			:	None
            '' Dependencies			:	cRoleLevelAccessFilter
            '' Author				:	Rajanikant
            '' Created				:	Jan 12,2004
            '' Revisions				:	
            ''=====================================================================

            'Public Shared Function GetAccessFilters( _
            '                ByVal UseSQL As Boolean, _
            '                Optional ByVal EntityID As Long = 0, _
            '                Optional ByVal AccessKey As String = "", _
            '                Optional ByVal ShowReleasedProjects As Boolean = True, _
            '                Optional ByVal RoleLevel As Integer = 0 _
            '                ) As String
            '    '=====================================================================
            '    ' Procedure Name        : GetAccessFilters
            '    ' Purpose               : To get the access filters for the parameters
            '    '                         for the user attribs from session
            '    ' Description           : same as above
            '    ' Parameters Passed     : [EntityID] = EntityID from tbl_QRB_DataDictionary_Master
            '    '                         [ExistingFilterCondition] = Based on this AND condition is applied
            '    '                         [AccessKey]= The key on which filter is required
            '    ' Returns               : Filters as string
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : WebPage.Filters.cRoleLevelAccessFilter,CommonFunctions.Data
            '    ' Author                : Rajanikant
            '    ' Created               : Jan 12,2004
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim objQRB As WebPage.Filters.cRoleLevelAccessFilter
            '    Dim dr As IDataReader
            '    Dim strFilters As String = ""

            '    ' the role level 
            '    If RoleLevel = 0 Then RoleLevel = CType(HttpContext.Current.Session("intRoleLevel"), Integer)

            '    If EntityID <> 0 Then
            '        ' when entity id is passed we check for all possibilities of
            '        ' applying filters( thus we check for all attribs of the entity) 
            '        dr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_QRB_DataDictionary_Details " + EntityID.ToString, UseSQL)
            '        Do While dr.Read
            '            objQRB = New WebPage.Filters.cRoleLevelAccessFilter(HttpContext.Current.Session("strUserName").ToString, CType(HttpContext.Current.Session("intPostID"), Long), CType(HttpContext.Current.Session("intUserID"), Long), HttpContext.Current.Session("LoginType").ToString, CType(HttpContext.Current.Session("intLoginID"), Long), RoleLevel, CType(HttpContext.Current.Session("IsCreatedByCustomer"), Boolean))
            '            objQRB.UseSQL = UseSQL
            '            objQRB.ShowReleasedProjects = ShowReleasedProjects
            '            Select Case dr("AttributeName").ToString.Trim.ToUpper
            '                Case "PROJECTNAME"
            '                    objQRB.AccessParameter = "PROJECTNAME"
            '                    If Not objQRB Is Nothing Then
            '                        If strFilters.Trim <> "" Then
            '                            strFilters += " AND "
            '                        End If
            '                        strFilters += objQRB.GetRoleLevelAccessFilter()
            '                    End If
            '                Case "USERNAME"
            '                    objQRB.AccessParameter = "USERNAME"
            '                    If Not objQRB Is Nothing Then
            '                        If strFilters.Trim <> "" Then
            '                            strFilters += " AND "
            '                        End If
            '                        strFilters += objQRB.GetRoleLevelAccessFilter()
            '                    End If
            '                Case "PROJECTGROUPNAME"
            '                    objQRB.AccessParameter = "PROJECTGROUPNAME"
            '                    If Not objQRB Is Nothing Then
            '                        If strFilters.Trim <> "" Then
            '                            strFilters += " AND "
            '                        End If
            '                        strFilters += objQRB.GetRoleLevelAccessFilter()
            '                    End If
            '                Case "CUSTOMERNAME"
            '                    objQRB.AccessParameter = "CUSTOMERNAME"
            '                    If Not objQRB Is Nothing Then
            '                        If strFilters.Trim <> "" Then
            '                            strFilters += " AND "
            '                        End If
            '                        strFilters += objQRB.GetRoleLevelAccessFilter()
            '                    End If
            '                Case Else
            '            End Select
            '            objQRB = Nothing
            '        Loop
            '        dr.Close() : dr.Dispose() : dr = Nothing

            '        ' get the role specific filters for the entity
            '        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_DefaultRoleEntityFilters  " & EntityID & "," & CType(HttpContext.Current.Session("intPostID"), Long), UseSQL)
            '        If dr.Read Then
            '            If Not IsDBNull(dr("DefaultFilter")) Then
            '                If Trim(dr("DefaultFilter").ToString & "") <> "" Then
            '                    If Trim(strFilters & "") <> "" Then
            '                        strFilters += " AND (" & dr("DefaultFilter").ToString & ")"
            '                    Else
            '                        strFilters = "(" & dr("DefaultFilter").ToString & ")"
            '                    End If
            '                End If
            '            End If
            '        End If
            '        dr.Close() : dr.Dispose() : dr = Nothing

            '    Else
            '        ' Access Key must be specified for this case
            '        If Trim(AccessKey & "") <> "" Then
            '            objQRB = New WebPage.Filters.cRoleLevelAccessFilter(HttpContext.Current.Session("strUserName").ToString, CType(HttpContext.Current.Session("intPostID"), Long), CType(HttpContext.Current.Session("intUserID"), Long), HttpContext.Current.Session("LoginType").ToString, CType(HttpContext.Current.Session("intLoginID"), Long), CType(HttpContext.Current.Session("intRoleLevel"), Integer), CType(HttpContext.Current.Session("IsCreatedByCustomer"), Boolean))
            '            objQRB.UseSQL = UseSQL
            '            objQRB.ShowReleasedProjects = ShowReleasedProjects
            '            objQRB.AccessParameter = AccessKey
            '            strFilters = objQRB.GetRoleLevelAccessFilter()
            '            objQRB = Nothing
            '        End If
            '    End If

            '    Return strFilters

            'End Function

        End Class

        Public Class GenericGrid
            Inherits WebPages.Template.GenericGrid
            ''=====================================================================
            '' Class	Name	        :	cGenericGrid
            '' Purpose				:	This class builds the GRID for the specified 
            ''                           values 
            '' Description			:	This class is inherited from cGrid class
            ''                           
            '' Assumptions			:	None
            '' Dependencies			:	
            '' Author				:	Rajanikant
            '' Created				:	September 09,2003
            '' Revisions				:	
            ''=====================================================================
            'Private m_arrUserFriendlyColumn() As String = {}
            'Private m_arrActualColumn() As String = {}
            'Private m_arrCheckBoxID() As String
            'Private m_arrCheckboxCheckOnColumn() As String
            'Private m_arrCheckboxDisableOnColumn() As String
            'Private m_arrRowLink() As String
            'Private m_arrRowLinkToolTip() As String
            'Private m_arrRowLinkEnableOnColumn() As String
            'Private m_arrReplacementValue() As String
            'Private m_arrTDStyle() As String
            'Private m_intNoOfRows As Integer = 0
            'Private m_intDIVHeight As Integer = 300
            'Private m_intNoOfDataColumns As Integer = 0
            'Private m_blnColNameToolTipOnEachRow As Boolean = False
            'Private m_blnVerticalDisplay As Boolean = False
            'Private m_blnReturnHTML As Boolean = False
            'Private m_blnPrinterFriendlyVersion As Boolean = False
            'Private m_strPrimaryKey As String = ""
            'Private m_strHorizontalSeparatorHTML As String = ""
            'Private m_strColumnHeaderAlignment As String = ""
            'Private m_strBooleanTrueHTML As String = "Yes"
            'Private m_strBooleanFalseHTML As String = "No"
            'Private m_strDIVStyle As String = "overflow:auto"
            'Private m_strDIVID As String = "DivList"
            'Private m_strHeaderHTML As String = ""
            'Private m_strFooterHTML As String = ""
            'Private m_strSortBy As String = ""
            'Private m_strSortOrder As String = ""
            'Private m_strSQL As String = ""
            'Private m_strClientSideSortFunctionName As String = ""
            'Private m_strEmptyValueReplacement As String = "&lt;Not Specified&gt;"
            'Private m_blnUseSQL As Boolean
            'Private m_strNoDataComment As String = "There are no items to show in this view"


            'Private m_lngCurrentPage As Long = 0
            'Private m_lngPageSize As Long = 0
            'Private m_lngFirstRow As Long = -1
            'Private m_lngLastRow As Long = -1
            'Private m_intNoOfRowsInPage As Integer = 0

            '' group arrays
            'Private m_arrGroupOnColumn() As String '= {}
            'Private m_arrGroupSummaryFunc() As String = {}
            'Private m_arrIgnoreHTMLEncode() As String = {}

            '' Private m_strGroupTRStyle As String = "clsTRSectionTitle"

            'Public Property GroupOnColumn() As String()
            '    Get
            '        GroupOnColumn = m_arrGroupOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrGroupOnColumn = Value
            '    End Set
            'End Property
            'Public Property GroupSummaryFunc() As String()
            '    Get
            '        GroupSummaryFunc = m_arrGroupSummaryFunc
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrGroupSummaryFunc = Value
            '    End Set
            'End Property

            '' check box related
            'Public Property CheckBoxIDArray() As String()
            '    Get
            '        CheckBoxIDArray = m_arrCheckBoxID
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrCheckBoxID = Value
            '    End Set
            'End Property
            'Public Property CheckboxCheckOnColumnArray() As String()
            '    Get
            '        CheckboxCheckOnColumnArray = m_arrCheckboxCheckOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrCheckboxCheckOnColumn = Value
            '    End Set
            'End Property
            'Public Property CheckboxDisableOnColumnArray() As String()
            '    Get
            '        CheckboxDisableOnColumnArray = m_arrCheckboxDisableOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrCheckboxDisableOnColumn = Value
            '    End Set
            'End Property

            '' paging related
            'Public Property CurrentPage() As Long
            '    Get
            '        CurrentPage = m_lngCurrentPage
            '    End Get
            '    Set(ByVal Value As Long)
            '        m_lngCurrentPage = Value
            '    End Set
            'End Property
            'Public Property PageSize() As Long
            '    Get
            '        PageSize = m_lngPageSize
            '    End Get
            '    Set(ByVal Value As Long)
            '        m_lngPageSize = Value
            '    End Set
            'End Property

            '' column access related
            'Public Property ColumnReplacementValue() As String()
            '    Get
            '        ColumnReplacementValue = m_arrReplacementValue
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrReplacementValue = Value
            '    End Set
            'End Property

            'Public Property UseSQL() As Boolean
            '    Get
            '        UseSQL = m_blnUseSQL
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnUseSQL = Value
            '    End Set
            'End Property

            'Public Property EmptyValueReplacement() As String
            '    Get
            '        EmptyValueReplacement = m_strEmptyValueReplacement
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strEmptyValueReplacement = Value
            '    End Set
            'End Property
            'Public Property BooleanTrueHTML() As String
            '    Get
            '        BooleanTrueHTML = m_strBooleanTrueHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strBooleanTrueHTML = Value
            '    End Set
            'End Property
            'Public Property BooleanFalseHTML() As String
            '    Get
            '        BooleanFalseHTML = m_strBooleanFalseHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strBooleanFalseHTML = Value
            '    End Set
            'End Property
            'Public Property ColumnHeaderAlignment() As String
            '    Get
            '        ColumnHeaderAlignment = m_strColumnHeaderAlignment
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strColumnHeaderAlignment = Value
            '    End Set
            'End Property
            'Public Property TDStyleArray() As String()
            '    Get
            '        TDStyleArray = m_arrTDStyle
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrTDStyle = Value
            '    End Set
            'End Property
            'Public Property HorizontalSeparatorHTML() As String
            '    Get
            '        HorizontalSeparatorHTML = m_strHorizontalSeparatorHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strHorizontalSeparatorHTML = Value
            '    End Set
            'End Property
            'Public Property VerticalDisplay() As Boolean
            '    Get
            '        VerticalDisplay = m_blnVerticalDisplay
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnVerticalDisplay = Value
            '    End Set
            'End Property
            'Public Property PrimaryKey() As String
            '    Get
            '        PrimaryKey = m_strPrimaryKey
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strPrimaryKey = Value
            '    End Set
            'End Property
            'Public Property NoOfDataColumns() As Integer
            '    Get
            '        NoOfDataColumns = m_intNoOfDataColumns
            '    End Get
            '    Set(ByVal Value As Integer)
            '        m_intNoOfDataColumns = Value
            '    End Set
            'End Property
            'Public Property ColNameToolTipOnEachRow() As Boolean
            '    Get
            '        ColNameToolTipOnEachRow = m_blnColNameToolTipOnEachRow
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnColNameToolTipOnEachRow = Value
            '    End Set
            'End Property
            'Public Property DIVID() As String
            '    Get
            '        DIVID = m_strDIVID
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strDIVID = Value
            '    End Set
            'End Property
            'Public Property DIVStyle() As String
            '    Get
            '        DIVStyle = m_strDIVStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strDIVStyle = Value
            '    End Set
            'End Property
            'Public Property DIVHeight() As Integer
            '    Get
            '        DIVHeight = m_intDIVHeight
            '    End Get
            '    Set(ByVal Value As Integer)
            '        m_intDIVHeight = Value
            '    End Set
            'End Property
            'Public Property SQL() As String
            '    Get
            '        SQL = m_strSQL
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strSQL = Value
            '    End Set
            'End Property
            'Public Property ClientSideSortFunctionName() As String
            '    Get
            '        ClientSideSortFunctionName = m_strClientSideSortFunctionName
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strClientSideSortFunctionName = Value
            '    End Set
            'End Property
            'Public Property UserFriendlyColumnArray() As String()
            '    Get
            '        UserFriendlyColumnArray = m_arrUserFriendlyColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrUserFriendlyColumn = Value
            '    End Set
            'End Property
            'Public Property ActualColumnArray() As String()
            '    Get
            '        ActualColumnArray = m_arrActualColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrActualColumn = Value
            '    End Set
            'End Property
            'Public Property RowLinkArray() As String()
            '    Get
            '        RowLinkArray = m_arrRowLink
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrRowLink = Value
            '    End Set
            'End Property
            'Public Property RowLinkToolTipArray() As String()
            '    Get
            '        RowLinkToolTipArray = m_arrRowLinkToolTip
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrRowLinkToolTip = Value
            '    End Set
            'End Property
            'Public Property RowLinkEnableOnColumn() As String()
            '    Get
            '        RowLinkEnableOnColumn = m_arrRowLinkEnableOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrRowLinkEnableOnColumn = Value
            '    End Set
            'End Property
            'Public Property HeaderHTML() As String
            '    Get
            '        HeaderHTML = m_strHeaderHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strHeaderHTML = Value
            '    End Set
            'End Property
            'Public Property FooterHTML() As String
            '    Get
            '        FooterHTML = m_strFooterHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strFooterHTML = Value
            '    End Set
            'End Property
            'Public Property SortBy() As String
            '    Get
            '        SortBy = m_strSortBy
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strSortBy = Value
            '    End Set
            'End Property
            'Public Property SortOrder() As String
            '    Get
            '        SortOrder = m_strSortOrder
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strSortOrder = Value
            '    End Set
            'End Property
            'Public Property returnHTML() As Boolean
            '    Get
            '        returnHTML = m_blnReturnHTML
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnReturnHTML = Value
            '    End Set
            'End Property
            'Public ReadOnly Property NoOfRows() As Integer
            '    Get
            '        NoOfRows = m_intNoOfRows
            '    End Get
            'End Property
            'Public ReadOnly Property NoOfRowsInPage() As Integer
            '    Get
            '        NoOfRowsInPage = m_intNoOfRowsInPage
            '    End Get
            'End Property
            'Public Property PrinterFriendlyVersion() As Boolean
            '    Get
            '        PrinterFriendlyVersion = m_blnPrinterFriendlyVersion
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnPrinterFriendlyVersion = Value
            '    End Set
            'End Property
            'Public Property IgnoreHTMLEncode() As String()
            '    Get
            '        IgnoreHTMLEncode = m_arrIgnoreHTMLEncode
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrIgnoreHTMLEncode = Value
            '    End Set
            'End Property
            'Public Function DrawGrid() As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawGrid
            '    ' Purpose               : To draw the grid
            '    ' Description           : This is a wrapper class of class cGenericGrid(generic.vb)
            '    '                         This class is used as a template class for drawing grids
            '    ' Parameters Passed     : None
            '    ' Returns               : string of grid if property returnHTML = true
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : WebPage.Grid.cGenericGrid,WebPage.Templates.WhizTemplate
            '    ' Author                : Rajanikant
            '    ' Created               : Jan 13,2004
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim objGrid As WebPage.Grid.cGenericGrid
            '    Dim objResources As WebPages.Template.WhizTemplate

            '    objGrid = New WebPage.Grid.cGenericGrid
            '    ' draw the grid
            '    With objGrid

            '        ' column display related
            '        .ActualColumnArray = m_arrActualColumn
            '        .UserFriendlyColumnArray = m_arrUserFriendlyColumn

            '        .CheckboxCheckOnColumnArray = m_arrCheckboxCheckOnColumn
            '        .CheckboxDisableOnColumnArray = m_arrCheckboxDisableOnColumn
            '        .CheckBoxIDArray = m_arrCheckBoxID

            '        .RowLinkArray = m_arrRowLink
            '        .RowLinkEnableOnColumn = m_arrRowLinkEnableOnColumn
            '        .RowLinkToolTipArray = m_arrRowLinkToolTip

            '        .NoOfDataColumns = m_intNoOfDataColumns

            '        ' display related
            '        .ColNameToolTipOnEachRow = m_blnColNameToolTipOnEachRow
            '        .ColumnHeaderAlignment = m_strColumnHeaderAlignment
            '        .ColumnReplacementValue = m_arrReplacementValue

            '        .BooleanFalseHTML = m_strBooleanFalseHTML
            '        .BooleanTrueHTML = m_strBooleanTrueHTML

            '        .DIVHeight = m_intDIVHeight
            '        .DIVID = m_strDIVID
            '        .DIVStyle = m_strDIVStyle

            '        .TDStyleArray = m_arrTDStyle

            '        .EmptyValueReplacement = m_strEmptyValueReplacement
            '        .FooterHTML = m_strFooterHTML
            '        .HeaderHTML = m_strHeaderHTML
            '        .HorizontalSeparatorHTML = m_strHorizontalSeparatorHTML



            '        ' paging related
            '        .CurrentPage = m_lngCurrentPage
            '        .PageSize = m_lngPageSize

            '        .PrimaryKey = m_strPrimaryKey
            '        .PrinterFriendlyVersion = m_blnPrinterFriendlyVersion
            '        .returnHTML = m_blnReturnHTML
            '        .VerticalDisplay = m_blnVerticalDisplay

            '        ' sorting related
            '        .ClientSideSortFunctionName = m_strClientSideSortFunctionName
            '        .SortBy = m_strSortBy
            '        .SortOrder = m_strSortOrder

            '        ' template related
            '        .TableStyle = "cellpadding=0 cellspacing=0"
            '        .SortByImage = "../../Images/SortBy.gif"
            '        .SortDownImage = "../../Images/Sort_Down.gif"
            '        .SortedTDStyle = "clsTDSortColHeader"
            '        .SortUpImage = "../../Images/Sort_up.gif"
            '        .clsColumnHeader = "clsTRColumnHeader"
            '        .clsTable = "clsTable"
            '        .clsTREven = "clsTREven"
            '        .clsTROdd = "clsTROdd"
            '        objResources = New WebPages.Template.WhizTemplate
            '        objResources.InitializeResources("Resources.StandardMessages", "Resources")
            '        .NoDataComment = objResources.GetResourceString("NO_RECORDS")
            '        objResources = Nothing

            '        .GroupOnColumn = m_arrGroupOnColumn
            '        .GroupSummaryFunc = m_arrGroupSummaryFunc
            '        .GroupTRStyle = "clsTRColumnHeader"

            '        .IgnoreHTMLEncode = m_arrIgnoreHTMLEncode

            '        ' data source related
            '        .SQL = m_strSQL
            '        .UseSQL = m_blnUseSQL

            '        DrawGrid = .DrawGrid()

            '        ' get properties
            '        m_intNoOfRowsInPage = .NoOfRowsInPage
            '        m_intNoOfRows = .NoOfRows
            '    End With
            '    objGrid = Nothing
            'End Function
        End Class




        Public Class AdvancedGrid
            Inherits WebPages.Template.AdvancedGrid
            ''=====================================================================
            '' Class	Name	        :	cAdvancedGrid
            '' Purpose				:	This class builds the GRID for the specified 
            ''                           values 
            '' Description			:	This class is inherited from cGrid class
            ''                           
            '' Assumptions			:	None
            '' Dependencies			:	
            '' Author				:	Rajanikant
            '' Created				:	Feb 02,2003
            '' Revisions				:	
            ''=====================================================================
            'Private m_arrUserFriendlyColumn() As String = {}
            'Private m_arrActualColumn() As String = {}
            'Private m_arrCheckBoxID() As String
            'Private m_arrCheckboxCheckOnColumn() As String
            'Private m_arrCheckboxDisableOnColumn() As String
            'Private m_arrRowLink() As String
            'Private m_arrRowLinkToolTip() As String
            'Private m_arrRowLinkEnableOnColumn() As String
            'Private m_arrReplacementValue() As String
            'Private m_arrTDStyle() As String
            'Private m_intNoOfRows As Integer = 0
            'Private m_intDIVHeight As Integer = 300
            'Private m_intNoOfDataColumns As Integer = 0
            'Private m_blnColNameToolTipOnEachRow As Boolean = False
            'Private m_blnVerticalDisplay As Boolean = False
            'Private m_blnReturnHTML As Boolean = False
            'Private m_blnPrinterFriendlyVersion As Boolean = False
            'Private m_strPrimaryKey As String = ""
            'Private m_strHorizontalSeparatorHTML As String = ""
            'Private m_strColumnHeaderAlignment As String = ""
            'Private m_strBooleanTrueHTML As String = "Yes"
            'Private m_strBooleanFalseHTML As String = "No"
            'Private m_strDIVStyle As String = "overflow:auto"
            'Private m_strDIVID As String = "DivList"
            'Private m_strHeaderHTML As String = ""
            'Private m_strFooterHTML As String = ""
            'Private m_strSortBy As String = ""
            'Private m_strSortOrder As String = ""
            'Private m_strSQL As String = ""
            'Private m_strClientSideSortFunctionName As String = ""
            'Private m_strEmptyValueReplacement As String = "&lt;Not Specified&gt;"
            'Private m_blnUseSQL As Boolean
            'Private m_strNoDataComment As String = "There are no items to show in this view"


            'Private m_lngCurrentPage As Long = 0
            'Private m_lngPageSize As Long = 0
            'Private m_lngFirstRow As Long = -1
            'Private m_lngLastRow As Long = -1
            'Private m_intNoOfRowsInPage As Integer = 0

            '' group arrays
            'Private m_arrGroupOnColumn() As String '= {}
            'Private m_arrGroupSummaryFunc() As String = {}

            '' collapsible col properties
            'Private m_arrColumnGroupNames() As String = {}         ' "grp 1","grp 2"
            'Private m_arrColumnGroupColumns() As String = {}       ' "1-3","4-6"
            'Private m_arrColumnGroupExpanded() As String = {}     ' "1","0"
            'Private m_strExpandCollapseClientSideFunctionName As String = "ExpandCollapse_OnClick"

            'Private m_arrIgnoreHTMLEncode() As String = {}

            'Public Property ExpandCollapseClientSideFunctionName() As String
            '    Get
            '        ExpandCollapseClientSideFunctionName = m_strExpandCollapseClientSideFunctionName
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strExpandCollapseClientSideFunctionName = Value
            '    End Set
            'End Property

            'Public Property ColumnGroupNameArray() As String()
            '    Get
            '        ColumnGroupNameArray = m_arrColumnGroupNames
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrColumnGroupNames = Value
            '    End Set
            'End Property

            'Public Property ColumnGroupColumnsArray() As String()
            '    Get
            '        ColumnGroupColumnsArray = m_arrColumnGroupColumns
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrColumnGroupColumns = Value
            '    End Set
            'End Property

            'Public Property ColumnGroupExpandedArray() As String()
            '    Get
            '        ColumnGroupExpandedArray = m_arrColumnGroupExpanded
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrColumnGroupExpanded = Value
            '    End Set
            'End Property

            'Public Property GroupOnColumn() As String()
            '    Get
            '        GroupOnColumn = m_arrGroupOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrGroupOnColumn = Value
            '    End Set
            'End Property
            'Public Property GroupSummaryFunc() As String()
            '    Get
            '        GroupSummaryFunc = m_arrGroupSummaryFunc
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrGroupSummaryFunc = Value
            '    End Set
            'End Property

            '' check box related
            'Public Property CheckBoxIDArray() As String()
            '    Get
            '        CheckBoxIDArray = m_arrCheckBoxID
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrCheckBoxID = Value
            '    End Set
            'End Property
            'Public Property CheckboxCheckOnColumnArray() As String()
            '    Get
            '        CheckboxCheckOnColumnArray = m_arrCheckboxCheckOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrCheckboxCheckOnColumn = Value
            '    End Set
            'End Property
            'Public Property CheckboxDisableOnColumnArray() As String()
            '    Get
            '        CheckboxDisableOnColumnArray = m_arrCheckboxDisableOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrCheckboxDisableOnColumn = Value
            '    End Set
            'End Property

            '' paging related
            'Public Property CurrentPage() As Long
            '    Get
            '        CurrentPage = m_lngCurrentPage
            '    End Get
            '    Set(ByVal Value As Long)
            '        m_lngCurrentPage = Value
            '    End Set
            'End Property
            'Public Property PageSize() As Long
            '    Get
            '        PageSize = m_lngPageSize
            '    End Get
            '    Set(ByVal Value As Long)
            '        m_lngPageSize = Value
            '    End Set
            'End Property

            '' column access related
            'Public Property ColumnReplacementValue() As String()
            '    Get
            '        ColumnReplacementValue = m_arrReplacementValue
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrReplacementValue = Value
            '    End Set
            'End Property

            'Public Property UseSQL() As Boolean
            '    Get
            '        UseSQL = m_blnUseSQL
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnUseSQL = Value
            '    End Set
            'End Property

            'Public Property EmptyValueReplacement() As String
            '    Get
            '        EmptyValueReplacement = m_strEmptyValueReplacement
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strEmptyValueReplacement = Value
            '    End Set
            'End Property
            'Public Property BooleanTrueHTML() As String
            '    Get
            '        BooleanTrueHTML = m_strBooleanTrueHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strBooleanTrueHTML = Value
            '    End Set
            'End Property
            'Public Property BooleanFalseHTML() As String
            '    Get
            '        BooleanFalseHTML = m_strBooleanFalseHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strBooleanFalseHTML = Value
            '    End Set
            'End Property
            'Public Property ColumnHeaderAlignment() As String
            '    Get
            '        ColumnHeaderAlignment = m_strColumnHeaderAlignment
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strColumnHeaderAlignment = Value
            '    End Set
            'End Property
            'Public Property TDStyleArray() As String()
            '    Get
            '        TDStyleArray = m_arrTDStyle
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrTDStyle = Value
            '    End Set
            'End Property
            'Public Property HorizontalSeparatorHTML() As String
            '    Get
            '        HorizontalSeparatorHTML = m_strHorizontalSeparatorHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strHorizontalSeparatorHTML = Value
            '    End Set
            'End Property
            'Public Property VerticalDisplay() As Boolean
            '    Get
            '        VerticalDisplay = m_blnVerticalDisplay
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnVerticalDisplay = Value
            '    End Set
            'End Property
            'Public Property PrimaryKey() As String
            '    Get
            '        PrimaryKey = m_strPrimaryKey
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strPrimaryKey = Value
            '    End Set
            'End Property
            'Public Property NoOfDataColumns() As Integer
            '    Get
            '        NoOfDataColumns = m_intNoOfDataColumns
            '    End Get
            '    Set(ByVal Value As Integer)
            '        m_intNoOfDataColumns = Value
            '    End Set
            'End Property
            'Public Property ColNameToolTipOnEachRow() As Boolean
            '    Get
            '        ColNameToolTipOnEachRow = m_blnColNameToolTipOnEachRow
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnColNameToolTipOnEachRow = Value
            '    End Set
            'End Property
            'Public Property DIVID() As String
            '    Get
            '        DIVID = m_strDIVID
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strDIVID = Value
            '    End Set
            'End Property
            'Public Property DIVStyle() As String
            '    Get
            '        DIVStyle = m_strDIVStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strDIVStyle = Value
            '    End Set
            'End Property
            'Public Property DIVHeight() As Integer
            '    Get
            '        DIVHeight = m_intDIVHeight
            '    End Get
            '    Set(ByVal Value As Integer)
            '        m_intDIVHeight = Value
            '    End Set
            'End Property
            'Public Property SQL() As String
            '    Get
            '        SQL = m_strSQL
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strSQL = Value
            '    End Set
            'End Property
            'Public Property ClientSideSortFunctionName() As String
            '    Get
            '        ClientSideSortFunctionName = m_strClientSideSortFunctionName
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strClientSideSortFunctionName = Value
            '    End Set
            'End Property
            'Public Property UserFriendlyColumnArray() As String()
            '    Get
            '        UserFriendlyColumnArray = m_arrUserFriendlyColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrUserFriendlyColumn = Value
            '    End Set
            'End Property
            'Public Property ActualColumnArray() As String()
            '    Get
            '        ActualColumnArray = m_arrActualColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrActualColumn = Value
            '    End Set
            'End Property
            'Public Property RowLinkArray() As String()
            '    Get
            '        RowLinkArray = m_arrRowLink
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrRowLink = Value
            '    End Set
            'End Property
            'Public Property RowLinkToolTipArray() As String()
            '    Get
            '        RowLinkToolTipArray = m_arrRowLinkToolTip
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrRowLinkToolTip = Value
            '    End Set
            'End Property
            'Public Property RowLinkEnableOnColumn() As String()
            '    Get
            '        RowLinkEnableOnColumn = m_arrRowLinkEnableOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrRowLinkEnableOnColumn = Value
            '    End Set
            'End Property
            'Public Property HeaderHTML() As String
            '    Get
            '        HeaderHTML = m_strHeaderHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strHeaderHTML = Value
            '    End Set
            'End Property
            'Public Property FooterHTML() As String
            '    Get
            '        FooterHTML = m_strFooterHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strFooterHTML = Value
            '    End Set
            'End Property
            'Public Property SortBy() As String
            '    Get
            '        SortBy = m_strSortBy
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strSortBy = Value
            '    End Set
            'End Property
            'Public Property SortOrder() As String
            '    Get
            '        SortOrder = m_strSortOrder
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strSortOrder = Value
            '    End Set
            'End Property
            'Public Property returnHTML() As Boolean
            '    Get
            '        returnHTML = m_blnReturnHTML
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnReturnHTML = Value
            '    End Set
            'End Property
            'Public ReadOnly Property NoOfRows() As Integer
            '    Get
            '        NoOfRows = m_intNoOfRows
            '    End Get
            'End Property
            'Public ReadOnly Property NoOfRowsInPage() As Integer
            '    Get
            '        NoOfRowsInPage = m_intNoOfRowsInPage
            '    End Get
            'End Property
            'Public Property PrinterFriendlyVersion() As Boolean
            '    Get
            '        PrinterFriendlyVersion = m_blnPrinterFriendlyVersion
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnPrinterFriendlyVersion = Value
            '    End Set
            'End Property

            'Public Property IgnoreHTMLEncode() As String()
            '    Get
            '        IgnoreHTMLEncode = m_arrIgnoreHTMLEncode
            '    End Get
            '    Set(ByVal Value As String())
            '        m_arrIgnoreHTMLEncode = Value
            '    End Set
            'End Property

            'Public Function DrawGrid() As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawGrid
            '    ' Purpose               : To draw the grid
            '    ' Description           : This is a wrapper class of class cGenericGrid(generic.vb)
            '    '                         This class is used as a template class for drawing grids
            '    ' Parameters Passed     : None
            '    ' Returns               : string of grid if property returnHTML = true
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : WebPage.Grid.cGenericGrid,WebPage.Templates.WhizTemplate
            '    ' Author                : Rajanikant
            '    ' Created               : Feb 02,2004
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim objGrid As WebPage.Grid.cAdvancedGrid
            '    Dim objResources As WebPages.Template.WhizTemplate

            '    objGrid = New WebPage.Grid.cAdvancedGrid
            '    ' draw the grid
            '    With objGrid

            '        ' column display related
            '        .ActualColumnArray = m_arrActualColumn
            '        .UserFriendlyColumnArray = m_arrUserFriendlyColumn

            '        .CheckboxCheckOnColumnArray = m_arrCheckboxCheckOnColumn
            '        .CheckboxDisableOnColumnArray = m_arrCheckboxDisableOnColumn
            '        .CheckBoxIDArray = m_arrCheckBoxID

            '        .RowLinkArray = m_arrRowLink
            '        .RowLinkEnableOnColumn = m_arrRowLinkEnableOnColumn
            '        .RowLinkToolTipArray = m_arrRowLinkToolTip

            '        .NoOfDataColumns = m_intNoOfDataColumns

            '        ' display related
            '        .ColNameToolTipOnEachRow = m_blnColNameToolTipOnEachRow
            '        .ColumnHeaderAlignment = m_strColumnHeaderAlignment
            '        .ColumnReplacementValue = m_arrReplacementValue

            '        .BooleanFalseHTML = m_strBooleanFalseHTML
            '        .BooleanTrueHTML = m_strBooleanTrueHTML

            '        .DIVHeight = m_intDIVHeight
            '        .DIVID = m_strDIVID
            '        .DIVStyle = m_strDIVStyle

            '        .TDStyleArray = m_arrTDStyle

            '        .EmptyValueReplacement = m_strEmptyValueReplacement
            '        .FooterHTML = m_strFooterHTML
            '        .HeaderHTML = m_strHeaderHTML
            '        .HorizontalSeparatorHTML = m_strHorizontalSeparatorHTML



            '        ' paging related
            '        .CurrentPage = m_lngCurrentPage
            '        .PageSize = m_lngPageSize

            '        .PrimaryKey = m_strPrimaryKey
            '        .PrinterFriendlyVersion = m_blnPrinterFriendlyVersion
            '        .returnHTML = m_blnReturnHTML
            '        .VerticalDisplay = m_blnVerticalDisplay

            '        ' sorting related
            '        .ClientSideSortFunctionName = m_strClientSideSortFunctionName
            '        .SortBy = m_strSortBy
            '        .SortOrder = m_strSortOrder

            '        ' template related
            '        .TableStyle = "cellpadding=0 cellspacing=0"
            '        .SortByImage = "../../Images/SortBy.gif"
            '        .SortDownImage = "../../Images/Sort_Down.gif"
            '        .SortedTDStyle = "clsTDSortColHeader"
            '        .SortUpImage = "../../Images/Sort_up.gif"
            '        .clsColumnHeader = "clsTRColumnHeader"
            '        .clsTable = "clsTable"
            '        .clsTREven = "clsTREven"
            '        .clsTROdd = "clsTROdd"
            '        objResources = New WebPages.Template.WhizTemplate
            '        objResources.InitializeResources("Resources.StandardMessages", "Resources")
            '        .NoDataComment = objResources.GetResourceString("NO_RECORDS")
            '        objResources = Nothing

            '        .GroupOnColumn = m_arrGroupOnColumn
            '        .GroupSummaryFunc = m_arrGroupSummaryFunc
            '        .GroupTRStyle = "clsTRColumnHeader"

            '        .ColumnGroupColumnsArray = m_arrColumnGroupColumns
            '        .ColumnGroupExpandedArray = m_arrColumnGroupExpanded
            '        .ColumnGroupNameArray = m_arrColumnGroupNames
            '        .ExpandCollapseClientSideFunctionName = m_strExpandCollapseClientSideFunctionName
            '        .ExpandImage = "<img src='../../Images/minus.gif' border=0>"
            '        .CollapseImage = "<img src='../../Images/plus.gif' border=0>"
            '        .ColumnGroupTRStyle = "clsTRSectionHeader"
            '        .ColumnSeparatorTDStyle = "clsTDColumnSeparator"

            '        .IgnoreHTMLEncode = m_arrIgnoreHTMLEncode
            '        ' data source related
            '        .SQL = m_strSQL
            '        .UseSQL = m_blnUseSQL

            '        DrawGrid = .DrawGrid()

            '        ' get properties
            '        m_intNoOfRowsInPage = .NoOfRowsInPage
            '        m_intNoOfRows = .NoOfRows
            '    End With
            '    objGrid = Nothing
            'End Function
        End Class
    End Namespace
End Namespace