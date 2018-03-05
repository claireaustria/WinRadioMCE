package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.win.radio.manila.utilities.CodeUtil;

@WebServlet("/sendInquiryController")
public class SendInquiryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public SendInquiryController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();
				
		try{
			String strFullName = request.getParameter("fullName");
			String strMobileNo = request.getParameter("mobileNo");
			String strEmail = request.getParameter("email");
			String strSubject = request.getParameter("subject");
			String strMessage = request.getParameter("message");
			
			
			if(sendInquiryEmail(strFullName, strMobileNo, strEmail, strSubject, strMessage)) {
				//Event log
				
				rspns.println("success");
				rspns.close();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	protected boolean sendInquiryEmail(String strFullName, String strMobileNo, 
		String strEmail, String strSubject, String strMessage) 
	{

		// Sender's email ID needs to be mentioned
		String from = CodeUtil.DEFAULT_FROM_EMAIL;
		String pass = CodeUtil.DEFAULT_EMAIL_PW;
	    // Recipient's email ID needs to be mentioned.
		String to = CodeUtil.DEFAULT_FROM_EMAIL;
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
			message.setSubject("[WEBSITE INQUIRY] Subject: " + strSubject);

			// Now set the actual message
			String msg = "<b>Name: </b>" + strFullName + "<br>";
			if (!strMobileNo.equals("")) {
				msg += "<b>Mobile No: </b>" + strMobileNo + "<br>";
			}
			msg += "<b>Email: </b>" + strEmail + "<br><br>";
			msg += "<b>Subject: </b>" + strSubject + "<br>";
			msg += "<b>Message: </b><br>";
			msg += strMessage;			
			message.setContent(msg, "text/html; charset=utf-8");

			// Send message
			Transport transport = session.getTransport("smtp");
			transport.connect(host, from, pass);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
			
			return true;
	   }catch (MessagingException mex) {
	      mex.printStackTrace();
	      return false;
	   }
       
	}



}
