package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Date;
import java.util.Locale;
import java.util.Random;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.win.radio.manila.utilities.AccountOperations;
import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.SQLOperations;
import com.win.radio.manila.models.AccountModel;

@WebServlet("/createUserController")
public class CreateUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public CreateUserController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String saltString = getSaltString(8);
				
		Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
		AccountModel account = new AccountModel();
		account.setCreateDate(currentDateTime);
		account.setUpdateDate(currentDateTime);
		account.setCodProfile(request.getParameter("codProfile"));
		account.setEmail(request.getParameter("email"));
		account.setScreenName(request.getParameter("screenName"));
		account.setLastName(request.getParameter("lastName"));
		account.setFirstName(request.getParameter("firstName"));
		account.setGender(request.getParameter("gender"));
		account.setMobileNo(request.getParameter("mobileNo"));
		account.setUsername(request.getParameter("username"));
		account.setPassword(String.valueOf(saltString.hashCode()));
		account.setCodStatus(CodeUtil.COD_STATUS_ACTIVE);
		
		try{
			new AccountOperations();
			AccountOperations.addUser(account);
			
			sendInitialEmail(account, saltString);
			
			/*
			 * Use for alert display for successful transaction
			 * 
			//PrintWriter rspns = response.getWriter();
			RequestDispatcher rd = null;
			//rspns.println("<div class=\"alert bg-success\" role=\"alert\"><em class=\"fa fa-check-circle mr-2\"></em> Account successfully created. <a href=\"#\" class=\"float-right\"><em class=\"fa fa-remove\"></em></a></div>");
			rd = request.getRequestDispatcher("manila/adminUserMaintenance.jsp");
			request.setAttribute("isSuccess", "success");
			rd.include(request, response);
			//rspns.close();
			 * 
			 * */
			
			response.sendRedirect("manila/adminUserMaintenance.jsp");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	protected String getSaltString(int length) {
		String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String lower = upper.toLowerCase(Locale.ROOT);
		String digits = "0123456789";
		String SALTCHARS = upper + lower + digits;
		
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < length) { 
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        String saltStr = salt.toString();
        return saltStr;
    }
	
	protected void sendInitialEmail(AccountModel account, String saltString) {

		// Sender's email ID needs to be mentioned
		String from = CodeUtil.DEFAULT_FROM_EMAIL;
		String pass = CodeUtil.DEFAULT_EMAIL_PW;
	    // Recipient's email ID needs to be mentioned.
		String to = account.getEmail();
		String host = "smtp.gmail.com";

		// Get system properties
		Properties properties = System.getProperties();
		// Setup mail server
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.user", from);
		properties.put("mail.smtp.password", pass);
		properties.put("mail.smtp.port", "587");
		properties.put("mail.smtp.auth", "true");

		// Get the default Session object.
		Session session = Session.getDefaultInstance(properties);

		try{
			// Create a default MimeMessage object.
			MimeMessage message = new MimeMessage(session);

			// Set From: header field of the header.
			message.setFrom(new InternetAddress(from));

			// Set To: header field of the header.
			message.addRecipient(Message.RecipientType.TO,
	                               new InternetAddress(to));

			// Set Subject: header field
			message.setSubject("Win Radio Account Credentials");

			// Now set the actual message
			message.setText("Username: " + account.getUsername() + " " + "Password: " + saltString);

			// Send message
			Transport transport = session.getTransport("smtp");
			transport.connect(host, from, pass);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
	   }catch (MessagingException mex) {
	      mex.printStackTrace();
	   }
       
	}
}
