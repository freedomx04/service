package com.hongmeng.service.repository.authority;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hongmeng.service.entity.authority.LocationEntity;

public interface LocationRepository extends CrudRepository<LocationEntity, Long> {
	
	Iterable<LocationEntity> findByIdIn(List<Long> locationIds);
	
	List<LocationEntity> findByLevel(Integer level);
	
	List<LocationEntity> findByPid(Long pid);

}
