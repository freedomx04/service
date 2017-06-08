package com.hongmeng.service.entity.authority;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;

@Entity
@Table(name = "authority_area", indexes={
	@Index(name = "index_authority_area_name", columnList = "name")
})
public class AreaEntity extends BaseEntity {
	
	@Column(unique = true)
	private String name;
	
	private String description;
	
	public AreaEntity() {
		// TODO Auto-generated constructor stub
	}

	public AreaEntity(String name, String description) {
		super();
		this.name = name;
		this.description = description;
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
	
}