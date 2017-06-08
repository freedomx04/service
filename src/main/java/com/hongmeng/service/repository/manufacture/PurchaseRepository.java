package com.hongmeng.service.repository.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.manufacture.PurchaseEntity;

public interface PurchaseRepository extends PagingAndSortingRepository<PurchaseEntity, Long> {
	
	Iterable<PurchaseEntity> findByIdIn(List<Long> purchaseIds);
	
	List<PurchaseEntity> findAllByOrderByUpdateTimeDesc();

	Page<PurchaseEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);
	
	List<PurchaseEntity> findByUserIdOrderByUpdateTimeDesc(Long userId);

	Page<PurchaseEntity> findByUserIdOrderByUpdateTimeDesc(Long userId, Pageable pageable);

}