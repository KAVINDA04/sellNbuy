<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="assets/css/siteStyle.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="assets/js/sweetalert.min.js"></script>
</head>
<body style="background-image: url('image/buyWall.jpg');width: 100%">
	
	<div class="site_navBar">
        <img src="image/buy.png" class="logo" onclick="window.location.href='profileServlet'">
        <p onclick="window.location.href='registerServlet'">Register</p>
        <p onclick="window.location.href='loginServlet'">Login</p>
        <table>
            <tr>
                <form id="searchForm">
                    <td><input type="text" id="sreachProducts" placeholder="Search for anythig"></td>
                    <td><input type="submit" value="Search"></td>
                </form>
            </tr>
        </table>
    </div>
    
    <div class="loginBox">
	    <h2>Log In Here</h2>
	    <form id="loginForm">
	        <p>Email</p>
	        <input type="text" id="email" placeholder="Enter Email" required>
	        <p>Password</p>
	        <input type="password" id="pass1" placeholder="Enter Password" required>
	        <input type="submit" value="Sign in">
	    </form>
	    <a href="registerServlet">Register</a>
	</div>
	
</body>
</html>
<script>

	$(document).ready(function(){
		
		$("#loginForm").submit(function(e){
	        	
	       	var jsonfile = JSON.stringify({
				"email" : $('#email').val(),
				"pass1" : $('#pass1').val()
			});
			
			var ans = $.ajax({
				type : 'POST',
				url : 'http://localhost:8080/Ebuy/rest/register/login',
				dataType : 'json',
				contentType : 'application/json',
				data : jsonfile
			});
			
			ans.done(function(data){
				if(data['success']=="3"){
					$.ajax({
			             url:'http://localhost:8080/Ebuy/loginServlet',
			             type:'POST',
			             data:{
			            	 "email" : $('#email').val(),
			            	 "user" : "seller"
			             },
			             success : function(data){
			            	 window.location.href = "http://localhost:8080/Ebuy/sellerServlet";
			             }
			         });
				}else if(data['success']=="2"){
					$.ajax({
			             url:'http://localhost:8080/Ebuy/loginServlet',
			             type:'POST',
			             data:{
			            	 "email" : $('#email').val(),
			            	 "user" : "admin"
			             },
			             success : function(data){
			            	 window.location.href = "http://localhost:8080/Ebuy/adminServlet";
			             }
			         });
				}else if(data['success']=="1"){
					$.ajax({
			             url:'http://localhost:8080/Ebuy/loginServlet',
			             type:'POST',
			             data:{
			            	 "email" : $('#email').val(),
			            	 "user" : "user"
			             },
			             success : function(data){
			            	 window.location.href = "http://localhost:8080/Ebuy/userServlet";
			             }
			         });
				}else if(data['success']=="0"){
					swal({
			            title: "Error",
			            text: "Your Password Or Email Is Wrong!",
			            icon: "warning",
			            dangerMode: true,
			        });
				}
			});
			ans.fail(function(data){
				swal({
	                title: "Error",
	                text: "Connection Error !",
	                icon: "warning",
	                dangerMode: true,
	            });
			});
			
			
			e.preventDefault();
		});
		
	});
	
	$("#searchForm").submit(function(e){
    	
		$.ajax({
             url:'http://localhost:8080/Ebuy/serachServlet',
             type:'POST',
             data:{
            	 "search" : $('#sreachProducts').val()
             },
             success : function(data){
            	 window.location.href = "http://localhost:8080/Ebuy/serachServlet";
             }
         });
		
		e.preventDefault();
	});
	
</script>