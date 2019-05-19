<%@page import="com.ebuy.service.*"%>
<%@page import="com.ebuy.model.*"%>
<%@page import="java.util.ArrayList"%>
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
	<script src="assets/js/sweetalert.min.js" crossorigin="anonymous"></script>
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
	    <h2>Send Message To Seller</h2>
	    <form id="MessageForm" >
	        <p>Message</p>
	        <input type="text" id="message" placeholder="Enter Message" required>
	        <input type="hidden" id="user" value="${sessionScope.email }" required>
	        <br><br>
	        <input type="submit" value="Send Message">
	    </form>
	    <div id="messageDiv">
		    <%
		    	messageService msg = new messageService();
				ArrayList<Message> arrayList = msg.getMsg((String)session.getAttribute("email"));
			
				String seller = null;
				
				for (Message messages : arrayList) {
					
					if(messages.getSeller()==1){
						seller = "Seller : ";
					}else{
						seller = "You : ";
					}
					
			%>
				<p><%=seller+messages.getMessage() %></p>
			<%
				}
			%>
		</div>
	</div>
	
</body>
</html>

<script>

	$(document).ready(function(){
		
		$("#MessageForm").submit(function(e){
	        	
        	var jsonfile = JSON.stringify({
				"message" : $('#message').val(),
				"user" : $('#user').val()
			});
			
			var ans = $.ajax({
				type : 'POST',
				url : 'http://localhost:8080/Ebuy/rest/message/message',
				dataType : 'json',
				contentType : 'application/json',
				data : jsonfile
			});
			
			ans.done(function(data){
				if(data['success']=="1"){
					swal("Success!", "Message Send Successfull!", "success");
					$('#message').val("");
					$('#user').val("");
				}else if(data['success']=="0"){
					swal({
			            title: "Error",
			            text: "Message Send Unsuccessfull!",
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
	
	setInterval("my_function();",1000); 
	 
    function my_function(){
    	$("#messageDiv").load(location.href + " #messageDiv");
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