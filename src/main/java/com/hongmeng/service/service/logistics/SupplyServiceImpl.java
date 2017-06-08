package com.hongmeng.service.service.logistics;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.logistics.SupplyEntity;
import com.hongmeng.service.repository.logistics.SupplyRepository;

@Service
public class SupplyServiceImpl implements SupplyService {

	@Autowired
	SupplyRepository supplyRepository;

	@Override
	public SupplyEntity findOne(Long supplyId) {
		return supplyRepository.findOne(supplyId);
	}

	@Override
	public void save(SupplyEntity supply) {
		Date now = new Date();
		supply.setCreateTime(now);
		supply.setUpdateTime(now);
		supplyRepository.save(supply);
	}

	@Override
	public void update(SupplyEntity supply, String origin, String destination, String description, Integer supplyType,
			Date validDate, String remark, String contactUser, String contact, String address) {
		supply.setOrigin(origin);
		supply.setDestination(destination);
		supply.setDescription(description);
		supply.setSupplyType(supplyType);
		supply.setValidDate(validDate);
		supply.setRemark(remark);
		supply.setContactUser(contactUser);
		supply.setContact(contact);
		supply.setAddress(address);

		supply.setUpdateTime(new Date());
		supplyRepository.save(supply);
	}

	@Override
	public void delete(List<Long> supplyIds) {
		Iterable<SupplyEntity> it = supplyRepository.findByIdIn(supplyIds);
		supplyRepository.delete(it);
	}

	@Override
	public Page<SupplyEntity> search(String origin, String destination, int page, int size) {
		return supplyRepository.findByOriginContainingAndDestinationContaining(origin, destination,
				new PageRequest(page, size));
	}

	@Override
	public List<SupplyEntity> list() {
		return supplyRepository.findByOrderByCreateTimeDesc();
	}

	@Override
	public Page<SupplyEntity> listPaging(int page, int size) {
		return supplyRepository.findByOrderByCreateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<SupplyEntity> listByUserId(Long userId) {
		return supplyRepository.findByUserIdOrderByCreateTimeDesc(userId);
	}

	@Override
	public Page<SupplyEntity> listByUserIdPaging(Long userId, int page, int size) {
		return supplyRepository.findByUserIdOrderByCreateTimeDesc(userId, new PageRequest(page, size));
	}

}