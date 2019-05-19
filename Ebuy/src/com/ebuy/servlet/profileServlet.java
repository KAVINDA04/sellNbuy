package com.ebuy.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class profileServlet
 */
@WebServlet("/profileServlet")
public class profileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public profileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// check user login
		HttpSession session = request.getSession();
		try {
			if(session.getAttribute("email") != null ) {
				
				// check admin or user or seller
				if(session.getAttribute("user").toString().equals("admin")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
					dispatcher.forward(request, response);
				}else if(session.getAttribute("user").toString().equals("seller") ){
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/seller.jsp");
					dispatcher.forward(request, response);
				}else if(session.getAttribute("user").toString().equals("user") ){
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/user.jsp");
					dispatcher.forward(request, response);
				}else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
					dispatcher.forward(request, response);
				}
				
			}else {
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
				dispatcher.forward(request, response);
			}
		}catch (NullPointerException e){
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/home.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
