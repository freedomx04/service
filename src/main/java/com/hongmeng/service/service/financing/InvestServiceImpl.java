package com.hongmeng.service.service.financing;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.financing.InvestEntity;
import com.hongmeng.service.repository.financing.InvestRepository;

@Service
public class InvestServiceImpl implements InvestService {
	
	@Autowired
	InvestRepository investRepository;

	@Override
	public InvestEntity findOne(Long investId) {
		return investRepository.findOne(investId);
	}

	@Override
	public void save(InvestEntity invest) {
		Date now = new Date();
		invest.setCreateTime(now);
		invest.setUpdateTime(now);
		investRepository.save(invest);
	}

	@Override
	public void update(InvestEntity invest, String name, Integer investType, Integer fundType, String location,
			String profession, String investArea, String amount, String description, String remark) {
		invest.setName(name);
		invest.setInvestType(investType);
		invest.setFundType(fundType);
		invest.setLocation(location);
		invest.setProfession(profession);
		invest.setInvestArea(investArea);
		invest.setAmount(amount);
		invest.setDescription(description);
		invest.setRemark(remark);
		
		invest.setUpdateTime(new Date());
		investRepository.save(invest);
	}

	@Override
	public void delete(List<Long> investIds) {
		Iterable<InvestEntity> it = investRepository.findByIdIn(investIds);
		investRepository.delete(it);		
	}
	
	@Override
	public Page<InvestEntity> search(String searchStr, int page, int size) {
		return investRepository.findByNameContaining(searchStr, new PageRequest(page, size));
	}
	
	@Override
	public Page<InvestEntity> filter(String investType, String fundType, int page, int size) {
		List<Integer> itlist = new LinkedList<>();
		for (String it: StringUtils.split(investType, '-')) {
			itlist.add(Integer.parseInt(it));
		}
		
		List<Integer> ftlist = new LinkedList<>();
		for (String ft: StringUtils.split(fundType, '-')) {
			ftlist.add(Integer.parseInt(ft));
		}
		
		return investRepository.findByInvestTypeInAndFundTypeIn(itlist, ftlist, new PageRequest(page, size));
	}

	@Override
	public List<InvestEntity> list() {
		return investRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<InvestEntity> list(int page, int size) {
		return investRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public List<InvestEntity> listByCompanyId(Long companyId) {
		return investRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId);
	}

	@Override
	public Page<InvestEntity> listByCompanyId(Long companyId, int page, int size) {
		return investRepository.findByCompanyIdOrderByUpdateTimeDesc(companyId, new PageRequest(page, size));
	}

}