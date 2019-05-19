package com.ebuy.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

import com.ebuy.model.*;
import com.ebuy.util.DBConnect;

public class registerService {
	
	private int success;

	public void register(User user) {
		
		Connection connection;
		PreparedStatement preparedStatement;
		String email=null;
		
		try {
			connection = DBConnect.getDBConnection();
			
			//check email
			preparedStatement = connection.prepareStatement("select * from users where email=?");
			preparedStatement.setString(1, user.getEmail());
			ResultSet rs = preparedStatement.executeQuery();
			
			while(rs.next())
			{
				email = rs.getString(4);	
			}
			
			if(email==null) {
				
				//insert value
				preparedStatement = connection.prepareStatement("insert into users (fname,lname,email,password) values (?,?,?,?)");
				preparedStatement.setString(1, user.getFname());
				preparedStatement.setString(2, user.getLname());
				preparedStatement.setString(3, user.getEmail());
				preparedStatement.setString(4, user.getPassword());
				preparedStatement.execute();
				preparedStatement.close();
				connection.close();
				setSuccess(1);
				
			}else {
				setSuccess(0);
			}
			
		}catch (ClassNotFoundException | SQLException  e) {
			System.out.println(e.getMessage());
		}
		
	}

	public int getSuccess() {
		return success;
	}

	public void setSuccess(int success) {
		this.success = success;
	}
	
	public void login(User user) {
		Connection connection;
		PreparedStatement preparedStatement;
		String email=null,admin=null;
		
		try {
			connection = DBConnect.getDBConnection();
			
			//check email and password
			preparedStatement = connection.prepareStatement("select * from users where email=? and password=?");
			preparedStatement.setString(1, user.getEmail());
			preparedStatement.setString(2, user.getPassword());
			ResultSet rs = preparedStatement.executeQuery();
			
			while(rs.next())
			{
				email = rs.getString(4);
				admin = rs.getString(6);
			}
			
			if(email==null) {
				setSuccess(0);
			}else {
				if(admin==null) {
					setSuccess(1);
				}else if(admin.toString().equals("1")){
					setSuccess(2);
				}else if(admin.toString().equals("2")){
					setSuccess(3);
				}
			}
			
		}catch (ClassNotFoundException | SQLException  e) {
			System.out.println(e.getMessage());
		}

	}

}
