package com.hongmeng.service.service.common;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.common.BaseCompanyEntity.CompanyStatus;
import com.hongmeng.service.entity.common.CompanyEntity;
import com.hongmeng.service.repository.common.CompanyRepository;

@Service
public class CompanyServiceImpl implements CompanyService {

	@Autowired
	CompanyRepository companyRepository;

	@Override
	public CompanyEntity findOne(Long companyId) {
		return companyRepository.findOne(companyId);
	}

	@Override
	public CompanyEntity findByUserId(Long userId) {
		return companyRepository.findByUserId(userId);
	}

	@Override
	public CompanyEntity save(CompanyEntity company) {
		Date now = new Date();
		company.setCreateTime(now);
		company.setUpdateTime(now);
		return companyRepository.save(company);
	}

	@Override
	public void update(CompanyEntity company, AreaEntity area, String imagePath, Integer scale, String address,
			String phone, String fax, String contactUser, String contact, String website, String introduction) {
		company.setArea(area);
		company.setImagePath(imagePath);
		company.setScale(scale);
		company.setAddress(address);
		company.setPhone(phone);
		company.setFax(fax);
		company.setContactUser(contactUser);
		company.setContact(contact);
		company.setWebsite(website);
		company.setIntroduction(introduction);

		company.setUpdateTime(new Date());
		companyRepository.save(company);
	}

	@Override
	public void update(CompanyEntity company, String license, String attachmentPath, String protocolPath,
			Integer status) {
		company.setLicense(license);
		company.setAttachmentPath(attachmentPath);
		company.setProtocolPath(protocolPath);
		company.setStatus(status);
		companyRepository.save(company);
	}

	@Override
	public void update(CompanyEntity company, Integer status) {
		company.setStatus(status);
		companyRepository.save(company);
	}

	@Override
	public void update(CompanyEntity company) {
		companyRepository.save(company);
	}

	@Override
	public List<CompanyEntity> list() {
		return (List<CompanyEntity>) companyRepository.findAll();
	}

	@Override
	public List<CompanyEntity> listPass() {
		return companyRepository.findByStatus(CompanyStatus.STATUS_PASS);
	}

	@Override
	public List<CompanyEntity> listCertification() {
		return companyRepository.findByStatus(CompanyStatus.STATUS_BEING_CERTIFIED);
	}

}
