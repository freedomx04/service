package com.hongmeng.service.entity.manufacture;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.common.CompanyEntity;

@Entity
@Table(name = "manufacture_dynamic")
public class ManufactureDynamicEntity extends BaseEntity {
	
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "company_id")
	private CompanyEntity company; // 物流公司
	
	private String title; // 标题

	private String source; // 来源

	private String linkPath; // 文章地址

	private String content; // 文章内容
	
	public ManufactureDynamicEntity() {
		// TODO Auto-generated constructor stub
	}

	public ManufactureDynamicEntity(CompanyEntity company, String title, String source, String linkPath) {
		super();
		this.company = company;
		this.title = title;
		this.source = source;
		this.linkPath = linkPath;
	}

	public CompanyEntity getCompany() {
		return company;
	}

	public void setCompany(CompanyEntity company) {
		this.company = company;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getLinkPath() {
		return linkPath;
	}

	public void setLinkPath(String linkPath) {
		this.linkPath = linkPath;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}