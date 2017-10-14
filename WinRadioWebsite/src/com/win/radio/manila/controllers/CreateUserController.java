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
import javax.servlet.http.HttpSession;

import com.win.radio.manila.utilities.AccountOperations;
import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.DJListOperations;
import com.win.radio.manila.utilities.LogHelper;
import com.win.radio.manila.models.AccountModel;
import com.win.radio.manila.models.DJListModel;

@WebServlet("/createUserController")
public class CreateUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public CreateUserController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();
		String saltString = getSaltString(8);
		
		HttpSession session = request.getSession();
		int idAccount = (int) session.getAttribute("idAccount");
				
		Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		AccountModel account = new AccountModel();
		account.setCreateDate(currentDateTime);
		account.setUpdateDate(currentDateTime);
		account.setUpdateUser(idAccount);
		account.setCodType(request.getParameter("codType"));
		account.setEmail(request.getParameter("email"));
		account.setLastName(request.getParameter("lastName"));
		account.setFirstName(request.getParameter("firstName"));
		account.setGender(request.getParameter("gender"));
		account.setMobileNo(request.getParameter("mobileNo"));
		account.setUsername(request.getParameter("username"));
		account.setPassword(String.valueOf(saltString.hashCode()));
		account.setCodStatus(CodeUtil.COD_STATUS_ACTIVE);
		account.setCodRegion(CodeUtil.COD_REGION_MNL);
		
		try{
			new AccountOperations();
			if(AccountOperations.addUser(account)) {
				
				if (account.getCodType().equals(CodeUtil.COD_TYPE_DJ)) {
					DJListModel dj = new DJListModel();
					dj.setCreateDate(currentDateTime);
					dj.setUpdateDate(currentDateTime);
					dj.setUpdateUser(idAccount);
					dj.setDjName(request.getParameter("screenName"));
					dj.setDescription("-");
					dj.setCodRegion(CodeUtil.COD_REGION_MNL);
					
					new DJListOperations();
					DJListOperations.addNewDJ(dj);
				}
				
				//sendInitialEmail(account, saltString);
			
				new LogHelper();
				LogHelper.insertTransactionLogs(idAccount, "addUser", "added a new user.", CodeUtil.COD_REGION_MNL);

				rspns.println("success");
				rspns.close();
			}
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
	
	protected boolean sendInitialEmail(AccountModel account, String saltString) {

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
			String msg = "Hi, " + account.getFirstName() + "! <br>";
			msg += "You have been assigned an account at Win Radio PH. <br>";
			msg += "<b>Username: </b>" + account.getUsername() + " " + "<b>Password:</b> " + saltString + "<br>";
			msg += "To login, go to <b>www.winradio.com.ph/admin. </b><br><br><br>";
			msg += "This is an automated message, please do not respond. <br>";
			msg += "For assistance, please contact your systems administrator.";
			
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
