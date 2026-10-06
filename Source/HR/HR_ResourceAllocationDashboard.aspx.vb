Public Partial Class HR_ResourceAllocationDashboard
    Inherits WebPages.Template.WhizTemplate

    Private m_sbHTML As System.Text.StringBuilder
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private m_sbHTMLDraw As System.Text.StringBuilder

    Private m_LocationID As String = ""
    Private dtFromDate As String = ""
    Private m_LocationID_SP As String = ""
    Private dtFromDate_SP As String = ""
    Private m_FinancialPeriodCount As String

    Private DateForPeriod As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
    End Sub
    Protected Sub PageInit()

        If Not Request.QueryString("FromXML") Is Nothing Then
            If Request.QueryString("FromXML") = "1" Then
                If Request.QueryString("For").ToUpper = "EMPDTLS" Then
                    Select Case Request.QueryString("FromWhere").ToUpper
                        Case "TOTALRES"
                            Call DrawDtlEmpDiv(Request.QueryString("FromWhere").ToUpper)
                        Case "BENCH"
                            Call DrawDtlEmpDiv(Request.QueryString("FromWhere").ToUpper)
                        Case "NONBILLABLE"
                            Call DrawDtlEmpPRJDiv(Request.QueryString("FromWhere").ToUpper)
                        Case Else '"1", "2", "3", "4", "5", "TOTALALLOCATION"
                            Call DrawDtlEmpPRJDiv(Request.QueryString("FromWhere").ToUpper)
                    End Select
                End If
              
            End If
        End If

        Call InitializeVariables()
        Call GenerateMenu()
        Call DrawFilter()
        'Call DrawPage()
        m_sbHTMLDraw = DrawPage()
        m_sbHTML.Append(m_sbHTMLDraw)
        Call DrawTotalRec()


        If Request.QueryString("Mode") = "PRINT" Then
            Dim sbHTMLExcel As New StringBuilder

            sbHTMLExcel.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")

            sbHTMLExcel.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            
            sbHTMLExcel.Append("<BR>")

            sbHTMLExcel.Append("</div>")

            sbHTMLExcel.Append(m_sbHTMLDraw)

            ExporttoExcel(sbHTMLExcel)
            Response.End()
            sbHTMLExcel = Nothing
        End If
       
        Response.Write(m_sbHTML.ToString())

    End Sub

    Protected Sub ExporttoExcel(ByVal sbHTML As StringBuilder)
        '====================================================================
        ' Procedure Name        : ExporttoExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export the report in Excel Format
        ' Description           : To export the report in Excel Format
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RohiniK
        ' Created               : 1 Sep 2009
        ' Revisions             :
        '=====================================================================
        Dim strCode, strCode1 As String
        Dim intSearchCount As Integer
        Dim strcodeBuilder As New StringBuilder

        strCode = sbHTML.ToString
        Dim strsearch As String = "<td class=clsTDColumnSeparator width=1pt></td>"
        strcodeBuilder.Append(strCode)
        strcodeBuilder = strcodeBuilder.Replace("<TABLE", "<TABLE style=""FONT-SIZE: 8pt"" border=1 ")
        'strcodeBuilder = strcodeBuilder.Replace("<img src='../../Images/minus.gif' border=0>", "")
        'strcodeBuilder = strcodeBuilder.Replace(strsearch, "")
        'strcodeBuilder = strcodeBuilder.Replace("<TD  align=left ", "<TD  align=left ><B")
        'strcodeBuilder = strcodeBuilder.Replace("<TD  align=right ", "<TD  align=right ><B")
        'strcodeBuilder = strcodeBuilder.Replace("<TD colspan=7 align=center>", "<TD colspan=7 align=center><B>")
        'strcodeBuilder = strcodeBuilder.Replace("<TD colspan=3 align=center>", "<TD colspan=3 align=center><B>")
        'strcodeBuilder = strcodeBuilder.Replace("<TD colspan=8 align=center>", "<TD colspan=8 align=center><B>")
        'strcodeBuilder = strcodeBuilder.Replace("<TD colspan=2 align=center>", "<TD colspan=2 align=center><B>")
        'strcodeBuilder = strcodeBuilder.Replace("<TD colspan=6 align=center>", "<TD colspan=6 align=center><B>")
        'strcodeBuilder = strcodeBuilder.Replace("<TD colspan=1 align=center>", "<TD colspan=1 align=center><B>")
        'strcodeBuilder = strcodeBuilder.Replace("<TD colspan=1 align=left>", "<TD colspan=29 align=left><B>")
        Dim intStart, intEnd, intLength As Integer
        strCode = strcodeBuilder.ToString
        strcodeBuilder.Remove(0, strcodeBuilder.Length)
        PrintExcelDoc(strCode)
    End Sub
    Protected Sub PrintExcelDoc(ByVal query As String)
        '====================================================================
        ' Procedure Name        : PrintExcelDoc
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export the report in Excel Format
        ' Description           : To export the report in Excel Format
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RohiniK
        ' Created               : 1 Sep 2009
        ' Revisions             :
        '=====================================================================
        Dim strBody As New System.Text.StringBuilder("")


        strBody.Append("<html " & _
          "xmlns:o='urn:schemas-microsoft-com:office:office' " & _
          "xmlns:w='urn:schemas-microsoft-com:office:Excel'" & _
          "xmlns='http://www.w3.org/TR/REC-html40'>" & _
          "<head><title>Time</title>")

        'The setting specifies document's view after it is downloaded as Print instead of the default Web Layout
        strBody.Append("<!--[if gte mso 9]>" & _
         "<xml>" & _
         "<w:ExcelDocument>" & _
         "<w:View>Print</w:View>" & _
         "<w:Zoom>90</w:Zoom>" & _
         "<w:DoNotOptimizeForBrowser/>" & _
         "</w:ExcelDocument>" & _
         "</xml>" & _
         "<![endif]-->")

        strBody.Append("<style>" & _
           "<!-- /* Style Definitions */" & _
           "@page Section1" & _
           "   {size:8.5in 12in; " & _
           "   margin:0.5in 0.5in 0.5in 0.5in ; " & _
           "   mso-header-margin:.5in; " & _
           "   mso-footer-margin:.5in; mso-paper-source:0;size:landscape;}" & _
           " div.Section1" & _
           "   {page:Section1;}" & _
           "-->" & _
          "</style></head>")

        strBody.Append("<body lang=EN-US style='tab-interval:.5in'>" & _
          "<div class=Section1><font face='Verdana' size=10><pre>" & query.ToString & "</pre></font></div></body></html>")
        strBody = strBody.Replace("–", "-")
        strBody = strBody.Replace("‘", "'")
        strBody = strBody.Replace("’", "'")
        Dim m_filepath As String
        Dim Logfile As String
        m_filepath = Server.MapPath("../../Reports/")
        Logfile = CommonFunctions.FileDirectory.GetUniqueFileName("XLS")
        CommonFunctions.FileDirectory.WriteFileStream(m_filepath, Logfile, strBody.ToString)

        CommonFunctions.General.WriteHTML("<Script language=javascript>")
        CommonFunctions.General.WriteHTML("window.open(""../CRW/CRW_ReportOutput.aspx?filename=" + Logfile + ""","""",""menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500"");")
        CommonFunctions.General.WriteHTML("window.close();")
        CommonFunctions.General.WriteHTML("</Script>")
    End Sub

    Private Sub InitializeVariables()

        m_sbHTML = New System.Text.StringBuilder
        m_sbHTMLDraw = New System.Text.StringBuilder
        If Not Request.Form("cboLocation") Is Nothing Then
            m_LocationID = Request.Form("cboLocation").ToString()

        End If

        If dtFromDate Is Nothing OrElse dtFromDate = "" Then
            dtFromDate = Now.Date
            DateForPeriod = dtFromDate
        End If

        If Not Request.Form("dtFromDate") Is Nothing Then
            dtFromDate = Request.Form("dtFromDate").ToString()
            DateForPeriod = dtFromDate
        End If

       

    End Sub
    Private Sub GenerateMenu()
        '====================================================================
        ' Procedure Name        :  GenerateMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To getnerate Menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  27,Oct 2009
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList = New System.Collections.ArrayList

        arrMenu.Add("&nbsp;Export To Excel")
        arrMenuToolTip.Add("Export To Excel")
        arrClientSideFunctions.Add("ExportToExcel()")


        m_objMenu = New WebPages.Template.StaticMenu
        Dim strmenu As String = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True)
        m_sbHTML.Append(strmenu)

        m_objMenu = Nothing
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()

        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub DrawFilter()

        m_sbHTML.Append("<TABLE id='tblHeader' cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable  >" + vbCrLf)
        m_sbHTML.Append("<TR class=clsTRPageCaption>")
        m_sbHTML.Append("<TD>Resource Allocation Dashboard")
        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("</TR>")
        m_sbHTML.Append("</TABLE>")

        m_sbHTML.Append("</BR>")

        m_sbHTML.Append("<TABLE id='tblHeader' cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable  >" + vbCrLf)
        m_sbHTML.Append("<TR class=clsTRPageFilters>")
        m_sbHTML.Append("<TD>Location&nbsp;")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' m_sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboLocation", "SELECT FacilityID , FacilityName FROM tbl_PM_Facility Order by FacilityName ", 200, m_LocationID, , True, True))
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboLocation", "usp_sel_tbl_PM_Facility", 200, m_LocationID, , True, True))
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        m_sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;As On Date&nbsp;")
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawDateControl("dtFromDate", "dtFromDate", , , dtFromDate, , "frmResAllocationDashboard", , , , , , , True))

        m_sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
        m_sbHTML.Append("<Input type=button name=btnFilters onclick='ApplyFilters()' value='Show'>")
        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("</TR>")
        m_sbHTML.Append("</TABLE>")
    End Sub
    Private Function DrawPage()

        Dim strClass As String = "clsTREven"
        Dim strQuery As String
        Dim dr As IDataReader
        Dim Role As String
        Dim FixBid As String
        Dim TM As String
        Dim NonBillable As String
        Dim Bench As String
        Dim TotalResources As String
        Dim RoleId As String
        Dim dsRole As DataSet
        Dim strContractType As String
        Dim arrContractType() As String = {"Fixed Bid", "T&M by Resource", "T&M by Role"}
        Dim arrContractTypeTotals() As String = {"", "", ""}
        Dim arrContractTypeEMPTotals() As String = {"", "", ""}
       

        Dim CNT As Integer = 0

        Dim iterator As Integer = 0
        Dim ContractTypeCNT As Integer
        Dim flagDetail As Boolean = False
        Dim NonBillableCNT As String
        Dim BenchPercentage As String
        Dim TotalAllocation As String
        Dim AllResourceCNT As String
        Dim SUMtotalAllocation As Double
        Dim SUMNonBillable As Double
        Dim SUMOnBench As Double

        Dim TACNT As Integer
        Dim BenchCNT As Integer
        Dim NBCNT As Integer
        Dim TotalAllocationCNT As String


        If m_LocationID Is Nothing OrElse m_LocationID = "" Then
            m_LocationID_SP = "NULL"
        Else
            m_LocationID_SP = m_LocationID
        End If

        If dtFromDate Is Nothing OrElse dtFromDate = "" Then
            dtFromDate_SP = "NULL"
        Else
            dtFromDate_SP = "'" + dtFromDate + "'"
        End If

        strQuery = "usp_Sel_ResourceAllocationDashboard " + m_LocationID_SP + "," + dtFromDate_SP + "," + Session("intUserID").ToString()

        dsRole = CommonFunction.Data.GetDataSet(strQuery, "TEMP", , , MyBase.UseSQL)

        m_sbHTMLDraw.Append("<BR>")

        ContractTypeCNT = dsRole.Tables(0).Rows.Count



        m_sbHTMLDraw.Append("<DIV Id=DivMain Style='OVERFLOW:auto; WIDTH:100%'>" + vbCrLf)

        m_sbHTMLDraw.Append("<TABLE id='tblHeader' cellspacing=1 cellpadding=0 Width='99.9%' class=clsGridTable >" + vbCrLf)
        m_sbHTMLDraw.Append("<THead class='clsTRColumnHeader' >" + vbCrLf)
        m_sbHTMLDraw.Append("<TH align=left>Role</TH>" + vbCrLf)
        m_sbHTMLDraw.Append("<TH align=right>Total Resources</TH>" + vbCrLf)
        m_sbHTMLDraw.Append("<TH colspan=" + ContractTypeCNT.ToString() + " align=center>Billable Projects</TH>" + vbCrLf)
        m_sbHTMLDraw.Append("<TH align=right >Non-Billable Projects</TH>" + vbCrLf)
        m_sbHTMLDraw.Append("<TH align=right >Total Allocation</TH>" + vbCrLf)
        m_sbHTMLDraw.Append("<TH align=right >On Bench</TH>" + vbCrLf)
        m_sbHTMLDraw.Append("</THead>" + vbCrLf)

        m_sbHTMLDraw.Append("<TR class=clsTROdd>" + vbCrLf)
        m_sbHTMLDraw.Append("<TD>&nbsp;</TD>" + vbCrLf)
        m_sbHTMLDraw.Append("<TD align=right>&nbsp;</TD>" + vbCrLf)



        For Each drRowContractType As DataRow In dsRole.Tables(0).Rows
            m_sbHTMLDraw.Append("<TD align=right>" + drRowContractType("NodeLabel").ToString() + "</TD>" + vbCrLf)
            strContractType = strContractType + drRowContractType("NodeLabel").ToString() + ","
            arrContractTypeTotals.Resize(arrContractTypeTotals, ContractTypeCNT)
            arrContractTypeEMPTotals.Resize(arrContractTypeEMPTotals, ContractTypeCNT)
        Next

        arrContractType = strContractType.Split(","c)

        m_sbHTMLDraw.Append("<TD>&nbsp;</TD>" + vbCrLf)
        m_sbHTMLDraw.Append("<TD>&nbsp;</TD>" + vbCrLf)
        m_sbHTMLDraw.Append("<TD>&nbsp;</TD>" + vbCrLf)
        m_sbHTMLDraw.Append("</TR>" + vbCrLf)


        For Each drRowMain As DataRow In dsRole.Tables(1).Rows

            RoleId = drRowMain("RoleID").ToString()
            Role = drRowMain("Role").ToString()
            'FixBid = CommonFunction.Data.CheckIsDBNull(dr("Fixed Bid"), "-").ToString()
            'TM = CommonFunction.Data.CheckIsDBNull(dr("T&M"), "-").ToString()
            NonBillable = CommonFunction.Data.CheckIsDBNull(drRowMain("NonBillable"), "-").ToString()
            Bench = CommonFunction.Data.CheckIsDBNull(drRowMain("Bench"), "-").ToString()
            TotalResources = CommonFunction.Data.CheckIsDBNull(drRowMain("TotalCOUNT"), "-").ToString()
            NonBillableCNT = CommonFunction.Data.CheckIsDBNull(drRowMain("NonBillableCNT"), "-").ToString()
            BenchPercentage = CommonFunction.Data.CheckIsDBNull(drRowMain("BenchPercentage"), "-").ToString()
            TotalAllocation = CommonFunction.Data.CheckIsDBNull(drRowMain("TotalAllocation"), "-").ToString()
            TotalAllocationCNT = CommonFunction.Data.CheckIsDBNull(drRowMain("TotalAllocationCNT"), "-").ToString()
            AllResourceCNT = CommonFunction.Data.CheckIsDBNull(drRowMain("TotalResources"), "-").ToString()


            If TotalAllocation <> "-" Then
                SUMtotalAllocation = SUMtotalAllocation + CType(TotalAllocation, Double)
                If TotalAllocationCNT <> "-" Then
                    TACNT = TACNT + CType(TotalAllocationCNT, Double)
                End If
            End If

            If NonBillable <> "-" Then
                SUMNonBillable = SUMNonBillable + CType(NonBillable, Double)
                If NonBillableCNT <> "-" Then
                    NBCNT = NBCNT + CType(NonBillableCNT, Double)
                End If

            End If

            If BenchPercentage <> "-" Then
                SUMOnBench = SUMOnBench + CType(BenchPercentage, Double)
                If Bench <> "-" Then
                    BenchCNT = BenchCNT + CType(Bench, Double)
                End If

            End If


            m_sbHTMLDraw.Append("<TR class=" + strClass + ">" + vbCrLf)

            m_sbHTMLDraw.Append("<TD>" + Role + "</TD>" + vbCrLf)

            If TotalResources = "-" Then
                m_sbHTMLDraw.Append("<TD align=right>0</TD>" + vbCrLf)
            Else
                m_sbHTMLDraw.Append("<TD align=right><A onclick=ShowEmployees(" + RoleId + ",'" + m_LocationID_SP + "','" + dtFromDate + "'" + ",'TotalRES')><U>" + TotalResources + ".00 (" + TotalResources + ")</U></A></TD>" + vbCrLf)
            End If


            For Each drRowDtl As DataRow In dsRole.Tables(2).Rows

                If RoleId = drRowDtl("RoleID") Then
                    flagDetail = True

                    If drRowDtl("TypeWiseEMPCount") = 0 Then
                        m_sbHTMLDraw.Append("<TD align=right>-</TD>")
                    Else
                        arrContractTypeTotals(iterator) = drRowDtl("TypewiseTotal")
                        arrContractTypeEMPTotals(iterator) = drRowDtl("TypeWiseEMPCount")

                        If IsDBNull(drRowDtl("AllocationPercent")) Then
                            m_sbHTMLDraw.Append("<TD align=right>-</TD>")
                        Else
                            m_sbHTMLDraw.Append("<TD align=right> <A onclick=ShowEmployees(" + RoleId + ",'" + m_LocationID_SP + "','" + dtFromDate + "'" + ",'" + drRowDtl("ContractTypeID").ToString() + "')><U>" + drRowDtl("AllocationPercent").ToString() + " (" + drRowDtl("TypewiseCNT").ToString() + ")</U></A></TD>" + vbCrLf)
                        End If


                    End If
                   
                    iterator = iterator + 1


                End If

            Next

            iterator = 0
           

            If NonBillableCNT = "-" Then
                m_sbHTMLDraw.Append("<TD align=right>-</TD>" + vbCrLf)
            Else
                m_sbHTMLDraw.Append("<TD align=right> <A onclick=ShowEmployees(" + RoleId + ",'" + m_LocationID_SP + "','" + dtFromDate + "'" + ",'NonBillable')><U>" + NonBillable + " (" + NonBillableCNT + ")</U></A></TD>" + vbCrLf)
            End If

            If TotalAllocationCNT = "-" OrElse TotalAllocationCNT = "0" Then
                m_sbHTMLDraw.Append("<TD align=right>-</TD>" + vbCrLf)
            Else
                m_sbHTMLDraw.Append("<TD align=right> <A onclick=ShowEmployees(" + RoleId + ",'" + m_LocationID_SP + "','" + dtFromDate + "'" + ",'TotalAllocation')><U>" + TotalAllocation + " (" + TotalAllocationCNT.ToString() + ")</U></A></TD>" + vbCrLf)
            End If

            If BenchPercentage = "-" Then
                m_sbHTMLDraw.Append("<TD align=right>-</TD>" + vbCrLf)
            ElseIf BenchPercentage = "0.00" OrElse (Bench = "0" And CType(BenchPercentage, Double) >= 0) Then
                m_sbHTMLDraw.Append("<TD align=right>" + BenchPercentage + " (" + Bench + ")</TD>" + vbCrLf)
            ElseIf CType(BenchPercentage, Double) <= 0 Then
                m_sbHTMLDraw.Append("<TD align=right>[" + BenchPercentage + " (" + Bench + ")]</TD>" + vbCrLf)
            Else
                m_sbHTMLDraw.Append("<TD align=right> <A onclick=ShowEmployees(" + RoleId + ",'" + m_LocationID_SP + "','" + dtFromDate + "'" + ",'Bench')><U>" + BenchPercentage + " (" + Bench + ")</U></A></TD>" + vbCrLf)
            End If


            m_sbHTMLDraw.Append("</TR>" + vbCrLf)


        Next

        iterator = 0

        m_sbHTMLDraw.Append("<TR class=" + strClass + ">" + vbCrLf)

        m_sbHTMLDraw.Append("<TD><B>Total</B></TD>" + vbCrLf)

        If AllResourceCNT <> "-" Then
            m_sbHTMLDraw.Append("<TD align=right><B>" + AllResourceCNT + ".00 (" + AllResourceCNT + ")</B></TD>" + vbCrLf)
        Else
            m_sbHTMLDraw.Append("<TD align=right>0</TD>" + vbCrLf)
        End If


        While iterator < arrContractTypeTotals.Length
            If arrContractTypeTotals(iterator) = "" Then
                m_sbHTMLDraw.Append("<TD align=right><B>-</B></TD>" + vbCrLf)
            Else
                m_sbHTMLDraw.Append("<TD align=right><B>" + arrContractTypeTotals(iterator).ToString() + " (" + arrContractTypeEMPTotals(iterator).ToString() + ")</B></TD>" + vbCrLf)
            End If

            iterator = iterator + 1
        End While



        m_sbHTMLDraw.Append("<TD align=right><B>" + SUMNonBillable.ToString() + " (" + NBCNT.ToString() + ")</B></TD>" + vbCrLf)
        m_sbHTMLDraw.Append("<TD align=right><B>" + SUMtotalAllocation.ToString() + " (" + TACNT.ToString() + ")</B></TD>" + vbCrLf)
        m_sbHTMLDraw.Append("<TD align=right><B>" + SUMOnBench.ToString() + " (" + BenchCNT.ToString() + ")</B></TD>" + vbCrLf)

        m_sbHTMLDraw.Append("</TR>" + vbCrLf)


        m_sbHTMLDraw.Append("</Table>" + vbCrLf)
        m_sbHTMLDraw.Append("</DIV>" + vbCrLf)

        CommonFunction.Data.DisposeDataReader(dr)

        Return m_sbHTMLDraw

    End Function

    

    Private Sub DrawTotalRec()

        Dim strQuery As String
        Dim TotalRecords As String


        If m_LocationID Is Nothing OrElse m_LocationID = "" Then
            m_LocationID_SP = "NULL"
        Else
            m_LocationID_SP = m_LocationID
        End If

        If dtFromDate Is Nothing OrElse dtFromDate = "" Then
            dtFromDate_SP = "NULL"
        Else
            dtFromDate_SP = "'" + dtFromDate + "'"
        End If

        strQuery = "usp_Sel_ResourceAllocationDashboard_Count " + m_LocationID_SP + "," + dtFromDate_SP + "," + Session("intUserID").ToString()

        TotalRecords = CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL)

        m_sbHTML.Append("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'>")
        m_sbHTML.Append("<TR class=clsTREven>")
        m_sbHTML.Append("<TD  width='100%' align='right'>Total Records :" + TotalRecords)
        m_sbHTML.Append("</TD></TR></TABLE>")
        


    End Sub
    Private Sub DrawDtlEmpDiv(ByVal FromWhere As String)
        Dim strQuery As String
        Dim dr As IDataReader
        Dim RoleID As String
        Dim dtFromDate As String
        Dim EmployeeName As String
        Dim Role As String
        Dim Location As String
        Dim FormWhere As String
        Dim strClass As String = "clsTREven"
        Dim Cnt As Integer = 1
        Dim BG As String
        Dim EmailID As String

        'If FromWhere = "TOTALRES" Then
        '    FromWhere = "Total Resources"
        'ElseIf FromWhere = "BENCH" Then
        '    FromWhere = "Bench Resource"
        'ElseIf FromWhere = "NONBILLABLE" Then
        '    FromWhere = "Non Billable Resource"
        'End If

        Dim m_sbHTMLDIV As System.Text.StringBuilder
        m_sbHTMLDIV = New System.Text.StringBuilder

        If Not Request.QueryString("RoleID") Is Nothing Then
            RoleID = Request.QueryString("RoleID").ToString()
        End If

        If Not Request.QueryString("FromDate") Is Nothing Then
            dtFromDate = Request.QueryString("FromDate").ToString()
        End If

        FormWhere = Request.QueryString("FromWhere").ToString()
        Location = Request.QueryString("LocationID").ToString()

        strQuery = "usp_Sel_EmployeeInformation " + RoleID + ",'" + dtFromDate + "'," + Location + ",'" + FormWhere + "'," + Session("intUserID").ToString()

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)


        While dr.Read()

            EmployeeName = dr("EmployeeName").ToString()
            Location = dr("Location").ToString()
            Role = dr("Role").ToString()
            BG = dr("BusinessGroup").ToString()
            EmailID = CommonFunction.Data.CheckIsDBNull(dr("EmailID"), "-").ToString()
            FromWhere = CommonFunction.Data.CheckIsDBNull(dr("FromWhere"), "-").ToString()

            If Cnt = 1 Then

                m_sbHTMLDIV.Append("<Table  cellpadding=0 cellspacing=0 width=100%>")
                m_sbHTMLDIV.Append("<tr class='clsTRPageCaption'>")
                m_sbHTMLDIV.Append("<td>" + FromWhere + " For Role : " + Role + "</td>")
                m_sbHTMLDIV.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a></td>")
                m_sbHTMLDIV.Append("</tr>")
                m_sbHTMLDIV.Append("</Table>")

                m_sbHTMLDIV.Append("<TABLE id='tblHeader' cellpadding=0 cellspacing=1 class='clsGridTable'  width=99.9% >" + vbCrLf)
                m_sbHTMLDIV.Append("<THead class='clsTRColumnHeader' >" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=left>Resource</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=left>Business Group</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=left>Organization Unit</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=left>Email ID</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("</THead>" + vbCrLf)

                Cnt = Cnt + 1
            End If

            m_sbHTMLDIV.Append("<TR class=" + strClass + ">")
            m_sbHTMLDIV.Append("<TD>" + EmployeeName + "</TD>")
            m_sbHTMLDIV.Append("<TD>" + BG + "</TD>")
            m_sbHTMLDIV.Append("<TD>" + Location + "</TD>")
            m_sbHTMLDIV.Append("<TD>" + EmailID + "</TD>")
            m_sbHTMLDIV.Append("</TR>")


            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If


        End While

        CommonFunction.Data.DisposeDataReader(dr)

        m_sbHTMLDIV.Append("</TABLE>" + vbCrLf)
        ' m_sbHTMLDIV.Append("</Div>" + vbCrLf)

        Response.Clear()
        Response.Write(m_sbHTMLDIV.ToString())
        Response.End()
    End Sub


    Private Sub DrawDtlEmpPRJDiv(ByVal FromWhere As String)
        Dim strQuery As String
        Dim dr As IDataReader
        Dim RoleID As String
        Dim dtFromDate As String
        Dim EmployeeName As String
        Dim Role As String
        Dim Location As String
        Dim FormWhereQS As String
        Dim strClass As String = "clsTREven"
        Dim Cnt As Integer = 1
        Dim BG As String
        Dim EmailID As String
        Dim Project As String
        Dim StartDate As String
        Dim EndDate As String
        Dim Per As String
        Dim EmployeeID As String
        Dim oldEmployeeName As String = ""
        Dim oldProjectName As String = ""

        Dim m_sbHTMLDIV As System.Text.StringBuilder
        m_sbHTMLDIV = New System.Text.StringBuilder

         


        If Not Request.QueryString("RoleID") Is Nothing Then
            RoleID = Request.QueryString("RoleID").ToString()
        End If

        If Not Request.QueryString("FromDate") Is Nothing Then
            dtFromDate = Request.QueryString("FromDate").ToString()
            DateForPeriod = dtFromDate
        End If

        FormWhereQS = Request.QueryString("FromWhere").ToString()
        Location = Request.QueryString("LocationID").ToString()

        strQuery = "usp_Sel_EmployeeInformation " + RoleID + ",'" + dtFromDate + "'," + Location + ",'" + FormWhereQS + "'," + Session("intUserID").ToString()

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)


        While dr.Read()

            EmployeeName = dr("EmployeeName").ToString()
            'Location = dr("Location").ToString()
            Role = dr("Role").ToString()
            Project = dr("ProjectName").ToString()
            StartDate = CommonFunction.Dates.CGetDate(CType(dr("ExpectedStartDate"), Date)).ToString()
            EndDate = CommonFunction.Dates.CGetDate(CType(dr("ExpectedEndDate"), Date)).ToString()
            Per = CommonFunction.Data.CheckIsDBNull(dr("ResourcePercentage"), "-").ToString()
            'BG = dr("BusinessGroup").ToString()
            'EmailID = dr("EmailID").ToString()
            EmployeeID = dr("EmployeeID").ToString()
            FromWhere = dr("FromWhere").ToString()

            If Cnt = 1 Then

                m_sbHTMLDIV.Append("<Table  cellpadding=0 cellspacing=0 width=100%>")
                m_sbHTMLDIV.Append("<tr class='clsTRPageCaption'>")
                m_sbHTMLDIV.Append("<td>" + FromWhere + " For Role : " + Role + "</td>")
                m_sbHTMLDIV.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a></td>")
                m_sbHTMLDIV.Append("</tr>")
                m_sbHTMLDIV.Append("</Table>")

                m_sbHTMLDIV.Append("<TABLE id='tblHeader' cellpadding=0 cellspacing=1 class='clsGridTable'  width=99.9% >" + vbCrLf)
                m_sbHTMLDIV.Append("<THead class='clsTRColumnHeader' >" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=left>Resource</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=left>Project</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=left>Start Date</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=left>End Date</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("<TH align=right>Allocation %</TH>" + vbCrLf)
                m_sbHTMLDIV.Append("</THead>" + vbCrLf)

                Cnt = Cnt + 1
            End If

            If DateForPeriod = "" Then
                DateForPeriod = CType(Now.Date, String)
            End If

            m_FinancialPeriodCount = DateDiff("m", Now.Date, DateForPeriod)

            m_sbHTMLDIV.Append("<TR class=" + strClass + ">")

            If oldEmployeeName <> EmployeeName Then
                m_sbHTMLDIV.Append("<TD><A onclick=ShowAllocation_onClick(" + EmployeeID + ",'" + m_FinancialPeriodCount + "')><U>" + EmployeeName + "</U></A></TD>")
            Else
                m_sbHTMLDIV.Append("<TD>&nbsp;</TD>")
            End If

            If oldProjectName <> Project OrElse (oldEmployeeName <> EmployeeName And oldProjectName = Project) Then
                m_sbHTMLDIV.Append("<TD>" + Project + "</TD>")
            Else
                m_sbHTMLDIV.Append("<TD>&nbsp;</TD>")
            End If

            m_sbHTMLDIV.Append("<TD>" + StartDate + "</TD>")
            m_sbHTMLDIV.Append("<TD>" + EndDate + "</TD>")
            m_sbHTMLDIV.Append("<TD align=right>" + Per + "</TD>")

            m_sbHTMLDIV.Append("</TR>")


            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If

            oldEmployeeName = EmployeeName
            oldProjectName = Project
        End While

        m_sbHTMLDIV.Append("</TABLE>" + vbCrLf)
        ' m_sbHTMLDIV.Append("</Div>" + vbCrLf)

        CommonFunction.Data.DisposeDataReader(dr)

        Response.Clear()
        Response.Write(m_sbHTMLDIV.ToString())
        Response.End()
    End Sub

End Class