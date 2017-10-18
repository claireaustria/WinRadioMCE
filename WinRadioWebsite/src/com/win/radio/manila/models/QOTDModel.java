package com.win.radio.manila.models;

import java.sql.Timestamp;

public class QOTDModel {
	
	private Timestamp	createDate;
	private Timestamp	updateDate;
	private int 		updateUser;
	private int 		idQuestion;
	private String 		question;
	private int			postOwner;
	private int			indPost;
	private String 		codRegion;
	
	
	public int getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(int updateUser) {
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
	public int getIndPost() {
		return indPost;
	}
	public void setIndPost(int indPost) {
		this.indPost = indPost;
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
