<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Demo.aspx.vb" Inherits="PbNIT.Demo" %>

<!DOCTYPE html>

<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../../responsive/jquery/jquery-2.1.3.min.js"></script>
    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        $(document).ready(function () {
            $.ajax({
                url: strUrl + '/token',
                type: "POST",
                data: { username: "Test", password: "Test", grant_type: "password" },
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                },
                success: function (data) {
                    localStorage.setItem("access_token", data.access_token);
                    CheckPostService()
                },
                error: function (err) {
                    console.log(err);
                }
            })
        })
        function CheckPostService() {

            $.ajax({
                url: strUrl + '/api/Demo/GetDemos',
                type: "POST",
                data: {},
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                },
                success: function (data) {
                    console.log(data);
                    $("#divMain").html('');
                    var strHTML = "";
                    var selHTML = "";
                    strHTML += "<table>"
                    for (var i = 0; i < data.length; i++) {
                        var d = data[i];
                        var demoID = d.DemoID;
                        var DemoName = d.DemoName;
                        strHTML += "<tr>"
                        strHTML += "<td>"
                        strHTML += demoID;
                        strHTML += "</td>"
                        strHTML += "<td>"
                        strHTML += DemoName;
                        strHTML += "</td>"
                        strHTML += "</tr>"

                        selHTML += "<option value='" + demoID + "'>" + DemoName + "</option>"
                    }

                    strHTML += "</table>"
                    $("#divMain").html(strHTML);
                    $("#selMain").html(selHTML);
                    
                },
                error: function (err) {
                    console.log(err);
                }
            })
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divMain">
        </div>
        <select id="selMain">
            <option value="value">text</option>
        </select>
    </form>
</body>
</html>--%>
<html lang="en">
        <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
 <%CommonFunctions.General.PlotPageHeadTag("Bootstrap Example")%>
<head>
<%--    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

</head>
        <style type="text/css">
        .checkbox {
            padding-left: 20px;
        }

            .checkbox label {
                display: inline-block;
                position: relative;
                padding-left: 5px;
            }

                .checkbox label::before {
                    content: "";
                    display: inline-block;
                    position: absolute;
                    width: 17px;
                    height: 17px;
                    left: 0;
                    margin-left: -20px;
                    border: 1px solid #cccccc;
                    border-radius: 3px;
                    background-color: #fff;
                    -webkit-transition: border 0.15s ease-in-out, color 0.15s ease-in-out;
                    -o-transition: border 0.15s ease-in-out, color 0.15s ease-in-out;
                    transition: border 0.15s ease-in-out, color 0.15s ease-in-out;
                }

                .checkbox label::after {
                    display: inline-block;
                    position: absolute;
                    width: 16px;
                    height: 16px;
                    left: 0;
                    top: 0;
                    margin-left: -20px;
                    padding-left: 3px;
                    padding-top: 1px;
                    font-size: 11px;
                    color: #555555;
                }

            .checkbox input[type="checkbox"] {
                opacity: 0;
            }

                .checkbox input[type="checkbox"]:focus + label::before {
                    outline: thin dotted;
                    outline: 5px auto -webkit-focus-ring-color;
                    outline-offset: -2px;
                }

                .checkbox input[type="checkbox"]:checked + label::after {
                    font-family: 'FontAwesome';
                    content: "\f00c";
                }

                .checkbox input[type="checkbox"]:disabled + label {
                    opacity: 0.65;
                }

                    .checkbox input[type="checkbox"]:disabled + label::before {
                        background-color: #eeeeee;
                        cursor: not-allowed;
                    }

            .checkbox.checkbox-circle label::before {
                border-radius: 50%;
            }

            .checkbox.checkbox-inline {
                margin-top: 0px;
                margin-bottom: 15px;
            }

        .taskexceed {
            vertical-align: middle;
            width: 80px;
            margin-left: 20px;
            height: 28px;
        }

        .taskstatus {
            display: inline-flex;
        }

        .align-bottom {
            margin-bottom: 20px;
        }

        .numbers {
            margin-left: 10px;
            vertical-align: middle;
            margin-top: 5px;
        }

        .border-bottom {
            border-bottom: 2px solid #337ab7;
            width: 40px;
            padding-top: 10px;
        }

        .approval {
            border-bottom: 2px solid #337ab7;
            width: 60px;
            padding-top: 10px;
        }

        .col-lg-12, .col-md-12, .col-sm-12, .col-xs-12 {
            padding-left: 0px !important;
        }
    </style>
<body>



    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h4>Alerts and Notificatiion</h4>
                <hr>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 align-bottom">
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="form-group">
                        <label class="control-label">Select User</label>
                        <select class="form-control">
                            <option></option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <div class="form-group">
                        <button class="btn btnyellow" id="btnSave" onclick="Save_OnClick()">Save</button>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 align-bottom">
                <h5 class="border-bottom">Tasks</h5>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 align-bottom taskstatus">
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-8 ">
                    <div class="checkbox checkbox-inline">
                        <input type="checkbox" id="inlineCheckbox1" value="option1">
                        <label for="inlineCheckbox1">No of overdue tasks exceed</label>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-4 taskstatus">
                    <input type="text" class="form-control taskexceed" />
                    <span class="numbers">Numbers</span>
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 align-bottom taskstatus">
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-8 ">
                    <div class="checkbox checkbox-inline">
                        <input type="checkbox" id="inlineCheckbox2" value="option1">
                        <label for="inlineCheckbox2">The Task has exceeded More than</label>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-4 taskstatus">
                    <input type="text" class="form-control taskexceed" />
                    <span class="numbers">Day's</span>
                </div>
            </div>

            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 align-bottom">
                <h5 class="approval">Approval</h5>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 align-bottom taskstatus">
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-8 ">
                    <div class="checkbox checkbox-inline">
                        <input type="checkbox" id="inlineCheckbox3" value="option1">
                        <label for="inlineCheckbox3">Accepatance pending More than</label>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-4 taskstatus">
                    <input type="text" class="form-control taskexceed" />
                    <span class="numbers">Day's</span>
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 align-bottom taskstatus">
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-8 ">
                    <div class="checkbox checkbox-inline">
                        <input type="checkbox" id="inlineCheckbox4" value="option1">
                        <label for="inlineCheckbox4">Approval pending More than</label>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-4 taskstatus">
                    <input type="text" class="form-control taskexceed" />
                    <span class="numbers">Day's</span>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
