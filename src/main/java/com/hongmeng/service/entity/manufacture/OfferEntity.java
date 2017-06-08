package com.hongmeng.service.entity.manufacture;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.common.CompanyEntity;

@Entity
@Table(name = "manufacture_offer")
public class OfferEntity extends BaseEntity {

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "company_id")
	private CompanyEntity company; // 公司

	private String name; // 名称
	
	private String imagePath; // 图片地址

	private Double price; // 价格
	
	private String origin; // 产地

	private String location; // 所在地

	private Integer lowest; // 起订量

	private Integer total; // 供货总量

	private String description; // 详情
	
	private Date validDate; // 有效期
	
	public OfferEntity() {
		// TODO Auto-generated constructor stub
	}

	public OfferEntity(CompanyEntity company, String name, String imagePath, Double price, String origin, String location, Integer lowest,
			Integer total, String description, Date validDate) {
		super();
		this.company = company;
		this.name = name;
		this.imagePath = imagePath;
		this.price = price;
		this.origin = origin;
		this.location = location;
		this.lowest = lowest;
		this.total = total;
		this.description = description;
		this.validDate = validDate;
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

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Integer getLowest() {
		return lowest;
	}

	public void setLowest(Integer lowest) {
		this.lowest = lowest;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getValidDate() {
		return validDate;
	}

	public void setValidDate(Date validDate) {
		this.validDate = validDate;
	}
	
}