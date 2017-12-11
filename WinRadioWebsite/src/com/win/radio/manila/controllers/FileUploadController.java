package com.win.radio.manila.controllers;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.*;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;


@WebServlet("/fileUpload")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
             maxFileSize=1024*1024*10,      // 10MB
             maxRequestSize=1024*1024*50)

public class FileUploadController extends HttpServlet {	
	private static final long serialVersionUID = 1L;
	
	private static final String DATA_DIRECTORY = "data";
    private static final int MAX_MEMORY_SIZE = 1024 * 1024 * 2;
    private static final int MAX_REQUEST_SIZE = 1024 * 1024;
    
	public FileUploadController() {
		super();
	}
	
	private static final String SAVE_DIR="img/sponsors/";

	protected void doPost(RequestContext request, HttpServletResponse response) {
		// Check that we have a file upload request
	    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	
	    if (!isMultipart) {
	      //  return;
	    }
	
	    // Create a factory for disk-based file items
	    DiskFileItemFactory factory = new DiskFileItemFactory();
	
	    // Sets the size threshold beyond which files are written directly to
	    // disk.
	    factory.setSizeThreshold(MAX_MEMORY_SIZE);
	
	    // Sets the directory used to temporarily store files that are larger
	    // than the configured size threshold. We use temporary directory for
	    // java
	    factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
	
	    // constructs the folder where uploaded file will be stored
	    String uploadFolder = getServletContext().getRealPath("")
	            + File.separator + DATA_DIRECTORY;
	    
	    System.out.println(uploadFolder);
	
	    // Create a new file upload handler
	    ServletFileUpload upload = new ServletFileUpload(factory);
	
	    // Set overall request size constraint
	    upload.setSizeMax(MAX_REQUEST_SIZE);
	
	    try {
	        // Parse the request
	        List items = upload.parseRequest(request);
	        Iterator iter = items.iterator();
	        while (iter.hasNext()) {
	            FileItem item = (FileItem) iter.next();
	
	            if (!item.isFormField()) {
	                String fileName = new File(item.getName()).getName();
	                String filePath = uploadFolder + File.separator + fileName;
	                File uploadedFile = new File(filePath);
	                System.out.println(filePath);
	                // saves the file to upload directory
	                item.write(uploadedFile);
	            }
	        }
	
	
	    } catch (FileUploadException ex) {
	        ex.printStackTrace();
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }

	}
	
	
}