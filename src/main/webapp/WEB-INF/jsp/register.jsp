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
    <title>Register</title>
    
    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css"
href="webjars/bootstrap/4.3.1/css/bootstrap.min.css" />
<c:url value="/css/main.css" var="jstlCss" />
<link href="${jstlCss}" rel="stylesheet" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
     --><link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>

  </head>
  <body>

<br>
<div class="container">	     
       <div class="col-lg-10 col-md-10">
        
<form:form method="POST" action="${action}" modelAttribute="user" >	
<h1>
<span class="text-success">${msg}</span>
<span class="text-danger">${error}</span></h1>

<label>First Name*</label>

<form:input path="firstName" id="fn" class="form-control"/>	
<div class="has-error">
<form:errors path="firstName" class="text-danger"/>
</div>	

<label>Last Name*</label>
<form:input path="lastName" id="ln" class="form-control" />	
<div class="has-error">
<form:errors path="lastName" class="text-danger"/>
</div>
<c:if test="${hideit ne 'none'}">
<label>Email*</label>	

<form:input  path="email" id="em" class="form-control" />	
<div class="has-error">
<form:errors path="email" class="text-danger"/>
</div>
<label>Password*</label>	

<form:input type="password"  path="password" id="password" class="form-control" />	
<div class="has-error">
<form:errors path="password" class="text-danger"/>
</div>	
</c:if>
<label>Phone</label>	

<form:input  path="phone" id="phone" class="form-control" />	
<div class="has-error">
<form:errors path="phone" class="text-danger"/>
</div>	
<span class="d-none">
<form:input path="id" />
</span>

<br>
<div class="container-login100-form-btn">
<button class="btn btn-primary" type="submit" id="submit" >Submit</button>
<a class="btn btn-primary" href="index">Cancel </a>	
</div>
</form:form>
        
</div>  
     </div>
 
  

  </body>  
  <script type="text/javascript" src="webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>  
      
  
</html>
