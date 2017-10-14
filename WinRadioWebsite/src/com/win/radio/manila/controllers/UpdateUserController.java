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

@WebServlet("/updateUserController")
public class UpdateUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public UpdateUserController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();
		
		HttpSession session = request.getSession();
		int updateUserIdAccount = (int) session.getAttribute("idAccount");
				
		Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		AccountModel account = new AccountModel();
		account.setIdAccount(Integer.valueOf(request.getParameter("idAccount")));
		account.setUpdateDate(currentDateTime);
		account.setUpdateUser(updateUserIdAccount);
		account.setCodType(request.getParameter("codType"));
		account.setUsername(request.getParameter("username"));
		account.setEmail(request.getParameter("email"));
		account.setLastName(request.getParameter("lastName"));
		account.setFirstName(request.getParameter("firstName"));
		account.setGender(request.getParameter("gender"));
		account.setMobileNo(request.getParameter("mobileNo"));
		
		try{
			new AccountOperations();
			if(AccountOperations.updateUser(account)) {
				new LogHelper();
				LogHelper.insertTransactionLogs(updateUserIdAccount, "addUser", "added a new user.", CodeUtil.COD_REGION_MNL);
	
				rspns.println("success");
				rspns.close();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
       
}
