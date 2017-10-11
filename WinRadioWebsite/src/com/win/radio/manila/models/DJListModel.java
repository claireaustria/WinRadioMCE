package com.win.radio.manila.models;

import java.sql.Date;

public class DJListModel {
	
	private Date 		createDate;
	private Date 		updateDate;
	private int 		updateUser;
	private int			idDJ;
	private String		djName;
	private String		description;
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
	public int getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(int updateUser) {
		this.updateUser = updateUser;
	}	
	
}
