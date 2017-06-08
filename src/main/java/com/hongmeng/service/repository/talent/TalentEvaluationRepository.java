package com.hongmeng.service.repository.talent;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import com.hongmeng.service.entity.talent.TalentEvaluationEntity;

public interface TalentEvaluationRepository extends CrudRepository<TalentEvaluationEntity, Long> {
	
	List<TalentEvaluationEntity> findByCompanyIdOrderByCreateTimeDesc(Long companyId);
	
	Page<TalentEvaluationEntity> findByCompanyIdOrderByCreateTimeDesc(Long companyId, Pageable pageable);
	
	List<TalentEvaluationEntity> findByUserIdOrderByCreateTimeDesc(Long userId);
	
	Page<TalentEvaluationEntity> findByUserIdOrderByCreateTimeDesc(Long userId, Pageable pageable);

}
