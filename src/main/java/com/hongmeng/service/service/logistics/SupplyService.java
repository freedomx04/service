package com.hongmeng.service.service.logistics;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.logistics.SupplyEntity;

public interface SupplyService {

	SupplyEntity findOne(Long supplyId);

	void save(SupplyEntity supply);

	void update(SupplyEntity supply, String origin, String destination, String description, Integer supplyType,
			Date validDate, String remark, String contactUser, String contact, String address);
	
	void delete(List<Long> supplyIds);
	
	Page<SupplyEntity> search(String origin, String destination, int page, int size);
	
	List<SupplyEntity> list();
	
	Page<SupplyEntity> listPaging(int page, int size);
	
	List<SupplyEntity> listByUserId(Long userId);
	
	Page<SupplyEntity> listByUserIdPaging(Long userId, int page, int size);

}
