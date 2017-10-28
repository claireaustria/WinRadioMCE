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
import com.win.radio.manila.utilities.DramaOperations;
import com.win.radio.manila.utilities.SQLOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.models.DramaModel;

@WebServlet("/createDramaController")
public class CreateDramaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CreateDramaController() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();

		HttpSession session = request.getSession();
		int idUserAccount = (int) session.getAttribute("idAccount");

		Calendar cal = Calendar.getInstance();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());

		DramaModel episode = new DramaModel();

		episode.setCreateDate(timestamp);
		episode.setUpdateDate(timestamp);
		episode.setUpdateUser(idUserAccount);
		episode.setTitle(request.getParameter("title"));
		episode.setDescription(request.getParameter("description"));
		episode.setFilename(request.getParameter("file"));
		episode.setImage(request.getParameter("thumbnail"));
		episode.setStatus(1);
		episode.setCodRegion(CodeUtil.COD_REGION_MNL);

		try {

			new DramaOperations();

			if (DramaOperations.addDrama(episode)) {
				
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
