<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty loggedInUser}">
<c:redirect url="/login"/>
</c:if>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TxtBook</title>
    
    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css"
href="webjars/bootstrap/4.3.1/css/bootstrap.min.css" />
<c:url value="/css/main.css" var="jstlCss" />
<link href="${jstlCss}" rel="stylesheet" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>

  </head>
  <body>

<br>
<div class="container">	     
        <div class="col-lg-12 col-md-12">
         <jsp:include page="header.jsp"></jsp:include>
 
<c:if test="${not empty list}">            
<table class="table table-bordered table-hover">
<thead class="thead-dark">
		
		<tr>
		<th>ID</th>
		<th>Image</th>
		<th>Name</th>
		<th>Role</th>
		<th>Email</th>
		<th>
		<i class="glyphicon glyphicon-trash"></i>
		</th>
		</tr>
		<tbody>
		<c:forEach var="item" items="${list}">
		<tr>
		<td>${item.id}</td>
		<td>
			<c:choose>
			<c:when test="${not empty item.image}">
			<img src="${contextPath}//user//${item.id}//${item.image}" width="70" height="55">
			<div>
			<!-- this is using a query string instead of path variable!!! -->
				<a href="deleteUser?id=${item.id}"><b>Delete</b><i class="glyphicon glyphicon-trash"></i></a>
			</div>
			</c:when>
			<c:otherwise>
			No image
			</c:otherwise>
			</c:choose>
		
		</td>
		<td>${item.firstName}
		${item.lastName}</td>
		<td>
			<form:form method="POST" modelAttribute="${addUser}" action="editrole">
				<input type="hidden" name="id" value="${item.id}">
				<input type="hidden" name="firstName" value="${item.firstName}">
				<select onChange="this.form.submit()" name="role" class="form-control">
				<option value="${item.role}">${item.role}</option>
				<option value="USER">USER</option>
        		<option value="ADMIN">ADMIN</option>
				</select>
				</form:form>
				</td>
		<td>${item.email}</td>
		<td>
		<a href="deleteuser?id=${item.id}" onClick="confirmed(); return false;" id="${item.id}" title="Delete" class="btn btn-danger">Delete
		<i class="glyphicon glyphicon-trash"></i></a>
		</td>
		</c:forEach>
		</tbody>
		
		</table>
	</c:if>	
             
</div>	
       
     </div>
 
  
 
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    
  </body>
  
  <script type="text/javascript" src="webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>  
  <script>
    function confirmed(){
            if (confirm('You are about to delete this book, Do you want to proceed?')) {
                  document.getElementById("del").submit();
                  return true;
            } else {
               return false;
            }
         }

    
    $("#search").keyup(function () {
        var value = this.value.toLowerCase().trim();

        $("table tr").each(function (index) {
            if (!index) return;
            $(this).find("td").each(function () {
                var id = $(this).text().toLowerCase().trim();
                var not_found = (id.indexOf(value) == -1);
                $(this).closest('tr').toggle(!not_found);
                return not_found;
            });
        });
    });
    </script> 
    
    <script>
            function updateSize() {
                var nBytes = 0,
                        oFiles = document.getElementById("fileInput").files,
                        nFiles = oFiles.length;
                for (var nFileId = 0; nFileId < nFiles; nFileId++) {
                    nBytes += oFiles[nFileId].size;
                }

                var sOutput = nBytes + " bytes";
                // optional code for multiples approximation
                for (var aMultiples = ["KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"], nMultiple = 0, nApprox = nBytes / 1024; nApprox > 1; nApprox /= 1024, nMultiple++) {
                    sOutput = nApprox.toFixed(3) + " " + aMultiples[nMultiple] + " (" + nBytes + " bytes)";
                }
                // end of optional code

                document.getElementById("fileNum").innerHTML = nFiles;
                document.getElementById("fileSize").innerHTML = sOutput;
            }
        </script>
  
</html>
