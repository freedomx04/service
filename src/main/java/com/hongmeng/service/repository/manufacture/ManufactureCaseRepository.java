package com.hongmeng.service.repository.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.manufacture.ManufactureCaseEntity;

public interface ManufactureCaseRepository extends PagingAndSortingRepository<ManufactureCaseEntity, Long> {
	
	Iterable<ManufactureCaseEntity> findByIdIn(List<Long> caseIds);

	List<ManufactureCaseEntity> findAllByOrderByUpdateTimeDesc();

	Page<ManufactureCaseEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<ManufactureCaseEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId);

	Page<ManufactureCaseEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId, Pageable pageable);

}