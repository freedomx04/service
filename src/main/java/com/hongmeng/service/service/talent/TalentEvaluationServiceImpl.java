package com.hongmeng.service.service.talent;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.talent.TalentEvaluationEntity;
import com.hongmeng.service.repository.talent.TalentEvaluationRepository;

@Service
public class TalentEvaluationServiceImpl implements TalentEvaluationService {
	
	@Autowired
	TalentEvaluationRepository evaluationRepository;

	@Override
	public TalentEvaluationEntity findOne(Long evaluationId) {
		return evaluationRepository.findOne(evaluationId);
	}

	@Override
	public void save(TalentEvaluationEntity evaluation) {
		Date now = new Date();
		evaluation.setCreateTime(now);
		evaluation.setUpdateTime(now);
		evaluationRepository.save(evaluation);
	}

	@Override
	public List<TalentEvaluationEntity> listByCompanyId(Long companyId) {
		return evaluationRepository.findByCompanyIdOrderByCreateTimeDesc(companyId);
	}

	@Override
	public Page<TalentEvaluationEntity> listByCompanyId(Long companyId, int page, int size) {
		return evaluationRepository.findByCompanyIdOrderByCreateTimeDesc(companyId, new PageRequest(page, size));
	}

	@Override
	public List<TalentEvaluationEntity> listByUserId(Long userId) {
		return evaluationRepository.findByUserIdOrderByCreateTimeDesc(userId);
	}

	@Override
	public Page<TalentEvaluationEntity> listByUserId(Long userId, int page, int size) {
		return evaluationRepository.findByUserIdOrderByCreateTimeDesc(userId, new PageRequest(page, size));
	}

}