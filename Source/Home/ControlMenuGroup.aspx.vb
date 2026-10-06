Option Strict Off
Imports System.Text
Public Class ControlMenuGroup
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents objMenu As WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    Protected m_strMenuGroupID As String = ""
    Protected m_strAction As String = ""
    Public m_strControlItemIDs As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub
    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : Call All methods for a Page from this method
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 12,2008
        ' Revisions             : 
        '                         
        '=====================================================================
       
        Initialize()
        DrawHiddenFields()
        writeMenu()
        Response.Write("<br>")
        CreateCaption()
        If m_strAction = "SAVE" Then
            Call SaveData()
        End If
        Response.Write("<br>")
        DrawPage()
        Response.Write("<br>")
        PlotControlMenuItems()
        writeMenu()
    End Sub
    Protected Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : Initialize all variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 12,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        m_strMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MenuGroupID"), "")
        If m_strMenuGroupID = "" Then
            m_strMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtMenuGroupID"), "")
        End If
        m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "")
        If m_strAction = "" Then
            m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtAction"), "")
        End If
    End Sub

    Protected Sub DrawHiddenFields()
        '=====================================================================
        ' Procedure Name        : DrawHiddenFields()	
        ' Purpose               : Plot hidden fields on page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 12,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMenuGroupID", "txtMenuGroupID", , , , m_strMenuGroupID, , , True, , , True, , True))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtAction", "txtAction", , , , m_strAction, , , True, , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMenuGroupID", "txtMenuGroupID", , , , m_strMenuGroupID, , , True, , , True, , True, EnableHTMLEncode:=True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtAction", "txtAction", , , , m_strAction, , , True, , , True, , True, EnableHTMLEncode:=True))

    End Sub
    Private Sub writeMenu()
        '=====================================================================
        ' Procedure Name        : writeMenu()	
        ' Purpose               : Write Menu on page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 12,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        objMenu = New WebPage.Templates.StaticMenu
        Dim arrMenu() As String = {"<img id='imgSave' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Save.gif'> Save", "<img id='imgSaveClose' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\saveclose.gif'> Save and Close", "<img id='imgClose' style='text-decoration:none;'  border='0' src='..\..\Images\cssImages\Link Images\Close.gif' title='Close'> Close", "<img id='imgHelp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Help.gif'>"}
        Dim arrMenuToolTip() As String = {"Save", "Save and Close", "Close", "Help"}
        Dim arrCSFunction() As String = {"Save_onClick()", "SaveAndClose_onClick()", "Close_OnClick()", "Help_OnClick('CMG')"}
        objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)
    End Sub
    Protected Sub CreateCaption()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : Create Caption for a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 12,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim sbHTML As New StringBuilder
        sbHTML.Append("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>")
        sbHTML.Append("<TR width=99.9% colspan=1 class=clsTRPageCaption align='left'>")
        sbHTML.Append("<td style='width:99.99%;text-align:left'><B>&nbsp;Control Menu Group</B>")
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</TABLE>")
        CommonFunction.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
    End Sub
    Protected Sub SaveData()
        '=====================================================================
        ' Procedure Name        : SaveData()	
        ' Purpose               : Save Data on Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 13,2008
        ' Revisions             : 
        ' =====================================================================   
        Dim sControlItem As New StringBuilder
        Dim sImageName As New StringBuilder
        Dim strPriorityNumber As String = ""
        Dim strOrderNumber As String = ""
        Dim strRowNumber As String = ""
        Dim strTagID As String = ""
        Dim strControlItemID As String = ""
        Dim strControlItem As String = ""
        Dim strImageName As String = ""
        Dim strPriorityNumbers As String()
        Dim strOrderNumbers As String()
        Dim strRowNumbers As String()
        Dim strTagIDs As String()
        Dim strControlItemIDs As String()
        Dim strImageNames As String()
        Dim strControlItems As String()
        Dim strSQL As String = ""
        Dim loopCount As Integer = 0
        strControlItemID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ControlItemIDs"), "")
        strPriorityNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PriorityNumbers"), "")
        strOrderNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OrderNumbers"), "")
        strRowNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RowNumbers"), "")
        strTagID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagIDs"), "")
        strControlItemIDs = strControlItemID.Split(",")
        strPriorityNumbers = strPriorityNumber.Split(",")
        strOrderNumbers = strOrderNumber.Split(",")
        strRowNumbers = strRowNumber.Split(",")
        strTagIDs = strTagID.Split(",")
        For loopCount = 0 To strControlItemIDs.Length - 2
            sControlItem = sControlItem.Append(CommonFunction.General.CheckIsNothing(CommonFunction.General.BuildQueryString(HttpContext.Current.Request.Form("txtControlItem_" + strControlItemIDs(loopCount))), "") + ",")
            sImageName = sImageName.Append(CommonFunction.General.CheckIsNothing(CommonFunction.General.BuildQueryString(HttpContext.Current.Request.Form("txtImageName_" + strControlItemIDs(loopCount))), "") + ",")
            'strControlItem = strControlItem + CommonFunction.General.CheckIsNothing(CommonFunction.General.BuildQueryString(HttpContext.Current.Request.Form("txtControlItem_" + strControlItemIDs(loopCount))), "") + ","
            'strImageName = strImageName + CommonFunction.General.CheckIsNothing(CommonFunction.General.BuildQueryString(HttpContext.Current.Request.Form("txtImageName_" + strControlItemIDs(loopCount))), "") + ","
        Next

        strControlItem = sControlItem.ToString()
        strImageName = sImageName.ToString()
        strControlItems = strControlItem.Split(",")
        strImageNames = strImageName.Split(",")

        For loopCount = 0 To strControlItemIDs.Length - 2
            strSQL = "usp_INS_tbl_UI_ControlMenuItem "
            strSQL = strSQL + strControlItemIDs(loopCount) + "," + strPriorityNumbers(loopCount) + "," + strOrderNumbers(loopCount) + "," + strRowNumbers(loopCount) + "," + strTagIDs(loopCount) + ",'" + strControlItems(loopCount) + "','" + strImageNames(loopCount) + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strSQL = ""
        Next
        'CommonFunction.General.WriteHTML("<script  language=""javascript"">")
        'CommonFunction.General.WriteHTML(" function refreshParent(){")
        'CommonFunction.General.WriteHTML("var strParentPage= '../General/CommonPage.aspx?MasterTagID=2729';")
        'CommonFunction.General.WriteHTML("refreshParent('frmCommonPage', 'CommonPage.aspx', strParentPage);}")
        'CommonFunction.General.WriteHTML("</script>")
        CommonFunction.General.WriteHTML("<Script Language=javascript>")
        CommonFunction.General.WriteHTML("RefreshWebFormDesigner()")
        'CommonFunction.General.WriteHTML("refreshParent(""frmCommonPage"",""CommonPage.aspx"",""../General/CommonPage.aspx?MasterTagID=2729 &FromCL=1&ParentTagID=0"",true)")
        CommonFunction.General.WriteHTML("</Script>")
        'CommonFunction.General.WriteHTML("<script  language=""javascript"">")
        'CommonFunction.General.WriteHTML(" refreshParent()")
        'CommonFunction.General.WriteHTML("</script>")


    End Sub
    Protected Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : Plot a Page with allcontrols and details
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 12,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim sbHTML As New StringBuilder
        Dim objDR As IDataReader
        Dim strSQL As String = ""
        Dim arrUserFriendlyCols() As String = {"Parent Item", "ControlItemID", "Control Item", "Image Name", "Priority Number", "Order Number", "Row Number", "Tag ID"}
        Dim arrActualCols() As String = {"GroupingOn", "ControlItemID", "ControlItem", "ImageName", "PriorityNumber", "OrderNumber", "RowNumber", "TagID"}
        Dim strGroupByCols() As String = {"GroupingOn"}
        strSQL = "usp_SEL_tbl_UI_ControlMenuItem_Edit  " + m_strMenuGroupID

        m_objGrid = New WebPages.Template.AdvancedGrid
        With m_objGrid

            .NoOfDataColumns = arrUserFriendlyCols.Length
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = True
            .DIVID = "divGrid"
            .DIVStyle = "overflow:auto;width:99.99%;"
            '.DIVHeight = 450
            '.DIVHeight = "99.99%"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            .SortBy = "PriorityNumber"
            '.PageSize = 20
            '.CurrentPage = m_intPageNumber
            '.CheckboxCheckOnColumnArray = arrCheckboxArray

            .SortOrder = "Asc"
            .GroupOnColumn = strGroupByCols
            .DrawGrid()
        End With
        m_objGrid = Nothing
    End Sub
    Protected Sub PlotControlMenuItems()
        '=====================================================================
        ' Procedure Name        : PlotControlMenuItems()	
        ' Purpose               : Plot a hidden field to save all Control Item IDs
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 12,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtControlItemIDs", "txtControlItemIDs", , , , m_strControlItemIDs, , , , , , True, , True))
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToUpper() = "CONTROLITEMID" Then
            Cancel = True
        End If
    End Sub


    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strControlItemID As String = ""
        strControlItemID = Args.DataReader("ControlItemID")

        If Args.ColumnName.ToUpper() = "CONTROLITEMID" Then
            m_strControlItemIDs = m_strControlItemIDs + Args.DataReader("ControlItemID").ToString() + ","
            Cancel = True
        End If
        If Args.DataField.ToUpper = "CONTROLITEM" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtControlItem_" + strControlItemID.ToString, "txtControlItem_" + strControlItemID.ToString, , 200, 200, Args.DataReader("ControlItem").ToString, "left", , False, , , , , True, True, "../../Images/Star.gif") + "</TD>"
        End If
        If Args.DataField.ToUpper = "IMAGENAME" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtImageName_" + strControlItemID.ToString, "txtImageName_" + strControlItemID.ToString, , 200, 400, Args.DataReader("ImageName").ToString, "left", , False, , , , , True, True, "../../Images/Star.gif") + "</TD>"
        End If
        If Args.DataField.ToUpper = "PRIORITYNUMBER" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtPriorityNumber_" + strControlItemID.ToString, "txtPriorityNumber_" + strControlItemID.ToString, , 50, , Args.DataReader("PriorityNumber").ToString, "right", , False, , , , , True, True, "../../Images/Star.gif") + "</TD>"
        End If
        If Args.DataField.ToUpper = "ORDERNUMBER" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber_" + strControlItemID.ToString, "txtOrderNumber_" + strControlItemID.ToString, , 50, , Args.DataReader("OrderNumber").ToString, "right", , False, , , , , True, True, "../../Images/Star.gif") + "</TD>"
        End If
        If Args.DataField.ToUpper = "TAGID" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtTagID_" + strControlItemID.ToString, "txtTagID_" + strControlItemID.ToString, , 50, , Args.DataReader("TagID").ToString, "right", , False, , , , , True, True, "../../Images/Star.gif") + "</TD>"
        End If
        If Args.DataField.ToUpper = "ROWNUMBER" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=Center> " + CommonFunctions.HTMLControls.DrawTextBox("txtRowNumber_" + strControlItemID.ToString, "txtRowNumber_" + strControlItemID.ToString, , 50, , Args.DataReader("RowNumber").ToString, "right", , False, , , , , True, True, "../../Images/Star.gif") + "</TD>"
        End If
    End Sub


    'Private Sub m_objGrid_Footer_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_Footer) Handles m_objGrid.Footer_BeforePrint
    '    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtControlItemIDs", "txtControlItemIDs", , , , m_strControlItemIDs, , , , , , True, , True))
    'End Sub
End Class