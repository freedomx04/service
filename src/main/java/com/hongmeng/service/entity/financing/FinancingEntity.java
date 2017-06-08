package com.hongmeng.service.entity.financing;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;

@Entity
@Table(name = "financing_financing", indexes={
	@Index(name = "index_financing_financing_name", columnList = "name"),
	@Index(name = "index_financing_financing_profession_financingtype", columnList = "profession, financingType")
})
public class FinancingEntity extends BaseEntity {

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	private BaseUserEntity user; // 用户

	private String name; // 融资名称

	private String location; // 所在地

	private Integer profession; // 所属行业

	private String purpose; // 融资用途

	private String amount; // 融资金额

	private Integer financingType; // 融资类型

	private String description; // 项目描述

	private String advantage; // 项目优势

	private String companyName; // 公司名称

	private String contactUser; // 联系人

	private String contact; // 联系方式

	public FinancingEntity() {
		// TODO Auto-generated constructor stub
	}

	public FinancingEntity(BaseUserEntity user, String name, String location, Integer profession, String purpose,
			String amount, Integer financingType, String description, String advantage, String companyName,
			String contactUser, String contact) {
		super();
		this.user = user;
		this.name = name;
		this.location = location;
		this.profession = profession;
		this.purpose = purpose;
		this.amount = amount;
		this.financingType = financingType;
		this.description = description;
		this.advantage = advantage;
		this.companyName = companyName;
		this.contactUser = contactUser;
		this.contact = contact;
	}

	public BaseUserEntity getUser() {
		return user;
	}

	public void setUser(BaseUserEntity user) {
		this.user = user;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Integer getProfession() {
		return profession;
	}

	public void setProfession(Integer profession) {
		this.profession = profession;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public Integer getFinancingType() {
		return financingType;
	}

	public void setFinancingType(Integer financingType) {
		this.financingType = financingType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAdvantage() {
		return advantage;
	}

	public void setAdvantage(String advantage) {
		this.advantage = advantage;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getContactUser() {
		return contactUser;
	}

	public void setContactUser(String contactUser) {
		this.contactUser = contactUser;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

}