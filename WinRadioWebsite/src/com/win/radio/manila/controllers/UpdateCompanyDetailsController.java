package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Date;
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
import com.win.radio.manila.utilities.CompanyDescriptionOperations;
import com.win.radio.manila.utilities.DJListOperations;
import com.win.radio.manila.utilities.LogHelper;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.models.AccountModel;
import com.win.radio.manila.models.CompanyDescriptionModel;
import com.win.radio.manila.models.DJListModel;

@WebServlet("/updateCompanyDetails")
public class UpdateCompanyDetailsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public UpdateCompanyDetailsController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();
		
		HttpSession session = request.getSession();
		int idAccount = (int) session.getAttribute("idAccount");

		Calendar cal = Calendar.getInstance();  
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
		
		String strAction = request.getParameter("action");
		
		if(strAction.equals("updateCompanyDetails")) {
			CompanyDescriptionModel companyDescription = new CompanyDescriptionModel();
			companyDescription.setIdDescription(Integer.valueOf(request.getParameter("idDescription")));
			companyDescription.setUpdateDate(timestamp);
			companyDescription.setUpdateUser(idAccount);
			companyDescription.setDescription(request.getParameter("description"));
			companyDescription.setContactPhone(request.getParameter("contactPhone"));
			companyDescription.setContactMobile(request.getParameter("contactMobile"));
			companyDescription.setContactEmail(request.getParameter("contactEmail"));
			companyDescription.setCodRegion(CodeUtil.COD_REGION_MNL);
			
			try{
				new CompanyDescriptionOperations();
				if(CompanyDescriptionOperations.updateDescription(companyDescription)) {
					new TransactionLogOperations();
					TransactionLogOperations.addTransactionLog(idAccount, "updateDescription", "updated the company details.", CodeUtil.COD_REGION_MNL);

					rspns.println("success");
					rspns.close();
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		} else if (strAction.equals("")) {
			
		}
		
		
	}
}
