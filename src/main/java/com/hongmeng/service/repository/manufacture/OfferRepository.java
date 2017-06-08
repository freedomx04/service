package com.hongmeng.service.repository.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.manufacture.OfferEntity;

public interface OfferRepository extends PagingAndSortingRepository<OfferEntity, Long> {
	
	Iterable<OfferEntity> findByIdIn(List<Long> offerIds);
	
	List<OfferEntity> findAllByOrderByUpdateTimeDesc();

	Page<OfferEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);
	
	List<OfferEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId);

	Page<OfferEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId, Pageable pageable);

}