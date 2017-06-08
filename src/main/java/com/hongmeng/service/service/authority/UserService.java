package com.hongmeng.service.service.authority;

import java.util.List;

import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.authority.RoleEntity;
import com.hongmeng.service.entity.authority.UserEntity;

public interface UserService {
	
	/**
	 * base user
	 */
	BaseUserEntity findOneBase(Long userId);
	
	BaseUserEntity findByUsernameBase(String username);
	
	void saveBase(BaseUserEntity user);
	
	List<BaseUserEntity> listBase();
	
	/**
	 * user
	 */
	UserEntity findOne(Long userId);
	
	UserEntity findByUsername(String username);
	
	void save(UserEntity user);
	
	void update(UserEntity user, RoleEntity role, String telephone);
	
	void update(UserEntity user, String telephone);
	
	void updatePassword(UserEntity user, String password);
	
	List<UserEntity> list();
	
	void delete(List<Long> userIds);
	
	/**
	 * platform
	 */
	BaseUserEntity findByGcUsername(String gcUsername);
	
	BaseUserEntity findByNcUsername(String ncUsername);

}