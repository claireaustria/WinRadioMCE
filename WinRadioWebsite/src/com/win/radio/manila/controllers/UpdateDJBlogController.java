package com.win.radio.manila.controllers;

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
import com.win.radio.manila.models.BlogContentModel;

@WebServlet("/updateDJBlogController")
public class UpdateDJBlogController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public UpdateDJBlogController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter rspns = response.getWriter();
		
		HttpSession session = request.getSession();
		int updateUserIdAccount = (int) session.getAttribute("idAccount");
				
		Calendar cal = Calendar.getInstance();  
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
		
		BlogContentModel blog = new BlogContentModel();
		blog.setIdBlog(Integer.valueOf(request.getParameter("idBlog")));
		blog.setUpdateDate(timestamp);
		blog.setUpdateUser(updateUserIdAccount);
		blog.setPostOwner(Integer.valueOf(request.getParameter("postOwner")));
		if (request.getParameter("action").equals("saveDraft")) {
			blog.setStatus(CodeUtil.COD_BLOG_STATUS_DRAFT);
		} else if (request.getParameter("action").equals("publish")) {
			blog.setStatus(CodeUtil.COD_BLOG_STATUS_PUBLISHED);
		}
		
		try{
			if(BlogContentOperations.saveDJBlogDraft(blog)) {				
				new TransactionLogOperations();
				TransactionLogOperations.addTransactionLog(updateUserIdAccount, "saveDJBlogDraft", "saved a draft blog post.", CodeUtil.COD_REGION_MNL);
	
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
