package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.common.BaseCompanyEntity.CompanyStatus;
import com.hongmeng.service.entity.manufacture.ManufactureCompanyEntity;
import com.hongmeng.service.repository.manufacture.ManufactureCompanyRepository;

@Service
public class ManufactureCompanyServiceImpl implements ManufactureCompanyService {

	@Autowired
	ManufactureCompanyRepository companyRepository;

	@Override
	public ManufactureCompanyEntity findOne(Long companyId) {
		return companyRepository.findOne(companyId);
	}

	@Override
	public ManufactureCompanyEntity findByUserId(Long userId) {
		return companyRepository.findByUserId(userId);
	}

	@Override
	public void save(ManufactureCompanyEntity company) {
		Date now = new Date();
		company.setCreateTime(now);
		company.setUpdateTime(now);
		companyRepository.save(company);
	}

	@Override
	public void delete(ManufactureCompanyEntity company) {
		companyRepository.delete(company);
	}

	@Override
	public List<ManufactureCompanyEntity> list() {
		return companyRepository.findByStatusManufacture(CompanyStatus.STATUS_PASS);
	}

	@Override
	public Page<ManufactureCompanyEntity> listPaging(int page, int size) {
		return companyRepository.findByStatusManufacture(CompanyStatus.STATUS_PASS, new PageRequest(page, size));
	}

}