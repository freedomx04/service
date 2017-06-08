package com.hongmeng.service.repository.talent;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hongmeng.service.entity.talent.TalentCompanyEntity;

public interface TalentCompanyRepository extends PagingAndSortingRepository<TalentCompanyEntity, Long> {
	
	TalentCompanyEntity findByUserId(Long userId);
	
	Page<TalentCompanyEntity> findByNameContainingAndStatusTalent(String name, Integer status, Pageable pageable);
	
	List<TalentCompanyEntity> findByStatusTalent(Integer status);
	
	Page<TalentCompanyEntity> findByStatusTalent(Integer status, Pageable pageable);
	
}
