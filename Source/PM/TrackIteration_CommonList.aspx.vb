Imports CommonEngines.General.cEventHandlers
Imports CommonFunctions
Imports System.Web.UI.Page
Public Class TrackIteration_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "TrackIteration_CommonList.aspx"
        MyBase.strFormPage = "TrackIteration_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cTrackIteration_CommonList_PlotGrid(MyBase.m_objGlobal)
    End Function
    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Cancel = True
    End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
End Class
Class cTrackIteration_CommonList_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    'Dim m_intCnt As Integer = 0
    Private m_IterationId As String
    Private strClass As String = "clsTROdd"
    Private intTotalCol As Integer
    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Args.TDStyle = "style='border-bottom: 1pt solid gray;'"
        m_IterationId = CType(Args.DataReader("ID"), Integer)

        If Args.DataField.Trim.ToUpper = "NAME" Then
            Args.StringToBeInserted = "<TD style='border-bottom: 1pt solid gray;'  nowrap  align=Left ><A href=""JavaScript:Name_OnClick('" + m_IterationId + "','ITERATION')"" >" + Args.DataReader("Name").ToString + "</A></TD>"
            Cancel = True
        End If

        If Args.DataField.Trim.ToUpper = "MODIFIEDDATE" Then
            Args.TDStyle = " title='Description'"
            Args.StringToBeInserted = "<TD id= " + m_IterationId.ToString() + " name=" + m_IterationId.ToString() + " vAlign=top title='Description' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:ShowDescription_onClick(" + m_IterationId.ToString + " )""><IMG Border=0  SRC='../../Images/plus.gif' Collapse='N' title='User Stories' onclick="""" ID='imgSummaryShowHide" & CType(m_IterationId, String) & "' name='imgSummaryShowHide" & CType(m_IterationId, String) & "'></a></TD>"
            Cancel = True
        End If

        If Args.DataField.Trim.ToUpper = "VELOCITY" Then
            Args.StringToBeInserted = "<TD style='border-bottom: 1pt solid gray;'  align=Center >" + Args.DataReader("Velocity").ToString + " h</TD>"
            Cancel = True
        End If
        If Args.DataField.Trim.ToUpper = "EFFORT" Then
            Dim drProgress As IDataReader
            drProgress = CommonFunctions.Data.GetDataReader("EXEC Usp_Sel_TrackIteration " + m_IterationId + ",'IterationEffort'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drProgress.Read Then
                Args.StringToBeInserted = "<TD style='border-bottom: 1pt solid gray;'  align=Center >" + drProgress("Effort").ToString + " h</TD>"
                Cancel = True
            End If
        End If
        If Args.DataField.Trim.ToUpper = "PROGRESS" Then
            Dim drProgress As IDataReader
            drProgress = CommonFunctions.Data.GetDataReader("EXEC Usp_Sel_TrackIteration " + m_IterationId + ",'IterationProgress'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drProgress.Read Then
                Args.StringToBeInserted = "<TD style='border-bottom: 1pt solid gray;'  align=Center >" + drProgress("I_Progress").ToString + "%</TD>"
            End If
            Cancel = True
        End If
        If Args.DataField.Trim.ToUpper = "TAGS" Then
            'Args.StringToBeInserted = "<TD style='border-bottom: 1pt solid gray;'  align=Left ><A href=""JavaScript:Name_OnClick('18','RELEASE')"" >0%</TD>"
            'Cancel = True
        End If
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "MODIFIEDDATE" Then
            Args.ColumnName = ""
        End If
    End Sub
    'Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub
    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Args.TableStyle = " cellpadding=0 cellspacing=0  style='border-right: 2px solid gray;border-left: 2px solid gray;border-top: 2px solid gray;'"
    End Sub
    Protected Overrides Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_IterationId = CType(Args.DataReader("ID"), Integer)
        intTotalCol = CType(Args.DataReader.Table.Columns.Count, Integer)

        Dim dtUserStorySummary As DataTable
        'Dim drUserStorySummary As IDataReader
        'Dim strSQL As String
        'strSQL = "SELECT UserStoryID,UserStoryName,BusinessValueName,CONVERT(INT,InitialEstimate) AS InitialEstimate,StateName,ReleaseName"
        'strSQL += " FROM d_tbl_PM_ScrumUserStory INNER JOIN tbl_pm_scrumbusinessvalue ON d_tbl_PM_ScrumUserStory.Businessvalueid = tbl_pm_scrumbusinessvalue.Businessvalueid"
        'strSQL += " INNER JOIN tbl_pm_scrumentitystate ON d_tbl_PM_ScrumUserStory.entitystateid = tbl_pm_scrumentitystate.entitystateid WHERE iterationid = " + m_IterationId

        dtUserStorySummary = CommonFunctions.Data.GetDataTable("EXEC Usp_Sel_TrackIteration " + m_IterationId + ",'UserStoryProgress'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If dtUserStorySummary.Rows.Count > 0 Then


            Args.StringToBeInserted = "<TR class=" + strClass + " id='Description" & CType(m_IterationId, String) & "' name='Description" & CType(m_IterationId, String) & "' width=99.9% style=""display:none"">"
            Args.StringToBeInserted += "<TD style='border-top: 1pt solid gray;border-bottom: 1pt solid gray;'> </td><TD style='border-top: 1pt solid gray;border-bottom: 1pt solid gray;'> </td>"
            Args.StringToBeInserted += "<TD style='border-top: 1pt solid gray;border-bottom: 1pt solid gray;' align=left colspan=" + (intTotalCol - 2).ToString() + ">"
            Args.StringToBeInserted += "<DIV id=Summary" & CType(m_IterationId, String) & " name=Summary" & CType(m_IterationId, String) & " style=""overflow:auto;display:none"">"
            Args.StringToBeInserted += "<TABLE ID='Description' cellspacing=0 cellpadding=0 Width=90% style='font-size: 10pt;font-family: Verdana, Arial;'>"
            ''Args.StringToBeInserted += "<tr class=" + strClass + ">tttt<td valign='top' colspan='7'  ></td></tr>"
            'Args.StringToBeInserted += "<tr class=" + strClass + ">"
            ''Args.StringToBeInserted += "<td valign='top' align='left' ></TD><td valign='top' align='left' >"
            ''Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td valign='top' align='left' >"

            'Args.StringToBeInserted += "<TABLE width='100%' CellSpacing=""0"" CellPadding=""0"">"

            Args.StringToBeInserted += "<tr style=""color:gray;"">"
            Args.StringToBeInserted += "<td align='Left' title='Type' width='50'>"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "<td align='Left' title='ID' width='50'>ID"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "<td align='Left' title='Name' width='100'>Name"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "<td align='Left' title='BV' width='100'>BV"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "<td align='Left' title='Effort' width='50'>Effort"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "<td align='Left' title='State' width='50'>State"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "<td align='Left' title='Remain' width='100'>Spent/Remain"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "<td align='Left' title='Release' width='100'>Release"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "<td align='Left' title='Edit' width='50'>"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "</TR>"
            For i As Int32 = 0 To dtUserStorySummary.Rows.Count - 1
                Args.StringToBeInserted += "<tr class='clsTREven'>"
                Args.StringToBeInserted += "<td align='Left' title='Type' width='50'><IMG src=""../../Images/Scrum/UserStory.gif"">"
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "<td align='Left' title='ID' width='50'>" + dtUserStorySummary.Rows(i)("UserStoryID").ToString
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "<td align='Left' title='Name' width='100'><A href=""JavaScript:Name_OnClick('" + dtUserStorySummary.Rows(i)("UserStoryID").ToString + "','STORY')"" >" + dtUserStorySummary.Rows(i)("UserStoryName").ToString
                Args.StringToBeInserted += "</A></TD>"
                Args.StringToBeInserted += "<td align='Left' title='BV' width='100'>" + dtUserStorySummary.Rows(i)("BusinessValueName").ToString
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "<td align='Left' title='Effort' width='50'>" + dtUserStorySummary.Rows(i)("InitialEstimate").ToString + " h"
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "<td align='Left' title='State' width='50'>" + dtUserStorySummary.Rows(i)("StateName").ToString
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "<td align='Left' title='Remain' width='100'><span id=""pr1""></span><div title='Spent: " + dtUserStorySummary.Rows(i)("TimeSpent").ToString + " h, Remain: " + dtUserStorySummary.Rows(i)("TimeRemain").ToString + " h' class='rankBar' style='width: 50px'><div class='rankFilledBar' style='width:" + dtUserStorySummary.Rows(i)("Progress").ToString + "%'>&nbsp;</div></div>"
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "<td align='Left' title='Release' width='100'>" + dtUserStorySummary.Rows(i)("ReleaseName").ToString
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "<td align='Left' title='Edit' width='50'>"
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "</TR>"
            Next
            Args.StringToBeInserted += "</TABLE>"

            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "</TR>"
            ''Args.StringToBeInserted += "<tr class=" + strClass + ">tttt<td valign='top' colspan='7'  ></td></tr>"
            'Args.StringToBeInserted += "</TABLE>"
            Args.StringToBeInserted += "</DIV>"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "</TR>"

        Else

            Args.StringToBeInserted = "<TR class=" + strClass + " id='Description" & CType(m_IterationId, String) & "' name='Description" & CType(m_IterationId, String) & "' width=99.9% style=""display:none"">"
            Args.StringToBeInserted += "<TD style='border-top: 1pt solid gray;border-bottom: 1pt solid gray;'> </td><TD style='border-top: 1pt solid gray;border-bottom: 1pt solid gray;'> </td>"
            Args.StringToBeInserted += "<TD style='border-top: 1pt solid gray;border-bottom: 1pt solid gray;' align=left colspan=" + (intTotalCol - 2).ToString() + ">"
            Args.StringToBeInserted += "<DIV id=Summary" & CType(m_IterationId, String) & " name=Summary" & CType(m_IterationId, String) & " style=""overflow:auto;display:none"">"
            Args.StringToBeInserted += "<center>There is no user story assign.</center>"
            'Args.StringToBeInserted += "<TABLE ID='Description' cellspacing=0 cellpadding=0 Width=90% style='font-size: 10pt;font-family: Verdana, Arial;'>"
            '''Args.StringToBeInserted += "<tr class=" + strClass + ">tttt<td valign='top' colspan='7'  ></td></tr>"
            ''Args.StringToBeInserted += "<tr class=" + strClass + ">"
            '''Args.StringToBeInserted += "<td valign='top' align='left' ></TD><td valign='top' align='left' >"
            '''Args.StringToBeInserted += "</TD>"
            ''Args.StringToBeInserted += "<td valign='top' align='left' >"

            ''Args.StringToBeInserted += "<TABLE width='100%' CellSpacing=""0"" CellPadding=""0"">"

            'Args.StringToBeInserted += "<tr style=""color:gray;"">"
            'Args.StringToBeInserted += "<td align='Left' title='Type' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='ID' width='50'>ID"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Name' width='50'>Name"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='BV' width='50'>BV"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Effort' width='50'>Effort"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='State' width='50'>State"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Remain' width='50'>Spent/Remain"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Release' width='50'>Release"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Edit' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "</TR>"
            'Args.StringToBeInserted += "<tr class='clsTREven'>"
            'Args.StringToBeInserted += "<td align='Left' title='Type' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='ID' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Name' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='BV' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Effort' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='State' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Remain' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Release' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "<td align='Left' title='Edit' width='50'>"
            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "</TR>"
            'Args.StringToBeInserted += "</TABLE>"

            'Args.StringToBeInserted += "</TD>"
            'Args.StringToBeInserted += "</TR>"
            ''Args.StringToBeInserted += "<tr class=" + strClass + ">tttt<td valign='top' colspan='7'  ></td></tr>"
            'Args.StringToBeInserted += "</TABLE>"
            Args.StringToBeInserted += "</DIV>"
            Args.StringToBeInserted += "</TD>"
            Args.StringToBeInserted += "</TR>"
        End If
    End Sub

End Class
