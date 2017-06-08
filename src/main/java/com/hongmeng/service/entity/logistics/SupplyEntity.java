package com.hongmeng.service.entity.logistics;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;

@Entity
@Table(name = "logistics_supply", indexes={
	@Index(name = "index_logistics_supply_origin_destination", columnList = "origin, destination")
})
public class SupplyEntity extends BaseEntity {

	public class SupplyType {
		public static final int SUPPLY_HEAVY = 0; // 重货
		public static final int SUPPLY_LIGHT = 1; // 轻货
	}

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	private BaseUserEntity user; // 用户

	private String origin; // 发货地

	private String destination; // 收货地

	private String description; // 货源描述

	private Integer supplyType; // 货源类型

	private Date validDate; // 有效时间

	private String remark; // 备注

	private String contactUser; // 联系人

	private String contact; // 联系电话

	private String address; // 具体地点
	
	public SupplyEntity() {
		// TODO Auto-generated constructor stub
	}

	public SupplyEntity(BaseUserEntity user, String origin, String destination, String description, Integer supplyType,
			Date validDate, String remark, String contactUser, String contact, String address) {
		super();
		this.user = user;
		this.origin = origin;
		this.destination = destination;
		this.description = description;
		this.supplyType = supplyType;
		this.validDate = validDate;
		this.remark = remark;
		this.contactUser = contactUser;
		this.contact = contact;
		this.address = address;
	}

	public BaseUserEntity getUser() {
		return user;
	}

	public void setUser(BaseUserEntity user) {
		this.user = user;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getSupplyType() {
		return supplyType;
	}

	public void setSupplyType(Integer supplyType) {
		this.supplyType = supplyType;
	}

	public Date getValidDate() {
		return validDate;
	}

	public void setValidDate(Date validDate) {
		this.validDate = validDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
}