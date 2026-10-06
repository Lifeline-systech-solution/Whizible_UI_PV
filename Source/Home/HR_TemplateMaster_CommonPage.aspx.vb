Option Strict Off
Imports CommonEngines.General.cEventHandlers



Public Class cHR_TemplateMaster_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If WhizGlobal.ParentTagID <> 0 Then
            Dim strSQL As String = ""
            Dim strSQLIsApplicable As String = ""
            Dim strSQLInrospection As String = ""
            Dim intSectionID_PK As String
            Dim BooleanIsApplicable As Boolean
            strSQLIsApplicable = "SELECT IsApplicable from tbl_HR_TemplateSections where SectionID= "
            intSectionID_PK = HttpContext.Current.Request.QueryString("SectionID_PK")
            strSQLIsApplicable = strSQLIsApplicable + intSectionID_PK

            Dim Dr As Boolean = CommonFunction.Data.GetDataScalar(strSQL, True)

            Dim Dr2 As Boolean = CommonFunction.Data.GetDataScalar(strSQLIsApplicable, True).ToString


            If Args.ControlName.ToUpper = "ISAPPLICABLE" Then
                If Dr = True Then
                    Args.Editable = False
                End If
            End If

            If Args.ControlName.ToUpper = "ORDERNUMBER" Then
                If Dr = True Then
                    Args.Editable = False
                End If
            End If
        End If

    End Sub

End Class


Public Class HR_TemplateMaster_CommonPage
    Inherits CommonPage
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "HR_TemplateMaster_CommonList.aspx"
        MyBase.strFormPage = "HR_TemplateMaster_CommonPage.aspx"
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        If Not Request.QueryString("Operation") Is Nothing Then
            If Request.QueryString("Operation").ToUpper = "SAVE" Or Request.QueryString("Operation").ToUpper = "SAVEANDADD" Then
                CommonFunction.Data.GetDataScalar("Update tbl_HR_TemplateMaster  set IsDefault=0 where TemplateID<>" + strPrimaryKey, True)
            End If
        End If
        'Purpose to add the details inserted by user into the tbl_PA_TemplateSections
        If m_objGlobal.ParentTagID = 0 Then
            If (HttpContext.Current.Request.QueryString("IsSubTagDynamicLink") = "1") Then
                Dim strSQL As String = ""
                Dim clrSQL As String = ""
                Dim strLinkID As String = ""
                Dim strInsSQL As String = ""
                Dim intloopCount As Integer = 0
                Dim intCount As Integer
                Dim count As Integer = 0
                Dim intApplicablesLength As Integer
                Dim intOrderNumbersLength As Integer
                Dim intdifference As Integer = 0
                Dim strOrderNumber As String = ""
                Dim stOrderNumbers As String = ""
                Dim strIsMandatory As String = ""
                Dim strIsApplicable As String = ""
                Dim strTemplateSection As String = ""
                Dim strListOfEnabledTextBox As String
                Dim strMaxLimit As String = ""
                Dim stMaxLimitNumber As String = ""
                intCount = 0

                Dim compareintApplicables As String = ""

                clrSQL = " UPDATE tbl_HR_TemplateSections  SET IsApplicable=0 WHERE TemplateID = "
                clrSQL = clrSQL + strPrimaryKey
                CommonFunction.Data.InsertOrUpdateData(clrSQL, True)
                ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                ''strSQL = " Select UniqueID from tbl_UI_subTag_Dynamic_Links WITH (NOLOCK) where SubTagid = 3310 and ClientSideFunctionName like 'ValidateControl'"
                strSQL = "sel_tbl_UI_subTag_Dynamic_Links_UniqueID"
                ''end of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                strLinkID = CommonFunctions.Data.GetDataScalar(strSQL, True)
                If strLinkID = HttpContext.Current.Request.QueryString("DYNAMIC_LINK_ID") Then
                    strIsApplicable = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkIsApplicable"), "").ToString
                    Dim strIsApplicables As String() = strIsApplicable.Split(",")
                    Dim strOrder As String = ""
                    Dim NoofAppli = strIsApplicables.Length
                    Dim NoofApplicables = strIsApplicable.Length
                    count = 0


                    For intloopCount = 0 To NoofAppli - 1
                        strMaxLimit = ""
                        strOrderNumber = ""
                        strMaxLimit = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtMaxLimit_" + strIsApplicables(count).ToString))
                        strOrderNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNumber_" + strIsApplicables(count).ToString))
                        strSQL = "usp_UPD_tbl_HR_TemplateSections "

                        strSQL = strSQL + strIsApplicables(count).ToString + "," + strIsApplicables(count).ToString + "," + strOrderNumber.ToString + "," + strMaxLimit.ToString + "," + strPrimaryKey
                        CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                        count = count + 1
                        strMaxLimit = ""
                        strOrderNumber = ""
                    Next

                End If

            End If

        End If

    End Function
    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ClientSideFunctionName.ToUpper = "VALIDATECONTROL" Then
            Args.ToBeInsertedInFunction = "" + vbCrLf
            Args.ToBeInsertedInFunction += "if(!ValidateControl()) return;" + vbCrLf
            Args.ToBeInsertedInFunction += "" + vbCrLf


        End If
    End Sub


    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cHR_TemplateMaster_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cHR_TemplateMaster_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function



    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cHR_TemplateMaster_CommonPage(m_objSubTagGlobal)
    End Function

    'addition end by ninad ' Requirement Tag :WAF3_PB_33 
