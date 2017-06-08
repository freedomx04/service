package com.hongmeng.service.entity.common;

import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;

@Entity
@Table(name = "common_company", indexes = {
	@Index(name = "index_common_company_name", columnList = "name")
})
public class CompanyEntity extends BaseCompanyEntity {
	
	private int score = 0;
	
	public CompanyEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public CompanyEntity(BaseUserEntity user, AreaEntity area, String name, String imagePath, Integer profession,
			Integer property, Integer scale, String address, String phone, String fax, String contactUser, String contact,
			String website, String introduction) {
		super();
		this.user = user;
		this.area = area;
		this.name = name;
		this.imagePath = imagePath;
		this.profession = profession;
		this.property = property;
		this.scale = scale;
		this.address = address;
		this.phone = phone;
		this.fax = fax;
		this.contactUser = contactUser;
		this.contact = contact;
		this.website = website;
		this.introduction = introduction;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

}