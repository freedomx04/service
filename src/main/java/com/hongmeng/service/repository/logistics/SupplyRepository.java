package com.hongmeng.service.repository.logistics;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.logistics.SupplyEntity;

public interface SupplyRepository extends PagingAndSortingRepository<SupplyEntity, Long> {
	
	Iterable<SupplyEntity> findByIdIn(List<Long> supplyIds);
	
	Page<SupplyEntity> findByOriginContainingAndDestinationContaining(String origin, String destination, Pageable pageable);
	
	List<SupplyEntity> findByOrderByCreateTimeDesc();
	
	Page<SupplyEntity> findByOrderByCreateTimeDesc(Pageable pageable);
	
	List<SupplyEntity> findByUserIdOrderByCreateTimeDesc(Long userId);
	
	Page<SupplyEntity> findByUserIdOrderByCreateTimeDesc(Long userId, Pageable pageable);
	
	List<SupplyEntity> findByOriginAndDestinationOrderByCreateTimeDesc(String origin, String destination);
	
	Page<SupplyEntity> findByOriginAndDestinationOrderByCreateTimeDesc(String origin, String destination, Pageable pageable);

}