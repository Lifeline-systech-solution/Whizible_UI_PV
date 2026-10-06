<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_Grade_Master_Help.aspx.vb" Inherits="PbNIT.HR_Grade_Master_Help" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/fonts/font-awesome/css/all.css" rel="stylesheet">
    <link href="assets/fonts/fonts.css" rel="stylesheet">
    <title>Knowledge Management</title>
  </head>
  <body>
    <header id="topheader">
      <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container">
          <a class="navbar-brand" href="index.html"><img src="assets/images/whizible-logo.png" width="100" /></a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
              <li class="nav-item">
                <a class="nav-link py-1 py-md-0 mt-3 mt-md-0" aria-current="page" href="index.html">Home</a>
              </li>
              <li class="nav-item active">
                <a class="nav-link py-1 py-md-0" href="knowledge-management.html">Knowledge Management</a>
              </li>
              <li class="nav-item">
                <a class="nav-link py-1 py-md-0" href="#">Sign In</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </header>
    <section>
      <div class="bg-dark-blue">
        <div class="container">
          <div class="row py-4">
            <div class="col-md-9">
              <form class="d-flex">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn form-banner-btn" type="button" data-bs-toggle="modal" data-bs-target="#signInPopup">Search</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>
    <div class="modal fade" id="signInPopup" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" id="exampleModalLabel">Sign in</h4>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form>
              <div class="mb-3 text-dark">
                <label for="userID" class="form-label">User ID :</label>
                <input type="email" class="form-control" id="userID" placeholder="User ID">
              </div>
              <div class="mb-3">
                <label for="userPassword" class="form-label">Password :</label>
                <input type="password" class="form-control" id="userPassword" placeholder="Password">
              </div>
              <div class="mb-1">
                <div class="d-flex justify-content-between">
                  <a class="" href="javascript:;">Forgot Password?</a>
                  <a class="ms-auto" href="javascript:;">Change Password?</a>
                  <div class="clearfix"></div>
                </div>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn loginbtn mt-2">Sign In</button>
          </div>
        </div>
      </div>
    </div>
    <main>
      <div class="container mt-5">
        <div class="row">
          <div class="col-md-8">
            <h3>Grade Master</h3>
            <nav class="mb-4" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript: void(0);">Resources</a></li>
                <li class="breadcrumb-item"><a href="javascript: void(0);">Plan</a></li>
                <li class="breadcrumb-item active" aria-current="page">Grade Master</li>
              </ol>
            </nav>
            <p><strong>Grade</strong> is the quality of potentiality possessed by resource in terms of Technical Skills, Software Skills, efficiency and qualification.</p>
            <p>Using this master designated user can define grades and maintain its repository. This is useful for evaluating the level of achievement of the resources while mandating employee records.</p>
            <section id="listView" class="my-5">
              <h4>List View</h4>
              <img src="assets/images/list-view-img.png" class="img-fluid my-3" alt="" />
              <div class="alert grade-alert text-center" role="alert">
                Grade defines a category assigned to resources having the same functional or technical skills. It is a category assigned based on expertise.
              </div>
            </section>
            <section id="benefits" class="mb-5">
              <h4>Benefits</h4>
              <ol class="mt-3">
                <li>Sort Resources into Categories</li>
                <li>Filter resources by Grades</li>
              </ol>
            </section>
            <section id="access" class="mb-5">
              <h4>Access</h4>
              <ol class="mt-3">
                <li>Whizible is a role-based system, hence menu access is configurable in the roles access.</li>
                <li>Admin user can configure access for a role, to a menu option with ADD, EDIT, DELETE and VIEW permissions.</li>
                <li>The menu would appear to the user based on the same.</li>
              </ol>
              <div class="alert access-alert d-flex align-items-center" role="alert">
                <img src="assets/images/alert-icon.png" class="me-2" width="25" alt="" />
                <div>
                  <a href="javascript: void(0);">Click to learn more about access privileges, Role access</a>
                </div>
              </div>
            </section>
            <section id="newGrade" class="mb-5">
              <h4>Adding New Grade</h4>
              <ol class="mt-3">
                <li>On the <strong>Resource module</strong>, click <strong>Resource</strong>, Select <strong>Plan</strong> and then click <strong>Grade</strong>.</li>
                <li>Grade page opens enlisting previously added Grades under the column <strong>Grade</strong>, <strong>Description</strong>, <strong>Weightage</strong>.</li>
                <li>To define a <strong>Grade</strong>, click <strong>Add</strong> link on the <strong>Grade</strong> page</li>
                <li>On the <strong>Grade</strong> details page, enter the suitable title for <strong>Grade</strong> in the box.</li>
                <li>Enter the brief <strong>Description</strong> for the grade in the provided box.</li>
                <li>Enter the <strong>Weightage</strong> which you want to configure for that grade in the provided box.</li>
                <li>Click <strong>Save</strong> to add the Grade to the list.</li>
              </ol>
              <img src="assets/images/adding-grade-1.png" class="img-fluid" alt="" />
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
                      <td>Grade</td>
                      <td>Name of the grade</td>
                      <td>Text</td>
                      <td>50</td>
                      <td>yes</td>
                      <td>Once the Grade master is mapped to a Employee master then it cannot be deleted.</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td>Description</td>
                      <td>Detail description of Grade</td>
                      <td>Text Area</td>
                      <td>500</td>
                      <td>No</td>
                      <td></td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td>Weightage</td>
                      <td>Provide the weightage of the grade using this option</td>
                      <td>Text</td>
                      <td>3</td>
                      <td>Yes</td>
                      <td>Range from 1 to 100</td>
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
                  <p><u>For adding Grade</u></p>
                  <ul class="mt-3">
                    <li>On the Resource module, click Resources, select Plan click Grade master.</li>
                    <li>On Grade master page enlists all the Grades defined in the system under the head Grade.</li>
                    <li>To add Grade click Add link.</li>
                    <li>Enter the name of the Grade in the Grade text box and provide some brief description.</li>
                    <li>Provide the weightage from range 1 to100.</li>
                    <li>Click Save to add newly defined Grade to the list.</li>
                  </ul>
                  <p><u>These will be used to add Grade at resource master level for adding resources</u></p>
                  <p>Once the details are saved, it will be available on the list page. User can use the ‘Filters’ option to search for a particular value. In filter user can apply: My Filter, Basic Filter, Save and Apply Filter, Apply Filter ,Edit filter ,Clear Filter.</p>
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
                    <li><strong>Delete Validation</strong> – If the master value has been mapped to Employee record or the reference of the master is used anywhere in the system then the master value cannot be deleted.</li>
                    <li><strong>Text validation</strong> – Text Size and for field related validation refer the table above.</li>
                    <li><strong>Pagination</strong> – Default pagination shall be 10 records per page and the system should provide facility to increase or decrease the number.</li>
                  </ul>
                </div>
              </div>
            </section>
			<section id="seeSection">
                <h4>See Also</h4> 
				<ul class="mt-3">
                    <li><a href="javascript:;">Role access</a></li>
                    <li><a href="javascript:;">Create Employee</a></li>
                  </ul>				
            </section>
          </div>
          <div class="col-md-4 mt-4 mt-lg-0">
            <div class="make-me-sticky right-sidebar">
              <nav class="section-nav">
                <p class="sub-list-heading mb-3">- Current page</p>
                <ul class="currentPage">
                  <li><a href="#listView"><img src="assets/images/list-icon.svg" class="me-3" width="23" alt="" />List View</a></li>
                  <li><a href="#benefits"><img src="assets/images/benefit-icon.svg" class="me-3" width="25" alt="" />Benefits</a></li>
                  <li><a href="#access"><img src="assets/images/access-icon.svg" class="me-3" width="26" alt="" />Access</a></li>
                  <li><a href="#newGrade"><img src="assets/images/add-grade-icon.svg" class="me-3" width="27" alt="" />Adding New Grade</a></li>
                  <li><a href="#UIElement"><img src="assets/images/ui-icon.svg" class="me-3" width="25" alt="" />UI Element / Label</a></li>
                  <li><a href="#businessRules"><img src="assets/images/business-rules-icon.svg" class="me-3" width="25" alt="" />Business Rules</a></li>
                  <li><a href="#UIRelatedValidations"><img src="assets/images/ui-validations-icon.svg" class="me-3" width="23" alt="" />Other UI related Validations</a></li>
                </ul>
                <div class="my-4 list-icon">
                  <p class="sub-list-heading">Most Visited Pages</p>
                  <div class="moreLess" data-city="mostVisited">
                    <ul style="margin-bottom:0;">
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
                    <a href="javascript:;" onclick="readMore('mostVisited')" class="myBtn mt-2">More</a>
                  </div>
                </div>
                <div class="mb-4 list-icon">
                  <p class="sub-list-heading">Recent Updated Document</p>
                  <div class="moreLess" data-city="recentUpdated">
                    <ul style="margin-bottom:0;">
                      <li><a href="javascript:;">Resources</a></li>
                      <li><a href="javascript:;">Certification</a></li>
                      <li><a href="javascript:;">Timesheet</a></li>
                    </ul>
                    <span class="dots"></span>
                    <span class="more" style="display: none;">
                      <ul style="margin-bottom:0;">
                        <li><a href="#">IR-PIR</a></li>
                        <li><a href="#">Project Closure</a></li>
                        <li><a href="#">Skills</a></li>
                      </ul>
                    </span>
                    <a href="javascript:;" onclick="readMore('recentUpdated')" class="myBtn mt-2">More</a>
                  </div>
                </div>
                <div class="list-icon">
                  <p class="sub-list-heading">Most Rated Help Document</p>
                  <div class="moreLess" data-city="mostRated">
                    <ul style="margin-bottom:0;">
                        <li><a href="javascript:;">IR-PIR</a></li>
                        <li><a href="javascript:;">Project Closure</a></li>
                        <li><a href="javascript:;">Skills</a></li>
                    </ul>
                    <span class="dots"></span>
                    <span class="more" style="display: none;">
                      <ul style="margin-bottom:0;">
                        <li><a href="javascript:;">IR-PIR</a></li>
                        <li><a href="javascript:;">Project Closure</a></li>
                        <li><a href="javascript:;">Skills</a></li>
                      </ul>
                    </span>
                    <a href="javascript:;" onclick="readMore('mostRated')" class="myBtn mt-2">More</a>
                  </div>
                </div>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </main>
    <section>
      <div class="container my-5 mt-3 pb-3 comments">
        <div class="row">
          <div class="col-md-12">
		  <h5 class="mb-4 mt-2">Helpful?</h5>
            
                <i class="far fa-thumbs-up me-4 position-relative" id="like">
                    <span class="badge badge-green" id="spanLike">35</span>

                </i>

           
            <i class="far fa-thumbs-down me-4 ms-2 position-relative" id="dislikes"><span class="badge badge-red">12</span></i>
            <i class="far fa-comment-alt ms-2 position-relative" data-bs-toggle="modal" data-bs-target="#comments"><span class="badge badge-blue">59</span></i>
            <div class="modal fade" id="comments" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h4>Comments</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <form>
                      <div class="mb-3">
                        <label for="comment" class="form-label">Write Your Comments :</label>
                        <textarea class="form-control" id="comment" rows="3"></textarea>
                      </div>
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="submit" class="btn loginbtn mt-2" id="btnPost" data-bs-dismiss="modal">Post</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <footer class="footer">
      <div class="container">
        <div class="row d-flex align-items-center py-4 py-md-5">
          <div class="col-md-7">
            <h4 class="mb-4">Contact</h4>
            <p class="mb-0">+91 8554983315</p>
            <p><a href="mailto:info@whizible.com">info@whizible.com</a></p>
            <p>Mrugank, Level 3, Kothrud,<br>Pune Maharashtra, 411038
            </p>
          </div>
          <div class="col-md-5 footer-icons text-md-end">
            <a href="#" class="active"><i class="fab fa-facebook-f pe-3"></i></a>
            <a href="#"><i class="fab fa-twitter pe-3"></i></a>
            <a href="#"><i class="fab fa-linkedin-in pe-3"></i></a>
            <a href="#"><i class="fab fa-instagram pe-3"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
          </div>
        </div>
      </div>
    </footer>
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script>
      $( '#topheader .navbar-nav a' ).on( 'click', function () {
      	$( '#topheader .navbar-nav' ).find( 'li.active' ).removeClass( 'active' );
      	$( this ).parent( 'li' ).addClass( 'active' );
      });
      
      window.addEventListener('DOMContentLoaded', () => {
      
        const observer = new IntersectionObserver(entries => {
          entries.forEach(entry => {
            const id = entry.target.getAttribute('id');
            if (entry.intersectionRatio > 0) {
              document.querySelector(`nav li a[href="#${id}"]`).parentElement.classList.add('active');
            } else {
              document.querySelector(`nav li a[href="#${id}"]`).parentElement.classList.remove('active');
            }
          });
        });
      
        // Track all sections that have an `id` applied
        document.querySelectorAll('section[id]').forEach((section) => {
          observer.observe(section);
        });
        
      });
	  
      function readMore(city) {
         let dots = document.querySelector(`.moreLess[data-city="${city}"] .dots`);
         let moreText = document.querySelector(`.moreLess[data-city="${city}"] .more`); 
         let btnText = document.querySelector(`.moreLess[data-city="${city}"] .myBtn`);
      
         if (dots.style.display === "none") {
             dots.style.display = "inline";
             btnText.textContent = "More";
             moreText.style.display = "none";
         } else {
             dots.style.display = "none";
             btnText.textContent = "Less"; 
             moreText.style.display = "inline";
         }
        }
        //Added By Nikhil A on 05-Dec-2021
        $("#like").click(function () {
           
            var parameter = {
                TagID: "716",
                EmployeeID: '<%= Session("intUserID") %>',
                Liked: 1,
                DisLiked:0
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/HR_Grade_Master_Help/SaveLikeDislike", param, false);
            if (data.length != 0) {
                for (var i = 0; i <= data.length; i++)
                {
                    var GradeResult = data[i];
                    $("#spanLike").text(GradeResult.Liked);
                    $("#dislikes").text(GradeResult.DisLiked);
                    
                }
                
            }
            
        });
        $("#dislikes").click(function () {
           
          var parameter = {
                TagID: "716",
                EmployeeID: '<%= Session("intUserID") %>',
                Liked: 0,
                DisLiked:1
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/HR_Grade_Master_Help/SaveLikeDislike", param, false);
            if (data.length != 0) {
                for (var i = 0; i <= data.length; i++)
                {
                    var GradeResult = data[i];
                    $("#spanLike").text(GradeResult.Liked);
                    $("#dislikes").text(GradeResult.DisLiked);
                    
                }
                
            }
            
        });
         $("#btnPost").click(function () {

            
        <%-- var parameter = {
                TagID: "716",
                EmployeeID: '<%= Session("intUserID") %>',
               comments:$("#comment").val()
            }
            var param = JSON.stringify(parameter);
            var data = AJAXCallWithResult("/api/HR_Grade_Master_Help/PostComments", param, false);
            if (data.length != 0) {
                for (var i = 0; i <= data.length; i++)
                {
                    var GradeResult = data[i];
                    $("#spanLike").text(GradeResult.Liked);
                    $("#dislikes").text(GradeResult.DisLiked);
                    
                }
                
            }--%>
           
        });
        
        var ajaxResult;
        var  strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Help").ToString%>';
    function AJAXCallWithResult(url, param, async) {
            //StartLoader("#bodyIssueDetails");
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Help"));
                },
                success: function (data) {
                    //StopAjaxLoader("#bodyIssueDetails");
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

        //End Of Added BY Nikhil A
    </script>
  </body>
</html>
