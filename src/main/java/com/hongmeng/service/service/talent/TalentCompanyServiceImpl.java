package com.hongmeng.service.service.talent;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.common.BaseCompanyEntity.CompanyStatus;
import com.hongmeng.service.entity.talent.TalentCompanyEntity;
import com.hongmeng.service.repository.talent.TalentCompanyRepository;

@Service
public class TalentCompanyServiceImpl implements TalentCompanyService {

	@Autowired
	TalentCompanyRepository talentCompanyRepository;
	
	@Override
	public TalentCompanyEntity findOne(Long talentCompanyId) {
		return talentCompanyRepository.findOne(talentCompanyId);
	}
	
	@Override
	public TalentCompanyEntity findByUserId(Long userId) {
		return talentCompanyRepository.findByUserId(userId);
	}

	@Override
	public void save(TalentCompanyEntity talentCompany) {
		Date now = new Date();
		talentCompany.setCreateTime(now);
		talentCompany.setUpdateTime(now);
		talentCompanyRepository.save(talentCompany);
	}

	@Override
	public void update(TalentCompanyEntity talentCompany, AreaEntity area, String name, String imagePath, Integer profession,
			Integer property, Integer scale, String address, String phone, String contactUser, String contact,
			String website, String introduction) {
		talentCompany.setArea(area);
		talentCompany.setName(name);
		talentCompany.setImagePath(imagePath);
		talentCompany.setProfession(profession);
		talentCompany.setProperty(property);
		talentCompany.setScale(scale);
		talentCompany.setAddress(address);
		talentCompany.setPhone(phone);
		talentCompany.setContactUser(contactUser);
		talentCompany.setContact(contact);
		talentCompany.setWebsite(website);
		talentCompany.setIntroduction(introduction);

		talentCompany.setUpdateTime(new Date());
		talentCompanyRepository.save(talentCompany);
	}

	@Override
	public void delete(TalentCompanyEntity talentCompany) {
		talentCompanyRepository.delete(talentCompany);
	}

	@Override
	public List<TalentCompanyEntity> list() {
		return talentCompanyRepository.findByStatusTalent(CompanyStatus.STATUS_PASS);
	}

	@Override
	public Page<TalentCompanyEntity> listPaging(int page, int size) {
		return talentCompanyRepository.findByStatusTalent(CompanyStatus.STATUS_PASS, new PageRequest(page, size));
	}

	@Override
	public Page<TalentCompanyEntity> search(String searchStr, int page, int size) {
		return talentCompanyRepository.findByNameContainingAndStatusTalent(searchStr, CompanyStatus.STATUS_PASS, new PageRequest(page, size));
	}

}