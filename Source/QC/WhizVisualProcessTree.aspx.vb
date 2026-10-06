
Imports System

Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Data.SqlClient
Imports Infragistics.WebUI.UltraWebNavigator




Partial Public Class WhizVisualProcessTree
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        Dim objDS As New DataSet()
        WhizProcessFunctions.ProcessTreeDataset(objDS, "USP_VPM_GET_PROCESSTree")
        'objDS.ReadXml(Server.MapPath("WhizProjectCenterMenu.xml").ToString());
        objDS.Relations.Add("FirstLevel", objDS.Tables(0).Columns("RootLevel"), objDS.Tables(1).Columns("RootLevel"))
        objDS.Relations.Add("SecondLevel", objDS.Tables(1).Columns("LevelOneID"), objDS.Tables(2).Columns("LevelOneID"))
        objDS.Relations.Add("ThirdLevel", objDS.Tables(2).Columns("LevelTwoID"), objDS.Tables(3).Columns("LevelTwoID"))
        objDS.Relations.Add("FourthLevel", objDS.Tables(3).Columns("LevelThreeID"), objDS.Tables(4).Columns("LevelThreeID"))
        UltraWebTree1.DataSource = objDS.Tables(0).DefaultView

        UltraWebTree1.Cursor = Infragistics.WebUI.Shared.Cursors.Hand
        'First level 
        UltraWebTree1.Levels(0).RelationName = "FirstLevel"
        UltraWebTree1.Levels(0).ColumnName = objDS.Tables(0).Columns("QualityCenter").ColumnName
        UltraWebTree1.Levels(0).LevelKeyField = objDS.Tables(0).Columns("RootLevel").ColumnName
        UltraWebTree1.Levels(0).ImageColumnName = "ImageSource"

        'Second level
        UltraWebTree1.Levels(1).RelationName = "SecondLevel"
        UltraWebTree1.Levels(1).ColumnName = objDS.Tables(1).Columns("LevelOneColumnName").ColumnName
        UltraWebTree1.Levels(1).LevelKeyField = objDS.Tables(1).Columns("LevelOneID").ColumnName
        UltraWebTree1.Levels(1).ImageColumnName = "ImageSource"

        'Third level
        UltraWebTree1.Levels(2).RelationName = "ThirdLevel"
        UltraWebTree1.Levels(2).ColumnName = objDS.Tables(2).Columns("LevelTwoColumnName").ColumnName
        UltraWebTree1.Levels(2).LevelKeyField = objDS.Tables(2).Columns("LevelTwoID").ColumnName
        UltraWebTree1.Levels(2).ImageColumnName = "ImageSource"

        'Fourth Level
        UltraWebTree1.Levels(3).RelationName = "FourthLevel"
        UltraWebTree1.Levels(3).ColumnName = objDS.Tables(3).Columns("LevelThreeColumnName").ColumnName
        UltraWebTree1.Levels(3).LevelKeyField = objDS.Tables(3).Columns("LevelThreeID").ColumnName
        UltraWebTree1.Levels(3).ImageColumnName = "ImageSource"

        'Fifth Level
        UltraWebTree1.Levels(4).ColumnName = objDS.Tables(4).Columns("LevelFourColumnName").ColumnName
        UltraWebTree1.Levels(4).LevelKeyField = objDS.Tables(4).Columns("LevelFourID").ColumnName
        UltraWebTree1.Levels(4).ImageColumnName = "ImageSource"

        UltraWebTree1.DataBind()
        UltraWebTree1.ExpandAll()
    End Sub 'Page_Load 


    Protected Function GetModules() As String
        '=====================================================================
        ' Function  Name		:	GetModules()
        ' Parameters Passed		:	TagID
        ' Returns				:	To return system modules 
        ' Parameters Affected	:	None
        ' Purpose				:	To return system modules 
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	June 26 2009
        ' Revisions				:	
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim intCount As Integer = 0
        Dim strImage As String = ""
        Dim strModuleList As String = ""
        '--- Added By purvaj on 21 jul 09 SEM 8.1 New ui show module icons  in the left
        Dim strNavigationMenu As String = ""

        Dim objSystemModulesAry() As CommonEngines.HashTables.SystemModules

        If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
        Else
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules" + MyBase.CurrentThreadUICultureID.ToString)
            If objSystemModulesAry Is Nothing Then
                objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
            End If
        End If

        If Not objSystemModulesAry Is Nothing Then
            strHTML.Append("<div id='trGM'>")
            strHTML.Append("<Table border=0 cellspacing=0 cellpadding=0 width='99.9%' class='clsTable' valign='bottom'>")
            strHTML.Append("<TR  >")
            strHTML.Append("<Td  style='height:3%;' class='clsTDScroll' align='center' colspan='2' title='Enlarge/Shrink module bar' onclick='javascript:ShowHideModules(this)' style='cursor:hand;' onmouseover='SetRollOverTD(this,event,1)' onmouseout='SetRollOverTD(this,event,2)'>")
            strHTML.Append("...<img id='imgUpDown' alt='Enlarge/Shrink module bar' src='../../Images/Sort_down.gif' border=0 style=""vertical-align:middle;align:center;"" />...")
            strHTML.Append("</Td>")
            strHTML.Append("</TR>")
            strHTML.Append("<TR  id='trModuleBar' class='clsTRMenu' style='display:none;'>")
            strHTML.Append("<Td id='tdModuleBar' align='center' colspan='2' >")
            strHTML.Append("</Td>")
            strHTML.Append("</TR>")


            For intCount = 0 To objSystemModulesAry.Length - 1
                If Not objSystemModulesAry(intCount).HideModuleNameOnTab And (objSystemModulesAry(intCount).ShortName.ToUpper <> "BTS" And objSystemModulesAry(intCount).ShortName <> "DT" And objSystemModulesAry(intCount).ShortName <> "SU") And GetTagAccessRights(objSystemModulesAry(intCount).ModuleTagID, True) Then
                    If objSystemModulesAry(intCount).ShortName.ToUpper = "PM" Then
                        strImage = "../../Images/dc.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SM" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "FA" Then
                        strImage = "../../Images/RDB_Outstanding2.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "RM" Then
                        strImage = "../../Images/cssImages/WF_UserStage_Old.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "MR" Then
                        strImage = "../../Images/cssImages/Link images/graph.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "PRO" Then
                        strImage = "../../Images/TimeSheet.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "SU" Then
                        strImage = "../../Images/cssImages/Link images/config.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "CRM" Then
                        strImage = "../../Images/template.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "KM" Then
                        strImage = "../../Images/bs.gif"
                    ElseIf objSystemModulesAry(intCount).ShortName.ToUpper = "DB" Then
                        strImage = "../../Images/Home/home.jpg"
                    End If

                    strModuleList += "<A style='text-decoration:none;' Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' onmouseover='this.style.backgroundColor=""#FFD695""' onmouseout='this.style.backgroundColor=""""' class='clsMenu' href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'><img src='" + strImage + "' border=0 style=""vertical-align:bottom;align:left;""></a>" ''+ "&nbsp;&nbsp;"
                    If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                        strHTML.Append("<TR class='clsTRMenuMouseOver' id='trModules' style='cursor:hand;text-align:left;'  onclick='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'>") 'onmouseover=javascript:ModulesOnMouseOver(this)' onmouseout='javascript:ModulesOnMouseOut(this);'
                    Else
                        strHTML.Append("<TR class='clsTRMenu' id='trModules' style='cursor:hand;text-align:left;' onclick='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'  onmouseover='javascript:ModulesOnMouseOver(this)' onmouseout='javascript:ModulesOnMouseOut(this)'>") 'onmouseover=javascript:ModulesOnMouseOver(this)' onmouseout='javascript:ModulesOnMouseOut(this);'
                    End If

                    strHTML.Append("<Td align='left' style='height:15%;'>")
                    strHTML.Append("<img src='" + strImage + "' border=0 style=""vertical-align:bottom;align:left;"">")
                    strHTML.Append("</Td>")

                    strHTML.Append("<Td align='left'  style='cursor:hand;text-align:left;height:15%;' id='iMenu'>")
                    'strHTML.Append("<A class='Menu' style='TEXT-DECORATION:NONE' onmouseover='this.style.backgroundColor='#FFD695'' onmouseout='this.style.backgroundColor='''  Title='Configuration' >")



                    strHTML.Append("<A style='text-decoration:none;width:170px;' class='clsMenu'")
                    ''''If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                    ''''    ''strHTML.Append(" class='cSelected' ")
                    ''''    ''strHTML.Append(" class='cSelected' ") ''clsLinkSelectedNavMenu

                    ''''Else
                    ''''    strHTML.Append(" class='clsMenu' ")
                    ''''End If


                    strHTML.Append(" Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ToolTip)) & "' ")
                    strHTML.Append(" href='javascript:Tab_OnClick(" & Chr(34) & objSystemModulesAry(intCount).ShortName & Chr(34) & ")'>")

                    'strHTML.Append("<b>")
                    ''Tahoma
                    '''If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                    '''    strHTML.Append("<i>")
                    '''    strHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ModuleName)))
                    '''    strHTML.Append("</i>")
                    '''Else
                    strHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ModuleName)))
                    '''End If
                    'strHTML.Append("</b>")

                    strHTML.Append("</A>")
                    strHTML.Append("</Td>")
                    strHTML.Append("</TR>")
                End If
            Next
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidTxtModules", "hidTxtModules", , , , strModuleList, , , , , , True, , True))
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidTxtModules", "hidTxtModules", , , , strModuleList, , , , , , True, , True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            strHTML.Append("</Table>")
            strHTML.Append("</div>")
        End If
        GetModules = strHTML.ToString
        objSystemModulesAry = Nothing
        strHTML = Nothing
    End Function

    Private Function GetTagAccessRights(ByVal lngTagID As Long, Optional ByVal IsModuleAccess As Boolean = False) As Boolean
        '=====================================================================
        ' Function  Name		:	GetTagAccessRights()
        ' Parameters Passed		:	TagID
        ' Returns				:	boolean value whether tag is accessable or not
        ' Parameters Affected	:	None
        ' Purpose				:	To verify whether tag is accessable or not
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        Dim m_objAccess As New WebPage.Templates.AccessRights
        Dim m_GlobalObject As New WebPages.Template.WhizGlobal
        Dim cWhizTemplate As New WebPages.Template.WhizTemplate
        Dim IsAccessForNode As Boolean
        cWhizTemplate.FillGlobalObject(cWhizTemplate.CurrentThreadUICultureID)
        m_GlobalObject = cWhizTemplate.GlobalObject()

        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            m_objAccess.GetAccess(m_GlobalObject, IsModuleAccess)

            If IsModuleAccess Then
                Return m_objAccess.Access()
            End If

            If m_objAccess.Add = True OrElse m_objAccess.Delete = True OrElse m_objAccess.Edit = True OrElse m_objAccess.View Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        cWhizTemplate.Dispose()
        m_objAccess = Nothing
        Return IsAccessForNode

    End Function

End Class '_Default