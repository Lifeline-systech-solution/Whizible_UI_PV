<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Source/WhizibleHelp/MasterPage/Help.Master" CodeBehind="RM_EmployeeMaster_Help.aspx.vb" Inherits="PbNIT.RM_EmployeeMaster_Help" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title> Employee Master</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper">
        <!-- Page Content Holder -->
        <div id="maincontainer">
            <div class="mainheader">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <div class="container-fluid">
                        <div class="headerTop">
                            <div class="pgname">
                                <h3>Excel Upload</h3>
                                <nav class="" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Resources</a></li>
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Manage</a></li>
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Employee or Resource Master</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Excel Upload</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <div class="page_content">
                <div class="row">
                    <div class="col-md-9">
                        <p>During the initial implementation of the system Employee information is gathered in an excel in the below mentioned template and uploaded into the system.</p>
                        <p>The template contains only the minimum required fields, which would make the related functionalities usable. However the system has to be configured to make the pre-requisite data available for the upload to be successful.</p>
                        <section id="listView" class="my-5">
                            <h4>List View</h4>
                            <img src="../../../Whizible2.0/assets/images/excel-upload-list-view.png" class="img-fluid my-3" alt="Excel Upload List View" />
                            <div class="alert grade-alert text-center" role="alert">
                                The Objective of Excel Upload is to reduce the efforts required in creating each employee in the system manually.
                            </div>
                        </section>
                        <section id="credits" class="mb-5">
                            <h4>Credits</h4>
                            <p>This feature would be highly used during the initial implementation as bulk employee information would be required to be uploaded. And would be used by the Tool Administrators or the HR Managers.</p>
                        </section>
                        <section id="access" class="mb-5">
                            <h4>Access</h4>
                            <ol class="mt-3">
                                <li>Whizible is a role-based system, hence menu access is configurable in the roles access.</li>
                                <li>Admin user can configure access for a role, to a menu option with <strong>ADD</strong>, <strong>EDIT</strong>, <strong>DELETE</strong> and <strong>VIEW</strong> permissions.</li>
                                <li>Excel upload options would appear based on role access.</li>
                            </ol>
                            <div class="alert access-alert d-flex align-items-center" role="alert">
                                <img src="../../../Whizible2.0/assets/images/alert-icon.png" class="me-2" width="25" alt="Alert Icon" />
                                <div>
                                    <a href="javascript: void(0);">Click to learn more about access privileges, Role access</a>
                                </div>
                            </div>
                        </section>
                        <section id="addNew" class="mb-5">
                            <h4>Adding New Excel upload file</h4>
                            <p>The upload UI shall be wizard where there user shall be able to perform the below steps</p>
                            <ol class="mt-3">
                                <li><strong>Step 1</strong> - Select an excel file with columns, User shall also be able to drag and drop. The system shall validate the file at this level and allow only a valid excel file.</li>
                                <li><strong>Step 2</strong> - The system shall provide a list of all destination fields with an option to map excel columns. The system shall mandate mapping of columns which are mentioned as mandatory in the Resource Master (refer table below).</li>
                                <li><strong>Step 3</strong> - The system shall have an option to validate data in the excel and provide an option to upload the information from the excel to the system. The system shall also display error messages if any and a summary on successful upload. For validation of the fields refer to the table below.</li>
                            </ol>
                            <div class="text-center">
                                <img src="../../../Whizible2.0/assets/images/adding-new-excel-upload-1.png" class="img-fluid" alt="Adding New Excel Upload 1" />
                                <img src="../../../Whizible2.0/assets/images/adding-new-excel-upload-2.png" class="img-fluid mt-4" alt="Adding New Excel Upload 2" />
                                <img src="../../../Whizible2.0/assets/images/adding-new-excel-upload-3.png" class="img-fluid mt-4" alt="Adding New Excel Upload 3" />
                            </div>
                        </section>
                        <section id="UIElement" class="mb-5">
                            <h4>UI Element / Label</h4>
                            <div class="ui-element-table mt-3 table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>UI Element / Label</th>
                                            <th>Description</th>
                                            <th>Type</th>
                                            <th>Size</th>
                                            <th>Mandatory (Yes/No)</th>
                                            <th>Validation Rule</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Employee Name</td>
                                            <td>This text box captures full name of the Employee.</td>
                                            <td>Alphanumeric,</td>
                                            <td>50</td>
                                            <td>Yes</td>
                                            <td>First Name should be alphanumeric and can have maximum of 40 characters.</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Username</td>
                                            <td>This is a Unique Username /login name which the system shall use during login id creation.</td>
                                            <td>Alphanumeric,</td>
                                            <td>10</td>
                                            <td>Yes</td>
                                            <td>1. Checked for Uniqueness across the Employees</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Employee Code</td>
                                            <td>Should match the Organization Employee Code</td>
                                            <td>Alphanumeric,</td>
                                            <td>10</td>
                                            <td>Yes</td>
                                            <td>1. Checked for Uniqueness across the Employees</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Gender</td>
                                            <td></td>
                                            <td>Text</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Shall be checked with system values</td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>Email ID</td>
                                            <td>Valid Email ID</td>
                                            <td>Alphanumeric</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Enter Valid Email ID</td>
                                        </tr>
                                        <tr>
                                            <td>6</td>
                                            <td>Birth Date</td>
                                            <td></td>
                                            <td>Date</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>
                                                1. Date should be validated for non Minor (or age > 18 Year)<br />
                                                2. Format - DD-MMM-YY
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>7</td>
                                            <td>Department</td>
                                            <td>Value from the existing list of Departments from the Department Master</td>
                                            <td>Alphanumeric</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Shall be checked with Master values</td>
                                        </tr>
                                        <tr>
                                            <td>8</td>
                                            <td>Role</td>
                                            <td>Value from the existing list of Roles from the Role Master</td>
                                            <td>Alphanumeric</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Shall be checked with Master values</td>
                                        </tr>
                                        <tr>
                                            <td>9</td>
                                            <td>Designation</td>
                                            <td>Value from the existing list of Designations from the Designation Master</td>
                                            <td>Alphanumeric</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Shall be checked with Master values</td>
                                        </tr>
                                        <tr>
                                            <td>10</td>
                                            <td>Employee Type</td>
                                            <td>Value from the existing system types</td>
                                            <td>Text</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Shall be checked with System values</td>
                                        </tr>
                                        <tr>
                                            <td>11</td>
                                            <td>Joining Date</td>
                                            <td>Employee Organization Joining Date</td>
                                            <td>Date</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Format - DD-MMM-YY</td>
                                        </tr>
                                        <tr>
                                            <td>12</td>
                                            <td>Reporting to</td>
                                            <td>Value from the existing Employee list</td>
                                            <td>Text</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>
                                                1. Shall be checked within Employee Master<br />
                                                2. Need to specify the Username of the Manager
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>13</td>
                                            <td>Business Group</td>
                                            <td>Value from the existing list of Active Business Groups</td>
                                            <td>Selection</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Shall be checked with Master values</td>
                                        </tr>
                                        <tr>
                                            <td>14</td>
                                            <td>Organization Unit</td>
                                            <td>Value from the existing list of Active Organization Units mapped to selected Business Group</td>
                                            <td>Selection</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>
                                                1. Shall be checked with Master values<br />
                                                2. And should be associated to the Business Group Record
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>15</td>
                                            <td>Rate / Hour</td>
                                            <td>Default Zero</td>
                                            <td>Decimal</td>
                                            <td>5.2</td>
                                            <td>Yes</td>
                                            <td>1. Should be a positive value</td>
                                        </tr>
                                        <tr>
                                            <td>16</td>
                                            <td>Cost / Hour</td>
                                            <td>Default Zero</td>
                                            <td>Decimal</td>
                                            <td>5.2</td>
                                            <td>Yes</td>
                                            <td>1. Should be a positive value</td>
                                        </tr>
                                        <tr>
                                            <td>17</td>
                                            <td>Currency</td>
                                            <td>Value from the existing Currency Relative to the Rate , Cost and CTC</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td>1. Shall be checked with Master values</td>
                                        </tr>
                                        <tr>
                                            <td>18</td>
                                            <td>Cost to Company</td>
                                            <td>Default Zero</td>
                                            <td>Decimal</td>
                                            <td>9.2</td>
                                            <td>Yes</td>
                                            <td>1. Should be a positive value</td>
                                        </tr>
                                        <tr>
                                            <td>19</td>
                                            <td>Deployable</td>
                                            <td>Value from the existing list of system values (Yes, No)</td>
                                            <td>Selection</td>
                                            <td></td>
                                            <td>Yes</td>
                                            <td>1. Shall be checked with System values</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <section id="businessRules">
                            <div class="business-rules">
                                <div class="business-heading">
                                    <h4>Business Rules</h4>
                                </div>
                                <div class="inner-content">
                                    <ol class="mt-3">
                                        <li>
                                            System shall check for the respective master have been pre-configured.
                                            <ol type="a" class="mt-2">
                                                <li>Department</li>
                                                <li>Role</li>
                                                <li>Designation</li>
                                                <li>Business Group</li>
                                                <li>Organization Unit</li>
                                                <li>Currency</li>
                                            </ol>
                                        </li>
                                        <li>The system shall upload all valid rows during an upload.</li>
                                        <li>The system shall create a error log against the invalid records and provide link to download the error file.</li>
                                    </ol>
                                </div>
                            </div>
                        </section>
                        <section id="UIRelatedValidations">
                            <div class="ui-section">
                                <div class="ui-heading">
                                    <h4>Other UI related Validations</h4>
                                </div>
                                <div class="inner-content">
                                    <ul class="mt-3">
                                        <li><strong>Delete Validation</strong> – If the employee is allocated to project or the dependency of the employee is created anywhere in the system then the employee cannot be deleted.</li>
                                        <li><strong>Text validation</strong> – Text Size and for field related validation refer the table above.</li>
                                    </ul>
                                </div>
                            </div>
                        </section>
                        <section id="seeSection">
                             <%--Added By Imran Mujawar on 23-01-2022 For getting Help link Access--%>
                            <%If m_IsLinkActiveAccess = "True" %>
                            <h4>See Also</h4>
                            <ul class="mt-3">
                                <li><a href="javascript:;">Role access</a></li>
                                <li><a href="javascript:;">Create Employee</a></li>
                            </ul>
                            <%End If %>
                            <%--End of Added By Imran Mujawar on 23-01-2022 For getting Help link Access--%>
                        </section>
                        <section class="comments">
                            <div class="row">
                                <div class="col-md-12">
                                    <h5 class="mb-4 mt-2">Helpful?</h5>
                                    <i class="far fa-thumbs-up me-4 position-relative" id="BtnLike"><span class="badge badge-green" id="Like"></span></i>
                                    <i class="far fa-thumbs-down me-4 ms-2 position-relative" id="BtnDisLike"><span class="badge badge-red" id="DisLike"></span></i>
                                    <i class="far fa-comment-alt ms-2 position-relative" data-bs-toggle="modal" data-bs-target="#comments" id="Btncomment"><span class="badge badge-blue" id="Comments"></span></i>
                                    <div class="modal fade" id="comments" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4>Comments</h4>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                 <div class="modal-body" id="C1">
                                                    <form>
                                                        <div class="mb-3">
                                                            <label for="comment" class="form-label">Write Your Comments :</label>
                                                            <textarea class="form-control" id="comment" rows="3"></textarea>
                                                        </div>
                                                    </form>
                                                </div>
                                               <div class="modal-footer" id="C2">
                                                    <button type="submit" class="btn loginbtn mt-2" id="BtnPost">Post</button>
                                                </div>
                                                <div class="row mb-2" style="padding: 1rem;">
                                                    <div class="col-md-12">
                                                        <a href="#!" onclick="DoShowTable()" id="ShowText"><u id="txtvcomment">View Comments</u> <span id="CCount"></span></a>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input id="hdid" type="hidden" value="0" /></div>
                                                </div>

                                                <div id="ShowTable" style="padding: 1rem; width: 100%!important;">
                                                    <table id="tablewk" class="table table-bordered GmTbllist" style="width: 100%;">
                                                        <thead id="CommentThHead">
                                                            <tr>
                                                                <th class="" width="150">ID</th>
                                                                <th class="" width="150">Comments</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="CommentTable"></tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div class="col-xl-3 mt-4 mt-lg-0 rightpanel">
                        <div class="make-me-sticky right-sidebar">
                            <nav class="section-nav">
                                <div class="accordion_container">
                                    <div class="sub-list-heading accordion_head mb-3">Current page <span class="plusminus">+</span></div>
                                    <ul class="currentPage accordion_body">
                                        <li><a href="#listView"><img src="../../../Whizible2.0/assets/images/list-icon.svg" class="me-3" width="18" alt="" />List View</a></li>
                                        <li><a href="#credits"><img src="../../../Whizible2.0/assets/images/benefit-icon.svg" class="me-3" width="18" alt="" />Credits</a></li>
                                        <li><a href="#access"><img src="../../../Whizible2.0/assets/images/access-icon.svg" class="me-3" width="18" alt="" />Access</a></li>
                                        <li><a href="#addNew"><img src="../../../Whizible2.0/assets/images/add-grade-icon.svg" class="me-3" width="18" alt="" />Adding New Excel upload file</a></li>
                                        <li><a href="#UIElement"><img src="../../../Whizible2.0/assets/images/ui-icon.svg" class="me-3" width="18" alt="" />UI Element / Label</a></li>
                                        <li><a href="#businessRules"><img src="../../../Whizible2.0/assets/images/business-rules-icon.svg" class="me-3" width="18" alt="" />Business Rules</a></li>
                                        <li><a href="#UIRelatedValidations"><img src="../../../Whizible2.0/assets/images/ui-validations-icon.svg" class="me-3" width="18" alt="" />Other UI related Validations</a></li>
                                    </ul>
                                    <div class="my-4 list-icon">
                                        <div class="sub-list-heading accordion_head">Most Visited Pages <span class="plusminus">+</span></div>
                                        <div class="moreLess accordion_body" data-city="mostVisited" id="MostVisited"> </div>
                                    </div>
                                    <div class="mb-4 list-icon">
                                        <div class="sub-list-heading accordion_head">Recent Updated Document <span class="plusminus">+</span></div>
                                        <div class="moreLess accordion_body" data-city="recentUpdated" id="RecentUpdated"> </div>
                                    </div>
                                    <div class="list-icon">
                                        <div class="sub-list-heading accordion_head">Most Rated Help Document <span class="plusminus">+</span></div>
                                        <div class="moreLess accordion_body" data-city="mostRated" id="MostLiked"></div>
                                    </div>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div href="#" id="scrollToPageTop"><i class="fas fa-chevron-up"></i></div>
    </div>

    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Help").ToString%>';
        var LoginType = '<%= Session("LoginType") %>';
        var EmployeeId = '<%= Session("intUserId") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var IsCreatedByCustomer = '<%= Session("IsCreatedByCustomer") %>';

        $(document).ready(function ()
        {
            StartLoader("#body-Progressbar");
            MostVistedPerson();
            MostLiked();
            MostRecentUpdated();
            FillLikeDislikeCount();
            StopAjaxLoader("#body-Progressbar");
            $('.show-more').on('click', function () {
                $('.ty-compact-list:gt(2)').toggle();
                $(this).text() === 'More' ? $(this).text('Less') : $(this).text('More');
            });
        });

        // Added by imran on 08-02-2022-2022
        function FillLikeDislikeCount() {
            var parameter = {
                TagID: "23",
                EmployeeID: EmployeeId,
                IsCreatedByCustomer: IsCreatedByCustomer,
                LoginType: LoginType
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/Common_Help/GetLikeDislikeCount", param, false);
            if (data.length != 0) {
                for (var i = 0; i <= data.length - 1; i++) {
                    var GradeResult = data[i];
                    $("#Like").text(GradeResult.Likes);
                    $("#DisLike").text(GradeResult.DisLikes);
                    $("#Comments").text(GradeResult.Comments);

                    if (GradeResult.Liked == 1) {
                        $('#BtnLike').addClass('fas fa-thumbs-up');
                        $('#BtnDisLike').addClass('far fa-thumbs-down');
                        $('#BtnDisLike').removeClass('fas fa-thumbs-up');
                    }

                    if (GradeResult.Disliked == 1) {
                        $('#BtnLike').removeClass('fas fa-thumbs-up');
                        $('#BtnDisLike').removeClass('fas fa-thumbs-down');
                        $('#BtnLike').addClass('far fa-thumbs-up');
                        $('#BtnDisLike').addClass('fas fa-thumbs-down');
                    }

                    if (GradeResult.CheckComment >= 1) {
                        $('#Btncomment').addClass('fas fa-comment-alt'); 
                        $("#ShowText").show();
                    }
                    else {
                        $("#ShowText").hide();
                        $('#Btncomment').removeClass('fas fa-comment-alt');
                        $('#Btncomment').addClass('far fa-comment-alt');
                    }
                }
            }
            else {
                $("#Like").text(0);
                $("#DisLike").text(0);
                $("#Comments").text(0);
            }

        }
        //End Of comment by imran on 08-02-2022-2022

        // Added by imran on 08-02-2022-2022
        $("#BtnLike").click(function () {
            var parameter = {
                TagID: "23",
                EmployeeID: EmployeeId,
                LoginType: LoginType,
                IsCreatedByCustomer: IsCreatedByCustomer,
                Liked: 1,
                DisLiked: 0
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/Common_Help/SaveLikeDislike", param, false);
            if (data.length != 0) {
                FillLikeDislikeCount();
            }
        });
        //End Of comment by imran on 08-02-2022-2022

        // Added by imran on 08-02-2022-2022
        $("#BtnDisLike").click(function () {
            var parameter = {
                TagID: "23",
                EmployeeID: EmployeeId,
                LoginType: LoginType,
                IsCreatedByCustomer: IsCreatedByCustomer,
                Liked: 0,
                DisLiked: 1
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/Common_Help/SaveLikeDislike", param, false);
            if (data.length != 0) {
                FillLikeDislikeCount();
            }
        });
        //End Of comment by imran on 08-02-2022-2022

        // Added by imran on 08-02-2022-2022
        $("#BtnPost").click(function () {
            var comment = $("#comment").val();
            if (comment == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Comment Cannot Be Blank");
                $("#comment").focus();
            }
            else {
                comment = comment.replace(/'/g, "''")
                var parameter =
                {
                    TagID: "23",
                    EmployeeID: EmployeeId,
                    LoginType: LoginType,
                    comments: comment
                }
                var param = JSON.stringify(parameter);
                var data = AJAXCallWithResult("/api/Common_Help/PostComments", param, false);
                if (data.length != 0) {
                    $('#comments').modal('hide')
                    $("#comment").val('');
                    FillLikeDislikeCount();
                }
            }

        });
        //End Of comment by imran on 08-02-2022-2022

        // Added by imran on 08-07-2022
        $("#Btncomment").click(function () {
            $("#ShowTable").hide();
            GetComments();
        });
        //End Of comment by imran on 08-07-2022

        // Added by imran on 08-07-2022
        function DoShowTable() {
            var k = $("#hdid").val();
            if (k == 0) {
                $("#ShowTable").show();
                $("#C1").hide();
                $("#C2").hide();
                $("#hdid").val(1);
                $("#txtvcomment").text("Hide Comment");
            }
            else {
                $("#txtvcomment").text("View Comment");
                $("#hdid").val(0);
                $("#ShowTable").hide();
                $("#C1").show();
                $("#C2").show();
            }
        }
        //End Of comment by imran on 08-02-2022-2022

        // Added by imran on 08-02-2022-2022
        function GetComments() {
            var parameter =
            {
                TagID: "23",
                EmployeeID: EmployeeId,
                LoginType: LoginType
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/Common_Help/GetAllCommentByUser", param, false);
            var Tcount = 0;
            var strHTML = '';
            if (data.length != 0) {
                for (var i = 0; i < data.length; i++) {
                    Tcount++;
                    strHTML += '<tr>'
                    strHTML += '<td>' + (i + 1) + '</td>'
                    strHTML += '<td>' + data[i]["comments"] + '</td>'
                    strHTML += '</tr>'
                }
                document.getElementById("CCount").innerHTML = "(" + Tcount + ")";
                $('#tablewk').dataTable().fnDestroy();
                $("#CommentTable").html('');
                $("#CommentTable").append(strHTML);
                $("#tablewk").dataTable({
                    "scrollY": true,
                    "scrollX": true,
                    "pageLength": 5,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "responsive": true
                });
            }
        }
        //End Of comment by imran on 08-02-2022-2022

        // Added by imran on 08-02-2022-2022 Most Visited Person
        function MostVistedPerson() {
            $("#MostVisited").html('');
            var parameter =
            {
                TagID: "23"
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/Common_Help/GetMostVisitedPages", param, false);
            var strHTML = '';
            if (data.length != 0) {
                strHTML += '<ul style="margin-bottom: 0;">';
                for (var i = 0; i < data.length; i++) {
                    strHTML += '<li class="ty-compact-list"><a href="javascript:;">' + data[i].TagName + '</a></li>';
                }
                strHTML += '</ul>';
                strHTML += '<a href="javascript:;" class="myBtn mt-2 show-more">More</a>';
                $("#MostVisited").append(strHTML);
                if ($('.ty-compact-list').length > 3) {
                    $('.ty-compact-list:gt(2)').hide();
                    $('.show-more').show();
                }
            }
        }
        //End Of comment by imran on 08-02-2022-2022

        // Added by imran on 08-02-2022 Most Liked
        function MostLiked() {
            $("#MostLiked").html('');
            var parameter =
            {
                TagID: "23"
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/Common_Help/GetMostVisitedLikes", param, false);
            var strHTML = '';
            if (data.length != 0) {
                strHTML += '<ul style="margin-bottom: 0;">';
                for (var i = 0; i < data.length; i++) {
                    strHTML += '<li><a href="javascript:;">' + data[i].TagName + '</a></li>';
                }
                strHTML += '</ul>';
                $("#MostLiked").append(strHTML);
            }
        }
        //End Of comment by imran on 08-02-2022

        // Added by imran on 08-02-2022 Most LikeRecent Updated
        function MostRecentUpdated()
        {
            $("#RecentUpdated").html('');
            var parameter =
            {
                TagID: "23"
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/Common_Help/GetMostRecentUpdated", param, false);
            var strHTML = '';
            if (data.length != 0) {
                strHTML += '<ul style="margin-bottom: 0;">';
                for (var i = 0; i < data.length; i++) {
                    strHTML += '<li><a href="javascript:;">' + data[i].TagName + '</a></li>';
                }
                strHTML += '</ul>';
                $("#RecentUpdated").append(strHTML);
            }
        }
        //End Of comment by imran on 08-02-2022

        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Help"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    alert(err.responseText);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    console.log(err);
                }
            });
            return ajaxResult;
        }
    </script>
</asp:Content>