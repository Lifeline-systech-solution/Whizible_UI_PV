<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Source/WhizibleHelp/MasterPage/Help.Master" CodeBehind="RM_Designation_help.aspx.vb" Inherits="PbNIT.RM_Designation_help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Designation Master</title>
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
                                <h3>Designation</h3>
                                <nav class="" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Resources</a></li>
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Plan</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Designation</li>
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
                        <p><strong>Designation</strong> can be defined as the post or position that the <strong>resource</strong> holds in the <strong>organization</strong>.</p>
                        <p>In Whizible, it is an attribute of the <strong>leaves</strong>, a <strong>resource</strong> can avail. It specifically eases the HR's job of <strong>managing designations</strong> in the <strong>organization</strong>.</p>
                        <p>You should use the <strong>Designation Master</strong> to maintain a repository of the <strong>designations</strong> in your <strong>organization</strong> and map its associated attributes.</p>
                        <section id="listView" class="my-5">
                            <h4>List View</h4>
                            
                            <img src="../../../Whizible2.0/assets/images/designation-help-image.png" class="img-fluid my-3" alt="Designation Help" />
                            <p><strong>Designation Master</strong> is the repository where in you can add and maintain the <strong>Designation Master</strong> against <strong>Employee</strong>. Example of <strong>Designation</strong> can be any: <strong>Developer</strong>, <strong>Team Lead</strong>, <strong>Project Manager</strong> Etc.</p>
                            <p><strong>Designation Master</strong> can be added in the master through the below Screens further for Details of S <strong>Designation Master</strong> can be mapped with <strong>Leaves</strong> fetched through <strong>Leave Master</strong>. Where <strong>Multiple leaves</strong> and <strong>Leave Details</strong> can be mapped to a Selected <strong>Designation</strong>.</p>
                            <img src="../../../Whizible2.0/assets/images/designation-list-view.png" class="img-fluid my-3" alt="Designation List View" />
                            <img src="../../../Whizible2.0/assets/images/designation-list-view-detail.png" class="img-fluid my-3" alt="DesignationList View Detail" />
                            <div class="alert grade-alert text-center" role="alert">
                                Designation defines a Post or Position of an Employee in the Organization.
                            </div>
                        </section>
                        <section id="benefits" class="mb-5">
                            <h4>Benefits</h4>
                            <ol class="mt-3">
                                <li>Sort On Designation Listing can be done by Clicking on the any Column Header Text in Ascending or Descending</li>
                                <li>Filter can be done on Designation.</li>
                            </ol>
                        </section>
                        <section id="access" class="mb-5">
                            <h4>Access</h4>
                            <ol class="mt-3">
                                <li>Whizible is a role-based system, hence menu access is configurable in the roles access.</li>
                                <li>Admin user can configure access for a role, to a menu option with <strong>ADD</strong>, <strong>EDIT</strong>, <strong>DELETE</strong> and <strong>VIEW</strong> permissions.</li>
                                <li>The menu would appear to the user based on the same.</li>
                            </ol>
                            <div class="alert access-alert d-flex align-items-center" role="alert">
                                <img src="../../../Whizible2.0/assets/images/alert-icon.png" class="me-2" width="25" alt="Alert Icon" />
                                <div>
                                    <a href="javascript: void(0);">Click to learn more about access privileges, Role access</a>
                                </div>
                            </div>
                        </section>
                        <section id="addNew" class="mb-5">
                            <h4>Adding Designation</h4>
                            <ol class="mt-3">
                                <li>On the <strong>Resource Module</strong>, click <strong>Resources</strong>, Select <strong>Plan</strong> and then Click <strong>Designation</strong>.</li>
                                <li><strong>Designation</strong> page enlists previously defined <strong>Designations</strong> under the column head <strong>Designation</strong>.</li>
                                <li>To define new <strong>Designation</strong>, click <strong>Add Link</strong>.</li>
                                <li>On the <strong>Designation Master</strong> page enter the <strong>Designation</strong>.</li>
                                <li>Click Save to add the <strong>Designation</strong> to the list.</li>
                            </ol>
                            <p>After saving the record <strong>Leaves</strong> tab appears on the screen.</p>
                        </section>
                        <section id="mapping" class="mb-5">
                            <h4>Mapping Leaves to Designation</h4>
                            <p>You can map <strong>Leaves</strong> to <strong>Designation</strong> under this tab.</p>
                            <ol class="mt-3">
                                <li>Select the <strong>Designation</strong></li>
                                <li>Click <strong>Leaves</strong> on the <strong>Leaves tab</strong> on the <strong>Designation</strong> page.</li>
                                <li>All the <strong>Leaves</strong> defined under <strong>Leave Master</strong> are displayed on this page.</li>
                                <li>Select the leaves and <strong>Leaves</strong> and Enter the details related to Leave Entitlement </li>
                                <li>Enter of <strong>Pro-Rata</strong> leaves in the provided box.</li>
                                <li>Click <strong>Save</strong> to add leaves.
                                <p class="pt-3"><u>NOTE</u></p>
                                    <ol style="list-style-type: lower-alpha;">
                                        <li>Pro- rata leaves are the number of proportional leaves added. These leaves vary according to company policy.</li>
                                        <li>For Example: If an employee works for a month then you can add 1 pro rata leave to while configuring the leaves for the employee. Instead of adding one leave for each month, designated resource can add leaves for all the 12 months in one go using this feature.</li>
                                    </ol>
                                </li>
                                <li>Repeat the same for other leaves to be assigned.</li>
                                <li>The Leaves mapped to the Designation will be listed on the Leaves TAB page.</li>
                            </ol>
                            <p>You can edit leaves. In the edit mode you can modify both the leave type and the number of leaves configured for the type.</p>
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
                                            <td>Designation</td>
                                            <td>Enter Unique Designation</td>
                                            <td>Text Box</td>
                                            <td>50</td>
                                            <td>Yes</td>
                                            <td>Skill Category cannot be blank and Characters should not exceed the length of 50.</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Leave Type</td>
                                            <td>Select Designation to Map to Leave Type</td>
                                            <td>Combo Box</td>
                                            <td>50</td>
                                            <td>Yes</td>
                                            <td>Leaves should be Added through Leave Master</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Leave Entitlement</td>
                                            <td>Number of Days Entitled to the Leave Type</td>
                                            <td>Text Box</td>
                                            <td>12</td>
                                            <td>No</td>
                                            <td>No of Digits Should not exceed above 5</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Pro-Rata</td>
                                            <td>Number of Pro-rata Days against the Leave Type to the Designation</td>
                                            <td>Text Box</td>
                                            <td>5</td>
                                            <td>No</td>
                                            <td>No of Digits Should not exceed above 5</td>
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
                                    <p><u>For adding Designation</u></p>
                                    <ul class="mt-3">
                                        <li>On the Resource module, click Resources, select Plan click Designation.</li>
                                        <li>On Designation page enlists all the Designation defined.</li>
                                        <li>To add Designation Value, Click Add link.</li>
                                        <li>Enter the name of the Designation in the Designation text box.</li>
                                        <li>Click Save to add newly defined Designation to the list.</li>
                                        <li>Click Save and Add to continue adding the Skill Category to the Skill Category Master</li>
                                        <li>To select other designation while addressing the current Designation, use Cancel Link to Enable the List </li>
                                    </ul>
                                    <p><u>These will be used to add Leaves and the same can be viewed Leaves applied by the resource by clicking Leaves under My Leaves.</u></p>
                                    <p>Once the details are saved, it will be available on the list page. User can use the ‘Filters’ option to search for a particular value. In filter user can apply: My Filter, Basic Filter, Save and Apply Filter, Apply Filter, Edit filter, Clear Filter.</p>
                                    <ul class="mt-3">
                                        <li><strong>My Filter</strong> : This will be user specific filter and will be available to logged in user when he/she comes to this page.</li>
                                        <li><strong>Basic Filter</strong> : User can apply normal filters by selecting the field from the drop down and using condition and value to define the constraint.</li>
                                        <li><strong>Save & Apply</strong> : This will allow the user to save the filter parameter for future reference and at the same time update the list page after applying the filter.</li>
                                        <li><strong>Apply Filter</strong> : This will only apply the filter constraint to search the value but will not save the filter for future reference.</li>
                                        <li><strong>Edit Filter</strong> : Allow user to modify the already saved filters. User can only modify the filter created by him.</li>
                                        <li><strong>Clear Filter</strong> : If a filter is applied on the page, this option will bring back the standard list and remove any filter which is applied on the page.</li>
                                    </ul>
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
                                        <li><strong>Delete Validation</strong> – Once the Mapping is done it cannot be deleted.</li>
                                        <li><strong>Text validation</strong> – Text Size and for field related validation refer the table above.</li>
                                        <li><strong>Pagination</strong> – Default pagination shall be 10 records per page and the system should provide facility to increase or decrease the number.</li>
                                    </ul>
                                </div>
                            </div>
                        </section>
                        <section id="seeSection">
                            <%--Added By Imran Mujawar on 23-01-2022 For getting Help link Access--%>
                            <%If m_IsLinkActiveAccess = "True" %>
                            <h4>See Also</h4>
                            <ul class="mt-3">
                                <li><a href="javascript:;">Leave Type</a></li>
                                <li><a href="javascript:;">My Leaves</a></li>
                                <li><a href="javascript:;">Employee Leaves</a></li>
                                <li><a href="javascript:;">Employee Leaves Mapping</a></li>
                                <li><a href="javascript:;">Resource Timesheet</a></li>
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
                                                        <input id="hdid" type="hidden" value="0" />
                                                    </div>
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
                    <div class="col-xl-3 mt-3 mt-lg-0 rightpanel">
                        <div class="make-me-sticky right-sidebar">
                            <nav class="section-nav">
                                <div class="accordion_container">
                                    <div class="sub-list-heading accordion_head mb-3">Current page <span class="plusminus">+</span></div>
                                    <ul class="currentPage accordion_body">
                                        <li><a href="#listView">
                                            <img src="../../../Whizible2.0/assets/images/list-icon.svg" class="me-3" width="18" alt="" />List View</a></li>
                                        <li><a href="#benefits">
                                            <img src="../../../Whizible2.0/assets/images/benefit-icon.svg" class="me-3" width="18" alt="" />Benefits</a></li>
                                        <li><a href="#access">
                                            <img src="../../../Whizible2.0/assets/images/access-icon.svg" class="me-3" width="18" alt="" />Access</a></li>
                                        <li><a href="#addNew">
                                            <img src="../../../Whizible2.0/assets/images/add-grade-icon.svg" class="me-3" width="18" alt="" />Adding Designation</a></li>
                                        <li><a href="#UIElement">
                                            <img src="../../../Whizible2.0/assets/images/ui-icon.svg" class="me-3" width="18" alt="" />UI Element / Label</a></li>
                                        <li><a href="#businessRules">
                                            <img src="../../../Whizible2.0/assets/images/business-rules-icon.svg" class="me-3" width="18" alt="" />Business Rules</a></li>
                                        <li><a href="#UIRelatedValidations">
                                            <img src="../../../Whizible2.0/assets/images/ui-validations-icon.svg" class="me-3" width="18" alt="" />Other UI related Validations</a></li>
                                    </ul>
                                    <div class="my-4 list-icon">
                                        <div class="sub-list-heading accordion_head">Most Visited Pages <span class="plusminus">+</span></div>
                                        <div class="moreLess accordion_body" data-city="mostVisited" id="MostVisited">
                                            <%--<ul style="margin-bottom:0;">
                                            <li><a href="javascript:;">Manage Projects</a></li>
                                            <li><a href="javascript:;">Timesheet</a></li>
                                            <li><a href="javascript:;">IR Approval</a></li>
                                        </ul>
                                        <span class="dots"></span>
                                        <span class="more" style="display: none;">
                                            <ul style="margin-bottom:0;">
                                                <li><a href="javascript:;">Manage Projects</a></li>
                                                <li><a href="javascript:;">Timesheet</a></li>
                                                <li><a href="javascript:;">IR Approval</a></li>
                                            </ul>
                                        </span>
                                        <a href="javascript:;" onclick="readMore('mostVisited')" class="myBtn mt-2">More</a>--%>
                                        </div>
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

        $(document).ready(function () {
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

        // Added by imran on 20-01-2022
        function FillLikeDislikeCount() {
            var parameter = {
                TagID: "727",
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

        $("#BtnLike").click(function () {
            var parameter = {
                TagID: "727",
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

        $("#BtnDisLike").click(function () {
            var parameter = {
                TagID: "727",
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
                    TagID: "727",
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

        $("#Btncomment").click(function () {
            $("#ShowTable").hide();
            GetComments();
        });

        // Added by imran on 25-01-2022
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
        //End Of comment by imran on 25-01-2022

        function GetComments() {
            var parameter =
            {
                TagID: "727",
                EmployeeID: EmployeeId,
                LoginType: LoginType
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/Common_Help/GetAllCommentByUser", param, false);
            var strHTML = '';
            var Tcount = 0;
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
                    "scrollY": "100px",
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

        // Added by imran on 27-01-2022 Most Visited Person
        function MostVistedPerson() {
            $("#MostVisited").html('');
            var parameter =
            {
                TagID: "727"
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
        //End Of comment by imran on 27-01-2022

		// Added by imran on 04-02-2022 Most MostLiked
		function MostLiked() {
			$("#MostLiked").html('');
			var parameter =
			{
				TagID: "727"
			}
			var param = JSON.stringify(parameter);
			var data = AJAXCallWithResult("/api/Common_Help/GetMostVisitedLikes", param, false);
			var strHTML = '';
			if (data.length != 0) {
				strHTML += '<ul style="margin-bottom: 0;">';
				for (var i = 0; i < data.length; i++)
				{
					strHTML += '<li><a href="javascript:;">' + data[i].TagName + '</a></li>';
				}
				strHTML += '</ul>';
				$("#MostLiked").append(strHTML);
			}
		}
		//End Of comment by imran on 04-02-2022

	// Added by imran on 04-02-2022 Most LikeRecent Updated
    function MostRecentUpdated() {
        $("#RecentUpdated").html('');
        var parameter =
        {
            TagID: "727"
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
    //End Of comment by imran on 04-02-2022
	
        //End Of Comment by imran 20-01-2022
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
