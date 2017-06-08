package com.hongmeng.service.service.manufacture;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.manufacture.OfferEntity;
import com.hongmeng.service.repository.manufacture.OfferRepository;

@Service
public class OfferServiceImpl implements OfferService {

	@Autowired
	OfferRepository offerRepository;

	@Override
	public OfferEntity findOne(Long offerId) {
		return offerRepository.findOne(offerId);
	}

	@Override
	public void save(OfferEntity offer) {
		Date now = new Date();
		offer.setCreateTime(now);
		offer.setUpdateTime(now);
		offerRepository.save(offer);
	}

	@Override
	public void update(OfferEntity offer, String name, String imagePath, Double price, String origin, String location, Integer lowest,
			Integer total, String description) {
		offer.setName(name);
		offer.setImagePath(imagePath);
		offer.setPrice(price);
		offer.setOrigin(origin);
		offer.setLocation(location);
		offer.setLowest(lowest);
		offer.setTotal(total);
		offer.setDescription(description);

		offer.setUpdateTime(new Date());
		offerRepository.save(offer);
	}

	@Override
	public void delete(List<Long> offerIds) {
		Iterable<OfferEntity> it = offerRepository.findByIdIn(offerIds);
		offerRepository.delete(it);
	}

	@Override
	public List<OfferEntity> list() {
		return offerRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<OfferEntity> list(int page, int size) {
		return offerRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<OfferEntity> listByCompanyId(Long companyId) {
		return offerRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId);
	}

	@Override
	public Page<OfferEntity> listByCompanyId(Long companyId, int page, int size) {
		return offerRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId, new PageRequest(page, size));
	}

}