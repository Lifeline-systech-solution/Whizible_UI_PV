<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Source/WhizibleHelp/MasterPage/Help.Master" CodeBehind="RM_Skill_help.aspx.vb" Inherits="PbNIT.RM_Skill_help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Skills Master</title>
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
                                <h3>Resource Skills</h3>
                                <nav class="" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Resources</a></li>
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Plan</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Skills</li>
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
                        <p><strong>Skills</strong> inventory can help determine the skills possessed by the employees in general. This inventory will help the organization determine what skills are available now and what skills are needed for future development. This node gives a comprehensive view of the employee skill sets. This helps in effective resource allocation to different projects, it also helps in identifying the training needs for different resources.</p>
                        <p><strong>Skills</strong> denote the working proficiency that employee possesses. It is the ability of the resource to apply knowledge on the job.</p>
                        <p>Using this feature, you can define skills as well as map skill categories to it.</p>
                        <section id="listView" class="my-5">
                            <h4>List View</h4>
                            <img src="../../../Whizible2.0/assets/images/skills-help-image.png" class="img-fluid my-3" alt="Skills Help Image" />
                            <p>Skill master is the repository where in you can add and maintain the Resource Skills. Example of Skills can be any Technology or Hands-on on the Technology Viz: <strong>ASP.Net</strong>, <strong>Oracle</strong>, <strong>C#</strong>, <strong>Networking</strong>, <strong>SCADA</strong>, <strong>Salesforce</strong> Etc.</p>
                            <p>Skills can be added in the master through the below Screen</p>
                            <img src="../../../Whizible2.0/assets/images/skills-list-view.png" class="img-fluid my-3" alt="Skills List View" />
                            <div class="alert grade-alert text-center" role="alert">
                                Resource Skills defines a Skill category assigned to a resource and resource Demand  when Resource Demand is addressed.
                            </div>
                        </section>
                        <section id="benefits" class="mb-5">
                            <h4>Benefits</h4>
                            <ol class="mt-3">
                                <li>Sort On Skill can be done by Clicking on the Sorting Icon of any Column Header in Ascending or Descending</li>
                                <li>Filter can be Done on Skills</li>
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
                            <h4>Adding New Skill</h4>
                            <ol class="mt-3">
                                <li>On the <strong>Resource module</strong>, click <strong>Resource</strong>, Select <strong>Plan</strong> and then click <strong>Skill</strong>.</li>
                                <li>Skill page opens enlisting previously added Skill under the column <strong>Skills</strong>.</li>
                                <li>To define a <strong>Skill</strong>, click <strong>Add</strong> link on the <strong>Skill</strong> page.</li>
                                <li>On the <strong>Skill</strong> page, enter the suitable title for <strong>Skill</strong> in the Text box.</li>
                                <li>Mark (Check / Uncheck) <strong>Required For Metrics calculation</strong> Check box.</li>
                                <li>Enter the maximum number of days in the <strong>Resource Request Validity Days</strong> box. These days represents days within which the resource of the particular skill has to be assigned by the project manager or Requestor, after they are allocated by the request Allocator. Otherwise these resources will be released back to free pool. This is mainly useful in case of those skills, for which the demand is high.</li>
                                <li>Click <strong>Save</strong> to add the Skill to the list.</li>
                                <li>Select <strong>Skills category</strong> from the list. The category selected here is mapped with that skills.</li>
                                <li>Click <strong>Save</strong> to add the <strong>Skill</strong> to the list.</li>
                            </ol>
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
                                            <td>Skills</td>
                                            <td>Name of the Skill</td>
                                            <td>Text</td>
                                            <td>50</td>
                                            <td>Yes</td>
                                            <td>Once the Skill is Mapped to the Resource then it cannot be deleted.</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Required for Metrics Calculation</td>
                                            <td>It’s a check Box where you can Check if the Skill is Required for  Metrics Calculation and Un-Check if not Required</td>
                                            <td>Checkbox</td>
                                            <td>True/False</td>
                                            <td>No</td>
                                            <td>If Checked the Skill will be Considered for  Metrics Calculation and if Un-Checked, the Skill will not be Considered for  Metrics Calculation</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Resource Validity Request</td>
                                            <td>Used during Resource requisition</td>
                                            <td>Numeric</td>
                                            <td>8</td>
                                            <td>Yes</td>
                                            <td>These days represents days within which the resource of the particular skill has to be assigned by the project manager or Requestor, after they are allocated by the request Allocator. Otherwise these resources will be released back to free pool.</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Skill Category</td>
                                            <td>Used to Select the Category of the Skill which maps the skill to the required Skill Categorization</td>
                                            <td>Drop Down</td>
                                            <td>Listing</td>
                                            <td>No</td>
                                            <td>Once the Category is mapped to the Skill the category from the Category Master will not be deleted</td>
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
                                    <p><u>For adding Demand Status</u></p>
                                    <ul class="mt-3">
                                        <li>On the Resource module, click Resources, select Plan click Skill.</li>
                                        <li>On Skill page enlists all the Skills defined in the system under the head Skills.</li>
                                        <li>To add New Skills click Add link.</li>
                                        <li>Enter the name of the Skill in the Skills text box and provide some brief description.</li>
                                        <li>Click Save to add newly defined Skill to the list.</li>
                                        <li>Click Save and Add to continue adding the Skill to the Skills Master</li>
                                        <li>To select other Skill while addressing the current Skill, use Cancel Link to Enable the List</li>
                                    </ul>
                                    <p><u>These will be used to add Skills at Opportunity Request for Request Status</u></p>
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
                                        <li><strong>Delete Validation</strong> – Once the Skill is Mapped to the Employee it cannot be deleted.</li>
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
                                <li><a href="javascript:;">Employee</a></li>
                                <li><a href="javascript:;">Category</a></li>
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
                                            <img src="../../../Whizible2.0/assets/images/add-grade-icon.svg" class="me-3" width="18" alt="" />Adding New Skill</a></li>
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
                                            <%--<ul style="margin-bottom: 0;">
                                                <li><a href="javascript:;">Manage Projects</a></li>
                                                <li><a href="javascript:;">Timesheet</a></li>
                                                <li><a href="javascript:;">IR Approval</a></li>
                                            </ul>
                                            <span class="dots"></span>
                                            <span class="more" style="display: none;">
                                                <ul style="margin-bottom: 0;">
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
                TagID: "1262",
                EmployeeID: EmployeeId,
                LoginType: LoginType,
                IsCreatedByCustomer: IsCreatedByCustomer,
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
                TagID: "1262",
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
                TagID: "1262",
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
                    TagID: "1262",
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

        // Added by imran on 28-01-2022
        function GetComments() {
            var parameter =
            {
                TagID: "1262",
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
        //End Of comment by imran on 25-01-2022

        // Added by imran on 27-01-2022 Most Visited Person
        function MostVistedPerson() {
            $("#MostVisited").html('');
            var parameter =
            {
                TagID: "1262"
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

		// Added by imran on 04-02-2022 Most Liked Pages
		function MostLiked() {
			$("#MostLiked").html('');
			var parameter =
			{
				TagID: "1262"
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
				TagID: "1262"
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
