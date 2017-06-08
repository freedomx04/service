package com.hongmeng.service.repository.financing;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.financing.FinancingCompanyEntity;

public interface FinancingCompanyRepository extends PagingAndSortingRepository<FinancingCompanyEntity, Long> {

	FinancingCompanyEntity findByUserId(Long userId);
	
	List<FinancingCompanyEntity> findByStatusFinancing(Integer status);
	
	Page<FinancingCompanyEntity> findByStatusFinancing(Integer status, Pageable pageable);
	
}