package com.hongmeng.service.service.logistics;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.logistics.LogisticsEvaluationEntity;

public interface LogisticsEvaluationService {
	
	LogisticsEvaluationEntity findOne(Long evaluationId);

	void save(LogisticsEvaluationEntity evaluation);
	
	List<LogisticsEvaluationEntity> listByCompanyId(Long companyId);
	
	Page<LogisticsEvaluationEntity> listByCompanyId(Long companyId, int page, int size);
	
	List<LogisticsEvaluationEntity> listByUserId(Long userId);
	
	Page<LogisticsEvaluationEntity> listByUserId(Long userId, int page, int size);

}
