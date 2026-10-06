<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LoginConfigurationPage.aspx.vb" Inherits="PbNIT.LoginConfigurationPage" %>

<!DOCTYPE html>

<html>
    <%CommonFunctions.General.PlotPageHeadTag("Print Expense Sheet")%>
<head runat="server">

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script> -->
<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/editor.css" />
<script src="../../Whizible2.0-new/dist/js/editor.js"></script>
    <title></title>
    <style>
        /*html,body,form,.Editor-container{
            height: 100%!important;
        }
        #FreeTextBox_editor{
            overflow: scroll!important;
            height: 100%!important;
        }*/
        
        #menuBarDiv > .btn-group:nth-of-type(4) {
            display: none;
        }
        #menuBarDiv > .btn-group:nth-of-type(5) {
            display: none;
        }


        #menuBarDiv > .btn-group:nth-of-type(7) {
            display: none;
        }

        #menuBarDiv > .btn-group:nth-of-type(8) {
            display: none;
        }

        #menuBarDiv > .btn-group:nth-of-type(9) {
            display: none;
        }
        #menuBarDiv a.btn[title="Unlink"] {display:none;
        }
        #menuBarDiv a.btn[title="Insert Image"] {display:none;
        }
        #menuBarDiv a.btn[title="Insert Table"] {display:none;
        }
    </style>
</head>
   
<body>
    <form id="form1" runat="server">
        <div>
             <input type="button" class="btn btn-info" name="Save" onclick="Save_OnClick()" value="Save" style="margin-left: 5px;margin-top: 5px;" />
             <textarea class="editor" rows="3" name="FreeTextBox" id="FreeTextBox"></textarea>
                        <input type="hidden" id="freeHidden" name="freeHidden" />
        </div>
    </form>
</body>

<script type="text/javascript">

    $(document).ready(function () {
        
        $("#FreeTextBox").Editor();

        var result = AjaxCall('LoginConfigurationPage.aspx/GetLoginConfiguration', JSON.stringify({}))
        $("#FreeTextBox_editor").html(result.d);
    });

    function Save_OnClick() {
      
        var ConfiText = $("#FreeTextBox_editor").html();
      
        var result = AjaxCall('LoginConfigurationPage.aspx/SaveLoginConfiguration', JSON.stringify({ ConfiText: ConfiText }) )
        if (result.d == "1") {
            alert("Data Saved Successfully!!");
        }
    }
    function AjaxCall(url, data) {
        var ajaxresult;
        $.ajax({
            url: url,
            data: data,
            type: "POST",
            contentType: "application/json",
            async: false,
            data: data,
            dataType : "json",   
            success: function (result) {
                ajaxresult = result;
            },
            error: function (xhr) {
               
            }

        })
        return ajaxresult;
    }


</script>
</html>
