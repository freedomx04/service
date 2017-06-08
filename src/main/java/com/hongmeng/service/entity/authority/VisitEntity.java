package com.hongmeng.service.entity.authority;

import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;

@Entity
@Table(name = "authority_visit", indexes={
	@Index(name = "index_authority_visit_date", columnList = "date")
})
public class VisitEntity extends BaseEntity {

	private String ip;

	private String date;

	public VisitEntity() {
		// TODO Auto-generated constructor stub
	}

	public VisitEntity(String ip, String date) {
		super();
		this.ip = ip;
		this.date = date;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}