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
import com.win.radio.manila.utilities.CompanyDescriptionOperations;
import com.win.radio.manila.utilities.SocialMediaOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.models.CompanyDescriptionModel;
import com.win.radio.manila.models.SocialMediaModel;

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
		} else if (strAction.equals("updateSocialLinks")) {
			int facebookId = Integer.valueOf(request.getParameter("facebookId"));
			int audioStreamId = Integer.valueOf(request.getParameter("audioStreamId"));
			int videoStreamId = Integer.valueOf(request.getParameter("videoStreamId"));
			
			SocialMediaModel social = null;
			new SocialMediaOperations();
			
			if (facebookId != 0) {
				social = new SocialMediaModel();
				social.setUpdateDate(timestamp);
				social.setUpdateUser(idAccount);
				social.setIdMedia(facebookId);
				social.setUrl(request.getParameter("facebookUrl"));
				
				SocialMediaOperations.updateSocialLink(social);
			}
			
			if (audioStreamId != 0) {
				social = new SocialMediaModel();
				social.setUpdateDate(timestamp);
				social.setUpdateUser(idAccount);
				social.setIdMedia(audioStreamId);
				social.setUrl(request.getParameter("audioStreamUrl"));
				
				SocialMediaOperations.updateSocialLink(social);
			}
			
			if (videoStreamId != 0) {
				social = new SocialMediaModel();
				social.setUpdateDate(timestamp);
				social.setUpdateUser(idAccount);
				social.setIdMedia(videoStreamId);
				social.setUrl(request.getParameter("videoStreamUrl"));
				
				SocialMediaOperations.updateSocialLink(social);
			}
			
			new TransactionLogOperations();
			TransactionLogOperations.addTransactionLog(idAccount, "updateSocialLinks", "updated the social media links.", CodeUtil.COD_REGION_MNL);

			rspns.println("success");
			rspns.close();
		}
		
		
	}
}
