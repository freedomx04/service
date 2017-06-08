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
@Table(name = "logistics_line", indexes={
	@Index(name = "index_logistics_line_origin_destination", columnList = "origin, destination")
})
public class LineEntity extends BaseEntity {
	
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "company_id")
	private CompanyEntity company; // 物流公司

	private String origin; // 始发地

	private String destination; // 目的地
	
	private Integer transportMode; // 运输方式
	
	private Integer aging; // 参考时效
	
	private Double heavyPrice; // 重货单价（公斤）
	
	private Double lightPrice; // 轻货单价（立方米）
	
	private Double lowest; // 最低一票
	
	public LineEntity() {
		// TODO Auto-generated constructor stub
	}

	public LineEntity(CompanyEntity company, String origin, String destination, Integer transportMode, Integer aging,
			Double heavyPrice, Double lightPrice, Double lowest) {
		super();
		this.company = company;
		this.origin = origin;
		this.destination = destination;
		this.transportMode = transportMode;
		this.aging = aging;
		this.heavyPrice = heavyPrice;
		this.lightPrice = lightPrice;
		this.lowest = lowest;
	}

	public CompanyEntity getCompany() {
		return company;
	}

	public void setCompany(CompanyEntity company) {
		this.company = company;
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

	public Integer getTransportMode() {
		return transportMode;
	}

	public void setTransportMode(Integer transportMode) {
		this.transportMode = transportMode;
	}

	public Integer getAging() {
		return aging;
	}

	public void setAging(Integer aging) {
		this.aging = aging;
	}

	public Double getHeavyPrice() {
		return heavyPrice;
	}

	public void setHeavyPrice(Double heavyPrice) {
		this.heavyPrice = heavyPrice;
	}

	public Double getLightPrice() {
		return lightPrice;
	}

	public void setLightPrice(Double lightPrice) {
		this.lightPrice = lightPrice;
	}

	public Double getLowest() {
		return lowest;
	}

	public void setLowest(Double lowest) {
		this.lowest = lowest;
	}
	
}