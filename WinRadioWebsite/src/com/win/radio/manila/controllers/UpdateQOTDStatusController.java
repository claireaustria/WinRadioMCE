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

import com.win.radio.manila.models.QOTDModel;
import com.win.radio.manila.utilities.QOTDOperations;
import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.TransactionLogOperations;

@WebServlet("/updateQuestionStatus")
public class UpdateQOTDStatusController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateQOTDStatusController() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();

		HttpSession session = request.getSession();
		int idAccount = (int) session.getAttribute("idAccount");

		Calendar cal = Calendar.getInstance();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());

		QOTDModel question = new QOTDModel();

		question.setUpdateDate(timestamp);
		question.setUpdateUser(idAccount);
		question.setIndPost(Integer.valueOf(request.getParameter("questionStatus")));
		question.setIdQuestion(Integer.parseInt(request.getParameter("idQuestion")));

		try {
			new QOTDOperations();
			
			QOTDOperations.updateNewInd(question);

			if (QOTDOperations.updateQuestionStatus(question)) {

				//response.sendRedirect("manila/adminQOTD.jsp");

				new TransactionLogOperations();
				TransactionLogOperations.addTransactionLog(idAccount, "updateQOTDStatus",
						"updated the status question of the day.", CodeUtil.COD_REGION_MNL);

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
