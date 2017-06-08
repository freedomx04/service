package com.hongmeng.service.repository.authority;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hongmeng.service.entity.authority.RoleEntity;

public interface RoleRepository extends CrudRepository<RoleEntity, Long> {

	Iterable<RoleEntity> findByIdIn(List<Long> roleIds);

	RoleEntity findByName(String name);

}
