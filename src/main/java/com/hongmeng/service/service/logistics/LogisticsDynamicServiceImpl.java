package com.hongmeng.service.service.logistics;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.logistics.LogisticsDynamicEntity;
import com.hongmeng.service.repository.logistics.LogisticsDynamicRepository;

@Service
public class LogisticsDynamicServiceImpl implements LogisticsDynamicService {
	
	@Autowired
	LogisticsDynamicRepository dynamicRepository;

	@Override
	public LogisticsDynamicEntity findOne(Long dynamicId) {
		return dynamicRepository.findOne(dynamicId);
	}

	@Override
	public void save(LogisticsDynamicEntity dynamic) {
		Date now = new Date();
		dynamic.setCreateTime(now);
		dynamic.setUpdateTime(now);
		dynamicRepository.save(dynamic);
	}

	@Override
	public void update(LogisticsDynamicEntity dynamic, String title, String source, String linkPath) {
		dynamic.setTitle(title);
		dynamic.setSource(source);
		dynamic.setLinkPath(linkPath);
		
		dynamic.setUpdateTime(new Date());
		dynamicRepository.save(dynamic);
	}

	@Override
	public void delete(List<Long> dynamicIds) {
		Iterable<LogisticsDynamicEntity> it = dynamicRepository.findByIdIn(dynamicIds);
		dynamicRepository.delete(it);
	}

	@Override
	public List<LogisticsDynamicEntity> list() {
		return dynamicRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<LogisticsDynamicEntity> list(int page, int size) {
		return dynamicRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<LogisticsDynamicEntity> listByCompanyId(Long companyId) {
		return dynamicRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId);
	}

	@Override
	public Page<LogisticsDynamicEntity> listByCompanyId(Long companyId, int page, int size) {
		return dynamicRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId, new PageRequest(page, size));
	}

}