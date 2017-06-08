package com.hongmeng.service.service.common;

import java.util.List;

import com.hongmeng.service.entity.authority.AreaEntity;
import com.hongmeng.service.entity.common.CompanyEntity;

public interface CompanyService {

	CompanyEntity findOne(Long companyId);

	CompanyEntity findByUserId(Long userId);

	CompanyEntity save(CompanyEntity company);

	void update(CompanyEntity company, AreaEntity area, String imagePath, Integer scale, String address, String phone,
			String fax, String contactUser, String contact, String website, String introduction);

	void update(CompanyEntity company, String license, String attachmentPath, String protocolPath, Integer status);

	void update(CompanyEntity company, Integer status);

	void update(CompanyEntity company);

	List<CompanyEntity> list();

	List<CompanyEntity> listPass();

	List<CompanyEntity> listCertification();

}
