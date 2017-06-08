package com.hongmeng.service.service.financing;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.financing.FinancingEntity;
import com.hongmeng.service.repository.financing.FinancingRepository;

@Service
public class FinancingServiceImpl implements FinancingService {

	@Autowired
	FinancingRepository financingRepository;

	@Override
	public FinancingEntity findOne(Long financingId) {
		return financingRepository.findOne(financingId);
	}

	@Override
	public void save(FinancingEntity financing) {
		Date now = new Date();
		financing.setCreateTime(now);
		financing.setUpdateTime(now);
		financingRepository.save(financing);
	}

	@Override
	public void update(FinancingEntity financing, String name, String location, Integer profession, String purpose,
			String amount, Integer financingType, String description, String advantage, String companyName,
			String contactUser, String contact) {
		financing.setName(name);
		financing.setLocation(location);
		financing.setProfession(profession);
		financing.setPurpose(purpose);
		financing.setAmount(amount);
		financing.setFinancingType(financingType);
		financing.setDescription(description);
		financing.setAdvantage(advantage);
		financing.setCompanyName(companyName);
		financing.setContactUser(contactUser);
		financing.setContact(contact);

		financing.setUpdateTime(new Date());
		financingRepository.save(financing);
	}

	@Override
	public void delete(List<Long> financingIds) {
		Iterable<FinancingEntity> it = financingRepository.findByIdIn(financingIds);
		financingRepository.delete(it);
	}
	
	@Override
	public Page<FinancingEntity> search(String searchStr, int page, int size) {
		return financingRepository.findByNameContaining(searchStr, new PageRequest(page, size));
	}
	
	@Override
	public Page<FinancingEntity> filter(String profession, String financingType, int page, int size) {
		List<Integer> prlist = new LinkedList<>();
		for (String pr: StringUtils.split(profession, '-')) {
			prlist.add(Integer.parseInt(pr));
		}
		
		List<Integer> ftlist = new LinkedList<>();
		for (String ft: StringUtils.split(financingType, '-')) {
			ftlist.add(Integer.parseInt(ft));
		}
		
		return financingRepository.findByProfessionInAndFinancingTypeIn(prlist, ftlist, new PageRequest(page, size));
	}

	@Override
	public List<FinancingEntity> list() {
		return financingRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<FinancingEntity> list(int page, int size) {
		return financingRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<FinancingEntity> listByUserId(Long userId) {
		return financingRepository.findByUserIdOrderByUpdateTimeDesc(userId);
	}

	@Override
	public Page<FinancingEntity> listByUserId(Long userId, int page, int size) {
		return financingRepository.findByUserIdOrderByUpdateTimeDesc(userId, new PageRequest(page, size));
	}

}