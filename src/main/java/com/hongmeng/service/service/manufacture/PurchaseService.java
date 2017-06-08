package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.manufacture.PurchaseEntity;

public interface PurchaseService {

	PurchaseEntity findOne(Long purchaseId);

	void save(PurchaseEntity purchase);

	void update(PurchaseEntity purchase, String title, String description, Date validDate, String num, String location,
			String contactUser, String contact);

	void delete(List<Long> purchaseIds);

	List<PurchaseEntity> list();

	Page<PurchaseEntity> list(int page, int size);

	List<PurchaseEntity> listByUserId(Long userId);

	Page<PurchaseEntity> listByUserId(Long userId, int page, int size);

}