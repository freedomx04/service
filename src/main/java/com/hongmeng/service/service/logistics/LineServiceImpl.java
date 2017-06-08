package com.hongmeng.service.service.logistics;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.logistics.LineEntity;
import com.hongmeng.service.repository.logistics.LineRepository;

@Service
public class LineServiceImpl implements LineService {

	@Autowired
	LineRepository lineRepository;

	@Override
	public LineEntity findOne(Long lineId) {
		return lineRepository.findOne(lineId);
	}

	@Override
	public void save(LineEntity line) {
		Date now = new Date();
		line.setCreateTime(now);
		line.setUpdateTime(now);
		lineRepository.save(line);
	}

	@Override
	public void update(LineEntity line, String origin, String destination, Integer transportMode, Integer aging,
			Double heavyPrice, Double lightPrice, Double lowest) {
		line.setOrigin(origin);
		line.setDestination(destination);
		line.setTransportMode(transportMode);
		line.setAging(aging);
		line.setHeavyPrice(heavyPrice);
		line.setLightPrice(lightPrice);
		line.setLowest(lowest);

		line.setUpdateTime(new Date());
		lineRepository.save(line);
	}

	@Override
	public void delete(List<Long> lineIds) {
		Iterable<LineEntity> it = lineRepository.findByIdIn(lineIds);
		lineRepository.delete(it);
	}

	@Override
	public Page<LineEntity> search(String origin, String destination, int page, int size) {
		return lineRepository.findByOriginContainingAndDestinationContaining(origin, destination,
				new PageRequest(page, size));
	}

	@Override
	public List<LineEntity> list() {
		return (List<LineEntity>) lineRepository.findAll();
	}

	@Override
	public Page<LineEntity> list(int page, int size) {
		return lineRepository.findAll(new PageRequest(page, size));
	}

	@Override
	public List<LineEntity> listByCompanyId(Long companyId) {
		return lineRepository.findByCompanyId(companyId);
	}

	@Override
	public Page<LineEntity> listByCompanyId(Long companyId, int page, int size) {
		return lineRepository.findByCompanyId(companyId, new PageRequest(page, size));
	}

}