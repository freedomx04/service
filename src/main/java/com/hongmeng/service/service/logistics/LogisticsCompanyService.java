package com.hongmeng.service.service.logistics;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.logistics.LogisticsCompanyEntity;

public interface LogisticsCompanyService {
	
	LogisticsCompanyEntity findOne(Long companyId);
	
	LogisticsCompanyEntity findByUserId(Long userId);
	
	void save(LogisticsCompanyEntity company);
	
	void update(LogisticsCompanyEntity company, String phone, String address, String contactUser, String contact, String fax, String website);
	
	void delete(LogisticsCompanyEntity company);
	
	List<LogisticsCompanyEntity> list();
	
	Page<LogisticsCompanyEntity> listPaging(int page, int size);

}