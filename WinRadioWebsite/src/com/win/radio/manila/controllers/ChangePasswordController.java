package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.win.radio.manila.models.AccountModel;
import com.win.radio.manila.utilities.AccountOperations;
import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.TransactionLogOperations;

@WebServlet("/changePasswordController")
public class ChangePasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ChangePasswordController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
		PrintWriter rspns = response.getWriter();
		
		HttpSession session = request.getSession();
		int idAccount = (int) session.getAttribute("idAccount");
		
		AccountModel account = new AccountModel();
		account.setUpdateDate(currentDateTime);
		account.setUpdateUser(idAccount);
		account.setPassword(String.valueOf(request.getParameter("password1").hashCode()));
		account.setIndChangePwd(0);
		account.setIdAccount(idAccount);
		
		try{	
			new AccountOperations();
			if (AccountOperations.changePassword(account)) {
				rspns.println("success");
			} else {
				rspns.println("fail");
			}
			
			rspns.close();
			
		} catch(Exception e)	{
			e.printStackTrace();
		}
		
	}

}
