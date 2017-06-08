package com.hongmeng.service.service.financing;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.financing.InvestEntity;

public interface InvestService {

	InvestEntity findOne(Long investId);

	void save(InvestEntity invest);

	void update(InvestEntity invest, String name, Integer investType, Integer fundType, String location,
			String profession, String investArea, String amount, String description, String remark);

	void delete(List<Long> investIds);
	
	Page<InvestEntity> search(String searchStr, int page, int size);
	
	Page<InvestEntity> filter(String investType, String fundType, int page, int size);

	List<InvestEntity> list();

	Page<InvestEntity> list(int page, int size);

	List<InvestEntity> listByCompanyId(Long companyId);

	Page<InvestEntity> listByCompanyId(Long companyId, int page, int size);

}