package com.ebuy.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;

import com.ebuy.model.*;
import com.ebuy.util.*;



public class messageService {

	private int success;
	
	public void newMessage(Message message) {
		Connection connection;
		PreparedStatement preparedStatement;
		String cardNumber=null;
		
		try {
			connection = DBConnect.getDBConnection();
			
			//insert value
			preparedStatement = connection.prepareStatement("insert into messages (message,user,seller) values (?,?,?)");
			preparedStatement.setString(1, message.getMessage());
			preparedStatement.setString(2, message.getUser());
			preparedStatement.setInt(3, 0);
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
	
	public ArrayList<Message> getMsg(String user) {
		
		ArrayList<Message> messageList = new ArrayList<Message>();
		Connection connection;
		PreparedStatement preparedStatement;
		try {
			
			connection = DBConnect.getDBConnection();
			preparedStatement = connection.prepareStatement("select * from messages where user=? ORDER BY id DESC");
			preparedStatement.setString(1, user);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				
				Message message = new Message();
				
				message.setMessage(resultSet.getString(2));
				message.setSeller(resultSet.getInt(4));
				
				messageList.add(message);
				
			}
			
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {
	
			System.out.println(e.getMessage());
		}
	
		return messageList;
	}
	
	public ArrayList<Message> getSellerMsg() {
		
		ArrayList<Message> messageList = new ArrayList<Message>();
		Connection connection;
		PreparedStatement preparedStatement;
		try {
			
			connection = DBConnect.getDBConnection();
			preparedStatement = connection.prepareStatement("select * from messages ORDER BY id DESC");
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				
				Message message = new Message();
				
				message.setMessage(resultSet.getString(2));
				message.setUser(resultSet.getString(3));
				message.setSeller(resultSet.getInt(4));
				
				messageList.add(message);
				
			}
			
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {
	
			System.out.println(e.getMessage());
		}
	
		return messageList;
	}
	
	public ArrayList<User> getUser() {
		
		ArrayList<User> userList = new ArrayList<User>();
		Connection connection;
		PreparedStatement preparedStatement;
		try {
			
			connection = DBConnect.getDBConnection();
			preparedStatement = connection.prepareStatement("select * from users");
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				
				User user = new User();
				
				user.setEmail(resultSet.getString(4));
				
				userList.add(user);
				
			}
			
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {
	
			System.out.println(e.getMessage());
		}
	
		return userList;
	}

	public void newSellerMessage(Message message) {
		Connection connection;
		PreparedStatement preparedStatement;
		String cardNumber=null;
		
		try {
			connection = DBConnect.getDBConnection();
			
			//insert value
			preparedStatement = connection.prepareStatement("insert into messages (message,user,seller) values (?,?,?)");
			preparedStatement.setString(1, message.getMessage());
			preparedStatement.setString(2, message.getUser());
			preparedStatement.setInt(3, message.getSeller());
			preparedStatement.execute();
			preparedStatement.close();
			connection.close();
			setSuccess(1);
			
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess(0);
		}
		
	}

}
