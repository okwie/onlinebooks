<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ship" value="5.00"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    
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
     -->
     <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>

<style>
.badge:after{
content:attr(value);
font-size:12px;
background: red;
border-radius:50%;
padding:3px;
position:relative;
left:-8px;
top:-10px;
opacity:0.9;
}

.nav-item dropdown a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-menu a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-menu {display: block;}


</style>

  </head>
  <body>


<div class="container">	     
      <div class="col-lg-12 col-md-12">
         <jsp:include page="header.jsp"></jsp:include>	
         <br><br>
         
         <c:if test="${empty cart}">
         <h3 class="text-center text-info"> ${msg} <br>Cart is empty 
         <a href="index" title="Continue Shopping" class="btn btn-info btn-sm">
    <b>Shopping Now </b> <i class="fa fa-shopping-bag"></i> 
</a>
</h3>
         </c:if>
         <c:if test="${not empty cart}">  
         <h3 class="text-center text-info">${msg} <br>Cart Details 
             <a href="index" class="btn btn-outline-success btn-sm pull-right">
                        Continue Shopping <i class="fa fa-shopping-bag"></i>
              </a>
         </h3>
         <div class="row">
         <div class="col-lg-8 col-md-8"> 
         <table class="table table-striped table-hover">
             <thead class="thead-dark">
             <tr class="text-success">
             <th>#</th>
             <th>
             </th>
             <th>
              <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                Shipping cart              
             </th>             
                         
             </tr>
             </thead>
             <tbody>
             <c:set var="totalprice" value="${0}" />
             <c:forEach var="item" items="${cart}">
             <c:set var="totalprice" value="${totalprice + item.price + ship}" />
             <tr>
             <td>${cart.indexOf(item)+1} </td>             
             <td>              
  <c:choose>
<c:when test="${not empty item.image}">
<a href="checkout-${item.bookId}" title="${item.title} ${item.description}">
<img src="${contextPath}//books//${item.bookId}//${item.image}" width="120" height="80"/></a>
             
            <c:choose>
                <c:when test="${not empty loggedInUser.email}">  
                <c:if test="${not empty cart}">	
                <a href="deletefromcart-${item.id}-${loggedInUser.email}" onclick="confirmed(); return false;" title="Delete Book" >
             <i class="far fa-trash-alt btn btn-danger btn-xs"></i>           
             </a>	  
                </c:if>                
                </c:when>
                <c:otherwise>
                <a href="removefromcart-${item.id}" onclick="confirmed(); return false;" title="Delete Book" >
             <i class="far fa-trash-alt btn btn-danger btn-xs"></i>           
             </a>
                </c:otherwise>                
                </c:choose>  
                
             <a href="#" class="btn btn-secondary btn-sm">$ ${item.price} </a>	 
</c:when>

<c:otherwise>
No Image
<a href="removefromcart-${item.id}" onclick="confirmed(); return false;" title="Delete Book" >
             ${item.title} <i class="far fa-trash-alt btn btn-danger btn-xs"></i>           
             </a>
    
</c:otherwise>
</c:choose>
     
</td>
             <td> 
             ${item.title} <br>           
             ${item.description}<br>             
              <small class="text-info"> Author: ${item.author}</small>
             </td>            
                  
             </tr>
             </c:forEach>
             <tr>
             <td></td>
             <td> Sub Total </td>             
             <td>            
             $ ${totalprice}	 
             </td>
             
             </tr>
             </tbody>
             
             </table>
             </div>
             <div class="col-lg-4 col-md-4">                    
    <table class="table table-condensed">
                      <thead>
                        <tr>
                          <th colspan="2"><span><img src="
https://www.paypalobjects.com/webstatic/mktg/logo/PP_AcceptanceMarkTray-NoDiscover_243x40.png
" alt="TxtBook">  </span>
                         </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            Sub total                            
                          </td>
                          <td>
                            <div class="price-box"> 
                            $ ${totalprice}
  </div>
                          </td>                          
                        </tr>
                        <tr>
                          <td>
                           Shipping                             
                          </td>
                          <td>
                             $ ${ship}  
                          </td>                          
                        </tr>
                        <tr>
                          <td>
                           Total                             
                          </td>
                          <td>                           
                            $ ${totalprice + ship}                            
                          </td>                          
                        </tr>
                        
                      </tbody>
                    </table>
                     <hr>
                     <a href="index" class="btn btn-outline-success btn-sm pull-right">
                        Continue Shopping <i class="fa fa-shopping-bag"></i>
                     </a>
                     <form action="https://www.paypal.com/cgi-bin/webscr" method="post" class="float-right">	
<!-- Identify your business so that you can collect the payments. -->
<input type="hidden" name="business" value="okwi@gmail.com">
<input type=hidden name="amount" value=" ${totalprice + ship}     ">
<!-- Specify a Buy Now button. -->
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="currency_code" value="USD">
<!-- Display the payment button. -->
<input type="image" name="submit" id="checkout"
   src="
https://www.paypalobjects.com/webstatic/en_US/i/buttons/checkout-logo-medium.png
"
   alt="Add to Cart">
   <img alt="" border="0" width="1" height="1"
src="static/images/paypal-img.png" >	
</form> 
               </div>
               </div>
             
                </c:if>
             
        
 
       </div>     
     </div>	 
    </body>
 
  <script>
        
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
  
  
</html>