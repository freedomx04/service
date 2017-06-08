package com.hongmeng.service.service.authority;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.authority.RoleEntity;
import com.hongmeng.service.repository.authority.RoleRepository;

@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	RoleRepository roleRepository;

	@Override
	public RoleEntity findOne(Long roleId) {
		return roleRepository.findOne(roleId);
	}

	@Override
	public RoleEntity findByName(String name) {
		return roleRepository.findByName(name);
	}

	@Override
	public void save(RoleEntity role) {
		Date now = new Date();
		role.setCreateTime(now);
		role.setUpdateTime(now);
		roleRepository.save(role);
	}

	@Override
	public void update(RoleEntity role, String name, String description, String resource) {
		role.setName(name);
		role.setDescription(description);
		role.setResource(resource);
		
		role.setUpdateTime(new Date());
		roleRepository.save(role);
	}

	@Override
	public void delete(List<Long> roleIds) {
		Iterable<RoleEntity> it = roleRepository.findByIdIn(roleIds);
		roleRepository.delete(it);
	}

	@Override
	public List<RoleEntity> list() {
		return (List<RoleEntity>) roleRepository.findAll();
	}

}
