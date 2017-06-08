package com.hongmeng.service.service.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.manufacture.ManufactureCompanyEntity;

public interface ManufactureCompanyService {
	
	ManufactureCompanyEntity findOne(Long companyId);
	
	ManufactureCompanyEntity findByUserId(Long userId);
	
	void save(ManufactureCompanyEntity company);
	
	void delete(ManufactureCompanyEntity company);
	
	List<ManufactureCompanyEntity> list();
	
	Page<ManufactureCompanyEntity> listPaging(int page, int size);

}