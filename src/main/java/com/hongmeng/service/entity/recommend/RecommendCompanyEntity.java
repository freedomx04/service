package com.hongmeng.service.entity.recommend;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.hongmeng.service.entity.common.BaseCompanyEntity;

@Entity
@Table(name = "common_company")
public class RecommendCompanyEntity extends BaseCompanyEntity {
	
	private String recommendPath; // 推介详情地址
	
	private String content;	// 推介详情
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<RecommendDynamicEntity> dynamics = new LinkedList<>(); // 推介动态
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<RecommendProductEntity> products = new LinkedList<>(); // 企业产品
	
	public RecommendCompanyEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public String getRecommendPath() {
		return recommendPath;
	}

	public void setRecommendPath(String recommendPath) {
		this.recommendPath = recommendPath;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public List<RecommendDynamicEntity> getDynamics() {
		return dynamics;
	}

	public void setDynamics(List<RecommendDynamicEntity> dynamics) {
		this.dynamics = dynamics;
	}

	public List<RecommendProductEntity> getProducts() {
		return products;
	}

	public void setProducts(List<RecommendProductEntity> products) {
		this.products = products;
	}
	
}