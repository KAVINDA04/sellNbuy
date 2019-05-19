package com.ebuy.rest;

import java.sql.SQLException;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import org.json.simple.*;
import org.json.simple.parser.*;

import com.ebuy.model.*;
import com.ebuy.service.*;

@Path("/payment")
public class payment {
	
	@POST
	@Path("/payment")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	
	public String payment(String re) throws ClassNotFoundException,SQLException,ParseException {
		
		JSONParser jp = new JSONParser();
		JSONObject jobj = (JSONObject) jp.parse(re);
		
		Payment payment = new Payment();
		
		payment.setId(Integer.parseInt(jobj.get("id").toString()));
		payment.setName(jobj.get("name").toString());
		payment.setAmount(Double.parseDouble(jobj.get("amount").toString()));
		payment.setQuantity(Integer.parseInt(jobj.get("quantity").toString()));
		
		// create object
		Card card =  new Card();
		
		card.setCardNumber(jobj.get("cardNumber").toString());
		card.setCcvCode(Integer.parseInt(jobj.get("ccvCode").toString()));
		card.setMonth(Integer.parseInt(jobj.get("month").toString()));
		card.setYear(Integer.parseInt(jobj.get("year").toString()));
		card.setUser(jobj.get("user").toString());
		
		buyService buy = new buyService();
		buy.addPayment(payment,card);
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(buy.getSuccess()));
		
		return json.toString();
		
	}
	
	
	@POST
	@Path("/cancel")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	
	public String cancel(String re) throws ClassNotFoundException,SQLException,ParseException {
		
		JSONParser jp = new JSONParser();
		JSONObject jobj = (JSONObject) jp.parse(re);
		
		Payment payment = new Payment();
		
		payment.setId(Integer.parseInt(jobj.get("id").toString()));
		
		buyService buy = new buyService();
		buy.cancel(payment);
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(buy.getSuccess()));
		
		return json.toString();
		
	}
	
	@POST
	@Path("/refund")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	
	public String refund(String re) throws ClassNotFoundException,SQLException,ParseException {
		
		JSONParser jp = new JSONParser();
		JSONObject jobj = (JSONObject) jp.parse(re);
		
		Payment payment = new Payment();
		
		payment.setId(Integer.parseInt(jobj.get("id").toString()));
		
		buyService buy = new buyService();
		buy.refund(payment);
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(buy.getSuccess()));
		
		return json.toString();
		
	}
	

}
