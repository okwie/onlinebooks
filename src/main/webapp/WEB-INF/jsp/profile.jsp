<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


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
         
             <h1>${msg}</h1>
             <c:if test="${action eq 'editBook'}">     
             <form:form modelAttribute="addBook" action="${action}" method="POST" class="col-lg-6 col-md-6"> 
             <h3>${success}</h3> 
             <form:input type="hidden" path="id" class="form-control" />           
             <label>Title</label>
             <form:input path="title" class="form-control"  placeholder="Title"/>
             <label>Author</label>
             <form:input path="author" class="form-control"  placeholder="Author"/>
             <label>Description</label>
             <form:input path="description" class="form-control"  placeholder="Description"/>
             <label>Price</label>
             <form:input path="price" class="form-control"  placeholder="Price"/>
             <label>ISBN</label>
             <form:input path="isbn" class="form-control"  placeholder="ISBN"/><br>
             <button type="submit" class="btn btn-success">Submit</button>
             <a href="index" class="btn btn-info">Cancel</a>
             </form:form>
             </c:if>
             <c:if test="${action ne 'editBook'}">
             <c:if test="${not empty loggedInUser.email}">
             <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
  Add Book <br>
</button>
  
			 </c:if>
             </c:if>
             <c:if test="${empty list}">
             
             <a href="index" class="btn btn-default">
             <i class="spinner-border" role="status">
<span class="sr-only"></span>
</i>
             </a>
             </c:if>
<c:if test="${not empty list}">            
<table class="table table-bordered table-hover">
<thead class="thead-dark">
		
		<tr>
		<th>#</th>
		<th>Image</th>
		<th><input type="text" id="search" placeholder="Filter Titles " class="form-control"  ></th>
		<th>Author</th>
		<th>Description</th>
		<th>Price</th>
		<c:if test="${not empty loggedInUser.email}">
		<th>
		<i class="glyphicon glyphicon-pencil"></i>
		</th>
		<th>
		<i class="glyphicon glyphicon-trash"></i>
		</th>
		</c:if>
		</tr>
		<tbody>
		<c:forEach var="item" items="${list}">
		<c:if test="${loggedInUser.email eq item.email}">
		<tr>
		<td>${list.indexOf(item)+1}</td>
		<td>
			<c:choose>
			<c:when test="${not empty item.image}">
			<a href="checkout-${item.id}" title="${item.title}"><img src="${contextPath}//books//${item.id}//${item.image}" width="70" height="55"></a>
			<div>
				<a href="remove-${item.id}-${item.image}" title="Delete ${item.image}"><b>Delete</b><i class="glyphicon glyphicon-trash"></i></a>
			</div>
			</c:when>
			<c:otherwise>
			<form:form modelAttribute="addBook" enctype="multipart/form-data" action="uploadFile" method="POST">	            
			<div class="form-group"> 
                <form:input id="fileInput" type="file" path="file" onchange="updateSize();" />	                
                <form:input type="hidden" path="id" value="${item.id}"/>
                <p>selected files: <span id="fileNum">0</span>;
                total size: <span id="fileSize">0</span></p>
                <input type="submit" class="btn btn-primary" value="Upload Image">
             </div> 
             </form:form> 
			</c:otherwise>
			</c:choose>
		
		</td>
		<td>${item.title}</td>
		<td>${item.author}</td>
		
		<td>${item.description}</td>
		<td>$ ${item.price}</td>
		<c:if test="${not empty loggedInUser.email}">
		
		<td>
		
		<a href="editBook-${item.id}" class="btn btn-info">Edit
		<i class="glyphicon glyphicon-pencil"></i></a>
		</td>
		<td>
		<a href="deleteBook-${item.id}" onClick="confirmed(); return false;" title="Delete" class="btn btn-danger">Delete
		<i class="glyphicon glyphicon-trash"></i></a>
		</td>
		</c:if>
		</c:if>
		
		</c:forEach>
		</tbody>
		
		</table>
		</c:if>
             
</div>	
       
     </div>
 
  <div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Add Book</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form class="navbar-form navbar-right" role="search"  action="search" method="post">
				    <div class="input-group add-on">										      
				     
					    </div>
					 </form>
  <div class="container">
 <h1 class="text-center text-danger"> <span id="msg">${msg}</span> <br> ${success}</h1>
	<div class="row col-lg-6 col-md-6" >
		<form:form action="${action}" modelAttribute="addBook" method="POST">
			 <form:input type="hidden" path="id" class="form-control"/>
			 <label>Author</label>
			 <form:input path="author" class="form-control" placeholder="Author"/><br>
			 <label>Title</label>
			 <form:input path="title" class="form-control" placeholder="Title"/><br>
			 <label>Description</label>
			 <form:input path="description" class="form-control" placeholder="Description"/><br>
			 <label>Price</label>
			 <form:input path="price" class="form-control" placeholder="Price"/><br>
			 <label>ISBN</label>
			 <form:input path="isbn" class="form-control" placeholder="ISBN"/><br>
			 <form:input type="text" path="email" value="${loggedInUser.email}" class="form-control" />     
			 <button type="submit" class="btn btn-success">Submit</button>
		 
 		</form:form><br>
 		</div>
      </div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

  </body>
  
  <script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>  
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
        <footer><jsp:include page="footer.jsp"></jsp:include></footer>
  
</html>
