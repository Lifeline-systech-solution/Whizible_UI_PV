Imports CommonEngines.General.cEventHandlers



Public Class HR_Role_CommonPage
    Inherits CommonPage
    Public Shared m_blnHeaderPlotted As Boolean = False

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
        MyBase.strListPage = "CommonList.aspx"
        MyBase.strFormPage = "HR_Role_CommonPage.aspx"

        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Dim strPipelineID, strOpportunityID, strRoleID, strToolID, strResourceInDate, strResourceOutDate As String
            strRoleID = HttpContext.Current.Request.QueryString("RoleID")
            strToolID = HttpContext.Current.Request.QueryString("ToolID")
            strResourceInDate = HttpContext.Current.Request.QueryString("TentativeStartDate")
            strResourceOutDate = HttpContext.Current.Request.QueryString("TentativeEndDate")
            strPipelineID = HttpContext.Current.Request.QueryString("PipelineID")
            strOpportunityID = HttpContext.Current.Request.QueryString("OpportunityID")

            Response.Write(CheckDuplicate(strPipelineID, strOpportunityID, strRoleID, strToolID, strResourceInDate, strResourceOutDate))
            Response.End()
        Else
            MyBase.Page_Load(sender, e)
            m_blnHeaderPlotted = False
        End If

        ''''MyBase.Page_Load(sender, e)
    End Sub

    Private Function CheckDuplicate(ByVal strPipelineID As String, ByVal strOpportunityID As String, ByVal strRoleID As String, ByVal strToolID As String, ByVal strResourceINDate As String, ByVal strResourceOutDate As String) As String
        Dim strSQL As String
        strSQL = "Exec Usp_Sel_IsRoleExistsForOpportunity " + strOpportunityID + "," + strRoleID
        strSQL += "," + strToolID + ",'" + strResourceINDate + "','" + strResourceOutDate + "'"
        If strPipelineID <> "" Then
            strSQL += "," + strPipelineID
        End If
        CheckDuplicate = CType(CommonFunction.Data.GetDataScalar(strSQL, True), String)
    End Function

    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cHR_Role_CommonPage_cPlotGrid(m_objSubTagGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cHR_Role_CommonPageSubTagCLSQL(WhizGlobal)
    End Function
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cHR_Role_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim strTagId As String
        strTagId = HttpContext.Current.Request.QueryString("OpenerTagID")

        If strTagId = "" Then
            strTagId = HttpContext.Current.Request.Form("OpenerTagID")
        End If

        If strTagId = "" Then
            strTagId = "3851"
        End If
        CommonFunctions.General.WriteHTML("<Input Type=Hidden name=OpenerTagID id=OpenerTagID value=" + strTagId + " >")

        If (HttpContext.Current.Request.QueryString("Operation") = "SAVE") And m_objGlobal.ParentTagID = 0 And m_objGlobal.TagID = 3852 Then
            PageUIPostRender = "strParentPage = new String();" + vbCrLf
            PageUIPostRender += " if (window.opener != null) " + vbCrLf
            PageUIPostRender += "{" + vbCrLf
            'PageUIPostRender += " strParentPage = window.opener.location;" + vbCrLf

            PageUIPostRender += "var objTokenPK = window.opener.document.getElementById('PKToken');" + vbCrLf
            PageUIPostRender += "var objIDPK = window.opener.document.getElementById('OpportunityID_PK');" + vbCrLf
            PageUIPostRender += "strParentPage = '../HR/HR_Opportunity_CommonPage.aspx?';" + vbCrLf
            PageUIPostRender += "strParentPage = strParentPage + 'OpportunityID_PK='+objIDPK.value+'&PKToken='+objTokenPK.value;" + vbCrLf
            PageUIPostRender += "strParentPage = strParentPage + '&MasterTagID=" + strTagId + "&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';" + vbCrLf
            PageUIPostRender += "refreshParent('frmCommonPage', 'HR_Opportunity_CommonPage.aspx', strParentPage)" + vbCrLf
            'PageUIPostRender += "focusOnFirstControl();" + vbCrLf
            PageUIPostRender += "window.close();" + vbCrLf
            PageUIPostRender += "}" + vbCrLf
            strActionCode = ReturnCodes.ON_LOAD.ToString
        End If
    End Function

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strSQL As String
        Dim SiteID As String
        Dim SoftBookingID As String
        Dim dr As IDataReader

        SiteID = Request.Form("SiteID")
        If SiteID = "" Then
            SiteID = "NULL"
        End If
        If WhizGlobal.TagID = 3852 And IsEditMode = False And PrimaryKey <> "" Then
            strSQL = "usp_Ins_tbl_RM_Pipeline_Distribution " + PrimaryKey + ",'" + Request.Form("TentativeStartDate") + "'"
            strSQL += ",'" + Request.Form("TentativeEndDate") + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        End If

        'To Update SoftBooking when we update Role
        strSQL = "UPDATE tbl_RM_SoftBooking SET ResourceInDate='" + Request.Form("TentativeStartDate") + "'"
        strSQL += ",ResourceOutDate ='" + Request.Form("TentativeEndDate") + "',CoolingOf='" + Request.Form("CoolingOf") + "',SiteID=" + SiteID
        strSQL += " WHERE PipelineID =" + PrimaryKey
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' dr = CommonFunction.Data.GetDataReader("select BookingID from tbl_RM_SoftBooking where PipeLineID = " + PrimaryKey, MyBase.UseSQL)
        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_RM_SoftBooking " + PrimaryKey, MyBase.UseSQL)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        While dr.Read
            CommonFunction.Data.InsertOrUpdateData("usp_Ins_tbl_RM_SoftBooking_Distribution " + dr("BookingID").ToString + ",'" + Request.Form("TentativeStartDate") + "','" + Request.Form("TentativeEndDate") + "'", MyBase.UseSQL)
        End While
        CommonFunction.Data.DisposeDataReader(dr)

    End Function

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strSQL As String

        If WhizGlobal.TagID = 3852 And PrimaryKey <> "" Then
            strSQL = "usp_Ins_tbl_RM_Pipeline_Distribution " + PrimaryKey + ",'" + Request.Form("TentativeStartDate") + "'"
            strSQL += ",'" + Request.Form("TentativeEndDate") + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)

        End If
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Addition by SuchitraP on 17-Dec-2008 for Hiding Save link when opportunity is closed
        Dim strSQL As String
        Dim IsOpen As Boolean = False
        'End of addition by SuchitraP on 17-Dec-2008

        If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = 3224 And Args.LinkName.ToUpper = "SAVE" Then
            If Not m_blnHeaderPlotted Then
                Cancel = True
                m_blnHeaderPlotted = False
            End If
        End If

        'Added by Archanan on 5 Dec 2007
        ' To hide Save Links on Opportunity Search Page
        Dim strTagId As String
        strTagId = HttpContext.Current.Request.QueryString("OpenerTagID")
        If strTagId = "" Then
            strTagId = HttpContext.Current.Request.Form("OpenerTagID")
        End If

        If strTagId = "3871" Then
            If WhizGlobal.TagID = 3852 And Args.LinkName.ToUpper = "SAVE" Then
                Cancel = True
            ElseIf WhizGlobal.TagID = 3225 And Args.LinkName.ToUpper = "ADD" Then
                Cancel = True
            ElseIf WhizGlobal.TagID = 3224 And Args.LinkName.ToUpper = "SAVE" Then
                Cancel = True

            End If
            'Addition by SuchitraP on 17-Dec-2008 for Hiding Save link when opportunity is closed
        ElseIf strTagId = "3851" Or strTagId = "3865" Then
            '  strSQL = "SELECT 1 FROM tbl_RM_Opportunity INNER JOIN tbl_CNF_OpportunityStatus OS ON tbl_RM_Opportunity.StatusID = OS.OpportunityStatusID AND ISNULL(MapToReadyForClosure,0) = 0 WHERE OpportunityID =" + HttpContext.Current.Request.QueryString("OpportunityID")
            strSQL = "usp_sel_OpportunityID_tbl_RM_Opportunity " + HttpContext.Current.Request.QueryString("OpportunityID")
            IsOpen = CommonFunction.Data.GetDataScalar(strSQL, True)
            If IsOpen = False And Args.LinkName.ToUpper = "SAVE" And (WhizGlobal.TagID = 3852 Or WhizGlobal.TagID = 3870) Then
                Cancel = True
            End If
            'End of addition by SuchitraP on 17-Dec-2008
        End If

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
        CommonFunction.General.WriteHTML("alert(""'Monthly Distribution' value should be in the range of (0-100)."");								")
        CommonFunction.General.WriteHTML("setFocus(obj);")
        CommonFunction.General.WriteHTML("return true;")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("return false;")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("</script>")
    End Function

End Class
Public Class cHR_Role_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        HR_Role_CommonPage.m_blnHeaderPlotted = True
    End Sub
End Class


Public Class cHR_Role_CommonPageSubTagCLSQL
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Jan = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Feb = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Mar = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Apr = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET May = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Jun = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Jul = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Aug = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Sep = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Oct = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Nov = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_Pipeline_Distribution SET Dec = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)
                End Select
                MonthCounter = MonthCounter + 1
            End While
            PKCounter = PKCounter + 1
        End While
    End Sub



End Class

Public Class cHR_Role_CommonPage_cPlotGrid
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
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Jan").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If
        End If
        If Args.DataField.ToUpper = "FEB" Then
            If Args.DataReader("Feb").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Feb").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If
        End If
        If Args.DataField.ToUpper = "MAR" Then
            If Args.DataReader("Mar").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Mar").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If
        End If
        If Args.DataField.ToUpper = "APR" Then
            If Args.DataReader("Apr").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Apr").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
        If Args.DataField.ToUpper = "MAY" Then
            If Args.DataReader("May").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("May").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
        If Args.DataField.ToUpper = "JUN" Then
            If Args.DataReader("Jun").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Jun").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
        If Args.DataField.ToUpper = "JUL" Then
            If Args.DataReader("Jul").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Jul").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
        If Args.DataField.ToUpper = "AUG" Then
            If Args.DataReader("Aug").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Aug").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
        If Args.DataField.ToUpper = "SEP" Then
            If Args.DataReader("Sep").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Sep").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If


        End If
        If Args.DataField.ToUpper = "OCT" Then
            If Args.DataReader("Oct").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Oct").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
        If Args.DataField.ToUpper = "NOV" Then
            If Args.DataReader("Nov").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Nov").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
        If Args.DataField.ToUpper = "DEC" Then
            If Args.DataReader("Dec").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD align='right'>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 6, Args.DataReader("Dec").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.PrimaryKeyName.ToUpper = "DISTRIBUTIONID" Then
            CommonFunctions.General.WriteHTML("<INPUT type=hidden name=hidPKValues id=hidPKValues value=" + Args.DataReader("DistributionID").ToString + " />")
        End If
    End Sub

End Class

