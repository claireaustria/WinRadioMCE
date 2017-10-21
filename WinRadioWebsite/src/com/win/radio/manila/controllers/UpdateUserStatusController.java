package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Calendar;

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

@WebServlet("/updateAccountStatus")
public class UpdateUserStatusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateUserStatusController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter rspns = response.getWriter();
		
		HttpSession session = request.getSession();
		int idAccount = (int) session.getAttribute("idAccount");
		
		Calendar cal = Calendar.getInstance();  
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
		
		AccountModel account = new AccountModel();
		account.setUpdateDate(timestamp);
		account.setUpdateUser(idAccount);
		account.setCodStatus(request.getParameter("codStatus"));
		account.setIdAccount(Integer.valueOf(request.getParameter("idAccount")));
		
		try{	
			new AccountOperations();
			if (AccountOperations.updateAccountStatus(account)) {
				rspns.println("success");
			} else {
				rspns.println("fail");
			}
			
			String strLogDesc = "";
			
			if (account.getCodStatus() == CodeUtil.COD_STATUS_ACTIVE) {
				strLogDesc = "activated an account.";
			} else {
				strLogDesc = "deactivated an account.";
			}
			
			new TransactionLogOperations();
			TransactionLogOperations.addTransactionLog(idAccount, "updateUserStatus", strLogDesc, CodeUtil.COD_REGION_MNL);

			
			rspns.close();
			
		} catch(Exception e)	{
			e.printStackTrace();
		}
		
	}

}
