package com.hongmeng.service.entity.financing;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.common.CompanyEntity;

@Entity
@Table(name = "financing_invest", indexes={
	@Index(name = "index_financing_invest_name", columnList = "name")
})
public class InvestEntity extends BaseEntity {

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "company_id")
	private CompanyEntity company; // 公司

	private String name; // 投资名称

	private Integer investType; // 投资方式

	private Integer fundType; // 资金类型

	private String location; // 所在地区

	private String profession; // 投资行业

	private String investArea; // 投资地区

	private String amount; // 投资金额

	private String description;	// 投资项目概述
	
	private String remark;	// 其他备注
	
	public InvestEntity() {
		// TODO Auto-generated constructor stub
	}

	public InvestEntity(CompanyEntity company, String name, Integer investType, Integer fundType, String location,
			String profession, String investArea, String amount, String description, String remark) {
		this.company = company;
		this.name = name;
		this.investType = investType;
		this.fundType = fundType;
		this.location = location;
		this.profession = profession;
		this.investArea = investArea;
		this.amount = amount;
		this.description = description;
		this.remark = remark;
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

	public Integer getInvestType() {
		return investType;
	}

	public void setInvestType(Integer investType) {
		this.investType = investType;
	}

	public Integer getFundType() {
		return fundType;
	}

	public void setFundType(Integer fundType) {
		this.fundType = fundType;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getProfession() {
		return profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public String getInvestArea() {
		return investArea;
	}

	public void setInvestArea(String investArea) {
		this.investArea = investArea;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}