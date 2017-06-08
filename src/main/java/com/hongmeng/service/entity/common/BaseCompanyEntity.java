package com.hongmeng.service.entity.common;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToOne;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.authority.BaseUserEntity;

@MappedSuperclass
public class BaseCompanyEntity extends BaseEntity {

	public class CompanyStatus {
		public static final int STATUS_NEW = 0; // 新增/未申请
		public static final int STATUS_BEING_CERTIFIED = 1; // 审核中
		public static final int STATUS_PASS = 2; // 通过
		public static final int STATUS_DENY = 3; // 未通过
	}
	
	public class ServiceType {
		public static final int SERVICE_RECOMMEND = 1; // 企业推介 
		public static final int SERVICE_MANUFACTURE = 2; // 智能制造
		public static final int SERVICE_TALENT = 3; // 人才服务
		public static final int SERVICE_FINANCING = 4; // 融资服务
		public static final int SERVICE_LOGISTICS = 5; // 物流服务
	}

	/**
	 * 基本信息
	 */
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	protected BaseUserEntity user; // 用户

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "area_id")
	protected AreaEntity area; // 区域

	protected String name; // 公司名称

	protected String imagePath; // 头像地址

	protected Integer profession; // 行业类别

	protected Integer property; // 企业性质

	protected Integer scale; // 企业规模

	protected String address; // 地址

	protected String phone; // 座机
	
	protected String fax; // 传真

	protected String contactUser; // 联系人

	protected String contact; // 联系方式

	protected String website; // 网站地址

	@Column(length = 2000)
	protected String introduction; // 简介

	/**
	 * 审批
	 */
	protected String license; // 营业执照

	protected String attachmentPath; // 附件地址

	protected String protocolPath; // 协议地址
	
	protected Integer status = CompanyStatus.STATUS_NEW; // 认证状态
	
	/**
	 * 
	 */
	protected Integer statusRecommend = CompanyStatus.STATUS_NEW; // 企业推介供应商状态 
	
	protected Integer statusManufacture = CompanyStatus.STATUS_NEW; // 智能制造供应商状态 
	
	protected Integer statusTalent = CompanyStatus.STATUS_NEW; // 人才服务供应商状态 
	
	protected Integer statusFinancing = CompanyStatus.STATUS_NEW; // 融资服务供应商状态 
	
	protected Integer statusLogistics = CompanyStatus.STATUS_NEW; // 物流供应商状态

	public BaseCompanyEntity() {
		// TODO Auto-generated constructor stub
	}

	public BaseUserEntity getUser() {
		return user;
	}

	public void setUser(BaseUserEntity user) {
		this.user = user;
	}

	public AreaEntity getArea() {
		return area;
	}

	public void setArea(AreaEntity area) {
		this.area = area;
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

	public Integer getProfession() {
		return profession;
	}

	public void setProfession(Integer profession) {
		this.profession = profession;
	}

	public Integer getProperty() {
		return property;
	}

	public void setProperty(Integer property) {
		this.property = property;
	}

	public Integer getScale() {
		return scale;
	}

	public void setScale(Integer scale) {
		this.scale = scale;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
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

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getAttachmentPath() {
		return attachmentPath;
	}

	public void setAttachmentPath(String attachmentPath) {
		this.attachmentPath = attachmentPath;
	}

	public String getProtocolPath() {
		return protocolPath;
	}

	public void setProtocolPath(String protocolPath) {
		this.protocolPath = protocolPath;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getStatusRecommend() {
		return statusRecommend;
	}

	public void setStatusRecommend(Integer statusRecommend) {
		this.statusRecommend = statusRecommend;
	}

	public Integer getStatusManufacture() {
		return statusManufacture;
	}

	public void setStatusManufacture(Integer statusManufacture) {
		this.statusManufacture = statusManufacture;
	}

	public Integer getStatusTalent() {
		return statusTalent;
	}

	public void setStatusTalent(Integer statusTalent) {
		this.statusTalent = statusTalent;
	}

	public Integer getStatusFinancing() {
		return statusFinancing;
	}

	public void setStatusFinancing(Integer statusFinancing) {
		this.statusFinancing = statusFinancing;
	}

	public Integer getStatusLogistics() {
		return statusLogistics;
	}

	public void setStatusLogistics(Integer statusLogistics) {
		this.statusLogistics = statusLogistics;
	}
	
}