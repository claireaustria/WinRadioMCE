package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.win.radio.manila.models.BlogContentModel;
import com.win.radio.manila.models.CompanyDescriptionModel;

public class BlogContentOperations implements BlogContentCommands  {

	/* CONTROLLER FUNCTIONS */
	
	public static boolean updateBlog(BlogContentModel blog){
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_BLOG_POST);
			pstmt.setTimestamp(1, blog.getUpdateDate());
			pstmt.setInt(2, blog.getUpdateUser());
			pstmt.setString(3, blog.getTitle());
			pstmt.setString(4, blog.getContent());
			pstmt.setInt(5, blog.getPostOwner());
			pstmt.setString(6, blog.getStatus());
			pstmt.setInt(7, blog.getIdBlog());
			pstmt.executeUpdate(); 
		} catch (SQLException sqle){
			System.out.println("SQLException - updateBlog: " +sqle.getMessage());
			return false;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
	
	public static boolean createBlog(BlogContentModel blog){
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(CREATE_BLOG_POST);
			pstmt.setTimestamp(1, blog.getCreateDate());
			pstmt.setTimestamp(2, blog.getUpdateDate());
			pstmt.setInt(3, blog.getUpdateUser());
			pstmt.setString(4, blog.getTitle());
			pstmt.setString(5, blog.getContent());
			pstmt.setInt(6, blog.getPostOwner());
			pstmt.setString(7, blog.getStatus());
			pstmt.setString(8, blog.getCodRegion());
			pstmt.executeUpdate(); 
		} catch (SQLException sqle){
			System.out.println("SQLException - createBlog: " +sqle.getMessage());
			return false;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
}