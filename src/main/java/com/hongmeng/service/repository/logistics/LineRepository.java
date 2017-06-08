package com.hongmeng.service.repository.logistics;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.logistics.LineEntity;

public interface LineRepository extends PagingAndSortingRepository<LineEntity, Long> {

	Iterable<LineEntity> findByIdIn(List<Long> lineIds);
	
	Page<LineEntity> findByOriginContainingAndDestinationContaining(String origin, String destination, Pageable pageable);

	List<LineEntity> findByCompanyId(Long companyId);

	Page<LineEntity> findByCompanyId(Long companyId, Pageable pageable);

}
