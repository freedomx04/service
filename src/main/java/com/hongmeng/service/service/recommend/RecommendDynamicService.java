package com.hongmeng.service.service.recommend;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.recommend.RecommendDynamicEntity;

public interface RecommendDynamicService {
	
	RecommendDynamicEntity findOne(Long dynamicId);
	
	void save(RecommendDynamicEntity dynamic);
	
	void update(RecommendDynamicEntity dynamic, String title, String source, String linkPath);
	
	void delete(List<Long> dynamicIds);
	
	List<RecommendDynamicEntity> list();
	
	Page<RecommendDynamicEntity> list(int page, int size);
	
	List<RecommendDynamicEntity> listByCompanyId(Long companyId);
	
	Page<RecommendDynamicEntity> listByCompanyId(Long companyId, int page, int size);

}
