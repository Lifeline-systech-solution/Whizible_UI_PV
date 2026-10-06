<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Whizible.Login1" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- title changed By Madhuri.K on 24-03-2026 -->
    <title>Whizible 27</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />

    <link rel="stylesheet" href="Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- Font Awesome --> 
    <link rel="stylesheet" href="Whizible2.0-new/fontawesome/css/all.css" />
    <!-- Theme style -->
    
    <!-- media_queries -->
    <!--<link rel="stylesheet" href="Whizible2.0-new/dist/css/media_queries.css" />-->
    <link rel="stylesheet" href="Whizible2.0-new/dist/css/login.css?v=3.13" />
    <!-- Whizible Icon changed By Madhuri.K on 24-03-2026 -->
    <link rel="icon" type="image/png" href="Whizible2.0-new/dist/img/Whizible-app-logo.png"/>
    <script src="Whizible2.0-new/dist/js/CommonValidations.js?date=<%=DateTime.Now %>"></script>
  
    <style type="text/css">
        /* Laptops non-retina screens */
        @media screen and (min-device-width: 1281px) and (max-device-width: 1600px) and (-webkit-min-device-pixel-ratio: 1) {

            .Dloginpanel_left .loginform_body {
                padding: 4em 5em !important;
            }

            .log_notificationbox {
                margin: 3em 0 !important;
            }

            .loginform_body {
                padding: 4em !important;
            }

            .logheaderlogo img {
                width: 130px;
            }
        }
        /*Added By Dipali V On 27th march 2020 For Logo issue*/

        .customerlogo {
            max-width: 41.66%;
        }
        /*End of Added By Dipali V On 27th march 2020 For Logo issue*/

         .btn-check:checked+.btn, .btn.active, .btn.show, .btn:first-child:active, :not(.btn-check)+.btn:active, .btn:focus-visible{color:#FFF;background-color: #fbb03b;}
        /* Added CSS by Madhuri.k for carousel-indicators */
        .carousel-indicators li {
            list-style-type: none;
        }
 b, strong {
    font-weight: bold;
}    
 .btn-check:checked+.btn, .btn.active, .btn.show, .btn:first-child:active, :not(.btn-check)+.btn:active, .btn:focus-visible{color:#FFF;background-color: #fbb03b;}
    </style>
</head>
<body class="fixed" onload="window_onload()">
    <form id="frmLogin1" action="Source/General/Navigation.aspx" method="post" autocomplete="off">
        <div class="wrapper logginwrap" id="maindiv" style="display: none;">

            <div class="row row-eq-height">
                <div class="col-sm-7 Dloginpanel_left">
                    <div class="Dloginpanel_leftbg">&nbsp;</div>
                    <div class="loginform_body">
                        <div class="loginboxleft">
                            <div class="logheaderlogo">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <a href="#">
                                            <img width="200px" src="Whizible2.0-new/dist/img/Whizible-white.png" alt="whizible" title="whizible"></a>
                                    </div>
                                </div>
                            </div>
                            <div class="log_notificationbox">
                                <h5>Notifications / Alerts</h5>
                                <%--  <div id="myCarousel">
                                  
                                </div>--%>
                                <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
                                    <!-- Indicators -->
                                    <ol id="defaultNotificationsList" class="carousel-indicators">
                                        <li data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></li>
                                        <li data-bs-target="#myCarousel" data-bs-slide-to="1"></li>
                                        <li data-bs-target="#myCarousel" data-bs-slide-to="2"></li>
                                    </ol>

                                    <!-- Wrapper for slides -->
                                    <div class="carousel-inner slim-scroll" id="defaultNotifications">
                                        <div class="carousel-item active">
                                            <p><strong>Manage your operations and collaborations in an integrated and visible environment</strong></p>
                                            <p>The information framework that powers the Services Business.The key to success in the services business is a seamless and integrated execution model. A model that enables improved decision making and proactive performance management at all levels through real time visibility into project performance.</p>
                                        </div>

                                        <div class="carousel-item">
                                            <p><strong>PROJECT MANAGEMENT</strong></p>
                                            <p>Managing Projects successfully and profitably is at the core of your organization’s success. You need to plan for success and then manage all aspects of execution until completion of the project.</p>
                                        </div>

                                        <div class="carousel-item">
                                            <p><strong>E-DASHBOARDS</strong></p>
                                            <p>Whizible Execution allows you to see further and closer than ever before. Need the broad picture on the status of the various projects or the effort variance of an individual project? With the eDashboards,you can view the information that you need to the required level of detail.</p>
                                        </div>
                                    </div>

                                   
                                     <button class="left carousel-control-arrow carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                  </button>
                                  <button class="right carousel-control-arrow carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                  </button>


                                </div>

                            </div>

                            <p class="logcontact">
                                <span><a id="Mobiledetails" href="tel:+91 20 65003314">+91 20 65003314</a></span>
                                <span><a id="MailDetails" href="mailto:example@tutorialspark.com">support@whizible.com </a></span>
                                <span><a id="SiteDetails" href="https://pm.whizible.com/">www.pm.whizible.com</a></span>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-sm-5 Dloginpanel_right">
                    <div class="customerlogo">
                    <%--    <img src="Whizible2.0-new/dist/img/customerlogo1.png" alt="" title=""></div>--%>
                        <%If strCompanyLogo <> "" Then%>
                        <a class="navbar-brand img2" href="#"><img src="Images/<%= strCompanyLogo%>" class="img-responsive" style="height: 52px;"></a>
                       <%-- <%Else %>
                        <a class="navbar-brand img2" href="#"><img src="Images/<%= strCompanyLogo%>" class="img-responsive" style="height: 52px;"></a>--%>
                       <%End If%>
                   </div>
                        <div class="loginform_body">
                        <div class="loginboxright">
                            <!--login form start - added by PRADIP-->
                            <div id="loginformboxformD">
                                <div class="loginheader">
                                    <h2>Sign in</h2>

                                </div>
                                <div class="loginform">

                                    <div class="form-group mb-3">
                                        <label class="control-label">User ID :</label>
                                        <input type="text" class="form-control" placeholder="User ID" id="txtLogin" name="txtLogin" onblur='ValidateUserName()' onkeyup="ClearSpan('txtLogin','SpanEmailID')" autofocus oncopy="return false" oncut="return false" onpaste="return false"  autocomplete="off"/>
                                        <span style="color: #dd1037; font-size: 12px;" id="SpanEmailID"></span>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label class="control-label">Password :</label>
                                        <input type="password" class="form-control" placeholder="Password" id="txtPassword" name="txtPassword" onkeypress='Password_OnKeyPress(event)' onkeyup="ClearSpan('txtPassword','SpanPassword')" onkeypress="Password_OnKeyPress(event)" oncopy="return false" oncut="return false" onpaste="return false" autocomplete="off" />
                                        <%If m_blnIsWindowsAuthenticated = False Then%>
                                        <input id="ChangeUser" name="ChangeUser" type="hidden" size="5000" value="<%=m_strChangeUser%>" />
                                        <%End If%>
                                        <input id="txtPasswordHide" name="txtPasswordHide" type="hidden" size="5000" runat="server" />
                                        <input id="Hidden1" name="mobileResponsive" type="hidden" size="5000" runat="server" />

                                        <input id="txtEncryptedUserName" type="hidden" size="5000" name="txtEncryptedUserName" />
                                        <input id="txtEncryptedUserNameLength" type="hidden" size="5000" name="txtEncryptedUserNameLength" />


                                        <input type="hidden" name="NonDataBase3" id="NonDatabase3" />
                                        <span style="color: #dd1037; font-size: 12px;" id="SpanPassword"></span>
                                        <div class="clearfix"></div>
                                    </div>

                                    <% If m_blnEnableCaptcha = True Then%>

                                    <% If (Session("time") > m_intPassCaptchCount - 1) Then%>
                                    <div id="divCaptcha" class="form-group" align="left">
                                        <table style="width: 100%">
                                            <tr>
                                                <td class="auto-style1" style="width: 91%">
                                                    <img id="imgCaptcha" height="33" width="100%" />
                                                    <%--src="Handler.ashx"--%>
                                                </td>
                                                <td align="left">
                                                    <img id="Img1" src="Images/RefreshButton.jpg" style="background-color: #3c8dbc; cursor: pointer;" onclick='javascript: RefreshCaptcha();' alt="" title="Refresh for new captcha" align="left" height="33" />
                                                    <input type="hidden" id="hdCaptcha" value="<%= strCaptcha%>" />
                                                </td>
                                            </tr>
                                            <tr style='height: 6px;'></tr>
                                            <tr>
                                                <td class="auto-style1" colspan="2">
                                                    <input name="txtInput" type="text" id="txtInput" class="form-control" oncopy="return false" ondrag="return false" ondrop="return false" onpaste="return false" onkeyup="ClearSpan('txtInput','SpanInput')" placeholder="Captcha" />
                                                    <span style="color: #dd1037; font-size: 12px;" id="SpanInput"></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <% End If%>
                                    <% End If%>

                                    <div class="form-group">
                                        <div class="">
                                            <a onclick="myFunction1()" class="forgotpass float-start" href="javascript:;">Forgot Password?</a>
                                            <a onclick="myFunction3()" class="forgotpass ml-1 float-end" href="javascript:;" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="">Change Password?</a>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <button type="button" class="btn loginbtn" onclick="login()">Sign In</button>
                                    </div>
                                    <label id="lblLoginError" style="color: red; font-weight: normal; width: 100%; text-align: center"></label>
                                </div>
                            </div>
                            <!--login form end - added by PRADIP-->
                            <!--Enter User ID and Password to sign in-->
                            <!--forgot password form start - added by PRADIP-->
                            <div id="forgotpassformD" style="display: none;">
                                <div class="loginheader">
                                    <h2>Forgot Password</h2>
                                </div>
                                <div class="loginform">
                                    <div class="form-group mb-3">
                                        <label class="control-label">User ID:</label>
                                        <input id="txtFUserID" name="txtFUserID" type="text" class="form-control" placeholder="User ID" onkeyup="ClearSpan('txtFUserID','SpanFUserID')" autofocus oncopy="return false" oncut="return false" onpaste="return false" />
                                        <span style="color: #dd1037; font-size: 12px;" id="SpanFUserID"></span>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="control-label">Email ID :</label>
                                        <input type="text" class="form-control" placeholder="Email ID" id="txtEmailID" name="txtEmailID" onblur='ValidateUserName()' onkeyup="ClearSpan('txtEmailID','SpanFEmailID')" autofocus oncopy="return false" oncut="return false" onpaste="return false" />
                                        <span style="color: #dd1037; font-size: 12px;" id="SpanFEmailID"></span>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <button type="button" class="btn loginbtn" onclick="ForgotPassword()">Reset</button>
                                        <button onclick="myFunction2()" type="button" class="btn loginbtn">Cancel</button>
                                    </div>
                                </div>
                            </div>
                            <!--forgot password form end - added by PRADIP-->

                            <!--change password form start - added by PRADIP-->
                            <div id="changepassformD" style="display: none;">

                                <div class="loginheader">
                                    <h2>Change Password</h2>
                                </div>
                                <div class="loginform">

                                    <div class="form-group mb-3">
                                        <label class="control-label">User ID :</label>
                                        <input id="txtLoginName" name="txtLoginName" type="text" class="form-control" placeholder="User ID" onkeyup="ClearSpan('txtLoginName','SpanUserID')" autofocus oncopy="return false" oncut="return false" onpaste="return false" />
                                        <span style="color: #dd1037; font-size: 12px;" id="SpanUserID"></span>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label class="control-label">Old Password :</label>
                                        <input id="txtOldPassword" name="txtOldPassword" type="password" class="form-control" placeholder="Old Password" onkeyup="ClearSpan('txtOldPassword','SpanCPassword')" oncopy="return false" oncut="return false" onpaste="return false" />
                                        <span style="color: #dd1037; font-size: 12px;" id="SpanCPassword"></span>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label class="control-label">New Password :</label>
                                        <input id="txtNewPassword" name="txtNewPassword" type="password" class="form-control" placeholder="New Password" onkeyup="ClearSpan('txtNewPassword','SpanNewPassword')" oncopy="return false" oncut="return false" onpaste="return false" />
                                        <span style="color: #dd1037; font-size: 12px;" id="SpanNewPassword"></span>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label class="control-label">Confirm Password :</label>
                                        <input id="txtConfirmPassword" name="txtConfirmPassword" type="password" class="form-control" placeholder="Confirm Password" onkeyup="ClearSpan('txtConfirmPassword','SpanConfirmPassword')" oncopy="return false" oncut="return false" onpaste="return false" />
                                        <span style="color: #dd1037; font-size: 12px;" id="SpanConfirmPassword"></span>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <button type="button" onclick="ChangePassword()" class="btn loginbtn">Change Password</button>
                                        <br />
                                        <button id="btnChangePwdCancel" onclick="myFunction2()" type="button" class="btn loginbtn">Cancel</button>
                                    </div>

                                </div>
                            </div>
                            <!--change password form end added by PRADIP-->

                        </div>

                    </div>
                </div>

            </div>

            <div class="clearfix"></div>
            <input type="hidden" name="hdnToken" id="hdnToken" />
            <input type="hidden" name="hdnRandom" id="Random" value="<%=Session("RandomNumber")%>" />
        </div>
        <div class="wrapper logginwrap" id="divMobileLogin" style="display: none;">
            <div class="logginwrap_inner">&nbsp;</div>
            <div class="col-xs-12 col-sm-12">
                <div class="loginform_panel">

                    <div class="loginheader">
                        <div class="logo">
                            <a href="javascript:;"><img width="230px" src="Whizible2.0-new/dist/img/Whizible-white.png" alt="whizible" title="whizible" /></a>
                        </div>
                    </div>
                    <div class="loginform">
                        <div id="loginformboxformM" class="loginformbox">
                            <div class="loginform_body">
                                <div class="input-effect">
                                    <input class="effect-16" type="text" placeholder="" id="txtLoginMobile" name="txtLoginMobile" onkeyup="ClearSpan('txtLoginMobile','SpanEmailIDMobile')" autocomplete="off" onblur="ValidateUserName();" autofocus oncopy="return false" oncut="return false" onpaste="return false"  />
                                    <label>User ID</label>
                                    <%--<span ></span>--%>
                                    <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanEmailIDMobile"></span>
                                </div>

                                <div class="input-effect">
                                    <input id="txtPasswordMobile" name="txtPasswordMobile" onkeyup="ClearSpan('txtPasswordMobile','SpanPasswordMobile')" class="effect-16" type="password" placeholder="" autocomplete="off" onkeypress="PasswordM_OnKeyPress(event)" oncopy="return false" oncut="return false" onpaste="return false" />
                                    <label>Password</label>

                                    <%If m_blnIsWindowsAuthenticated = False Then%>
                                    <input id="ChangeUserMobile" name="ChangeUserMobile" type="hidden" size="5000" value="<%=m_strChangeUser%>" />
                                    <%End If%>
                                    <input id="txtPasswordHideMobile" name="txtPasswordHideMobile" type="hidden" size="5000" />
                                    <input id="mobileResponsive" name="mobileResponsive" type="hidden" size="5000" />

                                    <input id="txtEncryptedUserNameMobile" type="hidden" size="5000" name="txtEncryptedUserNameMobile" />
                                    <input id="txtEncryptedUserNameLengthMobile" type="hidden" size="5000" name="txtEncryptedUserNameLengthMobile" />


                                    <input type="hidden" name="NonDatabase3Mobile" id="NonDatabase3Mobile" />
                                    <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanPasswordMobile"></span>
                                </div>

                                <% If m_blnEnableCaptcha = True Then%>

                                <% If (Session("time") > m_intPassCaptchCount - 1) Then%>
                                <div id="divCaptchaMobile" class="input-effect" align="left">
                                    <table style="width: 100%">
                                        <tr>
                                            <td class="auto-style1" style="width: 91%">
                                                <img id="imgCaptchaMobile" height="33" width="100%" />
                                                <%--src="Handler.ashx"--%>
                                            </td>
                                            <td align="left">
                                                <img id="Img1Mobile" src="Images/RefreshButton.jpg" style="background-color: #3c8dbc; cursor: pointer;" onclick='javascript: RefreshCaptcha();' alt="" title="Refresh for new captcha" align="left" height="33" />
                                                <input type="hidden" id="hdCaptchaMobile" value="<%= strCaptcha%>" />
                                            </td>
                                        </tr>
                                        <tr style='height: 6px;'></tr>
                                        <tr>
                                            <td class="auto-style1" colspan="2">
                                                <input name="txtInputM" type="text" id="txtInputMobile" class="effect-16" oncopy="return false" ondrag="return false" ondrop="return false" onpaste="return false" onkeyup="ClearSpan('txtInputMobile','SpanInputMobile')" placeholder="" />
                                                <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanInputMobile"></span>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <% End If%>
                                <% End If%>
                                <button type="button" class="btn loginbtn" onclick="login_Mobile()">LOGIN</button>
                                <%If strShowPasswordLinks = True Then%>
                                <p class="mb-0">

                                    <a onclick="myFunction1()" class="forgotpass" href="javascript:;" data-bs-toggle="tooltip" data-bs-placement="bottom" data-title="Click here to Forgot Password">Forgot Password</a>


                                    <a onclick="myFunction3()" class="forgotpass ml-1" href="javascript:;" data-bs-toggle="tooltip" data-bs-placement="bottom" data-title="Click here to Change Password">Change Password</a>

                                </p>
                                <%   End If%>
                                <label id="lblLoginErrorMobile" style="color: red; font-weight: normal; width: 100%; text-align: center;"></label>

                            </div>
                        </div>

                        <div id="forgotpassformM" class="loginformbox" style="display: none">
                            <div class="loginform_body">
                                <h4>Forgot Password</h4>
                                <div class="input-effect">
                                    <%-- Added By Dipali V On 26th Feb 2019 For Remove Validation msg--%>
                                    <%--                              <input class="effect-16" type="text" id="txtFUserIDMobile" name="txtFUserIDMobile" placeholder="" />--%>
                                    <input class="effect-16" type="text" id="txtFUserIDMobile" name="txtFUserIDMobile" placeholder="" onkeyup="ClearSpan('txtFUserIDMobile','SpanFUserIDMobile')" />
                                    <%-- End of Added By Dipali V On 26th Feb 2019 For Remove Validation msg--%>
                                    <label>User ID</label>

                                    <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanFUserIDMobile"></span>
                                </div>
                                <div class="input-effect">

                                    <input type="text" class="effect-16" placeholder="" id="txtEmailIDMobile" name="txtEmailIDMobile" onkeyup="ClearSpan('txtEmailIDMobile','SpanFEmailIDMobile')" />
                                    <label>Email ID</label>
                                    <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanFEmailIDMobile"></span>

                                </div>
                                <button type="button" onclick="ForgotPasswordMobile()" class="btn loginbtn">Reset</button>
                                <button onclick="myFunction2()" type="button" class="btn loginbtn">Cancel</button>


                            </div>
                        </div>


                        <div id="changepassformM" class="loginformbox" style="display: none">
                            <div class="loginform_body">
                                <h4>Change Password</h4>
                                <div class="input-effect">
                                    <input class="effect-16" id="txtLoginNameMobile" name="txtLoginNameMobile" onkeyup="ClearSpan('txtLoginNameMobile','SpanUserIDMobile')" type="text" placeholder="">
                                    <label>Login Name</label>

                                    <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanUserIDMobile"></span>
                                </div>
                                <div class="input-effect">
                                    <input class="effect-16" id="txtOldPasswordMobile" name="txtOldPasswordMobile" onkeyup="ClearSpan('txtOldPasswordMobile','SpanCPasswordMobile')" type="password" placeholder="" />
                                    <label>Old Password</label>
                                    <%-- <span class="focus-border"></span>--%>
                                    <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanCPasswordMobile"></span>
                                </div>

                                <div class="input-effect">
                                    <input id="txtNewPasswordMobile" name="txtNewPasswordMobile" class="effect-16" type="password" onkeyup="ClearSpan('txtNewPasswordMobile','SpanNewPasswordMobile')" placeholder="" />
                                    <label>New Password</label>
                                    <%-- <span class="focus-border"></span>--%>
                                    <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanNewPasswordMobile"></span>
                                </div>

                                <div class="input-effect">
                                    <input id="txtConfirmPasswordMobile" name="txtConfirmPasswordMobile" class="effect-16" type="password" onkeyup="ClearSpan('txtConfirmPasswordMobile','SpanConfirmPasswordMobile')" placeholder="" />
                                    <label>Confirm Password</label>
                                    <%--  <span class="focus-border"></span>--%>
                                    <span class="alert-danger" style="color: #dd1037; font-size: 12px;" id="SpanConfirmPasswordMobile"></span>
                                </div>

                                <button type="button" class="btn loginbtn" onclick="ChangePasswordMobile()">Change Password</button><br />
                                <button onclick="myFunction2()" id="btnChangePwdCancelMobile" type="button" class="btn loginbtn">Cancel</button>

                            </div>
                        </div>

                        <%--  <label id="lblLoginErrorMobile" style="color: red; font-weight: normal; width: 100%; text-align: center"></label>--%>
                    </div>

                    <div class="lginform_fooer">
                        <h4>Notifications / Alerts</h4>
                        <div id="defaultNotificationsMobile">
                            <p><strong>Lorem Ipsum is simply dummy text typesetting industry.</strong></p>
                            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer.</p>
                            <p class="foot_contctno">
                                <span><a href="#">+91 2065003314</a></span>
                                <span><a href="mailto:support@whizible.com">support@whizible.com</a></span>
                                <span><a href="https://pm.whizible.com/">www.pm.whizible.com</a></span>
                            </p>
                        </div>
                    </div>
                   
                </div>
            </div>



        </div>
        <!-- ./wrapper -->
    </form>
    <!-- REQUIRED JS SCRIPTS -->
    <%--Commented and Added By Vishal Mane on 07/07/2025 for SAML SSO Integration--%>
     
<%--<script src="Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="Source/General/CommonFunctions.js"></script>
    <script src="Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="Whizible2.0-new/plugins/slimScroll/jquery.slimscroll.min.js"></script>
--%>
    <script src="<%= ResolveUrl("~/Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js") %>"></script>
    <script src="<%= ResolveUrl("~/Source/General/CommonFunctions.js") %>"></script>
    <script src="<%= ResolveUrl("~/Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js") %>"></script>
    <script src="<%= ResolveUrl("~/Whizible2.0-new/plugins/slimScroll/jquery.slimscroll.min.js") %>"></script>

    <%--End of Commented and Added By Vishal Mane on 07/07/2025 for SAML SSO Integration--%>



     <script
    type="text/javascript"
    src="Whizible2.0-new/AzureAD/msal-browserv2.13.1.js"
    integrity=""
    crossorigin="anonymous"></script>
    <script>

        $('.slim-scroll').slimScroll({
            position: 'right',
            height: '142px',
            railVisible: false,
            alwaysVisible: false
        });
        //Code Added for ADFS integration 
        var strAPIUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("IntegrationAPIUrl").ToString%>';
        var allowADFSRedirection = '<%=System.Configuration.ConfigurationManager.AppSettings("AllowADFSRedirection").ToString%>';
        var Identity = '<%=CommonFunctions.General.CheckIsNothing(Request.QueryString("T"), "")%>';
        var Message = '<%=CommonFunctions.General.CheckIsNothing(Request.QueryString("Message"), "")%>';
        if (allowADFSRedirection == '1') {
            
            $(document).ready(function () {
                //debugger
                if (Identity == "" && Message == "") {
                  
                    $.ajax({
                        type: "GET",
                        url: strAPIUrl + "Auth/Login",
                        dataType: "json",
                        contentType: "application/json",

                        success: function (data) {

                            // window.location.href = "Source/General/Navigation.aspx?T=" + a + ""
                        },
                        error: function (xhr, status, error) {


                            window.location.href = xhr.responseText;
                        }
                    });
                }
                else if (Message != "") {

                }
                else {

                    window.location.href = "Source/General/Navigation.aspx?T=" + Identity
                }
            })
        }

        //End Of Code Added For ADFS Integartion
        //Added By Nikhi Adkar on 27-Sep-2023 for AzureAD
        //Code Added for AD integration  by SajiU 19-Sep-23
        <%--Added By Nikhil Adkar on 26-Dec-2025 for W26 VAPT : Exposure of Sensitive Credentials in Client-Side Source Code --%>
        var AzureAD = '<%=System.Configuration.ConfigurationManager.AppSettings("AzureAD").ToString%>';
        var IdentityAD = '<%=CommonFunctions.General.CheckIsNothing(Request.QueryString("#code"), "")%>';
        var ActulUserName = "";
        if (AzureAD == '1' && Message == "") {
            var clientId = '<%= System.Configuration.ConfigurationManager.AppSettings("ClientID") %>';
            var authority = '<%= System.Configuration.ConfigurationManager.AppSettings("Authority") %>';
            const msalConfig = {
                auth: {
                    clientId: clientId,
                    authority: authority,
                    redirectUri: window.location.origin + window.location.pathname
                },
                cache: {
                    cacheLocation: "sessionStorage",
                    storeAuthStateInCookie: false
                }
            };
            const msalInstance = new msal.PublicClientApplication(msalConfig);
            msalInstance.handleRedirectPromise()
                .then(function (response) {
                    if (response && response.account) {
                        onLoginSuccess(response.account);
                    }
                    else {
                        const accounts = msalInstance.getAllAccounts();
                        if (accounts.length > 0) {
                            onLoginSuccess(accounts[0]);
                        }
                        else {
                            msalInstance.loginRedirect({
                                scopes: ["User.Read"]
                            });
                        }
                    }
                })
                .catch(function (error) {
                    console.error("SSO Error:", error);
                });
     <%--End of Added By Nikhil Adkar on 26-Dec-2025 for W26 VAPT : Exposure of Sensitive Credentials in Client-Side Source Code --%>

          <%--Commented By Nikhil Adkar on 26-Dec-2025 for W26 VAPT : Exposure of Sensitive Credentials in Client-Side Source Code--%>
           <%-- var ClientID = '<%=System.Configuration.ConfigurationManager.AppSettings("ClientID").ToString%>';
            var authority = '<%=System.Configuration.ConfigurationManager.AppSettings("authority").ToString%>';
            var clientSecret = '<%=System.Configuration.ConfigurationManager.AppSettings("clientSecret").ToString%>';
            if (IdentityAD == "" && Message == "") {

                const msalconfig = {
                    auth: {
                        clientId: ClientID,
                        authority: authority,
                        clientSecret: clientSecret
                    },
                    cache: {
                        cahelocation: "sessionStorage",
                        storeAuthStateInCooki: false

                    }
                }

                const MSALobj = new msal.PublicClientApplication(msalconfig);
                let usename = ""

                const loginScope = {
                    scope: ["User.Read"]
                }
                MSALobj.loginRedirect(loginScope);
                MSALobj.handleRedirectPromise().then((response) => {
                    if (response != null) {

                        username = response.account.username;

                        ActulUserName = username;
                        if (ActulUserName != "") {
                            AuthenticationAjax(ActulUserName, ActulUserName);
                            ActulUserName = encryptString(ActulUserName);
				
                            window.location.href = "Source/General/Navigation.aspx?AD=" + ActulUserName

                        }



                        //alert(User.Identity.IsAuthenticated);
                    }
                    selectAccount();
                }).catch((error) => { console.error(error) });


                function selectAccount() {

                    const accounts = MSALobj.getAllAccounts();
                    if (accounts.length === 0) {
                        return;
                    }
                    else if (accounts.length > 1) {
                        console.warn("Multiple Accounts")
                    } else if (accounts.length === 1) {
                        username = accounts[0].username;
                        //AuthenticationAjax(ActulUserName, ActulUserName);
                        //window.location.href = "Source/General/Navigation.aspx?AD=" + ActulUserName
                        // document.getElementById("userClaim").innerHTML = + ActulUserName;


                    }

                }

            }
            else if (Message != "") {
                //alert(Message);
                //const logoutReq = {
                //    account: MSALobj.getAccountByUsername(Message)
                //}
                //MSALobj.loginRedirect(logoutReq);
                sessionStorage.clear();
            }
            --%>
            <%--Commented By Nikhil Adkar on 26-Dec-2025 for W26 VAPT : Exposure of Sensitive Credentials in Client-Side Source Code--%>


        } //Main 

        function onLoginSuccess(account) {
            fetch("SSOHandler.aspx", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    email: account.username,
                    name: account.name
                })
            })
            .then(() => {
                AuthenticationAjax(account.username, account.username);
                window.location.href =
                    "Source/General/Navigation.aspx?AD=" +
                    encryptString(account.username);
            })
            .catch(err => {
                console.error("SSO redirect error:", err);
            });
        }

        //Added By Vishal Mane on 07/07/2025 for SAML SSO Integration
        var ActulUserName = "";
        var saml = '<%=CommonFunctions.General.CheckIsNothing(Request.QueryString("saml"), "")%>';
        var SamlEmailID = '<%=CommonFunctions.General.CheckIsNothing(Request.QueryString("email"), "")%>';
        if (saml == "1") {
            $(document).ready(function () {
                //debugger
                ActulUserName = SamlEmailID;
                if (ActulUserName != "") {                    
                    AuthenticationAjax(ActulUserName, ActulUserName);
                    ActulUserName = encryptString(ActulUserName);
                    //var url = "Source/General/Navigation.aspx?SAML=" + encodeURIComponent(ActulUserName);
                    //location.href = url;
                    var url = '<%= ResolveUrl("~/Source/General/Navigation.aspx") %>?SAML=' + encodeURIComponent(ActulUserName);
                    window.location.href = url;
                }
            })
        }
        function encryptString(value) {
            var intStrArr;
            intStrArr = [];
            var strEncryptedString = "";
            var intEncryptNum = 1;
            var i;
            if (String(value).length > 0) {
                for (i = 0; i <= value.length - 1; i++) {
                    intStrArr[i] = String(String(String(value[i])).charCodeAt(0) + intEncryptNum);
                    intEncryptNum = intEncryptNum + 2;
                }
                strEncryptedString = intStrArr.join("-");
                if (String(strEncryptedString).substring(0, 1) == "-") {
                    strEncryptedString = String(strEncryptedString).substring(1, String(strEncryptedString).length - 1)
                }
            }
            return strEncryptedString;
        }
        //End of Added By Vishal Mane on 07/07/2025 for SAML SSO Integration

        function AuthenticationAjax(userName, password) {
           
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $.ajax({
                url: strUrl + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {

                    console.log(data);
                    sessionStorage.setItem("access_token", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    //alert(err.responseText);
                    //console.log(err);
                }
            })

            var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';

            $.ajax({
                url: strUrl_new + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);

                    sessionStorage.setItem("access_token-I", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);
                    //alert(err.responseText);
                }
            })
            var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Dashboard").ToString%>';

            $.ajax({
                url: strUrl_new + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);

                    sessionStorage.setItem("access_token_Dashboard", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);

                }
            })
            var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Helpdesk").ToString%>';

            $.ajax({
                url: strUrl_new + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);

                    sessionStorage.setItem("access_token-Helpdesk", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);

                }
            })
            var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>';
            $.ajax({
                url: strUrl_new + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);

                    sessionStorage.setItem("access_token_Issue", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);

                }
            })
            var strUrl_Cust = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
            //For Invoice
            $.ajax({
                url: strUrl_Cust + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {

                    console.log(data);
                    //alert(data.access_token);
                    sessionStorage.setItem("access_token_project", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    //alert(err.responseText);
                    //console.log(err);
                }
            })
            var strUrl_Resource = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Resource").ToString%>';
            $.ajax({
                url: strUrl_Resource + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    sessionStorage.setItem("access_token_resource", data.access_token);

                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);
                }
            })
            //Added By Dipali V On 29th Oct  2024 For VAPT Changes
            var strUrl_Configuration = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
            $.ajax({
                url: strUrl_Configuration + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);
                    sessionStorage.setItem("access_token_Configuration", data.access_token);

                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);
                }
            })
                 //End of Added By Dipali V On 29th Oct  2024 For VAPT Changes
            var strUrl_Invoice = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
            $.ajax({
                url: strUrl_Invoice + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);
                    sessionStorage.setItem("access_token_invoice", data.access_token);

                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);
                }
            })
            var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Timesheet").ToString%>';
            $.ajax({
                url: strUrl_new + '/token',
                type: "POST",
                //Added and Commented by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                //data: { username: "", password: "", grant_type: "password" },
                data: { username: userName, password: "", grant_type: "password" },
                //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);
                    sessionStorage.setItem("access_token-Timesheet", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);

                }
            })

            //Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
            //debugger
            var strUrl_W26API = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
            $.ajax({
                url: strUrl_W26API + 'api/auth/token',
                type: "POST",
                data: { username: userName, password: userName, grant_type: "AzureAD" },
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);
                    sessionStorage.setItem("access_token_W26API", data.access_token);
                },
                error: function (err) {
                    console.log(err);
                }
            })
            //End of Added by Vishal Mane on 28/05/2026 for W26API token generation for Azure/SAML case
            
            //Added by Madhuri.K for Token Authentication of Dashboard Service on 17/08/2026
            var strUrl_Dashboard = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
            $.ajax({
                url: strUrl_Dashboard + 'api/auth/token',
                type: "POST",
                data: { username: userName, password: userName, grant_type: "AzureAD" },
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);
                    sessionStorage.setItem("access_token_W27_Dashboard", data.access_token);
                },
                error: function (err) {
                    console.log(err);
                }
            })
            //End of Added by Madhuri.K for Token Authentication of Dashboard Service on 17/08/2026
        }
        //End Of Added By Nikhil Adkar
        //tooltip
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();
        });

        var objfrm;
        objfrm = GetFormReference('frmLogin1');
        var IsLoginCalled = false;
        var objtxtpassword, sResponseText;
        var objtxtlogin;
        objtxtpassword = GetObjectReference('frmLogin', 'txtPassword')
        objtxtlogin = GetObjectReference('frmLogin', 'txtLogin')
        $(document).ready(function () {
            //Added By Dipali V On 27th Aug 2020 For Reset password
            <%If ResetPwd = "1" Then%>
            document.getElementById("lblLoginError").innerHTML = "Reset Password Successfully";
               <%End If%>
            //End of Added By  Dipali V On 27th Aug 2020 For Reset password
            //$.ajax({
            //    type: "GET",
            //    url: "DefaultNotifications.xml",
            //    dataType: "xml",
            //    async: false,
            //    success: function (xml) {

            //        var intCounter = 1;
            //        var strClass = 'in active'
            //        var strClass1 = "active"
            //        var intCounter1 = 0;
            //        $("#defaultNotifications").html("");
            //        $("#defaultNotificationsMobile").html("");
            //        $("#defaultNotificationsList").html("");
            //        $(xml).find('Notification').each(function () {
            //            if (intCounter != 1) {
            //                strClass = "";
            //                strClass1 = "";
            //            }

            //            $("#defaultNotificationsList").append('<li data-bs-target="#myCarousel" class="' + strClass1 + '" data-bs-slide-to="' + intCounter1 + '">')


            //            var sNotification = $(this).text();

            //            $("#defaultNotifications").append(' <div class="carousel-item ' + strClass1 + '"><p class="text_cars">' + sNotification + '</p></div>');



            //            $("#defaultNotificationsMobile").html("<p>" + sNotification + "</p>")
            //            intCounter += 1;
            //            intCounter1 += 1;
            //        });
            //        var mobileDetails;
            //        var mailDetails;
            //        var siteDetails;

            //        mobileDetails = $(xml).find('Mobiledetails').text();
            //        mailDetails = $(xml).find('MailDetails').text();
            //        siteDetails = $(xml).find('SiteDetails').text();
            //        $("#Mobiledetails").append(mobileDetails);
            //        $("#MailDetails").append(mailDetails);
            //        $("#SiteDetails").append(siteDetails);

            //        var strHTML = "";
            //        strHTML += "<p class='foot_contctno'><span><a href='#'>" + mobileDetails + "</a></span>";
            //        strHTML += " <span><a href='" + mailDetails + "'>" + mailDetails + "</a></span>";
            //        strHTML += "<span><a href='" + siteDetails + "'>" + siteDetails + "</a></span></p>";
            //        $("#defaultNotificationsMobile").append(strHTML);
            //    },
            //    error: function () {
            //        alert("An error occurred while processing XML file.");
            //    }
            //});
        });

        /*jQuery(window).load(function () {*/
        $(window).on("load", function () {

            document.getElementById("maindiv").style.display = "block";
            if ($(window).width() < 1024) {
                $("#maindiv").css('display', 'none');
                $("#divMobileLogin").css('display', 'block');
                document.getElementById("mobileResponsive").value = "Mobile";
            }
            else {
                $("#divMobileLogin").css('display', 'none');
                $("#maindiv").css('display', 'block');
            }
        });

        /*$(window).resize(function () {*/
        $(window).on("resize", function () {
            var objfrm = document.getElementById("frmLogin1");
            if ($(window).width() < 1024) {
                $("#maindiv").css('display', 'none');
                $("#divMobileLogin").css('display', 'block');
                document.getElementById("mobileResponsive").value = "Mobile";
            }
            else {
                $("#divMobileLogin").css('display', 'none');
                $("#maindiv").css('display', 'block');
            }
        });

        function window_onload() {
            //debugger;
            var objfrm = document.getElementById("frmLogin1");
            //document.getElementById("maindiv").style.height = window.innerHeight - 2 + 'px';
            if ($(window).width() < 1024) {
                document.getElementById("mobileResponsive").value = "Mobile"
                //document.body.style.height = window.innerHeight + "px";
            }
            if (getParameterByName("Message") == "InvalidLogin" || getParameterByName("Message") == "PBNInvalidLogin") {

                if (document.getElementById("mobileResponsive").value == "Mobile") {
                    document.getElementById("lblLoginErrorMobile").innerHTML = "Invalid Login";
                }
                else {
                    document.getElementById("lblLoginError").innerHTML = "Invalid Login";
                }
                     <%
        If m_blnIsWindowsAuthenticated = False Then
            If Session("time") Is Nothing Then

                Dim time As Integer = 1
                Session("time") = time
            Else
                Dim time As Integer = CInt(Session("time"))
                Session("time") = time + 1
            End If
        End If
  %>
            }
            if (getParameterByName("Message") == "ALREADY_LOGGEDIN") {
                if (document.getElementById("mobileResponsive").value == "Mobile") {
                    var x = document.getElementById('lblLoginErrorMobile'); x.innerHTML = "Invalid Login";
                }
                else {
                    var x = document.getElementById('lblLoginError'); x.innerHTML = "Invalid Login";
                }
            }
            if (getParameterByName("Message") == "LDAPINVALIDLOGIN") {
                if (document.getElementById("mobileResponsive").value == "Mobile") {
                    var x = document.getElementById('lblLoginError'); x.innerHTML = "Invalid Login";
                }
                else {
                    var x = document.getElementById('lblLoginError'); x.innerHTML = "Invalid Login";
                }
            }
            if (getParameterByName("Message") == "SESSIONEXPIRED") {

                if (document.getElementById("mobileResponsive").value == "Mobile") {
                    document.getElementById("txtLoginMobile").value = getParameterByName("strLogin")
                    if (getParameterByName("Mode") == "M") {
                    }
                    else {
                        objfrm.submit();
                    }

                    if (getParameterByName("strPass") == "") {

                        var x = document.getElementById('lblLoginErrorMobile'); x.innerHTML = "SESSION EXPIRED";
                    }
                }
                else {
                    document.getElementById("txtLogin").value = getParameterByName("strLogin")
                    if (getParameterByName("Mode") == "M") {
                    }
                    else {
                        objfrm.submit();
                    }
                    if (getParameterByName("strPass") == "") {
                        var x = document.getElementById('lblLoginError'); x.innerHTML = "SESSION EXPIRED";
                    }
                }
            }
            if (getParameterByName("Message") == "SessionExpired") {

                if (document.getElementById("mobileResponsive").value == "Mobile") {
                    document.getElementById("txtLoginMobile").value = getParameterByName("strLogin")
                    if (getParameterByName("Mode") == "M") {
                    }
                    else {
                        objfrm.submit();
                    }
                    if (getParameterByName("strPass") == "") {

                        var x = document.getElementById('lblLoginErrorMobile'); x.innerHTML = "SESSION EXPIRED";
                    }
                }
                else {
                    if (document.getElementById("mobileResponsive").value == "Mobile") {
                        document.getElementById("txtLoginMobile").value = getParameterByName("strLogin")
                        if (getParameterByName("Mode") == "M") {
                        }
                        else {
                            objfrm.submit();
                        }
                        if (getParameterByName("strPass") == "") {

                            var x = document.getElementById('lblLoginErrorMobile'); x.innerHTML = "SESSION EXPIRED";
                        }
                    }
                    else {
                        document.getElementById("txtLogin").value = getParameterByName("strLogin")
                        if (getParameterByName("Mode") == "M") {
                        }
                        else {
                            objfrm.submit();
                        }
                        if (getParameterByName("strPass") == "") {
                            var x = document.getElementById('lblLoginError'); x.innerHTML = "SESSION EXPIRED";
                        }
                    }
                }
            }
            if (getParameterByName("Message") == "INVALIDDOMAIN") {
                if (document.getElementById("mobileResponsive").value == "Mobile") {
                    var x = document.getElementById('lblLoginErrorMobile'); x.innerHTML = "Invalid Login";
                }
                else {
                    var x = document.getElementById('lblLoginError'); x.innerHTML = "Invalid Login";
                }
            }
            if (getParameterByName("Message") == "LOGGEDOUT") {
                if (document.getElementById("mobileResponsive").value == "Mobile") {
                    var x = document.getElementById('lblLoginErrorMobile'); x.innerHTML = "Successfully logged out";
                }
                else {
                    var x = document.getElementById('lblLoginError'); x.innerHTML = "Successfully logged out";
                }
            }
            $("#txtLogin").val('');

            blnEnabledLockUserID = '<%=m_blnEnableLockUserID%>';
            intPassLockingCount = '<%=m_intPassLockingCount%>';
            intPassCaptchCount = '<%=m_intPassCaptchCount%>';
            var blnEnableCaptcha = '<%=m_blnEnableCaptcha%>'

            if (getParameterByName("MES") == "INVALIDCAPCHA") {

                if (document.getElementById("mobileResponsive").value == "Mobile") {
                    var x = document.getElementById('lblLoginErrorMobile'); x.innerHTML = "Invalid Captcha !";
                }
                else {
                    var x = document.getElementById('lblLoginError'); x.innerHTML = "Invalid Captcha !";
                }
            }
            if (blnEnableCaptcha == 'True') {

                <% If (Session("time") > (m_intPassCaptchCount - 1)) Then%>
                RefreshCaptcha()
                <%End If%>
            }
            
            // Change Password 
            <%MyBase.InitializeResources("Resources.SM_ChangePassword", "Resources")%>
            if (getParameterByName("Mode") == "ChangePassword") {
                if (document.getElementById("hidChangePassword").value == 1) {
                    //document.getElementById('loginformboxformD').style.display = "none";
                    //document.getElementById('changepassformD').style.display = "block";
                    document.getElementById('loginformboxformD').style.display = "block";
                    document.getElementById('changepassformD').style.display = "none";
                    //document.getElementById('SpanConfirmPassword').style.color = "green";
                    document.getElementById('SpanPassword').style.color = "green";

                    document.getElementById('SpanPassword').innerHTML = "<%=MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY")%>";
                   <%-- document.getElementById('SpanConfirmPassword').innerHTML = "<%=MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY")%>";--%>
                    document.getElementById("txtLogin").focus();
                }
                else if (document.getElementById("hidChangePassword").value == 2) {
                    document.getElementById('loginformboxformD').style.display = "none";
                    document.getElementById('changepassformD').style.display = "block";
                    document.getElementById('SpanConfirmPassword').innerHTML = "";
                    document.getElementById("txtLoginName").focus();
                }
                else {
                    document.getElementById('loginformboxformD').style.display = "none";
                    document.getElementById('changepassformD').style.display = "block";
                    document.getElementById('SpanConfirmPassword').innerHTML = "Invalid Login";
                    document.getElementById("txtLoginName").focus();
                }
            }
            //Change Password For Mobile view Added by Swapnagandha
            if (getParameterByName("Mode") == "ChangePasswordMobile") {
                if (document.getElementById("hidChangePasswordMobile").value == 1) {                    
                    //document.getElementById('SpanConfirmPasswordMobile').innerHTML = "<%=MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY")%>";
                    document.getElementById('loginformboxformM').style.display = "block";
                    document.getElementById('changepassformM').style.display = "none";
                    document.getElementById('SpanPasswordMobile').style.color = "green";
                    document.getElementById('SpanPasswordMobile').innerHTML = "<%=MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY")%>";
                    document.getElementById("txtLoginMobile").focus();
                }
                else if (document.getElementById("hidChangePasswordMobile").value == 2) {
                    document.getElementById('loginformboxformM').style.display = "none";
                    document.getElementById('changepassformM').style.display = "block";
                    document.getElementById('SpanConfirmPasswordMobile').innerHTML = "";
                    document.getElementById("txtLoginNameMobile").focus();
                }
                else {
                    document.getElementById('loginformboxformM').style.display = "none";
                    document.getElementById('changepassformM').style.display = "block";
                    document.getElementById('SpanConfirmPasswordMobile').innerHTML = "Invalid Login";
                    document.getElementById("txtLoginNameMobile").focus();
                }
            }

            //End Change Password For Mobile view Added by Swapnagandha
            if (getParameterByName("FirstTimeLogin") == "1") {
                document.getElementById('loginformboxformD').style.display = "none";
                document.getElementById('changepassformD').style.display = "block";
                document.getElementById("btnChangePwdCancel").style.display = "none";
                if (getParameterByName("PassPhraseDay") == "1") {
                    document.getElementById("txtLoginName").value = getParameterByName("LoginName");
                    document.getElementById("txtLoginName").disabled = true;
                    document.getElementById('SpanConfirmPassword').innerHTML = "As per password policy, Your password has expired, Please change the password!";
                }
                else {
                    document.getElementById("txtLoginName").value = getParameterByName("LoginName");
                    document.getElementById("txtLoginName").disabled = true;
                    document.getElementById('SpanConfirmPassword').innerHTML = " You are login first time or your password has been reset/expired, As per password policy you are enforced to Change Password ";
                }
            }
            if (getParameterByName("FirstTimeLogin") == "1") {
                document.getElementById('loginformboxformM').style.display = "none";
                document.getElementById('changepassformM').style.display = "block";
                document.getElementById("btnChangePwdCancelMobile").style.display = "none";
                if (getParameterByName("PassPhraseDay") == "1") {
                    document.getElementById("txtLoginNameMobile").value = getParameterByName("LoginName");
                    document.getElementById("txtLoginNameMobile").disabled = true;
                    document.getElementById('SpanConfirmPasswordMobile').innerHTML = "As per password policy, Your password has expired, Please change the password!";
                }
                else {
                    document.getElementById("txtLoginNameMobile").value = getParameterByName("LoginName");
                    document.getElementById("txtLoginNameMobile").disabled = true;
                    document.getElementById('SpanConfirmPasswordMobile').innerHTML = " You are login first time or your password has been reset/expired, As per password policy you are enforced to Change Password ";
                }
            }

            <% MyBase.InitializeResources("AppResources.SM_ForgotPassword", "AppResources")%>
            if (getParameterByName("Mode") == "ResetPassword") {
                if (document.getElementById("hidForgetPassword").value == 1) {
                   <%-- document.getElementById('SpanPassword').innerHTML = "<%= MyBase.GetResourceString("PASSWORD_SEND")%>";
                    document.getElementById("txtLogin").focus();--%>


                    //Commented and Added By Dipali V On 27th Aug 2020 For Reset password
                    <%--document.getElementById('SpanPassword').innerHTML = "<%= MyBase.GetResourceString("PASSWORD_SEND")%>";--%>
                    //An email has been sent to your email account with the new password information.
                    document.getElementById('SpanPassword').innerHTML = "A Mail has been sent to your email account with the new Reset Password Link";
                    document.getElementById("txtLogin").focus();
                    //End Commented and Added ByDipali V On 27th Aug 2020 For Reset password
                }
                else if (document.getElementById("hidForgetPassword").value == 0) {
                    document.getElementById('loginformboxformD').style.display = "none";
                    document.getElementById('forgotpassformD').style.display = "block";
                    document.getElementById('SpanFUserID').innerHTML = "<%=MyBase.GetResourceString("VALIDATION_MSG6")%>";
                    document.getElementById("txtFUserID").focus();
                }
                else if (document.getElementById("hidForgetPassword").value == 2) {
                    document.getElementById('loginformboxformD').style.display = "none";
                    document.getElementById('forgotpassformD').style.display = "block";
                    //Commented & Added by Dipali V On 27th Aug 2020 For Reset Password
                    <%-- Commented And Added By Usha Pandit On 04.07.2019 For Invalid Error Message --%>
                    <%--document.getElementById('SpanFUserID').innerHTML = "<%=MyBase.GetResourceString("TRY_AGAIN")%>";--%>
                    //document.getElementById('SpanFUserID').innerHTML = "Invalid User Id";
                    <%-- End Of Added By Usha Pandit On 04.07.2019 For Invalid Error Message --%>
                    //document.getElementById("txtFUserID").focus();
                     
                     <%--document.getElementById('SpanFUserID').innerHTML = "<%=MyBase.GetResourceString("TRY_AGAIN")%>";
                    document.getElementById("txtFUserID").focus();--%>
                    document.getElementById('SpanFEmailID').innerHTML = "Invalid User ID / Email ID.";
                    document.getElementById("txtEmailID").focus();                    
                     //End Added by Commented & Added by Dipali V On 27th Aug 2020 For Reset Password

                }
                else if (document.getElementById("hidForgetPassword").value == 3) {
                    document.getElementById('loginformboxformD').style.display = "none";
                    document.getElementById('forgotpassformD').style.display = "block";
                    document.getElementById('SpanFUserID').innerHTML = "<%=MyBase.GetResourceString("INVALID_EMAILID")%>";
                    document.getElementById("txtFUserID").focus();
                }
                else if (document.getElementById("hidForgetPassword").value == 4) {
                    document.getElementById('loginformboxformD').style.display = "none";
                    document.getElementById('forgotpassformD').style.display = "block";
                    
                    document.getElementById('SpanFEmailID').innerHTML = "The User ID and Email ID are not associated with each other.";
                    document.getElementById("txtEmailID").focus();
                    
                }
                else if (document.getElementById("hidForgetPassword").value == 5) {
                     document.getElementById('loginformboxformD').style.display = "none";
                     document.getElementById('forgotpassformD').style.display = "block";
                    
                     document.getElementById('SpanFEmailID').innerHTML = "Invalid User ID / Email ID.";
                     document.getElementById("txtEmailID").focus();
                 }
                //End of Commented & Added by Dipali V on 27th Aug 2020 For Reset Password
            }
            //Forget Password Mobile Added by swapnagandha
            if (getParameterByName("Mode") == "ResetPasswordMobile") {

                document.getElementById("hidForgetPasswordMobile").value;
                if (document.getElementById("hidForgetPasswordMobile").value == 1) {
                     //added by dipali v on 15th Jan 2021 for Reset Pwd 
                    //document.getElementById('SpanPasswordMobile').innerHTML = "<%= MyBase.GetResourceString("PASSWORD_SEND")%>";
                     document.getElementById('SpanPasswordMobile').innerHTML = "A Mail has been sent to your email account with the new Reset Password Link";
                    // End of added by dipali v on 15th Jan 2021 for Reset Pwd 
                    document.getElementById("txtLoginMobile").focus();
                }
                else if (document.getElementById("hidForgetPasswordMobile").value == 0) {
                    document.getElementById('loginformboxformM').style.display = "none";
                    document.getElementById('forgotpassformM').style.display = "block";
                    document.getElementById('SpanFUserIDMobile').innerHTML = "<%=MyBase.GetResourceString("VALIDATION_MSG6")%>";
                    document.getElementById("txtFUserIDMobile").focus();
                }
                else if (document.getElementById("hidForgetPasswordMobile").value == 2) {
                    document.getElementById('loginformboxformM').style.display = "none";
                    document.getElementById('forgotpassformM').style.display = "block";
                     //added by dipali v on 15th Jan 2021 for Reset Pwd 
                    <%-- Commented And Added By Usha Pandit On 04.07.2019 For Invalid Error Message --%>
                    <%--document.getElementById('SpanFUserIDMobile').innerHTML = "<%=MyBase.GetResourceString("TRY_AGAIN")%>";--%>
                    //document.getElementById('SpanFUserIDMobile').innerHTML =  "Invalid User Id";
                    document.getElementById('SpanFUserIDMobile').innerHTML =  "Invalid User ID / Email ID."
                    <%-- End Of Added By Usha Pandit On 04.07.2019 For Invalid Error Message --%>
                     //End of added by dipali v on 15th Jan 2021 for Reset Pwd 
                    document.getElementById("txtFUserIDMobile").focus();
                }
                else if (document.getElementById("hidForgetPasswordMobile").value == 3) {
                    document.getElementById('loginformboxformM').style.display = "none";
                    document.getElementById('forgotpassformM').style.display = "block";
                    document.getElementById('SpanFUserIDMobile').innerHTML = "<%=MyBase.GetResourceString("INVALID_EMAILID")%>";
                    document.getElementById("txtFUserIDMobile").focus();
                }
                else if (document.getElementById("hidForgetPasswordMobile").value == 4) {
                    document.getElementById('loginformboxformM').style.display = "none";
                    document.getElementById('forgotpassformM').style.display = "block";
                     //added by dipali v on 15th Jan 2021 for Reset Pwd 
                    //document.getElementById('SpanFEmailIDMobile').innerHTML = "Invalid Email ID";
                     document.getElementById('SpanFEmailIDMobile').innerHTML = "The User ID and Email ID are not associated with each other.";
                  
                    //Commented and added by Chetan M on 31 Dec 2020 for focus Issue
                    //document.getElementById("txtFUserIDMobile").focus();
                    document.getElementById("txtEmailIDMobile").focus();
                    //End of Commented and added by Chetan M on 31 Dec 2020 for focus Issue
                     //End of added by dipali v on 15th Jan 2021 for Reset Pwd 
                }

                else if (document.getElementById("hidForgetPassword").value == 5) {
                     document.getElementById('loginformboxformM').style.display = "none";
                    document.getElementById('forgotpassformM').style.display = "block";
                     //added by dipali v on 15th Jan 2021 for Reset Pwd 
                    //document.getElementById('SpanFEmailID').innerHTML = "Invalid Email ID";
                     document.getElementById('SpanFEmailIDMobile').innerHTML = "Invalid User ID / Email ID.";
                    document.getElementById("txtEmailIDMobile").focus();
                    // End of added by dipali v on 15th Jan 2021 for Reset Pwd 
                 }
            }
            //Forget Password Mobile End by swapnagandha
        }

        
        function ChangePassword() {
            
            if (Validate() == true) {

                var objtxtLoginName = GetObjectReference('frmChangePassword', 'txtLoginName');
                if (objtxtLoginName != null) {
                    objtxtLoginName.disabled = false;
                }

                setFrameLoader();

                //commeneted and added by Aditya J. on 06-11-2024
                //objfrm.action = "Default.aspx?Mode=ChangePassword";
                var Parameters = {
                    UserName: $('#txtLoginName').val(),
                    OldPassword: $('#txtOldPassword').val(),
                    NewPassword: $('#txtNewPassword').val(),
                    ConfirmPassword: $('#txtConfirmPassword').val()
                };

                var param = JSON.stringify(Parameters);
                var Result = AJAXCallWithResult("/api/SM_Default/SetPassword", param, false);
                //alert(m_strStatus);
                if (Result.hidChangePassword == "1") {
                    
                    document.getElementById('loginformboxformD').style.display = "block";
                    document.getElementById('changepassformD').style.display = "none";
                    //document.getElementById('SpanConfirmPassword').style.color = "green";
                    document.getElementById('SpanPassword').style.color = "green";

                    document.getElementById('SpanPassword').innerHTML = "<%=MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY")%>";
                    document.getElementById("txtLogin").focus();                  
                }
                else if (Result.hidChangePassword == "2") {
                    document.getElementById('loginformboxformD').style.display = "none";
                    document.getElementById('changepassformD').style.display = "block";
                    document.getElementById('SpanConfirmPassword').innerHTML = "";
                    document.getElementById("txtLoginName").focus();
                }
                else {
                    //objfrm.submit();
                    document.getElementById('loginformboxformD').style.display = "none";
                    document.getElementById('changepassformD').style.display = "block";         
                    document.getElementById('SpanConfirmPassword').innerHTML = "Invalid Login";
                    document.getElementById("txtLoginName").focus();
                    document.getElementById('txtLoginName').value = "";
                    document.getElementById('txtOldPassword').value = "";
                    document.getElementById('txtNewPassword').value = "";
                    document.getElementById('txtConfirmPassword').value = "";                    
                   
                }
                //End of commeneted and added by Aditya J. on 06-11-2024               
                //objfrm.submit();

            }
        }
        function ChangePasswordMobile() {
            //debugger;
            if (Validate() == true) {
                var objtxtLoginName = GetObjectReference('frmChangePassword', 'txtLoginNameMobile');
                if (objtxtLoginName != null) {
                    objtxtLoginName.disabled = false;
                }

                setFrameLoader();//FOR SAVE ISSUE  

                //commeneted and added by Aditya J. on 06-11-2024
                //objfrm.action = "Default.aspx?Mode=ChangePasswordMobile";

                var Parameters = {
                    UserName: $('#txtLoginNameMobile').val(),
                    OldPassword: $('#txtOldPasswordMobile').val(),
                    NewPassword: $('#txtNewPasswordMobile').val(),
                    ConfirmPassword: $('#txtConfirmPasswordMobile').val()
                };

                var param = JSON.stringify(Parameters);
                var Result = AJAXCallWithResult("/api/SM_Default/SetPasswordMobile", param, false);
                if (Result.hidChangePasswordMobile == "1") {                    
                    //document.getElementById('SpanConfirmPasswordMobile').innerHTML = "<%=MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY")%>";
                    document.getElementById('loginformboxformM').style.display = "block";
                    document.getElementById('changepassformM').style.display = "none";
                    document.getElementById('SpanPasswordMobile').style.color = "green";
                        document.getElementById('SpanPasswordMobile').innerHTML = "<%=MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY")%>";
                        document.getElementById("txtLoginMobile").focus();
                    }
                    else if (Result.hidChangePasswordMobile == 2) {
                        document.getElementById('loginformboxformM').style.display = "none";
                        document.getElementById('changepassformM').style.display = "block";
                        document.getElementById('SpanConfirmPasswordMobile').innerHTML = "";
                        document.getElementById("txtLoginNameMobile").focus();
                    }
                    else {
                        document.getElementById('loginformboxformM').style.display = "none";
                        document.getElementById('changepassformM').style.display = "block";
                        document.getElementById('SpanConfirmPasswordMobile').innerHTML = "Invalid Login";
                        document.getElementById("txtLoginNameMobile").focus();
                        document.getElementById('txtLoginNameMobile').value = "";
                        document.getElementById('txtOldPasswordMobile').value = "";
                        document.getElementById('txtNewPasswordMobile').value = "";
                        document.getElementById('txtConfirmPasswordMobile').value = "";
                    }

                }
                //End of commeneted and added by Aditya J. on 06-11-2024
                //objfrm.submit();

            }
        function Validate() {
           // debugger;
            var blnEnablePassLength = '<%=m_blnEnablePassLength %>';
            var intMinPassLen = '<%=m_intMinPassLen %>';
            var intMaxPassLen = '<%=m_intMaxPassLen %>';
            var blnEnableAlphaNumSpeChar = '<%=m_blnEnableAlphaNumSpeChar %>';
            var intNumberOfAlpha = '<%=m_intNumberOfAlpha %>';
            var intNumberOfNumerals = '<%=m_intNumberOfNumerals %>';
            var intNumberOfSpecialChars = '<%=m_intNumberOfSpecialChars %>';
            var blnAllowSameLoginPwd = '<%=m_blnAllowSameLoginPwd %>';
            var EnablePassPharsesDays = '<%=m_blnEnablePassPharsesDays%>';
            var PassPharsesDays = '<%=m_intPassPharsesDays%>';
            var EnablePreviousPassCheck = '<%=m_blnEnablePreviousPassCheck%>';
            var PreviousPassCount = '<%=m_intPreviousPassCount%>';
            var EnablePassLockoutDuration = '<%=m_blnEnablePassLockoutDuration%>';
            var PassLockoutDuration = '<%=m_intPassLockoutDuration%>';
            var EnableLockUserID = '<%=m_blnEnableLockUserID%>';
            var PassLockingCount = '<%=m_intPassLockingCount%>';
            var PassCaptchaCount = '<%=m_intPassCaptchaCount%>';
            var intCurrAlphaCount = 0;
            var intCurrNumCount = 0;
            var intCurrSpecCount = 0;
            var intAsciiValue;
            var strAlertMsg;
            var AuthenticationType = '<%=strAuthenticationType %>';
            var stralphacharset = '65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122';
            var strnumeralcharset = '48 49 50 51 52 53 54 55 56 57';
            var strspecialcharset = '32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 58 59 60 61 62 63 64 91 92 93 94 95 96 123 124 125 126 127';
            if ($(window).width() < 1024) {
                var objLoginName = GetObjectReference('frmLogin1', 'txtLoginNameMobile');
                var objOldPwd = GetObjectReference('frmLogin1', 'txtOldPasswordMobile');
                var objNewPwd = GetObjectReference('frmLogin1', 'txtNewPasswordMobile');
                var objConfirmPwd = GetObjectReference('frmLogin1', 'txtConfirmPasswordMobile');
                var hdCount = GetObjectReference("frmCommonPage", "NonDatabase3Mobile");
                var objSpanConfirmPassword = $('#SpanConfirmPasswordMobile');
                var objtxtLoginName = $('#txtLoginNameMobile');
                var objSpanUserID = $('#SpanUserIDMobile');
                var objtxtOldPassword = $('#txtOldPasswordMobile');
                var objSpanCPassword = $('#SpanCPasswordMobile');
                var objtxtNewPassword = $('#txtNewPasswordMobile');
                var objSpanNewPassword = $('#SpanNewPasswordMobile');
                var objtxtConfirmPassword = $('#txtConfirmPasswordMobile');
            }
            else {
                var objLoginName = GetObjectReference('frmLogin1', 'txtLoginName');
                var objOldPwd = GetObjectReference('frmLogin1', 'txtOldPassword');
                var objNewPwd = GetObjectReference('frmLogin1', 'txtNewPassword');
                var objConfirmPwd = GetObjectReference('frmLogin1', 'txtConfirmPassword');
                var hdCount = GetObjectReference("frmCommonPage", "NonDatabase3");
                var objSpanConfirmPassword = $('#SpanConfirmPassword');
                var objtxtLoginName = $('#txtLoginName');
                var objSpanUserID = $('#SpanUserID');
                var objtxtOldPassword = $('#txtOldPassword');
                var objSpanCPassword = $('#SpanCPassword');
                var objtxtNewPassword = $('#txtNewPassword');
                var objSpanNewPassword = $('#SpanNewPassword');
                var objtxtConfirmPassword = $('#txtConfirmPassword');

            }


                <%MyBase.InitializeResources("Resources.SM_ChangePassword", "Resources")%>

            var strEncryptionKey = "";
            var strEncryptedNewPwd = "";
            var strEncryptedOldPwd = "";
            var strEncryptedConPwd = "";
  //Commented & Added By Dipali v on 29th oct 2024 For VAPT
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/ValidateUserName",
                data: JSON.stringify({ UserName: objLoginName.value }),
                async: false,
                success: function (data) {

                    var strResult = String(data.d).split("||");
                    strEncryptionKey = strResult[0];
                },
                error: function (result) {
                    console.log(result);
                }
            })
            //debugger;
            //var Parameters = {
            //    UserName: objLoginName.value ,
            //}
            //var param = JSON.stringify(Parameters);
            //var Result = AJAXCallWithResult("/api/SM_Default/ValidateUserName", param, false);
            //if (Result != "") {
            //    var strResult = String(Result).split("||");
            //    strEncryptionKey = strResult[0];
            //}
           //End of Added By Dipali v on 29th oct 2024 For VAPT

            if (hdCount != null)
                hdCount.value = strEncryptionKey.length;
            objSpanConfirmPassword.text("");
            if (objLoginName != null && objLoginName.value == '') {
                objtxtLoginName.css('border-color', '#fecc00');
                objtxtLoginName.css('border-width', '2px');
               // objSpanUserID.text('<%=MyBase.GetResourceString("VALIDATION_MSG1")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));
                 objSpanUserID.text('The User ID field should not be left blank.'.replace("&#39; ", "' ").replace("&#39;", "'"));
                return false;
            }
            else {
                objtxtLoginName.css('border-color', '#d8dade');
                objtxtLoginName.css('border-width', '1px');
                objSpanUserID.text("");
            }

            if (objOldPwd != null && objOldPwd.value == '') {
                objtxtOldPassword.css('border-color', '#fecc00');
                objtxtLoginName.css('border-width', '2px');
                objSpanCPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG2")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));

                return false;
            }
            else {
                objtxtOldPassword.css('border-color', '#d8dade');
                objtxtOldPassword.css('border-width', '1px');
                objSpanCPassword.text("");
            }
            if (objNewPwd != null && objNewPwd.value == '') {
                objtxtNewPassword.css('border-color', '#fecc00');
                objtxtNewPassword.css('border-width', '2px');
                objSpanNewPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG3")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));
                return false;
            }
            else {
                objtxtNewPassword.css('border-color', '#d8dade');
                objtxtNewPassword.css('border-width', '1px');
                objSpanNewPassword.text("");
            }
            if (objConfirmPwd != null && objConfirmPwd.value == '') {
                objtxtConfirmPassword.css('border-color', '#fecc00');
                objtxtConfirmPassword.css('border-width', '2px');
                objSpanConfirmPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG4")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));
                return false;
            } else {
                objtxtConfirmPassword.css('border-color', '#d8dade');
                objtxtConfirmPassword.css('border-width', '1px');
                objSpanConfirmPassword.text("");
            }


            if (objNewPwd != null && objConfirmPwd != null && objNewPwd.value != objConfirmPwd.value) {
                objtxtConfirmPassword.css('border-color', '#fecc00');
                objtxtConfirmPassword.css('border-width', '2px');
                objSpanConfirmPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG6")%>'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39; ", "' ").replace("&#39;", "'"));
                return false;
            }
            else {
                objtxtConfirmPassword.css('border-color', '#d8dade');
                objtxtConfirmPassword.css('border-width', '1px');
                objSpanConfirmPassword.text("");
            }
            var strNewPass = objNewPwd.value;
            var strConPass = objConfirmPwd.value;
            var strOldPass = objOldPwd.value;
            for (var i = strOldPass.length - 1, len = 0; i >= 0; i--) {
                strEncryptedOldPwd += strOldPass[i] + strEncryptionKey + '|';
            }

            for (var i = strNewPass.length - 1, len = 0; i >= 0; i--) {
                strEncryptedNewPwd += strNewPass[i] + strEncryptionKey + '|';
                strEncryptedConPwd += strConPass[i] + strEncryptionKey + '|';
            }
            if (objOldPwd != null && objNewPwd != null && objOldPwd.value == objNewPwd.value) {
                objtxtConfirmPassword.css('border-color', '#fecc00');
                objtxtConfirmPassword.css('border-width', '2px');
                objSpanConfirmPassword.text('The &#39;Old Password&#39; and &#39;New Password&#39; fields should not be same.'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39; ", "' ").replace("&#39;", "'"))
                return false;
            }
                <% If ((strAuthenticationType = "N" OrElse strAuthenticationType = "M") AndAlso blnFirstTimeLogin = True) Then%>
            if (objOldPwd != null && objNewPwd != null && objOldPwd.value == objNewPwd.value) {
                objtxtConfirmPassword.css('border-color', '#fecc00');
                objtxtConfirmPassword.css('border-width', '2px');
                objSpanConfirmPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG11")%>'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39;", "'"));
                return false;
            }
            else {
                objtxtConfirmPassword.css('border-color', '#d8dade');
                objtxtConfirmPassword.css('border-width', '1px');
                objSpanConfirmPassword.text("");

            }
                <%End If%>

                <% If ((strAuthenticationType = "N" OrElse strAuthenticationType = "M") AndAlso m_blnAllowSameLoginPwd = True) Then%>
            if (objLoginName != null && objNewPwd != null && objLoginName.value == objNewPwd.value) {
                objtxtNewPassword.css('border-color', '#fecc00');
                objtxtNewPassword.css('border-width', '2px');
                objSpanNewPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG10")%>'.replace(" &#39;", " '").replace("&#39; ", "' ").replace("&#39;Password&#39;", "'Password'"));
                return false;
            }
            else {
                objtxtNewPassword.css('border-color', '#d8dade');
                objtxtNewPassword.css('border-width', '1px');
                objSpanNewPassword.text("");

            }
                <%End If%>
            if ((AuthenticationType == 'N' || AuthenticationType == 'M') && blnEnablePassLength == 'True') {
                if (objNewPwd != null && intMinPassLen > (objNewPwd.value).trim().length) {
                    strAlertMsg = '<%=MyBase.GetResourceString("VALIDATION_MSG7")%>';
                    strAlertMsg = strAlertMsg.replace('<MINPASSWORDLENGTH>', intMinPassLen);
                    objtxtNewPassword.css('border-color', '#fecc00');
                    objtxtNewPassword.css('border-width', '2px');
                    objSpanNewPassword.text(strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'"));
                    objNewPwd.focus();
                    return false;
                }
                else {
                    objtxtNewPassword.css('border-color', '#d8dade');
                    objtxtNewPassword.css('border-width', '1px');
                    objSpanNewPassword.text("");

                }
                if (objNewPwd != null && intMaxPassLen < (objNewPwd.value).trim().length) {
                    strAlertMsg = '<%=MyBase.GetResourceString("VALIDATION_MSG8")%>';
                    strAlertMsg = strAlertMsg.replace('<MAXPASSWORDLENGTH>', intMaxPassLen);
                    objSpanNewPassword.text(strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'"));
                    objtxtNewPassword.css('border-color', '#fecc00');
                    objtxtNewPassword.css('border-width', '2px');
                    objNewPwd.focus();
                    return false;
                }
                else {
                    objtxtNewPassword.css('border-color', '#d8dade');
                    objtxtNewPassword.css('border-width', '1px');
                    objSpanNewPassword.text("");

                }
            }
            else {
                if (objNewPwd != null && (objNewPwd.value).trim().length < 6) {
                    objSpanNewPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG5")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));
                    objtxtNewPassword.css('border-color', '#fecc00');
                    objtxtNewPassword.css('border-width', '2px');
                    objNewPwd.focus();
                    return false;
                }
            }

            if ((AuthenticationType == 'N' || AuthenticationType == 'M') && blnEnableAlphaNumSpeChar == 'True') {
                if (objNewPwd != null) {
                    newPass = objNewPwd.value;
                    for (i = 0; i < newPass.length; i++) {
                        intAsciiValue = newPass.charCodeAt(i);
                        if (stralphacharset.indexOf(intAsciiValue) >= 0) {
                            intCurrAlphaCount = parseInt(intCurrAlphaCount) + 1;
                        }
                        if (strnumeralcharset.indexOf(intAsciiValue) >= 0) {
                            intCurrNumCount = parseInt(intCurrNumCount) + 1;
                        }
                        if (strspecialcharset.indexOf(intAsciiValue) >= 0) {
                            intCurrSpecCount = parseInt(intCurrSpecCount) + 1;
                        }
                    }
                }
                if (intCurrAlphaCount < intNumberOfAlpha || intCurrNumCount < intNumberOfNumerals || intCurrSpecCount < intNumberOfSpecialChars) {
                    strAlertMsg = '<%=MyBase.GetResourceString("VALIDATION_MSG9")%>';
                    strAlertMsg = strAlertMsg.replace('<NUMBEROFALPHABETS>', intNumberOfAlpha);
                    strAlertMsg = strAlertMsg.replace('<NUMBEROFNUMERALS>', intNumberOfNumerals);
                    strAlertMsg = strAlertMsg.replace('<NUMBEROFSPECIALCHAR>', intNumberOfSpecialChars);
                    strAlertMsg = strAlertMsg.replace('alphabets', 'alphabet(s)');
                    strAlertMsg = strAlertMsg.replace('numerals', 'numeral(s)');
                    strAlertMsg = strAlertMsg.replace('characters', 'character(s)');
                    objSpanNewPassword.text(strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'"));
                    objtxtNewPassword.css('border-color', '#fecc00');
                    objtxtNewPassword.css('border-width', '2px');
                    objNewPwd.focus();
                    return false;
                }
            }
            
            if (('<%=strAuthenticationType%>' == 'N' || '<%=strAuthenticationType%>' == 'M') && (EnablePreviousPassCheck == 'True')) {

                var strResult
                //var strURL = 'Action=CHECKLASTENTEREDPWDS&LoginName=' + objLoginName.value + '&NewPassword=' + strEncryptedNewPwd + "&AuthNo=" + strEncryptionKey.length;
                // Added By Dipali v on 29th oct 2024 For VAPT 
                //$.ajax({
                //    type: "POST",
                //    contentType: "application/json; charset=utf-8",
                //    url: 'Default.aspx/CHECKLASTENTEREDPWDS',
                //    data: JSON.stringify({ LoginName: objLoginName.value, NewPassword: strEncryptedNewPwd, AuthNo: strEncryptionKey.length }),
                //    async: false,
                //    success: function (data) {
                //        strResult = data.d;
                //    },
                //    error: function (result) {
                //        console.log(result.statusText);
                //    }
                //})

               
                var Parameters = {
                    LoginName: objLoginName.value,
                    NewPassword: strEncryptedNewPwd,
                    AuthNo: strEncryptionKey.length
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/SM_Default/CHECKLASTENTEREDPWDS", param, false);
                if (strResult != "") {
                    strResult = strResult;
                }
                //End of Added By Dipali v on 29th oct 2024 For VAPT 
                if (strResult == '1') {
                    objSpanNewPassword.text("As per password policy, New password should not be same as previous " + PreviousPassCount + " passwords!");
                    objtxtNewPassword.css('border-color', '#fecc00');
                    objtxtNewPassword.css('border-width', '2px');
                    return false;
                }
                else {
                    objtxtNewPassword.css('border-color', '#d8dade');
                    objtxtNewPassword.css('border-width', '1px');
                    objSpanNewPassword.text("");
                }
            }

            objNewPwd.value = strEncryptedNewPwd;
            objConfirmPwd.value = strEncryptedConPwd;
            objOldPwd.value = strEncryptedOldPwd;
            return true;
        }

      //Added By Dipali v on 29th oct 2024 For VAPT 
        var strUrl_Conf = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
        var ajaxResult = "";
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl_Conf) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Configuration"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {

                   
                    ajaxResult = data;
                },
                error: function (err) {
                   
                    console.log(err);
                  
                }
            });
            return ajaxResult;
        }
        //End of Added By Dipali v on 29th oct 2024 For VAPT 
        function ClearSpan(txt, span) {


            if ($('#' + txt).val() == "") {
                //Added By Reshma Chavan on 16th Nov 2021 to restrict Quotes
                document.getElementById("lblLoginError").innerHTML = "";
                //End of Added By Reshma Chavan on 16th Nov 2021 to restrict Quotes
            }
            else {
                $('#' + txt).css('border-color', '#d8dade');
                $('#' + txt).css('border-width', '1px');
                $('#' + span).text("");

                //Added By Reshma Chavan on 16th Nov 2021 to restrict Quotes
                if ($('#' + txt).val().indexOf("'") > -1 || $('#' + txt).val().indexOf("''") > -1 || $('#' + txt).val().indexOf('"') > -1) {
                    document.getElementById("lblLoginError").innerHTML = "Invalid Login";
                }
                else {
                    document.getElementById("lblLoginError").innerHTML = "";
                }
                //End of Added By Reshma Chavan on 16th Nov 2021 to restrict Quotes
            }
        }

        function ValidateUserName() {
            //debugger;
            if (document.getElementById("mobileResponsive").value == "Mobile") {
                 //Added By Dipali v on 29th oct 2024 For VAPT
                //$.ajax({
                //    type: "POST",
                //    contentType: "application/json; charset=utf-8",
                //    url: 'Default.aspx/ValidateUserName',
                //    data: JSON.stringify({ UserName: $("#txtLoginMobile").val() }),
                //    async: false,
                //    success: function (data) {

                //        var strResult = String(data.d).split("||");
                //        document.getElementById("txtEncryptedUserNameMobile").value = strResult[0];
                //        document.getElementById("hdnToken").value = strResult[1];

                //    },
                //    error: function (result) {
                //        console.log(result.statusText);
                //    }
                //})
                <%--Commented  By Dipali V On 06th May 2026 For Token And Password Plaintext--%>
                //var Parameters = {
                //    UserName: $("#txtLoginMobile").val(),
                //}
                //var param = JSON.stringify(Parameters);
                //var Result = AJAXCallWithResult("/api/SM_Default/ValidateUserName", param, false);
                //if (Result != "") {
                //    var strResult = String(Result).split("||");
                //    document.getElementById("txtEncryptedUserNameMobile").value = strResult[0];
                //    document.getElementById("hdnToken").value = strResult[1];
                //}
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Default.aspx/ValidateUserName',
                    data: JSON.stringify({ UserName: $("#txtLoginMobile").val() }),
                    async: false,
                    success: function (data) {

                        var strResult = String(data.d).split("||");
                        document.getElementById("txtEncryptedUserNameMobile").value = strResult[0];
                        document.getElementById("hdnToken").value = strResult[1];

                    },
                    error: function (result) {
                        console.log(result.statusText);
                    }
                })
                <%--End of Commented  By Dipali V On 06th May 2026 For Token And Password Plaintext--%>
           //End of Added By Dipali v on 29th oct 2024 For VAPT

            }
            else if (document.getElementById("mobileResponsive").value == "NewMobileView") {
                <%--Commented  By Dipali V On 06th May 2026 For Token And Password Plaintext--%>
                //Added By Dipali v on 29th oct 2024 For VAPT
                //$.ajax({
                //    type: "POST",
                //    contentType: "application/json; charset=utf-8",
                //    url: 'Default.aspx/ValidateUserName',
                //    data: JSON.stringify({ UserName: $("#txtLoginMobile").val() }),
                //    async: false,
                //    success: function (data) {

                //        var strResult = String(data.d).split("||");
                //        document.getElementById("txtEncryptedUserNameMobile").value = strResult[0];
                //        document.getElementById("hdnToken").value = strResult[1];

                //    },
                //    error: function (result) {
                //        console.log(result.statusText);
                //    }
                //})
                //var Parameters = {
                //    UserName: $("#txtLoginMobile").val(),
                //}
                //var param = JSON.stringify(Parameters);
                //var Result = AJAXCallWithResult("/api/SM_Default/ValidateUserName", param, false);
                //if (Result != "") {
                //    var strResult = String(Result).split("||");
                //    document.getElementById("txtEncryptedUserNameMobile").value = strResult[0];
                //    document.getElementById("hdnToken").value = strResult[1];
                //}
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Default.aspx/ValidateUserName',
                    data: JSON.stringify({ UserName: $("#txtLoginMobile").val() }),
                    async: false,
                    success: function (data) {

                        var strResult = String(data.d).split("||");
                        document.getElementById("txtEncryptedUserNameMobile").value = strResult[0];
                        document.getElementById("hdnToken").value = strResult[1];

                    },
                    error: function (result) {
                        console.log(result.statusText);
                    }
                })
                <%--End of Commented  By Dipali V On 06th May 2026 For Token And Password Plaintext--%>
           //End of Added By Dipali v on 29th oct 2024 For VAPT
            }
            else {
                //Added By Dipali v on 29th oct 2024 For VAPT
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Default.aspx/ValidateUserName',
                    data: JSON.stringify({ UserName: $("#txtLogin").val() }),
                    async: false,
                    success: function (data) {

                        var strResult = String(data.d).split("||");
                        document.getElementById("txtEncryptedUserName").value = strResult[0];
                        document.getElementById("hdnToken").value = strResult[1];

                    },
                    error: function (result) {
                        console.log(result.statusText);
                    }
                })

                //var Parameters = {
                //    UserName: $("#txtLogin").val(),
                //}
                //var param = JSON.stringify(Parameters);
                //var Result = AJAXCallWithResult("/api/SM_Default/ValidateUserName", param, false);
                //if (Result != "") {
                //    var strResult = String(Result).split("||");
                //    document.getElementById("txtEncryptedUserName").value = strResult[0];
                //    document.getElementById("hdnToken").value = strResult[1];
                //}
           //End of Added By Dipali v on 29th oct 2024 For VAPT
            }
        }

        function RefreshCaptcha() {
            var a = Math.ceil(Math.random() * 10) + '';
            var b = Math.ceil(Math.random() * 10) + '';
            var c = Math.ceil(Math.random() * 10) + '';
            var d = Math.ceil(Math.random() * 10) + '';
            var e = Math.ceil(Math.random() * 10) + '';
            code = a + ' ' + b + ' ' + ' ' + c + ' ' + d + ' ' + e


            var imgM = document.getElementById("imgCaptchaMobile");
            var hdM = document.getElementById("hdCaptchaMobile");

            var img = document.getElementById("imgCaptcha");
            var hd = document.getElementById("hdCaptcha");

            if (hd != null)
                hd.value = code;
            if (img != null)
                img.src = "Handler.ashx?query=" + hd.value;

            if (hdM != null)
                hdM.value = code;
            if (imgM != null)
                imgM.src = "Handler.ashx?query=" + hd.value;

        }
        //Added and Commented by Vishal Mane on 29/05/2026 to fix Reset password issue
        function ForgotPassword() {
            <%MyBase.InitializeResources("AppResources.SM_ForgotPassword", "AppResources")%>
            if ($('#txtFUserID').val() == "") {
                $('#txtFUserID').css('border-color', '#fecc00');
                $('#txtFUserID').css('border-width', '2px');
                $('#SpanFUserID').text("Enter User ID");
                return false;
            }
            else {
                $('#txtFUserID').css('border-color', '#d8dade');
                $('#txtFUserID').css('border-width', '1px');
                $('#SpanFUserID').text("");
            }
            if ($('#txtEmailID').val() == "") {

                $('#txtEmailID').css('border-color', '#fecc00');
                $('#txtEmailID').css('border-width', '2px');
                $('#SpanFEmailID').text("Enter Email ID");
                return false;
            }
            else {
                $('#txtEmailID').css('border-color', '#d8dade');
                $('#txtEmailID').css('border-width', '1px');
                $('#SpanFEmailID').text("");
            }
            objfrm.action = "Default.aspx?Mode=ResetPassword";
            objfrm.submit();
        }

        <%--function ForgotPassword() {
            //debugger;
               <%MyBase.InitializeResources("AppResources.SM_ForgotPassword", "AppResources")%>
            if ($('#txtFUserID').val() == "") {

                $('#txtFUserID').css('border-color', '#fecc00');
                $('#txtFUserID').css('border-width', '2px');
                $('#SpanFUserID').text("Enter User ID");
                return false;
            }
            else {
                $('#txtFUserID').css('border-color', '#d8dade');
                $('#txtFUserID').css('border-width', '1px');
                $('#SpanFUserID').text("");
            }
            if ($('#txtEmailID').val() == "") {

                $('#txtEmailID').css('border-color', '#fecc00');
                $('#txtEmailID').css('border-width', '2px');
                $('#SpanFEmailID').text("Enter Email ID");
                return false;
            }
            else {
                $('#txtEmailID').css('border-color', '#d8dade');
                $('#txtEmailID').css('border-width', '1px');
                $('#SpanFEmailID').text("");
            }

            //commented and added by Aditya J. on 06-11-2024 for VAPT
            //objfrm.action = "Default.aspx?Mode=ResetPassword";           

            var Parameters = {
                UserName: $('#txtFUserID').val(),
                EmailID: $('#txtEmailID').val()
            };

            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/SM_Default/ReSetPassword", param, false);
            //End of commented and added by Aditya J. on 06-11-2024 for VAPT

            var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';

            $.ajax({
                url: strUrl_new + '/token',
                type: "POST",
                data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);

                    sessionStorage.setItem("access_token-I", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);
                    //alert(err.responseText);
                }
            })
            var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Dashboard").ToString%>';

            $.ajax({
                url: strUrl_new + '/token',
                type: "POST",
                data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);

                    sessionStorage.setItem("access_token_Dashboard", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);

                }
            })
            var strUrl_HD = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Helpdesk").ToString%>';

            $.ajax({
                url: strUrl_HD + '/token',
                type: "POST",
                data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);

                    sessionStorage.setItem("access_token-Helpdesk", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);

                }
            })
            var strUrl_Issue = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>';
            $.ajax({
                url: strUrl_Issue + '/token',
                type: "POST",
                data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);

                    sessionStorage.setItem("access_token_Issue", data.access_token);
                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);

                }
            })
            var strUrl_Cust = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
                //For Invoice
                $.ajax({
                    url: strUrl_Cust + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {

                        console.log(data);
                        //alert(data.access_token);
                        sessionStorage.setItem("access_token_project", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        //alert(err.responseText);
                        //console.log(err);
                    }
                })
                var strUrl_Resource = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Resource").ToString%>';
                $.ajax({
                    url: strUrl_Resource + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_resource", data.access_token);

                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                //2
                var strUrl_Invoice = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
                $.ajax({
                    url: strUrl_Invoice + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_invoice", data.access_token);

                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                //Added By Dipali V On 29th Oct  2024 For VAPT Changes
                var strUrl_Configuration = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
                $.ajax({
                    url: strUrl_Configuration + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_Configuration", data.access_token);

                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })

            //Added by Ajit L on 09/10/2025 for W26API token generation
            var strUrl_W26API = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
            $.ajax({
                url: strUrl_W26API + 'api/auth/token',
                type: "POST",
                data: {
                    username: document.getElementById("txtFUserID").value,
                    password: document.getElementById("txtEmailID").value,
                    grant_type: "password"
                },
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);
                    sessionStorage.setItem("access_token_W26API", data.access_token);
                },
                error: function (err) {
                    console.log(err);
                }
            })
            //End of Added by Ajit L on 09/10/2025 for W26API token generation

                 //End of Added By Dipali V On 29th Oct  2024 For VAPT Changes
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            $.ajax({
                url: strUrl + '/token',
                type: "POST",
                data: { username: document.getElementById("txtFUserID").value, password: document.getElementById("txtEmailID").value, grant_type: "password" },
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    //alert(1);
                    console.log(data);
                    //alert(data.access_token);
                    sessionStorage.setItem("access_token", data.access_token);
                    // objfrm.submit();
                },
                error: function (err) {
                    //alert(err.responseText);
                    //console.log(err);
                }
            })

            objfrm.action = "Default.aspx?Mode=ResetPassword";

            objfrm.submit();
        }--%>

        //Added and Commented by Vishal Mane on 29/05/2026 to fix Reset password issue

        function ForgotPasswordMobile() {
            
              <%MyBase.InitializeResources("AppResources.SM_ForgotPassword", "AppResources")%>

            if ($('#txtFUserIDMobile').val() == "") {
                $('#txtFUserIDMobile').css('border-color', '#fecc00');
                $('#txtFUserIDMobile').css('border-width', '2px');
                $('#SpanFUserIDMobile').text("Enter User ID");
                return false;
            }
            else {
                $('#txtFUserIDMobile').css('border-color', '#d8dade');
                $('#txtFUserIDMobile').css('border-width', '1px');
                $('#txtFUserIDMobile').text("");
            }
            if ($('#txtEmailIDMobile').val() == "") {

                $('#txtEmailIDMobile').css('border-color', '#fecc00');
                $('#txtEmailIDMobile').css('border-width', '2px');
                $('#SpanFEmailIDMobile').text("Enter Email ID");
                return false;
            }
            else {
                $('#txtEmailIDMobile').css('border-color', '#d8dade');
                $('#txtEmailIDMobile').css('border-width', '1px');
                $('#SpanFEmailIDMobile').text("");
            }

            //commented and added by Aditya J. on 06-11-2024 for VAPT
            objfrm.action = "Default.aspx?Mode=ResetPasswordMobile";

            //var Parameters = {
            //    UserName: $('#txtFUserIDMobile').val(),
            //    EmailID: $('#txtEmailIDMobile').val()
            //};

            //var param = JSON.stringify(Parameters);
            //var Result = AJAXCallWithResult("/api/SM_Default/ReSetPasswordMobile", param, false);
            //End of commented and added by Aditya J. on 06-11-2024 for VAPT

            objfrm.submit();
        }

        function CheckFirstTimeLogin() {
            
              //Added By Dipali v on 29th oct 2024 For VAPT
            //$.ajax({
            //    type: "POST",
            //    contentType: "application/json; charset=utf-8",
            //    url: 'Default.aspx/ForcefullyChangePassword',
            //    data: JSON.stringify({ LoginName: objtxtlogin.value, strPassword: objtxtpassword.value }),
            //    async: false,
            //    success: function (data) {

            //        if (data.d == "1") {
            //            sResponseText = "1";
            //            window.location.href = "Default.aspx?FirstTimeLogin=1&LoginName=" + objtxtlogin.value;
            //        }
            //    },
            //    error: function (result) {

            //        console.log(result.statusText);
            //    }
            //})

            //Commented and Added by Riddhesh Patil on 11 Nov 2024 for Passing Encrypted parameters
            //var Parameters = {
            //    LoginName: objtxtlogin.value,
            //    Password: objtxtpassword.value
            //}

            var strUrl_Configuration = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
            $.ajax({
                url: strUrl_Configuration + '/token',
                type: "POST",
                data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPassword").value, grant_type: "password" },
                dataType: "json",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    console.log(data);
                    sessionStorage.setItem("access_token_Configuration", data.access_token);

                    //objfrm.submit();
                },
                error: function (err) {
                    console.log(err);
                }
            })
            var Parameters = {
                LoginName: encryptString(objtxtlogin.value),
                Password: encryptString(objtxtpassword.value)
            }
            //End of Commented and Added by Riddhesh Patil on 11 Nov 2024 for Passing Encrypted parameters

            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/SM_Default/ForcefullyChangePassword", param, false);
            if (strResult != "") {
                if (strResult == "1") {
                    
                    sResponseText = "1";
                    window.location.href = "Default.aspx?FirstTimeLogin=1&LoginName=" + objtxtlogin.value;
                }
            }
           //End of Added By Dipali v on 29th oct 2024 For VAPT
        }
        function CheckFirstTimeLoginMobile() {
            //Added By Dipali v on 29th oct 2024 For VAPT
            //$.ajax({
            //    type: "POST",
            //    contentType: "application/json; charset=utf-8",
            //    url: 'Default.aspx/ForcefullyChangePassword',
            //    data: JSON.stringify({ LoginName: document.getElementById("txtLoginMobile").value, strPassword: document.getElementById("txtPasswordMobile").value }),
            //    async: false,
            //    success: function (data) {
            //        if (data.d == "1") {
            //            sResponseText = "1";
            //            window.location.href = "Default.aspx?FirstTimeLogin=1&LoginName=" + document.getElementById("txtLoginMobile").value;

            //            $("#txtLoginMobile").parent(".input-effect").find('label').css({ 'top': '4px', 'font-size': '10px' });
            //        }
            //    },
            //    error: function (result) {
            //        console.log(result.statusText);
            //    }
            //})

            //Commented and Added by Riddhesh Patil on 11 Nov 2024 for Passing Encrypted parameters
            //var Parameters = {
            //    LoginName: document.getElementById("txtLoginMobile").value,
            //    Password: document.getElementById("txtPasswordMobile").value
            //}
            var Parameters = {
                LoginName: encryptString(document.getElementById("txtLoginMobile").value),
                Password: encryptString(document.getElementById("txtPasswordMobile").value)
            }
            //End of Commented and Added by Riddhesh Patil on 11 Nov 2024 for Passing Encrypted parameters
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/SM_Default/ForcefullyChangePassword", param, false);
            if (strResult != "") {
                if (strResult == "1") {
                    sResponseText = "1";
                    window.location.href = "Default.aspx?FirstTimeLogin=1&LoginName=" + document.getElementById("txtLoginMobile").value;
                    $("#txtLoginMobile").parent(".input-effect").find('label').css({ 'top': '4px', 'font-size': '10px' });
                }
            }
            //End of Added By Dipali v on 29th oct 2024 For VAPT
        }


        function removeSpaces(string) {
            return string.split(' ').join('');
        }
        function login() {
            //debugger
            if (IsLoginCalled == false) {

                var loginFlag = true;

                if ($('#txtLogin').val() == "") {

                    $('#txtLogin').css('border-color', '#fecc00');
                    $('#txtLogin').css('border-width', '2px');
                    $('#SpanEmailID').text("Enter User ID ");

                    loginFlag = false;
                }
                else {
                    $('#txtLogin').css('border-color', '#d8dade');
                    $('#txtLogin').css('border-width', '1px');
                    $('#SpanEmailID').text("");
                }

                //Added By Reshma Chavan on 16th Nov 2021 to restrict Quotes
                if ($('#txtLogin').val().indexOf("'") > -1) {
                    document.getElementById("lblLoginError").innerHTML = "Invalid Login";
                    loginFlag = false;
                }
                //End of Added By Reshma Chavan on 16th Nov 2021 to restrict Quotes

                if ($('#txtPassword').val() == "") {
                    $('#txtPassword').css('border-color', '#fecc00');
                    $('#txtPassword').css('border-width', '2px');
                    $('#SpanPassword').text("Enter Password");

                    loginFlag = false;
                } else {
                    $('#txtPassword').css('border-color', '#d8dade');
                    $('#txtPassword').css('border-width', '1px');
                    $('#SpanPassword').text("");
                }

                if (loginFlag == false)
                    return;

                if (document.getElementById("divCaptcha") != null) {
                    var str2 = removeSpaces(document.getElementById('txtInput').value);
                    if (str2 == '' || str2 == 'Captcha') {
                        document.getElementById('txtInput').focus();
                        document.getElementById("lblLoginError").innerHTML = "Please Enter Captcha.";
                        return;
                    }
                }
                else {

                }
                var blnEnablePassPhrases, intPassPhrasesDays;
                var blnEnabledLockUserID, intPassLockingCount, intPassCaptchCount;

                var blnEnablePassLength = '<%=m_blnEnablePassLength %>';
                var blnEnableAlphaNumSpeChar = '<%=m_blnEnableAlphaNumSpeChar %>';
                var blnAllowSameLoginPwd = '<%=m_blnAllowSameLoginPwd %>';

                blnEnablePassPhrases = '<%=m_blnEnablePassPhrases%>';
                intPassPhrasesDays = '<%=m_intPassPhrasesDays%>';
                blnEnabledLockUserID = '<%=m_blnEnableLockUserID%>';
                intPassLockingCount = '<%=m_intPassLockingCount%>';
                intPassCaptchCount = '<%=m_intPassCaptchCount%>';

                if ('<%=strAuthenticationType%>' != 'Y' && document.getElementById("txtLogin").value != '*****') {

                    var UserName = document.getElementById("txtEncryptedUserName").value;
                    document.getElementById("txtEncryptedUserNameLength").value = UserName.length

                    var objPwd = document.getElementById("txtPassword").value;
                    var strEncryptedPwd = "";

                    for (var i = objPwd.length - 1, len = 0; i >= 0; i--) {
                        strEncryptedPwd += objPwd[i] + UserName + '|'
                    }

                    var strResult1;
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: 'Source/PasswordManagement/Ajax_XMLHttp.aspx/CheckUpdLoginDetails',
                        data: JSON.stringify({ LoginName: document.getElementById("txtLogin").value, AuthCR: strEncryptedPwd, AuthNo: UserName.length }),
                        async: false,
                        success: function (data) {

                            strResult1 = data.d;
                        },
                        error: function (result) {
                            console.log(result.statusText);
                        }
                    })
                    if (blnEnabledLockUserID == 'True' && document.getElementById("txtLogin").value != '****') {
                        if (strResult1 == '1') {
                            document.getElementById("lblLoginError").innerHTML = "Login has been locked, Contact Administrator.";
                            objtxtlogin.focus();
                            return;
                        }
                    }
                }
                
                if (document.getElementById("txtLogin").value != '****') {
                        <% If ((strAuthenticationType = "N" OrElse strAuthenticationType = "M") AndAlso (blnFirstTimeLogin = True OrElse blnEnablePwdOnReset = True)) Then%>
            CheckFirstTimeLogin();
                        <%End If%>
                }

                if (sResponseText == "1") {
                    return;
                }


                if (('<%=strAuthenticationType%>' == 'N' || '<%=strAuthenticationType%>' == 'M') && (blnEnablePassPhrases == 'True') && document.getElementById("txtLogin").value != '****') {
                     //Commented & Added By Dipali v on 29th oct 2024 For VAPT
                    //$.ajax({
                    //    type: "POST",
                    //    contentType: "application/json; charset=utf-8",
                    //    url: 'Default.aspx/GetPwdChangeDays',
                    //    data: JSON.stringify({ LoginName: document.getElementById("txtLogin").value }),
                    //    async: false,
                    //    success: function (data) {
                    //        strResult = data.d;
                    //    },
                    //    error: function (result) {
                    //        console.log(result.statusText);
                    //    }
                    //})

                    var Parameters = {
                        LoginName: document.getElementById("txtLogin").value
                    }
                    var param = JSON.stringify(Parameters);
                    var Result = AJAXCallWithResult("/api/SM_Default/GetPwdChangeDays", param, false);
                    if (Result != "") {
                        strResult = Result;

                    }
                    //End of Commented & Added By Dipali v on 29th oct 2024 For VAPT

                    //Commented and Added By Nikhil A on 24-Jul-2020 for PswDays Changes
                    //if (strResult > intPassPhrasesDays) {
                    //    window.location.href = "Default.aspx?FirstTimeLogin=1&PassPhraseDay=1&LoginName=" + document.getElementById("txtLogin").value;
                    //    return;
                    //}
                    if (strResult=="1") {
                        window.location.href = "Default.aspx?FirstTimeLogin=1&PassPhraseDay=1&LoginName=" + document.getElementById("txtLogin").value;
                        return;
                    }
                    //End Of Commented and Added By Nikhil A on 24-Jul-2020 for PswDays Changes

                }
                if (document.getElementById("txtPassword").value != '') {

                    document.getElementById("txtPasswordHide").value = document.getElementById("txtPassword").value
                    document.getElementById("txtPassword").value = '*********************';

                    document.getElementById("txtPassword").type = 'text';
                    document.getElementById("txtPassword").autocomplete = 'off';
                    document.getElementById("txtLogin").autocomplete = 'off';
                }
                //To decrypt Password
                var UserName = document.getElementById("txtEncryptedUserName").value;
                document.getElementById("txtEncryptedUserNameLength").value = UserName.length

                            var objPwd = document.getElementById("txtPasswordHide").value;
                <%--Commented  By Dipali V On 06th May 2026 For Token And Password Plaintext--%>
                //var strEncryptedPwd = "";

                //for (var i = objPwd.length - 1, len = 0; i >= 0; i--) {
                //    strEncryptedPwd += objPwd[i] + UserName + '|'
                            //}
               <%--Commented By Dipali V On 06th May 2026 For Token And Password Plaintext--%>
                document.getElementById("txtEncryptedUserName").value = strEncryptedPwd;
               // document.getElementById("txtPasswordHide").value = strEncryptedPwd;
                 //document.getElementById("txtPasswordHide").value = document.getElementById("txtPassword").value;
                //End of decrypt Password
                //debugger;
                //alert(strUrl);
               // debugger
                var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
                
                $.ajax({
                    url: strUrl_new + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async:false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                       
                       sessionStorage.setItem("access_token-I", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                         //alert(err.responseText);
                    }
                })
               var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Dashboard").ToString%>';

                $.ajax({
                    url: strUrl_new + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);

                        sessionStorage.setItem("access_token_Dashboard", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);

                    }
                })
                var strUrl_HD = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Helpdesk").ToString%>';

                $.ajax({
                    url: strUrl_HD + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);

                        sessionStorage.setItem("access_token-Helpdesk", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);

                    }
                })
                var strUrl_Issue = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>';
                $.ajax({
                    url: strUrl_Issue + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);

                        sessionStorage.setItem("access_token_Issue", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);

                    }
                })
                var strUrl_Cust = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
                //For Invoice
                $.ajax({
                    url: strUrl_Cust + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {

                        console.log(data);
                        //alert(data.access_token);
                        sessionStorage.setItem("access_token_project", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        //alert(err.responseText);
                        //console.log(err);
                    }
                })
                var strUrl_Resource = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Resource").ToString%>';
                $.ajax({
                    url: strUrl_Resource + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_resource", data.access_token);

                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                //2
                var strUrl_Invoice = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
                $.ajax({
                    url: strUrl_Invoice + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_invoice", data.access_token);

                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                //Added By Dipali V On 29th Oct  2024 For VAPT Changes
                var strUrl_Configuration = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
                $.ajax({
                    url: strUrl_Configuration + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_Configuration", data.access_token);

                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
              
                 //End of Added By Dipali V On 29th Oct  2024 For VAPT Changes
                var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
                $.ajax({
                    url: strUrl + '/token',
                    type: "POST",
                    async: false,
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        //alert(1);
                        console.log(data);
                        //alert(data.access_token);
                       sessionStorage.setItem("access_token", data.access_token);
                       // objfrm.submit();
                    },
                    error: function (err) {
                        //alert(err.responseText);
                        //console.log(err);
                    }
                })

                //Added by Vishal to add new service Timesheet
                var strUrl_Timesheet = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Timesheet").ToString%>';
                $.ajax({
                    url: strUrl_Timesheet + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token-Timesheet", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                //End of Added by Vishal to add new service Timesheet


                //Added by Ajit L on 09/10/2025 for W26API token generation
                var strUrl_W26 = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
                $.ajax({
                    url: strUrl_W26 + '/api/auth/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_W26API", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                //End of Added by Ajit L on 09/10/2025 for W26API token generation

                //Added by Madhuri.K for Token Authentication of Dashboard Service on 17/08/2026
                var strUrl_27_Dashboard = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
                $.ajax({
                    url: strUrl_27_Dashboard + 'api/auth/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLogin").value, password: document.getElementById("txtPasswordHide").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        
                        sessionStorage.setItem("access_token_W27_Dashboard", data.access_token);
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
               
                objfrm.submit();

            }
            if (IsLoginCalled == false) {
                IsLoginCalled = true;
            }
        }
        function login_Mobile() {
            if (IsLoginCalled == false) {
                var loginFlag = true;
                if ($('#txtLoginMobile').val() == "") {
                    $('#txtLoginMobile').css('border-color', '#fecc00');
                    $('#txtLoginMobile').css('border-width', '2px');
                    $('#SpanEmailIDMobile').text("Enter User ID ");
                    return;
                }
                else {
                    $('#txtLoginMobile').css('border-color', '#d8dade');
                    $('#txtLoginMobile').css('border-width', '1px');
                    $('#SpanEmailIDMobile').text("");
                }
                if ($('#txtPasswordMobile').val() == "") {
                    $('#txtPasswordMobile').css('border-color', '#fecc00');
                    $('#txtPasswordMobile').css('border-width', '2px');
                    $('#SpanPasswordMobile').text("Enter Password");
                    return;
                } else {
                    $('#txtPasswordMobile').css('border-color', '#d8dade');
                    $('#txtPasswordMobile').css('border-width', '1px');
                    $('#SpanPasswordMobile').text("");
                }
                var blnEnablePassPhrases, intPassPhrasesDays;
                var blnEnabledLockUserID, intPassLockingCount, intPassCaptchCount;
                var blnEnablePassLength = '<%=m_blnEnablePassLength %>';
                var blnEnableAlphaNumSpeChar = '<%=m_blnEnableAlphaNumSpeChar %>';
                var blnAllowSameLoginPwd = '<%=m_blnAllowSameLoginPwd %>';

                blnEnablePassPhrases = '<%=m_blnEnablePassPhrases%>';
                intPassPhrasesDays = '<%=m_intPassPhrasesDays%>';
                blnEnabledLockUserID = '<%=m_blnEnableLockUserID%>';
                intPassLockingCount = '<%=m_intPassLockingCount%>';
                intPassCaptchCount = '<%=m_intPassCaptchCount%>';

                if ('<%=strAuthenticationType%>' != 'Y' && document.getElementById("txtLoginMobile").value != 'ADMIN') {

                    var UserName = document.getElementById("txtEncryptedUserNameMobile").value;
                    document.getElementById("txtEncryptedUserNameLengthMobile").value = UserName.length

                    var objPwd = document.getElementById("txtPasswordMobile").value;
                    var strEncryptedPwd = "";

                    for (var i = objPwd.length - 1, len = 0; i >= 0; i--) {
                        strEncryptedPwd += objPwd[i] + UserName + '|'
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: 'Source/PasswordManagement/Ajax_XMLHttp.aspx/CheckUpdLoginDetails',
                        data: JSON.stringify({ LoginName: document.getElementById("txtLoginMobile").value, AuthCR: strEncryptedPwd, AuthNo: UserName.length }),
                        async: false,
                        success: function (data) {
                            strResult1 = data.d;
                        },
                        error: function (result) {
                            console.log(result.statusText);
                        }
                    })
                    if (blnEnabledLockUserID == 'True' && document.getElementById("txtLoginMobile").value != 'ADMIN') {
                        if (strResult1 == '1') {
                            document.getElementById("SpanPasswordMobile").innerHTML = "Login has been locked, Contact Administrator.";
                            objtxtlogin.focus();
                            return;
                        }

                    }
                }
                var strAuthenticationType ='<%=strAuthenticationType%>';
                var blnFirstTimeLogin = '<%=blnFirstTimeLogin%>';
                var blnEnablePwdOnReset = '<%=blnEnablePwdOnReset%>';
                if (document.getElementById("txtLoginMobile").value != 'ADMIN') {
                    if ((strAuthenticationType == 'N' || strAuthenticationType == 'M') && (blnFirstTimeLogin == 'True' || blnEnablePwdOnReset == 'True')) {
                        CheckFirstTimeLoginMobile();
                    }
                }

                if (sResponseText == "1") {
                    return;
                }

                if (('<%=strAuthenticationType%>' == 'N' || '<%=strAuthenticationType%>' == 'M') && (blnEnablePassPhrases == 'True') && document.getElementById("txtLoginMobile").value != 'ADMIN') {

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: 'Default.aspx/GetPwdChangeDays',
                        data: JSON.stringify({ LoginName: document.getElementById("txtLoginMobile").value }),
                        async: false,
                        success: function (data) {
                            strResult = data.d;
                        },
                        error: function (result) {
                            console.log(result.statusText);
                        }
                    })
                    //Commented and Added By Nikhil A on 24-July-2020
                    //if (strResult > intPassPhrasesDays) {
                    //    document.getElementById("SpanPasswordMobile").innerHTML = "As per password policy, Your password has expired, Please change the password!";
                    //    objtxtlogin.focus();
                    //    return;
                    //}
                    if (strResult =="1") {
                        document.getElementById("SpanPasswordMobile").innerHTML = "As per password policy, Your password has expired, Please change the password!";
                        objtxtlogin.focus();
                        return;
                    }
                    //End Of Commented and Added By Nikhil A on 24-July-2020
                }

                if (document.getElementById("txtPasswordMobile").value != '') {
                    document.getElementById("txtPasswordHideMobile").value = document.getElementById("txtPasswordMobile").value;
                }

                var UserName = document.getElementById("txtEncryptedUserNameMobile").value;
                document.getElementById("txtEncryptedUserNameLengthMobile").value = UserName.length

                var objPwd = document.getElementById("txtPasswordHideMobile").value;
                var strEncryptedPwd = "";

                for (var i = objPwd.length - 1, len = 0; i >= 0; i--) {
                    strEncryptedPwd += objPwd[i] + UserName + '|'
                }
                document.getElementById("txtEncryptedUserNameMobile").value = strEncryptedPwd;
                document.getElementById("txtPasswordHideMobile").value = strEncryptedPwd;

                document.getElementById("txtLoginMobile").value
                document.getElementById("mobileResponsive").value
                document.getElementById("lblLoginErrorMobile").style.display = "block";

                 var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
                
                $.ajax({
                    url: strUrl_new + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async:false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                       sessionStorage.setItem("access_token-I", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                         //alert(err.responseText);
                    }
                })
               var strUrl_new = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Dashboard").ToString%>';

                $.ajax({
                    url: strUrl_new + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_Dashboard", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);

                    }
                })
                var strUrl_hd = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Helpdesk").ToString%>';
                $.ajax({
                    url: strUrl_hd + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token-Helpdesk", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);

                    }
                });
                var strUrl_Issue = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>';
                $.ajax({
                    url: strUrl_Issue + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_Issue", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);

                    }
                })
                var strUrl_Cust = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
                //For Invoice
                $.ajax({
                    url: strUrl_Cust + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        //alert(data.access_token);
                        sessionStorage.setItem("access_token_project", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        //alert(err.responseText);
                        //console.log(err);
                    }
                })
                var strUrl_Resource = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Resource").ToString%>';
                $.ajax({
                    url: strUrl_Resource + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_resource", data.access_token);
                        // objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                //1
                var strUrl_Invoice = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
                $.ajax({
                    url: strUrl_Invoice + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_invoice", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });

                //Added by Ajit L for Token Authentication of Configuration API on 09/01/2024
                var strUrl_Configuration = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
                $.ajax({
                    url: strUrl_Configuration + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_Configuration", data.access_token);

                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                 //Added by Ajit L for Token Authentication of Configuration API on 09/01/2024

                var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

                $.ajax({
                    url: strUrl + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        //alert(1);
                       sessionStorage.setItem("access_token", data.access_token);
                      // objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })

                //Added by Ajit L for Token Authentication of Timesheet Service on 01 Feb 2025
                var strUrl_Timesheet = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Timesheet").ToString%>';
                $.ajax({
                    url: strUrl_Timesheet + '/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token-Timesheet", data.access_token);

                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
                //End of Added by Ajit L for Token Authentication of Timesheet Service on 01 Feb 2025

                var strUrl_W26 = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
                $.ajax({
                    url: strUrl_W26 + '/api/auth/token',
                    type: "POST",
                    data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    //data: { username: document.getElementById("txtLoginMobile").value, password: document.getElementById("txtPasswordMobile").value, grant_type: "password" },
                    dataType: "json",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    },
                    success: function (data) {
                        console.log(data);
                        sessionStorage.setItem("access_token_W26API", data.access_token);
                        //objfrm.submit();
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })

                objfrm.submit();
            }
            if (IsLoginCalled == false) {
                IsLoginCalled = true;
            }
        }
        var IsLoginCalled = false;
        function Password_OnKeyPress(e) {
            var code;
            if (e.keyCode) code = e.keyCode;
            else if (e.which) code = e.which;
            if (code == 13)
                login();
        }
        function PasswordM_OnKeyPress(e) {
            var code;
            if (e.keyCode) code = e.keyCode;
            else if (e.which) code = e.which;
            if (code == 13)
                login_Mobile();
        }

        function myFunction1() {
            if ($(window).width() < 1024) {

                document.getElementById("forgotpassformM").style.display = "block";
                document.getElementById("changepassformM").style.display = "none";
                document.getElementById("loginformboxformM").style.display = "none";
                $("#SpanFUserIDMobile").val('');
                $("#txtFUserIDMobile").text('');
                $("#txtEmailIDMobile").val('');
                $("#SpanFEmailIDMobile").val('');
            }
            else {
                document.getElementById("forgotpassformD").style.display = "block";
                document.getElementById("changepassformD").style.display = "none";
                document.getElementById("loginformboxformD").style.display = "none";
                $("#txtFUserID").val("");
                $("#txtEmailID").val("");
            }
        }

        function myFunction2() {
                //Added by Chetan M on 29 Dec 2020 for Refresh Issue
                //location.reload();
                //End of Added by Chetan M on 29 Dec 2020 for Refresh Issue
            if ($(window).width() < 1024) {
                document.getElementById("forgotpassformM").style.display = "none";
                document.getElementById("changepassformM").style.display = "none";
                document.getElementById("loginformboxformM").style.display = "block";
                document.getElementById("lblLoginErrorMobile").innerHTML = "";
                document.getElementById("SpanConfirmPasswordMobile").innerHTML = "";
                document.getElementById("SpanNewPasswordMobile").innerHTML = "";
                document.getElementById("SpanCPasswordMobile").innerHTML = "";
                document.getElementById("SpanUserIDMobile").innerHTML = "";
                document.getElementById("SpanEmailIDMobile").innerHTML = "";
                document.getElementById("SpanPasswordMobile").innerHTML = "";
                $('#txtLoginNameMobile').css('border-color', '#d8dade');
                $('#txtOldPasswordMobile').css('border-color', '#d8dade');
                $('#txtNewPasswordMobile').css('border-color', '#d8dade');
                $('#txtConfirmPasswordMobile').css('border-color', '#d8dade');
                $('#txtLoginMobile').css('border-color', '#d8dade');
                $('#txtPasswordMobile').css('border-color', '#d8dade');
                $('#txtLoginMobile').val('');
                $('#txtPasswordMobile').val('');
            }
            else {
                document.getElementById("forgotpassformD").style.display = "none";
                document.getElementById("changepassformD").style.display = "none";
                document.getElementById("loginformboxformD").style.display = "block";
                document.getElementById("lblLoginError").innerHTML = "";
                document.getElementById("SpanConfirmPassword").innerHTML = "";
                document.getElementById("SpanNewPassword").innerHTML = "";
                document.getElementById("SpanCPassword").innerHTML = "";
                document.getElementById("SpanUserID").innerHTML = "";
                document.getElementById("SpanEmailID").innerHTML = "";
                document.getElementById("SpanPassword").innerHTML = "";
                $('#txtLoginName').css('border-color', '#d8dade');
                $('#txtOldPassword').css('border-color', '#d8dade');
                $('#txtNewPassword').css('border-color', '#d8dade');
                $('#txtConfirmPassword').css('border-color', '#d8dade');
                $('#txtLogin').css('border-color', '#d8dade');
                $('#txtPassword').css('border-color', '#d8dade');
                $('#txtLogin').val('');
                $('#txtPassword').val('');
                 //added by Dipali V On 27th Aug 2020 For Alert Clear On click on cancel Button
                document.getElementById("SpanFUserID").innerHTML = "";
                document.getElementById("SpanFEmailID").innerHTML = "";
                 //End of added by Dipali V On 27th Aug 2020 For Alert Clear On click on cancel Button


            }
            //Added by Chetan M on 29 Dec 2020 for Refresh Issue
            //location.reload();
            //End of Added by Chetan M on 29 Dec 2020 for Refresh Issue
        }

        function myFunction3() {
            if ($(window).width() < 1024) {
                document.getElementById("forgotpassformM").style.display = "none";
                document.getElementById("changepassformM").style.display = "block";
                document.getElementById("loginformboxformM").style.display = "none";
                ClearTextBoxmyFunction3();
            }
            else {
                document.getElementById("forgotpassformD").style.display = "none";
                document.getElementById("changepassformD").style.display = "block";
                document.getElementById("loginformboxformD").style.display = "none";
                ClearTextBoxmyFunction3();
            }
        }

        function ClearTextBoxmyFunction3() {
            if ($(window).width() < 1024) {
                $("#txtLoginNameMobile").val('');
                $("#txtOldPasswordMobile").val('');
                $("#txtNewPasswordMobile").val('');
                $("#txtConfirmPasswordMobile").val('');

                $("#txtLoginNameMobile").parent(".input-effect").find('label').css({ 'top': '4px', 'font-size': '18px' });
                $("#txtOldPasswordMobile").parent(".input-effect").find('label').css({ 'top': '4px', 'font-size': '18px' });
                $("#txtNewPasswordMobile").parent(".input-effect").find('label').css({ 'top': '4px', 'font-size': '18px' });
                $("#txtConfirmPasswordMobile").parent(".input-effect").find('label').css({ 'top': '4px', 'font-size': '18px' });

            }
            else {
                $("#txtLoginName").val('');
                $("#txtOldPassword").val('');
                $("#txtNewPassword").val('');
                $("#txtConfirmPassword").val('');

            }

        }

        var inputs = document.getElementsByTagName('input');

        for (var i = 0; i < inputs.length; i++) {
            var input = inputs[i];
            input.addEventListener('input', function () {
                $(this).parent(".input-effect").find('label').css({ 'top': '-16px', 'font-size': '12px' });
                this.value ? ($(this).parent(".input-effect").find('label').css({ 'top': '-16px', 'font-size': '12px' })) : ($(this).parent(".input-effect").find('label').css({ 'top': '4px', 'font-size': '18px' }));
            });
        }
    </script>

</body>
</html>
