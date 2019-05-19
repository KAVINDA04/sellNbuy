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
    
	<div id="editProductsDiv">
		<div class="registerBox">
		    <h2>Edit Product</h2>
		    <form id="productForm" >
		    	<p>Old Product Name</p>
		    	<select id="productId" onchange="setProduct()" required>
		    		<option value="">Select Package Name</option>
		    		<%
		    			productService getProduct = new productService();
						ArrayList<Product> arrayList = getProduct.getProduct();
			
						for (Product product : arrayList) {
					%>
					<option value="<%=product.getId() %>" ><%=product.getName() %></option>
					<%
						}
					%>
		    	</select>
		        <p>Product Name</p>
		        <input type="text" id="name" placeholder="Enter Name" required>
		        <p>Product Price</p>
		        <input type="number" id="price" min="0" step="0.01" placeholder="Enter Price" required>
		        <p>Product Category</p>
		        <select id="category" required>
		        	<option value="" >Select Category</option>
		        	<option value="1" >Electronics</option>
		        	<option value="2" >Fashion</option>
		        	<option value="3" >Toys</option>
		        	<option value="4" >Music</option>
		        	<option value="5" >Accessories</option>
		        </select>
		        <p>Quantity</p>
		        <input type="number" id="quantity" min="0" step="1" placeholder="Enter Quantity" required>
		        <br><br>
		        <input type="submit" value="Edit Product">
		    </form>
		</div>
	</div>
	
	<div style="display: none;" id="storeValues" >
    		<%
				for (Product product : arrayList) {
			%>
			<input id="productName<%=product.getId() %>"  value="<%=product.getName() %>">
			<input id="productPrice<%=product.getId() %>"  value="<%=product.getPrice() %>">
			<input id="productCategory<%=product.getId() %>"  value="<%=product.getCategory() %>">
			<input id="productQuantity<%=product.getId() %>"  value="<%=product.getQuantity() %>">
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
        		"id" : $('#productId').val(),
        		"name" : $('#name').val(),
				"price" : $('#price').val(),
				"category" : $('#category').val(),
				"quantity" : $('#quantity').val()
			});
			
			var ans = $.ajax({
				type : 'POST',
				url : 'http://localhost:8080/Ebuy/rest/product/editproduct',
				dataType : 'json',
				contentType : 'application/json',
				data : jsonfile
			});
			
			ans.done(function(data){
				if(data['success']=="1"){
					swal("Success!", "Product Edit Successfull!", "success");
					$('#productId').val("");
					$('#name').val("");
					$('#price').val("");
					$('#category').val("");
					$('#quantity').val("");
					$('#editProductsDiv').empty();
					$("#editProductsDiv").load(location.href + " #editProductsDiv");
					$('#storeValues').empty();
					$("#storeValues").load(location.href + " #storeValues");
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
		
	});
	
	function setProduct() {
		
	    var id = document.getElementById("productId").value;
	
	    var name = 'productName'+id;
	    var price = 'productPrice'+id;
	    var category = 'productCategory'+id;
	    var quantity = 'productQuantity'+id;
	
	    document.getElementById("name").value = document.getElementById(name).value;
	    document.getElementById("price").value = document.getElementById(price).value;
	    document.getElementById("category").value = document.getElementById(category).value;
	    document.getElementById("quantity").value = document.getElementById(quantity).value;
	
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