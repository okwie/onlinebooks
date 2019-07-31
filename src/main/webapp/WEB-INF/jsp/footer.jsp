  <div class="modal" id="editUser">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Edit Profile</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form class="navbar-form navbar-right" role="search"  action="search" method="post">
				    <div class="input-group add-on">										      
				     <form:form method="POST" action="editUser" modelAttribute="${loggedInUser}" >	

							<label>First Name</label>
							
							<form:input path="firstName" id="fn" class="form-control"/>	
							<div class="has-error">
							<form:errors path="firstName" class="text-danger"/>
							</div>	
							
							<label>Last Name</label>
							<form:input path="lastName" id="ln" class="form-control" />	
							<div class="has-error">
							<form:errors path="lastName" class="text-danger"/>
							</div>
							
							<label>Email</label>	
							
							<form:input  path="email" id="em" class="form-control" />	
							<div class="has-error">
							<form:errors path="email" class="text-danger"/>
							</div>
							
							<label>Password</label>	
							
							<form:input type="password"  path="password" id="password" class="form-control" />	
							<div class="has-error">
							<form:errors path="password" class="text-danger"/>
							</div>	
							<label>Phone</label>	
							
							<form:input  path="phone" id="phone" class="form-control" />	
							<div class="has-error">
							<form:errors path="phone" class="text-danger"/>
							</div>	
							
							<form:input type="hidden" path="id" />
							<br>
							<div class="container-login100-form-btn">
							<button class="btn btn-primary" type="submit" id="submit" >Submit</button>
							<a class="btn btn-primary" href="index">Cancel </a>	
							</div>
							</form:form>
					    </div>
					 </form>
  
      
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-bottom">        
        <div id="navbarNavDropdown" class="navbar-collapse collapse">
             <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index">College Books <span class="sr-only">(current)</span></a>
                </li>                
            
				<li class="nav-item">
                    <a class="nav-link" href="#">Contact Us</a>
                </li>
                
               
                <li class="nav-item">
                    <a class="nav-link" id="logout" href="logout">Logout</a>
                </li>
                
        
                <li class="nav-item">
                    <a class="nav-link" href="login" id="login">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register">Register</a>
                </li>
                </ul>
                                
  </div>        
</nav>
       
               