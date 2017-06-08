package com.hongmeng.service.service.authority;

import java.util.List;

import com.hongmeng.service.entity.authority.LocationEntity;

public interface LocationService {
	
	LocationEntity findOne(Long locationId);
	
	void save(LocationEntity location);
	
	void update(LocationEntity location, Long pid, Integer level, String name);
	
	void delete(List<Long> locationIds);
	
	List<LocationEntity> listByLevel(Integer level);
	
	List<LocationEntity> listByPid(Long pid);

}
