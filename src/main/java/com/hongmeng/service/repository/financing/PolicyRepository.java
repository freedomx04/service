package com.hongmeng.service.repository.financing;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.financing.PolicyEntity;

public interface PolicyRepository extends PagingAndSortingRepository<PolicyEntity, Long> {
	
	Iterable<PolicyEntity> findByIdIn(List<Long> policyIds);

	List<PolicyEntity> findAllByOrderByUpdateTimeDesc();

	Page<PolicyEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

}