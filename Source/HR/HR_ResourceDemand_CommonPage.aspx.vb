Imports CommonEngines.General.cEventHandlers
'=====================================================================
' Class	Name	        :	HR_ResourceDemand_CommonPage
' Purpose				:	Page for soft booking request for resource
' Description			:	Same as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	ShraddhaM
' Created				:	12,Oct 2007
' Revisions				:	
'=====================================================================
Public Class HR_ResourceDemand_CommonPage
    Inherits CommonPage

    Public Shared m_blnHeaderPlotted As Boolean = False
    Protected strSQL As String
    Dim drQuery As IDataReader
    Private Const APP_TAG_SOFTBOOKING As Long = 3859
    Private Const APP_TAG_ENGAGEMENT_PROBABILITY As Long = 3229

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)

        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "CommonList.aspx"
        MyBase.strFormPage = "HR_ResourceDemand_CommonPage.aspx"
        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Select Case Request.QueryString("From")
                Case "BG"
                    Response.Write(GetBGwiseOU())
                Case "OU"
                    Response.Write(GetOUWiseDU())
                Case "DU"
                    Response.Write(GetDUWiseDT())
                Case "ForDuplication"
                    Response.Write(GetIsRecordPresent())
            End Select
            Response.End()
        Else
            MyBase.Page_Load(sender, e)
            m_blnHeaderPlotted = False
        End If

    End Sub

    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cHR_ResourceDemand_cPlotGrid(m_objSubTagGlobal)
    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cHR_ResourceDemand_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String


        If WhizGlobal.TagID = APP_TAG_SOFTBOOKING And PrimaryKey <> "" Then

            strSQL = "usp_Ins_tbl_RM_SoftBooking_Distribution " + PrimaryKey + ",'" + Request.Form("ResourceInDate") + "','" + Request.Form("ResourceOutDate") + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)

        End If

    End Function

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        If PrimaryKey <> "" Then
            If WhizGlobal.TagID = APP_TAG_SOFTBOOKING And IsEditMode = False Then

                strSQL = "usp_Ins_tbl_RM_SoftBooking_Distribution " + PrimaryKey + ",'" + Request.Form("ResourceInDate") + "','" + Request.Form("ResourceOutDate") + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)

            End If

            If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = APP_TAG_ENGAGEMENT_PROBABILITY Then
                'To enable publish link for respected Opportunity
                Dim strSQL As String
                strSQL = "Update tbl_RM_SoftBooking Set Published = 0 Where BookingID = "
                strSQL += " (Select BookingID From tbl_RM_SoftBooking_Probability Where ProbabilityID = " + PrimaryKey + ") "
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            End If
        End If
    End Function
    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = 3223 And Args.LinkName.ToUpper = "SAVE" Then
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
            If WhizGlobal.TagID = 3859 And Args.LinkName.ToUpper = "SAVE" Then
                Cancel = True
            ElseIf WhizGlobal.TagID = 3223 And Args.LinkName.ToUpper = "SAVE" Then
                Cancel = True
            End If

        End If

    End Sub

    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cHR_ResourceDemand_CommonPageSubTagCLSQL(m_objSubTagGlobal)

    End Function
    Private Function GetBGwiseOU() As String
        '====================================================================
        ' Function Name         :  GetBGwiseOU
        ' Parameters Passed     :  None
        ' Returns               :  LocationID and Location name separeted by "$___#"
        ' Parameters Affected   :  None
        ' Purpose               :  To get BG wise OU.
        ' Description           :  same as above 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  12,Oct 2007
        ' Revisions             :  
        '=====================================================================
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strBGID As String
        Dim strJscript As String = "BG"
        If Request.QueryString("BusinessGroupID") Is Nothing OrElse Request.QueryString("BusinessGroupID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BusinessGroupID")
        End If
        strQuery = "usp_Sel_GetBusinessGroupsForLocation " + strBGID + ",NULL,0"
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("OUPoolID"), String) + "$___#" + CType(dr("Location"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetOUWiseDU() As String
        '====================================================================
        ' Function Name         :  GetOUWiseDU
        ' Parameters Passed     :  None
        ' Returns               :  ResourcePoolID and ResourcePoolName separeted by "$___#"
        ' Parameters Affected   :  None
        ' Purpose               :  To get OU wise DU.
        ' Description           :  same as above 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  12,Oct 2007
        ' Revisions             :  
        '=====================================================================
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strOUID As String
        Dim strJscript As String = "OU"
        If Request.QueryString("LocationID") Is Nothing OrElse Request.QueryString("LocationID") = "" Then
            strOUID = "NULL"
        Else
            strOUID = Request.QueryString("LocationID")
        End If
        strQuery = "usp_Sel_GetResourcePoolForLocation " + strOUID + ",0"
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("ResourcePoolID"), String) + "$___#" + CType(dr("ResourcePoolName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetDUWiseDT() As String
        '====================================================================
        ' Function Name         :  GetDUWiseDT
        ' Parameters Passed     :  None
        ' Returns               :  GroupID and Group Name separeted by "$___#"
        ' Parameters Affected   :  None
        ' Purpose               :  To get DU wise DT.
        ' Description           :  same as above 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  12,Oct 2007
        ' Revisions             :  
        '=====================================================================
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strDUID As String
        Dim strJscript As String = "DU"
        If Request.QueryString("DeliveryUnitID") Is Nothing OrElse Request.QueryString("DeliveryUnitID") = "" Then
            strDUID = "NULL"
        Else
            strDUID = Request.QueryString("DeliveryUnitID")
        End If
        strQuery = "usp_sel_GetDeliverayTeam " + strDUID + ",0"
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("GroupID"), String) + "$___#" + CType(dr("GroupName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetIsRecordPresent() As String
        Dim ResourceInDate As String
        Dim ResourceOutDate As String
        'Dim RaisedBy As String
        Dim EmployeeID As String
        'Dim BusinessGroupID As String
        'Dim LocationID As String
        'Dim ResourcePoolID As String
        'Dim GroupID As String
        Dim BookingID As String
        Dim strSQLValidation As String
        Dim IsRecordPresent As String
        Dim OpportunityID As String

        ResourceInDate = CommonFunction.General.CheckIsNothing(Request.QueryString("ResourceInDate"), "NULL")
        ResourceOutDate = CommonFunction.General.CheckIsNothing(Request.QueryString("ResourceOutDate"), "NULL")
        'RaisedBy = CommonFunction.General.CheckIsNothing(Request.QueryString("RaisedBy"), "0")
        EmployeeID = CommonFunction.General.CheckIsNothing(Request.QueryString("EmployeeID"), "0")
        'BusinessGroupID = CommonFunction.General.CheckIsNothing(Request.QueryString("BGID"), "0")
        'LocationID = CommonFunction.General.CheckIsNothing(Request.QueryString("OUID"), "0")
        'If LocationID = "" Then
        '    LocationID = "0"
        'End If
        'ResourcePoolID = CommonFunction.General.CheckIsNothing(Request.QueryString("DUID"), "0")
        'If ResourcePoolID = "" Then
        '    ResourcePoolID = "0"
        'End If
        'GroupID = CommonFunction.General.CheckIsNothing(Request.QueryString("DTID"), "0")
        'If GroupID = "" Then
        '    GroupID = "0"
        'End If

        BookingID = CommonFunction.General.CheckIsNothing(Request.QueryString("BookingID"), "NULL")
        If BookingID = "" Then
            BookingID = "NULL"
        End If

        'Addition done by SuchitraP for IssueID 17180 on 11-Dec-2007
        'Purpose:Duplicate check for Resource, Resource-In Date & Resource-Out Date for particular opportunity.
        OpportunityID = Request.QueryString("OpportunityID")
        'End of addition by SuchitraP on 11-Dec-2007

        'strSQLValidation = "usp_sel_ExistingRecord_SoftBooking '" + ResourceInDate + "','" + ResourceOutDate + "'," + RaisedBy + "," + EmployeeID + "," + BusinessGroupID + "," + LocationID + "," + ResourcePoolID + "," + GroupID + "," + BookingID

        'Comment and modification by SuchitraP for IssueID 17180 on 11-Dec-2007
        'strSQLValidation = "Exec usp_sel_ExistingRecord_SoftBooking '" + ResourceInDate + "','" + ResourceOutDate + "'," + EmployeeID + "," + BookingID
        strSQLValidation = "Exec usp_sel_ExistingRecord_SoftBooking '" + ResourceInDate + "','" + ResourceOutDate + "'," + EmployeeID + "," + BookingID + "," + OpportunityID
        'End of comment and modification by SuchitraP on 11-Dec-2007
        IsRecordPresent = CType(CommonFunction.Data.GetDataScalar(strSQLValidation, True), String)

        Return IsRecordPresent

    End Function
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

        If (HttpContext.Current.Request.QueryString("Operation") = "SAVE") And m_objGlobal.ParentTagID = 0 And m_objGlobal.TagID = 3859 Then
            PageUIPostRender = "strParentPage = new String();" + vbCrLf
            PageUIPostRender += " if (window.opener != null) " + vbCrLf
            PageUIPostRender += "{" + vbCrLf
            'PageUIPostRendere += " strParentPage = window.opener.location;" + vbCrLf

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
End Class
Public Class cHR_ResourceDemand_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Private Const APP_TAG_MONTHLY_DISTRIBUTION As Long = 3223
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.TagID = APP_TAG_MONTHLY_DISTRIBUTION Then
            Dim IsDistributionSave As String
            IsDistributionSave = HttpContext.Current.Request.QueryString("DistributionSave")
            If IsDistributionSave = "1" Then
                Call Distribution_Save()
            End If
        End If

        MyBase.Initialize_GridSQL(Cancel, Args, WhizGlobal)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Jan = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Feb = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Mar = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Apr = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET May = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Jun = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Jul = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Aug = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Sep = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Oct = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Nov = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
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
                        strUpdateQuery = "UPDATE tbl_RM_SoftBooking_Distribution SET Dec = " + ColumnValues + " WHERE DistributionId = " + strPKValuesArray(PKCounter)
                        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, True)


                End Select

                MonthCounter = MonthCounter + 1
            End While
            PKCounter = PKCounter + 1
        End While

    End Sub
End Class

Public Class cHR_ResourceDemand_cPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim txtBoxName As String
    Private Const APP_TAG_MONTHLY_DISTRIBUTION As Long = 3223
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.TagID <> APP_TAG_MONTHLY_DISTRIBUTION Then
            Exit Sub
        End If

        If Args.DataField.ToUpper = "JAN" Then
            If Args.DataReader("Jan").ToString <> "" Then
                txtBoxName = "txtMonth" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Jan").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Feb").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"
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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Mar").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Apr").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("May").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Jun").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Jul").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Aug").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Sep").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Oct").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Nov").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

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
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, 5, Args.DataReader("Dec").ToString, "right", returnHTML:=True, EnableHTMLEncode:=True) + "</TD>"

            Else
                txtBoxName = "hid" + Args.DataField.ToString + Args.DataReader("DistributionID").ToString
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawTextBox(txtBoxName, txtBoxName, , 50, , "NULL", "right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>"
                'ended by Shamkant s  for HTML encoding Date:06/10/15
            End If

        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.TagID = APP_TAG_MONTHLY_DISTRIBUTION Then
            CommonFunctions.General.WriteHTML("<INPUT type=hidden name=hidPKValues id=hidPKValues value=" + Args.DataReader("DistributionID").ToString + " />")
        End If
    End Sub
End Class

Public Class cHR_ResourceDemand_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        HR_ResourceDemand_CommonPage.m_blnHeaderPlotted = True
    End Sub
End Class

