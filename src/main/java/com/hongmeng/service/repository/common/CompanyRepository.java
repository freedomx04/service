package com.hongmeng.service.repository.common;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.common.CompanyEntity;

public interface CompanyRepository extends PagingAndSortingRepository<CompanyEntity, Long> {
	
	CompanyEntity findByUserId(Long userId);
	
	List<CompanyEntity> findByStatus(Integer status);

}
