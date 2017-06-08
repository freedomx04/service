package com.hongmeng.service.service.talent;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.talent.TalentEvaluationEntity;

public interface TalentEvaluationService {
	
	TalentEvaluationEntity findOne(Long evaluationId);

	void save(TalentEvaluationEntity evaluation);
	
	List<TalentEvaluationEntity> listByCompanyId(Long companyId);
	
	Page<TalentEvaluationEntity> listByCompanyId(Long companyId, int page, int size);
	
	List<TalentEvaluationEntity> listByUserId(Long userId);
	
	Page<TalentEvaluationEntity> listByUserId(Long userId, int page, int size);

}