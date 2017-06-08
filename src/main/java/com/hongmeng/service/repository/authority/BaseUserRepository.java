package com.hongmeng.service.repository.authority;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hongmeng.service.entity.authority.BaseUserEntity;

public interface BaseUserRepository extends CrudRepository<BaseUserEntity, Long> {

	Iterable<BaseUserEntity> findByIdIn(List<Long> userIds);

	BaseUserEntity findByUsername(String username);

	BaseUserEntity findByGcUsername(String gcUsername);

	BaseUserEntity findByNcUsername(String ncUsername);

}
