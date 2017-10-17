package com.win.radio.manila.controllers;

import java.io.BufferedReader;
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
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.google.gson.Gson;
import com.win.radio.manila.models.AccountModel;
import com.win.radio.manila.models.DJListModel;

@WebServlet("/updateUserController")
public class UpdateUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public UpdateUserController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder sbAccount = new StringBuilder();
	    BufferedReader reader = request.getReader();
	    try {
	        String line;
	        while ((line = reader.readLine()) != null) {
	        	sbAccount.append(line).append('\n');
	        }
	    } finally {
	        reader.close();
	    }
	    
	    Gson gson = new Gson();
	    AccountModel accountJson = (AccountModel) gson.fromJson(sbAccount.toString(), AccountModel.class);
		
		PrintWriter rspns = response.getWriter();
		
		HttpSession session = request.getSession();
		int updateUserIdAccount = (int) session.getAttribute("idAccount");
				
		Calendar cal = Calendar.getInstance();  
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
		
		AccountModel account = new AccountModel();
		account.setIdAccount(accountJson.getIdAccount());
		account.setUpdateDate(timestamp);
		account.setUpdateUser(updateUserIdAccount);
		account.setCodType(accountJson.getCodType());
		account.setUsername(accountJson.getUsername());
		account.setEmail(accountJson.getEmail());
		account.setLastName(accountJson.getLastName());
		account.setFirstName(accountJson.getFirstName());
		account.setGender(accountJson.getGender());
		account.setMobileNo(accountJson.getMobileNo());		
		
		try{
			new AccountOperations();
			if(AccountOperations.updateUser(account)) {
				String strLogDesc = "";
				
				if (account.getIdAccount() == updateUserIdAccount) {
					strLogDesc = "updated his/her account.";
				} else {
					strLogDesc = "updated a user's account.";
				}
				
				new TransactionLogOperations();
				TransactionLogOperations.addTransactionLog(updateUserIdAccount, "updateUser", strLogDesc, CodeUtil.COD_REGION_MNL);
	
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
