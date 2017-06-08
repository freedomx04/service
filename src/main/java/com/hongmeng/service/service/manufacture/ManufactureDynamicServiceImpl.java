package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.manufacture.ManufactureDynamicEntity;
import com.hongmeng.service.repository.manufacture.ManufactureDynamicRepository;

@Service
public class ManufactureDynamicServiceImpl implements ManufactureDynamicService {

	@Autowired
	ManufactureDynamicRepository dynamicRepository;
	
	@Override
	public ManufactureDynamicEntity findOne(Long dynamicId) {
		return dynamicRepository.findOne(dynamicId);
	}

	@Override
	public void save(ManufactureDynamicEntity dynamic) {
		Date now = new Date();
		dynamic.setCreateTime(now);
		dynamic.setUpdateTime(now);
		dynamicRepository.save(dynamic);
	}

	@Override
	public void update(ManufactureDynamicEntity dynamic, String title, String source, String linkPath) {
		dynamic.setTitle(title);
		dynamic.setSource(source);
		dynamic.setLinkPath(linkPath);
		
		dynamic.setUpdateTime(new Date());
		dynamicRepository.save(dynamic);
	}

	@Override
	public void delete(List<Long> dynamicIds) {
		Iterable<ManufactureDynamicEntity> it = dynamicRepository.findByIdIn(dynamicIds);
		dynamicRepository.delete(it);
	}

	@Override
	public List<ManufactureDynamicEntity> list() {
		return dynamicRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<ManufactureDynamicEntity> list(int page, int size) {
		return dynamicRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<ManufactureDynamicEntity> listByCompanyId(Long companyId) {
		return dynamicRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId);
	}

	@Override
	public Page<ManufactureDynamicEntity> listByCompanyId(Long companyId, int page, int size) {
		return dynamicRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId, new PageRequest(page, size));
	}

}