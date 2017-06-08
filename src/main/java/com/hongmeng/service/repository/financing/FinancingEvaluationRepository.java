package com.hongmeng.service.repository.financing;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import com.hongmeng.service.entity.financing.FinancingEvaluationEntity;

public interface FinancingEvaluationRepository extends CrudRepository<FinancingEvaluationEntity, Long> {
	
	List<FinancingEvaluationEntity> findByCompanyIdOrderByCreateTimeDesc(Long companyId);
	
	Page<FinancingEvaluationEntity> findByCompanyIdOrderByCreateTimeDesc(Long companyId, Pageable pageable);
	
	List<FinancingEvaluationEntity> findByUserIdOrderByCreateTimeDesc(Long userId);
	
	Page<FinancingEvaluationEntity> findByUserIdOrderByCreateTimeDesc(Long userId, Pageable pageable);

}
