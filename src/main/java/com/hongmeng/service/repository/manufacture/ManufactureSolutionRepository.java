package com.hongmeng.service.repository.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.manufacture.ManufactureSolutionEntity;

public interface ManufactureSolutionRepository extends PagingAndSortingRepository<ManufactureSolutionEntity, Long> {
	
	Iterable<ManufactureSolutionEntity> findByIdIn(List<Long> solutionIds);

	List<ManufactureSolutionEntity> findAllByOrderByUpdateTimeDesc();

	Page<ManufactureSolutionEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<ManufactureSolutionEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId);

	Page<ManufactureSolutionEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId, Pageable pageable);

}