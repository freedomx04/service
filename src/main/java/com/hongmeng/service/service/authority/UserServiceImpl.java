package com.hongmeng.service.service.authority;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.authority.BaseUserEntity;
import com.hongmeng.service.entity.authority.RoleEntity;
import com.hongmeng.service.entity.authority.UserEntity;
import com.hongmeng.service.repository.authority.BaseUserRepository;
import com.hongmeng.service.repository.authority.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	BaseUserRepository baseUserRepository;
	
	@Autowired
	UserRepository userRepository;
	
	/**
	 * base user
	 */
	@Override 
	public BaseUserEntity findOneBase(Long userId) {
		return baseUserRepository.findOne(userId);
	}
	
	@Override
	public BaseUserEntity findByUsernameBase(String username) {
		return baseUserRepository.findByUsername(username);
	}

	@Override
	public void saveBase(BaseUserEntity user) {
		Date now = new Date();
		user.setCreateTime(now);
		user.setUpdateTime(now);
		baseUserRepository.save(user);
	}
	
	@Override
	public List<BaseUserEntity> listBase() {
		return (List<BaseUserEntity>) baseUserRepository.findAll();
	}
	
	/**
	 * user
	 */
	@Override
	public UserEntity findOne(Long userId) {
		return userRepository.findOne(userId);
	}

	@Override
	public UserEntity findByUsername(String username) {
		return userRepository.findByUsername(username);
	}
	
	@Override
	public void save(UserEntity user) {
		Date now = new Date();
		user.setCreateTime(now);
		user.setUpdateTime(now);
		userRepository.save(user);
	}
	
	@Override
	public void update(UserEntity user, RoleEntity role, String telephone) {
		user.setRole(role);
		user.setTelephone(telephone);
		user.setUpdateTime(new Date());
		userRepository.save(user);
	}
	

	@Override
	public void update(UserEntity user, String telephone) {
		user.setTelephone(telephone);
		user.setUpdateTime(new Date());
		userRepository.save(user);
	}
	
	@Override
	public void updatePassword(UserEntity user, String password) {
		user.setPassword(password);
		user.setUpdateTime(new Date());
		userRepository.save(user);
	}

	@Override
	public List<UserEntity> list() {
		return (List<UserEntity>) userRepository.findAll();
	}

	@Override
	public void delete(List<Long> userIds) {
		Iterable<UserEntity> it = userRepository.findByIdIn(userIds);
		userRepository.delete(it);
	}

	@Override
	public BaseUserEntity findByGcUsername(String gcUsername) {
		return baseUserRepository.findByGcUsername(gcUsername);
	}

	@Override
	public BaseUserEntity findByNcUsername(String ncUsername) {
		return baseUserRepository.findByNcUsername(ncUsername);
	}

}