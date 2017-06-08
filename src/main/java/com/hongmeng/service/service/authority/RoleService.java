package com.hongmeng.service.service.authority;

import java.util.List;

import com.hongmeng.service.entity.authority.RoleEntity;

public interface RoleService {
	
	RoleEntity findOne(Long roleId);
	
	RoleEntity findByName(String name);
	
	void save(RoleEntity role);
	
	void update(RoleEntity role, String name, String description, String resource);
	
	void delete(List<Long> roleIds);
	
	List<RoleEntity> list();

}
