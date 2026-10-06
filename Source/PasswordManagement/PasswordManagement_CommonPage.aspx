<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PasswordManagement_CommonPage.aspx.vb" Inherits="PbNIT.PasswordManagement_CommonPage" %>
<%--/*Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->


    <script>
        //Added by Yogesh Jalamkar on 27-OCT-2016 Purpose: Disable the Textbox while page load
        //if the checkbox is unchecked
        $(document).ready(function () {
            $(":checkbox").each(function () {
                EnableDisableControls(this);
            });
        });

        function EnableDisableControls(objControl) {

            /*Added by Yogesh Jalamkar on 26-OCT-2016 Purpose:Euronet Customization*/
            var ObjControlID = objControl.id;
            var objPassCaptchaCount = GetObjectReference("frmCommonPage", "PassCaptchaCount");
            var objPassLockingCount = GetObjectReference("frmCommonPage", "PassLockingCount");
            var objPassLockoutDuration = GetObjectReference("frmCommonPage", "PassLockoutDuration");
            var objLockUserID = GetObjectReference("frmCommonPage", "EnableLockUserID");
            var objLockoutDuration = GetObjectReference("frmCommonPage", "EnablePassLockoutDuration");
            var objPassLockoutDuration = GetObjectReference("frmCommonPage", "PassLockoutDuration");
            var objMinPassword = GetObjectReference("frmCommonPage", "MiniPwdLength");
            var objMaxPassword = GetObjectReference("frmCommonPage", "MaxPwdLength");
            var objNumOfAlpha = GetObjectReference("frmCommonPage", "NumOfAlpha");
            var objNumOfNumerals = GetObjectReference("frmCommonPage", "NumOfNumerals");
            var objNumOfSpecial = GetObjectReference("frmCommonPage", "NumOfSpecial")
            var ObjEnablePwdLength = GetObjectReference("frmCommonPage", "EnablePwdLength")
            var ObjEnableAlphaNumSpecialChar = GetObjectReference("frmCommonPage", "EnableAlphaNumSpecialChar")

            var objEnableCaptcha = GetObjectReference("frmCommonPage", "EnableCaptcha");

            switch (ObjControlID) {
                case "EnablePwdLength":

                    if (objControl.checked == true) {

                        objMinPassword.disabled = false;
                        objMaxPassword.disabled = false
                        ObjEnableAlphaNumSpecialChar.checked = true
                        objNumOfAlpha.disabled = false;
                        objNumOfNumerals.disabled = false;
                        objNumOfSpecial.disabled = false;
                        //if (objMinPassword != null) {
                        //    objMinPassword.value = 5;
                        //}
                        //if (objMaxPassword != null) {
                        //    objMaxPassword.value = 7;
                        //}
                    }
                    else {
                        objMinPassword.disabled = true;
                        objMaxPassword.disabled = true;
                        ObjEnableAlphaNumSpecialChar.checked = false
                        objNumOfAlpha.disabled = true;
                        objNumOfNumerals.disabled = true;
                        objNumOfSpecial.disabled = true;
                        objNumOfAlpha.value = "";
                        objNumOfNumerals.value = "";
                        objNumOfSpecial.value = "";
                        if (objMinPassword != null) {
                            objMinPassword.value = "";
                        }
                        if (objMaxPassword != null) {
                            objMaxPassword.value = "";
                        }
                    }
                    break;
                case "EnableAlphaNumSpecialChar":
                    ;
                    if (objControl.checked == true) {
                        objNumOfAlpha.disabled = false;
                        objNumOfNumerals.disabled = false;
                        objNumOfSpecial.disabled = false;
                        ObjEnablePwdLength.checked = true
                        objMinPassword.disabled = false;
                        objMaxPassword.disabled = false
                        //if (objMinPassword != null) {
                        //    objMinPassword.value = 5;
                        //}
                        //if (objMaxPassword != null) {
                        //    objMaxPassword.value = 7;
                        //}
                    }
                    else {
                        objNumOfAlpha.disabled = true;
                        objNumOfNumerals.disabled = true;
                        objNumOfSpecial.disabled = true;
                        objNumOfAlpha.value = "";
                        objNumOfNumerals.value = "";
                        objNumOfSpecial.value = "";
                        ObjEnablePwdLength.checked = false
                        objMinPassword.disabled = true;
                        objMaxPassword.disabled = true
                        if (objMinPassword != null) {
                            objMinPassword.value = "";
                        }
                        if (objMaxPassword != null) {
                            objMaxPassword.value = "";
                        }
                    }
                    break;
                case "EnablePassPhrases":
                    var objPassPharsesDays = GetObjectReference("frmCommonPage", "PassPharsesDays");

                    if (objControl.checked == true) {
                        objPassPharsesDays.disabled = false;
                    }
                    else {
                        objPassPharsesDays.disabled = true;
                        objPassPharsesDays.value = "";
                    }
                    break;

                case "EnablePreviousPassCheck":
                    var objPreviousPassCount = GetObjectReference("frmCommonPage", "PreviousPassCount");

                    if (objControl.checked == true) {
                        objPreviousPassCount.disabled = false;
                    }
                    else {
                        objPreviousPassCount.disabled = true;
                        objPreviousPassCount.value = "";
                    }
                    break;
                case "EnablePassLockoutDuration":


                    if (objControl.checked == true) {
                        objPassLockoutDuration.disabled = false;
                        if (objLockUserID != null) {
                            objLockUserID.checked = true;                           
                            objPassLockingCount.disabled = false;
                        }
                    }
                    else {
                        objPassLockoutDuration.disabled = true;
                        objPassLockoutDuration.value = "";
                        if (objLockUserID != null) {
                            objLockUserID.checked = false;                           
                            objPassLockingCount.disabled = true;                           
                            objPassLockingCount.value = "";

                        }
                    }
                    break;

                case "EnableLockUserID":


                    if (objControl.checked == true) {
                       
                        objPassLockingCount.disabled = false;

                        if (objLockoutDuration != null) {
                            objLockoutDuration.checked = true;
                            objPassLockoutDuration.disabled = false;
                            objPassLockingCount.disabled = false;


                        }

                    }
                    else {
                        
                        objPassLockingCount.disabled = true;                        
                        objPassLockingCount.value = "";
                        if (objLockoutDuration != null) {
                            objLockoutDuration.checked = false;
                            objPassLockoutDuration.disabled = true;
                            objPassLockoutDuration.value = "";

                        }
                    }
                    break;
                case "EnableCaptcha":
                    if (objControl.checked == true) {
                        objPassCaptchaCount.disabled = false;
                    }
                    else {
                        objPassCaptchaCount.value = "";
                        objPassCaptchaCount.disabled = true;
                    }
                    break;
            }


        }
        /*End of addition by Yogesh Jalamkar on 26-OCT-2016 Purpose:Euronet Customization*/

        //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose: Disable the Textbox
    </script>