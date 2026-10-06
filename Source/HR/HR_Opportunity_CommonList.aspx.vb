Imports CommonEngines.General.cEventHandlers
Public Class HR_Opportunity_CommonList
    Inherits CommonList
    '=====================================================================
    ' Class Name		    :	HR_Opportunity_CommonList
    ' Purpose				:	
    ' Description			:	
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	ArchanaN
    ' Created				:	31 Oct 2007
    ' Revisions				:	
    '=====================================================================

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "HR_Opportunity_CommonList.aspx"
        MyBase.strFormPage = "HR_Opportunity_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
#End Region

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cHR_Opportunity_CommonListCLSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cHR_Opportunity_CommonListGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Args.HTMLLegend = ""
        Cancel = True
    End Sub
End Class

Class cHR_Opportunity_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Private Const APP_TAG_OPPORTUNITY_ENTRY As Long = 3851
    Private Const APP_TAG_OPPORTUNITY_APPROVAL As Long = 3865

    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strQuery As String
        Dim dr As IDataReader
        Dim strLevel As String
        Dim IDs As String
        Dim strRaisedBy As String
        Dim strTagID As String

        Dim blnIsApprover As Boolean = False

        Dim strQuery1 As String = ""
        Dim drGetRoleLevelInformation As IDataReader
        Dim strBusinessGroupID As String = ""
        Dim strLocationID As String = ""
        Dim strRoleLevel As String = ""
        Dim strAccessibleOpportunity As String
        Dim OpportunityIDs As String
        'Added by SanaS on 14-Oct-2009 for Demand Approver at Role Level
        Dim blnIsDemandApprover As Boolean
        'End Added by SanaS on 14-Oct-2009 for Demand Approver at Role Level
        strTagID = CType(objGlobal.TagID, String)
        strRaisedBy = CType(HttpContext.Current.Session("intUserID"), String)


        'PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
        'strQuery = "usp_Sel_GetRoleLevelInformation " + CType(HttpContext.Current.Session("intUserID"), String)
        'drGetRoleLevelInformation = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        'If drGetRoleLevelInformation.Read Then
        '    strBusinessGroupID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("BusinessGroupID"), "0"), String)
        '    strLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("LocationID"), "0"), String)
        '    strRoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("Level"), "0"), String)
        'End If

        'CommonFunctions.Data.DisposeDataReader(drGetRoleLevelInformation)

        'If strRoleLevel.Trim = "1" Then
        '    Exit Function
        'End If

        'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD

        Select Case CType(strTagID, Long)

            Case APP_TAG_OPPORTUNITY_ENTRY

                strQuery = "usp_Sel_GetRoleLevelInformation " + CType(HttpContext.Current.Session("intUserID"), String)
                drGetRoleLevelInformation = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drGetRoleLevelInformation.Read Then
                    strBusinessGroupID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("BusinessGroupID"), "0"), String)
                    strLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("LocationID"), "0"), String)
                    strRoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("Level"), "0"), String)
                End If

                CommonFunctions.Data.DisposeDataReader(drGetRoleLevelInformation)

                If strRoleLevel = "2" Then

                    'GetPageSpecificFilters += " AND " + "((BusinessGroupID = " + CType(strBusinessGroupID, String) + " AND " + "LocationID = " + CType(strLocationID, String) + ")"
                    GetPageSpecificFilters += " AND " + "( 1=2 "
                    strAccessibleOpportunity = "usp_sel_BGOU_Wise_Opprtunity " + CType(HttpContext.Current.Session("intUserID"), String)
                    OpportunityIDs = CType(CommonFunctions.Data.GetDataScalar(strAccessibleOpportunity, True), String)
                    If OpportunityIDs <> "" Then
                        GetPageSpecificFilters += " OR OpportunityID IN( " + OpportunityIDs + ")"
                    End If
                    GetPageSpecificFilters &= " ) "
                    GetPageSpecificFilters += " OR (RaisedBy = " + strRaisedBy + " OR CreatedBy = '" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "' )"
                ElseIf strRoleLevel = "3" Then
                    GetPageSpecificFilters += " AND (RaisedBy = " + strRaisedBy + " OR CreatedBy = '" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "' )"
                End If

                'GetPageSpecificFilters += " OR (RaisedBy = " + strRaisedBy + " OR CreatedBy = '" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "' )"

            Case APP_TAG_OPPORTUNITY_APPROVAL



                GetPageSpecificFilters += " AND ISNULL(ApprovedStatus,'D') <> 'D' "

                strQuery = "usp_Sel_GetRoleLevelInformation " + CType(HttpContext.Current.Session("intUserID"), String)
                drGetRoleLevelInformation = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drGetRoleLevelInformation.Read Then
                    strBusinessGroupID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("BusinessGroupID"), "0"), String)
                    strLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("LocationID"), "0"), String)
                    strRoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("Level"), "0"), String)
                    'Added by SanaS on 14-Oct-2009 for Demand Approver at Role Level
                    blnIsDemandApprover = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("DemandApprover"), 0), Boolean)
                    'End Added by SanaS on 14-Oct-2009 for Demand Approver at Role Level
                End If

                CommonFunctions.Data.DisposeDataReader(drGetRoleLevelInformation)
                'Added by SanaS on 14-Oct-2009 for Demand Approver at Role Level
                If blnIsDemandApprover = True Then
                    'End Added by SanaS on 14-Oct-2009 for Demand Approver at Role Level
                    If strRoleLevel = "1" Then
                        'Code commented and added by SanaS on 15-Sep2009 for issue as only ADMIN can approve the demand.
                        '    If HttpContext.Current.Session("intUserID").ToString = "61" Then
                        GetPageSpecificFilters += " AND 1=1 "
                        '    Else
                        '        GetPageSpecificFilters += " AND 1=2 "
                        '    End If
                        'End Code comment and addition by SanaS on 15-Sep2009 for issue as only ADMIN can approve the demand.
                    ElseIf strRoleLevel = "2" Then
                        GetPageSpecificFilters += " AND " + " ((BusinessGroupID = " + CType(strBusinessGroupID, String) + " AND " + "LocationID = " + CType(strLocationID, String) + ")"
                        strAccessibleOpportunity = "usp_sel_BGOU_Wise_Opprtunity " + CType(HttpContext.Current.Session("intUserID"), String)
                        OpportunityIDs = CType(CommonFunctions.Data.GetDataScalar(strAccessibleOpportunity, True), String)
                        If OpportunityIDs <> "" Then
                            GetPageSpecificFilters += " OR OpportunityID IN( " + OpportunityIDs + ")"
                        End If
                        GetPageSpecificFilters &= " ) "

                        'If Low Level ,Don't show opportunity in Approval Page.
                    ElseIf strRoleLevel = "3" Then
                        GetPageSpecificFilters += " AND 1=2 "
                    End If
                    'Added by SanaS on 14-Oct-2009 for Demand Approver at Role Level
                Else
                    GetPageSpecificFilters += " AND 1=2 "
                End If
                'End Added by SanaS on 14-Oct-2009 for Demand Approver at Role Level
        End Select

    End Function

End Class
'Addition done by SuchitraP on 12-Dec-2007
'Purpose:In order to cancel the hyperlink seen on list page
Class cHR_Opportunity_CommonListGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Dim strProspect As String
        'strProspect = Args.DataReader("Prospect").ToString

        If Args.ColumnName = "Prospect/Customer" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=Left>" + Args.DataReader("Prospect").ToString + "</TD>"
        End If
    End Sub
End Class
'End of addition by SuchitraP on 12-Dec-2007