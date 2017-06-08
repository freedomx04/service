package com.hongmeng.service.service.financing;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.financing.FinancingEvaluationEntity;

public interface FinancingEvaluationService {

	FinancingEvaluationEntity findOne(Long evaluationId);

	void save(FinancingEvaluationEntity evaluation);

	List<FinancingEvaluationEntity> listByCompanyId(Long companyId);

	Page<FinancingEvaluationEntity> listByCompanyId(Long companyId, int page, int size);

	List<FinancingEvaluationEntity> listByUserId(Long userId);

	Page<FinancingEvaluationEntity> listByUserId(Long userId, int page, int size);

}