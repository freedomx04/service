package com.hongmeng.service.repository.recommend;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.recommend.RecommendDynamicEntity;

public interface RecommendDynamicRepository extends PagingAndSortingRepository<RecommendDynamicEntity, Long> {
	
	Iterable<RecommendDynamicEntity> findByIdIn(List<Long> dynamicIds);

	List<RecommendDynamicEntity> findAllByOrderByUpdateTimeDesc();

	Page<RecommendDynamicEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);

	List<RecommendDynamicEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId);

	Page<RecommendDynamicEntity> findByCompanyIdOrderByUpdateTimeDesc(Long companyId, Pageable pageable);

}