package com.hongmeng.service.service.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.manufacture.ManufactureSolutionEntity;

public interface ManufactureSolutionService {
	
	ManufactureSolutionEntity findOne(Long solutionId);
	
	void save(ManufactureSolutionEntity solution);
	
	void update(ManufactureSolutionEntity solution, String title, String source, String linkPath);
	
	void delete(List<Long> solutionIds);
	
	List<ManufactureSolutionEntity> list();
	
	Page<ManufactureSolutionEntity> list(int page, int size);
	
	List<ManufactureSolutionEntity> listByCompanyId(Long companyId);
	
	Page<ManufactureSolutionEntity> listByCompanyId(Long companyId, int page, int size);

}
