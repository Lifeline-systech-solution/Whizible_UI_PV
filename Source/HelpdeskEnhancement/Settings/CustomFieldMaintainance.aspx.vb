Public Class CustomFieldMaintainance
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    'Private m_lngUniqueId As Long = 0
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    'Private m_strQueryMessage As String
    Private WithEvents m_objAssignType As New WebPages.Template.GenericGrid
    Private WithEvents m_objAccess As New WebPages.Template.GenericGrid
    Private WithEvents m_objMainGrid As New WebPages.Template.GenericGrid
    'Private WithEvents m_objValidationRule As New WebPages.Template.GenericGrid
    Public Shared WithEvents m_objValidationRule As New WebPages.Template.GenericGrid
    Private m_lngUserId As Long
    Protected m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
    Protected m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Protected m_strUserName As String = ""
    Protected m_lngLoginID As Long
    Protected m_strLoginName As String
    Protected m_blnUseSQL As String = ""
    Protected Shared m_strAction As String
    Protected Shared m_bitIsQueryValue As String = "0"
    Protected Shared m_strQueryMessage As String
    'Private m_blnDisplay As Boolean = False
    'Protected m_bitIsQueryValue As String = "0"
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private m_objSubTagGlobal As WebPages.Template.IGlobal
    Protected m_objSubTagAccess As WebPage.Templates.AccessRights
    Private m_objSubTagCLSQL As CommonEngines.CommonList.cSubTagCLSQL
    Private Shared m_objSubTabAccess As WebPage.Templates.AccessRights
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""
    Protected Shared strUserName As String = ""
    Protected Shared intUserID As Integer = 0
    Protected Shared TagID As String = ""
    Protected Shared m_Id As Integer = 0
    Protected Shared m_strDBFieldName As String = ""
    Protected Shared Globalm_strUserGivenCaption As String = ""
    Protected Shared m_strEntityName As String = "Help-Desk"
    Protected Shared m_lngUniqueId As Long = 0
    Protected Shared m_strQueryToValidate As String = ""
    Protected Sharedm_strDefaultValueType As String = "S"
    Protected Shared m_blnDisplay As Boolean = False
    Public Shared m_strRules As String = ""
    Private m_lngRowCount As Long = 0
    Private m_strNbyA As String = "N/A"
    Protected Shared GlobalUniqueID As String = ""
    Protected Shared GlobalSelectedUniqueID As String = ""
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=center width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Public Shared m_SavedFlag As Integer = 0
    'Added by Usha Pandit on 06 Aug 2018 for combo box plotting
    Public Shared m_strGlobalQueryText As String = ""
    'End of Added by Usha Pandit on 06 Aug 2018 for combo box plotting
    Protected WithEvents m_objGrid1 As New WebPages.Template.GenericGrid
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_lngLoginID = CommonFunctions.General.CheckIsNothing(CType(Session("intLOGINID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("strUserName"), String)
        intUserID = CType(Session("intUserID"), Integer)
        m_lngUserId = intUserID
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
    End Sub
    Protected Function WritePage(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : WritePage
        ' Purpose               : To Plot the Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali Vekhande
        ' Created               : 4th Jan 2018
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div id='Type' class='tabcontent1 h-type clsSettingstabs'>")
        strHTML.Append(CustomFieldDetails(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")

        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function
    Protected Sub GetGlobalObject(ByVal TagID As String)
        '=====================================================================
        ' Procedure Name        :	GetGlobalObject
        ' Purpose               :	Get the global object and assign it to variable
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali Vekhande
        ' Created               :	4th jan  2018
        '=====================================================================

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = TagID
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub

    Public Function CustomFieldDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal CustomField As String)
        '=====================================================================
        ' Procedure Name        : CustomFieldDetails
        ' Purpose               : To Plot the Customer Master With Subtag
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali Vekhande
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================
        '/*Changed By Yasmin on 25th july 2018*/

        GetGlobalObject(3560)

        Dim strHTML As New StringBuilder("")
        If strWhichGrid <> "PlotSubtab" And strGridFlag = "Load" And strWhichGrid <> "ClientContact" Then
            strHTML.Append("<div id='divTypeStatus'>")
            strHTML.Append("<div class='type-top-bar top-bar' id='divTypeTab'>")
            strHTML.Append("<ul class='left'>")
            strHTML.Append("<li class='search-bar'>")
            strHTML.Append("<div class='left search-bar'>")
            strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
            strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table' >")
            strHTML.Append("</div>")
            strHTML.Append("</li>")
            'strHTML.Append("<li >")
            strHTML.Append("</ul>")

            strHTML.Append("<div id='btngroup'>")

            If m_objAccessRights.Delete = True Then
                ' strHTML.Append(" <button id='btnsaveList' type='button' onclick='Delete_OnClick()' class='btn btn-default save' style='float:right' title='Save'><i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                ' strHTML.Append("<button onclick='Delete_OnClick()'id='btndelete' type='button' class='btn btn-default' title='Delete' style='color:black!important;background-color:white!important'><i id='icondelete' class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
                strHTML.Append("    <button onclick='Delete_OnClick()' id='btndelete' type='button' class='btn btn-default' title='Delete Custom Field'> Delete   <i class='fa fa-trash-o' aria-hidden='true' ></i></button></li>")
            End If

            If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
                strHTML.Append(" <button id='btnsaveList' type='button' onclick='SaveListDetails()' class='btn btn-default save' style='float:right' >Save</button>")
            End If




            strHTML.Append("</div>")
            strHTML.Append(" </div>")

            strHTML.Append("<div class='table-responsive' id='divRequestTypes'>")
            strHTML.Append(WriteCustomGrid("TYPE", strGridFlag, ""))
            strHTML.Append("</div>")
            'strHTML.Append("<div id='btngroupSave'>")

            'If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            '    strHTML.Append(" <button id='btnsaveList' type='button' onclick='SaveListDetails()' class='btn btn-default save' style='float:right' title='Save'>Save</button>")
            'End If
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div id='divSubRequestType'>")


        Else
            If strWhichGrid = "EditCustom" Then
                strHTML.Append("<div class='imgcontainer' id='header'>")
                strHTML.Append("<span class='appro-title' id='Spanconfiguration'></span>")
                strHTML.Append("</div>")
            End If

            If strWhichGrid <> "ClientContact" Then
                strHTML.Append("<div id='divmain'>")
                strHTML.Append("<div id='divInner'>")
            End If

            strHTML.Append("<table class='table' id='tblcontrl'>")
            strHTML.Append("<tr>")
            'Added by Usha Pandit on 06 Aug 2018 for combo box plotting
            Dim strQueryText As String = ""
            'End of Added by Usha Pandit on 06 Aug 2018 for combo box plotting
            If strWhichGrid = "EditCustom" Then

                strHTML.Append("<td id='tdleft'>")
                strHTML.Append("<div id='DivRight'>")
                'Commented and Added by Usha Pandit on 06 Aug 2018 for combo box plotting
                'strHTML.Append(DisplayDetails(CustomField))
                strHTML.Append(DisplayDetails(CustomField, strQueryText))
                'End of Added by Usha Pandit on 06 Aug 2018 for combo box plotting

                strHTML.Append("</div>")
                strHTML.Append("</td>")

            End If


            'strHTML.Append("<tr>")
            'strHTML.Append("<td>")
            'strHTML.Append("<div class='imgcontainer'")
            'strHTML.Append("<span class='appro-title' id='Spanconfiguration'></span>")
            'strHTML.Append("</div>")
            'strHTML.Append("</td>")
            'strHTML.Append("</tr>")


            strHTML.Append("<td id='tdRight'>")
            strHTML.Append("<div id='DivLeft'>")

            If strWhichGrid <> "ClientContact" Then
                strHTML.Append("<div class='clsHideHorizontalDiv' id='DivHorizontal'>")
            End If

            strHTML.Append("<div class='h-tabs'>")
            strHTML.Append("<div class='tab'>")
            'GetSubTabAccessRights(90, 54)
            ' If m_objSubTabAccess.View = True Then
            If InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0 Then
                strHTML.Append("<button id='btnTab1' class='tablinks4 active clsSubtags' onclick='openCity4(event, ""Tab1"")' id='defaultOpen4'>Plot combo box</button>")
            End If

            'End If
            'GetSubTabAccessRights(3373, 54)
            ' If m_objSubTabAccess.View = True Then
            strHTML.Append("<button id='btnTab2' class='tablinks4 clsSubtags' onclick='openCity4(event, ""Tab2"")'>Map SubRequest Type</button>")

            ' End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            If strWhichGrid <> "ClientContact" Then
                strHTML.Append("<div id='Tab1' class='tabcontent4' style='display: block;'>")
                strHTML.Append("<div class='type-top-bar top-bar'>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='table-responsive'  id='tblConfigureHRM' >")
                'Commented and Added by Usha Pandit on 06 Aug 2018 for combo box plotting
                'strHTML.Append(DisplayComboBoxValues(CustomField))
                strQueryText = m_strGlobalQueryText
                If strQueryText = "" Then
                    strHTML.Append(DisplayComboBoxValues(CustomField))
                Else
                    strHTML.Append(DisplayComboBoxValues(CustomField, strQueryText))
                End If

                'End of Added by Usha Pandit on 06 Aug 2018 for combo box plotting

                strHTML.Append(" </div>")

            Else
                If strWhichGrid = "ClientContact" Then
                    strHTML.Append("<div id='Tab2' class='tabcontent4' style='display:block;'>")
                    strHTML.Append("<div class='type-top-bar top-bar'>")
                    'GetSubTabAccessRights(3373, 54)
                    'If m_objSubTabAccess.Add = True Then
                    strHTML.Append("<ul class=''>")
                    strHTML.Append("<li>")
                    ' strHTML.Append("<label id='lblassigntype'>Assign Types  >> " & CustomField & " >> " & Globalm_strUserGivenCaption & " </label>")
                    '/*Changed By Yasmin on 27th july 2018*/
                    strHTML.Append("<div class='left search-bar'>")
                    strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
                    strHTML.Append("<input type='text' id='AssignType' placeholder='Search in table' >")
                    strHTML.Append("</div>")
                    strHTML.Append("</li>")

                    strHTML.Append("<li id='libtn'>")
                    strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveAssignTypes()'  id=''>Save</button>")
                    strHTML.Append("</li>")
                    strHTML.Append("</ul>")
                    'End If

                    strHTML.Append("</div>")
                    strHTML.Append("<div class='table-responsive' id='tblProjectMapping'>")

                    strHTML.Append(WriteMasterGrid("AssignType", ""))
                    strHTML.Append("</div>")

                    'strHTML.Append("<div class='table-responsive' id='tblProjectMapping'>")
                    'strHTML.Append(WriteMasterGrid("AssignType", ""))
                    'strHTML.Append("</div>")

                End If
            End If
            If strWhichGrid <> "ClientContact" Then
                strHTML.Append(" </div>")
            End If

            strHTML.Append("</div>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")
            'Removed &nbsp; after every button for alignment issue By Yasmin on 22-5-19
            If strWhichGrid = "EditCustom" Then
                strHTML.Append("<tr>")
                strHTML.Append("<td colspan='' style='border:none!important'>")
                strHTML.Append(" <button id='btncancelClick' type='button' onclick='CancelPage()' class='btn btn-default save' style='float:right;' >Cancel</button>")

                strHTML.Append("<button type='button' id='btnShowHistory' style='display: none;margin-left: 2px;font-size: 11px;line-height: 10px;' onclick='ShowHistory()' class='btn btn-default save' >Show History</button>")

                strHTML.Append("<button type='button' id='btnAccess' style='display: none;margin-left: 2px;font-size: 11px;line-height: 10px;' onclick='ConFigureAccess()' class='btn btn-default save' >Configure Access</button>")
                If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then

                    strHTML.Append(" <button id='btnsaveClick' type='button' onclick='Save_OnClick()' class='btn btn-default save' style='float:right' >Save</button>")
                End If
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
            End If
            strHTML.Append("</table>")

            If strWhichGrid <> "ClientContact" Then
                strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If

            strHTML.Append("</div>")

        End If






        If strWhichGrid <> "PlotSubtab" Then
            strHTML.Append("</div>")
        End If

        Return strHTML.ToString
    End Function
    Protected Function WriteCustomGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteCustomGrid
        ' Purpose               : To Plot the Custom Grid 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 4th Jan 2018
        ' Revisions             : None
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        strGridHTML.Append(WriteMasterGrid(strWhichGrid, RequestTypeID))
        If (strGridFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function
    'Commented and Added by Usha Pandit on 06 Aug 2018 for combo box plotting
    'Private Function DisplayDetails(ByVal CustomField As String)
    Private Function DisplayDetails(ByVal CustomField As String, ByRef QueryText As String)
        'End of Added by Usha Pandit on 06 Aug 2018 for combo box plotting
        Dim m_blnDisplay As Boolean = True
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        Dim strFieldValue As String = ""
        Dim drWork As IDataReader
        Dim strHTML As String = ""
        Dim blnTemp As Boolean = False
        Dim intDefaultRowNo As Integer
        Dim intDefaultColNo As Integer

        Dim strResult As String = ""
        Dim drTabData As IDataReader
        Dim CustomerName As String = ""
        Dim CustomerID1 As String = ""
        Dim DateSigned As String = ""
        Dim Address As String = ""
        Dim City As String = ""
        Dim State As String = ""
        Dim EmailID As String = ""
        Dim PinCode As String = ""
        Dim CustomerIDnew As String = ""
        Dim ContractValidityDate As String = ""
        Dim SystemFilename As String = ""
        Dim strReasonForOccurence As String = ""
        Dim strEmployeeImage As String = ""
        Dim strFilePath As String = ""
        Dim strSeeHelpdeskSLA As String = ""
        Dim strSQL As String = ""

        'Dim m_lngUniqueId As Long = 0
        Dim m_strUserGivenCaption As String = ""
        Dim m_intDataType As Integer = 0
        Dim m_strValidationRules As String = ""
        Dim m_strControlHeight As String = ""
        Dim m_strControlWidth As String = ""
        Dim m_intRowNumber As Integer = 0
        Dim m_intColumnNumber As Integer = 0
        Dim m_strDefaultValue As String = ""
        Dim m_strMinValue As String = ""
        Dim m_strMaxValue As String = ""
        Dim m_strMaxLength As String = ""
        Dim m_bitIsQueryValue As String = "0"
        Dim m_strQueryText As String = ""
        'Dim m_strQueryToValidate As String = ""
        Dim m_strDefaultValueType As String = "S"

        m_strDBFieldName = CustomField

        Dim strQuery1 As String = ""
        Dim drCustomField As IDataReader
        Dim blnHasDetails As Boolean = False

        strQuery1 = "Exec Usp_Sel_tbl_PM_CustomFields_Master 0 "
        strQuery1 &= ",'" & CustomField & "'"
        'Added By Amol Changle On: 21 Jul 2009
        'Purpose: To select fields Entity Specific
        strQuery1 += ",0,NULL,'help-desk'"
        'End Addition
        drCustomField = CommonFunctions.Data.GetDataReader(strQuery1, True)

        If (m_strAction = "") Then
            If CommonFunctions.General.CheckIsNothing(drCustomField) <> "" Then
                If drCustomField.Read() Then
                    blnHasDetails = True
                    m_strUserGivenCaption = drCustomField.Item("UserGivenCaption").ToString().Trim()
                    m_strUserGivenCaption = CommonFunctions.General.UnBuildQueryString(m_strUserGivenCaption)
                    m_intDataType = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("DataType"), "0"), Integer)
                    m_strValidationRules = drCustomField.Item("ValidationRules").ToString().Trim()
                    m_strValidationRules = CommonFunctions.General.UnBuildQueryString(m_strValidationRules)
                    m_intRowNumber = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("RowNumber"), "0"), Integer)
                    m_intColumnNumber = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("ColumnNumber"), "0"), Integer)
                    m_strControlHeight = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("ControlHeight"), "").ToString()
                    m_strControlWidth = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("ControlWidth"), "").ToString()
                    m_strDefaultValue = drCustomField.Item("DefaultValue").ToString().Trim()
                    m_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                    m_strMinValue = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("MinValue"), "").ToString()
                    m_strMaxValue = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("MaxValue"), "").ToString()
                    m_strMaxLength = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("MaxLength"), "").ToString()
                    m_lngUniqueId = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("UniqueID"), "0"), Long)
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("IsQueryValue"), "False"), Boolean) = True Then
                        m_bitIsQueryValue = "1"
                    Else
                        m_bitIsQueryValue = "0"
                    End If
                    m_strQueryText = drCustomField.Item("QueryText").ToString().Trim()
                    m_strQueryText = CommonFunctions.General.UnBuildQueryString(m_strQueryText)

                    m_strQueryToValidate = m_strQueryText
                    If InStr(1, m_strQueryToValidate, "<PROJECT_ID>", CompareMethod.Text) <> 0 Then
                        m_strQueryToValidate = Replace(m_strQueryToValidate, "<PROJECT_ID>", 0)
                    End If
                    If InStr(1, m_strQueryToValidate, "<USER_ID>", CompareMethod.Text) <> 0 Then
                        m_strQueryToValidate = Replace(m_strQueryToValidate, "<USER_ID>", 0)
                    End If

                    m_strDefaultValueType = drCustomField.Item("DefaultType").ToString().Trim()
                    m_strDefaultValueType = CommonFunctions.General.UnBuildQueryString(m_strDefaultValueType)
                End If
            End If

        End If



        strHTML = "<div id='divList1' style='WIDTH: 100%'>"
        strHTML &= "<table cellSpacing='0' class='clsTable' width='99.9%' id='CustomDetails'>"
        strHTML &= "<tr class=''><td>"
        strHTML &= "Control Caption * "
        strHTML &= "</td>"
        strHTML &= "<td>"
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtUserGivenCaption", "txtUserGivenCaption", , 130, 100, m_strUserGivenCaption, , , blnTemp, , , , "class='form-control'  placeholder='Enter Control Name' ", True, , EnableHTMLEncode:=True)
        strHTML &= "</td>"
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txthidFieldList", "txthidFieldList", , , , strTemp, , , , , , True, , True, EnableHTMLEncode:=True)
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txthidlngUniqueId", "txthidlngUniqueId", , , , m_lngUniqueId, , , , , , True, , True, EnableHTMLEncode:=True)


        strTemp = ""
        strQuery = "Exec usp_Sel_PM_CustomFields_Existing_OrderNumber 0 "

        strQuery += ",'help-desk'"
        'End Addition

        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                'Skip current record
                strFieldValue = CommonFunctions.Data.CheckIsDBNull(drWork.Item("OrderNumber"), "").ToString()
                strFieldValue = CommonFunctions.General.UnBuildQueryString(strFieldValue)
                If (m_intRowNumber & m_intColumnNumber).ToString() <> strFieldValue Then
                    strTemp &= strFieldValue & ","
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txthidOrderNoList", "txthidOrderNoList", , , , strTemp, , , , , , True, , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'Duplicate custom field names are not allowed					
        'Get the Existing User given field captions for the custom fields.
        strTemp = ""
        strQuery = "Exec Usp_Sel_tbl_PM_CustomFields_Master 0"
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                'Skip current record
                strFieldValue = CommonFunctions.Data.CheckIsDBNull(drWork.Item("UserGivenCaption"), "").ToString()
                strFieldValue = CommonFunctions.General.UnBuildQueryString(strFieldValue)
                If m_strUserGivenCaption <> strFieldValue Then
                    strTemp &= strFieldValue & ","
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txthidCFList", "txthidCFList", , , , strTemp, , , , , , True, , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        'Get the Maximum position at which the Custom Field is placed by the User.
        intDefaultRowNo = 1
        intDefaultColNo = 1

        'Commented and Added by Usha Pandit on 30 July 2018 for getting correct Last Row Number for selected field 
        'strQuery = "Exec usp_Sel_PM_CustomFields_Max_Positon 0 "
        strQuery = "Exec usp_Sel_PM_CustomFields_Max_Positon 0, 0,'Help-Desk' "
        'End of Added by Usha Pandit on 30 July 2018 for getting correct Last Row Number for selected field 

        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                strFieldValue = CommonFunctions.Data.CheckIsDBNull(drWork.Item("RowNumber"), "0").ToString()
                'Maximum allowable Row Number is not 99
                If CType(strFieldValue, Integer) <> 99 Then
                    'Display next Row Number as default for the add new mode
                    intDefaultRowNo = CType(strFieldValue, Integer) + 1
                    intDefaultColNo = 1
                Else
                    intDefaultColNo = -1
                    intDefaultRowNo = -1
                End If
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        'strHTML &= "<tr class='clsTREven'>
        strHTML &= "<td valign='top' align='right'>"
        strHTML &= "Control Name *"
        strHTML &= "</td>"
        strHTML &= "<td >"
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseFieldName", "txtDatabaseFieldName", , 130, 100, m_strDBFieldName, , , True, , " ", , " class='form-control'  placeholder='Enter Control Caption' ", True, , EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= "</td></tr>"

        strHTML &= "<tr class=''><td valign='top' align='right' style='width:40%'>"
        strHTML &= "Data Type * "
        strHTML &= "</td>"
        strHTML &= "<td>"
        strQuery = "Exec usp_Sel_tbl_UI_FieldDataTypes "

        If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 Then
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboDataType", strQuery, 130, "2", "Disabled", True, True, , )
        ElseIf InStr(1, UCase(Trim(m_strDBFieldName)), "NUMERIC", CompareMethod.Text) <> 0 Then
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboDataType", strQuery, 130, "1", "Disabled", True, True, , )
        Else
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboDataType", strQuery, 130, m_intDataType.ToString(), , True, True, , )
        End If
        strHTML &= "</td>"
        strHTML &= "<td>"
        strHTML &= "Default Value"
        strHTML &= "</td>"
        'strHTML &= "<tr class='clsTREven'><td valign='top' align='left'></td>"
        'The default value is static value
        'If Trim(m_strDefaultValueType & "") <> "S" Then
        '    strHTML &= "<td id='TDStaticDefaultValue' valign='top' align='left' colspan='3' style='Display:none'>"
        'Else
        strHTML &= "<td id='TDStaticDefaultValue' valign='top' align='left' colspan='3'>"
        'End If

        'Selected Control is date control
        If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 Then
            'If m_strDefaultValueType = "S" Then
            ' strHTML &= CommonFunction.HTMLControls.DrawDateControl("txtDefaultValue", "txtDefaultValue", , 80, m_strDefaultValue, , "frmTaskCustomFields", returnHTML:=True)
            strHTML &= ("<div class='col-sm-2'>")
            'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='JoiningDate'   name='JoiningDate' placeholder='Joining Date'>")
            ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("JoiningDate", "JoiningDate", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Enter Joining Date' ", returnHTML:=True, EnableHTMLEncode:=True))

            'Commented and Added by Usha Pandit on 30 July 2018 for blank default value getting passed, when default value entered
            'strHTML &= ("<input type='text' value='' class='form-control inp clsDateControl' id='txtDefaultValue' placeholder='Enter Default Value' style='width:90px!important'>")
            If m_strDefaultValue <> "" Then
                strHTML &= ("<input type='text' value='" & m_strDefaultValue & "' class='form-control inp clsDateControl' id='txtDefaultValue' placeholder='Enter Default Value' style='width:130px!important;margin-right: 7px;' onclick=""$('#txtDefaultValue').datepicker();$('#txtDefaultValue').datepicker('show');"">")

            Else
                strHTML &= ("<input type='text' value='' class='form-control inp clsDateControl' id='txtDefaultValue' placeholder='Enter Default Value' style='width:130px!important;margin-right: 7px;' onclick=""$('#txtDefaultValue').datepicker();$('#txtDefaultValue').datepicker('show');"">")
            End If
            'End of Added by Usha Pandit on 30 July 2018 for blank default value getting passed, when default value entered

            strHTML &= ("</div>")
            strHTML &= (" <div id='Idcal'>")

            'Commented and Added by Usha Pandit on 30 July 2018 for removing same id given to calender icon
            'strHTML &= ("<i class='fa fa-calendar fcal' id='txtDefaultValue' style='font-size: 14px; margin-right: 10px;' onclick=""$('#txtDefaultValue').datepicker();$('#txtDefaultValue').datepicker('show');""></i>")
            strHTML &= ("<i class='fa fa-calendar fcal' style='font-size: 14px; margin-right: 10px;' onclick=""$('#txtDefaultValue').datepicker();$('#txtDefaultValue').datepicker('show');""></i>")
            'End of Added by Usha Pandit on 30 July 2018 for removing same id given to calender icon

            strHTML &= ("</div>")
            '    Else
            '    strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDefaultValue", "txtDefaultValue", "clsTextBoxReadOnly", 100, , "", , , , True, "", , , True)
            'End If
        Else
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDefaultValue", "txtDefaultValue", , 130, 100, m_strDefaultValue, , , , , , , " class='form-control'  placeholder='Enter Default Value' ", True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If
        'If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 And m_blnDisplay = True Then
        '    strHTML &= CommonFunctions.HTMLControls.DrawImage("../../images/Calendar.gif", "", , "javascript:callcalendar('frmTaskCustomFields','txtDefaultValue')", , , , True)
        'End If
        strHTML &= "</td></tr>"

        strHTML &= "<tr class=''><td valign='top' align='right' style='width:40%'>"
        strHTML &= "Control Position *"
        strHTML &= "</td>"
        strHTML &= "<td valign='top' align='left' colspan=3>"
        strHTML &= "<label style='width:200'> [ ROWNUMBER ] </label>&nbsp;"
        strHTML &= "<label style='width:200'> [ COLUMNNUMBER ] </label>"
        strHTML &= "<br><label style='width:200'>"
        If m_strUserGivenCaption = "" Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtRowNumber", "txtRowNumber", , 93, 2, intDefaultRowNo.ToString(), "right", , , , , , " class='form-control'  placeholder='Enter Row No' ", True, , EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtRowNumber", "txtRowNumber", , 93, 2, m_intRowNumber.ToString(), "right", , , , , , " class='form-control'  placeholder='Enter Row No' ", True, , EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If
        strHTML &= "</label>&nbsp;&nbsp;&nbsp;"
        strHTML &= "<label style='width:200'>"
        If m_strUserGivenCaption = "" Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtColumnNumber", "txtColumnNumber", , 93, 1, 1, "right", , True, , , , " class='form-control'  placeholder='Enter Column No' ", True, , EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtColumnNumber", "txtColumnNumber", , 93, 1, 1, "right", , True, , , , " class='form-control'  placeholder='Enter Column No' ", True, , EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If
        strHTML &= "</label>"
        strHTML &= "</td></tr>"


        'Commented by Usha Pandit on 31 July 2018 for showing actual width for specific custom field
        'If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 Then
        '    m_strControlWidth = "200"

        'ElseIf InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0 Then
        '    m_strControlWidth = "200"
        'ElseIf InStr(1, UCase(Trim(m_strDBFieldName)), "NUMERIC", CompareMethod.Text) <> 0 Then
        '    m_strControlWidth = "200"
        'ElseIf InStr(1, UCase(Trim(m_strDBFieldName)), "CUSTOMFIELDTEXTAREA", CompareMethod.Text) <> 0 Then
        '    m_strControlWidth = "200"
        'Else
        '    m_strControlWidth = "200"
        'End If
        'End of Commented by Usha Pandit on 31 July 2018 for showing actual width for specific custom field

        strHTML &= "<tr class=''><td valign='top' align='right'>"
        strHTML &= "Control Size"
        strHTML &= "</td>"
        strHTML &= "<td valign='top' align='left' colspan=3>"
        strHTML &= "<label style='width:200'>[ HEIGHT ] </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        strHTML &= "<label style='width:200'>[ WIDTH ] </label>"
        strHTML &= "<br><label style='width:200'>"
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtControlHeight", "txtControlHeight", , 93, 3, m_strControlHeight, "Left ", , , , , , " class='form-control'  placeholder='Enter Height' ", True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= "</label>&nbsp;&nbsp;&nbsp;"
        strHTML &= "<label style='width:200'>"
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        'Commented and Added by Usha Pandit on 31 July 2018 for enabling width for custom field 
        'strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtControlWidth", "txtControlWidth", , 93, 3, m_strControlWidth, "Left", , True, , , , " class='form-control'  placeholder='Enter Width' ", True, EnableHTMLEncode:=True)
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtControlWidth", "txtControlWidth", , 93, 3, m_strControlWidth, "Left", , False, , , , " class='form-control'  placeholder='Enter Width' ", True, EnableHTMLEncode:=True)
        'End of Added by Usha Pandit on 31 July 2018 for enabling width for custom field 

        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= "</label>"
        strHTML &= "</td></tr>"

        If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) = 0 Then
            strHTML &= "<tr class=''><td valign='top' align='right'>"
            strHTML &= "Validation Rules"
            strHTML &= "</td>"

            strHTML &= "<td valign='top' align='left'>"
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtValidationRules", "txtValidationRules", , 130, , m_strValidationRules, , , , True, , , "OnPropertyChange='txtValidationRules_OnPropertyChange();  class='form-control'  placeholder='Enter validation Rule'", True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            If m_blnDisplay = True Then
                'Modified By VidyaJ - Browser Issue - IssueID - 809 
                'We need to put javascript function in <A href> tag to make it reconize to Netscape
                Dim strTemp1 As String
                strTemp1 = ""
                strHTML &= "<A onclick=""SelectValidation('" & m_strDBFieldName & "', 0 )"">Select</A>"
                'End addition

                'Commented by Rajashrik for Netscape Implementation on 13/3/2005
                'strTemp = "JavaScript:SelectValidation('" & m_strDBFieldName & "'," & m_lngProjectId.ToString() & ")"
                'strHTML &= "&nbsp;" & CommonFunctions.HTMLControls.DrawImage("../../images/dblclick.gif", "imgValidationRules", , strTemp, 12, 12, , True)
                'End comment
            End If
            strHTML &= "</td>"

            'Added by Usha Pandit on 01 Aug 2018 for Max length property not applicable for combobox
            If InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) = 0 Then
                'End of Added by Usha Pandit on 01 Aug 2018 for Max length property not applicable for combobox
                strHTML &= "<td valign='top' align='right'>"
                strHTML &= "Max Length"
                strHTML &= "</td>"
            End If

            strHTML &= "<td valign='top'>"
            If InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0 Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

                'Commented by Usha Pandit on 01 Aug 2018 for Max length property not applicable for combobox
                'strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxLength", "txtMaxLength", , 130, 8, m_strMaxLength, "Left", , True, , , , " class='form-control'  placeholder='Enter Max length' ", True, EnableHTMLEncode:=True)
                'End of Commented by Usha Pandit on 01 Aug 2018 for Max length property not applicable for combobox

                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            ElseIf InStr(1, "," & m_strValidationRules & ",", ",12,", CompareMethod.Text) <> 0 Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxLength", "txtMaxLength", , 130, 8, m_strMaxLength, "Left", , , , , , " class='form-control'  placeholder='Enter Max length' ", True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxLength", "txtMaxLength", , 130, 8, "", "Left", , True, , , , " class='form-control'  placeholder='Enter Max length' ", True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            strHTML &= "</td></tr>"

            strHTML &= "<tr class=''><td valign='top' align='right'>"
            strHTML &= "Minimum value"
            strHTML &= "</td>"
            strHTML &= "<td valign='top' align='left'>"
            If InStr(1, "," & m_strValidationRules & ",", ",18,", CompareMethod.Text) <> 0 _
                Or InStr(1, "," & m_strValidationRules & ",", ",16,", CompareMethod.Text) <> 0 Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMinValue", "txtMinValue", , 130, 8, m_strMinValue, "Left", , , , , , " class='form-control'  placeholder='Enter Min value' ", True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMinValue", "txtMinValue", , 130, 8, m_strMinValue, "Left", , True, , , , " class='form-control'  placeholder='Enter Min value' ", True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            strHTML &= "</td>"
            strHTML &= "<td valign='top' align='right'>"
            strHTML &= "Maximum Value"
            strHTML &= "</td>"
            strHTML &= "<td valign='top'>"
            If InStr(1, "," & m_strValidationRules & ",", ",18,", CompareMethod.Text) <> 0 _
                Or InStr(1, "," & m_strValidationRules & ",", ",17,", CompareMethod.Text) <> 0 Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxValue", "txtMaxValue", , 130, 8, m_strMaxValue, "Left", , , , , , " class='form-control'  placeholder='Enter Max value' ", True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxValue", "txtMaxValue", , 130, 8, m_strMaxValue, "Left", , True, , , , " class='form-control'  placeholder='Enter Max value' ", True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            strHTML &= "</td></tr>"
        End If


        If InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0 Then
            'Commented by Usha Pandit on 30 July 2018 as 2 fields getting plot for Default value 
            'strHTML &= "<tr class=''><td valign='top' align='right'>"
            'strHTML &= "Default Value"
            'strHTML &= "</td>"
            'strHTML &= "<td valign='top' align='left' colspan='3'>"
            ''Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDefaultValue", "txtDefaultValue", "clsTextBoxReadOnly", 130, 100, m_strDefaultValue, , , , True, , , " class='form-control'  placeholder='Enter Default Value' ", True, EnableHTMLEncode:=True)
            ''End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'strHTML &= "</td></tr>"
            'End of Commented by Usha Pandit on 30 July 2018 as 2 fields getting plot for Default value 
        Else

            strHTML &= "<td valign='top' align='left' style='display:none' >"
            'If Trim(m_strDefaultValueType & "") = "S" Then
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optDefaultValue", "optDefaultValue", , True, "S", , "Onclick='JavaScript:optDefaultValue_Onclick()'", True)
            ' Else
            '   strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optDefaultValue", "optDefaultValue", , , "S", , "Onclick='JavaScript:optDefaultValue_Onclick()'", True)
            'End If
            'strHTML &= MyBase.GetResourceString("STATICVALUE") & "</td>"

            strHTML &= "<td valign='top' align='left' colspan='2' style='display:none'>"
            'If Trim(m_strDefaultValueType & "") = "F" Then
            'strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optDefaultValue", "optDefaultValue", , True, "F", , "Onclick='JavaScript:optDefaultValue_Onclick()'", True)
            'Else
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optDefaultValue", "optDefaultValue", , , "F", , "Onclick='JavaScript:optDefaultValue_Onclick()'", True)
            'End If
            'strHTML &= MyBase.GetResourceString("DYNAMICVALUE") & "</td></tr>"
            'Default Value
            strHTML &= "<tr class=''><td valign='top' align='right'>"

            'strHTML &= "DEFAULTVALUE"
            'strHTML &= "</td>"
            ''strHTML &= "<tr class='clsTREven'><td valign='top' align='left'></td>"
            ''The default value is static value
            ''If Trim(m_strDefaultValueType & "") <> "S" Then
            ''    strHTML &= "<td id='TDStaticDefaultValue' valign='top' align='left' colspan='3' style='Display:none'>"
            ''Else
            'strHTML &= "<td id='TDStaticDefaultValue' valign='top' align='left' colspan='3'>"
            ''End If

            ''Selected Control is date control
            'If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 Then
            '    'If m_strDefaultValueType = "S" Then
            '    strHTML &= CommonFunction.HTMLControls.DrawDateControl("txtDefaultValue", "txtDefaultValue", , 80, m_strDefaultValue, , "frmTaskCustomFields", returnHTML:=True)
            '    '    Else
            '    '    strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDefaultValue", "txtDefaultValue", "clsTextBoxReadOnly", 100, , "", , , , True, "", , , True)
            '    'End If
            'Else
            '    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDefaultValue", "txtDefaultValue", , 200, 100, m_strDefaultValue, , , , , , , , True, EnableHTMLEncode:=True)
            '    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'End If
            ''If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 And m_blnDisplay = True Then
            ''    strHTML &= CommonFunctions.HTMLControls.DrawImage("../../images/Calendar.gif", "", , "javascript:callcalendar('frmTaskCustomFields','txtDefaultValue')", , , , True)
            ''End If
            'strHTML &= "</td>"

            'If Trim(m_strDefaultValueType & "") = "S" Then
            strHTML &= "<td id='TDCommonFieldDefaultValue' valign='top' align='left' colspan='3' style='display:none'>"
            'Else
            '    strHTML &= "<td id='TDCommonFieldDefaultValue' valign='top' align='left' colspan='3'>"
            'End If
            'Selected Control is date control
            If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 Then
                strQuery = "Exec usp_sel_Get_ProjectTasks_Fields 0 "
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "',1 "
            Else
                strQuery = "Exec usp_sel_Get_ProjectTasks_Fields 0 "
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
            End If
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboDefaultValue", strQuery, 150, m_strDefaultValue, , , True)
            strHTML &= "</td></tr>"
        End If
        'This Section is only applicable for the Combo box Custom Fields
        If InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0 Then
            strHTML &= "<tr class=''>"
            strHTML &= "<td valign='top' align='right'>"
            strHTML &= "Combobox values"
            strHTML &= "</td>"
            strHTML &= "<td valign='top' align='left'>"
            If m_bitIsQueryValue.Trim() = "0" Then
                blnTemp = True
            Else
                blnTemp = False
            End If
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optComboValue", "optComboValue", , blnTemp, "0", , "Onclick='JavaScript:optComboValue_Onclick()'", True)
            strHTML &= "Custom Values"
            strHTML &= "</td>"
            strHTML &= "<td valign='top' align='left' colspan='2'>"
            If m_bitIsQueryValue.Trim() = "1" Then
                blnTemp = True
            Else
                blnTemp = False
            End If
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optComboValue", "optComboValue", , blnTemp, "1", , "Onclick='JavaScript:optComboValue_Onclick()'", True)
            strHTML &= "Query or Stored Procedure"
            strHTML &= "</td>"
            strHTML &= "</tr>"
            If m_bitIsQueryValue.Trim() = "0" Then
                strHTML &= "<tr id='TRQueryText' class='clsTREven' style='display:none'>" '<td valign='top' align='left'></td>
            Else
                strHTML &= "<tr id='TRQueryText' class='clsTREven'>" '<td valign='top' align='left'></td>
            End If
            strHTML &= "<td valign='top' align='left' colspan='5'>"
            strHTML &= CommonFunctions.HTMLControls.DrawTextArea("txtQueryText", "txtQueryText", widthInPixel:=150, heightInPixel:=50, value:=m_strQueryText, returnHTML:=True)
            'strHTML &= "<span id='errormsg'></span>"
            strHTML &= "</td>"
            strHTML &= "</tr>"
            strHTML &= "<TR class='clsTREven'><TD colspan='6'><B><Center>"
            strHTML &= "<span id='errormsg'><FONT COLOR=RED></FONT><span>"
            strHTML &= "</Center></B></TD></TR>"
            'If m_strQueryMessage <> "" Then
            '    strHTML &= "<TR class='clsTREven'><TD colspan='6'><B><Center>
            '    strHTML &= "<FONT COLOR=RED>" & m_strQueryMessage & "</FONT>"
            '    strHTML &= "</Center></B></TD></TR>"
            'End If
        End If
        strHTML &= "</table><br>" + vbCrLf
        'CommonFunctions.General.WriteHTML(strHTML)
        'strHTML = ""

        'This Section is only applicable for the Combo box Custom Fields
        'DisplayComboBoxValues()
        'Added by Usha Pandit on 06 Aug 2018 for Query text 
        QueryText = m_strQueryText
        m_strGlobalQueryText = m_strQueryText
        'End of Added by Usha Pandit on 06 Aug 2018 for Query text 

        'Only for Query Values
        'DisplayQueryValues()
        Globalm_strUserGivenCaption = m_strUserGivenCaption
        strHTML &= "</div>" & vbCrLf
        Return strHTML
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid(ByVal GridParameter As Object, ByVal CustomerID As String, ByVal Role As String, ByVal Status As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid
        ' Created Date           : 7th Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCustomFieldMaintainance As New CustomFieldMaintainance()

            strGridHTML.Append(objCustomFieldMaintainance.WriteMasterGrid(GridParameter("cityName"), ""))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Private Function WriteMasterGrid(ByVal strWhichGrid As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteMasterGrid()	
        ' Purpose               : To Plot the Grids
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 4th Jan 2018
        ' Revisions             : None
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""

        If strWhichGrid.ToUpper = "TYPE" Then
            Dim intNoOfDataColumn As Integer = 8
            Dim strDivID As String = ""
            'Dim intTotalColumns As Integer = 8
            'Chakshuta
            Dim intTempTotalColumns As Integer = intNoOfDataColumn
            'If m_strPageCalledFrom = PAGE_CALLEDFROM_CORPORATE Then
            intTempTotalColumns = intNoOfDataColumn - 1
            'End If
            Dim arrstrActualList(intTempTotalColumns - 1) As String
            Dim arrstrUserFriendlyList(intTempTotalColumns - 1) As String
            Dim arrCheckBoxId(intTempTotalColumns - 1) As String
            Dim arrCheckedOnColumn(intTempTotalColumns - 1) As String
            Dim arrRowLink(intTempTotalColumns - 1) As String
            Dim arrRowLinkTooltip(intTempTotalColumns - 1) As String
            Dim arrWidthArray(intTempTotalColumns - 1) As String
            'Dim arrstrActualList() As String
            'Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            'Dim arrCheckBoxArray() As String
            'Dim arrWidthArray() As String
            'Dim arrCheckedOnColumn() As String
            'Dim arrCheckBoxId() As String
            Dim intIndex As Integer = 0
            Dim arrIgnoreHTMLEncode() As String = {"0"}


            'Initialize the Required arrays for the advanced grid
            'Commented and Added by Usha Pandit on 30 July 2018 for displaying correct Column Name
            'arrstrUserFriendlyList(intIndex) = "DatabaseField Name" 'MyBase.GetResourceString("CONTROLNAME")
            arrstrUserFriendlyList(intIndex) = "Control Name" 'MyBase.GetResourceString("CONTROLNAME")
            'End of Added by Usha Pandit on 30 July 2018 for displaying correct Column Name

            arrstrActualList(intIndex) = "DatabaseFieldName"

            arrCheckBoxId(intIndex) = ""
            arrCheckedOnColumn(intIndex) = ""

            arrWidthArray(intIndex) = ""
            intIndex += 1

            arrstrUserFriendlyList(intIndex) = "Control Caption" ' MyBase.GetResourceString("CONTROLCAPTION")
            arrstrActualList(intIndex) = "UserGivenCaption"
            arrCheckBoxId(intIndex) = ""
            arrCheckedOnColumn(intIndex) = ""

            arrWidthArray(intIndex) = ""
            intIndex += 1

            arrstrUserFriendlyList(intIndex) = "Row Number" 'MyBase.GetResourceString("ROWNUMBER")
            arrstrActualList(intIndex) = "RowNumber"
            arrCheckBoxId(intIndex) = ""
            arrCheckedOnColumn(intIndex) = ""

            arrWidthArray(intIndex) = "align=center"
            intIndex += 1

            arrstrUserFriendlyList(intIndex) = "Column Number" ' MyBase.GetResourceString("COLUMNNUMBER")
            arrstrActualList(intIndex) = "ColumnNumber"
            arrCheckBoxId(intIndex) = ""
            arrCheckedOnColumn(intIndex) = ""

            arrWidthArray(intIndex) = "align=center"
            intIndex += 1

            arrstrUserFriendlyList(intIndex) = "Show" ' MyBase.GetResourceString("SHOW")
            arrstrActualList(intIndex) = ""
            arrCheckBoxId(intIndex) = "chkActive"
            arrCheckedOnColumn(intIndex) = "Active"

            arrWidthArray(intIndex) = "align=center"
            intIndex += 1


            arrstrUserFriendlyList(intIndex) = "Edit" ' MyBase.GetResourceString("SHOW")
            arrstrActualList(intIndex) = ""
            arrCheckBoxId(intIndex) = ""
            arrCheckedOnColumn(intIndex) = ""

            arrWidthArray(intIndex) = "align=center"
            intIndex += 1


            arrstrUserFriendlyList(intIndex) = "Delete" 'MyBase.GetResourceString("DELETE")
            arrstrActualList(intIndex) = ""
            arrCheckBoxId(intIndex) = "chkDelete"
            arrCheckedOnColumn(intIndex) = ""

            arrWidthArray(intIndex) = "align=center"
            intIndex += 1


            ' intNoOfDataColumn = 4
            strDivID = "DivList"
            strSQLQuery = "Usp_Sel_PM_Get_CustomFields  0, 'ORDER BY RowNumber ASC','Help-Desk'"
            'arrstrActualList = {"DatabaseFieldName", "UserGivenCaption", "RowNumber", "ColumnNumber", "", "", ""}
            'arrstrUserFriendlyList = {"Control Name", "Control Caption", "RowNumber", "ColumnNumber", "Show", "Edit", "Delete"}
            'arrstrLinkArray = {"", "", "", "", "", "", ""}
            'arrCheckBoxArray = {"", "", "", "", "Active", "", "chkActive"}
            'arrCheckBoxId = {"", "", "", "", "chkActive", "", "chkDelete"}
            'arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
            ID = "DatabaseFieldName"
            objGrid = m_objMainGrid

            '/*Changed By Yasmin on 25th july 2018*/


            With objGrid
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                .ActualColumnArray = arrstrActualList
                .CheckBoxIDArray = arrCheckBoxId
                .CheckboxCheckOnColumnArray = arrCheckedOnColumn
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray

                .ColNameToolTipOnEachRow = False
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                '.PrimaryKey = ID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = False
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With

            'intRecordCount = m_objGridAttachment.NoOfRows

            objGrid = Nothing



        ElseIf strWhichGrid.ToUpper = "ASSIGNTYPE" Then 'AssignType
            Dim intNoOfDataColumn As Int16
            Dim strDivID As String = ""
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            Dim arrCheckBoxId() As String
            Dim Flag As Integer = 0
            Dim ID As String = ""

            intNoOfDataColumn = 1
            strDivID = "divAssignType"
            strSQLQuery = "Usp_SEL_TypesToAssign_For_CustomFields 0 ,'Help-Desk'"
            arrstrActualList = {"Type", ""}
            arrstrUserFriendlyList = {"Sub Request Type", "Select"}
            arrstrLinkArray = {"", ""}
            arrCheckBoxArray = {"", ""}
            arrWidthArray = {"align=left", "align=left"}
            ID = "TypeID"
            objGrid = m_objAssignType
            '/*Changed By Yasmin on 25th july 2018*/


            If Flag = 0 Then
                With objGrid
                    .ActualColumnArray = arrstrActualList
                    .UserFriendlyColumnArray = arrstrUserFriendlyList
                    ' .CheckBoxIDArray = arrCheckBoxArray
                    .NoOfDataColumns = intNoOfDataColumn
                    .RowLinkArray = arrstrLinkArray
                    .TDStyleArray = arrWidthArray

                    .ColNameToolTipOnEachRow = False
                    .EmptyValueReplacement = (" ")
                    .DIVID = strDivID
                    '.PrimaryKey = ID
                    .SQL = strSQLQuery
                    .ColNameToolTipOnEachRow = False
                    .UseSQL = True
                    .returnHTML = True
                    .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                    strGridHTML.Append(.DrawGrid())
                End With

                'intRecordCount = m_objGridAttachment.NoOfRows

                objGrid = Nothing
            End If

        ElseIf strWhichGrid.ToUpper = "SHOWACCESS" Then 'ShowAccess
            Dim intNoOfDataColumn As Int16
            Dim strDivID As String = ""
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            Dim arrCheckBoxId() As String
            Dim Flag As Integer = 0
            Dim ID As String = ""

            intNoOfDataColumn = 1
            strDivID = "divAccess"
            strSQLQuery = "usp_NG2_Sel_ConfigureeRoleacess"
            arrstrActualList = {"RoleDescription", ""}
            arrstrUserFriendlyList = {"Role", "Select"}
            arrstrLinkArray = {"", ""}
            arrCheckBoxArray = {"", ""}
            arrWidthArray = {"align=left", "align=left"}
            ID = "RoleID"
            objGrid = m_objAccess
            '/*Changed By Yasmin on 25th july 2018*/


            If Flag = 0 Then
                With objGrid
                    .ActualColumnArray = arrstrActualList
                    .UserFriendlyColumnArray = arrstrUserFriendlyList
                    ' .CheckBoxIDArray = arrCheckBoxArray
                    .NoOfDataColumns = intNoOfDataColumn
                    .RowLinkArray = arrstrLinkArray
                    .TDStyleArray = arrWidthArray

                    .ColNameToolTipOnEachRow = False
                    .EmptyValueReplacement = (" ")
                    .DIVID = strDivID
                    '.PrimaryKey = ID
                    .SQL = strSQLQuery
                    .ColNameToolTipOnEachRow = False
                    .UseSQL = True
                    .returnHTML = True
                    .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                    strGridHTML.Append(.DrawGrid())
                End With

                'intRecordCount = m_objGridAttachment.NoOfRows

                objGrid = Nothing
            End If

        End If




        Return strGridHTML.ToString
    End Function
    'Private Sub m_objMainGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMainGrid.DataRowTD_BeforePrint
    '    Dim blnShow As Boolean = False
    '    Dim blnIsCorporate As Boolean = False
    '    Dim blnActive As Boolean = False
    '    Dim objLink As WebPages.UI.cDynamicLink

    '    blnShow = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Show"), "False"), Boolean)
    '    blnIsCorporate = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("IsCorporate"), "False"), Boolean)
    '    blnActive = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Active"), "False"), Boolean)


    '    If Args.ColumnName.ToUpper = "EDIT" Then
    '        Cancel = True

    '        If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UniqueID"), ""), String) = "" Then

    '            Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt' data-toggle='tooltip' checked=true id=chkCustomEdit name=chkCustomEdit onclick=""Edit_Custom(this,'','" & Args.DataReader("DatabaseFieldName") & "')"" value='' ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt' data-toggle='tooltip' checked=true id=chkCustomEdit name=chkCustomEdit onclick=""Edit_Custom(this," & Args.DataReader("UniqueID") & ",'" & Args.DataReader("DatabaseFieldName") & "')"" value=" & Args.DataReader("UniqueID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
    '        End If


    '        'Else
    '        '    Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt1' data-toggle='tooltip' id=chkCustomDelete name=chkCustomDelete onclick='Edit_Custom(this," & Args.DataReader("UniqueID") & ")' value=" & Args.DataReader("UniqueID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
    '    End If

    '    'End If
    '    If Args.ColumnName.ToUpper = "DELETE" Then
    '        'Cancel = True
    '        If m_objAccessRights.Delete = False Then
    '            Cancel = True
    '        Else
    '            If (blnShow = True) And (blnIsCorporate = False) And (m_lngRowCount = 0) Then
    '                'Args.StringToBeInserted = "<td align='center' Title = 'Delete'><button type='button' class='edit-bt1' data-toggle='tooltip' checked=true id=chkCustomDelete name=chkCustomDelete onclick='Delete_Customer(this," & Args.DataReader("UniqueID") & ")' value=" & Args.DataReader("UniqueID") & " ><i class='fa fa-trash-o' aria-hidden='true'></i></button>" + "</TD>"
    '                Args.StringToBeInserted = "<TD align=center>"
    '                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkCustomDelete", "chkCustomDelete", , , Args.DataReader.Item("DatabaseFieldName").ToString().Trim(), , "", True)
    '                Args.StringToBeInserted &= "</TD>"
    '            Else
    '                Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
    '                Cancel = True
    '            End If
    '        End If
    '    End If

    '    If Args.ColumnName.ToUpper = "COLUMNNUMBER" Then
    '        If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ColumnNumber"), "0"), Long) = 9999 Then 'ColumnNumber
    '            Args.ReplacementValue = m_strNbyA
    '        End If
    '    End If

    '    If Args.ColumnName.ToUpper = "ROWNUMBER" Then
    '        If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RowNumber"), "0"), Long) = 9999 Then 'RowNumber
    '            Args.ReplacementValue = m_strNbyA
    '            'Cancel = True
    '            'Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
    '        End If
    '    End If

    '    If Args.ColumnName.ToUpper = "SHOW" Then
    '        Cancel = True
    '        'If m_objAccessRights.Delete = False Then
    '        '    Cancel = True
    '        'Else
    '        '    If (blnShow = True) And (blnIsCorporate = False) And (m_lngRowCount = 0) Then
    '        '    ElseIf blnIsCorporate = True Then
    '        '        'Args.StringToBeInserted = "<TD align=center>"
    '        '        ' Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkActive", "chkActive", , blnActive, Args.DataReader.Item("DatabaseFieldName").ToString().Trim(), , "style='display:none'", True)
    '        '        If blnActive = True Then
    '        '            'Args.StringToBeInserted &= "yes"
    '        '            Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkActive' id='chkActive' title='Select' value='" & Args.DataReader("DatabaseFieldName") & "' checked /></td>"
    '        '        Else
    '        '            'Args.StringToBeInserted &= "No"
    '        '            Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkActive' id='chkActive' title='Select' value='" & Args.DataReader("DatabaseFieldName") & "'  /></td>"
    '        '        End If
    '        '        ' Args.StringToBeInserted &= "</TD>"
    '        '        Cancel = True
    '        '    Else
    '        '        Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
    '        '        Cancel = True
    '        '    End If
    '        'End If
    '        If (blnShow = True) Then
    '            Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkActive' id='chkActive' title='Select' value='" & Args.DataReader("DatabaseFieldName") & "' /></td>"
    '            If blnActive = True Then
    '                Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkActive' id='chkActive' title='Select' value='" & Args.DataReader("DatabaseFieldName") & "' checked /></td>"
    '            Else
    '                Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkActive' id='chkActive' title='Select' value='" & Args.DataReader("DatabaseFieldName") & "' /></td>"
    '            End If

    '        Else
    '            Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
    '        End If
    '    End If
    'End Sub
    Private Sub m_objMainGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMainGrid.DataRowTD_BeforePrint

        Dim blnShow As Boolean = False
        Dim blnIsCorporate As Boolean = False
        Dim blnActive As Boolean = False
        Dim objLink As WebPages.UI.cDynamicLink
        GetGlobalObject(3560)
        blnShow = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Show"), "False"), Boolean)
        blnIsCorporate = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("IsCorporate"), "False"), Boolean)
        blnActive = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Active"), "False"), Boolean)
        Select Case Args.ColIndex
            Case 0  'Control Name Column
                If Not (m_lngRowCount = 0 And _
                   ((m_objAccessRights.Edit And blnShow = True) Or _
                    (m_objAccessRights.Add And blnShow = False))) Then
                    Args.EnableLink = False
                End If

            Case 1  'Control Caption Column 
                If m_lngRowCount = 0 Then
                    If blnShow = True Then
                        Args.StringToBeInserted = "<TD>"
                        Args.StringToBeInserted &= Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UserGivenCaption")).ToString())
                        Args.StringToBeInserted &= ""
                        Args.StringToBeInserted &= "</TD>"
                        Cancel = True
                    End If
                Else
                    objLink = New WebPages.UI.cDynamicLink
                    objLink.FunctionName = "Add_To_Project_OnClick('" & Args.DataReader("DatabaseFieldName").ToString() & "')"
                    objLink.LinkName = MyBase.GetResourceString("ADD_TO_PROJECT")
                    objLink.Tooltip = MyBase.GetResourceString("ADD_TO_PROJECT_TOOLTIP")
                    objLink.ReturnHTML = True
                    'Modified By VarunA on 12-Aug-2008 RequestID-14439
                    'Purpose : To have role level security and custom field name
                    'Args.StringToBeInserted = "<TD>" & MyBase.GetResourceString("DEFINE_AT_CORPORATE_LEVEL")
                    ' Args.StringToBeInserted = "<TD>" & m_strCorprateCFCaption & " - " & MyBase.GetResourceString("DEFINE_AT_CORPORATE_LEVEL")
                    If m_objAccessRights.Add = False And m_objAccessRights.Edit = False Then
                        Args.StringToBeInserted &= " " & MyBase.GetResourceString("ADD_TO_PROJECT")
                    Else
                        Args.StringToBeInserted &= " " & objLink.GetDynamicLink()
                    End If
                    'End By VarunA on 12-Aug-2008 RequestID-14439
                    Args.StringToBeInserted &= "</TD>"
                    Cancel = True
                End If

            Case 2  'Row Number Column
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RowNumber"), "0"), Long) = 9999 Then
                    Args.ReplacementValue = m_strNbyA
                End If

            Case 3  'Column Number Column
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ColumnNumber"), "0"), Long) = 9999 Then
                    Args.ReplacementValue = m_strNbyA
                End If

            Case 4  'Show Checkbox Column
                'Cancel = True
                If m_objAccessRights.Edit = False Then
                    Cancel = True
                Else
                    If (blnShow = True) And (blnIsCorporate = False) And (m_lngRowCount = 0) Then
                        Cancel = True
                        If blnActive = True Then
                            'Args.StringToBeInserted &= "yes"
                            Args.StringToBeInserted = "<td style='text-align:center' title='Show Custom Field'><input type=checkbox name='chkActive' id='chkActive' value='" & Args.DataReader("DatabaseFieldName") & "' checked /></td>"
                        Else
                            'Args.StringToBeInserted &= "No"
                            Args.StringToBeInserted = "<td style='text-align:center' title='Show Custom Field'><input type=checkbox name='chkActive' id='chkActive' value='" & Args.DataReader("DatabaseFieldName") & "'  /></td>"
                        End If

                        'ElseIf blnIsCorporate = True Then
                        '    Args.StringToBeInserted = "<TD align=center>"
                        '    Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkActive", "chkActive", , blnActive, Args.DataReader.Item("DatabaseFieldName").ToString().Trim(), , "style='display:none'", True)
                        '    If blnActive = True Then
                        '        Args.StringToBeInserted &= "Yes"
                        '    Else
                        '        Args.StringToBeInserted &= "No"
                        '    End If
                        '    Args.StringToBeInserted &= "</TD>"
                        '    Cancel = True
                    Else
                        Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
                        Cancel = True
                    End If
                End If

            Case 5  'Edit Column
                Cancel = True
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UniqueID"), ""), String) <> "" Then
                    GlobalUniqueID = CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UniqueID"), "")
                Else
                    GlobalUniqueID = ""
                End If

                If m_objAccessRights.Edit = False Then
                    Cancel = True
                Else
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UniqueID"), ""), String) = "" Then

                        Args.StringToBeInserted = "<td align='center' Title = 'Edit Custom Field'><button type='button' class='edit-bt' checked=true id=chkCustomEdit name=chkCustomEdit onclick=""Edit_Custom(this,'','" & Args.DataReader("DatabaseFieldName") & "')"" value='' ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
                    Else
                        Args.StringToBeInserted = "<td align='center' Title = 'Edit Custom Field'><button type='button' class='edit-bt' checked=true id=chkCustomEdit name=chkCustomEdit onclick=""Edit_Custom(this," & Args.DataReader("UniqueID") & ",'" & Args.DataReader("DatabaseFieldName") & "')"" value=" & Args.DataReader("UniqueID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
                    End If

                End If

            Case 6  'Delete  Column
                Cancel = True
                If m_objAccessRights.Delete = False Then
                    Cancel = True
                Else

                    If (blnShow = True) And (blnIsCorporate = False) And (m_lngRowCount = 0) Then

                        Args.StringToBeInserted = "<TD align=center title='Delete Custom Field'>"
                        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkCustomDelete", "chkCustomDelete", , , Args.DataReader.Item("DatabaseFieldName").ToString().Trim(), , "", True)
                        Args.StringToBeInserted &= "</TD>"
                    Else
                        Args.StringToBeInserted = "<TD align=center  title='Delete Custom Field'>" & m_strNbyA & "</TD>"
                        Cancel = True
                    End If
                End If


        End Select
        'If Args.ColumnName.ToUpper = "EDIT" Then
        '    Cancel = True

        '    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UniqueID"), ""), String) = "" Then

        '        Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt' data-toggle='tooltip' checked=true id=chkCustomEdit name=chkCustomEdit onclick=""Edit_Custom(this,'','" & Args.DataReader("DatabaseFieldName") & "')"" value='' ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
        '    Else
        '        Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt' data-toggle='tooltip' checked=true id=chkCustomEdit name=chkCustomEdit onclick=""Edit_Custom(this," & Args.DataReader("UniqueID") & ",'" & Args.DataReader("DatabaseFieldName") & "')"" value=" & Args.DataReader("UniqueID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
        '    End If
        'End If
    End Sub

    Private Sub m_objMainGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objMainGrid.ColumnHeaderTD_BeforePrint



        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.ApplyHTMLEncode = False
            Args.ApplySorting = False
            Args.TDStyle = " "
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteMultiple()' type=checkbox id=chkAllCustom name=chkAllCustom title='Select All'/></th>"
        End If



    End Sub
    Private Sub m_objAssignType_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objAssignType.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Dim strQuery As String = ""
            Dim drWork As IDataReader
            Args.IsCheckBoxChecked = True
            strQuery = "usp_Sel_tbl_PM_CustomFields_Type '" & m_strDBFieldName & "'," & Args.DataReader("TypeID") & " ,'Help-Desk'"
            drWork = CommonFunctions.Data.GetDataReader(strQuery, True)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If Not (drWork.Read()) Then Args.IsCheckBoxChecked = False
                If Args.IsCheckBoxChecked = True Then

                    Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkAssignTypeSelect' id='chkAssignTypeSelect' title='Select' value='" & Args.DataReader("TypeID") & "' checked /></td>"
                Else
                    Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkAssignTypeSelect' id='chkAssignTypeSelect' title='Select' value='" & Args.DataReader("TypeID") & "' /></td>"
                End If
            End If
            'CommonFunctions.Data.DisposeDataReader(drWork)

        End If


    End Sub

    Private Sub m_objAccess_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objAccess.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Dim strQuery As String = ""
            Dim Flag As String = "0"
            Dim dsRoleSecurity As DataSet
            Args.IsCheckBoxChecked = True
            'Usp_SEL_tbl_PM_RoleCustomFieldSecurity_ConfigureAccess 0,39,NULL,'Help-Desk'
            strQuery = "Usp_SEL_tbl_PM_RoleCustomFieldSecurity_ConfigureAccess 0 ,'" & GlobalSelectedUniqueID & "', null ,'Help-Desk'"
            dsRoleSecurity = CommonFunctions.Data.GetDataSet(strQuery.ToString(), "Tbl_ConfigureAccess", True)
            If dsRoleSecurity.Tables(0).Select("RoleID=" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RoleID"), "0").ToString()).Length > 0 Then
                Args.IsCheckBoxChecked = True
                If Args.IsCheckBoxChecked = True Then
                    Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkAccess' id='chkAccess' title='Select' value='" & Args.DataReader("RoleID") & "' checked /></td>"

                Else
                    Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkAccess' id='chkAccess' title='Select' value='" & Args.DataReader("RoleID") & "'  /></td>"
                End If
            Else
                Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkAccess' id='chkAccess' title='Select' value='" & Args.DataReader("RoleID") & "'  /></td>"
            End If
            Args.StringToBeInserted += "<input type='hidden' id='txthdnCustomID'  value='" & GlobalSelectedUniqueID & "'>"

        End If
        'CommonFunctions.Data.DisposeDataReader(drWork)


        'End If


    End Sub

    <System.Web.Services.WebMethod> _
    Public Shared Function PlotSubtab(ByVal CustomFieldID As String, ByVal Flag As String, ByVal CustomFieldName As String) As String
        '=====================================================================
        ' Procedure Name        : PlotSubtab
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :8 Nov -2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim OBJCustomFieldMaintainance As New CustomFieldMaintainance()
            GlobalSelectedUniqueID = CustomFieldID
            strGridHTML.Append(OBJCustomFieldMaintainance.CustomFieldDetails(Flag, "PlotSubRequestType", CustomFieldName))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function DeleteCustomFieldList(ByVal SelectedDeleteContrl As String) As String
        Dim strQuery As String
        Dim strDeleteList As String = ""
        Dim arrCheckedCustomField() As String
        Dim intCnt As Integer
        Dim Flag As String = "0"
        strDeleteList = SelectedDeleteContrl
        Try
            If (strDeleteList <> "") Then
                arrCheckedCustomField = strDeleteList.Split(CType(",", Char))
                strDeleteList = ""
                For intCnt = 0 To arrCheckedCustomField.Length - 1
                    strDeleteList &= "'" & CommonFunctions.General.BuildQueryString(arrCheckedCustomField(intCnt)) & "',"
                Next
                strDeleteList = Left(strDeleteList, strDeleteList.Length - 1)
            End If
            strQuery = "Usp_Del_tbl_PM_CustomFields 0 "
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strDeleteList) & "'"
            'Added By Amol Changle On: 21 Jul 2009
            'Purpose: To select fields Entity Specific
            strQuery += ",'" + m_strEntityName + "'"
            'End Addition
            Flag = 1
            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            Return Flag
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function
    'Commented and Added by Usha Pandit on 06 Aug 2018 for combo box plotting
    'Private Function DisplayComboBoxValues(CustomField)
    Private Function DisplayComboBoxValues(ByVal CustomField As String, Optional ByVal QueryText As String = "")
        'End of Added by Usha Pandit on 06 Aug 2018 for combo box plotting
        Dim strHTML As String = ""
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        m_blnDisplay = True
        If (InStr(1, UCase(Trim(CustomField)), "COMBO", CompareMethod.Text) = 0) Or (m_bitIsQueryValue.Trim() = "1") Then
            strHTML &= "<div id='divComboboxValues' style='display:none'>"
        Else
            strHTML &= "<div id='divComboboxValues'>"
        End If


        strHTML &= "<table cellspacing='0' width='99.9%' class='clsTable'>"
        strHTML &= "<tr class='clsTRColumnHeader'><td align='left' style='width:70%'>"
        If m_blnDisplay = True Then
            strHTML &= "Please enter values to populate the combo box"
        Else
            strHTML &= "Please enter values to populate the combo box"
        End If
        strHTML &= "</td></tr></table>"


        strHTML &= "<table cellspacing='0' width='99.9%' class='clsTable'>"
        strHTML &= "<tr class='clsTREven'><td align='right' style='width:40%'>&nbsp;</td>"
        strHTML &= "<td align='left' valign='top'>"
        strHTML &= "<label id='lblSelectedValue' name='lblSelectedValue'>&nbsp;</label>"
        strHTML &= "</td></tr>"
        If m_blnDisplay = True Then
            strHTML &= "<tr class='clsTREven'>"
            strHTML &= "<td align='right' style='width:40%'>"
            strHTML &= "Enter the value*"
            strHTML &= "</td>"
            strHTML &= "<td align='left'>"
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'Commented and Added by Usha Pandit on 02 Aug 2018 for combo box Enter the value text box placeholder display
            'strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtValue", "txtValue", , 200, 100, , , , , , , (Not m_blnDisplay), "placeholder='Enter value to populate the combo box'", True, , EnableHTMLEncode:=True)
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtValue", "txtValue", , 220, 100, , , , , , , (Not m_blnDisplay), "placeholder='Enter value to populate the combo box'", True, , EnableHTMLEncode:=True)
            'End Of Added by Usha Pandit on 02 Aug 2018 for combo box Enter the value text box placeholder display

            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= "</td>"
            strHTML &= "</tr>"
            strHTML &= "<tr class='clsTREven'>"
            strHTML &= "<td align='right'>&nbsp;</td><td align='Left'><label style='width:200;text-align:center'>"
            strHTML &= "|&nbsp;"
            ''Commented and Added by Usha Pandit on 28.05.2019 for getting id of Insert/Update/Delete link
            'strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:InsertValue_OnClick()'>"
            strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:InsertValue_OnClick()' id = 'lnkCboInsert'>"
            ''End of Added by Usha Pandit on 28.05.2019 for getting id of Insert/Update/Delete link
            strHTML &= "<font size='1' face='verdana' color='black'>"
            strHTML &= "<b> INSERT </b>"
            strHTML &= "</font></a>&nbsp;|&nbsp;&nbsp;"
            ''Commented and Added by Usha Pandit on 28.05.2019 for getting id of Insert/Update/Delete link
            'strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:UpdateValue_OnClick()'>"
            strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:UpdateValue_OnClick()' id = 'lnkCboUpdate'>"
            ''End of Added by Usha Pandit on 28.05.2019 for getting id of Insert/Update/Delete link
            strHTML &= "<font size='1' face='verdana' color='black'>"
            strHTML &= "<b> UPDATE </b>"
            strHTML &= "</font></a>&nbsp;|&nbsp;&nbsp;"
            ''Commented and Added by Usha Pandit on 28.05.2019 for getting id of Insert/Update/Delete link
            'strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:DeleteValue_OnClick()'>"
            strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:DeleteValue_OnClick()' id = 'lnkCboDelete'>"
            ''End of Added by Usha Pandit on 28.05.2019 for getting id of Insert/Update/Delete link
            strHTML &= "<font size='1' face='verdana' color='black'>"
            strHTML &= "<b> DELETE </b>"
            strHTML &= "</font></a>&nbsp;|&nbsp;&nbsp;"
            strHTML &= "</label></td></tr>"
        End If

        strHTML &= "<tr class='clsTREven'>"
        strHTML &= "<td align='right' style='width:40%'>"
        strHTML &= "Combo box Values * "
        strHTML &= "</td><td align='left'>"
        strQuery = "Exec Usp_Sel_tbl_PM_CustomFields_Details '"
        strQuery &= CommonFunctions.General.BuildQueryString(CustomField) & "',0,0"
        'Added By Amol Changle On: 21 Jul 2009
        'Purpose: To select fields Entity Specific
        strQuery += ",'help-desk'"
        'End Addition
        If m_blnDisplay = True Then strTemp = "ondblclick=""javascript:SelectElement_OnClick('C')"""

        'Commented and Added by Usha Pandit on 06 Aug 2018 for combo box plotting
        'strHTML &= CommonFunctions.HTMLControls.DrawListBox("lstValue", strQuery, 200, 150, , strTemp, ReturnAsHTML:=True, IsMandatory:=False)
        If QueryText = "" Then
            strHTML &= CommonFunctions.HTMLControls.DrawListBox("lstValue", strQuery, 200, 150, , strTemp, ReturnAsHTML:=True, IsMandatory:=False)
        Else
            strHTML &= CommonFunctions.HTMLControls.DrawListBox("lstValue", QueryText, 200, 150, , strTemp, ReturnAsHTML:=True, IsMandatory:=False)
        End If
        'End of Added by Usha Pandit on 06 Aug 2018 for combo box plotting
        strHTML &= "</td></tr>"

        If m_blnDisplay = True Then
            strHTML &= "<tr class='clsTREven'>"
            strHTML &= "<td align='right'>&nbsp;</td><td align='left' valign='top'>"
            strHTML &= "(Double click to edit the value)"
            strHTML &= "</td></tr>"
        End If

        strHTML &= "</table>"
        strHTML &= "</div>"

        Return strHTML
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveAccess(ByVal SelectedAccess As String, ByVal m_strEntityName As String, ByVal m_strCustomFieldID As String) As String
        Try
            Dim strSQL As New StringBuilder()
            Dim intChkCount As Integer = 0
            Dim RoleID As String = ""
            Dim arrValue() As String

            GlobalSelectedUniqueID = m_strCustomFieldID
            'first delete all the entries for current project and custom field ID, then insert new 
            strSQL.Append("usp_del_tbl_PM_RoleCustomFieldSecurity ")
            If m_strEntityName.ToLower() = "help-desk" Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Added "Sub projects" and "projects" condition by NitinC on 20 April 2011 for WhizibleSEM 10.0 for custom field
                strSQL.Append("0")
            Else
                strSQL.Append("0")
            End If
            strSQL.Append(",")
            strSQL.Append(m_strCustomFieldID)
            strSQL.Append(",'")
            strSQL.Append("-1")
            strSQL.Append("',N'")
            strSQL.Append(m_strEntityName)
            strSQL.Append("'")
            CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)


            'insert new records for the selected custom field for current project and RoleIDs

            RoleID = SelectedAccess

            arrValue = RoleID.Split(CType(",", Char))
            For intChkCount = 0 To arrValue.Length - 1
                If RoleID <> "" Then
                    strSQL.Length = 0
                    strSQL.Append("usp_ins_tbl_PM_RoleCustomFieldSecurity ")
                    'Modified by syamantak Chavan On 05-Oct-2011 for whizible 10.0
                    If m_strEntityName.ToLower() = "help-desk" Then
                        strSQL.Append("0")
                    Else
                        strSQL.Append("0")
                    End If
                    'End Modified by syamantak Chavan On 05-Oct-2011 for whizible 10.0
                    strSQL.Append(",")
                    strSQL.Append(m_strCustomFieldID.Trim)
                    strSQL.Append(",")
                    strSQL.Append(arrValue(intChkCount).Trim)
                    strSQL.Append(",N'")
                    strSQL.Append(m_strEntityName)
                    strSQL.Append("'")
                    'Added m_SavedFlag veriable in below line  by NitinC on 28 April 2011 for WhizibleSEM 10.0
                    m_SavedFlag = CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)
                    'End - 'Added m_SavedFlag veriable in below line  by NitinC on 28 April 2011 for WhizibleSEM 10.0
                End If
            Next
            Return m_SavedFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveAssignTypes(ByVal SelectedAssignType As String) As String
        Try
            Dim strQuery As String
            Dim Flags As Integer = 0
            Dim intChkCount As Integer = 0
            Dim strCheckBoxValues As String = ""
            Dim arrValue() As String
            Dim m_lngProjectId As Integer = 0
            Dim m_strEntityName As String = "Help-Desk"
            If m_lngProjectId = 0 Then
                strQuery = "usp_Del_tbl_PM_CustomFields_Type '" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
                strQuery += ",'" + m_strEntityName + "'"

            End If
            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

            strCheckBoxValues = SelectedAssignType
            ' strCheckBoxValues = CommonFunctions.General.UnBuildQueryString(strCheckBoxValues)
            If strCheckBoxValues <> "" Then
                arrValue = strCheckBoxValues.Split(CType(",", Char))
                For intChkCount = 0 To arrValue.Length - 1
                    If arrValue(intChkCount) <> "" Then
                        If m_lngProjectId = 0 Then
                            strQuery = "usp_Ins_tbl_PM_CustomFields_Type '" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
                            strQuery &= "," & arrValue(intChkCount)
                            'Added By Amol Changle On: 21 Jul 2009
                            'Purpose: To save Assign Types Entity Specific
                            strQuery += ",'" + m_strEntityName + "'"
                            'End Addition
                            Flags = 1
                        End If
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                    End If
                Next
            End If
            Return Flags
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Added by Usha Pandit on 06 Aug 2018 for Combo box query validation
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateCustomComboQuery(ByVal strQuery As String) As String
        Try
            Dim strQueryResult As String = ""
            If CommonFunctions.Data.ValidateQuery(strQuery, True) = False Then
                strQueryResult = "Error : Invalid Query"
            Else
                strQueryResult = "Success"
            End If
            Return strQueryResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Private Sub DisplayQueryValues(ByVal QueryText As String)
        Dim strHTML As String = ""
        Dim strQuery As String = ""
        Dim strTemp As String = ""

        If (InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0) And (m_bitIsQueryValue.Trim() = "1") Then
            strHTML &= "<div id='divQueryValues' Style='display:block'>"
        Else
            strHTML &= "<div id='divQueryValues' Style='display:none'>"
        End If

        strHTML &= "<table cellspacing='0' width='99.9%' class='clsTable'>"
        strHTML &= "<tr class='clsTRColumnHeader'><td align='left' style='width:70%'>"
        strHTML &= MyBase.GetResourceString("COMBOBOXVALUES")
        strHTML &= "</td></tr></table>"


        strHTML &= "<table cellspacing='0' width='99.9%' class='clsTable'>"
        If QueryText.Trim() <> "" And m_strQueryToValidate.Trim() <> "" Then
            strHTML &= "<tr class='clsTREven'><td align='right' valign='top' width='40%'>"
            strHTML &= MyBase.GetResourceString("COMBOBOXVALUES")
            strHTML &= "</td>"
            strHTML &= "<td align='left'>"
            strHTML &= CommonFunctions.HTMLControls.DrawListBox("lstValueQ", m_strQueryToValidate, 200, 150, , "ondblclick=""javascript:SelectElement_OnClick('Q')""", ReturnAsHTML:=True, IsMandatory:=True)
            strHTML &= "</td></tr>"
            If m_blnDisplay = True Then
                strHTML &= "<tr class='clsTREven'>"
                strHTML &= "<td align='right'>&nbsp;</td><td align='left' valign='top'>"
                strHTML &= "(" & MyBase.GetResourceString("SET_VALUE_AS_DEFAULT") & ")"
                strHTML &= "</td></tr>"
            End If
        Else
            strHTML &= "<tr class='clsTREven'><td align=Center>"
            strHTML &= MyBase.GetResourceString("NOITEMS")
            strHTML &= "</td></tr>"
        End If
        strHTML &= "</table>"
        strHTML &= "</div>"

        CommonFunctions.General.WriteHTML(strHTML)
    End Sub
    'End of Added by Usha Pandit on 06 Aug 2018 for Combo box query validation

    ' data1 = JSON.stringify({ m_strDBFieldName: m_strDBFieldName, m_intDataType: m_intDataType, m_intRowNumber: m_intRowNumber, m_intColumnNumber: m_intColumnNumber, m_strControlHeight: m_strControlHeight, m_strControlWidth: m_strControlWidth, m_strValidationRules: m_strValidationRules, m_strMaxLength: m_strMaxLength, m_strMinValue: m_strMinValue, m_strMaxValue: m_strMaxValue, m_strDefaultValue: m_strDefaultValue, m_strMinValue: m_strMinValue, m_strQueryText: m_strQueryText });
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveCustomFieldDetails(ByVal m_txtUserGivenCaption As String, ByVal m_strDBFieldName As String, ByVal m_intDataType As String, ByVal m_intRowNumber As String, ByVal m_intColumnNumber As String, ByVal m_strControlHeight As String, ByVal m_strControlWidth As String, ByVal m_strValidationRules As String, ByVal m_strMaxLength As String, ByVal m_strMinValue As String, ByVal m_strMaxValue As String, ByVal m_strDefaultValue As String, ByVal m_strQueryText As String, ByVal lstValue As String, ByVal m_bitIsQueryValue As String, ByVal m_strDefaultValueType As String) As String
        Try
            Dim strQuery As String = ""
            Dim strTemp As String = ""
            Dim strValues As String = ""
            Dim arrValues() As String
            Dim strDataValue As String = ""
            Dim intCtr As Integer = 0
            Dim drWork As IDataReader
            Dim Flags As String = "0"

            If m_bitIsQueryValue = "" Then m_bitIsQueryValue = "0"
            ' m_strQueryText = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtQueryText"), ""), 0, False, False).ToString()
            m_strQueryText = CommonFunctions.General.UnBuildQueryString(m_strQueryText)
            m_strQueryToValidate = m_strQueryText
            ''Commented and Added by Usha Pandit on 28.05.2019 for getting text entered in Query textarea field
            m_strGlobalQueryText = m_strQueryText
            ''End of Added by Usha Pandit on 28.05.2019 for getting text entered in Query textarea field

            If InStr(1, CommonFunctions.General.CheckIsNothing(m_strDBFieldName).ToUpper(), "COMBO", CompareMethod.Text) = 0 Then
                'm_strDefaultValueType = CommonFunctions.General.CheckIsNothing(Request.Form("optDefaultValue"), "S").ToString()
                If m_strDefaultValueType <> "" Then
                    If m_strDefaultValueType = "S" Then
                        m_strDefaultValue = CommonFunction.General.CheckIsNothing(m_strDefaultValue, "").ToString()
                        m_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                    Else
                        m_strDefaultValue = CommonFunction.General.CheckIsNothing(m_strDefaultValue, "").ToString()
                        m_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                        'm_strDefaultValue = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("cboDefaultValue"), ""), 0, False, False).ToString()
                        'm_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                    End If
                End If
            Else
                'Commented and Added by Usha Pandit on 30 July 2018 for blank default value getting passed, when default value entered
                'm_strDefaultValue = m_strDefaultValue = CommonFunction.General.CheckIsNothing(m_strDefaultValue, "").ToString()
                m_strDefaultValue = CommonFunction.General.CheckIsNothing(m_strDefaultValue, "").ToString()
                'End of Added by Usha Pandit on 30 July 2018 for blank default value getting passed, when default value entered
                m_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                m_strDefaultValueType = "S"
            End If



            If m_bitIsQueryValue = "1" Then
                If InStr(1, m_strQueryToValidate, "<PROJECT_ID>", CompareMethod.Text) <> 0 Then
                    m_strQueryToValidate = Replace(m_strQueryToValidate, "<PROJECT_ID>", 0)
                End If
                If InStr(1, m_strQueryToValidate, "<USER_ID>", CompareMethod.Text) <> 0 Then
                    m_strQueryToValidate = Replace(m_strQueryToValidate, "<USER_ID>", HttpContext.Current.Session("intUserID"))
                End If

                'Modified By NitinVS on 19 Apr 2007 for WhizibleSEM SP 8 Regression fixes Issue 12408 
                ' to Validate for Invalid sql keywords 
                Dim Pattern As New System.Text.StringBuilder

                Dim strConfigPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory) & "bin\"
                'Create the config manager
                Dim objConfigMgr As New Utilities.Config.ConfigManager(strConfigPath & "Security.Config")
                'Open the config file
                objConfigMgr.Open()
                'Get the config key value
                Pattern.Append(objConfigMgr.GetValue("SQLKeyWords"))
                Pattern.Replace("select|", "")
                Pattern.Replace("exec|", "")
                Pattern.Replace("execute|", "")
                Pattern.Replace("sp_|", "truncate|")
                'Craete the regular exception object
                Dim reEx As New System.Text.RegularExpressions.Regex(Pattern.ToString(), System.Text.RegularExpressions.RegexOptions.IgnoreCase)

                'Clean the string with pattern
                m_strQueryToValidate = reEx.Replace(m_strQueryToValidate, "")
                'Destroy the re object
                reEx = Nothing
                Pattern = Nothing
                'Destroy the object
                objConfigMgr = Nothing

                'End Modification By NitinVS on 19 Apr 2007 for WhizibleSEM SP 8 Regression fixes Issue 12408 

                If CommonFunctions.Data.ValidateQuery(m_strQueryToValidate, True) = False Then
                    'm_strQueryMessage = "Error: Invalid Query."
                    Flags = ""
                End If
            End If
            If m_strQueryMessage = "" Then
                strQuery = "Exec Usp_Upd_tbl_PM_CustomFields_Master 0 "
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_txtUserGivenCaption)
                strQuery &= "','" & CommonFunctions.General.BuildQueryString(m_strDBFieldName)
                strQuery &= "'," & m_intDataType.ToString()
                If m_intRowNumber > 0 Then
                    strQuery &= "," & m_intRowNumber.ToString()
                Else
                    strQuery &= ", NULL"
                End If
                If m_intColumnNumber > 0 Then
                    strQuery &= "," & m_intColumnNumber.ToString()
                Else
                    strQuery &= ", NULL"
                End If
                If m_strControlHeight <> "" Then
                    strQuery &= "," & m_strControlHeight
                Else
                    strQuery &= ", NULL"
                End If
                If m_strControlWidth <> "" Then
                    strQuery &= "," & m_strControlWidth
                Else
                    strQuery &= ", NULL"
                End If
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strValidationRules)
                If m_strMaxLength <> "" Then
                    strQuery &= "'," & m_strMaxLength
                Else
                    strQuery &= "', NULL"
                End If

                If m_strMinValue <> "" Then
                    strQuery &= "," & m_strMinValue
                Else
                    strQuery &= ", NULL"
                End If
                If m_strMaxValue <> "" Then
                    strQuery &= "," & m_strMaxValue
                Else
                    strQuery &= ", NULL"
                End If
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDefaultValue)
                strQuery &= "','" & HttpContext.Current.Session("strUserName") & "',"
                strQuery &= m_bitIsQueryValue

                If m_bitIsQueryValue = "0" Then
                    strTemp = "Exec Usp_Sel_tbl_PM_CustomFields_Master 0"
                    strTemp &= ",'" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
                    drWork = CommonFunctions.Data.GetDataReader(strTemp, True)
                    If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                        If drWork.Read() Then
                            m_lngUniqueId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("UniqueID"), "0"), Long)

                            strQuery &= ",''"

                        Else

                            strQuery &= ",''"

                        End If
                    Else

                        strQuery &= ",''"

                    End If
                    CommonFunctions.Data.DisposeDataReader(drWork)
                Else
                    strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strQueryText) & "'"
                End If
                strQuery &= ",S "
                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To save fields Entity Specific
                strQuery += ",'" + m_strEntityName + "'"
                'End Addition

                'Commented and Added by Usha Pandit On 27 July 2018 for getting current CustomFieldId
                'CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                Dim CustomFieldId As String = CommonFunctions.Data.GetDataScalar(strQuery, True)
                If CustomFieldId <> 0 Then
                    GlobalSelectedUniqueID = CustomFieldId
                End If
                'End of Added by Usha Pandit On 27 July 2018 for getting current CustomFieldId

                'If the custom field is a combo box then replace existing values with the new values
                'for that Custom Field.
                If InStr(1, UCase(m_strDBFieldName.Trim()), "COMBO", CompareMethod.Text) <> 0 And m_bitIsQueryValue = "0" Then
                    strValues = lstValue
                    strValues = CommonFunctions.General.UnBuildQueryString(strValues)
                    strTemp = "Usp_Sel_tbl_PM_CustomFields_Details '"
                    strTemp &= m_strDBFieldName.Trim().ToUpper() & "',0,0"
                    'Added By Amol Changle On: 21 Jul 2009
                    'Purpose: To save field details Entity Specific
                    strTemp += ",'" + m_strEntityName + "'"
                    'End Addition

                    drWork = CommonFunctions.Data.GetDataReader(strTemp, True)
                    If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                        While drWork.Read()
                            strDataValue = drWork.Item("Value").ToString().Trim()
                            strDataValue = CommonFunctions.General.UnBuildQueryString(strDataValue)
                            If InStr(1, "," & strValues & ",", "," & strDataValue & ",", CompareMethod.Text) = 0 Then
                                'Commented by Usha Pandit on 31 July 2018 for object referrence error for HttpContext.Current.Session("")
                                'strTemp = "EXEC usp_Ins_tbl_PM_AuditTrail null "
                                'strTemp &= HttpContext.Current.Session("").ToString() & ",0"
                                'strTemp &= ",'" & HttpContext.Current.Session("strUserName")
                                'strTemp &= "','Value','" & CommonFunctions.General.BuildQueryString(strDataValue) & "'"
                                'CommonFunctions.Data.InsertOrUpdateData(strTemp, True)
                                'End of Commented by Usha Pandit on 31 July 2018 for object referrence error for HttpContext.Current.Session("")
                            End If
                        End While
                    End If
                    CommonFunctions.Data.DisposeDataReader(drWork)

                    strTemp = "Exec Usp_Del_tbl_PM_CustomFields_Details 0 ,'"
                    strTemp &= CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
                    'Added By Amol Changle On: 21 Jul 2009
                    'Purpose: To delete field details Entity Specific
                    strTemp += ",'" + m_strEntityName + "'"
                    'End Addition
                    CommonFunctions.Data.InsertOrUpdateData(strTemp, True)

                    arrValues = strValues.Split(CType(",", Char))
                    For intCtr = 0 To arrValues.Length - 1
                        strTemp = "Exec Usp_Ins_tbl_PM_CustomFields_Details 0,'"
                        strTemp &= CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "','"
                        strTemp &= CommonFunctions.General.BuildQueryString(m_txtUserGivenCaption) & "','"
                        strTemp &= CommonFunctions.General.BuildQueryString(arrValues(intCtr)) & "','"
                        strTemp &= HttpContext.Current.Session("strUserName") & "'"
                        'Added By Amol Changle On: 21 Jul 2009
                        'Purpose: To insert field details Entity Specific
                        strTemp += ",'" + m_strEntityName + "'"
                        'End Addition
                        CommonFunctions.Data.InsertOrUpdateData(strTemp, True)
                    Next
                End If
                'Commented and Added by Usha Pandit On 27 July 2018 for getting current CustomFieldId
                'Flags = "1"
                Flags = "1" & "|" & GlobalSelectedUniqueID
                'End of Added by Usha Pandit On 27 July 2018 for getting current CustomFieldId
            End If
            'm_strAction = ACTION_SUCCESSFULLY_COMPLETED
            Return Flags
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetValidationRules(ByVal strDatabaseFieldName As String, ByVal strValidationRules As String) As String
        '=====================================================================
        ' Procedure Name        : GetValidationRules
        ' Purpose               : Render the UI for showing validation rules
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 25th Feb 2004
        ' Revisions             :
        '=====================================================================
        Try
            m_strRules = strValidationRules
            Dim strSQL As String
            Dim arrstrActualList() As String = {"ValidationDescription", ""}
            Dim arrstrUserFriendlyList() As String = {"Validation Rule", "Apply"}
            Dim arrCheckBox() As String = {"", "chkApply"}
            Dim arrstrTDStyle() As String = {" align=left noWrap ", " align=center "}
            Dim strGRID As String
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            Dim arrIgnoreHTMLEncode() As String = {"0"}
            'ended by Yogesh J for HTML encoding Date:07/10/15
            strSQL = "EXEC usp_Sel_tbl_UI_Validation "

            With m_objValidationRule
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                .CheckBoxIDArray = arrCheckBox
                .TDStyleArray = arrstrTDStyle
                .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
                .PrimaryKey = "ValidationID"
                .ColumnHeaderAlignment = "center"
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                .SQL = strSQL
                .DIVHeight = 0
                .returnHTML = True
                .UseSQL = True
                .DIVID = "divValidation"
                strGRID = .DrawGrid()
            End With
            Return strGRID
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    Private Shared Sub m_objValidationRule_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objValidationRule.DataRowTR_BeforePrint
        If CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_DATE Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_GREATER_THAN_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_LESS_THAN_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_EQUAL_TO_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_NOT_EQUAL_TO_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_GREATER_THAN_OR_EQUAL_TO_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_DISALLOW_VALUE1_LESS_THAN_OR_EQUAL_TO_VALUE2 Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_DUPLICATE Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_DUPLICATE_MATCH_CASE Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_MIN_LENGTH Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_INTEGER Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) = CommonFunction.Constants.VALIDATION_IS_POSITIVE_INTEGER Then
            Cancel = True
        ElseIf CType(Args.DataReader("ValidationID"), Long) > 28 Then
            Cancel = True
        End If
    End Sub

    Private Shared Sub m_objValidationRule_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objValidationRule.DataRowTD_BeforePrint
        If Args.ColIndex = 1 Then
            If InStr("," & m_strRules, "," & Args.DataReader.Item("ValidationID").ToString() & ",", CompareMethod.Text) > 0 Then
                Args.IsCheckBoxChecked = True
                'If Args.IsCheckBoxChecked = True Then
                '    Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkApply' id='chkApply' title='Select' value='" & Args.DataReader("ValidationID") & "' checked /></td>"
                'Else
                '    Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkApply' id='chkApply' title='Select' value='" & Args.DataReader("ValidationID") & "'  /></td>"
                'End If

                'Else
                '    Args.StringToBeInserted = "<td style='text-align:center'><input type=checkbox name='chkApply' id='chkApply' title='Select' value='" & Args.DataReader("ValidationID") & "'  /></td>"
            End If


        End If
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function ShowCustomDetails(ByVal UniqueID As Integer)
        '*******************************************************************************'
        ' Function Name	        :	ShowCustomDetails                              '
        ' Purpose				:   Call ShowCustomDetails function                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande                             '
        '*******************************************************************************'
        Try
            Dim objCustomFieldMaintainance As New CustomFieldMaintainance
            Dim strHTML As New StringBuilder("")
            Dim str As String = objCustomFieldMaintainance.ShowHistoryGrid(UniqueID, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowAccess(ByVal flag As String) As String
        '*******************************************************************************'
        ' Function Name	        :	ShowAccess                              '
        ' Purpose				:   ShowAccessn                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande                             '
        '*******************************************************************************'
        Try
            Dim objCustomFieldMaintainance As New CustomFieldMaintainance
            Dim strHTML As New StringBuilder("")
            Dim str As String = objCustomFieldMaintainance.WriteMasterGrid(flag, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    Public Function ShowHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	ShowHistoryGrid                                 '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   UniqueID                                            '
        ' Returns               :   grid                                                '
        ' Author                :  Dipali Vekhande                                      '
        '*******************************************************************************'

        '/*Changed By Yasmin on 25th july 2018*/

        Dim strHTML As New StringBuilder("")
        Dim txtSQLQuery As New StringBuilder
        Dim strSQLQuery As String = ""
        If (storedprocedure = Nothing) Then
            txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_CustomFiled '" & 3560 & "','" & UniqueID & "'")
        Else
            txtSQLQuery.Append(storedprocedure)
        End If

        strSQLQuery = txtSQLQuery.ToString

        arrColumnHeadingList.Add("Modified Date")
        arrColumnHeadingList.Add("Field Modified")
        arrColumnHeadingList.Add("Modified By")
        arrColumnHeadingList.Add("Value")

        arrActualColumnNames.Add("Date")
        arrActualColumnNames.Add("FieldName")
        arrActualColumnNames.Add("ModifiedBy")
        arrActualColumnNames.Add("Value")
        m_objGrid1 = New WebPages.Template.GenericGrid
        With m_objGrid1
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = 4
            .PrimaryKey = "LogID"
            .TDStyleArray = arrWidthArray
            .ColNameToolTipOnEachRow = False
            .DIVID = "ShowHistoryGrid"
            .DIVStyle = "overflow: auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = False
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
        ' Author                :  Dipali Vekhande       
        ' Created               : 
        ' Revisions             :
        '===============================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function FilteredHistory(ByVal newModifiedField As String, ByVal globalCustomFieldID As Integer, ByVal newModifiedBy As String)
        '================================================================================
        ' Procedure Name        : FilteredHistory()	
        ' Purpose               :
        ' Description           : 
        ' Parameters Passed     : 
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Dipali Vekhande       
        ' Created               : 8-Jan-2018
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            Dim objCustomFieldMaintainance As New CustomFieldMaintainance
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_CustomFiled 3560, '" & globalCustomFieldID & "','" & newModifiedField & "','" & newModifiedBy & "'"

            Dim str As String = objCustomFieldMaintainance.ShowHistoryGrid(globalCustomFieldID, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveCustomFieldList(ByVal SelectedActiveContrl As String) As String
        '================================================================================
        ' Procedure Name        : SaveCustomFieldList()	
        ' Purpose               :
        ' Description           : 
        ' Parameters Passed     : 
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Dipali Vekhande       
        ' Created               : 8-Jan-2018
        ' Revisions             :
        '===============================================================================
        Try
            Dim strQuery As String
            Dim strActiveList As String = ""
            Dim arrActiveCustomField() As String
            Dim intCnt As Integer
            Dim Flag As String = "0"

            strActiveList = SelectedActiveContrl
            If (strActiveList <> "") Then
                arrActiveCustomField = strActiveList.Split(CType(",", Char))
                strActiveList = ""
                For intCnt = 0 To arrActiveCustomField.Length - 1
                    strActiveList &= "'" & CommonFunctions.General.BuildQueryString(arrActiveCustomField(intCnt)) & "',"
                Next
                strActiveList = Left(strActiveList, strActiveList.Length - 1)
            End If
            strQuery = "Usp_Upd_tbl_PM_CustomFields_Master_Active 0 "
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strActiveList) & "'"
            'Added by ShraddhaM on 17,Aug 2009 
            strQuery &= ", '" & m_strEntityName & "'"
            'Ended by ShraddhaM

            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            Flag = 1
            Return Flag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

End Class