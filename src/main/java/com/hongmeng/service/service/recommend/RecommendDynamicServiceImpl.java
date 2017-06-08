package com.hongmeng.service.service.recommend;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.recommend.RecommendDynamicEntity;
import com.hongmeng.service.repository.recommend.RecommendDynamicRepository;

@Service
public class RecommendDynamicServiceImpl implements RecommendDynamicService {
	
	@Autowired
	RecommendDynamicRepository dynamicRepository;

	@Override
	public RecommendDynamicEntity findOne(Long dynamicId) {
		return dynamicRepository.findOne(dynamicId);
	}

	@Override
	public void save(RecommendDynamicEntity dynamic) {
		Date now = new Date();
		dynamic.setCreateTime(now);
		dynamic.setUpdateTime(now);
		dynamicRepository.save(dynamic);
	}

	@Override
	public void update(RecommendDynamicEntity dynamic, String title, String source, String linkPath) {
		dynamic.setTitle(title);
		dynamic.setSource(source);
		dynamic.setLinkPath(linkPath);
		
		dynamic.setUpdateTime(new Date());
		dynamicRepository.save(dynamic);
	}

	@Override
	public void delete(List<Long> dynamicIds) {
		Iterable<RecommendDynamicEntity> it = dynamicRepository.findByIdIn(dynamicIds);
		dynamicRepository.delete(it);
	}

	@Override
	public List<RecommendDynamicEntity> list() {
		return dynamicRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<RecommendDynamicEntity> list(int page, int size) {
		return dynamicRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<RecommendDynamicEntity> listByCompanyId(Long companyId) {
		return dynamicRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId);
	}

	@Override
	public Page<RecommendDynamicEntity> listByCompanyId(Long companyId, int page, int size) {
		return dynamicRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId, new PageRequest(page, size));
	}

}
