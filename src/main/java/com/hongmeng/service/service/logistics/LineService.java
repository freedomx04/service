package com.hongmeng.service.service.logistics;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.logistics.LineEntity;

public interface LineService {

	LineEntity findOne(Long lineId);

	void save(LineEntity line);

	void update(LineEntity line, String origin, String destination, Integer transportMode, Integer aging,
			Double heavyPrice, Double lightPrice, Double lowest);
	
	void delete(List<Long> lineIds);
	
	Page<LineEntity> search(String origin, String destination, int page, int size);
	
	List<LineEntity> list();
	
	Page<LineEntity> list(int page, int size);
	
	List<LineEntity> listByCompanyId(Long companyId);
	
	Page<LineEntity> listByCompanyId(Long companyId, int page, int size);

}
