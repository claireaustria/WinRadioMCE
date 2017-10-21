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
import com.win.radio.manila.utilities.QOTDOperations;
import com.win.radio.manila.utilities.SQLOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.models.QOTDModel;

@WebServlet("/qotdController")
public class QOTDController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public QOTDController() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();

		HttpSession session = request.getSession();
		int idAccount = (int) session.getAttribute("idAccount");

		Calendar cal = Calendar.getInstance();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());

		QOTDModel qotd = new QOTDModel();

		qotd.setCreateDate(timestamp);
		qotd.setUpdateDate(timestamp);
		qotd.setUpdateUser(idAccount);
		qotd.setQuestion(request.getParameter("question"));
		qotd.setPostOwner(Integer.valueOf(request.getParameter("djName")));
		qotd.setCodRegion(CodeUtil.COD_REGION_MNL);

		try {

			new QOTDOperations();

			QOTDOperations.updateNewInd(qotd);

			QOTDOperations.addQOTD(qotd);

			response.sendRedirect("manila/adminQOTD.jsp");

			new TransactionLogOperations();
			TransactionLogOperations.addTransactionLog(idAccount, "postQOTD", "posted a new question of the day.",
					CodeUtil.COD_REGION_MNL);

			rspns.println("success");
			rspns.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
