package com.hongmeng.service.repository.logistics;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import com.hongmeng.service.entity.logistics.LogisticsEvaluationEntity;

public interface LogisticsEvaluationRepository extends CrudRepository<LogisticsEvaluationEntity, Long> {
	
	List<LogisticsEvaluationEntity> findByCompanyIdOrderByCreateTimeDesc(Long companyId);
	
	Page<LogisticsEvaluationEntity> findByCompanyIdOrderByCreateTimeDesc(Long companyId, Pageable pageable);
	
	List<LogisticsEvaluationEntity> findByUserIdOrderByCreateTimeDesc(Long userId);
	
	Page<LogisticsEvaluationEntity> findByUserIdOrderByCreateTimeDesc(Long userId, Pageable pageable);

}
