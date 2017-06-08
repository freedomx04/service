package com.hongmeng.service.service.recommend;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.common.BaseCompanyEntity.CompanyStatus;
import com.hongmeng.service.entity.recommend.RecommendCompanyEntity;
import com.hongmeng.service.repository.recommend.RecommendCompanyRepository;

@Service
public class RecommendCompanyServiceImpl implements RecommendCompanyService {
	
	@Autowired
	RecommendCompanyRepository companyRepository;

	@Override
	public RecommendCompanyEntity findOne(Long companyId) {
		return companyRepository.findOne(companyId);
	}

	@Override
	public RecommendCompanyEntity findByUserId(Long userId) {
		return companyRepository.findByUserId(userId);
	}

	@Override
	public void save(RecommendCompanyEntity company) {
		Date now = new Date();
		company.setCreateTime(now);
		company.setUpdateTime(now);
		companyRepository.save(company);
	}

	@Override
	public void delete(RecommendCompanyEntity company) {
		companyRepository.delete(company);
	}

	@Override
	public List<RecommendCompanyEntity> list() {
		return companyRepository.findByStatusRecommend(CompanyStatus.STATUS_PASS);
	}

	@Override
	public Page<RecommendCompanyEntity> listPaging(int page, int size) {
		return companyRepository.findByStatusRecommend(CompanyStatus.STATUS_PASS, new PageRequest(page, size));
	}

}