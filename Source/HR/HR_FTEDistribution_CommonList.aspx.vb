Imports CommonEngines.General.cEventHandlers

'=====================================================================
' Class	Name	        :	HR_FTEDistribution_CommonList
' Purpose				:	Page for soft booking monthly distribution  
' Description			:	Same as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	ShraddhaM
' Created				:	12,Oct 2007
' Revisions				:	
'=====================================================================
Public Class HR_FTEDistribution_CommonList
    Inherits CommonList

    Private Const APP_TAG_SOFTBOOKING As Long = 3859
    Private Const APP_TAG_OPPORTUNITY As Long = 3851
    Private Const APP_TAG_TEAMSTRUCTURE As Long = 3855
    Private m_strMainTableName As String
    Private m_strPKColName As String
    Private m_strResourceDemand_TagID As String
    Private strPKID As String

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

    Protected Overrides Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        m_strResourceDemand_TagID = Request.QueryString("ResourceDemand_TagID")
        If m_strResourceDemand_TagID Is Nothing OrElse m_strResourceDemand_TagID = "" Then
            m_strResourceDemand_TagID = Request.Form("hidResourceDemand_TagID")
        End If
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strListPage = "HR_FTEDistribution_CommonList.aspx"

        MyBase.Page_Load(sender, e)






    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New HR_FTEDistribution_cPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Select Case CType(m_strResourceDemand_TagID, Long)
            Case APP_TAG_SOFTBOOKING
                m_strMainTableName = "tbl_RM_SoftBooking_Distribution"
                m_strPKColName = "DistributionID"
            Case APP_TAG_OPPORTUNITY
                m_strMainTableName = "tbl_RM_Pipeline_Distribution"
                m_strPKColName = "DistributionID"
            Case APP_TAG_TEAMSTRUCTURE
                m_strMainTableName = "tbl_PM_TeamStructure_Distribution"
                m_strPKColName = "DistributionID"
        End Select

        Dim IsDistributionSave As String
        IsDistributionSave = HttpContext.Current.Request.QueryString("DistributionSave")
        If IsDistributionSave = "1" Then
            Call Distribution_Save()
            If CType(m_strResourceDemand_TagID, Long) = 3851 Then 'APP_TAG_OPPORTUNITY 
                Call SyncDistributionWithPipeline()
            End If

        End If

        Return New HR_FTEDistributionCLSQL(MyBase.m_objGlobal)
    End Function
    Private Sub SyncDistributionWithPipeline()
        CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_RM_SoftBooking_Distribution_Sync " + Request.Form("hidPKID"), MyBase.UseSQL)
    End Sub
    Private Sub Distribution_Save()

        '====================================================================
        ' Procedure Name        :  Distribution_Save
        ' Parameters Passed     :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To updates monthly distribution in sub tab.
        ' Description           :  same as above 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  12,Oct 2007
        ' Revisions             :  
        '=====================================================================
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Jan = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Feb = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Mar = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Apr = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET May = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Jun = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Jul = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Aug = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Sep = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Oct = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Nov = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE " + m_strMainTableName + " SET Dec = " + ColumnValues + " WHERE " + m_strPKColName + " = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)


                End Select

                MonthCounter = MonthCounter + 1
            End While
            PKCounter = PKCounter + 1
        End While

    End Sub



    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Args.HTMLLegend = " "
        Cancel = True
    End Sub

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim IsDistributionSave As String
        Dim strFrom As String
        Dim strQuery As String
        Dim fltTotalFTE As Double

        strPKID = HttpContext.Current.Request.QueryString("PKID")

        If strPKID Is Nothing OrElse strPKID = "" Then
            strPKID = HttpContext.Current.Request.Form("hidPKID")
        End If
        If m_strResourceDemand_TagID = "3855" Then
            ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            ''strQuery = "SELECT TotalFTE FROM tbl_PM_TeamStructure WHERE TeamStructureID = " + strPKID
            strQuery = "usp_sel_tbl_PM_TeamStructure_TotalFTE " + strPKID
            ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ElseIf m_strResourceDemand_TagID = "3851" Then
            ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            ''strQuery = "SELECT TotalFTE FROM tbl_RM_Pipeline WHERE PipelineID = " + strPKID
            strQuery = "usp_sel_tbl_RM_Pipeline_TotalFTE " + strPKID
            ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        End If

        'Commented and modified by SuchitraP on 20 Feb 2008 
        'Purpose:To avoid page crash when when TotalFTE is null
        'fltTotalFTE = CType(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), Double)
        fltTotalFTE = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Double)
        'End of modification by SuchitraP on 20 Feb 2008 

        IsDistributionSave = HttpContext.Current.Request.QueryString("DistributionSave")
        strFrom = HttpContext.Current.Request.QueryString("From")
        CommonFunction.General.WriteHTML("<script language=javascript>")
        If IsDistributionSave = "1" Then
            If strFrom = "Save" Then
                Select Case CType(m_strResourceDemand_TagID, Long)
                    'Case APP_TAG_SOFTBOOKING
                    '    CommonFunction.General.WriteHTML("window.opener.location.href='../General/CommonList.aspx?FromWhere=RM&MasterTagId=3859';")
                    'Case APP_TAG_TEAMSTRUCTURE
                    '        CommonFunction.General.WriteHTML("window.opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=3855';")

                End Select
            ElseIf strFrom = "SaveClose" Then
                Select Case CType(m_strResourceDemand_TagID, Long)
                    Case APP_TAG_SOFTBOOKING
                        'CommonFunction.General.WriteHTML("window.opener.location.href='../General/CommonList.aspx?FromWhere=RM&MasterTagId=3859';")
                        CommonFunction.General.WriteHTML("window.close();")

                    Case APP_TAG_TEAMSTRUCTURE
                        'CommonFunction.General.WriteHTML("window.opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=3855';")
                        CommonFunction.General.WriteHTML("window.close();")

                    Case APP_TAG_OPPORTUNITY
                        CommonFunction.General.WriteHTML("window.close();")
                End Select
            End If

        End If
        CommonFunction.General.WriteHTML("function IsInvalidData()")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("var frmObj=document.getElementById('frmCommonList');")
        CommonFunction.General.WriteHTML("var str, obj;")
        CommonFunction.General.WriteHTML("for (var i=0;i<frmObj.length;i++)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("str = frmObj.elements[i].name")
        CommonFunction.General.WriteHTML("if (str.search('txtMonth') >= 0)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("obj = GetObjectReference('frmCommonPage', frmObj.elements[i].name);")
        CommonFunction.General.WriteHTML("if (disallowNegativeNumeric(obj, 'Please enter only positive Numeric value.',true))")
        CommonFunction.General.WriteHTML("{return true; }")

        'CommonFunction.General.WriteHTML("if (obj.value > 100)")
        'CommonFunction.General.WriteHTML("{")
        'CommonFunction.General.WriteHTML("alert(""'Monthly Distribution' value should be in the range of (0-100)."");								")
        'CommonFunction.General.WriteHTML("setFocus(obj);")
        'CommonFunction.General.WriteHTML("return true;")
        'CommonFunction.General.WriteHTML("}")

        CommonFunction.General.WriteHTML("if (parseFloat(obj.value) % 0.25 != 0)")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("alert(""'Monthly Distribution' should be multiple of 0.25"");	")
        CommonFunction.General.WriteHTML("setFocus(obj);")
        CommonFunction.General.WriteHTML("return true;")
        CommonFunction.General.WriteHTML("}")

        CommonFunction.General.WriteHTML("if (parseFloat(obj.value)> parseFloat(" + fltTotalFTE.ToString() + "))")
        CommonFunction.General.WriteHTML("{")
        CommonFunction.General.WriteHTML("alert(""'Monthly Distribution' should not be greater than Total FTE : " + fltTotalFTE.ToString() + "."");	")
        CommonFunction.General.WriteHTML("setFocus(obj);")
        CommonFunction.General.WriteHTML("return true;")
        CommonFunction.General.WriteHTML("}")

        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("return false;")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("</script>")
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added by Archanan on 5 Dec 2007
        ' To hide Save Links on Opportunity Search Page
        Dim strTagId As String
        Dim strPKID As String
        Dim strQuery As String
        Dim blnFreezed As Boolean = False
        'Addition by SuchitraP on 17-Dec-2008 for Hiding Save and SaveAndClose link when opportunity is closed
        Dim strSQL As String
        Dim IsOpen As Boolean = False
        'End of addition by SuchitraP on 17-Dec-2008

        strTagId = HttpContext.Current.Request.QueryString("OpenerTagID")
        If strTagId = "" Then
            strTagId = HttpContext.Current.Request.Form("OpenerTagID")
        End If

        

        CommonFunctions.General.WriteHTML("<Input Type=Hidden name=OpenerTagID id=OpenerTagID value=" + strTagId + " >")
        If strTagId = "3871" Then
            If WhizGlobal.TagID = 3860 And Args.LinkName.ToUpper = "SAVE" Or Args.LinkName.ToUpper = "SAVE AND CLOSE" Then
                Cancel = True
            End If

        End If
        
        strPKID = HttpContext.Current.Request.QueryString("PKID")

        If strPKID Is Nothing OrElse strPKID = "" Then
            strPKID = HttpContext.Current.Request.Form("hidPKID")
        End If

        If strTagId = "3855" Then
            ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            '' strQuery = "SELECT ISNULL(IsFreezed,0) FROM tbl_PM_TeamStructure WHERE TeamStructureID=" + strPKID  ' + " AND IsFreezed = 1"
            strQuery = "usp_sel_tbl_PM_TeamStructure_IsFreezed " + strPKID  ' + " AND IsFreezed = 1"
            ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            blnFreezed = CType(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), Boolean)
            If blnFreezed = True Then
                If WhizGlobal.TagID = 3860 And Args.LinkName.ToUpper = "SAVE" Or Args.LinkName.ToUpper = "SAVE AND CLOSE" Then
                    Cancel = True
                End If
            End If
            'Addition by SuchitraP on 17-Dec-2008 for Hiding Save and SaveAndClose link when opportunity is closed
        ElseIf strTagId = "3851" Or strTagId = "3865" Then
            ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            ''strSQL = "SELECT 1 FROM tbl_RM_Opportunity INNER JOIN tbl_CNF_OpportunityStatus OS ON tbl_RM_Opportunity.StatusID = OS.OpportunityStatusID AND ISNULL(MapToReadyForClosure,0) = 0 INNER JOIN tbl_RM_Pipeline ON tbl_RM_Pipeline.OpportunityID=tbl_RM_Opportunity.OpportunityID WHERE PipelineID = " + strPKID
            strSQL = "usp_sel_tbl_RM_Opportunity_HR " + strPKID
            ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            IsOpen = CommonFunction.Data.GetDataScalar(strSQL, True)
            If IsOpen = False And (Args.LinkName.ToUpper = "SAVE" Or Args.LinkName.ToUpper = "SAVE AND CLOSE") And WhizGlobal.TagID = 3860 Then
                Cancel = True
            End If
            'End of addition by SuchitraP on 17-Dec-2008
        End If

    End Sub
End Class
Public Class HR_FTEDistribution_cPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private Const APP_TAG_SOFTBOOKING As Long = 3859
    Private Const APP_TAG_OPPORTUNITY As Long = 3851
    Private Const APP_TAG_TEAMSTRUCTURE As Long = 3855

    Private m_strMainTableName As String
    Private m_strPKColName As String

    Private m_strResourceDemand_TagID As String


    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
        m_strResourceDemand_TagID = HttpContext.Current.Request.QueryString("ResourceDemand_TagID")
        If m_strResourceDemand_TagID Is Nothing OrElse m_strResourceDemand_TagID = "" Then
            m_strResourceDemand_TagID = HttpContext.Current.Request.Form("hidResourceDemand_TagID")
        End If

        Select Case CType(m_strResourceDemand_TagID, Long)
            Case APP_TAG_SOFTBOOKING
                m_strMainTableName = "tbl_RM_SoftBooking_Distribution"
                m_strPKColName = "DistributionID"
            Case APP_TAG_OPPORTUNITY
                m_strMainTableName = "tbl_RM_Pipeline_Distribution"
                m_strPKColName = "DistributionID"
            Case APP_TAG_TEAMSTRUCTURE
                m_strMainTableName = "tbl_PM_TeamStructure_Distribution"
                m_strPKColName = "DistributionID"
        End Select

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim txtBoxName As String

        If Args.DataField.ToUpper = "JAN" Then

            If Args.DataReader("Jan").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Jan").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "FEB" Then

            If Args.DataReader("Feb").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Feb").ToString(), "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "MAR" Then

            If Args.DataReader("Mar").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Mar").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "APR" Then

            If Args.DataReader("Apr").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Apr").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "MAY" Then

            If Args.DataReader("May").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("May").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "JUN" Then

            If Args.DataReader("Jun").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Jun").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "JUL" Then

            If Args.DataReader("Jul").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Jul").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "AUG" Then

            If Args.DataReader("Aug").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Aug").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "SEP" Then

            If Args.DataReader("Sep").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Sep").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If


        End If

        If Args.DataField.ToUpper = "OCT" Then

            If Args.DataReader("Oct").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Oct").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "NOV" Then

            If Args.DataReader("Nov").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Nov").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If

        If Args.DataField.ToUpper = "DEC" Then

            If Args.DataReader("Dec").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 65, 6, Args.DataReader("Dec").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader(m_strPKColName).ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align=center><DIV style='width:50'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</DIV></TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If


        End If

    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidPKValues id=hidPKValues value=" + Args.DataReader(m_strPKColName).ToString + " />")
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)


        Dim strAllContols() As String
        Dim i As Integer = 0
        Dim sum As Double
        Dim FTE As Double
        Dim strPKID As String
        Dim strPKToken As String

        strPKID = HttpContext.Current.Request.QueryString("PKID")
        strPKToken = HttpContext.Current.Request.QueryString("PKToken")

        If strPKID Is Nothing OrElse strPKID = "" Then
            strPKID = HttpContext.Current.Request.Form("hidPKID")
        End If

        If strPKToken Is Nothing OrElse strPKToken = "" Then
            strPKToken = HttpContext.Current.Request.Form("hidPKToken")
        End If

        m_strResourceDemand_TagID = HttpContext.Current.Request.QueryString("ResourceDemand_TagID")
        If m_strResourceDemand_TagID Is Nothing OrElse m_strResourceDemand_TagID = "" Then
            m_strResourceDemand_TagID = HttpContext.Current.Request.Form("hidResourceDemand_TagID")
        End If

        CommonFunctions.General.WriteHTML("<INPUT type=hidden name=hidResourceDemand_TagID id=hidResourceDemand_TagID value=" + m_strResourceDemand_TagID + " />")
        CommonFunctions.General.WriteHTML("<INPUT type=hidden name=hidPKID id=hidPKID value=" + strPKID + ">")
        CommonFunctions.General.WriteHTML("<INPUT type=hidden name=hidPKToken id=hidPKToken value=" + strPKToken + ">")

        MyBase.Initialize_Grid(Cancel, Args, WhizGlobal)

    End Sub

