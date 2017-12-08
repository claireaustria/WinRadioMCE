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

import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.LogHelper;
import com.win.radio.manila.utilities.BannerOperations;
import com.win.radio.manila.utilities.SQLOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.models.BannerModel;

@WebServlet("/createBannerController")
public class CreateBannerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CreateBannerController() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();

		HttpSession session = request.getSession();
		int idUserAccount = (int) session.getAttribute("idAccount");

		Calendar cal = Calendar.getInstance();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());

		BannerModel sponsor = new BannerModel();

		sponsor.setCreateDate(timestamp);
		sponsor.setUpdateDate(timestamp);
		sponsor.setUpdateUser(idUserAccount);
		sponsor.setBrand(request.getParameter("brand"));
		sponsor.setImage(request.getParameter("image"));
		sponsor.setStatus("Active");
		sponsor.setCodRegion(CodeUtil.COD_REGION_MNL);

		try {

			new BannerOperations();

			if (BannerOperations.addSponsor(sponsor)) {
				
				new TransactionLogOperations();
				TransactionLogOperations.addTransactionLog(idUserAccount, "addDrama", "posted a new Heart Stories Episode.",
						CodeUtil.COD_REGION_MNL);

				rspns.println("success");
			} else {
				rspns.println("fail");
			}
			
			rspns.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
