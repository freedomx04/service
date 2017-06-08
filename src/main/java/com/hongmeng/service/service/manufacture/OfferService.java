package com.hongmeng.service.service.manufacture;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.manufacture.OfferEntity;

public interface OfferService {

	OfferEntity findOne(Long offerId);

	void save(OfferEntity offer);

	void update(OfferEntity offer, String name, String imagePath, Double price, String origin, String location,
			Integer lowest, Integer total, String description);

	void delete(List<Long> offerIds);

	List<OfferEntity> list();

	Page<OfferEntity> list(int page, int size);

	List<OfferEntity> listByCompanyId(Long companyId);

	Page<OfferEntity> listByCompanyId(Long companyId, int page, int size);

}