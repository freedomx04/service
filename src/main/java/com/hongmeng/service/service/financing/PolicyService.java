package com.hongmeng.service.service.financing;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hongmeng.service.entity.financing.PolicyEntity;

public interface PolicyService {

	PolicyEntity findOne(Long policyId);

	void save(PolicyEntity policy);

	void update(PolicyEntity policy, String title, String source, String linkPath);

	void delete(List<Long> policyIds);

	List<PolicyEntity> list();

	Page<PolicyEntity> list(int page, int size);

}