package com.hongmeng.service.repository.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.manufacture.ManufactureDynamicEntity;

public interface ManufactureDynamicRepository extends PagingAndSortingRepository<ManufactureDynamicEntity, Long> {

	Iterable<ManufactureDynamicEntity> findByIdIn(List<Long> dynamicIds);

	List<ManufactureDynamicEntity> findAllByOrderByUpdateTimeDesc();

	Page<ManufactureDynamicEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<ManufactureDynamicEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId);

	Page<ManufactureDynamicEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId, Pageable pageable);
	
}
