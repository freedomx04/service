package com.hongmeng.service.entity.recommend;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.common.CompanyEntity;

@Entity
@Table(name = "recommend_product")
public class RecommendProductEntity extends BaseEntity {

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "company_id")
	private CompanyEntity company; // 公司

	private String name; // 产品名称

	private String imagePath; // 图片地址

	private String model; // 型号

	private String location; // 所在地

	private String introduction; // 简单介绍

	private String description; // 详细说明

	public RecommendProductEntity() {
		// TODO Auto-generated constructor stub
	}

	public RecommendProductEntity(CompanyEntity company, String name, String imagePath, String model, String location,
			String introduction, String description) {
		super();
		this.company = company;
		this.name = name;
		this.imagePath = imagePath;
		this.model = model;
		this.location = location;
		this.introduction = introduction;
		this.description = description;
	}

	public CompanyEntity getCompany() {
		return company;
	}

	public void setCompany(CompanyEntity company) {
		this.company = company;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}