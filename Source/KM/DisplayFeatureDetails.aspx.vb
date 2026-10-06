#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
' To Plot the Dynamic Menu
Imports Telerik.WebControls



#End Region

Partial Public Class DisplayFeatureDetails
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Dim m_strFeatureID As String
    Private mstrFromWhere As String
    Protected MyMenuGroup As MenuGroup
    Protected MyMenuChildGroup As MenuGroup
    Protected MyMenuItem As New Telerik.WebControls.MenuItem

    Protected WithEvents MyMenu As New Telerik.WebControls.RadMenu
    Protected strProductID As String

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load


    End Sub
    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        :  DrawMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Image Menu
        ' Description           :  This sub-routine Draws the Image menu based.
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrajaktaR 
        ' Created               :  6 Jun 2006
        ' Revisions             :  
        '                       'Modified by JijeshP on 31st July 2006 for WhizibleSEM SP 7.2 Issue ID.3735
        '                       ' Used the WhizibleSEM6.0 solution Pages for the Integration                        
        '=====================================================================
        Dim strSQL As String
        Dim strSQLSections As String
        Dim objDr As IDataReader
        Dim objDrSections As IDataReader
        Dim strCaption As String
        Dim strHref As String
        Dim strImage As String
        Dim IsGroupedOn As Boolean
        Dim strMenuId As String
        Dim strCurrentMenuGroup As String
        Dim objSectionTitle As New WebPages.Template.SectionTitle
        Dim objfirstGroup As MenuGroup
        Dim blnFirstMenuGroup As Boolean = False
        Dim strMenu As String
        Dim strDiv As String



        MyMenuGroup = New MenuGroup

        Dim MyMenu1 As New Telerik.WebControls.RadMenu

        MyMenu1.ID = "MyMenu1"
        MyMenuGroup.Flow = "Horizontal"
        MyMenuGroup.Id = "LeftMenu"

        MyMenu1.RootGroup = MyMenuGroup

        MyMenu1.ScrollSpeed = 10
        MyMenu1.OverrideDefaultTDCss = True
        MyMenu1.CausesValidation = 0
        MyMenu1.ClickToOpen = True
        MyMenu1.CssFile = "../General/WindowsXP.css"
        MyMenu1.DefaultExpandEffectDuration = 5
        MyMenu1.DefaultGroupCss = "MenuGroup"
        MyMenu1.DefaultItemCss = "MenuItem"
        MyMenu1.DefaultItemHeight = 15
        MyMenu1.DefaultItemOverCss = "arrow_right.gif"
        MyMenu1.EnableViewState = 0
        MyMenu1.GroupHideDelay = 1000
        MyMenu1.DefaultItemOverCss = "MenuItemOver"
        MyMenu1.OnClientClick = "ProcessClientHover"
        MyMenu1.Opacity = 100
        MyMenu1.Overlay = 1
        MyMenu1.OverrideDefaultTDCss = 0
        MyMenu1.ScrollCssClass = "MenuScroll"
        MyMenu1.ScrollDownDisabledImage = "ScrollDownDisabled.gif"
        MyMenu1.ScrollDownImage = "ScrollDown.gif"
        MyMenu1.ScrollOverCssClass = "MenuScrollOver"
        MyMenu1.ScrollSpeed = 10
        MyMenu1.ScrollUpDisabledImage = "ScrollUpDisabled.gif"
        MyMenu1.ScrollUpImage = "ScrollUp.gif"
        MyMenu1.ShadowColor = "White"
        MyMenu1.ShadowWidth = 1
        MyMenu1.ShowPath = 1
        MyMenu1.ImagesBaseDir = "Images"


        MyMenuItem = New MenuItem
        MyMenuItem.Id = "m1"
        MyMenuItem.Label = "Prev"
        MyMenuItem.Href = ""
        MyMenuItem.LeftLogo = "../../../images/arrowup.gif"
        MyMenuItem.NoWrap = False
        MyMenuItem.TextAlign = "Bottom"
        MyMenuItem.Target = "WorkSpace"
        MyMenuItem.ToolTip = "Previous"
        MyMenuItem.CssClassOver = "MenuItemOver"

        MyMenuItem.PostBack = False
        MyMenuItem.ParentGroup = MyMenuGroup

        MyMenuGroup.AddItem(MyMenuItem)
        MyMenuItem = Nothing
        MyMenuItem = New MenuItem
        MyMenuItem.Id = "m2"
        MyMenuItem.Label = "Next"
        MyMenuItem.Href = ""
        MyMenuItem.LeftLogo = "../../../images/arrowdown.gif"
        MyMenuItem.NoWrap = False
        MyMenuItem.TextAlign = "Bottom"
        MyMenuItem.Target = "WorkSpace"
        MyMenuItem.ToolTip = "Previous"

        MyMenuItem.PostBack = False
        MyMenuItem.ParentGroup = MyMenuGroup

        MyMenuGroup.AddItem(MyMenuItem)



        strMenu = MyMenu1.GetMenuHTML()
        strMenu = Replace(strMenu, "<Table>", "<tr class=clsTREven><td>")
        strMenu = Replace(strMenu, "<td align=""center"">&lt;BR&gt;", "<td></TD></tr><tr class=clsTREven> <td align='center' >")

        strMenu = Replace(strMenu, "align=""Left"" width=""5px""", "align='Center'")

        Response.Write(strMenu)
        Response.Write("</td></tr></table>")
        MyMenu1 = Nothing

        MyMenuItem = Nothing
        MyMenuGroup = Nothing


    End Sub
    Public Sub PageInit()

        Dim strSql As String
        Dim drFeatureDetails As IDataReader
        Dim drSubFeatureDetails As IDataReader
        Dim intCounter As Integer
        Dim strSubFeatureDiv As String
        Dim strsubFeatureImg As String
        Dim strComplexity As String
        Dim strSize As String
        Dim strUnit As String
        Dim strProduct As String
        Dim intFromSearch As Integer

        intCounter = 1

        Response.Write("<Div class=divListTag id='PageDiv' Style='HEIGHT:500px;OVERFLOW:auto; WIDTH:100%';'>")

        If Request.QueryString("FeatureId") <> "" Then
            m_strFeatureID = Request.QueryString("FeatureId")
        ElseIf Request.Form("hidFeatureId") <> "" Then
            m_strFeatureID = Request.Form("hidFeatureId")
        Else
            Response.End()
        End If

        If Request.QueryString("FromSearch") <> "" Then
            intFromSearch = Request.QueryString("FromSearch")
        Else
            intFromSearch = 0
        End If

        Session("FeatureList") = Session("FeatureList") & m_strFeatureID & ","
        Session("CurrentFeature") = m_strFeatureID

        CommonFunction.General.WriteHTML("<input type=hidden name=hidFeatureId id=hidFeatureId value=" + m_strFeatureID + ">")
        '        m_strFeatureID = "1"

        strSql = "select *, tbl_PM_sizeunits.Unit as SizeUnit , tbl_PRD_Product.Product from tbl_PRD_ProductFeature  left join tbl_PM_sizeunits on tbl_PRD_ProductFeature.unit=tbl_PM_sizeunits.sizeunitid left join tbl_PRD_Product ON tbl_PRD_Product.ProductID = tbl_PRD_ProductFeature.ProductID where ProductFeatureID=" & m_strFeatureID

        drFeatureDetails = CommonFunctions.Data.GetDataReader(strSql, True)


        'Response.Write("<A><Img Border=0  Src='../../Images/treenodeimages/PrevBKMK.gif' title=''></A></TD></TR></TABLE>")




        If drFeatureDetails.Read Then
            strComplexity = Trim(CStr(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drFeatureDetails("Complexity")))))
            strSize = Trim(CStr(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drFeatureDetails("FeatureSize")))))
            strUnit = Trim(CStr(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drFeatureDetails("SizeUnit")))))

            ' Draw Section Header
            strProduct = Trim(CStr(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drFeatureDetails("Product")))))
            strProductID = Trim(CStr(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drFeatureDetails("ProductID")))))
            If intFromSearch = 0 Then
                Response.Write("<TABLE width=99.9% class=clsTable><TR class=clsTRPageCaption><TD><FONT color='red'>")
                Response.Write("<A href=Javascript:whiztech_onclick()><B> WhizTech </B></A>")
                Response.Write("--> " & strProduct & " --> " & drFeatureDetails("Feature").ToString)
                Response.Write("</td></font></tr></table>")
            Else
                Response.Write("<TABLE width=99.9% class=clsTable cellspacing=0 cellpadding=0><TR class=clsTRPageCaption><TD >")
                Response.Write(strProduct & " --> " & drFeatureDetails("Feature").ToString)
                Response.Write("</td><TD align=right><a  class='Menu' style='TEXT-DECORATION:NONE'  href=javascript:Close_OnClick() > Close </a></TD></TR></TABLE> ")
            End If
            Response.Write("<TABLE cellspacing=0 cellpading=0 width=99.9% class=clsTable><TR class=clsTRSectionHeader><TD class=clsTDOdd><A href=Javascript:showHide_Feature()><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></A><b> " & CStr(drFeatureDetails("Feature")) & "</B>")

            If strComplexity <> "" Then
                Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Complexity:")
                If strComplexity.ToUpper = "HIGH" Then
                    Response.Write(" High ( <Img Border=0  Src='../../Images/KM images/red.gif' title=''>)")
                Else
                    If strComplexity.ToUpper = "MEDIUM" Then
                        Response.Write(" Medium (<Img Border=0  Src='../../Images/KM images/yellow.gif' title=''>)")
                    Else
                        Response.Write("Low (<Img Border=0  Src='../../Images/KM images/green.gif' title=''>)")

                    End If
                End If
            End If

            If strSize <> "" Then
                Response.Write(" &nbsp;&nbsp;&nbsp;&nbsp; Size : " & strSize & "  " & strUnit)
            End If
            ' Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            Response.Write("</td><td align=right class=clstdodd>")

            Response.Write(" <a href=javascript:DisplayUsecase(" & drFeatureDetails("ProductFeatureID") & ") > Usecase </a>")
            Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

            Response.Write(" <a href=javascript:DisplayUseage(" & drFeatureDetails("ProductFeatureID") & ") > Usage </a>")



            Response.Write("</TD></TR></TABLE>")

            Session("CurrentFeatureDesc") = CStr(drFeatureDetails("Feature"))
            'Response.Write("<Table class=clstable > <tr class=clsTROdd> <td class=clsTDOdd > Feature : " & CType(drFeatureDetails("Feature"), String) & "</td></tr>")
            Response.Write("<DIV id='ShowFeature' name='ShowFeature'  style=overflow:auto;> ")
            Response.Write("<TABLE width=99.9% class=clsTable><TR class=clsTROdd><TD class=clsTDOdd>")

            Response.Write("<PRE>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drFeatureDetails("FeatureDescription"), ""), "") & "</PRE></td></TR></Table>")
            Call Displaytechnicaldetails(CType(drFeatureDetails("productfeatureid"), Integer), 0)
            Call DisplayAttachmentdetails(CType(drFeatureDetails("productfeatureid"), Integer), 0)

            Response.Write("</div>")
            'Code Commented and Added by RajkumarM to add Feature Related Topics
            'strSql = "select * from tbl_PRD_ProductFeature where parentfeatureid=" & m_strFeatureID
            strSql = "usp_Sel_FeatureRelatedTopics " & m_strFeatureID
            'Code Commented and Added by RajkumarM to add Feature Related Topics

            drSubFeatureDetails = CommonFunctions.Data.GetDataReader(strSql, True)

            Response.Write("<TABLE width=99.9% class=clsTable><TR class=clsTRSectionHeader><TD class=clsTDOdd><B>                Related Topics </B> </TD></TR></TABLe> ")

            intCounter = 1

            While drSubFeatureDetails.Read

                strSubFeatureDiv = "Div" & intCounter
                strsubFeatureImg = "img" & intCounter
                Response.Write("<TABLE width=99.9% class=clsTable><TR class=clsTROdd><TD class=clsTDOdd width=15></TD><TD class=clstdodd><A href=Javascript:showHide_SubFeature(" & intCounter & ")><Img Border=0 id=" & strsubFeatureImg & " Src='../../Images/plus.gif' title=''></A> " & CStr(drSubFeatureDetails("Feature")) & "</TD></TR></TABLE>")
                Response.Write("<DIV id=" & strSubFeatureDiv & " name=" & strsubFeatureImg & "  style=overflow:auto;display:none> ")
                Response.Write("<TABLE width=99.9% class=clsTable><TR class=clsTROdd><TD class=clsTDOdd width=15></TD><TD class=clsTDOdd>")

                'Response.Write("<Table class=clstable > <tr class=clsTROdd> <td class=clsTDOdd >Sub Feature : " & CType(drSubFeatureDetails("Feature"), String) & "</td></tr>")


                Response.Write("<TR class=clsTROdd><TD class=clsTDOdd width=15></TD><TD class=clsTDOdd><PRE>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubFeatureDetails("FeatureDescription"), ""), "") & "</PRE></td></TR></Table>")


                Call Displaytechnicaldetails(CType(drSubFeatureDetails("ProductFeatureID"), Integer), intCounter)

                Call DisplayAttachmentdetails(CType(drSubFeatureDetails("ProductFeatureID"), Integer), intCounter)

                Response.Write("</div>")

                intCounter = intCounter + 1

            End While

            CommonFunctions.Data.DisposeDataReader(drSubFeatureDetails)

        End If

        Call DisplayReferencedetails(CType(drFeatureDetails("productfeatureid"), Integer), 0)

        CommonFunctions.Data.DisposeDataReader(drFeatureDetails)



        Response.Write("</Div>")

    End Sub
    Sub Displaytechnicaldetails(ByVal intFeatureid As Integer, ByVal intcounter As Integer)
        Dim strTechFeatureDiv As String
        Dim strTechFeatureImg As String
        Dim strSQL As String
        Dim drTech As IDataReader
        Dim intFlag As Integer
        Dim strCommandSpname As String

        intFlag = 0

        strSQL = "Exec usp_sel_FeatureTechnicaldetails " & CStr(intFeatureid)
        drTech = CommonFunction.Data.GetDataReader(strSQL, True)


        While drTech.Read
            If intFlag = 0 Then
                strTechFeatureDiv = "DivTech" & intcounter
                strTechFeatureImg = "imgTech" & intcounter
                Response.Write("<TABLE width=99.9% class=clsTable><TR class=clsTROdd><TD class=clsTDOdd width=25></TD><TD class=clsTDOdd><A href=Javascript:showHide_TechFeature(" & intcounter & ")><Img Border=0 id=" & strTechFeatureImg & " Src='../../Images/plus.gif' title=''></A><B>" & " Technical Details" & "</B></TD></TR></TABLE>")
                Response.Write("<DIV id=" & strTechFeatureDiv & " name=" & strTechFeatureDiv & "  style=overflow:auto;display:none> ")
                Response.Write("<TABLE width=99.9% class=clsGridTable><TR class=clstrColumnHeader ><TD width=10%> Object </TD> <TD width=10%> Type </TD><TD> Description </TD></TR>")
                intFlag = 1
            End If


            If IsDBNull(drTech.Item("CommandSPname")) Then
                Response.Write("<TR class=clsTROdd><TR class=clsTROdd><TD class=clsTDOdd>" & CStr(drTech("BaseObject")) & "</TD>")
            Else
                Response.Write("<TR class=clsTROdd><TR class=clsTROdd><TD class=clsTDOdd><A HREF=Javascript:ViewSource('" & CStr(drTech("Objecttype")) & "'," & CStr(drTech.Item("objectID")) & ") </a> " & CStr(drTech("BaseObject")) & "</TD>")
            End If

            Response.Write("<TD class=clsTDOdd>" & CStr(drTech("ObjectType")) & "</td>")
            Response.Write("<TD class=clsTDOdd><PRE>" & CStr(drTech("objectdescription")) & "</PRE></td></TR>")

        End While

        CommonFunction.Data.DisposeDataReader(drTech)
        'Response.Write("<Table class=clstable > <tr class=clsTROdd> <td class=clsTDOdd >Sub Feature : " & CType(drSubFeatureDetails("Feature"), String) & "</td></tr>")
        If intFlag = 1 Then
            Response.Write("</Table></div>")
        End If


    End Sub

    Sub DisplayAttachmentdetails(ByVal intFeatureid As Integer, ByVal intcounter As Integer)
        Dim strAttachFeatureDiv As String
        Dim strAttachFeatureImg As String
        Dim strSQL As String
        Dim drAttachment As IDataReader
        Dim intFlag As Integer
        intFlag = 0

        strSQL = "Exec usp_sel_FeatureAttachmentdetails " & CStr(intFeatureid)
        drAttachment = CommonFunction.Data.GetDataReader(strSQL, True)


        While drAttachment.Read
            If intFlag = 0 Then
                strAttachFeatureDiv = "DivAtt" & intcounter
                strAttachFeatureImg = "imgAtt" & intcounter
                Response.Write("<TABLE width=99.9% class=clsTable><TR class=clsTROdd><TD class=clsTDOdd width=25></TD><TD class=clsTDOdd><A href=Javascript:showHide_AttFeature(" & intcounter & ")><Img Border=0 id=" & strAttachFeatureImg & " Src='../../Images/plus.gif' title=''></A><B>" & " Reference Documents" & "</B></TD></TR></TABLE>")
                Response.Write("<DIV id=" & strAttachFeatureDiv & " name=" & strAttachFeatureDiv & "  style=overflow:auto;display:none> ")
                Response.Write("<TABLE width=99.9% class=clsTable>")

                intFlag = 1
            End If
            Response.Write("<TR class=clsTROdd><TD width=25 class=clsTDOdd></TD><TD class=clsTDOdd><a href=javascript:ViewAttachments('" & drAttachment("FileName") & "') >" + CStr(drAttachment("OriginalFilename")) & "</a></TD></TR>")

        End While

        CommonFunction.Data.DisposeDataReader(drAttachment)

        If intFlag = 1 Then
            Response.Write("</Table></div>")
        End If


    End Sub

    Sub DisplayReferencedetails(ByVal intFeatureid As Integer, ByVal intcounter As Integer)
        Dim strRefFeatureDiv As String
        Dim strRefFeatureImg As String
        Dim strSQL As String
        Dim drRef As IDataReader
        Dim intFlag As Integer
        intFlag = 0

        strSQL = "Exec usp_sel_FeatureReferencedetails  " & CStr(intFeatureid)
        drRef = CommonFunction.Data.GetDataReader(strSQL, True)


        While drRef.Read
            If intFlag = 0 Then
                strRefFeatureDiv = "DivRef" & intcounter
                strRefFeatureImg = "imgRef" & intcounter
                Response.Write("<TABLE width=99.9% class=clsTable><TR class=clsTROdd><TD class=clsTDOdd><A href=Javascript:showHide_RefFeature(" & intcounter & ")><Img Border=0 id=" & strRefFeatureImg & " Src='../../Images/plus.gif' title=''></A><B>" & " See Also " & "</B></TD></TR></TABLE>")
                Response.Write("<DIV id=" & strRefFeatureDiv & " name=" & strRefFeatureDiv & "  style=overflow:auto;display:none> ")
                Response.Write("<TABLE width=99.9% class=clsTable>")

                intFlag = 1
            End If
            Response.Write("<TR class=clsTROdd><TD width=5 class=clsTDOdd></TD><TD class=clsTDOdd><a href=javascript:ViewReference(" & drRef("ReferenceID") & ") >" + CStr(drRef("ReferenceFeature")) & "</a></TD></TR>")

        End While

        CommonFunction.Data.DisposeDataReader(drRef)

        If intFlag = 1 Then
            Response.Write("</Table></div>")
        End If


    End Sub


End Class