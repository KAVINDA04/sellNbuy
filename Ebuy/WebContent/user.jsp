<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Ebuy</title>
	<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="assets/js/jquery.okayNav.js"></script>

    <link rel="stylesheet" type="text/css" href="assets/css/siteStyle.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="assets/js/sweetalert.min.js"></script>
</head>
<body style="background-image: url('image/buyWall.jpg');width: 100%">
	
	<div class="site_navBar">
        <img src="image/buy.png" class="logo" onclick="window.location.href='profileServlet'">
        <p onclick="window.location.href='logoutServlet'" >Logout</p>
        <p onclick="window.location.href='profileServlet'" >Account</p>
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
	    <h2>User Account</h2>
	    <br>
	    <form action="addCardSevlet" >
	        <input type="submit" value="Add Card">
	    </form>
	    <br>
	    <form action="removeCardSevlet" >
	        <input type="submit" value="Remove Card">
	    </form>
	    <br>
	    <form action="userOrdersServlet" >
	        <input type="submit" value="My Orders">
	    </form>
	    <br>
	    <form action="userMessageServlet" >
	        <input type="submit" value="Messages">
	    </form>
	</div>
	
</body>
</html>
<script>

	window.onload = function(){
	    var x=${sessionScope.errors_success };
	    if("1"==x){
	        swal("Success!", "Payment Successful!", "success");
	        <% session.setAttribute("errors_success", null); %>
	    }
	}
	

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