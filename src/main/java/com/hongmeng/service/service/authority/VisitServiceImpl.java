package com.hongmeng.service.service.authority;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.authority.VisitEntity;
import com.hongmeng.service.repository.authority.VisitRepository;

@Service
public class VisitServiceImpl implements VisitService {
	
	@Autowired
	VisitRepository visitRepository;

	@Override
	public void save(VisitEntity visit) {
		Date now = new Date();
		visit.setCreateTime(now);
		visit.setUpdateTime(now);
		visitRepository.save(visit);
	}

	@Override
	public List<?> listByDate() {
		return visitRepository.listByDate();
	}

}