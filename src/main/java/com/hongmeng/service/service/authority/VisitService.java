package com.hongmeng.service.service.authority;

import java.util.List;

import com.hongmeng.service.entity.authority.VisitEntity;

public interface VisitService {
	
	void save(VisitEntity visit);
	
	List<?> listByDate();
	
}
