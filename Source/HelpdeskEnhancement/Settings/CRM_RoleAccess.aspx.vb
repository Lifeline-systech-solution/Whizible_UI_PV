Public Class CRM_RoleAccess
    Inherits WebPages.Template.WhizTemplate

    Protected m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Protected m_strUserName As String = ""
    Protected m_lngLoginID As Long
    Protected m_strLoginName As String
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared TagID As String = 312
    Protected m_lngTagID As Long
    'Initi Varibale Related to Access
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected CONST_ROLE_ACCESS As String = "ROLE"
    Protected CONST_TAG_ACCESS As String = "TAG"
    Protected CONST_GROUP_ACCESS As String = "GROUP"

    Protected CONST_ACTION_SAVE As String = "1"
    Protected CONST_ACTION_SAVE_AND_CLOSE As String = "2"
    Protected CONST_SUBNODE_ACCESS As String = "SUBNODE"
    Protected CONST_SUBNODE_ACCESS_GROUP As String = "SUBNODEG"
    Protected CONST_INHERIT_ACCESS As String = "INHERIT"
    Protected CONST_INHERIT_ACCESS_GROUP As String = "INHERITG"
    Protected m_strMode As String = "Role"

    Private m_strModule As String
    Protected m_strTemplateID As String
    Protected m_lngUserAccessID As Long
    Protected strRefreshAction As String
    Private m_blnIsAdmin As Boolean = False
    Private m_lngCurrentUserRoleID As Long
    Protected m_strFromWhere As String
    Private m_strParentList As String

    Protected m_lngRoleID As Long
    Protected m_strWindowTitle As String
    Private m_arlSubTagIDList As New ArrayList

    Protected Function PageInit(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal Flag As String)
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali Vekhande
        ' Created               : 11th Dec 2017
        ' Revisions             : None
        '=====================================================================


        Dim strHTML As New StringBuilder
        Dim strAction As String = ""
        GetAccessRights()
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)

        strRefreshAction = Request.QueryString("strAction")
        If m_blnIsAdmin = False Then
            If (strRefreshAction = "") Then
                strHTML.Append("<Input Type='hidden' id='MasterTagID' name='MasterTagID' value='" + m_objGlobal.TagID.ToString + "'>")
            End If
        End If

        strHTML.Append("<div id='Type' class='tabcontent1 h-type clsSettingstabs'>")
        'strHTML.Append(PlotFilter(strWhichGrid, strGridFlag, ""))
        
        'For Filter Plotting As Per Role Default Module
        Dim strSQL As String = ""
        Dim strRoleDesc As String
        Dim objRoleAccess As IDataReader
        'dt = CommonFunctions.Data.GetDataTable("usp_NG_sel_tbl_PM_Role_UserAccess", True)
        If (Request.QueryString("RoleID") IsNot Nothing) Then
           m_lngUserAccessID = CType(Request.QueryString("RoleID"), Long)
        Else
            strSQL = "usp_NG_Sel_tbl_PM_RoleAcess "
            objRoleAccess = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objRoleAccess.Read Then
                If Not IsDBNull(objRoleAccess("UserAccessID")) Then
                    m_lngUserAccessID = CType(objRoleAccess("UserAccessID"), Long)
                Else
                    m_lngUserAccessID = ""
                End If
            End If
        End If

        strAction = HttpUtility.HtmlEncode(Request.QueryString("Action") + "")


        If strAction = "CONST_ACTION_SAVE" Then
            strAction = "1"
        ElseIf strAction = "CONST_ACTION_SAVE_AND_CLOSE" Then
            strAction = "2"
        End If

        If Request.QueryString("TagID") <> "" Then
            m_lngTagID = CType(Request.QueryString("TagID"), Long)
        Else
            m_lngTagID = 0
        End If



        If m_lngUserAccessID > 0 Then
            Dim objDR As IDataReader
            'get the Role name and editable tag list for the userAccessID from the database
            strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
            objDR = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDR.Read Then
                If Not IsDBNull(objDR("RoleID")) Then
                    m_intRoleID = CType(objDR("RoleID"), Long)
                Else
                    m_intRoleID = 0
                End If
                If Not IsDBNull(objDR("RoleDescription")) Then
                    strRoleDesc = objDR("RoleDescription").ToString + ""
                Else
                    strRoleDesc = ""
                End If

            End If
            objDR.Close()
            objDR.Dispose()
            objDR = Nothing
        End If
        If m_strMode.ToUpper = CONST_TAG_ACCESS.ToUpper Or m_strMode.ToUpper = CONST_ROLE_ACCESS.ToUpper Then
            If Not Request.QueryString("ModuleID") Is Nothing Then
                ' ***********************************************************************************
                ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
                ' ***********************************************************************************
                m_strTemplateID = HttpUtility.HtmlEncode(Request.QueryString("ModuleID").ToString)
            End If
        End If
        If m_strMode.ToUpper = CONST_ROLE_ACCESS Then
            If m_strTemplateID = "" Then m_strTemplateID = "SM" 'default module is Project
        Else
            If m_strTemplateID = "" Then m_strTemplateID = "SM"
        End If
        Select Case (m_strMode.ToUpper)
            Case CONST_ROLE_ACCESS
                If strAction <> "" Then
                    Call performAction(strAction, m_lngUserAccessID)
                End If


                If m_strMode <> CONST_INHERIT_ACCESS And m_strMode <> CONST_INHERIT_ACCESS_GROUP Then
                    If Not IsPostBack Then
                        m_strTemplateID = HttpUtility.HtmlEncode(Request.QueryString("ModuleID")) + ""
                        If m_strTemplateID = "" Then
                            strSQL = "usp_Sel_tbl_Pm_Role_DefaultModule " + m_intRoleID.ToString
                            m_strTemplateID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")
                        End If
                    Else
                        '
                        m_strTemplateID = HttpUtility.HtmlEncode(Request.QueryString("ModuleID")) + ""
                        If m_strTemplateID = "" Then
                            m_strTemplateID = Request.Form("cboModule") + ""
                        End If
                    End If

                    If m_strMode = CONST_ROLE_ACCESS Then
                        If Not Request.QueryString("ModuleID") Is Nothing Then

                            m_strTemplateID = HttpUtility.HtmlEncode(Request.QueryString("ModuleID").ToString)
                        End If
                    End If

                End If
                If (strRefreshAction <> "Refresh") Then
                    strHTML.Append("<table width='100%'>" + vbCrLf)
                    strHTML.Append("<tr>" + vbCrLf)
                    strHTML.Append("<td>")
                    strHTML.Append("<div class='form-group'>")
                    strHTML.Append("<label class='control-label col-sm-4' for='request type' id='labelModule'>Select Modules </label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "usp_NG2_Sel_Modules", 183, m_strTemplateID, " onchange='javascript:Module_OnChange()' class='form-control'", False, True) + "</TD>")
                    '<input type="text" style="width:217px;" class="form-control" id="requesttype"  name="requesttype">
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("</td>")


                    strHTML.Append("<td>")
                    strHTML.Append("<div class='form-group'>")
                    strHTML.Append("<label class='control-label col-sm-2' for='request type' id='labelRole'>Role </label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_NG_Sel_tbl_PM_RoleAcess ", 183, m_lngUserAccessID, " class='form-control' style='display:inline-block'", False, True) + "")
                    '<input type="text" style="width:217px;" class="form-control" id="requesttype"  name="requesttype">
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("</td>")

                    strHTML.Append("<td>")
                    strHTML.Append("<div class='divBtn'>")
                    'If m_objAccess.Add = True Or m_objAccess.Edit = True Then
                    '/*Changed By Yasmin on 25th july 2018*/
                    strHTML.Append("<button type='button' class='btn btn-default save' onclick=Save_OnClick('CONST_ACTION_SAVE_AND_CLOSE') style='margin-right:2px;'>Save</button>")
                    'End If

                    strHTML.Append("<button type='button' class='btn btn-default save' onclick=SelectAll_OnClick() style='margin-right:2px;'>Select All</button>")
                    strHTML.Append("<button type='button' class='btn btn-default save' onclick=ClearAll_OnClick() style='margin-right:2px;'>Clear All</button>")
                    strHTML.Append("</div>")
                    strHTML.Append("</td>")

                    strHTML.Append("</tr>" + vbCrLf)
                    strHTML.Append("</table>" + vbCrLf)
                    'End of  Filter Plotting As Per Role Default Module

                    If (strRefreshAction = "Refresh") Then
                        'CommonFunctions.General.WriteHTML(strHTML.ToString())
                        'CommonFunctions.General.WriteHTML("<BR>")
                        Response.Clear()
                    End If
                End If

                'For GRid Plotting
                strHTML.Append(plotGrid(m_strTemplateID))
                'End of  GRid Plotting
        End Select
        strHTML.Append("</div>")



        'If (strGridFlag.ToUpper = "LOAD") Then
        '    CommonFunctions.General.WriteHTML(strHTML.ToString)
        'Else
        '    Return strHTML.ToString
        'End If

        If (strRefreshAction = "" And strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString())
            CommonFunctions.General.WriteHTML("<BR>")
        Else
            ' Return strHTML.ToString
            CommonFunctions.General.WriteHTML(strHTML.ToString())
        End If

    End Function
    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali Vekhande
        ' Created               :	6th-DEC-2017
        ' Revisions             :
        '=====================================================================
      
        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), m_strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

    End Sub
    Public Function plotGrid(ByVal strTemplateID As String)
        '=====================================================================
        ' Procedure Name        : plotGrid()	
        ' Purpose               : To Plot Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali Vekhande
        ' Created               : 11 Dec 2017
        ' Revisions             : None
        '=====================================================================

        Dim strSQL As String
        Dim strHTML As New StringBuilder
        Dim objDrParent As IDataReader
        Dim objDrSubTag As IDataReader
        Dim objDr As IDataReader
        Dim lngTagID As Long
        Dim lngSubTagID As Long
        Dim blnAdd As Boolean
        Dim blnEdit As Boolean
        Dim blnDelete As Boolean
        Dim blnView As Boolean
        Dim blnAccess As Boolean
        Dim strModuleName As String = ""
        Dim strEditableTagList As String = ""
        Dim blnCheckboxDisabled As Boolean
        ' Dim objLink As UI.cDynamicLink
        Dim intCnter As Integer
        Dim intRowCount As Integer
        Dim intTRCount As Integer
        Dim blnIsParent As Boolean

        'get the Role name and editable tag list for the userAccessID from the database
        strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
        objDr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("EditableTagList")) Then
                strEditableTagList = objDr("EditableTagList").ToString + ""
            Else
                strEditableTagList = ""
            End If
        End If
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        'display table
        '******************************************************************************************
        ' strHTML.Append("<BR>")
        strHTML.Append("<Div id='MainOuterDiv' width='100%' >")
        strHTML.Append("<Div id='DivList' width='100%' >")
        If UCase(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("IsStaticHeaderStyle"), "ON")) = "ON" Then
            CommonFunction.General.WriteHTML(CommonFunctions.General.PlotStaticHeaderStyle("DivList"))
        End If
        'If strRefreshAction = "Refresh" Then
        '    Response.Clear()
        'End If
        strHTML.Append("<Table class='clsGridTable table' width=100% cellspacing=1 cellpadding=0>")
        'display column headers
        If UCase(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("IsStaticHeaderStyle"), "ON")) = "ON" Then
            strHTML.Append("<THead class='clsTRColumnHeader'>")
            strHTML.Append("<TH class='FixedTD' align=left>Functionality</TH>")
            'General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_TAB_COLL") + "</TH>")
            'General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_SUBTAG") + "</TH>")
            strHTML.Append("<TH class='FixedTD' align=center style='text-align:center !important;'>Access</TH>")
            strHTML.Append("<TH class='FixedTD' align=center style='text-align:center !important;'>Add</TH>")
            strHTML.Append("<TH class='FixedTD' align=center style='text-align:center !important;'>Edit</TH>")
            strHTML.Append("<TH class='FixedTD' align=center style='text-align:center !important;'>Delete</TH>")
            strHTML.Append("<TH class='FixedTD' align=center style='text-align:center !important;'>View</TH>")
            strHTML.Append("</THead>")
        Else
            strHTML.Append("<TR class='clsTRColumnHeader'>")
            strHTML.Append("<TD align=left>Functionality</TD>")
            'General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_TAB_COLL") + "</TD>")
            'General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_SUBTAG") + "</TD>")
            strHTML.Append("<TD align=center>Access</TD>")
            strHTML.Append("<TD align=center>Add</TD>")
            strHTML.Append("<TD align=center>Edit</TD>")
            strHTML.Append("<TD align=center>Delete</TD>")
            strHTML.Append("<TD align=center>View</TD>")
            strHTML.Append("</TR>")
        End If


        'start displaying the data
        strSQL = "usp_NG2_Sel_tbl_UI_TagMaster_AllParents " + m_strTemplateID.Trim

        If CommonFunctions.General.GetFrameworkSettings("PB_DO_NOT_SHOW_SYSTEM_WEB_FORMS_IN_ROLE_ACCESS", "Enabled") Then
            strSQL += ",0"
        End If

        objDrParent = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        intRowCount = 0
        intTRCount = 0
        Dim objhtTagMaster As CommonEngines.HashTables.UITagMaster 'Added By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        Dim objhtSubTagMaster As CommonEngines.HashTables.SubUITagMaster() 'Added By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        While objDrParent.Read
            If Not IsDBNull(objDrParent("ModuleID")) Then
                strModuleName = objDrParent("ModuleDescription").ToString + ""
            Else
                strModuleName = ""
            End If
            If Not IsDBNull(objDrParent("TagID")) Then
                lngTagID = CType(objDrParent("TagID"), Long)
            Else
                lngTagID = 0
            End If

            strHTML.Append("<TR class='ClsTR'>")

            strHTML.Append("<TD align=left><B>" + strModuleName.Trim + "</B></TD>")

            'check if user has access to Tag
            blnCheckboxDisabled = False
            If (UserHasAccessToTag(lngTagID, strEditableTagList)) Then
                blnAccess = True
                blnCheckboxDisabled = False
            Else
                blnAccess = False
                blnCheckboxDisabled = True
            End If
         
            intRowCount += 1
            intTRCount += 1
            'if it is ShowAccessLinks flag is on then only show Add.Edit,Delete,View checkboxes for the tag.
            If CType(objDrParent("ShowAccessLinks"), Boolean) = True Then
                Dim blnValues As Boolean()
                blnValues = CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole(m_intRoleID.ToString + "-0-" + lngTagID.ToString)
                If Not blnValues Is Nothing Then
                    blnAdd = blnValues(0)
                    blnEdit = blnValues(1)
                    blnDelete = blnValues(2)
                    blnView = blnValues(3)
                Else
                    blnAdd = False
                    blnEdit = False
                    blnDelete = False
                    blnView = False
                End If
                ''General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(" + intTRCount.ToString + ",event)", True) + "</TD>")
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(event," + intTRCount.ToString + ")", True) + "</TD>")
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")

                strHTML.Append("</TR>")
            Else

                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(" + intTRCount.ToString + ")", True) + "</TD>")
                'Ended
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , , "", True, , True, , , , True) + "</TD>")
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , , "", True, , True, , , , True) + "</TD>")
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , "", True, , True, , , , True) + "</TD>")
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkView", "chkView", , , "", True, , True, , , , True) + "</TD>")

                strHTML.Append("</TR>")
            End If

            'display the Subtag list
            If strModuleName = "" Then
                strSQL = "EXEC usp_NG2_Sel_UserAccessControls Null," + lngTagID.ToString
            Else
                strSQL = "EXEC usp_NG2_Sel_UserAccessControls '" + strTemplateID.Trim + "'," + lngTagID.ToString
            End If

            If CommonFunction.General.GetFrameworkSettings("PB_DO_NOT_SHOW_SYSTEM_WEB_FORMS_IN_ROLE_ACCESS", "Enabled") Then
                strSQL += ",0"
            End If
            objDrSubTag = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            intCnter = 1
            While objDrSubTag.Read

                If Not IsDBNull(objDrSubTag("TagID")) Then
                    lngSubTagID = CType(objDrSubTag("TagID"), Long)
                End If

                'get the tag info
                objhtTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngSubTagID)
                If Not objhtTagMaster Is Nothing AndAlso objhtTagMaster.ModuleIdentifier.Trim.ToUpper <> "R" Then 'Modified By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
                    'if the tag is parent tag then dont show 
                    blnIsParent = objhtTagMaster.IsParent
                    If blnIsParent = False Then
                        If (UserHasAccessToTag(lngSubTagID, strEditableTagList)) Then
                            blnAccess = True
                            blnCheckboxDisabled = False
                        Else
                            blnAccess = False
                            blnCheckboxDisabled = True
                        End If

                        If intCnter Mod 2 <> 0 Then
                            strHTML.Append("<TR class='clsTROdd odd' id='chkAccess" + intTRCount.ToString + "TR' name='chkAccess" + intTRCount.ToString + "TR' >") 'Modified By Ninad on 18 May 2009 IssueID-30417
                        Else
                            strHTML.Append("<TR class='ClsTR' id='chkAccess" + intTRCount.ToString + "TR' name='chkAccess" + intTRCount.ToString + "TR' >") 'Modified By Ninad on 18 May 2009 IssueID-30417
                        End If

                        'display the link in the first column depending on the blnAccess
                        If blnAccess = True AndAlso Not CommonEngines.HashTables.GetHashTableObject.IsTabCollectionTag(lngSubTagID) Then
                           
                            strHTML.Append("<TD align='left'>" + strModuleName.Trim + "-->" + objDrSubTag("ModuleDescription").ToString + "</TD>")
                        Else
                            strHTML.Append("<TD align='left'>" + strModuleName.Trim + "-->" + objDrSubTag("ModuleDescription").ToString + "</TD>")
                        End If
                        
                        Dim blnValues As Boolean()
                        blnValues = CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole(m_intRoleID.ToString + "-0-" + lngSubTagID.ToString)
                        If Not blnValues Is Nothing Then
                            blnAdd = blnValues(0)
                            blnEdit = blnValues(1)
                            blnDelete = blnValues(2)
                            blnView = blnValues(3)
                            'End Modification By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
                        Else
                            blnAdd = False
                            blnEdit = False
                            blnDelete = False
                            blnView = False
                        End If

                        'display the check boxes

                        'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngSubTagID.ToString, , "onclick=javascript:Access_OnClick(event,'')", True))
                        strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngSubTagID.ToString, , "onclick=javascript:Access_OnClick(" + intRowCount.ToString + ",event)", True))
                        ''End of Commented and Modified by swapnil aswale on 01-Oct-2015 Purpose:Initiative issue fixing
                        'Added By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
                        If CommonEngines.HashTables.GetHashTableObject.IsTabCollectionTag(lngSubTagID) Then
                            strHTML.Append("<TD colspan=4 align='center'>")
                            strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            strHTML.Append("</TD>")
                        Else
                            'End Addition By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
                            strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                            strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                            strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                            strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                        End If
                        intRowCount += 1
                        strHTML.Append("</TR>")
                        intCnter += 1
                    End If
                End If
            End While
            objDrSubTag.Close()
            objDrSubTag.Dispose()
            objDrSubTag = Nothing
        End While

        objhtTagMaster = Nothing
        objDrParent.Close()
        objDrParent.Dispose()
        objDrParent = Nothing

        strHTML.Append("</Table>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , intRowCount.ToString, , , , , , True, , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("hdtxtParentRowCount", "hdtxtParentRowCount", , , , intTRCount.ToString, , , , , , True, , True))
        'If strRefreshAction = "Refresh" Then
        '    Response.End()
        'End If
        strHTML.Append("</Div>")

        Return strHTML.ToString

    End Function
  
    Private Function UserHasAccessToTag(ByVal lngTagID As Long, ByVal strEditableTagIDList As String) As Boolean
        '=====================================================================
        ' Procedure Name		:	UserHasAccessToTag
        ' Parameters Passed		:	lngTagID - Long
        '                           strEditableTagIDList - string
        ' Returns				:	boolean, True if Tag id Present in the list
        ' Parameters Affected	:	None
        ' Purpose				:	To check if given tagid is there in the list of tag id's.
        ' Description			:	This function will check the existence of the TagID in the 
        '                           given tag id list in strEditableTagIDList by spliting the quama seperated list 
        '                           and returns true if Tag id present in the list.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author                : Dipali Vekhande
        ' Created               : 12 Dec 2017
        ' Revisions				:	
        '=====================================================================
        Dim arrTagID() As String
        Dim intCnt As Integer
        Dim blnReturn As Boolean = False

        If strEditableTagIDList <> "" Then
            arrTagID = Split(strEditableTagIDList, ",")

            For intCnt = 0 To arrTagID.Length - 1
                If lngTagID.ToString.Trim = arrTagID(intCnt).Trim Then
                    blnReturn = True
                    Exit For
                End If
            Next
        Else
            blnReturn = False
        End If

        UserHasAccessToTag = blnReturn
    End Function
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_lngCurrentUserRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), "0"), Long)
        If m_lngCurrentUserRoleID <> CommonFunctions.Constants.ROLE_ADMINISTRATOR Then
            m_blnIsAdmin = False
            GetAccessRights()
        Else
            m_blnIsAdmin = True
        End If
    End Sub


    Private Sub performAction(ByVal strAction As String, ByVal lngUserAccessID As Long)
        '=====================================================================
        ' Procedure Name		:	performAction
        ' Parameters Passed		:	strAction - string 
        '                           lngUserAccessID - long
        '                           
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To update the database based on the action parameter
        ' Description			:	This procedure will update the database for access for the 
        '                           UserAccessID passed to it.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:	12th Dec 2017
        ' Revisions				:	
        '=====================================================================

        Dim arrAccessTagIDList() As String
        Dim strAccessTagID As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim i As Integer
        Dim strAddAccess As String
        Dim strEditAccess As String
        Dim strDeleteAccess As String
        Dim strViewAccess As String

        Select Case (strAction)
            Case CONST_ACTION_SAVE, CONST_ACTION_SAVE_AND_CLOSE 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                'get the list of all tagID's of parents

                strAccessTagID = Request.Form("chkAccess") + ""
                If strAccessTagID = "" Then

                    strSQL = "usp_udt_tbl_UserAccess '" + CommonFunction.General.BuildQueryString(m_strTemplateID.Trim) + "'," + lngUserAccessID.ToString + ",Null"
                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                Else
                    m_strParentList = ""

                    'here parent tag ID list is created for giving access as if subtag has access
                    'then parent tag gets the access.
                    arrAccessTagIDList = Split(strAccessTagID, ",")
                    For i = 0 To arrAccessTagIDList.Length - 1
                        Call getParentTagIDList(CType(arrAccessTagIDList(i).Trim, Long))
                    Next

                    'update the database for parent Tag access
                    If m_strTemplateID = "" Then
                        If strAccessTagID = "" Then
                            strSQL = "usp_udt_tbl_UserAccess Null," + lngUserAccessID.ToString + ",Null"
                        Else
                            strSQL = "usp_udt_tbl_UserAccess Null," + lngUserAccessID.ToString + ",'" + m_strParentList.Trim + "'"
                        End If
                    Else
                        If strAccessTagID = "" Then
                            strSQL = "usp_udt_tbl_UserAccess '" + CommonFunction.General.BuildQueryString(m_strTemplateID.Trim) + "'," + lngUserAccessID.ToString + ",Null"
                        Else
                            strSQL = "usp_udt_tbl_UserAccess '" + CommonFunction.General.BuildQueryString(m_strTemplateID.Trim) + "'," + lngUserAccessID.ToString + ",'" + m_strParentList.Trim + "'"
                        End If
                    End If

                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                    'get the RoleId for UserAccessID
                    strSQL = "usp_Sel_RoleForUserAccessID " + lngUserAccessID.ToString
                    objDR = CommonFunction.Data.GetDataReader(strSQL, True)
                    If objDR.Read Then
                        If Not IsDBNull(objDR("RoleID")) Then
                            m_lngRoleID = CType(objDR("RoleID"), Long)
                        Else
                            m_lngRoleID = 0
                        End If

                    End If
                    objDR.Close()
                    objDR.Dispose()
                    objDR = Nothing

                    'check if there is no entry in the node access table for the role then make entry
                    'in the node access table for the role
                    strSQL = "Exec usp_Ins_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + m_strParentList.Trim + "'"
                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                    'update the user access table for add,edit,delete and view access
                    strAddAccess = Request.Form("chkAdd") + ""
                    strEditAccess = Request.Form("chkEdit") + ""
                    strDeleteAccess = Request.Form("chkDelete") + ""
                    strViewAccess = Request.Form("chkView") + ""

                    'Set/Reset the access rights for Add
                    strSQL = "EXEC usp_Upd_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + strAddAccess.Trim + "','A','" + CommonFunction.General.BuildQueryString(m_strTemplateID.Trim) + "'"
                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                    'set/reset access for Edit
                    strSQL = "EXEC usp_Upd_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + strEditAccess.Trim + "','E','" + CommonFunction.General.BuildQueryString(m_strTemplateID.Trim) + "'"
                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                    'set/reset access for Delete
                    strSQL = "EXEC usp_Upd_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + strDeleteAccess.Trim + "','D','" + CommonFunction.General.BuildQueryString(m_strTemplateID.Trim) + "'"
                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                    'set/reset access for View
                    strSQL = "EXEC usp_Upd_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + strViewAccess.Trim + "','V','" + CommonFunction.General.BuildQueryString(m_strTemplateID.Trim) + "'"
                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                End If
            Case Else
        End Select


        CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()


        'clear the hashtable entries for all the user who have selected role.
        If UCase(m_strMode) = CONST_ROLE_ACCESS Then
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'R','" + m_strTemplateID.Trim + "'," + m_lngRoleID.ToString)
        ElseIf UCase(m_strMode) = CONST_GROUP_ACCESS Then
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'U',null,null,null,null," + m_lngRoleID.ToString)
        End If


    End Sub
    Private Sub getParentTagIDList(ByVal lngTagID As Long)

        '=====================================================================
        ' Procedure Name		:	getParentTagIDList
        ' Parameters Passed		:	TagID - long
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	to get the list of parent Tag ID of the passed Tag ID.
        ' Description			:	This procedure will get tag id and check it in the other 
        '                           array of Tag ID for presence. If not present the add to that
        '                           list and check if it has any parent.If it has any parent then
        '                           for that parent TagID also same procedure will be called in recursion.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:	12th Dec 2017

        '=====================================================================
        Dim blnPresent As Boolean
        Dim arrParentTagIDList() As String
        Dim i As Integer
        Dim lngTempTagID As Long
        'Dim objDR As IDataReader

        blnPresent = False
        arrParentTagIDList = Split(m_strParentList, ",")
        For i = 0 To arrParentTagIDList.Length - 1
            If lngTagID.ToString.Trim = arrParentTagIDList(i).Trim Then
                blnPresent = True
                Exit For
            End If
        Next
        If blnPresent = False Then
            m_strParentList += lngTagID.ToString + ","
        End If
        lngTempTagID = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID).ParentTagID
        If lngTempTagID <> 0 Then
            Call getParentTagIDList(lngTempTagID)
        End If
    End Sub
End Class