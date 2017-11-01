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

import org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation;

import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.LogHelper;
import com.win.radio.manila.utilities.DramaOperations;
import com.win.radio.manila.utilities.SQLOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.models.DramaModel;

@WebServlet("/updateDramaController")
public class UpdateDramaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateDramaController() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();

		HttpSession session = request.getSession();
		int idAccount = (int) session.getAttribute("idAccount");

		Calendar cal = Calendar.getInstance();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());

		String strAction = request.getParameter("action");

		if (strAction.equals("updateEpisodeDetails")) {
			DramaModel drama = new DramaModel();

			drama.setUpdateDate(timestamp);
			drama.setUpdateUser(Integer.valueOf(idAccount));
			drama.setTitle(request.getParameter("title"));
			drama.setDescription(request.getParameter("description"));
			drama.setFilename(request.getParameter("filename"));
			drama.setImage(request.getParameter("image"));
			drama.setIdEpisode(Integer.valueOf(request.getParameter("idEpisode")));

			try {
				new DramaOperations();
				if (DramaOperations.updateDrama(drama)) {
					new TransactionLogOperations();
					TransactionLogOperations.addTransactionLog(idAccount, "updateEpisode",
							"updated the a Heart Stories Episode.", CodeUtil.COD_REGION_MNL);

					rspns.println("success");
					rspns.close();

				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (strAction.equals("updateEpisodeStatus")) {

			DramaModel dramaStatus = new DramaModel();

			dramaStatus.setUpdateDate(timestamp);
			dramaStatus.setUpdateUser(Integer.valueOf(idAccount));
			dramaStatus.setStatus(Integer.valueOf(request.getParameter("status")));
			dramaStatus.setIdEpisode(Integer.valueOf(request.getParameter("idEpisode")));

		}
	}

}
