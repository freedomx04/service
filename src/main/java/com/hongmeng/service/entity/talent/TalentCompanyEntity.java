package com.hongmeng.service.entity.talent;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.common.BaseCompanyEntity;

@Entity
@Table(name = "common_company")
public class TalentCompanyEntity extends BaseCompanyEntity {
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<RecruitmentEntity> recruitments = new LinkedList<>(); // 招聘信息
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<TalentEvaluationEntity> evaluations = new LinkedList<>(); // 评价
	
	private int score = 0;
	
	public TalentCompanyEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public TalentCompanyEntity(BaseUserEntity user, AreaEntity area, String name, String imagePath, Integer profession,
			Integer property, Integer scale, String address, String phone, String contactUser, String contact,
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
		this.contactUser = contactUser;
		this.contact = contact;
		this.website = website;
		this.introduction = introduction;
	}
	
	public List<RecruitmentEntity> getRecruitments() {
		return recruitments;
	}

	public void setRecruitments(List<RecruitmentEntity> recruitments) {
		this.recruitments = recruitments;
	}

	public List<TalentEvaluationEntity> getEvaluations() {
		return evaluations;
	}

	public void setEvaluations(List<TalentEvaluationEntity> evaluations) {
		this.evaluations = evaluations;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

}