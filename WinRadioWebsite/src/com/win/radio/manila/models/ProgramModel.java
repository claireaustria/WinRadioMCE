package com.win.radio.manila.models;

import java.sql.Timestamp;

public class ProgramModel {

	private Timestamp createDate;
	private Timestamp updateDate;
	private int updateUser;
	private int idProgram;
	private String ProgramDj;
	private String title;
	private String description;
	private String schedule;
	private String codRegion;
	private String status;
	
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
	public int getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(int updateUser) {
		this.updateUser = updateUser;
	}
	public int getIdProgram() {
		return idProgram;
	}
	public void setIdProgram(int idProgram) {
		this.idProgram = idProgram;
	}
	public String getProgramDj() {
		return ProgramDj;
	}
	public void setProgramDj(String programDj) {
		ProgramDj = programDj;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSchedule() {
		return schedule;
	}
	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
