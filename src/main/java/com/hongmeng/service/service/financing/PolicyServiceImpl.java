package com.hongmeng.service.service.financing;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hongmeng.service.entity.financing.PolicyEntity;
import com.hongmeng.service.repository.financing.PolicyRepository;

@Service
public class PolicyServiceImpl implements PolicyService {
	
	@Autowired
	PolicyRepository policyRepository;

	@Override
	public PolicyEntity findOne(Long policyId) {
		return policyRepository.findOne(policyId);
	}

	@Override
	public void save(PolicyEntity policy) {
		Date now = new Date();
		policy.setCreateTime(now);
		policy.setUpdateTime(now);
		policyRepository.save(policy);
	}

	@Override
	public void update(PolicyEntity policy, String title, String source, String linkPath) {
		policy.setTitle(title);
		policy.setSource(source);
		policy.setLinkPath(linkPath);
		
		policy.setUpdateTime(new Date());
		policyRepository.save(policy);
	}

	@Override
	public void delete(List<Long> policyIds) {
		Iterable<PolicyEntity> it = policyRepository.findByIdIn(policyIds);
		policyRepository.delete(it);
	}

	@Override
	public List<PolicyEntity> list() {
		return policyRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<PolicyEntity> list(int page, int size) {
		return policyRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

}