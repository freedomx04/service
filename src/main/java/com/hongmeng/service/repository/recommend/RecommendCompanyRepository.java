package com.hongmeng.service.repository.recommend;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.recommend.RecommendCompanyEntity;

public interface RecommendCompanyRepository extends PagingAndSortingRepository<RecommendCompanyEntity, Long> {

	RecommendCompanyEntity findByUserId(Long userId);
	
	List<RecommendCompanyEntity> findByStatusRecommend(Integer status);
	
	Page<RecommendCompanyEntity> findByStatusRecommend(Integer status, Pageable pageable);
	
}