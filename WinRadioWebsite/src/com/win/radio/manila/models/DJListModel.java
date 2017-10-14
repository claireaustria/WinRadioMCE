package com.win.radio.manila.models;

import java.sql.Date;
import java.sql.Timestamp;

public class DJListModel {
	
	private Timestamp 	createDate;
	private Timestamp 	updateDate;
	private int 		updateUser;
	private int			idDJ;
	private String		djName;
	private String		description;
	private int			idAccount;
	private String 		codRegion;
	
	
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
	public int getIdAccount() {
		return idAccount;
	}
	public void setIdAccount(int idAccount) {
		this.idAccount = idAccount;
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
