Imports CommonEngines.General.cEventHandlers

'=====================================================================
' Class Name		    :	PM_ResourceTeamStructure_CommonPage
' Purpose				:	handles all controls on the page
' Description			:	
' Assumptions			:	None
' Dependencies			:	None
' Author				:	ArchanaN
' Created				:	19 Oct 2007
' Revisions				:	
'=====================================================================
Public Class PM_ResourceTeamStructure_CommonPage
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
    Public Const APP_TAG_TEAMSTRUCTURE As Long = 3855
    Public Const APP_TAG_TEAMSTRUCTURE_PROBABILITY As Long = 3222 '10126
    'Addition by SuchitraP on 17-Dec-2008 to prompt an alert when resource allocation W/F is on
    Private m_strMode As String
    Private m_strOperation As String
    'End of addition by SuchitraP on 17-Dec-2008
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        'Commented and modified by SuchitraP on 17-Dec-2008 for deletion purpose
        'MyBase.strListPage = "../General/CommonList.aspx"
        MyBase.strListPage = "../HR/HR_CommonList.aspx"
        'End by SuchitraP on 17-Dec-2008
        MyBase.strFormPage = "PM_ResourceTeamStructure_CommonPage.aspx"



        'Addition by SuchitraP on 17-Dec-2008 to prompt an alert when resource allocation W/F is on
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") <> "" Then
            m_strMode = Request.QueryString("Mode")
        Else
            m_strMode = ""
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Operation"), "") <> "" Then
            m_strOperation = Request.QueryString("Operation")
        Else
            m_strOperation = ""
        End If
        'End of addition by SuchitraP on 17-Dec-2008

        'Addition by SuchitraP on 10-dec-2008 for Freezing the Staffing plan
        If CommonFunction.General.CheckIsNothing(Request.QueryString("IsFreezed"), "") <> "" Then
            Dim strTeamStructureID As String
            strTeamStructureID = Request.QueryString("TeamStructureID_PK")
            If Request.QueryString("IsFreezed") = "1" Then
                Call UpdateStatus(strTeamStructureID)
            End If
        End If
        'End of addition by SuchitraP on 10-Dec-2008

        If Request.QueryString("FromXML") = "1" Then
            Dim strTeamStructureID, strRoleID, strToolID, strResourceInDate, strResourceOutDate As String
            strRoleID = HttpContext.Current.Request.QueryString("RoleID")
            strToolID = HttpContext.Current.Request.QueryString("ToolID")
            strResourceInDate = HttpContext.Current.Request.QueryString("TentativeStartDate")
            strResourceOutDate = HttpContext.Current.Request.QueryString("TentativeEndDate")
            strTeamStructureID = HttpContext.Current.Request.QueryString("TeamStructureID")

            Response.Write(chkDuplication(strTeamStructureID, strRoleID, strToolID, strResourceInDate, strResourceOutDate))
            Response.End()
        Else
            MyBase.Page_Load(sender, e)
        End If
    End Sub
 
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cPM_ResourceTeamStructure_cPlotGrid(m_objSubTagGlobal)
    End Function


    Private strSQL As String
    'Addition by SuchitraP on 10-dec-2008 for updating staffing plan as freezed
    Private Function UpdateStatus(ByVal strTeamStructureID As String)
        Dim strSQL As String
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "UPDATE tbl_PM_TeamStructure SET IsFreezed=1 WHERE TeamStructureID=" + strTeamStructureID
        strSQL = "usp_upd_tbl_PM_TeamStructure_IsFreezed " + strTeamStructureID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)

    End Function
    'End of Addition by SuchitraP on 10-dec-2008 
    Public Function chkDuplication(ByVal strTeamStructureID As String, ByVal strRoleID As String, ByVal strToolID As String, ByVal strResourceINDate As String, ByVal strResourceOutDate As String) As String
        Dim strSQL1, strProjectID As String
        strProjectID = HttpContext.Current.Session("intProjectID").ToString
        If strTeamStructureID = "" Then
            strTeamStructureID = "NULL"
        End If

        strSQL1 = " Usp_Get_Role_Skill " + strTeamStructureID + "," + strRoleID + "," + strToolID + ",'" + strResourceINDate + "','" + strResourceOutDate + "'," + strProjectID
        chkDuplication = CType(CommonFunction.Data.GetDataScalar(strSQL1, True), String)
    End Function

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        If WhizGlobal.TagID = APP_TAG_TEAMSTRUCTURE And PrimaryKey <> "" Then
            strSQL = "usp_Ins_tbl_PM_TeamStructure_Distribution " + PrimaryKey + ",'" + Request.Form("TentativeStartDate") + "','" + Request.Form("TentativeEndDate") + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        End If
        'CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        RedirectToCL = False
    End Function
    Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        'If PrimaryKey <> "" Then
        '    Dim strGanttChartType As String = "1"
        '    Dim arrGC() As String
        '    arrGC = CommonFunction.General.CheckIsNothing(Request.QueryString("GanttChartType"), "1").Split(",")

        '    strGanttChartType = arrGC(0)

        '    Response.Write("<iframe name='frmGantt'  id='frmGantt'   src='../Home/RM_GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + APP_TAG_TEAMSTRUCTURE.ToString + "&GanttChartType=" + strGanttChartType + "&TeamStructureID=" + PrimaryKey + "' scrolling='no' marginwidth='0' marginheight='0' onLoad='calcHeight()' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>") 'onmouseover='HideFrame()''onLoad='calcHeight()'
        'End If

    End Sub
    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strTentativeEndDate As String
        Dim strSQL As String

        If WhizGlobal.TagID = APP_TAG_TEAMSTRUCTURE And IsEditMode = False Then
            ''strSQL = "SELECT dbo.udf_Get_EndDate(TentativeStartDate,ApproxDuration) FROM tbl_PM_teamStructure WHERE  TeamStructureID=" + PrimaryKey.ToString
            ''strTentativeEndDate = CType(CommonFunction.Data.GetDataScalar(strSQL, True), String)
            'If PrimaryKey Is Nothing Then
            strSQL = "usp_Ins_tbl_PM_TeamStructure_Distribution " + PrimaryKey + ",'" + Request.Form("TentativeStartDate") + "','" + Request.Form("TentativeEndDate") + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            '  EndIf

           

        End If

        strSQL = "usp_Ins_tbl_PM_TeamStructure_Details " + PrimaryKey + ",N'" + WhizGlobal.UserName + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)

        'Commented by SuchitraP on 27-Dec-2007
        'If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = APP_TAG_TEAMSTRUCTURE_PROBABILITY Then

        '    'To enable publish link for respected  TeamStructure
        '    Dim strSQL As String
        '    strSQL = "Update tbl_PM_TeamStructure Set Published = 0 Where TeamStructureID = "
        '    strSQL += " (Select TeamStructureID From tbl_PM_TeamStructure_Probability Where ProbabilityID = " + PrimaryKey + ") "
        '    CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        'End If
        'End of Comment By SuchitraP on 27-Dec-2007

        'Commented by ShraddhaM for Whiziblesem8.0 on 14,Nov 2008
        ''Addition by SuchitraP on 27-Dec-2007 
        ''Purpose:To save engagement probability values for particular Team Structure
        'Dim strProbabilityBy As String
        'Dim strCreatedBy As String
        'Dim strEngagementProbability As String
        'Dim strComments As String
        'Dim strQuery As String
        'Dim dr As IDataReader

        'strProbabilityBy = Session("intUserID").ToString
        'strCreatedBy = Session("strUserName").ToString
        'strEngagementProbability = HttpContext.Current.Request.Form("NonDatabase9")
        'strComments = HttpContext.Current.Request.Form("NonDatabase10")

        'If Not strEngagementProbability Is Nothing Or Not strComments Is Nothing Then
        '    If strEngagementProbability.Trim <> "" Then
        '        If strComments <> "" Then
        '            strQuery = "usp_Ins_tbl_PM_TeamStructure_Probability " + strProbabilityBy + ",'" + strCreatedBy + "'," + PrimaryKey + "," + strEngagementProbability + ",'" + strComments + "'"
        '            CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        '        End If
        '    End If
        'End If
        ''End of adition by SuchitraP on 27-Dec-2007 
        'End of comment by ShraddhaM for Whiziblesem8.0 on 14,Nov 2008
    End Function
    'Addition done by SuchitraP on 27-Dec-2007
    'Purpose:To hide the controls when value for that control is blank
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cPM_ResourceTeamStructure_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    'End of addition by SuchitraP on 27-Dec-2007
    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cPM_ResourceTeamStructure_CommonPageSubTagCLSQL(m_objSubTagGlobal)
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        CommonFunction.General.WriteHTML("<script language=javascript>")
        CommonFunction.General.WriteHTML("function IsInvalidData()")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("var frmObj=document.getElementById('frmCommonPage');")
        CommonFunction.General.WriteHTML("var str, obj;")
        CommonFunction.General.WriteHTML("for (var i=0;i<frmObj.length;i++)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("str = frmObj.elements[i].name")
        CommonFunction.General.WriteHTML("if (str.search('txtMonth') >= 0)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("obj = GetObjectReference('frmCommonPage', frmObj.elements[i].name);")
        CommonFunction.General.WriteHTML("if (disallowNegativeNumeric(obj, 'Please enter only positive Numeric value.',true))")
        CommonFunction.General.WriteHTML("{return true; }")
        CommonFunction.General.WriteHTML("if (obj.value > 100)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("alert(""'Monthly Distribution' value should be in the range of (0-100)."");")
        CommonFunction.General.WriteHTML("setFocus(obj);")
        CommonFunction.General.WriteHTML("return true;")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("return false;")
        'Addition by SuchitraP on 17-Dec-2008 to prompt an alert when resource allocation W/F is on
        CommonFunction.General.WriteHTML("}")
        Dim strSQL As String
        Dim strAllowResourceAllocation As String

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT AllowResourceAllocation FROM tbl_PM_CompanyInformation"
        strSQL = "usp_sel_tbl_PM_CompanyInformation_ResourceTeamStructure_AllowResourceAllocation"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


        strAllowResourceAllocation = CommonFunction.Data.GetDataScalar(strSQL, True)
        If strAllowResourceAllocation = True And m_strMode.ToUpper = "ADD_NEW" And m_strOperation.ToUpper <> "SAVE" Then
            CommonFunction.General.WriteHTML("alert('Resource Allocation Workflow is on,Staffing plan count will not be considered in Resource staffing plan.')")
        End If
        'End of addition by SuchitraP on 17-Dec-2008
        CommonFunction.General.WriteHTML("</script>")
    End Function


End Class
Public Class cPM_ResourceTeamStructure_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim IsDistributionSave As String

        IsDistributionSave = HttpContext.Current.Request.QueryString("DistributionSave")
        If IsDistributionSave = "1" Then
            Call Distribution_Save()
        End If
    End Sub
    '=====================================================================
    ' Procedure Name		:   Distribution_Save	
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the subtag
    ' Description			:	
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	ArchanaN
    ' Created				:	19 Oct 2007
    ' Revisions				:	
    '=====================================================================  
    Protected Sub Distribution_Save()
        Dim strPKValues As String
        Dim strPKValuesArray() As String
        Dim ColumnName As String
        Dim ColumnValues As String
        Dim PKCounter As Integer = 0
        Dim MonthCounter As Integer
        Dim strUpdateQuery As String
        strPKValues = HttpContext.Current.Request.Form("hidPKValues")
        strPKValuesArray = strPKValues.Split(","c)

        While PKCounter < strPKValuesArray.Length
            MonthCounter = 1
            While MonthCounter <= 12
                Select Case MonthCounter
                    Case 1
                        If Not HttpContext.Current.Request.Form("txtMonthJan" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthJan" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidJan" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidJan" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Jan = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 2
                        If Not HttpContext.Current.Request.Form("txtMonthFeb" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthFeb" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidFeb" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidFeb" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Feb = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 3
                        If Not HttpContext.Current.Request.Form("txtMonthMar" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthMar" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidMar" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidMar" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Mar = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 4
                        If Not HttpContext.Current.Request.Form("txtMonthApr" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthApr" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidApr" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidApr" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Apr = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 5
                        If Not HttpContext.Current.Request.Form("txtMonthMay" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthMay" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidMay" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidMay" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET May = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 6
                        If Not HttpContext.Current.Request.Form("txtMonthJun" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthJun" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidJun" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidJun" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Jun = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 7
                        If Not HttpContext.Current.Request.Form("txtMonthJul" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthJul" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidJul" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidJul" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Jul = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 8
                        If Not HttpContext.Current.Request.Form("txtMonthAug" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthAug" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidAug" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidAug" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Aug = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 9
                        If Not HttpContext.Current.Request.Form("txtMonthSep" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthSep" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidSep" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidSep" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Sep = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 10
                        If Not HttpContext.Current.Request.Form("txtMonthOct" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthOct" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidOct" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidOct" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Oct = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 11
                        If Not HttpContext.Current.Request.Form("txtMonthNov" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthNov" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidNov" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidNov" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Nov = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)

                    Case 12
                        If Not HttpContext.Current.Request.Form("txtMonthDec" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("txtMonthDec" + strPKValuesArray(PKCounter))
                            If ColumnValues.Trim() = "" Then
                                ColumnValues = "0"
                            End If
                        ElseIf Not HttpContext.Current.Request.Form("hidDec" + strPKValuesArray(PKCounter)) Is Nothing Then

                            ColumnValues = HttpContext.Current.Request.Form("hidDec" + strPKValuesArray(PKCounter))
                        End If
                        strUpdateQuery = "UPDATE tbl_PM_TeamStructure_Distribution SET Dec = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)


                End Select

                MonthCounter = MonthCounter + 1
            End While
            PKCounter = PKCounter + 1
        End While
        'CommonFunctions.General.WriteHTML("<script language=javascript>")
        'CommonFunctions.General.WriteHTML("window.location.href=window.location.href;")
        'CommonFunctions.General.WriteHTML("</script>")
    End Sub
End Class

Public Class cPM_ResourceTeamStructure_cPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim txtBoxName As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.DataField.ToUpper = "JAN" Then
            If Args.DataReader("Jan").ToString <> "" Then

                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Jan").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

            End If

        End If
        If Args.DataField.ToUpper = "FEB" Then
            If Args.DataReader("Feb").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Feb").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

            End If

        End If
        If Args.DataField.ToUpper = "MAR" Then
            If Args.DataReader("Mar").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Mar").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

            End If

        End If
        If Args.DataField.ToUpper = "APR" Then
            If Args.DataReader("Apr").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Apr").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

            End If

        End If
        If Args.DataField.ToUpper = "MAY" Then
            If Args.DataReader("May").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("May").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If

        End If
        If Args.DataField.ToUpper = "JUN" Then
            If Args.DataReader("Jun").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Jun").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If

        End If
        If Args.DataField.ToUpper = "JUL" Then
            If Args.DataReader("Jul").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Jul").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If

        End If
        If Args.DataField.ToUpper = "AUG" Then
            If Args.DataReader("Aug").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Aug").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If

        End If
        If Args.DataField.ToUpper = "SEP" Then
            If Args.DataReader("Sep").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Sep").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If


        End If
        If Args.DataField.ToUpper = "OCT" Then
            If Args.DataReader("Oct").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Oct").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If

        End If
        If Args.DataField.ToUpper = "NOV" Then
            If Args.DataReader("Nov").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Nov").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If

        End If
        If Args.DataField.ToUpper = "DEC" Then
            If Args.DataReader("Dec").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Dec").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If

        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.PrimaryKeyName.ToUpper = "DISTRIBUTIONID" Then
            CommonFunctions.General.WriteHTML("<INPUT type=hidden name=hidPKValues id=hidPKValues value=" + Args.DataReader("DistributionID").ToString + " />")
        End If
    End Sub

End Class
'Addition by SuchitraP on 27-Dec-2007 
'Purpose:To hide the controls when value for that control is blank
Public Class cPM_ResourceTeamStructure_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Private EngProb As String
    Private CreatedBy As String
    Private CreatedDate As String
    Private Comments As String
    'Added By ShraddhaM
    Private EngProbNew As String
    Private CreatedByNew As String
    Private CommentsNew As String
    Private CreatedDateNew As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        'Dim dr As IDataReader
        'Dim dr1 As IDataReader

        'If Args.ControlName = "NonDatabase4" Or Args.ControlName = "NonDatabase5" Or Args.ControlName = "NonDatabase7" Or Args.ControlName = "NonDatabase8" Then
        '    'Cancel = True
        '    If EngProb = "" Then
        '        dr = CommonFunction.Data.GetDataReader("Select EngagementProbability, CreatedBy, Comments,CreatedDate from tbl_PM_TeamStructure_Probability Where ProbabilityID = (SELECT MAX(ProbabilityID) - 1 FROM tbl_PM_TeamStructure_Probability WHERE TeamStructureID = " + drControls("TeamStructureID").ToString + ") AND TeamStructureID = " + drControls("TeamStructureID").ToString, True)  ''remove hard code

        '        dr1 = CommonFunction.Data.GetDataReader("Select EngagementProbability, CreatedBy, Comments,CreatedDate from tbl_PM_TeamStructure_Probability Where ProbabilityID = (SELECT MAX(ProbabilityID) FROM tbl_PM_TeamStructure_Probability WHERE TeamStructureID = " + drControls("TeamStructureID").ToString + ") AND TeamStructureID = " + drControls("TeamStructureID").ToString, True)

        '        If dr1.Read Then
        '            EngProbNew = dr1("EngagementProbability").ToString
        '            CreatedByNew = dr1("CreatedBy").ToString
        '            CommentsNew = dr1("Comments").ToString
        '            CreatedDateNew = CommonFunctions.Dates.CGetDate(CType(dr1("CreatedDate"), Date))

        '        End If

        '        If dr.Read Then
        '            EngProb = dr("EngagementProbability").ToString
        '            CreatedBy = dr("CreatedBy").ToString
        '            Comments = dr("Comments").ToString
        '            CreatedDate = CommonFunctions.Dates.CGetDate(CType(dr("CreatedDate"), Date))

        '        End If
        '        CommonFunction.Data.DisposeDataReader(dr)
        '    End If
        '    If EngProb = "" Then
        '        Cancel = True
        '    Else
        '        Select Case Args.ControlName.ToUpper
        '            Case "NONDATABASE5"
        '                Cancel = True
        '            Case "NONDATABASE7"
        '                If CreatedBy = "" Then Cancel = True
        '            Case "NONDATABASE8"
        '                Cancel = True
        '        End Select
        '    End If
        'End If
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

        '    If Args.ControlName = "NonDatabase4" Or Args.ControlName = "NonDatabase5" Or Args.ControlName = "NonDatabase7" Or Args.ControlName = "NonDatabase8" Then

        '        If EngProb = "" Then
        '            Cancel = True
        '        Else
        '            Select Case Args.ControlName.ToUpper
        '                Case "NONDATABASE4"
        '                    If EngProbNew <> EngProb Or CommentsNew <> Comments Then
        '                        Args.DefaultValue = "1-" + EngProb
        '                    End If

        '                Case "NONDATABASE5"
        '                    If Comments = "" Then Cancel = True
        '                Case "NONDATABASE7"
        '                    If CreatedBy = "" Then Cancel = True
        '                    If CommentsNew <> Comments Or EngProbNew <> EngProb Then
        '                        Args.DefaultValue = "1-" + CreatedBy + "&nbsp;&nbsp;&nbsp;[" + CreatedDate + "]"
        '                    End If

        '                Case "NONDATABASE8"
        '                    If Comments = "" Then
        '                        Cancel = True
        '                    Else
        '                        If CommentsNew <> Comments Or EngProbNew <> EngProb Then
        '                            Args.DefaultValue = "1-" + Comments
        '                        End If
        '                    End If
        '            End Select
        '        End If
        '    End If
        'Addition by SuchitraP on 10-dec-2008 for disabling controls after staffing plan is freezed
        ''Dim strIsFreezed As String
        ''strIsFreezed = CommonFunction.Data.GetDataScalar("SELECT ISNULL(IsFreezed,0) IsFreezed FROM tbl_PM_TeamStructure WHERE TeamStructureID=" + Args.PrimaryKeyValue, True)
        ''If strIsFreezed = True Then
        ''    Args.DisableInEditMode = True
        ''End If
        'End of addition by SuchitraP on 10-Dec-2008
    End Sub
End Class
'End of addition by SuchitraP on 27-Dec-2007 