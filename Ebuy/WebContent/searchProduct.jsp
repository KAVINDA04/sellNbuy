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
	
	<div class="productitems">
        <br>
        <%
   			buyService getProduct = new buyService();
			ArrayList<Product> arrayList = getProduct.getProduct((String)session.getAttribute("search"));

			String category = null;
                    		
			for (Product product : arrayList) {
				if(product.getCategory()==1){
					category="image/Electronics.jpg";
				}else if(product.getCategory()==2){
					category="image/Fashion.jpg";
				}else if(product.getCategory()==3){
					category="image/Toys.jpg";
				}else if(product.getCategory()==4){
					category="image/Music.jpg";
				}else if(product.getCategory()==5){
					category="image/Accessories.jpg";
				}
				
		%>
			<div class="searchItems">
	            <img src="<%=category %>" >
	            <p id="<%=product.getId() %>" onclick="clickProduct(this)" ><%=product.getName() %><br>Price Rs.<%=product.getPrice() %><br>Available Quantity :<%=product.getQuantity() %></p>
			</div>
		<%	
			}
		%>
    </div>
	
</body>
</html>

<script>

	$(document).ready(function(){
		
		$("#productForm").submit(function(e){
	        	
        	var jsonfile = JSON.stringify({
				"name" : $('#name').val(),
				"price" : $('#price').val(),
				"category" : $('#category').val(),
				"quantity" : $('#quantity').val()
			});
			
			var ans = $.ajax({
				type : 'POST',
				url : 'http://localhost:8080/Ebuy/rest/product/product',
				dataType : 'json',
				contentType : 'application/json',
				data : jsonfile
			});
			
			ans.done(function(data){
				if(data['success']=="1"){
					swal("Success!", "Product Added Successfull!", "success");
					$('#name').val("");
					$('#price').val("");
					$('#category').val("");
					$('#quantity').val("");
				}else if(data['success']=="0"){
					swal({
			            title: "Error",
			            text: "This Product is Already Exists",
			            icon: "warning",
			            dangerMode: true,
			        });
					$('#name').val("");
					$('#category').val("");
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
		
	});
	
	function clickProduct(id){
		var item = id.id;
		
		$.ajax({
            url:'http://localhost:8080/Ebuy/buyServlet',
            type:'POST',
            data:{
           	 "id" : item
            },
            success : function(data){
           	 window.location.href = "http://localhost:8080/Ebuy/buyServlet";
            }
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