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
	    <h2>Add Card</h2>
	    <form id="cardForm">
    	<p>Card Number</p>
        <input type="tel" pattern="[0-9]{16}" id="cardNumber" placeholder="Enter Card Number" required>
        <p>CCV Code</p>
        <input type="tel" pattern="[0-9]{3}" id="ccvCode" placeholder="Enter CCV Code" required>
        <p>Expiry Date (Month)</p>
        <select id="month" required>
        	<option value="">Select Month</option>
        	<option value="1">01</option>
        	<option value="2">02</option>
        	<option value="3">03</option>
        	<option value="4">04</option>
        	<option value="5">05</option>
        	<option value="6">06</option>
        	<option value="7">07</option>
        	<option value="8">08</option>
        	<option value="9">09</option>
        	<option value="10">10</option>
        	<option value="11">11</option>
        	<option value="12">12</option>
        </select>
        <p>Expiry Date (Year)</p>
        <select id="year" required>
        	<option value="">Select Year</option>
        	<option value="19">19</option>
        	<option value="20">20</option>
        	<option value="21">21</option>
        	<option value="22">22</option>
        	<option value="23">23</option>
        	<option value="24">24</option>
        	<option value="25">25</option>
        	<option value="26">26</option>
        	<option value="27">27</option>
        	<option value="28">28</option>
        	<option value="29">29</option>
        	<option value="30">30</option>
        </select>
        <input type="hidden" id="user" value="${sessionScope.email }" required>
        <br><br><br>
        <input type="submit" value="Add Crad">
    </form>
	</div>
	
</body>
</html>

<script>

	$(document).ready(function(){
		
		$("#cardForm").submit(function(e){
	        	
        	var jsonfile = JSON.stringify({
				"cardNumber" : $('#cardNumber').val(),
				"ccvCode" : $('#ccvCode').val(),
				"month" : $('#month').val(),
				"year" : $('#year').val(),
				"user" : $('#user').val()
			});
			
			var ans = $.ajax({
				type : 'POST',
				url : 'http://localhost:8080/Ebuy/rest/card/addCard',
				dataType : 'json',
				contentType : 'application/json',
				data : jsonfile
			});
			
			ans.done(function(data){
				if(data['success']=="1"){
					swal("Success!", "Card Added Successfull!", "success");
					$('#cardNumber').val("");
					$('#ccvCode').val("");
					$('#month').val("");
					$('#year').val("");
				}else if(data['success']=="0"){
					swal({
			            title: "Error",
			            text: "Card Added Unsuccessfull",
			            icon: "warning",
			            dangerMode: true,
			        });
					$('#cardNumber').val("");
					$('#ccvCode').val("");
					$('#month').val("");
					$('#year').val("");
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