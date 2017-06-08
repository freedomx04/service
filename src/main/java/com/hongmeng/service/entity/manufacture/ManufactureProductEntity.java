package com.hongmeng.service.entity.manufacture;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.common.CompanyEntity;

@Entity
@Table(name = "manufacture_product")
public class ManufactureProductEntity extends BaseEntity {

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "company_id")
	private CompanyEntity company; // 公司

	private String name; // 产品名称
	
	private String imagePath; // 图片地址

	private Integer clazz; // 大类

	private Integer subClazz; // 子类

	private String model; // 型号

	private Double price; // 产品价格

	private String location; // 所在地

	private String origin; // 产地

	private Integer property; // 厂商性质

	private String introduction; // 简单介绍

	private String description; // 详细说明

	public ManufactureProductEntity() {
		// TODO Auto-generated constructor stub
	}

	public ManufactureProductEntity(CompanyEntity company, String name, String imagePath, Integer clazz, Integer subClazz, String model,
			Double price, String location, String origin, Integer property, String introduction, String description) {
		super();
		this.company = company;
		this.name = name;
		this.imagePath = imagePath;
		this.clazz = clazz;
		this.subClazz = subClazz;
		this.model = model;
		this.price = price;
		this.location = location;
		this.origin = origin;
		this.property = property;
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

	public Integer getClazz() {
		return clazz;
	}

	public void setClazz(Integer clazz) {
		this.clazz = clazz;
	}

	public Integer getSubClazz() {
		return subClazz;
	}

	public void setSubClazz(Integer subClazz) {
		this.subClazz = subClazz;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public Integer getProperty() {
		return property;
	}

	public void setProperty(Integer property) {
		this.property = property;
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