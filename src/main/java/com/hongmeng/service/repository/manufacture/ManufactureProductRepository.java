package com.hongmeng.service.repository.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.manufacture.ManufactureProductEntity;

public interface ManufactureProductRepository extends PagingAndSortingRepository<ManufactureProductEntity, Long> {
	
	Iterable<ManufactureProductEntity> findByIdIn(List<Long> productIds);
	
	List<ManufactureProductEntity> findByCompanyId(Long companyId);
	
	Page<ManufactureProductEntity> findByCompanyId(Long companyId, Pageable pageable);
	
	Page<ManufactureProductEntity> findByClazz(Integer clazz, Pageable pageable);
	
	Page<ManufactureProductEntity> findBySubClazz(Integer subClazz, Pageable pageable);

}
