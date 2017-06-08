package com.hongmeng.service.service.financing;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.common.BaseCompanyEntity.CompanyStatus;
import com.hongmeng.service.entity.financing.FinancingCompanyEntity;
import com.hongmeng.service.repository.financing.FinancingCompanyRepository;

@Service
public class FinancingCompanyServiceImpl implements FinancingCompanyService {

	@Autowired
	FinancingCompanyRepository companyRepository;

	@Override
	public FinancingCompanyEntity findOne(Long companyId) {
		return companyRepository.findOne(companyId);
	}

	@Override
	public FinancingCompanyEntity findByUserId(Long userId) {
		return companyRepository.findByUserId(userId);
	}

	@Override
	public void save(FinancingCompanyEntity company) {
		Date now = new Date();
		company.setCreateTime(now);
		company.setUpdateTime(now);
		companyRepository.save(company);
	}

	@Override
	public void delete(FinancingCompanyEntity company) {
		companyRepository.delete(company);
	}

	@Override
	public List<FinancingCompanyEntity> list() {
		return companyRepository.findByStatusFinancing(CompanyStatus.STATUS_PASS);
	}

	@Override
	public Page<FinancingCompanyEntity> listPaging(int page, int size) {
		return companyRepository.findByStatusFinancing(CompanyStatus.STATUS_PASS, new PageRequest(page, size));
	}

}