End Class
Public Class cHR_TemplateMaster_CommonPage
    Inherits CommonEngine.CommonList.cPlotGrid
    'To declare global variables
    Protected strOrderNumber As String = ""
    Protected strIsApplicable As String = ""
    Protected strSectionID As String = ""
    Protected strEnableList As String = ""
    Protected strCaption As String = ""
    Protected strMaxLimit As String = ""

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim chkApplicable As Boolean
        Dim m_TagID As String = ""
        Dim boolIsDisabled As Boolean

        boolIsDisabled = True

        m_TagID = WhizGlobal.TagID
        If m_TagID = "3310" Then
            chkApplicable = Args.DataReader("ISAPPLICABLE")
        End If
        If m_TagID = "3310" Then
            If Args.DataField.ToUpper = "ISAPPLICABLE" Then
                Args.IgnoreActualValue = True
                Cancel = True
                Args.StringToBeInserted = "<TD   align=Center >" + CommonFunctions.HTMLControls.DrawCheckBox("chkIsApplicable", "chkIsApplicable", , chkApplicable, CType(Args.DataReader("MenuGroupID"), String), False, "Onclick='Javascript:Applicable_Click(id,value)' ", True) + "</TD>"
            End If

            If Args.DataField.ToUpper = "ORDERNUMBER" Then
                Args.IgnoreActualValue = True
                Cancel = True
                If chkApplicable = True Then
                    boolIsDisabled = "false"
                End If
                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                ''Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber_" + Args.DataReader("MenuGroupID").ToString, "txtOrderNumber_" + Args.DataReader("MenuGroupID").ToString, , 50, 4, Args.DataReader("OrderNumber").ToString, "right", , boolIsDisabled, , , , , True) + "</td>" '+ CommonFunctions.HTMLControls.DrawImage("imgOrderNumber" + id_txtOrderNumber.ToString, "imgOrderNumber" + id_txtOrderNumber.ToString, "", "", 5, 5, , True, ) + "</TD>"
                Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber_" + Args.DataReader("MenuGroupID").ToString, "txtOrderNumber_" + Args.DataReader("MenuGroupID").ToString, , 50, 4, Args.DataReader("OrderNumber").ToString, "right", , boolIsDisabled, , , , , True, EnableHTMLEncode:=True) + "</td>" '+ CommonFunctions.HTMLControls.DrawImage("imgOrderNumber" + id_txtOrderNumber.ToString, "imgOrderNumber" + id_txtOrderNumber.ToString, "", "", 5, 5, , True, ) + "</TD>"
            End If

            If Args.DataField.ToUpper = "MAXCONTROLLIMIT" Then
                Args.IgnoreActualValue = True
                Cancel = True
                If chkApplicable = True Then
                    boolIsDisabled = "false"
                End If
                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                '' Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtMaxLimit_" + Args.DataReader("MenuGroupID").ToString, "txtMaxLimit_" + Args.DataReader("MenuGroupID").ToString, , 50, 4, Args.DataReader("MaxControlLimit").ToString, "right", , boolIsDisabled, , , , , True) + "</td>"  ' + CommonFunctions.HTMLControls.DrawImage("imgMaxLimit" + id_txtOrderNumber.ToString, "imgMaxLimit" + id_txtOrderNumber.ToString, "", "", 5, 5, , True, ) + "</TD>"
                Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtMaxLimit_" + Args.DataReader("MenuGroupID").ToString, "txtMaxLimit_" + Args.DataReader("MenuGroupID").ToString, , 50, 4, Args.DataReader("MaxControlLimit").ToString, "right", , boolIsDisabled, , , , , True, EnableHTMLEncode:=True) + "</td>"  ' + CommonFunctions.HTMLControls.DrawImage("imgMaxLimit" + id_txtOrderNumber.ToString, "imgMaxLimit" + id_txtOrderNumber.ToString, "", "", 5, 5, , True, ) + "</TD>"
            End If
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            'CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtMenuGroupID", "txtMenuGroupID", , 50, 4, Args.DataReader("MenuGroupID").ToString, "right", , , , , True, , True))
            'CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , 50, 4, m_TagID.ToString, "right", , , , , True, , True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtMenuGroupID", "txtMenuGroupID", , 50, 4, Args.DataReader("MenuGroupID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , 50, 4, m_TagID.ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))

        End If
    End Sub
    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If WhizGlobal.TagID = 3310 Then
            Dim strapplicable As String
            Dim strisordernumber As String
            Dim strtemplatesection As String
            Dim strSectionIDList As String
            Dim strtemplatesectionIDList As String
            Dim strCaption1 As String
            'start
            If strCaption.Length > 0 Then
                strCaption1 = CommonFunctions.General.BuildQueryString(strCaption).Substring(0, strCaption.Length - 1)
            End If
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidCaption", "txtHidCaption", , , , strCaption1, "left", , , , , True, , True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidCaption", "txtHidCaption", , , , strCaption1, "left", , , , , True, , True, EnableHTMLEncode:=True))
            'end
            If strIsApplicable.Length > 0 Then
                '  strapplicable = CommonFunction.General.CheckIsNothing(Request.Form(), "").ToString
                strapplicable = CommonFunctions.General.BuildQueryString(strIsApplicable).Substring(0, strIsApplicable.Length - 1)
            End If
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidIsApplicable", "txtHidIsApplicable", , , , strapplicable, "right", , , , , True, , True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidIsApplicable", "txtHidIsApplicable", , , , strapplicable, "right", , , , , True, , True, EnableHTMLEncode:=True))
            If strOrderNumber.Length > 0 Then
                strisordernumber = CommonFunctions.General.BuildQueryString(strOrderNumber).Substring(0, strOrderNumber.Length - 1)
            End If
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidstrOrderNumber", "txtHidstrOrderNumber", , , , strisordernumber, "right", , , , , True, , True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidstrOrderNumber", "txtHidstrOrderNumber", , , , strisordernumber, "right", , , , , True, , True, EnableHTMLEncode:=True))
            If strSectionID.Length > 0 Then
                strtemplatesection = CommonFunctions.General.BuildQueryString(strSectionID).Substring(0, strSectionID.Length - 1)
            End If
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidstrTemplateSectionID", "txtHidstrTemplateSectionID", , , , strtemplatesection, "right", , , , , True, , True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidstrTemplateSectionID", "txtHidstrTemplateSectionID", , , , strtemplatesection, "right", , , , , True, , True, EnableHTMLEncode:=True))

            If strEnableList.Length > 0 Then
                strtemplatesectionIDList = CommonFunctions.General.BuildQueryString(strEnableList).Substring(0, strEnableList.Length - 1)
            End If
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidstrSectionID", "txtHidstrSectionID", , , , strtemplatesection, "right", , , , , True, , True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidstrSectionID", "txtHidstrSectionID", , , , strtemplatesection, "right", , , , , True, , True, EnableHTMLEncode:=True))

            If strEnableList.Length > 0 Then
                strSectionIDList = CommonFunctions.General.BuildQueryString(strEnableList).Substring(0, strEnableList.Length - 1)
            End If
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidstrSectionIDList", "txtHidstrSectionIDList", , , , strSectionIDList, "right", , , , , True, , True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHidstrSectionIDList", "txtHidstrSectionIDList", , , , strSectionIDList, "right", , , , , True, , True, EnableHTMLEncode:=True))


        End If

    End Sub

    Protected Overrides Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.TagID = 3310 Then
            strIsApplicable += CType(CommonFunction.General.CheckIsNothing(Args.DataReader("IsApplicable"), "False"), String) + ","
        End If
        If WhizGlobal.TagID = 3310 Then
            strSectionID += CType(CommonFunction.General.CheckIsNothing(Args.DataReader("SectionID"), "False"), String) + ","
        End If
    End Sub

End Class
