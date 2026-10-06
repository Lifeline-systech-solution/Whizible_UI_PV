<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Source/WhizibleHelp/MasterPage/Help.Master" CodeBehind="RM_BusinessGroup_Help.aspx.vb" Inherits="PbNIT.RM_BusinessGroup_Help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Business Group</title>
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
                                <h3>Business Group</h3>
                                <nav class="" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Resources</a></li>
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Resource Pool</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Business Group</li>
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
                        <p>After a resource is registered in <strong>Whizible</strong> he/ she becomes a part of the business group, the <strong>Business Group Pool</strong>, from which they are identified and deployed on projects. </p>
                        <p><strong>Business Group Pool</strong> encompasses all the resources in each Business Group to which they belong. Business Group is used for managing the resource allocation, resource swapping and tracking resource utilization across the particular business group.</p>
                        <section id="listView" class="my-5">
                            <h4>List View</h4>
                            <img src="../../../Whizible2.0/assets/images/business-group-list-view.png" class="img-fluid my-3" alt="Business Group List View" />
                            <p><strong>Business Group</strong> is the repository where in you can maintain the <strong>Business Group Resource</strong> against Each Employee in the Organisation.</p>
                            <p>You should add the <strong>Business Group Manager</strong> who will be responsible for managing the Business Group and shall be the resource in the organisation and available in Employee Master.</p>
                        </section>
                        <section id="addNew" class="mb-5">
                            <h4>Adding Business Group Manager</h4>
                            <p>On Clicking the Link of the <strong>Business Group</strong>, Five Tabs Appears containing <strong>Details</strong> which gives the details of the <strong>Business Group with Code</strong>, <strong>Organisation Unit</strong> which is mapped through corporate Structure, <strong>Business Group Manager</strong> which are needed to be added through <strong>Add Link</strong> from the TAB, <strong>Resources</strong> which displays the and <strong>By Role</strong> Tab which give the Analysis of all the Roles in the Organisation Head count of the Role and Percentage of Individual Roles in overall Organisation.</p>
                        </section>
                        <section id="viewingBusinessGroup" class="mb-5">
                            <h4>Viewing Business Group Details</h4>
                            <ol class="mt-3">
                                <li>On the <strong>Resource</strong> menu click <strong>Resource Pool</strong>, <strong>Select Business Group</strong>.</li>
                                <li>Click <strong>Business Group</strong>. A <strong>Business Group</strong> page lists previously defined <strong>Business Group</strong> with their respective <strong>Code</strong> and <strong>Name</strong>.</li>
                                <li>To view details click <strong>Business Group Name</strong> link.</li>
                                <li>Under <strong>Master</strong> section you can find Business Group with its unique code and specific name.</li>
                                <li>Under <strong>Details</strong> page <strong>Organization Units</strong>, <strong>Business Group Managers</strong> and <strong>Resources</strong> tabs are displayed.</li>
                            </ol>
                            <div class="text-center">
                                <img src="../../../Whizible2.0/assets/images/viewing-busines-group-details.png" class="img-fluid" alt="Viewing Business Group Details" />
                            </div>
                        </section>
                        <section id="viewingBusinessGroupDetails" class="mb-5">
                            <h4>Viewing Business Group Details</h4>
                            <p>On the Business Group Details page by default Organization Unit tab is selected.</p>
                            <ol class="mt-3">
                                <li>The <strong>Organization Unit</strong> details page lists all the previously defined Organization Units with their proper <strong>Name</strong> and <strong>Code</strong>.</li>
                                <li>Under <strong>Organization Unit</strong> you can view name of organization Unit.</li>
                                <li>Under <strong>Organization Unit Code</strong> unique code for the organization Unit is displayed.</li>
                            </ol>
                            <div class="text-center">
                                <img src="../../../Whizible2.0/assets/images/viewing-busines-group-details-1.png" class="img-fluid" alt="Viewing Business Group Details" />
                            </div>
                        </section>
                        <section id="viewAddNew" class="mb-5">
                            <h4>Viewing and Adding Business Group Managers</h4>
                            <p>You can configure Business Manager under <strong>Business Group Managers</strong> tab, Click <strong>Business Group Managers</strong> tab</p>
                            <ol class="mt-3">
                                <li><strong>Business Group Managers</strong> details page enlists Business Group managers under column head <strong>Manager</strong>, <strong>Is Primary Responsible</strong>, <strong>Responsibilities</strong>.</li>
                                <li>Click <strong>Add</strong> on the <strong>Business Group Managers</strong> details page.</li>
                                <li>The List of Managers appearing in the Drop down shall be a Middle Level Role Resources.</li>
                                <li>Select the resource that you want to set as manager of business group from the <strong>Business Group Mangers</strong> list.</li>
                                <li>Optionally, you can select <strong>Is Primarily Responsible</strong> box if you want to set the selected manager as main responsible person for the activities of the business group. When a manager is marked as primary responsible, all the activities in the business group are first directed to him and then to the others. Similarly, his / her name appears in the <strong><i>To</i></strong> list of the mails fired while the rest of the resources appear in the <strong><i>CC</i></strong> list.</li>
                                <li>Click <strong>Save</strong> to set the selected resource as manager of the Business Group.</li>
                            </ol>
                            <div class="text-center">
                                <img src="../../../Whizible2.0/assets/images/adding-business-group-managers.png" class="img-fluid" alt="Adding Business Group Manager" />
                            </div>
                        </section>
                        <section id="viewingResources" class="mb-5">
                            <h4>Viewing Resources</h4>
                            <p>You can view Resources with their Role Description by using <strong>Resources</strong> tab.</p>
                            <ol class="mt-3">
                                <li>Click Resource tab. Use the <strong>Role Description</strong> Combo filter to view the resources of a particular <strong>Role</strong>.</li>
                                <li>After selecting role, you can find the name of resource is displayed with <strong>Employee Name</strong>, <strong>Role description</strong>, <strong>Location</strong>, <strong>Email Id</strong>, and <strong>Resume</strong>.</li>
                                <li><strong>Employee Name</strong> displays the name of the resource satisfying the criteria selected in the filters. Alternatively, if none of the filter is applied, all the resource having a role with <strong>Middle Level access rights</strong> are displayed.</li>
                                <li><strong>Role Description</strong> displays role of resources.</li>
                                <li><strong>Location</strong> displays name of the organization unit of the resource.</li>
                                <li><strong>Department</strong> displays department of the resource.</li>
                                <li><strong>Email ID</strong> displays the email address of the resources are displayed. For any correspondence related to the Organization Unit in question are sent to the selected resources using their corresponding email ids specified here.</li>
                                <li>Click on <strong>Resume</strong> link of the respective resource to get his detailed bio-data.</li>
                            </ol>
                            <div class="text-center">
                                <img src="../../../Whizible2.0/assets/images/viewing-resources-business-group.png" class="img-fluid" alt="Viewing Resources" />
                            </div>
                        </section>
                        <section id="viewingGraph" class="mb-5">
                            <h4>Viewing Graph through Role Tab</h4>
                            <p>You can view Resource by role graphs.</p>
                            <ol class="mt-3">
                                <li><strong>Resource by Roles</strong> graph is displayed below <strong>Resource</strong> tab section.</li>
                                <li>This is pie graph showing all the resources working in the <strong>Business Group</strong> in question, segregated by their individual roles</li>
                                <li>This mandatory association of the resource to a particular Role, too, is carried out in the <strong>Employee</strong> node.</li>
                                <li>On the face of each pie-section, the total number of resources falling in that criteria are displayed.</li>
                            </ol>
                            <div class="alert grade-alert text-center" role="alert">
                                Business Group Pool encompasses all the resources in each Business Group to which they belong.
                            </div>
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
                                            <td>Role Description</td>
                                            <td>Prepopulated Roles Combo under Resources Tab</td>
                                            <td>List Combo</td>
                                            <td>NA</td>
                                            <td>NA</td>
                                            <td>All the Roles Across the Organization will appear in the List </td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Manager</td>
                                            <td>Selector for Name of the Business Group Manager </td>
                                            <td>List Combo</td>
                                            <td>NA</td>
                                            <td>NA</td>
                                            <td>All the Resources with Role level as Middle Level Across the Organization will appear in the List</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Global Resource Pool Manager</td>
                                            <td>Global Resource Pool Manager</td>
                                            <td>Combo Box</td>
                                            <td>50</td>
                                            <td>Yes</td>
                                            <td>Manager Can be from the List</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Is Primary Responsible</td>
                                            <td>Whether the Selected Employee is Primarily responsible for the Selected Business Group</td>
                                            <td>Check Box</td>
                                            <td></td>
                                            <td>No</td>
                                            <td>If Primary then all the activities in the business group are first directed to him and then to the others. Similarly, his / her name appears in the To list of the mails fired while the rest of the resources appear in the CC list.</td>
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
                                <li><a href="javascript:;">Employee Master</a></li>
                                <li><a href="javascript:;">Role</a></li>
                                <li><a href="javascript:;">Role Access</a></li>
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
                    <div class="col-xl-3 mt-4 mt-lg-0 rightpanel">
                        <div class="make-me-sticky right-sidebar">
                            <nav class="section-nav">
                                <div class="accordion_container">
                                    <div class="sub-list-heading accordion_head mb-3">Current page <span class="plusminus">+</span></div>
                                    <ul class="currentPage accordion_body">
                                        <li><a href="#listView">
                                            <img src="../../../Whizible2.0/assets/images/list-icon.svg" class="me-3" width="18" alt="List View" />List View</a></li>
                                        <li><a href="#addNew">
                                            <img src="../../../Whizible2.0/assets/images/adding-business-group-manager-icon.svg" class="me-3" width="18" alt="Adding Business Group Manager" />Adding Business Group Manager</a></li>
                                        <li><a href="#viewingBusinessGroup">
                                            <img src="../../../Whizible2.0/assets/images/viewing-group-details-icon.svg" class="me-3" width="18" alt="Viewing Business Group Details" />Viewing Business Group Details</a></li>
                                        <li><a href="#viewAddNew">
                                            <img src="../../../Whizible2.0/assets/images/viewing-adding-business-group-icon.svg" class="me-3" width="18" alt="Viewing and Adding Business Group Managers" />Viewing and Adding Business Group Managers</a></li>
                                        <li><a href="#viewingResources">
                                            <img src="../../../Whizible2.0/assets/images/viewing-resources-icon.svg" class="me-3" width="18" alt="Viewing Resources" />Viewing Resources</a></li>
                                        <li><a href="#viewingGraph">
                                            <img src="../../../Whizible2.0/assets/images/viewing-graph-icon.svg" class="me-3" width="18" alt="Viewing Graph through Role Tab" />Viewing Graph through Role Tab</a></li>
                                        <li><a href="#access">
                                            <img src="../../../Whizible2.0/assets/images/access-icon.svg" class="me-3" width="18" alt="Access" />Access</a></li>
                                        <li><a href="#UIElement">
                                            <img src="../../../Whizible2.0/assets/images/ui-icon.svg" class="me-3" width="18" alt="UI Element / Label" />UI Element / Label</a></li>
                                        <li><a href="#businessRules">
                                            <img src="../../../Whizible2.0/assets/images/business-rules-icon.svg" class="me-3" width="18" alt="Business Rules" />Business Rules</a></li>
                                        <li><a href="#UIRelatedValidations">
                                            <img src="../../../Whizible2.0/assets/images/ui-validations-icon.svg" class="me-3" width="18" alt="Other UI related Validations" />Other UI related Validations</a></li>
                                    </ul>
                                    <div class="my-4 list-icon">
                                        <div class="sub-list-heading accordion_head">Most Visited Pages <span class="plusminus">+</span></div>
                                        <div class="moreLess accordion_body" data-city="mostVisited" id="MostVisited"></div>
                                    </div>
                                    <div class="mb-4 list-icon">
                                        <div class="sub-list-heading accordion_head">Recent Updated Document <span class="plusminus">+</span></div>
                                        <div class="moreLess accordion_body" data-city="recentUpdated" id="RecentUpdated"></div>
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

        // Added by imran on 08-02-2022
        function FillLikeDislikeCount() {
            var parameter = {
                TagID: "2075",
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
                TagID: "2075",
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
                TagID: "2075",
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
                    TagID: "2075",
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

        // Added by imran on 08-02-2022
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
        //End Of comment by imran on 08-02-2022

        function GetComments() {
            var parameter =
            {
                TagID: "2075",
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

        // Added by imran on 08-02-2022 Most Visited Person
        function MostVistedPerson() {
            $("#MostVisited").html('');
            var parameter =
            {
                TagID: "2075"
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
        //End Of comment by imran on 08-02-2022

        // Added by imran on 08-02-2022 Most MostLiked
        function MostLiked() {
            $("#MostLiked").html('');
            var parameter =
            {
                TagID: "2075"
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
        function MostRecentUpdated() {
            $("#RecentUpdated").html('');
            var parameter =
            {
                TagID: "2075"
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

        //End Of Comment by imran 08-02-2022
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