package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Date;
import java.util.Locale;
import java.util.Random;
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

import com.win.radio.manila.utilities.AccountOperations;
import com.win.radio.manila.utilities.CodeUtil;
import com.win.radio.manila.utilities.SQLOperations;
import com.win.radio.manila.models.AccountModel;
import com.win.radio.manila.models.QOTDModel;

@WebServlet("/qotdController")
public class QOTDController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    public QOTDController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
		QOTDModel qotd = new QOTDModel();
		
		qotd.setCreateDate(currentDateTime);
		qotd.setUpdateDate(currentDateTime);
		qotd.setUpdateUser("0");
		qotd.setQuestion(request.getParameter("question"));
		qotd.setPostOwner(Integer.valueOf(request.getParameter("codType")));
		qotd.setCodRegion(CodeUtil.COD_REGION_MNL);
		
	}
	
}
