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
    
	<div id="cancelDiv">
		<div class="registerBox">
		    <h2>My Orders</h2>
		    <div class="reservations">
	            <table class="reservationTable">
	                <tr>
	                	<th class="tableNew">Order ID</th>
	                    <th class="tableNew">Product Name</th>
	                    <th class="tableNew">Amount(Rs.)</th>
	                    <th class="tableNew">quantity</th>
	                    <th class="tableNew">Card Number</th>
	                    <th class="tableNew">Order Cancel</th>
	                    <th class="tableNew">Refund</th>
	                </tr>
	                	<%
			    			cardService card = new cardService();
							ArrayList<Payment> arrayList = card.getOrders((String)session.getAttribute("email"));
				
							String cancel="",refund="";
							
							for (Payment payment : arrayList) {
								
								if(payment.getCancel()==0){
									cancel="X";
								}else{
									cancel="";
								}
								
								if(payment.getRefund()==0){
									refund="";
								}else if(payment.getRefund()==1){
									refund="Pending";
								}else if(payment.getRefund()==2){
									refund="Refunded";
								}else if(payment.getRefund()==3){
									refund="Rejected";
								}
						%><tr>
							<td class="tableNew"><%=payment.getId() %></td>
							<td class="tableNew"><%=payment.getName() %></td>
							<td class="tableNew"><%=payment.getAmount() %></td>
							<td class="tableNew"><%=payment.getQuantity() %></td>
							<td class="tableNew"><%=payment.getCardNumber() %></td>
							<td class="tableNew"><p id="<%=payment.getId() %>" style="cursor: pointer" onclick="clickCancel(this);"><%=cancel %></p></td>
							<td class="tableNew"><%=refund %></td>
						  </tr>
						<%
							}
						%>
	            </table>
		</div>
	</div>
</body>
</html>

<script>
	
	function clickCancel(id){
		var order = id.id;
		
		var jsonfile = JSON.stringify({
			"id" : order
		});
		
		var ans = $.ajax({
			type : 'POST',
			url : 'http://localhost:8080/Ebuy/rest/card/cancel',
			dataType : 'json',
			contentType : 'application/json',
			data : jsonfile
		});
		
		ans.done(function(data){
			if(data['success']=="1"){
				swal("Success!", "Request Successfull!", "success");
				$('#cancelDiv').empty();
				$("#cancelDiv").load(location.href + " #cancelDiv");
			}else if(data['success']=="0"){
				swal({
		            title: "Error",
		            text: "Request Unuccessfull!",
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