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

import com.win.radio.manila.models.DJListModel;
import com.win.radio.manila.utilities.AccountOperations;
import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.DJListOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;


@WebServlet("/updateDJListController")
public class UpdateDJListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public UpdateDJListController() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();
		
		HttpSession session = request.getSession();
		int idAccount = (int) session.getAttribute("idAccount");
		
		Calendar cal = Calendar.getInstance();  
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
		
		DJListModel dj = new DJListModel();
		dj.setUpdateDate(timestamp);
		dj.setUpdateUser(idAccount);
		dj.setIdDJ(Integer.valueOf(request.getParameter("idDJ")));
		dj.setDescription(request.getParameter("description"));
		
		try{	
			if (DJListOperations.updateDJ(dj)) {
				TransactionLogOperations.addTransactionLog(idAccount, "updateDJ", "updated a DJ's details.", CodeUtil.COD_REGION_MNL);
				
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