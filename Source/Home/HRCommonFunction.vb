'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleHR
' Module Name           :  HRCommonfunction
' Purpose               :  This class will include all the public functions and methods used in HRMS
' Description           :  
' Dependencies          :  None
' Author                :  KapilGK
' Reviewed              :  
' Tested                :  
' Created               :  30 Jul 2008
' Revisions             :  
'=====================================================================
Public Class HRCommonfunction
    Public Shared Function PlotHomeLink() As String
        Dim strReturnValue As String = ""
        Dim strFrom_Where As String = ""
        If Not HttpContext.Current.Request.QueryString("From_Where") Is Nothing Then
            strFrom_Where = HttpContext.Current.Request.QueryString("From_Where").ToString().ToUpper()
        ElseIf Not HttpContext.Current.Request.Form("From_Where") Is Nothing Then
            strFrom_Where = HttpContext.Current.Request.Form("From_Where").ToString().ToUpper()
        End If
        'Dim strMenuGroupID As String = ""
        'strMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("MenuGroupID"))
        'strReturnValue = "| <A class='Menu' style='TEXT-DECORATION:NONE' href=""../Home/DetailView.aspx?MenuGroupID=" + strMenuGroupID + "&MasterTagID=2450&FromWhere=PA&FromTree=1""; Title=""Home"" >&nbsp;Home&nbsp;</A> "
        If strFrom_Where = "DETAILVIEW" Then
            Dim strMenuGroupID As String = ""
            If Not HttpContext.Current.Request.QueryString("MenuGroupID") Is Nothing Then
                strMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MenuGroupID"))
            ElseIf Not HttpContext.Current.Request.Form("MenuGroupID") Is Nothing Then
                strMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("MenuGroupID"))
            End If
            'strMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("MenuGroupID"))
            strReturnValue = "| <A class='Menu' style='TEXT-DECORATION:NONE' href=""../Home/DetailView.aspx?MenuGroupID=" + strMenuGroupID + "&MasterTagID=2450&FromWhere=PA&FromTree=1""; Title=""Home"" >&nbsp;Home&nbsp;</A> "
        ElseIf strFrom_Where = "HRHOME" Then
            strReturnValue = "| <A class='Menu' style='TEXT-DECORATION:NONE' href=""../Home/HRHome.aspx?""; Title=""Home"" >&nbsp;Home&nbsp;</A> "
        End If
        PlotHomeLink = strReturnValue
    End Function

    Public Shared Sub PlotHiddenFrom_Where()
        Dim strFrom_Where As String = ""
        If Not HttpContext.Current.Request.QueryString("From_Where") Is Nothing Then
            strFrom_Where = HttpContext.Current.Request.QueryString("From_Where").ToString().ToUpper()
        ElseIf Not HttpContext.Current.Request.Form("From_Where") Is Nothing Then
            strFrom_Where = HttpContext.Current.Request.Form("From_Where").ToString().ToUpper()
        End If
        If strFrom_Where <> "" Then
            CommonFunction.General.WriteHTML("<input type=hidden name='From_Where' id='From_Where' value='" + strFrom_Where + "'>")
            If strFrom_Where = "DETAILVIEW" Then
                Dim strMenuGroupID As String = ""
                If Not HttpContext.Current.Request.QueryString("MenuGroupID") Is Nothing Then
                    strMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MenuGroupID"))
                ElseIf Not HttpContext.Current.Request.Form("MenuGroupID") Is Nothing Then
                    strMenuGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("MenuGroupID"))
                End If
                CommonFunction.General.WriteHTML("<input type=hidden name='MenuGroupID' id='MenuGroupID' value='" + strMenuGroupID + "'>")
            End If
        End If
    End Sub
    Public Shared Function ReplacePlaceHolders(ByVal strInput As String, Optional ByVal HandleSingleQuotes As Boolean = False) As String
        '=====================================================================
        ' Procedure Name        : ReplacePlaceHolders
        ' Purpose               : Replace the Place Holders by actual values
        ' Description           : Same as above
        ' Parameters Passed     : None.
        ' Parameters Affected   : None.
        ' Returns               : String with actual values for the place holders
        ' Assumptions           : None.
        ' Dependencies          : None.
        ' Author                : UmeshJ
        ' Created               : Monday, December 08, 2003 
        ' Revisions             :
        '=====================================================================
        If strInput = "" Then Return ""
        Dim objPlaceHolders() As CommonEngines.HashTables.UIPlaceHolders
        'Get Place holder collection
        objPlaceHolders = CommonEngines.HashTables.GetHashTableObject.GetHashTablePlaceHoldersObject()
        'Sorry ... no object
        If objPlaceHolders Is Nothing Then Return strInput
        Dim intIndex As Integer
        Dim intLastIndex As Integer = objPlaceHolders.Length - 1
        For intIndex = 0 To intLastIndex
            If objPlaceHolders(intIndex).UseSessionVariables = True Then
                If HandleSingleQuotes Then
                    strInput = Microsoft.VisualBasic.Replace(strInput, objPlaceHolders(intIndex).PlaceHolder, CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session(objPlaceHolders(intIndex).SessionVariable))))
                Else
                    strInput = Microsoft.VisualBasic.Replace(strInput, objPlaceHolders(intIndex).PlaceHolder, CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session(objPlaceHolders(intIndex).SessionVariable)))
                End If
            Else
                ' Added Nov 20,2004 Rajanikant Khethawatt R.No. WAF2_PB_69
                If objPlaceHolders(intIndex).VariableType = CommonFunctions.Constants.PLACEHOLDER_VARIABLETYPE_APPLICATION Then
                    If Trim(objPlaceHolders(intIndex).SystemName & "") <> "" Then
                        If HandleSingleQuotes Then
                            strInput = Microsoft.VisualBasic.Replace(strInput, objPlaceHolders(intIndex).PlaceHolder, CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting(objPlaceHolders(intIndex).SystemName))))
                        Else
                            strInput = Microsoft.VisualBasic.Replace(strInput, objPlaceHolders(intIndex).PlaceHolder, CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting(objPlaceHolders(intIndex).SystemName)))
                        End If
                    End If
                End If
                ' End Addition Nov 20,2004 R.No. WAF2_PB_69
            End If
        Next
        'Clean the object from the memory
        objPlaceHolders = Nothing
        Return strInput
    End Function




End Class