End Class


Class HR_FTEDistributionCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Private Const APP_TAG_SOFTBOOKING As Long = 3859
    Private Const APP_TAG_OPPORTUNITY As Long = 3851
    Private Const APP_TAG_TEAMSTRUCTURE As Long = 3855

    Private strPKID As String
    Private m_strResourceDemand_TagID As String



    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
        m_strResourceDemand_TagID = HttpContext.Current.Request.QueryString("ResourceDemand_TagID")
        If m_strResourceDemand_TagID Is Nothing OrElse m_strResourceDemand_TagID = "" Then
            m_strResourceDemand_TagID = HttpContext.Current.Request.Form("hidResourceDemand_TagID")
        End If

    End Sub



    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        strPKID = HttpContext.Current.Request.QueryString("PKID")
        If strPKID Is Nothing OrElse strPKID = "" Then
            strPKID = HttpContext.Current.Request.Form("hidPKID")
        End If

        Select Case CType(m_strResourceDemand_TagID, Long)
            Case APP_TAG_SOFTBOOKING
                ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                '' Args.GridSQL = "SELECT * FROM v_tbl_RM_SoftBooking_Distribution WITH (NOLOCK) WHERE  BookingID=" + strPKID
                Args.GridSQL = "usp_sel_v_tbl_RM_SoftBooking_Distribution " + strPKID
            Case APP_TAG_OPPORTUNITY
                ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                '' Args.GridSQL = "SELECT  * FROM v_tbl_RM_Pipeline_Distribution WITH (NOLOCK) WHERE PipelineID = " + strPKID
                Args.GridSQL = "usp_sel_v_tbl_RM_Pipeline_Distribution " + strPKID
            Case APP_TAG_TEAMSTRUCTURE
                ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                ''  Args.GridSQL = "SELECT * FROM v_tbl_PM_TeamStructure_Distribution WITH (NOLOCK) WHERE TeamStructureID=" + strPKID
                Args.GridSQL = "usp_sel_v_tbl_PM_TeamStructure_Distribution " + strPKID
                ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        End Select


    End Sub
End Class