Public Partial Class ConfigureGadgetNodes
    Inherits WebPages.Template.WhizTemplate
    Protected strHTML As New System.Text.StringBuilder
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    'this indicates the NodeTagID
    Private strGadgetNodeID As String
    'Added by sonald on 12th august 2008
    'this indicates the NodeGadgetID
    Private strNodeGadgetID As String
    Dim strSQL As String
    Dim drStatus As String
    Dim m_Access As String
    'End of addition by sonald on 12th august 2008
    Private ModuleID As String = ""
    Private ModuleID_ForSP As String = ""
    Private selectedCheckBoxes_ForDelete As String
    Private strcboGadgetName As String
    Private ParentID_ForSP As String = ""
    Private strParentID As String = ""
    Private FilterParentName As String = "NULL"
    Private FilterPageName As String = ""
    Private m_IsSelected As String = ""
    Private m_strMode = ""
    Protected m_isreadonly As Boolean = False
    Dim tagID As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To draw page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : NA
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShraddhaM
        ' Created               : 10,June 2008
        ' Revisions             :
        '=====================================================================
        Dim strMenu As String
        strMenu = GenerateMenu()
        strHTML.Append(strMenu)

        Call InitVariables()

        If Request.QueryString("Action") = "SAVE" Then
            Call SaveData()
        ElseIf Request.QueryString("Upload") = "1" Then
            UploadFile()
        End If

        Call DrawHeaderSection()
        strHTML.Append("<div ID='PageDiv' Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:100%'>")
        If m_strMode = "EDIT" Then
            Call DrawGrid()
        End If
        strHTML.Append("</div>")
        Call PlotHiddenControls()

        strHTML.Append(GenerateMenu())

        Response.Write(strHTML.ToString())
    End Sub

    Private Sub PlotHiddenControls()
        strHTML.Append("<input type=hidden name='hidNodeIDForDelete' id='hidNodeIDForDelete' value=" + selectedCheckBoxes_ForDelete + ">")
        'Added by SonalD on 25th june 2008
        strHTML.Append("<input type=hidden name='hidIsSelected' id='hidIsSelected' value=" + m_IsSelected + ">")
        'end of addition by SonalD on 25th june 2008
        strHTML.Append("<input type=hidden name='hidMode' id='hidMode' value=" + m_strMode + ">")
    End Sub


    Private Function GenerateMenu()

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionsList As New ArrayList

        arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\save.gif'>Save")
        arrMenuToolTipList.Add("Save")
        arrClientSideFunctionsList.Add("Save_OnClick()")

        'arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\saveadd.gif'> Save and Add")
        'arrMenuToolTipList.Add("Save and Add")
        'arrClientSideFunctionsList.Add("SaveandAdd_OnClick()")

        arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/back.gif'>Back")
        arrMenuToolTipList.Add("Back")
        arrClientSideFunctionsList.Add("Back_OnClick()")

        arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        arrMenuToolTipList.Add("Help")
        arrClientSideFunctionsList.Add("Help_OnClick('3966')")

        Dim arrMenu() As String = GetArray(arrMenuList)
        Dim arrMenuToolTip() As String = GetArray(arrMenuToolTipList)
        Dim arrClientSideFunctions() As String = GetArray(arrClientSideFunctionsList)

        m_objMenu = New WebPage.Templates.StaticMenu
        GenerateMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
    End Function

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

    Private Sub DrawHeaderSection()

        Dim strQuery As String
        Dim dr As IDataReader
        Dim GadgetNodeName As String = ""
        Dim strNewNodeName As String = ""


        Dim ParentID As String = ""
        Dim OrderNo As String = ""

        Dim NodeImage As String = "Upload Image"

        Dim ParentID_ForFilter As String

        'Plot page names Grid
        If Request.QueryString("Action") = "comboChanged" Then
            ModuleID_ForSP = CommonFunction.General.CheckIsNothing(Request.Form("cboModuleName"), "NULL")
            ModuleID = Request.Form("cboModuleName")
        Else
            'added by sonalD on 10th October 2008
            'Purpose:select project module as default module while creating gadgets..for issue id 23458
            ModuleID = "PM"
            ModuleID_ForSP = "PM"
            'End of addition by sonalD on 10th October 2008
            'Commented by sonalD for the same purpose as above
            'ModuleID_ForSP = "NULL"
        End If

        If ModuleID_ForSP = "" Then
            strcboGadgetName = ""
        End If

        'If Request.QueryString("Action") = "AppliedFilter" Then
        If Not Request.Form("cboParentName_Filter") Is Nothing And Request.Form("cboParentName_Filter") <> "" Then
            FilterParentName = Request.Form("cboParentName_Filter")
        Else
            FilterParentName = "NULL"
        End If
        If Not Request.Form("txtPageName_Filter") Is Nothing And Request.Form("txtPageName_Filter") <> "" Then
            FilterPageName = Request.Form("txtPageName_Filter")
        End If
        'End If

        strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>" + vbCrLf)
        strHTML.Append("<TR class=clsTRPageCaption>" + vbCrLf)
        strHTML.Append("<TD align=Left>Add Gadget Node</TD>" + vbCrLf)
        strHTML.Append("<TD align='Right'><B>(<IMG src='../../Images/Star.gif' border=0> Mandatory)</B></TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)
        strHTML.Append("</TABLE>" + vbCrLf)
        strHTML.Append("<BR>" + vbCrLf)

        'Plot controls

        strQuery = "usp_Sel_GadgetDetails " + strGadgetNodeID
        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        GadgetNodeName = Request.Form("txtGadgetNode")

        While dr.Read()
            'GadgetNodeName = dr("TagName").ToString()
            ModuleID = CommonFunction.General.CheckIsNothing(dr("ModuleID").ToString(), "NULL")
            ModuleID_ForSP = ModuleID
            strParentID = CommonFunction.General.CheckIsNothing(dr("ParentTagID").ToString(), "")
            OrderNo = CommonFunction.General.CheckIsNothing(dr("OrderNumber").ToString(), "")
            strcboGadgetName = CommonFunction.General.CheckIsNothing(dr("NodeTagID").ToString, "")
            'added by sonald on 12th august 2008
            strNodeGadgetID = CommonFunction.General.CheckIsNothing(dr("NodeGadgetID").ToString, "")
            strNewNodeName = CommonFunction.General.CheckIsNothing(dr("NewNodeName"), "")
            'end of addition by sonald on 12 th august 2008
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        ''strHTML.Append("<div ID='PageDiv' Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:100%'>")
        strHTML.Append("<table border=0 width=100% cellspacing=0 cellpadding=0 class='clsGridTable'>" + vbCrLf)

        strHTML.Append("<tr class='clsTRBody'>" + vbCrLf)
        strHTML.Append("<TD align=right >Module Name</TD>" + vbCrLf)
        strHTML.Append("<TD>" + vbCrLf)
        If m_strMode = "EDIT" Then
            'Modified by SonalD for issue id 23458 on 10th October 2008
            'strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboModuleName", "usp_Sel_PB_tbl_PM_SystemModules", 150, ModuleID, " onChange=comboChanged() IIf(true, ' disabled ')", True, True, , True, , ))
            strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboModuleName", "select 'PM' as ShortName,'Project' as ModuleName", 150, ModuleID, " onChange=comboChanged() IIf(true, ' disabled ')", True, True, , True, , ))
            'End of Modification
        End If
        If m_strMode = "ADD_NEW" Then
            'Modified by SonalD for issue id 23458 on 10th October 2008
            'strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboModuleName", "usp_Sel_PB_tbl_PM_SystemModules", 150, ModuleID, " onChange=comboChanged()", True, True, , True, , ))
            strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboModuleName", "select 'PM' as ShortName,'Project' as ModuleName", 150, ModuleID, " onChange=comboChanged()", True, True, , True, , ))
            'End of Modification
        End If

        'CommonFunctions.HTMLControls.DrawComboBox("cboBusinessGroup", strSQL, 200, strControlValue, InsertBlankRow:=True, IsMandatory:=True, ToBeInserted:=IIf(m_isreadonly, " disabled ", ""))
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)

        'Dim strModuleID As String
        strHTML.Append("<tr class='clsTRBody'>" + vbCrLf)
        strHTML.Append("<TD align=right >Select Node</TD>" + vbCrLf)
        strHTML.Append("<TD>" + vbCrLf)

        'Added by SonalD on 19th August 2008
        Dim GroupingColName As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
        GroupingColName.DropdownGroupingColumn = "Parent"
        GroupingColName.MatchFieldID = CommonFunction.General.CheckIsNothing(strcboGadgetName, "0")
        If m_strMode = "EDIT" Then
            GroupingColName.ToBeInserted = " onChange=comboNodeChanged() IIf(True, ' disabled ')"
        End If
        If m_strMode = "ADD_NEW" Then
            GroupingColName.ToBeInserted = " onChange=comboNodeChanged()"
        End If
        GroupingColName.WidthInPixel = 300
        GroupingColName.IsMandatory = True
        GroupingColName.InsertBlankRow = True
        GroupingColName.ReturnHTML = True
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboGadgetName", "usp_Sel_GroupName_ForModule '" + ModuleID_ForSP + "','" + CommonFunction.General.CheckIsNothing(strcboGadgetName, "NULL") + "'", GroupingColName))
        'End of addition by SonalD on 19th August 2008

        'Added by SonalD on 3rd july 2008
        If Request.QueryString("Action") = "SAVE" Or m_strMode <> "ADD_NEW" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''strQuery = "SELECT ISNULL(OriginalTagImage,'Upload Image') OriginalTagImage FROM tbl_CNF_GadgetNodes WHERE NodeTagID=" + strGadgetNodeID
            strQuery = "usp_sel_tbl_CNF_GadgetNodes_OriginalTagImage " + strGadgetNodeID
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            NodeImage = CommonFunction.Data.GetDataScalar(strQuery, True)
            strHTML.Append("&nbsp;<A href='javascript:ShowUploadDialog(" + strGadgetNodeID + ",0)' Title='Upload Image' >")
            strHTML.Append(NodeImage)
            strHTML.Append("</A>")
        End If
        'end of addition by SonalD on 3rd july 2008
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)

        'added by SonaD on 18th August 2008
        strHTML.Append("<tr class='clsTRBody'>" + vbCrLf)
        strHTML.Append("<TD align=right >New Node Name</TD>" + vbCrLf)
        strHTML.Append("<TD>" + vbCrLf)
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtNewNodeName", "txtNewNodeName", , 300, 200, strNewNodeName, "LEFT", , , , IsMandatory:=True, returnHTML:=True))
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</tr>")
        'end of addition by SonalD on 18th August 2008

        strHTML.Append("<tr class='clsTRBody'>" + vbCrLf)
        strHTML.Append("<td>")
        strHTML.Append("</td>")
        strHTML.Append("<TD ALIGN=left>" + vbCrLf)
        strHTML.Append("[This selected node will have following Gadgets]" + vbCrLf)
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</tr>")

        strHTML.Append("</Table>" + vbCrLf)
        strHTML.Append("<BR>" + vbCrLf)

        'filter
        'strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>" + vbCrLf)
        'strHTML.Append("<TR class=clsTRPageFilters>" + vbCrLf)
        'strHTML.Append("<TD align=Left>Filters</TD>" + vbCrLf)
        'strHTML.Append("</TR>" + vbCrLf)
        'strHTML.Append("</TABLE>" + vbCrLf)
        'strHTML.Append("<BR>" + vbCrLf)

        If m_strMode = "EDIT" Then
            strHTML.Append("<table border=0 width=100% cellspacing=0 cellpadding=0 class='clsGridTable'>" + vbCrLf)
            strHTML.Append("<tr class='clsTRPageFilters'>" + vbCrLf)
            strHTML.Append("<TD align=right >Parent Node</TD>" + vbCrLf)
            strHTML.Append("<TD>" + vbCrLf)
            strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboParentName_Filter", "usp_Sel_tbl_UI_TagMaster_Parent_New '" + ModuleID_ForSP + "'", 200, FilterParentName, "onChange=ModuleFilter_onChange()", True, True, , , , ))
            strHTML.Append("</TD>" + vbCrLf)

            strHTML.Append("<TD align=right >Page Name</TD>" + vbCrLf)
            strHTML.Append("<TD title='Starts with'>" + vbCrLf)
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageName_Filter", "txtPageName_Filter", , 200, 200, FilterPageName, , , , , , , "onkeypress=txtPageName_OnKeyPress(event)", returnHTML:=True))
            strHTML.Append("</TD>" + vbCrLf)

            'added by sonald on 12 th august 2008
            CommonFunction.General.WriteHTML("<input type=hidden name='hidIsSelectedTemp' id='hidIsSelectedTemp' value='" + m_IsSelected + "'>")
            strSQL = "usp_sel_Gadgets " + strNodeGadgetID
            drStatus = CommonFunction.Data.GetDataScalar(strSQL, True)
            'drStatus is set to 1 if there are selected nodes else 0
            If m_Access = "1" Then
                If drStatus = 0 Then
                    m_IsSelected = 0
                End If
            End If
            'end of addition by sonald on 12th august 2008
            'Added by SonalD on 25th June 2008
            If m_strMode <> "ADD_NEW" Then
                If m_IsSelected = "0" Then
                    strHTML.Append("<TD>" + vbCrLf)
                    strHTML.Append("<A HREF=javascript:ShowSelectedPages_OnClick()>")
                    strHTML.Append("Show Selected Pages")
                    strHTML.Append("</A>")
                End If
                If m_IsSelected = "1" Or m_IsSelected = "" Then
                    strHTML.Append("<TD>" + vbCrLf)
                    strHTML.Append("<A HREF=javascript:ShowAllPages_OnClick()>")
                    strHTML.Append("Show All Pages")
                    strHTML.Append("</A>")
                End If
            End If
            If m_Access = "1" Then
                If drStatus = 0 Then
                    m_IsSelected = CommonFunction.General.CheckIsNothing(Request.Form("hidIsSelectedTemp"), "")
                End If
            End If
            'End of addition by SonalD on 25th June 2008

            strHTML.Append("</TD>" + vbCrLf)

            strHTML.Append("</TR>" + vbCrLf)


            strHTML.Append("</Table>" + vbCrLf)
            strHTML.Append("<BR>" + vbCrLf)
        End If
        strHTML.Append("<input type=hidden name='hidGadgetNodeID' id='hidGadgetNodeID' value=" + strGadgetNodeID + ">")

        'strHTML.Append("</div>" + vbCrLf)
    End Sub

    Private Sub DrawGrid()

        Dim strPageName As String
        'Dim tagID As String
        Dim strClass As String = "clsTROdd"
        Dim strQuery As String
        Dim drGrid As IDataReader
        Dim TagOrderNo As String
        Dim TagImage As String
        Dim IsChecked As Boolean
        Dim flag As Boolean = False

        If ModuleID Is Nothing OrElse ModuleID = "" Then
            ModuleID = Request.Form("cboModuleName")
        End If

        If ModuleID Is Nothing OrElse ModuleID = "" Then
            ModuleID = "NULL"
        End If

        selectedCheckBoxes_ForDelete = ""

        'strHTML.Append("<div ID='PageDiv' Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:100%'>")
        strHTML.Append("<table  width=100% CellSpacing=1 CellPadding=0  class='clsGridTable'>" + vbCrLf)
        strHTML.Append("<THead class='clsTRColumnHeader'>" + vbCrLf)
        strHTML.Append("<TH class='divListTag'  align='Left'>Page Name</TH>" + vbCrLf)
        strHTML.Append("<TH class='divListTag'  align='Left'>Image</TH>" + vbCrLf)
        'strHTML.Append("<TH class='divListTag'  align='right'>Order Number</TH>" + vbCrLf)
        strHTML.Append("<TH class='divListTag'  align='center'>Select</TH>" + vbCrLf)
        strHTML.Append("</THead>" + vbCrLf)

        strQuery = "usp_Sel_GadgetWise_SubNodes '" + ModuleID + "'," + strGadgetNodeID + "," + FilterParentName + ",'" + FilterPageName + "'"
        drGrid = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        'added by sonald on 12th august 2008
        If m_Access = "1" Then
            If drStatus = 0 Then
                m_IsSelected = 0
            End If
        End If
        'added by sonald on 12th august 2008

        While drGrid.Read()
            strPageName = drGrid("TagDescription").ToString()
            tagID = drGrid("TagID").ToString()
            TagImage = CommonFunction.Data.CheckIsDBNull(drGrid("OriginalTagImage"), "Upload Image").ToString
            IsChecked = CType(drGrid("IsChecked"), Boolean)
            TagOrderNo = drGrid("OrderNo").ToString

            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If

            If m_IsSelected = "1" Or m_IsSelected = "" Then
                'show only selected node 
                If IsChecked = True Then
                    strHTML.Append("<TR class=" + strClass + ">" + vbCrLf)
                    strHTML.Append("<TD>" + strPageName + "</TD>" + vbCrLf)
                    strHTML.Append("<TD><A href='javascript:ShowUploadDialog(" + strGadgetNodeID + "," + tagID + ")' Title='Upload Image' >" + TagImage + "</A></TD>" + vbCrLf)
                    'strHTML.Append("<TD align=right>" + CommonFunction.HTMLControls.DrawTextBox("txtTagOrderNo_" + tagID, "txtTagOrderNo_" + tagID, , 50, 2, TagOrderNo, "right", IsMandatory:=True, returnHTML:=True) + "</TD>" + vbCrLf)
                    strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , IsChecked, tagID, , , True) + "</TD>" + vbCrLf)
                    strHTML.Append("</TR>" + vbCrLf)
                    flag = True '******
                End If
            Else
                'show all the nodes
                strHTML.Append("<TR class=" + strClass + ">" + vbCrLf)
                strHTML.Append("<TD>" + strPageName + "</TD>" + vbCrLf)
                strHTML.Append("<TD><A href='javascript:ShowUploadDialog(" + strGadgetNodeID + "," + tagID + ")' Title='Upload Image' >" + TagImage + "</A></TD>" + vbCrLf)
                'strHTML.Append("<TD align=right>" + CommonFunction.HTMLControls.DrawTextBox("txtTagOrderNo_" + tagID, "txtTagOrderNo_" + tagID, , 50, 2, TagOrderNo, "right", IsMandatory:=True, returnHTML:=True) + "</TD>" + vbCrLf)
                strHTML.Append("<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , IsChecked, tagID, , , True) + "</TD>" + vbCrLf)
                strHTML.Append("</TR>" + vbCrLf)
            End If


            If IsChecked = True Then
                selectedCheckBoxes_ForDelete = selectedCheckBoxes_ForDelete + tagID + ","
            End If

        End While
        CommonFunction.Data.DisposeDataReader(drGrid)
        'added by sonald on 12 th august 2008
        If m_Access = "1" Then
            If drStatus = 0 Then
                m_IsSelected = CommonFunction.General.CheckIsNothing(Request.Form("hidIsSelected"), "")
            End If
        End If
        'added by sonald on 12 th august 2008

        strHTML.Append("</Table>")
        'strHTML.Append("</div>")
    End Sub

    Private Sub InitVariables()

        strGadgetNodeID = CommonFunction.General.CheckIsNothing(Request.QueryString("NodeTagID"), "")

        If strGadgetNodeID Is Nothing Or strGadgetNodeID = "" Then
            strGadgetNodeID = Request.Form("hidGadgetNodeID")
        End If
        If strGadgetNodeID Is Nothing Or strGadgetNodeID = "" Then
            strGadgetNodeID = "NULL"
        End If

        If Not Request.Form("hidNodeIDForDelete") Is Nothing Then
            selectedCheckBoxes_ForDelete = Request.Form("hidNodeIDForDelete")
        End If

        If Not Request.Form("cboGadgetName") Is Nothing OrElse Request.Form("cboGadgetName") <> "" Then
            strcboGadgetName = Request.Form("cboGadgetName")
        Else
            strcboGadgetName = ""
        End If

        'If Request.QueryString("Action") = "comboChanged" Then
        If Not Request.Form("cboModuleName") Is Nothing Then
            ModuleID_ForSP = Request.Form("cboModuleName")
            ModuleID = Request.Form("cboModuleName")
        Else
            ModuleID_ForSP = "NULL"
            ModuleID = ""
        End If

        If Not Request.Form("cboModuleName") Is Nothing Then
            ParentID_ForSP = Request.Form("cboParentName")
            strParentID = Request.Form("cboParentName")
        Else
            ParentID_ForSP = ""
            strParentID = ""
        End If

        'Added by SonalD on 25th june 2008
        m_IsSelected = CommonFunction.General.CheckIsNothing(Request.QueryString("IsSelected"), "")
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "")
        Else
            m_strMode = Request.Form("hidMode")
        End If

        'End of Addition by SonalD on 25th june 2008
        m_Access = CommonFunction.General.CheckIsNothing(Request.QueryString("Access"), "")
        'If m_strMode <> "ADD_NEW" Then
        '    m_isreadonly = True
        'End If
    End Sub

    Private Sub SaveData()
        Dim selectedCheckBoxes As String
        Dim arrselectedCheckBoxes() As String
        Dim selectedOrderNo As String
        Dim strTagID As String
        Dim i As Integer
        Dim strQuery As String
        Dim GadgetName As String
        Dim ModuleID As String
        Dim ParentNode As String
        Dim GadgetOrderNo As String
        Dim StrNewNodeName As String
        'Added by SonalD on 4rth Nov 2008
        Dim intGadgetCount As Integer
        Dim intTotalGadgetCount As Integer
        'End of Addition by sonalD on 4rth Nov 2008

        selectedCheckBoxes = Request.Form("chkSelect")
        GadgetName = Request.Form("txtGadgetNode")
        ModuleID = Request.Form("cboModuleName")
        ParentNode = Request.Form("cboParentName")
        'GadgetOrderNo = Request.Form("txtOrderNo")
        StrNewNodeName = Request.Form("txtNewNodeName")
        If selectedCheckBoxes <> "" Then
            arrselectedCheckBoxes = selectedCheckBoxes.Split(","c)

            For i = 0 To arrselectedCheckBoxes.Length - 1
                strTagID = arrselectedCheckBoxes(i)
                'selectedOrderNo = selectedOrderNo + CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTagOrderNo_" + strTagID), "0"), String) + ","
            Next
        End If

        'Added by SonalD on 4rth Nov 2008
        'purpose:to check that max no of gadgets for a particular node does not exceed 10
        If selectedCheckBoxes <> "" Then
            strQuery = "SELECT COUNT(GadgetID) FROM tbl_CNF_Gadgets WHERE TAGID IN (" + selectedCheckBoxes + ")"
            intGadgetCount = arrselectedCheckBoxes.Length - CommonFunction.Data.GetDataScalar(strQuery, True)

            strQuery = "usp_sel_GetGadgetCount " + strGadgetNodeID
            intTotalGadgetCount = CommonFunction.Data.GetDataScalar(strQuery, True)
            If (intTotalGadgetCount + intGadgetCount) > 10 Then
                CommonFunction.General.WriteHTML("<Script language=javascript>" + vbCrLf)
                CommonFunction.General.WriteHTML("alert('Gadgets can not be more than 10');")
                CommonFunction.General.WriteHTML("</Script>" + vbCrLf)
                Return
            End If
        End If
        'End of Addition by sonalD on 4rth Nov 2008

        'strQuery = "usp_INS_GadgetNodes " + strGadgetNodeID + "," + strcboGadgetName + ",'" + selectedCheckBoxes + "','" + selectedOrderNo + "','" + selectedCheckBoxes_ForDelete + "'"
        strQuery = "usp_INS_GadgetNodes " + strGadgetNodeID + "," + strcboGadgetName + ",'" + selectedCheckBoxes + "','" + selectedCheckBoxes_ForDelete + "'" + ",'" + StrNewNodeName + "'"
        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        strGadgetNodeID = strcboGadgetName
        'CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E','" + ModuleID.Trim + "',NULL," + CType(HttpContext.Current.Session("intUserID"), String) + ",NULL,NULL")

        Dim strFiles() As String = System.IO.Directory.GetFiles(Server.MapPath("../../Reports"), ModuleID + "*.html")
        Dim strFile As String
        For Each strFile In strFiles
            System.IO.File.Delete(strFile)
        Next
        'CType(HttpContext.Current.Session("intPostID"), Long)
        'CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E','" + ModuleID.Trim + "'," + CType(HttpContext.Current.Session("intPostID"), String) + "," + CType(HttpContext.Current.Session("intUserID"), String) + ",'NULL','NULL','NULL'")
    End Sub
    Private Sub UploadFile()
        Dim TagID As String
        Dim oldFile As String
        Dim arrSelectValue() As String
        Dim i As Integer
        Dim IsChkSelected As String = "0"
        Dim strSelectValue As String
        Dim FileExtension As String

        oldFile = Request.Form("frmFile_hidOldFileQues")
        'arrSelectValue = Request.Form("chkSelect").Split(","c)

        If Request.QueryString("Fromwhere") = "Detail" Then
            strSelectValue = HttpContext.Current.Request.Form("chkSelect")
            If strSelectValue <> "" Then
                arrSelectValue = strSelectValue.Split(","c)
            End If
        End If

        Dim strAttachPath As String = Server.MapPath("../../Images\tabimages\IconImages") + "/"

        TagID = CType(Request.QueryString("TagID"), Integer)

        'If Not CommonFunction.FileDirectory.IsDirectoryExists(strAttachPath + QID.ToString()) Then
        '    CommonFunction.FileDirectory.CreateDirectory(strAttachPath, QID.ToString())
        'End If

        ''If oldFile <> "" Then
        ''    DeleteFile(Server.MapPath("../../Attachments/QuestionBank") + "/", oldFile, TagID.ToString)
        ''End If

        Dim oUpload As FileUpload.cUpload = New FileUpload.cUpload("PictFile", strAttachPath, TagID.ToString)
        oUpload.OverwriteIfExists = True
        oUpload.UploadFile()
        If Request.QueryString("Fromwhere") = "Detail" And strSelectValue <> "" Then
            For i = 0 To arrSelectValue.Length - 1
                If TagID = arrSelectValue(i) Then
                    IsChkSelected = "1"
                    Exit For
                End If
            Next
        End If

        FileExtension = oUpload.OriginalFileName
        FileExtension = FileExtension.Substring(FileExtension.IndexOf("."))

        If Request.QueryString("Fromwhere") = "Detail" Then
            'CommonFunction.Data.InsertOrUpdateData("usp_INS_IMG_tbl_CNF_Gadgets " + strGadgetNodeID + "," + TagID.ToString + ",'" + oUpload.OriginalFileName + "'," + IsChkSelected, MyBase.UseSQL)
            CommonFunction.Data.InsertOrUpdateData("usp_INS_IMG_tbl_CNF_Gadgets " + strGadgetNodeID + "," + TagID.ToString + ",'" + TagID.ToString + FileExtension + "','" + oUpload.OriginalFileName + "'," + IsChkSelected, MyBase.UseSQL)
        End If
        If Request.QueryString("Fromwhere") = "Header" Then
            'CommonFunction.Data.InsertOrUpdateData("usp_UPD_tbl_CNF_GadgetNodes " + strGadgetNodeID + ",'" + oUpload.OriginalFileName + "'", MyBase.UseSQL)
            CommonFunction.Data.InsertOrUpdateData("usp_UPD_tbl_CNF_GadgetNodes " + strGadgetNodeID + ",'" + TagID.ToString + FileExtension + "','" + oUpload.OriginalFileName + "'", MyBase.UseSQL)
        End If


    End Sub
End Class