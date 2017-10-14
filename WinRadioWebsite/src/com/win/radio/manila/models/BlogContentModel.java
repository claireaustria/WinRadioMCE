package com.win.radio.manila.models;

import java.sql.Date;
import java.sql.Timestamp;

public class BlogContentModel {

	private Timestamp createDate;
	private Timestamp updateDate;
	private String updateUser;
	private int idBlog;
	private String title;
	private String content;
	private int postOwner;
	private String codRegion;

	
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public int getIdBlog() {
		return idBlog;
	}
	public void setIdBlog(int idBlog) {
		this.idBlog = idBlog;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getPostOwner() {
		return postOwner;
	}
	public void setPostOwner(int postOwner) {
		this.postOwner = postOwner;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public Timestamp getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}
	public Timestamp getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}
	
}
