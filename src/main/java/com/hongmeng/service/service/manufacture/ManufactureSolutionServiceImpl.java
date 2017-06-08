package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.manufacture.ManufactureSolutionEntity;
import com.hongmeng.service.repository.manufacture.ManufactureSolutionRepository;

@Service
public class ManufactureSolutionServiceImpl implements ManufactureSolutionService {
	
	@Autowired
	ManufactureSolutionRepository solutionRepository;

	@Override
	public ManufactureSolutionEntity findOne(Long solutionId) {
		return solutionRepository.findOne(solutionId);
	}

	@Override
	public void save(ManufactureSolutionEntity solution) {
		Date now = new Date();
		solution.setCreateTime(now);
		solution.setUpdateTime(now);
		solutionRepository.save(solution);
	}

	@Override
	public void update(ManufactureSolutionEntity solution, String title, String source, String linkPath) {
		solution.setTitle(title);
		solution.setSource(source);
		solution.setLinkPath(linkPath);
		
		solution.setUpdateTime(new Date());
		solutionRepository.save(solution);
	}

	@Override
	public void delete(List<Long> solutionIds) {
		Iterable<ManufactureSolutionEntity> it = solutionRepository.findByIdIn(solutionIds);
		solutionRepository.delete(it);
	}

	@Override
	public List<ManufactureSolutionEntity> list() {
		return solutionRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<ManufactureSolutionEntity> list(int page, int size) {
		return solutionRepository.findAll(new PageRequest(page, size));
	}

	@Override
	public List<ManufactureSolutionEntity> listByCompanyId(Long companyId) {
		return solutionRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId);
	}

	@Override
	public Page<ManufactureSolutionEntity> listByCompanyId(Long companyId, int page, int size) {
		return solutionRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId, new PageRequest(page, size));
	}

}