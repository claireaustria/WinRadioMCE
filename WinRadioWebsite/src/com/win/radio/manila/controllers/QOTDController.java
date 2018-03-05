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

import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.QOTDOperations;
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
		qotd.setPostOwner(Integer.parseInt(request.getParameter("djName")));
		qotd.setIndPost(1);
		qotd.setCodRegion(CodeUtil.COD_REGION_MNL);

		try {

			new QOTDOperations();

			QOTDOperations.updateNewInd(qotd);

			if (QOTDOperations.addQOTD(qotd)) {
				
				new TransactionLogOperations();
				TransactionLogOperations.addTransactionLog(idAccount, "postQOTD", "posted a new question of the day.",
						CodeUtil.COD_REGION_MNL);

				rspns.println("success");
			} else {
				rspns.println("fail");
			}

			// response.sendRedirect("manila/adminQOTD.jsp");
			rspns.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
