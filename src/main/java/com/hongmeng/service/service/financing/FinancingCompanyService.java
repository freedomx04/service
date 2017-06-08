package com.hongmeng.service.service.financing;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.financing.FinancingCompanyEntity;

public interface FinancingCompanyService {
	
	FinancingCompanyEntity findOne(Long companyId);
	
	FinancingCompanyEntity findByUserId(Long userId);
	
	void save(FinancingCompanyEntity company);
	
	void delete(FinancingCompanyEntity company);
	
	List<FinancingCompanyEntity> list();
	
	Page<FinancingCompanyEntity> listPaging(int page, int size);

}