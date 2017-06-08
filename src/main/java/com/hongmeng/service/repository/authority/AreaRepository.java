package com.hongmeng.service.repository.authority;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hongmeng.service.entity.authority.AreaEntity;

public interface AreaRepository extends CrudRepository<AreaEntity, Long> {

	Iterable<AreaEntity> findByIdIn(List<Long> areaIds);

	AreaEntity findByName(String name);

}
