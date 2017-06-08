package com.hongmeng.service.service.authority;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.authority.LocationEntity;
import com.hongmeng.service.repository.authority.LocationRepository;

@Service
public class LocationServiceImpl implements LocationService {
	
	@Autowired
	LocationRepository locationRepository;

	@Override
	public LocationEntity findOne(Long locationId) {
		return locationRepository.findOne(locationId);
	}

	@Override
	public void save(LocationEntity location) {
		Date now = new Date();
		location.setCreateTime(now);
		location.setUpdateTime(now);
		locationRepository.save(location);
	}

	@Override
	public void update(LocationEntity location, Long pid, Integer level, String name) {
		location.setPid(pid);
		location.setLevel(level);
		location.setName(name);
		
		location.setUpdateTime(new Date());
		locationRepository.save(location);
	}

	@Override
	public void delete(List<Long> locationIds) {
		Iterable<LocationEntity> it = locationRepository.findByIdIn(locationIds);
		locationRepository.delete(it);
	}

	@Override
	public List<LocationEntity> listByLevel(Integer level) {
		return locationRepository.findByLevel(level);
	}

	@Override
	public List<LocationEntity> listByPid(Long pid) {
		return locationRepository.findByPid(pid);
	}

}