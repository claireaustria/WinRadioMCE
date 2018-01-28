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

import com.win.radio.manila.utilities.BlogContentOperations;
import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.google.gson.Gson;
import com.win.radio.manila.models.BlogContentModel;

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
		
		StringBuilder sbBlogContent = new StringBuilder();
	    BufferedReader reader = request.getReader();
	    try {
	        String line;
	        while ((line = reader.readLine()) != null) {
	        	sbBlogContent.append(line).append('\n');
	        }
	    } finally {
	        reader.close();
	    }
	    
	    Gson gson = new Gson();
	    BlogContentModel blogContentRequest = (BlogContentModel) gson.fromJson(sbBlogContent.toString(), BlogContentModel.class);
				
	    blogContentRequest.setCreateDate(timestamp);
	    blogContentRequest.setUpdateDate(timestamp);
	    blogContentRequest.setUpdateUser(updateUserIdAccount);
	    blogContentRequest.setCodRegion(String.valueOf(session.getAttribute("codRegion")));
		
		try{
			if(BlogContentOperations.createBlog(blogContentRequest)) {				
				new TransactionLogOperations();
				String strLogDesc ="";
				String strBlogStatus = blogContentRequest.getStatus();
				
				if (strBlogStatus.equals(CodeUtil.COD_BLOG_STATUS_DRAFT)) {
					strLogDesc = "saved a new draft blog post.";
				} else if (strBlogStatus.equals(CodeUtil.COD_BLOG_STATUS_PUBLISHED)) {
					strLogDesc = "published a new blog post.";
				}
				
				TransactionLogOperations.addTransactionLog(updateUserIdAccount, "createBlog", strLogDesc, CodeUtil.COD_REGION_MNL);
	
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
