package com.hongmeng.service.repository.logistics;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.logistics.LogisticsDynamicEntity;

public interface LogisticsDynamicRepository extends PagingAndSortingRepository<LogisticsDynamicEntity, Long> {
	
	Iterable<LogisticsDynamicEntity> findByIdIn(List<Long> dynamicIds);

	List<LogisticsDynamicEntity> findAllByOrderByUpdateTimeDesc();

	Page<LogisticsDynamicEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<LogisticsDynamicEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId);

	Page<LogisticsDynamicEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId, Pageable pageable);

}