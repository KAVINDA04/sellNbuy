package com.ebuy.rest;

import java.sql.SQLException;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import org.json.simple.*;
import org.json.simple.parser.*;

import com.ebuy.model.*;
import com.ebuy.service.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Path("/message")
public class message {
	
	@POST
	@Path("/message")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	
	public String messages(String re) throws ClassNotFoundException,SQLException,ParseException {
		
		JSONParser jp = new JSONParser();
		JSONObject jobj = (JSONObject) jp.parse(re);
		
		// create object
		Message message =  new Message();
		
		message.setMessage(jobj.get("message").toString());
		message.setUser(jobj.get("user").toString());
		
		messageService newMessage = new messageService();
		newMessage.newMessage(message);
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(newMessage.getSuccess()));
		
		return json.toString();
		
	}

	@POST
	@Path("/sellerMessage")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	
	public String sellerMessages(String re) throws ClassNotFoundException,SQLException,ParseException {
		
		JSONParser jp = new JSONParser();
		JSONObject jobj = (JSONObject) jp.parse(re);
		
		// create object
		Message message =  new Message();
		
		message.setMessage(jobj.get("message").toString());
		message.setUser(jobj.get("user").toString());
		message.setSeller(1);
		
		messageService newMessage = new messageService();
		newMessage.newSellerMessage(message);
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(newMessage.getSuccess()));
		
		return json.toString();
		
	}

}
