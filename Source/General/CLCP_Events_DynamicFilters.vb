
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_DynamicFilters
            
            Public Shared Sub Initialize_Filters(ByRef Cancel As Boolean, ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFiltersTable, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before plotting Filters Table
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                        'Added By SandeepA on 14 Nov,2005 for IssueID -676
                        'Page: Project Listing TagID-32
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            'If the User has restricted access then hide filters (Restricted Access configured through 'Page TagID-3083') 
                            Dim strSQL As String
                            Dim intResult As Integer

                            'Code commented by SandeepA on 15 Nov,2005 for IssueID-676(Requirement Changes)
                            'Purpose Of Comment:To show the Filters to all Roles,except CUSTOMER LOGIN.
                            'strSQL = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & WhizGlobal.ProjectID & " and RoleID=" & WhizGlobal.RoleID & ")Select 1 Else Select 0"
                            'intResult = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"))
                            'If intResult = 1 Then
                            '    'If restricted Access hide the Filters
                            '    Cancel = True
                            'End If
                            'End of Comment by SandeepA on 15 Nov,2005 for IssueID-676
                            'End Integration

                            'If Customer Login , then hide the filters
                            If WhizGlobal.LoginType = "C" Then
                                Cancel = True
                            End If
                            'End of addition by SandeepA on 14 Nov,2005 for IssueID--676
                            'End Integration
                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                            'Set the no. of filters per row to 4 for the Change Management page
                            Args.ControlsPerRow = 4
                        Case CommonFunction.Constants.TAG_AUDIT_TRAIL
                            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowHistory")) = "1" Then
                                'Delete the Last Filter Settings for the user
                                Dim sql As String = "Delete From tbl_UI_EmployeeFilterSettings where TagID = " + WhizGlobal.TagID.ToString + " and LoginType = '" + WhizGlobal.LoginType.ToString + "' And UserID = " + WhizGlobal.UserID.ToString
                                Call CommonFunctions.Data.GetDataScalar(sql, True)
                                'Delete from Details table
                                sql = "Delete From tbl_UI_EmployeeFilterSettings_FieldDetails where TagID = " + WhizGlobal.TagID.ToString + " and LoginType = '" + WhizGlobal.LoginType.ToString + "' And UserID = " + WhizGlobal.UserID.ToString
                                Call CommonFunctions.Data.GetDataScalar(sql, True)
                                'Delete from User Preferences
                                sql = "DELETE FROM tbl_UI_UserPreferences WHERE ItemID =" + WhizGlobal.TagID.ToString + " and LoginType = '" + WhizGlobal.LoginType.ToString + "' And UserID = " + WhizGlobal.UserID.ToString
                                Call CommonFunctions.Data.GetDataScalar(sql, True)
                            End If

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                    End Select
                End If
            End Sub

            Public Shared Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before plotting Filters Table
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_FORM_GENERATION
                            'added by SachinR   on 2 Aug 2004
                            'Here contract filter SP is given parameter of customer ID selected
                            'to display contracts applicable to the selected customer 
                            Dim strCustomerID As String
                            Dim strSQL As String
                            'added by SachinR   on 23 Aug 2004
                            'issue - 12532
                            Dim strOldCustomerID As String
                            Dim strNewCustomerID As String
                            'here value of customer filter is stored in the session, to check it while printing 
                            'filter, is customer is changed then reset the value of contract filter
                            strOldCustomerID = ""
                            strNewCustomerID = ""
                            If Args.FilterName.ToUpper = "CONTRACTID" Then

                                If Not HttpContext.Current.Session("SoftexCustomerID") Is Nothing Then

                                    strOldCustomerID = HttpContext.Current.Session("SoftexCustomerID").ToString + ""
                                    strNewCustomerID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("CustomerID"), "")
                                    If strOldCustomerID <> strNewCustomerID Then
                                        'if customer is changed then make the contract filter blank
                                        strSQL = "Update tbl_ui_EmployeeFilterSettings_FieldDetails Set FixedValue=NULL"
                                        strSQL += " Where TagID=" + CommonFunction.Constants.APP_TAG_RFI_SOFTEX_FORM_GENERATION.ToString + " And UserID=" + WhizGlobal.UserID.ToString + " And LoginType='" + WhizGlobal.LoginType.Trim + "'"
                                        strSQL += "	And ControlName='ContractID'"
                                        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        strSQL = "Update tbl_ui_EmployeeFilterSettings Set FilterQuery="
                                        If strNewCustomerID <> "" And strNewCustomerID <> "0" Then
                                            strSQL += "'CustomerID=" + strNewCustomerID.Trim + ""
                                            If HttpContext.Current.Request.Form("SalesPeriodID") <> "" Then
                                                strSQL += " And SalesPeriodID=" + HttpContext.Current.Request.Form("SalesPeriodID") + ""
                                            End If
                                            strSQL += "',UserFriendlyFilterQuery='Customer=''" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("CustomerID_UserFriendlyValue"), "") + "''"
                                            If HttpContext.Current.Request.Form("SalesPeriodID") <> "" Then
                                                strSQL += " And Sales Period=''" + HttpContext.Current.Request.Form("SalesPeriodID_UserFriendlyValue") + "''"
                                            End If
                                            strSQL += "'"
                                        Else
                                            If HttpContext.Current.Request.Form("SalesPeriodID") <> "" Then
                                                strSQL += " 'SalesPeriodID=" + HttpContext.Current.Request.Form("SalesPeriodID") + "',"
                                                strSQL += " UserFriendlyFilterQuery='Sales Period=''" + HttpContext.Current.Request.Form("SalesPeriodID_UserFriendlyValue") + "'''"
                                            Else
                                                strSQL += "NULL,"
                                                strSQL += " UserFriendlyFilterQuery=NULL"
                                            End If

                                        End If
                                        strSQL += " Where TagID=" + CommonFunction.Constants.APP_TAG_RFI_SOFTEX_FORM_GENERATION.ToString + " And UserID=" + WhizGlobal.UserID.ToString + " And LoginType='" + WhizGlobal.LoginType.Trim + "'"
                                        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    End If
                                Else
                                    strSQL = "Select IsNull(FixedValue,'') As 'FixedValue' From tbl_ui_EmployeeFilterSettings_FieldDetails "
                                    strSQL += " Where TagID=" + CommonFunction.Constants.APP_TAG_RFI_SOFTEX_FORM_GENERATION.ToString + " And UserID=" + WhizGlobal.UserID.ToString + " And LoginType='" + WhizGlobal.LoginType.Trim + "'"
                                    strSQL += "	And ControlName='CustomerID'"
                                    strNewCustomerID = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0").ToString
                                    HttpContext.Current.Session.Add("SoftexCustomerID", "")

                                End If
                                HttpContext.Current.Session("SoftexCustomerID") = strNewCustomerID
                                'addition end

                                strCustomerID = HttpContext.Current.Session("SoftexCustomerID").ToString + ""
                                Args.SQL = "usp_Sel_Rfi_CustomerContracts " + strCustomerID.Trim
                            End If
                            'addition end
                            'Added by SandipL on 21 Feb 2006 --Whizsem_whiz2 sp6 IssueID 2120
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES_SELECTION_LIST
                            If Args.FilterName.ToUpper = "SCHEDULETYPEID" Then
                                If HttpContext.Current.Request.QueryString("FromWhere") = "IB" Or HttpContext.Current.Request("FromWhere") = "IB" Then
                                    'm_lngProjectId = CType(HttpContext.Current.Session("IssueProject"), Long)
                                    Args.SQL = "usp_Sel_tbl_PM_ProjectSchedule " & CType(HttpContext.Current.Session("IssueProject"), String)
                                End If
                            End If
                            'End addition by SandipL on 21 Feb 2006



                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                    End Select
                End If
            End Sub

            Public Shared Sub After_Filter_Print(ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This Event will occur before plotting Filters Table
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
            End Sub

            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            Public Shared Sub After_Getting_FilterClause(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef FilterClause As String, Optional ByVal strMasterPrimaryKeyValue As String = "")
                'End Of Modifications - IssueID : 672

                'This Event will occur before plotting Filters Table
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                        ''Added by Dhanashri S on 29 Oct 2015

                        Case CommonFunction.Constants.TAG_AUDIT_TRAIL
                            'If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ShowHistory")) = "1" Then
                            'For first time call only clear the settings..which could be for some other page
                            'Delete the Last Filter Settings for the user
                            Dim sql As String = "Delete From tbl_UI_EmployeeFilterSettings where TagID = " + WhizGlobal.TagID.ToString + " and LoginType = '" + WhizGlobal.LoginType.ToString + "' And UserID = " + WhizGlobal.UserID.ToString
                            Call CommonFunctions.Data.GetDataScalar(sql, True)
                            'Delete from Details table
                            sql = "Delete From tbl_UI_EmployeeFilterSettings_FieldDetails where TagID = " + WhizGlobal.TagID.ToString + " and LoginType = '" + WhizGlobal.LoginType.ToString + "' And UserID = " + WhizGlobal.UserID.ToString
                            Call CommonFunctions.Data.GetDataScalar(sql, True)
                            'End If

                            ''End of Addition by Dhanashri S on 29 Oct 2015

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                    End Select
                End If
            End Sub
            Public Shared Sub Before_Applying_Filter(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef ToBeInsertedInFunction As String, Optional ByVal PrimaryKey As String = "", Optional ByVal SubTagID As Long = 0)
                'This Event will occur before Applying the Filter, --before submitting the form
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS
                            Dim objAppResource As WebPages.Template.WhizTemplate
                            objAppResource = New WebPages.Template.WhizTemplate
                            objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")

                            ToBeInsertedInFunction = "  if (strHiddenControlName=='CustomerID_UserFriendlyValue' && objControl.selectedIndex==0) "
                            ToBeInsertedInFunction += vbCrLf + "        { alert(' " + objAppResource.GetResourceString("MSG_RFI_CUST_BLANK") + "');return;}"

                            ToBeInsertedInFunction += "  if (strHiddenControlName=='CompanyID_UserFriendlyValue' && objControl.selectedIndex==0) "
                            ToBeInsertedInFunction += vbCrLf + "        { alert('" + objAppResource.GetResourceString("MSG_RFI_COMP_BLANK") + "');return;}"

                            objAppResource = Nothing
                    End Select
                End If
            End Sub
        End Class
    End Namespace
End Namespace
