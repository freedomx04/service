package com.hongmeng.service.service.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.manufacture.ManufactureDynamicEntity;

public interface ManufactureDynamicService {
	
	ManufactureDynamicEntity findOne(Long dynamicId);
	
	void save(ManufactureDynamicEntity dynamic);
	
	void update(ManufactureDynamicEntity dynamic, String title, String source, String linkPath);
	
	void delete(List<Long> dynamicIds);
	
	List<ManufactureDynamicEntity> list();
	
	Page<ManufactureDynamicEntity> list(int page, int size);
	
	List<ManufactureDynamicEntity> listByCompanyId(Long companyId);
	
	Page<ManufactureDynamicEntity> listByCompanyId(Long companyId, int page, int size);

}