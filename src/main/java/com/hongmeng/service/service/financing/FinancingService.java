package com.hongmeng.service.service.financing;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.financing.FinancingEntity;

public interface FinancingService {

	FinancingEntity findOne(Long financingId);

	void save(FinancingEntity financing);

	void update(FinancingEntity financing, String name, String location, Integer profession, String purpose,
			String amount, Integer financingType, String description, String advantage, String companyName,
			String contactUser, String contact);

	void delete(List<Long> financingIds);
	
	Page<FinancingEntity> search(String searchStr, int page, int size);
	
	Page<FinancingEntity> filter(String profession, String financingType, int page, int size);

	List<FinancingEntity> list();

	Page<FinancingEntity> list(int page, int size);

	List<FinancingEntity> listByUserId(Long userId);

	Page<FinancingEntity> listByUserId(Long userId, int page, int size);

}