package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.manufacture.ManufactureCaseEntity;
import com.hongmeng.service.repository.manufacture.ManufactureCaseRepository;

@Service
public class ManufactureCaseServiceImpl implements ManufactureCaseService {
	
	@Autowired
	ManufactureCaseRepository caseRepository;

	@Override
	public ManufactureCaseEntity findOne(Long caseId) {
		return caseRepository.findOne(caseId);
	}

	@Override
	public void save(ManufactureCaseEntity manufactureCase) {
		Date now = new Date();
		manufactureCase.setCreateTime(now);
		manufactureCase.setUpdateTime(now);
		caseRepository.save(manufactureCase);
	}

	@Override
	public void update(ManufactureCaseEntity manufactureCase, String title, String source, String linkPath) {
		manufactureCase.setTitle(title);
		manufactureCase.setSource(source);
		manufactureCase.setLinkPath(linkPath);
		
		manufactureCase.setUpdateTime(new Date());
		caseRepository.save(manufactureCase);
	}

	@Override
	public void delete(List<Long> caseIds) {
		Iterable<ManufactureCaseEntity> it = caseRepository.findByIdIn(caseIds);
		caseRepository.delete(it);
	}

	@Override
	public List<ManufactureCaseEntity> list() {
		return caseRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<ManufactureCaseEntity> list(int page, int size) {
		return caseRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<ManufactureCaseEntity> listByCompanyId(Long companyId) {
		return caseRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId);
	}

	@Override
	public Page<ManufactureCaseEntity> listByCompanyId(Long companyId, int page, int size) {
		return caseRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId, new PageRequest(page, size));
	}

}