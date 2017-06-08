package com.hongmeng.service.entity.authority;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;

@Entity
@Table(name = "authority_role")
public class RoleEntity extends BaseEntity {

	@Column(unique = true)
	private String name;

	private String description;

	@Column(length = 500)
	private String resource;

	public RoleEntity() {
		// TODO Auto-generated constructor stub
	}

	public RoleEntity(String name, String description, String resource) {
		super();
		this.name = name;
		this.description = description;
		this.resource = resource;
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

	public String getResource() {
		return resource;
	}

	public void setResource(String resource) {
		this.resource = resource;
	}

}