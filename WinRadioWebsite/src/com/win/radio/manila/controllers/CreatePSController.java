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

import com.win.radio.manila.models.ProgramModel;
import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.LogHelper;
import com.win.radio.manila.utilities.PSOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;

@WebServlet("/psCreate")
public class CreatePSController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public CreatePSController() {
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
		
		ProgramModel prog = new ProgramModel();
		prog.setCreateDate(timestamp);
		prog.setUpdateDate(timestamp);
		prog.setDescription(request.getParameter("programdescription"));
		prog.setSchedule(request.getParameter("programschedule"));
		prog.setTitle(request.getParameter("programname"));
		prog.setUpdateUser(idAccount);
		prog.setStatus(request.getParameter("programstatus"));
		
		prog.setProgramDj(request.getParameter("djid"));
		prog.setCodRegion(CodeUtil.COD_REGION_MNL);
		
		try {
			new PSOperations();
			
			if(PSOperations.addProgram(prog))
			{
				new LogHelper();
				TransactionLogOperations.addTransactionLog(idAccount, "addProgram", "added a program schedule.", CodeUtil.COD_REGION_MNL);
				
				rspns.println("success");
				rspns.close();
			}else
			{
				rspns.println("fail");
				rspns.close();
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
