package com.hongmeng.service.entity.talent;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.authority.UserEntity.Sex;

@Entity
@Table(name = "talent_job", indexes = {
	@Index(name = "index_talent_job_updateTime", columnList = "updateTime"),
	@Index(name = "index_talent_job_userId_updateTime", columnList = "user_id, updateTime"),
	@Index(name = "index_talent_job_intention_updateTime", columnList = "intention, updateTime")
})
public class JobEntity extends BaseEntity {

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	private BaseUserEntity user; // 用户

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "area_id")
	private AreaEntity area; // 区域

	private String name; // 姓名
	
	private Integer sex = Sex.MALE; // 性别

	private String imagePath; // 头像路径

	private Integer birthYear; // 出生年份

	private Integer workingYears; // 工作年限

	private Integer education; // 学历

	private String contact; // 联系电话

	private String intention; // 求职意向

	private Integer profession; // 行业类别

	private Integer salary; // 期望薪资

	private String introduction; // 自我介绍

	private String workExperience; // 工作经验

	private String educationExperience; // 教育经历

	public JobEntity() {
		// TODO Auto-generated constructor stub
	}

	public JobEntity(BaseUserEntity user, AreaEntity area, String name, Integer sex, String imagePath, Integer birthYear, Integer workingYears,
			Integer education, String contact, String intention, Integer profession, Integer salary,
			String introduction, String workExperience, String educationExperience) {
		super();
		this.user = user;
		this.area = area;
		this.name = name;
		this.sex = sex;
		this.imagePath = imagePath;
		this.birthYear = birthYear;
		this.workingYears = workingYears;
		this.education = education;
		this.contact = contact;
		this.intention = intention;
		this.profession = profession;
		this.salary = salary;
		this.introduction = introduction;
		this.workExperience = workExperience;
		this.educationExperience = educationExperience;
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
	
	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public Integer getBirthYear() {
		return birthYear;
	}

	public void setBirthYear(Integer birthYear) {
		this.birthYear = birthYear;
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

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getIntention() {
		return intention;
	}

	public void setIntention(String intention) {
		this.intention = intention;
	}

	public Integer getProfession() {
		return profession;
	}

	public void setProfession(Integer profession) {
		this.profession = profession;
	}

	public AreaEntity getArea() {
		return area;
	}

	public void setArea(AreaEntity area) {
		this.area = area;
	}

	public Integer getSalary() {
		return salary;
	}

	public void setSalary(Integer salary) {
		this.salary = salary;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getWorkExperience() {
		return workExperience;
	}

	public void setWorkExperience(String workExperience) {
		this.workExperience = workExperience;
	}

	public String getEducationExperience() {
		return educationExperience;
	}

	public void setEducationExperience(String educationExperience) {
		this.educationExperience = educationExperience;
	}

}