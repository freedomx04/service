package com.hongmeng.service.entity.authority;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;

@Entity
@Table(name = "logistics_location")
public class LocationEntity extends BaseEntity {

	public class LocationLevel {
		public static final int LOCATION_COUNTRY = 0; // 国家
		public static final int LOCATION_PROVINCE = 1; // 省
		public static final int LOCATION_CITY = 2; // 市
		public static final int LOCATION_COUNTY = 3; // 区县
	}

	private Long pid; // 父节点

	private Integer level; // 省市区分类

	private String name; // 地点名称

	public LocationEntity() {
		// TODO Auto-generated constructor stub
	}

	public LocationEntity(Long pid, Integer level, String name) {
		this.pid = pid;
		this.level = level;
		this.name = name;
	}
	
	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}