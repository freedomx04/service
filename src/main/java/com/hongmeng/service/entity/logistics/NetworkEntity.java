package com.hongmeng.service.entity.logistics;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.common.CompanyEntity;

@Entity
@Table(name = "logistics_network", indexes={
	@Index(name = "index_logistics_network_name_address", columnList = "name, address")
})
public class NetworkEntity extends BaseEntity {

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "company_id")
	private CompanyEntity company; // 物流公司

	private String name; // 名称

	private String address; // 地址

	private String contact; // 联系电话

	private String business; // 业务内容
	
	public NetworkEntity() {
		// TODO Auto-generated constructor stub
	}

	public NetworkEntity(CompanyEntity company, String name, String address, String contact, String business) {
		super();
		this.company = company;
		this.name = name;
		this.address = address;
		this.contact = contact;
		this.business = business;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getBusiness() {
		return business;
	}

	public void setBusiness(String business) {
		this.business = business;
	}
	
}