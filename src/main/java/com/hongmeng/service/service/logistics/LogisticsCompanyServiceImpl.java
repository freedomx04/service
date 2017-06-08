package com.hongmeng.service.service.logistics;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.common.BaseCompanyEntity.CompanyStatus;
import com.hongmeng.service.entity.logistics.LogisticsCompanyEntity;
import com.hongmeng.service.repository.logistics.LogisticsCompanyRepository;

@Service
public class LogisticsCompanyServiceImpl implements LogisticsCompanyService {
	
	@Autowired
	LogisticsCompanyRepository companyRepository;

	@Override
	public LogisticsCompanyEntity findOne(Long companyId) {
		return companyRepository.findOne(companyId);
	}

	@Override
	public LogisticsCompanyEntity findByUserId(Long userId) {
		return companyRepository.findByUserId(userId);
	}

	@Override
	public void save(LogisticsCompanyEntity company) {
		Date now = new Date();
		company.setCreateTime(now);
		company.setUpdateTime(now);
		companyRepository.save(company);
	}
	
	@Override
	public void update(LogisticsCompanyEntity company, String phone, String address, String contactUser,
			String contact, String fax, String website) {
		company.setPhone(phone);
		company.setAddress(address);
		company.setContactUser(contactUser);
		company.setContact(contact);
		company.setFax(fax);
		company.setWebsite(website);
		
		company.setUpdateTime(new Date());
		companyRepository.save(company);
	}

	@Override
	public void delete(LogisticsCompanyEntity company) {
		companyRepository.delete(company);
	}

	@Override
	public List<LogisticsCompanyEntity> list() {
		return companyRepository.findByStatusLogistics(CompanyStatus.STATUS_PASS);
	}

	@Override
	public Page<LogisticsCompanyEntity> listPaging(int page, int size) {
		return companyRepository.findByStatusLogistics(CompanyStatus.STATUS_PASS, new PageRequest(page, size));
	}

}