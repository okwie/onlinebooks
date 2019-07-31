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
     --><link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
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
             
             <br>
             <h3 class="text-info text-center">
                ${book.title} ${msg} 
             </h3><br>
    <div class="row justify-content-center">
    <div class="col-lg-4 col-md-4">	        
   <img src="${contextPath}//books//${book.id}//${book.image}" width="350" height="280"/>
</div>  
 
<div class="col-lg-4 col-md-4 text-info">	        
    ${book.author}<br>
            ${book.title}            
            ${book.description}<br>
            Total Due $ ${book.price}<br>
            
            <c:choose>
            <c:when test="${not empty loggedInUser.email}">
             <a href="addcart-${book.id}-${loggedInUser.email}" title="add to cart ${item.title}" class="btn btn-success btn-sm">
    <b>Add To Cart </b> <i class="fa fa-shopping-bag"></i> 
</a>
            </c:when>
            <c:otherwise>
             <a href="addtocart-${book.id}" title="add to cart ${item.title}" class="btn btn-success btn-sm">
    <b>Add To Cart </b> <i class="fa fa-shopping-bag"></i> 
</a>
            </c:otherwise>	            
            </c:choose>
            
            
<a href="index" title="Continue Shopping" class="btn btn-info btn-sm">
    <b>Continue Shopping </b> <i class="fa fa-shopping-bag"></i> 
</a>
<br>	
 
</div>     
    
            <div class="col-lg-4 col-md-4"> 
                   
    <table class="table table-condensed">
                      <thead>
                        <tr>
                          <th colspan="2"><span>
                          <img src="
							https://www.paypalobjects.com/webstatic/mktg/logo/PP_AcceptanceMarkTray-NoDiscover_243x40.png" 
							alt="BooksOnline">  
							</span>
                         </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            Sub total                            
                          </td>
                          <td>
                            <div class="price-box"> 
                            $ ${book.price}
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
                            $ ${book.price+ship}                            
                          </td>                          
                        </tr>
                        
                      </tbody>
                    </table>
                    <hr>
                    <c:if test="${empty cart}">
                     <form action="https://www.paypal.com/cgi-bin/webscr" method="post" class="float-right">	
						<!-- Identify your business so that you can collect the payments. -->
						<input type="hidden" name="business" value="okwi@gmail.com">
						<input type=hidden name="amount" value=" ${book.price+ship} ">
						<!-- Specify a Buy Now button. -->
						<input type="hidden" name="cmd" value="_xclick">
						<input type="hidden" name="currency_code" value="USD">
						<!-- Display the payment button. -->
						<input type="image" name="submit"
						   src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/checkout-logo-medium.png
						"
						   alt="Add to Cart">
							   <img alt="" border="0" width="1" height="1"
							src="static/images/paypal-img.png" >	
					</form>
					</c:if> 
					<c:if test="${not empty cart}">
								<c:choose>
								<c:when test="${not empty loggedInUser.email}">
								<a href="shoppcart-${loggedInUser.email}" title="Shopping Cart" class="btn btn-info btn-sm">
								    <b>Check Out </b> <i class="fa badge" style="font-size:16px" value="${cart.size()}">&#xf07a;</i></a>
								    <button type="button" class="btn" data-toggle="modal" data-target="#myModal"><i class="fa fa-envelope">
								    Contact Seller</i></button>
								
								</c:when>
								<c:otherwise>
								<a href="mycart" title="Continue Shopping" id="checkout" class="btn btn-info btn-sm">
								    <b>Check Out </b> <i class="fa badge" style="font-size:16px" value="${cart.size()}">&#xf07a;</i>
								</a>
								</c:otherwise>
								</c:choose>
								
					
					</c:if>
               </div>            
            </div>             
</div>	

<c:if test="${not empty list}">

     <br>
             <h3 class="text-info text-center">
                Related Products
             </h3>
             <table class="table table-striped table-hover">
             <thead class="thead-dark">
             <tr class="text-success">
             <th>#</th>
             <th>Image <i class="fa fa-sort-amount-desc"></i></th>
             <th>Title</th>
             <th>Author</th>
             <th><input type="text" id="search" placeholder=" Filter Books (${list.size()}) " class="form-control"  ></th>
             <th>Price<i class="fas fa-dollar-sign"></i>             
             </th>
             
             </tr>
             </thead>
             <tbody>
             <c:forEach var="item" items="${list}">
             <tr>
             <td>${list.indexOf(item)+1} </td>             
             <td>              
  <c:choose>
<c:when test="${not empty item.image}">
<a href="checkout-${item.id}" title="View ${item.title}">
<img src="${contextPath}//books//${item.id}//${item.image}" width="150" height="100"/></a>
<div>    
    
<div class="form-group">
<form action="https://www.paypal.com/cgi-bin/webscr" method="post" >	
  <input type="hidden" name="business" value="okwi@gmail.com">
<input type=hidden name="amount" value=" ${item.price+ship} ">
<!-- Specify a Buy Now button. -->
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="currency_code" value="USD">
<!-- Display the payment button. -->
 
<input type="image" name="submit"
   src="
https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif
"
   alt="Add to Cart">
   	
  </form> 
</div> 
 
</div>
</c:when>
<c:otherwise>
No Image	

<div class="form-group">
<form action="https://www.paypal.com/cgi-bin/websrc" method="post" >	
  <input type="hidden" name="business" value="okwi@gmail.com">
<input type=hidden name="amount" value=" ${item.price+ship} ">
<!-- Specify a Buy Now button. -->
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="currency_code" value="USD">
<!-- Display the payment button. -->
 
<input type="image" name="submit"
   src="
https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif
"
   alt="Add to Cart">
   	
  </form> 
</div>     
</c:otherwise>
</c:choose>
     
</td>
             <td>${item.title}</td>             
             <td>${item.author}</td>
             <td>${item.description}<br>
             <c:choose>
            <c:when test="${not empty loggedInUser.email}">
             <a href="addcart-${item.id}-${loggedInUser.email}" title="add to cart ${item.title}" class="btn btn-success btn-sm">
    <b>Add To Cart </b> <i class="fa fa-shopping-bag"></i> 
</a>
            </c:when>
            <c:otherwise>
             <a href="addtocart-${item.id}" title="add to cart ${item.title}" class="btn btn-success btn-sm">
    <b>Add To Cart </b> <i class="fa fa-shopping-bag"></i> 
</a>
            </c:otherwise>	            
            </c:choose>
             
     
</td>
             <td>
            
             <fmt:formatNumber value = "${item.price}" 
              type = "currency"/>
         </td>
                      
             </tr>
             </c:forEach>
             
             </tbody>
             
             </table>
             </c:if>
     
     
     
     </div>
 
  <div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Contact Seller</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
     	<form action="contactseller" method="POST"> 
     	<input type="hidden" class="form-control" name="email" value="${book.email}">
     	<input type="hidden" class="form-control" name="email2" value="${loggedInUser.email}">
     	<textarea name="msg" placeholder="type your message here" rows="4" cols="62"></textarea>
     	<button type="submit" class="btn btn-success">Send</button>
     	</form>
     	
            
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