package com.hongmeng.service.service.authority;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.repository.authority.AreaRepository;

@Service
public class AreaServiceImpl implements AreaService {
	
	@Autowired
	AreaRepository areaRepository;

	@Override
	public AreaEntity findOne(Long areaId) {
		return areaRepository.findOne(areaId);
	}
	
	@Override
	public AreaEntity findByName(String name) {
		return areaRepository.findByName(name);
	}

	@Override
	public void save(AreaEntity area) {
		Date now = new Date();
		area.setCreateTime(now);
		area.setUpdateTime(now);
		areaRepository.save(area);
	}
	
	@Override
	public void update(AreaEntity area, String name, String description) {
		area.setName(name);
		area.setDescription(description);
		
		area.setUpdateTime(new Date());
		areaRepository.save(area);
	}

	@Override
	public void delete(List<Long> areaIds) {
		Iterable<AreaEntity> it = areaRepository.findByIdIn(areaIds);
		areaRepository.delete(it);
	}

	@Override
	public List<AreaEntity> list() {
		return (List<AreaEntity>) areaRepository.findAll();
	}
	
}