package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.MRHOperations;
import com.win.radio.manila.utilities.TransactionLogOperations;
import com.win.radio.manila.models.MRHModel;

@WebServlet("/updateMRHController")
public class UpdateMRHController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public UpdateMRHController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter rspns = response.getWriter();
		Boolean booSuccess = false;
		
		Calendar cal = Calendar.getInstance();  
		java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
				
		HttpSession session = request.getSession();
		int updateUserIdAccount = (int) session.getAttribute("idAccount");
		
		String jsonArrMRH = request.getParameter("jsonArrMRH");
		
		Object obj = JSONValue.parse(jsonArrMRH);
		JSONArray array = (JSONArray) obj;
		
		@SuppressWarnings("rawtypes")
		Iterator i = array.iterator();
		
		MRHModel mrhItem = null;
		int intRank = 1;

		try{
		    while (i.hasNext()) {
		        JSONObject row = (JSONObject) i.next();
		        
		        mrhItem = new MRHModel();
		        mrhItem.setArtist((String)row.get("Artist"));
		        mrhItem.setTitle((String)row.get("Title"));
		        mrhItem.setRank(intRank);
		        mrhItem.setUpdateDate(timestamp);
		        mrhItem.setUpdateUser(updateUserIdAccount);
		        mrhItem.setImage("");
		        mrhItem.setCodRegion(CodeUtil.COD_REGION_MNL);
		        
		        booSuccess = MRHOperations.updateMRH(mrhItem);
		        		      
		        intRank++;
		        
		        if (!booSuccess) {
		        	rspns.println("fail");
		        	return;
		        }
		    }
        			
			new TransactionLogOperations();
			TransactionLogOperations.addTransactionLog(updateUserIdAccount, "updateMRH", "updated the most requested hits list.", CodeUtil.COD_REGION_MNL);

			rspns.println("success");
			rspns.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
       
}
