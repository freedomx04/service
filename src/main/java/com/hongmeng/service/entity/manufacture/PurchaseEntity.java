package com.hongmeng.service.entity.manufacture;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;

@Entity
@Table(name = "manufacture_purchase")
public class PurchaseEntity extends BaseEntity {

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	private BaseUserEntity user; // 用户

	private String name; // 求购标题

	private String description; // 详细描述
	
	private Date validDate; // 有效期

	private String num; // 采购数量

	private String location; // 所在地

	private String contactUser; // 联系人

	private String contact; // 联系方式
	
	public PurchaseEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public PurchaseEntity(BaseUserEntity user, String name, String description, Date validDate, String num,
			String location, String contactUser, String contact) {
		super();
		this.user = user;
		this.name = name;
		this.description = description;
		this.validDate = validDate;
		this.num = num;
		this.location = location;
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

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
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