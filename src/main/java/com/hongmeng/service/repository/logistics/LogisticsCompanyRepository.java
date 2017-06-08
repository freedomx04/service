package com.hongmeng.service.repository.logistics;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.logistics.LogisticsCompanyEntity;

public interface LogisticsCompanyRepository extends PagingAndSortingRepository<LogisticsCompanyEntity, Long> {

	LogisticsCompanyEntity findByUserId(Long userId);
	
	List<LogisticsCompanyEntity> findByStatusLogistics(Integer status);
	
	Page<LogisticsCompanyEntity> findByStatusLogistics(Integer status, Pageable pageable);
	
}
