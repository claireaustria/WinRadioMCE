package com.win.radio.manila.models;

import java.sql.Date;

public class QOTDModel {
	
	private Date 		createDate;
	private Date 		updateDate;
	private String 		updateUser;
	private int 		idQuestion;
	private String 		question;
	private int			postOwner;
	private String 		codRegion;
	
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public int getIdQuestion() {
		return idQuestion;
	}
	public void setIdQuestion(int idQuestion) {
		this.idQuestion = idQuestion;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
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
	
}
