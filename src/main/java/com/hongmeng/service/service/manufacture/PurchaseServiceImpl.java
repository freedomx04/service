package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.manufacture.PurchaseEntity;
import com.hongmeng.service.repository.manufacture.PurchaseRepository;

@Service
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	PurchaseRepository purchaseRepository;

	@Override
	public PurchaseEntity findOne(Long purchaseId) {
		return purchaseRepository.findOne(purchaseId);
	}

	@Override
	public void save(PurchaseEntity purchase) {
		Date now = new Date();
		purchase.setCreateTime(now);
		purchase.setUpdateTime(now);
		purchaseRepository.save(purchase);
	}

	@Override
	public void update(PurchaseEntity purchase, String name, String description, Date validDate, String num,
			String location, String contactUser, String contact) {
		purchase.setName(name);
		purchase.setDescription(description);
		purchase.setValidDate(validDate);
		purchase.setNum(num);
		purchase.setLocation(location);
		purchase.setContactUser(contactUser);
		purchase.setContact(contact);
		
		purchase.setUpdateTime(new Date());
		purchaseRepository.save(purchase);
	}

	@Override
	public void delete(List<Long> purchaseIds) {
		Iterable<PurchaseEntity> it = purchaseRepository.findByIdIn(purchaseIds);
		purchaseRepository.delete(it);	
	}

	@Override
	public List<PurchaseEntity> list() {
		return purchaseRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<PurchaseEntity> list(int page, int size) {
		return purchaseRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<PurchaseEntity> listByUserId(Long userId) {
		return purchaseRepository.findByUserIdOrderByUpdateTimeDesc(userId);
	}

	@Override
	public Page<PurchaseEntity> listByUserId(Long userId, int page, int size) {
		return purchaseRepository.findByUserIdOrderByUpdateTimeDesc(userId, new PageRequest(page, size));
	}

}