package com.hongmeng.service.service.recommend;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.recommend.RecommendCompanyEntity;

public interface RecommendCompanyService {
	
	RecommendCompanyEntity findOne(Long companyId);
	
	RecommendCompanyEntity findByUserId(Long userId);
	
	void save(RecommendCompanyEntity company);
	
	void delete(RecommendCompanyEntity company);
	
	List<RecommendCompanyEntity> list();
	
	Page<RecommendCompanyEntity> listPaging(int page, int size);

}
