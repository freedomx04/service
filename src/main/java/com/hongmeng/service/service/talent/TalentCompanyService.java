package com.hongmeng.service.service.talent;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.talent.TalentCompanyEntity;

public interface TalentCompanyService {

	TalentCompanyEntity findOne(Long talentCompanyId);
	
	TalentCompanyEntity findByUserId(Long userId);

	void save(TalentCompanyEntity talentCompany);

	void update(TalentCompanyEntity talentCompany, AreaEntity area, String name, String imagePath, Integer profession,
			Integer companyProperty, Integer scale, String address, String phone, String contactUser, String contact,
			String website, String introduction);

	void delete(TalentCompanyEntity talentCompany);

	List<TalentCompanyEntity> list();

	Page<TalentCompanyEntity> listPaging(int page, int size);

	Page<TalentCompanyEntity> search(String searchStr, int page, int size);

}