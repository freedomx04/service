package com.hongmeng.service.service.logistics;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.logistics.LogisticsEvaluationEntity;
import com.hongmeng.service.repository.logistics.LogisticsEvaluationRepository;

@Service
public class LogisticsEvaluationServiceImpl implements LogisticsEvaluationService {
	
	@Autowired
	LogisticsEvaluationRepository evaluationRepository;

	@Override
	public LogisticsEvaluationEntity findOne(Long evaluationId) {
		return evaluationRepository.findOne(evaluationId);
	}

	@Override
	public void save(LogisticsEvaluationEntity evaluation) {
		Date now = new Date();
		evaluation.setCreateTime(now);
		evaluation.setUpdateTime(now);
		evaluationRepository.save(evaluation);
	}

	@Override
	public List<LogisticsEvaluationEntity> listByCompanyId(Long companyId) {
		return evaluationRepository.findByCompanyIdOrderByCreateTimeDesc(companyId);
	}

	@Override
	public Page<LogisticsEvaluationEntity> listByCompanyId(Long companyId, int page, int size) {
		return evaluationRepository.findByCompanyIdOrderByCreateTimeDesc(companyId, new PageRequest(page, size));
	}

	@Override
	public List<LogisticsEvaluationEntity> listByUserId(Long userId) {
		return evaluationRepository.findByUserIdOrderByCreateTimeDesc(userId);
	}

	@Override
	public Page<LogisticsEvaluationEntity> listByUserId(Long userId, int page, int size) {
		return evaluationRepository.findByUserIdOrderByCreateTimeDesc(userId, new PageRequest(page, size));
	}

}