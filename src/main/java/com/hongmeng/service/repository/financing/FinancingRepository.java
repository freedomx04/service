package com.hongmeng.service.repository.financing;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.financing.FinancingEntity;

public interface FinancingRepository extends PagingAndSortingRepository<FinancingEntity, Long> {
	
	Iterable<FinancingEntity> findByIdIn(List<Long> financingIds);
	
	Page<FinancingEntity> findByNameContaining(String name, Pageable pageable);
	
	Page<FinancingEntity> findByProfessionInAndFinancingTypeIn(List<Integer> profession, List<Integer> financingType, Pageable pageable);
	
	List<FinancingEntity> findAllByOrderByUpdateTimeDesc();

	Page<FinancingEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<FinancingEntity> findByUserIdOrderByUpdateTimeDesc(Long userId);

	Page<FinancingEntity> findByUserIdOrderByUpdateTimeDesc(Long userId, Pageable pageable);

}