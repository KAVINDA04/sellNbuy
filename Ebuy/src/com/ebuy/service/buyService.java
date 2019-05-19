package com.ebuy.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ebuy.model.Card;
import com.ebuy.model.Payment;
import com.ebuy.model.Product;
import com.ebuy.util.DBConnect;

public class buyService {
	
	private int success;

	public ArrayList<Product> getProduct(String search) {
		
		ArrayList<Product> productList = new ArrayList<Product>();
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			
			connection = DBConnect.getDBConnection();
			preparedStatement = connection.prepareStatement("select * from product where name like ?");
			preparedStatement.setString(1, '%'+search+'%');
			
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				
				Product product = new Product();
				
				product.setId(Integer.parseInt(resultSet.getString(1)));
				product.setName(resultSet.getString(2));
				product.setPrice(Double.parseDouble(resultSet.getString(3)));
				product.setCategory(Integer.parseInt(resultSet.getString(4)));
				product.setQuantity(Integer.parseInt(resultSet.getString(5)));
				
				productList.add(product);
				
			}
			
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return productList;
	}
	
	public ArrayList<Product> getBuyProduct(String search) {
		
		ArrayList<Product> productList = new ArrayList<Product>();
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			
			connection = DBConnect.getDBConnection();
			preparedStatement = connection.prepareStatement("select * from product where id=?");
			preparedStatement.setInt(1,Integer.parseInt(search));
			
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				
				Product product = new Product();
				
				product.setId(Integer.parseInt(resultSet.getString(1)));
				product.setName(resultSet.getString(2));
				product.setPrice(Double.parseDouble(resultSet.getString(3)));
				product.setCategory(Integer.parseInt(resultSet.getString(4)));
				product.setQuantity(Integer.parseInt(resultSet.getString(5)));
				
				productList.add(product);
				
			}
			
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return productList;
	}

	public void addPayment(Payment payment, Card card) {
		Connection connection;
		PreparedStatement preparedStatement;
		String cardNumber=null;
		
		try {
			connection = DBConnect.getDBConnection();
			
			//insert value
			preparedStatement = connection.prepareStatement("insert into payment (productID,name,amount,quantity,cardNumber,user,cancel,refund) values (?,?,?,?,?,?,?,?)");
			preparedStatement.setInt(1, payment.getId());
			preparedStatement.setString(2, payment.getName());
			preparedStatement.setDouble(3, payment.getAmount());
			preparedStatement.setInt(4, payment.getQuantity());
			preparedStatement.setString(5, card.getCardNumber());
			preparedStatement.setString(6, card.getUser());
			preparedStatement.setInt(7, 0);
			preparedStatement.setInt(8, 0);
			preparedStatement.execute();
			preparedStatement.close();
			connection.close();
			setSuccess(1);
				
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess(0);
		}
	}

	public int getSuccess() {
		return success;
	}

	public void setSuccess(int success) {
		this.success = success;
	}

	public void cancel(Payment payment) {
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			
			connection = DBConnect.getDBConnection();
			preparedStatement = connection.prepareStatement("UPDATE payment SET cancel=?,refund=? where id=?");
			preparedStatement.setInt(1, 2);
			preparedStatement.setInt(2, 3);
			preparedStatement.setInt(3, payment.getId());
			preparedStatement.execute();
			setSuccess(1);
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess(0);
		}
		
	}

	public void refund(Payment payment) {
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			
			connection = DBConnect.getDBConnection();
			preparedStatement = connection.prepareStatement("UPDATE payment SET cancel=?,refund=? where id=?");
			preparedStatement.setInt(1, 2);
			preparedStatement.setInt(2, 2);
			preparedStatement.setInt(3, payment.getId());
			preparedStatement.execute();
			setSuccess(1);
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess(0);
		}
	}
	
}
