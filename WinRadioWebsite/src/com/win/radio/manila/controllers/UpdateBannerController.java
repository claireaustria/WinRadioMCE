package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.DramaOperations;
import com.win.radio.manila.utilities.BannerOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.models.BannerModel;

@WebServlet("/updateSponsorController")
public class UpdateBannerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateBannerController() {
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

		if (strAction.equals("updateSponsorDetails")) {
			BannerModel banner = new BannerModel();

			banner.setUpdateDate(timestamp);
			banner.setUpdateUser(Integer.valueOf(idAccount));
			banner.setBrand(request.getParameter("brand"));
			banner.setImage(request.getParameter("image"));
			banner.setIdAd(Integer.valueOf(request.getParameter("idSponsor")));

			try {
				new BannerOperations();
				if (BannerOperations.updateSponsor(banner)) {
					new TransactionLogOperations();
					TransactionLogOperations.addTransactionLog(idAccount, "updateSponsor",
							"updated the Sponsor in Banner.", CodeUtil.COD_REGION_MNL);

					rspns.println("success");
					rspns.close();

				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (strAction.equals("updateBannerStatus")) {

			BannerModel bannerStatus = new BannerModel();
			
			bannerStatus.setUpdateDate(timestamp);
			bannerStatus.setUpdateUser(Integer.valueOf(idAccount));
			bannerStatus.setStatus(request.getParameter("status"));
			bannerStatus.setIdAd(Integer.valueOf(request.getParameter("idSponsor")));

			try {
				new DramaOperations();

				if (BannerOperations.updateSponsorStatus(bannerStatus)) {
					new TransactionLogOperations();
					TransactionLogOperations.addTransactionLog(idAccount, "updateSponsorStatus",
							"updated the status of a sponsor.", CodeUtil.COD_REGION_MNL);

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

}
