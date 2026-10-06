Public Class clsCommonFunctions

    Public Shared Function PlotPageHeadTag( _
                        Optional ByVal strPageCaption As String = "", _
                        Optional ByVal strCSSPath As String = "", _
                        Optional ByVal strCommonFunctionJSPath As String = "../../General/CommonFunctions.js", _
                        Optional ByVal strCommonValidationsJSPath As String = "../../General/CommonValidations.js", _
                        Optional ByVal strInsertHTML As String = "", Optional ByVal returnHTML As Boolean = False, _
                        Optional ByVal TagID As Long = 0, _
                        Optional ByVal strScrollableJSPath As String = "../../General/ScrollableTable.js" _
                        ) As String
        ' =====================================================================
        ' Procedure Name        :	PlotPageHeadTag
        ' Purpose               :	Plot Header Tag
        ' Description           :	same as above
        ' Parameters Passed     :	Optional strPageCaption - Page Caption, Optional strCSSPath - Stylesheet Path, 
        '                           Optional strCommonFunctionJSPath - CommonFunction JS Path, Optional strCommonValidationsJSPath - CommonValidations JS Path, 
        '                           Optional strInsertHTML - Additonal HTML in Head Tag , Optional returnHTML - return HTML or plot the response
        '                           strScrollableJSPath - path of the JS required for fixing grid headers  
        ' Parameters Affected   :	None
        ' Returns               :	NA
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Vaijat K
        ' Created               :	07/12/2017
        ' Revisions             :   
        '                           
        '=====================================================================

        Dim sbHeadTag As New System.Text.StringBuilder

        Dim htUITagMaster As CommonEngines.HashTables.UITagMaster
        Dim htCSS As CommonEngines.HashTables.AppCss
        Dim lngStyleSheetID As Long = 0
        Dim blnStylesheetSet As Boolean = False

        Dim strImgDirRelPath As String = ""

        sbHeadTag.Append("<HEAD>" + vbCrLf)
        sbHeadTag.Append("<TITLE>" + strPageCaption + "</TITLE>" + vbCrLf)

        sbHeadTag.Append("<meta http-equiv=""Cache-Control"" CONTENT=""no-cache"">" + vbCrLf)
        sbHeadTag.Append("<meta http-equiv=""Pragma"" CONTENT=""no-cache"">" + vbCrLf)

        If Trim(strCSSPath & "") = "" Then
            If TagID <> 0 Then
                If CommonFunctions.General.GetFrameworkSettings("PB_ENABLE_PAGE_STYLESHEET", "Enabled") Then
                    htUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(TagID)
                    lngStyleSheetID = htUITagMaster.StyleSheetID
                    htUITagMaster = Nothing

                    If lngStyleSheetID <> 0 Then
                        ' get the style sheet details
                        htCSS = CommonEngines.HashTables.AppCssImplementation.GetAppCssObject(lngStyleSheetID)
                        If Not htCSS Is Nothing Then
                            ' style sheet is set
                            blnStylesheetSet = True
                            strCSSPath = CommonFunctions.FileDirectory.CleanMapPath(htCSS.StyleSheetRelativePath) + htCSS.StyleSheetName
                            strImgDirRelPath = CommonFunctions.General.CheckIsNothing(htCSS.ImageFolderRelativePath) 'Added By - PushkarK On 29-May-2007 For Requirement ID - WAF3_PB_47
                        End If
                    End If
                End If
            End If
            If blnStylesheetSet = False And CommonFunctions.General.GetFrameworkSettings("GEN_ENABLE_USER_STYLESHEET", "Enabled") Then
                ' yes!its not tag specific..check if user has some style sheet specified 
                If Trim(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("WAF_StyleSheetID"), "") & "") <> "" Then
                    ' set the session value set for style sheet by the user
                    lngStyleSheetID = CType(HttpContext.Current.Session("WAF_StyleSheetID"), Long)
                    ' get the style sheet details
                    htCSS = CommonEngines.HashTables.AppCssImplementation.GetAppCssObject(lngStyleSheetID)
                    If Not htCSS Is Nothing Then
                        ' style sheet is set
                        blnStylesheetSet = True
                        strCSSPath = CommonFunctions.FileDirectory.CleanMapPath(htCSS.StyleSheetRelativePath) + htCSS.StyleSheetName
                        strImgDirRelPath = CommonFunctions.General.CheckIsNothing(htCSS.ImageFolderRelativePath) 'Added By - PushkarK On 29-May-2007 For Requirement ID - WAF3_PB_47
                    End If
                End If
            End If

            If blnStylesheetSet = False Then
                ' set the default style sheet
                htCSS = CommonEngines.HashTables.AppCssImplementation.GetDefaultAppCss()
                If Not htCSS Is Nothing Then
                    strCSSPath = CommonFunctions.FileDirectory.CleanMapPath(htCSS.StyleSheetRelativePath) + htCSS.StyleSheetName
                    strImgDirRelPath = CommonFunctions.General.CheckIsNothing(htCSS.ImageFolderRelativePath) 'Added By - PushkarK On 29-May-2007 For Requirement ID - WAF3_PB_47
                End If
            End If
            htCSS = Nothing
        Else
            strImgDirRelPath = Trim(CommonFunctions.General.CheckIsNothing(strCSSPath))
            Dim intLength As Integer = strImgDirRelPath.Length - 1
            If intLength > 0 Then
                Dim intLastIdx As Integer = strImgDirRelPath.LastIndexOf("_")
                If intLastIdx > 0 AndAlso intLastIdx + 1 <= intLength Then
                    strImgDirRelPath = strImgDirRelPath.Substring(intLastIdx + 1, intLength - intLastIdx)
                    strImgDirRelPath = strImgDirRelPath.Replace(".css", "")
                    'Handle Special Cases
                    If UCase(strImgDirRelPath) = "BURNTSIENNA" Then
                        strImgDirRelPath = "bsImages"
                    ElseIf UCase(strImgDirRelPath) = "GYELLOW" Then
                        strImgDirRelPath = "goldenyellow"
                    End If
                    strImgDirRelPath = "../../../images/" + strImgDirRelPath + "/"
                End If
            End If

        End If

        sbHeadTag.Append("<link rel='stylesheet' type='text/css' href='../" + strCSSPath + "'/>" + vbCrLf)

        If strImgDirRelPath = "" Then strImgDirRelPath = "../../../images/cssImages/"
        sbHeadTag.Append("<link id='lnkWhizStyleSheetImgDir' type='text/plain' href='" + strImgDirRelPath + "'/>" + vbCrLf)

        'JS-CommonFunctions
        sbHeadTag.Append("<script language='javascript' src='" + strCommonFunctionJSPath + "'></script>" + vbCrLf)
        'JS-CommonValidations
        sbHeadTag.Append("<script language='javascript' src='" + strCommonValidationsJSPath + "'></script>" + vbCrLf)
        sbHeadTag.Append("<script src='../../../EnhancementFiles/OnlineFiles/js/jquery/2.1.4/jquery.min.js'></script>" + vbCrLf)
        sbHeadTag.Append("<script language='javascript' > $(document).ajaxStop(function(){ $('.close').attr('title','Close');})</script>" + vbCrLf)

        sbHeadTag.Append("<style>textarea {   resize:none!important;} " & vbCrLf & " .form-control:-ms-input-placeholder {  color: #bbb!important; }</style>")
        sbHeadTag.Append(strInsertHTML)
        sbHeadTag.Append("<link href='../../General/loaderStylesheet.css' rel='stylesheet' />")
        sbHeadTag.Append("</HEAD>" + vbCrLf)
        If returnHTML = False Then
            'Write the Response for Head Tag
            HttpContext.Current.Response.Write(vbCrLf + sbHeadTag.ToString)
        Else
            'Return the Head Tag HTML string
            PlotPageHeadTag = sbHeadTag.ToString
        End If
        'Remove the object from memory
        sbHeadTag = Nothing
    End Function
End Class
