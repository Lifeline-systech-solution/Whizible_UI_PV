Public Partial Class SnapshotGeneration
    Inherits WebPage.Templates.WhizTemplate

#Region "Local Variables"
    Protected m_tagID As Long = 3950
    Protected m_ProjectID As String = "0"
    Private WithEvents objGrid As WebPage.Templates.GenericGrid
    Protected M_strAction As String = ""
    Protected m_FromDate As String = ""
    Protected m_ToDate As String = ""
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub InitVariables()
        m_ProjectID = HttpContext.Current.Session("intProjectId").ToString()
        If Not HttpContext.Current.Request.QueryString("Action") Is Nothing Then
            M_strAction = HttpContext.Current.Request.QueryString("Action").ToString()
        End If
        If Not HttpContext.Current.Request.QueryString("FromDate") Is Nothing Then
            m_FromDate = HttpContext.Current.Request.QueryString("FromDate").ToString()
        End If

        If Not HttpContext.Current.Request.QueryString("ToDate") Is Nothing Then
            m_ToDate = HttpContext.Current.Request.QueryString("ToDate").ToString()
        End If

    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : This function is get called after form load.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : SEP 15 2008
        ' Revisions             :
        '=====================================================================

        If M_strAction <> "" Then
            Call PerformAction()
        End If
        Call DrawMenu()
        ' Page header
        CommonFunction.General.WriteHTML("<br>")
        CommonFunction.General.WriteHTML("<table id='tblCap'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>Project Profitability Snapshot</TD><TD align=right><a id='aShowNote' href='javascript:ShowInfoNote()' title='Note' style='display:none;'><img src='../../Images/KM.jpg' border='0' valign='top' /></a></TD></TR></TABLE>")
        CommonFunction.General.WriteHTML("<br>")
        Call DrawInfoNote()

        Call DrawSnpashotGrid()
        CommonFunction.General.WriteHTML("<br>")
        Call DrawMenu()
    End Sub

    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : This function is to plot menu.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : SEP 15 2008
        ' Revisions             :
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        ' arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('3950')")

        'copy all the element to string array
        Dim arrstrMenu(arrMenu.Count - 1) As String
        Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
        Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
        arrMenu.CopyTo(arrstrMenu)
        arrMenuToolTip.CopyTo(arrstrMenuToolTip)
        arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        'draw upper menu
        CommonFunction.General.WriteHTML(strMenu)

    End Sub

    Private Sub DrawSnpashotGrid()
        '=====================================================================
        ' Procedure Name        : DrawSnpashotGrid()	
        ' Purpose               : This function is plots the grid for generation of project profitability snapshot 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : SEP 15 2008
        ' Revisions             :
        '=====================================================================
        Dim arrlstColHeader As Collections.ArrayList
        Dim arrlstAN As Collections.ArrayList
        Dim arrlstRowLink As Collections.ArrayList
        Dim arrlstTDStyle As Collections.ArrayList
        Dim arrlstCheckBox As Collections.ArrayList
        Dim intNoOfCol As Integer = 0
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        arrlstColHeader = New Collections.ArrayList
        arrlstAN = New Collections.ArrayList
        arrlstRowLink = New Collections.ArrayList
        arrlstTDStyle = New Collections.ArrayList
        arrlstCheckBox = New Collections.ArrayList

        arrlstColHeader.Add(CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("COL_FROM_DATE"), "From Date")) : arrlstColHeader.Add(CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("COL_TO_DATE"), "To Date")) : arrlstColHeader.Add(CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("COL_STATUS"), "Status"))
        arrlstAN.Add("FromDate") : arrlstAN.Add("toDate") : arrlstAN.Add("status")
        arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("Generate(FromDate,ToDate)")
        arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("")
        arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'")
        intNoOfCol = 2

        Dim arrColHeader(arrlstColHeader.Count) As String
        Dim arrAN(arrlstAN.Count) As String
        Dim arrRowLink(arrlstRowLink.Count) As String
        Dim arrCheckBox(arrlstCheckBox.Count) As String
        Dim arrTDStyle(arrlstTDStyle.Count) As String

        arrlstColHeader.CopyTo(arrColHeader)
        arrlstAN.CopyTo(arrAN)
        arrlstRowLink.CopyTo(arrRowLink)
        arrlstCheckBox.CopyTo(arrCheckBox)
        arrlstTDStyle.CopyTo(arrTDStyle)

        arrlstColHeader = Nothing
        arrlstAN = Nothing
        arrlstRowLink = Nothing
        arrlstTDStyle = Nothing
        arrlstCheckBox = Nothing

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.RowLinkArray = arrRowLink
        'objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.TDStyleArray = arrTDStyle
        'objGrid.PrimaryKey = "ProjectProfitabilityID"
        ''Commented by PrashantSJ on 29th Jan 2009 : Profitability
        '  objGrid.ClientSideSortFunctionName = "Sort_OnClick"
        ''End of addition by PrashantSJ on 29th Jan 2009: Profitabiltiy
        objGrid.DIVID = "DivMain"
        objGrid.DIVHeight = 450
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = intNoOfCol
        ''Commented by PrashantSJ on 29th Jan 2009 : Profitability
        ' objGrid.SortOrder = "DESC"
        '  objGrid.SortBy = "FromDate"
        ''End of addition by PrashantSJ on 29th Jan 2009: Profitabiltiy
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = "usp_SEL_Tbl_PM_ProjectProfitability_forSnapshot " + m_ProjectID
        objGrid.UseSQL = MyBase.UseSQL
        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        'intRowCount = objGrid.NoOfRows
        objGrid = Nothing

    End Sub

    Private Sub PerformAction()
        '=====================================================================
        ' Procedure Name        : PerformAction()	
        ' Purpose               : This function is to generate the Project profitability snapshot
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : SEP 15 2008
        ' Revisions             :
        '=====================================================================
        Dim sbSQL As New StringBuilder

        If M_strAction = "G" Then
            sbSQL.Append("usp_CDE_ProjectProfitability ")
            sbSQL.Append(m_ProjectID)
            sbSQL.Append(" , '")
            sbSQL.Append(m_FromDate)
            sbSQL.Append("', '")
            sbSQL.Append(m_ToDate)
            sbSQL.Append("'")
            CommonFunction.Data.InsertOrUpdateData(sbSQL.ToString(), MyBase.UseSQL)
        End If

    End Sub
    Protected Sub DrawInfoNote()
        '=====================================================================
        ' Procedure Name        : DrawInfoNote()	
        ' Purpose               : This function is to draw the Project profitability checklist note.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : Aug 4,2009
        ' Revisions             :
        '=====================================================================
        Dim sbHTML As New StringBuilder("")

        Dim strNote As String = ""

        strNote = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_InformativieNote " + m_ProjectID, MyBase.UseSQL)))

        sbHTML.Append("<div Id=divCQ class='clsInfoNote' Style='OVERFLOW:auto;width:100%;height:150px;'>")
        sbHTML.Append("<table id=tblCQ cellpadding=0 cellspacing=0 class='clsTable' >")
        

        sbHTML.Append("<tr class='clsTRNote'  >")
        sbHTML.Append("<td  align='left' width='20%' colspan='2'>")
        sbHTML.Append("&nbsp;<i>Note : </i></td>")
        sbHTML.Append("<td  width='80%'  style='align:right;text-align:right;' >")
        sbHTML.Append("<a href='javascript:CloseNote_OnClick()' title='Close Note' ><img src='../../Images/Home/Close.gif' border='0' /></a>")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")

        sbHTML.Append("<tr  class='clsTRNote' >")
        sbHTML.Append("<td  align='left' width='5%' align='left' valign='top' >")
        sbHTML.Append("<img src='../../Images/KM.jpg' border='0' valign='top' /></td>")
        sbHTML.Append("<td  width='95%' align='left' >")
        'sbHTML.Append("While generation of project profitability snapshots you have to verify few corporate and project setup for calculation of <i>cost</i> and <i>revenue</i>")
        sbHTML.Append(strNote)
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")

        'sbHTML.Append("<tr  class='clsTRNote' >")
        'sbHTML.Append("<td  align='left' >")
        'sbHTML.Append("&nbsp;&nbsp;</td>")
        'sbHTML.Append("<td  align='left' >")
        'sbHTML.Append("1. Cost")
        'sbHTML.Append("</td>")
        'sbHTML.Append("</tr>")


        sbHTML.Append("</table>")
        sbHTML.Append("</div>")

        sbHTML.Append("</br>")


        Response.Write(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Public Sub New()
        MyBase.InitializeResources("AppResources.standardMenu", "AppResources")
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity(False, 2)
        MyBase.ApplySecurity(True, 2)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
    End Sub

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint

        If Args.ColumnName.ToLower = "status" Then
            Cancel = True
            If CommonFunction.Data.CheckIsDBNull(Args.DataReader("LastGeneratedOn"), "").ToString() <> "" Then

                If DateDiff(DateInterval.Day, CType(Args.DataReader("ToDate"), Date), CType(Args.DataReader("LastGeneratedOn"), Date)) >= 0 Then
                    Args.StringToBeInserted = "<td><a href=""javascript:Generate('" + CType(Args.DataReader("FromDate"), Date).ToString("dd-MMM-yyyy") + "','" + CType(Args.DataReader("ToDate"), Date).ToString("dd-MMM-yyyy") + "')"")>" + IIf(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), "0"), Boolean), "Re-Generate", "Generate") + "</a></td>"
                ElseIf DateDiff(DateInterval.Day, CType(Args.DataReader("ToDate"), Date), CType(Args.DataReader("LastGeneratedOn"), Date)) < 0 Then
                    Args.StringToBeInserted = "<td>Pending</td>"
                End If
            Else
                Args.StringToBeInserted = "<td><a href=""javascript:Generate('" + CType(Args.DataReader("FromDate"), Date).ToString("dd-MMM-yyyy") + "','" + CType(Args.DataReader("ToDate"), Date).ToString("dd-MMM-yyyy") + "')"")>Generate</a></td>"
            End If
        End If
    End Sub
End Class