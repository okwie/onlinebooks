<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light">        
        <div id="navbarNavDropdown" class="navbar-collapse collapse">
             <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index">College Books <span class="sr-only">(current)</span></a>
                </li>                
             </ul>
            <ul class="navbar-nav"> 
                <c:if test="${empty cart}">
                <li class="nav-item">
                    <a class="nav-link" href="index">Shop 
                    <i class="fa fa-shopping-bag text-danger"></i></a>                    
                </li>
                </c:if>  
                <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        About
      </a>
      <div class="dropdown-menu">
      <c:if test="${loggedInUser.role eq 'ADMIN'}">
        <a class="dropdown-item" href="admin" >Admin</a>
        </c:if>
        <a class="dropdown-item" href="#">About Us</a>
        <a class="dropdown-item" href="#">Contact Us</a>
       
      </div>
    </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contact Us</a>
                </li>
                <c:choose>
                <c:when test="${not empty loggedInUser.email}">  
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="myprofile" data-toggle="dropdown">
			        My Profile
			      </a>
			      <div class="dropdown-menu">
			      	<c:if test="${loggedInUser.role eq 'ADMIN'}">
			        <a class="dropdown-item" href="admin" id="admin">Admin</a>
			        </c:if>
			        <a class="dropdown-item" href="profile">Profile</a>
			        <a href="editUser-${loggedInUser.id}" class="dropdown-item" >Edit Profile
			        ${loggedInUser.id}</a>
			        </div>
                </li> 
                <li class="nav-item">
                    <a class="nav-link" id="logout" href="logout">${loggedInUser.email} || Logout</a>
                </li>
                
                </c:when>
                <c:otherwise>
                <li class="nav-item">
                    <a class="nav-link" href="login" id="login">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register">Register</a>
                </li>
                </c:otherwise>                
                </c:choose>                  
                <c:if test="${not empty cart}">	
                <li class="nav-item dropdown">
      
      <c:choose>
                <c:when test="${not empty loggedInUser.email}"> 
                <c:if test="${not empty cart}">	  
                    <a class="nav-link" href="shoppcart"><i class="fa badge" style="font-size:20px" value="${cart.size()}">&#xf07a;</i></a>                           
                </c:if>
                
                </c:when>
                <c:otherwise>
                <a  href="mycart" id="navbardrop" >
        <i class="fa badge" style="font-size:20px" value="${cart.size()}">&#xf07a;</i> 
        </a>
                </c:otherwise>                
                </c:choose> 
      <div class="dropdown-menu">
      <c:set var="totalprice" value="${0}" />             
        <table class="table table-striped table-hover text-success">
          <c:forEach var="item" items="${cart}">
                     <c:set var="totalprice" value="${totalprice + item.price + ship}" />
                        <tr>
                         <td>${cart.indexOf(item)+1}.</td>
                         <td>
                         ${item.title}
                         </td>
                         <td>$${totalprice}0</td>
                         <td>
                         <c:choose>
                <c:when test="${not empty loggedInUser.email}">  
                <c:if test="${not empty cart}">	
                <a href="deletefromcart-${item.id}-${loggedInUser.email}" onclick="confirmed(); return false;" title="Delete Book" >
            <i class="far fa-trash-alt text-danger"></i>           
             </a>	  
                </c:if>                
                </c:when>
                <c:otherwise>
                <a href="removefromcart-${item.id}" onclick="confirmed(); return false;" title="Delete Book" >
             <i class="far fa-trash-alt text-danger"></i>           
             </a>
                </c:otherwise>                
             </c:choose>	                
            </td>                                    
                        </tr>
                       </c:forEach>                       
                      </tbody>
                    </table>
        
      </div>
    </li>
      
                                            
                </c:if>        
    
    <li class="nav-item text-right">
    <form action="search" method="post">
<div class="input-group">
      <input class="form-control" type="search" name="author" placeholder="Search Books">
      <span class="input-group-append">
        <button class="btn btn-outline-secondary" type="submit">
            <i class="fa fa-search"></i>
        </button>
      </span>
    </div>
  </form>
  </li>
  
            </ul>
        </div>
    </nav>
