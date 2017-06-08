package com.hongmeng.service.repository.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.manufacture.ManufactureCompanyEntity;

public interface ManufactureCompanyRepository extends PagingAndSortingRepository<ManufactureCompanyEntity, Long> {

	ManufactureCompanyEntity findByUserId(Long userId);
	
	List<ManufactureCompanyEntity> findByStatusManufacture(Integer status);
	
	Page<ManufactureCompanyEntity> findByStatusManufacture(Integer status, Pageable pageable);
	
}
