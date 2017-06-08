package com.hongmeng.service.entity.authority;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hongmeng.service.entity.BaseEntity;
import com.hongmeng.service.entity.authority.UserEntity.UserStatus;

@Entity
@Table(name = "authority_user")
public class BaseUserEntity extends BaseEntity {

	@Column(unique = true)
	private String username; // 用户名

	private String password; // MD5加密后的密码
	
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "role_id")
	private RoleEntity role; // 角色
	
	private String telephone;

	private Integer status = UserStatus.STATUS_VALID; // 用户状态
	
	private String gcUsername; // 广昌平台账号

	private String ncUsername; // 南城平台账号
	
	public BaseUserEntity() {
		// TODO Auto-generated constructor stub
	}

	public BaseUserEntity(String username, String password, RoleEntity role, String telephone) {
		super();
		this.username = username;
		this.password = password;
		this.role = role;
		this.telephone = telephone;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public RoleEntity getRole() {
		return role;
	}

	public void setRole(RoleEntity role) {
		this.role = role;
	}
	
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getGcUsername() {
		return gcUsername;
	}

	public void setGcUsername(String gcUsername) {
		this.gcUsername = gcUsername;
	}

	public String getNcUsername() {
		return ncUsername;
	}

	public void setNcUsername(String ncUsername) {
		this.ncUsername = ncUsername;
	}

}