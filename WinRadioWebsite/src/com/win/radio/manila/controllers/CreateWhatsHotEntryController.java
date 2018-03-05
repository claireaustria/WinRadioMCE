package com.win.radio.manila.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.utilities.WhatsHotOperations;
import com.google.gson.Gson;
import com.win.radio.manila.models.WhatsHotModel;

@WebServlet("/createWhatsHotEntryController")
public class CreateWhatsHotEntryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public CreateWhatsHotEntryController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();
		
		HttpSession session = request.getSession();
		int updateUserIdAccount = (int) session.getAttribute("idAccount");
				
		Calendar cal = Calendar.getInstance();  
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
		
		StringBuilder sbEntry = new StringBuilder();
	    BufferedReader reader = request.getReader();
	    try {
	        String line;
	        while ((line = reader.readLine()) != null) {
	        	sbEntry.append(line).append('\n');
	        }
	    } finally {
	        reader.close();
	    }
	    
	    Gson gson = new Gson();
	    WhatsHotModel entryRequest = (WhatsHotModel) gson.fromJson(sbEntry.toString(), WhatsHotModel.class);
				
	    entryRequest.setCreateDate(timestamp);
	    entryRequest.setUpdateDate(timestamp);
	    entryRequest.setUpdateUser(updateUserIdAccount);
	    entryRequest.setCodRegion(String.valueOf(session.getAttribute("codRegion")));
		
		try{
			if(WhatsHotOperations.createEntry(entryRequest)) {				
				new TransactionLogOperations();
				String strLogDesc ="";
				String strEntryStatus = entryRequest.getStatus();
				
				if (strEntryStatus.equals(CodeUtil.COD_BLOG_STATUS_DRAFT)) {
					strLogDesc = "saved a new post.";
				} else if (strEntryStatus.equals(CodeUtil.COD_BLOG_STATUS_PUBLISHED)) {
					strLogDesc = "published a new post.";
				}
				
				TransactionLogOperations.addTransactionLog(updateUserIdAccount, "createWhatsHotEntry", strLogDesc, String.valueOf(session.getAttribute("codRegion")));
	
				rspns.println("success");
			} else {
				rspns.println("fail");
			}
			
			rspns.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
       
}
