Public Class PRO_ConfigureTaskAttributes
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Constants Used in the Class "
    Protected Const ACTION_SAVE As String = "Save"

    Private Const ATTRIBUTE_PHASE As String = "Phase"
    Private Const ATTRIBUTE_MODULE As String = "Module"
    Private Const ATTRIBUTE_SUBPROJECT As String = "Sub Project"
    Private Const ATTRIBUTE_MILESTONE As String = "Milestone"
    Private Const ATTRIBUTE_CHANGE_REQUEST As String = "Change Request"
    Private Const ATTRIBUTE_FEATURE As String = "Feature"
    Private Const ATTRIBUTE_ESTIMATION_TYPE As String = "Estimation Type"

    Private Enum MenuIndex
        SAVE
        CLOSE
        HELP
    End Enum
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    'Menu
    Private m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(2) As String
    Private m_arrMenuTooltip(2) As String
    Private m_arrClientSideFunctions(2) As String
    'Grid
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_strAction As String = ""
    Private m_strPageTitle As String = ""
    Protected m_lngProjectTypeId As Long = 0
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security
        'Put user code to initialize the page here
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_strPageTitle = MyBase.GetResourceString("TASK_ATTRIBUTES")
        InitPageMenu()

        m_lngProjectTypeId = CType("0" & Request.QueryString("TypeID"), Long)
        m_strAction = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txthidAction"))
        If m_strAction = ACTION_SAVE Then
            Save_TaskAttributes()
        End If
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PRO_ConfigureTaskAttributes", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PRO_ConfigureTaskAttributes : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub WritePage()
        Dim strQuery As String = ""
        Dim strProjectTypeName As String = ""
        Dim strRightCaption As String = ""
        Dim strMenu As String

        'Get the Project Type Name
        strQuery = "EXEC usp_sel_ProjectTypeRelated_Informaion 3," & m_lngProjectTypeId.ToString()
        strProjectTypeName = CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL).ToString()
        strProjectTypeName = CommonFunctions.General.UnBuildQueryString(strProjectTypeName)

        strRightCaption = MyBase.GetResourceString("CONFIGURE_TASK_ATTRIBUTES")
        strRightCaption &= " '" & strProjectTypeName & "'"

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<br>")

        'Display Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, m_strPageTitle, strRightCaption, , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display Page Body
        Display_AttributesList()

        'Display Menu at Footer
        CommonFunctions.General.WriteHTML(strMenu)

        'Hidden 
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''  CommonFunctions.HTMLControls.DrawTextBox("txthidAction", "txthidAction", , , , , , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction", "txthidAction", , , , , , , , , , True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('PTYPECONFIG_TASKATTRIBUTES')"

        MyBase.InitializeResources("AppResources.PRO_ConfigureTaskAttributes", "AppResources")
    End Sub

    Private Sub Display_AttributesList()
        Dim strQuery As String = ""
        Dim intTotalColumns As Integer = 3
        Dim arrActualColumns(intTotalColumns - 1) As String
        Dim arrUserFriendlyColumn(intTotalColumns - 1) As String
        Dim arrCheckBoxId(intTotalColumns - 1) As String
        Dim arrstrTDStyle(intTotalColumns - 1) As String
        Dim intIndex As Integer = 0

        'Initialize the Required arrays for the advanced grid
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ATTRIBUTES")
        arrActualColumns(intIndex) = "Attributes"
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "valign='top'"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("SHOW")
        arrActualColumns(intIndex) = ""
        arrCheckBoxId(intIndex) = "chkShow"
        arrstrTDStyle(intIndex) = "align='center'"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("MANDATORY")
        arrActualColumns(intIndex) = ""
        arrCheckBoxId(intIndex) = "chkMandatory"
        arrstrTDStyle(intIndex) = "align='center'"
        intIndex += 1
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        strQuery = "Exec usp_Sel_Get_Task_Attributes " & m_lngProjectTypeId.ToString()

        'Set the Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBoxId
            .PrimaryKey = "Attributes"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVHeight = 240
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intTotalColumns - 2
            .TDStyleArray = arrstrTDStyle
            .returnHTML = True
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub Save_TaskAttributes()
        Dim strQuery As String = ""
        Dim strShowList As String = ""
        Dim strMandatoryList As String = ""

        strShowList = MyBase.GetFormValue("chkShow").ToString()
        strShowList = CommonFunctions.General.UnBuildQueryString(strShowList)
        strMandatoryList = MyBase.GetFormValue("chkMandatory").ToString()
        strMandatoryList = CommonFunctions.General.UnBuildQueryString(strMandatoryList)

        'Prefix and postfix the , to the list string
        strShowList = "," & strShowList & ","
        strMandatoryList = "," & strMandatoryList & ","

        strQuery = " EXEC usp_Upd_tbl_PRS_ProjectTypes_Configure " & m_lngProjectTypeId.ToString()
        'Attribute Phase
        If InStr(strShowList, "," & ATTRIBUTE_PHASE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        If InStr(strMandatoryList, "," & ATTRIBUTE_PHASE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        'Attribute Module
        If InStr(strShowList, "," & ATTRIBUTE_MODULE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        If InStr(strMandatoryList, "," & ATTRIBUTE_MODULE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        'Attribute Sub Project
        If InStr(strShowList, "," & ATTRIBUTE_SUBPROJECT & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        If InStr(strMandatoryList, "," & ATTRIBUTE_SUBPROJECT & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        'Attribute Milestone
        If InStr(strShowList, "," & ATTRIBUTE_MILESTONE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        If InStr(strMandatoryList, "," & ATTRIBUTE_MILESTONE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        'Attribute Change Request
        If InStr(strShowList, "," & ATTRIBUTE_CHANGE_REQUEST & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        If InStr(strMandatoryList, "," & ATTRIBUTE_CHANGE_REQUEST & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        'Attribute Feature
        If InStr(strShowList, "," & ATTRIBUTE_FEATURE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        If InStr(strMandatoryList, "," & ATTRIBUTE_FEATURE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        'Attribute Estimation Type
        If InStr(strShowList, "," & ATTRIBUTE_ESTIMATION_TYPE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        If InStr(strMandatoryList, "," & ATTRIBUTE_ESTIMATION_TYPE & ",") > 0 Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Added by NitinC on 09 April 2012 for WhizibleSEM 11.0 [Issue Fix 61180]
        Dim m_intFlag As String

        ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
        '' m_intFlag = CType(CommonFunction.Data.GetDataScalar("SELECT ISNULL(IsAgileMethodFollowed,0) FROM tbl_PRS_ProjectTypes WITH(NOLOCK) WHERE TypeID = " + m_lngProjectTypeId.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        m_intFlag = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PRS_ProjectTypes_IsAgileMethodFollowed " + m_lngProjectTypeId.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)

        If Args.DataReader.Item("Attributes").ToString().ToUpper = "PHASE" And m_intFlag = True Then
            If Args.ColIndex = 0 Then
                Cancel = True
            End If
        End If
        'End of Added by NitinC on 09 April 2012 for WhizibleSEM 11.0 [Issue Fix 61180]

        If Args.ColIndex = 1 Then
            Dim blnChecked As Boolean
            Dim strValue As String

            blnChecked = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Show"), "False"), Boolean)
            strValue = Args.DataReader.Item("Attributes").ToString()
            ''Commented and Added by NitinC on 09 April 2012 for WhizibleSEM 11.0 [Issue Fix 61180]
            'Args.StringToBeInserted = "<TD align='center'>"
            'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkShow", "chkShow", , blnChecked, strValue, , "OnClick=""javascript:chkShow_OnClick('" & Args.DataReader.Item("Attributes").ToString() & "')""", True)
            'Args.StringToBeInserted &= "</TD>"
            'Cancel = True
            If strValue.ToUpper = "PHASE" And m_intFlag = True Then
                Cancel = True
            Else
                Args.StringToBeInserted = "<TD align='center'>"
                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkShow", "chkShow", , blnChecked, strValue, , "OnClick=""javascript:chkShow_OnClick('" & Args.DataReader.Item("Attributes").ToString() & "')""", True)
                Args.StringToBeInserted &= "</TD>"
                Cancel = True
            End If
            ''End of Commented and Added by NitinC on 09 April 2012 for WhizibleSEM 11.0 [Issue Fix 61180]
        ElseIf Args.ColIndex = 2 Then
            ''Commented and Added by NitinC on 09 April 2012 for WhizibleSEM 11.0 [Issue Fix 61180]
            'If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Show"), "False"), Boolean) = False Then
            '    Args.IsCheckBoxChecked = False
            '    Args.IsCheckBoxDisabled = True
            'Else
            '    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Mandatory"), "False"), Boolean) = True Then
            '        Args.IsCheckBoxChecked = True
            '    End If
            'End If
            If m_intFlag = False Then
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Show"), "False"), Boolean) = False Then
                    Args.IsCheckBoxChecked = False
                    Args.IsCheckBoxDisabled = True
                Else
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Mandatory"), "False"), Boolean) = True Then
                        Args.IsCheckBoxChecked = True
                    End If
                End If
                ''Commented and Modified By Aniruddh Gujar on 08-May-2018 Purpose::Whizible Agile Changes
                'ElseIf Args.DataReader.Item("Attributes").ToString().ToUpper = "PHASE" And m_intFlag = True Then
                '    Cancel = True
            Else
                If Args.DataReader.Item("Attributes").ToString().ToUpper = "PHASE" Then
                    Cancel = True
                Else
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Mandatory"), "False"), Boolean) = True Then
                        Args.IsCheckBoxChecked = True
                    End If
                End If
                ''End of Commented and Modified By Aniruddh Gujar on 08-May-2018 Purpose::Whizible Agile Changes
            End If
            ''End of Commented and Added by NitinC on 09 April 2012 for WhizibleSEM 11.0 [Issue Fix 61180]
        End If
    End Sub
End Class
