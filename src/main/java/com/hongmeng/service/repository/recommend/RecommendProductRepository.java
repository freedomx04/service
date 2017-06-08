package com.hongmeng.service.repository.recommend;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.recommend.RecommendProductEntity;

public interface RecommendProductRepository extends PagingAndSortingRepository<RecommendProductEntity, Long> {
	
	Iterable<RecommendProductEntity> findByIdIn(List<Long> productIds);
	
	List<RecommendProductEntity> findByCompanyId(Long companyId);
	
	Page<RecommendProductEntity> findByCompanyId(Long companyId, Pageable pageable);

}