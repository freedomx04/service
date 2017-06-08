package com.hongmeng.service.service.financing;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.financing.FinancingEvaluationEntity;
import com.hongmeng.service.repository.financing.FinancingEvaluationRepository;

@Service
public class FinancingEvaluationServiceImpl implements FinancingEvaluationService {

	@Autowired
	FinancingEvaluationRepository evaluationRepository;

	@Override
	public FinancingEvaluationEntity findOne(Long evaluationId) {
		return evaluationRepository.findOne(evaluationId);
	}

	@Override
	public void save(FinancingEvaluationEntity evaluation) {
		Date now = new Date();
		evaluation.setCreateTime(now);
		evaluation.setUpdateTime(now);
		evaluationRepository.save(evaluation);
	}

	@Override
	public List<FinancingEvaluationEntity> listByCompanyId(Long companyId) {
		return evaluationRepository.findByCompanyIdOrderByCreateTimeDesc(companyId);
	}

	@Override
	public Page<FinancingEvaluationEntity> listByCompanyId(Long companyId, int page, int size) {
		return evaluationRepository.findByCompanyIdOrderByCreateTimeDesc(companyId, new PageRequest(page, size));
	}

	@Override
	public List<FinancingEvaluationEntity> listByUserId(Long userId) {
		return evaluationRepository.findByUserIdOrderByCreateTimeDesc(userId);
	}

	@Override
	public Page<FinancingEvaluationEntity> listByUserId(Long userId, int page, int size) {
		return evaluationRepository.findByUserIdOrderByCreateTimeDesc(userId, new PageRequest(page, size));
	}

}