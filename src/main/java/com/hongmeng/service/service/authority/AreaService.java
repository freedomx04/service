package com.hongmeng.service.service.authority;

import java.util.List;

import com.hongmeng.service.entity.authority.AreaEntity;

public interface AreaService {

	AreaEntity findOne(Long areaId);
	
	AreaEntity findByName(String name);
	
	void save(AreaEntity area);
	
	void update(AreaEntity area, String name, String description);
	
	void delete(List<Long> areaIds);
	
	List<AreaEntity> list();
	
}
