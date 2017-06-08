package com.hongmeng.service.service.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.manufacture.ManufactureCaseEntity;

public interface ManufactureCaseService {
	
	ManufactureCaseEntity findOne(Long caseId);
	
	void save(ManufactureCaseEntity manufactureCase);
	
	void update(ManufactureCaseEntity manufactureCase, String title, String source, String linkPath);
	
	void delete(List<Long> caseIds);
	
	List<ManufactureCaseEntity> list();
	
	Page<ManufactureCaseEntity> list(int page, int size);
	
	List<ManufactureCaseEntity> listByCompanyId(Long companyId);
	
	Page<ManufactureCaseEntity> listByCompanyId(Long companyId, int page, int size);

}