<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Register</title>
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
	
	<div class="registerBox">
	    <h2>Register In Here</h2>
	    <form id="registerForm" >
	        <p>First Name</p>
	        <input type="text" id="fname" placeholder="Enter First Name" required>
	        <p>Last Name</p>
	        <input type="text" id="lname" placeholder="Enter Last Name" required>
	        <p>Email</p>
	        <input type="email" id="email" placeholder="Enter Email" required>
	        <p>Password</p>
	        <input type="password" id="pass1" placeholder="Enter Password" required>
	        <p>Confirm Password</p>
	        <input type="password" id="pass2" placeholder="Enter Confirm Password" required>
	        <br><br>
	        <input type="submit" value="Register">
	    </form>
	    <a href="loginServlet">Login</a>
	</div>
	
</body>
</html>
<script>

	$(document).ready(function(){
		
		$("#registerForm").submit(function(e){
			
			var pass1 =document.getElementById("pass1").value;
	        var pass2 =document.getElementById("pass2").value;
			
	        if (pass1.length<6){
	            swal({
	                title: "Error",
	                text: "Your Password Must Contain At Least 6 Characters!",
	                icon: "warning",
	                dangerMode: true,
	            });
	            return false;
	        }else if (pass1 != pass2){
	            swal({
	                title: "Error",
	                text: "Your Password & Confirm Password Are not Match!",
	                icon: "warning",
	                dangerMode: true,
	            });
	            document.getElementById("pass1").value = "";
	            document.getElementById("pass2").value = "";
	            return false;
	        } else {
	        	
	        	var jsonfile = JSON.stringify({
					"fname" : $('#fname').val(),
					"lname" : $('#lname').val(),
					"email" : $('#email').val(),
					"pass1" : $('#pass1').val()
				});
				
				var ans = $.ajax({
					type : 'POST',
					url : 'http://localhost:8080/Ebuy/rest/register/register',
					dataType : 'json',
					contentType : 'application/json',
					data : jsonfile
				});
				
				ans.done(function(data){
					if(data['success']=="1"){
						swal("Success!", "Your Account Has Been Registered. You Can Login Now!", "success");
						$('#fname').val("");
						$('#lname').val("");
						$('#email').val("");
						$('#pass1').val("");
					}else if(data['success']=="0"){
						swal({
				            title: "Error",
				            text: "This Email is Already Exists",
				            icon: "warning",
				            dangerMode: true,
				        });
						$('#email').val("");
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
				
	        }
			
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