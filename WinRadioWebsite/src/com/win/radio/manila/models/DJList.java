package com.win.radio.manila.models;

import java.sql.Date;

public class DJList {
	
	private Date 		createDate;
	private Date 		updateDate;
	private String 		updateUser;
	private int			idDJ;
	private String		djName;
	private String		description;
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
	
	public int getIdDJ() {
		return idDJ;
	}
	public void setIdDJ(int idDJ) {
		this.idDJ = idDJ;
	}
	public String getDjName() {
		return djName;
	}
	public void setDjName(String djName) {
		this.djName = djName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	private String 		codRegion;
	
	
	
}
