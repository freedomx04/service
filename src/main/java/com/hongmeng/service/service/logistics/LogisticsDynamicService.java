package com.hongmeng.service.service.logistics;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.logistics.LogisticsDynamicEntity;

public interface LogisticsDynamicService {
	
	LogisticsDynamicEntity findOne(Long dynamicId);
	
	void save(LogisticsDynamicEntity dynamic);
	
	void update(LogisticsDynamicEntity dynamic, String title, String source, String linkPath);
	
	void delete(List<Long> dynamicIds);
	
	List<LogisticsDynamicEntity> list();
	
	Page<LogisticsDynamicEntity> list(int page, int size);
	
	List<LogisticsDynamicEntity> listByCompanyId(Long companyId);
	
	Page<LogisticsDynamicEntity> listByCompanyId(Long companyId, int page, int size);

}
