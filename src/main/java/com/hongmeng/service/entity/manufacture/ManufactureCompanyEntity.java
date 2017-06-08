package com.hongmeng.service.entity.manufacture;

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
public class ManufactureCompanyEntity extends BaseCompanyEntity {
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<OfferEntity> offers = new LinkedList<>(); // 供应信息
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<ManufactureDynamicEntity> dynamics = new LinkedList<>(); // 企业动态
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<ManufactureProductEntity> products = new LinkedList<>(); // 产品
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<ManufactureSolutionEntity> solutions = new LinkedList<>(); // 解决方案
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "company_id")
	private List<ManufactureCaseEntity> cases = new LinkedList<>(); // 成功案例

	public ManufactureCompanyEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public List<OfferEntity> getOffers() {
		return offers;
	}

	public void setOffers(List<OfferEntity> offers) {
		this.offers = offers;
	}

	public List<ManufactureDynamicEntity> getDynamics() {
		return dynamics;
	}

	public void setDynamics(List<ManufactureDynamicEntity> dynamics) {
		this.dynamics = dynamics;
	}

	public List<ManufactureProductEntity> getProducts() {
		return products;
	}

	public void setProducts(List<ManufactureProductEntity> products) {
		this.products = products;
	}

	public List<ManufactureSolutionEntity> getSolutions() {
		return solutions;
	}

	public void setSolutions(List<ManufactureSolutionEntity> solutions) {
		this.solutions = solutions;
	}

	public List<ManufactureCaseEntity> getCases() {
		return cases;
	}

	public void setCases(List<ManufactureCaseEntity> cases) {
		this.cases = cases;
	}
	
}