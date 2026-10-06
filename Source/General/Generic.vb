Imports ProjectByNet.CommonFunction
Imports System.Data.SqlClient
Imports System.Text

Namespace WebPage
    Namespace UI
        Public Class cStaticMenu
            Inherits WebPages.UI.cStaticMenu
            ''=====================================================================
            '' Class	Name	        :	cStaticMenu
            '' Purpose				:   'to create the static menus
            '' Description			:	
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	AshishR
            '' Created				:	October 9 , 2003
            '' Revisions				:	
            ''=====================================================================
            'Private m_strclsTR As String = ""
            'Private m_strclsTable As String = ""
            'Private m_strTableStyle As String = ""
            'Private m_strLinkStyle As String = ""
            'Private m_strLinkSeperator As String = ""
            'Private m_blnReturnHTML As Boolean = False
            'Private m_strMenuNames() As String
            'Private m_strClientSideFunctionNames() As String
            'Private m_strPageingString As String = ""
            'Private m_strMenuAlignment As String = "Right"
            'Private m_strToolTip() As String
            'Private m_cssClass As String = "Menu"


            'Public Property clsTR() As String
            '    Get
            '        Return m_strclsTR
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strclsTR = Value
            '    End Set
            'End Property
            'Public Property clsTable() As String
            '    Get
            '        Return m_strclsTable
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strclsTable = Value
            '    End Set
            'End Property
            'Public Property TableStyle() As String
            '    Get
            '        Return m_strTableStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strTableStyle = Value
            '    End Set
            'End Property
            'Public Property LinkStyle() As String
            '    Get
            '        Return m_strLinkStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strLinkStyle = Value
            '    End Set
            'End Property
            'Public Property LinkSeperator() As String
            '    Get
            '        Return m_strLinkSeperator
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strLinkSeperator = Value
            '    End Set
            'End Property
            'Public Property returnHTML() As Boolean
            '    Get
            '        Return m_blnReturnHTML
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        m_blnReturnHTML = Value
            '    End Set
            'End Property
            'Public Property MenuNames() As String()
            '    Get
            '        Return m_strMenuNames
            '    End Get
            '    Set(ByVal Value As String())
            '        m_strMenuNames = Value
            '    End Set
            'End Property
            'Public Property ClientSideFunctionNames() As String()
            '    Get
            '        Return m_strClientSideFunctionNames
            '    End Get
            '    Set(ByVal Value As String())
            '        m_strClientSideFunctionNames = Value
            '    End Set
            'End Property
            'Public Property ToolTip() As String()
            '    Get
            '        Return m_strToolTip
            '    End Get
            '    Set(ByVal Value As String())
            '        m_strToolTip = Value
            '    End Set
            'End Property
            'Public Property PageingString() As String
            '    Get
            '        Return m_strPageingString
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strPageingString = Value
            '    End Set
            'End Property
            'Public Property MenuAlignment() As String
            '    Get
            '        Return m_strMenuAlignment
            '    End Get
            '    Set(ByVal Value As String)
            '        m_strMenuAlignment = Value
            '    End Set
            'End Property
            'Public Property cssClass() As String
            '    Get
            '        Return m_cssClass
            '    End Get
            '    Set(ByVal Value As String)
            '        m_cssClass = Value
            '    End Set
            'End Property
            'Public Function DrawMenu() As String
            '    Dim sbMenu As New System.Text.StringBuilder()
            '    sbMenu.Append("")

            '    sbMenu.Append("<Table class=" + m_strclsTable + " " + m_strTableStyle + ">")
            '    sbMenu.Append("<TR class=" + m_strclsTR & ">")

            '    If m_strMenuAlignment.ToUpper = "RIGHT" Then
            '        If m_strPageingString.ToString.Trim <> "" Then
            '            sbMenu.Append("<TD align=left>")
            '            sbMenu.Append(m_strPageingString + "</TD>")
            '        End If
            '        sbMenu.Append("<TD align=Right>" + GetMenu() + m_strLinkSeperator + "</TD>")
            '    Else
            '        sbMenu.Append("<TD align=left>" + GetMenu() + m_strLinkSeperator + "</TD>")
            '        If m_strPageingString.ToString.Trim <> "" Then
            '            sbMenu.Append("<TD align=right>")
            '            sbMenu.Append(m_strPageingString + "</TD>")
            '        End If
            '    End If
            '    sbMenu.Append("</TR></TABLE>")
            '    If m_blnReturnHTML = True Then
            '        DrawMenu = sbMenu.ToString
            '    Else
            '        HttpContext.Current.Response.Write(sbMenu.ToString)
            '        DrawMenu = ""
            '    End If
            '    sbMenu = Nothing
            'End Function
            'Private Function GetMenu() As String
            '    Dim objDynamicLink As New WebPage.UI.cDynamicLink()
            '    Dim sbMenuString As New System.Text.StringBuilder()
            '    Dim intCount As Integer
            '    objDynamicLink.ReturnHTML = True
            '    objDynamicLink.LinkStyle = m_strLinkStyle
            '    objDynamicLink.cssClass = m_cssClass

            '    For intCount = 0 To m_strMenuNames.Length - 1

            '        If Not m_strMenuNames Is Nothing Then objDynamicLink.LinkName = m_strMenuNames(intCount).ToString
            '        If Not m_strClientSideFunctionNames Is Nothing Then objDynamicLink.FunctionName = m_strClientSideFunctionNames(intCount).ToString
            '        If Not m_strToolTip Is Nothing Then objDynamicLink.Tooltip = m_strToolTip(intCount)
            '        sbMenuString.Append(" " & m_strLinkSeperator & " " & objDynamicLink.GetDynamicLink())

            '    Next
            '    GetMenu = sbMenuString.ToString
            '    sbMenuString = Nothing
            '    objDynamicLink = Nothing

            'End Function
        End Class


        Public Class cPageLegends
            Inherits WebPages.UI.cPageLegends
            'Inherits WebPage.Templates.Global
            ''=====================================================================
            '' Class	Name	        :	cPageLegends
            '' Purpose				:	This class is used for drawing the Page 
            ''                           Legends
            '' Description			:	Same as above
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	August 30, 2003
            '' Revisions				:	
            ''=====================================================================
            ''Property Variables
            'Private blnEnclosingBrackets As Boolean
            'Private strStartEnclosingBracket As String
            'Private strEndEnclosingBracket As String
            'Private strHTMLTagImageArray() As String
            'Private strHTMLTagCaptionArray() As String
            'Private strHTMLLegend As String = ""

            'Public WriteOnly Property EnclosingBrackets() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnEnclosingBrackets = Value
            '    End Set
            'End Property

            'Public WriteOnly Property StartEnclosingBracket() As String
            '    Set(ByVal Value As String)
            '        strStartEnclosingBracket = Value
            '    End Set
            'End Property

            'Public WriteOnly Property EndEnclosingBracket() As String
            '    Set(ByVal Value As String)
            '        strEndEnclosingBracket = Value
            '    End Set
            'End Property

            'Public WriteOnly Property HTMLTagImageArray() As String()
            '    Set(ByVal Value As String())
            '        strHTMLTagImageArray = Value
            '    End Set
            'End Property

            'Public WriteOnly Property HTMLTagCaptionArray() As String()
            '    Set(ByVal Value As String())
            '        strHTMLTagCaptionArray = Value
            '    End Set
            'End Property

            'Public WriteOnly Property HTMLLegend() As String
            '    Set(ByVal Value As String)
            '        strHTMLLegend = Value
            '    End Set
            'End Property

            'Public Function DrawPageLegends() As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawPageLegends
            '    ' Description           :   This PUBLIC method will build the complete HTML
            '    '                           Table for the Page Legends
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Return the HTML string for the Legends to the caller  
            '    '                          when returnHTML=true else will write the reponse
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, August 30, 2003
            '    ' Revisions             :
            '    '=====================================================================
            '    'If no legends then exit
            '    If strHTMLTagCaptionArray Is Nothing And strHTMLLegend.Trim = "" Then Return ""

            '    Dim sbPageLegends As New System.Text.StringBuilder()
            '    Dim intLength As Integer
            '    Dim intCnt As Integer

            '    'Prepare the Page Legend string
            '    sbPageLegends.Append("<TABLE " & MyBase.TableStyle & " class=" & MyBase.clsTable & ">")
            '    sbPageLegends.Append("<TR class=" & MyBase.clsTR & "><TD align=right><B>")
            '    'If the Legends are specified in the HTML string then append it to the page legends 
            '    If strHTMLLegend.Trim <> "" Then sbPageLegends.Append(strHTMLLegend.Trim)

            '    If Not strHTMLTagCaptionArray Is Nothing Then
            '        'Get the Upper limit of the Caption array
            '        intLength = UBound(strHTMLTagCaptionArray)
            '        For intCnt = 0 To intLength
            '            sbPageLegends.Append(strStartEnclosingBracket)
            '            sbPageLegends.Append(strHTMLTagImageArray(intCnt) & " " & strHTMLTagCaptionArray(intCnt))
            '            sbPageLegends.Append(strEndEnclosingBracket)
            '        Next
            '    End If
            '    sbPageLegends.Append("</B></TD></TR></TABLE>")
            '    'Return the string if Flag is True
            '    If MyBase.returnHTML = False Then
            '        HttpContext.Current.Response.Write(sbPageLegends.ToString)
            '        DrawPageLegends = ""
            '    Else
            '        DrawPageLegends = sbPageLegends.ToString
            '    End If
            '    sbPageLegends = Nothing
            'End Function

        End Class

        Public Class cHeaderFooter
            Inherits WebPages.UI.cHeaderFooter
            'Inherits WebPage.Templates.Global
            ''=====================================================================
            '' Class	Name	        :	cHeaderFooter
            '' Purpose				:	This class is used for drawing the Page 
            ''                           Header - Footer Table
            '' Description			:	Same as above
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	August 27, 2003
            '' Revisions				:	
            ''=====================================================================
            ''Property Variables
            'Private strHeaderFooter As String = ""
            'Private strDisplayPosition As String = "LIST_HEADER"

            ''Display Positions of the Headers and Footers for LIST page and UI Page
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
            '        'Get the String value from the Enum value
            '        strDisplayPosition = Value.ToString
            '        'Select Case Value
            '        '    Case HeaderFooterDisplayPosition.LIST_HEADER
            '        '        strDisplayPosition = "LIST_HEADER"
            '        '    Case HeaderFooterDisplayPosition.LIST_FOOTER
            '        '        strDisplayPosition = "LIST_FOOTER"
            '        '    Case HeaderFooterDisplayPosition.UI_HEADER
            '        '        strDisplayPosition = "UI_HEADER"
            '        '    Case HeaderFooterDisplayPosition.UI_FOOTER
            '        '        strDisplayPosition = "UI_FOOTER"
            '        'End Select
            '    End Set
            'End Property

            'Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            '    'Assign the Parameter values to the local variables
            '    MyBase.TagID = WhizGlobal.TagID
            '    MyBase.RoleID = WhizGlobal.RoleID
            '    MyBase.UserID = WhizGlobal.UserID
            '    MyBase.LoginType = WhizGlobal.LoginType.ToString
            '    MyBase.ParentTagID = WhizGlobal.ParentTagID
            '    MyBase.ProjectID = WhizGlobal.ProjectID
            '    MyBase.LoginID = WhizGlobal.LoginID
            '    MyBase.IsCustomerCreated = WhizGlobal.IsCustomerCreated
            '    MyBase.UserName = WhizGlobal.UserName.ToString
            '    MyBase.clsTable = WhizGlobal.clsTable.ToString
            '    MyBase.clsTR = WhizGlobal.clsTR.ToString
            '    MyBase.TableStyle = WhizGlobal.TableStyle
            '    MyBase.returnHTML = WhizGlobal.returnHTML
            '    MyBase.LCID = WhizGlobal.LCID
            'End Sub

            'Sub New()
            '    MyBase.clsTable = "clsTable"
            '    MyBase.clsTR = " clsTROdd "
            '    MyBase.TableStyle = " Width='100%' cellspacing=0"
            'End Sub

            'Public Function DrawHeaderFooter() As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawHeaderFooter
            '    ' Description           :   This PUBLIC method will build the complete HTML
            '    '                           Table for the Page Header - Footer
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Return the HTML string for the Page Header/Footer to the caller  
            '    '                          when returnHTML=true else will write the reponse
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, August 30, 2003
            '    ' Revisions             :
            '    '=====================================================================

            '    'If the Header/Footer is not specified then retrieve it from the Database
            '    If (strHeaderFooter.ToString.Trim = "" And MyBase.TagID <> 0) Then strHeaderFooter = GetPageHeaderFooter()

            '    'If Still the Header/Footer value is not exists then return the blank string and exit
            '    If strHeaderFooter.ToString.Trim = "" Then Return ""

            '    Dim sbHeaderFooter As New System.Text.StringBuilder()
            '    sbHeaderFooter.Append("<TABLE " & MyBase.TableStyle & " class=" & MyBase.clsTable & ">")
            '    sbHeaderFooter.Append("<TR class=" & MyBase.clsTR & ">")
            '    sbHeaderFooter.Append("<TD align=Left>" & strHeaderFooter.ToString.Trim & "</TD>")
            '    sbHeaderFooter.Append("</TR></TABLE>")
            '    If MyBase.returnHTML = False Then
            '        HttpContext.Current.Response.Write(sbHeaderFooter.ToString)
            '        DrawHeaderFooter = ""
            '    Else
            '        DrawHeaderFooter = sbHeaderFooter.ToString
            '    End If
            '    'Destroy the object
            '    sbHeaderFooter = Nothing
            'End Function

            'Private Function GetPageHeaderFooter() As String
            '    '=====================================================================
            '    ' Procedure Name        : GetPageHeaderFooter
            '    ' Description           :   This PRIVATE method will get the Page Header
            '    '                           or footer from the database for the selected 
            '    '                           Tag / Sub Tag ID and for the Common Page or 
            '    '                           Common List
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Return the HTML string for the Page Header/Footer 
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, September 05,2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim drPageHeaderFooter As IDataReader
            '    Dim strSQL As String
            '    Dim strPageHeaderFooter As String = ""

            '    'If the ParentTagID is not specified (0 - zero) then the Get the Page Header / Footer for the Tag (Page)
            '    'else get the Page Caption for the Sub Tag
            '    'The TagID / Sub Tag ID are mandatory
            '    If MyBase.UseHashTable = "N" Then
            '        If CommonFunction.General.GetApplicationKeySetting("DefaultUICultureID") = MyBase.LCID.ToString Then
            '            'Local culture ID is same as the default culture id
            '            strSQL = "usp_Sel_tbl_UI_TagMaster_PageHeaderFooter " & MyBase.TagID & ",'" & CommonFunction.General.CheckIsNothing(strDisplayPosition) & "'"
            '        Else
            '            'Culture ID is other than the default culture id
            '            'Check if the Culture is supported by the system
            '            If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), MyBase.LCID.ToString, CompareMethod.Text) <> 0 Then
            '                'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '                strSQL = "usp_Sel_tbl_UI_TagMaster_PageHeaderFooter " & MyBase.TagID & ",'" & CommonFunction.General.CheckIsNothing(strDisplayPosition) & "'," & MyBase.LCID.ToString
            '            Else
            '                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
            '                strSQL = "usp_Sel_tbl_UI_TagMaster_PageHeaderFooter " & MyBase.TagID & ",'" & CommonFunction.General.CheckIsNothing(strDisplayPosition) & "'"
            '            End If
            '        End If

            '        drPageHeaderFooter = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '        If drPageHeaderFooter.Read() Then
            '            If Not IsDBNull(drPageHeaderFooter(0)) Then strPageHeaderFooter = drPageHeaderFooter(0).ToString
            '        End If
            '        drPageHeaderFooter.Dispose()
            '        drPageHeaderFooter.Close()
            '        drPageHeaderFooter = Nothing
            '        'Return the Page Header / Footer
            '    Else
            '        Dim objUITagMaster As New CommonEngines.HashTables.UITagMaster()
            '        If CommonFunction.General.GetApplicationKeySetting("DefaultUICultureID") = MyBase.LCID.ToString Then
            '            'Local culture ID is same as the default culture id
            '            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(MyBase.TagID)
            '        Else
            '            'Culture ID is other than the default culture id
            '            'Check if the Culture is supported by the system
            '            If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), MyBase.LCID.ToString, CompareMethod.Text) <> 0 Then
            '                'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '                objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterCultureObject(MyBase.TagID.ToString & CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"))
            '            Else
            '                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
            '                objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(MyBase.TagID)
            '            End If
            '        End If
            '        Select Case strDisplayPosition.ToUpper
            '            Case "LIST_HEADER"
            '                If CommonFunction.General.CheckIsNothing(objUITagMaster.PageHeaderDisplayPosition).Trim = "LIST" Or CommonFunction.General.CheckIsNothing(objUITagMaster.PageHeaderDisplayPosition).Trim = "BOTH" Then
            '                    strPageHeaderFooter = objUITagMaster.PageHeader.ToString
            '                End If
            '            Case "LIST_FOOTER"
            '                If CommonFunction.General.CheckIsNothing(objUITagMaster.PageFooterDisplayPosition).Trim = "LIST" Or CommonFunction.General.CheckIsNothing(objUITagMaster.PageFooterDisplayPosition).Trim = "BOTH" Then
            '                    strPageHeaderFooter = objUITagMaster.PageFooter.ToString
            '                End If
            '            Case "UI_HEADER"
            '                If CommonFunction.General.CheckIsNothing(objUITagMaster.PageHeaderDisplayPosition).Trim = "UI" Or CommonFunction.General.CheckIsNothing(objUITagMaster.PageHeaderDisplayPosition).Trim = "BOTH" Then
            '                    strPageHeaderFooter = objUITagMaster.UIPageHeader.ToString
            '                End If
            '            Case "UI_FOOTER"
            '                If CommonFunction.General.CheckIsNothing(objUITagMaster.PageFooterDisplayPosition).Trim = "UI" Or CommonFunction.General.CheckIsNothing(objUITagMaster.PageFooterDisplayPosition).Trim = "BOTH" Then
            '                    strPageHeaderFooter = objUITagMaster.UIPageFooter.ToString
            '                End If
            '        End Select
            '        objUITagMaster = Nothing
            '    End If

            '    Return strPageHeaderFooter
            'End Function
        End Class

        Public MustInherit Class cControls
            Inherits WebPages.UI.cControls
            ''=====================================================================
            '' Class	Name	        :	cControls
            '' Purpose				:	This is a base class. This class should be 
            ''                           inherited by classes wanting to plot controls 
            ''                           in the UI.
            '' Description			:	The other Control classes will inherit this class
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	Sept 01, 2003
            '' Revisions				:	
            ''=====================================================================
            'Private strclsTable As String = "clsTable"
            'Private strclsTR As String = "clsTREven"
            'Private strZoomOutImageSrc As String = "../../Images/zoomin.gif"
            'Private strZoomOutFunctionName As String = "opentextdialog"
            'Private strZoomOutToolTip As String = ""
            'Private strMandatoryImageSrc As String = "../../Images/Star.gif"
            'Private strCalendarImageSrc As String = "../../Images/Calendar.gif"
            'Private strCalendarFunctionName As String = "callcalendar"
            'Private strCalendarToolTip As String = ""

            'Public Property clsTable() As String
            '    Get
            '        Return strclsTable
            '    End Get
            '    Set(ByVal Value As String)
            '        strclsTable = Value
            '    End Set
            'End Property

            'Public Property clsTR() As String
            '    Get
            '        Return strclsTR
            '    End Get
            '    Set(ByVal Value As String)
            '        strclsTR = Value
            '    End Set
            'End Property

            'Public Property ZoomOutImageSrc() As String
            '    Get
            '        Return strZoomOutImageSrc
            '    End Get
            '    Set(ByVal Value As String)
            '        strZoomOutImageSrc = Value
            '    End Set
            'End Property

            'Public Property ZoomOutFunctionName() As String
            '    Get
            '        Return strZoomOutFunctionName
            '    End Get
            '    Set(ByVal Value As String)
            '        strZoomOutFunctionName = Value
            '    End Set
            'End Property

            'Public Property ZoomOutToolTip() As String
            '    Get
            '        Return strZoomOutToolTip
            '    End Get
            '    Set(ByVal Value As String)
            '        strZoomOutToolTip = Value
            '    End Set
            'End Property

            'Public Property MandatoryImageSrc() As String
            '    Get
            '        Return strMandatoryImageSrc
            '    End Get
            '    Set(ByVal Value As String)
            '        strMandatoryImageSrc = Value
            '    End Set
            'End Property

            'Public Property CalendarImageSrc() As String
            '    Get
            '        Return strCalendarImageSrc
            '    End Get
            '    Set(ByVal Value As String)
            '        strCalendarImageSrc = Value
            '    End Set
            'End Property

            'Public Property CalendarFunctionName() As String
            '    Get
            '        Return strCalendarFunctionName
            '    End Get
            '    Set(ByVal Value As String)
            '        strCalendarFunctionName = Value
            '    End Set
            'End Property

            'Public Property CalendarToolTip() As String
            '    Get
            '        Return strCalendarToolTip
            '    End Get
            '    Set(ByVal Value As String)
            '        strCalendarToolTip = Value
            '    End Set
            'End Property

        End Class

        Public Class cDynamicLink
            Inherits WebPages.UI.cDynamicLink
            ''=====================================================================
            '' Class	Name	        :	cDynamicLink
            '' Purpose				:	This class will return the link tag, 
            ''                           depending upon the passed parameters
            '' Description			:	This class will be used in cDynamicMenu and 
            ''                           cPlotGrid classes
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	August 25, 2003
            '' Revisions				:	
            ''=====================================================================
            ''Constructor Valiables
            'Private lngTagID As Long
            'Private lngRoleID As Long
            'Private lngParentTagID As Long
            'Private lngProjectID As Long
            'Private lngUserID As Long
            'Private strLoginType As String
            ''Property Variables
            'Private strLinkName As String
            'Private strTooltip As String
            'Private strFunctionName As String
            'Private strLinkStyle As String
            'Private blnReturnHTML As Boolean
            'Private strOtherProperties As String = ""
            'Private strcssClass As String = ""
            ''Other class variable

            'Public WriteOnly Property LinkName() As String
            '    Set(ByVal Value As String)
            '        strLinkName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property Tooltip() As String
            '    Set(ByVal Value As String)
            '        strTooltip = Value
            '    End Set
            'End Property

            'Public WriteOnly Property FunctionName() As String
            '    Set(ByVal Value As String)
            '        strFunctionName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property LinkStyle() As String
            '    Set(ByVal Value As String)
            '        strLinkStyle = Value
            '    End Set
            'End Property

            'Public WriteOnly Property OtherProperties() As String
            '    Set(ByVal Value As String)
            '        strOtherProperties = Value
            '    End Set
            'End Property
            'Public WriteOnly Property ReturnHTML() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnReturnHTML = Value
            '    End Set
            'End Property
            'Public Property cssClass() As String
            '    Get
            '        Return strcssClass
            '    End Get
            '    Set(ByVal Value As String)
            '        strcssClass = Value
            '    End Set
            'End Property

            'Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            '    'Assign the Parameter values to the local variables
            '    lngTagID = WhizGlobal.TagID
            '    lngRoleID = WhizGlobal.RoleID
            '    lngUserID = WhizGlobal.UserID
            '    strLoginType = WhizGlobal.LoginType
            '    lngParentTagID = WhizGlobal.ParentTagID
            '    lngProjectID = WhizGlobal.ProjectID
            'End Sub
            'Public Sub New()

            'End Sub

            'Public Function GetDynamicLink() As String
            '    '=====================================================================
            '    ' Procedure Name        : GetDynamicLink
            '    ' Description           : This PUBLIC method will build the complete link tag
            '    '                           <A>...</A> for the values passed (link name, href...) 
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Return the HTML string for the link to the caller  
            '    '                          when returnHTML=true else will write the reponse
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, August 25, 2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim sbDynamicLink As New System.Text.StringBuilder()
            '    If strcssClass.Trim = "" Then
            '        sbDynamicLink.Append("<A style='" & strLinkStyle & "' HREF=" & Chr(34) & "Javascript:" & strFunctionName & Chr(34) & " Title=""" & strTooltip & """ " + strOtherProperties + ">")
            '    Else
            '        sbDynamicLink.Append("<A class='" & strcssClass & "' style='" & strLinkStyle & "' HREF=" & Chr(34) & "Javascript:" & strFunctionName & Chr(34) & " Title=""" & strTooltip & """ " + strOtherProperties + ">")
            '    End If
            '    sbDynamicLink.Append(strLinkName)
            '    sbDynamicLink.Append("</A>")
            '    If blnReturnHTML = False Then
            '        HttpContext.Current.Response.Write(sbDynamicLink.ToString)
            '    Else
            '        GetDynamicLink = sbDynamicLink.ToString
            '    End If
            '    sbDynamicLink = Nothing
            'End Function

        End Class

        Public Class cDynamicMenu
            Inherits WebPages.UI.cDynamicMenu
            'Inherits WebPage.Templates.Global
            ''=====================================================================
            '' Class	Name	        :	cDynamicMenu
            '' Purpose				:	This class is used for drawing the top and 
            ''                           bottom level page menu
            '' Description			:	Same as above
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	September 01, 2003
            '' Revisions				:	
            ''=====================================================================

            ''Property Variables
            'Private strDisplayPosition As String = "LIST_HEAD"
            'Private strLinkStyle As String = "TEXT-DECORATION:NONE"
            'Private strLinkSQL As String
            'Private strUniqueID As String = ""
            'Private blnShowBackLink As Boolean
            'Private blnShowSaveLink As Boolean
            'Private blnAdd As Boolean
            'Private blnDelete As Boolean
            'Private blnEdit As Boolean
            'Private blnView As Boolean
            'Private blnEnablePaging As Boolean
            'Private strPagingAlphabet As String
            'Private strPagingFunctionName As String
            'Private lngRecordCount As Long
            'Private blnReturnHTML As Boolean
            'Private blnReturnClientsideScript As Boolean
            'Private strClientsideScript As String = ""
            'Private strEnabledControls As String
            'Private blnIsListPageLink As Boolean = False
            'Private strCommonQueryString As String
            'Private strSubTagCommonQueryString As String
            'Private strValidationRules As String
            'Private strMenuLinkAlignment As String
            'Private strLinkSeperatorHTML As String = ""
            'Private strMessageForDeleteConfirm As String
            'Private strMessageForPagingSelect As String
            'Private strAddNewMode_UIPage As String = "CommonPage.aspx"
            'Private strPageMode As String = ""
            'Private strNavigationLinkSysNames As String()
            'Private strNavigationLinkNames As String()
            'Private strNavigationLinkFunctions As String()
            'Private strNavigationLinkTooltips As String()
            'Private strcssPagingClass As String
            'Private strcssPagingSelectedClass As String
            'Private strcssMenuClass As String
            'Private lngWindowHeight As Long = 500
            'Private lngWindowWidth As Long = 650
            'Private blnAddNewMode_UIPageOpenInWindow As Boolean = False
            'Private blnEditMode_UIPageOpenInWindow As Boolean = False
            'Private strPagingSeperatorHTML As String = ""
            'Private strMasterPrimaryKeyValue As String = ""
            'Private strAddNewLinkOnUI_CommonQueryString As String = ""
            'Private blnConsiderAccessRights As Boolean = True
            'Private strDeletionCheckboxName As String
            ''Class variable
            'Private m_ObjGlobal As WebPages.Template.IGlobal

            ''Link display positions
            'Public Enum LinkDisplayPosition
            '    LIST_HEAD
            '    LIST_FOOT
            '    UI_HEAD
            '    UI_FOOT
            'End Enum

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
            'Public WriteOnly Property ConsiderAccessRights() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnConsiderAccessRights = Value
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
            'Public WriteOnly Property MasterPrimaryKeyValue() As String
            '    Set(ByVal Value As String)
            '        strMasterPrimaryKeyValue = Value
            '    End Set
            'End Property
            'Public WriteOnly Property DisplayPosition() As LinkDisplayPosition
            '    Set(ByVal Value As LinkDisplayPosition)
            '        Select Case Value
            '            Case LinkDisplayPosition.LIST_HEAD
            '                strDisplayPosition = "LIST_HEAD"
            '            Case LinkDisplayPosition.LIST_FOOT
            '                strDisplayPosition = "LIST_FOOT"
            '            Case LinkDisplayPosition.UI_HEAD
            '                strDisplayPosition = "UI_HEAD"
            '            Case LinkDisplayPosition.UI_FOOT
            '                strDisplayPosition = "UI_FOOT"
            '        End Select
            '    End Set
            'End Property

            'Public WriteOnly Property WindowHeight() As Long
            '    Set(ByVal Value As Long)
            '        lngWindowHeight = Value
            '    End Set
            'End Property

            'Public WriteOnly Property WindowWidth() As Long
            '    Set(ByVal Value As Long)
            '        lngWindowWidth = Value
            '    End Set
            'End Property

            'Public WriteOnly Property cssMenuClass() As String
            '    Set(ByVal Value As String)
            '        strcssMenuClass = Value
            '    End Set
            'End Property

            'Public WriteOnly Property cssPagingClass() As String
            '    Set(ByVal Value As String)
            '        strcssPagingClass = Value
            '    End Set
            'End Property

            'Public WriteOnly Property cssPagingSelectedClass() As String
            '    Set(ByVal Value As String)
            '        strcssPagingSelectedClass = Value
            '    End Set
            'End Property

            'Public WriteOnly Property AddNewMode_UIPage() As String
            '    Set(ByVal Value As String)
            '        strAddNewMode_UIPage = Value
            '    End Set
            'End Property

            'Public WriteOnly Property LinkStyle() As String
            '    Set(ByVal Value As String)
            '        strLinkStyle = Value
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

            'Public WriteOnly Property ShowBackLink() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnShowBackLink = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ShowSaveLink() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnShowSaveLink = Value
            '    End Set
            'End Property

            'Public WriteOnly Property Add() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnAdd = Value
            '    End Set
            'End Property

            'Public WriteOnly Property Delete() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnDelete = Value
            '    End Set
            'End Property

            'Public WriteOnly Property Edit() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnEdit = Value
            '    End Set
            'End Property

            'Public WriteOnly Property View() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnView = Value
            '    End Set
            'End Property

            'Public WriteOnly Property EnablePaging() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnEnablePaging = Value
            '    End Set
            'End Property

            'Public WriteOnly Property PagingAlphabet() As String
            '    Set(ByVal Value As String)
            '        strPagingAlphabet = Value
            '    End Set
            'End Property

            'Public WriteOnly Property PagingFunctionName() As String
            '    Set(ByVal Value As String)
            '        strPagingFunctionName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property RecordCount() As Long
            '    Set(ByVal Value As Long)
            '        lngRecordCount = Value
            '    End Set
            'End Property

            'Public WriteOnly Property IsListPageLink() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnIsListPageLink = Value
            '    End Set
            'End Property

            'Public WriteOnly Property EnabledControls() As String
            '    Set(ByVal Value As String)
            '        strEnabledControls = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ReturnClientsideScript() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnReturnClientsideScript = Value
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

            'Public WriteOnly Property PagingSeperatorHTML() As String
            '    Set(ByVal Value As String)
            '        strPagingSeperatorHTML = Value
            '    End Set
            'End Property

            'Public WriteOnly Property LinkSeperatorHTML() As String
            '    Set(ByVal Value As String)
            '        strLinkSeperatorHTML = Value
            '    End Set
            'End Property

            'Public WriteOnly Property MenuLinkAlignment() As String
            '    Set(ByVal Value As String)
            '        strMenuLinkAlignment = Value
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

            'Public WriteOnly Property PageMode() As String
            '    Set(ByVal Value As String)
            '        strPageMode = Value
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

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                'Assign the Parameter values to the local variables
                'm_ObjGlobal = WhizGlobal
                MyBase.New(WhizGlobal)
                'MyBase.TagID = WhizGlobal.TagID
                'MyBase.RoleID = WhizGlobal.RoleID
                'MyBase.UserID = WhizGlobal.UserID
                'MyBase.LoginType = WhizGlobal.LoginType
                'MyBase.UserName = WhizGlobal.UserName
                'MyBase.ParentTagID = WhizGlobal.ParentTagID
                'MyBase.ProjectID = WhizGlobal.ProjectID
                'MyBase.UseHashTable = WhizGlobal.UseHashTable.ToString
                'MyBase.LCID = WhizGlobal.LCID
            End Sub

            'Public Function DrawMenu() As String
            '    '=====================================================================
            '    ' Procedure Name        :	DrawMenu
            '    ' Purpose               :	Draw the Menu 
            '    ' Description           :	This method will build the HTML string to
            '    '                           draw the page menu depending upon its display
            '    '                           position. 
            '    ' Parameters Passed     :	None.
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	If ReturnHTML = True Then Return the HTML string
            '    '                           else writes the response
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Tuesday, September 04, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim sbMenu As New System.Text.StringBuilder()
            '    sbMenu.Append("<Table " & MyBase.TableStyle.ToString & " class='" & MyBase.clsTable & "' >")
            '    sbMenu.Append("<TR class='" & MyBase.clsTR.ToString & "'>")
            '    'If the Paging Flag is enabled then display it
            '    If blnEnablePaging = True Then sbMenu.Append(GetPaging())
            '    'Draw Navigation Links
            '    sbMenu.Append(DrawNavigationLinks())
            '    'Draw the Menu Links
            '    If m_ObjGlobal.ParentTagID = 0 Then
            '        sbMenu.Append(DrawMenuLinks())
            '    Else
            '        sbMenu.Append(DrawSubTagMenuLinks())
            '    End If
            '    sbMenu.Append("</TR></TABLE>")
            '    DrawMenu = sbMenu.ToString()
            '    sbMenu = Nothing
            'End Function

            'Private Function DrawNavigationLinks() As String
            '    '=====================================================================
            '    ' Procedure Name        :	DrawNavigationLinks
            '    ' Purpose               :	Draw the Navigation Links 
            '    ' Description           :	This method will build the HTML string to
            '    '                           draw the First | Previous | Next | Last
            '    '                           navigation links
            '    ' Parameters Passed     :	None.
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	Return the navigation Links HTML string
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	November 11, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    If Not strNavigationLinkNames Is Nothing Then
            '        Dim strScript As String = ""
            '        DrawNavigationLinks = CommonEngine.General.cPageSpecificBehavior.GetNavigationLinks(m_ObjGlobal, strNavigationLinkSysNames, strNavigationLinkNames, strNavigationLinkFunctions, strNavigationLinkTooltips, strScript, "", blnReturnClientsideScript)
            '        If blnReturnClientsideScript = True Then strClientsideScript = strClientsideScript + strScript
            '    End If
            'End Function

            'Private Function DrawMenuLinks() As String
            '    '=====================================================================
            '    ' Procedure Name        :	DrawMenuLinks
            '    ' Purpose               :	Draw the Menu Links 
            '    ' Description           :	This method will build the HTML string to
            '    '                           draw the page menu links depending upon its display
            '    '                           position. 
            '    ' Parameters Passed     :	None.
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	Return the Menu Links HTML string
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	September 06, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim drMenuLinks As IDataReader
            '    Dim strSQL As String
            '    Dim sbMenuLink As New System.Text.StringBuilder()
            '    Dim sbClientsideScript As New System.Text.StringBuilder()
            '    Dim objDynamicLink As New cDynamicLink()
            '    Dim blnLink As Boolean = False

            '    sbMenuLink.Append("<TD align=right>")
            '    'Assign the Common Properties only once
            '    objDynamicLink.LinkStyle = strLinkStyle
            '    objDynamicLink.ReturnHTML = True
            '    'START Client side script block
            '    If blnReturnClientsideScript = True Then sbClientsideScript.Append(vbCrLf & "<SCRIPT Language=javascript>" & vbCrLf)

            '    If MyBase.UseHashTable = "N" Then
            '        'Get the Link details for the selected Page
            '        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.LCID Then
            '            'Local culture ID is same as the default culture id
            '            strSQL = "usp_Sel_tbl_UI_Dynamic_Links " & MyBase.TagID & ",null,null,'" & strDisplayPosition & "'"
            '        Else
            '            'Culture ID is other than the default culture id
            '            'Check if the Culture is supported by the system
            '            'If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), MyBase.LCID.ToString, CompareMethod.Text) <> 0 Then
            '            'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '            strSQL = "usp_Sel_tbl_UI_Dynamic_Links " & MyBase.TagID & ",null,null,'" & strDisplayPosition & "'," & MyBase.LCID.ToString
            '            drMenuLinks = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '            If Not drMenuLinks.Read Then
            '                'No. Culture is NOT supported. Retrieve the data from the defual culture 
            '                strSQL = "usp_Sel_tbl_UI_Dynamic_Links " & MyBase.TagID & ",null,null,'" & strDisplayPosition & "'"
            '            Else
            '                drMenuLinks.Close()
            '                drMenuLinks.Dispose()
            '                drMenuLinks = Nothing
            '            End If
            '        End If

            '        drMenuLinks = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '        'Plot links one by one
            '        Do While drMenuLinks.Read
            '            Dim strLinkURL As String = ""
            '            If Not IsDBNull(drMenuLinks("CustomLink")) Then strLinkURL = drMenuLinks("CustomLink").ToString
            '            'Check if the User has access of the link
            '            If CheckLinkAccessRights(CommonFunction.General.CheckIsNothing(drMenuLinks("AccessRights"))) = True Then
            '                If CheckConditionClause(CommonFunction.General.CheckIsNothing(drMenuLinks("ConditionClause")), CommonFunction.General.CheckIsNothing(drMenuLinks("LinkType"), ""), strLinkURL) = True Then
            '                    If CheckSystemLink(drMenuLinks("LinkName").ToString, CommonFunction.General.CheckIsNothing(drMenuLinks("SystemLinkType"), "")) = True Then
            '                        'Flag to indicate : link(s) are present
            '                        blnLink = True
            '                        If Not IsDBNull(drMenuLinks("ImageURL")) Then
            '                            If drMenuLinks("ImageURL").ToString.Trim <> "" Then
            '                                objDynamicLink.LinkName = "<Img Border=0 src='" + drMenuLinks("ImageURL").ToString.Trim + "'>&nbsp;" + drMenuLinks("LinkName").ToString
            '                            Else
            '                                objDynamicLink.LinkName = drMenuLinks("LinkName").ToString
            '                            End If
            '                        Else
            '                            objDynamicLink.LinkName = drMenuLinks("LinkName").ToString
            '                        End If
            '                        If CommonFunction.General.CheckIsNothing(drMenuLinks("LinkType")).ToUpper = "C" Or _
            '                            CommonFunction.General.CheckIsNothing(drMenuLinks("LinkType")).ToUpper = "D" Then
            '                            objDynamicLink.FunctionName = drMenuLinks("ClientSideFunctionName").ToString + "(&quot;" + strUniqueID.ToString + "&quot;)"
            '                        Else
            '                            If CommonFunction.General.CheckIsNothing(drMenuLinks("SystemLinkType").ToString).Trim.ToUpper <> "HELP" Then
            '                                objDynamicLink.FunctionName = drMenuLinks("ClientSideFunctionName").ToString + "()"
            '                            Else
            '                                'Help function need a parameter
            '                                objDynamicLink.FunctionName = drMenuLinks("ClientSideFunctionName").ToString + "(" + MyBase.TagID.ToString + ")"
            '                            End If
            '                        End If

            '                        objDynamicLink.Tooltip = drMenuLinks("LinkToolTip").ToString
            '                        objDynamicLink.cssClass = strcssMenuClass
            '                        sbMenuLink.Append(" " & strLinkSeperatorHTML & " " & objDynamicLink.GetDynamicLink())
            '                        'Code for Client side function 
            '                        If blnReturnClientsideScript = True And _
            '                            CommonFunction.General.CheckIsNothing(drMenuLinks("SystemLinkType").ToString).Trim.ToUpper <> "HELP" Then
            '                            'Do not generate Client side script for help tag
            '                            Select Case CommonFunction.General.CheckIsNothing(drMenuLinks("LinkType")).ToUpper
            '                                Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_CUSTOMPAGE_D
            '                                    sbClientsideScript.Append("function " + CommonFunction.General.CheckIsNothing(drMenuLinks("ClientSideFunctionName").ToString) + "(lngUniqueID)" + vbCrLf)
            '                                    sbClientsideScript.Append("{" & vbCrLf)
            '                                    'Dynamic Custom Page Link
            '                                    sbClientsideScript.Append("window.open (" + Chr(34) + ReplacePlaceHolders(CommonFunction.General.CheckIsNothing(drMenuLinks("CustomLink").ToString)) + Chr(34) + ", """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                    sbClientsideScript.Append("}" + vbCrLf)
            '                                Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_COMMONENGINE_C
            '                                    sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(drMenuLinks("ClientSideFunctionName").ToString) + "(intUniqueID)" + vbCrLf)
            '                                    sbClientsideScript.Append("{" + vbCrLf)
            '                                    sbClientsideScript.Append(strEnabledControls + vbCrLf)
            '                                    If blnIsListPageLink = True Then
            '                                        sbClientsideScript.Append(vbCrLf & "objfrm.action=" + Chr(34) + "CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + drMenuLinks("UniqueID").ToString + "&UniqueValue="" + intUniqueID + ""&IsListPageLink=1&" + strCommonQueryString & Chr(34))
            '                                    Else
            '                                        sbClientsideScript.Append(vbCrLf & "objfrm.action=" + Chr(34) + "CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + drMenuLinks("UniqueID").ToString + "&UniqueValue="" + intUniqueID + ""&IsListPageLink=0" & Chr(34))
            '                                    End If
            '                                    sbClientsideScript.Append(vbCrLf & "objfrm.submit()" & vbCrLf)
            '                                    sbClientsideScript.Append("}" & vbCrLf)
            '                                Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_SYSTEM_S
            '                                    sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(drMenuLinks("ClientSideFunctionName").ToString) & "()" + vbCrLf)
            '                                    sbClientsideScript.Append("{" & vbCrLf)
            '                                    Select Case CommonFunction.General.CheckIsNothing(drMenuLinks("SystemLinkType").ToString).Trim.ToUpper
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_ADD_NEW  '"ADD_NEW"
            '                                            '....IssueID 9046...Show Add New link in Edit Mode
            '                                            Dim strTempQueryString As String = strCommonQueryString
            '                                            If strAddNewLinkOnUI_CommonQueryString.Trim <> "" Then strCommonQueryString = strAddNewLinkOnUI_CommonQueryString
            '                                            If blnAddNewMode_UIPageOpenInWindow = False Then
            '                                                If strCommonQueryString.Trim = "" Then
            '                                                    If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                        'No Parameters
            '                                                        sbClientsideScript.Append("     window.location.href=" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW" & Chr(34) + ";" + vbCrLf)
            '                                                    Else
            '                                                        sbClientsideScript.Append("     window.location.href=" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW" & Chr(34) + ";" + vbCrLf)
            '                                                    End If
            '                                                Else
            '                                                    If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                        'No parameters
            '                                                        sbClientsideScript.Append("     window.location.href=" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW&" & strCommonQueryString & Chr(34) + ";" + vbCrLf)
            '                                                    Else
            '                                                        sbClientsideScript.Append("     window.location.href=" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW&" & strCommonQueryString & Chr(34) + ";" + vbCrLf)
            '                                                    End If
            '                                                End If
            '                                            Else
            '                                                If strCommonQueryString.Trim = "" Then
            '                                                    If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                        'No Parameters
            '                                                        sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW" & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                    Else
            '                                                        sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW" & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                    End If
            '                                                Else
            '                                                    If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                        'No parameters
            '                                                        sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW&" & strCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                    Else
            '                                                        sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW&" & strCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                    End If
            '                                                End If
            '                                            End If
            '                                            strCommonQueryString = strTempQueryString
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_DELETE  '"DELETE"
            '                                            'Check if any records selected before submitting the form
            '                                            sbClientsideScript.Append(vbCrLf + WriteClientsideScript_CheckIfRecordsSelected())
            '                                            sbClientsideScript.Append(vbCrLf & "if(confirm(" & Chr(34) & strMessageForDeleteConfirm & Chr(34) & "))")
            '                                            sbClientsideScript.Append(vbCrLf & "{")
            '                                            If strCommonQueryString.Trim = "" Then
            '                                                sbClientsideScript.Append(vbCrLf & "    objfrm.action=" & Chr(34) & "Commonlist.aspx?Operation=DELETE" & Chr(34))
            '                                            Else
            '                                                sbClientsideScript.Append(vbCrLf & "    objfrm.action=" & Chr(34) & "Commonlist.aspx?Operation=DELETE&" & strCommonQueryString & Chr(34))
            '                                            End If
            '                                            sbClientsideScript.Append(vbCrLf & "    objfrm.submit()")
            '                                            sbClientsideScript.Append(vbCrLf & "}" & vbCrLf)
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SELECT_ALL  '"SELECT_ALL"
            '                                            sbClientsideScript.Append(vbCrLf & "if (" & lngRecordCount & " == 0 )")
            '                                            sbClientsideScript.Append(vbCrLf & "{ return; }")
            '                                            sbClientsideScript.Append(vbCrLf & "else if (" & lngRecordCount & "== 1 )")
            '                                            sbClientsideScript.Append(vbCrLf & "{")
            '                                            sbClientsideScript.Append(vbCrLf & "if (objfrm." + strDeletionCheckboxName + ".disabled == false )")
            '                                            sbClientsideScript.Append(vbCrLf & "{objfrm." + strDeletionCheckboxName + ".checked = true }")
            '                                            sbClientsideScript.Append(vbCrLf & "}")
            '                                            sbClientsideScript.Append(vbCrLf & "else")
            '                                            sbClientsideScript.Append(vbCrLf & "{")
            '                                            sbClientsideScript.Append(vbCrLf & "    for(intCnt = 0;intCnt<=" & lngRecordCount - 1 & ";intCnt++)")
            '                                            sbClientsideScript.Append(vbCrLf & "    {")
            '                                            sbClientsideScript.Append(vbCrLf & "if (objfrm." + strDeletionCheckboxName + "(intCnt).disabled == false )")
            '                                            sbClientsideScript.Append(vbCrLf & "{objfrm." + strDeletionCheckboxName + "(intCnt).checked = true }")
            '                                            sbClientsideScript.Append(vbCrLf & "    }")
            '                                            sbClientsideScript.Append(vbCrLf & "}" & vbCrLf)

            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SAVE  '"SAVE"
            '                                            sbClientsideScript.Append(strValidationRules & vbCrLf)
            '                                            sbClientsideScript.Append(strEnabledControls & vbCrLf)
            '                                            If strCommonQueryString.Trim = "" Then
            '                                                sbClientsideScript.Append(vbCrLf & "objfrm.action=" & Chr(34) & "CommonPage.aspx?Operation=SAVE" & Chr(34))
            '                                            Else
            '                                                sbClientsideScript.Append(vbCrLf & "objfrm.action=" & Chr(34) & "CommonPage.aspx?Operation=SAVE&" & strCommonQueryString & Chr(34))
            '                                            End If
            '                                            sbClientsideScript.Append(vbCrLf & "objfrm.submit()" & vbCrLf)

            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_BACK  '"BACK"
            '                                            'Got back to the Commmon List Page
            '                                            sbClientsideScript.Append("window.location.href=" & Chr(34) & "CommonList.aspx?" & strCommonQueryString & Chr(34) & vbCrLf)
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SHOW_HISTORY  '"SHOW_HISTORY"
            '                                            'Show the Audit Trail
            '                                            If CommonFunction.General.CheckIsNothing(m_ObjGlobal.FromWhere, "") <> "PM" Then
            '                                                sbClientsideScript.Append(vbCrLf & "window.open (""AuditTrail.aspx?IsSubTag=0&TagID=" & m_ObjGlobal.TagID & "&UniqueID=" & strUniqueID & "&ProjectID="", """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                            Else
            '                                                sbClientsideScript.Append(vbCrLf & "window.open (""AuditTrail.aspx?IsSubTag=0&TagID=" & m_ObjGlobal.TagID & "&UniqueID=" & strUniqueID & "&ProjectID=" & m_ObjGlobal.ProjectID.ToString & """, """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                            End If

            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_CONFIGURE  '"CONFIGURE"
            '                                            'Show the Page Maintenance wizard  '''''Special height and width
            '                                            sbClientsideScript.Append(vbCrLf + "window.open (""../SM/PB_PageCanvas.aspx?FromUI=1&FromElement=Tag&MasterTagID=315&FromWhere=SM&TagID=" & m_ObjGlobal.TagID & """, """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - 900)/2) + "",top="" + ((window.screen.height - 650)/2) + "",width=900,height=650"");" + vbCrLf)
            '                                    End Select
            '                                    sbClientsideScript.Append(vbCrLf + "}" + vbCrLf)
            '                            End Select

            '                        End If
            '                    End If
            '                End If
            '            End If
            '        Loop
            '        drMenuLinks.Dispose()
            '        drMenuLinks.Close()
            '        drMenuLinks = Nothing
            '    Else

            '        Dim objDynamicLinksHashTable As CommonEngines.HashTables.DynamicLinks()
            '        Dim intIndex As Integer
            '        Dim intLength As Integer

            '        If InStr(strDisplayPosition, "LIST", CompareMethod.Text) > 0 Then
            '            'Get the Link details for the selected Page
            '            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.LCID Then
            '                objDynamicLinksHashTable = CommonEngines.HashTables.GetHashTableObject.GetHashTableDynamicLinkCLObject(CType(MyBase.TagID, Long))
            '            Else
            '                'Culture ID is other than the default culture id
            '                'Check if the Culture is supported by the system

            '                'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '                objDynamicLinksHashTable = CommonEngines.HashTables.GetHashTableObject.GetHashTableDynamicLinkCLObject(MyBase.TagID.ToString & MyBase.LCID.ToString)
            '                If objDynamicLinksHashTable Is Nothing Then
            '                    'No. Culture is NOT supported. Retrieve the data from the defualt culture 
            '                    objDynamicLinksHashTable = CommonEngines.HashTables.GetHashTableObject.GetHashTableDynamicLinkCLObject(CType(MyBase.TagID, Long))
            '                End If
            '            End If
            '        Else
            '            'Get the Link details for the selected Page
            '            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.LCID Then
            '                objDynamicLinksHashTable = CommonEngines.HashTables.GetHashTableObject.GetHashTableDynamicLinkCPObject(MyBase.TagID)
            '            Else
            '                'Culture ID is other than the default culture id
            '                'Check if the Culture is supported by the system
            '                'If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), MyBase.LCID.ToString, CompareMethod.Text) <> 0 Then
            '                'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '                objDynamicLinksHashTable = CommonEngines.HashTables.GetHashTableObject.GetHashTableDynamicLinkCPObject(MyBase.TagID.ToString & MyBase.LCID.ToString)
            '                If objDynamicLinksHashTable Is Nothing Then
            '                    'No. Culture is NOT supported. Retrieve the data from the defualt culture 
            '                    objDynamicLinksHashTable = CommonEngines.HashTables.GetHashTableObject.GetHashTableDynamicLinkCPObject(MyBase.TagID)
            '                End If
            '            End If
            '        End If
            '        If objDynamicLinksHashTable Is Nothing Then Return ""
            '        intLength = objDynamicLinksHashTable.Length

            '        For intIndex = 0 To intLength - 1
            '            strDisplayPosition = UCase(strDisplayPosition)
            '            If (strDisplayPosition = "LIST_HEAD" And _
            '                    (InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "LIST_HEAD") <> 0 Or InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "LIST_BOTH") <> 0)) _
            '               Or (strDisplayPosition = "LIST_FOOT" And _
            '                    (InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "LIST_FOOT") <> 0 Or InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "LIST_BOTH") <> 0)) _
            '               Or (strDisplayPosition = "UI_HEAD" And _
            '                    (InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "UI_HEAD") <> 0 Or InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "UI_BOTH") <> 0)) _
            '               Or (strDisplayPosition = "UI_FOOT" And _
            '                    (InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "UI_FOOT") <> 0 Or InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "UI_BOTH") <> 0)) Then
            '                'If the Link is defined for the Specified position then for each link
            '                'Check if the User has access of the link
            '                If CheckLinkAccessRights(CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).AccessRights)) = True Then
            '                    If CheckConditionClause(CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ConditionClause), CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).LinkType, ""), CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).CustomLink)) = True Then
            '                        If CheckSystemLink(objDynamicLinksHashTable(intIndex).LinkName.ToString, CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SystemLinkType, "")) = True Then
            '                            'Flag to indicate : link(s) are present
            '                            blnLink = True
            '                            If CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ImageURL).Trim <> "" Then
            '                                objDynamicLink.LinkName = "<Img Border=0 src='" + objDynamicLinksHashTable(intIndex).ImageURL + "'>&nbsp;" + objDynamicLinksHashTable(intIndex).LinkName.ToString
            '                            Else
            '                                objDynamicLink.LinkName = objDynamicLinksHashTable(intIndex).LinkName.ToString
            '                            End If
            '                            If CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).LinkType).ToUpper = "D" Or _
            '                                CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).LinkType).ToUpper = "C" Then
            '                                objDynamicLink.FunctionName = objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString + "(&quot;" + strUniqueID.ToString + "&quot;)"
            '                            Else
            '                                If CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SystemLinkType).ToString.Trim.ToUpper <> "HELP" Then
            '                                    objDynamicLink.FunctionName = objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString + "()"
            '                                Else
            '                                    objDynamicLink.FunctionName = objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString + "(" + MyBase.TagID.ToString + ")"
            '                                End If
            '                            End If
            '                            objDynamicLink.Tooltip = objDynamicLinksHashTable(intIndex).LinkToolTip.ToString
            '                            objDynamicLink.cssClass = strcssMenuClass
            '                            sbMenuLink.Append(" " + strLinkSeperatorHTML & " " + objDynamicLink.GetDynamicLink())
            '                            'Code for Client side function
            '                            If blnReturnClientsideScript = True And _
            '                                CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SystemLinkType).ToString.Trim.ToUpper <> "HELP" Then
            '                                'Do not generate client side script for Help
            '                                Select Case CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).LinkType).ToUpper
            '                                    Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_CUSTOMPAGE_D
            '                                        sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ClientSideFunctionName).ToString + "(lngUniqueID)" + vbCrLf)
            '                                        sbClientsideScript.Append("{" & vbCrLf)
            '                                        'Dynamic Custom Page Link
            '                                        sbClientsideScript.Append("window.open (" & Chr(34) & ReplacePlaceHolders(CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).CustomLink.ToString)) + Chr(34) + ", """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                        sbClientsideScript.Append("}" & vbCrLf)
            '                                    Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_COMMONENGINE_C
            '                                        sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString) + "(intUniqueID)" + vbCrLf)
            '                                        sbClientsideScript.Append("{" & vbCrLf)
            '                                        sbClientsideScript.Append(strEnabledControls)
            '                                        If blnIsListPageLink = True Then
            '                                            sbClientsideScript.Append(vbCrLf & "objfrm.action=" + Chr(34) + "CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + objDynamicLinksHashTable(intIndex).UniqueID.ToString + "&UniqueValue="" + intUniqueID + ""&IsListPageLink=1&" + strCommonQueryString & Chr(34))
            '                                        Else
            '                                            sbClientsideScript.Append(vbCrLf & "objfrm.action=" + Chr(34) + "CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + objDynamicLinksHashTable(intIndex).UniqueID.ToString + "&UniqueValue="" + intUniqueID + ""&IsListPageLink=0" & Chr(34))
            '                                        End If
            '                                        sbClientsideScript.Append(vbCrLf & "objfrm.submit()" & vbCrLf)
            '                                        sbClientsideScript.Append("}" & vbCrLf)
            '                                    Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_SYSTEM_S
            '                                        sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString) & "()" & vbCrLf)
            '                                        sbClientsideScript.Append("{" & vbCrLf)
            '                                        Select Case CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SystemLinkType).Trim.ToUpper
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_ADD_NEW  '"ADD_NEW"
            '                                                '....IssueID 9046...Show Add New link in Edit Mode
            '                                                Dim strTempQueryString As String = strCommonQueryString
            '                                                If strAddNewLinkOnUI_CommonQueryString.Trim <> "" Then strCommonQueryString = strAddNewLinkOnUI_CommonQueryString

            '                                                If blnAddNewMode_UIPageOpenInWindow = False Then
            '                                                    If strCommonQueryString.Trim = "" Then
            '                                                        If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                            sbClientsideScript.Append("     window.location.href=" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW" & Chr(34) + ";" + vbCrLf)
            '                                                        Else
            '                                                            sbClientsideScript.Append("     window.location.href=" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW" & Chr(34) + ";" + vbCrLf)
            '                                                        End If
            '                                                    Else
            '                                                        If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                            sbClientsideScript.Append("     window.location.href=" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW&" & strCommonQueryString & Chr(34) + ";" + vbCrLf)
            '                                                        Else
            '                                                            sbClientsideScript.Append("     window.location.href=" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW&" & strCommonQueryString & Chr(34) + ";" + vbCrLf)
            '                                                        End If
            '                                                    End If
            '                                                Else
            '                                                    If strCommonQueryString.Trim = "" Then
            '                                                        If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                            sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW" & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                        Else
            '                                                            sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW" & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                        End If
            '                                                    Else
            '                                                        If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                            sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW&" & strCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                        Else
            '                                                            sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW&" & strCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                        End If
            '                                                    End If
            '                                                End If
            '                                                strCommonQueryString = strTempQueryString
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_DELETE  '"DELETE"
            '                                                'Check if any records selected before submitting the form
            '                                                sbClientsideScript.Append(vbCrLf + WriteClientsideScript_CheckIfRecordsSelected())
            '                                                sbClientsideScript.Append(vbCrLf & "if(confirm(" & Chr(34) & strMessageForDeleteConfirm & Chr(34) & "))")
            '                                                sbClientsideScript.Append(vbCrLf & "{")
            '                                                If strCommonQueryString.Trim = "" Then
            '                                                    sbClientsideScript.Append(vbCrLf & "    objfrm.action=" & Chr(34) & "Commonlist.aspx?Operation=DELETE" & Chr(34))
            '                                                Else
            '                                                    sbClientsideScript.Append(vbCrLf & "    objfrm.action=" & Chr(34) & "Commonlist.aspx?Operation=DELETE&" & strCommonQueryString & Chr(34))
            '                                                End If
            '                                                sbClientsideScript.Append(vbCrLf & "    objfrm.submit()")
            '                                                sbClientsideScript.Append(vbCrLf & "}" & vbCrLf)
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SELECT_ALL  '"SELECT_ALL"
            '                                                sbClientsideScript.Append(vbCrLf & "if (" & lngRecordCount & " == 0 )")
            '                                                sbClientsideScript.Append(vbCrLf & "{ return; }")
            '                                                sbClientsideScript.Append(vbCrLf & "else if (" & lngRecordCount & "== 1 )")
            '                                                sbClientsideScript.Append(vbCrLf & "{")
            '                                                sbClientsideScript.Append(vbCrLf & "if (objfrm." + strDeletionCheckboxName + ".disabled == false )")
            '                                                sbClientsideScript.Append(vbCrLf & "{objfrm." + strDeletionCheckboxName + ".checked = true }")
            '                                                sbClientsideScript.Append(vbCrLf & "}")
            '                                                sbClientsideScript.Append(vbCrLf & "else")
            '                                                sbClientsideScript.Append(vbCrLf & "{")
            '                                                sbClientsideScript.Append(vbCrLf & "    for(intCnt = 0;intCnt<=" & lngRecordCount - 1 & ";intCnt++)")
            '                                                sbClientsideScript.Append(vbCrLf & "    {")
            '                                                sbClientsideScript.Append(vbCrLf & "if (objfrm." + strDeletionCheckboxName + "[intCnt].disabled == false )")
            '                                                sbClientsideScript.Append(vbCrLf & "{objfrm." + strDeletionCheckboxName + "[intCnt].checked = true }")
            '                                                sbClientsideScript.Append(vbCrLf & "    }")
            '                                                sbClientsideScript.Append(vbCrLf & "}" & vbCrLf)

            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SAVE  '"SAVE"
            '                                                sbClientsideScript.Append(strValidationRules & vbCrLf)
            '                                                sbClientsideScript.Append(strEnabledControls & vbCrLf)
            '                                                If strCommonQueryString.Trim = "" Then
            '                                                    sbClientsideScript.Append(vbCrLf & "objfrm.action=" & Chr(34) & "CommonPage.aspx?Operation=SAVE" & Chr(34))
            '                                                Else
            '                                                    sbClientsideScript.Append(vbCrLf & "objfrm.action=" & Chr(34) & "CommonPage.aspx?Operation=SAVE&" & strCommonQueryString & Chr(34))
            '                                                End If
            '                                                sbClientsideScript.Append(vbCrLf & "objfrm.submit()" & vbCrLf)

            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_BACK  '"BACK"
            '                                                'Got back to the Commmon List Page
            '                                                sbClientsideScript.Append("window.location.href=" & Chr(34) & "CommonList.aspx?" & strCommonQueryString & Chr(34) & vbCrLf)
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SHOW_HISTORY  '"SHOW_HISTORY"
            '                                                'Show the Audit Trail
            '                                                If CommonFunction.General.CheckIsNothing(m_ObjGlobal.FromWhere, "") <> "PM" Then
            '                                                    sbClientsideScript.Append(vbCrLf & "window.open (""AuditTrail.aspx?IsSubTag=0&TagID=" & m_ObjGlobal.TagID & "&UniqueID=" & strUniqueID & "&ProjectID="", """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                Else
            '                                                    sbClientsideScript.Append(vbCrLf & "window.open (""AuditTrail.aspx?IsSubTag=0&TagID=" & m_ObjGlobal.TagID & "&UniqueID=" & strUniqueID & "&ProjectID=" & m_ObjGlobal.ProjectID.ToString & """, """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                End If

            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_CONFIGURE  '"CONFIGURE"
            '                                                'Show the Page Maintenance wizard  '''''Special height and width
            '                                                sbClientsideScript.Append(vbCrLf + "window.open (""../SM/PB_PageCanvas.aspx?FromUI=1&FromElement=Tag&MasterTagID=315&FromWhere=SM&TagID=" & m_ObjGlobal.TagID & """, """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - 900)/2) + "",top="" + ((window.screen.height - 650)/2) + "",width=900,height=650"");" + vbCrLf)
            '                                        End Select
            '                                        sbClientsideScript.Append(vbCrLf + "}" + vbCrLf)
            '                                End Select

            '                            End If
            '                        End If
            '                    End If
            '                End If
            '            End If
            '        Next
            '        objDynamicLinksHashTable = Nothing
            '    End If

            '    'If the Link(s) are present then append "|"
            '    If blnLink = True Then sbMenuLink.Append(" " & strLinkSeperatorHTML)
            '    sbMenuLink.Append("</TD>")
            '    'END Client side script block
            '    If blnReturnClientsideScript = True Then sbClientsideScript.Append(vbCrLf & "</SCRIPT>" & vbCrLf)
            '    strClientsideScript = strClientsideScript + sbClientsideScript.ToString
            '    DrawMenuLinks = (sbMenuLink.ToString)
            '    'Destroy the objects
            '    sbMenuLink = Nothing
            '    sbClientsideScript = Nothing
            'End Function
            'Private Function DrawSubTagMenuLinks() As String
            '    '=====================================================================
            '    ' Procedure Name        :	DrawSubTagMenuLinks
            '    ' Purpose               :	Draw the Menu Links 
            '    ' Description           :	This method will build the HTML string to
            '    '                           draw the page menu links depending upon its display
            '    '                           position. 
            '    ' Parameters Passed     :	None.
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	Return the Sub Tag Menu Links HTML string
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	September 06, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim drMenuLinks As IDataReader
            '    Dim strSQL As String
            '    Dim sbMenuLink As New System.Text.StringBuilder()
            '    Dim sbClientsideScript As New System.Text.StringBuilder()
            '    Dim objDynamicLink As New cDynamicLink()
            '    Dim blnLink As Boolean = False

            '    sbMenuLink.Append("<TD align=right>")
            '    'Assign the Common Properties only once
            '    objDynamicLink.LinkStyle = strLinkStyle
            '    objDynamicLink.ReturnHTML = True
            '    'START Client side script block
            '    If blnReturnClientsideScript = True Then sbClientsideScript.Append(vbCrLf & "<SCRIPT Language=javascript>" & vbCrLf)

            '    If MyBase.UseHashTable = "N" Then
            '        'Get the Link details for the selected Page
            '        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.LCID Then
            '            'Local culture ID is same as the default culture id
            '            strSQL = "usp_Sel_tbl_UI_SubTag_Dynamic_Links " & MyBase.TagID & ",null,null,'" & strDisplayPosition & "'"
            '        Else
            '            'Culture ID is other than the default culture id
            '            'Check if the Culture is supported by the system
            '            'If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), MyBase.LCID.ToString, CompareMethod.Text) <> 0 Then
            '            'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '            strSQL = "usp_Sel_tbl_UI_SubTag_Dynamic_Links " & MyBase.TagID & ",null,null,'" & strDisplayPosition & "'," & MyBase.LCID.ToString
            '            drMenuLinks = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '            If Not drMenuLinks.Read Then
            '                'No. Culture is NOT supported. Retrieve the data from the defual culture 
            '                strSQL = "usp_Sel_tbl_UI_SubTag_Dynamic_Links " & MyBase.TagID & ",null,null,'" & strDisplayPosition & "'"
            '            Else
            '                drMenuLinks.Close()
            '                drMenuLinks.Dispose()
            '                drMenuLinks = Nothing
            '            End If
            '        End If

            '        drMenuLinks = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '        'Plot links one by one
            '        Do While drMenuLinks.Read
            '            Dim strLinkURL As String = ""
            '            If Not IsDBNull(drMenuLinks("CustomLink")) Then strLinkURL = drMenuLinks("CustomLink").ToString
            '            'Check if the User has access of the link
            '            If CheckLinkAccessRights(CommonFunction.General.CheckIsNothing(drMenuLinks("AccessRights"))) = True Then
            '                If CheckConditionClause(CommonFunction.General.CheckIsNothing(drMenuLinks("ConditionClause")), CommonFunction.General.CheckIsNothing(drMenuLinks("LinkType"), ""), strLinkURL) = True Then
            '                    If CheckSystemLink(drMenuLinks("LinkName").ToString, CommonFunction.General.CheckIsNothing(drMenuLinks("SystemLinkType"), "")) = True Then
            '                        'Flag to indicate : link(s) are present
            '                        blnLink = True
            '                        If Not IsDBNull(drMenuLinks("ImageURL")) Then
            '                            If drMenuLinks("ImageURL").ToString.Trim <> "" Then
            '                                objDynamicLink.LinkName = "<Img Border=0 src='" + drMenuLinks("ImageURL").ToString.Trim + "'>&nbsp;" + drMenuLinks("LinkName").ToString
            '                            Else
            '                                objDynamicLink.LinkName = drMenuLinks("LinkName").ToString
            '                            End If
            '                        Else
            '                            objDynamicLink.LinkName = drMenuLinks("LinkName").ToString
            '                        End If
            '                        If CommonFunction.General.CheckIsNothing(drMenuLinks("LinkType")).ToUpper = "C" Or _
            '                            CommonFunction.General.CheckIsNothing(drMenuLinks("LinkType")).ToUpper = "D" Then
            '                            objDynamicLink.FunctionName = drMenuLinks("ClientSideFunctionName").ToString + "(&quot;" + strUniqueID.ToString + "&quot;)"
            '                        Else
            '                            If CommonFunction.General.CheckIsNothing(drMenuLinks("SystemLinkType").ToString).Trim.ToUpper <> "HELP" Then
            '                                objDynamicLink.FunctionName = drMenuLinks("ClientSideFunctionName").ToString + "()"
            '                            Else
            '                                'Help function need a parameter
            '                                objDynamicLink.FunctionName = drMenuLinks("ClientSideFunctionName").ToString + "('" + MyBase.ParentTagID.ToString + "-" + MyBase.TagID.ToString + "')"
            '                            End If
            '                        End If
            '                        objDynamicLink.cssClass = strcssMenuClass
            '                        objDynamicLink.Tooltip = drMenuLinks("LinkToolTip").ToString
            '                        sbMenuLink.Append(" " & strLinkSeperatorHTML & " " & objDynamicLink.GetDynamicLink())
            '                        'Code for Client side function 
            '                        If blnReturnClientsideScript = True And _
            '                            CommonFunction.General.CheckIsNothing(drMenuLinks("SystemLinkType").ToString).Trim.ToUpper <> "HELP" Then
            '                            'Do not generate Client side script for help tag
            '                            Select Case CommonFunction.General.CheckIsNothing(drMenuLinks("LinkType")).ToUpper
            '                                Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_CUSTOMPAGE_D
            '                                    sbClientsideScript.Append("function " + CommonFunction.General.CheckIsNothing(drMenuLinks("ClientSideFunctionName").ToString) + "(intUniqueID)" + vbCrLf)
            '                                    sbClientsideScript.Append("{" & vbCrLf)
            '                                    'Dynamic Custom Page Link
            '                                    sbClientsideScript.Append("window.open (" + Chr(34) + ReplacePlaceHolders(CommonFunction.General.CheckIsNothing(drMenuLinks("CustomLink").ToString)) + Chr(34) + ", """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                    sbClientsideScript.Append("}" + vbCrLf)
            '                                Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_COMMONENGINE_C
            '                                    sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(drMenuLinks("ClientSideFunctionName").ToString) + "(intUniqueID)" + vbCrLf)
            '                                    sbClientsideScript.Append("{" + vbCrLf)
            '                                    sbClientsideScript.Append(strEnabledControls + vbCrLf)
            '                                    If blnIsListPageLink = True Then
            '                                        sbClientsideScript.Append(vbCrLf & "objfrm.action=" + Chr(34) + "CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + drMenuLinks("UniqueID").ToString + "&UniqueValue="" + intUniqueID + ""&IsListPageLink=1&" + strCommonQueryString & Chr(34))
            '                                    Else
            '                                        sbClientsideScript.Append(vbCrLf & "objfrm.action=" + Chr(34) + "CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + drMenuLinks("UniqueID").ToString + "&UniqueValue="" + intUniqueID + ""&IsListPageLink=0&" + strCommonQueryString & Chr(34))
            '                                    End If
            '                                    sbClientsideScript.Append(vbCrLf & "objfrm.submit()" & vbCrLf)
            '                                    sbClientsideScript.Append("}" & vbCrLf)
            '                                Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_SYSTEM_S
            '                                    sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(drMenuLinks("ClientSideFunctionName").ToString) & "()" + vbCrLf)
            '                                    sbClientsideScript.Append("{" & vbCrLf)
            '                                    Select Case CommonFunction.General.CheckIsNothing(drMenuLinks("SystemLinkType").ToString).Trim.ToUpper
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_ADD_NEW  '"ADD_NEW"
            '                                            '....IssueID 9046...Show Add New link in Edit Mode
            '                                            Dim strTempQueryString As String = strSubTagCommonQueryString
            '                                            If strAddNewLinkOnUI_CommonQueryString.Trim <> "" Then strSubTagCommonQueryString = strAddNewLinkOnUI_CommonQueryString

            '                                            If strSubTagCommonQueryString.Trim = "" Then
            '                                                If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                    'No Parameters
            '                                                    sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW" & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                Else
            '                                                    sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW" & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                End If
            '                                            Else
            '                                                If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                    'No parameters
            '                                                    sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW&" & strSubTagCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                Else
            '                                                    sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW&" & strSubTagCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                End If
            '                                            End If
            '                                            strSubTagCommonQueryString = strTempQueryString
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_DELETE  '"DELETE"
            '                                            'Check if any records selected before submitting the form
            '                                            sbClientsideScript.Append(vbCrLf + WriteClientsideScript_CheckIfRecordsSelected())
            '                                            sbClientsideScript.Append(vbCrLf & "if(confirm(" & Chr(34) & strMessageForDeleteConfirm & Chr(34) & "))")
            '                                            sbClientsideScript.Append(vbCrLf & "{")
            '                                            If strCommonQueryString.Trim = "" Then
            '                                                sbClientsideScript.Append(vbCrLf & "    objfrm.action=" & Chr(34) & "CommonPage.aspx?FocusOn=SUBTAG&Operation=DELETE" & Chr(34))
            '                                            Else
            '                                                sbClientsideScript.Append(vbCrLf & "    objfrm.action=" & Chr(34) & "CommonPage.aspx?FocusOn=SUBTAG&Operation=DELETE&" & strCommonQueryString & Chr(34))
            '                                            End If
            '                                            sbClientsideScript.Append(vbCrLf & "    objfrm.submit()")
            '                                            sbClientsideScript.Append(vbCrLf & "}" & vbCrLf)
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SELECT_ALL  '"SELECT_ALL"
            '                                            sbClientsideScript.Append(vbCrLf & "if (" & lngRecordCount & " == 0 )")
            '                                            sbClientsideScript.Append(vbCrLf & "{ return; }")
            '                                            sbClientsideScript.Append(vbCrLf & "else if (" & lngRecordCount & "== 1 )")
            '                                            sbClientsideScript.Append(vbCrLf & "{")
            '                                            sbClientsideScript.Append(vbCrLf & "if (objfrm." + strDeletionCheckboxName + ".disabled == false )")
            '                                            sbClientsideScript.Append(vbCrLf & "{objfrm." + strDeletionCheckboxName + ".checked = true }")
            '                                            sbClientsideScript.Append(vbCrLf & "}")
            '                                            sbClientsideScript.Append(vbCrLf & "else")
            '                                            sbClientsideScript.Append(vbCrLf & "{")
            '                                            sbClientsideScript.Append(vbCrLf & "    for(intCnt = 0;intCnt<=" & lngRecordCount - 1 & ";intCnt++)")
            '                                            sbClientsideScript.Append(vbCrLf & "    {")
            '                                            sbClientsideScript.Append(vbCrLf & "if (objfrm." + strDeletionCheckboxName + "(intCnt).disabled == false )")
            '                                            sbClientsideScript.Append(vbCrLf & "{objfrm." + strDeletionCheckboxName + "(intCnt).checked = true }")
            '                                            sbClientsideScript.Append(vbCrLf & "    }")
            '                                            sbClientsideScript.Append(vbCrLf & "}" & vbCrLf)

            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SAVE  '"SAVE"
            '                                            sbClientsideScript.Append(strValidationRules & vbCrLf)
            '                                            sbClientsideScript.Append(strEnabledControls & vbCrLf)
            '                                            If strCommonQueryString.Trim = "" Then
            '                                                sbClientsideScript.Append(vbCrLf & "objfrm.action=" & Chr(34) & "CommonPage.aspx?Operation=SAVE" & Chr(34))
            '                                            Else
            '                                                sbClientsideScript.Append(vbCrLf & "objfrm.action=" & Chr(34) & "CommonPage.aspx?Operation=SAVE&" & strCommonQueryString & Chr(34))
            '                                            End If
            '                                            sbClientsideScript.Append(vbCrLf & "objfrm.submit()" & vbCrLf)
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_CLOSE  '"CLOSE"
            '                                            'Close the window
            '                                            sbClientsideScript.Append("window.close();" & vbCrLf)
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_BACK  '"BACK"
            '                                            'Got back to the Commmon List Page
            '                                            sbClientsideScript.Append("window.location.href=" & Chr(34) & "CommonList.aspx?" & strCommonQueryString & Chr(34) & vbCrLf)
            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SHOW_HISTORY  '"SHOW_HISTORY"
            '                                            'Show the Audit Trail
            '                                            If CommonFunction.General.CheckIsNothing(m_ObjGlobal.FromWhere, "") <> "PM" Then
            '                                                sbClientsideScript.Append(vbCrLf & "window.open (""AuditTrail.aspx?IsSubTag=1&TagID=" & m_ObjGlobal.TagID & "&UniqueID=" & strUniqueID & "&ProjectID="", """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                            Else
            '                                                sbClientsideScript.Append(vbCrLf & "window.open (""AuditTrail.aspx?IsSubTag=1&TagID=" & m_ObjGlobal.TagID & "&UniqueID=" & strUniqueID & "&ProjectID=" & m_ObjGlobal.ProjectID.ToString & """, """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                            End If

            '                                        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_CONFIGURE  '"CONFIGURE"
            '                                            'Show the Page Maintenance wizard 
            '                                            sbClientsideScript.Append(vbCrLf + "window.open (""../SM/PB_PageCanvas.aspx?FromUI=1&FromElement=SubTag&MasterTagID=315&FromWhere=SM&SubTagID=" & m_ObjGlobal.TagID & """, """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - 900)/2) + "",top="" + ((window.screen.height - 650)/2) + "",width=900,height=650"");" + vbCrLf)
            '                                    End Select
            '                                    sbClientsideScript.Append(vbCrLf + "}" + vbCrLf)
            '                            End Select

            '                        End If
            '                    End If
            '                End If
            '            End If
            '        Loop
            '        drMenuLinks.Dispose()
            '        drMenuLinks.Close()
            '        drMenuLinks = Nothing
            '    Else

            '        Dim objDynamicLinksHashTable As CommonEngines.HashTables.DynamicLinks()
            '        Dim intIndex As Integer
            '        Dim intLength As Integer

            '        If InStr(strDisplayPosition, "LIST", CompareMethod.Text) > 0 Then
            '            'Get the Link details for the selected Page
            '            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.LCID Then
            '                objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCLObject(CType(MyBase.TagID, Long))
            '            Else
            '                'Culture ID is other than the default culture id
            '                'Check if the Culture is supported by the system

            '                'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '                objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCLObject(MyBase.TagID.ToString & MyBase.LCID.ToString)
            '                If objDynamicLinksHashTable Is Nothing Then
            '                    'No. Culture is NOT supported. Retrieve the data from the defualt culture 
            '                    objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCLObject(CType(MyBase.TagID, Long))
            '                End If
            '            End If
            '        Else
            '            'Get the Link details for the selected Page
            '            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.LCID Then
            '                objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCPObject(MyBase.TagID)
            '            Else
            '                'Culture ID is other than the default culture id
            '                'Check if the Culture is supported by the system
            '                'If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), MyBase.LCID.ToString, CompareMethod.Text) <> 0 Then
            '                'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '                objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCPObject(MyBase.TagID.ToString & MyBase.LCID.ToString)
            '                If objDynamicLinksHashTable Is Nothing Then
            '                    'No. Culture is NOT supported. Retrieve the data from the defualt culture 
            '                    objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCPObject(MyBase.TagID)
            '                End If
            '            End If
            '        End If
            '        If objDynamicLinksHashTable Is Nothing Then Return ""
            '        intLength = objDynamicLinksHashTable.Length

            '        For intIndex = 0 To intLength - 1
            '            strDisplayPosition = UCase(strDisplayPosition)
            '            If (strDisplayPosition = "LIST_HEAD" And _
            '                    (InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "LIST_HEAD") <> 0 Or InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "LIST_BOTH") <> 0)) _
            '               Or (strDisplayPosition = "LIST_FOOT" And _
            '                    (InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "LIST_FOOT") <> 0 Or InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "LIST_BOTH") <> 0)) _
            '               Or (strDisplayPosition = "UI_HEAD" And _
            '                    (InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "UI_HEAD") <> 0 Or InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "UI_BOTH") <> 0)) _
            '               Or (strDisplayPosition = "UI_FOOT" And _
            '                    (InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "UI_FOOT") <> 0 Or InStr(objDynamicLinksHashTable(intIndex).DisplayPosition, "UI_BOTH") <> 0)) Then
            '                'If the Link is defined for the Specified position then for each link
            '                'Check if the User has access of the link
            '                If CheckLinkAccessRights(CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).AccessRights)) = True Then
            '                    If CheckConditionClause(CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ConditionClause), CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).LinkType, ""), CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).CustomLink)) = True Then
            '                        If CheckSystemLink(objDynamicLinksHashTable(intIndex).LinkName.ToString, CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SystemLinkType, "")) = True Then
            '                            'Flag to indicate : link(s) are present
            '                            blnLink = True
            '                            If CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ImageURL).Trim <> "" Then
            '                                objDynamicLink.LinkName = "<Img Border=0 src='" + objDynamicLinksHashTable(intIndex).ImageURL + "'>&nbsp;" + objDynamicLinksHashTable(intIndex).LinkName.ToString
            '                            Else
            '                                objDynamicLink.LinkName = objDynamicLinksHashTable(intIndex).LinkName.ToString
            '                            End If
            '                            If CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).LinkType).ToUpper = "D" Or _
            '                                CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).LinkType).ToUpper = "C" Then
            '                                objDynamicLink.FunctionName = objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString + "(&quot;" + strUniqueID.ToString + "&quot;)"
            '                            Else
            '                                If CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SystemLinkType).ToString.Trim.ToUpper <> "HELP" Then
            '                                    objDynamicLink.FunctionName = objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString + "()"
            '                                Else
            '                                    objDynamicLink.FunctionName = objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString + "('" + MyBase.ParentTagID.ToString + "-" + MyBase.TagID.ToString + "')"
            '                                End If
            '                            End If
            '                            objDynamicLink.cssClass = strcssMenuClass
            '                            objDynamicLink.Tooltip = objDynamicLinksHashTable(intIndex).LinkToolTip.ToString
            '                            sbMenuLink.Append(" " + strLinkSeperatorHTML + " " + objDynamicLink.GetDynamicLink())
            '                            'Code for Client side function
            '                            If blnReturnClientsideScript = True And _
            '                                CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SystemLinkType).ToString.Trim.ToUpper <> "HELP" Then
            '                                'Do not generate client side script for Help
            '                                Select Case CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).LinkType).ToUpper
            '                                    Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_CUSTOMPAGE_D
            '                                        sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ClientSideFunctionName).ToString + "(intUniqueID)" + vbCrLf)
            '                                        sbClientsideScript.Append("{" & vbCrLf)
            '                                        'Dynamic Custom Page Link
            '                                        sbClientsideScript.Append("window.open (" & Chr(34) & ReplacePlaceHolders(CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).CustomLink.ToString)) + Chr(34) + ", """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                        sbClientsideScript.Append("}" & vbCrLf)
            '                                    Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_COMMONENGINE_C
            '                                        sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString) + "(intUniqueID)" + vbCrLf)
            '                                        sbClientsideScript.Append("{" & vbCrLf)
            '                                        sbClientsideScript.Append(strEnabledControls)
            '                                        If blnIsListPageLink = True Then
            '                                            sbClientsideScript.Append(vbCrLf & "objfrm.action=" + Chr(34) + "CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + objDynamicLinksHashTable(intIndex).UniqueID.ToString + "&UniqueValue="" + intUniqueID + ""&IsListPageLink=1&" + strCommonQueryString & Chr(34))
            '                                        Else
            '                                            sbClientsideScript.Append(vbCrLf & "objfrm.action=" + Chr(34) + "CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + objDynamicLinksHashTable(intIndex).UniqueID.ToString + "&UniqueValue="" + intUniqueID + ""&IsListPageLink=0&" + strCommonQueryString & Chr(34))
            '                                        End If
            '                                        sbClientsideScript.Append(vbCrLf & "objfrm.submit()" & vbCrLf)
            '                                        sbClientsideScript.Append("}" & vbCrLf)
            '                                    Case CommonFunction.Constants.DYNAMIC_LINK_TYPE_SYSTEM_S
            '                                        sbClientsideScript.Append("function " & CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).ClientSideFunctionName.ToString) & "()" & vbCrLf)
            '                                        sbClientsideScript.Append("{" & vbCrLf)
            '                                        Select Case CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SystemLinkType).Trim.ToUpper
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_ADD_NEW  '"ADD_NEW"
            '                                                '....IssueID 9046...Show Add New link in Edit Mode
            '                                                Dim strTempQueryString As String = strSubTagCommonQueryString
            '                                                If strAddNewLinkOnUI_CommonQueryString.Trim <> "" Then strSubTagCommonQueryString = strAddNewLinkOnUI_CommonQueryString
            '                                                If strSubTagCommonQueryString.Trim = "" Then
            '                                                    If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                        sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW" & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                    Else
            '                                                        sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW" & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                    End If
            '                                                Else
            '                                                    If InStr(1, strAddNewMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            '                                                        sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "?Mode=ADD_NEW&" & strSubTagCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                    Else
            '                                                        sbClientsideScript.Append("     window.open(" & Chr(34) + strAddNewMode_UIPage + "&Mode=ADD_NEW&" & strSubTagCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                    End If
            '                                                End If
            '                                                strSubTagCommonQueryString = strTempQueryString
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_DELETE  '"DELETE"
            '                                                'Check if any records selected before submitting the form
            '                                                sbClientsideScript.Append(vbCrLf + WriteClientsideScript_CheckIfRecordsSelected())
            '                                                sbClientsideScript.Append(vbCrLf & "if(confirm(" & Chr(34) & strMessageForDeleteConfirm & Chr(34) & "))")
            '                                                sbClientsideScript.Append(vbCrLf & "{")
            '                                                If strCommonQueryString.Trim = "" Then
            '                                                    sbClientsideScript.Append(vbCrLf & "    objfrm.action=" & Chr(34) & "CommonPage.aspx?FocusOn=SUBTAG&Operation=DELETE" & Chr(34))
            '                                                Else
            '                                                    sbClientsideScript.Append(vbCrLf & "    objfrm.action=" & Chr(34) & "CommonPage.aspx?FocusOn=SUBTAG&Operation=DELETE&" & strCommonQueryString & Chr(34))
            '                                                End If
            '                                                sbClientsideScript.Append(vbCrLf & "    objfrm.submit()")
            '                                                sbClientsideScript.Append(vbCrLf & "}" & vbCrLf)
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SELECT_ALL  '"SELECT_ALL"
            '                                                sbClientsideScript.Append(vbCrLf & "if (" & lngRecordCount & " == 0 )")
            '                                                sbClientsideScript.Append(vbCrLf & "{ return; }")
            '                                                sbClientsideScript.Append(vbCrLf & "else if (" & lngRecordCount & "== 1 )")
            '                                                sbClientsideScript.Append(vbCrLf & "{")
            '                                                sbClientsideScript.Append(vbCrLf & "if (objfrm." + strDeletionCheckboxName + ".disabled == false )")
            '                                                sbClientsideScript.Append(vbCrLf & "{objfrm." + strDeletionCheckboxName + ".checked = true }")
            '                                                sbClientsideScript.Append(vbCrLf & "}")
            '                                                sbClientsideScript.Append(vbCrLf & "else")
            '                                                sbClientsideScript.Append(vbCrLf & "{")
            '                                                sbClientsideScript.Append(vbCrLf & "    for(intCnt = 0;intCnt<=" & lngRecordCount - 1 & ";intCnt++)")
            '                                                sbClientsideScript.Append(vbCrLf & "    {")
            '                                                sbClientsideScript.Append(vbCrLf & "if (objfrm." + strDeletionCheckboxName + "[intCnt].disabled == false )")
            '                                                sbClientsideScript.Append(vbCrLf & "{objfrm." + strDeletionCheckboxName + "[intCnt].checked = true }")
            '                                                sbClientsideScript.Append(vbCrLf & "    }")
            '                                                sbClientsideScript.Append(vbCrLf & "}" & vbCrLf)

            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SAVE  '"SAVE"
            '                                                sbClientsideScript.Append(strValidationRules & vbCrLf)
            '                                                sbClientsideScript.Append(strEnabledControls & vbCrLf)
            '                                                If strCommonQueryString.Trim = "" Then
            '                                                    sbClientsideScript.Append(vbCrLf & "objfrm.action=" & Chr(34) & "CommonPage.aspx?Operation=SAVE" & Chr(34))
            '                                                Else
            '                                                    sbClientsideScript.Append(vbCrLf & "objfrm.action=" & Chr(34) & "CommonPage.aspx?Operation=SAVE&" & strCommonQueryString & Chr(34))
            '                                                End If
            '                                                sbClientsideScript.Append(vbCrLf & "objfrm.submit()" & vbCrLf)

            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_BACK  '"BACK"
            '                                                'Got back to the Commmon List Page
            '                                                sbClientsideScript.Append("window.location.href=" & Chr(34) & "CommonList.aspx?" & strCommonQueryString & Chr(34) & vbCrLf)
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_CLOSE  '"CLOSE"
            '                                                'Close the window
            '                                                sbClientsideScript.Append("window.close();" & vbCrLf)
            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SHOW_HISTORY  '"SHOW_HISTORY"
            '                                                'Show the Audit Trail
            '                                                If CommonFunction.General.CheckIsNothing(m_ObjGlobal.FromWhere, "") <> "PM" Then
            '                                                    sbClientsideScript.Append(vbCrLf & "window.open (""AuditTrail.aspx?IsSubTag=1&TagID=" & m_ObjGlobal.TagID & "&UniqueID=" & strUniqueID & "&ProjectID="", """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                Else
            '                                                    sbClientsideScript.Append(vbCrLf & "window.open (""AuditTrail.aspx?IsSubTag=1&TagID=" & m_ObjGlobal.TagID & "&UniqueID=" & strUniqueID & "&ProjectID=" & m_ObjGlobal.ProjectID.ToString & """, """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf)
            '                                                End If

            '                                            Case CommonFunction.Constants.SYSTEM_LINK_TYPE_CONFIGURE  '"CONFIGURE"
            '                                                'Show the Page Maintenance wizard 
            '                                                sbClientsideScript.Append(vbCrLf + "window.open (""../SM/PB_PageCanvas.aspx?FromUI=1&FromElement=SubTag&MasterTagID=315&FromWhere=SM&SubTagID=" & m_ObjGlobal.TagID & """, """", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - 900)/2) + "",top="" + ((window.screen.height - 650)/2) + "",width=900,height=650"");" + vbCrLf)
            '                                        End Select
            '                                        sbClientsideScript.Append(vbCrLf + "}" + vbCrLf)
            '                                End Select

            '                            End If
            '                        End If
            '                    End If
            '                End If
            '            End If
            '        Next
            '        objDynamicLinksHashTable = Nothing
            '    End If

            '    'If the Link(s) are present then append "|"
            '    If blnLink = True Then sbMenuLink.Append(" " & strLinkSeperatorHTML)
            '    sbMenuLink.Append("</TD>")
            '    'END Client side script block
            '    If blnReturnClientsideScript = True Then sbClientsideScript.Append(vbCrLf & "</SCRIPT>" & vbCrLf)
            '    strClientsideScript = strClientsideScript + sbClientsideScript.ToString
            '    DrawSubTagMenuLinks = (sbMenuLink.ToString)
            '    'Destroy the objects
            '    sbMenuLink = Nothing
            '    sbClientsideScript = Nothing
            'End Function
            'Private Function WriteClientsideScript_CheckIfRecordsSelected() As String
            '    '=====================================================================
            '    ' Procedure Name        :	WriteClientsideScript_CheckIfRecordsSelected
            '    ' Purpose               :	WriteClientsideScript to Check If deletion Records are Selected
            '    ' Description           :	same as above
            '    ' Parameters Passed     :	none
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	client side script for checking if deletion Records are Selected
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Wednesday, January 07, 2004
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim sbCS As New System.Text.StringBuilder()
            '    sbCS.Append(vbCrLf + "var blnIsRecordSelected=false;")
            '    sbCS.Append(vbCrLf + "if (" + lngRecordCount.ToString + " == 0 )")
            '    sbCS.Append(vbCrLf + "{ return; }")
            '    sbCS.Append(vbCrLf + "else if (" + lngRecordCount.ToString + "== 1 )")
            '    sbCS.Append(vbCrLf + "{")
            '    sbCS.Append(vbCrLf + "if (objfrm." + strDeletionCheckboxName + ".checked == true )")
            '    sbCS.Append(vbCrLf + "{blnIsRecordSelected=true; }")
            '    sbCS.Append(vbCrLf + "}")
            '    sbCS.Append(vbCrLf + "else")
            '    sbCS.Append(vbCrLf + "{")
            '    sbCS.Append(vbCrLf + "    for(intCnt = 0;intCnt<=" + (lngRecordCount - 1).ToString + ";intCnt++)")
            '    sbCS.Append(vbCrLf + "    {")
            '    sbCS.Append(vbCrLf + "      if (objfrm." + strDeletionCheckboxName + "[intCnt].checked == true )")
            '    sbCS.Append(vbCrLf + "      {blnIsRecordSelected = true; break;}")
            '    sbCS.Append(vbCrLf + "    }")
            '    sbCS.Append(vbCrLf + "}")
            '    sbCS.Append(vbCrLf + "if (blnIsRecordSelected == false) {return;}" + vbCrLf)
            '    WriteClientsideScript_CheckIfRecordsSelected = sbCS.ToString
            '    'Destroy
            '    sbCS = Nothing
            'End Function
            'Private Function CheckConditionClause(ByVal strConditionClause As String, ByVal strLinkType As String, Optional ByVal LinkURL As String = "") As Boolean
            '    '=====================================================================
            '    ' Procedure Name        :	CheckConditionClause
            '    ' Purpose               :	Check should the link be displayed or not
            '    ' Description           :	Execute the Conditional clause. If it returns
            '    '                           some result then only display the link else not
            '    ' Parameters Passed     :	strConditionClause - Conditional Clause (SQL),
            '    '                           strLinkType -Link Type, LinkURL
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	If the link to be displayed then return TRUE
            '    '                           else return FALSE
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Thursday, September 11, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    'For Dynamic Links(D) Unique ID is mandatory
            '    If blnIsListPageLink = False And (strLinkType = CommonFunction.Constants.DYNAMIC_LINK_TYPE_CUSTOMPAGE_D Or strLinkType = CommonFunction.Constants.DYNAMIC_LINK_TYPE_COMMONENGINE_C) Then
            '        If strLinkType = CommonFunction.Constants.DYNAMIC_LINK_TYPE_CUSTOMPAGE_D And InStr(1, LinkURL.Trim, "<UNIQUE_ID>", CompareMethod.Text) <> 0 Then
            '            If strUniqueID.Trim = "" Then Return False
            '        End If
            '        If strLinkType = CommonFunction.Constants.DYNAMIC_LINK_TYPE_COMMONENGINE_C Then
            '            If strUniqueID.Trim = "" Then Return False
            '        End If
            '    End If
            '    'If the condition clause is not specified then exit
            '    If strConditionClause.Trim = "" Then
            '        Return True
            '    Else
            '        'For other links if Condition clause is specified then Unique ID is mandatory
            '        If InStr(1, strConditionClause.Trim, "<UNIQUE_ID>", CompareMethod.Text) <> 0 Then
            '            If strUniqueID.Trim = "" Then Return False
            '        End If
            '    End If

            '    Dim drClause As IDataReader
            '    drClause = CommonFunction.Data.GetDataReader(ReplacePlaceHolders(strConditionClause), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '    If drClause.Read() Then
            '        drClause.Dispose()
            '        drClause.Close()
            '        drClause = Nothing
            '        'The Condition clause is successful
            '        Return True
            '    Else
            '        drClause.Dispose()
            '        drClause.Close()
            '        drClause = Nothing
            '        'Condition clause does not return any result. Condition Failed. Do not display the link
            '        Return False
            '    End If
            'End Function

            'Private Function CheckLinkAccessRights(ByVal strAccessRights As String) As Boolean
            '    '=====================================================================
            '    ' Procedure Name        :	CheckLinkAccessRights
            '    ' Purpose               :	Check if the user can access the link or not 
            '    ' Description           :	Check the Mapped Access rights for the user access 
            '    ' Parameters Passed     :	strAccessRights - Mapped Access Rights for the Link
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	If the link is accessible to the user then return TRUE
            '    '                           else return FALSE
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Tuesday, September 09, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    'if access rights should not be considered the  always return true
            '    If blnConsiderAccessRights = False Then Return True

            '    'If none of the access is mapped then return false
            '    If strAccessRights = "" Then Return False

            '    If Microsoft.VisualBasic.InStr(1, strAccessRights, "A", CompareMethod.Text) <> 0 And blnAdd = True Then
            '        'If the AccessRights for the Link are mapped to A then show the link
            '        Return True
            '    ElseIf Microsoft.VisualBasic.InStr(1, strAccessRights, "E", CompareMethod.Text) <> 0 And blnEdit = True Then
            '        'If the AccessRights for the Link are mapped to E then show the link
            '        Return True
            '    ElseIf Microsoft.VisualBasic.InStr(1, strAccessRights, "D", CompareMethod.Text) <> 0 And blnDelete = True Then
            '        'If the AccessRights for the Link are mapped to D then show the link
            '        Return True
            '    ElseIf Microsoft.VisualBasic.InStr(1, strAccessRights, "V", CompareMethod.Text) <> 0 And blnView = True Then
            '        'If the AccessRights for the Link are mapped to V then show the link
            '        Return True
            '    Else
            '        'If none of the access is mapped then return false
            '        Return False
            '    End If
            'End Function

            'Private Function CheckSystemLink(ByVal strLinkName As String, ByVal strSystemLinkType As String) As Boolean
            '    '=====================================================================
            '    ' Procedure Name        :	CheckSystemLink
            '    ' Purpose               :	Check if the specified system link should be 
            '    '                           displayed or not
            '    ' Description           :	Same as above 
            '    ' Parameters Passed     :	strLinkName - Link Name
            '    '                           strSystemLinkType - Link Type    
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	If the link is to be displayed then return TRUE
            '    '                           else return FALSE
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Tuesday, September 11, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    CheckSystemLink = True

            '    'If the Link Type is not (system) then return TRUE
            '    If strSystemLinkType = "" Then Return True
            '    Select Case strSystemLinkType.Trim.ToUpper
            '        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_BACK  '"BACK"
            '            If blnEditMode_UIPageOpenInWindow = False Then
            '                CheckSystemLink = blnShowBackLink
            '                'If HttpContext.Current.Request.ServerVariables("HTTP_REFERER") <> "" Then
            '                '    'HttpContext.Current.Request.UrlReferrer   
            '                '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("IsWindow")) = "1" Then
            '                '        CheckSystemLink = False
            '                '    Else
            '                '        CheckSystemLink = blnShowBackLink
            '                '    End If
            '                'Else
            '                '    CheckSystemLink = False
            '                'End If
            '            Else
            '                CheckSystemLink = False
            '            End If
            '        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_CONFIGURE  '"CONFIGURE"
            '            If MyBase.RoleID <> CommonFunction.Constants.ROLE_ADMINISTRATOR Then CheckSystemLink = False
            '        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_DELETE, CommonFunction.Constants.SYSTEM_LINK_TYPE_SELECT_ALL  '"DELETE", "SELECT_ALL"
            '            If lngRecordCount = 0 Then CheckSystemLink = False
            '        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_SAVE  '"SAVE"
            '            CheckSystemLink = blnShowSaveLink
            '        Case CommonFunction.Constants.SYSTEM_LINK_TYPE_ADD_NEW  '"ADD_NEW"
            '            'ADD NEW Mode...do not show the Add New link....IssueID 9046
            '            If blnIsListPageLink = False And strUniqueID.Trim = "" Then CheckSystemLink = False
            '    End Select
            'End Function
            'Private Function GetPaging() As String
            '    '=====================================================================
            '    ' Procedure Name        :	GetPaging
            '    ' Purpose               :	Get the Paging String
            '    ' Description           :	Use the cPaging Class to get the Paging string 
            '    ' Parameters Passed     :	None.
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	Paging String
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Tuesday, September 02, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    If lngRecordCount = 0 Then Return ""
            '    Dim strPaging As String
            '    Dim objcPaging As New WebPage.UI.cPaging()
            '    GetPaging = ""
            '    With objcPaging
            '        .SQL = strLinkSQL
            '        .PagingAlphabet = strPagingAlphabet
            '        '.PagingAlphabetFontColor = strPagingAlphabetFontColor
            '        '.NonPagingAlphabetFontColor = strNonPagingAlphabetFontColor
            '        .cssClass = strcssPagingClass
            '        .cssSelectedClass = strcssPagingSelectedClass
            '        .ClientSideFunctionName = strPagingFunctionName
            '        .LinkSeperatorHTML = strPagingSeperatorHTML
            '        .MessageForPagingSelect = strMessageForPagingSelect
            '        .ReturnHTML = True
            '        strPaging = objcPaging.DrawPaging.ToString
            '        If strPaging.Trim <> "" Then GetPaging = "<TD align=Left>" + strPaging + "</TD>"
            '    End With
            '    objcPaging = Nothing
            'End Function

            'Private Function ReplacePlaceHolders(ByVal strInput As String) As String
            '    '=====================================================================
            '    ' Procedure Name        :	ReplacePlaceHolders
            '    ' Purpose               :	Replace the Place Holders by actual values
            '    ' Description           :	Same as above
            '    ' Parameters Passed     :	None.
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	String with actual values for the place holders
            '    ' Assumptions           :	None.
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Thursday, September 11, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    If strInput = "" Then Return ""
            '    strInput = CommonFunction.General.ReplacePlaceHolders(strInput)
            '    strInput = Microsoft.VisualBasic.Replace(strInput, "<UNIQUE_ID>", strUniqueID.ToString)
            '    strInput = Microsoft.VisualBasic.Replace(strInput, "<MASTER_PK>", strMasterPrimaryKeyValue)
            '    If MyBase.ParentTagID <> 0 Then
            '        strInput = Microsoft.VisualBasic.Replace(strInput, "<TAG_ID>", MyBase.ParentTagID.ToString)
            '        strInput = Microsoft.VisualBasic.Replace(strInput, "<SUBTAG_ID>", MyBase.TagID.ToString)
            '    Else
            '        strInput = Microsoft.VisualBasic.Replace(strInput, "<TAG_ID>", MyBase.TagID.ToString)
            '    End If
            '    Return strInput
            'End Function

        End Class
        Public Class cSectionTitle 'SectionTitle
            Inherits WebPages.UI.cSectionTitle
            'Inherits WebPage.Templates.Global
            ''=====================================================================
            '' Class	Name	        :	cSectionTitle
            '' Purpose				:	Draw Section Title 
            '' Description			:	
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	Nov 06, 2003
            '' Revisions				:	
            ''=====================================================================
            'Private strImgSrcHideSection As String = ""
            'Private strImgSrcShowSection As String = ""
            'Private strTooltipHideSection As String = ""
            'Private strTooltipShowSection As String = ""
            'Private strFunctionName As String = ""
            'Private blnAllowHideShow As Boolean = True
            'Private strdivID_SectionTag As String = ""
            'Private strClientSideScript As String = ""
            'Private strLinkNames As String()
            'Private strLinkFunctions As String()
            'Private strLinkTooltips As String()
            'Private strLinkSeperatorHTML As String
            'Private blnSaveUserPreference As Boolean = False
            'Private blnShowHideLinks As Boolean = True
            ''Class
            'Private m_strDynamicHideShow As String

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

            'Public WriteOnly Property LinkSeperatorHTML() As String
            '    Set(ByVal Value As String)
            '        strLinkSeperatorHTML = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ImgSrcHideSection() As String
            '    Set(ByVal Value As String)
            '        strImgSrcHideSection = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ImgSrcShowSection() As String
            '    Set(ByVal Value As String)
            '        strImgSrcShowSection = Value
            '    End Set
            'End Property

            'Public WriteOnly Property TooltipHideSection() As String
            '    Set(ByVal Value As String)
            '        strTooltipHideSection = Value
            '    End Set
            'End Property

            'Public WriteOnly Property TooltipShowSection() As String
            '    Set(ByVal Value As String)
            '        strTooltipShowSection = Value
            '    End Set
            'End Property

            'Public WriteOnly Property FunctionName() As String
            '    Set(ByVal Value As String)
            '        strFunctionName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property AllowHideShow() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnAllowHideShow = Value
            '    End Set
            'End Property

            'Public WriteOnly Property divID_SectionTag() As String
            '    Set(ByVal Value As String)
            '        strdivID_SectionTag = Value
            '    End Set
            'End Property

            'Public ReadOnly Property ClientSideScript() As String
            '    Get
            '        Return strClientSideScript
            '    End Get
            'End Property

            'Public WriteOnly Property SaveUserPreference() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnSaveUserPreference = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ShowHideLinks() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnShowHideLinks = Value
            '    End Set
            'End Property

            'Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            '    'Assign the Parameter values to the local variables
            '    MyBase.TagID = WhizGlobal.TagID
            '    MyBase.RoleID = WhizGlobal.RoleID
            '    MyBase.UserID = WhizGlobal.UserID
            '    MyBase.LoginType = WhizGlobal.LoginType
            '    MyBase.UserName = WhizGlobal.UserName
            '    MyBase.ParentTagID = WhizGlobal.ParentTagID
            '    MyBase.ProjectID = WhizGlobal.ProjectID
            '    MyBase.UseHashTable = WhizGlobal.UseHashTable.ToString
            '    MyBase.LCID = WhizGlobal.LCID
            '    MyBase.clsTable = WhizGlobal.clsTable.ToString
            '    MyBase.clsTR = WhizGlobal.clsTR.ToString
            '    MyBase.TableStyle = WhizGlobal.TableStyle.ToString
            '    MyBase.returnHTML = WhizGlobal.returnHTML
            'End Sub

            'Public Sub New()
            '    MyBase.clsTable = "clsTable"
            '    MyBase.clsTR = " clsTRSectionHeader "
            '    MyBase.TableStyle = " cellspacing=0 cellpadding=0 Width='100%' "
            'End Sub

            'Public Function DrawSectionTitle(ByVal LeftSectionTitle As String, Optional ByVal RightSectionTitle As String = "", Optional ByVal MiddleSectionTitle As String = "") As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawSectionTitle
            '    ' Description           :   This PUBLIC method will build the complete HTML
            '    '                           Table for the Section Title
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Return the HTML string for the Section Title
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, November 06, 2003
            '    ' Revisions             :
            '    '=====================================================================

            '    Dim sbSectionTitleHTML As New System.Text.StringBuilder()
            '    sbSectionTitleHTML.Append("<TABLE " & MyBase.TableStyle & " class=" & MyBase.clsTable & ">")
            '    sbSectionTitleHTML.Append("<TR class=" & MyBase.clsTR & ">")

            '    If strLinkNames Is Nothing Then blnShowHideLinks = False

            '    'Hode-show image
            '    If blnAllowHideShow = True And Trim(strFunctionName) <> "" Then
            '        m_strDynamicHideShow = "tdShowHide_" + strFunctionName
            '        sbSectionTitleHTML.Append("<TD  align=Left width='1%'")
            '        sbSectionTitleHTML.Append(">")
            '        sbSectionTitleHTML.Append("<A href=""Javascript:" + strFunctionName + "()""><Img Border=0 id=" + m_strDynamicHideShow + " Src='" + strImgSrcHideSection.Trim + "' title='" + strTooltipHideSection.Trim + "'></A>")
            '        sbSectionTitleHTML.Append("</TD>")

            '        'Construct the client side script
            '        If blnSaveUserPreference = False Then Call MakeClientsideScript()
            '    End If
            '    If Trim(LeftSectionTitle) <> "" Then sbSectionTitleHTML.Append("<TD align=Left>" & LeftSectionTitle & "</TD>")
            '    If Trim(MiddleSectionTitle) <> "" Then sbSectionTitleHTML.Append("<TD align=Center>" & MiddleSectionTitle & "</TD>")
            '    If Trim(RightSectionTitle) <> "" Then
            '        sbSectionTitleHTML.Append("<TD align=Right>" & RightSectionTitle)
            '        If Not strLinkNames Is Nothing Then Call sbSectionTitleHTML.Append(DrawLinks())
            '        sbSectionTitleHTML.Append("</TD>")
            '    Else
            '        sbSectionTitleHTML.Append("<TD align=Right>")
            '        If Not strLinkNames Is Nothing Then Call sbSectionTitleHTML.Append(DrawLinks())
            '        sbSectionTitleHTML.Append("</TD>")
            '    End If

            '    sbSectionTitleHTML.Append("</TR></TABLE>")
            '    If MyBase.returnHTML = False Then
            '        HttpContext.Current.Response.Write(sbSectionTitleHTML.ToString)
            '        DrawSectionTitle = ""
            '    Else
            '        DrawSectionTitle = sbSectionTitleHTML.ToString
            '    End If
            '    'Destroy the object
            '    sbSectionTitleHTML = Nothing

            'End Function

            'Private Function DrawLinks() As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawLinks
            '    ' Description           : This method will build the complete HTML
            '    '                         Links
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Return the HTML string for the Section Title
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, November 10, 2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim sbLinks As New System.Text.StringBuilder("<Div id='SecLinks" + strdivID_SectionTag + "'>" + strLinkSeperatorHTML + " ")
            '    Dim intIndex As Integer
            '    Dim intLength As Integer = strLinkNames.Length - 1
            '    Dim objDynamicLink As New cDynamicLink()
            '    objDynamicLink.ReturnHTML = True
            '    objDynamicLink.LinkStyle = "TEXT-DECORATION:NONE"
            '    For intIndex = 0 To intLength
            '        With objDynamicLink
            '            .LinkName = strLinkNames(intIndex)
            '            .FunctionName = strLinkFunctions(intIndex)
            '            .Tooltip = strLinkTooltips(intIndex)
            '            sbLinks.Append(.GetDynamicLink() + " " + strLinkSeperatorHTML)
            '        End With
            '    Next
            '    sbLinks.Append("</Div>")
            '    DrawLinks = sbLinks.ToString
            '    'Destroy the objects
            '    sbLinks = Nothing
            '    objDynamicLink = Nothing
            'End Function

            'Private Sub MakeClientsideScript()
            '    '=====================================================================
            '    ' Procedure Name        : MakeClientsideScript
            '    ' Description           : Make Clientside Script
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : None
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, November 24, 2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim sbSection As New System.Text.StringBuilder()
            '    sbSection.Append(vbCrLf + " function " + strFunctionName + "() {")
            '    sbSection.Append(vbCrLf + "var obj" + m_strDynamicHideShow + " = document.getElementById(""" + m_strDynamicHideShow + """);")
            '    sbSection.Append(vbCrLf + "var obj" + strdivID_SectionTag + " = document.getElementById(""" + strdivID_SectionTag + """);")
            '    sbSection.Append(vbCrLf + "var strDisplay=(arguments.length>0)?arguments[0]:obj" + strdivID_SectionTag + ".style.display;")
            '    If blnShowHideLinks = True Then
            '        'Show Hide Links..get the object for the div tag of links
            '        sbSection.Append(vbCrLf + "var objSecLinks" + strdivID_SectionTag + " = document.getElementById(""SecLinks" + strdivID_SectionTag + """);")
            '    End If
            '    sbSection.Append(vbCrLf + "if (strDisplay != ""none"") {")
            '    sbSection.Append(vbCrLf + "obj" + strdivID_SectionTag + ".style.display=""none"";")
            '    If strTooltipShowSection.Trim <> "" Then
            '        sbSection.Append(vbCrLf + "obj" + m_strDynamicHideShow + ".title=""" + strTooltipShowSection.Trim + """;")
            '    End If
            '    If blnShowHideLinks = True Then
            '        sbSection.Append(vbCrLf + "objSecLinks" + strdivID_SectionTag + ".style.display=""none"";")
            '    End If
            '    sbSection.Append(vbCrLf + "obj" + m_strDynamicHideShow + ".src='" + strImgSrcShowSection.Trim + "';")
            '    sbSection.Append(vbCrLf + "}")
            '    sbSection.Append(vbCrLf + "else")
            '    sbSection.Append(vbCrLf + "{")
            '    sbSection.Append(vbCrLf + "obj" + strdivID_SectionTag + ".style.display="""";")
            '    If strTooltipHideSection.Trim <> "" Then
            '        sbSection.Append(vbCrLf + "obj" + m_strDynamicHideShow + ".title=""" + strTooltipHideSection.Trim + """;")
            '    End If
            '    If blnShowHideLinks = True Then
            '        sbSection.Append(vbCrLf + "objSecLinks" + strdivID_SectionTag + ".style.display="""";")
            '    End If
            '    sbSection.Append(vbCrLf + "obj" + m_strDynamicHideShow + ".src='" + strImgSrcHideSection.Trim + "';")
            '    sbSection.Append(vbCrLf + "}")
            '    'sbSection.Append(vbCrLf + "return;")
            '    sbSection.Append(vbCrLf + "}")
            '    strClientSideScript = sbSection.ToString
            '    sbSection = Nothing
            'End Sub
            'Private Sub MakeClientsideScript()
            '    '=====================================================================
            '    ' Procedure Name        : MakeClientsideScript
            '    ' Description           : Make Clientside Script
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : None
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, November 24, 2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim sbSection As New System.Text.StringBuilder()
            '    sbSection.Append(vbCrLf + " function " + strFunctionName + "() {")
            '    sbSection.Append(vbCrLf + " }")
            '    'Destroy the object
            '    sbSection = Nothing
            'End Sub
        End Class
        Public Class cPageCaption
            Inherits WebPages.UI.cPageCaption
            'Inherits WebPage.Templates.Global
            ''=====================================================================
            '' Class	Name	        :	cPageCaption
            '' Purpose				:	This class is used for drawing the Page 
            ''                           Caption Table
            '' Description			:	Same as above
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	August 27, 2003
            '' Revisions				:	
            ''=====================================================================
            '''Property Variables
            'Private strLeftPageCaption As String
            'Private strRightPageCaption As String
            'Private strMiddlePageCaption As String
            'Private blnIsPageCaption As Boolean = True

            'Public WriteOnly Property LeftPageCaption() As String
            '    Set(ByVal Value As String)
            '        strLeftPageCaption = Value
            '    End Set
            'End Property

            'Public WriteOnly Property RightPageCaption() As String
            '    Set(ByVal Value As String)
            '        strRightPageCaption = Value
            '    End Set
            'End Property

            'Public WriteOnly Property MiddlePageCaption() As String
            '    Set(ByVal Value As String)
            '        strMiddlePageCaption = Value
            '    End Set
            'End Property

            'Public WriteOnly Property IsPageCaption() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnIsPageCaption = Value
            '    End Set
            'End Property

            'Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            '    'Assign the Parameter values to the local variables
            '    MyBase.TagID = WhizGlobal.TagID
            '    MyBase.RoleID = WhizGlobal.RoleID
            '    MyBase.UserID = WhizGlobal.UserID
            '    MyBase.LoginType = WhizGlobal.LoginType
            '    MyBase.UserName = WhizGlobal.UserName
            '    MyBase.ParentTagID = WhizGlobal.ParentTagID
            '    MyBase.ProjectID = WhizGlobal.ProjectID
            '    MyBase.UseHashTable = WhizGlobal.UseHashTable.ToString
            '    MyBase.LCID = WhizGlobal.LCID
            '    MyBase.clsTable = WhizGlobal.clsTable.ToString
            '    MyBase.clsTR = WhizGlobal.clsTR.ToString
            '    MyBase.TableStyle = WhizGlobal.TableStyle.ToString
            '    MyBase.returnHTML = WhizGlobal.returnHTML
            'End Sub

            'Public Sub New()
            '    MyBase.clsTable = "clsTable"
            '    MyBase.clsTR = " clsTRPageCaption "
            '    MyBase.TableStyle = " cellspacing=0 cellpadding=0 Width='100%' "
            'End Sub

            'Public Function DrawPageCaption() As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawPageCaption
            '    ' Description           :   This PUBLIC method will build the complete HTML
            '    '                           Table for the Page Caption
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Return the HTML string for the caption to the caller  
            '    '                          when returnHTML=true else will write the reponse
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, August 27, 2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim sbPageCaptionHTML As New System.Text.StringBuilder()
            '    sbPageCaptionHTML.Append("<TABLE " & MyBase.TableStyle & " class=" & MyBase.clsTable & ">")
            '    sbPageCaptionHTML.Append("<TR class=" & MyBase.clsTR & ">")

            '    'If the Left Page Caption is not specified then retrieve it from the Database
            '    If blnIsPageCaption = True And Trim(strLeftPageCaption) = "" Then strLeftPageCaption = GetPageCaption()

            '    If Trim(strLeftPageCaption) <> "" Then sbPageCaptionHTML.Append("<TD align=Left>" & strLeftPageCaption & "</TD>")
            '    If Trim(strMiddlePageCaption) <> "" Then sbPageCaptionHTML.Append("<TD align=Center>" & strMiddlePageCaption & "</TD>")
            '    If Trim(strRightPageCaption) <> "" Then sbPageCaptionHTML.Append("<TD align=Right>" & strRightPageCaption & "</TD>")
            '    sbPageCaptionHTML.Append("</TR></TABLE>")
            '    If MyBase.returnHTML = False Then
            '        Dim tagid As Long = MyBase.TagID
            '        HttpContext.Current.Response.Write(sbPageCaptionHTML.ToString)
            '        DrawPageCaption = ""
            '    Else
            '        DrawPageCaption = sbPageCaptionHTML.ToString
            '    End If
            '    'Destroy the object
            '    sbPageCaptionHTML = Nothing
            'End Function

            'Private Function GetPageCaption() As String
            '    '=====================================================================
            '    ' Procedure Name        : GetPageCaption
            '    ' Description           :   This PRIVATE method will retrieve the Page
            '    '                           Caption for the Tag from the Database
            '    ' Purpose               : Same as above
            '    ' Parameters Passed     : None
            '    ' Returns               : Returns Page Caption
            '    ' Parameters Affected   : None
            '    ' Assumptions           : None
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, September 05, 2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim drPageCaption As IDataReader
            '    Dim strSQL As String
            '    Dim strPageCaption As String = ""

            '    If MyBase.UseHashTable = "N" Then
            '        'If the ParentTagID is not specified (0 - zero) then the Get the Page Caption for the Tag (Page)
            '        'else get the Page Caption for the Sub Tag
            '        'The TagID / Sub Tag ID are mandatory

            '        If CommonFunction.General.GetApplicationKeySetting("DefaultUICultureID") = MyBase.LCID.ToString Then
            '            'Local culture ID is same as the default culture id
            '            strSQL = "usp_Sel_tbl_UI_Tag_SubTag_Master_PageCaption " & MyBase.TagID & "," & CommonFunction.General.CheckIsNothing(MyBase.ParentTagID, "0")
            '        Else
            '            'Culture ID is other than the default culture id
            '            'Check if the Culture is supported by the system
            '            If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), MyBase.LCID.ToString, CompareMethod.Text) <> 0 Then
            '                'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '                strSQL = "usp_Sel_tbl_UI_Tag_SubTag_Master_PageCaption " & MyBase.TagID & "," & CommonFunction.General.CheckIsNothing(MyBase.ParentTagID, "0") & "," & MyBase.LCID.ToString
            '            Else
            '                'No. Culture is NOT supported. Retrieve the data from the defual culture 
            '                strSQL = "usp_Sel_tbl_UI_Tag_SubTag_Master_PageCaption " & MyBase.TagID & "," & CommonFunction.General.CheckIsNothing(MyBase.ParentTagID, "0")
            '            End If
            '        End If

            '        drPageCaption = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '        If drPageCaption.Read() Then
            '            If Not IsDBNull(drPageCaption("PageCaption")) Then strPageCaption = drPageCaption("PageCaption").ToString
            '        End If
            '        drPageCaption.Dispose()
            '        drPageCaption.Close()
            '        drPageCaption = Nothing
            '    Else
            '        If MyBase.ParentTagID = 0 Then
            '            Dim objUITagMaster As New CommonEngines.HashTables.UITagMaster()
            '            If CommonFunction.General.GetApplicationKeySetting("DefaultUICultureID") = MyBase.LCID.ToString Then
            '                'Local culture ID is same as the default culture id
            '                objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(MyBase.TagID)
            '            Else
            '                'Culture ID is other than the default culture id
            '                'Check if the Culture is supported by the system
            '                If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), MyBase.LCID.ToString, CompareMethod.Text) <> 0 Then
            '                    'Yes. Culture is supported. Retrieve the data specific to that Culture 
            '                    objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterCultureObject(MyBase.TagID.ToString & CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs").ToString)
            '                Else
            '                    'No. Culture is NOT supported. Retrieve the data from the defual culture 
            '                    objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(MyBase.TagID)
            '                End If
            '            End If
            '            strPageCaption = objUITagMaster.TagDescription.ToString
            '            objUITagMaster = Nothing
            '        Else
            '            Dim objSubTagMasterHashTable() As CommonEngines.HashTables.SubUITagMaster

            '            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = MyBase.LCID Then
            '                'Local culture ID is same as the default culture id
            '                objSubTagMasterHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(CType(MyBase.ParentTagID, Long))
            '            Else
            '                'Check if the Culture is supported by the system
            '                objSubTagMasterHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(MyBase.ParentTagID.ToString & MyBase.LCID.ToString)
            '                If objSubTagMasterHashTable Is Nothing Then
            '                    'Culture ID is other than the default culture id
            '                    objSubTagMasterHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(CType(MyBase.ParentTagID, Long))
            '                End If
            '            End If
            '            Dim intIndex As Integer = 0
            '            Dim intLastIndex As Integer = objSubTagMasterHashTable.Length - 1
            '            For intIndex = 0 To intLastIndex
            '                If MyBase.TagID = objSubTagMasterHashTable(intIndex).TagID Then
            '                    strPageCaption = objSubTagMasterHashTable(intIndex).TagDescription
            '                End If
            '            Next
            '            'Destroy the object
            '            objSubTagMasterHashTable = Nothing
            '        End If
            '    End If
            '    'Return the Page Caption
            '    Return strPageCaption
            'End Function
        End Class

        Public Class cTabs
            Inherits WebPages.UI.cTabs
            ''=====================================================================
            '' Class	Name	        :	cTabs
            '' Purpose				:	This class is used for drawing the Tabs
            '' Description			:	Same as above
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	November 15, 2003
            '' Revisions				:	
            ''=====================================================================
            ''Property Variables
            'Private strTabNameArray As String()
            'Private strTabInformationArray As String()
            'Private strTooltipArray As String()
            'Private strTabOnclickFunctionArray As String()
            'Private strSelectedTab As String = ""
            'Private strclsTab As String = "navtab"
            'Private blnShowTabInformationOnSameRow As Boolean = True
            'Private strclsTable As String = "clsTable"
            'Private strTableStyle As String = " BORDER=0 cellspacing=0  "
            'Private strAlign As String = "Right"
            'Private blnNoWrap As Boolean = True

            'Private blnReturnHTML As Boolean = True
            'Private intTagWidthInPixel As Integer = 20
            ''Class Variables
            'Private m_objGlobal As WebPages.Template.IGlobal

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

            'Public WriteOnly Property TabOnclickFunctionArray() As String()
            '    Set(ByVal Value As String())
            '        strTabOnclickFunctionArray = Value
            '    End Set
            'End Property

            'Public WriteOnly Property clsTable() As String
            '    Set(ByVal Value As String)
            '        strclsTable = Value
            '    End Set
            'End Property

            'Public WriteOnly Property TableStyle() As String
            '    Set(ByVal Value As String)
            '        strTableStyle = Value
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

            'Public WriteOnly Property cssClass() As String
            '    Set(ByVal Value As String)
            '        strclsTab = Value
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
            '    ' Dependencies          : None
            '    ' Author                : UmeshJ
            '    ' Created               : Monday, November 15, 2003
            '    ' Revisions             :
            '    '=====================================================================
            '    If strTabNameArray Is Nothing Then Return ""
            '    Dim sbTabs As New System.Text.StringBuilder()
            '    Dim intIndex As Integer
            '    Dim intLastIndex As Integer = strTabNameArray.Length - 1
            '    Dim strWrap As String = ""
            '    If blnNoWrap = True Then strWrap = "noWrap"

            '    Select Case UCase(Trim(strAlign & ""))
            '        Case "RIGHT", "LEFT", "MIDDLE", "CENTER"
            '        Case Else : strAlign = "RIGHT"
            '    End Select
            '    sbTabs.Append("<TABLE " + "class=" + strclsTable + " cellspacing=0 width=100% cellpadding=0>")
            '    sbTabs.Append("<TR>")
            '    sbTabs.Append("<TD valign=bottom align=" & strAlign & ">")
            '    sbTabs.Append("<TABLE " + strTableStyle & " class=" + strclsTable + ">")

            '    sbTabs.Append("<TR> ")
            '    'Display according to the alignment
            '    If strAlign.ToUpper = "RIGHT" Or strAlign.ToUpper = "CENTER" Or strAlign.ToUpper = "MIDDLE" Then
            '        sbTabs.Append("<TD id =""ignoreRight""></TD>")
            '    End If
            '    'Draw the Tab list one by one
            '    For intIndex = 0 To intLastIndex

            '        If strSelectedTab Is Nothing Then
            '            'Set First Tab as default
            '            If intIndex = 0 Then
            '                strSelectedTab = strTabNameArray(intIndex).Trim
            '            End If
            '        End If
            '        Dim strTDProperties As String = ""
            '        sbTabs.Append("<TD " + strTDProperties + " align=center " + strWrap + " Title=" + Chr(34) + Replace(strTooltipArray(intIndex), """", "&quot;") + Chr(34))

            '        sbTabs.Append(">")

            '        If strTabNameArray(intIndex).Trim.ToUpper = strSelectedTab.Trim.ToUpper Then
            '            sbTabs.Append("<span id='selected'>")
            '            sbTabs.Append(strTabNameArray(intIndex).Trim)
            '            If Not strTabInformationArray Is Nothing Then
            '                If strTabInformationArray.Length > 0 Then
            '                    If strTabInformationArray(intIndex).Trim <> "" Then
            '                        If blnShowTabInformationOnSameRow = True Then
            '                            'Show Tab information on the same row of Tab Title
            '                            sbTabs.Append(" ")
            '                        Else
            '                            'Next Row
            '                            sbTabs.Append("<BR>")
            '                        End If
            '                        sbTabs.Append(strTabInformationArray(intIndex).Trim)
            '                    End If
            '                End If
            '            End If
            '            sbTabs.Append("</span>")
            '        Else

            '            sbTabs.Append("<A class='" & strclsTab & "' href='JavaScript:" + strTabOnclickFunctionArray(intIndex).Trim + "'>")
            '            sbTabs.Append(strTabNameArray(intIndex).Trim)
            '            If Not strTabInformationArray Is Nothing Then
            '                If strTabInformationArray.Length > 0 Then
            '                    If strTabInformationArray(intIndex).Trim <> "" Then
            '                        If blnShowTabInformationOnSameRow = True Then
            '                            'Show Tab information on the same row of Tab Title
            '                            sbTabs.Append(" ")
            '                        Else
            '                            'Next Row
            '                            sbTabs.Append("<BR>")
            '                        End If
            '                        sbTabs.Append(strTabInformationArray(intIndex).Trim)
            '                    End If
            '                End If
            '            End If
            '            sbTabs.Append("</A>")

            '        End If
            '        sbTabs.Append("</TD>")
            '    Next
            '    'Display according to the alignment
            '    If strAlign.ToUpper = "LEFT" Or strAlign.ToUpper = "CENTER" Or strAlign.ToUpper = "MIDDLE" Then
            '        sbTabs.Append("<TD id =""ignoreLeft""></TD>")
            '    End If

            '    sbTabs.Append("</TR></TABLE>")
            '    sbTabs.Append("</TD></TR></TABLE>")
            '    DrawTabs = ""
            '    If blnReturnHTML = False Then
            '        HttpContext.Current.Response.Write(sbTabs.ToString)
            '    Else
            '        DrawTabs = sbTabs.ToString
            '    End If
            '    'Destroy the object
            '    sbTabs = Nothing
            'End Function


        End Class

        Public Class cPaging
            Inherits WebPages.UI.cPaging
            ''=====================================================================
            '' Class	Name	        :	cPaging
            '' Purpose				:	cPaging will build a string with the paging 
            ''                           alphabets returned by the SQL passed to it.
            ''                           The PagingAlphabet will be shown with highlighted 
            ''                           color in the paging links.
            '' Description			:	These paging links will all have Href values to 
            ''                           the ClientSideFunctionName with the paging link 
            ''                           value as the parameter.
            '' Assumptions			:	1. The class assumes that the clientsidefunctionname 
            ''                              is physically present on the calling page.
            ''                           2. The class assumes that for the 'ALL' records 
            ''                              to display it will use '-1' as the PagingAlphabet
            '' Dependencies			:	CommonFunction
            '' Author				:	UmeshJ
            '' Created				:	Thursday, August 28, 2003
            '' Revisions				:	
            ''=====================================================================
            ''Property Variables
            'Private strSQL As String
            'Private strPagingAlphabet As String
            ''Private strPagingAlphabetFontColor As String
            ''Private strNonPagingAlphabetFontColor As String
            'Private strClientSideFunctionName As String
            'Private blnReturnHTML As Boolean
            'Private strLinkSeperatorHTML As String = "|"
            'Private strMessageForPagingSelect As String
            'Private strPagingFieldName As String = ""
            'Private strcssClass As String = ""
            'Private strcssSelectedClass As String = ""

            'Public WriteOnly Property cssClass() As String
            '    Set(ByVal Value As String)
            '        strcssClass = Value
            '    End Set
            'End Property

            'Public WriteOnly Property cssSelectedClass() As String
            '    Set(ByVal Value As String)
            '        strcssSelectedClass = Value
            '    End Set
            'End Property

            'Public WriteOnly Property SQL() As String
            '    Set(ByVal Value As String)
            '        strSQL = Value
            '    End Set
            'End Property

            'Public WriteOnly Property PagingFieldName() As String
            '    Set(ByVal Value As String)
            '        strPagingFieldName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property PagingAlphabet() As String
            '    Set(ByVal Value As String)
            '        strPagingAlphabet = Value
            '    End Set
            'End Property

            'Public WriteOnly Property MessageForPagingSelect() As String
            '    Set(ByVal Value As String)
            '        strMessageForPagingSelect = Value
            '    End Set
            'End Property

            'Public WriteOnly Property LinkSeperatorHTML() As String
            '    Set(ByVal Value As String)
            '        strLinkSeperatorHTML = Value
            '    End Set
            'End Property

            ''Public WriteOnly Property PagingAlphabetFontColor() As String
            ''    Set(ByVal Value As String)
            ''        strPagingAlphabetFontColor = Value
            ''    End Set
            ''End Property

            ''Public WriteOnly Property NonPagingAlphabetFontColor() As String
            ''    Set(ByVal Value As String)
            ''        strNonPagingAlphabetFontColor = Value
            ''    End Set
            ''End Property

            'Public WriteOnly Property ClientSideFunctionName() As String
            '    Set(ByVal Value As String)
            '        strClientSideFunctionName = Value
            '    End Set
            'End Property

            'Public WriteOnly Property ReturnHTML() As Boolean
            '    Set(ByVal Value As Boolean)
            '        blnReturnHTML = Value
            '    End Set
            'End Property

            'Public Function DrawPaging() As String
            '    '=====================================================================
            '    ' Procedure Name        :	DrawPaging
            '    ' Purpose               :	This public method will build the paging 
            '    '                           links string based on the records returned 
            '    '                           by the SQL. This will set the color of the 
            '    '                           PagedAlphabet also.
            '    ' Description           :	Same as above
            '    ' Parameters Passed     :	None.
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	This will return the string if retrunHTML=true 
            '    '                           else will write the response.
            '    ' Assumptions           :	For 'All' link use '-1' as Paging Alphabet 
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Friday, August 29, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim drPaging As IDataReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '    Dim sbPageLinks As New System.Text.StringBuilder(strMessageForPagingSelect + " ")
            '    Dim intLinks As Integer = 0
            '    'Upper Case
            '    strPagingAlphabet = UCase(strPagingAlphabet)
            '    'Build string to plot the paging alphabets
            '    Do While drPaging.Read()
            '        'Increment Paging Link Count
            '        intLinks += 1
            '        If strPagingFieldName.Trim = "" Then
            '            If UCase(drPaging(0).ToString) = strPagingAlphabet Then
            '                sbPageLinks.Append("<A class='" + strcssSelectedClass + "' HREF='JavaScript:" & strClientSideFunctionName & "(""" & HandleSpecialCharacters(drPaging(0).ToString) & """)'>")
            '            Else
            '                sbPageLinks.Append("<A class='" + strcssClass + "' HREF='JavaScript:" & strClientSideFunctionName & "(""" & HandleSpecialCharacters(drPaging(0).ToString) & """)'>")
            '            End If
            '            sbPageLinks.Append(UCase(HttpContext.Current.Server.HtmlEncode(drPaging(0).ToString)) + "</A>" & strLinkSeperatorHTML)
            '        Else
            '            If UCase(Left(drPaging(strPagingFieldName).ToString.Trim, 1)) = strPagingAlphabet Then
            '                sbPageLinks.Append("<A class='" + strcssSelectedClass + "' HREF='JavaScript:" & strClientSideFunctionName & "(""" & HandleSpecialCharacters(Left(drPaging(strPagingFieldName).ToString.Trim, 1)) & """)'>")
            '            Else
            '                sbPageLinks.Append("<A class='" + strcssClass + "' HREF='JavaScript:" & strClientSideFunctionName & "(""" & HandleSpecialCharacters(Left(drPaging(strPagingFieldName).ToString.Trim, 1)) & """)'>")
            '            End If
            '            sbPageLinks.Append(UCase(HttpContext.Current.Server.HtmlEncode(Left(drPaging(strPagingFieldName).ToString.Trim, 1))) + "</A>" & strLinkSeperatorHTML)
            '        End If
            '    Loop
            '    'Replace # (%23) , & (%26) and + (%2b) by place holders
            '    sbPageLinks.Replace("%23", CommonFunction.Constants.PAGING_SPECIAL_CHAR_HASH)
            '    sbPageLinks.Replace("%26", CommonFunction.Constants.PAGING_SPECIAL_CHAR_AND)
            '    sbPageLinks.Replace("%2b", CommonFunction.Constants.PAGING_SPECIAL_CHAR_PLUS)
            '    'Modified By UmeshJ on 5th Jan 2003 to resolve the the issue with ID = 9065
            '    If intLinks = 0 Or intLinks = 1 Then
            '        'Close and Destroy the Data Reader
            '        drPaging.Dispose()
            '        drPaging.Close()
            '        drPaging = Nothing
            '        sbPageLinks = Nothing
            '        'Do not draw any link
            '        Return ""
            '    End If
            '    'Append "All" ("" for Show All)
            '    If strPagingAlphabet = "-1" Then
            '        sbPageLinks.Append("<A class='" + strcssSelectedClass + "' HREF=" & Chr(34) & "JavaScript:" & strClientSideFunctionName & "('-1')" & Chr(34) & ">ALL</A>") '<FONT size=1pt ")
            '    Else
            '        sbPageLinks.Append("<A class='" + strcssClass + "' HREF=" & Chr(34) & "JavaScript:" & strClientSideFunctionName & "('-1')" & Chr(34) & ">ALL</A>") '<FONT size=1pt ")                    sbPageLinks.Append("ALL</A>")
            '    End If
            '    If blnReturnHTML = True Then
            '        DrawPaging = sbPageLinks.ToString
            '    Else
            '        HttpContext.Current.Response.Write(sbPageLinks.ToString)
            '        DrawPaging = ""
            '    End If
            '    'Close and Destroy the Data Reader
            '    drPaging.Dispose()
            '    drPaging.Close()
            '    drPaging = Nothing
            '    sbPageLinks = Nothing
            'End Function
            'Private Function HandleSpecialCharacters(ByVal strInput As String) As String
            '    '=====================================================================
            '    ' Procedure Name        :	HandleSpecialCharacters
            '    ' Purpose               :	HandleSpecialCharacters
            '    ' Description           :	Same as above
            '    ' Parameters Passed     :	None.
            '    ' Parameters Affected   :	None.
            '    ' Returns               :	Paging character after handling SP. chars
            '    ' Assumptions           :	none 
            '    ' Dependencies          :	None.
            '    ' Author                :	UmeshJ
            '    ' Created               :	Wednesday, December 24, 2003 
            '    ' Revisions             :
            '    '=====================================================================
            '    If InStr(1, strInput, "\", CompareMethod.Text) <> 0 Or InStr(1, strInput, """", CompareMethod.Text) <> 0 Then
            '        HandleSpecialCharacters = Replace(Replace(strInput, "\", "\\"), """", "\&quot;")
            '    Else
            '        HandleSpecialCharacters = Replace(HttpContext.Current.Server.UrlEncode(strInput), "'", "&#39;")
            '    End If
            'End Function
        End Class

        Public Class cClientSideTabs
            Inherits WebPages.UI.cClientSideTabs
            ''=====================================================================
            '' Class	Name	        :	cClientSideTabs
            '' Purpose				:	This class is used for drawing the Tabs
            '' Description			:	Same as above
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	Rajanikant
            '' Created				:	Dec 24,2003
            '' Revisions				:	
            ''=====================================================================
            ''Property Variables
            'Private strTabNameArray() As String
            'Private strTabInformationArray() As String
            'Private strTooltipArray() As String
            'Private strTabOnclickFunctionName As String
            'Private strDIVIDArray() As String

            'Private strClientSideScript As String = ""
            'Private strSelectedTab As String = ""
            'Private strclsTab As String = "navtab"
            'Private strclsTabSelected As String = "clsTabSelected"
            'Private blnShowTabInformationOnSameRow As Boolean = True
            'Private strclsTable As String = "clsTable"
            'Private strTableStyle As String = " BORDER=0 cellspacing=0  "
            'Private strAlign As String = "Right"
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

            'Public WriteOnly Property clsTable() As String
            '    Set(ByVal Value As String)
            '        strclsTable = Value
            '    End Set
            'End Property

            'Public WriteOnly Property TableStyle() As String
            '    Set(ByVal Value As String)
            '        strTableStyle = Value
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

            'Public WriteOnly Property clsTab() As String
            '    Set(ByVal Value As String)
            '        strclsTab = Value
            '    End Set
            'End Property

            'Public WriteOnly Property clsTabSelected() As String
            '    Set(ByVal Value As String)
            '        strclsTabSelected = Value
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
            '    ' Dependencies          : None
            '    ' Author                : Rajanikant
            '    ' Created               : Dec 24,2003
            '    ' Revisions             :
            '    '=====================================================================
            '    If strTabNameArray Is Nothing Then Return ""
            '    Dim sbTabs As New System.Text.StringBuilder()
            '    Dim sbCSScript As New System.Text.StringBuilder()
            '    Dim intIndex As Integer
            '    Dim intLastIndex As Integer = strTabNameArray.Length - 1
            '    Dim strWrap As String = ""
            '    If blnNoWrap = True Then strWrap = "noWrap"

            '    Select Case UCase(Trim(strAlign & ""))
            '        Case "RIGHT", "LEFT", "MIDDLE", "CENTER"
            '        Case Else : strAlign = "RIGHT"
            '    End Select

            '    sbTabs.Append("<TABLE " + "class=" + strclsTable + " cellspacing=0 width=100% cellpadding=0>" & vbCrLf)
            '    sbTabs.Append("<TR>" & vbCrLf)
            '    sbTabs.Append("<TD valign=bottom align=" & strAlign & ">" & vbCrLf)
            '    sbTabs.Append("<TABLE " + strTableStyle & " class=" + strclsTable + " >" & vbCrLf)

            '    sbTabs.Append("<TR> " & vbCrLf)

            '    sbCSScript.Append("<script language=javascript>" & vbCrLf)
            '    sbCSScript.Append("function " & Trim(strTabOnclickFunctionName & "") & "(index)" & vbCrLf)
            '    sbCSScript.Append("{" & vbCrLf)
            '    sbCSScript.Append("switch(true)" & vbCrLf)
            '    sbCSScript.Append("{")

            '    'Draw the Tab list one by one
            '    For intIndex = 0 To intLastIndex

            '        Dim strTDProperties As String = ""
            '        sbTabs.Append("<TD id=TD" + intIndex.ToString + strTDProperties + " align=center " + strWrap + " Title=" + Chr(34) + Replace(strTooltipArray(intIndex), """", "&quot;") + Chr(34) + ">" & vbCrLf)
            '        If strTabNameArray(intIndex).Trim.ToUpper = strSelectedTab.Trim.ToUpper Then

            '            ' apply tab selected class to href
            '            sbTabs.Append("<A id=HREF" + intIndex.ToString + " class='" & strclsTabSelected & "' href='JavaScript:" + Trim(strTabOnclickFunctionName & "") + "(" & intIndex & ")'>" & vbCrLf)

            '            sbTabs.Append(strTabNameArray(intIndex).Trim)
            '            If Not strTabInformationArray Is Nothing Then
            '                If strTabInformationArray.Length > 0 Then
            '                    If strTabInformationArray(intIndex).Trim <> "" Then
            '                        If blnShowTabInformationOnSameRow = True Then
            '                            'Show Tab information on the same row of Tab Title
            '                            sbTabs.Append(" ")
            '                        Else
            '                            'Next Row
            '                            sbTabs.Append("<BR>")
            '                        End If
            '                        sbTabs.Append(strTabInformationArray(intIndex).Trim)
            '                    End If
            '                End If
            '            End If
            '            sbTabs.Append("</A>" & vbCrLf)
            '        Else
            '            ' apply tab class
            '            sbTabs.Append("<A id=HREF" + intIndex.ToString + " class='" & strclsTab & "' href='JavaScript:" + Trim(strTabOnclickFunctionName & "") + "(" & intIndex & ")'>" & vbCrLf)

            '            sbTabs.Append(strTabNameArray(intIndex).Trim)
            '            If Not strTabInformationArray Is Nothing Then
            '                If strTabInformationArray.Length > 0 Then
            '                    If strTabInformationArray(intIndex).Trim <> "" Then
            '                        If blnShowTabInformationOnSameRow = True Then
            '                            'Show Tab information on the same row of Tab Title
            '                            sbTabs.Append(" ")
            '                        Else
            '                            'Next Row
            '                            sbTabs.Append("<BR>")
            '                        End If
            '                        sbTabs.Append(strTabInformationArray(intIndex).Trim)
            '                    End If
            '                End If
            '            End If
            '            sbTabs.Append("</A>" & vbCrLf)

            '        End If
            '        sbTabs.Append("</TD>" & vbCrLf)

            '        ' build the case for client side function for the tab
            '        sbCSScript.Append("case (index==" & intIndex & "):" & vbCrLf)
            '        Dim intUBound As Integer
            '        Dim intLoopCtr As Integer
            '        intUBound = UBound(strTabNameArray)
            '        For intLoopCtr = 0 To intUBound
            '            ' variable declarations
            '            sbCSScript.Append("var HREF" & intLoopCtr & "=GetObjectReference('" & strFormName & "','HREF" & intLoopCtr & "');" & vbCrLf)
            '            sbCSScript.Append("var " & strDIVIDArray(intLoopCtr) & "=GetObjectReference('" & strFormName & "','" & strDIVIDArray(intLoopCtr) & "');" & vbCrLf)

            '            If intLoopCtr = intIndex Then
            '                sbCSScript.Append("HREF" & intLoopCtr & ".className='" & strclsTabSelected & "';" & vbCrLf)
            '                sbCSScript.Append(strDIVIDArray(intLoopCtr) & ".style.display='block';" & vbCrLf)
            '            Else
            '                sbCSScript.Append("HREF" & intLoopCtr & ".className='" & strclsTab & "';" & vbCrLf)
            '                sbCSScript.Append(strDIVIDArray(intLoopCtr) & ".style.display='none';" & vbCrLf)
            '            End If
            '        Next
            '        sbCSScript.Append("break;" & vbCrLf)
            '    Next

            '    sbCSScript.Append("}")
            '    sbCSScript.Append("}")
            '    sbCSScript.Append("</script>")

            '    strClientSideScript = sbCSScript.ToString

            '    sbTabs.Append("</TR></TABLE>" & vbCrLf)
            '    sbTabs.Append("</TD></TR></TABLE>" & vbCrLf)
            '    DrawTabs = ""
            '    If blnReturnHTML = False Then
            '        HttpContext.Current.Response.Write(sbTabs.ToString)
            '    Else
            '        DrawTabs = sbTabs.ToString
            '    End If
            '    'Destroy the object
            '    sbTabs = Nothing
            'End Function


        End Class


    End Namespace

    Namespace Security
        Public Class cAccessRights
            Inherits WebPages.Security.cAccessRights
            '    Inherits WebPage.Templates.Global
            '    '=====================================================================
            '    ' Class	Name	        :	cAccessRights
            '    ' Purpose				:	This class will return the Access Rights for the
            '    '                           specified Tag / Sub Tag for the specified Role
            '    ' Description			:	Same as above
            '    ' Assumptions			:	None
            '    ' Dependencies			:	CommonFunction and required Stored Procedures
            '    ' Author				:	UmeshJ
            '    ' Created				:	August 19, 2003
            '    ' Revisions				:	
            '    '=====================================================================
            '    'Property Variables
            '    Private blnAdd As Boolean = False
            '    Private blnEdit As Boolean
            '    Private blnDelete As Boolean
            '    Private blnView As Boolean
            '    Private blnModuleAccess As Boolean


            '    Public Property Add() As Boolean
            '        Get
            '            Return blnAdd
            '        End Get
            '        Set(ByVal Value As Boolean)
            '            blnAdd = Value
            '        End Set
            '    End Property

            '    Public Property Edit() As Boolean
            '        Get
            '            Return blnEdit
            '        End Get
            '        Set(ByVal Value As Boolean)
            '            blnEdit = Value
            '        End Set
            '    End Property

            '    Public Property Delete() As Boolean
            '        Get
            '            Return blnDelete
            '        End Get
            '        Set(ByVal Value As Boolean)
            '            blnDelete = Value
            '        End Set
            '    End Property

            '    Public Property View() As Boolean
            '        Get
            '            Return blnView
            '        End Get
            '        Set(ByVal Value As Boolean)
            '            blnView = Value
            '        End Set
            '    End Property
            '    Public ReadOnly Property IsModuleAccessible() As Boolean
            '        Get
            '            Return blnModuleAccess
            '        End Get
            '    End Property

            Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
                'Assign the Parameter values to the local variables
                MyBase.New(WhizGlobal)
                'MyBase.TagID = WhizGlobal.TagID
                'MyBase.RoleID = WhizGlobal.RoleID
                'MyBase.UserID = WhizGlobal.UserID
                'MyBase.LoginType = WhizGlobal.LoginType
                'MyBase.UserName = WhizGlobal.UserName
                'MyBase.ParentTagID = WhizGlobal.ParentTagID
                'MyBase.ProjectID = WhizGlobal.ProjectID
                'MyBase.UseHashTable = WhizGlobal.UseHashTable.ToString
                'MyBase.LCID = WhizGlobal.LCID
            End Sub

            '    Public Sub New()

            '    End Sub
            '    Public Sub GetAccess(Optional ByVal ModuleAccess As Boolean = False)
            '        '=====================================================================
            '        ' Procedure Name        :	GetAccess
            '        ' Purpose               :	Get the Role level access for the selected 
            '        '                           Tag / Sub Tag
            '        ' Description           :	This method will set the values for the 
            '        '                           properties(Add, Edit, Delete And View)
            '        ' Parameters Passed     :	Optional ModuleAccess - Boolean Parameter
            '        '                           If TRUE then get only ModuleAccess else get
            '        '                           the Node Access (A,E,D,V) 
            '        ' Parameters Affected   :	None.
            '        ' Returns               :	No return values.
            '        ' Assumptions           :	None.
            '        ' Dependencies          :	None.
            '        ' Author                :	UmeshJ
            '        ' Created               :	Tuesday, August 19, 2003 
            '        ' Revisions             :
            '        '=====================================================================
            '        Dim strSQL As String

            '        If ModuleAccess = False Then
            '            Dim drAccess As IDataReader
            '            'If the ParentTagID is not specified (0 - zero) then the Get the Access Rights for the Tag (Page)
            '            'else get the access rights for the Sub Tag
            '            'The TagID / Sub Tag ID and RoleID are mandatory
            '            strSQL = "usp_Sel_tbl_UI_NodeAccess " & MyBase.TagID & "," & MyBase.RoleID

            '            'If the any value is not specified then pass Null to the SP
            '            strSQL = strSQL & "," & CommonFunction.General.CheckIsNothing(MyBase.UserID, "null") & ",'" & CommonFunction.General.CheckIsNothing(MyBase.LoginType, "E") & "'," & CommonFunction.General.CheckIsNothing(MyBase.ProjectID, "null") & "," & CommonFunction.General.CheckIsNothing(MyBase.ParentTagID, "0")

            '            drAccess = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            '            If drAccess.Read() Then
            '                If Not IsDBNull(drAccess("A")) Then blnAdd = CType(drAccess("A"), Boolean)
            '                If Not IsDBNull(drAccess("E")) Then blnEdit = CType(drAccess("E"), Boolean)
            '                If Not IsDBNull(drAccess("D")) Then blnDelete = CType(drAccess("D"), Boolean)
            '                If Not IsDBNull(drAccess("V")) Then blnView = CType(drAccess("V"), Boolean)
            '            End If
            '            drAccess.Dispose()
            '            drAccess.Close()
            '            drAccess = Nothing
            '        Else
            '            strSQL = "usp_Sel_tbl_UserAccess " & MyBase.RoleID & "," & MyBase.TagID
            '            'If the any value is not specified then pass Null to the SP
            '            strSQL = strSQL & "," & CommonFunction.General.CheckIsNothing(MyBase.UserID, "null") & ",'" & CommonFunction.General.CheckIsNothing(MyBase.LoginType, "E") & "'"

            '            blnModuleAccess = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
            '        End If
            '    End Sub


        End Class
    End Namespace


    Namespace Grid
        Public MustInherit Class cGrid
            Inherits WebPages.Grid.cGrid

            ''=====================================================================
            '' Class	Name	        :	cGrid
            '' Purpose				:	This is a base class. It must be inherited 
            ''                           by other class. It holds common grid properties
            '' Description			:	The other grid classes will inherit this class
            '' Assumptions			:	None
            '' Dependencies			:	None
            '' Author				:	UmeshJ
            '' Created				:	August 28, 2003
            '' Revisions				:	
            ''=====================================================================
            'Private strclsTable As String = "clsTable"
            'Private strclsColumnHeader As String = "clsTRColumnHeader"
            'Private strclsTREven As String = "clsTREven"
            'Private strclsTROdd As String = "clsTROdd"
            'Private strSortUpImage As String = "../../Images/Sort_up.gif"
            'Private strSortDownImage As String = "../../Images/Sort_down.gif"
            'Private strSortByImage As String = "../../Images/Sortby.gif"
            'Private strTableStyle As String = "cellpadding=1 cellspacing=1"

            'Public Property clsTable() As String
            '    Get
            '        Return strclsTable
            '    End Get
            '    Set(ByVal Value As String)
            '        strclsTable = Value
            '    End Set
            'End Property

            'Public Property clsColumnHeader() As String
            '    Get
            '        Return strclsColumnHeader
            '    End Get
            '    Set(ByVal Value As String)
            '        strclsColumnHeader = Value
            '    End Set
            'End Property

            'Public Property clsTREven() As String
            '    Get
            '        Return strclsTREven
            '    End Get
            '    Set(ByVal Value As String)
            '        strclsTREven = Value
            '    End Set
            'End Property

            'Public Property clsTROdd() As String
            '    Get
            '        Return strclsTROdd
            '    End Get
            '    Set(ByVal Value As String)
            '        strclsTROdd = Value
            '    End Set
            'End Property

            'Public Property SortUpImage() As String
            '    Get
            '        Return strSortUpImage
            '    End Get
            '    Set(ByVal Value As String)
            '        strSortUpImage = Value
            '    End Set
            'End Property

            'Public Property SortDownImage() As String
            '    Get
            '        Return strSortDownImage
            '    End Get
            '    Set(ByVal Value As String)
            '        strSortDownImage = Value
            '    End Set
            'End Property

            'Public Property SortByImage() As String
            '    Get
            '        Return strSortByImage
            '    End Get
            '    Set(ByVal Value As String)
            '        strSortByImage = Value
            '    End Set
            'End Property
            'Public Property TableStyle() As String
            '    Get
            '        Return strTableStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        strTableStyle = Value
            '    End Set
            'End Property

        End Class



        Public Class cGenericGrid
            Inherits WebPages.Grid.cGenericGrid
            'Inherits WebPages.Grid.cGrid
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
            'Protected marrUserFriendlyColumn() As String = {}
            'Protected marrActualColumn() As String = {}
            'Protected marrCheckBoxID() As String
            'Protected marrCheckboxCheckOnColumn() As String
            'Protected marrCheckboxDisableOnColumn() As String
            'Protected marrRowLink() As String
            'Protected marrRowLinkToolTip() As String
            'Protected marrRowLinkEnableOnColumn() As String
            'Protected marrReplacementValue() As String
            'Protected marrTDStyle() As String
            'Protected mintNoOfRows As Integer = 0
            'Protected mintDIVHeight As Integer = 300
            'Protected mintNoOfDataColumns As Integer = 0
            'Protected mblnColNameToolTipOnEachRow As Boolean = False
            'Protected mblnVerticalDisplay As Boolean = False
            'Protected mblnReturnHTML As Boolean = False
            'Protected mblnPrinterFriendlyVersion As Boolean = False
            'Protected mstrPrimaryKey As String = ""
            'Protected mstrHorizontalSeparatorHTML As String = ""
            'Protected mstrColumnHeaderAlignment As String = ""
            'Protected mstrBooleanTrueHTML As String = "Yes"
            'Protected mstrBooleanFalseHTML As String = "No"
            'Protected mstrDIVStyle As String = "overflow:auto"
            'Protected mstrDIVID As String = "DivList"
            'Protected mstrHeaderHTML As String = ""
            'Protected mstrFooterHTML As String = ""
            'Protected mstrSortBy As String = ""
            'Protected mstrSortOrder As String = ""
            'Protected mstrSQL As String = ""
            'Protected mstrClientSideSortFunctionName As String = ""
            'Protected mstrEmptyValueReplacement As String = "&lt;Not Specified&gt;"
            'Protected mblnUseSQL As Boolean
            'Protected mstrNoDataComment As String = "There are no items to show in this view"
            'Protected mstrSortedTDStyle As String = "clsTDSortColHeader"

            'Protected mlngCurrentPage As Long = 0
            'Protected mlngPageSize As Long = 0
            'Protected mlngFirstRow As Long = -1
            'Protected mlngLastRow As Long = -1
            'Protected mintNoOfRowsInPage As Integer = 0

            '' group arrays
            'Protected marrGroupOnColumn() As String = {}
            'Protected marrGroupSummaryFunc() As String = {}
            'Protected mstrGroupTRStyle As String = "clsTRSectionTitle"

            'Protected marrIgnoreHTMLEncode() As String

            'Public Property IgnoreHTMLEncode() As String()
            '    Get
            '        IgnoreHTMLEncode = marrIgnoreHTMLEncode
            '    End Get
            '    Set(ByVal Value As String())
            '        marrIgnoreHTMLEncode = Value
            '    End Set
            'End Property

            'Public Property GroupTRStyle() As String
            '    Get
            '        GroupTRStyle = mstrGroupTRStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrGroupTRStyle = Value
            '    End Set
            'End Property

            'Public Property GroupOnColumn() As String()
            '    Get
            '        GroupOnColumn = marrGroupOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        marrGroupOnColumn = Value
            '    End Set
            'End Property
            'Public Property GroupSummaryFunc() As String()
            '    Get
            '        GroupSummaryFunc = marrGroupSummaryFunc
            '    End Get
            '    Set(ByVal Value As String())
            '        marrGroupSummaryFunc = Value
            '    End Set
            'End Property
            'Public Property CheckBoxIDArray() As String()
            '    Get
            '        CheckBoxIDArray = marrCheckBoxID
            '    End Get
            '    Set(ByVal Value As String())
            '        marrCheckBoxID = Value
            '    End Set
            'End Property
            'Public Property CheckboxCheckOnColumnArray() As String()
            '    Get
            '        CheckboxCheckOnColumnArray = marrCheckboxCheckOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        marrCheckboxCheckOnColumn = Value
            '    End Set
            'End Property
            'Public Property CheckboxDisableOnColumnArray() As String()
            '    Get
            '        CheckboxDisableOnColumnArray = marrCheckboxDisableOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        marrCheckboxDisableOnColumn = Value
            '    End Set
            'End Property
            'Public Property CurrentPage() As Long
            '    Get
            '        CurrentPage = mlngCurrentPage
            '    End Get
            '    Set(ByVal Value As Long)
            '        mlngCurrentPage = Value
            '    End Set
            'End Property
            'Public Property PageSize() As Long
            '    Get
            '        PageSize = mlngPageSize
            '    End Get
            '    Set(ByVal Value As Long)
            '        mlngPageSize = Value
            '    End Set
            'End Property
            'Public Property ColumnReplacementValue() As String()
            '    Get
            '        ColumnReplacementValue = marrReplacementValue
            '    End Get
            '    Set(ByVal Value As String())
            '        marrReplacementValue = Value
            '    End Set
            'End Property
            'Public Property SortedTDStyle() As String
            '    Get
            '        SortedTDStyle = mstrSortedTDStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrSortedTDStyle = Value
            '    End Set
            'End Property
            'Public Property NoDataComment() As String
            '    Get
            '        NoDataComment = mstrNoDataComment
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrNoDataComment = Value
            '    End Set
            'End Property
            'Public Property UseSQL() As Boolean
            '    Get
            '        UseSQL = mblnUseSQL
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        mblnUseSQL = Value
            '    End Set
            'End Property
            'Public Property EmptyValueReplacement() As String
            '    Get
            '        EmptyValueReplacement = mstrEmptyValueReplacement
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrEmptyValueReplacement = Value
            '    End Set
            'End Property
            'Public Property BooleanTrueHTML() As String
            '    Get
            '        BooleanTrueHTML = mstrBooleanTrueHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrBooleanTrueHTML = Value
            '    End Set
            'End Property
            'Public Property BooleanFalseHTML() As String
            '    Get
            '        BooleanFalseHTML = mstrBooleanFalseHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrBooleanFalseHTML = Value
            '    End Set
            'End Property
            'Public Property ColumnHeaderAlignment() As String
            '    Get
            '        ColumnHeaderAlignment = mstrColumnHeaderAlignment
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrColumnHeaderAlignment = Value
            '    End Set
            'End Property
            'Public Property TDStyleArray() As String()
            '    Get
            '        TDStyleArray = marrTDStyle
            '    End Get
            '    Set(ByVal Value As String())
            '        marrTDStyle = Value
            '    End Set
            'End Property
            'Public Property HorizontalSeparatorHTML() As String
            '    Get
            '        HorizontalSeparatorHTML = mstrHorizontalSeparatorHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrHorizontalSeparatorHTML = Value
            '    End Set
            'End Property
            'Public Property VerticalDisplay() As Boolean
            '    Get
            '        VerticalDisplay = mblnVerticalDisplay
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        mblnVerticalDisplay = Value
            '    End Set
            'End Property
            'Public Property PrimaryKey() As String
            '    Get
            '        PrimaryKey = mstrPrimaryKey
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrPrimaryKey = Value
            '    End Set
            'End Property
            'Public Property NoOfDataColumns() As Integer
            '    Get
            '        NoOfDataColumns = mintNoOfDataColumns
            '    End Get
            '    Set(ByVal Value As Integer)
            '        mintNoOfDataColumns = Value
            '    End Set
            'End Property
            'Public Property ColNameToolTipOnEachRow() As Boolean
            '    Get
            '        ColNameToolTipOnEachRow = mblnColNameToolTipOnEachRow
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        mblnColNameToolTipOnEachRow = Value
            '    End Set
            'End Property
            'Public Property DIVID() As String
            '    Get
            '        DIVID = mstrDIVID
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrDIVID = Value
            '    End Set
            'End Property
            'Public Property DIVStyle() As String
            '    Get
            '        DIVStyle = mstrDIVStyle
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrDIVStyle = Value
            '    End Set
            'End Property
            'Public Property DIVHeight() As Integer
            '    Get
            '        DIVHeight = mintDIVHeight
            '    End Get
            '    Set(ByVal Value As Integer)
            '        mintDIVHeight = Value
            '    End Set
            'End Property
            'Public Property SQL() As String
            '    Get
            '        SQL = mstrSQL
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrSQL = Value
            '    End Set
            'End Property
            'Public Property ClientSideSortFunctionName() As String
            '    Get
            '        ClientSideSortFunctionName = mstrClientSideSortFunctionName
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrClientSideSortFunctionName = Value
            '    End Set
            'End Property
            'Public Property UserFriendlyColumnArray() As String()
            '    Get
            '        UserFriendlyColumnArray = marrUserFriendlyColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        marrUserFriendlyColumn = Value
            '    End Set
            'End Property
            'Public Property ActualColumnArray() As String()
            '    Get
            '        ActualColumnArray = marrActualColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        marrActualColumn = Value
            '    End Set
            'End Property
            'Public Property RowLinkArray() As String()
            '    Get
            '        RowLinkArray = marrRowLink
            '    End Get
            '    Set(ByVal Value As String())
            '        marrRowLink = Value
            '    End Set
            'End Property
            'Public Property RowLinkToolTipArray() As String()
            '    Get
            '        RowLinkToolTipArray = marrRowLinkToolTip
            '    End Get
            '    Set(ByVal Value As String())
            '        marrRowLinkToolTip = Value
            '    End Set
            'End Property
            'Public Property RowLinkEnableOnColumn() As String()
            '    Get
            '        RowLinkEnableOnColumn = marrRowLinkEnableOnColumn
            '    End Get
            '    Set(ByVal Value As String())
            '        marrRowLinkEnableOnColumn = Value
            '    End Set
            'End Property
            'Public Property HeaderHTML() As String
            '    Get
            '        HeaderHTML = mstrHeaderHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrHeaderHTML = Value
            '    End Set
            'End Property
            'Public Property FooterHTML() As String
            '    Get
            '        FooterHTML = mstrFooterHTML
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrFooterHTML = Value
            '    End Set
            'End Property
            'Public Property SortBy() As String
            '    Get
            '        SortBy = mstrSortBy
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrSortBy = Value
            '    End Set
            'End Property
            'Public Property SortOrder() As String
            '    Get
            '        SortOrder = mstrSortOrder
            '    End Get
            '    Set(ByVal Value As String)
            '        mstrSortOrder = Value
            '    End Set
            'End Property
            'Public Property returnHTML() As Boolean
            '    Get
            '        returnHTML = mblnReturnHTML
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        mblnReturnHTML = Value
            '    End Set
            'End Property
            'Public ReadOnly Property NoOfRows() As Integer
            '    Get
            '        NoOfRows = mintNoOfRows
            '    End Get
            'End Property
            'Public ReadOnly Property NoOfRowsInPage() As Integer
            '    Get
            '        NoOfRowsInPage = mintNoOfRowsInPage
            '    End Get
            'End Property
            'Public Property PrinterFriendlyVersion() As Boolean
            '    Get
            '        PrinterFriendlyVersion = mblnPrinterFriendlyVersion
            '    End Get
            '    Set(ByVal Value As Boolean)
            '        mblnPrinterFriendlyVersion = Value
            '    End Set
            'End Property


            'Public Function DrawGrid() As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawGrid()
            '    ' Description           : Uses private functions to draw the grids  
            '    ' Purpose               : draws the grid for the SQL using properties
            '    ' Parameters Passed     : None
            '    ' Returns               :
            '    ' Parameters Affected   : 
            '    ' Assumptions           :
            '    ' Dependencies          : private fns. DrawHorizontalGrid, DrawVerticalGrid
            '    ' Author                : Rajanikant
            '    ' Created               : September 09,2003
            '    ' Revisions             :
            '    '=====================================================================
            '    If mblnVerticalDisplay Then
            '        Return DrawVerticalGrid(returnHTML)
            '    Else
            '        Return DrawHorizontalGrid(returnHTML)
            '    End If
            'End Function


            'Private Function DrawHorizontalGrid(ByVal returnHTML As Boolean) As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawHorizontalGrid()
            '    ' Description           :
            '    ' Purpose               : draws the grid horizontally for the SQL using properties
            '    ' Parameters Passed     : None
            '    ' Returns               : string
            '    ' Parameters Affected   : 
            '    ' Assumptions           : 
            '    ' Dependencies          : module variables
            '    ' Author                : Rajanikant
            '    ' Created               : September 12,2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim intCount As Integer
            '    Dim intUpperBound As Integer
            '    Dim intItemCount As Integer
            '    Dim intLoopCtr As Integer
            '    Dim dr As IDataReader
            '    Dim sb As System.Text.StringBuilder
            '    Dim blnPrinted As Boolean = False
            '    Dim arr() As String
            '    Dim strParameters As String
            '    Dim strFunctionName As String
            '    Dim blnChecked As Boolean = False
            '    Dim blnDisabled As Boolean = False
            '    Dim strValue As String = ""
            '    Dim arrQueryString() As String = {}
            '    Dim arrPlaceHolder() As String = {}
            '    Dim strURL As String
            '    Dim intCount2 As Integer
            '    Dim intCount3 As Integer
            '    Dim intUBound1 As Integer
            '    Dim intUBound2 As Integer

            '    Dim blnEnableLink As Boolean = True
            '    Dim mblnPrintRow As Boolean = True
            '    Dim mblnExitLoop As Boolean = False

            '    Dim arrGroupOnColumnValue() As String = {}
            '    Dim arrSummaryFuncValue() As Double = {}
            '    Dim blnPrintColumn As Boolean = True
            '    Dim blnIsGroupingPresent As Boolean = False

            '    Dim blnApplyHTMLEncode As Boolean = True

            '    ' total number of columns to be displayed
            '    intUpperBound = UBound(marrUserFriendlyColumn)

            '    ReDim Preserve arrGroupOnColumnValue(intUpperBound)
            '    ReDim Preserve arrSummaryFuncValue(intUpperBound)

            '    ' initialize the string builder
            '    sb = New System.Text.StringBuilder

            '    ' grid header
            '    sb.Append(mstrHeaderHTML)

            '    mstrSortBy = Replace(Replace(mstrSortBy, "[", "", , , CompareMethod.Binary), "]", "", , , CompareMethod.Binary)

            '    ' do not show the DIV for printer friendly version
            '    If Not mblnPrinterFriendlyVersion And mintDIVHeight > 0 Then
            '        ' DIV start
            '        If mstrDIVID.Trim = "" Then
            '            mstrDIVID = "DivList"
            '        End If
            '        sb.Append("<DIV id=" + mstrDIVID + " style='" + mstrDIVStyle + ";Height:" + mintDIVHeight.ToString + "' >" + vbCrLf)
            '    End If

            '    ' table start
            '    sb.Append("<TABLE class='" + MyBase.clsTable + "'" + MyBase.TableStyle + " width='100%'>" + vbCrLf)

            '    ' get the data for the grid
            '    dr = CommonFunctions.Data.GetDataReader(mstrSQL, mblnUseSQL)



            '    ' COLUMNS for the grid
            '    sb.Append("<TR class='" + MyBase.clsColumnHeader.Trim + "'>" + vbCrLf)
            '    For intCount = 0 To intUpperBound
            '        sb.Append("<TD ")
            '        ' Apply HTML encode??
            '        blnApplyHTMLEncode = True
            '        If IsArrayValuePresent(marrIgnoreHTMLEncode, intCount) Then
            '            If Trim(marrIgnoreHTMLEncode(intCount) & "") = "1" Then
            '                blnApplyHTMLEncode = False
            '            End If
            '        End If

            '        If Trim(mstrColumnHeaderAlignment & "") <> "" Then
            '            ' use the specified alignment
            '            sb.Append("align=" + mstrColumnHeaderAlignment + vbCrLf)
            '        Else
            '            ' use the row TD style if present
            '            If IsArrayValuePresent(marrTDStyle, intCount) Then
            '                sb.Append(marrTDStyle(intCount) + vbCrLf)
            '            Else
            '                If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                    If intCount < mintNoOfDataColumns Then
            '                        Select Case dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper
            '                            Case "FLOAT", "INT", "BIT", "REAL"
            '                                sb.Append(" align=right " + vbCrLf)

            '                            Case "DATETIME"
            '                                sb.Append(" align=left " + vbCrLf)
            '                            Case Else
            '                                sb.Append(" align=left " + vbCrLf)
            '                        End Select
            '                    End If
            '                Else
            '                    If intCount < mintNoOfDataColumns Then
            '                        Select Case dr.GetDataTypeName(intCount).Trim.ToUpper
            '                            Case "FLOAT", "INT", "BIT", "REAL"
            '                                sb.Append(" align=right " + vbCrLf)

            '                            Case "DATETIME"
            '                                sb.Append(" align=left " + vbCrLf)
            '                            Case Else
            '                                sb.Append(" align=left " + vbCrLf)
            '                        End Select
            '                    End If
            '                End If

            '            End If
            '        End If

            '        If intCount < mintNoOfDataColumns Then
            '            ' For Priner Friendly versions/text/image data types ignore sorting images/functions
            '            'If Not mblnPrinterFriendlyVersion And Not (dr.GetDataTypeName(intCount).Trim.ToUpper = "TEXT" Or dr.GetDataTypeName(intCount).Trim.ToUpper = "IMAGE") Then
            '            If Not MyBase.SortByImage Is Nothing Then
            '                If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                    If Not mblnPrinterFriendlyVersion And Not (dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper = "TEXT" Or dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper = "IMAGE") Then
            '                        ' Is the sorting on this field?
            '                        If Trim(marrActualColumn(intCount) & "").ToUpper = Trim(mstrSortBy & "").ToUpper Then
            '                            sb.Append(" class='" + mstrSortedTDStyle + "'>")
            '                            ' What is the sort order?
            '                            If Trim(mstrSortOrder & "").ToUpper = "ASC" Then
            '                                ' Its ASC so next click on this should change the order to DESC
            '                                If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                    sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + marrActualColumn(intCount) + "','DESC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                    sb.Append("<img src='" + MyBase.SortDownImage + "' border=0>" + vbCrLf)
            '                                End If
            '                            Else
            '                                ' Its DESC so next click on this should change the order to ASC
            '                                If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                    sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + marrActualColumn(intCount) + "','ASC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                    sb.Append("<img src='" + MyBase.SortUpImage + "' border=0>" + vbCrLf)
            '                                End If

            '                            End If
            '                        Else
            '                            sb.Append(">")
            '                            ' Default Sorting
            '                            If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + marrActualColumn(intCount) + "','ASC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                sb.Append("<img src='" + MyBase.SortByImage + "' border=0>" + vbCrLf)
            '                            End If
            '                        End If
            '                    Else
            '                        sb.Append(">")
            '                    End If

            '                Else
            '                    ' Is the sorting on this field?
            '                    If Trim(dr.GetName(intCount).ToString & "").ToUpper = Trim(mstrSortBy & "").ToUpper Then
            '                        sb.Append(" class='" + mstrSortedTDStyle + "'>")
            '                        ' What is the sort order?
            '                        If Trim(mstrSortOrder & "").ToUpper = "ASC" Then
            '                            ' Its ASC so next click on this should change the order to DESC
            '                            If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + dr.GetName(intCount) + "','DESC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                sb.Append("<img src='" + MyBase.SortDownImage + "' border=0>" + vbCrLf)
            '                            End If
            '                        Else
            '                            ' Its DESC so next click on this should change the order to ASC
            '                            If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + dr.GetName(intCount) + "','ASC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                sb.Append("<img src='" + MyBase.SortUpImage + "' border=0>" + vbCrLf)
            '                            End If

            '                        End If
            '                    Else
            '                        sb.Append(">")
            '                        ' Default Sorting
            '                        If mstrClientSideSortFunctionName.Trim <> "" Then
            '                            sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + dr.GetName(intCount) + "','ASC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                            sb.Append("<img src='" + MyBase.SortByImage + "' border=0>" + vbCrLf)
            '                        End If
            '                    End If
            '                End If

            '            End If
            '            If mstrClientSideSortFunctionName.Trim <> "" Then
            '                sb.Append("</A>" + vbCrLf)
            '            End If
            '        Else
            '            sb.Append(">")
            '        End If
            '        If blnApplyHTMLEncode Then
            '            sb.Append(CommonFunctions.General.FormatString(marrUserFriendlyColumn(intCount)))
            '        Else
            '            sb.Append(marrUserFriendlyColumn(intCount))
            '        End If

            '        sb.Append("</TD>" + vbCrLf)
            '    Next intCount
            '    sb.Append("</TR>" + vbCrLf)

            '    ' before we plot the rows lets see if the request is for a specific page
            '    If mlngPageSize <> 0 And mlngCurrentPage > 0 Then
            '        If mlngCurrentPage = 1 Then
            '            mlngFirstRow = 1
            '        Else
            '            mlngFirstRow = ((mlngCurrentPage - 1) * mlngPageSize) + 1
            '        End If
            '        mlngLastRow = (mlngCurrentPage * mlngPageSize)
            '    End If


            '    ' ROWS go here
            '    Do While dr.Read()

            '        ' paging decisions!
            '        If mlngFirstRow <> -1 And mlngLastRow <> -1 Then
            '            If Not (mlngFirstRow = 1 And mintNoOfRows = 0) Then
            '                If mlngFirstRow > mintNoOfRows + 1 Then
            '                    mblnPrintRow = False
            '                Else
            '                    mblnPrintRow = True
            '                End If
            '            End If
            '            If mlngLastRow < mintNoOfRows Then
            '                mintNoOfRows -= 1
            '                mintNoOfRowsInPage -= 1
            '                mblnExitLoop = True
            '            Else
            '                mblnExitLoop = False
            '            End If
            '        End If
            '        If mblnExitLoop Then Exit Do

            '        If mblnPrintRow Then
            '            mintNoOfRowsInPage += 1
            '            For intCount = 0 To intUpperBound
            '                ' Apply HTML encode??
            '                blnApplyHTMLEncode = True
            '                If IsArrayValuePresent(marrIgnoreHTMLEncode, intCount) Then
            '                    If Trim(marrIgnoreHTMLEncode(intCount) & "") = "1" Then
            '                        blnApplyHTMLEncode = False
            '                    End If
            '                End If

            '                If intCount < mintNoOfDataColumns Then
            '                    blnPrintColumn = True
            '                    blnIsGroupingPresent = False
            '                    ' grouping info
            '                    If IsArrayValuePresent(marrGroupOnColumn, intCount) Then
            '                        blnIsGroupingPresent = True
            '                        If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                            ' actual col name is specified
            '                            If UCase(Trim(dr(marrActualColumn(intCount)).ToString & "")) <> UCase(Trim(arrGroupOnColumnValue(intCount) & "")) Then
            '                                ' new value print
            '                                blnPrintColumn = True
            '                            Else
            '                                ' prev value matched ..do not print
            '                                blnPrintColumn = False
            '                            End If
            '                            arrGroupOnColumnValue(intCount) = dr(marrActualColumn(intCount)).ToString
            '                        Else
            '                            If UCase(Trim(dr(intCount).ToString & "")) <> UCase(Trim(arrGroupOnColumnValue(intCount) & "")) Then
            '                                blnPrintColumn = True
            '                            Else
            '                                blnPrintColumn = False
            '                            End If
            '                            arrGroupOnColumnValue(intCount) = dr(intCount).ToString
            '                        End If
            '                    Else
            '                        blnPrintColumn = True
            '                    End If

            '                    If blnIsGroupingPresent Then
            '                        sb.Append("<TR class='" + mstrGroupTRStyle + "'>" + vbCrLf)
            '                    Else
            '                        If intCount = 0 Then
            '                            If mintNoOfRows Mod 2 = 0 Then
            '                                sb.Append("<TR class='" + MyBase.clsTROdd.Trim + "'>" + vbCrLf)
            '                            Else
            '                                sb.Append("<TR class='" + MyBase.clsTREven.Trim + "'>" + vbCrLf)
            '                            End If
            '                        End If
            '                    End If

            '                    If Not blnPrintColumn Then
            '                        'sb.Append("<TD colspan=" & intUpperBound + 1 & " align=left")
            '                        sb.Append("<TD  vAlign=top")
            '                    Else
            '                        If blnIsGroupingPresent Then
            '                            sb.Append("<TD colspan=" & intUpperBound + 1 & " align=left")
            '                        Else
            '                            sb.Append("<TD  vAlign=top")
            '                        End If

            '                        If IsArrayValuePresent(marrTDStyle, intCount) Then
            '                            strParameters = ""
            '                            ' code to replace place-holders "[]" present in the TDStyle for the position
            '                            If Left(marrTDStyle(intCount), 2) = "{}" Or Left(marrTDStyle(intCount), 3) = "'{}" Then
            '                                If InStr(marrTDStyle(intCount), "[", CompareMethod.Binary) > 0 And InStr(marrTDStyle(intCount), "]", CompareMethod.Binary) > 0 Then
            '                                    ' there are place holders which are to be replaced with data values
            '                                    ' build the url
            '                                    strURL = ""
            '                                    arrQueryString = Split(marrTDStyle(intCount), "[", -1, CompareMethod.Binary)
            '                                    intUBound1 = UBound(arrQueryString)
            '                                    For intCount2 = 0 To intUBound1
            '                                        arrPlaceHolder = Split(arrQueryString(intCount2), "]")
            '                                        intUBound2 = UBound(arrPlaceHolder)
            '                                        If intUBound2 >= 0 Then
            '                                            For intCount3 = 0 To intUBound2
            '                                                Try
            '                                                    strURL += Replace(dr(arrPlaceHolder(intCount3)).ToString, "'", "|||")
            '                                                Catch
            '                                                    strURL += arrPlaceHolder(intCount3)
            '                                                End Try
            '                                            Next
            '                                        Else
            '                                            strURL += arrQueryString(intCount2)
            '                                        End If
            '                                    Next
            '                                    strParameters += Replace(strURL, "{}", "")
            '                                Else
            '                                    ' pass the parameter as it is (just replace the {} prefix)
            '                                    strParameters += Replace(marrTDStyle(intCount), "{}", "")
            '                                End If
            '                            Else
            '                                strParameters += marrTDStyle(intCount)
            '                            End If
            '                            If Left(strParameters, 1) = "," Then
            '                                strParameters = Right(strParameters, Len(strParameters) - 1)
            '                            End If
            '                            sb.Append(" " & strParameters)

            '                        ElseIf IsArrayValuePresent(marrActualColumn, intCount) Then
            '                            Select Case dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper
            '                                Case "FLOAT", "INT", "BIT", "REAL"
            '                                    sb.Append(" align=right ")
            '                            End Select
            '                        Else
            '                            Select Case dr.GetDataTypeName(intCount).Trim.ToUpper
            '                                Case "FLOAT", "INT", "BIT", "REAL"
            '                                    sb.Append(" align=right ")
            '                            End Select
            '                        End If
            '                    End If
            '                    If mblnColNameToolTipOnEachRow Then
            '                        sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrUserFriendlyColumn(intCount)) + Chr(34))
            '                    End If
            '                    sb.Append(">" + vbCrLf)

            '                    If IsArrayValuePresent(marrRowLinkEnableOnColumn, intCount) Then
            '                        blnEnableLink = False
            '                        If CType(dr(marrRowLinkEnableOnColumn(intCount)), Boolean) = True Then
            '                            blnEnableLink = True
            '                        End If
            '                    End If


            '                    If blnEnableLink Then
            '                        ' link on the field??
            '                        If IsArrayValuePresent(marrRowLink, intCount) Then
            '                            sb.Append("<A href=" + Chr(34) + "JavaScript:")

            '                            arr = Split(GetFunctionAndParameters(marrRowLink(intCount), strFunctionName), ",")
            '                            intItemCount = UBound(arr)
            '                            strParameters = ""
            '                            For intLoopCtr = 0 To intItemCount
            '                                If Left(arr(intLoopCtr), 2) = "{}" Or Left(arr(intLoopCtr), 3) = "'{}" Then
            '                                    strParameters += "," + Replace(arr(intLoopCtr), "{}", "")
            '                                ElseIf arr(intLoopCtr).Trim <> "" Then
            '                                    strParameters += "," + "'" + Replace(dr(Replace(arr(intLoopCtr), "'", "")).ToString.Trim, "'", "|||") + "'"
            '                                End If
            '                            Next
            '                            ' remove the first comma ","
            '                            If Left(strParameters, 1) = "," Then
            '                                strParameters = Right(strParameters, Len(strParameters) - 1)
            '                            End If

            '                            ' function_Name(param1,param2,...)
            '                            sb.Append(strFunctionName + "(" + strParameters + ")" + Chr(34))

            '                            If IsArrayValuePresent(marrRowLinkToolTip, intCount) Then
            '                                sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrRowLinkToolTip(intCount)) + Chr(34))
            '                            End If
            '                            sb.Append(">")
            '                        End If
            '                    End If

            '                    If blnPrintColumn Then
            '                        If Not IsArrayValuePresent(marrReplacementValue, intCount) Then
            '                            If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                Select Case dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper
            '                                    Case "FLOAT", "REAL"
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            sb.Append(FormatNumber(dr(marrActualColumn(intCount)), 2))
            '                                        Else
            '                                            sb.Append("0.00")
            '                                        End If
            '                                    Case "INT"
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            sb.Append(FormatNumber(dr(marrActualColumn(intCount)), 0))
            '                                        Else
            '                                            sb.Append("0")
            '                                        End If
            '                                    Case "BIT"
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            If CType(dr(marrActualColumn(intCount)), Boolean) = True Then
            '                                                sb.Append(mstrBooleanTrueHTML)
            '                                            Else
            '                                                sb.Append(mstrBooleanFalseHTML)
            '                                            End If
            '                                        Else
            '                                            sb.Append(mstrBooleanFalseHTML)
            '                                        End If
            '                                    Case "DATETIME"
            '                                        ' date time get the date time
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            sb.Append(CommonFunctions.Dates.CGetDate(CType(dr(marrActualColumn(intCount)), Date)))
            '                                        Else
            '                                            sb.Append(mstrEmptyValueReplacement)
            '                                        End If
            '                                    Case Else
            '                                        ' normal text
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            If blnApplyHTMLEncode Then
            '                                                sb.Append(HttpContext.Current.Server.HtmlEncode(dr(marrActualColumn(intCount)).ToString))
            '                                            Else
            '                                                sb.Append(dr(marrActualColumn(intCount)).ToString)
            '                                            End If
            '                                        Else
            '                                            sb.Append(mstrEmptyValueReplacement)
            '                                        End If
            '                                End Select
            '                            Else
            '                                Select Case dr.GetDataTypeName(intCount).Trim.ToUpper
            '                                    Case "FLOAT", "REAL"
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            sb.Append(FormatNumber(dr(intCount), 2))
            '                                        Else
            '                                            sb.Append("0.00")
            '                                        End If

            '                                    Case "INT"
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            sb.Append(FormatNumber(dr(intCount), 0))
            '                                        Else
            '                                            sb.Append("0")
            '                                        End If
            '                                    Case "BIT"
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            If CType(dr(intCount), Boolean) = True Then
            '                                                sb.Append(mstrBooleanTrueHTML)
            '                                            Else
            '                                                sb.Append(mstrBooleanFalseHTML)
            '                                            End If
            '                                        Else
            '                                            sb.Append(mstrBooleanFalseHTML)
            '                                        End If
            '                                    Case "DATETIME"
            '                                        ' date time get the date time
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            sb.Append(CommonFunctions.Dates.CGetDate(CType(dr(intCount), Date)))
            '                                        Else
            '                                            sb.Append(mstrEmptyValueReplacement)
            '                                        End If
            '                                    Case Else
            '                                        ' normal text
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            If blnApplyHTMLEncode Then
            '                                                sb.Append(HttpContext.Current.Server.HtmlEncode(dr(intCount).ToString))
            '                                            Else
            '                                                sb.Append(dr(intCount).ToString)
            '                                            End If
            '                                        Else
            '                                            sb.Append(mstrEmptyValueReplacement)
            '                                        End If
            '                                End Select
            '                            End If
            '                        Else
            '                            sb.Append(HttpContext.Current.Server.HtmlEncode(marrReplacementValue(intCount).ToString))
            '                        End If
            '                    End If
            '                    If blnEnableLink Then
            '                        If IsArrayValuePresent(marrRowLink, intCount) Then
            '                            sb.Append("</A>")
            '                        End If
            '                    End If
            '                Else
            '                    If IsArrayValuePresent(marrCheckBoxID, intCount) Then
            '                        sb.Append("<TD align=center >" + vbCrLf)
            '                        ' value of the check box MUST be the Primary Key!!
            '                        If mstrPrimaryKey.Trim <> "" Then
            '                            strValue = dr(mstrPrimaryKey).ToString
            '                        End If

            '                        blnDisabled = False
            '                        blnChecked = False
            '                        ' if data bound (check the checkbox based on data value)
            '                        If IsArrayValuePresent(marrCheckboxCheckOnColumn, intCount) Then
            '                            If Not IsDBNull(dr(marrCheckboxCheckOnColumn(intCount))) Then
            '                                If CType(dr(marrCheckboxCheckOnColumn(intCount)), Boolean) Then
            '                                    blnChecked = True
            '                                End If
            '                            End If
            '                        End If
            '                        If IsArrayValuePresent(marrCheckboxDisableOnColumn, intCount) Then
            '                            If Not IsDBNull(dr(marrCheckboxDisableOnColumn(intCount))) Then
            '                                If CType(dr(marrCheckboxDisableOnColumn(intCount)), Boolean) Then
            '                                    blnDisabled = True
            '                                End If
            '                            End If
            '                        End If
            '                        sb.Append(CommonFunctions.HTMLControls.DrawCheckBox(marrCheckBoxID(intCount), marrCheckBoxID(intCount), , blnChecked, strValue, blnDisabled, , True))
            '                    Else
            '                        sb.Append("<TD align=left >" + vbCrLf)
            '                        If IsArrayValuePresent(marrRowLink, intCount) Then
            '                            sb.Append("<A href=" + Chr(34) + "JavaScript:")

            '                            ' split the parameters
            '                            arr = Split(GetFunctionAndParameters(marrRowLink(intCount), strFunctionName), ",")
            '                            ' the item count
            '                            intItemCount = UBound(arr)
            '                            ' build the parameter string
            '                            strParameters = ""
            '                            For intLoopCtr = 0 To intItemCount
            '                                If Left(arr(intLoopCtr), 2) = "{}" Or Left(arr(intLoopCtr), 3) = "'{}" Then
            '                                    If InStr(arr(intLoopCtr), "<", CompareMethod.Binary) > 0 And InStr(arr(intLoopCtr), ">", CompareMethod.Binary) > 0 Then
            '                                        ' there are place holders which are to be replaced with data values
            '                                        ' build the url
            '                                        strURL = ""
            '                                        arrQueryString = Split(arr(intLoopCtr), "<", -1, CompareMethod.Binary)
            '                                        intUBound1 = UBound(arrQueryString)
            '                                        For intCount2 = 0 To intUBound1
            '                                            arrPlaceHolder = Split(arrQueryString(intCount2), ">")
            '                                            intUBound2 = UBound(arrPlaceHolder)
            '                                            If intUBound2 >= 0 Then
            '                                                For intCount3 = 0 To intUBound2
            '                                                    Try
            '                                                        strURL += Replace(dr(arrPlaceHolder(intCount3)).ToString, "'", "|||")
            '                                                    Catch
            '                                                        strURL += Replace(arrPlaceHolder(intCount3), "'", "|||")
            '                                                    End Try
            '                                                Next
            '                                            Else
            '                                                strURL += Replace(arrQueryString(intCount2), "'", "|||")
            '                                            End If

            '                                        Next
            '                                        strParameters += ",'" + Replace(strURL, "{}", "") + "'"
            '                                    Else
            '                                        ' pass the parameter as it is (just replace the {} prefix)
            '                                        strParameters += "," + HttpContext.Current.Server.UrlEncode(Replace(arr(intLoopCtr), "{}", ""))
            '                                    End If

            '                                ElseIf arr(intLoopCtr).Trim <> "" Then
            '                                    ' get the database value for the parameter
            '                                    strParameters += "," + "'" + HttpContext.Current.Server.UrlEncode(Replace(dr(Replace(arr(intLoopCtr), "'", "")).ToString, "'", "|||")) + "'"
            '                                End If
            '                            Next

            '                            If Left(strParameters, 1) = "," Then
            '                                strParameters = Right(strParameters, Len(strParameters) - 1)
            '                            End If
            '                            sb.Append(strFunctionName + "(" + strParameters + ")" + Chr(34))

            '                            If IsArrayValuePresent(marrRowLinkToolTip, intCount) Then
            '                                sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrRowLinkToolTip(intCount)) + Chr(34))
            '                            End If
            '                            sb.Append(">")
            '                            If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                If blnApplyHTMLEncode Then
            '                                    sb.Append(HttpContext.Current.Server.HtmlEncode(marrActualColumn(intCount)))
            '                                Else
            '                                    sb.Append(marrActualColumn(intCount))
            '                                End If
            '                            End If
            '                            sb.Append("</A>")
            '                        Else
            '                            If blnApplyHTMLEncode Then
            '                                sb.Append(HttpContext.Current.Server.HtmlEncode(marrActualColumn(intCount)))
            '                            Else
            '                                sb.Append(marrActualColumn(intCount))
            '                            End If
            '                        End If
            '                    End If
            '                End If
            '                If blnIsGroupingPresent Then
            '                    If blnPrintColumn Then
            '                        If mintNoOfRows Mod 2 = 0 Then
            '                            sb.Append("</td></tr><TR class='" + MyBase.clsTROdd.Trim + "'><TD></TD>" + vbCrLf)
            '                        Else
            '                            sb.Append("</td></tr><TR class='" + MyBase.clsTREven.Trim + "'><TD></TD>" + vbCrLf)
            '                        End If
            '                    Else
            '                        sb.Append("</td>" + vbCrLf)
            '                    End If
            '                Else
            '                    sb.Append("</td>" + vbCrLf)
            '                End If


            '            Next intCount

            '            sb.Append("</TR>" + vbCrLf)
            '            sb.Append(mstrHorizontalSeparatorHTML)

            '        End If

            '        ' increment the row total ( this will be used by GET property "NoOfRows")
            '        mintNoOfRows += 1
            '    Loop
            '    dr = Nothing

            '    If mintNoOfRows = 0 Then
            '        ' no data present
            '        sb.Append("<TR class=" + MyBase.clsTREven + "><TD align=center colspan=" + (intUpperBound + 1).ToString + ">" + mstrNoDataComment + "</TD></TR>" + vbCrLf)
            '    End If

            '    sb.Append("</TABLE>" + vbCrLf)
            '    If Not mblnPrinterFriendlyVersion And mintDIVHeight > 0 Then
            '        ' DIV end
            '        sb.Append("</div>" + vbCrLf)
            '    End If

            '    ' grid footer
            '    sb.Append(mstrFooterHTML)

            '    If returnHTML Then
            '        ' return the HTML string
            '        Return sb.ToString
            '    Else
            '        ' write the response
            '        HttpContext.Current.Response.Write(sb.ToString)
            '    End If
            'End Function


            'Private Function DrawVerticalGrid(ByVal returnHTML As Boolean) As String
            '    '=====================================================================
            '    ' Procedure Name        : DrawVerticalGrid()
            '    ' Description           : draws the grid vertically for the SQL using properties
            '    ' Purpose               : draws the grid vertically for the SQL using properties
            '    ' Parameters Passed     : None
            '    ' Returns               : string
            '    ' Parameters Affected   : 
            '    ' Assumptions           : 
            '    ' Dependencies          : module variables
            '    ' Author                : Rajanikant
            '    ' Created               : September 12,2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim intCount As Integer
            '    Dim intUpperBound As Integer
            '    Dim dr As IDataReader
            '    Dim blnPrinted As Boolean = False
            '    Dim sb As System.Text.StringBuilder
            '    Dim arr() As String
            '    Dim intItemCount As Integer
            '    Dim intLoopCtr As Integer
            '    Dim strFunctionName As String
            '    Dim strParameters As String
            '    Dim blnChecked As Boolean = False
            '    Dim strValue As String = ""

            '    ' total number of columns to be displayed
            '    intUpperBound = UBound(marrUserFriendlyColumn)
            '    sb = New System.Text.StringBuilder
            '    ' grid header
            '    sb.Append(mstrHeaderHTML)
            '    ' do not show the DIV for printer friendly version
            '    If Not mblnPrinterFriendlyVersion Then
            '        ' DIV start
            '        If mstrDIVID.Trim = "" Then
            '            mstrDIVID = "DivList"
            '        End If
            '        sb.Append("<DIV id=" + mstrDIVID + " style='" + mstrDIVStyle + ";Height:" + mintDIVHeight.ToString + "' >" + vbCrLf)
            '    End If
            '    ' table start
            '    sb.Append("<TABLE class='" + MyBase.clsTable + "' " + MyBase.TableStyle + " width='100%'>" + vbCrLf)
            '    ' grid content
            '    dr = CommonFunctions.Data.GetDataReader(mstrSQL, mblnUseSQL)
            '    Do While dr.Read()
            '        ' columns are written for each row
            '        For intCount = 0 To intUpperBound
            '            If mintNoOfRows Mod 2 = 0 Then
            '                sb.Append("<TR class='" + MyBase.clsTROdd.Trim + "'>" + vbCrLf)
            '            Else
            '                sb.Append("<TR class='" + MyBase.clsTREven.Trim + "'>" + vbCrLf)
            '            End If
            '            sb.Append("<TD align=right><B>" + vbCrLf)
            '            sb.Append(CommonFunctions.General.FormatString(marrUserFriendlyColumn(intCount)))
            '            sb.Append("</B></TD>" + vbCrLf)

            '            If intCount < mintNoOfDataColumns Then

            '                sb.Append("<TD  vAlign=top " + vbCrLf)

            '                If mblnColNameToolTipOnEachRow Then
            '                    sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrUserFriendlyColumn(intCount)) + Chr(34))
            '                End If
            '                sb.Append(" align=right>" + vbCrLf)
            '                If IsArrayValuePresent(marrRowLink, intCount) Then
            '                    sb.Append("<A href=" + Chr(34) + "JavaScript:")


            '                    arr = Split(GetFunctionAndParameters(marrRowLink(intCount), strFunctionName), ",")
            '                    intItemCount = UBound(arr)
            '                    strParameters = ""
            '                    For intLoopCtr = 0 To intItemCount
            '                        If Left(arr(intLoopCtr), 2) = "{}" Or Left(arr(intLoopCtr), 3) = "'{}" Then
            '                            strParameters += "," + Replace(arr(intLoopCtr), "{}", "")
            '                        ElseIf arr(intLoopCtr).Trim <> "" Then
            '                            strParameters += "," + "'" + dr(Replace(arr(intLoopCtr), "'", "")).ToString.Trim + "'"
            '                        End If
            '                    Next

            '                    If Left(strParameters, 1) = "," Then
            '                        strParameters = Right(strParameters, Len(strParameters) - 1)
            '                    End If
            '                    sb.Append(strFunctionName + "(" + strParameters + ")" + Chr(34))

            '                    If IsArrayValuePresent(marrRowLinkToolTip, intCount) Then
            '                        sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrRowLinkToolTip(intCount)) + Chr(34))
            '                    End If
            '                    sb.Append(">")
            '                End If
            '                If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                    Select Case dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper
            '                        Case "FLOAT"
            '                            If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                sb.Append(FormatNumber(dr(marrActualColumn(intCount)), 2))
            '                            Else
            '                                sb.Append("0.00")
            '                            End If

            '                        Case "INT"
            '                            If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                sb.Append(FormatNumber(dr(marrActualColumn(intCount)), 0))
            '                            Else
            '                                sb.Append("0")
            '                            End If
            '                        Case "BIT"
            '                            If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                If CType(dr(marrActualColumn(intCount)), Boolean) = True Then
            '                                    sb.Append(mstrBooleanTrueHTML)
            '                                Else
            '                                    sb.Append(mstrBooleanFalseHTML)
            '                                End If
            '                            Else
            '                                sb.Append(mstrBooleanFalseHTML)
            '                            End If
            '                        Case "DATETIME"
            '                            If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                sb.Append(CommonFunctions.Dates.CGetDate(CType(dr(marrActualColumn(intCount)), Date)))
            '                            Else
            '                                sb.Append(mstrEmptyValueReplacement)
            '                            End If
            '                        Case Else
            '                            ' normal text
            '                            If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                sb.Append(HttpContext.Current.Server.HtmlEncode(dr(marrActualColumn(intCount)).ToString))
            '                            Else
            '                                sb.Append(mstrEmptyValueReplacement)
            '                            End If

            '                    End Select
            '                Else
            '                    Select Case dr.GetDataTypeName(intCount).Trim.ToUpper
            '                        Case "FLOAT"
            '                            If Not IsDBNull(dr(intCount)) Then
            '                                sb.Append(FormatNumber(dr(intCount), 2))
            '                            Else
            '                                sb.Append("0.00")
            '                            End If

            '                        Case "INT"
            '                            If Not IsDBNull(dr(intCount)) Then
            '                                sb.Append(FormatNumber(dr(intCount), 0))
            '                            Else
            '                                sb.Append("0")
            '                            End If
            '                        Case "BIT"
            '                            If Not IsDBNull(dr(intCount)) Then
            '                                If CType(dr(intCount), Boolean) = True Then
            '                                    sb.Append(mstrBooleanTrueHTML)
            '                                Else
            '                                    sb.Append(mstrBooleanFalseHTML)
            '                                End If
            '                            Else
            '                                sb.Append(mstrBooleanFalseHTML)
            '                            End If
            '                        Case "DATETIME"
            '                            If Not IsDBNull(dr(intCount)) Then
            '                                sb.Append(CommonFunctions.Dates.CGetDate(CType(dr(intCount), Date)))
            '                            Else
            '                                sb.Append(mstrEmptyValueReplacement)
            '                            End If
            '                        Case Else
            '                            ' normal text
            '                            If Not IsDBNull(dr(intCount)) Then
            '                                sb.Append(HttpContext.Current.Server.HtmlEncode(dr(intCount).ToString))
            '                            Else
            '                                sb.Append(mstrEmptyValueReplacement)
            '                            End If

            '                    End Select
            '                End If
            '                sb.Append("</A>")
            '            Else

            '                sb.Append("<TD vAlign=top align=left >" + vbCrLf)
            '                If IsArrayValuePresent(marrCheckBoxID, intCount) Then
            '                    ' check box has to be inserted here

            '                    ' value of the check box MUST be the Primary Key!!
            '                    If mstrPrimaryKey.Trim <> "" Then
            '                        strValue = dr(mstrPrimaryKey).ToString
            '                    End If
            '                    ' if data bound (check the checkbox based on data value)
            '                    If Not marrActualColumn(intCount) Is Nothing Then
            '                        If marrActualColumn(intCount).Trim <> "" Then
            '                            If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                    If CType(dr(marrActualColumn(intCount)), Boolean) Then
            '                                        blnChecked = True
            '                                    End If
            '                                End If
            '                            Else
            '                                If Not IsDBNull(dr(intCount)) Then
            '                                    If CType(dr(intCount), Boolean) Then
            '                                        blnChecked = True
            '                                    End If
            '                                End If
            '                            End If
            '                        End If
            '                    End If
            '                    sb.Append(CommonFunctions.HTMLControls.DrawCheckBox(marrCheckBoxID(intCount), marrCheckBoxID(intCount), , blnChecked, strValue, , , True))
            '                Else
            '                    If IsArrayValuePresent(marrRowLink, intCount) Then
            '                        sb.Append("<A href=" + Chr(34) + "JavaScript:")

            '                        arr = Split(GetFunctionAndParameters(marrRowLink(intCount), strFunctionName), ",")
            '                        intItemCount = UBound(arr)
            '                        strParameters = ""
            '                        For intLoopCtr = 0 To intItemCount
            '                            If Left(arr(intLoopCtr), 2) = "{}" Or Left(arr(intLoopCtr), 3) = "'{}" Then
            '                                strParameters += "," + Replace(arr(intLoopCtr), "{}", "")
            '                            ElseIf arr(intLoopCtr).Trim <> "" Then
            '                                strParameters += "," + "'" + dr(Replace(arr(intLoopCtr), "'", "")).ToString.Trim + "'"
            '                            End If
            '                        Next

            '                        If Left(strParameters, 1) = "," Then
            '                            strParameters = Right(strParameters, Len(strParameters) - 1)
            '                        End If
            '                        sb.Append(strFunctionName + "(" + strParameters + ")" + Chr(34))

            '                        If IsArrayValuePresent(marrRowLinkToolTip, intCount) Then
            '                            sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrRowLinkToolTip(intCount)) + Chr(34))
            '                        End If
            '                        sb.Append(">")
            '                        If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                            sb.Append(marrActualColumn(intCount))
            '                        End If
            '                        sb.Append("</A>")
            '                    End If
            '                End If
            '            End If
            '            sb.Append("</td>" + vbCrLf)

            '            sb.Append("</TR>" + vbCrLf)

            '        Next intCount

            '        sb.Append(mstrHorizontalSeparatorHTML)
            '        ' increment the row total ( this will be used by GET property "NoOfRows")
            '        mintNoOfRows += 1
            '    Loop
            '    dr.Close()

            '    If mintNoOfRows = 0 Then
            '        ' no data present
            '        sb.Append("<TR class=clsTROdd><TD align=center colspan=2>" + mstrNoDataComment + "</TD></TR>" + vbCrLf)
            '    End If

            '    sb.Append("</TABLE>" + vbCrLf)

            '    If Not mblnPrinterFriendlyVersion Then
            '        ' DIV end
            '        sb.Append("</div>" + vbCrLf)
            '    End If

            '    ' grid footer
            '    sb.Append(mstrFooterHTML)

            '    If returnHTML Then
            '        Return sb.ToString
            '    Else
            '        HttpContext.Current.Response.Write(sb.ToString)
            '    End If

            'End Function


            'Private Function IsArrayValuePresent(ByVal arr As String(), ByVal intPos As Integer) As Boolean
            '    '=====================================================================
            '    ' Procedure Name        : IsArrayValuePresent()
            '    ' Purpose               : checks for the value at the position for the array
            '    ' Description           : same as above
            '    ' Parameters Passed     : ByVal arr As String(), ByVal intPos As Integer
            '    ' Returns               : true/false
            '    ' Parameters Affected   : 
            '    ' Assumptions           : 
            '    ' Dependencies          : none
            '    ' Author                : Rajanikant
            '    ' Created               : September 12,2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim intUBound As Integer

            '    ' no such array?
            '    If arr Is Nothing Then Return False

            '    ' current position wants a lookup on array size greater than the size?
            '    intUBound = UBound(arr)
            '    If intUBound < intPos Then Return False

            '    ' check for value
            '    If Not arr(intPos) Is Nothing Then
            '        If arr(intPos).Trim <> "" Then
            '            Return True
            '        Else
            '            Return False
            '        End If
            '    Else
            '        Return False
            '    End If

            'End Function


            'Private Function GetFunctionAndParameters(ByVal strFunctionWithParamters As String, ByRef strFunctionName As String) As String
            '    '=====================================================================
            '    ' Procedure Name        : GetFunctionAndParameters()
            '    ' Purpose               : to get the function & parameters
            '    ' Description           : splits the string which should be in
            '    '                         function_name('param1','{}param2',...) format
            '    '                         to get the function name and string of comma separated
            '    '                         parameters
            '    ' Parameters Passed     : Byval strFunctionWithParamters | function_name('param1','{}param2',...) format
            '    '                         ByRef strFunctionName | function_name is set 
            '    ' Returns               : string of parameters sans the brackets and function name
            '    ' Parameters Affected   : strFunction Name
            '    ' Assumptions           : 
            '    ' Dependencies          : 
            '    ' Author                : Rajanikant
            '    ' Created               : September 15,2003
            '    ' Revisions             :
            '    '=====================================================================
            '    Dim arr() As String
            '    Dim strTemp As String

            '    ' split the string function_name('param1','{}param2',...) format on char "(" 
            '    arr = Split(strFunctionWithParamters, "(")
            '    If UBound(arr) > 0 Then
            '        ' the function_name
            '        strFunctionName = arr(0)
            '        ' the param list with ")"
            '        strTemp = arr(1).Trim
            '    End If

            '    ' remove the trailing ")" bracket
            '    If Right(strTemp, 1) = ")" Then
            '        strTemp = Left(strTemp, Len(strTemp) - 1)
            '    End If

            '    ' return the string
            '    Return strTemp

            'End Function


        End Class

        Public Class cAdvancedGrid
            Inherits WebPages.Grid.cAdvancedGrid
            'Inherits WebPages.Grid.cGrid
            '            '=====================================================================
            '            ' Class	Name	        :	cAdvancedGrid
            '            ' Purpose				:	This class builds the Advanced GRID for the specified 
            '            '                           values 
            '            ' Description			:	This class is inherited from cGrid class
            '            '                           
            '            ' Assumptions			:	None
            '            ' Dependencies			:	WebPages.Grid.cGrid
            '            ' Author				:	Rajanikant
            '            ' Created				:	Jan 22,2004
            '            ' Revisions				:	
            '            '=====================================================================
            '#Region "variable declaration"
            '            Protected marrUserFriendlyColumn() As String = {}
            '            Protected marrActualColumn() As String = {}
            '            Protected marrCheckBoxID() As String
            '            Protected marrCheckboxCheckOnColumn() As String
            '            Protected marrCheckboxDisableOnColumn() As String
            '            Protected marrRowLink() As String
            '            Protected marrRowLinkToolTip() As String
            '            Protected marrRowLinkEnableOnColumn() As String
            '            Protected marrReplacementValue() As String
            '            Protected marrTDStyle() As String
            '            Protected mintNoOfRows As Integer = 0
            '            Protected mintDIVHeight As Integer = 0
            '            Protected mintNoOfDataColumns As Integer = 0
            '            Protected mblnColNameToolTipOnEachRow As Boolean = False
            '            Protected mblnVerticalDisplay As Boolean = False
            '            Protected mblnReturnHTML As Boolean = False
            '            Protected mblnPrinterFriendlyVersion As Boolean = False
            '            Protected mstrPrimaryKey As String = ""
            '            Protected mstrHorizontalSeparatorHTML As String = ""
            '            Protected mstrColumnHeaderAlignment As String = ""
            '            Protected mstrBooleanTrueHTML As String = "Yes"
            '            Protected mstrBooleanFalseHTML As String = "No"
            '            Protected mstrDIVStyle As String = "overflow:auto"
            '            Protected mstrDIVID As String = "DivList"
            '            Protected mstrHeaderHTML As String = ""
            '            Protected mstrFooterHTML As String = ""
            '            Protected mstrSortBy As String = ""
            '            Protected mstrSortOrder As String = ""
            '            Protected mstrSQL As String = ""
            '            Protected mstrClientSideSortFunctionName As String = ""
            '            Protected mstrEmptyValueReplacement As String = "&lt;Not Specified&gt;"
            '            Protected mblnUseSQL As Boolean
            '            Protected mstrNoDataComment As String = "There are no items to show in this view"
            '            Protected mstrSortedTDStyle As String = "clsTDSortColHeader"

            '            Protected mlngCurrentPage As Long = 0
            '            Protected mlngPageSize As Long = 0
            '            Protected mlngFirstRow As Long = -1
            '            Protected mlngLastRow As Long = -1
            '            Protected mintNoOfRowsInPage As Integer = 0

            '            ' group arrays
            '            Protected marrGroupOnColumn() As String '= {}
            '            Protected marrGroupSummaryFunc() As String = {}
            '            Protected mstrGroupTRStyle As String = "clsTRSectionTitle"

            '            ' collapsible col properties
            '            Protected mstrCollapseImageHTML As String = "<img src='../../Images/plus.gif' border=0>"
            '            Protected mstrExpandImageHTML As String = "<img src='../../Images/minus.gif' border=0>"
            '            Protected marrColumnGroupNames() As String = {}         ' "grp 1","grp 2"
            '            Protected marrColumnGroupColumns() As String = {}       ' "1-3","4-6"
            '            Protected marrColumnGroupExpanded() As String = {}     ' "1","0"
            '            Protected mstrExpandCollapseClientSideFunctionName As String = "ExpandCollapse_OnClick" 'ExpandCollapse_OnClick(<col_name>,<status|0,1>)" '
            '            Protected mstrColumnGroupTRStyle As String = MyBase.clsColumnHeader

            '            Protected marrIgnoreHTMLEncode() As String
            '            Protected mstrColumnSeparatorTDStyle As String

            '            ' summary functions 
            '            Protected marrSummaryFunctions() As String = {}
            '            Protected mblnShowSummaryFunctions As Boolean = False
            '            Protected mstrSummaryFunctionTRStyle As String = ""
            '#End Region

            '#Region "properties"
            '            Public Property SummaryFunctionTRStyle() As String
            '                Get
            '                    SummaryFunctionTRStyle = mstrSummaryFunctionTRStyle
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrSummaryFunctionTRStyle = Value
            '                End Set
            '            End Property
            '            Public Property ShowSummaryFunctions() As Boolean
            '                Get
            '                    ShowSummaryFunctions = mblnShowSummaryFunctions
            '                End Get
            '                Set(ByVal Value As Boolean)
            '                    mblnShowSummaryFunctions = Value
            '                End Set
            '            End Property
            '            Public Property SummaryFunctions() As String()
            '                Get
            '                    SummaryFunctions = marrSummaryFunctions
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrSummaryFunctions = Value
            '                End Set
            '            End Property

            '            Public Property ColumnSeparatorTDStyle() As String
            '                Get
            '                    ColumnSeparatorTDStyle = mstrColumnSeparatorTDStyle
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrColumnSeparatorTDStyle = Value
            '                End Set
            '            End Property
            '            Public Property IgnoreHTMLEncode() As String()
            '                Get
            '                    IgnoreHTMLEncode = marrIgnoreHTMLEncode
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrIgnoreHTMLEncode = Value
            '                End Set
            '            End Property

            '            Public Property ColumnGroupTRStyle() As String
            '                Get
            '                    ColumnGroupTRStyle = mstrColumnGroupTRStyle
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrColumnGroupTRStyle = Value
            '                End Set
            '            End Property
            '            Public Property ExpandCollapseClientSideFunctionName() As String
            '                Get
            '                    ExpandCollapseClientSideFunctionName = mstrExpandCollapseClientSideFunctionName
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrExpandCollapseClientSideFunctionName = Value
            '                End Set
            '            End Property
            '            Public Property CollapseImage() As String
            '                Get
            '                    CollapseImage = mstrCollapseImageHTML
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrCollapseImageHTML = Value
            '                End Set
            '            End Property
            '            Public Property ExpandImage() As String
            '                Get
            '                    ExpandImage = mstrExpandImageHTML
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrExpandImageHTML = Value
            '                End Set
            '            End Property

            '            Public Property ColumnGroupNameArray() As String()
            '                Get
            '                    ColumnGroupNameArray = marrColumnGroupNames
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrColumnGroupNames = Value
            '                End Set
            '            End Property

            '            Public Property ColumnGroupColumnsArray() As String()
            '                Get
            '                    ColumnGroupColumnsArray = marrColumnGroupColumns
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrColumnGroupColumns = Value
            '                End Set
            '            End Property

            '            Public Property ColumnGroupExpandedArray() As String()
            '                Get
            '                    ColumnGroupExpandedArray = marrColumnGroupExpanded
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrColumnGroupExpanded = Value
            '                End Set
            '            End Property


            '            Public Property GroupTRStyle() As String
            '                Get
            '                    GroupTRStyle = mstrGroupTRStyle
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrGroupTRStyle = Value
            '                End Set
            '            End Property
            '            Public Property GroupOnColumn() As String()
            '                Get
            '                    GroupOnColumn = marrGroupOnColumn
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrGroupOnColumn = Value
            '                End Set
            '            End Property
            '            Public Property GroupSummaryFunc() As String()
            '                Get
            '                    GroupSummaryFunc = marrGroupSummaryFunc
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrGroupSummaryFunc = Value
            '                End Set
            '            End Property
            '            Public Property CheckBoxIDArray() As String()
            '                Get
            '                    CheckBoxIDArray = marrCheckBoxID
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrCheckBoxID = Value
            '                End Set
            '            End Property
            '            Public Property CheckboxCheckOnColumnArray() As String()
            '                Get
            '                    CheckboxCheckOnColumnArray = marrCheckboxCheckOnColumn
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrCheckboxCheckOnColumn = Value
            '                End Set
            '            End Property
            '            Public Property CheckboxDisableOnColumnArray() As String()
            '                Get
            '                    CheckboxDisableOnColumnArray = marrCheckboxDisableOnColumn
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrCheckboxDisableOnColumn = Value
            '                End Set
            '            End Property
            '            Public Property CurrentPage() As Long
            '                Get
            '                    CurrentPage = mlngCurrentPage
            '                End Get
            '                Set(ByVal Value As Long)
            '                    mlngCurrentPage = Value
            '                End Set
            '            End Property
            '            Public Property PageSize() As Long
            '                Get
            '                    PageSize = mlngPageSize
            '                End Get
            '                Set(ByVal Value As Long)
            '                    mlngPageSize = Value
            '                End Set
            '            End Property
            '            Public Property ColumnReplacementValue() As String()
            '                Get
            '                    ColumnReplacementValue = marrReplacementValue
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrReplacementValue = Value
            '                End Set
            '            End Property
            '            Public Property SortedTDStyle() As String
            '                Get
            '                    SortedTDStyle = mstrSortedTDStyle
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrSortedTDStyle = Value
            '                End Set
            '            End Property
            '            Public Property NoDataComment() As String
            '                Get
            '                    NoDataComment = mstrNoDataComment
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrNoDataComment = Value
            '                End Set
            '            End Property
            '            Public Property UseSQL() As Boolean
            '                Get
            '                    UseSQL = mblnUseSQL
            '                End Get
            '                Set(ByVal Value As Boolean)
            '                    mblnUseSQL = Value
            '                End Set
            '            End Property
            '            Public Property EmptyValueReplacement() As String
            '                Get
            '                    EmptyValueReplacement = mstrEmptyValueReplacement
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrEmptyValueReplacement = Value
            '                End Set
            '            End Property
            '            Public Property BooleanTrueHTML() As String
            '                Get
            '                    BooleanTrueHTML = mstrBooleanTrueHTML
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrBooleanTrueHTML = Value
            '                End Set
            '            End Property
            '            Public Property BooleanFalseHTML() As String
            '                Get
            '                    BooleanFalseHTML = mstrBooleanFalseHTML
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrBooleanFalseHTML = Value
            '                End Set
            '            End Property
            '            Public Property ColumnHeaderAlignment() As String
            '                Get
            '                    ColumnHeaderAlignment = mstrColumnHeaderAlignment
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrColumnHeaderAlignment = Value
            '                End Set
            '            End Property
            '            Public Property TDStyleArray() As String()
            '                Get
            '                    TDStyleArray = marrTDStyle
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrTDStyle = Value
            '                End Set
            '            End Property
            '            Public Property HorizontalSeparatorHTML() As String
            '                Get
            '                    HorizontalSeparatorHTML = mstrHorizontalSeparatorHTML
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrHorizontalSeparatorHTML = Value
            '                End Set
            '            End Property
            '            Public Property VerticalDisplay() As Boolean
            '                Get
            '                    VerticalDisplay = mblnVerticalDisplay
            '                End Get
            '                Set(ByVal Value As Boolean)
            '                    mblnVerticalDisplay = Value
            '                End Set
            '            End Property
            '            Public Property PrimaryKey() As String
            '                Get
            '                    PrimaryKey = mstrPrimaryKey
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrPrimaryKey = Value
            '                End Set
            '            End Property
            '            Public Property NoOfDataColumns() As Integer
            '                Get
            '                    NoOfDataColumns = mintNoOfDataColumns
            '                End Get
            '                Set(ByVal Value As Integer)
            '                    mintNoOfDataColumns = Value
            '                End Set
            '            End Property
            '            Public Property ColNameToolTipOnEachRow() As Boolean
            '                Get
            '                    ColNameToolTipOnEachRow = mblnColNameToolTipOnEachRow
            '                End Get
            '                Set(ByVal Value As Boolean)
            '                    mblnColNameToolTipOnEachRow = Value
            '                End Set
            '            End Property
            '            Public Property DIVID() As String
            '                Get
            '                    DIVID = mstrDIVID
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrDIVID = Value
            '                End Set
            '            End Property
            '            Public Property DIVStyle() As String
            '                Get
            '                    DIVStyle = mstrDIVStyle
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrDIVStyle = Value
            '                End Set
            '            End Property
            '            Public Property DIVHeight() As Integer
            '                Get
            '                    DIVHeight = mintDIVHeight
            '                End Get
            '                Set(ByVal Value As Integer)
            '                    mintDIVHeight = Value
            '                End Set
            '            End Property
            '            Public Property SQL() As String
            '                Get
            '                    SQL = mstrSQL
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrSQL = Value
            '                End Set
            '            End Property
            '            Public Property ClientSideSortFunctionName() As String
            '                Get
            '                    ClientSideSortFunctionName = mstrClientSideSortFunctionName
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrClientSideSortFunctionName = Value
            '                End Set
            '            End Property
            '            Public Property UserFriendlyColumnArray() As String()
            '                Get
            '                    UserFriendlyColumnArray = marrUserFriendlyColumn
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrUserFriendlyColumn = Value
            '                End Set
            '            End Property
            '            Public Property ActualColumnArray() As String()
            '                Get
            '                    ActualColumnArray = marrActualColumn
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrActualColumn = Value
            '                End Set
            '            End Property
            '            Public Property RowLinkArray() As String()
            '                Get
            '                    RowLinkArray = marrRowLink
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrRowLink = Value
            '                End Set
            '            End Property
            '            Public Property RowLinkToolTipArray() As String()
            '                Get
            '                    RowLinkToolTipArray = marrRowLinkToolTip
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrRowLinkToolTip = Value
            '                End Set
            '            End Property
            '            Public Property RowLinkEnableOnColumn() As String()
            '                Get
            '                    RowLinkEnableOnColumn = marrRowLinkEnableOnColumn
            '                End Get
            '                Set(ByVal Value As String())
            '                    marrRowLinkEnableOnColumn = Value
            '                End Set
            '            End Property
            '            Public Property HeaderHTML() As String
            '                Get
            '                    HeaderHTML = mstrHeaderHTML
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrHeaderHTML = Value
            '                End Set
            '            End Property
            '            Public Property FooterHTML() As String
            '                Get
            '                    FooterHTML = mstrFooterHTML
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrFooterHTML = Value
            '                End Set
            '            End Property
            '            Public Property SortBy() As String
            '                Get
            '                    SortBy = mstrSortBy
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrSortBy = Value
            '                End Set
            '            End Property
            '            Public Property SortOrder() As String
            '                Get
            '                    SortOrder = mstrSortOrder
            '                End Get
            '                Set(ByVal Value As String)
            '                    mstrSortOrder = Value
            '                End Set
            '            End Property
            '            Public Property returnHTML() As Boolean
            '                Get
            '                    returnHTML = mblnReturnHTML
            '                End Get
            '                Set(ByVal Value As Boolean)
            '                    mblnReturnHTML = Value
            '                End Set
            '            End Property
            '            Public ReadOnly Property NoOfRows() As Integer
            '                Get
            '                    NoOfRows = mintNoOfRows
            '                End Get
            '            End Property
            '            Public ReadOnly Property NoOfRowsInPage() As Integer
            '                Get
            '                    NoOfRowsInPage = mintNoOfRowsInPage
            '                End Get
            '            End Property
            '            Public Property PrinterFriendlyVersion() As Boolean
            '                Get
            '                    PrinterFriendlyVersion = mblnPrinterFriendlyVersion
            '                End Get
            '                Set(ByVal Value As Boolean)
            '                    mblnPrinterFriendlyVersion = Value
            '                End Set
            '            End Property
            '#End Region

            '#Region "public methods"
            '            Public Function DrawGrid() As String
            '                '=====================================================================
            '                ' Procedure Name        : DrawGrid()
            '                ' Description           : Uses private functions to draw the grids  
            '                ' Purpose               : draws the grid for the SQL using properties
            '                ' Parameters Passed     : None
            '                ' Returns               :
            '                ' Parameters Affected   : 
            '                ' Assumptions           :
            '                ' Dependencies          : private fns. DrawHorizontalGrid, DrawVerticalGrid
            '                ' Author                : Rajanikant
            '                ' Created               : Jan 22,2004
            '                ' Revisions             :
            '                '=====================================================================
            '                If mblnVerticalDisplay Then
            '                    Return DrawVerticalGrid(returnHTML)
            '                Else
            '                    Return DrawHorizontalGrid(returnHTML)
            '                End If
            '            End Function
            '#End Region

            '#Region "private methods"
            '            Private Function DrawHorizontalGrid(ByVal returnHTML As Boolean) As String
            '                '=====================================================================
            '                ' Procedure Name        : DrawHorizontalGrid()
            '                ' Description           :
            '                ' Purpose               : draws the grid horizontally for the SQL using properties
            '                ' Parameters Passed     : None
            '                ' Returns               : string
            '                ' Parameters Affected   : 
            '                ' Assumptions           : 
            '                ' Dependencies          : module variables
            '                ' Author                : Rajanikant
            '                ' Created               : Jan 22,2004
            '                ' Revisions             :
            '                '=====================================================================
            '                Dim intCount As Integer
            '                Dim intUpperBound As Integer
            '                Dim intItemCount As Integer
            '                Dim intLoopCtr As Integer
            '                Dim dr As IDataReader
            '                Dim sb As System.Text.StringBuilder
            '                Dim blnPrinted As Boolean = False
            '                Dim strParameters As String
            '                Dim strFunctionName As String
            '                Dim blnChecked As Boolean = False
            '                Dim blnDisabled As Boolean = False
            '                Dim strValue As String = ""
            '                Dim strURL As String
            '                Dim intCount2 As Integer
            '                Dim intCount3 As Integer
            '                Dim intUBound1 As Integer
            '                Dim intUBound2 As Integer

            '                Dim blnEnableLink As Boolean = True
            '                Dim mblnPrintRow As Boolean = True
            '                Dim mblnExitLoop As Boolean = False

            '                Dim arr() As String
            '                Dim arrQueryString() As String = {}
            '                Dim arrPlaceHolder() As String = {}

            '                Dim arrGroupOnColumnValue() As String = {}
            '                Dim blnPrintColumn As Boolean = True
            '                Dim blnIsGroupingPresent As Boolean = False

            '                Dim intColumnGroupCount As Integer = 0


            '                Dim blnAreColumnGroupsPresent As Boolean = False
            '                Dim blnIsColumnGroupExpanded As Boolean = True
            '                Dim intColumnGroupStart As Integer
            '                Dim intColumnGroupEnd As Integer
            '                Dim arrColumnGroupExpanded() As Boolean = {}
            '                Dim arrColumnGroupNumber() As Integer = {}

            '                Dim blnApplyHTMLEncode As Boolean = True
            '                Dim lngRowSpan As Long = 0
            '                Dim ds As DataSet

            '                Dim arrSummaryFuncValue() As Double = {}

            '                ' total number of columns to be displayed
            '                intUpperBound = UBound(marrUserFriendlyColumn)
            '                ReDim Preserve arrColumnGroupExpanded(intUpperBound)
            '                ReDim Preserve arrColumnGroupNumber(intUpperBound)
            '                ReDim Preserve arrGroupOnColumnValue(intUpperBound)
            '                ReDim Preserve arrSummaryFuncValue(intUpperBound)

            '                For intCount = 0 To intUpperBound
            '                    arrColumnGroupExpanded(intCount) = True
            '                Next
            '                ' initialize the string builder
            '                sb = New System.Text.StringBuilder

            '                ' grid header
            '                sb.Append(mstrHeaderHTML)

            '                mstrSortBy = Replace(Replace(mstrSortBy, "[", "", , , CompareMethod.Binary), "]", "", , , CompareMethod.Binary)

            '                ' do not show the DIV for printer friendly version
            '                If Not mblnPrinterFriendlyVersion And mintDIVHeight > 0 Then
            '                    ' DIV start
            '                    If mstrDIVID.Trim = "" Then
            '                        mstrDIVID = "DivList"
            '                    End If
            '                    sb.Append("<DIV id=" + mstrDIVID + " style='" + mstrDIVStyle + ";Height:" + mintDIVHeight.ToString + "' >" + vbCrLf)
            '                End If

            '                ' table start
            '                sb.Append("<TABLE class='" + MyBase.clsTable + "'" + MyBase.TableStyle + " width='100%'>" + vbCrLf)

            '                ' get the data for the grid
            '                dr = CommonFunctions.Data.GetDataReader(mstrSQL, mblnUseSQL)

            '                ' group columns !!
            '                intColumnGroupCount = UBound(marrColumnGroupColumns)
            '                If intColumnGroupCount >= 0 Then
            '                    blnAreColumnGroupsPresent = True
            '                    ' get the row span
            '                    ds = CommonFunctions.Data.GetDataSet(mstrSQL, "default", , , mblnUseSQL)
            '                    If Not ds Is Nothing Then
            '                        lngRowSpan = ds.Tables(0).Rows.Count - 1 + 4
            '                    End If
            '                Else
            '                    blnAreColumnGroupsPresent = False
            '                End If

            '                If blnAreColumnGroupsPresent Then
            '                    ' print the column groups in the first row
            '                    sb.Append("<TR class='" + mstrColumnGroupTRStyle + "'>" + vbCrLf)
            '                    ' now check the array having column group definition and print col group headers
            '                    For intCount2 = 0 To intColumnGroupCount
            '                        Dim arrColGroups() As String
            '                        Dim intColSpan As Integer
            '                        If IsArrayValuePresent(marrColumnGroupColumns, intCount2) Then
            '                            arrColGroups = Split(marrColumnGroupColumns(intCount2), "-")
            '                            Try
            '                                intColumnGroupStart = CType(arrColGroups(LBound(arrColGroups)), Integer)
            '                                intColumnGroupEnd = CType(arrColGroups(UBound(arrColGroups)), Integer)
            '                                intColSpan = intColumnGroupEnd - intColumnGroupStart

            '                                ' expand/collapse image
            '                                If Trim(mstrExpandCollapseClientSideFunctionName & "") <> "" Then
            '                                    If IsArrayValuePresent(marrColumnGroupExpanded, intCount2) Then
            '                                        If Trim(marrColumnGroupExpanded(intCount2) & "") = "1" Then
            '                                            For intCount = intColumnGroupStart To intColumnGroupEnd
            '                                                arrColumnGroupExpanded(intCount - 1) = True
            '                                                arrColumnGroupNumber(intCount - 1) = intCount2
            '                                            Next
            '                                            sb.Append("<td class=" & mstrColumnSeparatorTDStyle & "  rowspan=" & lngRowSpan & " width=1pt></td>")
            '                                            sb.Append("<TD colspan=" & intColSpan + 1 & " align=center>")
            '                                            blnIsColumnGroupExpanded = True
            '                                            If IsArrayValuePresent(marrColumnGroupNames, intCount2) Then
            '                                                sb.Append("<A href=" + Chr(34) + "javascript:" + mstrExpandCollapseClientSideFunctionName + "('" + marrColumnGroupNames(intCount2) + "',1)" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                                sb.Append(mstrExpandImageHTML)
            '                                                sb.Append("</A> ")
            '                                            End If
            '                                        Else
            '                                            sb.Append("<td class=" & mstrColumnSeparatorTDStyle & "  rowspan=" & lngRowSpan & "  width=1pt></td>")
            '                                            sb.Append("<TD align=center>")
            '                                            For intCount = intColumnGroupStart To intColumnGroupEnd
            '                                                arrColumnGroupExpanded(intCount - 1) = False
            '                                                arrColumnGroupNumber(intCount - 1) = intCount2
            '                                            Next
            '                                            blnIsColumnGroupExpanded = False
            '                                            If IsArrayValuePresent(marrColumnGroupNames, intCount2) Then
            '                                                sb.Append("<A href=" + Chr(34) + "javascript:" + mstrExpandCollapseClientSideFunctionName + "('" + marrColumnGroupNames(intCount2) + "',0)" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                                sb.Append(mstrCollapseImageHTML)
            '                                                sb.Append("</A> ")
            '                                            End If
            '                                        End If
            '                                    End If
            '                                End If

            '                                ' column grp name
            '                                If IsArrayValuePresent(marrColumnGroupNames, intCount2) Then
            '                                    If blnIsColumnGroupExpanded Then
            '                                        sb.Append(HttpContext.Current.Server.HtmlEncode(marrColumnGroupNames(intCount2)))
            '                                    Else
            '                                        sb.Append(HttpContext.Current.Server.HtmlEncode(Left(marrColumnGroupNames(intCount2), 1) + "..."))
            '                                    End If
            '                                End If
            '                                sb.Append("</TD>")
            '                            Catch
            '                                sb.Append("<TD  align=center></TD>")
            '                            End Try
            '                        Else
            '                            sb.Append("<TD  align=center></TD>")
            '                        End If
            '                    Next
            '                    sb.Append("</TR>")
            '                End If

            '                ' COLUMNS for the grid
            '                sb.Append("<TR class='" + MyBase.clsColumnHeader.Trim + "'>" + vbCrLf)
            '                For intCount = 0 To intUpperBound

            '                    ' Apply HTML encode??
            '                    blnApplyHTMLEncode = True
            '                    If IsArrayValuePresent(marrIgnoreHTMLEncode, intCount) Then
            '                        If Trim(marrIgnoreHTMLEncode(intCount) & "") = "1" Then
            '                            blnApplyHTMLEncode = False
            '                        End If
            '                    End If

            '                    If arrColumnGroupExpanded(intCount) = True Then
            '                        sb.Append("<TD ")

            '                        If Trim(mstrColumnHeaderAlignment & "") <> "" Then
            '                            ' use the specified alignment
            '                            sb.Append("align=" + mstrColumnHeaderAlignment + vbCrLf)
            '                        Else
            '                            ' use the row TD style if present
            '                            If IsArrayValuePresent(marrCheckBoxID, intCount) Then
            '                                sb.Append(" align=center " + vbCrLf)
            '                            Else
            '                                ' alignment based on data type of the column
            '                                If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                    If intCount < mintNoOfDataColumns Then
            '                                        Select Case dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper
            '                                            Case "FLOAT", "INT", "BIT", "REAL" : sb.Append(" align=right " + vbCrLf)
            '                                            Case "DATETIME" : sb.Append(" align=left " + vbCrLf)
            '                                            Case Else : sb.Append(" align=left " + vbCrLf)
            '                                        End Select
            '                                    End If
            '                                Else
            '                                    If intCount < mintNoOfDataColumns Then
            '                                        Select Case dr.GetDataTypeName(intCount).Trim.ToUpper
            '                                            Case "FLOAT", "INT", "BIT", "REAL" : sb.Append(" align=right " + vbCrLf)
            '                                            Case "DATETIME" : sb.Append(" align=left " + vbCrLf)
            '                                            Case Else : sb.Append(" align=left " + vbCrLf)
            '                                        End Select
            '                                    End If
            '                                End If
            '                            End If
            '                        End If

            '                        If intCount < mintNoOfDataColumns Then
            '                            ' For Priner Friendly versions/text/image data types ignore sorting images/functions
            '                            'If Not mblnPrinterFriendlyVersion And Not (dr.GetDataTypeName(intCount).Trim.ToUpper = "TEXT" Or dr.GetDataTypeName(intCount).Trim.ToUpper = "IMAGE") Then
            '                            If Not MyBase.SortByImage Is Nothing Then
            '                                If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                    If Not mblnPrinterFriendlyVersion And Not (dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper = "TEXT" Or dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper = "IMAGE") Then
            '                                        ' Is the sorting on this field?
            '                                        If Trim(marrActualColumn(intCount) & "").ToUpper = Trim(mstrSortBy & "").ToUpper Then
            '                                            sb.Append(" class='" + mstrSortedTDStyle + "'>")
            '                                            ' What is the sort order?
            '                                            If Trim(mstrSortOrder & "").ToUpper = "ASC" Then
            '                                                ' Its ASC so next click on this should change the order to DESC
            '                                                If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                                    sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + marrActualColumn(intCount) + "','DESC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                                    sb.Append("<img src='" + MyBase.SortDownImage + "' border=0>" + vbCrLf)
            '                                                End If
            '                                            Else
            '                                                ' Its DESC so next click on this should change the order to ASC
            '                                                If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                                    sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + marrActualColumn(intCount) + "','ASC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                                    sb.Append("<img src='" + MyBase.SortUpImage + "' border=0>" + vbCrLf)
            '                                                End If

            '                                            End If
            '                                        Else
            '                                            sb.Append(">")
            '                                            ' Default Sorting
            '                                            If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                                sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + marrActualColumn(intCount) + "','ASC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                                sb.Append("<img src='" + MyBase.SortByImage + "' border=0>" + vbCrLf)
            '                                            End If
            '                                        End If
            '                                    Else
            '                                        sb.Append(">")
            '                                    End If

            '                                Else
            '                                    ' Is the sorting on this field?
            '                                    If Trim(dr.GetName(intCount).ToString & "").ToUpper = Trim(mstrSortBy & "").ToUpper Then
            '                                        sb.Append(" class='" + mstrSortedTDStyle + "'>")
            '                                        ' What is the sort order?
            '                                        If Trim(mstrSortOrder & "").ToUpper = "ASC" Then
            '                                            ' Its ASC so next click on this should change the order to DESC
            '                                            If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                                sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + dr.GetName(intCount) + "','DESC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                                sb.Append("<img src='" + MyBase.SortDownImage + "' border=0>" + vbCrLf)
            '                                            End If
            '                                        Else
            '                                            ' Its DESC so next click on this should change the order to ASC
            '                                            If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                                sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + dr.GetName(intCount) + "','ASC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                                sb.Append("<img src='" + MyBase.SortUpImage + "' border=0>" + vbCrLf)
            '                                            End If

            '                                        End If
            '                                    Else
            '                                        sb.Append(">")
            '                                        ' Default Sorting
            '                                        If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                            sb.Append("<A href=" + Chr(34) + "JavaScript:" + mstrClientSideSortFunctionName + "('" + dr.GetName(intCount) + "','ASC')" + Chr(34) + " Style='TEXT-DECORATION:None'>" + vbCrLf)
            '                                            sb.Append("<img src='" + MyBase.SortByImage + "' border=0>" + vbCrLf)
            '                                        End If
            '                                    End If
            '                                End If

            '                            End If
            '                            If mstrClientSideSortFunctionName.Trim <> "" Then
            '                                sb.Append("</A>" + vbCrLf)
            '                            End If
            '                        Else
            '                            sb.Append(">")
            '                        End If
            '                        If blnApplyHTMLEncode Then
            '                            sb.Append(CommonFunctions.General.FormatString(marrUserFriendlyColumn(intCount)))
            '                        Else
            '                            sb.Append(marrUserFriendlyColumn(intCount))
            '                        End If
            '                        sb.Append("</TD>" + vbCrLf)
            '                    Else
            '                        If intCount > 0 Then
            '                            If arrColumnGroupNumber(intCount) <> arrColumnGroupNumber(intCount - 1) Then
            '                                sb.Append("</TD>")
            '                                sb.Append("<TD>")
            '                            End If
            '                        Else
            '                            sb.Append("<TD>")
            '                        End If
            '                    End If

            '                Next intCount
            '                sb.Append("</TR>" + vbCrLf)

            '                ' before we plot the rows lets see if the request is for a specific page
            '                If mlngPageSize <> 0 And mlngCurrentPage > 0 Then
            '                    If mlngCurrentPage = 1 Then
            '                        mlngFirstRow = 1
            '                    Else
            '                        mlngFirstRow = ((mlngCurrentPage - 1) * mlngPageSize) + 1
            '                    End If
            '                    mlngLastRow = (mlngCurrentPage * mlngPageSize)
            '                End If


            '                ' ROWS go here
            '                Do While dr.Read()

            '                    ' paging decisions!
            '                    If mlngFirstRow <> -1 And mlngLastRow <> -1 Then
            '                        If Not (mlngFirstRow = 1 And mintNoOfRows = 0) Then
            '                            If mlngFirstRow > mintNoOfRows + 1 Then
            '                                mblnPrintRow = False
            '                            Else
            '                                mblnPrintRow = True
            '                            End If
            '                        End If
            '                        If mlngLastRow < mintNoOfRows Then
            '                            mintNoOfRows -= 1
            '                            mintNoOfRowsInPage -= 1
            '                            mblnExitLoop = True
            '                        Else
            '                            mblnExitLoop = False
            '                        End If
            '                    End If
            '                    If mblnExitLoop Then Exit Do

            '                    If mblnPrintRow Then
            '                        mintNoOfRowsInPage += 1
            '                        For intCount = 0 To intUpperBound
            '                            ' Apply HTML encode??
            '                            blnApplyHTMLEncode = True
            '                            If IsArrayValuePresent(marrIgnoreHTMLEncode, intCount) Then
            '                                If Trim(marrIgnoreHTMLEncode(intCount) & "") = "1" Then
            '                                    blnApplyHTMLEncode = False
            '                                End If
            '                            End If
            '                            If intCount < mintNoOfDataColumns Then
            '                                blnPrintColumn = True
            '                                blnIsGroupingPresent = False
            '                                ' grouping info
            '                                If IsArrayValuePresent(marrGroupOnColumn, intCount) Then
            '                                    blnIsGroupingPresent = True
            '                                    If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                        ' actual col name is specified
            '                                        If UCase(Trim(dr(marrActualColumn(intCount)).ToString & "")) <> UCase(Trim(arrGroupOnColumnValue(intCount) & "")) Then
            '                                            ' new value print
            '                                            blnPrintColumn = True
            '                                        Else
            '                                            ' prev value matched ..do not print
            '                                            blnPrintColumn = False
            '                                            blnIsGroupingPresent = False
            '                                        End If
            '                                        arrGroupOnColumnValue(intCount) = dr(marrActualColumn(intCount)).ToString
            '                                    Else
            '                                        If UCase(Trim(dr(intCount).ToString & "")) <> UCase(Trim(arrGroupOnColumnValue(intCount) & "")) Then
            '                                            blnPrintColumn = True
            '                                        Else
            '                                            blnPrintColumn = False
            '                                            blnIsGroupingPresent = False
            '                                        End If
            '                                        arrGroupOnColumnValue(intCount) = dr(intCount).ToString
            '                                    End If
            '                                Else
            '                                    blnPrintColumn = True
            '                                End If

            '                                If blnIsGroupingPresent Then
            '                                    sb.Append("<TR class='" + mstrGroupTRStyle + "'>" + vbCrLf)
            '                                Else
            '                                    If intCount = 0 Then
            '                                        If mintNoOfRows Mod 2 = 0 Then
            '                                            sb.Append("<TR class='" + MyBase.clsTROdd.Trim + "'>" + vbCrLf)
            '                                        Else
            '                                            sb.Append("<TR class='" + MyBase.clsTREven.Trim + "'>" + vbCrLf)
            '                                        End If
            '                                    End If
            '                                End If

            '                                If arrColumnGroupExpanded(intCount) = True Then

            '                                    If Not blnPrintColumn Then
            '                                        sb.Append("<TD  vAlign=top")
            '                                    Else
            '                                        If blnIsGroupingPresent Then
            '                                            sb.Append("<TD colspan=" & intUpperBound + 1 & " align=left")
            '                                        Else
            '                                            sb.Append("<TD  vAlign=top")
            '                                        End If

            '                                        If IsArrayValuePresent(marrTDStyle, intCount) Then
            '                                            strParameters = ""
            '                                            ' code to replace place-holders "[]" present in the TDStyle for the position
            '                                            If Left(marrTDStyle(intCount), 2) = "{}" Or Left(marrTDStyle(intCount), 3) = "'{}" Then
            '                                                If InStr(marrTDStyle(intCount), "[", CompareMethod.Binary) > 0 And InStr(marrTDStyle(intCount), "]", CompareMethod.Binary) > 0 Then
            '                                                    ' there are place holders which are to be replaced with data values
            '                                                    ' build the url
            '                                                    strURL = ""
            '                                                    arrQueryString = Split(marrTDStyle(intCount), "[", -1, CompareMethod.Binary)
            '                                                    intUBound1 = UBound(arrQueryString)
            '                                                    For intCount2 = 0 To intUBound1
            '                                                        arrPlaceHolder = Split(arrQueryString(intCount2), "]")
            '                                                        intUBound2 = UBound(arrPlaceHolder)
            '                                                        If intUBound2 >= 0 Then
            '                                                            For intCount3 = 0 To intUBound2
            '                                                                Try
            '                                                                    strURL += Replace(dr(arrPlaceHolder(intCount3)).ToString, "'", "|||")
            '                                                                Catch
            '                                                                    strURL += arrPlaceHolder(intCount3)
            '                                                                End Try
            '                                                            Next
            '                                                        Else
            '                                                            strURL += arrQueryString(intCount2)
            '                                                        End If
            '                                                    Next
            '                                                    strParameters += Replace(strURL, "{}", "")
            '                                                Else
            '                                                    ' pass the parameter as it is (just replace the {} prefix)
            '                                                    strParameters += Replace(marrTDStyle(intCount), "{}", "")
            '                                                End If
            '                                            Else
            '                                                strParameters += marrTDStyle(intCount)
            '                                            End If
            '                                            If Left(strParameters, 1) = "," Then
            '                                                strParameters = Right(strParameters, Len(strParameters) - 1)
            '                                            End If
            '                                            sb.Append(" " & strParameters)

            '                                        ElseIf IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                            Select Case dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper
            '                                                Case "FLOAT", "INT", "BIT", "REAL"
            '                                                    sb.Append(" align=right ")
            '                                            End Select
            '                                        Else
            '                                            Select Case dr.GetDataTypeName(intCount).Trim.ToUpper
            '                                                Case "FLOAT", "INT", "BIT", "REAL"
            '                                                    sb.Append(" align=right ")
            '                                            End Select
            '                                        End If
            '                                    End If
            '                                    If mblnColNameToolTipOnEachRow Then
            '                                        sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrUserFriendlyColumn(intCount)) + Chr(34))
            '                                    End If
            '                                    sb.Append(">" + vbCrLf)

            '                                    If IsArrayValuePresent(marrRowLinkEnableOnColumn, intCount) Then
            '                                        blnEnableLink = False
            '                                        If CType(dr(marrRowLinkEnableOnColumn(intCount)), Boolean) = True Then
            '                                            blnEnableLink = True
            '                                        End If
            '                                    End If


            '                                    If blnEnableLink Then
            '                                        ' link on the field??
            '                                        If IsArrayValuePresent(marrRowLink, intCount) Then
            '                                            sb.Append("<A href=" + Chr(34) + "JavaScript:")

            '                                            arr = Split(GetFunctionAndParameters(marrRowLink(intCount), strFunctionName), ",")
            '                                            intItemCount = UBound(arr)
            '                                            strParameters = ""
            '                                            For intLoopCtr = 0 To intItemCount
            '                                                If Left(arr(intLoopCtr), 2) = "{}" Or Left(arr(intLoopCtr), 3) = "'{}" Then
            '                                                    strParameters += "," + Replace(arr(intLoopCtr), "{}", "")
            '                                                ElseIf arr(intLoopCtr).Trim <> "" Then
            '                                                    strParameters += "," + "'" + Replace(dr(Replace(arr(intLoopCtr), "'", "")).ToString.Trim, "'", "|||") + "'"
            '                                                End If
            '                                            Next
            '                                            ' remove the first comma ","
            '                                            If Left(strParameters, 1) = "," Then
            '                                                strParameters = Right(strParameters, Len(strParameters) - 1)
            '                                            End If

            '                                            ' function_Name(param1,param2,...)
            '                                            sb.Append(strFunctionName + "(" + strParameters + ")" + Chr(34))

            '                                            If IsArrayValuePresent(marrRowLinkToolTip, intCount) Then
            '                                                sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrRowLinkToolTip(intCount)) + Chr(34))
            '                                            End If
            '                                            sb.Append(">")
            '                                        End If
            '                                    End If

            '                                    If blnPrintColumn Then
            '                                        If Not IsArrayValuePresent(marrReplacementValue, intCount) Then
            '                                            If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                                Select Case dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper
            '                                                    Case "FLOAT", "REAL"
            '                                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                                            sb.Append(FormatNumber(dr(marrActualColumn(intCount)), 2))
            '                                                        Else
            '                                                            sb.Append("0.00")
            '                                                        End If
            '                                                    Case "INT"
            '                                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                                            sb.Append(FormatNumber(dr(marrActualColumn(intCount)), 0))
            '                                                        Else
            '                                                            sb.Append("0")
            '                                                        End If
            '                                                    Case "BIT"
            '                                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                                            If CType(dr(marrActualColumn(intCount)), Boolean) = True Then
            '                                                                sb.Append(mstrBooleanTrueHTML)
            '                                                            Else
            '                                                                sb.Append(mstrBooleanFalseHTML)
            '                                                            End If
            '                                                        Else
            '                                                            sb.Append(mstrBooleanFalseHTML)
            '                                                        End If
            '                                                    Case "DATETIME"
            '                                                        ' date time get the date time
            '                                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                                            sb.Append(CommonFunctions.Dates.CGetDate(CType(dr(marrActualColumn(intCount)), Date)))
            '                                                        Else
            '                                                            sb.Append(mstrEmptyValueReplacement)
            '                                                        End If
            '                                                    Case Else
            '                                                        ' normal text
            '                                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                                            If blnApplyHTMLEncode Then
            '                                                                sb.Append(HttpContext.Current.Server.HtmlEncode(dr(marrActualColumn(intCount)).ToString))
            '                                                            Else
            '                                                                sb.Append(dr(marrActualColumn(intCount)).ToString)
            '                                                            End If
            '                                                        Else
            '                                                            sb.Append(mstrEmptyValueReplacement)
            '                                                        End If
            '                                                End Select

            '                                                ' summary functions!!!
            '                                                If IsArrayValuePresent(marrSummaryFunctions, intCount) Then
            '                                                    If Trim(marrSummaryFunctions(intCount) & "") <> "" Then
            '                                                        Try
            '                                                            arrSummaryFuncValue(intCount) += CType(CommonFunctions.Data.CheckIsDBNull(dr(marrActualColumn(intCount)), "0"), Double)
            '                                                        Catch
            '                                                            arrSummaryFuncValue(intCount) += 0
            '                                                        End Try
            '                                                    End If
            '                                                End If
            '                                            Else
            '                                                Select Case dr.GetDataTypeName(intCount).Trim.ToUpper
            '                                                    Case "FLOAT", "REAL"
            '                                                        If Not IsDBNull(dr(intCount)) Then
            '                                                            sb.Append(FormatNumber(dr(intCount), 2))
            '                                                        Else
            '                                                            sb.Append("0.00")
            '                                                        End If

            '                                                    Case "INT"
            '                                                        If Not IsDBNull(dr(intCount)) Then
            '                                                            sb.Append(FormatNumber(dr(intCount), 0))
            '                                                        Else
            '                                                            sb.Append("0")
            '                                                        End If
            '                                                    Case "BIT"
            '                                                        If Not IsDBNull(dr(intCount)) Then
            '                                                            If CType(dr(intCount), Boolean) = True Then
            '                                                                sb.Append(mstrBooleanTrueHTML)
            '                                                            Else
            '                                                                sb.Append(mstrBooleanFalseHTML)
            '                                                            End If
            '                                                        Else
            '                                                            sb.Append(mstrBooleanFalseHTML)
            '                                                        End If
            '                                                    Case "DATETIME"
            '                                                        ' date time get the date time
            '                                                        If Not IsDBNull(dr(intCount)) Then
            '                                                            sb.Append(CommonFunctions.Dates.CGetDate(CType(dr(intCount), Date)))
            '                                                        Else
            '                                                            sb.Append(mstrEmptyValueReplacement)
            '                                                        End If
            '                                                    Case Else
            '                                                        ' normal text
            '                                                        If Not IsDBNull(dr(intCount)) Then
            '                                                            If blnApplyHTMLEncode Then
            '                                                                sb.Append(HttpContext.Current.Server.HtmlEncode(dr(intCount).ToString))
            '                                                            Else
            '                                                                sb.Append(dr(intCount).ToString)
            '                                                            End If
            '                                                        Else
            '                                                            sb.Append(mstrEmptyValueReplacement)
            '                                                        End If
            '                                                End Select

            '                                                ' summary functions!!!
            '                                                If IsArrayValuePresent(marrSummaryFunctions, intCount) Then
            '                                                    If Trim(marrSummaryFunctions(intCount) & "") <> "" Then
            '                                                        Try
            '                                                            arrSummaryFuncValue(intCount) += CType(CommonFunctions.Data.CheckIsDBNull(dr(intCount), "0"), Double)
            '                                                        Catch
            '                                                            arrSummaryFuncValue(intCount) += 0
            '                                                        End Try
            '                                                    End If
            '                                                End If
            '                                            End If
            '                                        Else
            '                                            sb.Append(HttpContext.Current.Server.HtmlEncode(marrReplacementValue(intCount).ToString))
            '                                        End If
            '                                    End If
            '                                    If blnEnableLink Then
            '                                        If IsArrayValuePresent(marrRowLink, intCount) Then
            '                                            sb.Append("</A>")
            '                                        End If
            '                                    End If
            '                                Else
            '                                    ' end of group
            '                                    If intCount > 0 Then
            '                                        If arrColumnGroupNumber(intCount) <> arrColumnGroupNumber(intCount - 1) Then
            '                                            sb.Append("</TD>")
            '                                            sb.Append("<TD> ")
            '                                        End If
            '                                    Else
            '                                        sb.Append("<TD> ")
            '                                    End If
            '                                End If
            '                            Else
            '                                If arrColumnGroupExpanded(intCount) = True Then
            '                                    If IsArrayValuePresent(marrCheckBoxID, intCount) Then

            '                                        sb.Append("<TD align=center >" + vbCrLf)
            '                                        ' value of the check box MUST be the Primary Key!!
            '                                        If mstrPrimaryKey.Trim <> "" Then
            '                                            strValue = dr(mstrPrimaryKey).ToString
            '                                        End If

            '                                        blnDisabled = False
            '                                        blnChecked = False
            '                                        ' if data bound (check the checkbox based on data value)
            '                                        If IsArrayValuePresent(marrCheckboxCheckOnColumn, intCount) Then
            '                                            If Not IsDBNull(dr(marrCheckboxCheckOnColumn(intCount))) Then
            '                                                If CType(dr(marrCheckboxCheckOnColumn(intCount)), Boolean) Then
            '                                                    blnChecked = True
            '                                                End If
            '                                            End If
            '                                        End If
            '                                        If IsArrayValuePresent(marrCheckboxDisableOnColumn, intCount) Then
            '                                            If Not IsDBNull(dr(marrCheckboxDisableOnColumn(intCount))) Then
            '                                                If CType(dr(marrCheckboxDisableOnColumn(intCount)), Boolean) Then
            '                                                    blnDisabled = True
            '                                                End If
            '                                            End If
            '                                        End If
            '                                        sb.Append(CommonFunctions.HTMLControls.DrawCheckBox(marrCheckBoxID(intCount), marrCheckBoxID(intCount), , blnChecked, strValue, blnDisabled, , True))
            '                                    Else
            '                                        sb.Append("<TD align=left >" + vbCrLf)
            '                                        If IsArrayValuePresent(marrRowLink, intCount) Then
            '                                            sb.Append("<A href=" + Chr(34) + "JavaScript:")

            '                                            ' split the parameters
            '                                            arr = Split(GetFunctionAndParameters(marrRowLink(intCount), strFunctionName), ",")
            '                                            ' the item count
            '                                            intItemCount = UBound(arr)
            '                                            ' build the parameter string
            '                                            strParameters = ""
            '                                            For intLoopCtr = 0 To intItemCount
            '                                                If Left(arr(intLoopCtr), 2) = "{}" Or Left(arr(intLoopCtr), 3) = "'{}" Then
            '                                                    If InStr(arr(intLoopCtr), "<", CompareMethod.Binary) > 0 And InStr(arr(intLoopCtr), ">", CompareMethod.Binary) > 0 Then
            '                                                        ' there are place holders which are to be replaced with data values
            '                                                        ' build the url
            '                                                        strURL = ""
            '                                                        arrQueryString = Split(arr(intLoopCtr), "<", -1, CompareMethod.Binary)
            '                                                        intUBound1 = UBound(arrQueryString)
            '                                                        For intCount2 = 0 To intUBound1
            '                                                            arrPlaceHolder = Split(arrQueryString(intCount2), ">")
            '                                                            intUBound2 = UBound(arrPlaceHolder)
            '                                                            If intUBound2 >= 0 Then
            '                                                                For intCount3 = 0 To intUBound2
            '                                                                    Try
            '                                                                        strURL += Replace(dr(arrPlaceHolder(intCount3)).ToString, "'", "|||")
            '                                                                    Catch
            '                                                                        strURL += Replace(arrPlaceHolder(intCount3), "'", "|||")
            '                                                                    End Try
            '                                                                Next
            '                                                            Else
            '                                                                strURL += Replace(arrQueryString(intCount2), "'", "|||")
            '                                                            End If

            '                                                        Next
            '                                                        strParameters += ",'" + Replace(strURL, "{}", "") + "'"
            '                                                    Else
            '                                                        ' pass the parameter as it is (just replace the {} prefix)
            '                                                        strParameters += "," + HttpContext.Current.Server.UrlEncode(Replace(arr(intLoopCtr), "{}", ""))
            '                                                    End If

            '                                                ElseIf arr(intLoopCtr).Trim <> "" Then
            '                                                    ' get the database value for the parameter
            '                                                    strParameters += "," + "'" + HttpContext.Current.Server.UrlEncode(Replace(dr(Replace(arr(intLoopCtr), "'", "")).ToString, "'", "|||")) + "'"
            '                                                End If
            '                                            Next

            '                                            If Left(strParameters, 1) = "," Then
            '                                                strParameters = Right(strParameters, Len(strParameters) - 1)
            '                                            End If
            '                                            sb.Append(strFunctionName + "(" + strParameters + ")" + Chr(34))

            '                                            If IsArrayValuePresent(marrRowLinkToolTip, intCount) Then
            '                                                sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrRowLinkToolTip(intCount)) + Chr(34))
            '                                            End If
            '                                            sb.Append(">")

            '                                            If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                                If blnApplyHTMLEncode Then
            '                                                    sb.Append(HttpContext.Current.Server.HtmlEncode(marrActualColumn(intCount)))
            '                                                Else
            '                                                    sb.Append(marrActualColumn(intCount))
            '                                                End If
            '                                            End If
            '                                            sb.Append("</A>")
            '                                        Else
            '                                            If blnApplyHTMLEncode Then
            '                                                sb.Append(HttpContext.Current.Server.HtmlEncode(marrActualColumn(intCount)))
            '                                            Else
            '                                                sb.Append(marrActualColumn(intCount))
            '                                            End If

            '                                        End If
            '                                    End If
            '                                Else
            '                                    ' end of group
            '                                    If intCount > 0 Then
            '                                        If arrColumnGroupNumber(intCount) <> arrColumnGroupNumber(intCount - 1) Then
            '                                            sb.Append("</TD>")
            '                                            sb.Append("<TD> ")
            '                                        End If
            '                                    Else
            '                                        sb.Append("<TD> ")
            '                                    End If
            '                                End If
            '                            End If

            '                            If blnIsGroupingPresent Then
            '                                If blnPrintColumn Then
            '                                    If mintNoOfRows Mod 2 = 0 Then
            '                                        sb.Append("</td></tr><TR class='" + MyBase.clsTROdd.Trim + "'><TD></TD>" + vbCrLf)
            '                                    Else
            '                                        sb.Append("</td></tr><TR class='" + MyBase.clsTREven.Trim + "'><TD></TD>" + vbCrLf)
            '                                    End If
            '                                Else
            '                                    sb.Append("</td>" + vbCrLf)
            '                                End If
            '                            Else
            '                                sb.Append("</td>" + vbCrLf)
            '                            End If


            '                        Next intCount

            '                        sb.Append("</TR>" + vbCrLf)
            '                        sb.Append(mstrHorizontalSeparatorHTML)

            '                    End If

            '                    ' increment the row total ( this will be used by GET property "NoOfRows")
            '                    mintNoOfRows += 1
            '                Loop
            '                dr = Nothing

            '                If mblnShowSummaryFunctions Then
            '                    If blnAreColumnGroupsPresent Then
            '                        ' print the column groups in the first row
            '                        sb.Append("<TR class='" + mstrSummaryFunctionTRStyle + "'>" + vbCrLf)
            '                        ' now check the array having column group definition and print col group headers
            '                        For intCount2 = 0 To intColumnGroupCount
            '                            Dim arrColGroups() As String
            '                            Dim intColSpan As Integer
            '                            If IsArrayValuePresent(marrColumnGroupColumns, intCount2) Then
            '                                arrColGroups = Split(marrColumnGroupColumns(intCount2), "-")
            '                                Try
            '                                    intColumnGroupStart = CType(arrColGroups(LBound(arrColGroups)), Integer)
            '                                    intColumnGroupEnd = CType(arrColGroups(UBound(arrColGroups)), Integer)
            '                                    intColSpan = intColumnGroupEnd - intColumnGroupStart

            '                                    If IsArrayValuePresent(marrColumnGroupExpanded, intCount2) Then
            '                                        If Trim(marrColumnGroupExpanded(intCount2) & "") = "1" Then
            '                                            'sb.Append("<TD align=center>")
            '                                            For intCount = intColumnGroupStart - 1 To intColumnGroupEnd - 1
            '                                                arrColumnGroupExpanded(intCount - 1) = False
            '                                                arrColumnGroupNumber(intCount - 1) = intCount2
            '                                                If IsArrayValuePresent(marrSummaryFunctions, intCount) Then
            '                                                    Select Case marrSummaryFunctions(intCount).Trim.ToUpper
            '                                                        Case "SUM"
            '                                                            sb.Append("<TD align=right><B>" & FormatNumber(arrSummaryFuncValue(intCount), 2) & "</B></TD>")
            '                                                        Case "AVG"
            '                                                            If mintNoOfRows > 0 Then
            '                                                                sb.Append("<TD align=right><B>" & FormatNumber(arrSummaryFuncValue(intCount) / mintNoOfRows, 2) & "</B></TD>")
            '                                                            Else
            '                                                                sb.Append("<TD align=right><B>00.00</B></TD>")
            '                                                            End If
            '                                                        Case Else
            '                                                            sb.Append("<TD align=right></TD>")
            '                                                    End Select
            '                                                Else
            '                                                    sb.Append("<TD align=right></TD>")
            '                                                End If
            '                                            Next
            '                                            blnIsColumnGroupExpanded = False
            '                                        Else
            '                                            sb.Append("<TD align=right colspan=" & intColSpan + 1 & "></TD>")
            '                                        End If
            '                                    End If
            '                                    'sb.Append("</TD>")
            '                                Catch
            '                                    sb.Append("<TD  align=center></TD>")
            '                                End Try
            '                            Else
            '                                sb.Append("<TD  align=center></TD>")
            '                            End If
            '                        Next
            '                        sb.Append("</TR>")
            '                    Else
            '                        ' no column groups are present.. all columns are expanded
            '                        sb.Append("<TR class=" + mstrSummaryFunctionTRStyle + ">")
            '                        For intCount = 0 To intUpperBound
            '                            If IsArrayValuePresent(marrSummaryFunctions, intCount) Then
            '                                Select Case marrSummaryFunctions(intCount).Trim.ToUpper
            '                                    Case "SUM"
            '                                        sb.Append("<TD align=right><B>" & FormatNumber(arrSummaryFuncValue(intCount), 2) & "</B></TD>")
            '                                    Case "AVG"
            '                                        If mintNoOfRows > 0 Then
            '                                            sb.Append("<TD align=right><B>" & FormatNumber(arrSummaryFuncValue(intCount) / mintNoOfRows, 2) & "</B></TD>")
            '                                        Else
            '                                            sb.Append("<TD align=right><B>00.00</B></TD>")
            '                                        End If
            '                                    Case Else
            '                                        sb.Append("<TD align=right></TD>")
            '                                End Select
            '                            Else
            '                                sb.Append("<TD align=right></TD>")
            '                            End If
            '                        Next
            '                        sb.Append("</TR>")
            '                    End If
            '                End If

            '                If mintNoOfRows = 0 Then
            '                    ' no data present
            '                    sb.Append("<TR class=" + MyBase.clsTREven + "><TD align=center colspan=" + (intUpperBound + 1).ToString + ">" + mstrNoDataComment + "</TD></TR>" + vbCrLf)
            '                End If

            '                sb.Append("</TABLE>" + vbCrLf)
            '                If Not mblnPrinterFriendlyVersion And mintDIVHeight > 0 Then
            '                    ' DIV end
            '                    sb.Append("</div>" + vbCrLf)
            '                End If

            '                ' grid footer
            '                sb.Append(mstrFooterHTML)

            '                If returnHTML Then
            '                    ' return the HTML string
            '                    Return sb.ToString
            '                Else
            '                    ' write the response
            '                    HttpContext.Current.Response.Write(sb.ToString)
            '                End If
            '            End Function
            '            Private Function DrawVerticalGrid(ByVal returnHTML As Boolean) As String
            '                '=====================================================================
            '                ' Procedure Name        : DrawVerticalGrid()
            '                ' Description           : draws the grid vertically for the SQL using properties
            '                ' Purpose               : draws the grid vertically for the SQL using properties
            '                ' Parameters Passed     : None
            '                ' Returns               : string
            '                ' Parameters Affected   : 
            '                ' Assumptions           : 
            '                ' Dependencies          : module variables
            '                ' Author                : Rajanikant
            '                ' Created               : Jan 22,2004
            '                ' Revisions             :
            '                '=====================================================================
            '                Dim intCount As Integer
            '                Dim intUpperBound As Integer
            '                Dim dr As IDataReader
            '                Dim blnPrinted As Boolean = False
            '                Dim sb As System.Text.StringBuilder
            '                Dim arr() As String
            '                Dim intItemCount As Integer
            '                Dim intLoopCtr As Integer
            '                Dim strFunctionName As String
            '                Dim strParameters As String
            '                Dim blnChecked As Boolean = False
            '                Dim strValue As String = ""

            '                ' total number of columns to be displayed
            '                intUpperBound = UBound(marrUserFriendlyColumn)
            '                sb = New System.Text.StringBuilder
            '                ' grid header
            '                sb.Append(mstrHeaderHTML)
            '                ' do not show the DIV for printer friendly version
            '                If Not mblnPrinterFriendlyVersion Then
            '                    ' DIV start
            '                    If mstrDIVID.Trim = "" Then
            '                        mstrDIVID = "DivList"
            '                    End If
            '                    sb.Append("<DIV id=" + mstrDIVID + " style='" + mstrDIVStyle + ";Height:" + mintDIVHeight.ToString + "' >" + vbCrLf)
            '                End If
            '                ' table start
            '                sb.Append("<TABLE class='" + MyBase.clsTable + "' " + MyBase.TableStyle + " width='100%'>" + vbCrLf)
            '                ' grid content
            '                dr = CommonFunctions.Data.GetDataReader(mstrSQL, mblnUseSQL)
            '                Do While dr.Read()
            '                    ' columns are written for each row
            '                    For intCount = 0 To intUpperBound
            '                        If mintNoOfRows Mod 2 = 0 Then
            '                            sb.Append("<TR class='" + MyBase.clsTROdd.Trim + "'>" + vbCrLf)
            '                        Else
            '                            sb.Append("<TR class='" + MyBase.clsTREven.Trim + "'>" + vbCrLf)
            '                        End If
            '                        sb.Append("<TD align=right><B>" + vbCrLf)
            '                        sb.Append(CommonFunctions.General.FormatString(marrUserFriendlyColumn(intCount)))
            '                        sb.Append("</B></TD>" + vbCrLf)

            '                        If intCount < mintNoOfDataColumns Then

            '                            sb.Append("<TD  vAlign=top " + vbCrLf)

            '                            If mblnColNameToolTipOnEachRow Then
            '                                sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrUserFriendlyColumn(intCount)) + Chr(34))
            '                            End If
            '                            sb.Append(" align=right>" + vbCrLf)
            '                            If IsArrayValuePresent(marrRowLink, intCount) Then
            '                                sb.Append("<A href=" + Chr(34) + "JavaScript:")


            '                                arr = Split(GetFunctionAndParameters(marrRowLink(intCount), strFunctionName), ",")
            '                                intItemCount = UBound(arr)
            '                                strParameters = ""
            '                                For intLoopCtr = 0 To intItemCount
            '                                    If Left(arr(intLoopCtr), 2) = "{}" Or Left(arr(intLoopCtr), 3) = "'{}" Then
            '                                        strParameters += "," + Replace(arr(intLoopCtr), "{}", "")
            '                                    ElseIf arr(intLoopCtr).Trim <> "" Then
            '                                        strParameters += "," + "'" + dr(Replace(arr(intLoopCtr), "'", "")).ToString.Trim + "'"
            '                                    End If
            '                                Next

            '                                If Left(strParameters, 1) = "," Then
            '                                    strParameters = Right(strParameters, Len(strParameters) - 1)
            '                                End If
            '                                sb.Append(strFunctionName + "(" + strParameters + ")" + Chr(34))

            '                                If IsArrayValuePresent(marrRowLinkToolTip, intCount) Then
            '                                    sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrRowLinkToolTip(intCount)) + Chr(34))
            '                                End If
            '                                sb.Append(">")
            '                            End If
            '                            If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                Select Case dr.GetDataTypeName(dr.GetOrdinal(marrActualColumn(intCount))).Trim.ToUpper
            '                                    Case "FLOAT"
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            sb.Append(FormatNumber(dr(marrActualColumn(intCount)), 2))
            '                                        Else
            '                                            sb.Append("0.00")
            '                                        End If

            '                                    Case "INT"
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            sb.Append(FormatNumber(dr(marrActualColumn(intCount)), 0))
            '                                        Else
            '                                            sb.Append("0")
            '                                        End If
            '                                    Case "BIT"
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            If CType(dr(marrActualColumn(intCount)), Boolean) = True Then
            '                                                sb.Append(mstrBooleanTrueHTML)
            '                                            Else
            '                                                sb.Append(mstrBooleanFalseHTML)
            '                                            End If
            '                                        Else
            '                                            sb.Append(mstrBooleanFalseHTML)
            '                                        End If
            '                                    Case "DATETIME"
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            sb.Append(CommonFunctions.Dates.CGetDate(CType(dr(marrActualColumn(intCount)), Date)))
            '                                        Else
            '                                            sb.Append(mstrEmptyValueReplacement)
            '                                        End If
            '                                    Case Else
            '                                        ' normal text
            '                                        If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                            sb.Append(HttpContext.Current.Server.HtmlEncode(dr(marrActualColumn(intCount)).ToString))
            '                                        Else
            '                                            sb.Append(mstrEmptyValueReplacement)
            '                                        End If

            '                                End Select
            '                            Else
            '                                Select Case dr.GetDataTypeName(intCount).Trim.ToUpper
            '                                    Case "FLOAT"
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            sb.Append(FormatNumber(dr(intCount), 2))
            '                                        Else
            '                                            sb.Append("0.00")
            '                                        End If

            '                                    Case "INT"
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            sb.Append(FormatNumber(dr(intCount), 0))
            '                                        Else
            '                                            sb.Append("0")
            '                                        End If
            '                                    Case "BIT"
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            If CType(dr(intCount), Boolean) = True Then
            '                                                sb.Append(mstrBooleanTrueHTML)
            '                                            Else
            '                                                sb.Append(mstrBooleanFalseHTML)
            '                                            End If
            '                                        Else
            '                                            sb.Append(mstrBooleanFalseHTML)
            '                                        End If
            '                                    Case "DATETIME"
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            sb.Append(CommonFunctions.Dates.CGetDate(CType(dr(intCount), Date)))
            '                                        Else
            '                                            sb.Append(mstrEmptyValueReplacement)
            '                                        End If
            '                                    Case Else
            '                                        ' normal text
            '                                        If Not IsDBNull(dr(intCount)) Then
            '                                            sb.Append(HttpContext.Current.Server.HtmlEncode(dr(intCount).ToString))
            '                                        Else
            '                                            sb.Append(mstrEmptyValueReplacement)
            '                                        End If

            '                                End Select
            '                            End If
            '                            sb.Append("</A>")
            '                        Else

            '                            sb.Append("<TD vAlign=top align=left >" + vbCrLf)
            '                            If IsArrayValuePresent(marrCheckBoxID, intCount) Then
            '                                ' check box has to be inserted here

            '                                ' value of the check box MUST be the Primary Key!!
            '                                If mstrPrimaryKey.Trim <> "" Then
            '                                    strValue = dr(mstrPrimaryKey).ToString
            '                                End If
            '                                ' if data bound (check the checkbox based on data value)
            '                                If Not marrActualColumn(intCount) Is Nothing Then
            '                                    If marrActualColumn(intCount).Trim <> "" Then
            '                                        If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                            If Not IsDBNull(dr(marrActualColumn(intCount))) Then
            '                                                If CType(dr(marrActualColumn(intCount)), Boolean) Then
            '                                                    blnChecked = True
            '                                                End If
            '                                            End If
            '                                        Else
            '                                            If Not IsDBNull(dr(intCount)) Then
            '                                                If CType(dr(intCount), Boolean) Then
            '                                                    blnChecked = True
            '                                                End If
            '                                            End If
            '                                        End If
            '                                    End If
            '                                End If
            '                                sb.Append(CommonFunctions.HTMLControls.DrawCheckBox(marrCheckBoxID(intCount), marrCheckBoxID(intCount), , blnChecked, strValue, , , True))
            '                            Else
            '                                If IsArrayValuePresent(marrRowLink, intCount) Then
            '                                    sb.Append("<A href=" + Chr(34) + "JavaScript:")

            '                                    arr = Split(GetFunctionAndParameters(marrRowLink(intCount), strFunctionName), ",")
            '                                    intItemCount = UBound(arr)
            '                                    strParameters = ""
            '                                    For intLoopCtr = 0 To intItemCount
            '                                        If Left(arr(intLoopCtr), 2) = "{}" Or Left(arr(intLoopCtr), 3) = "'{}" Then
            '                                            strParameters += "," + Replace(arr(intLoopCtr), "{}", "")
            '                                        ElseIf arr(intLoopCtr).Trim <> "" Then
            '                                            strParameters += "," + "'" + dr(Replace(arr(intLoopCtr), "'", "")).ToString.Trim + "'"
            '                                        End If
            '                                    Next

            '                                    If Left(strParameters, 1) = "," Then
            '                                        strParameters = Right(strParameters, Len(strParameters) - 1)
            '                                    End If
            '                                    sb.Append(strFunctionName + "(" + strParameters + ")" + Chr(34))

            '                                    If IsArrayValuePresent(marrRowLinkToolTip, intCount) Then
            '                                        sb.Append(" title=" + Chr(34) + CommonFunctions.General.FormatString(marrRowLinkToolTip(intCount)) + Chr(34))
            '                                    End If
            '                                    sb.Append(">")
            '                                    If IsArrayValuePresent(marrActualColumn, intCount) Then
            '                                        sb.Append(marrActualColumn(intCount))
            '                                    End If
            '                                    sb.Append("</A>")
            '                                End If
            '                            End If
            '                        End If
            '                        sb.Append("</td>" + vbCrLf)

            '                        sb.Append("</TR>" + vbCrLf)

            '                    Next intCount

            '                    sb.Append(mstrHorizontalSeparatorHTML)
            '                    ' increment the row total ( this will be used by GET property "NoOfRows")
            '                    mintNoOfRows += 1
            '                Loop
            '                dr.Close()

            '                If mintNoOfRows = 0 Then
            '                    ' no data present
            '                    sb.Append("<TR class=clsTROdd><TD align=center colspan=2>" + mstrNoDataComment + "</TD></TR>" + vbCrLf)
            '                End If

            '                sb.Append("</TABLE>" + vbCrLf)

            '                If Not mblnPrinterFriendlyVersion Then
            '                    ' DIV end
            '                    sb.Append("</div>" + vbCrLf)
            '                End If

            '                ' grid footer
            '                sb.Append(mstrFooterHTML)

            '                If returnHTML Then
            '                    Return sb.ToString
            '                Else
            '                    HttpContext.Current.Response.Write(sb.ToString)
            '                End If

            '            End Function
            '            Private Function IsArrayValuePresent(ByVal arr As String(), ByVal intPos As Integer) As Boolean
            '                '=====================================================================
            '                ' Procedure Name        : IsArrayValuePresent()
            '                ' Purpose               : checks for the value at the position for the array
            '                ' Description           : same as above
            '                ' Parameters Passed     : ByVal arr As String(), ByVal intPos As Integer
            '                ' Returns               : true/false
            '                ' Parameters Affected   : 
            '                ' Assumptions           : 
            '                ' Dependencies          : none
            '                ' Author                : Rajanikant
            '                ' Created               : Jan 22,2004
            '                ' Revisions             :
            '                '=====================================================================
            '                Dim intUBound As Integer

            '                ' no such array?
            '                If arr Is Nothing Then Return False

            '                ' current position wants a lookup on array size greater than the size?
            '                intUBound = UBound(arr)
            '                If intUBound < intPos Then Return False

            '                ' check for value
            '                If Not arr(intPos) Is Nothing Then
            '                    If arr(intPos).Trim <> "" Then
            '                        Return True
            '                    Else
            '                        Return False
            '                    End If
            '                Else
            '                    Return False
            '                End If

            '            End Function
            '            Private Function GetFunctionAndParameters(ByVal strFunctionWithParamters As String, ByRef strFunctionName As String) As String
            '                '=====================================================================
            '                ' Procedure Name        : GetFunctionAndParameters()
            '                ' Purpose               : to get the function & parameters
            '                ' Description           : splits the string which should be in
            '                '                         function_name('param1','{}param2',...) format
            '                '                         to get the function name and string of comma separated
            '                '                         parameters
            '                ' Parameters Passed     : Byval strFunctionWithParamters | function_name('param1','{}param2',...) format
            '                '                         ByRef strFunctionName | function_name is set 
            '                ' Returns               : string of parameters sans the brackets and function name
            '                ' Parameters Affected   : strFunction Name
            '                ' Assumptions           : 
            '                ' Dependencies          : 
            '                ' Author                : Rajanikant
            '                ' Created               : Jan 22,2004
            '                ' Revisions             :
            '                '=====================================================================
            '                Dim arr() As String
            '                Dim strTemp As String

            '                ' split the string function_name('param1','{}param2',...) format on char "(" 
            '                arr = Split(strFunctionWithParamters, "(")
            '                If UBound(arr) > 0 Then
            '                    ' the function_name
            '                    strFunctionName = arr(0)
            '                    ' the param list with ")"
            '                    strTemp = arr(1).Trim
            '                End If

            '                ' remove the trailing ")" bracket
            '                If Right(strTemp, 1) = ")" Then
            '                    strTemp = Left(strTemp, Len(strTemp) - 1)
            '                End If

            '                ' return the string
            '                Return strTemp

            '            End Function
            '#End Region
        End Class

    End Namespace

    Namespace Filters
        Public Class cRoleLevelAccessFilter
            Inherits WebPages.Filters.cRoleLevelAccessFilter
            '            Inherits WebPage.Templates.Global
            '            Private m_strAccessParameter As String
            '            Private m_blnShowReleasedProjects As Boolean = True
            '            Private m_blnUseSQL As Boolean

            '            Public Property AccessParameter() As String
            '                Get
            '                    AccessParameter = m_strAccessParameter
            '                End Get
            '                Set(ByVal Value As String)
            '                    m_strAccessParameter = Value
            '                End Set
            '            End Property

            '            Public Property ShowReleasedProjects() As Boolean
            '                Get
            '                    ShowReleasedProjects = m_blnShowReleasedProjects
            '                End Get
            '                Set(ByVal Value As Boolean)
            '                    m_blnShowReleasedProjects = Value
            '                End Set
            '            End Property

            '            Public Property UseSQL() As Boolean
            '                Get
            '                    UseSQL = m_blnUseSQL
            '                End Get
            '                Set(ByVal Value As Boolean)
            '                    m_blnUseSQL = Value
            '                End Set
            '            End Property

            Sub New(ByVal UserName As String, ByVal RoleID As Long, ByVal UserID As Long, _
                    ByVal LoginType As String, ByVal LoginID As Long, ByVal RoleLevel As Integer, Optional ByVal IsCustomerCreated As Boolean = False)
                ' Parameterized COnstructor
                MyBase.New(UserName, RoleID, UserID, LoginType, LoginID, RoleLevel, IsCustomerCreated)
                'MyBase.UserName = UserName
                'MyBase.RoleID = RoleID
                'MyBase.UserID = UserID
                'MyBase.LoginID = LoginID
                'MyBase.LoginType = LoginType
                'MyBase.RoleLevel = RoleLevel
                'MyBase.IsCustomerCreated = IsCustomerCreated
            End Sub

            '            Public Function GetRoleLevelAccessFilter() As String
            '                '=====================================================================
            '                ' Procedure Name        : GetRoleLevelAccessFilter()
            '                ' Description           : This PUBLIC method builds the filter string
            '                '                         for the user to be applied based on role level
            '                ' Purpose               : Same as above
            '                ' Parameters Passed     : None
            '                ' Returns               : Role Level access filter string 
            '                ' Parameters Affected   : None
            '                ' Assumptions           : 
            '                ' Dependencies          : usp_QRB_RoleLevelAccessFilter, GetFilter()
            '                ' Author                : Rajanikant
            '                ' Created               : Saturday September 06,2003
            '                ' Revisions             :
            '                '=====================================================================
            '                Dim sbFilter As System.Text.StringBuilder
            '                Dim strReportingEmployees As String
            '                Dim arr() As String
            '                Dim arrUserLevel() As String
            '                Dim intUpperBound As Integer
            '                Dim intLoopCtr As Integer
            '                Dim strLevel As String
            '                Dim strUserID As String
            '                Dim blnItemPresent As Boolean = False
            '                Dim strFilter As String

            '                ' login type is must for role access
            '                If MyBase.LoginType Is Nothing Then
            '                    GoTo exit_routine
            '                Else
            '                    ' Role level is must for Login Type "E"
            '                    If MyBase.LoginType.ToString.Trim.ToUpper = "E" And MyBase.RoleLevel = 0 Then
            '                        GoTo exit_routine
            '                    End If
            '                End If

            '                ' the access parameter is required for getting specific accessible Ids
            '                If m_strAccessParameter.Trim = "" Then GoTo exit_routine

            '                If MyBase.LoginType.Trim.ToUpper = "C" Then
            '                    ' Customer Logins
            '                    If MyBase.IsCustomerCreated Then
            '                        strFilter = GetFilter(MyBase.UserID, "C", 0, m_strAccessParameter, m_blnShowReleasedProjects, MyBase.LoginID).Trim
            '                    Else
            '                        strFilter = GetFilter(MyBase.UserID, "C", 0, m_strAccessParameter, m_blnShowReleasedProjects).Trim
            '                    End If

            '                    If strFilter <> "" Then
            '                        GetRoleLevelAccessFilter = m_strAccessParameter + " IN (" + strFilter + ")"
            '                    Else
            '                        GetRoleLevelAccessFilter = m_strAccessParameter + " IN ('0')"
            '                    End If
            '                Else
            '                    ' Employee Logins
            '                    Select Case MyBase.RoleLevel
            '                        Case 1 ' High level
            '                            ' no filters are needed for this level
            '                            GetRoleLevelAccessFilter = ""

            '                        Case 2 ' middle level
            '                            ' first of all we get all employees who report to the current user
            '                            strReportingEmployees = MyBase.UserID.ToString + "|" + MyBase.RoleLevel.ToString + GetAllReportingEmployees(MyBase.UserID, MyBase.RoleLevel)

            '                            ' now for each employee we find the accessible values
            '                            sbFilter = New System.Text.StringBuilder("")
            '                            sbFilter.Append(m_strAccessParameter)
            '                            sbFilter.Append(" IN(")

            '                            If strReportingEmployees.Trim <> "" Then
            '                                ' remove the last comma appended to the string
            '                                If Right(strReportingEmployees.Trim, 1) = "," Then strReportingEmployees = Left(strReportingEmployees, Len(strReportingEmployees) - 1)

            '                                ' get the employees and their levels
            '                                arr = Split(strReportingEmployees, ",")
            '                                intUpperBound = UBound(arr)

            '                                For intLoopCtr = 0 To intUpperBound
            '                                    ' get the user id & the role level ( value is in format <userid>|<level> ex:191|2)
            '                                    arrUserLevel = Split(arr(intLoopCtr), "|")
            '                                    strUserID = arrUserLevel(LBound(arrUserLevel))
            '                                    strLevel = arrUserLevel(UBound(arrUserLevel))
            '                                    ' get the filters for the user
            '                                    strFilter = GetFilter(CType(strUserID, Long), "E", CType(strLevel, Integer), m_strAccessParameter, m_blnShowReleasedProjects)
            '                                    If strFilter.Trim <> "" Then
            '                                        blnItemPresent = True
            '                                    End If
            '                                    sbFilter.Append(strFilter.Trim)
            '                                Next intLoopCtr

            '                                If blnItemPresent Then
            '                                    sbFilter.Append(")")
            '                                Else
            '                                    sbFilter.Append("'0')")
            '                                End If
            '                            Else
            '                                sbFilter.Append("'0')")
            '                            End If
            '                            ' return the access string
            '                            GetRoleLevelAccessFilter = sbFilter.ToString

            '                        Case 3 ' low level
            '                            ' return the access string
            '                            strFilter = GetFilter(MyBase.UserID, "E", MyBase.RoleLevel, m_strAccessParameter, m_blnShowReleasedProjects).Trim
            '                            If strFilter <> "" Then
            '                                GetRoleLevelAccessFilter = m_strAccessParameter + " IN (" + strFilter + ")"
            '                            Else
            '                                GetRoleLevelAccessFilter = m_strAccessParameter + " IN ('0')"
            '                            End If
            '                    End Select
            '                End If

            '                ' clean up
            '                sbFilter = Nothing
            '                Exit Function
            'exit_routine:
            '                ' some required parameters are missing return default filter string
            '                Return m_strAccessParameter + " IN ('0')"
            '            End Function

            '            Private Function GetFilter(ByVal UserID As Long, ByVal LoginType As String, _
            '                    ByVal RoleLevel As Integer, ByVal AccessParameter As String, _
            '                    ByVal ShowReleasedProjects As Boolean, Optional ByVal LoginID As Long = 0) As String
            '                '=====================================================================
            '                ' Procedure Name        : GetFilter()
            '                ' Purpose               : To get the comma separated list of accessible values
            '                ' Description           : Appends the accessible values separated by a comma
            '                ' Parameters Passed     : ByVal UserID As Long, ByVal LoginType As String, _
            '                '                         ByVal RoleLevel As Integer, ByVal AccessParameter As String
            '                ' Returns               : Comma separated string of Accessible values
            '                ' Parameters Affected   : 
            '                ' Assumptions           : 
            '                ' Dependencies          : usp_QRB_RoleLevelAccessFilter
            '                ' Author                : Rajanikant
            '                ' Created               : October 08,2003
            '                ' Revisions             :
            '                '=====================================================================
            '                Dim dr As IDataReader
            '                Dim sbSQL As System.Text.StringBuilder
            '                Dim sbFilter As System.Text.StringBuilder

            '                sbSQL = New System.Text.StringBuilder()

            '                ' build the sql
            '                sbSQL.Append("usp_QRB_RoleLevelAccessFilter '")
            '                sbSQL.Append(CommonFunction.General.BuildQueryString(AccessParameter))
            '                sbSQL.Append("',")
            '                sbSQL.Append(UserID)
            '                sbSQL.Append(",'" + CommonFunction.General.BuildQueryString(LoginType) + "'," + RoleLevel.ToString)
            '                If ShowReleasedProjects Then
            '                    sbSQL.Append(",1")
            '                Else
            '                    sbSQL.Append(",0")
            '                End If
            '                If LoginID <> 0 Then
            '                    sbSQL.Append("," + LoginID.ToString)
            '                End If

            '                ' get the data reader for the sql
            '                dr = CommonFunction.Data.GetDataReader(sbSQL.ToString, m_blnUseSQL)
            '                sbSQL = Nothing

            '                ' create new obj of string builder
            '                sbFilter = New System.Text.StringBuilder()

            '                ' build the role level access filter for the result set
            '                Do While dr.Read
            '                    sbFilter.Append("'")
            '                    sbFilter.Append(CommonFunctions.General.BuildQueryString(dr(0).ToString))
            '                    sbFilter.Append("'")
            '                    sbFilter.Append(",")
            '                Loop
            '                dr.Close()

            '                ' remove the last comma from the list
            '                If Right(sbFilter.ToString, 1) = "," Then
            '                    sbFilter.Length = sbFilter.Length - 1
            '                End If

            '                ' return the access string
            '                GetFilter = sbFilter.ToString
            '                ' clean up
            '                sbFilter = Nothing
            '            End Function


            '            Private Function GetAllReportingEmployees(ByVal intUserID As Long, ByVal intLevel As Integer) As String
            '                '=====================================================================
            '                ' Procedure Name        : GetAllReportingEmployees()
            '                ' Purpose               : To get the employees who report to the user
            '                ' Description           : Recursively appends the employee ids who report
            '                '                         to the user id passed
            '                ' Parameters Passed     : ByVal intUserID As Long
            '                ' Returns               : Comma separated string of userid|level
            '                ' Parameters Affected   : 
            '                ' Assumptions           : 
            '                ' Dependencies          : usp_QRB_MiddleLevel_Access_GetReportingEmployees
            '                ' Author                : Rajanikant
            '                ' Created               : October 07,2003
            '                ' Revisions             :
            '                '=====================================================================
            '                Dim dr As IDataReader
            '                Dim sbEmployees As New StringBuilder("")

            '                dr = CommonFunction.Data.GetDataReader("usp_QRB_MiddleLevel_Access_GetReportingEmployees  " + intUserID.ToString, m_blnUseSQL)
            '                Do While dr.Read
            '                    ' current employee
            '                    sbEmployees.Append(",")
            '                    sbEmployees.Append(dr("EmployeeID").ToString.Trim + "|" + dr("Level").ToString.Trim)
            '                    sbEmployees.Append(",")
            '                    ' recursive call->all employees who report to the current employee
            '                    sbEmployees.Append(GetAllReportingEmployees(CType(dr("EmployeeID"), Long), CType(dr("Level"), Integer)))
            '                Loop
            '                dr.Close()
            '                GetAllReportingEmployees = sbEmployees.ToString
            '                'Return sbEmployees.ToString
            '                sbEmployees = Nothing
            '            End Function

        End Class
    End Namespace
End Namespace


