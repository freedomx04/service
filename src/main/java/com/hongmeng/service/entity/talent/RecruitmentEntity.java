package com.hongmeng.service.entity.talent;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.common.CompanyEntity;

@Entity
@Table(name = "talent_recruitment", indexes = {
	@Index(name = "index_talent_recruitment_updateTime", columnList = "updateTime"),
	@Index(name = "index_talent_recruitment_companyId_updateTime", columnList = "company_id, updateTime"),
	@Index(name = "index_talent_recruitment_position_updateTime", columnList = "position, updateTime")
})
public class RecruitmentEntity extends BaseEntity {
	
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "company_id")
	private CompanyEntity company; // 人才服务单位

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "area_id")
	private AreaEntity area; // 区域

	private String position; // 招聘职位

	private Integer profession; // 行业类别

	private Integer salary; // 薪资待遇

	private Integer workingYears; // 工作年限

	private Integer education; // 学历

	private Integer number; // 招聘人数

	private String responsibilities; // 岗位职责

	private String requirements; // 任职要求

	private String address; // 工作地址

	private String workingHours; // 工作时间

	private String contact; // 联系电话

	public RecruitmentEntity() {
		// TODO Auto-generated constructor stub
	}

	public RecruitmentEntity(CompanyEntity company, AreaEntity area, String position,
			Integer profession, Integer salary, Integer workingYears, Integer education, Integer number,
			String responsibilities, String requirements, String address, String workingHours, String contact) {
		super();
		this.company = company;
		this.area = area;
		this.position = position;
		this.profession = profession;
		this.salary = salary;
		this.workingYears = workingYears;
		this.education = education;
		this.number = number;
		this.responsibilities = responsibilities;
		this.requirements = requirements;
		this.address = address;
		this.workingHours = workingHours;
		this.contact = contact;
	}

	public AreaEntity getArea() {
		return area;
	}

	public void setArea(AreaEntity area) {
		this.area = area;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Integer getProfession() {
		return profession;
	}

	public void setProfession(Integer profession) {
		this.profession = profession;
	}

	public Integer getSalary() {
		return salary;
	}

	public void setSalary(Integer salary) {
		this.salary = salary;
	}

	public Integer getWorkingYears() {
		return workingYears;
	}

	public void setWorkingYears(Integer workingYears) {
		this.workingYears = workingYears;
	}

	public Integer getEducation() {
		return education;
	}

	public void setEducation(Integer education) {
		this.education = education;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}
	
	public CompanyEntity getCompany() {
		return company;
	}

	public void setCompany(CompanyEntity company) {
		this.company = company;
	}

	public String getResponsibilities() {
		return responsibilities;
	}

	public void setResponsibilities(String responsibilities) {
		this.responsibilities = responsibilities;
	}

	public String getRequirements() {
		return requirements;
	}

	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getWorkingHours() {
		return workingHours;
	}

	public void setWorkingHours(String workingHours) {
		this.workingHours = workingHours;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

}