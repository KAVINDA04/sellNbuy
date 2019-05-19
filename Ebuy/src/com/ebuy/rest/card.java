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

@Path("/card")
public class card {
	
	@POST
	@Path("/addCard")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	
	public String myMethod(String re) throws ClassNotFoundException,SQLException,ParseException {
		
		JSONParser jp = new JSONParser();
		JSONObject jobj = (JSONObject) jp.parse(re);
		
		// create object
		Card card =  new Card();
		
		card.setCardNumber(jobj.get("cardNumber").toString());
		card.setCcvCode(Integer.parseInt(jobj.get("ccvCode").toString()));
		card.setMonth(Integer.parseInt(jobj.get("month").toString()));
		card.setYear(Integer.parseInt(jobj.get("year").toString()));
		card.setUser(jobj.get("user").toString());
		
		cardService newCard = new cardService();
		newCard.addCard(card);
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(newCard.getSuccess()));
		
		return json.toString();
		
	}
	
	@POST
	@Path("/deleteCard")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	
	public String deleteCard(String re) throws ClassNotFoundException,SQLException,ParseException {
		
		JSONParser jp = new JSONParser();
		JSONObject jobj = (JSONObject) jp.parse(re);
		
		// create object
		Card card =  new Card();
		
		card.setId(Integer.parseInt(jobj.get("id").toString()));
		
		cardService newCard = new cardService();
		newCard.deleteCard(card);
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(newCard.getSuccess()));
		
		return json.toString();
		
	}
	
	@POST
	@Path("/cancel")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	
	public String deleteProduct(String re) throws ClassNotFoundException,SQLException,ParseException {
		
		JSONParser jp = new JSONParser();
		JSONObject jobj = (JSONObject) jp.parse(re);
		
		// create object
		Payment payment =  new Payment();
		
		payment.setId(Integer.parseInt(jobj.get("id").toString()));
		
		cardService newCard = new cardService();
		newCard.cancel(payment);
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(newCard.getSuccess()));
		
		return json.toString();
		
	}

}
